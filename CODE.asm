.MODEL SMALL
.STACK 100H

.DATA
 XCUBE DW 36
 X1CUBE DW ?
 X2CUBE DW ?
 YCUBE DW 56
 Y1CUBE DW ?  
 Y2CUBE DW ?
 
 XLINE DW 70
 X1LINE DW ?
 X2LINE DW ?
 YLINE DW 120
 Y1LINE DW ?  
 Y2LINE DW ?
 
 NXLINE DW 150
 NX1LINE DW ?
 NX2LINE DW ?
 NYLINE DW 190
 NY1LINE DW ?  
 NY2LINE DW ?
             
 NNXLINE DW 10
 NNX1LINE DW ?
 NNX2LINE DW ?
 NNYLINE DW 170
 NNY1LINE DW ?  
 NNY2LINE DW ?
             
 CHECK DW 1
 
 randnumber dw 0 
 
 TIK DW ?
  
 CHECK_UND DB 0
 
 NCHECK_UND DB 0 
 NNCHECK_UND DB 0 
 
 RATE DW 1
 
 SCOREMSG DB 'Score: $'
 SCORE DW 0
 
 BORDERX DW 2
 BORDERY DW 13
              
 COUNT DW 3
 COUNT1 DW 3             
  
 MMM DB 0AH,0DH,'               RAPID ROLL$'  
 MMM1 DB 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,'        PRESS 1 TO START THE GAME$'
 MMM2 DB 0AH,0DH,0AH,0DH,'        PRESS 2 FOR HELP$'
 MMM3 DB 0AH,0DH,0AH,0DH,'        PRESS 3 TO EXIT THE GAME$'
 MMM4 DB 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,'             emu8086 PROJECT$'   
 MMM5 DB 0AH,0DH,0AH,0DH,' A GAME WRITTEN IN ASSEMBLY LANGUAGE :D$'   
 
 
 IMM1 DB 0AH,0DH,' You are a small box that falls along'
      db 0AH,0DH,' through the screen. By continuing in'
      db 0AH,0DH,' your descent through levels of the '
      db 0AH,0DH,' game,you gain points'
      db 0AH,0DH,0AH,0DH,0AH,0DH,' Controls:'
      db 0AH,0DH,' Press A to move left'
      db 0AH,0DH,' Press D to move right'
      db 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,' Press any key to get back$'      

  GAMEOVERMSG DB 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,'              GAME OVER'
              DB 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,'          YOUR SCORE: $'

  GAMEOVERMSG1 DB 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,'         PRESS P TO PLAY AGAIN$'
  
  SCORE_ARRAY DB 2,2,3,0,0
  
.CODE 


PLAY_AGAIN PROC
 MOV XCUBE , 36
 MOV YCUBE , 56
 
 MOV XLINE , 70
 MOV YLINE , 120
 
 MOV NXLINE , 150
 MOV NYLINE , 190
             
 MOV NNXLINE , 10
 MOV NNYLINE , 170
 MOV SCORE,0
 
    RET
ENDP PLAY_AGAIN
   
UPRMVCUBE PROC  
    MOV BX,X2CUBE          
    MOV XCUBE,BX
    
    MOV BX,XCUBE
    MOV X1CUBE,BX
    MOV X2CUBE,BX
    ADD X1CUBE,7
    
    MOV BX,Y2CUBE
    MOV YCUBE,BX

L1:
    MOV AH,0CH
    MOV AL,0
    MOV CX,XCUBE
    MOV DX,YCUBE
    INT 10H
    INC XCUBE
    MOV BX,X1CUBE
    CMP XCUBE,BX
    JLE L1
    
    MOV BX,X2CUBE
    MOV XCUBE,BX
    DEC YCUBE
    
    MOV BX,Y1CUBE
    CMP YCUBE,BX
    JNE L1
    
    MOV BX,X2CUBE
    MOV XCUBE,BX
    MOV BX,Y2CUBE
    MOV YCUBE,BX 
           
    RET
           
