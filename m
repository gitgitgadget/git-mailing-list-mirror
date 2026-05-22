Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42B374E42
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474294; cv=none; b=TsCJLHLTFwGCqmr+ozIZcgaCi3zTKuuRcol4ZnEnBRY+cokY4fdmM6/mXyW4Ltw0mF4kAaR7Ad/NhS29wEkAHocsnc12zwd8oF/cCSXkFR+KdtYgs6o1PTdEa80Atk+8iNzDoeBtwGq1xiaiwOWYyw92H6Fi0avH5qnF3LkRodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474294; c=relaxed/simple;
	bh=tYpwveQognsNt3Pk3RcOlt2i/pdnG84c3Msvg8DyEpE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=txZrgbYnni0+x9+hj4NKko3NDqhrD2EXnMTOIjYLQIV/hYtmU0NDGFFCgzvo8s5rsq1SooVIwtewX1bZ0jHp/BpNMsLgJSN2mS+3BEI7QYUsQPpnL9VOFN3c18OShWYipO5wrsJrdUb5dqKvLdT10/TBQ793CAu0Mkk/nQnn6II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiOlnIr1; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiOlnIr1"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-914bbfc2464so67228985a.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474291; x=1780079091; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wACVFlOjM+bnRgbybkb7aUoI1nRHejKCjSzwm0Ghhzo=;
        b=qiOlnIr1tyr1uTUW4WuR2IUMVjqlM8QVP6ZYP5XEV6EaBYUZ3PWaDj4htbIIfqYHYl
         BSdyT7kQZh6SP0OSIRowIByxQ1inou+EvTYX97ZdoYGKDECcy/s4OKigvzdlMUTBUNMn
         Dc3gByQdJi2Nx0hz8T526esMo1R8tqWCLAUvpWFgeL33wjfz89m+wDOvjLZlzuaZVtXK
         l/7T6u4shtQaem6I798+c25Bqwqj00Nad5OLpyxrXnIXko50wM8BhY2mOmFX+t3CgDZS
         7A4peVSs144hbknJJnznZUF4oFWwza3NSWreoptFn5qxifUwf3gp03opuU6e0ekBtQTA
         YoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474291; x=1780079091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wACVFlOjM+bnRgbybkb7aUoI1nRHejKCjSzwm0Ghhzo=;
        b=BOGebLV2gMNitCn4VmxrrNvmqQhZeFRHrZoCVvAHccheSWjd408RCJjtgKK/yL8PsQ
         XptqwaQ6pdwK5AFmsbv8Cq3GPgw5y6sXT8dk+p2BRFG4MLYoIcSWY5pEOJDHJN6trOvb
         fjz421qSJMjipHWz3PotI/aKmwtz3gDQgKzeZVFcaW2N7XamMmZn0hITPmLhN2bFLnhl
         NTAZ5EO5ljx2IbhvVMx4wugwwAgkAVTVRXA3Bqak9FJt/tmFafxXY/+LOVMsDsZbVhNl
         FDd+UYP2hm4LVXLPPv93wDdrff4G3bEUPgTa02Qj94BHS+eWQBbT4FUyAf0y5ChhTQie
         8QlA==
X-Gm-Message-State: AOJu0YyQu3nWNSToZY09A3C9plUcfhn9y2LN8ik7KJe9tuss/tcbOC5S
	fJSGcYID6D+sHjlylfBRiDg2hPShKP+CNV3Bb3AQynhZvSkgLakTFQeBBVSs5GNj
