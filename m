Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B688C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 10:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiKHKzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiKHKzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 05:55:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910445EC3
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 02:55:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i5-20020a1c3b05000000b003cfa97c05cdso796859wma.4
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 02:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dg9vcENzNN5XILcbdpZOxP1hZLSRuSQWzhzTxVF8SVY=;
        b=PA/kPaS0x84Z3xgfrEv0QaCEAr1wzP+YQCWtAIB4NftL8r5GJhG9SScqGbMmPHxibG
         55F21Cry49R5YTEUlvtVkwOK8SPD23ZcR+6K81T3PnaNQJbGTy0Ub27bA7TDAxkPGKTp
         H379Zh6Ego1Mj8Qb3Qm+Uiiz4xObL1hrKxO5cKP6FdqGHgxgIWOxpvDvoCkLO6DaN9LN
         DGE/V/w/CIeF+ey8xCmT8a4+8r8BKPlX0768ycHdzZ6G3Vy0kLnV9LvVpckQsI5BgmPR
         JcFsdNMRaejAXLVuBfflDfvqGcYum49Dxz36w4ucoap5ge8xT1t2K43LYKwCsZWtXByy
         Iqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dg9vcENzNN5XILcbdpZOxP1hZLSRuSQWzhzTxVF8SVY=;
        b=iETcTaP3D6xoX/vFezpYKxA1NSXvh0BeKM7+JU6C99rcSFyKNsFR81cK+BAgPMFj92
         sxYZLAgHq3mCwHGyg1Iv2oBlNGA7bEG1BfZKIcvn2jgWSCdYfKO4yj42mKZYbZ2PsyrV
         SrOLiHzom6unhrhGDpttgUJObV9bDVSs06iw0L9j1340DeYztVmX4qBZnMzxcWO94m0g
         Ejz733C/sbpL1Bya1BtAnGaFY0P087FqxRPUlf4b+KVG9d1WllC7zDqmav5RYyCcZDXa
         VlkWQBFML2Lc+ouZbqH2yRiqltJvc3L8eSGwCIc/L138xXowrtMB59FJu/I9OsjDHVe6
         1E5Q==
X-Gm-Message-State: ANoB5pnwEzb2GNKqPkfL/AsXTtCGbnyBOiqjXerrFdiCt/0BHN5dgEzg
        rs8QTzRTGBTk1s3PAcMooExhoD+UqY+prfpiHOtiS4LFuUoe5Q==
X-Google-Smtp-Source: AA0mqf7W7P0t9r1ZysBXbdglrOjkv+XMakuhVONUvLOsOnUbN8U/U78vLoPS519FdISnI0RP5V4OY8nw5nTrK1PDNco=
X-Received: by 2002:a05:600c:548e:b0:3cf:a6d9:7b0b with SMTP id
 iv14-20020a05600c548e00b003cfa6d97b0bmr8382060wmb.94.1667904914934; Tue, 08
 Nov 2022 02:55:14 -0800 (PST)
MIME-Version: 1.0
From:   Debra Obondo <debraobondo@gmail.com>
Date:   Tue, 8 Nov 2022 13:55:01 +0300
Message-ID: <CADZqe6cMahXdj0D+QZpHfOzjs9hu1PErjE+qT+PSo1FcbLkWow@mail.gmail.com>
Subject: [OUTREACHY][DRAFT Proposal] Unify ref-filter formats with other
 --pretty formats
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Team,
This is a draft proposal for the Outreachy Internship, could I kindly
have your reviews on it.
https://docs.google.com/document/d/11HX9dkEH--ZfXBTRWJ8rhGnlf3Bj_n_4U2Z-qgb=
DYVM/edit?usp=3Dsharing

Below is its basic structure:

UNIFY ref-filter FORMATS WITH OTHER --pretty FORMATS

Personal Information

Name: Debra Obondo

Email: debraobondo@gmail.com

University: Jomo Kenyatta University of Agriculture and Technology

Telephone Number: +254743635117

Course: B.Sc Electronic and Computer Engineering

