Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D302C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3110D60F56
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbhJ0OmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbhJ0Olz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:41:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B92EC061348
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g7so3495580wrb.2
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J5gycgtHpviMm7267zW7Aw7f2/Uvmyd+O1rDc19cPtc=;
        b=hrDEWFKve1dsIAkqtQUCgxyXiSPQKuqj9DoA4vgpViroeWvf0lpLBrtjtLfJCsrLFS
         JGiqfkiBumZ1DeBofwdjN0kMI63tryTxu4NTU/vbUfgo1p4HvTtlGoi2JFqVW51IBryb
         BPBmDC4bP5lRFQEwZ2eIBJUhcOnZszkDDZNt9wNa8NJsM0hZrfqKAlWwVYxBBNi5iVAA
         AbHLqmy27Vi8Ihe6teGBjleaBqxuPfnDjidfUWPmPAM3eClBK3oQygKu1FVrP8+IVmNQ
         CZKMcR0EznKcaYhY1kesx65Kao3bnlE3R3bac2QBHO/pM343eX3RO1Tqv/sUMcex7PJa
         gB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J5gycgtHpviMm7267zW7Aw7f2/Uvmyd+O1rDc19cPtc=;
        b=fYABBHwUe0CoMz4r+rDmeKXclpy0AT0mso3HYsVZrmaSC6efxt+zX6sphDYjiBfe0d
         X0+Nhzgt1C8I33K9gp5jIb0xmN+VMF1Ws/4bIwgjwwmOWFJBpuKzEPvJGILXopQBsLQI
         enBd1kYVYUqsJ3N+x7+MRa/XRXwneiSQTl4gkLiQfmUG5AQHE8Sb8n0IFJWW3rFiduzB
         beHo8qmU5LxNWj7opUvEbjkrrA5wmqMl4xsf5EP6+p+LuJF75z0BTAdjSKF54jOnDjR8
         zfotlcNJDWWZClzBTTsyeCDTBOoI89Ug4Y6wzr3Rf+85CcaIw1cCL4ysqFw+TPy59gfi
         QAQg==
X-Gm-Message-State: AOAM533ixoEa6045HtdwoC4Wi21ZjpN/6d7S9WZ9XIm5mA5+RKTdvLaA
        S4F8RHMgvhDl8jR4nO6N53IC7N5ZhAw=
X-Google-Smtp-Source: ABdhPJziAWBEvS8EhBoVkZxiZTYfD6ifdfYC2uRpiI2zxSdjaHw2s69+LgwZp22e5kwke3LPVI60Ag==
X-Received: by 2002:adf:f902:: with SMTP id b2mr41287053wrr.265.1635345568924;
        Wed, 27 Oct 2021 07:39:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm49423wrv.80.2021.10.27.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:39:28 -0700 (PDT)
Message-Id: <a9135a5ed64f031fa2b46baabf179611dde60e71.1635345563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
References: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
        <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:39:22 +0000
Subject: [PATCH v5 7/8] reset: make --mixed sparse-aware
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
index 5664ff8f039..44d5e11c762 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -781,11 +781,28 @@ test_expect_success 'sparse-index is not expanded' '
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

