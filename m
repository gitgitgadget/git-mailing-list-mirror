Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992BC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 10:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjDCKqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 06:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjDCKqq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 06:46:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720FE4212
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 03:46:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x17so37499436lfu.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 03:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680518801;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j/kyMGBxlFCEGsSn9VWMYw1tIey/g9r1hsF4rVv6nBg=;
        b=bvpsn20GhAXYDiqpRkZLmPCMYgf4kSRZtz0Ql6UoeHOVhvhaYPtScG8YheoHRbKKX5
         OVBBEmNhTiGNfD8RtX9aNU1IFJiSo9eJvY+BHvrJtY7GrqYp+A5uuFaM0EaAzCw69WBp
         Z/Udkb7YdVDyiH6qdBgEgnqH0j15UXt9rYP/Hc28KVv3K1jQ0Kf5g4A51ndKm124HNjz
         jovg1yxTvk7T6gkm/dV2OlVedvuNloyr+5IePlby/9Yfy2boRqL4qJAkwWkEXmD0HTio
         NLvyR8K7XzZ39wooIA3Sonu+vMbdqW+DNChzgfKCp5Vz2LWhBCTCTKFaDWUcF2eZsc62
         ylaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680518801;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/kyMGBxlFCEGsSn9VWMYw1tIey/g9r1hsF4rVv6nBg=;
        b=pvKzVWS0n/7iUkl5HVlQLil2vgOBgoTHMZER8Iv5mFhI2OQOOfjLrKvESJmue4gK61
         nfzdXQEvbN+DJxd3jUgB7SSnPGfMK3o8kYxBsDfFy8wMG31+8Twq+63c1kun3IYMaga+
         t9LUMRlsu5VqSQ+O23pSazh4+LX10lylmsuthkfg9fyOMol9zcDlnMuirR3eRSW6jH87
         1vsILR88//KTZbMNcnZQYH4XuP83V7WKni1nBKGVFfpgiUTgsTzHtWyRDPeCcVLbs8vO
         osu+cxGCRwWLtRePQocZexhHUzkFO1qY9G/E+ArnjQBd3/iwWQGzuqxrsEGwk+R7NT2d
         Jcug==
X-Gm-Message-State: AAQBX9f/M1KviyjsBIQHLVBzBrLTexhtTKPjRa0N+XVwRy5Li+w7SU61
        6E8oJQ3RkA2RHl78EKFJVtPuYynWOzmzo19QsuCmU7WPNAs=
X-Google-Smtp-Source: AKy350aBPUcqlS4qcEs5nhmhmpEawqJ3a9cEGYLLgNd6+TvGb+DI+1k99kJcD0lywBiP0s2S2OefA8qWee8Eu+rPetk=
X-Received: by 2002:a05:6512:ea7:b0:4e8:3ee1:db14 with SMTP id
 bi39-20020a0565120ea700b004e83ee1db14mr7775200lfb.6.1680518801068; Mon, 03
 Apr 2023 03:46:41 -0700 (PDT)
MIME-Version: 1.0
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Mon, 3 Apr 2023 16:16:29 +0530
Message-ID: <CADE8NaopF=xRJQvM1SbDYj6+O0dqSOJA0AY7roorLDc0G4oEPA@mail.gmail.com>
Subject: [RFC][GSoC Proposal V1] : Unify ref-filter formats with other pretty formats
To:     git@vger.kernel.org, christian.couder@gmail.com,
        hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone! I am sorry for being off the mailing list for so long,
my University exams were going on. This is a draft for my proposal for
GSoC 2023, with Git as my mentoring organisation. Thanks a lot!

-- Unify ref-filter formats with other pretty formats --

-- Personal Information --
==========================
Name:               Vinayak Dev
Email:                vinayakdev.sci@gmail.com
Github:              @vinayakdsci
Ph no:               +91-9119055909
Education:         Bachelor of Technology,
                          Computer Science and Engineering
                          University of Engineering and Technology, Roorkee.
Year/Semester: 2nd/IV


-- Overview/Synopsis --
=======================
Git has had the problem of different implementations to format command
outputs for different commands in the past. Through the efforts of the
community members and the past GSoC and Outreachy participants, much
of the formatting logic has been unified into ref-filter.c, allowing the
code base to get rid of duplicate implementations.

The current task of the project is to continue this effort and use the
formatting logic from ref-filter.c in pretty.c, to allow getting rid of
duplicate formatting logic.

Outreachy participant Olga Telezhnaya and GSoC participant Hariom Verma
provide a good insight into the logic and approach required for using
ref-filter formatting logic with other commands, like git cat-file, etc.
Olga also makes an attempt to generalize the formatting logic in
ref-filter.c to allow for migration to other commands easier.

Their blogs at [1] and [2] are a good starting point to understand the
structure and the history of the work on this idea.

Nsengiyumva Wilberforce also sent patches to the mailing list[3] where
he added a new `signature` atom to ref-filter.c. His work allows to get
rid of the implementation of the `signature` atom in pretty.c,
moving it to ref-filter.c for better unification of the logic with
other commands.

Also, the discussion[4] on the mailing list, with a patch series
concerning pretty.c by Anders Waldenborg add and improve upon the
features of git's pretty-formatting, with insightful comments about the
process from the reviewers, Eric Sunshine, Junio C Hamano, and
Jeff King.

[1] https://medium.com/@olyatelezhnaya
[2] https://harry-hov.github.io/blogs/posts/
[3] https://lore.kernel.org/git/?q=f%3A+Nsengiyumva+Wilberforce
[4] https://lore.kernel.org/git/20181104152232.20671-1-anders@0x63.nu/T/#u


-- Before GSoC --
=================
I joined the Git community in February 2023, and have since then been
hugely inspired by the efficient and strong workflow, and how the
members encourage newcomer's contributions, despite Git being such a
large scale and important project.

