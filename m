Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B945C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1BE61139
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhJGVRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhJGVRg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:17:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63685C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 14:15:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s15so23167233wrv.11
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L6YTTKKAyBaHzDp/SMwNsC0hkh/ZEJHZLofG/n477SI=;
        b=Y/UQ/DnYIG8y4rCvb5uYi+rWPE6iyv1DPyjdBCN5gYThXYNRCW+LA5951VkjhvFoK/
         pLYo03mlE53gHq8oIQ/c3gVe8WcEXZp5U3NazAmU/y2qTAJqrEJzgV7Kwoi8mLUSMSFz
         yUc0EAvt+KKFkQVhHWwwmdAXu0Nyf4rZmyE8G4USxBu1pvLQtlcQ5m8R4RWTi34RqJIx
         WTmthY6/mmCAa7Uee5oV9ag9FQiGv2QVqBGv2txaSbpzPIAajW3hy5CeQiwgXuotzWNC
         veHi8U2jTtSqDrKrVNs3ZaO5TqayD1rXQ3gAjLHFvGfRWqPj/DS4WfLD8NvovmOQrul9
         1cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L6YTTKKAyBaHzDp/SMwNsC0hkh/ZEJHZLofG/n477SI=;
        b=D1E24P5TK7z5kJlqV9GJVfqQo08hUv1o6dyFf+t83/LOYirIrRdqQJo47Xj9Uy5vU/
         UsAOx+8swve7KlwJZZUBLXPgjpt8brWkYSvWFPHP2vqJeIZRcI+3YhQtUBXYtj9D+liR
         o7AMtRxyXMINN+sIpNdrKfeDZgAxgcK0/SjCV73GlS/Mr8skJMYveVkk439giWgsJya+
         lJsZwkJN4uEVBdMUgSnZl5QO/OXomY0fxjwG76IXklEyiAIdOK1f2uEhKcmgILQcnzI6
         tQ6Khme/3kIzVD8NpC4HUoh1U4vd05vvyCmu7BpesfZGPH9P9IcVAYw5eJ8s4aTFrroN
         Zy3w==
X-Gm-Message-State: AOAM5317swCiiNeJF0wR73NVCBIQ9edSTyWaLyZa63Ke5LuhKk0AiNok
        E2sMY4IQvYQO2W+MSCJQ0kum3qhkSgc=
X-Google-Smtp-Source: ABdhPJy+jmhwBK0BROfOvSyU7oHDapk47clzxR37LgMGq+MYcyoDAt5BQWRkRfygR5wgvn8xxhA/1A==
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr7114436wmq.189.1633641340631;
        Thu, 07 Oct 2021 14:15:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g144sm10720974wmg.5.2021.10.07.14.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:15:40 -0700 (PDT)
Message-Id: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 21:15:30 +0000
Subject: [PATCH v3 0/8] Sparse Index: integrate with reset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series integrates the sparse index with git reset and provides
miscellaneous fixes and improvements to the command in sparse checkouts.
This includes:

 1. tests added to t1092 and p2000 to establish the baseline functionality
    of the command
 2. repository settings to enable the sparse index with ensure_full_index
    guarding any code paths that break tests without other compatibility
    updates.
 3. modifications to remove or reduce the scope in which ensure_full_index
    must be called.

The sparse index updates are predicated on a fix originating from the
microsoft/git fork [1], correcting how git reset --mixed handles resetting
entries outside the sparse checkout definition. Additionally, a performance
"bug" in next_cache_entry with sparse index is corrected, preventing
repeatedly looping over already-searched entries.

The p2000 tests demonstrate a ~70% execution time reduction in git reset
using a sparse index, and no change (within expected variability [2]) using
a full index. Results summarized below [3, 4]:

Test                           base              [5/8]                 
-----------------------------------------------------------------------
git reset --hard (full-v3)     1.00(0.50+0.39)   0.97(0.50+0.37) -3.0% 
git reset --hard (full-v4)     1.00(0.51+0.38)   0.96(0.50+0.36) -4.0% 
git reset --hard (sparse-v3)   1.68(1.17+0.39)   1.37(0.91+0.35) -18.5%
git reset --hard (sparse-v4)   1.70(1.18+0.40)   1.41(0.94+0.35) -17.1%

Test                           base              [6/8]   
-----------------------------------------------------------------------
git reset --hard (full-v3)     1.00(0.50+0.39)   0.94(0.48+0.34) -6.0% 
git reset --hard (full-v4)     1.00(0.51+0.38)   0.95(0.51+0.34) -5.0% 
git reset --hard (sparse-v3)   1.68(1.17+0.39)   0.46(0.05+0.29) -72.6%
git reset --hard (sparse-v4)   1.70(1.18+0.40)   0.46(0.06+0.29) -72.9%

Test                               base              [7/8]
---------------------------------------------------------------------------
git reset (full-v3)                0.77(0.27+0.37)   0.72(0.26+0.32) -6.5%
git reset (full-v4)                0.75(0.27+0.34)   0.73(0.26+0.32) -2.7%
git reset (sparse-v3)              1.44(0.96+0.36)   0.43(0.04+0.96) -70.1%
git reset (sparse-v4)              1.46(0.97+0.36)   0.43(0.05+0.79) -70.5%
git reset -- missing (full-v3)     0.72(0.26+0.32)   0.69(0.26+0.30) -4.2%
git reset -- missing (full-v4)     0.74(0.28+0.33)   0.71(0.27+0.32) -4.1% 
git reset -- missing (sparse-v3)   1.45(0.97+0.35)   0.81(0.42+0.90) -44.1%
git reset -- missing (sparse-v4)   1.41(0.94+0.34)   0.79(0.42+0.76) -44.0%

