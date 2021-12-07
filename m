Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78C0C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbhLGUX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbhLGUXu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEADAC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d24so253941wra.0
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NOpUpWkCDN0wHUNvbbXpaZLUD9Vl79ESalcPjT5KPyY=;
        b=LBu79x7mWt8aKm0RPu5xP8qjJ060DbWbVeqCOeX60WjRQtW7csFQcWUjjYDJHYMSFw
         eGkMvouNe3ZYN6P25W/NXiCo70Kh0+nPZ2f6JKRRD066R7KLG0eBdAc4dy71/t1KkT04
         o6NQ2Hmo4CHZLCiAaqIQcFGEUkFxFTwZB8Q/IqvzSvbjVF5AaQyAHfgH380UYtrzjoCM
         +XWzxA5paDEurhcPzPvQHUEl9101kHLsjfL9gdAeQIUS691OZJT/mn42kMlVVYd+hgUl
         ELWFmFYvNP4VSavcHWWGNycN2u10v82JACUlBsYFAQ/gmDXsQfn8RevZ6rG320k+dKU7
         1P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NOpUpWkCDN0wHUNvbbXpaZLUD9Vl79ESalcPjT5KPyY=;
        b=xMJzRV8/WxBzhLtUd4jeWPv/Bvg/MLAjGG2RPkOitPEySXtjdCt+j1stmKJpYCVekQ
         Cd4y6iWn9yJvVhBCgqxo6goMugzZQeszs5SFO1zKhWsukxtMOFicje7C55Gn5hXc26ep
         STxHyNkcwFIMRboTWsgzDz3sm86Q7ODxye5lfFRNjRYs1KL1Mz/jbTcUMWyZEpTzxx49
         IdBc2wq3RyP6pW+lUF+sNPzf1oBGufFwNOacTfV+aG0Jdh71hRtkfJdFfPg0wRz0uFMF
         xbExsrSoC23ojzSUf1WLvaDO90DROpfP1/D97IW5zV0BY2C0+CtGuflaqktaM4u1Gnc5
         CBBw==
X-Gm-Message-State: AOAM5323KkQhEdGhSeyDhWJ3e/8Xlbf4++cFfqP2TqtbCp+gTL/pHnNA
        ePlqOImBBOQvAJOqLAwE7u1geIX0dUg=
X-Google-Smtp-Source: ABdhPJxZ22auf6y1IKVvHBVdWfQpVdjPQPnXbevzh9P60eVNDcILmEzIwrL6aHPiwNBaFdrL7sE4aA==
X-Received: by 2002:a5d:4ed1:: with SMTP id s17mr55722763wrv.310.1638908418206;
        Tue, 07 Dec 2021 12:20:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m34sm3815921wms.25.2021.12.07.12.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:17 -0800 (PST)
Message-Id: <17b033caf4bc8c044795f5cb6580adaef15a9725.1638908410.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
        <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:08 +0000
Subject: [PATCH v2 08/10] git-sparse-checkout.txt: update to document
 init/set/reapply changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in the previous commit, using separate `init` and `set` steps
with sparse-checkout result in a number of issues.  The previous commits
made `set` able to handle the work of both commands, and enabled reapply
to tweak the {cone,sparse-index} settings.  Update the documentation to
reflect this, and mark `init` as deprecated.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 98 +++++++++++++++------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 42056ee9ff9..c7a25e282e7 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -30,28 +30,36 @@ COMMANDS
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
+quoted strings.  This may become the default in the future; --no-cone
+can be passed to request non-cone mode.
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
@@ -60,23 +68,6 @@ to rewrite your index to not be sparse. Older versions of Git will not
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
@@ -93,12 +84,35 @@ C-style quoted strings.
 	cases, it can make sense to run `git sparse-checkout reapply` later
 	after cleaning up affected paths (e.g. resolving conflicts, undoing
 	or committing changes, etc.).
++
+The `reapply` command can also take `--[no-]cone` and `--[no-]sparse-index`
+flags, with the same meaning as the flags from the `set` command, in order
+to change which sparsity mode you are using without needing to also respecify
+all sparsity paths.
 
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
@@ -117,10 +131,8 @@ directory, it updates the skip-worktree bits in the index based
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

