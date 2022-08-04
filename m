Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5F9C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbiHDUq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiHDUqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:46:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B7F6D55B
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:46:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m41-20020a05600c3b2900b003a4e094256eso444566wms.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=QaEQ55YjDSDMpXjNbl4+7WBqnp7hKCe7lLnFy8v2vag=;
        b=JFHsoOdqHYredF+xI2NrLoRkecm+h0WCHK6aeomLGOnX3m8p2LyRR+dEtSB2MIMh87
         Z3BoLoO6m4xGE5usccFdaVkFsaFrLbnSnaqz6x9hKFFpaDhlyZ8nh9XGTgACS7vyxY6n
         5HWWV/b8hvMz6UN+HY545htiQfyp9CHDZwh8H8u9Xe1Vz166mgHP5EtPkCZr2/UYbyu7
         ftQnMLSIP2TxjCGH9VI7MRPhi8U7u876NfDVMGNezv1NLIPwZKj1F8wbP+oL7muOIGiN
         KVMw9tVMZCV/Xe3+ujQ1BqQFK9c/kIi/HkTaP8f5PLdKzEXeVzUWHZbH6kOTo9g9Mcn5
         PdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=QaEQ55YjDSDMpXjNbl4+7WBqnp7hKCe7lLnFy8v2vag=;
        b=4l19qmtT+SmKCxcqzfC/R4jzBRcOVUhDBfVxO5XqOJ8N4KCzjAeno/3e4Ghk3C90N6
         4+2QaJ38FAMl3+S3bNIt0oajJw0DqZ6eDLfK7BEOIsqdbbFEInlGxDuhBgC1YUscNgxu
         CwmGbmlNYozWs4nr9kxot7HVNuopP43LXjsAfzAhshuiu8ZNuJ+22BBsJlMXKjVO1zDX
         glnMny92WYi1m1Ha8335n+uWSiVjhSQIMUUNTjzkzqf2Y2Xgk0T2CaW3AkoqKrE+lKKl
         p1gtQLutEpv5rRSlaVYkQXlCKy7ybWSxlBHWPTCPzFDNXjV6T+gELLRvzpkgBtW91qT7
         W3AQ==
X-Gm-Message-State: ACgBeo31cJ1AiQfy9UewGcrUmW7qPAscGZ7Lzap+u0Hrbd+YxGLXYjfB
        AvSrSBPsFp9GMFyTI+9NUyTmLpVLGHk=
X-Google-Smtp-Source: AA6agR7oZ6XSaXeKYR3fOkqs+wUGQshYl+Yv/3EjrKXQEXiPHZIYI3EdQKmgJMxqVYLv4vJF0/50Uw==
X-Received: by 2002:a05:600c:1515:b0:3a5:1690:557b with SMTP id b21-20020a05600c151500b003a51690557bmr1237185wmg.147.1659645973346;
        Thu, 04 Aug 2022 13:46:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4fc2000000b0021e8d205705sm2196772wrw.51.2022.08.04.13.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 13:46:12 -0700 (PDT)
Message-Id: <016971a67112efe2d15fe7908e86c5d2631f8e66.1659645967.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 20:46:07 +0000
Subject: [PATCH 4/4] unpack-trees: handle missing sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

If a sparse directory does not exist in the index, unpack it at the
directory level rather than recursing into it an unpacking its contents
file-by-file. This helps keep the sparse index as collapsed as possible in
cases such as 'git reset --hard' restoring a sparse directory.

A directory is determined to be truly non-existent in the index (rather than
the parent of existing index entries), if 1) its path is outside the sparse
cone and 2) there are no children of the directory in the index. This check
is performed by 'missing_dir_is_sparse()' in 'unpack_single_entry()'. If the
directory is a missing sparse dir, 'unpack_single_entry()'  will proceed
with unpacking it. This determination is also propagated back up to
'unpack_callback()' via 'is_missing_sparse_dir' to prevent further tree
traversal into the unpacked directory.

Reported-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 17 +++++
 unpack-trees.c                           | 88 +++++++++++++++++++++---
 2 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 99a1425a929..eb5edebfa5d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -695,6 +695,23 @@ test_expect_success 'reset with wildcard pathspec' '
 	test_all_match git ls-files -s -- folder1
 '
 
+test_expect_success 'reset hard with removed sparse dir' '
+	init_repos &&
+
+	test_all_match git rm -r --sparse folder1 &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard &&
+	test_all_match git status --porcelain=v2 &&
+
+	cat >expect <<-\EOF &&
+	folder1/
+	EOF
+
+	git -C sparse-index ls-files --sparse folder1 >out &&
+	test_cmp expect out
+'
+
 test_expect_success 'update-index modify outside sparse definition' '
 	init_repos &&
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 8a454e03bff..aa62cef20fe 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1069,6 +1069,53 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	return ce;
 }
 
