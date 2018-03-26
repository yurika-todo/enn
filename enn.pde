void setup() {
  size(640, 480);
  DrawCircle1(width/5, height/3, 80);
  DrawCircle2(width/2, height/3, 50, 0);
  DrawCircle3(width/5*4, height/3, 50, 0);
  DrawCircle4(width/5, height/3*2.3, 80);
  DrawCircle5(width/2, height/3*2.3, 80);
  DrawCircle6(width/5*4, height/3*2.3, 80);
}

void DrawCircle1(float x, float y, float r) {
  float ang =0;
  float rtmp=0;
  float rinc = 0.1;
  int n=12;
  while (rtmp < r) {
    for (int i = 0; i<n; i++) {
      point(x+rtmp*cos(radians(ang+i*360/n)), y+rtmp*sin(radians(ang+i*360/n)));
    }
    ang+= 360/(r/rinc);
    rtmp += rinc;
  }
}

void  DrawCircle2(float x, float y, float r, float ang) {
  float _x, _y, _x2, _y2;
  _x = x+sqrt(2)*r*cos(radians(ang));
  _y = y+sqrt(2)*r*sin(radians(ang));
  _x2=x+(_y-y);
  _y2=y+(_x-x);
  line (_x, _y, _x2, _y2);
  if (ang>360) return;
  DrawCircle2(x, y, r, ang+5);
}


void  DrawCircle3(float x, float y, float r, float ang) {
  float _x, _y, _x2, _y2;
  _x = x+sqrt(2)*r*cos(radians(ang));
  _y = y+sqrt(2)*r*sin(radians(ang));
  _x2=x+(_y-y);
  _y2=y-(_x-x);
  line (_x, _y, _x2, _y2);
  if (ang>360) return;
  DrawCircle3(x, y, r, ang+20);
}

void DrawCircle4(float x, float y, float r) {
  int N = 12;
  float[] _x = new float[N] ;
  float[] _y = new float[N] ;
  for (int i=0; i<N; i++) {
    _x[i] = x+r*cos(radians(360/N*i));
    _y[i] = y+r*sin(radians(360/N*i));
  }
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      line(_x[i], _y[i], _x[j], _y[j]);
    }
  }
}

void DrawCircle5(float x, float y, float r) {
  int N = 1000;
  float[] _r = new float[N] ;
  float[] ang = new float[N] ;
  for (int i=0; i<N; i++) {
    ang[i] = random(1)*PI * 2;
    _r[i]= r * sqrt(random(1));
  }
  for (int i=0; i<N-1; i++) {
    float x1 = x+_r[i]*cos(ang[i]);
    float y1 = y+_r[i]*sin(ang[i]);
    float x2 = x+_r[i+1]*cos(ang[i+1]);
    float y2 = y+_r[i+1]*sin(ang[i+1]);
    stroke(0, 100);
    line(x1, y1, x2, y2);
  }
}

void DrawCircle6(float x, float y, float r) {
  int N = 700;
  float[] angle = new float[N] ;
  float[] _x = new float[N] ;
  float[] _y = new float[N] ;

  for (int i=0; i<N; i++) {
    float ang = random(1)*PI * 2;
    float _r= r * sqrt(random(1));
    _x[i] = x+_r*cos(ang);
    _y[i] = y+_r*sin(ang);
  }

  int minypos = GetMinY(_y);

  swap(_x, 0, minypos);
  swap(_y, 0, minypos);
  angle[0] = 0;
  for (int i=1; i<N; i++) {
    angle[i] = atan2(_y[i]-_y[0], _x[i]-_x[0]);
  }
  
  int j;
  for (int i=1; i<N; i++) {
    float tmp = angle[i];
    int k=1;
    if (angle[i-1] > tmp) {
      j=i;
      k=i;
      do {
        angle[j] = angle[j-1];
        j--;
      } while (j>0&&angle[j-1] > tmp);
      angle[j] = tmp;
      insert(_x, j, k);
      insert(_y, j, k);
    }
  }
  //for (int i=0; i<N; i++) {
  //println(angle[i]+" : "+_x[i]+" : "+_y[i]);
  //}

  for (int i=0; i<N-1; i++) {
    stroke(0, 100);
    line(_x[i], _y[i], _x[i+1], _y[i+1]);
  }
  line(_x[0], _y[0], _x[N-1], _y[N-1]);
  
}

int GetMinY(float[] y) {
  float miny = max(y);
  int minypos=0;
  for (int i=0; i<y.length; i++) {
    if (y[i]==miny) {
      minypos = i;
    }
  }
  return minypos;
}

void swap(float[] array, int index1, int index2) {
  float tmp = array[index1];
  array[index1] = array[index2];
  array[index2] = tmp;
}

void insert(float[] array, int index1,int index2){
  float[] tmparray = new float[array.length];
  float tmp = array[index2];
  for(int i=0;i<index1;i++){
    tmparray[i] = array[i];    
  }
  tmparray[index1]=tmp;
  for(int i=index1+1;i<array.length;i++){
    if(i >= index2+1){
        tmparray[i] = array[i];
     }else{
        tmparray[i] = array[i-1];
     }
      
  }
  for(int i=0;i<array.length;i++){
    array[i]=tmparray[i];
  }
  
}