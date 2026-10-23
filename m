Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740392;
	b=p0i1q3wnKE4P309RzsD6ORn1zg+mlZ4maZMymDsT1zBKj707QrNFGuSklwSwWL6rLEDR
	 KRALglmQwWQyuGqQ9tPe9c4MYfCZ4YZmavqk7dBMri8U+DBf8HKLIw9qfjXGLMqN9AIvo
	 M2Bw5PFBCB7xymmERyyDbw1knHO33Y19w9bC1WkZitpxk4hpBH7Mad8lq2TZlyubrBO7G
	 hizrS3Z/Ca8Fm2ffDU+jlFZvprztwh9hn9KwwgCCJqQVjeiUoLCF8UuEh+TfdgmjAlhaN
	 CCZa2mXOT84QlgRWxP6I3NHPXhF+srL1rslOQtvFJGnS2MN1HFc3wxLkq7FfAUR+hSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cxQr6L9GGmmbYt6GeJwOcN/KU3OT5DkX6Ao5SW+qWOI=;
	b=deV6bG41ed5b2Yg3zrEuRr6VN3PUMLUe8XNnBy9LcBBfDYEeg+Qzt4AmXw71i0uFmwv7
	 p9RDNXySVF/0yRGNeqEPF6qRmqy9zsxZUGw5clBXmEUBOkNa77lXiY1tdtd9D99HJl5UG
	 JnoGe1I8kAGQykgLRch3jHPmSLbxQyNs5HuzX/wKINTs8SxiJP5d6KFXcKo/yGrkDFNyD
	 cVtdjdLpjVZpDthPOSvMBLsVg5ECgN324AyKrt/nl+j/gxwESNW0vSnF8ye18qEq74YQd
	 mgGD9j8rdNw7vS9iIJq7Vw74gyK9aF8nzLGCwX4h1zmzQhInUOVdbIY85wToYPk4OHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q1RGueyK;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A6606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 131A6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q1RGueyK
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso5330775e9.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740390; x=1793345190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cxQr6L9GGmmbYt6GeJwOcN/KU3OT5DkX6Ao5SW+qWOI=;
        b=q1RGueyK+lF4rxKrjuIP/kXxJJwgoV34qBlb6ff3Ccg/yZU0dITXMfaLatd2yEJcQk
         jCmGne0HW+14RObDIQTmulYVOMgA4AgEiIrA2ewrGB4zTan7+qycSQTLIRzLurkP7To+
         KwOtTS07akxBQ/tUagormHF6eEjgkIw7puX1/NILOibtTByOnwAcwJ2xiaSKUzPzHjhN
         9FzstFNpLJVRJZUgxKyPMvHx6KswvxNhx8cVQEJkurTydTn3jbnRYV1J85UZ/jqq72v3
         3EQQO/0KD6bfesNa/BByoeXa2bGZadqD7Y7NjCPGdbLOH4uhSE+fCn4x9LMCrV5ApIMz
         Ce1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740390; x=1793345190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cxQr6L9GGmmbYt6GeJwOcN/KU3OT5DkX6Ao5SW+qWOI=;
        b=jH1GOrVgLJwN/lD0bwb4eDVnwpx02MZYCDsarLsR97XI2BWWiGX/COF1eloQY29ffE
         Qu4pxcvozQhQEBbve1LFTy0eT5Jq3XqLhWwA7n9Y/8MIxRZMcoFa6/oZU1SMuZVD0NCO
         iNkcjwTg1w4L2M/weQv8If1CIsWofOw9DljYse/I0bZMbYFn5//9Ceym36vAz4P4u5iY
         aKE4oI/vVWQxGFojqBqhS/T4l60ek40/xbxXKoGQVlX/cI3SJ+VwelQQiRdtYCL0tcZ7
         JX28mBQHO0Vb0oUa8eZDDji4vqPgFKBBfpivkI3ykvlq3A6kPrvRss904RtFs4WTRrVz
         zWhg==
X-Gm-Message-State: AFq9FYIxEW9I8dVMz1J1VUGWgrhP15lu3tc7mdQaPMpLQuc/Vsfvh3gc
	J+0Xw1+pyV+TeuRLjmZanWhamelySmPjz6m236G1b07iuQtEH8uYZEcggsLsIg==
