Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A23C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiBWOaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbiBWOaK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:30:10 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB3B2D43
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s1so13525921wrg.10
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3mzYoBMb/LqABNWhOwFeFBJRtjvu3vUV5yKXSuTkHtg=;
        b=lfSsNhM3l2ewttQtOcptVGRW3v2JvEW26YvOb+TOUXu2PkNaSnEcF3j2WtBBm1MSoA
         +NoLsMmWyPNp01muT6dQ2nS5637eg3VeF43DJ8ZlKSiwGV/inFCk0agNF/uEjYydJH2t
         FDlUQBP2bUiIZc9OaLyVwjT65tyxAqJS4D5qtRMstS0C6A7hRTCU4dtZ5mTjpqEck+2e
         3HqNDbXVZYoWF2Zw10x3K1W/GGwG1QfYqojckthMcSGoQEl/tKD+Nrwl/V6LW+r0/EyL
         u/sIRdAydtehUM/RL4sWHgURGRBVULc3JDiItQUPs5lmzGL2FlBhenpegUcmMprS3Iyk
         e8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3mzYoBMb/LqABNWhOwFeFBJRtjvu3vUV5yKXSuTkHtg=;
        b=MAhKJi/ytXh9duCuQPltJ/cCjDtz8Z2E/iMcWsTvEhT6xGi7FJ9X3u06ox6TQjA3+F
         EsKChZAYkIcZYQ9Uxo8nmqTqOIR/fapW8mZm7Lh2GX1o9HNh1HfM0w4gsx09Dmhi6Sal
         d6KALKiAe+BY40k+g3MuYs8de/gvhupg6/9zUljl1t8/arXoI/044aegDHKEKlCx+FLR
         k2DQl+BqJjaBcZ6hLGxDhd4OBGVTV4SLSKvgquczdypRAWJ0qx5IWkTX5DboKWxluUSK
         Msdr96MB6fg9xF+4DbJ45eXh9JReKzwQSaDNE19zWr48LSPM+JycCDhwNZpWvI4Rz02P
         uyqg==
X-Gm-Message-State: AOAM530wQqkXRfRo+Cd1CTKL4f4e/LTP11VMcGw1qcETUGiyyo4E9QJZ
        yqvoYnhVXRmp1erWnM/yiRA9eafQCSg=
X-Google-Smtp-Source: ABdhPJxcViOLBcBl3zdUGJi3MvlJW2pC9RH9yCw0dDZgVd0BmxXiS2UAG6GgSxLuk1iBwspUcRmh4A==
X-Received: by 2002:adf:fe4a:0:b0:1e3:31af:6f02 with SMTP id m10-20020adffe4a000000b001e331af6f02mr24036974wrs.10.1645626570200;
        Wed, 23 Feb 2022 06:29:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm2759484wmq.29.2022.02.23.06.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:29 -0800 (PST)
Message-Id: <1e235677ef0032753c8bde0bb9f31ef7dc398e81.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:18 +0000
Subject: [PATCH v3 10/11] worktree: use 'worktree' over 'working tree'
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

This is the sixth of multiple changes to git-worktree.txt, restricted to
the DETAILS section.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index a1ee5c43f1d..1b4d1d69a16 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -319,29 +319,29 @@ linkgit:git-config[1] for more details.
 
 DETAILS
 -------
-Each linked working tree has a private sub-directory in the repository's
+Each linked worktree has a private sub-directory in the repository's
 `$GIT_DIR/worktrees` directory.  The private sub-directory's name is usually
-the base name of the linked working tree's path, possibly appended with a
+the base name of the linked worktree's path, possibly appended with a
 number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
 command `git worktree add /path/other/test-next next` creates the linked
-working tree in `/path/other/test-next` and also creates a
+worktree in `/path/other/test-next` and also creates a
 `$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
 if `test-next` is already taken).
 
-Within a linked working tree, `$GIT_DIR` is set to point to this private
+Within a linked worktree, `$GIT_DIR` is set to point to this private
 directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
-`$GIT_COMMON_DIR` is set to point back to the main working tree's `$GIT_DIR`
+`$GIT_COMMON_DIR` is set to point back to the main worktree's `$GIT_DIR`
 (e.g. `/path/main/.git`). These settings are made in a `.git` file located at
-the top directory of the linked working tree.
+the top directory of the linked worktree.
 
 Path resolution via `git rev-parse --git-path` uses either
 `$GIT_DIR` or `$GIT_COMMON_DIR` depending on the path. For example, in the
-linked working tree `git rev-parse --git-path HEAD` returns
+linked worktree `git rev-parse --git-path HEAD` returns
 `/path/main/.git/worktrees/test-next/HEAD` (not
 `/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
 rev-parse --git-path refs/heads/master` uses
 `$GIT_COMMON_DIR` and returns `/path/main/.git/refs/heads/master`,
-since refs are shared across all working trees, except `refs/bisect` and
+since refs are shared across all worktrees, except `refs/bisect` and
 `refs/worktree`.
 
 See linkgit:gitrepository-layout[5] for more information. The rule of
@@ -349,8 +349,8 @@ thumb is do not make any assumption about whether a path belongs to
 `$GIT_DIR` or `$GIT_COMMON_DIR` when you need to directly access something
 inside `$GIT_DIR`. Use `git rev-parse --git-path` to get the final path.
 
-If you manually move a linked working tree, you need to update the `gitdir` file
-in the entry's directory. For example, if a linked working tree is moved
+If you manually move a linked worktree, you need to update the `gitdir` file
+in the entry's directory. For example, if a linked worktree is moved
 to `/newpath/test-next` and its `.git` file points to
 `/path/main/.git/worktrees/test-next`, then update
 `/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/test-next`
@@ -359,10 +359,10 @@ automatically.
 
 To prevent a `$GIT_DIR/worktrees` entry from being pruned (which
 can be useful in some situations, such as when the
-entry's working tree is stored on a portable device), use the
+entry's worktree is stored on a portable device), use the
 `git worktree lock` command, which adds a file named
 `locked` to the entry's directory. The file contains the reason in
-plain text. For example, if a linked working tree's `.git` file points
+plain text. For example, if a linked worktree's `.git` file points
 to `/path/main/.git/worktrees/test-next` then a file named
 `/path/main/.git/worktrees/test-next/locked` will prevent the
 `test-next` entry from being pruned.  See
-- 
gitgitgadget

