Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B42C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8470661058
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhJGVRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhJGVRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:17:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ADBC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 14:15:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v25so23045029wra.2
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ym5RYjvNvaThyBB6K1qa1gYSUUke0ke+OZpefrfVgCU=;
        b=a5NiIjMAHzkIhBtC4PStpUcAJFeBgncp+lIu58pv/FGNnJezXSaGD+E5mOJlgLmxKY
         yL6dVFINCsKM1186sax8e1U1LF1A4WDmFltiSruo2aG+QEclF7nijM10QFtxNwClwArp
         jvqZcUkFaJXMMTSzbkvD6wu+0lVXTHmFHJJnEKJeP/E+4ol2730/RMzNnsKREdvzCKOH
         baxfXjPA8xmy7COeQLrrtNQF2/ZaqNrQy2r6bchTItgtjkf5Ntla2ARGZObmmJXnWX61
         jsDI/Nbm5Oy0qHOk75XEq8FgRKHgPeMT6f5IbCD6wQ5uUGf/eVDrLgj4re1rzCA0Uvb2
         nvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ym5RYjvNvaThyBB6K1qa1gYSUUke0ke+OZpefrfVgCU=;
        b=Aw/OUI7HlUlkua1P7nJ9Am2dS+kl9D1YeYL8Ec3NGygDzquPBBFXuQmpUC2EylHJTE
         53OpCJuhEG4H0LMKn6WHecsPFQN9m6FLyEc05dehg8tmlIvA7sXeY+InlG5rWSmgn3kQ
         DcECoT2Wkt29AaIimqJ2GP1Y35mwTL725ThiiEszSkw47rXzj4Mc24/QXo8AQ8OTckg/
         HJqtqTZMO3DL91/YHceXKX/EcchtyNc7Jv78dglLdCoLgx5zTPhrNsqotjOj7PH7+2T/
         4bzSmHUFRefM/2YQG5tiLHUq71kHD+zYPnaFJvWFHCLEUeRhG++noYGuz57BkHMCfHex
         Xw2g==
X-Gm-Message-State: AOAM531HzyDKm5oDZc6G0n2LeO/Kf4kHBrWq786rAV5/qVFRPTpqWNLk
        wvFc98QPc7GG3Dn+p9L85wHdhCKIaVI=
X-Google-Smtp-Source: ABdhPJypIqt2WN50HK3VCURUGaKth6UeWtVZlZ/vnVHDwnijgJo7Rje5wwz8cffZkBXQxVPSnOLzgQ==
X-Received: by 2002:adf:bbd1:: with SMTP id z17mr8413762wrg.61.1633641345507;
        Thu, 07 Oct 2021 14:15:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm518776wrg.18.2021.10.07.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:15:45 -0700 (PDT)
Message-Id: <6ef8e4e31d39386e3a6fa1e6c24acd2c005fbd54.1633641339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 21:15:37 +0000
Subject: [PATCH v3 7/8] reset: make --mixed sparse-aware
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
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Remove the `ensure_full_index` guard on `read_from_tree` and update `git
reset --mixed` to ensure it can use sparse directory index entries wherever
possible. Sparse directory entries are reset use `diff_tree_oid`, which
requires `change` and `add_remove` functions to process the internal
contents of the sparse directory. The `recursive` diff option handles cases
in which `reset --mixed` must diff/merge files that are nested multiple
levels deep in a sparse directory.

The use of pathspecs with `git reset --mixed` introduces scenarios in which
internal contents of sparse directories may be matched by the pathspec. In
order to reset *all* files in the repo that may match the pathspec, the
following conditions on the pathspec require index expansion before
performing the reset:

* "magic" pathspecs
* wildcard pathspecs that do not match only in-cone files or entire sparse
  directories
* literal pathspecs matching something outside the sparse checkout
  definition

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c                          | 78 +++++++++++++++++++++++-
 t/t1092-sparse-checkout-compatibility.sh | 17 ++++++
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 0ac0de7dc97..60517e7e1d6 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -148,7 +148,9 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		 * If the file 1) corresponds to an existing index entry with
 		 * skip-worktree set, or 2) does not exist in the index but is
 		 * outside the sparse checkout definition, add a skip-worktree bit
-		 * to the new index entry.
+		 * to the new index entry. Note that a sparse index will be expanded
+		 * if this entry is outside the sparse cone - this is necessary
+		 * to properly construct the reset sparse directory.
 		 */
 		pos = cache_name_pos(one->path, strlen(one->path));
 		if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
