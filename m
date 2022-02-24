Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CFFC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiBXWf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiBXWfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:35:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9921E016F
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n14so1790733wrq.7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IV3GAE1fh4gMstca/A+CoV4yUbx8Ot6pYCLIyCIHKBQ=;
        b=BTulfhxGYJ5zzwuVnnXBUCe5cQWRdfasXsd0Ennw4uNUyt1+M6c0iNzR6YcyqeWimz
         5OSWfSHp/VPXeVc5MBEMKMQbXakYWgbWcfu67/Nupo9TYG2WT9Hxgir1ZoJVbRcSVnaI
         X8lR+2Tv5aGCa80ab3IUdF15t4Lpeua0IyjHAh9t72IJVwJyGumANm8RsdALbtju7YGK
         ObINCF71kvFO2hXUOW2ApslC/0Bu91Yg7xqd2wyu77CKpSv2/fp0Yy3bCZ0AG0bQfdxg
         ZEndm0pmKR0H8VVyPkgP4C/R/IWjA2UUa/RqvA+6UU1EYBgsCDNbZ3z1V33uAi3D/ZMP
         F8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IV3GAE1fh4gMstca/A+CoV4yUbx8Ot6pYCLIyCIHKBQ=;
        b=1Pyoew4JrI1xmc0w7uiGOlo96Si1IZeZvgfFz9blV55klGjvfYrZqQ7SmgGkOq/Erp
         eHGhtLYb+3ykwOAmA2ilwul72fvpUGVIcp4xG3+gFGAlKu9U2SHEIpCD4xyZsEbznTAa
         nEspksyv4FMCy0G0+7kV6rRUS1Zld0qdeIByGl+XPa5D2nmbubxepBiimmQroynjCtk5
         f2pM7MgOfstqvRXg0gh6nSn2eg2nPMRMnlWmW69w7eWq0E6sqBtkwHWXg4GD7WdZArkK
         bY7hUQYG+DeQaLze3t64C487rgZp2lH2USxTyKtDu55DE9UVEp9IGpcl9VGZyinzdDHD
         S8Cw==
X-Gm-Message-State: AOAM5318nc6cXbW8zBhBBB/WkTXkwnC8/u/ekkKd5EKrKb+7sHznYpQY
        xueB30aJNyzFGVu598RoHX9sZugefMk=
X-Google-Smtp-Source: ABdhPJws5JceyMyghIrX8TGfecDi1ECJRExhL7wnp46N79NjQbQik6pjCbdNWTjYZ85KacwjuX8zHQ==
X-Received: by 2002:adf:fd4d:0:b0:1ea:9109:dae6 with SMTP id h13-20020adffd4d000000b001ea9109dae6mr3874808wrs.293.1645742079671;
        Thu, 24 Feb 2022 14:34:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d5545000000b001ed9d3f521csm494698wrw.113.2022.02.24.14.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:34:39 -0800 (PST)
Message-Id: <94c2aad2f93f61d1e7731017c720faebb7cd2467.1645742073.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
        <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:34:32 +0000
Subject: [PATCH v2 6/7] read-tree: make two-way merge sparse-aware
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

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                      |  5 --
 t/t1092-sparse-checkout-compatibility.sh |  3 +-
 unpack-trees.c                           | 75 ++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index a7b7f822281..5a421de2629 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -225,11 +225,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
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
index a404be0a10f..d6f19682d65 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1411,7 +1411,8 @@ test_expect_success 'sparse index is not expanded: read-tree' '
 	init_repos &&
 
 	ensure_not_expanded checkout -b test-branch update-folder1 &&
-	for MERGE_TREES in "update-folder2"
+	for MERGE_TREES in "update-folder2" \
+			   "base update-folder2"
 	do
 		ensure_not_expanded read-tree -mu $MERGE_TREES &&
 		ensure_not_expanded reset --hard HEAD || return 1
diff --git a/unpack-trees.c b/unpack-trees.c
index dba122a02bb..a4ace53904e 100644
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
@@ -2464,6 +2500,37 @@ static int merged_entry(const struct cache_entry *ce,
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
@@ -2734,6 +2801,14 @@ int twoway_merge(const struct cache_entry * const *src,
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

