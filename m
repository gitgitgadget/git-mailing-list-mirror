Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077A1F4FAC
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298767; cv=none; b=jy1WHc2OMuY/aMw7oy57PR37gWdsRkvSAKgJwqzryY9XvX09e8T+ZHAtKT3047iuFkuTXLphOWYAnvSWQ9aKm55iliWWgNwYQ4rwFiaaferF8+LTtK3SphoWW4yQLTE2t2ax1YCtjK4GeYTvIkKKcp0vTbxZEKbeq3RrQo/lot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298767; c=relaxed/simple;
	bh=80rrNFb3NM8xJN+Wj31TuePfUYW+MUWGBh1TvyOFv10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaIgntgWbwwvu8xi4wW9iHTdSzzCKHbIo+lUKS7f5/svrMOME9HJdaXsDNeXgvKgcMnrmYbXvlJgeAJe3iMM8x9QTb+E2c4mKMV91Xyz2upyIKxulSrnHyOEMtMX1vz9xP4XbJtg5fLYY79k8eVj5UTSjesvFUNTiedpzGEdlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dx5qIvvC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx5qIvvC"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso822358766b.3
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730298763; x=1730903563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWNHUAZNZjB2FejKDhfAfEBekIhM95m6wTe9D9RPF6E=;
        b=dx5qIvvCGI+n+fporanP3bmn58AfbpZ7uNKxg06ujT55KAjj5ECq4w8X2LBmcjc1k0
         /TxPETQ7FaAdRKlN2Zto0/pluVylgnSXQMlE1sDMQkoNDWYG7nu7Z4ubhlN49ixTITeA
         LNqTWx94+zSCs1cSO0BhHIW64/fxofK+wu9j6BEOmhw7qn8BFyOrXsGVEL5tBjxD6oUp
         XR0SULVGbi9+sCptz+a/qpDoI5gQJGr5d2h5BHYNp3482ZD4qQNzY4uwnl9yn27BKlAw
         ccYcfiQh1tZsbUnSCrHYX0eokUuuj3yCvBHHBYfPcYn4elzu4SRiWGvr2UGb1XczE43v
         nsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298763; x=1730903563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWNHUAZNZjB2FejKDhfAfEBekIhM95m6wTe9D9RPF6E=;
        b=jWHVhGXPmXJqyEJLVHJMAtguVeyVpXX0awQ2iCwaDcPiDPzHgiYw/n8vYIH2WG/yzE
         iBceq3VOmt6stJzKckmNdIkM0sVQkMfqkPVzMODGkdCEbUEOHW85RIjkRy0kQ8S5LMq+
         v6cjRir05AEzq5jZrnaos2RJzk07ge1InBPekUvJiLHZv/b3H1aUbsxls0eu4/62sSOS
         TJaHCLr0j2AwPw1xeb0d5kjOsL9OCsPw/LNPDYAmBzXYGOmDS409505mPrWy3DE7Bl4b
         3Q6ssaNc7WG+KN+yEIDZ4ZTLWsCsMsKmtkEOc1HctyRyMcHjbtGU9ZWpUnFuoXiv1DJH
         uohA==
X-Gm-Message-State: AOJu0YzJ3OWVy3JcBZ58sycciY/Tr2r9s0PzFr/GBojB+VUjOAqGijGx
	KKBQ0zh3WUFMvRZZr+JNzJS22uv7XmGiOWQ6Seqeten5lO/RTDLE
X-Google-Smtp-Source: AGHT+IGGiJ1GUFf5BlZdjNa3iVNK3BE3s8uG74cfwcdqdP9Euh33bjTSRIraEZY0KwJqxWm5uBE6fA==
X-Received: by 2002:a17:907:724a:b0:a9a:345a:6873 with SMTP id a640c23a62f3a-a9de5d0aeb1mr1549062866b.24.1730298763120;
        Wed, 30 Oct 2024 07:32:43 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dfbc7d4sm576821066b.32.2024.10.30.07.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:32:42 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v3 5/9] packfile: pass down repository to `has_object[_kept]_pack`
