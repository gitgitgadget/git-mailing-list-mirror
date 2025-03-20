Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B5227E8B
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493427; cv=none; b=g964bFZRjI9d7mhbDmWd+DTt7uySW42Lyx6RFM4Xd3HddlMR+6UVFZWkifDrVV3jUApPHOMk9nUT1j5t3+aqinV9Uzr+R9lBqf9U3tzcfjJEIY4+bwBSqRggn++4Uvd0lUmxAaEObzKgAevemfSzGAOydCvw6AV7DlywusSksFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493427; c=relaxed/simple;
	bh=8W/VW8WknwNEss3wDjHN7e32EAhgKCTsEBkUpjRBHIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv75udvTFrGa627m3y4NBy+r1DztXi+DKxYs0XyT9BWKZS9CU4dQwuUdX7NkG9lARfh6Vm3/6315MLF947ZaANkbPWDHEI5KcZQr/OHVOL+I8coTqZ27F3ODP6nxJlKK58yP4q36D//Cc9bTWaHvWDh44O0cREKAi1JMRrQcvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HESJa/UL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HESJa/UL"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46fcbb96ba9so2941341cf.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493424; x=1743098224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVhFct6OQmEeFxN9x+GgMtP3qbGV7vjamGAjlpSqNQ8=;
        b=HESJa/ULAQCbDUOo2ns9X2d6LVTYLBsDRtnScy89SUtSHTDgvPmkOYvIj+D+3hs8ca
         aDUzhFhjgAVoxgBYtZ2txmWzx0xSOIYy5tVw27Pbzzr5xEH2tOSBkV8Ft1mzarZeyVyE
         cfASqy69Gg/MieUwZGgLF0R2+DgjFSJIvD0ysJAhwi9RyvsorwgrlXJWmu4gXM8AYaD+
         jJBiikSrwLqWs4ktVhjQlcWQVeJ1I9xrzqQHqr5FbfbICvPrOyY0wiZcCOGEDrz0mOES
         rYzhKg1Q4UrzuW7KcPBji5XR/toT5NUWl0BQgJHjAxIYug65JAPvrXzwd5+MTz39VMgx
         XOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493424; x=1743098224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVhFct6OQmEeFxN9x+GgMtP3qbGV7vjamGAjlpSqNQ8=;
        b=EOhrPPKgmgNZo+k/CQ5xyRq14XpmfAAWRxX407TfE3IAsK+DcMnDCegRBSL2siidWp
         qxHgDKc86a42z6SHY7M2XJV2hElhunGEeO4UPT+68P6ib1fQJjkP9SpHN8o5mKc9HJIB
         NHwxAoik1y12+1u2IKHXr5P+tzHZHc0g5vfw2iDLGg47g25gIyFVGeUrR1mIUacS3rsu
         Qsc/MC5Syy0sZjckTXdqv4eonFD3hhP1CkD3ZRbk9dDCFtCfmuyCE2393gVGWZJwoYs3
         MgDT9L38eCb9RG3Bv09GdXZcTIEDI3pBQLUxoM0tjGo5VNNl2JzBbJlVgX1PkTBuHwsj
         eLvQ==
X-Gm-Message-State: AOJu0YxrG4NB/AZa/u0WA1EKM6u8b3oYdtSJvCRErmWdTgL54SS99YtJ
	xOpm+Af3JMQ9iVcCZDI1hh+U7OOJps0B0aGN7F1sTDAE1ZHQZVxp9R860PDyYTRwmlqjNxo09JN
	P1EQ=
X-Gm-Gg: ASbGncvtD3IxDORHymJ4/U5eqlfmzxDOcPGriStutTBXyus6Dddkj45q9DcLHUa4cQ+
	VexhA/6Hp590HJpWDG0ZgQC85YloLr1XSTi4Ya4iuCxklmoaLO1YET60BROr0GTz6w74S+fbooM
	2ny2ruuRJg7NgM9PXk9//cujAgcWK1sewh425V9Jzmo8IEQV103yVRrraG6RgKn60M2jn+p0scc
	9EAaZrUSYtiZbwBR7dioEvGVWggKv6YaLd+29t/39bLN9m15Ox94oOWhl80Iv8cXUovjk2Smakv
	wCfWjChA65nTFmFIib02AfL8OFFA7n7+S58DOu7mT/etYoaoK/x0M6mG3PbCnAd5tZUzSXDChus
	uWEVUwx7lCtkPXj1U
