name='agvs'
alias build='rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y; catkin_make'
alias attach="tmux attach-session -t $name"

function run_agv() {
    tmux new -s $name "source ~/catkin_agvs/devel/setup.bash; roslaunch agvs_gazebo agvs_office.launch;sleep 3" \; detach \;
    sleep 6
    tmux new-window -t $name "source ~/catkin_agvs/devel/setup.bash; roslaunch agvs_pad agvs_pad.launch" \; detach \;
    tmux new-window -t $name "source ~/catkin_agvs/devel/setup.bash; roslaunch agvs_robot_control agvs_robot_control.launch" \; detach \;
    tmux new-window -t $name "source ~/catkin_agvs/devel/setup.bash; rosrun rviz rviz -d $(rospack find agvs_complete)/rviz/nav.rviz" \; detach \;
    tmux new-window -t $name "source ~/catkin_agvs/devel/setup.bash; roslaunch agvs_complete agvs_gmapping.launch" \; detach \;
}
alias kill_agv="tmux kill-session -t $name"