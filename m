Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68D0C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA78860F3A
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhJKUcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhJKUca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:32:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A309DC06161C
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e12so59916082wra.4
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xa3qONcj6w8N7PT2ZmUQK53RJ1vufRoiX8kHUeTGKu8=;
        b=VY6amkXo480iAK5s+GFzJJ3NvMxoQi+kPr1NvP3tukVRthT6Ja7EYMNc7QPEs5aZuJ
         toS0XQz72qDngIKDNvQ7hqhjfnvZajrpLvnr7gCiBBEvVKlPjoSz4TVK0VdTQnlbgloM
         YCuOteDivPcsUVCLAfLNSlAa1gs1qpqkerJOJhZP84GkNl3NAh79IG2gYWsbNSnleAVI
         lvq8tB9RoTWc9O2/XvMIyZFsI5ITWJGUktM5RsSb6SUaZVNi6FyhLYUTgVPayAMBEgO2
         oHObbeGJMI7RxtHo4J5kPkwojIsVlmENynkWajsM+hVJPY2NeueQxbC94JZxU8aJdHyz
         dGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xa3qONcj6w8N7PT2ZmUQK53RJ1vufRoiX8kHUeTGKu8=;
        b=qoYGN861kU5Dfhf6i+wP9KGr+OVVvPWnKqY7uxRms1mTvGq30VadQ7hsBsFN3ilSfK
         ZZNDBTeD7lahw9nW6XZyo0a3zDPU+lC9UhIeBsNArkc5LdHUU/dcXrMBqwNGqWBX1VEe
         Y16XscO/MjjUF9/mHVPNnNbBfInnF4rMfUbkLUmvTxmIDUCI8MDQGSU3VgZxBpWOwkD8
         CQ8FradgNcgvUQpjvxJDrpXW8fR9olXJXE0FQmwWXa9X7ol1j1TeT3c68TaYsmO9VwDA
         Pp9Htca93xNR7+QLjBAxbZ5q/rdPSOmLci6L9aGjSuRwpejQ7gq+ENQTYuPW1bleXAR+
         ex/A==
X-Gm-Message-State: AOAM533ZgQJK1NzSR5/J4lDDevNS30Y9ZCnixIUVuSsB2kWqDpoVl8cI
        9xs85W0gCnw2Pt03EH5f8K2CoZGKTw0=
X-Google-Smtp-Source: ABdhPJwtUhHZ3xefuzXkarWH2hgL3Ea1IP9qvbPRQsCAdvUOMXZn3FVCgqsummKSWiXbKmYOk6BY0w==
X-Received: by 2002:a05:6000:184c:: with SMTP id c12mr27132248wri.127.1633984228255;
        Mon, 11 Oct 2021 13:30:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g144sm508332wmg.5.2021.10.11.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 13:30:27 -0700 (PDT)
Message-Id: <00d14fb60bd952ac541627e0a1c56370036e3ca0.1633984223.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
References: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Oct 2021 20:30:21 +0000
Subject: [PATCH v4 7/8] reset: make --mixed sparse-aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
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
index 78476de18ea..f19c1b3e2eb 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -778,11 +778,28 @@ test_expect_success 'sparse-index is not expanded' '
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

