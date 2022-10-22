Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AFAC04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 11:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJVLoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiJVLnz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 07:43:55 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E55B85
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 04:43:48 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j7so6119000ybb.8
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 04:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vk0uvnHUBzpZGfSwPcDxGbnCpFOHd3J9s/r1TKblGUI=;
        b=XifwdxHPPZ26m1mUnB9RN5A74bw8//hpBiFJJcGYJnuRntk+ZUjJKetYh8OhNAhDYq
         jSBGczxbPwW9LQ/RdMG0AqgKaLk1EF5pn6a+PZusF9qmnJ1Tvd5xQsMWmU/BA42VJz6U
         fLOu1bS2mP0XzB+s5PNzPq7XhtVK+NTzWmAQYPtyMxxgv630HG0aN2lgCWtnR+14OvAK
         gVE/CCKkDg3SOXGVASIjek8m8/1MWlg3xQ4i+ZoL11Pru1ko74xmeHdeVd0Y2nVUt0Gf
         x79nIRnKe5FXY9xwkQLmenSzY4eqXcm9/IQu4mY4Xx0ukaj9wiMqqumMcU3nrdATYr1T
         fsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vk0uvnHUBzpZGfSwPcDxGbnCpFOHd3J9s/r1TKblGUI=;
        b=Mno8sh4n3EUyzubaY2BjS9ebeD8hX+exsxyg6R9ECidqbb/NjtoVTJT0ovC8N6Uo1S
         RLeCBP+pycTzbarf3s3acmXTzoZlh1Lcn1iZgSj2LN3AUxL8KLTEgoQ47PqLbpuuoJow
         PJ5syUr712CznGU9TH6ywIPJZxIzk9ZSxWwcoPwJZ/GDLVIe5Q1SCM0ZAPq4Q3mj+7Uf
         YcoRzaMF7nxJ/SuKjsRaksQ7AybkIBsgvgFFe83s0wwgvW6H3UtJEk6uscdtSLdVfX6F
         19NWTFmaaIDre2I5K56mNuyhJ9x6rJ2PgBbztv3O2lgqo6h+JWAH8/1sTJkIxx+cSOYl
         X4Dw==
X-Gm-Message-State: ACrzQf0wTLDsShJxEyXHkQKSCXTs28vnnM+/zXbzLfQvfmqDjAKBud/s
        x1DbgAEblSM2t/R4ewEvhY97xHWAeZOoNquL9NLo5fnj2ME9isxxXpnHfw==
X-Google-Smtp-Source: AMsMyM6gl2b9XNIA8syKUvQ8Vn0pV2dWCtOGDuRiYRODiK8e+qPF4+siqZ7qZSwWLK0m87/0jEzBrRGTv7+m7pKIl2Q=
X-Received: by 2002:a25:888f:0:b0:6a8:f77c:4f96 with SMTP id
 d15-20020a25888f000000b006a8f77c4f96mr20561400ybl.103.1666439027818; Sat, 22
 Oct 2022 04:43:47 -0700 (PDT)
MIME-Version: 1.0
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Sat, 22 Oct 2022 14:43:36 +0300
Message-ID: <CA+PPyiGtoO4HYA+Z8_te5d0oBLYAxcXeZdTH17AJYaoZ32ObfQ@mail.gmail.com>
Subject: [OUTREACHY] Unify ref-filter formats with other --pretty
 formats[Draft proposal]
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,
I would like to have reviews on my

Google Docs link:https://docs.google.com/document/d/1Kdx8DVWF3c5pwV5-A8Z4n-=
SoRHlMDncI1gNeGCiLNsE/edit?usp=3Dsharing

Name:Nsengiyumva Wilberforce

Major:Software engineering

Mobile no.:+256 785065399

Email:nsengiyumvawilberforce@gmail.com

IRC:wilber4c

Github:nsengiyumva-wilberforce

Linkedin:https://www.linkedin.com/in/nsengiyumva-wilberforce-623664192/

Time Zone:EAT (UTC + 03:00)


About me

I am doing a Bachelor of Science in software engineering at Makerere
university in my 4th year(final). I spend most of my time writing PHP
applications. I am also interested in Java and embedded systems
development and I have participated in embedded systems development
projects like AdEMNEA.