+/*
+ * Determine whether the path specified corresponds to a sparse directory
+ * completely missing from the index. This function is assumed to only be
+ * called when the named path isn't already in the index.
+ */
+static int missing_dir_is_sparse(const struct traverse_info *info,
+				 const struct name_entry *p)
+{
+	int res, pos;
+	struct strbuf dirpath = STRBUF_INIT;
+	struct unpack_trees_options *o = info->data;
+
+	/*
+	 * First, check whether the path is in the sparse cone. If it is,
+	 * then this directory shouldn't be sparse.
+	 */
+	strbuf_add(&dirpath, info->traverse_path, info->pathlen);
+	strbuf_add(&dirpath, p->path, p->pathlen);
+	strbuf_addch(&dirpath, '/');
+	if (path_in_cone_mode_sparse_checkout(dirpath.buf, o->src_index)) {
+		res = 0;
+		goto cleanup;
+	}
+
+	/*
+	 * Given that the directory is not inside the sparse cone, it could be
+	 * (partially) expanded in the index. If child entries exist, the path
+	 * is not a missing sparse directory.
+	 */
+	pos = index_name_pos_sparse(o->src_index, dirpath.buf, dirpath.len);
+	if (pos >= 0)
+		BUG("cache entry '%s%s' shouldn't exist in the index",
+		    info->traverse_path, p->path);
+
+	pos = -pos - 1;
+	if (pos >= o->src_index->cache_nr) {
+		res = 1;
+		goto cleanup;
+	}
+
+	res = strncmp(o->src_index->cache[pos]->name, dirpath.buf, dirpath.len);
+
+cleanup:
+	strbuf_release(&dirpath);
+	return res;
+}
+
 /*
  * Note that traverse_by_cache_tree() duplicates some logic in this function
  * without actually calling it. If you change the logic here you may need to
@@ -1078,21 +1125,40 @@ static int unpack_single_entry(int n, unsigned long mask,
 			       unsigned long dirmask,
 			       struct cache_entry **src,
 			       const struct name_entry *names,
-			       const struct traverse_info *info)
+			       const struct traverse_info *info,
+			       int *is_missing_sparse_dir)
 {
 	int i;
 	struct unpack_trees_options *o = info->data;
 	unsigned long conflicts = info->df_conflicts | dirmask;
+	const struct name_entry *p = names;
 
-	if (mask == dirmask && !src[0])
-		return 0;
+	*is_missing_sparse_dir = 0;
+	if (mask == dirmask && !src[0]) {
+		/*
+		 * If the directory is completely missing from the index but
+		 * would otherwise be a sparse directory, we should unpack it.
+		 * If not, we'll return and continue recursively traversing the
+		 * tree.
+		 */
+		if (!o->src_index->sparse_index)
+			return 0;
+
+		/* Find first entry with a real name (we could use "mask" too) */
+		while (!p->mode)
+			p++;
+
+		*is_missing_sparse_dir = missing_dir_is_sparse(info, p);
+		if (!*is_missing_sparse_dir)
+			return 0;
+	}
 
 	/*
-	 * When we have a sparse directory entry for src[0],
-	 * then this isn't necessarily a directory-file conflict.
+	 * When we are unpacking a sparse directory, then this isn't necessarily
+	 * a directory-file conflict.
 	 */
-	if (mask == dirmask && src[0] &&
-	    S_ISSPARSEDIR(src[0]->ce_mode))
+	if (mask == dirmask &&
+	    (*is_missing_sparse_dir || (src[0] && S_ISSPARSEDIR(src[0]->ce_mode))))
 		conflicts = 0;
 
 	/*
@@ -1352,7 +1418,7 @@ static int unpack_sparse_callback(int n, unsigned long mask, unsigned long dirma
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
-	int ret;
+	int ret, is_missing_sparse_dir;
 
 	assert(o->merge);
 
@@ -1376,7 +1442,7 @@ static int unpack_sparse_callback(int n, unsigned long mask, unsigned long dirma
 	 * "index" tree (i.e., names[0]) and adjust 'names', 'n', 'mask', and
 	 * 'dirmask' accordingly.
 	 */
-	ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info);
+	ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info, &is_missing_sparse_dir);
 
 	if (src[0])
 		discard_cache_entry(src[0]);
@@ -1394,6 +1460,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
 	const struct name_entry *p = names;
+	int is_missing_sparse_dir;
 
 	/* Find first entry with a real name (we could use "mask" too) */
 	while (!p->mode)
@@ -1440,7 +1507,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 	}
 
-	if (unpack_single_entry(n, mask, dirmask, src, names, info) < 0)
+	if (unpack_single_entry(n, mask, dirmask, src, names, info, &is_missing_sparse_dir))
 		return -1;
 
 	if (o->merge && src[0]) {
@@ -1478,6 +1545,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 
 		if (!is_sparse_directory_entry(src[0], names, info) &&
+		    !is_missing_sparse_dir &&
 		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
 						    names, info) < 0) {
 			return -1;
-- 
gitgitgadget
