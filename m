Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ADC1D4325
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054050; cv=none; b=mCB55g/s5eEARljyW+pyFItxDgq3yq3mIGbDhkOKVpWExCz4t24E1+gqh2fyAu08cPN3wQphqRsRHVO9fRcuCkVtElPE5pWi2zeVSk3ZEVIVZ4XnV6GfAf6nnIjDdeXTOGew+vwa1t8C6qUUOG4kQ00rsDIG6hN3g3rLiCioITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054050; c=relaxed/simple;
	bh=L/MxjGPKK/aT+dWI59kd9+KF9SJ6jAAOir8MZW7uGfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwJTOGa6lFi/PDpaSEeQ3twVeIOINvARE8t4okPub4eATIlkxS+EfT3g8sLbvruh4lfNnb+jQ3wXBT2ASNcYaqyKCrLX0k+a4DOllJJqmntUMfR/gfKdjU9bMk5J3TAIOn4Re3FkrgDtv0rJn3v/i9J71vGVfn6YLEtYKZOtR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ey8r7E1K; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ey8r7E1K"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3873c7c9b4so1663557276.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054047; x=1732658847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2A+CS3T3JINS9cb+RzT8lj8gtedBPWkQsf3U52Y7MMM=;
        b=Ey8r7E1KinvvqNeGPRBwtTKr7cpoNKeh4y3xZJlS31mjtZTO6BC6ndR8lvUgqiZ3z5
         B9B/gnmWMaHCuuEBUmGgjmJ0xR6N8ejPsnCDJy8jXr2NHO7Nc3cXZD7l9Rn0bde8LrUg
         IKD9izs2Dd08bwpkcq35YRi9u92BRZAJ7iUqaKpuDiFlNwA/a7+wivpE1pTgUQHbc0pf
         H8fjUMEttJdAKyAXc138JTqf987UEFU339waIDp0uzQIXCaHVMgBD6YVC3/9NqafZCoD
         Xysygon+dDlEtG4SJA6T0ph83R6QTgYvRImpl8TG1Q0VNsMI1SdxDUW4GxZLUWVQlZef
         oHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054047; x=1732658847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A+CS3T3JINS9cb+RzT8lj8gtedBPWkQsf3U52Y7MMM=;
        b=iF8l+knNYOw+DPdWMnBRxly/HH9/dRPfUnhqjx4w5ZUemheHGmcV6lhIqV4q8LGJo/
         ufPQRdRZbJ7VGEKS7TDm21CE8jHERORhIiRGYYDYeLuU50jZ64qauHdPm6+NjBxuffrV
         iWf0Nw0LXbRTofzTyDwxgTpbnVpSdcF9WHAvBtBmibP11fJPIawLK7sF54ba+D2pWahz
         H08f/sTnvDzlwio23atI11d0reUwp/H/yC4n9BFJ+kbOdN19VYxxIo4spWZBw64YPta3
         m4ukFWM1jvS13YSj/wlLRdzh4FXvI1L9gVZqu0RHKHeIPSPwEGbIncZT1Cgz2RFPg18v
         0MpA==
X-Gm-Message-State: AOJu0YxYqgarDmxcRMUH+NU63CmBP/cbGT5iLrZxJoo+b04c8uWbJF4w
	c/qXILiedpj/py1EzmJHciTy1q7JxuA7/AGwxgyyREnxmJqlyV+XfIjFMT1elph5I5MU/qh7/So
	Bdjo=
X-Google-Smtp-Source: AGHT+IEvTRqsSdivhh7vyaSIgmrM/21qU2f0+SgoxL2aM4JDuVSEv2jFpL4WZuEKd92i9gIFwGiOvw==
X-Received: by 2002:a05:6902:1b88:b0:e29:2466:c813 with SMTP id 3f1490d57ef6-e38cb56ef60mr382476276.19.1732054047443;
        Tue, 19 Nov 2024 14:07:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e7e7718sm2716126276.40.2024.11.19.14.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:27 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/13] pack-bitmap.c: open and store incremental bitmap
 layers
Message-ID: <5b5d625cbe02560a20c12b7dd20aeda4979017bb.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

Prepare the pack-bitmap machinery to work with incremental MIDXs by
adding a new "base" field to keep track of the bitmap index associated
with the previous MIDX layer.

The changes in this commit are mostly boilerplate to open the correct
bitmap(s), add them to the chain bitmap layers along the "base" pointer,
ensures that the correct packs and their reverse indexes are loaded
across MIDX layers, etc.

While we're at it, keep track of a base_nr field to indicate how many
bitmap layers (including the current bitmap) exist. This will be used in
a future commit to allocate an array of 'struct ewah_bitmap' pointers to
collect all of the respective type bitmaps among all layers to
initialize a multi-EWAH iterator.

