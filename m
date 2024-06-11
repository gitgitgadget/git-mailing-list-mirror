Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A334CB55
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126902; cv=none; b=TVlP+BguLIEXPFTHdQzXld5NIzFkaJEWXfyorEENFZypKREMGLLh9nsK91RMGgA93wyZhXGPwv+vOx6wpZ9+LlmYpMVyRNBWhXoVgl6s9hp6QRnPlDEzVyHb+aSjz3mRLDg19rjvMpnAiR9XxKA0WAe4QHKFT8e7PfvJzjP4L1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126902; c=relaxed/simple;
	bh=2KRhPwawgmlftB/ce6/nKHSqtvEfkQqoef/QWxwQCcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+p/UcIiUnqzLYZTYIoQMM4chwAB/hCfATdvRJqn8Am77Z2I2BDnPx+UUC6oGMpp6PdFglapg4Ft8ue+XPsgg1ZiSw/8wC43m2pNMPh4Tkb6rA5ov/H27trzCQK4QiVp+z8CqdcL7uWqGJo4EU1Ek/fCge2suqzBQb6Zdvk4FF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wdSI/Md5; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wdSI/Md5"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6fa11ac8695so89235a34.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 10:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718126899; x=1718731699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9hIeBsMNyWNxTNy4LnKQXiMVwos9XS2fWmbam8J6f0=;
        b=wdSI/Md5v5SPfZuq2ugYkXy01nYixYFwRM/tQgNquvrMVz1AIjEjJUDwRU3+tkeRhT
         ZIccn6wQA9+Lh8UfS6pXBV3QaY2ptu+5osa3oqvq6XaK3uP4luJFVcfyaF7GYCIwPnR3
         vMBzeBMaaHSm+xZ0SA9natCu76Uth+veaN6ntYMAELetsKsY/696An0xdraysaDdWQid
         Wlu0NAcgH/U/z9ABDso7ZJh1NKL3S0sIWdYoZ7Ef4MOpxZqMWDFOJ/7Twf6iUIJ7yv7Q
         rnkW2n0vIsGi2EQq9dARoBIF4jRXHTSQQtCWj122OZ/f6AvxxLh91Z1Kg192/WSgaTmP
         ahAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126899; x=1718731699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9hIeBsMNyWNxTNy4LnKQXiMVwos9XS2fWmbam8J6f0=;
        b=IBrIfipAWbUpujN9uSLZhyBqiAAeW/g7lfzn4pEnUeH9NRf0ra7yn8hOqbWvFQKzTZ
         z+4TkOVHzswUZbF65IoBCmKTChfUn8mKstG0lFZGwICPOo0XJQNOK9tzQqRlStp/DjwK
         B90pj3PO4rxjW7Mu3+/LsNT3kMxIgdO8TRdUH13VOrS/Mbxctmn3BJUZUvb4msWixKhx
         Onhjo1KglU8JMWBVpCYH6J4g2hYtzKf68wKJRra2+KJnKaBEAfO9ye284ajz+00C8O2l
         XCHGJPyfKyRUS10Hx8PIGrmohK6Ct6CgqnvSC0wRTyeySufcjv1kP34NHpQtG1vPLpa3
         hgIw==
X-Gm-Message-State: AOJu0YwQSy3jD/ythnb9c6SPA519qSceS+f/Exuvkpy3Ilbtd17oo4zY
	gtXUdYJTJsc7lEg+L1vLRHSiBRjn27t6aJX1aDrag3Jw+EA8U2Zg+uOwR1Jk2OmPd7ZA0dthzU3
	LXhk=
X-Google-Smtp-Source: AGHT+IErwF9dRdW1PJTFQuA3BQFAJ2a7/yJgKCC0V4iA1iW7iDeAmaxBIBon9sBvWm0BcOtCOVcFkg==
X-Received: by 2002:a9d:7383:0:b0:6f9:5bfc:81f0 with SMTP id 46e09a7af769-6f95bfc9347mr11220832a34.31.1718126899228;
        Tue, 11 Jun 2024 10:28:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795332e1cddsm527937985a.132.2024.06.11.10.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:28:18 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:28:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/3] midx-write.c: do not read existing MIDX with
 `packs_to_include`
Message-ID: <0bdf925366daea7ed229883272da79dbcf7023b3.1718126886.git.me@ttaylorr.com>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
 <cover.1718126886.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1718126886.git.me@ttaylorr.com>

Commit d6a8c58675 (midx-write.c: support reading an existing MIDX with
`packs_to_include`, 2024-05-29) changed the MIDX generation machinery to
support reading from an existing MIDX when writing a new one.

Unfortunately, the rest of the MIDX generation machinery is not prepared
to deal with such a change. For instance, the function responsible for
adding to the object ID fanout table from a MIDX source
(midx_fanout_add_midx_fanout()) will gladly add objects from an existing
MIDX for some fanout level regardless of whether or not those objects
came from packs that are to be included in the subsequent MIDX write.

This results in broken pseudo-pack object order (leading to incorrect
object traversal results) and segmentation faults, like so (generated by
running the added test prior to the changes in midx-write.c):

    #0  0x000055ee31393f47 in midx_pack_order (ctx=0x7ffdde205c70) at midx-write.c:590
    #1  0x000055ee31395a69 in write_midx_internal (object_dir=0x55ee32570440 ".git/objects",
        packs_to_include=0x7ffdde205e20, packs_to_drop=0x0, preferred_pack_name=0x0,
        refs_snapshot=0x0, flags=15) at midx-write.c:1171
    #2  0x000055ee31395f38 in write_midx_file_only (object_dir=0x55ee32570440 ".git/objects",
        packs_to_include=0x7ffdde205e20, preferred_pack_name=0x0, refs_snapshot=0x0, flags=15)
        at midx-write.c:1274
    [...]