@@ -166,6 +168,73 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 	}
 }
 
+static int pathspec_needs_expanded_index(const struct pathspec *pathspec)
+{
+	unsigned int i, pos;
+	int res = 0;
+	char *skip_worktree_seen = NULL;
+
+	/*
+	 * When using a magic pathspec, assume for the sake of simplicity that
+	 * the index needs to be expanded to match all matchable files.
+	 */
+	if (pathspec->magic)
+		return 1;
+
+	for (i = 0; i < pathspec->nr; i++) {
+		struct pathspec_item item = pathspec->items[i];
+
+		/*
+		 * If the pathspec item has a wildcard, the index should be expanded
+		 * if the pathspec has the possibility of matching a subset of entries inside
+		 * of a sparse directory (but not the entire directory).
+		 *
+		 * If the pathspec item is a literal path, the index only needs to be expanded
+		 * if a) the pathspec isn't in the sparse checkout cone (to make sure we don't
+		 * expand for in-cone files) and b) it doesn't match any sparse directories
+		 * (since we can reset whole sparse directories without expanding them).
+		 */
+		if (item.nowildcard_len < item.len) {
+			for (pos = 0; pos < active_nr; pos++) {
+				struct cache_entry *ce = active_cache[pos];
+
+				if (!S_ISSPARSEDIR(ce->ce_mode))
+					continue;
+
+				/*
+				 * If the pre-wildcard length is longer than the sparse
+				 * directory name and the sparse directory is the first
+				 * component of the pathspec, need to expand the index.
+				 */
+				if (item.nowildcard_len > ce_namelen(ce) &&
+				    !strncmp(item.original, ce->name, ce_namelen(ce))) {
+					res = 1;
+					break;
+				}
+
+				/*
+				 * If the pre-wildcard length is shorter than the sparse
+				 * directory and the pathspec does not match the whole
+				 * directory, need to expand the index.
+				 */
+				if (!strncmp(item.original, ce->name, item.nowildcard_len) &&
+				    wildmatch(item.original, ce->name, 0)) {
+					res = 1;
+					break;
+				}
+			}
+		} else if (!path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
+			   !matches_skip_worktree(pathspec, i, &skip_worktree_seen))
+			res = 1;
+
+		if (res > 0)
+			break;
+	}
+
+	free(skip_worktree_seen);
+	return res;
+}
+
 static int read_from_tree(const struct pathspec *pathspec,
 			  struct object_id *tree_oid,
 			  int intent_to_add)
@@ -178,9 +247,14 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &intent_to_add;
 	opt.flags.override_submodule_config = 1;
+	opt.flags.recursive = 1;
 	opt.repo = the_repository;
+	opt.change = diff_change;
+	opt.add_remove = diff_addremove;
+
+	if (pathspec->nr && the_index.sparse_index && pathspec_needs_expanded_index(pathspec))
+		ensure_full_index(&the_index);
 
-	ensure_full_index(&the_index);
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
 	diffcore_std(&opt);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 4ac93874cb2..c9343ff5b9c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -774,11 +774,28 @@ test_expect_success 'sparse-index is not expanded' '
 		ensure_not_expanded reset --hard $ref || return 1
 	done &&
 
+	ensure_not_expanded reset --mixed base &&
 	ensure_not_expanded reset --hard update-deep &&
 	ensure_not_expanded reset --keep base &&
 	ensure_not_expanded reset --merge update-deep &&
 	ensure_not_expanded reset --hard &&
 
+	ensure_not_expanded reset base -- deep/a &&
+	ensure_not_expanded reset base -- nonexistent-file &&
+	ensure_not_expanded reset deepest -- deep &&
+
+	# Although folder1 is outside the sparse definition, it exists as a
+	# directory entry in the index, so the pathspec will not force the
+	# index to be expanded.
+	ensure_not_expanded reset deepest -- folder1 &&
+	ensure_not_expanded reset deepest -- folder1/ &&
+
+	# Wildcard identifies only in-cone files, no index expansion
+	ensure_not_expanded reset deepest -- deep/\* &&
+
+	# Wildcard identifies only full sparse directories, no index expansion
+	ensure_not_expanded reset deepest -- folder\* &&
+
 	ensure_not_expanded checkout -f update-deep &&
 	test_config -C sparse-index pull.twohead ort &&
 	(
-- 
gitgitgadget

