Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0D1DED42
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959620; cv=none; b=tqrHCw4Mujy5rdEsGzFpTd3CpKRtZ3deXmWgK1XT0tNunPKv/1Qu4oiIanauxogcpbnLZePx2VXJSffn9efO1yQgHGyAHmocE6sZ+pieGSUkCzCegz4iHn89d2d5tfvNpK+/IWH4vj5oMHo09NjlW4zSHHUK8LilBimWWU0eatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959620; c=relaxed/simple;
	bh=yhurOxO0up/pB5LVk+ZB+/uoKQ4ZN0o3bnx6dfUh/eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpLE89NmsujHSQC77QZYJV0KKg16jlqs+W9byBQqMw6+QXPEnr459xh+ffnRqmSFaznIQdkOzc2uih4DifaMfSwBv0e0skEQP8D/s0oYxTsW14VZIbyWoi7wXQBkzhTEUFk6RyhBhCQGMQnPtKSn+Yq0puKDp8iO0CSbkR7YdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=i/Atoj1f; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="i/Atoj1f"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-50336cffef9so45843881cf.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959617; x=1772564417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQs5gq2Kf/8z1SG8P6CLp3oizsbXlaeipjDLHMg85JI=;
        b=i/Atoj1fQfIJ+FdFu4E6iIVfnH1saBjOlOV7d4DFM4uJaaqQTHqvkptgcCOY+CM1IJ
         v4pSV3oYtDTxQhbgI7MmD2MvTHUhwWSisgqiOa6T6tk/bZ9ZE1nZx6u4ypwToE7I+VlA
         agza51fWD888qKxRns22HE7q7PWKTB/n8PisnUA2q6FZnAmtE/txWzDgI9IbtxpuYrak
         PBxcpTFjWQHsb8X0HHcwgaocLwh2qFCSOFQ9FxVU8gOHlaUHWzgG8wvJTLaJI9KMhog4
         pE99ZAvJRL1Xva2OinX+qd9XO119nMPCwLRhCHWYClvN8ycwyt7VOGGCm0Xl581NHOsW
         f6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959617; x=1772564417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQs5gq2Kf/8z1SG8P6CLp3oizsbXlaeipjDLHMg85JI=;
        b=QTy7vWv2e+oqckdIjD2F5xeDA53HgiOgPtwhistWFFegpNH8Zj/PWTDSaKF/N8hTpJ
         l3qcEwjT53jRF0wIqe89V7EKJ2znlIOagaqYwkfSiStCCEWzDzQ6iHibdDOpMENCool+
         x73j4FF7QIMbuIPy9prQk1omgEfaAvzJTLlnLat4PdYqenDTWgJK33sYgUQFbqRlDcrw
         xI211Kh1QK0xd90ktKCPEEZc5tPHYpW34M+zH3UwtuexsOZwx65sAyUPzE5uXP3lOnYO
         +q2g7ekjs/A9HlkHBdBr2FkecKHKN1w1S6eQQDn24d60XS+3h52Pwj3r0dCr3fs9cq67
         CUrA==
X-Gm-Message-State: AOJu0YyXd449ikLsIWKXNuWgpnNYDHexYDRDt4lhkx7SBVSTe3mlYiv/
	I8yDrqzQCYzCdUUwaPSC9qgg0+2X2Z2b9t8NG7M3RKYMj/RO2RMG1EGz5tBd/fKekoMiTtavtg+
	o0HsMc4S5Uxyh
X-Gm-Gg: AZuq6aKCNZQt0NEluzBiEnv7gRrz4DHIKTptPIUTJdQCsCf8qz0hK73n7OLJbFbx9E1
	VvzuMzWokF+9o7vGp9WysMJZ2BaPbxuhpTrdkShB4yAq04iL5hp30jznKh8Qpajd8MfOgFNLtEo
	8BQj7+j7NMpuKhASSMnBvNbU1gOGGcPdLJsLb0oQgN8OJnVr6QuuQZbtE/ymsyXdpgC3fgsqoAY
	Tm2uZuZCwRZ9c3Vgr8pb+gOqZWR9gKkXGdAvFQAuSG5uZLilWKLk8yOcb1IVyKFDeLymDyjFcaa
	2WCtAFWc2hecAaWMJ0TnQ1laiuIEe7Lj49sqpu/ztS3uVh+4K8G1ZtwkdXyfCnY3g6TfgdBguQB
	JGDwqgRh1bQ5XGXnr1T+4HzIVoVG3PDSd6/cAhm2Zcm01cu3MoMIBdbxN+TJlUCRhNwXOOE7tGw
	TGj1kFR582FKzHzYfWbgFNIl9uelpTFBazazex6wkxKlymgUxO2c+oWOj9w8d8W/QpmqSJevCjc
	rO/CWmuMoZxv8APPjdlndSwVJAdiuS2+kb+b/Mz
