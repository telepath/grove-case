include <lib/rj45_case.scad>
include <conf/config.scad>

x=58;
x1=0;
y1=25;
y2=y1;
z1=19;
z2=z1;

/* assembly(); */
print();

module part(cutout=NONE) {
  translate([50-w,0,0]){
    if (cutout==BOTTOM) {
      translate([-2, -y2, 5.5]) {
        cube(size=[20, y2*2, z2+w], center=false);
      }
      //part to cut as holes in the bottom case
    }
    if (cutout==TOP) {
      //part to cut as holes in the top case
      translate([-2+w, -y2, 5.5+w]) {
        cube(size=[20, y2*2, z2+w], center=false);
      }
    } else {
      //part to add to the case
      grove_module_holder();
      %grove_module(flat=0,pos=0,block=0);
      translate([-7-w, -y2/2-w, 0]) {
        cube(size=[18+w, w, 4+w]);
      }
      translate([-7-w, y2/2, 0]) {
        cube(size=[18+w, w, 4+w]);
      }
    }
  }
}

module cover_bottom() {
  translate([-7-w, -y2/2-w, 0]) {
    difference() {
      cube(size=[18+w*2, y2+w*2, z2-4]);
      translate([w+5, -w, w]) {
        cube(size=[18+w*2, y2+w*4, z2-4]);
      }
      translate([-w, w, 0]) {
        cube(size=[5, y2, z2-4-w]);
      }
      hull() {
        translate([8, y2/2-w, 0]) {
          cube(size=[7, 7, w]);
          translate([-w, -w*2, w]) {
            cube(size=[7+w*3, 7+w*4, w]);
          }
        }
      }
      translate([7+w, y2/2+w, 0]) {
        translate([0, -10, 0]) {
          cylinder(d=2.5, h=10, center=true,$fn=12);
        }
        translate([0, 10, 0]) {
          cylinder(d=2.5, h=10, center=true,$fn=12);
        }
      }
    }
  }
}

module assembly() {
  box_bottom();
  translate([50-w,0,5.5]){
    cover_bottom();
  }
  translate([-w, 0, -w]) {
    %box_top();
  }
}

module print() {
  box_bottom();
  translate([y2, y1*1.5, 0]) {
    rotate([0, -90, 0]) {
      box_top();
    }
  }
  translate([y2*2, y1*1.5, -3+w]) {
    cover_bottom();
  }
}
