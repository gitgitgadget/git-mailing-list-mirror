Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D26204C3F
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983512; cv=none; b=TRFXrXGgDmrnfsbVMMBWPjxULX0FilI3iTV79S5HZFs2K8De1d+S9hE9zJGrRWk5MMRuw1Np2csvGqbbGoNeUzHhmK7Qmh5MGIe9r6b0NfUUMcXs0fvlKhdoUWunNrpEqyNV6+xbCQB4m8R+cmR2BhCugeYiDidkGR0kltdD89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983512; c=relaxed/simple;
	bh=WcvUsjHqHLWDYm52ixOxJNFAPhG570Fyc1VHoyxp97o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlLG6cxsaN3KBkyF4dYvq7v4VmXE37A5pkvN5xKKylqr6JkzNWXyzgfO+Gfn7S8S2Hw8gQ7J3vGuJbirFSL0Bv+jeVFBxS8u79SGEJrCoQN4puECRTdSDg5ClofVyUxyjDtmc1vY60iu+vaJDehigCqtAXtbpuceWZhfQzXYV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=s2AnIWCb; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="s2AnIWCb"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso36628576d6.0
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983509; x=1742588309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5aN3ETzCXA6ruGv8x4ecQltwFZc7pmljK7qcMx67U8=;
        b=s2AnIWCbXHhmqCkHQXve8o2jbzeVGwZiJ6+Pj9hsX4mM343RRiKsezJ7l3VdEm4Cgq
         K9pU6IG/Scaiho0dc4SIlAKnWW7YrAKLs7tUXKHni8bygiWLuh82R3xf3LvXMhpkFcjf
         6Y+imAQaPtAT+VkQq195RQ7MxHKxk7uO0KzhWiVuHCVGDqcFAavctz1aXdFc8N1JJXtP
         hmHje/XPGxuyM2ykrwq8K7CLHj0t/eSN8681KRyPfhQCkjshLw0aS626U4vew6mlGlDY
         G438EmvCvXrchU3hZQbGoVSXJXEoVdpm7M/I+n1Mt16PqMxqVjlz+5ntD0DeM6uzSy9V
         GeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983509; x=1742588309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5aN3ETzCXA6ruGv8x4ecQltwFZc7pmljK7qcMx67U8=;
        b=SF2iOWJNN8gXqFSkGgf7rnel3tHGa1XnSCSknHpcyHs5u0Rf6+Z10sZ8QTwmjatBnZ
         SIl6qMOi+JDNGLSoPOX/PQIsmIPP9kDk/e5dDJFg4Lhs3a/FzYNIMKt5IgL0eGcTlT1K
         vORBCJt9kenryJZvr1+LjmORTQBvjrem778KB4A4SfZ2xFTy6w7YFx83PTjvs9Ip8LVO
         CD56dtXI1wrdSUJezITKbKLXdKvcnqeUpQDJYL8LxC3loOFHHMUbPf7vfZtwKW5V+cY8
         ZVSrtgbd0+vzRNluOMjscSVmM0qkTQlQ2xCS+yzfeiejqSWJrKuBJI2ZurO2zCEhMHqs
         +tRQ==
X-Gm-Message-State: AOJu0YyYYD0L3bkwdwNN/P26VPZYae/FYc1mU3zdbQYFy3a39Zq2ifN8
	ajpuUrM5wM6Wc9qcxJv4hk8Kh/TNymzLjUE+/7Fo2agNWHBi+NWil/KiW8QkGH21IJF+qU00liu
	7GlQ=
X-Gm-Gg: ASbGnculeNK8/JSn3y/NWSFlF9fK4ckvg0eqsu4A372RSSyN/1pAUfgVXvkLS1Tg8cJ
	6MkWPSamOJZzhwKmbpRF1wpUjfTYsCxiiUPcfB5htO/jzqdp0l2TkYb2hnfulLYU1g6Lw37iU1F
	bTxoG5QljnxRstZwW4/ol7CeXPH4bOpccuqhG4kQtQjJhHSc0u9DOmBcpjlbHFPkb1eKb8Puhcg
	aLqqvUm1/b1a7ZjyLQhxJmW+QbevpdEA+sqq/nc1npfyWotFrHM8ATMiDpJaJO5V857sLVtjTfU
	Q/xNBkYzBGlfjgUfJ6cn2+tBAin+jQx1IwcvkQWucqUyogUIZ/Gemb7Sb6i9RPT8gccMwx3k9+J
	SXk/kH+PsI0W7N8B4