X-Gm-Gg: AYBFou0xr2gGBwG60C2DuLoESZU55oM2BDzhHjfBUqSZIXe8HpyAj/NS19yJlFgN/t6
	BOfoxOBXkm+amDFuZwQ+hSa7fhglYBe8gxERTPhshApUwPPxPWZg53++YrxObh5yrElSicSV1ei
	CajQ6XiMktkewwaO3K5dx4cw5MrXMHG2luUQTw9sJwmVhirJMG9XdackATsivdu+3QWbqj7o4FN
	n04S1j7p/An/8rXo9A+sqi3LBEM1dyKAbRPpLCMdUcdoshxg2NaSsaRbmi8ZDFt5AO3FhBxrVaF
	xbSsxV9ghTucr5sr5+NnWGSMhycgQPpIbX2kmc5uip4Yhc73mqTtkBPbeUkilNAp84eR8Qz+3Gj
	gyEUX04sn25GOFCeJDp3N+SYH8ai1U4LpreRrHnAD73CNh4Rb8HrqFXfSnapF//v9dwspUO5xR7
	xA6pwpqtR9v1wbipbIC289WfK0QFq2ttCqmCrUmId/4ZcUXa4SUDy+iRoKnEcWview0WP1H/rcb
	3iS4Eo4XPSWAs0Wc6D2Zkkacc35/izwjxp153VVf++rm/blQ3UtMhkopRnhTwFdMQdjKwy2Eb4y
	fTr0mXJabnkE7+E1aX9l/yEFqdN4L8izJZ3rnH+iWDsTLWjSL7qH1YyKHGgVsfD/MG9Pik95o9R
	zDHBGpIfUgGLgeiruui/kFaGA/pmvz+nme0ee7nI7xA8vppc6trY0LuJ+JFOQuvLGNlwq9OmH50
	L2cOMI6gfJNWM=
X-Received: by 2002:a05:600c:8b38:b0:49d:34:420d with SMTP id 5b1f17b1804b1-4a211cbaf90mr19870725e9.20.1792740390157;
        Fri, 23 Oct 2026 00:26:30 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:29 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 09/13] packfile: add support for reading pack index v3
Date: Fri, 23 Oct 2026 09:25:54 +0200
Message-ID: <20261023072559.3204273-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Now that we can write pack index v3, we'll probably also want to read
it.  Let's add support for that by making our bsearch function more
generic to handle lookups of any size and then using that both for older
version and for pack index v3.

To make lookups easier, let's store several offsets we compute from
values per format so we don't need to look them up when reading.  Since
our pack may be larger than 4 GiB, let's make the crc_offset field
larger.  We can then use it when finding the offset into the file, since
it will be generic over both v2 and v3 indices.

A v3 index may contain data for only one hash algorithm, so just fail if
we look up an object ID in an algorithm for which the index has no data.

In the pack revindex, we use the order map for the algorithm in question
to look up the proper offset into the pack index, since we're iterating
over objects in the offset table, which is sorted by object ID, not pack
order.

Let's also update t5302 to generate this new format and disable the old
formats when we're using a compatibility hash algorithm, since the old
formats can't represent the SHA-1 values.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/index-pack.c  |   2 +-
 hash-lookup.c         |  47 +++++++++++++----
 hash-lookup.h         |  19 ++++++-
 pack-check.c          |   4 +-
 pack-revindex.c       |  21 ++++++--
 packfile.c            | 117 +++++++++++++++++++++++++++++++++++++-----
 packfile.h            |  18 +++++++
 t/t5302-pack-index.sh |  71 +++++++++++++------------
 8 files changed, 238 insertions(+), 61 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 723595ae03..4db3f18951 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1841,7 +1841,7 @@ static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 	/* Read the attributes from the existing idx file */
 	opts->version = p->index_version;
 
