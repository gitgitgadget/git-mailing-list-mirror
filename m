Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6779C25B08
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 19:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiHHTIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiHHTIC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 15:08:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE5C193F7
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 12:08:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a11so5242127wmq.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=2u8CcRF4Z7axc+JNvIlGvWV5aPCC/5ShJgcJ/COMXgM=;
        b=KTOz8NgioZR/jQb07CbklPS2r6TVB7YnrECoWbPqJnvFNKEBkrOfH2RU9a+/omRO7a
         Sm2T0Jr1uqcydpPJ+aP6qxlRxGg4wlNYA/IaZMwSsdIyUaaq6vpjQ7xYc1Ebonkykirh
         byUhg1wAheuU0YCaY5VROrZWXmdY2Bt46+9+sYULR7nGs83D0CjC4PrlTNYY3lVr3Zv8
         EhzdyP33Ms2n+KR7Qrr44J2TvoaQ8iibDgUSQhAhPI+/dPLIov9Wl/vZ3O0jTGrdZ/N/
         fVsNQsbShMu2CAruIHmNnaM0grhKBShvFuqn3VEL/4cKlfXbL/8ZGIiC61HLdatwJWiX
         0gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=2u8CcRF4Z7axc+JNvIlGvWV5aPCC/5ShJgcJ/COMXgM=;
        b=Iuj4y1G3v8bwKcugdtKpNcTTHfw/rkdvDd44xyKIaT8ULu3lgjlY/8pzRbdFbFg21H
         WskSIYeuggMGtLyia/U7NbXeQhLrGyq+lNnIZuKJhSTlY38JHPh0gOR88u0EiFbZDZML
         8a5KDAWv2citP7BUpLDXte/eztddqcYD8g6Sdf2VWGskaetqQlIJL/+ueJ/N2bLMvWSP
         /Y146isbIJ1uFxcxqzMANjVacE/+xb5jA5bZw9X8pQnp+1WjJbKewyGZKAEBlBZJXNxA
         LnqNrdp/Y2uAHz4L+l6Lq17uaSeC05DX8QQZaI96hsYHaX98teL/9DtWLRmOghGJmzm6
         8OeQ==
X-Gm-Message-State: ACgBeo3pQJ8XxEgjeFZA1VyPs+yLKn+v6zwKYdpA8Br1fAknHanmhHaI
        Ss+DWjLH0LPzSnOO/pZ++vyxMzGSZAg=
X-Google-Smtp-Source: AA6agR7um7wHwYJtKTG0hEpcOAfsFll3Oyoqg3fffZO+YcIi0CafW8g5yYg3LEV1WbBq56Ed/VfRaA==
X-Received: by 2002:a1c:ed05:0:b0:3a5:3af:f5c3 with SMTP id l5-20020a1ced05000000b003a503aff5c3mr13619608wmh.52.1659985678555;
        Mon, 08 Aug 2022 12:07:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c240b00b003a331c6bffdsm14767461wmp.47.2022.08.08.12.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:07:57 -0700 (PDT)
Message-Id: <010d5e51595bd3f77b6d3606298a2b436c66ecc6.1659985672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
References: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
        <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 19:07:52 +0000
Subject: [PATCH v3 4/4] unpack-trees: unpack new trees as sparse directories
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

If 'unpack_single_entry()' is unpacking a new directory tree (that is, one
not already present in the index) into a sparse index, unpack the tree as a
sparse directory rather than traversing its contents and unpacking each file
individually. This helps keep the sparse index as collapsed as possible in
cases such as 'git reset --hard' restoring a outside-of-cone directory
removed with 'git rm -r --sparse'.

Without this patch, 'unpack_single_entry()' will only unpack a directory
into the index as a sparse directory (rather than traversing into it and
unpacking its files one-by-one) if an entry with the same name already
exists in the index. This patch allows sparse directory unpacking without a
matching index entry when the following conditions are met:

1. the directory's path is outside the sparse cone, and
2. there are no children of the directory in the index

If a directory meets these requirements (as determined by
'is_new_sparse_dir()'), 'unpack_single_entry()' unpacks the sparse directory
index entry and propagates the decision back up to 'unpack_callback()' to
prevent unnecessary tree traversal into the unpacked directory.

Reported-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh |  17 ++++
 unpack-trees.c                           | 106 ++++++++++++++++++++---
 2 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 99a1425a929..3588dd7b102 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -695,6 +695,23 @@ test_expect_success 'reset with wildcard pathspec' '
 	test_all_match git ls-files -s -- folder1
 '
 
+test_expect_success 'reset hard with removed sparse dir' '
+	init_repos &&
+
+	run_on_all git rm -r --sparse folder1 &&
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
index 8a454e03bff..90b92114be8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1069,6 +1069,67 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	return ce;
 }
 
