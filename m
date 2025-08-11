Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782814658D
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920041; cv=none; b=MNY2NtN1rcorIm4GWj3kvptf8GueAVSgzoMgcpRtyUrpdCz/fSN68ZHDLsTkYHjL2Z8tSjFDqbWxxKinc+rd1s2Wbuo05W8AY+cPP5kLQ4Abtdj+u4Lr80LfFxiI2e14JxzyPz8SFTfLY23HHBtTKea1qb4dKoFsIVokeY0tR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920041; c=relaxed/simple;
	bh=XXPahg2Wk025+Sdf/kuIN1BXVl7vUXJPkvoGx+B+K0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fv34fxq2FaRUs8ScTpxvsd6N+8yiXeTRajLA5LfYI89Mkgibs2qYW29Y+s6w7MhN2HFu3E6RTBeONPKkGBlHiIR7piy1Y+WI76PSHv+4X9oAD8xp/Q8fYPF52XUbA4kLYtoTjMu3xoRkxW4LMxVE8OPzyqhCO00N1ouw/ddUXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HK1UcEqT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bOqtTD4r; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HK1UcEqT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bOqtTD4r"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 6DC9B1D0008E;
	Mon, 11 Aug 2025 09:47:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Aug 2025 09:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754920037;
	 x=1755006437; bh=avvw0XVXv61IlPY4JCLpr20Jd7A/wP96XuvIPTGTd3U=; b=
	HK1UcEqT0xzAFC4DTFsNtb5JX8F2krjwcDF8oGwzvq16X8XQGOC1Qj6aqbYv8pn0
	rDC832MJJM/sbK0bHmS5Rj4FKLKaotcVjHSnNmCA10RwxzHXnmSnaNhluFAWBmk9
	IHzza3rgiUbJ8VVYf0xyh+piU6xTtJpGZnqoFkBrZLgemytYYFG1O9h7jG+/joOx
	m+QLhBDzpC3DG+Uf9wca2yW1jZfuBjU49yoN9cJvrPWLHnpK5faQND20gPajawz1
	yiQwdlQ0c2ZTR5e8HHNt7dRw1S6p8fT8XiQNjrnJqvL1vvKfAcPw0ZkBVqTu3KqI
	8eLtRP5yHUW61fL+xuosxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754920037; x=
	1755006437; bh=avvw0XVXv61IlPY4JCLpr20Jd7A/wP96XuvIPTGTd3U=; b=b
	OqtTD4rySDqh623VCBNWtM7qyk+ZMFzVNjrcoTgPHBU7N3lAefwdOPGijhCc+69Y
	FmHMjBLLavnh1wvLaE+km0iYxanRHCACMjQdoMc4BGL9YEPJKrEe8LJzYH/2C93n
	nzJ7XE1ahXTeuC7Fy99+GYsC033Pif7uM9bIV8c9Fnx3xRwsFDCHpafxQ2UaG80m
	khBz58Jvjz5s166UMShlj3XDwNOrj6unwP8ghPKFRilxvZvKSGmb3kWTyeeHngGE
	86OPKCM/YMsvDMoDwcYijHhBl3g/ZvCBm4J6fEpvEMKIpDk+w3m3vMTy9A/+W+d9
	pZ1OgkM3A6V/BoayN2ejw==
X-ME-Sender: <xms:ZfSZaCuqgcDmoeCKS47M-Q59LL1gJnxMk02AlH72bkox-oPLiXJhlA>
    <xme:ZfSZaC-pzkI2wIGMZc5yQ6FJKZBYV2Ws4hOQY5QsE4Vm2rDyWLZ8PmqaDO4g1h0tJ
    qvStFxF-Tl-uZ8fnw>
X-ME-Received: <xmr:ZfSZaENt81xwqAqxAFDdsUtlkUpdgto2fwV13Yspa9DWclD15ZkfX8HiT_VcaOspzgwoNRGbFAIaN30E7V8ywT3k1rHq-BEjbMBc9t-8YTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:ZfSZaIF0qVBXOOp2WFy4z5WmOagNqG1h75a_F6_p4aKx0m8y2KkGPA>
    <xmx:ZfSZaKTaut9gcl7rDLsj_NvTZw7l502r3vfWa9oWkEuVRGOyc0a0sg>
    <xmx:ZfSZaNu3Z0D7Fh7s0zlP0RFVW8YjI01N4rZw6hOsPBKQsOV_g_lrow>
    <xmx:ZfSZaKJLrfqH6uK0xvDQIU1_aRGRG5gcE8aFKwDLwnOa3dYXP-34Pg>
    <xmx:ZfSZaKD_E-jp_fjx-F7NbOCqWP3lRxs7sJeZjGVAKHLIKC0zr96wN565>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:47:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28f412ff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 13:47:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Aug 2025 15:46:49 +0200
Subject: [PATCH v3 09/10] midx: stop duplicating info redundant with its
 owning source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-b4-pks-midx-deduplicate-source-info-v3-9-e442bdf2b4ad@pks.im>
