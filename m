Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F737206D
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474286; cv=none; b=kbDQJLt5D6W8LnET0JAFaFJIYT0rfwlj6tU2af4DD2wKS1r3wBsjzvyQPNCBpHeeaVB7tTLizbpl/x9B2REJl8pY0/+pbLRk254MtqhC4r1qu92/yBSsY056nIHoEJ2SowdYTbQWMHWc6ItE7x7gCKmYrcttuU7P1NqgAb0PF+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474286; c=relaxed/simple;
	bh=3kPKw3Rk+xXdwDTx5X7fWm7+KiJklPi7bhfwxG2fXJU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CKSAO3KqFr8R1pZicZoPmrswQNvtnG+LsrEMsqGAhlKGIWCtQOMHRttYSJDOWvIBXejFrs+AlDPIhlSHB+dP0PyZoQEr6hGPa9Wiw3wr1Sdu1SnPu3iSK9DrsedDAAKgdqVxWRYNQAmUw63GbZi0qD7deperLdjKO6JTyNKJkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWS7jhsa; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWS7jhsa"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516e130c64fso9011cf.3
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474283; x=1780079083; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfFz+oBiHcd6CYn3ou64EwQvdh1J1Q8TD+BgSrpUxBw=;
        b=BWS7jhsa53pMjZHty65+Hm7PAyxLrTZGCSiImh1dEL3QDplb/hGatBeTT0elENwqp/
         fE7q6EoN2xomxGkPvCr5FRh46/sv+W2d+zGnbjX2QznSGojySy75VAEmfO3W+vy0OE/r
         QmRpbyQhqlZIp9ynuv53pP6BMUAWDASSudazCHxSNOIu15RuyOHFqia18iPzGrG41Psa
         SzwHaM6Lltp8YNiHXdpAp3KHMEyTEMr/gCrg+WK/zyT85FuIRxz39574dO4t/MLulIMW
         9C8f8mGD4+kreO6N1a1JsaIVXbbksDH7CAWa302FMSagrfRQHJb8GYOvo1+K9v3oVGU2
         EDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474283; x=1780079083;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AfFz+oBiHcd6CYn3ou64EwQvdh1J1Q8TD+BgSrpUxBw=;
        b=SQF3ENeiiGmdEBs620mIyeKsblsNkx3E+qagXEOC/KRl6z9PtbgLIlTymsEWjsiaIo
         STCpE5+Z7w7sfywqetnP0X/HgNqHwN0gmv61syKHXMLrsGS6gCKqlhLJzcu9PI47ayxD
         9KmKeLH0aK0lVr6VYn8pb420OWGBfbWl3ttHef1/qME3PV60PWgChiA76PUieBWCa9xL
         ylWmeddoXNJYgU94TaRMJnybYovDhyA5F6X+201OAfUbz/HsQaQQDB6kB1GtS7sCAPxi
         6Pb/p4nUuZfQn+sXRsYecII0KjWpgYFlEZmtm9q6HGHfSb2hK0pgT/KRY49FR/JERQRW
         /JOg==
X-Gm-Message-State: AOJu0YzKKH+7UAU7MpTRWTuIx/Nt5tsFymN3R+9L1wm3A1lFZejOETA+
	2h+BbE7v2jpmGElB9y4+wcEbvJT6ajdXVFK2llym270fmOpmYV4dwbIJt0OYulhB
X-Gm-Gg: Acq92OEC64X01V0qjWGAOlEkTPUiIza0A1Hxe7fFA0fQPVurN18eW/N2VD9VAFwNB6u
	JpJWoMEyVG5Inx+PmiX5Wg5YtfPdqnM0McqyuZzvge0CT6S73NPkXiaJVkt9l9d/5/pEB7C84jq
	tTMV5xgfXGDdvymSvibRp5neinCC6njaQjqDvbo5A9PoiqSCsLTHrFJF9tsf5RBkm3c23JI52nM
	J8R8hrm80l0pPnIorAOz9NXmaZF6mLKJj1ikkQ9XORVsO5Q8E/rklimU/cjYpuaRqZAatZHTklI
	G26EhwReCIodO6zC/XUFSe8hkbqF9hzkZ2JMp7DRasnK6TVWloeeBQJGcr7y7wGO1+oLAzbpVvy
	jYLGDgEmSBr+06k9vBTyZt0zdw8s01O8+ppXnPbWNqu9s2Ob+VF8tawmBxevBJNHiKhXhVgWaUq
	w67+cpbao2SRuFuPLXPVDlOnR5blI=
X-Received: by 2002:ac8:7d49:0:b0:50d:7135:5631 with SMTP id d75a77b69052e-516d429b4damr68089251cf.6.1779474283479;
        Fri, 22 May 2026 11:24:43 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b0023bsm22124891cf.1.2026.05.22.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:42 -0700 (PDT)
Message-Id: <91845bcef0692bf15b41af1dbf01dcc02baf42ee.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:28 +0000
Subject: [PATCH v5 04/13] path-walk: always emit directly-requested objects
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
 path-walk.c                                | 42 ++++++++++++++--------
 path-walk.h                                |  5 +++
 3 files changed, 39 insertions(+), 15 deletions(-)

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
index 6e426af433..05bfc1c114 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -248,6 +248,17 @@ static int add_tree_entries(struct path_walk_context *ctx,
 	return 0;
 }
 
+/*
+ * Paths starting with '/' (e.g., "/tags", "/tagged-blobs") hold objects that
+ * were directly requested by 'pending' objects rather than discovered during
+ * tree traversal.
+ */
+static int path_is_for_direct_objects(const char *path)
+{
+	ASSERT(path);
+	return path[0] == '/';
+}
+
 /*
  * For each path in paths_to_explore, walk the trees another level
  * and add any found blobs to the batch (but only if they exist and
@@ -306,14 +317,19 @@ static int walk_path(struct path_walk_context *ctx,
 
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
@@ -374,10 +390,8 @@ static int setup_pending_objects(struct path_walk_info *info,
 
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
@@ -421,8 +435,6 @@ static int setup_pending_objects(struct path_walk_info *info,
 
 		switch (obj->type) {
 		case OBJ_TREE:
-			if (!info->trees)
-				continue;
 			if (pending->path) {
 				char *path = *pending->path ? xstrfmt("%s/", pending->path)
 							    : xstrdup("");
@@ -435,8 +447,6 @@ static int setup_pending_objects(struct path_walk_info *info,
 			break;
 
 		case OBJ_BLOB:
-			if (!info->blobs)
-				continue;
 			if (pending->path)
 				add_path_to_list(ctx, pending->path, OBJ_BLOB, &obj->oid, 1);
 			else
@@ -532,15 +542,17 @@ int walk_objects_by_path(struct path_walk_info *info)
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

