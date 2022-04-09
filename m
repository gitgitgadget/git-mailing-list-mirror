Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9137C433EF
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 18:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbiDISqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Apr 2022 14:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbiDISqS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Apr 2022 14:46:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82EA110D
        for <git@vger.kernel.org>; Sat,  9 Apr 2022 11:44:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t6so4325723plg.7
        for <git@vger.kernel.org>; Sat, 09 Apr 2022 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BpZgpM4geFkH+WHNGPDnLz/BOvgchhG8Jyud/l0CPqk=;
        b=SG23MkW1O7coiFbiTgHbJI46Q5F2ePCsw2EZ/RCJjnFYJnO7oNDNCWfdMkzAz18RBA
         iPwKUVM9knb/xzP83+/V6hudfpLWmx11YLRU0kSth83zs6Oi5sC5rGCEx2hxenJAnpWj
         1o7wJnRca70DQQD6eavOuB4cZJmikyvzNRxiqDDUV1eqPGAChYCBvkfxoNYPOBn+5v1N
         8BtdhiAOBGDQ+LBNoYIMs4vfJFeoL2SWSzL8CoAxCBF1D0lyBnZEMeqy1neY5k/JPnNF
         0p+1HPn6ObORbG4LaU1Lew98ys7GoAwe51/l+tNNwT4pG+dpWXxQCK0sd+cVBbbbok3w
         BhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpZgpM4geFkH+WHNGPDnLz/BOvgchhG8Jyud/l0CPqk=;
        b=b+WXFnSXBfMzrY1/X2QIpRGMEa98vUeu1uFFyw9JLLxgFWz5vJfiIeRxTykBiwBk05
         Wdjc0kNEV1oawwmkzTJqBpSZ7udNFL9DbzhB4Ghj9oTptmTkO3aWdC0+DvIee4g9Y1RU
         Pm8zl9V7QAlQIupSHpqCq+UHLg2Bf0/M0AFenNT8QCRs4dkUjETrngIlr9py+nq5RlmU
         ELb1Ox/CdRbEItjjz9pOl+ZttSJUq1P/iB3OFhlQkNkTeqEIEh7egdMhQcKVWXH5//9r
         pYo4WDj99uftcsrNru8M4/oyPdT3nZmJfdIOsyfZtGcHdjGpwojRFL+6qthDNE6OvVFh
         3x2g==
X-Gm-Message-State: AOAM532j7Qh73dQoQQvFsqFPFt1dedNZ3+XaOf9YaHCGVZIWNwyKZnP1
        PZ3Ko8spui9zyYKZu3Z57lz1vhc3rEqRkw==
X-Google-Smtp-Source: ABdhPJwqXSdZL6Laln18qPEpIxepWEzxnQGTnEqeWDQ+W3BCFAyT1lojGsLeOnkJrrgCkoYBU9MWng==
X-Received: by 2002:a17:90b:4ac9:b0:1c9:a345:6b9a with SMTP id mh9-20020a17090b4ac900b001c9a3456b9amr27982309pjb.118.1649529847900;
        Sat, 09 Apr 2022 11:44:07 -0700 (PDT)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.39])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001c77e79531bsm15898739pjb.50.2022.04.09.11.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 11:44:07 -0700 (PDT)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, kaartic.sivaraam@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH 1/1] [GSoC] Initial draft proposal
Date:   Sun, 10 Apr 2022 00:13:49 +0530
Message-Id: <20220409184350.1124-2-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409184350.1124-1-shivam828787@gmail.com>
References: <20220409184350.1124-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Initial draft proposal for reachability bitmap

Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
---
 proposal.txt | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 proposal.txt

