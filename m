Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716F6C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED45613D5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhJENWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbhJENWu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 09:22:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75FCC061755
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 06:20:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o20so19269394wro.3
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AuGUjzdZEIBTQTt3ms9UVQTODcqtxEoRIGijx75/kcQ=;
        b=Ny+ghdoxAwyQnENLy8oEU/5drNp0tNZAxcOgrtwuMmjkjYesn97VnOm/aGGCBJktTE
         jllv9c3qfcvOmmzmiIulfIkegZZeSGG1aHdMRrYlVwqLIPKto/YEa2T1+hiC2IyQcLRG
         2Y+Ri5cUwBrgVXxEwfzdfzblSl+MFxo6ej0Oh/3tzhdXVJ0Q06QS/4OgBJ7HlKg4sdve
         AXTYCcxqS0YnMjFkxcn4VNlnpnANJF0+byZ9dYx9Ec/WlAdgdMTyrgId7buMGe5rzFG2
         GMr4Ou877ZQYw3SMJkFVCDvToOCvN/zgOjwlLzOvJI+9sBdAcJOeECOXS6SQp0G2ZFE6
         PUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AuGUjzdZEIBTQTt3ms9UVQTODcqtxEoRIGijx75/kcQ=;
        b=Va4pbWNuDmE7OtWaeMN54J4paQANGeMrnm/nQapA5E/8S+SqEMBoD15yhWFpa4D/+H
         rID2NkzD/CdQDsoyh+iEIek2FW6nNrZcA9Rw0oDWo0+haHyJS3rcjl8g8Nw23MTRs+11
         VFpgJ11UNrZMgQ3pdecpPb52EHdYvOJAR2dWyqzIc/vyE9GOh8L51frkosPEK+PmZ7N6
         lQO8Yw2p85Spc1RUICdgwwBsd3K7a67LBDx2UgiW4GNo7mVBo0bnCN1waO50H5erCu17
         37s0hf80UJGUr651HsD8ZUhQxdmPng1vqFqo9lmkkZOlZ81Xm9MNHZ+VcpvRV5pkkTkC
         429w==
X-Gm-Message-State: AOAM5314FvRl/vijnl5tjrCTgjsgkllqvud3PwdGQZz/LEtSR5p+tWqg
        OOS+b9JFL3K9uuqXizipMr7TjTOCQSg=
X-Google-Smtp-Source: ABdhPJzIhXalEL2H4AE2Z0ZgRMo/JwTe85+gU40sWypcgDiUlv2Yab/vOOaVYsLdOIpwR6rU3FXmoA==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr21089190wrq.162.1633440058229;
        Tue, 05 Oct 2021 06:20:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm17804460wrq.7.2021.10.05.06.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:20:57 -0700 (PDT)
Message-Id: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Oct 2021 13:20:50 +0000
Subject: [PATCH v2 0/7] Sparse Index: integrate with reset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>
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

The p2000 tests demonstrate an overall ~70% execution time reduction across
all tested usages of git reset using a sparse index:

Test                                               before   after       
------------------------------------------------------------------------
2000.22: git reset (full-v3)                       0.48     0.51 +6.3% 
2000.23: git reset (full-v4)                       0.47     0.50 +6.4% 
2000.24: git reset (sparse-v3)                     0.93     0.30 -67.7%
2000.25: git reset (sparse-v4)                     0.94     0.29 -69.1%
2000.26: git reset --hard (full-v3)                0.69     0.68 -1.4% 
2000.27: git reset --hard (full-v4)                0.75     0.68 -9.3% 
2000.28: git reset --hard (sparse-v3)              1.29     0.34 -73.6%
2000.29: git reset --hard (sparse-v4)              1.31     0.34 -74.0%
2000.30: git reset -- does-not-exist (full-v3)     0.54     0.51 -5.6% 
2000.31: git reset -- does-not-exist (full-v4)     0.54     0.52 -3.7% 
2000.32: git reset -- does-not-exist (sparse-v3)   1.02     0.31 -69.6%
2000.33: git reset -- does-not-exist (sparse-v4)   1.07     0.30 -72.0%



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

Thanks! -Victoria

[1] microsoft@6b8a074

Kevin Willford (1):
  reset: behave correctly with sparse-checkout

