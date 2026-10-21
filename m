Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564400;
	b=jPTgX58CdbOBlmIveU0uKd+YtpvPuaxX3qGGTgn3uTdLXPNIGvXSvcNHKnCWGxZvNaAV
	 AAccInyUqSeMLcYvHLGqV7Sm/WN2yiMZMOZZ92Mr+RYAmVfCBbL8y7W7Kn531QT/G/Lbm
	 +wDwxGxTrRAgv7KkTiKAC0Tn2s1zuC2TzPs7QYDykB0Wy8SkxkFSbQ42r4F5o0IYxW+Fu
	 aZ1920w1dumdu8V/wnAFxSugGWMiI64ZCKmq0eQmtT/29rbVLI/3GAqLdgkMTJCbCfb7j
	 4GJ4qIhEBfdb1KyMRRO27GTOEJvAVk5MV63hjhMAZbYJUDtwLWksm2LwgKhaE4/WTMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6c4glWOerkTDWo0+AC3duwZCgNxjBYFLuqlMr72ukzo=;
	b=2nyBqGd7IaxD6+t1niVVNtzdEQi8FL6Syj4Y2xMWLnOnr48KL2bW6Knvu7P8sTuawj8e
	 Y7dP231F/31I1Aw+qmNKBaFCsH4gWEQ+scUC9tjnHrRu4Y73DmMwm6rNq1N9I7jzxcWtH
	 vWnjmBEkhsrbHT4r2aPqy01x4a6pD3bLko0qLiCeWV/Fa7y3Fo6PfO3ZgL5Y6xk19GltG
	 a3Z47MBzMcJV5JykjuBMsaFjCAE/IdWrHiTSbD55Ke4omTBh/bk7fxnXzUda79oLkkHXl
	 VALo14uaK2cVcGA0BOC8Gu/aJwwDddMuLq3lFety5dO9+hdf6bxvW5B5wIxChrzBmyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bRih66Pf;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D160A261C
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD1D160A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bRih66Pf
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c4d870d54so208414f8f.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564398; x=1793169198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6c4glWOerkTDWo0+AC3duwZCgNxjBYFLuqlMr72ukzo=;
        b=bRih66PfpBS0h4q/f6ZRq1fuoolOMYcYSXcJDswOWbN0zhtdCVFaG7BQpHgvL2La1I
         Vce8ZkHJN8Nci1aXIVc3wgBa5xs56ZUmXx1Z/vZ5XeTOe/3kbBIRVC3sEKX8pM9dHDRc
         U6uO2ivNJMnXKTzmf31+Hq5zIoPIckHPkpqrk2pd+uf6WYHowbg0DeoruMZr/Cu2KeK2
         J6P5aQL67769yrYrxGkwO/kRJIvPAq6lFNQ8/KQtI3CJFlPPI3x2Uw5rn3wM9gT+BFM2
         yCgyX8oZpdehloQA2emUxZHrr3nbiMKsB8PtX9Uw/hHk1pZoAZBR5HKldaKLGYz/hT49
         D8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564398; x=1793169198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6c4glWOerkTDWo0+AC3duwZCgNxjBYFLuqlMr72ukzo=;
        b=2sRANEhmUiL5fZoacTVYBegPmxFbjXPZPlCJhD8j+S7qVqPTxBfSRMAinyt0LgWVil
         RU4RqY1U5+tgymwFUECHOHr13Q8o5F/Le4N2ufEiTsGqQny8GPZe5FN6w/7svSyMLTA/
         nidgXV8nbjQjBPLqKsiElMvZQBezoMaqKa+jE+cbQiTmhlae3kC6wmup6JHfpoY0gN9Z
         W4bOi8BU9kES116fyNjmAjfYbTPtYEAhNpCjBdDQ8urYOFGO/0g+XpDUCg5+MbzsmD12
         u7Y2yyLoYyAORTgSDfQrgCSbfAB7yOefV6cTFwEGkq9c8oCuIG0XCEqmhvajGcBbIrHi
         WfkA==
