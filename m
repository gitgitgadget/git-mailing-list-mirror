Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F331E5738
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504700; cv=none; b=OyfmYMU2TVm1Jy00kGQEha/iDGe15/1dyxjrKtjLlITT9sGQYvAFhqwR1Z7vlKCaLO6zzlxpj8mSZGFbN1VFdmYMAEmg1xusqNArJ57cTpaHKgHj0Z6FGN9cgjAQBrjDg6R9oIsLC1gZJApIx8DzCTVjWS8pf1i+5hrPfcg/u3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504700; c=relaxed/simple;
	bh=3kCL4rieV6vIfPfDYMBuusTPWhwkNli0KVmsazh7hSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei/QhVAbelasxStovn8VoGwxOo6KDMrTCRPxmtkeAGZXIs0ubFLqpppsTQ+OUPC4aQEoXFKEwLKATjvH0m2nSAmtucY3eFzyW8XeaH7frz9fZWTdA5SgXcpSs5xOGedfrh45sFuC4ASy30T28JxqUO59yF/x8BmvNA7B1YxFx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2ar3lr5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2ar3lr5"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99f646ff1bso530123366b.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504697; x=1730109497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh39RwmTAv2Bn5DC37bJn6fA/uJ2zI7NaObHR8NVp5U=;
        b=B2ar3lr5h09F6XvpfiR8zQdgeobnr2aJcEJUR6/2Mh33SJqTWsTkC+8YpMKZIqp+8C
         kYENSBzUcGh5Yz6AYR4YOJ8joI2H4Jvwco7lAgEXV2p2jUynRkqhKS2wozFGnvbpimzc
         YcLv9y1mRgMllQnsEIl31E42FQM/J8bXW/viBmaEZ2wY9brU3Xb2KFdX3R9enNb5+2ri
         cUFRo1Yw/Q/FhWoU2LeM8cSqTW7bSMO1n9IxcyQT10Zq9J7Zxx6tkKEWfVq6stPwD3p6
         38VyTDzwXZVnnw2/nEa6IBgn+QzzOX7QOdgNGYPoIc21z3uL0KNo2Q/fYaBzSevsYSnB
         KkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504697; x=1730109497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh39RwmTAv2Bn5DC37bJn6fA/uJ2zI7NaObHR8NVp5U=;
        b=q1JNYAWV4sueRAyUgtKvGWqnQ/IUsbJnZ8tXLEXmB8Uk/N7BQxtccclC2MNn6mEEFU
         PJBhoOVxR2k7AC2WTPS4hb6MAR6lQAS3+TmyR47g2qOBBSD+DpkenI/lz+fGgtwQxh5u
         M+4B/kLSXZZ91l74MfhWld5FoZOp4LyouOjYtddxWy+azYZ+Q60yAhSfwatBCD/AKAcb
         tOM5wl5pqzwSKiNyMZXeDdH+JuXIJCA9Qjrm/L9h2xTe8r7yUBUOYVa22V4xX442o3Ga
         gi7+2LPPiJUhLv3gS0X/5hlpNMrL2Psd4AyYHL4CnOWg8bOu46r1UHncaC+zKal8cIrd
         PvCQ==
X-Gm-Message-State: AOJu0YzhR5JbAN4dNNeo+E587uEr4Aow0yGPz60dRDyNeOZ9E5BNn5gD
	/KExEF4cuQS3b7KjdE0wWQaUzslnKetOXEozbOAJ6ejbXEbxqJ0N7n1P2EXu
X-Google-Smtp-Source: AGHT+IFjuz+ujx3B6aKJI1mwwX14mKYXeI45K9KSzA1RRI8sqoT2gxtWhmn1K1p4ArVPzUdT3OOR6A==
X-Received: by 2002:a17:907:2d86:b0:a9a:29a9:70bb with SMTP id a640c23a62f3a-a9a69a7866amr988477266b.14.1729504696554;
        Mon, 21 Oct 2024 02:58:16 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 13/20] packfile: pass down repository to `for_each_packed_object`