ENDP UPRMVCUBE
             
DOWNRMVCUBE PROC 
    MOV BX,X2CUBE           
    MOV XCUBE,BX
     
    MOV BX,XCUBE
    MOV X1CUBE,BX
    MOV X2CUBE,BX
    ADD X1CUBE,7 
     
    MOV BX,Y2CUBE
    MOV YCUBE,BX

L1DOWN:
    MOV AH,0CH
    MOV AL,0
    MOV CX,XCUBE
    MOV DX,YCUBE
    INT 10H
    INC XCUBE
    MOV BX,X1CUBE
    CMP XCUBE,BX
    JLE L1DOWN
    MOV BX,X2CUBE
    MOV XCUBE,BX
    INC YCUBE
    MOV BX,Y1CUBE
    CMP YCUBE,BX
    JNE L1DOWN
    
    MOV BX,X2CUBE
    MOV XCUBE,BX
    MOV BX,Y2CUBE
    MOV YCUBE,BX 
           
    RET
           
ENDP DOWNRMVCUBE                          

UPDRAWCUBE PROC 
    MOV BX,XCUBE
    MOV X1CUBE,BX
    MOV X2CUBE,BX
    ADD X1CUBE,7
    
    MOV BX,YCUBE
    MOV Y1CUBE,BX
    MOV Y2CUBE,BX
    SUB Y1CUBE,7

LUP:
    MOV AH,0CH
    MOV AL,11
    MOV CX,XCUBE
    MOV DX,YCUBE
    INT 10H
    INC XCUBE
    MOV BX,X1CUBE
    CMP XCUBE,BX
    JLE LUP
    MOV BX,X2CUBE
    MOV XCUBE,BX
    DEC YCUBE
    MOV BX,Y1CUBE
    CMP YCUBE,BX
    JNE LUP
    
    RET
    
ENDP UPDRAWCUBE

DOWNDRAWCUBE PROC 
    MOV BX,XCUBE
    MOV X1CUBE,BX
    MOV X2CUBE,BX
    ADD X1CUBE,7
    
    MOV BX,YCUBE
    MOV Y1CUBE,BX
    MOV Y2CUBE,BX
    ADD Y1CUBE,7

LDOWN:
    MOV AH,0CH
    MOV AL,11
    MOV CX,XCUBE
    MOV DX,YCUBE
    INT 10H
    INC XCUBE
    MOV BX,X1CUBE
    CMP XCUBE,BX
    JLE LDOWN
    
    MOV BX,X2CUBE
    MOV XCUBE,BX
    INC YCUBE
    MOV BX,Y1CUBE
    CMP YCUBE,BX
    JNE LDOWN
    
    RET
    
ENDP DOWNDRAWCUBE

DELAY PROC    
    MOV AX,00H
    INT 1AH
    MOV TIK,DX
    ADD TIK,1H
    DELAY1:
    MOV AX,00H
    INT 1AH
    CMP TIK,DX
    JGE DELAY1
    
    CMP CHECK,0
    JE DDD
    MOV AH,7
    INT 21H
    DEC CHECK
    DDD:
    RET

ENDP DELAY
 
DRAWLINE PROC
    
    MOV BX,XLINE
    MOV X1LINE,BX
    MOV X2LINE,BX
    ADD X1LINE,40
    
    MOV BX,YLINE
    MOV Y1LINE,BX
    MOV Y2LINE,BX
    SUB Y1LINE,3
    
    LINE:
    MOV AH,0CH
    MOV AL,13
    MOV CX,XLINE
    MOV DX,YLINE
    INT 10H
    INC XLINE
    MOV BX,X1LINE
    CMP XLINE,BX
    JLE LINE
    
    MOV BX,X2LINE
    MOV XLINE,BX
    DEC YLINE
    MOV BX,Y1LINE
    CMP YLINE,BX
    JNE LINE
    
    RET
