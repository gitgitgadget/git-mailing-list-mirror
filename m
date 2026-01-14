Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9419C540
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420467; cv=none; b=hj/3lGffrXpWL4IuuYeTshbvXte8gbGNKGrSXaTTMJIkla+2lt6Dv9CBStSBkjPb6y8DNFzzoqH3HHmRfKI/jZV+rfyC4P0NdD6F3js5KTviDazwb6CmM34rVJB5zLe2j0LPd+8oMc2RVxMvsUHBezFwjcVoA0qvUdu19+7sisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420467; c=relaxed/simple;
	bh=pOk/gz0A0Aeh0070W/wOz6ELzem4gqwS/I1CMP9i7ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNSdkZownQH1UpNJ8Fbf3uuN5wrXOh8ROhsni/fzJQJy/BKikwycl/TTdCdyPncaWraT5IEmKwkdzQPsBE8PvSoc+68H0yMYfDZa2u4TMvjW7ONDrAaaUB4jV6LkEPPMrCvScnGlV0ftikdmUmsB902/I3TxWbYpMb3VmBtp3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Iw3c//Hv; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Iw3c//Hv"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78f89501423so14592357b3.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420463; x=1769025263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf1u1jHnBWr47WfcUKOVVlv1I/TeuITEjgBySd75Y4U=;
        b=Iw3c//HvhzJ1iKqrpfFPpGPaDHTsgPd2rUv6ATfBIEUkJttdsZTA+X/+Y+FjhbzXgv
         20/7pk34itzmir1asAhhhThLnAd+rBU4OhGup/Evj9Qazlr6OvviFRfm9d0iSIZGIJvY
         PVGefb2cgLzBxa/OXYH42yqGFJv3JwkLZOIc9vAp9XWrwUSL6XxnFG9W2ZYg57EdZVQM
         cRACFvKFYQXKl7/CAA4MxTWe889aZ+dXUvQVYOURCXnyKKbHjehqjDa56HbIaU+beam7
         Bv2t78zdBVFCM9LGqzq15c+sCTtm4uU6V9KMCmR6q6PCYsS1z9srTwCYx/T2FKqzvY9T
         lLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420463; x=1769025263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vf1u1jHnBWr47WfcUKOVVlv1I/TeuITEjgBySd75Y4U=;
        b=K8ASaB6Sya5OdPNUTk9QaKCfewcVchcBQXxf6+oAl/TYysb8ri49vjI/EwsmGW1tLz
         SbqoNTywLZhbqLls8DOKCDOSfYBouoDORLAc10fu/zhBGN56ZrlFeKAgXg4MwPk2tF1Y
         CO3XzaDXEnV3w1HuyTLYuAgORaR/h8AU1os2JFuYiWsosyGJZft+zyc4WTj4e1xIWk+4
         /e00rS9iNKMAogmYqs41mfBb/SH/O6l8wYME1ZqmOzHxsU3oHj/MZWbBTHq5l5CPxrDP
         wgiIuGAKHhzCc6jFZ6QVEB5hytH9EjCpm0Ual+GE3f4d/1/D3xcBY1zhXPErUa9G8Qal
         Geww==
X-Gm-Message-State: AOJu0YyvJqThI+emPRp3Fg+GOfcNYG4DngiPtPm9F6jFGrbfE2bGMpFw
	iRxjR05OWdVFkWxr0rdnfBbNY/VkNLO1fMP3hwBTDrCKzRPp402e8qfrWQz0Qbq+zTNPSURR/N/
	BntLmH7qVOA==
X-Gm-Gg: AY/fxX4BGVR60B4VeCeeMphsC8b4PIAWnA+/7R4qVfNmwb+Ki2lt6thV0k6KHJuv6tJ
	H8bAvXH2m7Jt36o6Z3ER/eOjN7GHye3ZBSFtRYcFIx/wDY+VP8Q9oi8TqVM5nek0hmaMjeTwduw
	KCxkKq3WH7wOFwfJQIowmL0J+lk1tl3Eo6dSl9ZCbKUDv5mhaiKknyt6PPWbvLVCbd1SqqTFM4i
	3ZvV9pHDK4U/6XctG76duXEbCuiheYRym+iViun9uh6j+JKoy8wcCfy6SZ9qEhVf2CfIC8YhNdM
	Z48GFiYp/8vKfCxPVUCR5A4Wby4pzMR1DZG9MpoVwasM1vEZvjBYU6DagPav/yztmLztgB0iGgs
	6lxW7CoEZN6QnaU+zhyuQAgafconH1ofQYp2q6tsFxY3weX/zFzFWFeUMWoAEww5r/MERV890Th
	ON3f3ZabkDD3OtiZnfddMT9t1jzJJABnnv0bZnlt23gfDLetjcMmZ6G5ShKFjBQCBLiMxH/q1sn
	FJMPUH9/0XYAuOr/Q==
X-Received: by 2002:a05:690e:1489:b0:646:5127:a024 with SMTP id 956f58d0204a3-6490a5eefc2mr564177d50.7.1768420462860;
        Wed, 14 Jan 2026 11:54:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa592cdcsm93567297b3.25.2026.01.14.11.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:22 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:21 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/18] midx: rename `get_midx_checksum()` to
 `midx_get_checksum_hash()`
Message-ID: <7255adafe70a4a49bd83ce2db4203d8e331f49ef.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

Since 541204aabea (Documentation: document naming schema for structs and
their functions, 2024-07-30), we have adopted a naming convention for
functions that would prefer a name like, say, `midx_get_checksum()` over
`get_midx_checksum()`.

