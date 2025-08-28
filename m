Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68BF33CE9D
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402804; cv=none; b=l614ltlE0eb+0u4hQIN8LIH+mG4NJabFdgyGOp9HQPZlGSYemZRyQQw1Airn/RZZIRPKehMmg4px//mG39I+xYjqchpGN6BJcSnT+YQ+ndWQdT0ypUDOwRalDEXu2y7ILXpO38DDS2MbeZGNJggvmxTVzJTknMi+OhJK66raG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402804; c=relaxed/simple;
	bh=ZqZENKhaIoKBvu2dbyNPgCFIOFe9FfgjAu0cY2tvQB4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JE6JkXkupG+aNJVH/lIEs8pAfLgUCK/cLxE5ErDKF/oSDGK72I9X91TZINhrGGkPAA7ySdULUcdS+BVafQPYH8Wn/oumf4HbiZvSHZ86SjSodkEcJZIbPPwSwwVsr2y51VT1vJmlsni4vmHl37USdffUPzNXiwHghwBRaBJiOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyklWJTv; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyklWJTv"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7f84c17078fso116212685a.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756402801; x=1757007601; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsLLrV71LPYm/g66xFqkxQT0VwZler5p+h4urTYGHzY=;
        b=RyklWJTvQ28AnvagEgVIEoKmOOo2PYqwPPOeXDzcDU+5cRBxwx6I/XAiZOiv/387dd
         yy15k2Ox6MRrXGXC17+Xusc9N+3lRNWvzCvYFdCNj4Ca0CP3G+bbYBxNo7/2pVsjPG8x
         fzIE3bsQH42YyELX+R+Oh/CHD7ooqjvtGYmGCKQDlBCEo/8mMxXuahYz9OR4AnOViNAk
         5oTJCHAZPelV5CXGpoigA3AKs0PgKrC3uzCSGYJ/k3xo0/5XLBGlJLwWgNpVgWJ3Zy5Y
         QunPUjnCqLXO1JnRPcPKukWqQ/bUdxNj9W8/jKUHa64CmGH3FLVmU+xL/fcETFkIAucG
         2Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756402801; x=1757007601;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsLLrV71LPYm/g66xFqkxQT0VwZler5p+h4urTYGHzY=;
        b=nBYU/9J2w5qZs9piOEyfoKnOcBBFwD3epDz1fnW0R0NACNBr0DeKdESxmynlDP1Pdg
         XmkuW3IxF1jpsv04UdGEscsPDFWf7BfbIhUz8YUMuAng0qsSHxsIConNJsNpc7mAINa4
         xusuJI6M6nYNxnZKZ1AAUtnsiPR2aBQiIt1sTXCT/5NSWS/9n4ir1dgv52uXqCZD2ySB
         pnFguQcRnd+87KPLWN4gA2H7eT3Wq3zBC/lS76soy/2grIQM8SGneLBA6uQjHZfaff+J
         YD+AHAO6jKZ59hiiC52ky8avKnE9XzYXucPMqfSNjQn+o+vvKHnwqacSYJ5Lu+HIyWrg
         jREQ==
X-Gm-Message-State: AOJu0YxQpJjOlqX4Xb6mD5EDlS343cxzP2so6mP32q88wTsSv6hYRhl2
	KMT0S2TtUG67e22g56U+uYIy7Q2Xt5wwJ+YeNTG1D5SA3s0RYLS7wQ79ziZeHvHN
X-Gm-Gg: ASbGncs/X2m1TM4tiylQckvqAbAW8UbwlV5DhBOh6BNNPnk2vSmFZgms5Yo9ajxsM5L
	KqKLWTukEKarmaa3vz3tT8aGIcvGlPBp9hjxycq4/3CPeVVlg4t0rLL2qd5VIcWK3B0/tCtFgsa
	2kU5xfaHJyN1OzUE0FqgThf5vEOibsA2tYKtsiYH6rs+Wijx9t+4D+sg8vx4IiyaXPzCGlEUoc/
	UQrupAlGnQ23SYRQTD8vil7df/rxxVVik5QnyN9zPOy5y4aPzj9wYexnmbBlWGC9+c4WbBZWI5c
	m/95RST47K1vCsDkmijIB00/tKk/VOIpSgYPwu+2wKmm0919x2lEZpQr9as9C8JRCiqVZ1+yh3w
	9UMT+bZ58LmTV/BJksGFDsphw1HqG/lPws5o=
X-Google-Smtp-Source: AGHT+IGSOinkiwolE9gadC6ekKuv9rC/u4cirqTefNwZyrx1Vx9RH/f5IXMvfGF3uApei9MEhLYjuw==
X-Received: by 2002:a05:620a:a017:b0:7e8:74d:fdf5 with SMTP id af79cd13be357-7ea10fc7aadmr2869308085a.4.1756402801079;
        Thu, 28 Aug 2025 10:40:01 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.244.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0d67c51asm22932885a.5.2025.08.28.10.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:40:00 -0700 (PDT)