To understand the source code, I have referred to many sources, some of
them being the Reference Manual, Git Internals, Hacking Git, and the
Pro Git book by Scott Chacon, all of which provide a good and deep
insight into the working of a git, both on the level of the terminal
commands, and the source code. (including MyFirstObjectWalk)

I have submitted following patches to Git:

1. [PATCH] t9160: Change test -(d | f) to test_path_is_*
   Description: The patch was intended to be a microproject for Git for GSoC.
                It replaces the test -f and test -d commands in t/t9160
                to helper functions described in t/test-lib-functions.sh,
                which provide better diagnostic, and error messages.
   Status: Discontinued

2. [PATCH v3] apply: Change #define to enum and variable types from int to enum
   Description: The patch changed preprocessor constants defined in apply.c
                to enums, along with changing the types of variables to the
                respective enum types, to allow for easier debugging in case of
                errors (many debuggers support listing out the
constants, if they are enums).
   Status: WIP


-- Benefits to the Community --
===============================
Git is a great and big community, where people volunteer to maintain
one of the best and well-written codebase of all open-source projects.
I, too, aspire to be a permanent part of the community, and leave a
lasting effect on the developer community. Since I joined the mailing list,
I have loved the way people communicate and work together here.

So, I want to remain a part of the Git community irrespective of if I am able
to make it as a GSoC contributor or not, as I am sure that Git will help
me become a better programmer, and a thinker in general.

This project is important as in my viewpoint removing duplicate logic
and unifying it helps improve the modularity of the code base, and make it
sleeker, which is one of the best qualities of the Git code base.
The project would help newcomers understand code easily, and remove scope
for error-prone or failing code, which often results from duplicate logic.


-- Previous Work --
===================
GSoC candidate Hariom Verma and Outreachy student Olga Telezhnaya
did important work in the direction of unifying formatting
logic into ref-filter.c and removing duplicate implementations in
other commands. Most importantly, Hariom's work, where he tries to
create a transition table(pretty-lib.c) between pretty.c and
ref-filter.c is important and highly relevant to this project.
It provides a good starting point and gives an insight into the code
in pretty.c and ref-filter.c.

His blogs(mentioned above) provide a peek into the way of thinking
he adopts, as he implements the logic. This helps to understand the
way of thinking of another person, which again provides knowledge.

Olga's work is important as it describes how the student might face
difficulties, especially during bug fixing. This makes me confident
and less hesitant to ask on the mailing list and to the mentors.
Also, she describes how she generalises the logic of ref-filter.c
to allow for better integration to other commands, like git cat-file.
The blog posts also emphasise the need for comfort with a debugger like
GDB, but that is alright.

Hariom has clearly described, and given a link to his commits, how
he adds new formatting specifiers in pretty-formatting.


-- Proposed Work --
===================
As Christian Couder mentions on the mailing list, one of the most
important parts while removing duplicate logic in pretty.c is to ensure
that ref-filter.c has to support all the atoms that pretty-formats have.

This is in accordance with the work of Nsengiyumva Wilberforce,
who outside of Outreachy has sent patches to implement the `signature`
atom in ref-filter.c. This patch-series is therefore an important
reference for much of the work in this project.

Therefore the target/proposed work is to implement at least some of the
atoms supported by pretty-formats into ref-filter.c, and then clean up
the duplicate logic. This should provide a neat and clean way of working
when applied incrementally.


-- Timeline --
==============
April 5 - May 4 - Contribute small but meaningful patches regularly,
                  as this is the best way to get comfortable with
                  the source code. Also, this would give me an
                  opportunity to interact freely with the mentors and
                  reviewers on the mailing list.

May 4 - May 28 -  (Community Bonding) This is one of the most important
                  phases  for any GSoC contributor, as interaction with
                  mentors and reading the documentation is as important
                  as implementing the code for the idea. During this,
                  I intend to start looking for duplicate implementations
                  in the source code for pretty formatting, that must
                  be moved to ref-filter.c, along with unsupported atoms.

May 29 - July 13 - The target is to re-implement the duplicate logic,
                  but it is important to keep the track of time.
                  so, (after reading Hariom's and Olga's blogs) the best
                  approach is to divide the work into weeks with coding,
                  testing, and bug-fixing on specific week-days.
                  This would help maintain a good speed, while still
                  ensuring that the code is properly written.
                  Also, pretty formats might have some atoms that are not
                  supported by ref-filter, so begin by implementing some
                  of them, and cleaning up the related logic.

July 14 - August 21-
                  Final work period involves wrapping up the code, and
                  writing extra tests to make sure that no new errors
                  are introduced into the code base. Also, it must
                  be made sure that none of the old functionality
                  breaks, so all the original tests have to pass, too.

August 22 - August 28-
                  This is the last week of the journey of GSoC,
                  and the most important part is to ensure that the
                  changes that have been made to the code base
                  integrate well with the existing code. I hope
                  to write good enough code to allow for this phase
                  to finish seamlessly.


-- Blogging --
==============
Like many participants on this mailing list, and programmers in general
I also find the idea of blogging about new topics and recent findings
to be an extremely enriching process. However, till now, I was just
playing with the idea of starting a blog, but now I am confident enough
to go ahead and start one. I intend to host it on github, and post
new information and updates about my progress regularly(weekly seems best).
Many people I know have progressed incredibly through blogging and sharing,
and I take huge inspiration from that.


-- Closing --
=============
Becoming a contributor to Git has been extremely meaningful to me.
It is the first real software that I have actually been a part of,
and interacting with people in the Git community has been a great and
memorable time. I hope to keep contributing actively, and remain a part
of the community as long as I can, maybe forever!

Thanks a lot!
Vinayak