X-Gm-Message-State: AFq9FYICc5/1RdW4xln7Z27cS+QQwE2AOSoESHRCkGe1nVf2YRXX0ZBf
	PdDb7JgioMTT/TOuxaprURl91a7+GfzMmU8kTjs72WJY/39kJIXVpdPCihZsYg==
X-Gm-Gg: AYBFou02EYjf2Z2yda6D+UPCpcLCQ9EcDKbS5MKGDrlm9o3RoEgbH4mPSK/yE5otT+G
	P7jwB7pu1bUcZH4q/pG1p6iZBF+KfM40IuAIWs1G0p68q22EjWdcHeb+CnvDUV/DnRJ1lKzT05+
	1ULu5VEmn25EotFkNcV+m4wNQxjr9Zlk24+9Evn7OpFgM3O3aUZu6wB//Hc7YTyFWywBHMBR9LC
	o5oqgbMUTi+MUlwjB0sz2MmKIEeBfX0unSvPYIbvI0XVYyH7U3mo9TkE0NDPAerJ8vbMHuKRIQJ
	WqYEFf4suG5hF5JWtmyKF21QeS0z1mYeckobvqdvBQHFycCLO08U1JJuOZEBALhEHbkkebZ3+6a
	2LCKrnTQ8UC1Vpm2U50DOWDssrIzXMb66Y2XsC/yJP+bOb46W0wGkFwlXSeOvsQa26Ngb4lV0YA
	grHVZriFyq4+FHOl6kTE1PnHPSRuDG2+0A3D8SzCNIa7V63wql+tLFSIwWX2lr+kaHNSQMltfas
	LCXg+EaqtvcMLGEMgZGccgEFQ8kyuP+eQCScV51KB9dOy2jo8huzjPIAuuROSSTlbxhMmGPIaNA
	4igKD26ZnX0LLlPPhftOHJjmPGFYfanmmkuF3Ilt5LxWnp1TYboSYVBUpK4iR9kGYANMHw2KoT/
	HTgUfUWyLR2HGzH4OPzEanOaMyNJp6nePzk3WkrkyoTBZK7k/OyJxHjdf2ws4m0TaxA==
X-Received: by 2002:a05:6000:2302:b0:487:72f:fb41 with SMTP id ffacd0b85a97d-48e264c6b67mr1681310f8f.39.1792564398071;
        Tue, 20 Oct 2026 23:33:18 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:17 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 10/13] packfile: validate pack index v3 tables
Date: Wed, 21 Oct 2026 08:32:42 +0200
Message-ID: <20261021063245.2917625-11-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261021063245.2917625-1-christian.couder@gmail.com>
References: <20261021063245.2917625-1-christian.couder@gmail.com>
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

A previous commit implemented loading a pack index v3, but didn't
check much of its format when doing so.

To avoid reading outside a v3 index, if it's corrupt or crafted, let's
check that its header, its format entries and all its tables lie within
the file, when loading it.

Let's also reject duplicate formats and short names longer than the
full object names.

The values in the order maps are checked when they are read, rather
than when loading the index, so that loading stays cheap. A new test in
t5313 ensures that an invalid order map entry is detected.

In the pack revindex, let's also check that the 8-byte offsets we read
lie within the index.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 hash-lookup.c                 |  5 ++-
 pack-revindex.c               |  5 ++-
 packfile.c                    | 71 ++++++++++++++++++++++++++---------
 t/t5313-pack-bounds-checks.sh | 17 +++++++++
 4 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/hash-lookup.c b/hash-lookup.c
