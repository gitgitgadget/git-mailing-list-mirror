Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B492AC433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244452AbiBTRzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:55:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBTRzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:55:02 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F10A4D9EA
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d27so23280119wrc.6
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ooY1QYXEPbGhIjXUarFnd1aghWl2RisU/4Dscpyy02U=;
        b=gbHFRKdcVoH3q4K2rDSOt9WBbAiIzoWVC0ZsdQG4BVoTbrQNWbdFbKC0JTOK317sbG
         EE6UQNfw7OKHxji6RXXXeOG6NP4X3B7ZlG15aKL5zZbv2XStOjcLHNfbTXFjbayzFMxN
         Bm8S6jEG4Zv0U6MGRZKlPBL2GzGIdNIhSrzKJpLIQ19eO1ePculP6b3tTVh31TZrlL1X
         3H/viH7gzde67XJXY7xj9tCCZehmHOCoAHPCwOAgIcZ9L+r+jfI7erDWrZcUZViPlyBo
         bnLYQpctk23TmbWEZeG8DNubysE9n3XdrNlrorFAm95VL3RBmXQkl0CS5mwDvmPmdL+R
         2A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ooY1QYXEPbGhIjXUarFnd1aghWl2RisU/4Dscpyy02U=;
        b=iWHuCTwcg0Opt8fF+tiJt0UfuHT343pBIUZAhX7J9GX5GM2InjlISBFLx6VvJfivNX
         fzYIv6wQH/1EU4zjY90fsqbY2ymdpeirCmG1Zw+8J04PiAPktaWV5FStDwc2Gq/Fv9B5
         8ex2kqZW6xOLqLw9AVU05I0SOHmh/FxkJnbmQQXxFSpCH7xF8uGDt9HlFnJ52HKUFQ5y
         3pD4czacJ0aW0PYJDtR7AJNkP5oidn1raC0dbtMKz/MncVRGBf1rk8Bv1oV6l/ZKQ0/n
         Iol+JUQtfRUquCV+5ZQh+mrpHU9tbkigLT4K3LgF5OoK3IthSJk4a4KHB4QmbKBUWyrq
         4nAA==
X-Gm-Message-State: AOAM533TdmhUmKVrOsBQZ0q+G/pESQ8K4Cfy9+w27tRZVTeocvuYB0St
        C5q0X8MhYg28iM9BSWH3HEv9oXhweOk=
X-Google-Smtp-Source: ABdhPJyZeOHD+qhmpIaYfhvcrjfslbkv1eZc91kmlWvjOM6Y5GlUdO4xd4ghifncRKLROZgKxx3nFA==
X-Received: by 2002:a5d:6d85:0:b0:1e2:f9f9:ab97 with SMTP id l5-20020a5d6d85000000b001e2f9f9ab97mr12815712wrs.469.1645379678639;
        Sun, 20 Feb 2022 09:54:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm5527133wmq.18.2022.02.20.09.54.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:38 -0800 (PST)
Message-Id: <4729a96af6ed47ea3bd3e6f6679e84013c07d5f9.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:26 +0000
Subject: [PATCH 10/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <[sunshine@sunshineco.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
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
index 8821e56c6ec..923b44d3fb2 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -318,29 +318,29 @@ linkgit:git-config[1] for more details.
 
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
@@ -348,8 +348,8 @@ thumb is do not make any assumption about whether a path belongs to
 `$GIT_DIR` or `$GIT_COMMON_DIR` when you need to directly access something
 inside `$GIT_DIR`. Use `git rev-parse --git-path` to get the final path.
 
-If you manually move a linked working tree, you need to update the `gitdir` file
-in the entry's directory. For example, if a linked working tree is moved
+If you manually move a linked worktree, you need to update the `gitdir` file
+in the entry's directory. For example, if a linked worktree is moved
 to `/newpath/test-next` and its `.git` file points to
 `/path/main/.git/worktrees/test-next`, then update
 `/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/test-next`
@@ -358,10 +358,10 @@ automatically.
 
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

