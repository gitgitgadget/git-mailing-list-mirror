Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4472747B410
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523199; cv=none; b=bHJB5/7RfWENHdcpVirciScqEwERGTyV6QS3BXNKcx/ApiHP4yWQZCf63v/tiXfZluYh61mM6Lh0PkrK2zvPuHCgtSrOV3P9NgC8OSBxTle1nsY5uUvQ3XpWbU9G4oZX2ZcHY6sQRs7aLGeOWTeX7DI7NTzcy44R626fJyWveAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523199; c=relaxed/simple;
	bh=Mo6IbBmizp1cQQOgBc1bBSF+2xxQjwTlrdAq6awP4AM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JmneE/HxX96qKwXCFD2lPa4Cz+YPW50IwNKkyXiLkNZwi/gAcv7K/nfNiF6TYEbmXSBYcZ6yBwogniVFYvRBEGL6UgEZ/AS8RGKQU0F3/Qay26E9DNgw71YiZ/4T2Nq7uUsioHcILuXVd2MNzLa1foDy9wKyCg7Qcv+BeD1Qbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwNi0cua; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwNi0cua"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50faeb8317bso33524411cf.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523197; x=1779127997; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+mAHYE8CEVyFFApxU/8vTJs2z4GEOzKX3yazU4Ib24=;
        b=jwNi0cuaSEZVadCSMRd7Q3ArIBl8DUMT6sgDw51xqDKbRDQa6ldl9GM9POLjBdZ0AK
         y8v1JPSeD5rwM7wLuKfb2+P9ccvvBiuabKTp69oo0BlVTyKeCM/u/TiuUYqhPh0+PCBF
         gaZledkl9Jv+ae9XMUhsb0x3zFpO+c50vr8MUjQio77e5s+DbvsFXd9eayb+Nw5fW9Bv
         IwdUEkwSn5sUskjycxwbOeIidTa7L/B4CUNJxcmzUO9TLkKbwbL+5xtyrMgfMLXrjSxC
         HfoPWWaEv4i3b3Ymert004iOpB+nBDuiUqTs4ErjVW8BuCyjKgN8n4dsYiM76lVlcbtq
         kcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523197; x=1779127997;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+mAHYE8CEVyFFApxU/8vTJs2z4GEOzKX3yazU4Ib24=;
        b=FAZdtGc7BEyOkYXfk09epgmdrUo7h3JHiEZMcCYETvdUFBPW2FJHSTj2cxFV608Qmi
         ni7T4e7GOMbarCVrRweDf0faliq0K89J3nj1PWqhNVW3G6w7b5GGUblubKoufGWHI2Xb
         sWnCKqd3hVNf4uNA/NF+4poCgISnNmXTrJ9V4buXym/StqimMspSTx2TeYwsDQwZqGdE
         cNvFSZiSoGHQ9da18u4jniIJisV6iP7y3dVPdZX/2bm6QHB4/EGpXWC7/ktHY7etCUbn
         K3pNyKkQflzmREf7/bvTv2k+Kzn09YAhOWzVZtCn7UMdLGEHGQSIbCEr7Z74ve5H8NQa
         Ubrw==
X-Gm-Message-State: AOJu0Yxls1yUG0IkJtjzAIVvsthGpWAncaofLrBSA4OTcR8Lhcq87F/o
	Jqp3MTIPbcuenodSKVd2DjVBvr77LEjyuk32aT8ke2n8b57cSuJl8VYdbDwT2Q==
X-Gm-Gg: Acq92OEgCRYQ0WHz6swSMf6qhlBbaHpdT5U3z5SfJG1qV302S5BdBA34W3R/rMRvVi6
	zyOGdBpo/kd1vNvzAsQm9SYeJdLJhCHEiOyIigV6N8qt9ME9mCUS1L2TsuxCN51s8nRiJmpfFGf
	zarjZvbu5POkE8CRIZhjgGKV4PS1VCjGCp16oh9H1bF3p753tJDmw3RZ7uFoOUgz+wShtGqxhRe
	D9R/pDpiefjZmkYzVZoV23OlGUaDSarj6g5RBa/T+ULX4iL9ukYrH/6MJaAU4oW+ojZZt0sRtcI
	sfX5uzE+Y20v8tVmYkeUaEzO+thmfcwRfOhN427M0MwghQA3I1g2Al5Nl34uEkVXRzTqnp/ZGu2
	vyHXhx7Zj3In2ON4FlUYYUD7gsnCGtLKwEz+S5AMHS0VE+qIqJENPa5R5f10po8lo0zT2h97EKD
	lTx8JzZuWf23DyNAAZt69aiQ8SXQ==
X-Received: by 2002:ac8:5815:0:b0:50f:c36a:3818 with SMTP id d75a77b69052e-5148e9e4c15mr232282501cf.59.1778523196469;
        Mon, 11 May 2026 11:13:16 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7c0fa5sm103486331cf.16.2026.05.11.11.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:15 -0700 (PDT)
Message-Id: <50933cccf508f71f47d955d5aceacad0db612fc5.1778523189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:13:01 +0000
Subject: [PATCH v3 04/12] path-walk: always emit directly-requested objects
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
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

We are preparing to integrate the path-walk API with some --filter options
in 'git pack-objects', but there is a subtle issue that is revealed when
those are put together and the test suite is run with
GIT_TEST_PACK_PATH_WALK=1.

When a filter reduces the set of requested objects, this results in
filtering out directly-requested objects, such as in the download of needed
blobs in a blobless partial clone.

The root cause is that the scan of pending objects in the path-walk API
respects the filters set in the path_walk_info instead of overriding them
for pending objects.

