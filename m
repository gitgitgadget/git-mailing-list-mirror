Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF71CEAC7
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618672; cv=none; b=VxYKHx+wQ+8wq//Fi+7P5+Tti0Yi3vdE+AW0e64Gtl8KBYpxFntmoh9BKb2M3ZuDXJI69Mx1JxmkyVl0mEQd3S1JMXHyCIoDNsZkpQxATPULwyToLq8Tzb3UDEuSASSDGQNIF8Q3yQPV0bRGNZIkz846Azu1V+u2ut8TKp4tBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618672; c=relaxed/simple;
	bh=qaGGC/h/mhbdPMor0R4nO6l0oLU7vmJ2PqNl4EeyQpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVOs77ZxmC61zVdT4fRF64GQYmG5mCgI6mpIVxNf5D32zstvsGUXmSGu5fQNl66IjPhU2icqKwtdRr2RT8C5/+wQvvWjUko5R47cixjhQhBCpqqSPXPdedHbSZImRA3C5wZQ83h546464oLT/jyCs90afy3Pkqd6dNiw+Jd0gZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT4oATYB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT4oATYB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa52edbcb63so540572266b.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 02:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732618668; x=1733223468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wwTwyZ0lwJvJ0FEJmRcNAc1S3+SrI2Oc833xqu6ox0=;
        b=JT4oATYB3qOZStva4cbTiOBOSTigtmLejHOsp1IJ/6F/ybc6Mzz0QOAd29JSZNNyWt
         IsYkaG3UuE53DyyuVqBNfk5evnBkeQYG62WTD3zyUhA4Klo4DK/EMenZFFUl4Mvdefir
         EJQctwG4uaIOB5KmvuImm91wLFTiexfJKq3L/Iy5/xUUi96ujzBX3a0mD8a/CxNGN2D+
         USDuY9fp/f2hQHPTjav8h02ISGiU0OddXyeyqFAEZzjOFDbAVsOVgmKmIUBftCPhehLV
         oKCFXN5yQt9vEjIRQvFDZc3ArBuwea8xDIheCa9uiYyRmxMY9Tc9jEkZKCRUMDrs5I2Z
         zyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732618668; x=1733223468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wwTwyZ0lwJvJ0FEJmRcNAc1S3+SrI2Oc833xqu6ox0=;
        b=hhXzCPU4lO6XnlMpx5UXHKNdh6s5q6douPFS/SQBOdza1co3gm+FgQYqI6GjDOvMfC
         bAwDDcsrLY00T2UNbHkFKkTzchtVhFM7gEazGuXTjgyp4+1xuZX8572r1SpIYuLdIOwE
         yN0VCWbndD4nm1My1cNdTx3dHNykrd18yYHQfrYeSH1yfp4ZV7pGop2HB13jjFag20kB
         8X7mYUSI+Nb1X6wyHeluaAXmFdGxLylduaRNjk0XyZ5shdFlaeCbTjNeAorYuQIc4ghx
         Ay+vozNZ38OJQJdQr465W708o6a1RznaQ8H0LzB+EOJWaaIpFGDe5AGbsTprZuXF/uhQ
         vcgg==
X-Gm-Message-State: AOJu0Yz3Uf60TDc1HrzNZ7PsoR3LBefLDc8Bjdd3Bv3kvZfiCa+p2r4U
	BR9zkU2dk79MqVs9swOexMfgVZrIm3NBQCE9WvsqnhufTIiAtyc6
X-Gm-Gg: ASbGnctJ7a403VC8CXXUYEX15dWXMVjPQG4OqxpXfs/2PzYkO1MNzk+J2cJCDAgO4I/
	4IIRDL5WjEKs+f54C7eT2p1JbKgMOuKjPQByINPEPwJ7g7WT2AQVzjzIboO1krJcseQtDRl85tH
	EcsSMGIi8az3lYbTR6G/Vvdzrp2v7YFgaRfEa33XFPVxbcoHJeDZrrQNpq4tjFYl4nz9kA6LZsV
	GUa4Zwv1nH8fHlVrVYk1sCZWkq1Kx1p0NnkBoNamwO2pvhrg1YhOhMJMv4vlVM=
X-Google-Smtp-Source: AGHT+IGTxO4gavybwEsj+nnwaQ3OjxBlnzwNG5dn3bJWIpWRIaWi9jWGkxb9ub2M0G3ZJSR1GA85yg==
X-Received: by 2002:a17:907:c992:b0:aa5:3663:64c5 with SMTP id a640c23a62f3a-aa5648b831emr239067966b.22.1732618668577;
        Tue, 26 Nov 2024 02:57:48 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b8c77sm587461366b.187.2024.11.26.02.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:57:48 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v9 05/10] packfile: pass down repository to `has_object[_kept]_pack`
Date: Tue, 26 Nov 2024 11:57:36 +0100
Message-ID: <ee210fa1537bf6de6e03713ac6362298ce121a92.1732618495.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732618495.git.karthik.188@gmail.com>
References: <cover.1732618495.git.karthik.188@gmail.com>
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
index 0800714267..0f32e92a3a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1529,7 +1529,7 @@ static int want_found_object(const struct object_id *oid, int exclude,
 			return 0;
 		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
 			return 0;
-		if (has_object_kept_pack(oid, flags))
+		if (has_object_kept_pack(p->repo, oid, flags))
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
index 1015dac6db..e7dd270217 100644
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