ENDP DRAWLINE  
 
RMVLINE PROC 
    
    MOV BX,XLINE
    MOV X1LINE,BX
    MOV X2LINE,BX
    ADD X1LINE,40
               
    MOV XLINE,BX
    MOV BX,Y2LINE
    MOV YLINE,BX

LINE1:
    MOV AH,0CH
    MOV AL,0
    MOV CX,XLINE
    MOV DX,YLINE
    INT 10H
    INC XLINE
    MOV BX,X1LINE
    CMP XLINE,BX
    JLE LINE1 
    
    MOV BX,X2LINE
    MOV XLINE,BX
    DEC YLINE
    MOV BX,Y1LINE
    CMP YLINE,BX
    JNE LINE1
    
    MOV BX,X2LINE
    MOV XLINE,BX
    MOV BX,Y2LINE
    MOV YLINE,BX 
           
    RET
           
ENDP RMVLINE 

DRAWNLINE PROC
    
    MOV BX,NXLINE
    MOV NX1LINE,BX
    MOV NX2LINE,BX
    ADD NX1LINE,40
    
    MOV BX,NYLINE
    MOV NY1LINE,BX
    MOV NY2LINE,BX
    SUB NY1LINE,3
    
    NLINE:
    MOV AH,0CH
    MOV AL,13
    MOV CX,NXLINE
    MOV DX,NYLINE
    INT 10H
    INC NXLINE
    MOV BX,NX1LINE
    CMP NXLINE,BX
    JLE NLINE
    
    MOV BX,NX2LINE
    MOV NXLINE,BX
    DEC NYLINE
    MOV BX,NY1LINE
    CMP NYLINE,BX
    JNE NLINE
     
     
     
    RET
ENDP DRAWNLINE  
 
RMVNLINE PROC 
    
    MOV BX,NXLINE
    MOV NX1LINE,BX
    MOV NX2LINE,BX
    ADD NX1LINE,40
               
    MOV NXLINE,BX
    MOV BX,NY2LINE
    MOV NYLINE,BX

NLINE1:
    MOV AH,0CH
    MOV AL,0
    MOV CX,NXLINE
    MOV DX,NYLINE
    INT 10H
    INC NXLINE
    MOV BX,NX1LINE
    CMP NXLINE,BX
    JLE NLINE1 
    
    MOV BX,NX2LINE
    MOV NXLINE,BX
    DEC NYLINE
    MOV BX,NY1LINE
    CMP NYLINE,BX
    JNE NLINE1
    
    MOV BX,NX2LINE
    MOV NXLINE,BX
    MOV BX,NY2LINE
    MOV NYLINE,BX 
           
    RET
           
ENDP RMVNLINE

DRAWNNLINE PROC
    
    MOV BX,NNXLINE
    MOV NNX1LINE,BX
    MOV NNX2LINE,BX
    ADD NNX1LINE,40
    
    MOV BX,NNYLINE
    MOV NNY1LINE,BX
    MOV NNY2LINE,BX
    SUB NNY1LINE,3
    
    NNLINE:
    MOV AH,0CH
    MOV AL,13
    MOV CX,NNXLINE
    MOV DX,NNYLINE
    INT 10H
    INC NNXLINE
    MOV BX,NNX1LINE
    CMP NNXLINE,BX
    JLE NNLINE
    
    MOV BX,NNX2LINE
    MOV NNXLINE,BX
    DEC NNYLINE
    MOV BX,NNY1LINE
    CMP NNYLINE,BX
    JNE NNLINE
    
    
     
    NNDIDI:
    
    RET
ENDP DRAWNNLINE  
 
RMVNNLINE PROC 
    
    MOV BX,NNXLINE
    MOV NNX1LINE,BX
    MOV NNX2LINE,BX
    ADD NNX1LINE,40
               
    MOV NNXLINE,BX
    MOV BX,NNY2LINE
    MOV NNYLINE,BX