index a77ccad8b5..3f0725f7ec 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -144,8 +144,9 @@ int bsearch_hash_v3(const unsigned char *hash, const unsigned char *full_oid,
 		    const uint32_t *pack_map, const unsigned char *short_oid,
 		    size_t stride, size_t hashsz, uint32_t *result)
 {
+	uint32_t nr = (full_oid - short_oid) / stride;
 	uint32_t obj_off, index;
-	int res = bsearch_hash_1(hash, short_oid, stride, stride, (full_oid - short_oid) / stride,
+	int res = bsearch_hash_1(hash, short_oid, stride, stride, nr,
 				 0, &obj_off);
 	if (result)
 		*result = obj_off;
@@ -157,6 +158,8 @@ int bsearch_hash_v3(const unsigned char *hash, const unsigned char *full_oid,
 	 * to find the full object ID.  index is the offset in pack order.
 	 */
 	index = ntohl(pack_map[obj_off]);
+	if (index >= nr)
+		return 0;
 	if (!memcmp(hash, full_oid + (hashsz * index), hashsz))
 		return 1;
 	return 0;
diff --git a/pack-revindex.c b/pack-revindex.c
index fb81db8033..4e6923cfd3 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -150,7 +150,10 @@ static void create_pack_revindex(struct packed_git *p)
 			if (!(off & 0x80000000)) {
 				p->revindex[i].offset = off;
 			} else {
-				p->revindex[i].offset = get_be64(off_64 + st_mult(lowoff, 2));
+				const uint32_t *ptr = off_64 + st_mult(lowoff, 2);
+
+				check_pack_index_ptr(p, ptr);
+				p->revindex[i].offset = get_be64(ptr);
 			}
 			p->revindex[i].nr = i;
 		}
diff --git a/packfile.c b/packfile.c
index 95207c0e19..f6e2db45d5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -180,50 +180,81 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 			return error("pack too large for current definition of off_t in %s", path);
 		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
 	} else if (version == 3) {
-		uint32_t hdrlen, num_formats, trailer_offset, main_algo;
+		uint32_t hdrlen, num_formats, main_algo;
+		uint64_t trailer_offset;
 		const uint32_t *q = index;
-		int i;
 
+		/* Fixed part of the header (after signature and version) */
 		hdrlen = ntohl(*q++);
-		if (idx_size < hdrlen)
-			return error("v3 index has truncated header");
-
 		nr = ntohl(*q++);
 		num_formats = ntohl(*q++);
 		if (num_formats < 1 || num_formats > ARRAY_SIZE(p->formats))
-			return error("too many formats for v3 index");
+			return error("v3 index %s has an invalid number of formats: %"PRIu32,
+				     path, num_formats);
+
+		/* Then 16 bytes per format and the 8-byte offset of the trailer */
+		if (hdrlen < 20 + num_formats * (4 + 4 + 8) + 8 ||
+		    hdrlen > idx_size - 2 * hashsz)
+			return error("v3 index %s has an invalid header length", path);
+
+		trailer_offset = get_be64(q + num_formats * 4);
+		if (trailer_offset != idx_size - 2 * hashsz)
+			return error("v3 index %s has a bad size", path);
+
 		memset(p->formats, 0, sizeof(p->formats));
 		for (i = 0; i < num_formats; i++) {
 			uint32_t format_id = ntohl(*q++);
 			uint32_t format = hash_algo_by_id(format_id);
 			struct packed_git_format *pfp;
+			uint64_t end;
 
 			if (format == GIT_HASH_UNKNOWN)
-				return error("v3 index with unknown format_id 0x%08x", format_id);
+				return error("v3 index %s has an unknown format_id 0x%08"PRIx32,
+					     path, format_id);
 			/*
 			 * We store at the value of the constant minus 1 to
 			 * avoid having to store a useless entry at offset 0.
 			 */
 			pfp = &p->formats[format-1];
+			if (pfp->data_offset)
+				return error("v3 index %s has duplicate format_id 0x%08"PRIx32,
+					     path, format_id);
 
 			pfp->short_name_len = ntohl(*q++);
 			pfp->data_offset = get_be64(q);
 			q += 2;
 
+			if (!pfp->short_name_len ||
+			    pfp->short_name_len > hash_algos[format].rawsz)
+				return error("v3 index %s has an invalid short name length",
+					     path);
+
+			if (pfp->data_offset < hdrlen ||
+			    pfp->data_offset > trailer_offset)
+				return error("v3 index %s has an invalid table offset", path);
+
+			/* No overflow as pfp->data_offset < idx_size and nr < 2^32 */
 			pfp->full_oid_offset = pfp->data_offset +
-					       (pfp->short_name_len * nr);
+					       (uint64_t)pfp->short_name_len * nr;
 			pfp->order_map_offset = pfp->full_oid_offset +
-						(hash_algos[format].rawsz * nr);
-			if (!i)
-				p->crc_offset = pfp->order_map_offset + nr * 4;
+						(uint64_t)hash_algos[format].rawsz * nr;
+			end = pfp->order_map_offset + (uint64_t)nr * 4;
+
+			/* After the first format tables: CRC32 and 4-byte offset tables */
+			if (!i) {
+				p->crc_offset = end;
+				end += (uint64_t)nr * (4 + 4); /* CRC32 + offset */
+			}
+
+			if (pfp->order_map_offset % 4 || end > trailer_offset)
+				return error("v3 index %s has invalid tables", path);
 		}
+
 		main_algo = hash_algo_by_length(hashsz);
 		if (main_algo == GIT_HASH_UNKNOWN ||
 		    !p->formats[main_algo - 1].data_offset)
-			return error("v3 index with missing data for this repository's algorithm");
-		trailer_offset = get_be64(q);
-		if (trailer_offset + 2 * hashsz != idx_size)
-			return error("v3 index with bad size\n");
+			return error("v3 index %s is missing data for the main hash algorithm",
+				     path);
 	}
 
 	p->index_version = version;
@@ -1897,10 +1928,14 @@ uint32_t nth_packed_object_pack_order_algop(const struct packed_git *p, uint32_t
 	const unsigned char *index = p->index_data;
 	const unsigned int algo = hash_algo_by_ptr(algop);
 	const struct packed_git_format *pfp = &p->formats[algo-1];
+	uint32_t pos = ntohl(*(uint32_t *)(index +
+					   st_add(pfp->order_map_offset,
+						  st_mult(4, n))));
 
-	return ntohl(*(uint32_t *)(index +
-				   st_add(pfp->order_map_offset,
-					  st_mult(4, n))));
+	if (pos >= p->num_objects)
+		die(_("invalid object position in pack index for %s (corrupt index?)"),
+		    p->pack_name);
+	return pos;
 }
 
 off_t find_pack_entry_one(const struct object_id *oid,
diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index 5be01260d7..ab2b0bb9c6 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -45,6 +45,14 @@ extended_table () {
 	echo $(($(ofs_table "$1") + 4*$1))
 }
 
+# Offset in a single-format v3 .idx with no extended offsets to the
+# start of its order map. $1 is its number of objects, nr.
+# The order map (4*nr) is followed by the CRC32 table (4*nr), the
+# 4-byte offset table (4*nr) and by the trailer (2*rawsz).
+v3_order_map () {
+	echo $(($(wc -c <"$idx") - 2*$(test_oid rawsz) - 12*$1))
+}
+
 test_expect_success 'setup' '
 	test_oid_cache <<-EOF
 	oid000 sha1:1485
@@ -171,6 +179,15 @@ test_expect_success 'bogus offset inside v2 extended table' '
 	test_must_fail git index-pack --verify $pack
 '
 
+test_expect_success 'bogus order map entry (v3)' '
+	do_pack $object --index-version=3 &&
+	munge $idx $(v3_order_map 1) "\377\377\377\377" &&
+	clear_base &&
+	test_must_fail git cat-file blob $object &&
+	test_must_fail git cat-file --batch-all-objects --batch-check 2>err &&
+	test_grep "corrupt index" err
+'
+
 test_expect_success 'bogus OFS_DELTA in packfile' '
 	# Generate a pack with a delta in it.
 	base=$(test-tool genrandom foo 3000 | git hash-object --stdin -w) &&
-- 
2.56.0.215.g47fdf2208c