Date: Mon, 21 Oct 2024 11:57:56 +0200
Message-ID: <9e4624440e64c3d373dfd58b3d191467dc050e99.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `for_each_packed_object` currently relies on the global
variable `the_repository`. To eliminate global variable usage in
`packfile.c`, we should progressively shift the dependency on
the_repository to higher layers. Let's remove its usage from this
function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c     |  9 +++++++--
 builtin/fsck.c         | 10 ++++++++--
 builtin/pack-objects.c |  8 ++++----
 builtin/repack.c       |  2 +-
 commit-graph.c         |  6 +++---
 object-store-ll.h      |  7 ++++---
 packfile.c             | 20 +++++++++++---------
 reachable.c            |  2 +-
 revision.c             |  2 +-
 9 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bfdfb51c7c..f6afe67bef 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -827,7 +827,9 @@ static int batch_objects(struct batch_options *opt)
 			cb.seen = &seen;
 
 			for_each_loose_object(batch_unordered_loose, &cb, 0);
-			for_each_packed_object(batch_unordered_packed, &cb,
+			for_each_packed_object(the_repository,
+					       batch_unordered_packed,
+					       &cb,
 					       FOR_EACH_OBJECT_PACK_ORDER);
 
 			oidset_clear(&seen);
@@ -835,7 +837,10 @@ static int batch_objects(struct batch_options *opt)
 			struct oid_array sa = OID_ARRAY_INIT;
 
 			for_each_loose_object(collect_loose_object, &sa, 0);
-			for_each_packed_object(collect_packed_object, &sa, 0);
+			for_each_packed_object(the_repository,
+					       collect_packed_object,
+					       &sa,
+					       0);
 
 			oid_array_for_each_unique(&sa, batch_object_cb, &cb);
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index bb56eb98ac..ccf6a8eab2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -391,7 +391,10 @@ static void check_connectivity(void)
 		 * traversal.
 		 */
 		for_each_loose_object(mark_loose_unreachable_referents, NULL, 0);
-		for_each_packed_object(mark_packed_unreachable_referents, NULL, 0);
+		for_each_packed_object(the_repository,
+				       mark_packed_unreachable_referents,
+				       NULL,
+				       0);
 	}
 
 	/* Look up all the requirements, warn about missing objects.. */