Github: https://github.com/fobiasic07

LinkedIn: https://www.linkedin.com/in/debra-obondo

Timezone: Nairobi (UTC+3)

Location: Nairobi, Kenya


Abstract

Git has an old problem of duplicated implementations of some logic
such as the four different implementations for formatting command
outputs for different commands. Ref-filter {.c.h} and pretty-lib
{.c.h} formatting logic have been no different and require(/d)
unification, which will help to simplify adding new functionality as
Git continues to develop.


This project was initially proposed by Hariom Verma following his FOSS
contributions to Git and Olga<olyatelezhnaya@gmail.com>=E2=80=99s work on
=E2=80=98Unifying Git=E2=80=99s format languages=E2=80=99.


In his final report, he had completed almost all pretty format
implementation with a few challenges :

30% Log related failing tests on branch pretty-lib-2.0.2

Inability of pretty-lib {.c.h} to handle unknown formatting options.

Mailmap logic in ref-filter requires modification due to the new email
options which do not allow rebasing and consequently affects the MBOX
commit format.

MBOX commit format.

Completing the work and Rebasing a few other pretty-lib branches with
features such as fix-graph3 using Junio's way to pretty-lib-2.0.2


He also brought attention to :

Olga=E2=80=99s remaining work https://github.com/telezhnaya/git/commits/for=
mat


The purpose of this Internship Project is to solve the challenges,
submit well-functioning patches and increase functionality and
simplicity in pretty-lib {.c.h}.

Deliverables

The purpose of this project having been to improve and easen the
functionality of pretty, I aim to deliver in the following:

Working on failing formats to pass tests and maintain desired functionality=
.

Easen error identification when handling unknown formats.

Update MBOX commit format so that it still holds initial settings with
additional functionality.

Modifying mailmap logic to allow additional application.

Finishing work in other pretty-lib branches and merging with original
once tests are passed successfully.

Update documentation for ease of understanding

Final report on the improvements made and their importance.


Work that may be done if the above is completed before the end of the
project timeline:

Understanding Olga=E2=80=99s work in depth.

Working on the formats in ref-filter that were being adopted from cat-file.

Write and run passing tests for the formats when using ref-filter.

Working on expanded and added cat-file formats.

Update documentation on both cat-file and ref-filter work related to
Olga=E2=80=99s work.


In the case of the outreachy timeline having been passed, I plan to
work on this during the two months left in my long after-semester
break to further my knowledge on git and remain an active member of
the git community.


Project Implementation

The project will be done using Git, Bash Scripting and C (and likely Google=
;-)


Since I am about to finish my current semester, my exams (5th - 16th
December)  are likely to clash with the start of the internship, but
not to worry, since after that, I will be able to give my full-time
concentration to this project, about 45-50 Hours or more a week, since
I will be having an academic year break between then and 8th May 2023
before my final academic year begins.. Below is my programming plan.


Programming Plan

I have divided my programming plan into 5 parts, which would be as follows:

PART 1(Pre- Program);

This is before the official start of the program, between now and 5th Dec :

I plan to familiarize myself better with the community, submit a few
patches using 'git send-email', as it enables ease of communication on
various contributions and projects as compared to gitgitgadget.
Learning and understanding the logic and format functionality of both
the pretty and ref-filter commands is a priority to easen working on
the project later on. If accepted, plan for the required weekly
mentor-mentee meeting time(s). I also plan to understand the function
die() by going through this project: Issue #635

PART 2 (Phase 1); 5th Dec -2nd Jan:

This is during the first third of the program:

Working with mentors to identify the log-related failing test formats.

 Reworking the failing formats to pass the tests, while still
functioning in the required unified logic.

Share the first two blogs via my social media handles.

 Update Documentation.

Start on 'handling unknown formatting options'

 Feedback #1 submission

PART 3 (Phase 2); 3rd Jan - 1st Feb:

During the second third of the program:

 Working on the die() function, to figure out the best way to handle
unknown formatting options by pretty, be it creating a new 'die'/end
process function with more options,, mentor and community discussion
will help.

 Feedback #2 submission

 Modifying mailmap logic in ref-filter to allow rebasing, in turn,