Adopt this convention throughout the midx.h API. Since this function
returns a raw (that is, non-hex encoded) hash, let's suffix the function
with "_hash()" to make this clear. As a side effect, this prepares us
for the subsequent change which will introduce a "_hex()" variant that
encodes the checksum itself.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c              | 6 +++---
 midx.c                    | 2 +-
 midx.h                    | 2 +-
 pack-bitmap.c             | 8 ++++----
 pack-revindex.c           | 4 ++--
 t/helper/test-read-midx.c | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 6485cb67068..73d33752ef1 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -946,7 +946,7 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
-		const unsigned char *hash = get_midx_checksum(m);
+		const unsigned char *hash = midx_get_checksum_hash(m);
 
 		get_midx_filename_ext(m->source, &from,
 				      hash, midx_exts[i].non_split);
@@ -1151,7 +1151,7 @@ static int write_midx_internal(struct odb_source *source,
 		while (m) {
 			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
 				error(_("could not load reverse index for MIDX %s"),
-				      hash_to_hex_algop(get_midx_checksum(m),
+				      hash_to_hex_algop(midx_get_checksum_hash(m),
 							m->source->odb->repo->hash_algo));
 				goto cleanup;
 			}
@@ -1520,7 +1520,7 @@ static int write_midx_internal(struct odb_source *source,
 		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
-			keep_hashes[j] = xstrdup(hash_to_hex_algop(get_midx_checksum(m),
+			keep_hashes[j] = xstrdup(hash_to_hex_algop(midx_get_checksum_hash(m),
 								   r->hash_algo));
 			m = m->base_midx;
 		}
diff --git a/midx.c b/midx.c
index 4c90eb04c64..554bdfc505b 100644
--- a/midx.c
+++ b/midx.c
@@ -24,7 +24,7 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
-const unsigned char *get_midx_checksum(const struct multi_pack_index *m)
+const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m)
 {
 	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
 }
diff --git a/midx.h b/midx.h
index 7c7e0b59121..62d6105195f 100644
--- a/midx.h
+++ b/midx.h
@@ -85,7 +85,7 @@ struct multi_pack_index {
 #define MIDX_EXT_BITMAP "bitmap"
 #define MIDX_EXT_MIDX "midx"
 
-const unsigned char *get_midx_checksum(const struct multi_pack_index *m);
+const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m);
 void get_midx_filename(struct odb_source *source, struct strbuf *out);
 void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
 			   const unsigned char *hash, const char *ext);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8ca79725b1d..90ae63e6804 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -441,11 +441,11 @@ char *midx_bitmap_filename(struct multi_pack_index *midx)
 	struct strbuf buf = STRBUF_INIT;
 	if (midx->has_chain)
 		get_split_midx_filename_ext(midx->source, &buf,
-					    get_midx_checksum(midx),
+					    midx_get_checksum_hash(midx),
 					    MIDX_EXT_BITMAP);
 	else
 		get_midx_filename_ext(midx->source, &buf,
-				      get_midx_checksum(midx),
+				      midx_get_checksum_hash(midx),
 				      MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
@@ -502,7 +502,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (load_bitmap_header(bitmap_git) < 0)
 		goto cleanup;
 
-	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum,
+	if (!hasheq(midx_get_checksum_hash(bitmap_git->midx), bitmap_git->checksum,
 		    bitmap_repo(bitmap_git)->hash_algo)) {
 		error(_("checksum doesn't match in MIDX and bitmap"));
 		goto cleanup;
@@ -2820,7 +2820,7 @@ void test_bitmap_walk(struct rev_info *revs)
 
 		if (bitmap_is_midx(found))
 			fprintf_ln(stderr, "Located via MIDX '%s'.",
-				   hash_to_hex_algop(get_midx_checksum(found->midx),
+				   hash_to_hex_algop(midx_get_checksum_hash(found->midx),
 						     revs->repo->hash_algo));
 		else
 			fprintf_ln(stderr, "Located via pack '%s'.",
diff --git a/pack-revindex.c b/pack-revindex.c
index 8598b941c8c..70731071ab6 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -390,11 +390,11 @@ int load_midx_revindex(struct multi_pack_index *m)
 
 	if (m->has_chain)
 		get_split_midx_filename_ext(m->source, &revindex_name,
-					    get_midx_checksum(m),
+					    midx_get_checksum_hash(m),
 					    MIDX_EXT_REV);
 	else
 		get_midx_filename_ext(m->source, &revindex_name,
-				      get_midx_checksum(m),
+				      midx_get_checksum_hash(m),
 				      MIDX_EXT_REV);
 
 	ret = load_revindex_from_disk(m->source->odb->repo->hash_algo,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 6de5d1665af..b8fefb1a124 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -34,7 +34,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		return 1;
 
 	if (checksum) {
-		while (m && strcmp(hash_to_hex(get_midx_checksum(m)), checksum))
+		while (m && strcmp(hash_to_hex(midx_get_checksum_hash(m)), checksum))
 			m = m->base_midx;
 		if (!m)
 			return 1;
@@ -94,7 +94,7 @@ static int read_midx_checksum(const char *object_dir)
 	m = setup_midx(object_dir);
 	if (!m)
 		return 1;
-	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
+	printf("%s\n", hash_to_hex(midx_get_checksum_hash(m)));
 
 	close_midx(m);
 	return 0;
-- 
2.52.0.457.gb599f1ad4b0