X-Google-Smtp-Source: AGHT+IEudqxgrL65+LT2yPoO360wE+49452o4KnApGRSpJ/lt+Y+s1mocOBTAlBF1iBoQ6kJf42ueg==
X-Received: by 2002:a05:6214:19c5:b0:6e8:9b26:8c5 with SMTP id 6a1803df08f44-6eaeaa047c7mr46221496d6.10.1741983509670;
        Fri, 14 Mar 2025 13:18:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade35c90fsm27634736d6.120.2025.03.14.13.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:29 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 03/13] pack-bitmap.c: open and store incremental bitmap
 layers
Message-ID: <aca0318fb12499ea810d03e66cc3145d682f5098.1741983492.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741983492.git.me@ttaylorr.com>

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
 pack-bitmap.c | 62 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index c26d85b5db..72fb11d014 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -54,6 +54,16 @@ struct bitmap_index {
 	struct packed_git *pack;
 	struct multi_pack_index *midx;
 
+	/*
+	 * If using a multi-pack index chain, 'base' points to the
+	 * bitmap index corresponding to this bitmap's midx->base_midx.
+	 *
+	 * base_nr indicates how many layers precede this one, and is
+	 * zero when base is NULL.
+	 */
+	struct bitmap_index *base;
+	uint32_t base_nr;
+
 	/* mmapped buffer of the whole bitmap index */
 	unsigned char *map;
 	size_t map_size; /* size of the mmaped buffer */
@@ -386,8 +396,15 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
 	struct strbuf buf = STRBUF_INIT;
-	get_midx_filename_ext(midx->repo->hash_algo, &buf, midx->object_dir,
-			      get_midx_checksum(midx), MIDX_EXT_BITMAP);
+	if (midx->has_chain)
+		get_split_midx_filename_ext(midx->repo->hash_algo, &buf,
+					    midx->object_dir,
+					    get_midx_checksum(midx),
+					    MIDX_EXT_BITMAP);
+	else
+		get_midx_filename_ext(midx->repo->hash_algo, &buf,
+				      midx->object_dir, get_midx_checksum(midx),
+				      MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
 }
@@ -454,16 +471,21 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		goto cleanup;
 	}
 
-	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-		if (prepare_midx_pack(bitmap_repo(bitmap_git),
-				      bitmap_git->midx,
-				      i)) {
+	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
+		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
 			warning(_("could not open pack %s"),
 				bitmap_git->midx->pack_names[i]);
 			goto cleanup;
 		}
 	}
 
+	if (midx->base_midx) {
+		bitmap_git->base = prepare_midx_bitmap_git(midx->base_midx);
+		bitmap_git->base_nr = bitmap_git->base->base_nr + 1;
+	} else {
+		bitmap_git->base_nr = 0;
+	}
+
 	return 0;
 
 cleanup:
@@ -515,6 +537,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	bitmap_git->map_size = xsize_t(st.st_size);
 	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	bitmap_git->map_pos = 0;
+	bitmap_git->base_nr = 0;
 	close(fd);
 
 	if (load_bitmap_header(bitmap_git) < 0) {
@@ -534,8 +557,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git)) {
-		uint32_t i;
-		int ret;
+		struct multi_pack_index *m;
 
 		/*
 		 * The multi-pack-index's .rev file is already loaded via
@@ -544,10 +566,15 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
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
@@ -573,6 +600,13 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
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
@@ -657,10 +691,9 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
-	struct repository *r = midx->repo;
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
+	if (!open_midx_bitmap_1(bitmap_git, midx))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -2899,6 +2932,7 @@ void free_bitmap_index(struct bitmap_index *b)
 		close_midx_revindex(b->midx);
 	}
 	free_pseudo_merge_map(&b->pseudo_merges);
+	free_bitmap_index(b->base);
 	free(b);
 }
 
-- 
2.49.0.13.gd0d564685b

