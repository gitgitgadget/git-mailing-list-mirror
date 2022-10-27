Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63C0FA3742
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 11:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiJ0L6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiJ0L6l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 07:58:41 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C987625C4
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 04:58:39 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id m125so1608300ybb.6
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 04:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K6JDZW8EuS20CYabp+6A+Dk+wcp5qgmjr0y6DZmi704=;
        b=DYLJmWUYjMZ52WVpWdBHAqLRkxb8p7NnVGlglZNnQXeHsNqyPQodzETNzNqnB24Ivy
         kxHImvDYGjFYJuqwUmc1XjnGi0LUUaI0YvBYNXOVRBn6wArKpVdAmDO2Rn0C0/DBXmXm
         HH0018Xd730nDRV1DinMoFkIF399yZcsKFtkvG++O3FjiTz6uSYNZZBHXCTW1JvTsyjX
         pJn41CDVF/6hE7nFryCMCLNtRtTyZWzfPtHn+UToZwpvxEsWF8bb9ch4b+LoNkm6WOI2
         OOk4g8DPXj6D6eZUJrHFCj/vehjd35JFKkUxigGUWaa5NGdAd4oi67jy0H+X63XqHsDF
         bE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6JDZW8EuS20CYabp+6A+Dk+wcp5qgmjr0y6DZmi704=;
        b=x1E13WuTiRS69T5DErPI07jctXv8FRz3n7RhFHFU+4ar5pvH5VlKztFM/s8hSw7PsL
         GgLWftHeXVOqfyZ+td+9Y8uUe2Ct7agkIjJ2JiRMaQKnfID88R+LVElGE7YCoqVpA4vU
         0J3bm6gEDmpwGzvyddH21nMhAPAeYZshvEeIEBaRQdeDf5aTlrM1wXjlkybuwvn2wV1x
         ZBknAmiCdCmggGOhig0G4cUEp1uX49CskW/o9ugjV3Gewq/vQ0oy6dSzwtXADeOAs8ZX
         f6smyt2WqVABxRWDin7uX+TgVTNDVMhzSjKPJjReHa0kSYVmE5ZGWWO/7iXZcygu3stk
         vM7Q==
X-Gm-Message-State: ACrzQf3DhQ2AVZQ06sPhCjQN7RxY2xflwbXSLxuANb+Jgck6WzwXelXa
        UsSvXTQsj2PD9MPevip/eYdeTHAAtRiTrDS92r612Xj1+lqxMe0Twuf37SRh
X-Google-Smtp-Source: AMsMyM5b45OaagrNX9k9m8GTBD/G1Lz2AAb1aInOuGsLrD7CCaVDoGURgfBQTu6MHm5/ir+B/DvYkrEag6Joir/lDiI=
X-Received: by 2002:a5b:110:0:b0:6be:3546:b761 with SMTP id
 16-20020a5b0110000000b006be3546b761mr44963433ybx.203.1666871918356; Thu, 27
 Oct 2022 04:58:38 -0700 (PDT)
MIME-Version: 1.0
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Thu, 27 Oct 2022 14:58:27 +0300
Message-ID: <CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com>
Subject: [OUTREACHY V2] Unify ref-filter formats with other --pretty formats[proposal]
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,
I am super excited and eagerly waiting for your comments on my second
version of the proposal. I have addressed all the comments that I was
given in the first version.

Google docs link:
https://docs.google.com/document/d/1Kdx8DVWF3c5pwV5-A8Z4n-SoRHlMDncI1gNeGCi=
LNsE/edit#

Name:Nsengiyumva Wilberforce

Major:Software engineering

Mobile no.:+256 785065399

Email:nsengiyumvawilberforce@gmail.com

IRC:wilber4c

Github:nsengiyumva-wilberforce

Linkedin:https://www.linkedin.com/in/nsengiyumva-wilberforce-623664192/

Time Zone:EAT (UTC + 03:00)


##About me

I am doing a Bachelor of Science in software engineering at Makerere
university in my 4th year(final). I spend most of my time writing PHP
applications. I am also interested in Java and embedded systems
development and I have participated in embedded systems development
projects like <https://www.ademnea.net/>.

##Microproject

When I was browsing the outreachy projects on outreachy website, I was
super excited about Git because I use it in most of my college work.
At first, it was intimidating for me to introduce myself to the
community. But I am glad I took a step. I am glad that I completed my
microproject and the whole process gave me confidence on how to submit
patches, communicate with the community members and interestingly, it
was a big learning process for me.  The following are the details
about my microproject with public-inbox links to different versions.


Mailing List for the microproject:
<https://public-inbox.org/git/pull.1362.v4.git.git.1665772130030.gitgitgadg=
et@gmail.com/>

Github:  <https://github.com/git/git/pull/1362>

Status: next


##Proposed Project

Abstract

Git has an old problem of duplicated implementations of some logic.
For example, Git had at least 4 different implementations to format
command output for different commands. The foremost aim of this
project is to simplify codebase by getting rid of duplication of a
similar logic and, as a result, simplify adding new functionality.
The current task is to reuse ref-filter formatting logic to minimize
code duplication and to have one unified interface to extract all
needed data from the object and to print it properly.

##Previous Work

JayDeep Das(GSoC) tried to =E2=80=9Cadd a new atom =E2=80=98signature=E2=80=
=99=E2=80=9D. However, I
have not been able to find his complete work in the public box, it
seems his work was not complete. According to
<https://github.com/JDeepD/git-1/commit/85ddfa4b33f2b6f05524e648e7165c72218=
8093e>
which was suggested at the outreachy website, it looks like he did not
complete writing the tests for the signature atom he was unifying.
Maybe with the help of the mentors, I could plan to start from where
he stopped from.