References: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
In-Reply-To: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>, 
 Derrick Stolee <stolee@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Multi-pack indices store some information that is redundant with their
owning source:

  - The locality bit that tracks whether the source is the primary
    object source or an alternate.

  - The object directory path the multi-pack index is located in.

  - The pointer to the owning parent directory.

All of this information is already contained in `struct odb_source`. So
now that we always have that struct available when loading a multi-pack
index we have it readily accessible.

Drop the redundant information and instead store a pointer to the object
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c          |  5 +++--
 midx-write.c              |  9 +++++----
 midx.c                    | 21 +++++++++++----------
 midx.h                    |  7 ++-----
 pack-bitmap.c             | 13 +++++++------
 pack-revindex.c           | 14 +++++++-------
 t/helper/test-read-midx.c |  2 +-
 7 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 94dec26f18..5af3e27357 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -223,9 +223,10 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct multi_pack_index *m = get_multi_pack_index(the_repository->objects->sources);
+	struct odb_source *source = the_repository->objects->sources;
+	struct multi_pack_index *m = get_multi_pack_index(source);
 	strbuf_addf(&buf, "%s.pack", base_name);
-	if (m && m->local && midx_contains_pack(m, buf.buf))
+	if (m && source->local && midx_contains_pack(m, buf.buf))
 		clear_midx_file(the_repository);
 	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
diff --git a/midx-write.c b/midx-write.c
index bf7c01d4b1..84f76856d6 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -981,10 +981,11 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
 		const unsigned char *hash = get_midx_checksum(m);
 