NNLINE1:
    MOV AH,0CH
    MOV AL,0
    MOV CX,NNXLINE
    MOV DX,NNYLINE
    INT 10H
    INC NNXLINE
    MOV BX,NNX1LINE
    CMP NNXLINE,BX
    JLE NNLINE1 
    
    MOV BX,NNX2LINE
    MOV NNXLINE,BX
    DEC NNYLINE
    MOV BX,NNY1LINE
    CMP NNYLINE,BX
    JNE NNLINE1
    
    MOV BX,NNX2LINE
    MOV NNXLINE,BX
    MOV BX,NNY2LINE
    MOV NNYLINE,BX 
           
    RET
           
ENDP RMVNNLINE
  
GENERATE_RANDOM_NUMBER PROC
    
    pushall macro
    push ax
    push bx
    push cx
    push dx
endm

popall macro
    pop dx
    pop cx
    pop bx
    pop ax
endm
    
getrand macro cur 
    pushall
    mov ah, 0
    int 1ah
    
    mov ax, dx
    mov dx, cx  ;dx:ax contains system time
    
    mov bx, 7261
    mul ax
    add ax, 1
    mov dx, 0
    mov bx, 200
    div bx
    
    mov cur, dx
    popall
endm    
    mov cx, 0
    getrand randnumber
    
    RET        
ENDP GENERATE_RANDOM_NUMBER     
 
CHECK_UP_OR_DOWN PROC
    
    MOV BX,YLINE
    SUB BX,4
    CMP YCUBE,BX
    JE NEXTPHASE
    MOV CHECK_UND,0
    JMP DID
    
    NEXTPHASE:
    MOV BX,XLINE
    ADD BX,42
    CMP XCUBE,BX
    JL NEXTPHASE1
    MOV CHECK_UND,0
    JMP DID
    
    NEXTPHASE1:
    MOV BX,XLINE
    SUB BX,9
    CMP BX,XCUBE
    JL LASTPHASE
    MOV CHECK_UND,0
    JMP DID
    
    LASTPHASE:
    MOV CHECK_UND,1
    
    DID:
    RET
ENDP CHECK_UP_OR_DOWN

NCHECK_UP_OR_DOWN PROC
    
    MOV BX,NYLINE
    SUB BX,4
    CMP YCUBE,BX
    JE NNEXTPHASE
    MOV NCHECK_UND,0
    JMP NDID
    
    NNEXTPHASE:
    MOV BX,NXLINE
    ADD BX,42
    CMP XCUBE,BX
    JL NNEXTPHASE1
    MOV NCHECK_UND,0
    JMP NDID
    
    NNEXTPHASE1:
    MOV BX,NXLINE
    SUB BX,9
    CMP BX,XCUBE
    JL NLASTPHASE
    MOV NCHECK_UND,0
    JMP NDID
    
    NLASTPHASE:
    MOV NCHECK_UND,1
    
    NDID:
    RET
ENDP NCHECK_UP_OR_DOWN

NNCHECK_UP_OR_DOWN PROC
    
    MOV BX,NNYLINE
    SUB BX,4
    CMP YCUBE,BX
    JE NNNEXTPHASE
    MOV NNCHECK_UND,0
    JMP NNDID
    
    NNNEXTPHASE:
    MOV BX,NNXLINE
    ADD BX,42
    CMP XCUBE,BX
    JL NNNEXTPHASE1
    MOV NNCHECK_UND,0
    JMP NNDID
    
    NNNEXTPHASE1:
    MOV BX,NNXLINE
    SUB BX,9
    CMP BX,XCUBE
    JL NNLASTPHASE
    MOV NNCHECK_UND,0
    JMP NNDID
    
    NNLASTPHASE:
    MOV NNCHECK_UND,1
    
    NNDID:
    RET
ENDP NNCHECK_UP_OR_DOWN