Hariom Verma contributed(https://harry-hov.github.io/blogs/posts/the-final-=
report)
tremendously towards =E2=80=9CUnifying Git=E2=80=99s format languages=E2=80=
=9D during his 2020
GSoC internship. Hariom finished most of the formatting options and
this will help me build on his work.  His work looks smart and
understandable thus adding on his work will be easy. And also his blog
is very fabulous, it=E2=80=99s a shooting point for me to start understandi=
ng
the codebase very well. Hariom mentions in his report that 30 % of the
log related tests are failing, he also mentions that the cause of
tests failure is because of the missing mailmap logic and mbox/email
commit format. Hariom also says it does not handle unknown formatting
options. I plan to start with his advice about the cause of the
failure of these tests and then intuitively refactor them into
something cool.

##Summary of remaining tasks by Hariom

-Around 30% log related tests are failing

-Teach pretty-lib.{c,h} to handle incorrect formatting option

-Email/MBoxed commit format needs work

##Some useful mailing lists links from Hariom

- https://public-inbox.org/git/pull.684.v4.git.1598046110.gitgitgadget@gmai=
l.com/

- https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@gmail.c=
om/

- https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@gmail.c=
om/


Olga<olyatelezhnaya@gmail.com> has done great work in =E2=80=9CUnifying Git=
=E2=80=99s
format languages=E2=80=9D during Outreachy Round 15 and continued even afte=
r
that [from 28-09-2017 to 04-04-2019]. Her work is mostly related to
`cat-file` and `ref-filter`.

She already did a pretty nice job in preparing ref-filter for more
general usage of its formatting logic. It will give me the possibility
to make the migration of pretty.c easier.

##The Plan

My task is to look at how pretty formats are different from ref-filter
formats. When some format is supported by the pretty formats but not
by the ref-filter formats, and should prepare some patches to support
the ref-filter format. I will basically build on Hariom=E2=80=99s previous
work

Step 1:List down all the formats supported by the pretty format but
are not supported by the ref-filter format e.g

User formats like %ah, %ch, %d, %D, %(describe[:options]), %S,
%GG,%G?, %GS, %GK, %GF, %GP, %GT, %gD, %gd, %gn, %gN, %ge, %gE, %gs.
PS: I am not pretty sure if this list is exhaustive.

Step 2:Maybe s/related/related to/ formats submitted by different
contributors to get a solid and a thorough understanding of the pretty
and ref-filter formats.

Step 3:s/Understanding/Understand/, and then look at how it was
implemented in ref-filter format. This is going to give me direction
to refactor the remaining pretty formats

Step 4(possible approach): Pick one format option at a time and
convert it to use ref-filter option format


#Estimated Timeline


period: December 5,2022 - January 2, 2023
Community bonding
tasks
-understanding all the logic of pretty.* and ref-filter.*

(what functions are used and how all formatting process is going)

-Working with mentors and identifying the best candidates to be converted f=
irst.

-Converting a couple of formatting options to reuse ref-filter
formatting logic and update the documentation


period: December 25, 2022

Christmas celebrations: Join my parents for celebrations

period: January 1, 2023:
New year=E2=80=99s day holiday:Join my parents for celebrations

period: January 3 - February 3, 2023
Coding Phase 1
tasks

-Add on Hariom=E2=80=99s work:Converting more formatting options to reuse
ref-filter formatting logic.

-Finish his incomplete work

-Update Documentation.

-Possibly look at Olga=E2=80=99s work

period: January 18, 2023: Cake cutting with my  friends
My Birthday:cake cutting

period:From January 6 - January 18, 2023:
Semester Exams: I will be working for a few hours per day and always
be available to reply to any communication

period:February 3 - March 3, 2023
Coding Phase 2
tasks
-Final touch-ups and bug fixes(if any)

-Update Documentation

-Wrapping up.
Blogging about Git

I do love writing a lot however much I have not taken time to put out
my personal opinions and thinking. Being an avid reader, I think it=E2=80=
=99s
now my time to start letting other people read what I write, to let
people know what I think, what I am doing with my life. And guess
what, I am super excited to start with Git.

Availability

I can easily devote 30-40 hours per week since my college just
requires 15 hours per week. I plan even to work more extra hours for
my internship tasks when time allows.


Post Outreachy

Apart from being an Outreachy intern, I plan to remain a member of git
community even after my internship, because I believe there is more to
do even after the Outreachy internship

Here are some other things I=E2=80=99d like to do beyond Outreachy

Mentor other students

Doing code reviews for other contributors

May be complete the work that I will have left pending after my internship

Keep learning from all of you...

Experience with Open Source

I have little  experience with open source, so I hope to learn a lot
through my internship with Git from you all.


Motivation

Git being a world=E2=80=99s best developer version control system, I feel
overjoyed that even my little first patch was accepted. The community
is very welcoming, the people there answer questions very first and
this turns everything overwhelming to a simple process


Closing remarks (Optional)

I am a consistent and passionate learner. Even if solving a problem
may look tricky to me, I just give it all my 100% time and think of
1000s of ways to approach it. I know I do not have the required
expertise to begin working with a skilled team like Git but I believe
in learning slowly by slowly until I will make it to the peak.


I hope you consider and give me a chance to work with git. It=E2=80=99s a
great hope I have that this opportunity is bringing me closer to my
dreams. Thanks for your consideration.


Best Regards


Nsengiyumva wilberforce