X-Gm-Gg: Acq92OG2WgbRQ55iiaQ8CBr79HGVROAxzXbgPWIIQ4OFlU4Py7Whw+gSp+Z43YNWyK4
	6AcKfMCfqYSmSOz+GYTZacVxvCjQf6FVqjPhgvdcbGG6ehdCabFsi+WbceKwv7+gwwo/tlOzSz6
	/Q0tBYyUFWWIDiytsUE8LKZBo3eKLiuPLe3jKNyPY+cGsS9/vwtbIckPC8JBT+7x49apIu7b9Ir
	VFpBM7U2ztxes48uBMS2ScbqXeWoLMxVmjYB5IJ1Bo1GqiSPJNVheW5IlmEY5GzrlN7i/ZEUqzN
	Ui9D3RSZYb6bc4rcFNY/ZCcWC6yOkzoJgPTJ8mMtlVWk6xkq4vCLpTnQVik/aBdTEPL1ekFlY1u
	g8HneSpsgdAWgjeURsk+4pTjXHoHkdQLgoxNJZ6VmXU4FygoXfufhZTvTo8zyMWgM10QyuYABOd
	gDAjhKtRf2Xhxo+pbBYfUpbw4PSx6rll7tSjdDBA==
X-Received: by 2002:a05:620a:7119:b0:90c:fc17:95f6 with SMTP id af79cd13be357-914b49b09f7mr688366785a.49.1779474291522;
        Fri, 22 May 2026 11:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bba0b6c8sm187486785a.41.2026.05.22.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:50 -0700 (PDT)
Message-Id: <b0db73c6cc2ed70675e35d7cfdd1a484ab337486.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:35 +0000
Subject: [PATCH v5 11/13] path-walk: support `tree:0` filter
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

The `tree:0` object filter omits all trees and blobs from the result,
keeping only commits and tags. Consequently, this filter type should
has a fairly straightforward integration with path-walk, as the decision
to include an object depends only on its type and does not depend on any
path-sensitive state.

Mapping it onto `path_walk_info` is direct: set `info->trees = 0` and
`info->blobs = 0` in `prepare_filters()` when the `LOFC_TREE_DEPTH`
choice is requested with depth zero. The existing code already plumbs
those flags through the rest of the walk:

 - 'walk_objects_by_path()' sets `revs->blob_objects = info->blobs` and
   `revs->tree_objects = info->trees` before `prepare_revision_walk()`,
   so the revision walk doesn't try to enumerate trees or blobs itself.

 - The commit-walk loop short-circuits the root-tree fetch with
   "if (!info->trees && !info->blobs) continue;", so we never even
   look up the root tree, let alone descend into it.

 - `setup_pending_objects()` skips pending trees and blobs based on
   the same flags.

This means the path-walk doesn't allocate or expand any tree structures
at all under `tree:0`, which matches the intended behavior of the
filter.

However, this requires first fixing some issues with how the path-walk
API handles directly-requested trees _and_ trees requested through
lightweight tags. These changes create substantial updates to
t6601-path-walk.sh, which the previous change highlighted as a problem
by tagging otherwise-unreachable trees and having them not appear in the
output.

Non-zero tree-depth filters are not supported. Those depend on the depth
at which a tree is visited, which is a path-walk concept the filter
machinery doesn't currently share with the path-walk API. Reject them in
`prepare_filters()` with a helpful error and let pack-objects fall back
to the regular traversal, the same way it already does for unsupported
filters.

