//
//  TasksViewController.swift
//  Do It!
//
//  Created by Stephen Romero on 1/30/17.
//  Copyright © 2017 Stephen Romero. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks : [Task] = []
//    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //adjusts the table to display on the whole screen and have the ability to scroll
        
      //  tasks = makeTasks()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getTasks()
        tableView.reloadData()
    }
    //function that allows number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
        if task.important
        {
            cell.textLabel?.text = "❗️\(task.name!)"
        }
        else
        {
            cell.textLabel?.text = task.name!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        selectedIndex = indexPath.row
        
        let task = tasks[indexPath.row]
        performSegue(withIdentifier: "selectTaskSegue", sender: task)
    }
    
/**
 func makeTasks() -> [Task]
    {
        let task1 = Task()
        task1.name = "Walk the dog"
        task1.important = false
        
        let task2 = Task()
        task2.name = "Buy cheese"
        task2.important = true
        
        let task3 = Task()
        task3.name = "Mow the lawn"
        task3.important = false
        
        return [task1, task2, task3]
        
    }**/
    //plus sign button on the table view
    @IBAction func plusTapped(_ sender: Any)
    {
        //segue name
        performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    func getTasks()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
           tasks = try  context.fetch(Task.fetchRequest()) as! [Task]
        } catch {
            
        }
        
    }
    //allows tasks to be written from the CreateTask VC to the Tasks VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue"
        {
 //           let nextVC = segue.destination as! CreateTaskViewController
//            nextVC.previousVC = self
        }
        if segue.identifier == "selectTaskSegue"{
            let nextVC = segue.destination as! CompleteTaskViewController
            nextVC.task = sender as? Task
//            nextVC.previousVC = self
            
            
                    }
    }
}

