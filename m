Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306B7C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiBVASs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiBVASf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5825593
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:11 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so465542wmp.5
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QnZ7I/VV3xp2APOmoWWVY4bR4SG68pRwWpRnTlA4TxQ=;
        b=eKu0yRIniy1UWiyviotjmsQm4OibO6ggD83FHJV1FHr8H6RbyW0tBs1TFHO9lX2Gs0
         144EyNkEeaWbLxd5QIlUGbb55l95ZS0AVqgY1qDDUpNbpRiMpQlTo9QRqPpTPtxp2sif
         3j4GqM2CDdDMDBXa1nruo4UHBEoAyVv9MkafGut+0IxJkMO3OJAhJyss94en2YC5aoqB
         1mpU+AetfJe4Oi5uGp+Fu1zVnJneWxxco1kx+R/2kTxBJp+h1zgQWq/0VumLeieAHm2V
         awcZp15QAi1DG3tBKntdN4F7judVZVHX00Be+Tl9z2z/jEg00QicQS31bprAMRJAbjhQ
         GFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QnZ7I/VV3xp2APOmoWWVY4bR4SG68pRwWpRnTlA4TxQ=;
        b=xhOKAGniCF0/x0v+xx2Scagxt/maVXbvo2LFKtWY70E9pV4/Tyy6Q/eXqRxkohhGGn
         IXZJeD/aDqXBEjudv+85Yt8tw33cMCjskY+dGtKDrgFk9TM822sVpEaFuSQJYNwkXAPK
         VtJn743W7/l1Yg6ETI+UlgFv8VfmgJyFAbBfOenr+7ew5oGFBiVBaGSqSvdnMO5zacmt
         ylR5ZZbtYxq2PLtzJ9tvcv0HQsrOKQqanXnROO2+Wk4rifTB7Y+d4ExoomXN31u0P1C5
         zrlvn26XuMFMcEJgHktCA4oSqZW4Efp6tJICb1JYCTtxed9SVUM66KCMLAhfJMpjC71N
         x2+Q==
X-Gm-Message-State: AOAM53345/K+RehA3shUKR4l+3akc7lH7TTsRHBEIx0UoLxuFMoYxSHx
        DWOb6ClgtAjRy+QmhtqoRfoa/0LdtUQ=
X-Google-Smtp-Source: ABdhPJxaNRtDJKN/DfJSmTCyHJEDdXI4DVAQeMqos4ERQyYSOFfEeJFVFCk/sbui/y17SS2oXJOuyg==
X-Received: by 2002:a05:600c:4fc4:b0:37c:9116:ef3d with SMTP id o4-20020a05600c4fc400b0037c9116ef3dmr1069223wmq.167.1645489089711;
        Mon, 21 Feb 2022 16:18:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10sm28063536wri.91.2022.02.21.16.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:09 -0800 (PST)
Message-Id: <75f0e4ff5c2538506011e50ca2e7076b2fecd081.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:17:59 +0000
Subject: [PATCH v2 10/11] worktree: use 'worktree' over 'working tree'
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
index d890221d31f..cca45f19a37 100644
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