Test                               base              [8/8]            
---------------------------------------------------------------------------
git reset -- missing (full-v3)     0.72(0.26+0.32)   0.73(0.26+0.33) +1.4% 
git reset -- missing (full-v4)     0.74(0.28+0.33)   0.74(0.27+0.32) +0.0% 
git reset -- missing (sparse-v3)   1.45(0.97+0.35)   0.43(0.05+0.80) -70.3%
git reset -- missing (sparse-v4)   1.41(0.94+0.34)   0.44(0.05+0.76) -68.8%



Changes since V1
================

 * Add --force-full-index option to update-index. The option is used
   circumvent changing command_requires_full_index from its default value -
   right now this is effectively a no-op, but will change once update-index
   is integrated with sparse index. By using this option in the t1092
   expand/collapse test, the command used to test will not need to be
   updated with subsequent sparse index integrations.
 * Update implementation of mixed reset for entries outside sparse checkout
   definition. The condition in which a file should be checked out before
   index reset is simplified to "if it has skip-worktree enabled and a reset
   would change the file, check it out".
   * After checking the behavior of update_index_from_diff with renames,
     found that the diff used by reset does not produce diff queue entries
     with different pathnames for one and two. Because of this, and that
     nothing in the implementation seems to rely on identical path names, no
     BUG check is added.
 * Correct a bug in the sparse index is not expanded tests in t1092 where
   failure of a git reset --mixed test was not being reported. Test now
   verifies an appropriate scenario with corrected failure-checking.


Changes since V2
================

 * Replace patch adding checkouts for git reset --mixed with sparse checkout
   with preserving the skip-worktree flag (including a new test for git
   reset --mixed and update to t1092 - checkout and reset (mixed))
 * Move rename of is_missing into its own patch
 * Further extend t1092 tests and remove unnecessary commands/tests where
   possible
 * Refine logic determining which pathspecs require ensure_full_index in git
   reset --mixed, add related ensure_not_expanded tests
 * Add index_search_mode enum to index_name_stage_pos
 * Clean up variable usage & remove unnecessary subtree_path in
   prime_cache_tree_rec
 * Update cover letter performance data
 * More thoroughly explain changes in each commit message

Thanks! -Victoria

[1] microsoft@6b8a074 [2]
https://lore.kernel.org/git/8b9fe3f8-f0e3-4567-b20b-17c92bd1a5c5@github.com/
[3] If a test and/or commit is not mentioned, there is no significant change
to performance [4] Pathspec "does-not-exist" is changed to "missing" to save
space in performance report

Kevin Willford (1):
  reset: preserve skip-worktree bit in mixed reset

Victoria Dye (7):
  reset: rename is_missing to !is_in_reset_tree
  update-index: add --force-full-index option for expand/collapse test
  reset: expand test coverage for sparse checkouts
  reset: integrate with sparse index
  reset: make sparse-aware (except --mixed)
  reset: make --mixed sparse-aware
  unpack-trees: improve performance of next_cache_entry

 Documentation/git-update-index.txt       |   5 +
 builtin/reset.c                          | 104 +++++++++++++++++-
 builtin/update-index.c                   |  11 ++
 cache-tree.c                             |  46 +++++++-
 cache.h                                  |  10 ++
 read-cache.c                             |  27 +++--
 t/perf/p2000-sparse-operations.sh        |   3 +
 t/t1092-sparse-checkout-compatibility.sh | 133 ++++++++++++++++++++---
 t/t7102-reset.sh                         |  17 +++
 unpack-trees.c                           |  23 +++-
 10 files changed, 342 insertions(+), 37 deletions(-)


base-commit: cefe983a320c03d7843ac78e73bd513a27806845
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1048%2Fvdye%2Fvdye%2Fsparse-index-part1-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1048/vdye/vdye/sparse-index-part1-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1048

