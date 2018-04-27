Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C131F424
	for <e@80x24.org>; Fri, 27 Apr 2018 19:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757689AbeD0TYO (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 15:24:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39532 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbeD0TYO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 15:24:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id b21so4717021wme.4
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 12:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pptuh+2ZE3WNc4UDPqChInOgJiydyz9NvD6qYZ96j2Y=;
        b=NgqEZlTVvEfELeANrvjmsnfLZCyEMmAjN3C5bgDlo2Qsb9NZh2Gd94k++rmrV120bW
         ORW4pm0kJVArItdZFemIrlBgL/n/XPUQozVisVyiM4Xgf+71f4IiByqzZfD9URnIt1X/
         fYlIMmKA+FUWCSTH9cci4us0BYOapV5o8oAVphhbAPhwRnC4UHqQ6r/xOLramnL3IX4y
         EQ6kzKNJzRJTEW4ojpB+DBlREK5scxh1uxLZkpqSs4Yh2wdqct5oDIsQercrMRlb9S+m
         BA89AGsOgJfxsMquEw7Kp20eiPRH54tIkLB7qfe6c0Qv7rVjTXfG9il08wnw41W6vwif
         lgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pptuh+2ZE3WNc4UDPqChInOgJiydyz9NvD6qYZ96j2Y=;
        b=LirY9QImkha9p2ACqT55fzAVK/ARycTD+k86PXsFp12/N8uwZmKI85i25rK/gHz5Bc
         S5twxUKa7Fz9wNbVIQGBR/29iC4AZZxaZcwCywZ54q3wjhF/KQMVp5VG3ZgaDOQPt2V7
         FQRHeb4TqOEb1FuDuRr2pNxZh24PMwVDyte2FKqNfDpLDYpW/1eY2biKL123GeZLqP8j
         nGXgMp2/nDC5znrsqMQhTay5MvORgv6Uulco7WG+VeGee0QMBbp6MQiCQx9C+gWi6j9P
         GfdIAec4eYbxfXJFvGzYXs8NRO22b5CRHdiyVh6jbBlDmh32ileU9WPJ5bHw0y2w11Zx
         ornw==
X-Gm-Message-State: ALQs6tAZybaCfpguPC0A7HPXugHa7aW7utc52PpaZowyHRDlUh2y1OVF
        TUACW6RneL2EM+N2nqI6fkBaHiDd
X-Google-Smtp-Source: AB8JxZqL+e+6VM9kulTlwsz+WJkev3ElnzM/wAoJvL8ouFLkNgmfL1Ex9GqcwXIrZMObUw+Tj70CRg==
X-Received: by 10.28.13.201 with SMTP id 192mr2295848wmn.117.1524857052561;
        Fri, 27 Apr 2018 12:24:12 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:b0f7:2e70:f673:62a9])
        by smtp.gmail.com with ESMTPSA id k89sm1929442wmc.15.2018.04.27.12.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 12:24:11 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 7/6] doc: normalize [--options] to [options] in git-diff
Date:   Fri, 27 Apr 2018 21:23:50 +0200
Message-Id: <20180427192350.9910-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SYNOPSIS and other manuals use [options] but DESCRIPTION
used [--options].

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-diff.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 6593b58299..7c2c442700 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -21,7 +21,7 @@ Show changes between the working tree and the index or a tree, changes
 between the index and a tree, changes between two trees, changes between
 two blob objects, or changes between two files on disk.
 
-'git diff' [--options] [--] [<path>...]::
+'git diff' [options] [--] [<path>...]::
 
 	This form is to view the changes you made relative to
 	the index (staging area for the next commit).  In other
@@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-'git diff' [--options] --no-index [--] <path> <path>::
+'git diff' [options] --no-index [--] <path> <path>::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
@@ -38,7 +38,7 @@ two blob objects, or changes between two files on disk.
 	or when running the command outside a working tree
 	controlled by Git.
 
-'git diff' [--options] --cached [<commit>] [--] [<path>...]::
+'git diff' [options] --cached [<commit>] [--] [<path>...]::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
@@ -48,7 +48,7 @@ two blob objects, or changes between two files on disk.
 	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.
 
-'git diff' [--options] <commit> [--] [<path>...]::
+'git diff' [options] <commit> [--] [<path>...]::
 
 	This form is to view the changes you have in your
 	working tree relative to the named <commit>.  You can
@@ -56,18 +56,18 @@ two blob objects, or changes between two files on disk.
 	branch name to compare with the tip of a different
 	branch.
 
-'git diff' [--options] <commit> <commit> [--] [<path>...]::
+'git diff' [options] <commit> <commit> [--] [<path>...]::
 
 	This is to view the changes between two arbitrary
 	<commit>.
 
-'git diff' [--options] <commit>..<commit> [--] [<path>...]::
+'git diff' [options] <commit>..<commit> [--] [<path>...]::
 
 	This is synonymous to the previous form.  If <commit> on
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
 
-'git diff' [--options] <commit>\...<commit> [--] [<path>...]::
+'git diff' [options] <commit>\...<commit> [--] [<path>...]::
 
 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
-- 
2.16.2