Date: Wed, 30 Oct 2024 15:32:30 +0100
Message-ID: <1fac06f19e482863cb64d30015c87c42a3993d64.1730297934.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730297934.git.karthik.188@gmail.com>
References: <cover.1730297934.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions `has_object[_kept]_pack` currently rely on the global
variable `the_repository`. To eliminate global variable usage in
`packfile.c`, we should progressively shift the dependency on
the_repository to higher layers. Let's remove its usage from these
functions and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/count-objects.c | 2 +-
 builtin/fsck.c          | 2 +-
 builtin/pack-objects.c  | 4 ++--
 diff.c                  | 3 ++-
 list-objects.c          | 3 ++-
 pack-bitmap.c           | 2 +-
 packfile.c              | 9 +++++----
 packfile.h              | 5 +++--
 prune-packed.c          | 2 +-
 reachable.c             | 2 +-
 revision.c              | 4 ++--
 11 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 04d80887e0..1e89148ed7 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -67,7 +67,7 @@ static int count_loose(const struct object_id *oid, const char *path,
 	else {
 		loose_size += on_disk_bytes(st);
 		loose++;
-		if (verbose && has_object_pack(oid))
+		if (verbose && has_object_pack(the_repository, oid))
 			packed_loose++;
 	}
 	return 0;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7f4e2f0414..bb56eb98ac 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -272,7 +272,7 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (is_promisor_object(&obj->oid))
 			return;
-		if (has_object_pack(&obj->oid))
+		if (has_object_pack(the_repository, &obj->oid))
 			return; /* it is in pack - forget about it */
 		printf_ln(_("missing %s %s"),
 			  printable_type(&obj->oid, obj->type),
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0800714267..ceb7e76b10 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1529,7 +1529,7 @@ static int want_found_object(const struct object_id *oid, int exclude,
 			return 0;
 		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
 			return 0;
-		if (has_object_kept_pack(oid, flags))
+		if (has_object_kept_pack(p->r, oid, flags))
 			return 0;
 	}
 
@@ -3627,7 +3627,7 @@ static void show_cruft_commit(struct commit *commit, void *data)
 
 static int cruft_include_check_obj(struct object *obj, void *data UNUSED)
 {
-	return !has_object_kept_pack(&obj->oid, IN_CORE_KEEP_PACKS);
+	return !has_object_kept_pack(to_pack.repo, &obj->oid, IN_CORE_KEEP_PACKS);
 }
 
 static int cruft_include_check(struct commit *commit, void *data)
diff --git a/diff.c b/diff.c
index dceac20d18..266ddf18e7 100644
--- a/diff.c
+++ b/diff.c
@@ -4041,7 +4041,8 @@ static int reuse_worktree_file(struct index_state *istate,
 	 * objects however would tend to be slower as they need
 	 * to be individually opened and inflated.
 	 */
-	if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
+	if (!FAST_WORKING_DIRECTORY && !want_file &&
+	    has_object_pack(istate->repo, oid))
 		return 0;
 
 	/*
diff --git a/list-objects.c b/list-objects.c
index 985d008799..31236a8dc9 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -41,7 +41,8 @@ static void show_object(struct traversal_context *ctx,
 {
 	if (!ctx->show_object)
 		return;
-	if (ctx->revs->unpacked && has_object_pack(&object->oid))
+	if (ctx->revs->unpacked && has_object_pack(ctx->revs->repo,
+						   &object->oid))
 		return;
 
 	ctx->show_object(object, name, ctx->show_data);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4fa9dfc771..d34ba9909a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1889,7 +1889,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 		bitmap_unset(result, i);
 
 	for (i = 0; i < eindex->count; ++i) {
-		if (has_object_pack(&eindex->objects[i]->oid))
+		if (has_object_pack(the_repository, &eindex->objects[i]->oid))
 			bitmap_unset(result, objects_nr + i);
 	}
 }
diff --git a/packfile.c b/packfile.c
index ce701255dd..3894646573 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2143,16 +2143,17 @@ int find_kept_pack_entry(struct repository *r,
 	return 0;
 }
 
-int has_object_pack(const struct object_id *oid)
+int has_object_pack(struct repository *r, const struct object_id *oid)
 {
 	struct pack_entry e;
-	return find_pack_entry(the_repository, oid, &e);
+	return find_pack_entry(r, oid, &e);
 }
 
-int has_object_kept_pack(const struct object_id *oid, unsigned flags)
+int has_object_kept_pack(struct repository *r, const struct object_id *oid,
+			 unsigned flags)
 {
 	struct pack_entry e;
-	return find_kept_pack_entry(the_repository, oid, flags, &e);
+	return find_kept_pack_entry(r, oid, flags, &e);
 }
 
 int for_each_object_in_pack(struct packed_git *p,
diff --git a/packfile.h b/packfile.h
index 51187f2393..b09fb2c530 100644
--- a/packfile.h
+++ b/packfile.h
@@ -193,8 +193,9 @@ const struct packed_git *has_packed_and_bad(struct repository *, const struct ob
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
 int find_kept_pack_entry(struct repository *r, const struct object_id *oid, unsigned flags, struct pack_entry *e);
 
-int has_object_pack(const struct object_id *oid);
-int has_object_kept_pack(const struct object_id *oid, unsigned flags);
+int has_object_pack(struct repository *r, const struct object_id *oid);
+int has_object_kept_pack(struct repository *r, const struct object_id *oid,
+			 unsigned flags);
 
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
diff --git a/prune-packed.c b/prune-packed.c
index 2bb99c29df..d1c65ab10e 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -24,7 +24,7 @@ static int prune_object(const struct object_id *oid, const char *path,
 {
 	int *opts = data;
 
-	if (!has_object_pack(oid))
+	if (!has_object_pack(the_repository, oid))
 		return 0;
 
 	if (*opts & PRUNE_PACKED_DRY_RUN)
diff --git a/reachable.c b/reachable.c
index 3e9b3dd0a4..09d2c50079 100644
--- a/reachable.c
+++ b/reachable.c
@@ -239,7 +239,7 @@ static int want_recent_object(struct recent_data *data,
 			      const struct object_id *oid)
 {
 	if (data->ignore_in_core_kept_packs &&
-	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS))
+	    has_object_kept_pack(data->revs->repo, oid, IN_CORE_KEEP_PACKS))
 		return 0;
 	return 1;
 }
diff --git a/revision.c b/revision.c
index f5f5b84f2b..d1d152a67b 100644
--- a/revision.c
+++ b/revision.c
@@ -4103,10 +4103,10 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
-	if (revs->unpacked && has_object_pack(&commit->object.oid))
+	if (revs->unpacked && has_object_pack(revs->repo, &commit->object.oid))
 		return commit_ignore;
 	if (revs->no_kept_objects) {
-		if (has_object_kept_pack(&commit->object.oid,
+		if (has_object_kept_pack(revs->repo, &commit->object.oid,
 					 revs->keep_pack_cache_flags))
 			return commit_ignore;
 	}
-- 
2.47.0

