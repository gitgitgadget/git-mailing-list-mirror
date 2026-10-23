Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740394;
	b=OF30KhCauRhS6ozx85mQe4CWx0+mqeM6fQFvjJizzgUpmezsu8Nd2ntC04/Wu6Dc2v4L
	 aClQnNzX6BPkTNaNpk3mdNwXtjYi3mdjntGMXtNNi6x9jqDTdeR+vxR08XlxjYcM8KAmG
	 TSdd6eyd51Uz6QDmjqRalaMeblTVgRfN+sN/fTvVrXKXkCCvyD1LPd6hVQPNkJ3+dS/PE
	 VBz8mKOMUPWHoT/686+xmsGVjlWvzGMFNYyKlZ9OUSM2TfI8DoEJT42AVQL6fCivEU1HU
	 tbr/FNGjEBlNn3Lg3b34EvFs8y98Ua5sQeFKqfTNl2PaioUrAgUhBXSwP+a3HOuhIEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6c4glWOerkTDWo0+AC3duwZCgNxjBYFLuqlMr72ukzo=;
	b=BDARI2PRYB4+aCWrZtO2jcqIF0iOeaa9p/Lxgu7skyo9CBRfGKGnz3PYAGrchSS/xgjO
	 d8Zr0sBy6CMW+9xx156k5bJWpUyh7xMJ1AyVSnkM6ENLTnJmOggjr2s/cKW1e5iqGESme
	 R0X7YqK/0QfcH6yMXjWCPXyi9E6+OGyKCFtAo53R8z8KPlF+6qOn6j3bqDFGZJRfKreue
	 b/CpX1Rddw5G+FYywR0tNNkDWYOmzufmEVMk1Y55PEDPSXStWgkYcXePdRQxR87qN7cUK
	 JCkARUcp3wkUKsXjugOAzzDjRWV+GGgutLRPBgjyJghwlt2Lx8vH773DDthK6QugU8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SvFK4y6d;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91A606A33C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD91A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SvFK4y6d
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48bbb06e746so243309f8f.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740392; x=1793345192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6c4glWOerkTDWo0+AC3duwZCgNxjBYFLuqlMr72ukzo=;
        b=SvFK4y6dFTx+yKmQKXhOHe3+uHO+B7eQKnzSh6mg+BOdHHOFV/31paT9qaJrnhe7RX
         +XzVmBTd+T3C9zpwj+1ZNV56Bm3Np0WOMh13m4avNjrVuCMbZEO3HPWR+YucfswM3MDy
         wc/CWJVLYhBohtsvsM0aiu7dg+pALjUXMf0S3vnOaE36uxnsbm3WWhT89MgBAbQLiIir
         cOnsq3mVTGj5LTdMBCmrjigyZ3jlsS+XQhPtq9L07pM18MgRIclTrFeChtKIVtLJJOYj
         tLIeQA2WJzU3O1uncd2EAOXeGfWajiyzQX5UnAGzhO5EbjXBaNNvWmF56nZMPDmOrqV+
         euqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740392; x=1793345192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6c4glWOerkTDWo0+AC3duwZCgNxjBYFLuqlMr72ukzo=;
        b=WFgJh1dNVPbbkP+RO79+RV7L3q/V0LEVPrlcsk+L42GYI84U3sCyxjQtST4zeO1fBB
         xnmMViztYyqUg5eowIpl52sD0qNpl2c8IKriU2mY9Lc6Qz5/SW8pJm5MQyMhsMJvQlxb
         hPujC/hf9vWO2uBNsFVFcTCriMFaht8n8eInxeeYnl0JOZDL+Yeet7Uc1lNig2q/hwF3
         yzfkDG1uPWL7uTW3FDKpJL1MJ5tiQ1NCvCFy7+Eie8pjT2BT9EyiWzqa0dxnoHXowBtS
         +fxwiN62/9JtWGU8qzPx0z3EQ/VNQmE6eG7guUjoHVOPNyc/XpsohEqwse8AUy5umoVQ
         faMQ==
X-Gm-Message-State: AFq9FYIjiLnWWGz4L58MVj801xuTd88hdHXISp73IMIq+r3yPvtcq6q1
	qsMXXAcSDrTSLyr4LOARxQ3puCoYYDPAYdWbHPNu6dNOIy2w7grMcGJj2KmAwg==
X-Gm-Gg: AYBFou0jUO9wu6kKmmpjRiKYiT2o80r8GKuujKpaw7tZfJm4iyxGUTh2GwHiy9q7Ys0
	7aikYnnCFSY8qhwnk4O5vlHE+7+BMpaRAvUV4OmyCKtOS6m6Bj063KGVwzQvop3p75+GUarAuPF
	oQKEbE8e3VJzZLaB44UPGxgTQNgY011hgbgg+Fv1Np19ae206TkGSd2188pg78lfvGrRSo8McIs
	NTpWuLO8rJ4+sok/s50WopyMA/r3JN1AxX1VNKSxOv64/TuhwbGtdVqz1MinKVWXpglLbW7jJ44
	H3Cg/MoUtjJHUEihymuFwRyutEfDnzsYRdDU5I2kNSaUKF3jwzIU+tKm4YH6lYN47rijQv0/XRC
	Z7ltfqYeMSdRNi9HpZ5Ufuiys9LdidC+013TxTb8p1wL8O2y7VR2zlsPpZkacYjsTu3PQ/PNtWX
	DGjSJT0VBq0teumevO9tv/k79hK+6WgU1QqK8aoghGXrHd7VMZxFuYZy2JwlIUg3tq/NEgQojFo
	1o8ioBS9Y0ZVoLPW/3HSWN+H3OjFvbutlEk8fRDvFuItXoY55/mC+gP4vBEKkpG6dKdfmBCRQSi
	gMsxY5IcGzu2eF5kauKaX7sUedSacc8SvuI6nIIUlfH4G1P2m36keJdmEXXBUecWf4V4Rmgn9Gm
	wnr5y4IcJO17fNERxfp+KX2/bKAncejRB/fWQlPONKyLvFAHf/F+Jzv9i695Y5ykEqlbITvWxgm
	NBDntlbtvr3dM=
X-Received: by 2002:a05:6000:400f:b0:48d:f6d2:9c88 with SMTP id ffacd0b85a97d-48e385bce72mr2013447f8f.47.1792740392018;
        Fri, 23 Oct 2026 00:26:32 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:30 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 10/13] packfile: validate pack index v3 tables
Date: Fri, 23 Oct 2026 09:25:55 +0200
Message-ID: <20261023072559.3204273-11-christian.couder@gmail.com>
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