Microproject

When I was browsing the outreachy projects on outreachy website, I was
super excited about Git because I use it in most of my college work.
At first, it was intimidating for me to introduce myself to the
community. But I am glad I took a step. I am glad that I completed my
microproject and the whole process gave me confidence on how to submit
patches, communicate with the community members and interestingly, it
was a big learning process for me.  The following are the details
about my microproject with public-inbox links to different versions.


Mailing List for the microproject:
https://lore.kernel.org/git/pull.1362.v4.git.git.1665772130030.gitgitgadget=
@gmail.com/

Github:  https://github.com/git/git/pull/1362

Status: next


Proposed Project

Abstract

Git has an old problem of duplicated implementations of some logic.
For example, Git had at least 4 different implementations to format
command output for different commands. The foremost aim of this
project is to simplify codebase by getting rid of duplication of a
similar logic and, as a result, simplify adding new functionality.
The current task is to reuse ref-filter formatting logic to minimize
code duplication and to have one unified interface to extract all
needed data from the object and to print it properly.

Previous Work

Hariom Verma contributed(final report) tremendously towards =E2=80=9CUnifyi=
ng
Git=E2=80=99s format languages=E2=80=9D during his 2020 GSoC internship. Ha=
riom
finished most of the formatting options and this will help me build on
his work.  His work looks smart and understandable thus adding on his
work will be easy. And also his blog is very fabulous, it=E2=80=99s a shoot=
ing
point for me to start understanding the codebase very well. Hariom
mentions in his report that 30 % of the log related tests are failing,
he also mentions that the cause of tests failure is because of the
missing mailmap logic and mbox/email commit format. Hariom also says
it does not handle unknown formatting options. I plan to start with
his advice about the cause of the failure of these tests and then
intuitively refactor them into something cool.

Summary of remaining tasks by Hariom

-Around 30% log related tests are failing

-Teach pretty-lib.{c,h} to handle incorrect formatting option

-Email/MBoxed commit format needs work

Some useful mailing lists links from Hariom

Improvements to ref-filter
Fix trailers atom bugs and improved tests

Unify trailer logic for pretty.{c,h} and ref-filter.{c, h}


Olga<olyatelezhnaya@gmail.com> has done great work in =E2=80=9CUnifying Git=
=E2=80=99s
format languages=E2=80=9D during Outreachy Round 15 and continued even afte=
r
that [from 28-09-2017 to 04-04-2019]. Her work is mostly related to
`cat-file` and `ref-filter`.

She already did a pretty nice job in preparing ref-filter for more
general usage of its formatting logic. It will give me the possibility
to make the migration of pretty.c easier.

The Plan

My task is to look at how pretty formats are different from ref-filter
formats. When some format is supported by the pretty formats but not
by the ref-filter formats, and should prepare some patches to support
the ref-filter format. I will basically build on Hariom=E2=80=99s previous
work

Step 1:List down all the formats supported by the pretty format but
are not supported by the ref-filter format

Step 2:Read through different patches related pretty and ref-filter
formats submitted by different contributors to get a solid and a
thorough understanding of the pretty and ref-filter formats.

Step 3:Understanding an implementation of one or two pretty formats,
and then look at how it was implemented in ref-filter format. This is
going to give me direction to refactor the remaining pretty formats

Step 4(possible approach): Pick one format option at a time and
convert it to use ref-filter option format

Estimated Timeline

Time Period



period: December 5,2022 - January 2, 2023
Community bonding
tasks
-understanding all the logic of pretty.* and ref-filter.*

(what functions are used and how all formatting process is going)

-Working with mentors and identifying the best candidates to be converted f=
irst.

-Converting a couple of formatting options to reuse ref-filter formatting l=
ogic.

-Update Documentation.


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

I can easily devote 50 hours per week since my college just requires
15 hours per week. I plan even to work more extra hours for my
internship tasks when time allows.


Post Outreachy

Apart from being an Outreachy intern, I plan to remain a member of git
community even after my internship, because I believe there is more
today even after the Outreachy internship

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
