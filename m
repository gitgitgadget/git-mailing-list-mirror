Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A99C433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbiCAU1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbiCAU0s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:26:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C857D8F634
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:24:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n14so22274457wrq.7
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 12:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lLJFoJr581XS1Vf5pgj6Oq3aJj6KyBnKtN0B6INs+94=;
        b=V6GO4FsPSiyi7cBrNRxd1Re5FfCy3//OEsgr12AzkJvJ5Ir+ZYlei+59LRsNGLMPBY
         Za+euVqIGAWkG2e4znKuY9i4P5uYxm1r32Sdl+E0rB9dBEH4xszZh76601afFEQJ8cf0
         xPZ0xrWd8nglNQRAmsruZfEHRC71Bp99iuAUwfcOzBBA/eBysTkONzekK2/L6gM3emxI
         2yx0GxrKQcP5PpQXr/St9EVTmaqZx15TSK7w52akLgpy08okredtHHMf33SJQvUBPx+7
         zWOqhEtCNWgTiwrR57mfN7oXO43Yh461h1kP0ujedspOuPatVzchVH802FLmb6/1WGOK
         X8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lLJFoJr581XS1Vf5pgj6Oq3aJj6KyBnKtN0B6INs+94=;
        b=0qq9TcHorIGaXeziUR9lzhSlpiSQ+jjX3KEkFeHgEqOJSlhZA+z63UF1bCzBkdj2es
         4nRk0u5h/AiNy78bhe8TuYJoI1Q2GexJRmYzsyEdznekzjAwnm1Rp04BAD6PPeWKf2F/
         LqiwZUrJVAhLiA8WTSaEA9H63DC2CeDYGgTAkzUvyFznE6Fa/lCfWOPh5oLKwq6VHF6g
         LjHkJJr0L2v2w4izVuksSwwKa+pvKkmGCBXVCPz+JuZmRl98zmKTOBXj3vgZ1Tk++Qxi
         j6aWOnHg3DSi01Z2YLhY7Kyfz/HCaNKGd2u1PrutSTWRtOTcBZbdkt298EyCeSJt+kQf
         0mFQ==
X-Gm-Message-State: AOAM53208dbE8L7iwqPj2ehza6VTgS8LDb9WDGPzjreB1ECkd98tgjug
        114P9tThIaMKByUWxq+iWqMqgkMQXLk=
X-Google-Smtp-Source: ABdhPJx7a7hz5UebDtCmxFYI+VNDPXgqp50EFeUpclDt9+pw0aZLZXI+a0FGwPS01x8AqufcZAk3sQ==
X-Received: by 2002:adf:d1e9:0:b0:1ea:7d0f:69c7 with SMTP id g9-20020adfd1e9000000b001ea7d0f69c7mr21451857wrd.373.1646166278380;
        Tue, 01 Mar 2022 12:24:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9-20020adffcc9000000b001e9e8163a46sm20730877wrs.54.2022.03.01.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:24:38 -0800 (PST)
Message-Id: <71bec3ddad1a086ba9b40ce6b69ad0ad9371cc75.1646166271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
        <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 20:24:30 +0000
Subject: [PATCH v3 7/8] read-tree: make two-way merge sparse-aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable two-way merge with 'git read-tree' without expanding the sparse
index. When in a sparse index, a two-way merge will trivially succeed as
long as there are not changes to the same sparse directory in multiple trees
(i.e., sparse directory-level "edit-edit" conflicts). If there are such
conflicts, the merge will fail despite the possibility that individual files
could merge cleanly.

In order to resolve these "edit-edit" conflicts, "conflicted" sparse
directories are - rather than rejected - merged by traversing their
associated trees by OID. For each child of the sparse directory:

1. Files are merged as normal (see Documentation/git-read-tree.txt for
   details).
2. Subdirectories are treated as sparse directories and merged in
   'twoway_merge'. If there are no conflicts, they are merged according to
   the rules in Documentation/git-read-tree.txt; otherwise, the subdirectory
   is recursively traversed and merged.

This process allows sparse directories to be individually merged at the
necessary depth *without* expanding a full index.

The 't/t1092-sparse-checkout-compatibility.sh' test 'read-tree --merge with
edit/edit conflicts in sparse directories' tests two-way merges with 1)
changes inside sparse directories that do not conflict and 2) changes that
do conflict (with the correct file(s) reported in the error message).
Additionally, add two-way merge cases to 'sparse index is not expanded:
read-tree' to confirm that the index is not expanded regardless of whether
edit/edit conflicts are present in a sparse directory.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                      |  5 --
 t/t1092-sparse-checkout-compatibility.sh |  4 +-
 unpack-trees.c                           | 75 ++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ec6d038242a..9227f07ab15 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -229,11 +229,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			opts.fn = opts.prefix ? bind_merge : oneway_merge;
 			break;
 		case 2:
-			/*
-			 * TODO: update twoway_merge to handle edit/edit conflicts in
-			 * sparse directories.
-			 */
-			ensure_full_index(&the_index);
 			opts.fn = twoway_merge;
 			opts.initial_checkout = is_cache_unborn();
 			break;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d98558f3238..61dc2ea777c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1413,7 +1413,9 @@ test_expect_success 'sparse index is not expanded: read-tree' '
 	init_repos &&
 
 	ensure_not_expanded checkout -b test-branch update-folder1 &&
-	for MERGE_TREES in "update-folder2"
+	for MERGE_TREES in "base update-folder2" \
+			   "base rename-base" \
+			   "update-folder2"
 	do
 		ensure_not_expanded read-tree -mu $MERGE_TREES &&
 		ensure_not_expanded reset --hard || return 1
diff --git a/unpack-trees.c b/unpack-trees.c
index f3667d85ec5..0c2a678cd6d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1360,6 +1360,42 @@ static int is_sparse_directory_entry(struct cache_entry *ce,
 	return sparse_dir_matches_path(ce, info, name);
 }
 
+static int unpack_sparse_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
+{
+	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
+	struct unpack_trees_options *o = info->data;
+	int ret;
+
+	assert(o->merge);
+
+	/*
+	 * Unlike in 'unpack_callback', where src[0] is derived from the index when
+	 * merging, src[0] is a transient cache entry derived from the first tree
+	 * provided. Create the temporary entry as if it came from a non-sparse index.
+	 */
+	if (!is_null_oid(&names[0].oid)) {
+		src[0] = create_ce_entry(info, &names[0], 0,
+					&o->result, 1,
+					dirmask & (1ul << 0));
+		src[0]->ce_flags |= (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
+	}
+
+	/*
+	 * 'unpack_single_entry' assumes that src[0] is derived directly from
+	 * the index, rather than from an entry in 'names'. This is *not* true when
+	 * merging a sparse directory, in which case names[0] is the "index" source
+	 * entry. To match the expectations of 'unpack_single_entry', shift past the
+	 * "index" tree (i.e., names[0]) and adjust 'names', 'n', 'mask', and
+	 * 'dirmask' accordingly.
+	 */
+	ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info);
+
+	if (src[0])
+		discard_cache_entry(src[0]);
+
+	return ret >= 0 ? mask : -1;
+}
+
 /*
  * Note that traverse_by_cache_tree() duplicates some logic in this function
  * without actually calling it. If you change the logic here you may need to
@@ -2472,6 +2508,37 @@ static int merged_entry(const struct cache_entry *ce,
 	return 1;
 }
 
+static int merged_sparse_dir(const struct cache_entry * const *src, int n,
+			     struct unpack_trees_options *o)
+{
+	struct tree_desc t[MAX_UNPACK_TREES + 1];
+	void * tree_bufs[MAX_UNPACK_TREES + 1];
+	struct traverse_info info;
+	int i, ret;
+
+	/*
+	 * Create the tree traversal information for traversing into *only* the
+	 * sparse directory.
+	 */
+	setup_traverse_info(&info, src[0]->name);
+	info.fn = unpack_sparse_callback;
+	info.data = o;
+	info.show_all_errors = o->show_all_errors;
+	info.pathspec = o->pathspec;
+
+	/* Get the tree descriptors of the sparse directory in each of the merging trees */
+	for (i = 0; i < n; i++)
+		tree_bufs[i] = fill_tree_descriptor(o->src_index->repo, &t[i],
+						    src[i] && !is_null_oid(&src[i]->oid) ? &src[i]->oid : NULL);
+
+	ret = traverse_trees(o->src_index, n, t, &info);
+
+	for (i = 0; i < n; i++)
+		free(tree_bufs[i]);
+
+	return ret;
+}
+
 static int deleted_entry(const struct cache_entry *ce,
 			 const struct cache_entry *old,
 			 struct unpack_trees_options *o)
@@ -2742,6 +2809,14 @@ int twoway_merge(const struct cache_entry * const *src,
 			 * reject the merge instead.
 			 */
 			return merged_entry(newtree, current, o);
+		} else if (S_ISSPARSEDIR(current->ce_mode)) {
+			/*
+			 * The sparse directories differ, but we don't know whether that's
+			 * because of two different files in the directory being modified
+			 * (can be trivially merged) or if there is a real file conflict.
+			 * Merge the sparse directory by OID to compare file-by-file.
+			 */
+			return merged_sparse_dir(src, 3, o);
 		} else
 			return reject_merge(current, o);
 	}
-- 
gitgitgadget