Message-Id: <bd97db26f7f789315134dc796403b1ab9976135b.1756402795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 17:39:54 +0000
Subject: [PATCH 4/5] midx-write: use uint32_t for preferred_pack_idx
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

midx-write.c has the DISABLE_SIGN_COMPARE_WARNINGS macro defined for a
few reasons, but the biggest one is the use of a signed
preferred_pack_idx member inside the write_midx_context struct. The code
currently uses -1 to indicate an unset preferred pack but pack int ids
are normally handled as uint32_t. There are also a few loops that search
for the preferred pack by name and those iterators will need updates to
uint32_t in the next change.

For now, replace the use of -1 with a 'NO_PREFERRED_PACK' macro and an
equality check. The macro stores the max value of a uint32_t, so we
cannot store a preferred pack that appears last in a list of 2^32 total
packs, but that's expected to be unreasonable already. This improves the
range from 2^31 already.

There are some careful things to worry about with initializing the
preferred pack in the struct and using that value when searching for a
preferred pack that was already incorrect but accidentally working when
the index was initialized to zero.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index f2d9a990e6..ea1b3a199c 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -24,6 +24,7 @@
 #define BITMAP_POS_UNKNOWN (~((uint32_t)0))
 #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
+#define NO_PREFERRED_PACK (~((uint32_t)0))
 
 extern int midx_checksum_valid(struct multi_pack_index *m);
 extern void clear_midx_files_ext(const char *object_dir, const char *ext,
@@ -104,7 +105,7 @@ struct write_midx_context {
 	unsigned large_offsets_needed:1;
 	uint32_t num_large_offsets;
 
-	int preferred_pack_idx;
+	uint32_t preferred_pack_idx;
 
 	int incremental;
 	uint32_t num_multi_pack_indexes_before;
@@ -260,7 +261,7 @@ static void midx_fanout_sort(struct midx_fanout *fanout)
 static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					struct multi_pack_index *m,
 					uint32_t cur_fanout,
-					int preferred_pack)
+					uint32_t preferred_pack)
 {
 	uint32_t start = m->num_objects_in_base, end;
 	uint32_t cur_object;
@@ -274,7 +275,7 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 	end = m->num_objects_in_base + ntohl(m->chunk_oid_fanout[cur_fanout]);
 
 	for (cur_object = start; cur_object < end; cur_object++) {
-		if ((preferred_pack > -1) &&
+		if ((preferred_pack != NO_PREFERRED_PACK) &&
 		    (preferred_pack == nth_midxed_pack_int_id(m, cur_object))) {
 			/*
 			 * Objects from preferred packs are added
@@ -364,7 +365,8 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 						    preferred, cur_fanout);
 		}
 
-		if (-1 < ctx->preferred_pack_idx && ctx->preferred_pack_idx < start_pack)
+		if (ctx->preferred_pack_idx != NO_PREFERRED_PACK &&
+		    ctx->preferred_pack_idx < start_pack)
 			midx_fanout_add_pack_fanout(&fanout, ctx->info,
 						    ctx->preferred_pack_idx, 1,
 						    cur_fanout);
@@ -1042,7 +1044,9 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct tempfile *incr;
-	struct write_midx_context ctx = { 0 };
+	struct write_midx_context ctx = {
+		.preferred_pack_idx = NO_PREFERRED_PACK,
+	 };
 	int bitmapped_packs_concat_len = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
@@ -1150,7 +1154,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		goto cleanup; /* nothing to do */
 
 	if (preferred_pack_name) {
-		ctx.preferred_pack_idx = -1;
+		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 
 		for (i = 0; i < ctx.nr; i++) {
 			if (!cmp_idx_or_pack_name(preferred_pack_name,
@@ -1160,12 +1164,12 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			}
 		}
 
-		if (ctx.preferred_pack_idx == -1)
+		if (ctx.preferred_pack_idx == NO_PREFERRED_PACK)
 			warning(_("unknown preferred pack: '%s'"),
 				preferred_pack_name);
 	} else if (ctx.nr &&
 		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
-		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
+		struct packed_git *oldest = ctx.info[0].p;
 		ctx.preferred_pack_idx = 0;
 
 		if (packs_to_drop && packs_to_drop->nr)
@@ -1193,17 +1197,17 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			 * objects to resolve, so the preferred value doesn't
 			 * matter.
 			 */
-			ctx.preferred_pack_idx = -1;
+			ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 		}
 	} else {
 		/*
 		 * otherwise don't mark any pack as preferred to avoid
 		 * interfering with expiration logic below
 		 */
-		ctx.preferred_pack_idx = -1;
+		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 	}
 
-	if (ctx.preferred_pack_idx > -1) {
+	if (ctx.preferred_pack_idx != NO_PREFERRED_PACK) {
 		struct packed_git *preferred = ctx.info[ctx.preferred_pack_idx].p;
 
 		if (open_pack_index(preferred))
-- 
gitgitgadget