Range-diff vs v2:

 -:  ----------- > 1:  ad7013a31aa reset: rename is_missing to !is_in_reset_tree
 1:  22c69bc6030 ! 2:  1f6da84830b reset: behave correctly with sparse-checkout
     @@ Metadata
      Author: Kevin Willford <kewillf@microsoft.com>
      
       ## Commit message ##
     -    reset: behave correctly with sparse-checkout
     +    reset: preserve skip-worktree bit in mixed reset
      
     -    When using the sparse checkout feature, 'git reset' will add entries to
     -    the index that will have the skip-worktree bit off but will leave the
     -    working directory empty. File data is lost because the index version of
     -    the files has been changed but there is nothing that is in the working
     -    directory. This will cause the next 'git status' call to show either
     -    deleted for files modified or deleting or nothing for files added. The
     -    added files should be shown as untracked and modified files should be
     -    shown as modified.
     +    Change `update_index_from_diff` to set `skip-worktree` when applicable for
     +    new index entries. When `git reset --mixed <tree-ish>` is run, entries in
     +    the index with differences between the pre-reset HEAD and reset <tree-ish>
     +    are identified and handled with `update_index_from_diff`. For each file, a
     +    new cache entry in inserted into the index, created from the <tree-ish> side
     +    of the reset (without changing the working tree). However, the newly-created
     +    entry must have `skip-worktree` explicitly set in either of the following
     +    scenarios:
      
     -    To fix this when the reset is running if there is not a file in the
     -    working directory and if it will be missing with the new index entry or
     -    was not missing in the previous version, we create the previous index
     -    version of the file in the working directory so that status will report
     -    correctly and the files will be availble for the user to deal with.
     +    1. the file is in the current index and has `skip-worktree` set
     +    2. the file is not in the current index but is outside of a defined sparse
     +       checkout definition
      
     -    This fixes a documented failure from t1092 that was created in 19a0acc
     -    (t1092: test interesting sparse-checkout scenarios, 2021-01-23).
     +    Not setting the `skip-worktree` bit leads to likely-undesirable results for
     +    a user. It causes `skip-worktree` settings to disappear on the
     +    "diff"-containing files (but *only* the diff-containing files), leading to
     +    those files now showing modifications in `git status`. For example, when
     +    running `git reset --mixed` in a sparse checkout, some file entries outside
     +    of sparse checkout could show up as deleted, despite the user never deleting
     +    anything (and not wanting them on-disk anyway).
      
     -    Signed-off-by: Kevin Willford <kewillf@microsoft.com>
     -    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     +    Additionally, add a test to `t7102` to ensure `skip-worktree` is preserved
     +    in a basic `git reset --mixed` scenario and update a failure-documenting
     +    test from 19a0acc (t1092: test interesting sparse-checkout scenarios,
     +    2021-01-23) with new expected behavior.
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## builtin/reset.c ##
     @@ builtin/reset.c
       #include "submodule.h"
       #include "submodule-config.h"
      +#include "dir.h"
     -+#include "entry.h"
       
       #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
       
     @@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
       	for (i = 0; i < q->nr; i++) {
      +		int pos;
       		struct diff_filespec *one = q->queue[i]->one;
     --		int is_missing = !(one->mode && !is_null_oid(&one->oid));
     -+		struct diff_filespec *two = q->queue[i]->two;
     -+		int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
     + 		int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
       		struct cache_entry *ce;
     +@@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
       
     --		if (is_missing && !intent_to_add) {
     + 		ce = make_cache_entry(&the_index, one->mode, &one->oid, one->path,
     + 				      0, 0);
     ++
      +		/*
     -+		 * If the file being reset has `skip-worktree` enabled, we need
     -+		 * to check it out to prevent the file from being hard reset.
     ++		 * If the file 1) corresponds to an existing index entry with
     ++		 * skip-worktree set, or 2) does not exist in the index but is
     ++		 * outside the sparse checkout definition, add a skip-worktree bit
     ++		 * to the new index entry.
      +		 */
     -+		pos = cache_name_pos(two->path, strlen(two->path));
     -+		if (pos >= 0 && ce_skip_worktree(active_cache[pos])) {
     -+			struct checkout state = CHECKOUT_INIT;
     -+			state.force = 1;
     -+			state.refresh_cache = 1;
     -+			state.istate = &the_index;
     ++		pos = cache_name_pos(one->path, strlen(one->path));
     ++		if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
     ++		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
     ++			ce->ce_flags |= CE_SKIP_WORKTREE;
      +
     -+			checkout_entry(active_cache[pos], &state, NULL, NULL);
     -+		}
     -+
     -+		if (!is_in_reset_tree && !intent_to_add) {
     - 			remove_file_from_cache(one->path);
     - 			continue;
     - 		}
     -@@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
       		if (!ce)
       			die(_("make_cache_entry failed for path '%s'"),
       			    one->path);
     --		if (is_missing) {
     -+		if (!is_in_reset_tree) {
     - 			ce->ce_flags |= CE_INTENT_TO_ADD;
     - 			set_object_name_for_intent_to_add_entry(ce);
     - 		}
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'blame with pathspec outside sparse definition' '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'blame with pathsp
       	init_repos &&
       
       	test_all_match git checkout -b reset-test update-deep &&
     + 	test_all_match git reset deepest &&
     +-	test_all_match git reset update-folder1 &&
     +-	test_all_match git reset update-folder2
     +-'
     +-
     +-# NEEDSWORK: a sparse-checkout behaves differently from a full checkout
     +-# in this scenario, but it shouldn't.
     +-test_expect_success 'checkout and reset (mixed) [sparse]' '
     +-	init_repos &&
     + 
     +-	test_sparse_match git checkout -b reset-test update-deep &&
     +-	test_sparse_match git reset deepest &&
     ++	# Because skip-worktree is preserved, resetting to update-folder1
     ++	# will show worktree changes for full-checkout that are not present
     ++	# in sparse-checkout or sparse-index.
     + 	test_sparse_match git reset update-folder1 &&
     +-	test_sparse_match git reset update-folder2
     ++	run_on_sparse test_path_is_missing folder1
     + '
     + 
     + test_expect_success 'merge, cherry-pick, and rebase' '
      
     - ## t/t7114-reset-sparse-checkout.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='reset when using a sparse-checkout'
     -+
     -+. ./test-lib.sh
     -+
     -+test_expect_success 'setup' '
     -+	test_tick &&
     -+	echo "checkout file" >c &&
     -+	echo "modify file" >m &&
     -+	echo "delete file" >d &&
     -+	git add . &&
     -+	git commit -m "initial commit" &&
     -+	echo "added file" >a &&
     -+	echo "modification of a file" >m &&
     -+	git rm d &&
     -+	git add . &&
     -+	git commit -m "second commit" &&
     -+	git checkout -b endCommit
     -+'
     -+
     -+test_expect_success 'reset when there is a sparse-checkout' '
     -+	echo "/c" >.git/info/sparse-checkout &&
     -+	test_config core.sparsecheckout true &&
     -+	git checkout -B resetBranch &&
     -+	test_path_is_missing m &&
     -+	test_path_is_missing a &&
     -+	test_path_is_missing d &&
     -+	git reset HEAD~1 &&
     -+	echo "checkout file" >expect &&
     -+	test_cmp expect c &&
     -+	echo "added file" >expect &&
     -+	test_cmp expect a &&
     -+	echo "modification of a file" >expect &&
     -+	test_cmp expect m &&
     -+	test_path_is_missing d
     -+'
     + ## t/t7102-reset.sh ##
     +@@ t/t7102-reset.sh: test_expect_success '--mixed refreshes the index' '
     + 	test_cmp expect output
     + '
     + 
     ++test_expect_success '--mixed preserves skip-worktree' '
     ++	echo 123 >>file2 &&
     ++	git add file2 &&
     ++	git update-index --skip-worktree file2 &&
     ++	git reset --mixed HEAD >output &&
     ++	test_must_be_empty output &&
      +
     -+test_expect_success 'reset after deleting file without skip-worktree bit' '
     -+	git checkout -f endCommit &&
     -+	git clean -xdf &&
     -+	cat >.git/info/sparse-checkout <<-\EOF &&
     -+	/c
     -+	/m
     ++	cat >expect <<-\EOF &&
     ++	Unstaged changes after reset:
     ++	M	file2
      +	EOF
     -+	test_config core.sparsecheckout true &&
     -+	git checkout -B resetAfterDelete &&
     -+	test_path_is_file m &&
     -+	test_path_is_missing a &&
     -+	test_path_is_missing d &&
     -+	rm -f m &&
     -+	git reset HEAD~1 &&
     -+	echo "checkout file" >expect &&
     -+	test_cmp expect c &&
     -+	echo "added file" >expect &&
     -+	test_cmp expect a &&
     -+	test_path_is_missing m &&
     -+	test_path_is_missing d
     ++	git update-index --no-skip-worktree file2 &&
     ++	git add file2 &&
     ++	git reset --mixed HEAD >output &&
     ++	test_cmp expect output
      +'
      +
     -+test_done
     + test_expect_success 'resetting specific path that is unmerged' '
     + 	git rm --cached file2 &&
     + 	F1=$(git rev-parse HEAD:file1) &&
 2:  f7cb9013d46 ! 3:  014a408ea5d update-index: add --force-full-index option for expand/collapse test
     @@ Commit message
          update-index: add --force-full-index option for expand/collapse test
      
          Add a new `--force-full-index` option to `git update-index`, which skips
     -    explicitly setting `command_requires_full_index`. This lets `git
     -    update-index --force-full-index` run as a command without sparse index
     -    compatibility implemented, even after it receives sparse index compatibility
     -    updates.
     +    explicitly setting `command_requires_full_index`. This option, intended for
     +    use in internal testing purposes only, lets `git update-index` run as a
     +    command without sparse index compatibility implemented, even after it
     +    receives updates to otherwise use the sparse index.
      
     -    By using `git update-index --force-full-index` in the `t1092` test
     -    `sparse-index is expanded and converted back`, commands can continue to
     -    integrate with the sparse index without the need to keep modifying the
     -    command used in the test.
     +    The specific test `--force-full-index` is intended for - `t1092 -
     +    sparse-index is expanded and converted back` - verifies index compatibility
     +    in commands that do not change the default (enabled)
     +    `command_requires_full_index` repo setting. In the past, the test used `git
     +    reset`. However, as `reset` and other commands are integrated with the
     +    sparse index, the command used in the test would need to keep changing.
     +    Conversely, the `--force-full-index` option makes `git update-index` behave
     +    like a not-yet-sparse-aware command, and can be used in the test
     +    indefinitely without interfering with future sparse index integrations.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Documentation/git-update-index.txt ##
 3:  c7e9d9f4e03 ! 4:  7f21cf53e9d reset: expand test coverage for sparse checkouts
     @@ Commit message
          reset: expand test coverage for sparse checkouts
      
          Add new tests for `--merge` and `--keep` modes, as well as mixed reset with
     -    pathspecs both inside and outside of the sparse checkout definition. New
     -    performance test cases exercise various execution paths for `reset`.
     +    pathspecs. New performance test cases exercise various execution paths for
     +    `reset`.
      
          Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git add -A
       test_done
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
     -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout and reset (mixed) [sparse]' '
     - 	test_sparse_match git reset update-folder2
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout and reset (mixed)' '
     + 	run_on_sparse test_path_is_missing folder1
       '
       
     -+# NEEDSWORK: with mixed reset, files with differences between HEAD and <commit>
     -+# will be added to the work tree even if outside the sparse checkout
     -+# definition, and even if the file is modified to a state of having no local
     -+# changes. The file is "re-ignored" if a hard reset is executed. We may want to
     -+# change this behavior in the future and enforce that files are not written
     -+# outside of the sparse checkout definition.
     -+test_expect_success 'checkout and mixed reset file tracking [sparse]' '
     -+	init_repos &&
     -+
     -+	test_all_match git checkout -b reset-test update-deep &&
     -+	test_all_match git reset update-folder1 &&
     -+	test_all_match git reset update-deep &&
     -+
     -+	# At this point, there are no changes in the working tree. However,
     -+	# folder1/a now exists locally (even though it is outside of the sparse
     -+	# paths).
     -+	run_on_sparse test_path_exists folder1 &&
     -+
     -+	run_on_all rm folder1/a &&
     -+	test_all_match git status --porcelain=v2 &&
     -+
     -+	test_all_match git reset --hard update-deep &&
     -+	run_on_sparse test_path_is_missing folder1 &&
     -+	test_path_exists full-checkout/folder1
     -+'
     -+
      +test_expect_success 'checkout and reset (merge)' '
      +	init_repos &&
      +
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout and rese
      +	test_all_match git status --porcelain=v2
      +'
      +
     -+test_expect_success 'reset with sparse directory pathspec outside definition' '
     ++# Although the working tree differs between full and sparse checkouts after
     ++# reset, the state of the index is the same.
     ++test_expect_success 'reset with pathspecs outside sparse definition' '
      +	init_repos &&
     ++	test_all_match git checkout -b reset-test base &&
      +
     -+	test_all_match git checkout -b reset-test update-deep &&
     -+	test_all_match git reset --hard update-folder1 &&
     -+	test_all_match git reset base -- folder1 &&
     -+	test_all_match git status --porcelain=v2
     -+'
     ++	test_sparse_match git reset update-folder1 -- folder1 &&
     ++	git -C full-checkout reset update-folder1 -- folder1 &&
     ++	test_sparse_match git status --porcelain=v2 &&
     ++	test_all_match git rev-parse HEAD:folder1 &&
      +
     -+test_expect_success 'reset with pathspec match in sparse directory' '
     -+	init_repos &&
     -+
     -+	test_all_match git checkout -b reset-test update-deep &&
     -+	test_all_match git reset --hard update-folder1 &&
     -+	test_all_match git reset base -- folder1/a &&
     -+	test_all_match git status --porcelain=v2
     ++	test_sparse_match git reset update-folder2 -- folder2/a &&
     ++	git -C full-checkout reset update-folder2 -- folder2/a &&
     ++	test_sparse_match git status --porcelain=v2 &&
     ++	test_all_match git rev-parse HEAD:folder2/a
      +'
      +
      +test_expect_success 'reset with wildcard pathspec' '
      +	init_repos &&
      +
      +	test_all_match git checkout -b reset-test update-deep &&
     -+	test_all_match git reset --hard update-folder1 &&
      +	test_all_match git reset base -- \*/a &&
     -+	test_all_match git status --porcelain=v2
     ++	test_all_match git status --porcelain=v2 &&
     ++	test_all_match git rev-parse HEAD:folder1/a &&
     ++
     ++	test_all_match git reset base -- folder\* &&
     ++	test_all_match git status --porcelain=v2 &&
     ++	test_all_match git rev-parse HEAD:folder2
      +'
      +
       test_expect_success 'merge, cherry-pick, and rebase' '
 4:  49813c8d9ed ! 5:  a2d6212e287 reset: integrate with sparse index
     @@ Metadata
       ## Commit message ##
          reset: integrate with sparse index
      
     -    `reset --soft` does not modify the index, so no compatibility changes are
     -    needed for it to function without expanding the index. For all other reset
     -    modes (`--mixed`, `--hard`, `--keep`, `--merge`), the full index is
     -    explicitly expanded with `ensure_full_index` to maintain current behavior.
     +    Disable `command_requires_full_index` repo setting and add
     +    `ensure_full_index` guards around code paths that cannot yet use sparse
     +    directory index entries. `reset --soft` does not modify the index, so no
     +    compatibility changes are needed for it to function without expanding the
     +    index. For all other reset modes (`--mixed`, `--hard`, `--keep`, `--merge`),
     +    the full index is expanded to prevent cache tree corruption and invalid
     +    variable accesses.
      
          Additionally, the `read_cache()` check verifying an uncorrupted index is
          moved after argument parsing and preparing the repo settings. The index is
     -    not used by the preceding argument handling, but `read_cache()` does need to
     -    be run after enabling sparse index for the command and before resetting.
     +    not used by the preceding argument handling, but `read_cache()` must be run
     +    *after* enabling sparse index for the command (so that the index is not
     +    expanded unnecessarily) and *before* using the index for reset (so that it
     +    is verified as uncorrupted).
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
 5:  78cd85d8dcc ! 6:  330e0c09774 reset: make sparse-aware (except --mixed)
     @@ Metadata
       ## Commit message ##
          reset: make sparse-aware (except --mixed)
      
     -    In order to accurately reconstruct the cache tree in `prime_cache_tree_rec`,
     -    the function must determine whether the currently-processing directory in
     -    the tree is sparse or not. If it is not sparse, the tree is parsed and
     -    subtree recursively constructed. If it is sparse, no subtrees are added to
     -    the tree and the entry count is set to 1 (representing the sparse directory
     -    itself).
     +    Remove `ensure_full_index` guard on `prime_cache_tree` and update
     +    `prime_cache_tree_rec` to correctly reconstruct sparse directory entries in
     +    the cache tree. While processing a tree's entries, `prime_cache_tree_rec`
     +    must determine whether a directory entry is sparse or not by searching for
     +    it in the index (*without* expanding the index). If a matching sparse
     +    directory index entry is found, no subtrees are added to the cache tree
     +    entry and the entry count is set to 1 (representing the sparse directory
     +    itself). Otherwise, the tree is assumed to not be sparse and its subtrees
     +    are recursively added to the cache tree.
      
     +    Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## cache-tree.c ##
     @@ cache-tree.c: out:
       	return ret;
       }
       
     -+static void prime_cache_tree_sparse_dir(struct repository *r,
     -+					struct cache_tree *it,
     -+					struct tree *tree,
     -+					struct strbuf *tree_path)
     ++static void prime_cache_tree_sparse_dir(struct cache_tree *it,
     ++					struct tree *tree)
      +{
      +
      +	oidcpy(&it->oid, &tree->object.oid);
      +	it->entry_count = 1;
     -+	return;
      +}
      +
       static void prime_cache_tree_rec(struct repository *r,
     @@ cache-tree.c: out:
      +				 struct tree *tree,
      +				 struct strbuf *tree_path)
       {
     -+	struct strbuf subtree_path = STRBUF_INIT;
       	struct tree_desc desc;
       	struct name_entry entry;
       	int cnt;
     ++	int base_path_len = tree_path->len;
       
       	oidcpy(&it->oid, &tree->object.oid);
      +
     @@ cache-tree.c: static void prime_cache_tree_rec(struct repository *r,
       			sub = cache_tree_sub(it, entry.path);
       			sub->cache_tree = cache_tree();
      -			prime_cache_tree_rec(r, sub->cache_tree, subtree);
     -+			strbuf_reset(&subtree_path);
     -+			strbuf_grow(&subtree_path, tree_path->len + entry.pathlen + 1);
     -+			strbuf_addbuf(&subtree_path, tree_path);
     -+			strbuf_add(&subtree_path, entry.path, entry.pathlen);
     -+			strbuf_addch(&subtree_path, '/');
     ++
     ++			/*
     ++			 * Recursively-constructed subtree path is only needed when working
     ++			 * in a sparse index (where it's used to determine whether the
     ++			 * subtree is a sparse directory in the index).
     ++			 */
     ++			if (r->index->sparse_index) {
     ++				strbuf_setlen(tree_path, base_path_len);
     ++				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
     ++				strbuf_add(tree_path, entry.path, entry.pathlen);
     ++				strbuf_addch(tree_path, '/');
     ++			}
      +
      +			/*
      +			 * If a sparse index is in use, the directory being processed may be
     @@ cache-tree.c: static void prime_cache_tree_rec(struct repository *r,
      +			 * as normal.
      +			 */
      +			if (r->index->sparse_index &&
     -+			    index_entry_exists(r->index, subtree_path.buf, subtree_path.len))
     -+				prime_cache_tree_sparse_dir(r, sub->cache_tree, subtree, &subtree_path);
     ++			    index_entry_exists(r->index, tree_path->buf, tree_path->len))
     ++				prime_cache_tree_sparse_dir(sub->cache_tree, subtree);
      +			else
     -+				prime_cache_tree_rec(r, sub->cache_tree, subtree, &subtree_path);
     ++				prime_cache_tree_rec(r, sub->cache_tree, subtree, tree_path);
       			cnt += sub->cache_tree->entry_count;
       		}
       	}
     - 	it->entry_count = cnt;
      +
     -+	strbuf_release(&subtree_path);
     + 	it->entry_count = cnt;
       }
       
     - void prime_cache_tree(struct repository *r,
     +@@ cache-tree.c: void prime_cache_tree(struct repository *r,
       		      struct index_state *istate,
       		      struct tree *tree)
       {
     @@ cache.h: struct cache_entry *index_file_exists(struct index_state *istate, const
        * precise match was not found but a position was found where the entry would
      
       ## read-cache.c ##
     +@@
     +  */
     + #define CACHE_ENTRY_PATH_LENGTH 80
     + 
     ++enum index_search_mode {
     ++	NO_EXPAND_SPARSE = 0,
     ++	EXPAND_SPARSE = 1
     ++};
     ++
     + static inline struct cache_entry *mem_pool__ce_alloc(struct mem_pool *mem_pool, size_t len)
     + {
     + 	struct cache_entry *ce;
      @@ read-cache.c: int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
       	return 0;
       }
     @@ read-cache.c: int cache_name_stage_compare(const char *name1, int len1, int stag
      +static int index_name_stage_pos(struct index_state *istate,
      +				const char *name, int namelen,
      +				int stage,
     -+				int search_sparse)
     ++				enum index_search_mode search_mode)
       {
       	int first, last;
       
     @@ read-cache.c: static int index_name_stage_pos(struct index_state *istate, const
       	}
       
      -	if (istate->sparse_index &&
     -+	if (search_sparse && istate->sparse_index &&
     ++	if (search_mode == EXPAND_SPARSE && istate->sparse_index &&
       	    first > 0) {
       		/* Note: first <= istate->cache_nr */
       		struct cache_entry *ce = istate->cache[first - 1];
     @@ read-cache.c: static int index_name_stage_pos(struct index_state *istate, const
       		    !strncmp(name, ce->name, ce_namelen(ce))) {
       			ensure_full_index(istate);
      -			return index_name_stage_pos(istate, name, namelen, stage);
     -+			return index_name_stage_pos(istate, name, namelen, stage, search_sparse);
     ++			return index_name_stage_pos(istate, name, namelen, stage, search_mode);
       		}
       	}
       
     @@ read-cache.c: static int index_name_stage_pos(struct index_state *istate, const
       int index_name_pos(struct index_state *istate, const char *name, int namelen)
       {
      -	return index_name_stage_pos(istate, name, namelen, 0);
     -+	return index_name_stage_pos(istate, name, namelen, 0, 1);
     ++	return index_name_stage_pos(istate, name, namelen, 0, EXPAND_SPARSE);
      +}
      +
      +int index_entry_exists(struct index_state *istate, const char *name, int namelen)
      +{
     -+	return index_name_stage_pos(istate, name, namelen, 0, 0) >= 0;
     ++	return index_name_stage_pos(istate, name, namelen, 0, NO_EXPAND_SPARSE) >= 0;
       }
       
       int remove_index_entry_at(struct index_state *istate, int pos)
     @@ read-cache.c: static int has_dir_name(struct index_state *istate,
       		}
       
      -		pos = index_name_stage_pos(istate, name, len, stage);
     -+		pos = index_name_stage_pos(istate, name, len, stage, 1);
     ++		pos = index_name_stage_pos(istate, name, len, stage, EXPAND_SPARSE);
       		if (pos >= 0) {
       			/*
       			 * Found one, but not so fast.  This could
     @@ read-cache.c: static int add_index_entry_with_check(struct index_state *istate,
       		pos = index_pos_to_insert_pos(istate->cache_nr);
       	else
      -		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
     -+		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), 1);
     ++		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
       
       	/* existing match? Just replace it. */
       	if (pos >= 0) {
     @@ read-cache.c: static int add_index_entry_with_check(struct index_state *istate,
       			return error(_("'%s' appears as both a file and as a directory"),
       				     ce->name);
      -		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
     -+		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), 1);
     ++		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
       		pos = -pos-1;
       	}
       	return pos + 1;
 6:  5eaae0825af ! 7:  6ef8e4e31d3 reset: make --mixed sparse-aware
     @@ Metadata
       ## Commit message ##
          reset: make --mixed sparse-aware
      
     -    Sparse directory entries are "diffed" as trees in `diff_cache` (used
     -    internally by `reset --mixed`), following a code path separate from
     -    individual file handling. The use of `diff_tree_oid` there requires setting
     -    explicit `change` and `add_remove` functions to process the internal
     -    contents of a sparse directory.
     +    Remove the `ensure_full_index` guard on `read_from_tree` and update `git
     +    reset --mixed` to ensure it can use sparse directory index entries wherever
     +    possible. Sparse directory entries are reset use `diff_tree_oid`, which
     +    requires `change` and `add_remove` functions to process the internal
     +    contents of the sparse directory. The `recursive` diff option handles cases
     +    in which `reset --mixed` must diff/merge files that are nested multiple
     +    levels deep in a sparse directory.
      
     -    Additionally, the `recursive` diff option handles cases in which `reset
     -    --mixed` must diff/merge files that are nested multiple levels deep in a
     -    sparse directory.
     +    The use of pathspecs with `git reset --mixed` introduces scenarios in which
     +    internal contents of sparse directories may be matched by the pathspec. In
     +    order to reset *all* files in the repo that may match the pathspec, the
     +    following conditions on the pathspec require index expansion before
     +    performing the reset:
      
     +    * "magic" pathspecs
     +    * wildcard pathspecs that do not match only in-cone files or entire sparse
     +      directories
     +    * literal pathspecs matching something outside the sparse checkout
     +      definition
     +
     +    Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## builtin/reset.c ##
     -@@ builtin/reset.c: static int read_from_tree(const struct pathspec *pathspec,
     - 			  int intent_to_add)
     - {
     - 	struct diff_options opt;
     -+	unsigned int i;
     -+	char *skip_worktree_seen = NULL;
     +@@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
     + 		 * If the file 1) corresponds to an existing index entry with
     + 		 * skip-worktree set, or 2) does not exist in the index but is
     + 		 * outside the sparse checkout definition, add a skip-worktree bit
     +-		 * to the new index entry.
     ++		 * to the new index entry. Note that a sparse index will be expanded
     ++		 * if this entry is outside the sparse cone - this is necessary
     ++		 * to properly construct the reset sparse directory.
     + 		 */
     + 		pos = cache_name_pos(one->path, strlen(one->path));
     + 		if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
     +@@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
     + 	}
     + }
       
     - 	memset(&opt, 0, sizeof(opt));
     - 	copy_pathspec(&opt.pathspec, pathspec);
     -@@ builtin/reset.c: static int read_from_tree(const struct pathspec *pathspec,
     - 	opt.format_callback = update_index_from_diff;
     - 	opt.format_callback_data = &intent_to_add;
     - 	opt.flags.override_submodule_config = 1;
     -+	opt.flags.recursive = 1;
     - 	opt.repo = the_repository;
     -+	opt.change = diff_change;
     -+	opt.add_remove = diff_addremove;
     ++static int pathspec_needs_expanded_index(const struct pathspec *pathspec)
     ++{
     ++	unsigned int i, pos;
     ++	int res = 0;
     ++	char *skip_worktree_seen = NULL;
      +
      +	/*
     -+	 * When pathspec is given for resetting a cone-mode sparse checkout, it may
     -+	 * identify entries that are nested in sparse directories, in which case the
     -+	 * index should be expanded. For the sake of efficiency, this check is
     -+	 * overly-cautious: anything with a wildcard or a magic prefix requires
     -+	 * expansion, as well as literal paths that aren't in the sparse checkout
     -+	 * definition AND don't match any directory in the index.
     ++	 * When using a magic pathspec, assume for the sake of simplicity that
     ++	 * the index needs to be expanded to match all matchable files.
      +	 */
     -+	if (pathspec->nr && the_index.sparse_index) {
     -+		if (pathspec->magic || pathspec->has_wildcard) {
     -+			ensure_full_index(&the_index);
     -+		} else {
     -+			for (i = 0; i < pathspec->nr; i++) {
     -+				if (!path_in_cone_mode_sparse_checkout(pathspec->items[i].original, &the_index) &&
     -+				    !matches_skip_worktree(pathspec, i, &skip_worktree_seen)) {
     -+					ensure_full_index(&the_index);
     ++	if (pathspec->magic)
     ++		return 1;
     ++
     ++	for (i = 0; i < pathspec->nr; i++) {
     ++		struct pathspec_item item = pathspec->items[i];
     ++
     ++		/*
     ++		 * If the pathspec item has a wildcard, the index should be expanded
     ++		 * if the pathspec has the possibility of matching a subset of entries inside
     ++		 * of a sparse directory (but not the entire directory).
     ++		 *
     ++		 * If the pathspec item is a literal path, the index only needs to be expanded
     ++		 * if a) the pathspec isn't in the sparse checkout cone (to make sure we don't
     ++		 * expand for in-cone files) and b) it doesn't match any sparse directories
     ++		 * (since we can reset whole sparse directories without expanding them).
     ++		 */
     ++		if (item.nowildcard_len < item.len) {
     ++			for (pos = 0; pos < active_nr; pos++) {
     ++				struct cache_entry *ce = active_cache[pos];
     ++
     ++				if (!S_ISSPARSEDIR(ce->ce_mode))
     ++					continue;
     ++
     ++				/*
     ++				 * If the pre-wildcard length is longer than the sparse
     ++				 * directory name and the sparse directory is the first
     ++				 * component of the pathspec, need to expand the index.
     ++				 */
     ++				if (item.nowildcard_len > ce_namelen(ce) &&
     ++				    !strncmp(item.original, ce->name, ce_namelen(ce))) {
     ++					res = 1;
     ++					break;
     ++				}
     ++
     ++				/*
     ++				 * If the pre-wildcard length is shorter than the sparse
     ++				 * directory and the pathspec does not match the whole
     ++				 * directory, need to expand the index.
     ++				 */
     ++				if (!strncmp(item.original, ce->name, item.nowildcard_len) &&
     ++				    wildmatch(item.original, ce->name, 0)) {
     ++					res = 1;
      +					break;
      +				}
      +			}
     -+		}
     ++		} else if (!path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
     ++			   !matches_skip_worktree(pathspec, i, &skip_worktree_seen))
     ++			res = 1;
     ++
     ++		if (res > 0)
     ++			break;
      +	}
      +
      +	free(skip_worktree_seen);
     ++	return res;
     ++}
     ++
     + static int read_from_tree(const struct pathspec *pathspec,
     + 			  struct object_id *tree_oid,
     + 			  int intent_to_add)
     +@@ builtin/reset.c: static int read_from_tree(const struct pathspec *pathspec,
     + 	opt.format_callback = update_index_from_diff;
     + 	opt.format_callback_data = &intent_to_add;
     + 	opt.flags.override_submodule_config = 1;
     ++	opt.flags.recursive = 1;
     + 	opt.repo = the_repository;
     ++	opt.change = diff_change;
     ++	opt.add_remove = diff_addremove;
     ++
     ++	if (pathspec->nr && the_index.sparse_index && pathspec_needs_expanded_index(pathspec))
     ++		ensure_full_index(&the_index);
       
      -	ensure_full_index(&the_index);
       	if (do_diff_cache(tree_oid, &opt))
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
       	ensure_not_expanded reset --hard update-deep &&
       	ensure_not_expanded reset --keep base &&
       	ensure_not_expanded reset --merge update-deep &&
     --	ensure_not_expanded reset --hard &&
     + 	ensure_not_expanded reset --hard &&
       
      +	ensure_not_expanded reset base -- deep/a &&
      +	ensure_not_expanded reset base -- nonexistent-file &&
      +	ensure_not_expanded reset deepest -- deep &&
      +
      +	# Although folder1 is outside the sparse definition, it exists as a
     -+	# directory entry in the index, so it will be reset without needing to
     -+	# expand the full index.
     -+	ensure_not_expanded reset --hard update-folder1 &&
     -+	ensure_not_expanded reset base -- folder1 &&
     ++	# directory entry in the index, so the pathspec will not force the
     ++	# index to be expanded.
     ++	ensure_not_expanded reset deepest -- folder1 &&
     ++	ensure_not_expanded reset deepest -- folder1/ &&
     ++
     ++	# Wildcard identifies only in-cone files, no index expansion
     ++	ensure_not_expanded reset deepest -- deep/\* &&
     ++
     ++	# Wildcard identifies only full sparse directories, no index expansion
     ++	ensure_not_expanded reset deepest -- folder\* &&
      +
     -+	ensure_not_expanded reset --hard update-deep &&
       	ensure_not_expanded checkout -f update-deep &&
       	test_config -C sparse-index pull.twohead ort &&
       	(
 7:  aa963eefae7 ! 8:  c7145e039f3 unpack-trees: improve performance of next_cache_entry
     @@ Commit message
          beginning of the index each time it is called.
      
          The `cache_bottom` must be preserved for the sparse index (see 17a1bb570b
     -    (unpack-trees: preserve cache_bottom, 2021-07-14)).  Therefore, to retain
     -    the benefit `cache_bottom` provides in non-sparse index cases, a separate
     -    `hint` position indicates the first position `next_cache_entry` should
     -    search, updated each execution with a new position.  The performance of `git
     -    reset -- does-not-exist` (testing the "worst case" in which all entries in
     -    the index are unpacked with `next_cache_entry`) is significantly improved
     -    for the sparse index case:
     -
     -    Test          before            after
     -    ------------------------------------------------------
     -    (full-v3)     0.79(0.38+0.30)   0.91(0.43+0.34) +15.2%
     -    (full-v4)     0.80(0.38+0.29)   0.85(0.40+0.35) +6.2%
     -    (sparse-v3)   0.76(0.43+0.69)   0.44(0.08+0.67) -42.1%
     -    (sparse-v4)   0.71(0.40+0.65)   0.41(0.09+0.65) -42.3%
     +    (unpack-trees: preserve cache_bottom, 2021-07-14)). Therefore, to retain the
     +    benefit `cache_bottom` provides in non-sparse index cases, a separate `hint`
     +    position indicates the first position `next_cache_entry` should search,
     +    updated each execution with a new position.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      

-- 
gitgitgadget
