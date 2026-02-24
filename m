Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262151DED42
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959623; cv=none; b=GO6+hl4G8CNt6Vk3/qEeQlBXDDa2Bs8s8z1JG8vVHNykg0YNTT8x8XGjijjxau6X97aXunua9JyFm/b1CthmgIN0Gv0g4beH6eoa68Wd/Ml5foaSgoAICm6nBIKQ5s4UgSjhmJQTpcJUdWxeSBiAtjb5uMpc9yjN5/EtB0U0BUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959623; c=relaxed/simple;
	bh=zRUGWvcPPz4zSlsNs/2A8aW8Dp8K/0MrCnxirAJ29uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV/FI/+JdO14EDwupsptXqkesjYEwTZJTzwudqJvc+v4ImdQH+qMihNanmcb6VvZVoNZn+xMFMvosE5Vw79xWZli9B+WBgu+PNahWZezWkuuopVUnBJw3eh+etGADNsJDNHmWmS4CnzvE6uJH8i/s8tjQgBaCw6tv0sjIta/bkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=AlDN0mSA; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="AlDN0mSA"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8cb38e6d164so720021685a.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959621; x=1772564421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYXfZ6aZHXCHz65jtQQTu4u3ZURnc/UsQBHWDHQsri0=;
        b=AlDN0mSA1REAgb/fWhDSSJWUQAhHRX9KoxCtAiOiMUY++haUfjoO5i7Nlszhzoa0mg
         dgwjYxDJfZ46lzi8pGtMVbc6vsLL2Sy3JTcmqxXGQIxPPUFVxY+0fYpDcnnh08kxE7+3
         63r1zVtyn8bz48VxnnVUN3BXS+wehQDP0bVgz9OV6j4jPsD+3M0j6RkcGOaV9Pt9zLNC
         vZY7jKUmtGagUBqMoTdjQNRJJ+3fyrEkqedCWzfvQ1yGC7c1oXJuAaCM8hVLegIfd8Ee
         L/VeSfAu8LqT/gn72j9iESfDpZEvAp985GvIPYtHjYH6ZaOKa7Unu3rbQIISHEmX0PRh
         YDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959621; x=1772564421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYXfZ6aZHXCHz65jtQQTu4u3ZURnc/UsQBHWDHQsri0=;
        b=WXO1K343HofynOJE6R5ckQReMjxzAOd6LKDaIakvsVB/t3ITI9nat0S2WT+M/0hV57
         GavdItzpt5c1QarqEANDYkClvbifObEQHHTnIJEutxey0p5F5nIPSZl56ICAbewNvVfd
         CNhNwNJG+i6pxnn+WNcgubsctQqhWdVBdDk6zGmQW7qSmi2HaRDgG1+V/d40vLpmPmjB
         4cE9TehNONQZGCeA5fABQZsdHBGbFLkT+SCLKbt2NHA0n+/GNzcCSLicKHyEBg/0a5Na
         AnfYt3t4jbOJMYD3j/Jzi2vDjj4jtVzK2/k6kdwWF/5j3Yy88kBj7cjAIKybf8L9014Z
         Nrqg==
X-Gm-Message-State: AOJu0Yx2AnWemTu1j87tGH8TTVOMbKLLj9Q42AgTB9DTiQ5/4YGc+lNG
	0SUMTWy2S/NhbybcGm7rMk/7B6jtqRRntOxhUjZ20HjbQL7oUSANaFdsDtd9Rtvbpp05JztOshj
	3sEhErX+xqbqh
X-Gm-Gg: AZuq6aK+yPcf10c/T3LOMcK/Ag8gLFFysBZMu/oVGRQxALTq7own2Ij+V42DXNz5gR+
	PUvxC8HFn1+2NChg/6vnHwjQiLQv07lgBB5cnVM8vZCsVgJSFcK2TZoMiDLvNYpE2sRG2QuHAXB
	ZV2jfv08Cg67B3BUmG3lRgWgM/81dZsITIB1JeJEK/UeDBg3NRILq3aMeoX9CtDSVtP7LscPsHH
	NAquxxmlNXMPxyuPSYa7v/ECTrLfjqBE89xQo+agmwaCf6rsPUoPqn7OsLfFoT6kgSOt6TwcvfL
	zhxaKrK6hJ1KcHi5HwS03lFFGaB5SF70YoWF4vArjXbBN9gyOUARyaAOBcGT/7OVs0NB9y42/rV
	cuaX72krms0Mnr81ZELQ6zqYTpjQSuEptEuSdbLJf804EP+cTO/LC+OokSL+E4f8LsEzSvD7k/q
	ZGO7CkZpsIrLT5+S5LLODklT8Ys8Zzj+HuuwJJK2qzKAhPXDIxYSfnC6/P3NsDUn3Ho0ERKr6Wx
	SKETyJp1zUqSpPrWbX6806SHlBCEw==
X-Received: by 2002:a05:620a:4455:b0:8c9:f996:81fd with SMTP id af79cd13be357-8cb8ca0a8femr1806865785a.33.1771959619998;
        Tue, 24 Feb 2026 11:00:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d1218d5sm1030030785a.50.2026.02.24.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:00:19 -0800 (PST)
Date: Tue, 24 Feb 2026 14:00:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/17] midx-write.c: introduce `midx_pack_perm()` helper
Message-ID: <7f99d3d728a41b7df37009def10dcd1a5bdfc9b3.1771959555.git.me@ttaylorr.com>
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
index 5c8700065a1..9d345fb4737 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -119,6 +119,12 @@ struct write_midx_context {
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
@@ -521,12 +527,12 @@ static int write_midx_object_offsets(struct hashfile *f,
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
@@ -627,7 +633,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *e = &ctx->entries[i];
 		data[i].nr = i;
-		data[i].pack = ctx->pack_perm[e->pack_int_id];
+		data[i].pack = midx_pack_perm(ctx, e->pack_int_id);
 		if (!e->preferred)
 			data[i].pack |= (1U << 31);
 		data[i].offset = e->offset;
@@ -637,7 +643,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *e = &ctx->entries[data[i].nr];
-		struct pack_info *pack = &ctx->info[ctx->pack_perm[e->pack_int_id]];
+		struct pack_info *pack = &ctx->info[midx_pack_perm(ctx, e->pack_int_id)];
 		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
 			pack->bitmap_pos = i + base_objects;
 		pack->bitmap_nr++;
@@ -698,7 +704,7 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 		struct object_entry *to = packlist_alloc(pdata, &from->oid);
 
 		oe_set_in_pack(pdata, to,
-			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
+			       ctx->info[midx_pack_perm(ctx, from->pack_int_id)].p);
 	}
 
 	trace2_region_leave("midx", "prepare_midx_packing_data", ctx->repo);
@@ -1384,7 +1390,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 						      sizeof(*ctx.info),
 						      idx_or_pack_name_cmp);
 		if (preferred) {
-			uint32_t perm = ctx.pack_perm[preferred->orig_pack_int_id];
+			uint32_t perm = midx_pack_perm(&ctx, preferred->orig_pack_int_id);
 			if (perm == PACK_EXPIRED)
 				warning(_("preferred pack '%s' is expired"),
 					opts->preferred_pack_name);
-- 
2.53.0.171.gde83996e422