-	if (opts->version == 2)
+	if (opts->version >= 2)
 		read_v2_anomalous_offsets(p, opts);
 
 	/*
diff --git a/hash-lookup.c b/hash-lookup.c
index 5f808caa51..a77ccad8b5 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -104,18 +104,13 @@ int oid_pos(const struct object_id *oid, const void *table, size_t nr,
 	return index_pos_to_insert_pos(lo);
 }
 
-int bsearch_hash(const unsigned char *hash, const uint32_t *fanout_nbo,
-		 const unsigned char *table, size_t stride, uint32_t *result)
+static int bsearch_hash_1(const unsigned char *hash, const unsigned char *table,
+			  size_t stride, size_t cmpsize, uint32_t hi,
+			  uint32_t lo, uint32_t *result)
 {
-	uint32_t hi, lo;
-
-	hi = ntohl(fanout_nbo[*hash]);
-	lo = ((*hash == 0x0) ? 0 : ntohl(fanout_nbo[*hash - 1]));
-
 	while (lo < hi) {
 		unsigned mi = lo + (hi - lo) / 2;
-		int cmp = hashcmp(table + mi * stride, hash,
-				  the_repository->hash_algo);
+		int cmp = memcmp(table + mi * stride, hash, cmpsize);
 
 		if (!cmp) {
 			if (result)
@@ -132,3 +127,37 @@ int bsearch_hash(const unsigned char *hash, const uint32_t *fanout_nbo,
 		*result = lo;
 	return 0;
 }
+
+int bsearch_hash(const unsigned char *hash, const uint32_t *fanout_nbo,
+		 const unsigned char *table, size_t stride, uint32_t *result)
+{
+	uint32_t hi, lo;
+
+	hi = ntohl(fanout_nbo[*hash]);
+	lo = ((*hash == 0x0) ? 0 : ntohl(fanout_nbo[*hash - 1]));
+
+	return bsearch_hash_1(hash, table, stride, the_hash_algo->rawsz, hi, lo, result);
+}
+
+/* full_oid is assumed to follow directly behind short_oid in memory. */
+int bsearch_hash_v3(const unsigned char *hash, const unsigned char *full_oid,
+		    const uint32_t *pack_map, const unsigned char *short_oid,
+		    size_t stride, size_t hashsz, uint32_t *result)
+{
+	uint32_t obj_off, index;
+	int res = bsearch_hash_1(hash, short_oid, stride, stride, (full_oid - short_oid) / stride,
+				 0, &obj_off);
+	if (result)
+		*result = obj_off;
+	if (!res)
+		return 0;
+	/*
+	 * obj_off is now the offset in the shortened list of object names that
+	 * we've found.  We now need to look it up in the mapping of pack order
+	 * to find the full object ID.  index is the offset in pack order.
+	 */
+	index = ntohl(pack_map[obj_off]);
+	if (!memcmp(hash, full_oid + (hashsz * index), hashsz))
+		return 1;
+	return 0;
+}
diff --git a/hash-lookup.h b/hash-lookup.h
index dbd71ebaf7..03a9be4929 100644
--- a/hash-lookup.h
+++ b/hash-lookup.h
@@ -20,7 +20,7 @@ int oid_pos(const struct object_id *oid,
  *    first byte is less than or equal to i
  *  - table: a sorted list of hashes with optional extra information in between
  *  - stride: distance between two consecutive elements in table (should be
- *    GIT_MAX_RAWSZ or greater)
+ *    GIT_MAX_RAWSZ or less)
  *  - result: if not NULL, this function stores the element index of the
  *    position found (if the search is successful) or the index of the least
  *    element that is greater than hash (if the search is not successful)
@@ -29,4 +29,21 @@ int oid_pos(const struct object_id *oid,
  */
 int bsearch_hash(const unsigned char *hash, const uint32_t *fanout_nbo,
 		 const unsigned char *table, size_t stride, uint32_t *result);
+
+/*
+ * Performs a binary search for hash, returning 1 if it is found and 0 if not.
+ *
+ * - hash is the object ID to search for.
+ * - short_oid is a sorted table of equal-length prefixes of the hashes (each of
+ *   which is stride bytes in length.
+ * - full_oid, which must follow in memory directly behind short_oid, is a list
+ *   of full object IDs in an arbitrary order (usually pack order); each item is
+ *   hashsz bytes in length.
+ * - pack_map is a 4-byte mapping of indices of items in short_oid to full_oid.
+ * - result may be NULL; if not, it is the index of the item in the list of
+ *   object IDs if found and the least element greater than it otherwise.
+ */
+int bsearch_hash_v3(const unsigned char *hash, const unsigned char *full_oid,
+		    const uint32_t *pack_map, const unsigned char *short_oid,
+		    size_t stride, size_t hashsz, uint32_t *result);
 #endif
diff --git a/pack-check.c b/pack-check.c
index c7275f4b92..f69a137a18 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -44,7 +44,9 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	} while (len);
 
 	index_crc = p->index_data;