+/*
+ * Determine whether the path specified by 'p' should be unpacked as a new
+ * sparse directory in a sparse index. A new sparse directory 'A/':
+ * - must be outside the sparse cone.
+ * - must not already be in the index (i.e., no index entry with name 'A/'
+ *   exists).
+ * - must not have any child entries in the index (i.e., no index entry
+ *   'A/<something>' exists).
+ * If 'p' meets the above requirements, return 1; otherwise, return 0.
+ */
+static int entry_is_new_sparse_dir(const struct traverse_info *info,
+				   const struct name_entry *p)
+{
+	int res, pos;
+	struct strbuf dirpath = STRBUF_INIT;
+	struct unpack_trees_options *o = info->data;
+
+	if (!S_ISDIR(p->mode))
+		return 0;
+
+	/*
+	 * If the path is inside the sparse cone, it can't be a sparse directory.
+	 */
+	strbuf_add(&dirpath, info->traverse_path, info->pathlen);
+	strbuf_add(&dirpath, p->path, p->pathlen);
+	strbuf_addch(&dirpath, '/');
+	if (path_in_cone_mode_sparse_checkout(dirpath.buf, o->src_index)) {
+		res = 0;
+		goto cleanup;
+	}
+
+	pos = index_name_pos_sparse(o->src_index, dirpath.buf, dirpath.len);
+	if (pos >= 0) {
+		/* Path is already in the index, not a new sparse dir */
+		res = 0;
+		goto cleanup;
+	}
+
+	/* Where would this sparse dir be inserted into the index? */
+	pos = -pos - 1;
+	if (pos >= o->src_index->cache_nr) {
+		/*
+		 * Sparse dir would be inserted at the end of the index, so we
+		 * know it has no child entries.
+		 */
+		res = 1;
+		goto cleanup;
+	}
+
+	/*
+	 * If the dir has child entries in the index, the first would be at the
+	 * position the sparse directory would be inserted. If the entry at this
+	 * position is inside the dir, not a new sparse dir.
+	 */
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
@@ -1078,21 +1139,44 @@ static int unpack_single_entry(int n, unsigned long mask,
 			       unsigned long dirmask,
 			       struct cache_entry **src,
 			       const struct name_entry *names,
-			       const struct traverse_info *info)
+			       const struct traverse_info *info,
+			       int *is_new_sparse_dir)
 {
 	int i;
 	struct unpack_trees_options *o = info->data;
 	unsigned long conflicts = info->df_conflicts | dirmask;
+	const struct name_entry *p = names;
 
-	if (mask == dirmask && !src[0])
-		return 0;
+	*is_new_sparse_dir = 0;
+	if (mask == dirmask && !src[0]) {
+		/*
+		 * If we're not in a sparse index, we can't unpack a directory
+		 * without recursing into it, so we return.
+		 */
+		if (!o->src_index->sparse_index)
+			return 0;
+
+		/* Find first entry with a real name (we could use "mask" too) */
+		while (!p->mode)
+			p++;
+
+		/*
+		 * If the directory is completely missing from the index but
+		 * would otherwise be a sparse directory, we should unpack it.
+		 * If not, we'll return and continue recursively traversing the
+		 * tree.
+		 */
+		*is_new_sparse_dir = entry_is_new_sparse_dir(info, p);
+		if (!*is_new_sparse_dir)
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
+	    (*is_new_sparse_dir || (src[0] && S_ISSPARSEDIR(src[0]->ce_mode))))
 		conflicts = 0;
 
 	/*
@@ -1352,7 +1436,7 @@ static int unpack_sparse_callback(int n, unsigned long mask, unsigned long dirma
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
-	int ret;
+	int ret, is_new_sparse_dir;
 
 	assert(o->merge);
 
@@ -1376,7 +1460,7 @@ static int unpack_sparse_callback(int n, unsigned long mask, unsigned long dirma
 	 * "index" tree (i.e., names[0]) and adjust 'names', 'n', 'mask', and
 	 * 'dirmask' accordingly.
 	 */
-	ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info);
+	ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info, &is_new_sparse_dir);
 
 	if (src[0])
 		discard_cache_entry(src[0]);
@@ -1394,6 +1478,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
 	const struct name_entry *p = names;
+	int is_new_sparse_dir;
 
 	/* Find first entry with a real name (we could use "mask" too) */
 	while (!p->mode)
@@ -1440,7 +1525,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 	}
 
-	if (unpack_single_entry(n, mask, dirmask, src, names, info) < 0)
+	if (unpack_single_entry(n, mask, dirmask, src, names, info, &is_new_sparse_dir))
 		return -1;
 
 	if (o->merge && src[0]) {
@@ -1478,6 +1563,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 
 		if (!is_sparse_directory_entry(src[0], names, info) &&
+		    !is_new_sparse_dir &&
 		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
 						    names, info) < 0) {
 			return -1;
-- 
gitgitgadget