diff --git a/proposal.txt b/proposal.txt
new file mode 100644
index 0000000000..0888ba8b38
--- /dev/null
+++ b/proposal.txt
@@ -0,0 +1,132 @@
+# GIT
+
+# Reachability bitmap performance improvement
+
+Name - Shubham Mishra
+
+Email - [shivam828787@gmail.com](mailto:shivam828787@gmail.com)
+
+IRC Nick - shubham828
+
+Location - Ghaziabad, Uttar Pradesh , India , UTC+5:30
+
+Proposal Title - Reachability bitmap performance improvement.
+
+* * *
+
+About Me
+
+I am Shubham, I am currently working as a Software Engineer at Microsoft India. I am a 2021 graduate from Delhi University. I am passionate about core engineering and backend technologies. I love to see beyond all abstractions and how things really work under the hood. So, I can work from their roots and make things better. I feel engineering is all about the tradeoffs that we make and I am trying to learn them to become a better Engineer.
+
+I am passionate about open source technologies and have quite a good amount of contribution to them, I participated in GSoC 2020 with [KDE](https://summerofcode.withgoogle.com/archive/2020/projects/6473982317953024), did Internship with Linux Foundation - [HDV](https://wiki.lfnetworking.org/display/LN/HDV), Season of KDE - [report](https://community.kde.org/SoK/2020/StatusReport/Shubham), and I am doing voluntary contributions to VSperf, BoostC++ and some other open-source projects.
+
+Motivation for Proposal
+
+I have been using Git for the last 3 years now, and I always find myself curious about how it manages a lot of files seamlessly to make developer collaboration so smooth.
+
+I was listening to one of Derrick Stolee's podcasts, where I felt git contributors really do cool stuff, So I also wanted to be one. By becoming a regular contributor of git, I can give my contribution back to it as well as I can show off it to my friends :) . I love to study advanced data structures and Algorithms that's the reason I chose a bitmap related project. I will get a chance to learn different compression algorithms and analyze their performance.
+
+Project Abstract
+
+During repository clones, the Git server needs to find out all the objects which clients do not have and need to be sent to the client.
+
+To make the process faster, Git uses bitmaps to quickly find all the related objects from an object. Bitmap approach is a performance optimization over the legacy "Counting Objects" - the process in which the git server used to iterate through the graph from branch tips to the beginning of history to list down all objects that need to be sent.
+
+bitmap made reachability faster but uncompressed bitmaps can cost a lot of extra storage. Git uses a C ported version of [EWAHBoolArray](https://github.com/lemire/EWAHBoolArray) to compress bitmaps which get stored in the ".bitmap" file with the same prefix "sha" as ".pack" and ".idx".
+
+The aim of the project is to design a performance test suite as well as do the necessary changes to improve bitmap performance by trying out a new compression scheme that can make read operations along with other common operations like intersect, union and negate faster.
+
+Me & Git:
+
+## Microproject:
+
+I worked on the microproject "Avoid pipes in git related commands in test scripts", the patches for it has been merged to master now
+
+*   [https://public-inbox.org/git/20220224054720.23996-3-shivam828787@gmail.com](https://public-inbox.org/git/20220224054720.23996-3-shivam828787@gmail.com/)
+*   [https://public-inbox.org/git/20220224054720.23996-3-shivam828787@gmail.co/](https://public-inbox.org/git/20220224054720.23996-3-shivam828787@gmail.com/)
+    
+
+I run a pattern matching grep to find all git commands on LHS of pipes and fix all of them from file t001-t050.
+
+As an outcome of this process, I got to learn the code review process at git work, which is quite cool and different from other organization's I contributed to before.
+
+I learned about building source code, running tests, using email to send patches, communicating with reviewers and sending the next patch version process.
+
+## Current understanding:
+
+*   I have gone through git internals, and I well understood about the pack files as well as the difference between git objects (tree, blob, commit).
+*   I have gone through some documentations - "MyFirstObjectWalk", etc. it was a good hands-on to get some glimpse of general object related tasks.
+*   I understand how bitmap works in general, I have got some idea how EWAH compression works and also I have gone through the research paper on roaring run.
+*   I played with commands of pack-object - "git pack-objects dir --progress < obj_lists.txt" and read the code of related files "pack-bitmap.c" and parts of "pack-object.c"
+*   I checked the general documentation of [Croaring](https://github.com/RoaringBitmap/CRoaring) as one of the potential alternatives to EWAH.
+    
+
+Execution plan:
+
+I am interested in keeping my primary focus on "building a performance suite and improving bitmaps performance by finding a better compression scheme" project and if I finish this early or even after the GSoC timeline, I will be happy to contribute to other tasks too.
+
+From the idea page, I got some sense that decompressing a bitmap for reading bits or doing operations like intersection, negation and union makes them slow and can be improved.
+
+Roaring + Run was the suggested alternative to explore. It divides the data into chunks of 2^16, which allows you to check for the presence of any one value faster. As a result, Roaring can compute many operations much faster than run-length-encoded formats like WAH, EWAH, Concise. After getting a high level understanding of algorithms, I explored a bit of the [Croaring](https://github.com/RoaringBitmap/CRoaring) library which is a C implementation of roaring bitmap. It provides a lot of useful functions to do all general operations (find cardinality, and, or, copy, equals). Which I think we will be using in the "pack-bitmap.c" and "pack-bitmap-write.c" files as a replacement of ewah/bitmap functions. I do not have enough knowledge yet to figure out how compatible croaring is with the current .bitmap format. We might need to make changes in the current .bitmap format accordingly.
+
+Steps I will be following to accomplish the task-
+
+1\. Get a better understanding of bitmap related functionalities/ codebase, EWAH, roaring+run techniques.
+
+2\. try to build out an initial draft version implementing only minimal required core changes, I will try to get a review on it from a wider audience (including mentors).
+
+3\. make changes according to the comment and repeat the review process.
+
+4\. build a performance suite for the changes I have done in the above steps.
+
+5\. If performance improves, I will be writing the rest of the required code changes to use the Croaring including perf tests for them.
+
+6\. Until this time, I will also get a good understanding of the bitmap related projects, so if we will be able to make good progress on roaring+run. I can start picking other subprojects too like 'table of contents' for the .bitmap file where past work - [https://lore.kernel.org/git/YNuiM8TR5evSeNsN@nand.local/](https://lore.kernel.org/git/YNuiM8TR5evSeNsN@nand.local/) can act as a good reference to me or/and 'append-only bitmap generation' subproject.
+
+I feel for any mentoring program, Communication is the key to success. I will be utilizing the community bonding periods to figure out a process for being in regular touch with mentors, which is essential to make sure I am going in the right direction.
+
+Timeline
+
+I am available to dedicate around 30-35 hours every week to the project.
+
+Community bonding periods -
+
+1.  Exploring code base mostly related to bitmaps
+2.  research on other bitmap compression techniques
+3.  reading technical documents
+4.  interacting with mentors to understand them and project in more detail.
+    
+
+12 June - 25 July:
+
+1.  Writing the first version with the new compression technique
+2.  Get the initial version reviewed by reviewers and make changes accordingly.
+3.  write performance test for these changes
+    
+
+25 July - 4 sept
+
+1.  if tests result well, extending the above functionality to completely move to a new technique.
+2.  writing more performance tests.
+3.  start picking up other tasks if time left
+    
+
+Sept 5 - Sept 12
+
+1.  I will make sure to get all changes merged before this week including tests
+2.  if not, make a decision with mentior on extending the project
+    
+
+Other proposals
+
+No, This is the only proposal I am making for GSoC 2022.
+
+Blog
+
+I want to make blog writing a habit so I planned to publish biweekly blogs at [https://shubham828.github.io/](https://shubham828.github.io/) during this GSoC and after that. This is something I started during my last GSoC too but unfortunately couldn't continue post-gsoc. This GSoC gives me another opportunity to become a regular blogger.
+
+After GSoC
+
+I would love to be a regular contributor of Git. After GSoC, I can pick any left out subprojects of bitmap reachability and I would also be happy to extend my knowledge beyond bitmaps to learn and contribute to other parts of git too.
+
+EndFragment
\ No newline at end of file
-- 
2.25.1