-	index_crc += 2 + 256 + (size_t)p->num_objects * (p->repo->hash_algo->rawsz/4) + nr;
+	if (p->index_version == 3)
+		nr = nth_packed_object_pack_order_algop(p, nr, p->repo->hash_algo);
+	index_crc += (p->crc_offset / 4) + nr;
 
 	return data_crc != ntohl(*index_crc);
 }
diff --git a/pack-revindex.c b/pack-revindex.c
index 62387ae632..fb81db8033 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -138,11 +138,25 @@ static void create_pack_revindex(struct packed_git *p)
 	const unsigned hashsz = p->repo->hash_algo->rawsz;
 
 	ALLOC_ARRAY(p->revindex, num_ent + 1);
-	index += 4 * 256;
 
-	if (p->index_version > 1) {
+	if (p->index_version == 3) {
 		const uint32_t *off_32 =
-			(uint32_t *)(index + 8 + (size_t)p->num_objects * (hashsz + 4));
+			(uint32_t *)(index + st_add(p->crc_offset, st_mult(p->num_objects, 4)));
+		const uint32_t *off_64 = off_32 + p->num_objects;
+		for (i = 0; i < num_ent; i++) {
+			const uint32_t pack_order = nth_packed_object_pack_order_algop(p, i, p->repo->hash_algo);
+			const uint32_t off = ntohl(off_32[pack_order]);
+			const uint32_t lowoff = off & 0x7fffffff;
+			if (!(off & 0x80000000)) {
+				p->revindex[i].offset = off;
+			} else {
+				p->revindex[i].offset = get_be64(off_64 + st_mult(lowoff, 2));
+			}
+			p->revindex[i].nr = i;
+		}
+	} else if (p->index_version == 2) {
+		const uint32_t *off_32 =
+			(uint32_t *)(index + st_add(p->crc_offset, st_mult(p->num_objects, 4)));
 		const uint32_t *off_64 = off_32 + p->num_objects;
 		for (i = 0; i < num_ent; i++) {
 			const uint32_t off = ntohl(*off_32++);
@@ -155,6 +169,7 @@ static void create_pack_revindex(struct packed_git *p)
 			p->revindex[i].nr = i;
 		}
 	} else {
+		index += 4 * 256;
 		for (i = 0; i < num_ent; i++) {
 			const uint32_t hl = *((uint32_t *)(index + (hashsz + 4) * i));
 			p->revindex[i].offset = ntohl(hl);
diff --git a/packfile.c b/packfile.c
index b32b4cd75d..95207c0e19 100644
--- a/packfile.c
+++ b/packfile.c
@@ -88,7 +88,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 		return -1;
 	}
 	idx_size = xsize_t(st.st_size);
-	if (idx_size < 4 * 256 + hashsz + hashsz) {
+	if (idx_size < hashsz * 3) {
 		close(fd);
 		return error("index file %s is too small", path);
 	}
@@ -109,14 +109,14 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	struct pack_idx_header *hdr = idx_map;
 	uint32_t version, nr, i, *index;
 
-	if (idx_size < 4 * 256 + hashsz + hashsz)
+	if (idx_size < hashsz * 3)
 		return error("index file %s is too small", path);
 	if (!idx_map)
 		return error("empty data");
 
 	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(hdr->idx_version);
-		if (version < 2 || version > 2)
+		if (version < 2 || version > 3)
 			return error("index file %s is version %"PRIu32
 				     " and is not supported by this binary"
 				     " (try upgrading GIT to a newer version)",
@@ -124,15 +124,20 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	} else
 		version = 1;
 
+	if (version < 3 && idx_size < 4 * 256 + hashsz + hashsz)
+		return error("index file %s is too small", path);
+
 	nr = 0;
 	index = idx_map;
 	if (version > 1)
 		index += 2;  /* skip index header */
-	for (i = 0; i < 256; i++) {
-		uint32_t n = ntohl(index[i]);
-		if (n < nr)
-			return error("non-monotonic index %s", path);
-		nr = n;
+	if (version <= 2) {
+		for (i = 0; i < 256; i++) {
+			uint32_t n = ntohl(index[i]);
+			if (n < nr)
+				return error("non-monotonic index %s", path);
+			nr = n;
+		}
 	}
 
 	if (version == 1) {
@@ -174,6 +179,51 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		    (sizeof(off_t) <= 4))
 			return error("pack too large for current definition of off_t in %s", path);
 		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
+	} else if (version == 3) {
+		uint32_t hdrlen, num_formats, trailer_offset, main_algo;
+		const uint32_t *q = index;
+		int i;
+
+		hdrlen = ntohl(*q++);
+		if (idx_size < hdrlen)
+			return error("v3 index has truncated header");
+
+		nr = ntohl(*q++);
+		num_formats = ntohl(*q++);
+		if (num_formats < 1 || num_formats > ARRAY_SIZE(p->formats))
+			return error("too many formats for v3 index");
+		memset(p->formats, 0, sizeof(p->formats));
+		for (i = 0; i < num_formats; i++) {
+			uint32_t format_id = ntohl(*q++);
+			uint32_t format = hash_algo_by_id(format_id);
+			struct packed_git_format *pfp;
+
+			if (format == GIT_HASH_UNKNOWN)
+				return error("v3 index with unknown format_id 0x%08x", format_id);
+			/*
+			 * We store at the value of the constant minus 1 to
+			 * avoid having to store a useless entry at offset 0.
+			 */
+			pfp = &p->formats[format-1];
+
+			pfp->short_name_len = ntohl(*q++);
+			pfp->data_offset = get_be64(q);
+			q += 2;
+
+			pfp->full_oid_offset = pfp->data_offset +
+					       (pfp->short_name_len * nr);
+			pfp->order_map_offset = pfp->full_oid_offset +
+						(hash_algos[format].rawsz * nr);
+			if (!i)
+				p->crc_offset = pfp->order_map_offset + nr * 4;
+		}
+		main_algo = hash_algo_by_length(hashsz);
+		if (main_algo == GIT_HASH_UNKNOWN ||
+		    !p->formats[main_algo - 1].data_offset)
+			return error("v3 index with missing data for this repository's algorithm");
+		trailer_offset = get_be64(q);
+		if (trailer_offset + 2 * hashsz != idx_size)
+			return error("v3 index with bad size\n");
 	}
 
 	p->index_version = version;
@@ -1730,6 +1780,26 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 	return data;
 }
 
+static int bsearch_pack_v3(const struct object_id *oid, const struct packed_git *p, uint32_t *result)
+{
+	int algo = oid->algo ? oid->algo : hash_algo_by_ptr(p->repo->hash_algo);
+	const struct packed_git_format *pfp = &p->formats[algo - 1];
+	const unsigned char *data = p->index_data;
+
+	/* This index has no data for the algorithm of the object ID. */
+	if (!pfp->data_offset) {
+		if (result)
+			*result = 0;
+		return 0;
+	}
+
+	return bsearch_hash_v3(oid->hash, data + pfp->full_oid_offset,
+			       (const uint32_t *)(data + pfp->order_map_offset),
+			       data + pfp->data_offset,
+			       pfp->short_name_len,
+			       hash_algos[algo].rawsz, result);
+}
+
 int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32_t *result)
 {
 	const unsigned char *index_fanout = p->index_data;
@@ -1740,6 +1810,9 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
 	if (!index_fanout)
 		BUG("bsearch_pack called without a valid pack-index");
 
+	if (p->index_version == 3)
+		return bsearch_pack_v3(oid, p, result);
+
 	index_lookup = index_fanout + 4 * 256;
 	if (p->index_version == 1) {
 		index_lookup_width = hashsz + 4;
@@ -1767,13 +1840,17 @@ int nth_packed_object_id(struct object_id *oid,
 	}
 	if (n >= p->num_objects)
 		return -1;
-	index += 4 * 256;
 	if (p->index_version == 1) {
+		index += 4 * 256;
 		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4),
 			p->repo->hash_algo);
-	} else {
-		index += 8;
+	} else if (p->index_version == 2) {
+		index += 4 * 256 + 8;
 		oidread(oid, index + st_mult(hashsz, n), p->repo->hash_algo);
+	} else {
+		int algo = hash_algo_by_ptr(p->repo->hash_algo);
+		const struct packed_git_format *pfp = &p->formats[algo-1];
+		oidread(oid, index + pfp->full_oid_offset + (hashsz * n), p->repo->hash_algo);
 	}
 	return 0;
 }