X-Google-Smtp-Source: AGHT+IGZ9Qel95/MXn+JGCZ6HsrRQnuS+kFWMwMf+bt3Sk791dYEyj94JdUp6Ub47EwdVRG0nTyHVw==
X-Received: by 2002:a05:622a:4c0d:b0:476:739a:5cf3 with SMTP id d75a77b69052e-4771dd607edmr3699361cf.1.1742493424283;
        Thu, 20 Mar 2025 10:57:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d18f7d4sm1516381cf.37.2025.03.20.10.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:57:03 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:57:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 12/14] pack-bitmap.c: keep track of each layer's type
 bitmaps
Message-ID: <439e743fd52e2023a2a215ce00703f6de1dea856.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

Prepare for reading the type-level bitmaps from previous bitmap layers
by maintaining an array for each type, where each element in that type's
array corresponds to one layer's bitmap for that type.

These fields will be used in a later commit to instantiate the 'struct
ewah_or_iterator' for each type.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1d1e1a65ca..5721fa7a0f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -81,6 +81,23 @@ struct bitmap_index {
 	struct ewah_bitmap *blobs;
 	struct ewah_bitmap *tags;
 
+	/*
+	 * Type index arrays when this bitmap is associated with an
+	 * incremental multi-pack index chain.
+	 *
+	 * If n is the number of unique layers in the MIDX chain, then
+	 * commits_all[n-1] is this structs 'commits' field,
+	 * commits_all[n-2] is the commits field of this bitmap's
+	 * 'base', and so on.
+	 *
+	 * When associated either with a non-incremental MIDX or a
+	 * single packfile, these arrays each contain a single element.
+	 */
+	struct ewah_bitmap **commits_all;
+	struct ewah_bitmap **trees_all;
+	struct ewah_bitmap **blobs_all;
+	struct ewah_bitmap **tags_all;
+
 	/* Map from object ID -> `stored_bitmap` for all the bitmapped commits */
 	kh_oid_map_t *bitmaps;
 
@@ -581,7 +598,32 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 	return load_pack_revindex(r, bitmap_git->pack);
 }
 
-static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
+static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
+{
+	struct bitmap_index *curr = bitmap_git;
+	size_t i = bitmap_git->base_nr;
+
+	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr + 1);
+	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr + 1);
+	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr + 1);
+	ALLOC_ARRAY(bitmap_git->tags_all, bitmap_git->base_nr + 1);
+
+	while (curr) {
+		bitmap_git->commits_all[i] = curr->commits;
+		bitmap_git->trees_all[i] = curr->trees;
+		bitmap_git->blobs_all[i] = curr->blobs;
+		bitmap_git->tags_all[i] = curr->tags;
+
+		curr = curr->base;
+		if (curr && !i)
+			BUG("unexpected number of bitmap layers, expected %"PRIu32,
+			    bitmap_git->base_nr + 1);
+		i -= 1;
+	}
+}
+
+static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
+		       int recursing)
 {
 	assert(bitmap_git->map);
 
@@ -603,10 +645,13 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
 	if (bitmap_git->base) {
 		if (!bitmap_is_midx(bitmap_git))
 			BUG("non-MIDX bitmap has non-NULL base bitmap index");
-		if (load_bitmap(r, bitmap_git->base) < 0)
+		if (load_bitmap(r, bitmap_git->base, 1) < 0)
 			goto failed;
 	}
 
+	if (!recursing)
+		load_all_type_bitmaps(bitmap_git);
+
 	return 0;
 
 failed:
@@ -682,7 +727,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git))
+	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git, 0))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -2052,7 +2097,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (load_bitmap(revs->repo, bitmap_git) < 0)
+	if (load_bitmap(revs->repo, bitmap_git, 0) < 0)
 		goto cleanup;
 
 	if (!use_boundary_traversal)
@@ -2985,6 +3030,10 @@ void free_bitmap_index(struct bitmap_index *b)
 	ewah_pool_free(b->trees);
 	ewah_pool_free(b->blobs);
 	ewah_pool_free(b->tags);
+	free(b->commits_all);
+	free(b->trees_all);
+	free(b->blobs_all);
+	free(b->tags_all);
 	if (b->bitmaps) {
 		struct stored_bitmap *sb;
 		kh_foreach_value(b->bitmaps, sb, {
-- 
2.49.0.14.g88b49c1b34

