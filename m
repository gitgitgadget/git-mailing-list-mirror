Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0252620958
	for <e@80x24.org>; Sat,  1 Apr 2017 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbdDAPkl (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 11:40:41 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33082 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdDAPkj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 11:40:39 -0400
Received: by mail-ua0-f182.google.com with SMTP id 17so9338883uah.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RleL+XOoNvvJQHmGOU2gjM4Pg4Aw1PgPNCNqe9+heaY=;
        b=PlKb4UDNy+ni049e2bA/3m98xDW6FMq4kxTbFWL0CYAXDYb9/fVo/1n91txTckxIII
         SNjLCFRvuulTr62QDTaBYDUsAz0fiThZ5tFFBIvIa6qglLEisoRXzzazT9C/bMPLUkFp
         FfpnAJooL6jZ32UZLZzGuUr3Fnz9h88Cw1oRkKB107IrFFOh2GdHjPPgyKOjGeUyH2P5
         LqMWcfmm1iXUsBj/q8cKbTyC3IDgoy7ZRJJixJoQZwEEwlOlJCuq/cpo5613xv+sCUll
         vn45brMZbmbTYosbCtfaABhThpOlirc6RwJ7J7NHkKldj4SXTn366fnCm/sJBBgjChd2
         xH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RleL+XOoNvvJQHmGOU2gjM4Pg4Aw1PgPNCNqe9+heaY=;
        b=daNAQUUvP2JoAk2yQNNrwtl481SEjvScoqgZvN0CY9N97IX8yoA+GRyeGJj1WgRpBi
         4s/+69UfU0LuYmmMaobWtlZad4dv31uYwivXviVj8yNo7zL1zDjj3gpQdq8RAE5/cGM3
         rtnOhPlMGfYVom9GOXiIN6y0B6qviRCSLZwj2AjgXawYHltxcvZJLuisjxOhjWRoJ5Dy
         kwvCoLbaIKs18NEevpeVHGMjLs0Pi19nAmt08vYke0jQt69uvMIvUmqY567HzuVRFUG4
         6/LEx/F7MImUrH1ue7XXJFmiD5rgVzciRCpJhA83IdtOrlwv1dfsae/gN2INo/mz80A1
         THJA==
X-Gm-Message-State: AFeK/H1j1CsYb2o56b9OKkL/v39h13em95dpGeKP86vH0/V/aiNswy2pFHGq1kj7qiml4gQWZjrAEDjlkFTpOg==
X-Received: by 10.176.3.6 with SMTP id 6mr4224987uat.84.1491061237801; Sat, 01
 Apr 2017 08:40:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.7.216 with HTTP; Sat, 1 Apr 2017 08:40:37 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Sat, 1 Apr 2017 21:10:37 +0530
Message-ID: <CAME+mvXBuLbbRJu1DAA8o-u6DeZATKypH=W=hPEks3KL5WMX+Q@mail.gmail.com>
Subject: [RFC] [GSoC] Proposal Draft for GSoC 2017 : Incremental Rewrite of git-submodules
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

This is the first draft of my project proposal. I decided to change my proj=
ect
since the project I initially intended to do and also proposed was slightly
a smaller project for 13 weeks. Also when I came across this project,
and also found out that there are left over bits (git submodule $cmd
$pathspec may want to error out when the $pathspec does not match any
submodules) which also can be included in this conversion process, I was
motivated to change my project and hence made my proposal regarding it.

Also I wish to complete the previously proposed task, probably after finish=
ing
GSoC first.

Here is a Google doc for my proposal,
https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1=
L-xU

Below I have also included the text only version of my proposal, so that
all the discussion related to it would also be there on the public-inbox of=
 git.
It would be great to have your suggestion, so that I can improve it futher.

Thanks,
Prathamesh Chavan
---

Incremental Rewrite of git-submodules
01.04.2017

About Me

Name              Prathamesh Chavan
University        Indian Institute of Technology, Kharagpur
Major             Computer Science and Engineering(Dual Degree)
Email             pc44800@gmail.com
IRC               pratham_pc
Blog              pratham-pc.github.io
Contact No.       +91-993-235-8333
Time Zone         IST (UTC +5:30)


Background

I am a second-year student from the Department of Computer Science and
Engineering IIT Kharagpur. I=E2=80=99m an active member at Kharagpur open
source society and also of Kharagpur Linux Users Group since my first
year. I got introduced to open source, Linux and git since the
beginning of my first year.
I use to try to complete any task on my laptop without the use of the
cursor and hence eventually got familiar with shell script and in the
same manner, I still find something new every day. I=E2=80=99m also quite
familiar with C language. I always wanted to get involved in the
development process. As Google Summer of Code is a great way to
achieve it, hence I would like to participate.
This is my first attempt to GSoC. Since I use Git on regular basis
and would also continue to use it, I would love to be a part of its
contributors and hence would also be able to contribute to the project
even after GSoC.

The Project

Abstract

To manage the external dependencies, git submodule commands have been
frequently used by the developers in their projects. But as most of the
subcommands of git submodule are still written in shell scripts (All, but
git submodule init), my project intends to convert the subcommands into
C code, thus making them builtins. This will increase Git's portability
and hence the efficiency of working with the git-submodule commands.
The function cmd_init has been ported to its built-in successfully and
similar operation needs to be done to the remaining functions.

Problems encountered while using Shell Scripts

Git submodule subcommands are currently implemented by using shell script
'git-submodule.sh'. There are several reasons why we'll prefer not to
use the shell script:

1. Less Efficient

Since being a part of shell script, the commands of git submodule do not
have access to the low-level internal API of git, which are designed to
carry out the task more efficiently.
Also, since the subcommands in  =E2=80=98git-submodule.sh=E2=80=99 do not h=
ave direct
access to the native low-level internal API's of git, carrying out even
trivial processes make git be spawned into a separate process with the
help of plumbing functions. Also since everything comes from external
commands even in the shell scripts, everything needs to undergo through
a fork and exec. Whenever fork takes place, the git command requires
another fully functioning POSIX shell. This results in making the git
submodule commands slow and relatively inefficient, and also reduces git's
portability, since it is difficult to port such commands to a non-POSIX
an environment like Windows.

2. Spawning makes the process slower in many cases

Most of the operations in the shell scripts require the scripts to call
the external executables, even for performing trivial tasks. When we
take a look at the file 'git-submodule.sh', then its is seen that
many git-executables like : 'git config', 'git checkout' 'git add',
'git rev-list', 'git fetch', 'git rev-parse', 'git describe', 'git
hash-object', 'git log' and since these and other shell command comes
from other executables, every command undergoes a through a fork and
exec, thus making the processes slow.

3. Additional dependencies are introduced

When we take a look at the 'git-submodule.sh' file, we can notice that
it is dependent upon various other executables like: 'test', 'printf',
'echo', 'sed', 'grep', 'mkdir', 'rm'. This leads to the requirement of
adding these various dependencies to a non-POSIX environment.

4. Coverage checking is not implemented for shell scripts:

Since currently kcov is not implemented, checking the coverage of the shell
scripts is still an issue. It was also proposed in previous GSoC proposals,=
 but
wasn=E2=80=99t implemented.  I also checked out its implementation for linu=
x kernel
project , but it seems quite difficult to cover this in my GSoC proposal.
Instead, I would run =E2=80=98make coverage=E2=80=99 after I port all funct=
ions to C. This will
also help me find the code for which the test suites aren=E2=80=99t created=
 and
improve the test coverage over submodule code.

Brief introduction of git-submodules

Git submodules are used for including a git repository inside a
subdirectory of another git repository. Submodules have their own
history, and the it doesn't interfere with the superproject's history.
Hence it helps the developers include external dependencies like third
party libraries in their project source tree. Submodules have been there
since quite a while, yet there are still areas to work on.
Currently the git submodule is implemented using various file which are:
'git-submodule.sh', 'submodule.c', 'submodule.h' and
'builtin/sumodule--helper.c'. Hence to convert the script file to
buitin, I would first port and implement all the algorithmic and
non-algorithmic part in 'submodule.c' and in 'submodule--helper.c'
respectively and then finally create 'builtin/submodule.c', which
can call any function from submodule--helper.c directly from C itself.
Eventually, I will be ensuring that the user interface part is
implemented in the builtin/submodule.c , having submodule--helper.c
for using it as plumbing command and will use submodule.c
for writing the reusable part for the code.

Goals

1. Convert submodule subcommands to C.
2. Finally creating a builtin/submodule.c

Plan

1. Understand the code written in 'git-submodule.sh'

   In the community bonding period, my main aim will be to understand
   the code is written in the 'git-submodule.sh' and get a clear
   understanding of how each submodule subcommand is being implemented.
   Understanding the subcommand's logical flow is very important since
   I will be retaining it in the rewritten code as well.

2. Understand what API's could be used and learn about these API's and
   also learn about other plumbing functions which will be required.

   In the community bonding period, once I understand the code written
   in 'git-submodule.sh', I would start the discussion of the procedure
   which will be appropriate for the rewriting the code to builtin.
   Since the procedure of rewriting is not simply translating the code
   into another language, but also to utilize the API's and functions
   available in the later language and to create new API to ease the
   future implementations. Here I will learn about the various API's
   I'll be using during the conversion, will clarify my doubts about
   the implementation of the functions and also check for the need of
   creation of any new APIs. Also, as submodule--helper is a plumbing funct=
ion,
   other such functions will also be used in the conversion and hence is
   learning about them will be useful.

3. Start Converting Submodule subcommands

   As done in the porting of the submodule subcommand 'init', I'll be
   first porting to the submodule--helper, and call the function from
   git-submodule.sh till I convert every subcommand. Then I'll make the
   required changes in the command structure to call submodule on
   place of submodule--helper and also make the similar changes for
   the complete conversion.
   Also while conversion of a single functions to builtin is over,
I=E2=80=99ll immediately
   perform step 4 also, so that while sending out patches, they are well
   tested, as well as the documentation is also updated at the same time.
4. Testing the rewritten code, Optimizing, Documenting and other
changes required:

   The working of rewritten code can be checked with the help of
   available test suites. Also taking into account the bug to be fixed :
   git submodule $cmd $pathspec may want to error out when the
   $pathspec does not match any submodules. [1],
   there will also need to add new test cases in the suite. Also
   the makefile would require changes for updating the build
   process. Once testing is completed, I would start working on
   optimizing various functions written in C so that the code will be
   more efficient. Then finally I would document all the changes. Once
   all of this is done, after sending the patches, the reviews will also
   help in the processes of optimizing the code, as well as improving
   the documentation. Also, I will try to send patches as early as possible
   since, the reviewing of patches takes time, and till then I may start to
   work on next function as well. Also I will try my best to get the code
   merged in time, so as to ensure that I=E2=80=99m on the correct path at =
any
   point of time.

Potential difficulties during the conversion

1. The rewritten code may introduce bugs, which formerly weren't
   present. Most of these bugs would be detected by the test suites,
   which exists. Apart from them, I would stick to following the same
   the structure of the code, as is written in the script form. And even
   after that, if still there are introduced bugs left, I have allotted
   time for fixing these bugs.
2. As it's witnessed in the porting of 'git submodule init' command,
   that the code written in C language takes more lines than the
   scripted code. Hence, this problem may be addressed by creating
   functions and once we identify the recurring code structures, we
   may also want to want to create a GIT API of them for future
   Convenience.

Timeline(Tentative)

April 1 to April 21

Since I started up with this project late. Hence in this time period,
I would like to convert the submodule subcommand 'foreach' from the
shell script to builtin. Also, in this time span, I would go through
the codebase as much as possible.

April 22 to April 28

End Semester examinations at college. Also I have some small class tests
In between 5th April to 9th April, but other than this, I do not
have any other test in between the described timeline( 1 April to
August 31, 2017).

April 29 to May 15:

We like to spend this time, reading the codebase to understand the
software very well and also get my doubts about implementation clarified
from the mentor.Also, this period will be utilized by me to understand
the various git APIs so that they can be used for the code's implementation=
.
Also, in this time span, I'll be discussing the way I
have decided to proceed further, and address any issue related to that.
Since my next semester at college starts on July 14th, I will prefer to
start actual coding by 16th May itself, giving sufficient time for
understanding the and for community bonding as well.

May 16 - July 3: (Week 1 - Week 7):

There are around 7 subcommands(excluding for each) of git submodule in
'git-submodule.sh'. I would require on an average 4 days to complete
the conversion of each subcommand. And finally to merge 'submodule.c'
and 'builtin/submodule--helper.c'. Also during this process of code the
conversion itself, I would like to address the BUG:  git submodule $cmd
$pathspec may want to error out when the $pathspec does not match any
submodules. [1]
I will also be keeping some additional buffer time here.


July 4 to July 17: (Week 8 - Week 9):

In this span of 2 weeks, I would like to fix the bugs introduced by the
new code. Also, will be working on fixing the issue: git submodule $cmd
$pathspec may want to error out when the $pathspec does not match any
submodules. [1]

July 18 to July 31: (Week 10 - Week 11):

Check the test coverage of the code, and improve it, wherever required.
Also will work on optimizing the code written, as required.

August 1 to August 7: (Week 12):

I would keep this final week to polish the code in written till then,
and give it the final touches as required.

August 8 to August 29 :

I would like to keep this time as buffer, for fixing any bugs created by th=
e
rewrite. Also in this time I would like to work on my wish list if I have t=
ime
remaining.

Wish-list

I have already discussed these topics before [2], but since I was more
interested in doing the above project, I=E2=80=99m adding these to my wishl=
ist.
1. "git -C sub add ." might behave just like "git add sub"
2. Teach "git -C <submodule-path> status" in an unpopulated
   submodule to report the submodule being unpopulated, do not
   fall back to the superproject.
3. Teach "git log -- <path/into/submodule/and/further>" to behave
   like "git -C <path/into/submodule> log -- <and/further>"

Microproject Attempted

The microproject which I attempted is: =E2=80=9CAvoid pipes in git related
commands for test suite=E2=80=9D. I hope it would soon get merged.
You can find my patch here.[3]

Plans for Summer

I recently went through an ACL-reconstruction surgery, and hence in
summers I'll be just continuing with the physiotherapy I'm
undergoing from last 3 months.


[1] : https://git-blame.blogspot.in/p/leftover-bits.html
[2] : https://public-inbox.org/git/CAME+mvW1x6fnGKt1_auGOp+wFYFR=3DY_Qhxfd5=
0E7KFe6t+X4kw@mail.gmail.com/
[3] : https://public-inbox.org/git/20170324120433.2890-1-pc44800@gmail.com/
