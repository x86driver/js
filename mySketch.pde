void setup()
{
    randomSeed(0);
    size(640, 480);
    background(0);
    fill(255);
    frameRate(10);
//    noLoop();
//    PFont fontA = loadFont("courier");
//    textFont(fontA, 14);
}

int LAST_R = 127;
int LAST_G = 127;
int LAST_B = 127;
int THRESHOLD1 = 5;
int THRESHOLD2 = 6;

int MIN_RANGE = 10;
int MAX_RANGE = 250;

int random_color(int last_color, int threshold1, int threshold2)
{
    int min_range, max_range;

    if (last_color - threshold1 <= MIN_RANGE)
        min_range = MIN_RANGE;
    else
        min_range = last_color - threshold1;

    if (last_color + threshold2 >= MAX_RANGE)
        max_range = MAX_RANGE;
    else
        max_range = last_color + threshold2;

    return random(min_range, max_range);
}

int rect_color = 0;
int STATE = 0;

    int startX = 20;
    int startY = 20;
    int width = 10;
    int height = 10;
    int space = 30;
    int rect_color = 0;
    int MAX_STATE = 5;

void flash_box(int n)
{
    int x = startX + n*space;
    int y = startY;

    noStroke();
    fill(0, 0, rect_color);
    rect(x, y, width+1, height+1);

    stroke(0, 0, 255);
    noFill();
    rect(x-5, y-5, width+10, height+10);

    if (rect_color > 255) {
        rect_color = 0;
        ++STATE;
        if (STATE > MAX_STATE)
            STATE = 0;
    } else {
        rect_color += 25;
    }
}

void draw_boxes(int num)
{
    int x = startX;
    int y = startY;

    for (int i = 0; i < num; ++i) {
        fill(0, 0, 255);
        rect(x, y, width, height);

        stroke(0, 0, 255);
        noFill();
        rect(x-5, y-5, width+10, height+10);

        x += space;
    }
}

void draw()
{

    background(0);

    long d = day();
    long h = hour();
    long min = minute();
    long sec = second();
    long mil = millis();

    long target_d = 20;
    long target_hour = 12;
    long target_min = 0;
    long target_second = 0;
    long target_mil = 0;

    long target_time = target_d*24*60*60 + target_hour*60*60;
    long today_time  = day()*24*60*60 + hour()*60*60 + minute()*60 + second();

    long diff_time = target_time - today_time;

    long diff_day = (int)(diff_time / 86400);
    diff_time -= diff_day * 86400;

    long diff_hour = (int)(diff_time / 3600);
    diff_time -= diff_hour * 3600;

    long diff_min = (int)(diff_time / 60);
    diff_time -= diff_min * 60;

    long diff_sec = (int)diff_time;

    str += diff_time;

    String[] str = "Remain: " + diff_day + " day, " + nf(diff_hour,2) + ":" + nf(diff_min,2) + ":" + nf(diff_sec,2);// + " " + nf(diff_mil,3) + "\"";

    myfont = createFont("monospace", 16);
    textFont(myfont);

    int NEW_R = random_color(LAST_R, THRESHOLD1, THRESHOLD2);
    int NEW_G = random_color(LAST_G, THRESHOLD1, THRESHOLD2);
    int NEW_B = random_color(LAST_B, THRESHOLD1, THRESHOLD2);

    LAST_R = NEW_R;
    LAST_G = NEW_G;
    LAST_B = NEW_B;

    fill(NEW_R, NEW_G, NEW_B);
    text(str, 100, 100);

    draw_boxes(STATE);
    flash_box(STATE);

//    String[] fontlist = PFont.list();
//    println(fontlist);
}