Add coverage in t6601 for both `--all` and a single-branch case to
confirm that no trees or blobs are emitted, and a separate test that
`tree:1` is rejected with the expected error message. Place the new
tests before "setup sparse filter blob" so they run on the original set
of refs, before the orphan branch that the sparse-tree tests create.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc |   4 +-
 path-walk.c                         |  53 +++++++--
 t/t6601-path-walk.sh                | 165 ++++++++++++++++++----------
 3 files changed, 152 insertions(+), 70 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index e38853391b..c86219be91 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -404,8 +404,8 @@ will be automatically changed to version `1`.
 +
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. The `--path-walk` option
-supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`, and
-`sparse:<oid>`.
+supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
+`tree:0`, and `sparse:<oid>`.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index ce38dcf1e9..cb67b8ce86 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -390,11 +390,18 @@ static int walk_path(struct path_walk_context *ctx,
 					ctx->info->path_fn_data);
 	}
 
-	/* Expand data for children. */
-	if (list->type == OBJ_TREE) {
+	/*
+	 * Expand tree children, except when the set is directly requested
+	 * _and_ we are otherwise filtering out trees.
+	 */
+	if (list->type == OBJ_TREE &&
+	    (!path_is_for_direct_objects(path) || ctx->info->trees)) {
+		/* Use root path if expanding from tagged/direct trees. */
+		const char *expand_path = !strcmp(path, "/tagged-trees")
+					  ? root_path : path;
 		for (size_t i = 0; i < list->oids.nr; i++) {
 			ret |= add_tree_entries(ctx,
-					    path,
+					    expand_path,
 					    &list->oids.oid[i]);
 		}
 	}
@@ -442,12 +449,12 @@ static int setup_pending_objects(struct path_walk_info *info,
 {
 	struct type_and_oid_list *tags = NULL;
 	struct type_and_oid_list *tagged_blobs = NULL;
-	struct type_and_oid_list *root_tree_list = NULL;
+	struct type_and_oid_list *tagged_trees = NULL;
 
 	if (info->tags)
 		CALLOC_ARRAY(tags, 1);
 	CALLOC_ARRAY(tagged_blobs, 1);
-	root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
+	CALLOC_ARRAY(tagged_trees, 1);
 
 	/*
 	 * Pending objects include:
@@ -491,14 +498,15 @@ static int setup_pending_objects(struct path_walk_info *info,
 
 		switch (obj->type) {
 		case OBJ_TREE:
-			if (pending->path) {
-				char *path = *pending->path ? xstrfmt("%s/", pending->path)
-							    : xstrdup("");
+			if (pending->path && *pending->path) {
+				char *path = xstrfmt("%s/", pending->path);
 				add_path_to_list(ctx, path, OBJ_TREE, &obj->oid, 1);
 				free(path);
+			} else if (!pending->path || !info->trees) {
+				oid_array_append(&tagged_trees->oids, &obj->oid);
 			} else {
-				/* assume a root tree, such as a lightweight tag. */
-				oid_array_append(&root_tree_list->oids, &obj->oid);
+				add_path_to_list(ctx, root_path, OBJ_TREE,
+						 &obj->oid, 1);
 			}
 			break;
 
@@ -535,6 +543,18 @@ static int setup_pending_objects(struct path_walk_info *info,
 			free(tagged_blobs);
 		}
 	}
+	if (tagged_trees) {
+		if (tagged_trees->oids.nr) {
+			const char *tagged_tree_path = "/tagged-trees";
+			tagged_trees->type = OBJ_TREE;
+			tagged_trees->maybe_interesting = 1;
+			strmap_put(&ctx->paths_to_lists, tagged_tree_path, tagged_trees);
+			push_to_stack(ctx, tagged_tree_path);
+		} else {
+			oid_array_clear(&tagged_trees->oids);
+			free(tagged_trees);
+		}
+	}
 	if (tags) {
 		if (tags->oids.nr) {
 			const char *tag_path = "/tags";
@@ -575,6 +595,19 @@ static int prepare_filters(struct path_walk_info *info,
 		}
 		return 1;
 
+	case LOFC_TREE_DEPTH:
+		if (options->tree_exclude_depth) {
+			error(_("tree:%lu filter not supported by the path-walk API"),
+			      options->tree_exclude_depth);
+			return 0;
+		}
+		if (info) {
+			info->trees = 0;
+			info->blobs = 0;
+			list_objects_filter_release(options);
+		}
+		return 1;
+
 	case LOFC_SPARSE_OID:
 		if (info) {
 			struct object_id sparse_oid;
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 92c524d145..566db7c7e3 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -77,23 +77,23 @@ test_expect_success 'all' '
 	3:tree::$(git rev-parse base^{tree})
 	3:tree::$(git rev-parse base~1^{tree})
 	3:tree::$(git rev-parse base~2^{tree})
-	3:tree::$(git rev-parse refs/tags/tree-tag^{})
-	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
 	4:blob:a:$(git rev-parse base~2:a)
-	5:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
-	6:tree:a/:$(git rev-parse base:a)
-	7:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
-	8:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
-	9:tree:left/:$(git rev-parse base:left)
-	9:tree:left/:$(git rev-parse base~2:left)
-	10:blob:left/b:$(git rev-parse base~2:left/b)
-	10:blob:left/b:$(git rev-parse base:left/b)
-	11:tree:right/:$(git rev-parse topic:right)
-	11:tree:right/:$(git rev-parse base~1:right)
-	11:tree:right/:$(git rev-parse base~2:right)
-	12:blob:right/c:$(git rev-parse base~2:right/c)
-	12:blob:right/c:$(git rev-parse topic:right/c)
-	13:blob:right/d:$(git rev-parse base~1:right/d)
+	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
+	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
+	6:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
+	7:tree:a/:$(git rev-parse base:a)
+	8:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	9:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
+	10:tree:left/:$(git rev-parse base:left)
+	10:tree:left/:$(git rev-parse base~2:left)
+	11:blob:left/b:$(git rev-parse base~2:left/b)
+	11:blob:left/b:$(git rev-parse base:left/b)
+	12:tree:right/:$(git rev-parse topic:right)
+	12:tree:right/:$(git rev-parse base~1:right)
+	12:tree:right/:$(git rev-parse base~2:right)
+	13:blob:right/c:$(git rev-parse base~2:right/c)
+	13:blob:right/c:$(git rev-parse topic:right/c)
+	14:blob:right/d:$(git rev-parse base~1:right/d)
 	blobs:10
 	commits:4
 	tags:7
@@ -471,15 +471,15 @@ test_expect_success 'all, blob:none filter' '
 	3:tree::$(git rev-parse base^{tree})
 	3:tree::$(git rev-parse base~1^{tree})
 	3:tree::$(git rev-parse base~2^{tree})
-	3:tree::$(git rev-parse refs/tags/tree-tag^{})
-	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
-	4:tree:a/:$(git rev-parse base:a)
-	5:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
-	6:tree:left/:$(git rev-parse base:left)
-	6:tree:left/:$(git rev-parse base~2:left)
-	7:tree:right/:$(git rev-parse topic:right)
-	7:tree:right/:$(git rev-parse base~1:right)
-	7:tree:right/:$(git rev-parse base~2:right)
+	4:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
+	4:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
+	5:tree:a/:$(git rev-parse base:a)
+	6:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	7:tree:left/:$(git rev-parse base:left)
+	7:tree:left/:$(git rev-parse base~2:left)
+	8:tree:right/:$(git rev-parse topic:right)
+	8:tree:right/:$(git rev-parse base~1:right)
+	8:tree:right/:$(git rev-parse base~2:right)
 	blobs:2
 	commits:4
 	tags:7
@@ -533,15 +533,15 @@ test_expect_success 'all, blob:limit=0 filter' '
 	3:tree::$(git rev-parse base^{tree})
 	3:tree::$(git rev-parse base~1^{tree})
 	3:tree::$(git rev-parse base~2^{tree})
-	3:tree::$(git rev-parse refs/tags/tree-tag^{})
-	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
-	4:tree:a/:$(git rev-parse base:a)
-	5:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
-	6:tree:left/:$(git rev-parse base:left)
-	6:tree:left/:$(git rev-parse base~2:left)
-	7:tree:right/:$(git rev-parse topic:right)
-	7:tree:right/:$(git rev-parse base~1:right)
-	7:tree:right/:$(git rev-parse base~2:right)
+	4:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
+	4:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
+	5:tree:a/:$(git rev-parse base:a)
+	6:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	7:tree:left/:$(git rev-parse base:left)
+	7:tree:left/:$(git rev-parse base~2:left)
+	8:tree:right/:$(git rev-parse topic:right)
+	8:tree:right/:$(git rev-parse base~1:right)
+	8:tree:right/:$(git rev-parse base~2:right)
 	blobs:2
 	commits:4
 	tags:7
@@ -572,19 +572,19 @@ test_expect_success 'all, blob:limit=3 filter' '
 	3:tree::$(git rev-parse base^{tree})
 	3:tree::$(git rev-parse base~1^{tree})
 	3:tree::$(git rev-parse base~2^{tree})
-	3:tree::$(git rev-parse refs/tags/tree-tag^{})
-	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
 	4:blob:a:$(git rev-parse base~2:a)
-	5:tree:a/:$(git rev-parse base:a)
-	6:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
-	7:tree:left/:$(git rev-parse base:left)
-	7:tree:left/:$(git rev-parse base~2:left)
-	8:blob:left/b:$(git rev-parse base~2:left/b)
-	9:tree:right/:$(git rev-parse topic:right)
-	9:tree:right/:$(git rev-parse base~1:right)
-	9:tree:right/:$(git rev-parse base~2:right)
-	10:blob:right/c:$(git rev-parse base~2:right/c)
-	11:blob:right/d:$(git rev-parse base~1:right/d)
+	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
+	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
+	6:tree:a/:$(git rev-parse base:a)
+	7:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	8:tree:left/:$(git rev-parse base:left)
+	8:tree:left/:$(git rev-parse base~2:left)
+	9:blob:left/b:$(git rev-parse base~2:left/b)
+	10:tree:right/:$(git rev-parse topic:right)
+	10:tree:right/:$(git rev-parse base~1:right)
+	10:tree:right/:$(git rev-parse base~2:right)
+	11:blob:right/c:$(git rev-parse base~2:right/c)
+	12:blob:right/d:$(git rev-parse base~1:right/d)
 	blobs:6
 	commits:4
 	tags:7
@@ -594,6 +594,55 @@ test_expect_success 'all, blob:limit=3 filter' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'all, tree:0 filter' '
+	test-tool path-walk --filter=tree:0 -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tag:/tags:$(git rev-parse refs/tags/first)
+	1:tag:/tags:$(git rev-parse refs/tags/second.1)
+	1:tag:/tags:$(git rev-parse refs/tags/second.2)
+	1:tag:/tags:$(git rev-parse refs/tags/third)
+	1:tag:/tags:$(git rev-parse refs/tags/fourth)
+	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{tree})
+	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2)
+	blobs:2
+	commits:4
+	tags:7
+	trees:2
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic only, tree:0 filter' '
+	test-tool path-walk --filter=tree:0 -- topic >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	blobs:0
+	commits:3
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'tree:1 filter is rejected' '
+	test_must_fail test-tool path-walk --filter=tree:1 -- --all 2>err &&
+	test_grep "tree:1 filter not supported by the path-walk API" err
+'
+
 test_expect_success 'setup sparse filter blob' '
 	# Cone-mode patterns: include root, exclude all dirs, include left/
 	cat >patterns <<-\EOF &&
@@ -625,19 +674,19 @@ test_expect_success 'all, sparse:oid filter' '
 	3:tree::$(git rev-parse base^{tree})
 	3:tree::$(git rev-parse base~1^{tree})
 	3:tree::$(git rev-parse base~2^{tree})
-	3:tree::$(git rev-parse refs/tags/tree-tag^{})
-	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
 	4:blob:a:$(git rev-parse base~2:a)
-	5:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
-	6:tree:a/:$(git rev-parse base:a)
-	7:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
-	8:tree:left/:$(git rev-parse base:left)
-	8:tree:left/:$(git rev-parse base~2:left)
-	9:blob:left/b:$(git rev-parse base~2:left/b)
-	9:blob:left/b:$(git rev-parse base:left/b)
-	10:tree:right/:$(git rev-parse topic:right)
-	10:tree:right/:$(git rev-parse base~1:right)
-	10:tree:right/:$(git rev-parse base~2:right)
+	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
+	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
+	6:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
+	7:tree:a/:$(git rev-parse base:a)
+	8:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	9:tree:left/:$(git rev-parse base:left)
+	9:tree:left/:$(git rev-parse base~2:left)
+	10:blob:left/b:$(git rev-parse base~2:left/b)
+	10:blob:left/b:$(git rev-parse base:left/b)
+	11:tree:right/:$(git rev-parse topic:right)
+	11:tree:right/:$(git rev-parse base~1:right)
+	11:tree:right/:$(git rev-parse base~2:right)
 	blobs:6
 	commits:4
 	tags:7
-- 
gitgitgadget