Subsequent commits will teach the functions within the pack-bitmap
machinery how to interact with these new fields.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 64 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index bba9c6a905a..41675a69f68 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -54,6 +54,13 @@ struct bitmap_index {
 	struct packed_git *pack;
 	struct multi_pack_index *midx;
 
+	/*
+	 * If using a multi-pack index chain, 'base' points to the
+	 * bitmap index corresponding to this bitmap's midx->base_midx.
+	 */
+	struct bitmap_index *base;
+	uint32_t base_nr;
+
 	/* mmapped buffer of the whole bitmap index */
 	unsigned char *map;
 	size_t map_size; /* size of the mmaped buffer */
@@ -377,8 +384,13 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
 	struct strbuf buf = STRBUF_INIT;
-	get_midx_filename_ext(&buf, midx->object_dir, get_midx_checksum(midx),
-			      MIDX_EXT_BITMAP);
+	if (midx->has_chain)
+		get_split_midx_filename_ext(&buf, midx->object_dir,
+					    get_midx_checksum(midx),
+					    MIDX_EXT_BITMAP);
+	else
+		get_midx_filename_ext(&buf, midx->object_dir,
+				      get_midx_checksum(midx), MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
 }
@@ -397,10 +409,17 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 {
 	struct stat st;
 	char *bitmap_name = midx_bitmap_filename(midx);
-	int fd = git_open(bitmap_name);
+	int fd;
 	uint32_t i, preferred_pack;
 	struct packed_git *preferred;
 
+	fd = git_open(bitmap_name);
+	if (fd < 0 && errno == ENOENT) {
+		FREE_AND_NULL(bitmap_name);
+		bitmap_name = midx_bitmap_filename(midx);
+		fd = git_open(bitmap_name);
+	}
+
 	if (fd < 0) {
 		if (errno != ENOENT)
 			warning_errno("cannot open '%s'", bitmap_name);
@@ -446,7 +465,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		goto cleanup;
 	}
 
-	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
 		if (prepare_midx_pack(the_repository, bitmap_git->midx, i)) {
 			warning(_("could not open pack %s"),
 				bitmap_git->midx->pack_names[i]);
@@ -459,13 +478,20 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		goto cleanup;
 	}
 
-	preferred = bitmap_git->midx->packs[preferred_pack];
+	preferred = nth_midxed_pack(bitmap_git->midx, preferred_pack);
 	if (!is_pack_valid(preferred)) {
 		warning(_("preferred pack (%s) is invalid"),
 			preferred->pack_name);
 		goto cleanup;
 	}
 
+	if (midx->base_midx) {
+		bitmap_git->base = prepare_midx_bitmap_git(midx->base_midx);
+		bitmap_git->base_nr = bitmap_git->base->base_nr + 1;
+	} else {
+		bitmap_git->base_nr = 1;
+	}
+
 	return 0;
 
 cleanup:
@@ -516,6 +542,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	bitmap_git->map_size = xsize_t(st.st_size);
 	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	bitmap_git->map_pos = 0;
+	bitmap_git->base_nr = 1;
 	close(fd);
 
 	if (load_bitmap_header(bitmap_git) < 0) {
@@ -535,8 +562,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git)) {
-		uint32_t i;
-		int ret;
+		struct multi_pack_index *m;
 
 		/*
 		 * The multi-pack-index's .rev file is already loaded via
@@ -545,10 +571,15 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 		 * But we still need to open the individual pack .rev files,
 		 * since we will need to make use of them in pack-objects.
 		 */
-		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-			ret = load_pack_revindex(r, bitmap_git->midx->packs[i]);
-			if (ret)
-				return ret;
+		for (m = bitmap_git->midx; m; m = m->base_midx) {
+			uint32_t i;
+			int ret;
+
+			for (i = 0; i < m->num_packs; i++) {
+				ret = load_pack_revindex(r, m->packs[i]);
+				if (ret)
+					return ret;
+			}
 		}
 		return 0;
 	}
@@ -574,6 +605,13 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
 	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
 		goto failed;
 
+	if (bitmap_git->base) {
+		if (!bitmap_is_midx(bitmap_git))
+			BUG("non-MIDX bitmap has non-NULL base bitmap index");
+		if (load_bitmap(r, bitmap_git->base) < 0)
+			goto failed;
+	}
+
 	return 0;
 
 failed:
@@ -658,10 +696,9 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
-	struct repository *r = the_repository;
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
+	if (!open_midx_bitmap_1(bitmap_git, midx))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -2875,6 +2912,7 @@ void free_bitmap_index(struct bitmap_index *b)
 		close_midx_revindex(b->midx);
 	}
 	free_pseudo_merge_map(&b->pseudo_merges);
+	free_bitmap_index(b->base);
 	free(b);
 }
 
-- 
2.47.0.301.g77ddd1170f9