@@ -966,7 +969,10 @@ int cmd_fsck(int argc,
 
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
-		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
+		for_each_packed_object(the_repository,
+				       mark_packed_for_connectivity,
+				       NULL,
+				       0);
 	} else {
 		prepare_alt_odb(the_repository);
 		for (odb = the_repository->objects->odb; odb; odb = odb->next)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 321e77ebf3..4b91dc0add 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3540,9 +3540,8 @@ static void read_packs_list_from_stdin(void)
 
 	for_each_string_list_item(item, &include_packs) {
 		struct packed_git *p = item->util;
-		for_each_object_in_pack(p,
-					add_object_entry_from_pack,
-					&revs,
+		for_each_object_in_pack(the_repository, p,
+					add_object_entry_from_pack, &revs,
 					FOR_EACH_OBJECT_PACK_ORDER);
 	}
 
@@ -3929,7 +3928,8 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
 
 static void add_objects_in_unpacked_packs(void)
 {
-	if (for_each_packed_object(add_object_in_unpacked_pack, NULL,
+	if (for_each_packed_object(the_repository,
+				   add_object_in_unpacked_pack, NULL,
 				   FOR_EACH_OBJECT_PACK_ORDER |
 				   FOR_EACH_OBJECT_LOCAL_ONLY |
 				   FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
diff --git a/builtin/repack.c b/builtin/repack.c
index d6bb37e84a..96a4fa234b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -404,7 +404,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	 * {type -> existing pack order} ordering when computing deltas instead
 	 * of a {type -> size} ordering, which may produce better deltas.
 	 */
-	for_each_packed_object(write_oid, &cmd,
+	for_each_packed_object(the_repository, write_oid, &cmd,
 			       FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (cmd.in == -1) {
diff --git a/commit-graph.c b/commit-graph.c
index 1c333a9c52..8c72c3ac10 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1923,8 +1923,8 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 			ret = error(_("error opening index for %s"), packname.buf);
 			goto cleanup;
 		}
-		for_each_object_in_pack(p, add_packed_commits, ctx,
-					FOR_EACH_OBJECT_PACK_ORDER);
+		for_each_object_in_pack(the_repository, p, add_packed_commits,
+					ctx, FOR_EACH_OBJECT_PACK_ORDER);
 		close_pack(p);
 		free(p);
 	}
@@ -1960,7 +1960,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 		ctx->progress = start_delayed_progress(
 			_("Finding commits for commit graph among packed objects"),
 			ctx->approx_nr_objects);
-	for_each_packed_object(add_packed_commits, ctx,
+	for_each_packed_object(the_repository, add_packed_commits, ctx,
 			       FOR_EACH_OBJECT_PACK_ORDER);
 	if (ctx->progress_done < ctx->approx_nr_objects)
 		display_progress(ctx->progress, ctx->approx_nr_objects);
diff --git a/object-store-ll.h b/object-store-ll.h
index 53b8e693b1..710130cd06 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -542,10 +542,11 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
-int for_each_object_in_pack(struct packed_git *p,
+int for_each_object_in_pack(struct repository *repo,
+			    struct packed_git *p,
 			    each_packed_object_fn, void *data,
 			    enum for_each_object_flags flags);
-int for_each_packed_object(each_packed_object_fn, void *,
-			   enum for_each_object_flags flags);
+int for_each_packed_object(struct repository *repo, each_packed_object_fn,
+			   void *, enum for_each_object_flags flags);
 
 #endif /* OBJECT_STORE_LL_H */
diff --git a/packfile.c b/packfile.c
index 6bc7b6e9eb..aea8e9f429 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2161,7 +2161,8 @@ int has_pack_index(struct repository *repo, const unsigned char *sha1)
 	return 1;
 }
 
-int for_each_object_in_pack(struct packed_git *p,
+int for_each_object_in_pack(struct repository *repo,
+			    struct packed_git *p,
 			    each_packed_object_fn cb, void *data,
 			    enum for_each_object_flags flags)
 {
@@ -2169,7 +2170,7 @@ int for_each_object_in_pack(struct packed_git *p,
 	int r = 0;
 
 	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
-		if (load_pack_revindex(the_repository, p))
+		if (load_pack_revindex(repo, p))
 			return -1;
 	}
 
@@ -2194,7 +2195,7 @@ int for_each_object_in_pack(struct packed_git *p,
 		else
 			index_pos = i;
 
-		if (nth_packed_object_id(the_repository, &oid, p, index_pos) < 0)
+		if (nth_packed_object_id(repo, &oid, p, index_pos) < 0)
 			return error("unable to get sha1 of object %u in %s",
 				     index_pos, p->pack_name);
 
@@ -2205,15 +2206,15 @@ int for_each_object_in_pack(struct packed_git *p,
 	return r;
 }
 
-int for_each_packed_object(each_packed_object_fn cb, void *data,
-			   enum for_each_object_flags flags)
+int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
+			   void *data, enum for_each_object_flags flags)
 {
 	struct packed_git *p;
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git(the_repository);
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	prepare_packed_git(repo);
+	for (p = get_all_packs(repo); p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
@@ -2229,7 +2230,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
 			pack_errors = 1;
 			continue;
 		}
-		r = for_each_object_in_pack(p, cb, data, flags);
+		r = for_each_object_in_pack(repo, p, cb, data, flags);
 		if (r)
 			break;
 	}
@@ -2298,7 +2299,8 @@ int is_promisor_object(const struct object_id *oid)
 
 	if (!promisor_objects_prepared) {
 		if (repo_has_promisor_remote(the_repository)) {
-			for_each_packed_object(add_promisor_object,
+			for_each_packed_object(the_repository,
+					       add_promisor_object,
 					       &promisor_objects,
 					       FOR_EACH_OBJECT_PROMISOR_ONLY |
 					       FOR_EACH_OBJECT_PACK_ORDER);
diff --git a/reachable.c b/reachable.c
index 09d2c50079..ecf7ccf504 100644
--- a/reachable.c
+++ b/reachable.c
@@ -324,7 +324,7 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 	if (ignore_in_core_kept_packs)
 		flags |= FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS;
 
-	r = for_each_packed_object(add_recent_packed, &data, flags);
+	r = for_each_packed_object(revs->repo, add_recent_packed, &data, flags);
 
 done:
 	oidset_clear(&data.extra_recent_oids);
diff --git a/revision.c b/revision.c
index d1d152a67b..d7913d7608 100644
--- a/revision.c
+++ b/revision.c
@@ -3915,7 +3915,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		revs->treesame.name = "treesame";
 
 	if (revs->exclude_promisor_objects) {
-		for_each_packed_object(mark_uninteresting, revs,
+		for_each_packed_object(revs->repo, mark_uninteresting, revs,
 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
-- 
2.47.0