NEXT_XLINE PROC
          
    CMP YLINE,15
    JGE NOCHANGE
    MOV YLINE,196
    MOV Y2LINE,196 
    
    MOV BX,RANDNUMBER
    MOV XLINE,BX
    MOV X1LINE,BX 
    
    NOCHANGE:
    RET
ENDP NEXT_XLINE

NEXT_NXLINE PROC
          
    CMP NYLINE,15
    JGE NNOCHANGE
    MOV NYLINE,196
    MOV NY2LINE,196 
    
    MOV BX,RANDNUMBER
    MOV NXLINE,BX
    MOV NX1LINE,BX 
    
    NNOCHANGE:
    RET
ENDP NEXT_NXLINE

NEXT_NNXLINE PROC
          
    CMP NNYLINE,15
    JGE NNNOCHANGE
    MOV NNYLINE,196
    MOV NNY2LINE,196 
    
    MOV BX,RANDNUMBER
    MOV NNXLINE,BX
    MOV NNX1LINE,BX 
    
    NNNOCHANGE:
    RET
ENDP NEXT_NNXLINE

GET_THE_SCORE PROC
    
    MOV AH,0
    MOV AL,2
    INT 10H
    
    MOV DI,0
    
    MOV AX,SCORE
    MOV BX,10
    
    SCL:
    CMP AX,0
    JE SCL2
    DIV BX
    PUSH DX
    MOV DX,0
    INC COUNT
    JMP SCL
    
    SCL2:
    MOV BX,COUNT
    MOV COUNT1,BX
    SCL1:
    CMP COUNT,0
    JE SCL3
    DEC COUNT
    POP DX
    ADD DX,48
    MOV SCORE_ARRAY[DI],DL
    INC DI
    JMP SCL1
    
    SCL3: 
    MOV AX,13H
    INT 10H
    MOV DI,0
    
    RET
ENDP GET_THE_SCORE


BORDER PROC
    
    BOR:
    MOV AH,0CH
    MOV AL,15
    MOV CX,BORDERX
    MOV DX,BORDERY
    INT 10H
    INC BORDERX
    CMP BORDERX,319
    JE NNP
    JMP BOR
    
    NNP:
    MOV BORDERX,2
    MOV BORDERY,195
    BOR1:
    MOV AH,0CH
    MOV AL,15
    MOV CX,BORDERX
    MOV DX,BORDERY
    INT 10H
    INC BORDERX
    CMP BORDERX,319
    JE NNP1
    JMP BOR1
    
    NNP1:
    MOV BORDERX,2
    MOV BORDERY,13
    BOR2:
    MOV AH,0CH
    MOV AL,15
    MOV CX,BORDERX
    MOV DX,BORDERY
    INT 10H
    INC BORDERY
    CMP BORDERY,195
    JE NNP2
    JMP BOR2
    
    NNP2:
    MOV BORDERX,319
    MOV BORDERY,13
    BOR3:
    MOV AH,0CH
    MOV AL,15
    MOV CX,BORDERX
    MOV DX,BORDERY
    INT 10H
    INC BORDERY
    CMP BORDERY,196
    JE DADA
    JMP BOR3
    
    DADA:
    MOV BORDERX,2
    MOV BORDERY,13
    RET
ENDP BORDER

MAIN_MENU PROC
    MPR:
    MOV AH,9
    LEA DX,MMM
    INT 21H
    LEA DX,MMM1
    INT 21H
    LEA DX,MMM2
    INT 21H
    LEA DX,MMM3
    INT 21H
    LEA DX,MMM4
    INT 21H
    LEA DX,MMM5
    INT 21H
    
    LOOPP:
    MOV AH,7
    INT 21H
    CMP AL,'1'
    JE STG
    CMP AL,'2'
    JE  INSTRUC
    CMP AL,'3'
    JE  STG
    JMP LOOPP
    
    
    INSTRUC:
    CALL RESET_THE_SCREEN
    
    MOV AH,9
    LEA DX,IMM1
    INT 21H
    
    MOV AH,1
    INT 21H
    
    CALL RESET_THE_SCREEN
     
    JMP MPR
    
    STG:
    CALL RESET_THE_SCREEN
    JMP GAME 
    RET