Victoria Dye (6):
  update-index: add --force-full-index option for expand/collapse test
  reset: expand test coverage for sparse checkouts
  reset: integrate with sparse index
  reset: make sparse-aware (except --mixed)
  reset: make --mixed sparse-aware
  unpack-trees: improve performance of next_cache_entry

 Documentation/git-update-index.txt       |   5 +
 builtin/reset.c                          |  62 +++++++++-
 builtin/update-index.c                   |  11 ++
 cache-tree.c                             |  43 ++++++-
 cache.h                                  |  10 ++
 read-cache.c                             |  22 ++--
 t/perf/p2000-sparse-operations.sh        |   3 +
 t/t1092-sparse-checkout-compatibility.sh | 139 ++++++++++++++++++++++-
 t/t7114-reset-sparse-checkout.sh         |  61 ++++++++++
 unpack-trees.c                           |  23 +++-
 10 files changed, 351 insertions(+), 28 deletions(-)
 create mode 100755 t/t7114-reset-sparse-checkout.sh


base-commit: cefe983a320c03d7843ac78e73bd513a27806845
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1048%2Fvdye%2Fvdye%2Fsparse-index-part1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1048/vdye/vdye/sparse-index-part1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1048

Range-diff vs v1:

 1:  65905bf4e00 ! 1:  22c69bc6030 reset: behave correctly with sparse-checkout
     @@ builtin/reset.c
       #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
       
      @@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
     - 		struct diff_options *opt, void *data)
     - {
     - 	int i;
     -+	int pos;
       	int intent_to_add = *(int *)data;
       
       	for (i = 0; i < q->nr; i++) {
     ++		int pos;
       		struct diff_filespec *one = q->queue[i]->one;
     +-		int is_missing = !(one->mode && !is_null_oid(&one->oid));
      +		struct diff_filespec *two = q->queue[i]->two;
     - 		int is_missing = !(one->mode && !is_null_oid(&one->oid));
     -+		int was_missing = !two->mode && is_null_oid(&two->oid);
     ++		int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
       		struct cache_entry *ce;
     -+		struct cache_entry *ce_before;
     -+		struct checkout state = CHECKOUT_INIT;
     -+
     + 
     +-		if (is_missing && !intent_to_add) {
      +		/*
     -+		 * When using the sparse-checkout feature the cache entries
     -+		 * that are added here will not have the skip-worktree bit
     -+		 * set. Without this code there is data that is lost because
     -+		 * the files that would normally be in the working directory
     -+		 * are not there and show as deleted for the next status.
     -+		 * In the case of added files, they just disappear.
     -+		 *
     -+		 * We need to create the previous version of the files in
     -+		 * the working directory so that they will have the right
     -+		 * content and the next status call will show modified or
     -+		 * untracked files correctly.
     ++		 * If the file being reset has `skip-worktree` enabled, we need
     ++		 * to check it out to prevent the file from being hard reset.
      +		 */
     -+		if (core_apply_sparse_checkout && !file_exists(two->path)) {
     -+			pos = cache_name_pos(two->path, strlen(two->path));
     -+			if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) &&
     -+			    (is_missing || !was_missing)) {
     -+				state.force = 1;
     -+				state.refresh_cache = 1;
     -+				state.istate = &the_index;
     -+
     -+				ce_before = make_cache_entry(&the_index, two->mode,
     -+							     &two->oid, two->path,
     -+							     0, 0);
     -+				if (!ce_before)
     -+					die(_("make_cache_entry failed for path '%s'"),
     -+						two->path);
     ++		pos = cache_name_pos(two->path, strlen(two->path));
     ++		if (pos >= 0 && ce_skip_worktree(active_cache[pos])) {
     ++			struct checkout state = CHECKOUT_INIT;
     ++			state.force = 1;
     ++			state.refresh_cache = 1;
     ++			state.istate = &the_index;
      +
     -+				checkout_entry(ce_before, &state, NULL, NULL);
     -+			}
     ++			checkout_entry(active_cache[pos], &state, NULL, NULL);
      +		}
     - 
     - 		if (is_missing && !intent_to_add) {
     ++
     ++		if (!is_in_reset_tree && !intent_to_add) {
       			remove_file_from_cache(one->path);
     + 			continue;
     + 		}
     +@@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
     + 		if (!ce)
     + 			die(_("make_cache_entry failed for path '%s'"),
     + 			    one->path);
     +-		if (is_missing) {
     ++		if (!is_in_reset_tree) {
     + 			ce->ce_flags |= CE_INTENT_TO_ADD;
     + 			set_object_name_for_intent_to_add_entry(ce);
     + 		}
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'blame with pathspec outside sparse definition' '
 2:  a1fa7c080ae ! 2:  f7cb9013d46 sparse-index: update command for expand/collapse test
     @@ Metadata
      Author: Victoria Dye <vdye@github.com>
      
       ## Commit message ##
     -    sparse-index: update command for expand/collapse test
     +    update-index: add --force-full-index option for expand/collapse test
      
     -    In anticipation of multiple commands being fully integrated with sparse
     -    index, update the test for index expand and collapse for non-sparse index
     -    integrated commands to use `mv`.
     +    Add a new `--force-full-index` option to `git update-index`, which skips
     +    explicitly setting `command_requires_full_index`. This lets `git
     +    update-index --force-full-index` run as a command without sparse index
     +    compatibility implemented, even after it receives sparse index compatibility
     +    updates.
     +
     +    By using `git update-index --force-full-index` in the `t1092` test
     +    `sparse-index is expanded and converted back`, commands can continue to
     +    integrate with the sparse index without the need to keep modifying the
     +    command used in the test.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     + ## Documentation/git-update-index.txt ##
     +@@ Documentation/git-update-index.txt: SYNOPSIS
     + 	     [--[no-]fsmonitor]
     + 	     [--really-refresh] [--unresolve] [--again | -g]
     + 	     [--info-only] [--index-info]
     ++	     [--force-full-index]
     + 	     [-z] [--stdin] [--index-version <n>]
     + 	     [--verbose]
     + 	     [--] [<file>...]
     +@@ Documentation/git-update-index.txt: time. Version 4 is relatively young (first released in 1.8.0 in
     + October 2012). Other Git implementations such as JGit and libgit2
     + may not support it yet.
     + 
     ++--force-full-index::
     ++	Force the command to operate on a full index, expanding a sparse
     ++	index if necessary.
     ++
     + -z::
     + 	Only meaningful with `--stdin` or `--index-info`; paths are
     + 	separated with NUL character instead of LF.
     +
     + ## builtin/update-index.c ##
     +@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     + 	int split_index = -1;
     + 	int force_write = 0;
     + 	int fsmonitor = -1;
     ++	int use_default_full_index = 0;
     + 	struct lock_file lock_file = LOCK_INIT;
     + 	struct parse_opt_ctx_t ctx;
     + 	strbuf_getline_fn getline_fn;
     +@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     + 		{OPTION_SET_INT, 0, "no-fsmonitor-valid", &mark_fsmonitor_only, NULL,
     + 			N_("clear fsmonitor valid bit"),
     + 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
     ++		OPT_SET_INT(0, "force-full-index", &use_default_full_index,
     ++			N_("run with full index explicitly required"), 1),
     + 		OPT_END()
     + 	};
     + 
     +@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     + 	if (newfd < 0)
     + 		lock_error = errno;
     + 
     ++	/*
     ++	 * If --force-full-index is set, the command should skip manually
     ++	 * setting `command_requires_full_index`.
     ++	 */
     ++	prepare_repo_settings(r);
     ++	if (!use_default_full_index)
     ++		r->settings.command_requires_full_index = 1;
     ++
     + 	entries = read_cache();
     + 	if (entries < 0)
     + 		die("cache corrupted");
     +
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is expanded and converted back' '
       	init_repos &&
       
       	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
      -		git -C sparse-index -c core.fsmonitor="" reset --hard &&
     -+		git -C sparse-index -c core.fsmonitor="" mv a b &&
     ++		git -C sparse-index -c core.fsmonitor="" update-index --force-full-index &&
       	test_region index convert_to_sparse trace2.txt &&
       	test_region index ensure_full_index trace2.txt
       '
 3:  d033c5e365f = 3:  c7e9d9f4e03 reset: expand test coverage for sparse checkouts
 4:  2d63a250637 = 4:  49813c8d9ed reset: integrate with sparse index
 5:  e919e6d3270 = 5:  78cd85d8dcc reset: make sparse-aware (except --mixed)
 6:  e7cda32efb6 ! 6:  5eaae0825af reset: make --mixed sparse-aware
     @@ builtin/reset.c: static int read_from_tree(const struct pathspec *pathspec,
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded' '
     - 	for ref in update-deep update-folder1 update-folder2 update-deep
     - 	do
     - 		echo >>sparse-index/README.md &&
     -+		ensure_not_expanded reset --mixed $ref
       		ensure_not_expanded reset --hard $ref || return 1
       	done &&
       
     ++	ensure_not_expanded reset --mixed base &&
       	ensure_not_expanded reset --hard update-deep &&
       	ensure_not_expanded reset --keep base &&
       	ensure_not_expanded reset --merge update-deep &&
 7:  8637ec1660e = 7:  aa963eefae7 unpack-trees: improve performance of next_cache_entry

-- 
gitgitgadget