@@ -1796,12 +1873,14 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 {
 	const unsigned char *index = p->index_data;
 	const unsigned int hashsz = p->repo->hash_algo->rawsz;
-	index += 4 * 256;
 	if (p->index_version == 1) {
+		index += 4 * 256;
 		return ntohl(*((uint32_t *)(index + st_mult(hashsz + 4, n))));
 	} else {
 		uint32_t off;
-		index += st_add(8, st_mult(p->num_objects, hashsz + 4));
+		if (p->index_version == 3)
+			n = nth_packed_object_pack_order_algop(p, n, p->repo->hash_algo);
+		index += st_add(p->crc_offset, st_mult(p->num_objects, 4));
 		off = ntohl(*((uint32_t *)(index + st_mult(4, n))));
 		if (!(off & 0x80000000))
 			return off;
@@ -1812,6 +1891,18 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	}
 }
 
+uint32_t nth_packed_object_pack_order_algop(const struct packed_git *p, uint32_t n,
+					    const struct git_hash_algo *algop)
+{
+	const unsigned char *index = p->index_data;
+	const unsigned int algo = hash_algo_by_ptr(algop);
+	const struct packed_git_format *pfp = &p->formats[algo-1];
+
+	return ntohl(*(uint32_t *)(index +
+				   st_add(pfp->order_map_offset,
+					  st_mult(4, n))));
+}
+
 off_t find_pack_entry_one(const struct object_id *oid,
 			  struct packed_git *p)
 {
diff --git a/packfile.h b/packfile.h
index ed3378c457..22278cc6c6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -1,6 +1,7 @@
 #ifndef PACKFILE_H
 #define PACKFILE_H
 
+#include "hash.h"
 #include "list.h"
 #include "object.h"
 #include "odb.h"
@@ -14,12 +15,22 @@
 struct object_info;
 struct odb_stream;
 
+struct packed_git_format {
+	/* This is also the location of the short OID table. */
+	uint64_t data_offset;
+	uint64_t full_oid_offset;
+	uint64_t order_map_offset;
+	uint32_t short_name_len;
+};
+
 struct packed_git {
 	struct pack_window *windows;
 	off_t pack_size;
 	const void *index_data;
 	size_t index_size;
 	uint32_t num_objects;
+	uint32_t num_formats;
+	struct packed_git_format formats[GIT_HASH_NALGOS - 1];
 	size_t crc_offset;
 	struct oidset bad_objects;
 	int index_version;
@@ -284,6 +295,13 @@ int nth_packed_object_id(struct object_id *, struct packed_git *, uint32_t n);
  */
 off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 
+/*
+ * Return the index into pack order of the nth object within the specified
+ * packfile.  The index must already be opened and it must be a v3 index.
+ */
+uint32_t nth_packed_object_pack_order_algop(const struct packed_git *, uint32_t n,
+					    const struct git_hash_algo *algop);
+
 /*
  * If the object named by oid is present in the specified packfile,
  * return its offset within the packfile; otherwise, return 0.
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 735de1023e..9ea0ed487e 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -36,50 +36,55 @@ test_expect_success 'setup' '
 	git update-ref HEAD $commit
 '
 
-test_expect_success 'pack-objects with index version 1' '
+test_expect_success !COMPAT_HASH 'pack-objects with index version 1' '
 	pack1=$(git pack-objects --index-version=1 test-1 <obj-list) &&
 	git verify-pack -v "test-1-${pack1}.pack"
 '
 
-test_expect_success 'pack-objects with index version 2' '
+test_expect_success !COMPAT_HASH 'pack-objects with index version 2' '
 	pack2=$(git pack-objects --index-version=2 test-2 <obj-list) &&
 	git verify-pack -v "test-2-${pack2}.pack"
 '
 
-test_expect_success 'both packs should be identical' '
+test_expect_success 'pack-objects with index version 3' '
+	packv3=$(git pack-objects --index-version=3 test-v3 <obj-list) &&
+	git verify-pack -v "test-v3-${packv3}.pack"
+'
+
+test_expect_success !COMPAT_HASH 'both packs should be identical' '
 	cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"
 '
 
-test_expect_success 'index v1 and index v2 should be different' '
+test_expect_success !COMPAT_HASH 'index v1 and index v2 should be different' '
 	! cmp "test-1-${pack1}.idx" "test-2-${pack2}.idx"
 '
 
-test_expect_success 'index-pack with index version 1' '
+test_expect_success !COMPAT_HASH 'index-pack with index version 1' '
 	git index-pack --index-version=1 -o 1.idx "test-1-${pack1}.pack"
 '
 
-test_expect_success 'index-pack with index version 2' '
+test_expect_success !COMPAT_HASH 'index-pack with index version 2' '
 	git index-pack --index-version=2 -o 2.idx "test-1-${pack1}.pack"
 '
 
-test_expect_success 'index-pack results should match pack-objects ones' '
+test_expect_success !COMPAT_HASH 'index-pack results should match pack-objects ones' '
 	cmp "test-1-${pack1}.idx" "1.idx" &&
 	cmp "test-2-${pack2}.idx" "2.idx"
 '
 
-test_expect_success 'index-pack --verify on index version 1' '
+test_expect_success !COMPAT_HASH 'index-pack --verify on index version 1' '
 	git index-pack --verify "test-1-${pack1}.pack"
 '
 
-test_expect_success 'index-pack --verify on index version 2' '
+test_expect_success !COMPAT_HASH 'index-pack --verify on index version 2' '
 	git index-pack --verify "test-2-${pack2}.pack"
 '
 
-test_expect_success 'pack-objects --index-version=2, is not accepted' '
+test_expect_success !COMPAT_HASH 'pack-objects --index-version=2, is not accepted' '
 	test_must_fail git pack-objects --index-version=2, test-3 <obj-list
 '
 
-test_expect_success 'index v2: force some 64-bit offsets with pack-objects' '
+test_expect_success !COMPAT_HASH 'index v2: force some 64-bit offsets with pack-objects' '
 	pack3=$(git pack-objects --index-version=2,0x40000 test-3 <obj-list)
 '
 
@@ -91,29 +96,29 @@ else
 	say "# skipping tests concerning 64-bit offsets"
 fi
 
-test_expect_success OFF64_T 'index v2: verify a pack with some 64-bit offsets' '
+test_expect_success OFF64_T,!COMPAT_HASH 'index v2: verify a pack with some 64-bit offsets' '
 	git verify-pack -v "test-3-${pack3}.pack"
 '
 
-test_expect_success OFF64_T '64-bit offsets: should be different from previous index v2 results' '
+test_expect_success OFF64_T,!COMPAT_HASH '64-bit offsets: should be different from previous index v2 results' '
 	! cmp "test-2-${pack2}.idx" "test-3-${pack3}.idx"
 '
 
-test_expect_success OFF64_T 'index v2: force some 64-bit offsets with index-pack' '
+test_expect_success OFF64_T,!COMPAT_HASH 'index v2: force some 64-bit offsets with index-pack' '
 	git index-pack --index-version=2,0x40000 -o 3.idx "test-1-${pack1}.pack"
 '
 
-test_expect_success OFF64_T '64-bit offsets: index-pack result should match pack-objects one' '
+test_expect_success OFF64_T,!COMPAT_HASH '64-bit offsets: index-pack result should match pack-objects one' '
 	cmp "test-3-${pack3}.idx" "3.idx"
 '
 
-test_expect_success OFF64_T 'index-pack --verify on 64-bit offset v2 (cheat)' '
+test_expect_success OFF64_T,!COMPAT_HASH 'index-pack --verify on 64-bit offset v2 (cheat)' '
 	# This cheats by knowing which lower offset should still be encoded
 	# in 64-bit representation.
 	git index-pack --verify --index-version=2,0x40000 "test-3-${pack3}.pack"
 '
 
-test_expect_success OFF64_T 'index-pack --verify on 64-bit offset v2' '
+test_expect_success OFF64_T,!COMPAT_HASH 'index-pack --verify on 64-bit offset v2' '
 	git index-pack --verify "test-3-${pack3}.pack"
 '
 
@@ -142,7 +147,7 @@ index_obj_offset()
 	( read offs extra && echo "$offs" )
 }
 
-test_expect_success '[index v1] 1) stream pack to repository' '
+test_expect_success !COMPAT_HASH '[index v1] 1) stream pack to repository' '
 	git index-pack --index-version=1 --stdin < "test-1-${pack1}.pack" &&
 	git prune-packed &&
 	git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
@@ -150,7 +155,7 @@ test_expect_success '[index v1] 1) stream pack to repository' '
 	cmp "test-1-${pack1}.idx"	".git/objects/pack/pack-${pack1}.idx"
 '
 
-test_expect_success \
+test_expect_success !COMPAT_HASH \
 	'[index v1] 2) create a stealth corruption in a delta base reference' '
 	# This test assumes file_101 is a delta smaller than 16 bytes.
 	# It should be against file_100 but we substitute its base for file_099
@@ -167,27 +172,27 @@ test_expect_success \
 	git cat-file blob $sha1_101 > file_101_foo1
 '
 
-test_expect_success \
+test_expect_success !COMPAT_HASH \
 	'[index v1] 3) corrupted delta happily returned wrong data' '
 	test -f file_101_foo1 && ! cmp file_101 file_101_foo1
 '
 
-test_expect_success \
+test_expect_success !COMPAT_HASH \
 	'[index v1] 4) confirm that the pack is actually corrupted' '
 	test_must_fail git fsck --full $commit
 '
 
-test_expect_success \
+test_expect_success !COMPAT_HASH \
 	'[index v1] 5) pack-objects happily reuses corrupted data' '
 	pack4=$(git pack-objects test-4 <obj-list) &&
 	test -f "test-4-${pack4}.pack"
 '
 
-test_expect_success '[index v1] 6) newly created pack is BAD !' '
+test_expect_success !COMPAT_HASH '[index v1] 6) newly created pack is BAD !' '
 	test_must_fail git verify-pack -v "test-4-${pack4}.pack"
 '
 
-test_expect_success '[index v2] 1) stream pack to repository' '
+test_expect_success !COMPAT_HASH '[index v2] 1) stream pack to repository' '
 	rm -f .git/objects/pack/* &&
 	git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
 	git prune-packed &&
@@ -196,7 +201,7 @@ test_expect_success '[index v2] 1) stream pack to repository' '
 	cmp "test-2-${pack1}.idx"	".git/objects/pack/pack-${pack1}.idx"
 '
 
-test_expect_success \
+test_expect_success !COMPAT_HASH \
 	'[index v2] 2) create a stealth corruption in a delta base reference' '
 	# This test assumes file_101 is a delta smaller than 16 bytes.
 	# It should be against file_100 but we substitute its base for file_099
@@ -212,23 +217,23 @@ test_expect_success \
 	git cat-file blob $sha1_101 > file_101_foo2
 '
 
-test_expect_success \
+test_expect_success !COMPAT_HASH \
 	'[index v2] 3) corrupted delta happily returned wrong data' '
 	test -f file_101_foo2 && ! cmp file_101 file_101_foo2
 '
 
-test_expect_success \
+test_expect_success !COMPAT_HASH \
 	'[index v2] 4) confirm that the pack is actually corrupted' '
 	test_must_fail git fsck --full $commit
 '
 
-test_expect_success \
+test_expect_success !COMPAT_HASH \
 	'[index v2] 5) pack-objects refuses to reuse corrupted data' '
 	test_must_fail git pack-objects test-5 <obj-list &&
 	test_must_fail git pack-objects --no-reuse-object test-6 <obj-list
 '
 
-test_expect_success \
+test_expect_success !COMPAT_HASH \
 	'[index v2] 6) verify-pack detects CRC mismatch' '
 	rm -f .git/objects/pack/* &&
 	git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
@@ -246,12 +251,12 @@ test_expect_success \
 
 test_expect_success 'running index-pack in the object store' '
 	rm -f .git/objects/pack/* &&
-	cp test-1-${pack1}.pack .git/objects/pack/pack-${pack1}.pack &&
+	cp test-v3-${packv3}.pack .git/objects/pack/pack-${packv3}.pack &&
 	(
 		cd .git/objects/pack &&
-		git index-pack pack-${pack1}.pack
+		git index-pack pack-${packv3}.pack
 	) &&
-	test -f .git/objects/pack/pack-${pack1}.idx
+	test -f .git/objects/pack/pack-${packv3}.idx
 '
 
 test_expect_success 'index-pack --strict warns upon missing tagger in tag' '
@@ -273,7 +278,7 @@ EOF
 	test_grep "^warning:.* expected .tagger. line" err
 '
 
-test_expect_success 'index-pack --fsck-objects also warns upon missing tagger in tag' '
+test_expect_success !COMPAT_HASH 'index-pack --fsck-objects also warns upon missing tagger in tag' '
 	git index-pack --fsck-objects tag-test-${pack1}.pack 2>err &&
 	test_grep "^warning:.* expected .tagger. line" err
 '
-- 
2.56.0.215.g47fdf2208c