ENDP MAIN_MENU


RESET_THE_SCREEN PROC
    MOV AH,0
    MOV AL,2
    INT 10H
    MOV AX,13H
    INT 10H
    
    RET

ENDP RESET_THE_SCREEN

GAME_OVER PROC
    
    CALL RESET_THE_SCREEN
    
    MOV AH,9
    LEA DX,GAMEOVERMSG
    INT 21H 
    
    MOV DI,0
    MOV BX,COUNT1
    MOV COUNT,BX
    GLO:
    CMP COUNT,0
    JE  GLO1
    DEC COUNT
    MOV AH,2
    MOV DL,SCORE_ARRAY[DI]
    ADD DL,48 
    INT 21H
    INC DI
    JMP GLO
    
    
    GLO1:
    MOV AH,9
    LEA DX,GAMEOVERMSG1
    INT 21H
    
    AGA:
    MOV AH,7
    INT 21H
    CMP AL,'X'
    JE GGG
    CMP AL,'x'
    JE GGG
    CMP AL,'P'
    JE DIDA
    JMP AGA
    
    DIDA:
    CALL RESET_THE_SCREEN
    CALL PLAY_AGAIN
    JMP GAME
    
    GGG:
    RET
ENDP GAME_OVER

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    
    ; Graphic mode
    MOV AX,13H
    INT 10H
    CALL MAIN_MENU
    
    ;LEA DX,SCOREMSG
    ;MOV AH,9
    ;INT 21H
    CALL GET_THE_SCORE
GAME:
 
    MOV AH,1
    INT 16H
    
    JZ NOKEYPRESS
    JNZ KEYPRESS
    
    NOKEYPRESS:
    CALL NEXT_XLINE
    CALL NEXT_NXLINE
    CALL NEXT_NNXLINE
    CALL GENERATE_RANDOM_NUMBER
    
    CALL BORDER
    CALL UPDRAWCUBE
    CALL DRAWLINE
    CALL DRAWNLINE
    CALL DRAWNNLINE
    
    CALL DELAY
               
    CALL UPRMVCUBE
    CALL RMVLINE
    CALL RMVNLINE
    CALL RMVNNLINE
    JMP AGAIN 
    
    KEYPRESS:
    MOV AH,0
    INT 16H
    CMP AL,'A'
    JE MOVELEFT
    CMP AL,'a'
    JE MOVELEFT
    CMP AL,'D'
    JE MOVERIGHT
    CMP AL,'d'
    JE MOVERIGHT
    JMP AGAIN
    
    MOVELEFT:
    SUB XCUBE,2
    SUB X2CUBE,2
    JMP AGAIN 
     
    MOVERIGHT:
    ADD XCUBE,2
    ADD X2CUBE,2
    
    AGAIN:
    CALL CHECK_UP_OR_DOWN
    CALL NCHECK_UP_OR_DOWN
    CALL NNCHECK_UP_OR_DOWN
    CMP CHECK_UND,1
    JE AGAIN1
    CMP NCHECK_UND,1
    JE AGAIN1
    CMP NNCHECK_UND,1
    JE AGAIN1
    
    INC YCUBE 
    INC SCORE
    AGAIN2:
    DEC YLINE
    DEC NYLINE
    DEC NNYLINE
    CMP YCUBE,198
    JE EXIT
    CMP YCUBE,19
    JE EXIT
    ;CALL GET_THE_SCORE 
    ;CALL RESET_THE_SCREEN
    JMP GAME
    
    AGAIN1:
    DEC YCUBE
    JMP AGAIN2
    EXIT:
    CALL GAME_OVER 
    MOV AH,1
    INT 21H
              
    MOV AH,0
    MOV AL,2
    INT 10H
       
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN