Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC12DA755
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053097; cv=none; b=tfA0/NARdGgLZWE6a13aMSH/Ha/vzB4loPAy1s04UBZQRraMva4YvR6SZQfVAAAnQK6lCoxfSaJrC3MdwbjAVdoS8Pu6fmrIrl+9CRgH+TushMWYxLeekNk4tw2vlz1UJkbAy5yvSZp5gpjGvZEoSiLpA2PtUKYTgPvf9ZZ8WbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053097; c=relaxed/simple;
	bh=0rsdw60LVMNHCRd4Z0TgVm99fRJwFZbLtrEFn2xSlRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXV7rrF+FcMssLZKgnMgf5SSJnaZxYtrVSsqpEgHE+LQ6wV2QVdmWzVXo7FHvrefRxqsucSMpamf/y/S/pDT2EGBdodMO6UhQOcwEYBbqXHAL8Q5g88b6xymu/17zbi6O9RWBGwXFSaLS0CnkBPbIBVwciiLlMAGNpFqqfWNe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QFxdZJTj; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QFxdZJTj"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6443b62daf6so2854856d50.0
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053093; x=1765657893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzmPXCns81RYV9D+u1KKBH0CwHQ9jyUgpd21dnvNwwI=;
        b=QFxdZJTjUtO0EVaP1GnbGe/wxLNGcvUmkNwZEUFGDbZUnTVquTeT3jgIjQeRntGDbZ
         rDariZBmp+hV/YRJI95WMYBT73YeA4obOFwaoAotT7S8NpsGS8L7v+3jSBWTnmZHALA+
         fZzMLoa5oQqesHZCnI1TJ+OrNJQnvuiymYP6PEGs9PeKDsH6gpT0QHZZlV/zCkygytva
         gHABuF/06k3ubzXdkoVsa2Wglm/GrclRbbknzyxuvbR4FdLpMAm2wiTCAAURLMYmBTw7
         wDC7dVVZ3Q3IFDvhPpgT0rz9pjSIdgEMYwopD0n5SnCkv7RNrsqIVYEcy5zq6rEL5MHz
         0hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053093; x=1765657893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzmPXCns81RYV9D+u1KKBH0CwHQ9jyUgpd21dnvNwwI=;
        b=mVac9arSJBqDEmECnwkfl+AIXwWKw9r65IULa1mg5bqq7GwKHV4WdiEeqkkj7u5/pk
         GL1BJGL1MbupLee+c6yiXSF75fcZTVrZOqWoRVT0LaDoR9/TZbyJo42cJ7TZiCUnzM7u
         Tmz5A8Q5VfUZLQ4Y+h0lmj8ilpLxn3WXN8l77+YPm3qVdNx1bDB6vTJbrQio37YPrBfQ
         CflXHvMKzC+o3rfGiyBFfyQvX1avofP/ATQREtZhHPp2Xg4HzLcIYwnD6UCER+6at0pF
         MTi5sdflC1TU38P6uwvxxym7MhhDi07m0/aQY/xCek91hY+w4LUP2KuiriFH2dYqZp47
         gFLA==
X-Gm-Message-State: AOJu0YzcRam3h/6BZT3/Jl/JQO12XMLyqx4Mad+DCuPfAWfdRjTw55GR
	bf7INP/VWHxHt7im+lDRhnlQ31wiZDK7KmKGn9vPgjBSbPqkjSqekxq3xiJWqLa+FHiWxBRIZoO
	MofMKc24=
X-Gm-Gg: ASbGncvXnP4BNBf+XmGY0L98gwFnvFLVjPDz9uKGhtOgqNaQuCpr030VHZvOp90QNV4
	XLoWE9Abc6OnKAl7DfRmhp3YmKlFSUibKBcA/AqnFojZbt3CvbCwS8OBicQEIaFjOPUQrVgo5vU
	lFttAl56pDFprpoSQmzA2bk8zh0VaIQZqyvnI4Snn3eqMkiJVdgRR+tPAl/szLlBkpGUEYNrJzv
	EBdSHWd8iWOjDfyJRMULcIbORkp+0l4z4Pd2jz3gHlPeOBvzRvUzBwShjQcfHjNtYIdsfQabrTZ
	WUjxMwzsdJY3WPSSxrFVHoD17/6/hcLiCu1GlT2xaQ1fhVfRjv7WkmNpzMWrx1bC+pbspPwoKxW
	l7KExEbT3H/mIimp/yhWKrPPbp5PNicHOwzjwCLkVk+q16ZUxJvvoEsDwNfb3oAxoTBNaPsVlZn
	xugSjG5Mg+bTC0h0kUo0q+T0lS3fgzpeuNbx8rlTRi2zwhxFcwYFZtzdAXDCQVxYpxYnYd5Y7nE
	5ug0+ZXnhsbtYToTg==
X-Google-Smtp-Source: AGHT+IHf5CnsE0Y0v4Xkx8ABeIhH91n8nRNML18peOWZtnuk3f6WI8WICQH2M0xhA+qYqqwlOnMV9Q==
X-Received: by 2002:a05:690e:4258:b0:641:f5bc:6950 with SMTP id 956f58d0204a3-6444e7d8da0mr1814845d50.84.1765053092717;
        Sat, 06 Dec 2025 12:31:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b79942dsm30446427b3.49.2025.12.06.12.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:32 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:31 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 11/17] midx-write.c: introduce `midx_pack_perm()` helper
Message-ID: <d4f0b369b6f6b37ffe3823fec1f64b0e542e080d.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

The `ctx->pack_perm` array can be considered as a permutation between
the original `pack_int_id` of some given pack to its position in the
`ctx->info` array containing all packs.

Today we can always index into this array with any known `pack_int_id`,
since there is never a `pack_int_id` which is greater than or equal to
the value `ctx->nr`.

That is not necessarily the case with MIDX compaction. For example,
suppose we have a MIDX chain with three layers, each containing three
packs. The base of the MIDX chain will have packs with IDs 0, 1, and 2,
the next layer 3, 4, and 5, and so on. If we are compacting the topmost
two layers, we'll have input `pack_int_id` values between [3, 8], but
`ctx->nr` will only be 6.

In that example, if we want to know where the pack whose original
`pack_int_id` value was, say, 7, we would compute `ctx->pack_perm[7]`,
leading to an uninitialized read, since there are only 6 entries
allocated in that array.

To address this, there are a couple of options:

 - We could allocate enough entries in `ctx->pack_perm` to accommodate
   the largest `orig_pack_int_id` value.

 - Or, we could internally shift the input values by the number of packs
   in the base layer of the lower end of the MIDX compaction range.

This patch prepare us to take the latter approach, since it does not
allocate more memory than strictly necessary. (In our above example, the
base of the lower end of the compaction range is the first MIDX layer
(having three packs), so we would end up indexing `ctx->pack_perm[7-3]`,
which is a valid read.)

Note that this patch does not actually implement that approach yet, but
merely performs a behavior-preserving refactoring which will make the
change easier to carry out in the future.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 55342fcb6dd..4a1a16431a6 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -114,6 +114,12 @@ struct write_midx_context {
 	struct odb_source *source;
 };
 
+static uint32_t midx_pack_perm(struct write_midx_context *ctx,
+			       uint32_t orig_pack_int_id)
+{
+	return ctx->pack_perm[orig_pack_int_id];
+}
+
 static int should_include_pack(const struct write_midx_context *ctx,
 			       const char *file_name)
 {
@@ -509,12 +515,12 @@ static int write_midx_object_offsets(struct hashfile *f,
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *obj = list++;
 
-		if (ctx->pack_perm[obj->pack_int_id] == PACK_EXPIRED)
+		if (midx_pack_perm(ctx, obj->pack_int_id) == PACK_EXPIRED)
 			BUG("object %s is in an expired pack with int-id %d",
 			    oid_to_hex(&obj->oid),
 			    obj->pack_int_id);
 
-		hashwrite_be32(f, ctx->pack_perm[obj->pack_int_id]);
+		hashwrite_be32(f, midx_pack_perm(ctx, obj->pack_int_id));
 
 		if (ctx->large_offsets_needed && obj->offset >> 31)
 			hashwrite_be32(f, MIDX_LARGE_OFFSET_NEEDED | nr_large_offset++);
@@ -615,7 +621,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *e = &ctx->entries[i];
 		data[i].nr = i;
-		data[i].pack = ctx->pack_perm[e->pack_int_id];
+		data[i].pack = midx_pack_perm(ctx, e->pack_int_id);
 		if (!e->preferred)
 			data[i].pack |= (1U << 31);
 		data[i].offset = e->offset;
@@ -625,7 +631,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *e = &ctx->entries[data[i].nr];
-		struct pack_info *pack = &ctx->info[ctx->pack_perm[e->pack_int_id]];
+		struct pack_info *pack = &ctx->info[midx_pack_perm(ctx, e->pack_int_id)];
 		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
 			pack->bitmap_pos = i + base_objects;
 		pack->bitmap_nr++;
@@ -686,7 +692,7 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 		struct object_entry *to = packlist_alloc(pdata, &from->oid);
 
 		oe_set_in_pack(pdata, to,
-			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
+			       ctx->info[midx_pack_perm(ctx, from->pack_int_id)].p);
 	}
 
 	trace2_region_leave("midx", "prepare_midx_packing_data", ctx->repo);
@@ -1285,7 +1291,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 						      sizeof(*ctx.info),
 						      idx_or_pack_name_cmp);
 		if (preferred) {
-			uint32_t perm = ctx.pack_perm[preferred->orig_pack_int_id];
+			uint32_t perm = midx_pack_perm(&ctx, preferred->orig_pack_int_id);
 			if (perm == PACK_EXPIRED)
 				warning(_("preferred pack '%s' is expired"),
 					opts->preferred_pack_name);
-- 
2.52.0.171.gd6a4e6b6955