working on the MBOX commit format.

Share my learning progress and challenges in other two blogs.

 Update Documentation.

 Feedback #3 submission.

PART 4 (Phase 3): 2nd Feb - 1st March:

During the final third of the program:

 Working on the other pretty lib branches (yet to go through them) and
rebasing/ merging the features to pretty-lib 2.0.2.

 Sharing my experience with Git as an FOSS community and giving my
final report through blogs.

 Fix any bugs that may be left and 'polish' the work on --pretty and ref-fi=
lter.

 Update Documentation.

Feedback #4 submission.

Part 5(Post-program):

After gaining many skills from working on the above, I believe I will
have the capacity to take on Olga's work during the remaining 2 month
break that I will be left with. In the case of similar projects during
GSoC 23';-) or Outreachy May to August, I will also be willing to
mentor, since teaching helps us learn more.

Perceived Obstacles and Challenges

Test Fails

This is always a possible occurrence in programming, therefore,
together with my mentors and the git community, solutions are highly
likely to emerge.

Maintaining compatibility for both newer and older systems

This is majorly in the mbox commit format and mailmap logic issue.
Further research and various opinions will lead to us finding the best
way forward.

Overflow of work past the internship period

This is likely to occur with rebasing of the other pretty-lib branches
and Olga=E2=80=99s work and can easily be dealt with by me giving more time=
 in
the case of not reaching my timeline personal set deadlines.

About Me

I am a fourth year B.Sc student taking Electronics and Computer
Engineering at Jomo Kenyatta University of Agriculture and Technology,
Kenya. I have also been a member of the ALX-Africa-2022 Software
Programme.


I recently decided to venture into software as my career path. This
was during my attachment at Gearbox Academy , where I gained skills in
Web Development, Microcontroller processing and 3D Design.


I have experience with C from my coursework and ALX practice and level
3 skills and knowledge in BASH scripting and Git, which I would like
to further improve on. I believe contributing to this open source
project will help me to further grow my skills and widen my knowledge
on FOSS as a whole.


Equipped with this chance, I shall also use the skills learnt to help
future developers on similar projects and to continue contributing to
git and other open-source projects.


Requirements


This is the micro project required while submitting the proposal for
the Outreachy 2022 program:
https://lore.kernel.org/git/pull.1372.git.git.1667150441883.gitgitgadget@gm=
ail.com


Description:

Older test scripts have used the command 'test -' to verify the
presence or absence of features such as files, directories and
symbolic links. This however requires slightly complicated uses, such
as 'test ! -f '. The helper functions 'test_path_is_' located in
t/test-lib-functions.sh have taken into account all scenarios of the
'test -*' to reduce errors. This was a microproject to replace them
with the helper functions.


Test script to verify the presence/absence of files, paths,
directories, symboliclinks and many other features in mv command are
using the command format


'test -(e|f|s|h|...)=E2=80=99


Replace them with helper functions of format


'test_path_is_*'


At the time of submission, this patch has been queued into =E2=80=98seen=E2=
=80=99
preparation for merging into next and eventually master: t7001-mv.sh
commit

Motivation

Git members are welcoming, I feel it will be a good learning community
for me to grow as an Open source contributor and software programmer,
which is one of my personal targets. During my contribution, I
received understandable feedback in a short period of time and was
able to make =E2=80=98polished=E2=80=99 and =E2=80=98out-of-the-blue=E2=80=
=99 patches as required.
(It=E2=80=99s part of the conversation thread in my microproject) This brou=
ght
to my awareness that git is an easily approachable community for any
programming challenges faced.

References

Git SoC 2022 Ideas : https://git.github.io/SoC-2022-Ideas/

Git Soc 2022 Applicant Microprojects :
https://git.github.io/SoC-2022-Microprojects/

The Final Report by Hariom Verma:
https://harry-hov.github.io/blogs/posts/the-final-report

Looking forward to your responses.

Kind regards,
Debra obondo.
