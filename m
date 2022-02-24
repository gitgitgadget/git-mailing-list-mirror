Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C900BC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiBXWfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiBXWfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:35:14 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AEC1EC274
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p4so677984wmg.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZJNTdDJqVb503/vN/Ny1Tp4YD/HfLqHE/0fnL1DoQs4=;
        b=ewmFmC5X0T/dVQTwEYFGA+L3uVb2FVgxxeuPzFk40Ny0P5vQkD+mUp5uUGlNNMi8T/
         ibKXETTYNpOcyySX8bmVIuME6dT7sGI+qHSF8CSlqWuUgqKpxYFHFpSRys+NIxbdG7fR
         bSUs0OmWkuwzMWJE8rc53PAX3hpvqa/1RMvUjmzmHlYokg94xPVsFWGZohEd8Nok3rwr
         izF28z0ul/HymcjmzAZgGYZB41SNc/c+g0ANcBqZAn0G87pCxJMXnUPGjh9Lvnk3gblM
         6hRCbcT7OX+BRGsc3RY4WO8J6NbvJdilqyKigta3/JPjM5M8+mMjRSOpwm4SjHod2qiP
         NAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZJNTdDJqVb503/vN/Ny1Tp4YD/HfLqHE/0fnL1DoQs4=;
        b=1bqaJpvzUi5k0IHtbI0ihXrI7TALKZ5uDr6mR6MPnRj0WnOy68YtDYbEwHsywXjMNg
         6/NVQ7ydyZSFfgxg0l7O6GzeX3qPoZrsOTdqwKkYr2DtniDR78kRIowpVdBs8mkpsISJ
         u4VvXNqrIHBB+d42QSq6OWLMIvDzUNrcEt1P17MSc+NGPh3nLtdWABA7EmYA9/6TUUlu
         KkrPxyJpZt5KkrUNmbJjmPhm75xSGMW9em2eEwaGafLsZO7TgkgLtPUxV+APWr8Fu5QC
         7PWGftHRWMDWOOpQYDs9sPehqGeeNzUFs4XSXoZXeZES7wKCWH0uUuSd5Uu1OkLM58fo
         LpGA==
X-Gm-Message-State: AOAM530KSXaQozQAaJb7MEQI5W3mhOUPhyGdEVrZvCFvLwi8JxkVFX4y
        vfFmfIF+vGbERHAUDUc98R8l35/r0Mo=
X-Google-Smtp-Source: ABdhPJxR1Y/QIiuUP8xR5S5gUmgUZi9KsDolvjxd2LjY5ACMDz6bYqMwWxUH7IRHVY8k186Y8b+6MA==
X-Received: by 2002:a05:600c:3d06:b0:37b:a5ea:a61b with SMTP id bh6-20020a05600c3d0600b0037ba5eaa61bmr207579wmb.32.1645742078012;
        Thu, 24 Feb 2022 14:34:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17-20020adffcd1000000b001edbf438d83sm568166wrs.32.2022.02.24.14.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:34:37 -0800 (PST)
Message-Id: <cb7e0cf419c02dfe9689ed2f2f448fbb098c7d6b.1645742073.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
        <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:34:30 +0000
Subject: [PATCH v2 4/7] read-tree: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable use of sparse index in 'git read-tree'. The integration in this patch
is limited only to usage of 'read-tree' that does not need additional
functional changes for the sparse index to behave as expected (i.e., produce
the same user-facing results as a non-sparse index sparse-checkout). To
ensure no unexpected behavior occurs, the index is explicitly expanded when:

* '--no-sparse-checkout' is specified (because it disables sparse-checkout)
* '--prefix' is specified (if the prefix is inside a sparse directory, the
  prefixed tree cannot be properly traversed)
* two or more <tree-ish> arguments are specified ('twoway_merge' and
  'threeway_merge' do not yet support merging sparse directories)

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                      | 21 +++++++++++++++++++--
 t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 2109c4c9e5c..c2fdbc2657f 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -160,8 +160,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	argc = parse_options(argc, argv, cmd_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
-
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
@@ -169,6 +167,11 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.reset)
 		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+
 	/*
 	 * NEEDSWORK
 	 *
@@ -210,6 +213,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
+	/* TODO: audit sparse index behavior in unpack_trees */
+	if (opts.skip_sparse_checkout || opts.prefix)
+		ensure_full_index(&the_index);
+
 	if (opts.merge) {
 		switch (stage - 1) {
 		case 0:
@@ -219,11 +226,21 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			opts.fn = opts.prefix ? bind_merge : oneway_merge;
 			break;
 		case 2:
+			/*
+			 * TODO: update twoway_merge to handle edit/edit conflicts in
+			 * sparse directories.
+			 */
+			ensure_full_index(&the_index);
 			opts.fn = twoway_merge;
 			opts.initial_checkout = is_cache_unborn();
 			break;
 		case 3:
 		default:
+			/*
+			 * TODO: update threeway_merge to handle edit/edit conflicts in
+			 * sparse directories.
+			 */
+			ensure_full_index(&the_index);
 			opts.fn = threeway_merge;
 			break;
 		}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 9d58da4e925..ae44451a0a9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1407,6 +1407,17 @@ test_expect_success 'sparse index is not expanded: fetch/pull' '
 	ensure_not_expanded pull full base
 '
 
+test_expect_success 'sparse index is not expanded: read-tree' '
+	init_repos &&
+
+	ensure_not_expanded checkout -b test-branch update-folder1 &&
+	for MERGE_TREES in "update-folder2"
+	do
+		ensure_not_expanded read-tree -mu $MERGE_TREES &&
+		ensure_not_expanded reset --hard HEAD || return 1
+	done
+'
+
 test_expect_success 'ls-files' '
 	init_repos &&
 
-- 
gitgitgadget

