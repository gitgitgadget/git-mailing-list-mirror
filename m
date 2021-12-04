Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EF3C433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 20:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378130AbhLDUD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 15:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377986AbhLDUDx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 15:03:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9814C0613F8
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 12:00:26 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so13265122wru.13
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 12:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/OJ/K7NTT9vfeKWuTekGJR9k1DFvuzCN0qkYghAYGq8=;
        b=oGiHbE2WHC4SF4dY25EVBSTVB8LRewBDgqfJGRCwpTX5CIAzAgNN3k4MY8lvogc0zV
         hqp9Po6VxdQ8gwtlx8YWhMEKma86JLiD5KKTXgGujZvJ6aiCOlG2z/+/TiaxMxw8t+sx
         DVQjYdaQairYvEaZm2WslxlC0avkn2rhyvZUq9uxQ44jvhtSKmPvOKk4ffaNazTGjXYu
         Vn15zgdnwXcosKXY+QEyERxpkp7zDGHoyif77VmFt70GlZcPfWUACOE/PjWC3QJqZaj/
         9031B2sRAnBWRn56Vz6p8We27/4yckMpMqpb2NlEKR79a+q3AtM4uBU9zsGcyRS1hEhK
         wSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/OJ/K7NTT9vfeKWuTekGJR9k1DFvuzCN0qkYghAYGq8=;
        b=nz3dTqzDdVCuFPnkgN7QsGcteKpCSnxndNf3MDfx5eV64NCT/s0I8ldLW6h056Tx6G
         y7SO8T2PW9O3KD4R3Vlkk7q4YfaydbkhxINuXBY4nMbt7x7PlM1lehZ4uCeWe6mZNoW+
         68IiSHGignoutR3Avq6GJnQHrqRXY3Uatrple9u9osGC6KvChh1qV55LM+hEhy3apBsy
         Uumpq9vN6Zzaw5cpL0A8frNxcYPpkDu807bPmfp/5tjmv1SaSVqJBFVRw+NnXOkzzJhE
         HV0+UxlEDThEDhdYvd4yfkUO6mpTSuBZlJodbv0w7mywxfY30JYJSK6y/V5V2UbXmhDY
         m6LQ==
X-Gm-Message-State: AOAM532Pg1oJamqfjEOTK0+WEWce/Iv/c5i7NsHNT42kvwsGg0+kS45F
        yRyOX4pDBZZtI2/llgRny3fp/uBHnQ4=
X-Google-Smtp-Source: ABdhPJwafGqGmjPEg0xLfSJOJfi0/1CqK/YVoJzzfP0SsrFCbg7vXsM/d5Moyjd4qfD5IUagj1qmpw==
X-Received: by 2002:a5d:54c5:: with SMTP id x5mr29676537wrv.607.1638648025018;
        Sat, 04 Dec 2021 12:00:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm6405647wmq.6.2021.12.04.12.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:00:24 -0800 (PST)
Message-Id: <95d3df78b2ffe2e0d6234f326f8f7acbd2b67301.1638648020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 20:00:18 +0000
Subject: [PATCH 4/6] git-sparse-checkout.txt: update to document that set
 handles init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in the previous commit, using separate `init` and `set` steps
with sparse-checkout result in a number of issues.  The previous commit
made `set` able to handle the work of both commands.  Update the
documentation to reflect this, and mark `init` as deprecated.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 92 ++++++++++++++-------------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 42056ee9ff9..d22c925ecf8 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -30,28 +30,35 @@ COMMANDS
 'list'::
 	Describe the patterns in the sparse-checkout file.
 
-'init'::
-	Enable the `core.sparseCheckout` setting. If the
-	sparse-checkout file does not exist, then populate it with
-	patterns that match every file in the root directory and
-	no other directories, then will remove all directories tracked
-	by Git. Add patterns to the sparse-checkout file to
-	repopulate the working directory.
+'set'::
+	Enable the necessary config settings
+	(extensions.worktreeConfig, core.sparseCheckout,
+	core.sparseCheckoutCone) if they are not already enabled, and
+	write a set of patterns to the sparse-checkout file from the
+	list of arguments following the 'set' subcommand. Update the
+	working directory to match the new patterns.
 +
-To avoid interfering with other worktrees, it first enables the
-`extensions.worktreeConfig` setting and makes sure to set the
-`core.sparseCheckout` setting in the worktree-specific config file.
+When the `--stdin` option is provided, the patterns are read from
+standard in as a newline-delimited list instead of from the arguments.
 +