In stack frame #0, the code on midx-write.c:590 is using the new pack ID
corresponding to some object which was added from the existing MIDX.
Importantly, the pack from which that object was selected in the
existing MIDX does not appear in the new MIDX as it was excluded via
`--stdin-packs`.

In this instance, the pack in question had pack ID "1" in the existing
MIDX, but since it was excluded from the new MIDX, we never filled in
that entry in the pack_perm table, resulting in:

    (gdb) p *ctx->pack_perm@2
    $1 = {0, 1515870810}

Which is what causes the segfault above when we try and read:

    struct pack_info *pack = &ctx->info[ctx->pack_perm[i]];
    if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
        pack->bitmap_pos = 0;

Fundamentally, we should be able to read information from an existing
MIDX when generating a new one. But in practice the midx-write.c code
assumes that we won't run into issues like the above with incongruent
pack IDs, and often makes those assumptions in extremely subtle and
fragile ways.

Instead, let's avoid reading from an existing MIDX altogether, and stick
with the pre-d6a8c58675 implementation. Harden against any regressions
in this area by adding a test which demonstrates these issues.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c                  | 42 ++++++++++++++++++++++++++---------
 t/t5326-multi-pack-bitmaps.sh | 30 +++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 55a6b63bac..0125aa4dc9 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -101,13 +101,27 @@ struct write_midx_context {
 };
 
 static int should_include_pack(const struct write_midx_context *ctx,
-			       const char *file_name,
-			       int exclude_from_midx)
+			       const char *file_name)
 {
-	if (exclude_from_midx && ctx->m && midx_contains_pack(ctx->m, file_name))
+	/*
+	 * Note that at most one of ctx->m and ctx->to_include are set,
+	 * so we are testing midx_contains_pack() and
+	 * string_list_has_string() independently (guarded by the
+	 * appropriate NULL checks).
+	 *
+	 * We could support passing to_include while reusing an existing
+	 * MIDX, but don't currently since the reuse process drags
+	 * forward all packs from an existing MIDX (without checking
+	 * whether or not they appear in the to_include list).
+	 *
+	 * If we added support for that, these next two conditional
+	 * should be performed independently (likely checking
+	 * to_include before the existing MIDX).
+	 */
+	if (ctx->m && midx_contains_pack(ctx->m, file_name))
 		return 0;
-	if (ctx->to_include && !string_list_has_string(ctx->to_include,
-						       file_name))
+	else if (ctx->to_include &&
+		 !string_list_has_string(ctx->to_include, file_name))
 		return 0;
 	return 1;
 }
@@ -121,7 +135,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
 
-		if (!should_include_pack(ctx, file_name, 1))
+		if (!should_include_pack(ctx, file_name))
 			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
@@ -880,9 +894,6 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 	uint32_t i;
 
 	for (i = 0; i < ctx->m->num_packs; i++) {
-		if (!should_include_pack(ctx, ctx->m->pack_names[i], 0))
-			continue;
-
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
 		if (flags & MIDX_WRITE_REV_INDEX || preferred_pack_name) {
@@ -937,7 +948,15 @@ static int write_midx_internal(const char *object_dir,
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
 
-	ctx.m = lookup_multi_pack_index(the_repository, object_dir);
+	if (!packs_to_include) {
+		/*
+		 * Only reference an existing MIDX when not filtering which
+		 * packs to include, since all packs and objects are copied
+		 * blindly from an existing MIDX if one is present.
+		 */
+		ctx.m = lookup_multi_pack_index(the_repository, object_dir);
+	}
+
 	if (ctx.m && !midx_checksum_valid(ctx.m)) {
 		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
 		ctx.m = NULL;
@@ -946,7 +965,6 @@ static int write_midx_internal(const char *object_dir,
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
 	ctx.info = NULL;
-	ctx.to_include = packs_to_include;
 	ALLOC_ARRAY(ctx.info, ctx.alloc);
 
 	if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
@@ -963,6 +981,8 @@ static int write_midx_internal(const char *object_dir,
 	else
 		ctx.progress = NULL;
 
+	ctx.to_include = packs_to_include;
+
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index cc7220b6c0..916da389b6 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -551,4 +551,34 @@ do
 	'
 done
 
+test_expect_success 'remove one packfile between MIDX bitmap writes' '
+	git init remove-pack-between-writes &&
+	(
+		cd remove-pack-between-writes &&
+
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+
+		# Create packs with the prefix "pack-A", "pack-B",
+		# "pack-C" to impose a lexicographic order on these
+		# packs so the pack being removed is always from the
+		# middle.
+		packdir=.git/objects/pack &&
+		A="$(echo A | git pack-objects $packdir/pack-A --revs)" &&
+		B="$(echo B | git pack-objects $packdir/pack-B --revs)" &&
+		C="$(echo C | git pack-objects $packdir/pack-C --revs)" &&
+
+		git multi-pack-index write --bitmap &&
+
+		cat >in <<-EOF &&
+		pack-A-$A.idx
+		pack-C-$C.idx
+		EOF
+		git multi-pack-index write --bitmap --stdin-packs <in &&
+
+		git rev-list --test-bitmap HEAD
+	)
+'
+
 test_done
-- 
2.45.2.448.g06de4005f1

