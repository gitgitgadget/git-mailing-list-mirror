Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEFBC4332F
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB4B610A5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhJGVRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhJGVRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:17:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93BC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 14:15:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t2so23079176wrb.8
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ebqIh5AHU/zofXoI8jc57lQ9o+gXe7fI807819BxbPM=;
        b=iyMLAzksOlCfayw/yavdo8CzmBYzV2GmqjfQ5ATKHOumwgiaEh0hYDhMQAMeeWX7f5
         nE04I4Zx+UOD0FoM6KqYwImmwiMDBABPHLVtEY1tIQ6qkBjMbGo45We/gDXP/aNuyM+8
         qsgT28o+h9GnaQ6uZaN0jCpBE2yafmEP1/to1peQCS6F+nwO1oIE/C2bei15cTWQdXyS
         GXw/hO9yz9ynprh+2Dd33lw2j8fifIBspG0EEt+WIiv2pqP0VAKh4Q004JyBJQkRF3I6
         /BAu14Pm7x0gp21Ng72cVkdt9YQu2htlpxmQ237MLohL4Q/mnoBWf+gG4kC4WNN+uY4F
         3yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ebqIh5AHU/zofXoI8jc57lQ9o+gXe7fI807819BxbPM=;
        b=X4iMBlhWEXN2vtCNYmZi3s9R9sfnWpi88bgU4oqdWuVvfpv736R/5Df4yJpYYEmr5L
         E1zWxTJ7wZKu+Sh7dni6R1BowCNR0hybbqdMuniaX38+Jg4qjVWHVXTyV7BMYMdxyH33
         6HRJmHIa/1NJAPHP38JfNA9FHa72jt0txU+55bso0+BUARtYlPyni/f7MNMlceMYfbkh
         Aj06mzAhR6VnoIZU9Lm4zQb2exOPgp99bp8/CNcZ/2nJFSvagxwnnsqLEADYb9MdZbED
         tBKxiTzX0IBpWRs947iJa/HPktbF+Zn8YkznaIh0zw7V1h/1v2jUigozAc//6pjwikRG
         S4nQ==
X-Gm-Message-State: AOAM5307TiceNAJDJ/K5fG6L++rj3kueH7+4kvcba2ixSJaN6Quy2JVi
        OOcl3ujwqI3xhNIl19FxnTZSbGWo6v4=
X-Google-Smtp-Source: ABdhPJwgks+0YRqjObb26bhR4zi0GNyYLGp4YJnfP80SmFcjxMwnKf6sQzprel4SMDzFfEp8Rb+nKw==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr8302896wrs.121.1633641342043;
        Thu, 07 Oct 2021 14:15:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm464265wrp.27.2021.10.07.14.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:15:41 -0700 (PDT)
Message-Id: <1f6da84830b00b7d33ac8ae4c6a46a90606c901f.1633641339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 21:15:32 +0000
Subject: [PATCH v3 2/8] reset: preserve skip-worktree bit in mixed reset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Kevin Willford <kewillf@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <kewillf@microsoft.com>

Change `update_index_from_diff` to set `skip-worktree` when applicable for
new index entries. When `git reset --mixed <tree-ish>` is run, entries in
the index with differences between the pre-reset HEAD and reset <tree-ish>
are identified and handled with `update_index_from_diff`. For each file, a
new cache entry in inserted into the index, created from the <tree-ish> side
of the reset (without changing the working tree). However, the newly-created
entry must have `skip-worktree` explicitly set in either of the following
scenarios:

1. the file is in the current index and has `skip-worktree` set
2. the file is not in the current index but is outside of a defined sparse
   checkout definition

Not setting the `skip-worktree` bit leads to likely-undesirable results for
a user. It causes `skip-worktree` settings to disappear on the
"diff"-containing files (but *only* the diff-containing files), leading to
those files now showing modifications in `git status`. For example, when
running `git reset --mixed` in a sparse checkout, some file entries outside
of sparse checkout could show up as deleted, despite the user never deleting
anything (and not wanting them on-disk anyway).

Additionally, add a test to `t7102` to ensure `skip-worktree` is preserved
in a basic `git reset --mixed` scenario and update a failure-documenting
test from 19a0acc (t1092: test interesting sparse-checkout scenarios,
2021-01-23) with new expected behavior.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c                          | 14 ++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 19 +++++--------------
 t/t7102-reset.sh                         | 17 +++++++++++++++++
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index d3695ce43c4..e441b6601b9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -25,6 +25,7 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "dir.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -130,6 +131,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	int intent_to_add = *(int *)data;
 
 	for (i = 0; i < q->nr; i++) {
+		int pos;
 		struct diff_filespec *one = q->queue[i]->one;
 		int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
 		struct cache_entry *ce;
@@ -141,6 +143,18 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 
 		ce = make_cache_entry(&the_index, one->mode, &one->oid, one->path,
 				      0, 0);
+
+		/*
+		 * If the file 1) corresponds to an existing index entry with
+		 * skip-worktree set, or 2) does not exist in the index but is
+		 * outside the sparse checkout definition, add a skip-worktree bit
+		 * to the new index entry.
+		 */
+		pos = cache_name_pos(one->path, strlen(one->path));
+		if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
+		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
+			ce->ce_flags |= CE_SKIP_WORKTREE;
+
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"),
 			    one->path);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 886e78715fe..889079f55b8 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -459,26 +459,17 @@ test_expect_failure 'blame with pathspec outside sparse definition' '
 	test_all_match git blame deep/deeper2/deepest/a
 '
 
-# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-# in this scenario, but it shouldn't.
-test_expect_failure 'checkout and reset (mixed)' '
+test_expect_success 'checkout and reset (mixed)' '
 	init_repos &&
 
 	test_all_match git checkout -b reset-test update-deep &&
 	test_all_match git reset deepest &&
-	test_all_match git reset update-folder1 &&
-	test_all_match git reset update-folder2
-'
-
-# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-# in this scenario, but it shouldn't.
-test_expect_success 'checkout and reset (mixed) [sparse]' '
-	init_repos &&
 
-	test_sparse_match git checkout -b reset-test update-deep &&
-	test_sparse_match git reset deepest &&
+	# Because skip-worktree is preserved, resetting to update-folder1
+	# will show worktree changes for full-checkout that are not present
+	# in sparse-checkout or sparse-index.
 	test_sparse_match git reset update-folder1 &&
-	test_sparse_match git reset update-folder2
+	run_on_sparse test_path_is_missing folder1
 '
 
 test_expect_success 'merge, cherry-pick, and rebase' '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 601b2bf97f0..d05426062ec 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -472,6 +472,23 @@ test_expect_success '--mixed refreshes the index' '
 	test_cmp expect output
 '
 
+test_expect_success '--mixed preserves skip-worktree' '
+	echo 123 >>file2 &&
+	git add file2 &&
+	git update-index --skip-worktree file2 &&
+	git reset --mixed HEAD >output &&
+	test_must_be_empty output &&
+
+	cat >expect <<-\EOF &&
+	Unstaged changes after reset:
+	M	file2
+	EOF
+	git update-index --no-skip-worktree file2 &&
+	git add file2 &&
+	git reset --mixed HEAD >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'resetting specific path that is unmerged' '
 	git rm --cached file2 &&
 	F1=$(git rev-parse HEAD:file1) &&
-- 
gitgitgadget