-When `--cone` is provided, the `core.sparseCheckoutCone` setting is
-also set, allowing for better performance with a limited set of
-patterns (see 'CONE PATTERN SET' below).
+When `--cone` is passed or `core.sparseCheckoutCone` is enabled, the
+input list is considered a list of directories instead of
+sparse-checkout patterns.  This allows for better performance with a
+limited set of patterns (see 'CONE PATTERN SET' below).  Note that the
+set command will write patterns to the sparse-checkout file to include
+all files contained in those directories (recursively) as well as
+files that are siblings of ancestor directories. The input format
+matches the output of `git ls-tree --name-only`.  This includes
+interpreting pathnames that begin with a double quote (") as C-style
+quoted strings.
 +
-Use the `--[no-]sparse-index` option to toggle the use of the sparse
-index format. This reduces the size of the index to be more closely
-aligned with your sparse-checkout definition. This can have significant
-performance advantages for commands such as `git status` or `git add`.
-This feature is still experimental. Some commands might be slower with
-a sparse index until they are properly integrated with the feature.
+Use the `--[no-]sparse-index` option to use a sparse index (the
+default is to not use it).  A sparse index reduces the size of the
+index to be more closely aligned with your sparse-checkout
+definition. This can have significant performance advantages for
+commands such as `git status` or `git add`.  This feature is still
+experimental. Some commands might be slower with a sparse index until
+they are properly integrated with the feature.
 +
 **WARNING:** Using a sparse index requires modifying the index in a way
 that is not completely understood by external tools. If you have trouble
@@ -60,23 +67,6 @@ to rewrite your index to not be sparse. Older versions of Git will not
 understand the sparse directory entries index extension and may fail to
 interact with your repository until it is disabled.
 
-'set'::
-	Write a set of patterns to the sparse-checkout file, as given as
-	a list of arguments following the 'set' subcommand. Update the
-	working directory to match the new patterns. Enable the
-	core.sparseCheckout config setting if it is not already enabled.
-+
-When the `--stdin` option is provided, the patterns are read from
-standard in as a newline-delimited list instead of from the arguments.
-+
-When `core.sparseCheckoutCone` is enabled, the input list is considered a
-list of directories instead of sparse-checkout patterns. The command writes
-patterns to the sparse-checkout file to include all files contained in those
-directories (recursively) as well as files that are siblings of ancestor
-directories. The input format matches the output of `git ls-tree --name-only`.
-This includes interpreting pathnames that begin with a double quote (") as
-C-style quoted strings.
-
 'add'::
 	Update the sparse-checkout file to include additional patterns.
 	By default, these patterns are read from the command-line arguments,
@@ -96,9 +86,27 @@ C-style quoted strings.
 
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
-	working directory to include all files. Leaves the sparse-checkout
-	file intact so a later 'git sparse-checkout init' command may
-	return the working directory to the same state.
+	working directory to include all files.
+
+'init'::
+	Deprecated command that behaves like `set` with no specified paths.
+	May be removed in the future.
++
+Historically, `set` did not used to handle all the necessary config
+settings, which meant that both `init` and `set` had to be called.
+Invoking both meant the `init` step would first remove nearly all
+tracked files (and in cone mode, ignored files too), then the `set`
+step would add many of the tracked files (but not ignored files) back.
+In addition to the lost files, the performance and UI of this
+combination was poor.
++
+Also, historically, `init` would not actually initialize the
+sparse-checkout file if it already existed.  This meant it was
+possible to return to a sparse-checkout without remembering which
+paths to pass to a subsequent 'set' or 'add' command.  However,
+`--cone` and `--sparse-index` options would not be remembered across
+the disable command, so the easy restore of calling a plain `init`
+decreased in utility.
 
 SPARSE CHECKOUT
 ---------------
@@ -117,10 +125,8 @@ directory, it updates the skip-worktree bits in the index based
 on this file. The files matching the patterns in the file will
 appear in the working directory, and the rest will not.
 
-To enable the sparse-checkout feature, run `git sparse-checkout init` to
-initialize a simple sparse-checkout file and enable the `core.sparseCheckout`
-config setting. Then, run `git sparse-checkout set` to modify the patterns in
-the sparse-checkout file.
+To enable the sparse-checkout feature, run `git sparse-checkout set` to
+set the patterns you want to use.
 
 To repopulate the working directory with all files, use the
 `git sparse-checkout disable` command.
-- 
gitgitgadget

