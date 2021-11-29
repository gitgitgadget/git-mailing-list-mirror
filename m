Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF124C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352735AbhK2TjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbhK2ThB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:37:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DACC09B18F
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so12740768wmd.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bCfMr+Jv2pEDwIaUjIBgrO8Hy49HM0OPtV6mD7B78o4=;
        b=CoIH4m1Mt5xTtRCFqpG3d39sPfz9fRibVgEJZeBC95zzoSegeb+cJQWnteAuvupmTu
         F9/n1pqNRFbRQ4hky2KsTtZvQqGQaMvb8C/zztMRkMp7Xonpw/3aJnhLD2R/vtI06f2D
         aVZBhnKLHshBZeeO+1LoGEKrzy59bMP3omQzH6qbcOYJMG1XmgW9QcCzbZSDUk6UyYL2
         DVThhiafULbOe1gynD2HLG0dIzHZtwkX6jAmN+2VCHeizewMoQBRJWgJTYlgElCM25Vu
         ynnHPfGup852ZuM5sCM7XE/fI5P/UaOaqMv1GSM6KuLmILessziOvpO3XB8pexCbLarS
         MtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bCfMr+Jv2pEDwIaUjIBgrO8Hy49HM0OPtV6mD7B78o4=;
        b=cjmve4rhZhReOGmYOqWcBATdm0l03XRTOgehhYp4xjpgrHqdnX0QgiuTEdrhVzKywE
         MQcUwYEVaBTvnNZWXgFMYcCS+WBIG0QBmWUJCPDHLhuFuzLtRYU+c64cBgFalJLUQZCJ
         GTWKVjl3tjcF4lZu4C+GN9LLFNioMKofTsN+sm1fpogCFWe7T7KTaCyUN63h9YwUuPaF
         H6noJ49IUw0cD9aX+iDxZD8hIGrQaoI0N58NRT/i6YXew64bxvyBY3PX5tq/yoFUeS8s
         3QpS8VqpRzkGyxNlcFCV/6/cGJ8yzQJekJnnHAeqa8I/yfmNqnUiV9L5SFuGgAMl/8M8
         HPUQ==
X-Gm-Message-State: AOAM532Xg4h+sGGhM9eWV8+WO58AEsgWQLrRHmrg9B+Bf7J0NQbkR5Mh
        1tGNZaaqQsaW1mrPOP2q4wr3QpkYi04=
X-Google-Smtp-Source: ABdhPJx3P11C2Iw3ruBK72tJUOzCuyPYYm6Eehd8Up8PpPa/osqD+4jTALeWVyAHY1A0WzG4aIioaQ==
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr37739048wml.0.1638201169740;
        Mon, 29 Nov 2021 07:52:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j40sm17271478wms.16.2021.11.29.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:52:49 -0800 (PST)
Message-Id: <822d7344587f698e73abba1ca726c3a905f7b403.1638201164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
        <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:52:42 +0000
Subject: [PATCH v6 7/8] reset: make --mixed sparse-aware
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
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Remove the `ensure_full_index` guard on `read_from_tree` and update `git
reset --mixed` to ensure it can use sparse directory index entries wherever
possible. Sparse directory entries are reset using `diff_tree_oid`, which
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
 builtin/reset.c                          | 87 +++++++++++++++++++++++-
 t/t1092-sparse-checkout-compatibility.sh | 17 +++++
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 0ac0de7dc97..dcb79fb43a3 100644
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
@@ -166,6 +168,82 @@ static void update_index_from_diff(struct diff_queue_struct *q,
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
+			/*
+			 * Special case: if the pattern is a path inside the cone
+			 * followed by only wildcards, the pattern cannot match
+			 * partial sparse directories, so we don't expand the index.
+			 */
+			if (path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
+			    strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len)
+				continue;
+
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
@@ -178,9 +256,14 @@ static int read_from_tree(const struct pathspec *pathspec,
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
index 871cc3fcb8d..77e302a0ef3 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -795,11 +795,28 @@ test_expect_success 'sparse-index is not expanded' '
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