-		get_midx_filename_ext(m->repo->hash_algo, &from, m->object_dir,
+		get_midx_filename_ext(m->source->odb->repo->hash_algo, &from,
+				      m->source->path,
 				      hash, midx_exts[i].non_split);
-		get_split_midx_filename_ext(m->repo->hash_algo, &to,
-					    m->object_dir, hash,
+		get_split_midx_filename_ext(m->source->odb->repo->hash_algo, &to,
+					    m->source->path, hash,
 					    midx_exts[i].split);
 
 		if (link(from.buf, to.buf) < 0 && errno != ENOENT) {
@@ -1109,7 +1110,7 @@ static int write_midx_internal(struct odb_source *source,
 			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
 				error(_("could not load reverse index for MIDX %s"),
 				      hash_to_hex_algop(get_midx_checksum(m),
-							m->repo->hash_algo));
+							m->source->odb->repo->hash_algo));
 				result = 1;
 				goto cleanup;
 			}
diff --git a/midx.c b/midx.c
index 831a7e9b5f..81bf3c4d5f 100644
--- a/midx.c
+++ b/midx.c
@@ -26,7 +26,7 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 {
-	return m->data + m->data_len - m->repo->hash_algo->rawsz;
+	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
 }
 
 void get_midx_filename(const struct git_hash_algo *hash_algo,
@@ -128,11 +128,10 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	FLEX_ALLOC_STR(m, object_dir, source->path);
+	CALLOC_ARRAY(m, 1);
 	m->data = midx_map;
 	m->data_len = midx_size;
-	m->local = source->local;
-	m->repo = r;
+	m->source = source;
 
 	m->signature = get_be32(m->data);
 	if (m->signature != MIDX_SIGNATURE)
@@ -446,7 +445,7 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
 int prepare_midx_pack(struct multi_pack_index *m,
 		      uint32_t pack_int_id)
 {
-	struct repository *r = m->repo;
+	struct repository *r = m->source->odb->repo;
 	struct strbuf pack_name = STRBUF_INIT;
 	struct strbuf key = STRBUF_INIT;
 	struct packed_git *p;
@@ -458,7 +457,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
 	if (m->packs[pack_int_id])
 		return 0;
 
-	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
+	strbuf_addf(&pack_name, "%s/pack/%s", m->source->path,
 		    m->pack_names[pack_int_id]);
 
 	/* pack_map holds the ".pack" name, but we have the .idx */
@@ -469,7 +468,8 @@ int prepare_midx_pack(struct multi_pack_index *m,
 					strhash(key.buf), key.buf,
 					struct packed_git, packmap_ent);
 	if (!p) {
-		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
+		p = add_packed_git(r, pack_name.buf, pack_name.len,
+				   m->source->local);
 		if (p) {
 			install_packed_git(r, p);
 			list_add_tail(&p->mru, &r->objects->packed_git_mru);
@@ -528,7 +528,8 @@ int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
 		     uint32_t *result)
 {
 	int ret = bsearch_hash(oid->hash, m->chunk_oid_fanout,
-			       m->chunk_oid_lookup, m->repo->hash_algo->rawsz,
+			       m->chunk_oid_lookup,
+			       m->source->odb->repo->hash_algo->rawsz,
 			       result);
 	if (result)
 		*result += m->num_objects_in_base;
@@ -559,7 +560,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	n = midx_for_object(&m, n);
 
 	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n),
-		m->repo->hash_algo);
+		m->source->odb->repo->hash_algo);
 	return oid;
 }
 
@@ -734,7 +735,7 @@ int prepare_multi_pack_index_one(struct odb_source *source)
 
 int midx_checksum_valid(struct multi_pack_index *m)
 {
-	return hashfile_checksum_valid(m->repo->hash_algo,
+	return hashfile_checksum_valid(m->source->odb->repo->hash_algo,
 				       m->data, m->data_len);
 }
 
diff --git a/midx.h b/midx.h
index d162001fbb..71dbdec66e 100644
--- a/midx.h
+++ b/midx.h
@@ -35,6 +35,8 @@ struct odb_source;
 	"GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL"
 
 struct multi_pack_index {
+	struct odb_source *source;
+
 	const unsigned char *data;
 	size_t data_len;
 
@@ -50,7 +52,6 @@ struct multi_pack_index {
 	uint32_t num_objects;
 	int preferred_pack_idx;
 
-	int local;
 	int has_chain;
 
 	const unsigned char *chunk_pack_names;
@@ -71,10 +72,6 @@ struct multi_pack_index {
 
 	const char **pack_names;
 	struct packed_git **packs;
-
-	struct repository *repo;
-
-	char object_dir[FLEX_ARRAY];
 };
 
 #define MIDX_PROGRESS     (1 << 0)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index fb0b11ca07..01e14c34bd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -216,7 +216,7 @@ static uint32_t bitmap_num_objects(struct bitmap_index *index)
 static struct repository *bitmap_repo(struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git))
-		return bitmap_git->midx->repo;
+		return bitmap_git->midx->source->odb->repo;
 	return bitmap_git->pack->repo;
 }
 
@@ -418,13 +418,13 @@ char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (midx->has_chain)
-		get_split_midx_filename_ext(midx->repo->hash_algo, &buf,
-					    midx->object_dir,
+		get_split_midx_filename_ext(midx->source->odb->repo->hash_algo, &buf,
+					    midx->source->path,
 					    get_midx_checksum(midx),
 					    MIDX_EXT_BITMAP);
 	else
-		get_midx_filename_ext(midx->repo->hash_algo, &buf,
-				      midx->object_dir, get_midx_checksum(midx),
+		get_midx_filename_ext(midx->source->odb->repo->hash_algo, &buf,
+				      midx->source->path, get_midx_checksum(midx),
 				      MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
@@ -463,7 +463,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
-		get_midx_filename(midx->repo->hash_algo, &buf, midx->object_dir);
+		get_midx_filename(midx->source->odb->repo->hash_algo, &buf,
+				  midx->source->path);
 		trace2_data_string("bitmap", bitmap_repo(bitmap_git),
 				   "ignoring extra midx bitmap file", buf.buf);
 		close(fd);
diff --git a/pack-revindex.c b/pack-revindex.c
index 0cc422a1e6..b206518dcb 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -379,25 +379,25 @@ int load_midx_revindex(struct multi_pack_index *m)
 		 * not want to accidentally call munmap() in the middle of the
 		 * MIDX.
 		 */
-		trace2_data_string("load_midx_revindex", m->repo,
+		trace2_data_string("load_midx_revindex", m->source->odb->repo,
 				   "source", "midx");
 		m->revindex_data = (const uint32_t *)m->chunk_revindex;
 		return 0;
 	}
 
-	trace2_data_string("load_midx_revindex", m->repo,
+	trace2_data_string("load_midx_revindex", m->source->odb->repo,
 			   "source", "rev");
 
 	if (m->has_chain)
-		get_split_midx_filename_ext(m->repo->hash_algo, &revindex_name,
-					    m->object_dir, get_midx_checksum(m),
+		get_split_midx_filename_ext(m->source->odb->repo->hash_algo, &revindex_name,
+					    m->source->path, get_midx_checksum(m),
 					    MIDX_EXT_REV);
 	else
-		get_midx_filename_ext(m->repo->hash_algo, &revindex_name,
-				      m->object_dir, get_midx_checksum(m),
+		get_midx_filename_ext(m->source->odb->repo->hash_algo, &revindex_name,
+				      m->source->path, get_midx_checksum(m),
 				      MIDX_EXT_REV);
 
-	ret = load_revindex_from_disk(m->repo->hash_algo,
+	ret = load_revindex_from_disk(m->source->odb->repo->hash_algo,
 				      revindex_name.buf,
 				      m->num_objects,
 				      &m->revindex_map,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index bcb8ea7671..6de5d1665a 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -66,7 +66,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 	for (i = 0; i < m->num_packs; i++)
 		printf("%s\n", m->pack_names[i]);
 
-	printf("object-dir: %s\n", m->object_dir);
+	printf("object-dir: %s\n", m->source->path);
 
 	if (show_objects) {
 		struct object_id oid;

-- 
2.51.0.rc1.163.g2494970778.dirty

