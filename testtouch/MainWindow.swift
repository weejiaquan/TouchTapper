//
//  MainWindow.swift
//  TouchTapper
//
//  Created by Lychwee on 2020-04-11.
//  Copyright © 2020 Lychwee. All rights reserved.
//

import Cocoa

class MainWindow: NSWindowController {
    var hitCount = 0
    var started:Bool = false
    var timer = 10
    var colorList: [NSColor] = [ /*NSColor.black,*/NSColor.blue,NSColor.brown,NSColor.cyan,NSColor.darkGray,NSColor.gray,NSColor.green,NSColor.lightGray,NSColor.magenta,NSColor.orange,NSColor.purple,NSColor.red,NSColor.white,NSColor.yellow,]
    @IBOutlet weak var button1: NSButton!
    @IBOutlet weak var scrubber1: NSScrubber!
    @IBOutlet weak var display: NSTextField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    var countDown=10
    var originalCount=10
    var cpsMeasure=Float(0)
    var cpsStorage=[Float]()
    var cpsFinal=Float(0)
    //var (countdown,originalCount) = (10,10) //it works if i use this instead
    func startGame(){
        if(countDown>0){
            started=true
            //print(cpsMeasure)
            display.stringValue=String(countDown) + " " + String(self.cpsMeasure) + "CPS"
            countDown-=1
            cpsStorage.append(cpsMeasure)
            cpsMeasure=0
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.display.textColor = self.colorList[Int.random(in: 0..<self.colorList.count)]
                
                self.startGame()
            }
        }else{
            avgCPScalc()
             self.display.textColor = self.colorList[Int.random(in: 0..<self.colorList.count)]
            display.stringValue=String(hitCount)+" Taps in " + String(originalCount) + " seconds || Average CPS " + String(cpsFinal)
            countDown=10
            hitCount=0
            cpsFinal=0
            cpsMeasure=0
            cpsStorage.removeAll()
//            print(cpsStorage.count)
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.started=false
            }
        }
    }
    
    func avgCPScalc(){
        if(cpsStorage.count>0){
            //print("cpsCount>0")
            for i in 0...cpsStorage.count-1{
                       cpsFinal+=cpsStorage[i]
                   }
                   cpsFinal/=Float(cpsStorage.count)
        }else{
            //print("cpsCOUNTFAIL")
            cpsFinal=0
        }
    }
    
    @IBAction func labelPress(_ sender: Any) {
        display.stringValue="__RESET__"
        hitCount=0
        button1.title="Retry"
        countDown=0
        cpsFinal=0
        cpsMeasure=0
        cpsStorage.removeAll()
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.countDown=10
        }
        started=false
    }
    @IBAction func buttonPressed(_ sender: Any) {
        //print(started)
        if started==false{
            hitCount=0
            cpsFinal=0
            cpsMeasure=0
            cpsStorage.removeAll()
            startGame()
        }
        if started==true{
            hitCount+=1
            cpsMeasure+=1
            button1.bezelColor = colorList[Int.random(in: 0..<colorList.count)]
            button1.title=String(hitCount)
        }
            
            
        
    }
}