We can tell that a path is part of the directly-referenced objects if its
path name starts with '/' (other paths, including root trees never have this
starting character). Create a path_is_for_direct_objects() to make this
meaning clear, especially as we add more references in the future as we
integrate the path-walk API with partial clone filter options.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.adoc |  7 ++++
 path-walk.c                                | 41 ++++++++++++++--------
 path-walk.h                                |  5 +++
 3 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/api-path-walk.adoc b/Documentation/technical/api-path-walk.adoc
index a67de1b143..6e17b13d61 100644
--- a/Documentation/technical/api-path-walk.adoc
+++ b/Documentation/technical/api-path-walk.adoc
@@ -48,6 +48,13 @@ commits.
 	applications could disable some options to make it simpler to walk
 	the objects or to have fewer calls to `path_fn`.
 +
+Note that objects directly requested as pending objects (such as targets
+of lightweight tags or other ref tips) are always emitted to `path_fn`,
+even when the corresponding type flag is disabled. Only objects
+discovered during the tree walk are subject to these type filters. This
+ensures that objects specifically requested through the revision input
+are never silently dropped.
++
 While it is possible to walk only commits in this way, consumers would be
 better off using the revision walk API instead.
 
diff --git a/path-walk.c b/path-walk.c
index 6e426af433..59a7670c5b 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -248,6 +248,16 @@ static int add_tree_entries(struct path_walk_context *ctx,
 	return 0;
 }
 
+/*
+ * Paths starting with '/' (e.g., "/tags", "/tagged-blobs") hold objects that
+ * were directly requested by 'pending' objects rather than discovered during
+ * tree traversal.
+ */
+static int path_is_for_direct_objects(const char *path)
+{
+	return path[0] == '/';
+}
+
 /*
  * For each path in paths_to_explore, walk the trees another level
  * and add any found blobs to the batch (but only if they exist and
@@ -306,14 +316,19 @@ static int walk_path(struct path_walk_context *ctx,
 
 	if (list->type == OBJ_BLOB &&
 	    ctx->revs->prune_data.nr &&
+	    !path_is_for_direct_objects(path) &&
 	    !match_pathspec(ctx->repo->index, &ctx->revs->prune_data,
 			   path, strlen(path), 0,
 			   NULL, 0))
 		return 0;
 
-	/* Evaluate function pointer on this data, if requested. */
-	if ((list->type == OBJ_TREE && ctx->info->trees) ||
-	    (list->type == OBJ_BLOB && ctx->info->blobs) ||
+	/*
+	 * Evaluate function pointer on this data, if requested.
+	 * Ignore object type filters for tagged objects (path starts
+	 * with `/`).
+	 */
+	if ((list->type == OBJ_TREE && (ctx->info->trees || path_is_for_direct_objects(path))) ||
+	    (list->type == OBJ_BLOB && (ctx->info->blobs || path_is_for_direct_objects(path))) ||
 	    (list->type == OBJ_TAG && ctx->info->tags))
 		ret = ctx->info->path_fn(path, &list->oids, list->type,
 					ctx->info->path_fn_data);
@@ -374,10 +389,8 @@ static int setup_pending_objects(struct path_walk_info *info,
 
 	if (info->tags)
 		CALLOC_ARRAY(tags, 1);
-	if (info->blobs)
-		CALLOC_ARRAY(tagged_blobs, 1);
-	if (info->trees)
-		root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
+	CALLOC_ARRAY(tagged_blobs, 1);
+	root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
 
 	/*
 	 * Pending objects include:
@@ -421,8 +434,6 @@ static int setup_pending_objects(struct path_walk_info *info,
 
 		switch (obj->type) {
 		case OBJ_TREE:
-			if (!info->trees)
-				continue;
 			if (pending->path) {
 				char *path = *pending->path ? xstrfmt("%s/", pending->path)
 							    : xstrdup("");
@@ -435,8 +446,6 @@ static int setup_pending_objects(struct path_walk_info *info,
 			break;
 
 		case OBJ_BLOB:
-			if (!info->blobs)
-				continue;
 			if (pending->path)
 				add_path_to_list(ctx, pending->path, OBJ_BLOB, &obj->oid, 1);
 			else
@@ -532,15 +541,17 @@ int walk_objects_by_path(struct path_walk_info *info)
 	push_to_stack(&ctx, root_path);
 
 	/*
-	 * Set these values before preparing the walk to catch
-	 * lightweight tags pointing to non-commits and indexed objects.
+	 * Ensure that prepare_revision_walk() keeps all pending objects
+	 * even through an object type filter.
 	 */
-	info->revs->blob_objects = info->blobs;
-	info->revs->tree_objects = info->trees;
+	info->revs->blob_objects = info->revs->tree_objects = 1;
 
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
 
+	info->revs->blob_objects = info->blobs;
+	info->revs->tree_objects = info->trees;
+
 	/*
 	 * Walk trees to mark them as UNINTERESTING.
 	 * This is particularly important when 'edge_aggressive' is set.
diff --git a/path-walk.h b/path-walk.h
index 5ef5a8440e..657eeda8ec 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -36,6 +36,11 @@ struct path_walk_info {
 	/**
 	 * Initialize which object types the path_fn should be called on. This
 	 * could also limit the walk to skip blobs if not set.
+	 *
+	 * Note: even when 'blobs' or 'trees' is disabled, objects that are
+	 * directly requested as pending objects will still be emitted to
+	 * path_fn. Only objects discovered during the tree walk are filtered by
+	 * these flags.
 	 */
 	int commits;
 	int trees;
-- 
gitgitgadget

