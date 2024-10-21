Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5EE1E5716
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504697; cv=none; b=N4fk58X+yB1zIfjlbXFJdzzSzTCYQtroxa41UwtSFFU6aO9vMunpqfpEf8J3dbY8tK1RDkrl0jfJB/cxyKvrNoZJDbJEJEkT7taPpbL2z9TgbhllV14T8PdTwZ/dSBq4WskQqIim788byif2imw6a7Q/vJY3YtAlqgGUQ1qQcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504697; c=relaxed/simple;
	bh=jK5Ud3UjBkMfpSOSLo6sp4JhblnX8Eu+mMUdU4nqX9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpZ//7QtK5MqUi1f051xUha5vG+zd5lVqukXbiagpFv00HaDYx5J9pzbGzX8vLZVUXuEB5bUCbW+/l7LtjJVc24UoTHb0LKlnLtIJ3AykqPiwxOc3PZ0CrBRTdWXB3hLdXlph5K1tQSqDrX4C4dTlJsuHJ8crP7r1Af5+xuOIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfpL6eYn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfpL6eYn"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86e9db75b9so557231466b.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504693; x=1730109493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVsxLA3IKQXCOUU+AB2r86BKiNH8MPzO1dv5XX2J17w=;
        b=dfpL6eYnz6MTZRwrx471NinnuXtc8r43W0bvwxPb3inKwNULzC1522ZeOzGcgAnOH5
         ErEW7LpHV2MqN+DWM3oCPamgH8b7J3yPxv2yQvzMjlmoYxUeF/HQEKSzS1Xu4m/qF4IS
         s1ug5Pj5IanqnWOYDpZ6a3AnDuRfKAWhfE9X/qBb3i7iCnkhN3XXCtoNT/LA0lhgx8I5
         9Wb8nzW6g2hNU2vVCO33o3JgwbIEeVixQDOwEJiV6fWX/T42mLAVitPNuHn0Jo5psFG4
         s3nhjL5AWadsupnez74Qas8/EvDHalpIKbuVvLEt0rGWkSy5RwKIE1Hs+EU6Wa28u6av
         bIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504693; x=1730109493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVsxLA3IKQXCOUU+AB2r86BKiNH8MPzO1dv5XX2J17w=;
        b=KkBz6D9GA8Ipz94b0Mtw8K8GmjRtUn6TKvDY/8+wDjC+yxnJhbF9823llTy8LGdsu+
         wgIk6G3oKYxUR2wiUdi2HQT+AWjYY7WR7+GEs0WiWRFELvkpIHZWmIG4WV18JvOxc9Br
         BNQJqT+IuH5HWiciwzE7pEmNPV4Px5NSQIlshs6VCxcTCPI4l/UurkoxNG4OA9J3ZYW7
         J0CFWFJqi4CgXTQVfXraflw8/WnEU2GnJ6CrxNjtikqbsQIRtEe5eIrb4hn25urqsPTd
         VF+Q9XkvwOX6ljZFfBh38zUqbdwIz90Bmd2REFgz3mLVc10hTvD7eQraPXU++ckLDd+l
         /0hw==
X-Gm-Message-State: AOJu0YyWx0OwPeGZntYAo6LLWoOUnnWJ7BXEXR4m+FGH5hccmB5iYt4t
	8vorZL+hEuJEL6j5xJ5mSQf9Y4a0n8zzGhRXuvrmGZCq2oYHi6qh6XIIhBbu
X-Google-Smtp-Source: AGHT+IEhy6L5CTPObrnUA7N8oFIFF0wIbshU4GWLsvovDX+H0n2S+OP4gkER6u01yvSiSn+VMlXitg==
X-Received: by 2002:a17:907:3a95:b0:a9a:80f9:d4e0 with SMTP id a640c23a62f3a-a9a80f9d8bamr550164066b.34.1729504693089;
        Mon, 21 Oct 2024 02:58:13 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:12 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 09/20] packfile: pass down repository to `nth_packed_object_id`
Date: Mon, 21 Oct 2024 11:57:52 +0200
Message-ID: <4f72ad569d004bc1401087254277b40301035106.1729504641.git.karthik.188@gmail.com>
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

