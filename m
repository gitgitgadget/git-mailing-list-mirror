Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A18C4332F
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbiBWOaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241598AbiBWOaK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:30:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F27B2D48
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i19so13850187wmq.5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tO7h+DeaJ3/BEvEuC8xoY3AML7GXYy7kJ7VgjcRzbPU=;
        b=b/j21jORB+CrTFZ91EUbuzpLkcgCnsOi1dGMhh5lw3k2b4tvfB8J5ceOFMhWyuwZ3f
         KllVfszSgcVWD/P/11QkmE8E9J4PrgHFo3OOG4uz9Se0T6U4GJEGjGZvU6isorH1bZiE
         e242VJ3rYOeaglWkri2XTDPlLOCpqVPPqVT0KWY4pIhVOY59D60OIt7W0TZWhdJmeC3r
         49enlhm6V8EjEW/rUqJZsCUCi4pYd1vXM5m1Hyxc2TH1mUqeBC/2W0ubrObAj8TSbi0g
         XsC2C+mzZlkdPHbb1cgZhSN6gH1JdfezVj80eujA8Dmrq78wyjqH8HNVv/fsZrMVhbX6
         bCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tO7h+DeaJ3/BEvEuC8xoY3AML7GXYy7kJ7VgjcRzbPU=;
        b=kMC0ZSJN82Xmos2Qp4DguU0dfQNG1/lFjBb3fxS2JSr//inVQESsuKH9NvjOhPZgJ8
         KrDVyDal7TNq1FStWsbIpCoyhW3zdAdsR4w/X2YPFFsHxrnN56Ba4ySy1BXApOihhRN9
         EQ7pNz57OrOABZYdqapHJ6UWtfwUbfG3URyyonkth5E5eGqYTyUlyH7xtW4vfqdAjn70
         qsCiHNSoQO+yqE1/FWwXxwv10KTMK07m9g1kqHOtE2deEty9Kq9xp8V1vWkqrEebL+83
         67UvaoZFgOCeKQgxYCs0eclVm5/4I06SZZAR0PXPxDB+YyXr7GXCnFUvaJOHWVvr3iNG
         kQNQ==
X-Gm-Message-State: AOAM531x1cfoDUpjBmYF9oTCNAaeppjzkgXmWe2MrU66UTBIySBX1lzu
        IuRxgvlNDuWrpEuzaTsNsKyMMsv1bd0=
X-Google-Smtp-Source: ABdhPJzweMsO5s2CDmrD5rS8pKxp04mlmpSUfSIGlv5WqW/pPj3kgLTqGD5fMLRu7qgkEj3Abqw1EQ==
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id z19-20020a1cf413000000b0037bd1de5762mr29572wma.108.1645626571073;
        Wed, 23 Feb 2022 06:29:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c26c800b0037bec3c03c9sm8686393wmv.2.2022.02.23.06.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:30 -0800 (PST)
Message-Id: <11ee7e107b44d3fb8b59927746aaa30c880f8563.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:19 +0000
Subject: [PATCH v3 11/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It is helpful to distinguish between a 'working tree' and a 'worktree'.
A worktree contains a working tree plus additional metadata. This
metadata includes per-worktree refs and worktree-specific config.

This is the last of multiple changes to git-worktree.txt, starting at
the LIST OUTPUT FORMAT section.

The EXAMPLES section has an instance of "working tree" that must stay as
it is, because it is not talking about a worktree, but an example of why
a user might want to create a worktree.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 1b4d1d69a16..453e1550226 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -383,11 +383,11 @@ $ git worktree list
 /path/to/other-linked-worktree  1234abc  (detached HEAD)
 ------------
 
-The command also shows annotations for each working tree, according to its state.
+The command also shows annotations for each worktree, according to its state.
 These annotations are:
 
- * `locked`, if the working tree is locked.
- * `prunable`, if the working tree can be pruned via `git worktree prune`.
+ * `locked`, if the worktree is locked.
+ * `prunable`, if the worktree can be pruned via `git worktree prune`.
 
 ------------
 $ git worktree list
@@ -405,14 +405,14 @@ $ git worktree list --verbose
 /path/to/linked-worktree              abcd1234 [master]
 /path/to/locked-worktree-no-reason    abcd5678 (detached HEAD) locked
 /path/to/locked-worktree-with-reason  1234abcd (brancha)
-	locked: working tree path is mounted on a portable device
+	locked: worktree path is mounted on a portable device
 /path/to/prunable-worktree            5678abc1 (detached HEAD)
 	prunable: gitdir file points to non-existent location
 ------------
 
 Note that the annotation is moved to the next line if the additional
 information is available, otherwise it stays on the same line as the
-working tree itself.
+worktree itself.
 
 Porcelain Format
 ~~~~~~~~~~~~~~~~
@@ -421,7 +421,7 @@ label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are present only
 if the value is true.  Some attributes (like `locked`) can be listed as a label
 only or with a value depending upon whether a reason is available.  The first
-attribute of a working tree is always `worktree`, an empty line indicates the
+attribute of a worktree is always `worktree`, an empty line indicates the
 end of the record.  For example:
 
 ------------
@@ -473,7 +473,7 @@ demands that you fix something immediately. You might typically use
 linkgit:git-stash[1] to store your changes away temporarily, however, your
 working tree is in such a state of disarray (with new, moved, and removed
 files, and other bits and pieces strewn around) that you don't want to risk
-disturbing any of it. Instead, you create a temporary linked working tree to
+disturbing any of it. Instead, you create a temporary linked worktree to
 make the emergency fix, remove it when done, and then resume your earlier
 refactoring session.
 
-- 
gitgitgadget