X-Received: by 2002:ac8:598d:0:b0:501:1795:9d52 with SMTP id d75a77b69052e-5070bc15fe2mr175378081cf.33.1771959615838;
        Tue, 24 Feb 2026 11:00:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d3a2dc8sm102607411cf.0.2026.02.24.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:00:15 -0800 (PST)
Date: Tue, 24 Feb 2026 14:00:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/17] midx: do not require packs to be sorted in
 lexicographic order
Message-ID: <3682bfd0e0872b9b8831d5c481db306e316c78ef.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

The MIDX file format currently requires that pack files be identified by
the lexicographic ordering of their names (that is, a pack having a
checksum beginning with "abc" would have a numeric pack_int_id which is
smaller than the same value for a pack beginning with "bcd").

As a result, it is impossible to combine adjacent MIDX layers together
without permuting bits from bitmaps that are in more recent layer(s).

To see why, consider the following example:

          | packs       | preferred pack
  --------+-------------+---------------
  MIDX #0 | { X, Y, Z } | Y
  MIDX #1 | { A, B, C } | B
  MIDX #2 | { D, E, F } | D

, where MIDX #2's base MIDX is MIDX #1, and so on. Suppose that we want
to combine MIDX layers #0 and #1, to create a new layer #0' containing
the packs from both layers. With the original three MIDX layers, objects
are laid out in the bitmap in the order they appear in their source
pack, and the packs themselves are arranged according to the pseudo-pack
order. In this case, that ordering is Y, X, Z, B, A, C.

But recall that the pseudo-pack ordering is defined by the order that
packs appear in the MIDX, with the exception of the preferred pack,
which sorts ahead of all other packs regardless of its position within
the MIDX. In the above example, that means that pack 'Y' could be placed
anywhere (so long as it is designated as preferred), however, all other
packs must be placed in the location listed above.

Because that ordering isn't sorted lexicographically, it is impossible
to compact MIDX layers in the above configuration without permuting the
object-to-bit-position mapping. Changing this mapping would affect all
bitmaps belonging to newer layers, rendering the bitmaps associated with
MIDX #2 unreadable.

One of the goals of MIDX compaction is that we are able to shrink the
length of the MIDX chain *without* invalidating bitmaps that belong to
newer layers, and the lexicographic ordering constraint is at odds with
this goal.

However, packs do not *need* to be lexicographically ordered within the
MIDX. As far as I can gather, the only reason they are sorted lexically
is to make it possible to perform a binary search over the pack names in
a MIDX, necessary to make `midx_contains_pack()`'s performance
logarithmic in the number of packs rather than linear.

Relax this constraint by allowing MIDX writes to proceed with packs that
are not arranged in lexicographic order. `midx_contains_pack()` will
lazily instantiate a `pack_names_sorted` array on the MIDX, which will
be used to implement the binary search over pack names.

This change produces MIDXs which may not be correctly read with external
tools or older versions of Git. Though older versions of Git know how to
gracefully degrade and ignore any MIDX(s) they consider corrupt,
external tools may not be as robust. To avoid unintentionally breaking
any such tools, guard this change behind a version bump in the MIDX's
on-disk format.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitformat-pack.adoc |  8 ++++++--
 midx-write.c                      | 26 ++++++++++++++++++++++----
 midx.c                            | 31 ++++++++++++++++++++++++++++---
 midx.h                            |  4 +++-
 t/t5319-multi-pack-index.sh       | 16 ++++++++++------
 5 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/Documentation/gitformat-pack.adoc b/Documentation/gitformat-pack.adoc
index 1b4db4aa611..3416edceab8 100644
--- a/Documentation/gitformat-pack.adoc
+++ b/Documentation/gitformat-pack.adoc
@@ -374,7 +374,9 @@ HEADER:
 	    The signature is: {'M', 'I', 'D', 'X'}
 
 	1-byte version number:
-	    Git only writes or recognizes version 1.
+	    Git writes the version specified by the "midx.version"
+	    configuration option, which defaults to 2. It recognizes
+	    both versions 1 and 2.
 
 	1-byte Object Id Version
 	    We infer the length of object IDs (OIDs) from this value:
@@ -413,7 +415,9 @@ CHUNK DATA:
 	    strings. There is no extra padding between the filenames,
 	    and they are listed in lexicographic order. The chunk itself
 	    is padded at the end with between 0 and 3 NUL bytes to make the
-	    chunk size a multiple of 4 bytes.
+	    chunk size a multiple of 4 bytes. Version 1 MIDXs are required to
+	    list their packs in lexicographic order, but version 2 MIDXs may
+	    list their packs in any arbitrary order.
 
 	Bitmapped Packfiles (ID: {'B', 'T', 'M', 'P'})
 	    Stores a table of two 4-byte unsigned integers in network order.
diff --git a/midx-write.c b/midx-write.c
index 8a54644e427..5c8700065a1 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -36,10 +36,13 @@ extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 
 static size_t write_midx_header(const struct git_hash_algo *hash_algo,
 				struct hashfile *f, unsigned char num_chunks,
-				uint32_t num_packs)
+				uint32_t num_packs, int version)
 {
+	if (version != MIDX_VERSION_V1 && version != MIDX_VERSION_V2)
+		BUG("unexpected MIDX version: %d", version);
+
 	hashwrite_be32(f, MIDX_SIGNATURE);
-	hashwrite_u8(f, MIDX_VERSION);
+	hashwrite_u8(f, version);
 	hashwrite_u8(f, oid_version(hash_algo));
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, 0); /* unused */
@@ -105,6 +108,8 @@ struct write_midx_context {
 
 	uint32_t preferred_pack_idx;
 
+	int version; /* must be MIDX_VERSION_V1 or _V2 */
+
 	int incremental;
 	uint32_t num_multi_pack_indexes_before;
 
@@ -410,7 +415,9 @@ static int write_midx_pack_names(struct hashfile *f, void *data)
 		if (ctx->info[i].expired)
 			continue;
 
-		if (i && strcmp(ctx->info[i].pack_name, ctx->info[i - 1].pack_name) <= 0)
+		if (ctx->version == MIDX_VERSION_V1 &&
+		    i && strcmp(ctx->info[i].pack_name,
+				ctx->info[i - 1].pack_name) <= 0)
 			BUG("incorrect pack-file order: %s before %s",
 			    ctx->info[i - 1].pack_name,
 			    ctx->info[i].pack_name);
@@ -1025,6 +1032,12 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 	if (!midx_checksum_valid(midx))
 		goto out;
 
+	/*
+	 * If the version differs, we need to update.
+	 */
+	if (midx->version != ctx->version)
+		goto out;
+
 	/*
 	 * Ignore incremental updates for now. The assumption is that any
 	 * incremental update would be either empty (in which case we will bail
@@ -1100,6 +1113,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	struct tempfile *incr;
 	struct write_midx_context ctx = {
 		.preferred_pack_idx = NO_PREFERRED_PACK,
+		.version = MIDX_VERSION_V2,
 	 };
 	struct multi_pack_index *midx_to_free = NULL;
 	int bitmapped_packs_concat_len = 0;
@@ -1114,6 +1128,10 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	ctx.repo = r;
 	ctx.source = opts->source;
 
+	repo_config_get_int(ctx.repo, "midx.version", &ctx.version);
+	if (ctx.version != MIDX_VERSION_V1 && ctx.version != MIDX_VERSION_V2)
+		die(_("unknown MIDX version: %d"), ctx.version);
+
 	ctx.incremental = !!(opts->flags & MIDX_WRITE_INCREMENTAL);
 
 	if (ctx.incremental)
@@ -1445,7 +1463,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	}
 
 	write_midx_header(r->hash_algo, f, get_num_chunks(cf),
-			  ctx.nr - dropped_packs);
+			  ctx.nr - dropped_packs, ctx.version);
 	write_chunkfile(cf, &ctx);
 
 	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
diff --git a/midx.c b/midx.c
index bae45892323..c1b9658240d 100644
--- a/midx.c
+++ b/midx.c
@@ -149,7 +149,7 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 		      m->signature, MIDX_SIGNATURE);
 
 	m->version = m->data[MIDX_BYTE_FILE_VERSION];
-	if (m->version != MIDX_VERSION)
+	if (m->version != MIDX_VERSION_V1 && m->version != MIDX_VERSION_V2)
 		die(_("multi-pack-index version %d not recognized"),
 		      m->version);
 
@@ -210,7 +210,8 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 			die(_("multi-pack-index pack-name chunk is too short"));
 		cur_pack_name = end + 1;
 
-		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0)
+		if (m->version == MIDX_VERSION_V1 &&
+		    i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0)
 			die(_("multi-pack-index pack names out of order: '%s' before '%s'"),
 			      m->pack_names[i - 1],
 			      m->pack_names[i]);
@@ -411,6 +412,7 @@ void close_midx(struct multi_pack_index *m)
 	}
 	FREE_AND_NULL(m->packs);
 	FREE_AND_NULL(m->pack_names);
+	FREE_AND_NULL(m->pack_names_sorted);
 	free(m);
 }
 
@@ -655,17 +657,40 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 	return strcmp(idx_or_pack_name, idx_name);
 }
 
+
+static int midx_pack_names_cmp(const void *a, const void *b, void *m_)
+{
+	struct multi_pack_index *m = m_;
+	return strcmp(m->pack_names[*(const size_t *)a],
+		      m->pack_names[*(const size_t *)b]);
+}
+
 static int midx_contains_pack_1(struct multi_pack_index *m,
 				const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
+	if (m->version == MIDX_VERSION_V2 && !m->pack_names_sorted) {
+		uint32_t i;
+
+		ALLOC_ARRAY(m->pack_names_sorted, m->num_packs);
+
+		for (i = 0; i < m->num_packs; i++)
+			m->pack_names_sorted[i] = i;
+
+		QSORT_S(m->pack_names_sorted, m->num_packs, midx_pack_names_cmp,
+			m);
+	}
+
 	while (first < last) {
 		uint32_t mid = first + (last - first) / 2;
 		const char *current;
 		int cmp;
 
-		current = m->pack_names[mid];
+		if (m->pack_names_sorted)
+			current = m->pack_names[m->pack_names_sorted[mid]];
+		else
+			current = m->pack_names[mid];
 		cmp = cmp_idx_or_pack_name(idx_or_pack_name, current);
 		if (!cmp)
 			return 1;
diff --git a/midx.h b/midx.h
index a39bcc9d03f..aa99a6cb215 100644
--- a/midx.h
+++ b/midx.h
@@ -11,7 +11,8 @@ struct git_hash_algo;
 struct odb_source;
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
-#define MIDX_VERSION 1
+#define MIDX_VERSION_V1 1
+#define MIDX_VERSION_V2 2
 #define MIDX_BYTE_FILE_VERSION 4
 #define MIDX_BYTE_HASH_VERSION 5
 #define MIDX_BYTE_NUM_CHUNKS 6
@@ -71,6 +72,7 @@ struct multi_pack_index {
 	uint32_t num_packs_in_base;
 
 	const char **pack_names;
+	size_t *pack_names_sorted;
 	struct packed_git **packs;
 };
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index efeab4d22b7..250d21dbd67 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -21,7 +21,7 @@ midx_read_expect () {
 	EXTRA_CHUNKS="$5"
 	{
 		cat <<-EOF &&
-		header: 4d494458 1 $HASH_LEN $NUM_CHUNKS $NUM_PACKS
+		header: 4d494458 2 $HASH_LEN $NUM_CHUNKS $NUM_PACKS
 		chunks: pack-names oid-fanout oid-lookup object-offsets$EXTRA_CHUNKS
 		num_objects: $NUM_OBJECTS
 		packs:
@@ -512,11 +512,6 @@ test_expect_success 'verify invalid chunk offset' '
 		"improper chunk offset(s)"
 '
 
-test_expect_success 'verify packnames out of order' '
-	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "z" $objdir \
-		"pack names out of order"
-'
-
 test_expect_success 'verify missing pack' '
 	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "a" $objdir \
 		"failed to load pack"
@@ -578,6 +573,15 @@ test_expect_success 'verify incorrect checksum' '
 		$objdir "incorrect checksum"
 '
 
+test_expect_success 'setup for v1-specific fsck tests' '
+	git -c midx.version=1 multi-pack-index write
+'
+
+test_expect_success 'verify packnames out of order (v1)' '
+	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "z" $objdir \
+		"pack names out of order"
+'
+
 test_expect_success 'repack progress off for redirected stderr' '
 	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack 2>err &&
 	test_line_count = 0 err
-- 
2.53.0.171.gde83996e422