The function `nth_packed_object_id` currently relies on the global
variable `the_repository`. To eliminate global variable usage in
`packfile.c`, we should progressively shift the dependency on
the_repository to higher layers. Let's remove its usage from this
function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/pack-objects.c      |  6 +++---
 midx-write.c                |  2 +-
 object-name.c               |  8 ++++----
 pack-bitmap.c               |  2 +-
 pack-check.c                |  2 +-
 packfile.c                  | 21 ++++++++++-----------
 packfile.h                  |  3 ++-
 t/helper/test-pack-mtimes.c |  2 +-
 8 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c2555d4986..adf55d892f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1059,7 +1059,7 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 				    (uintmax_t)base_offset,
 				    reuse_packfile->pack_name);
 
-			nth_packed_object_id(&base_oid, reuse_packfile,
+			nth_packed_object_id(the_repository, &base_oid, reuse_packfile,
 					     pack_pos_to_index(reuse_packfile, base_pos));
 
 			len = encode_in_pack_object_header(header, sizeof(header),
@@ -2141,7 +2141,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 				uint32_t pos;
 				if (offset_to_pack_pos(p, ofs, &pos) < 0)
 					goto give_up;
-				if (!nth_packed_object_id(&base_ref, p,
+				if (!nth_packed_object_id(the_repository, &base_ref, p,
 							  pack_pos_to_index(p, pos)))
 					have_base = 1;
 			}
@@ -4036,7 +4036,7 @@ static void loosen_unused_packed_objects(void)
 			die(_("cannot open pack index"));
 
 		for (i = 0; i < p->num_objects; i++) {
-			nth_packed_object_id(&oid, p, i);
+			nth_packed_object_id(the_repository, &oid, p, i);
 			if (!packlist_find(&to_pack, &oid) &&
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
 			    !loosened_object_can_be_discarded(&oid, p->mtime)) {
diff --git a/midx-write.c b/midx-write.c
index c57726ef94..4696b8326c 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -227,7 +227,7 @@ static void fill_pack_entry(uint32_t pack_int_id,
 			    struct pack_midx_entry *entry,
 			    int preferred)
 {
-	if (nth_packed_object_id(&entry->oid, p, cur_object) < 0)
+	if (nth_packed_object_id(the_repository, &entry->oid, p, cur_object) < 0)
 		die(_("failed to locate object %d in packfile"), cur_object);
 
 	entry->pack_int_id = pack_int_id;
diff --git a/object-name.c b/object-name.c
index c892fbe80a..43023884ef 100644
--- a/object-name.c
+++ b/object-name.c
@@ -188,7 +188,7 @@ static void unique_in_pack(struct packed_git *p,
 	 */
 	for (i = first; i < num && !ds->ambiguous; i++) {
 		struct object_id oid;
-		nth_packed_object_id(&oid, p, i);
+		nth_packed_object_id(ds->repo, &oid, p, i);
 		if (!match_hash(len, ds->bin_pfx.hash, oid.hash))
 			break;
 		update_candidates(ds, &oid);
@@ -776,14 +776,14 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	 */
 	mad->init_len = 0;
 	if (!match) {
-		if (!nth_packed_object_id(&oid, p, first))
+		if (!nth_packed_object_id(mad->repo, &oid, p, first))
 			extend_abbrev_len(&oid, mad);
 	} else if (first < num - 1) {
-		if (!nth_packed_object_id(&oid, p, first + 1))
+		if (!nth_packed_object_id(mad->repo, &oid, p, first + 1))
 			extend_abbrev_len(&oid, mad);
 	}
 	if (first > 0) {
-		if (!nth_packed_object_id(&oid, p, first - 1))
+		if (!nth_packed_object_id(mad->repo, &oid, p, first - 1))
 			extend_abbrev_len(&oid, mad);
 	}
 	mad->init_len = mad->cur_len;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d959e30682..96716c785b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -318,7 +318,7 @@ static int nth_bitmap_object_oid(struct bitmap_index *index,
 {
 	if (index->midx)
 		return nth_midxed_object_oid(oid, index->midx, n) ? 0 : -1;
-	return nth_packed_object_id(oid, index->pack, n);
+	return nth_packed_object_id(the_repository, oid, index->pack, n);
 }
 
 static int load_bitmap_entries_v1(struct bitmap_index *index)
diff --git a/pack-check.c b/pack-check.c
index e2c3b264e7..a5551809c1 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -111,7 +111,7 @@ static int verify_packfile(struct repository *r,
 		off_t curpos;
 		int data_valid;
 
-		if (nth_packed_object_id(&oid, p, entries[i].nr) < 0)
+		if (nth_packed_object_id(r, &oid, p, entries[i].nr) < 0)
 			BUG("unable to get oid of object %lu from %s",
 			    (unsigned long)entries[i].nr, p->pack_name);
 
diff --git a/packfile.c b/packfile.c
index 54f3b9f0a7..92c919d628 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1273,7 +1273,7 @@ static int get_delta_base_oid(struct repository *repo, struct packed_git *p,
 		if (offset_to_pack_pos(p, base_offset, &base_pos) < 0)
 			return -1;
 
-		return nth_packed_object_id(oid, p,
+		return nth_packed_object_id(repo, oid, p,
 					    pack_pos_to_index(p, base_pos));
 	} else
 		return -1;
@@ -1288,7 +1288,7 @@ static int retry_bad_packed_offset(struct repository *r,
 	struct object_id oid;
 	if (offset_to_pack_pos(p, obj_offset, &pos) < 0)
 		return OBJ_BAD;
-	nth_packed_object_id(&oid, p, pack_pos_to_index(p, pos));
+	nth_packed_object_id(r, &oid, p, pack_pos_to_index(p, pos));
 	mark_bad_packed_object(p, &oid);
 	type = oid_object_info(r, &oid, NULL);
 	if (type <= OBJ_NONE)
@@ -1723,7 +1723,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			index_pos = pack_pos_to_index(p, pack_pos);
 			if (check_pack_crc(p, &w_curs, obj_offset, len, index_pos)) {
 				struct object_id oid;
-				nth_packed_object_id(&oid, p, index_pos);
+				nth_packed_object_id(r, &oid, p, index_pos);
 				error("bad packed object CRC for %s",
 				      oid_to_hex(&oid));
 				mark_bad_packed_object(p, &oid);
@@ -1813,7 +1813,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			if (!(offset_to_pack_pos(p, obj_offset, &pos))) {
 				struct object_info oi = OBJECT_INFO_INIT;
 
-				nth_packed_object_id(&base_oid, p,
+				nth_packed_object_id(r, &base_oid, p,
 						     pack_pos_to_index(p, pos));
 				error("failed to read delta base object %s"
 				      " at offset %"PRIuMAX" from %s",
@@ -1917,12 +1917,11 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
 			    index_lookup, index_lookup_width, result);
 }
 
-int nth_packed_object_id(struct object_id *oid,
-			 struct packed_git *p,
-			 uint32_t n)
+int nth_packed_object_id(struct repository *repo, struct object_id *oid,
+			 struct packed_git *p, uint32_t n)
 {
 	const unsigned char *index = p->index_data;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = repo->hash_algo->rawsz;
 	if (!index) {
 		if (open_pack_index(p))
 			return -1;
@@ -1933,11 +1932,11 @@ int nth_packed_object_id(struct object_id *oid,
 	index += 4 * 256;
 	if (p->index_version == 1) {
 		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4),
-			the_repository->hash_algo);
+			repo->hash_algo);
 	} else {
 		index += 8;
 		oidread(oid, index + st_mult(hashsz, n),
-			the_repository->hash_algo);
+			repo->hash_algo);
 	}
 	return 0;
 }
@@ -2194,7 +2193,7 @@ int for_each_object_in_pack(struct packed_git *p,
 		else
 			index_pos = i;
 
-		if (nth_packed_object_id(&oid, p, index_pos) < 0)
+		if (nth_packed_object_id(the_repository, &oid, p, index_pos) < 0)
 			return error("unable to get sha1 of object %u in %s",
 				     index_pos, p->pack_name);
 
diff --git a/packfile.h b/packfile.h
index 050dc516b1..f744af6e9b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -150,7 +150,8 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
  * parameter. Open the index if it is not already open.  Returns 0 on success,
  * negative otherwise.
  */
-int nth_packed_object_id(struct object_id *, struct packed_git *, uint32_t n);
+int nth_packed_object_id(struct repository *repo, struct object_id *,
+			 struct packed_git *, uint32_t n);
 
 /*
  * Return the offset of the nth object within the specified packfile.
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index f8f9afbb5b..ebd980b308 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -16,7 +16,7 @@ static void dump_mtimes(struct packed_git *p)
 
 	for (i = 0; i < p->num_objects; i++) {
 		struct object_id oid;
-		if (nth_packed_object_id(&oid, p, i) < 0)
+		if (nth_packed_object_id(the_repository, &oid, p, i) < 0)
 			die("could not load object id at position %"PRIu32, i);
 
 		printf("%s %"PRIu32"\n",
-- 
2.47.0

