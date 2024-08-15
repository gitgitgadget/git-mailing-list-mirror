Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F915573B
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760942; cv=none; b=Q+rCJILxQEJA5DsEzn5Gdkh/LBNBwOnHat+eKgHb6Pu9G94+Lfa9hubl9VzfWkScJ4O/RpDcl0NvTaWT0JfNL5Nn/Esm6QoBn5rgGTl7+Ur1BWC87dChfM8gD6DUOOPvz32kv+lxendSyrLnuRLQyN3KeexyMrh6NH3F4u8nAkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760942; c=relaxed/simple;
	bh=0c1BLveCC0VTuedQ7gjhMnuviv9khlUd8jJuVt6QJGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAPRWhiKkX8tU85zyKYvGBtVY4cstlpO1gPselpbOhMwi/9wn4ZIR3dJSwfnU7QSozLCGW/4VQHIWpJwA8iNnsRYsZrj2SLCA7zRoQrW8G+uajYcHIitvNAf9CfkX9ntjXc58UBwdDmgX8kuUBQnjIzjkuyiauHwGtUXepteqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WfrrBx/Y; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WfrrBx/Y"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e124cdea21bso181038276.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760940; x=1724365740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DYNYWrfBb9brsbTpEoKkvZqrdyZOZli6q8goV7oYNrU=;
        b=WfrrBx/Y27V8m0pEcVB6Hd8dYO27wow9jDXetcqxgs3CUB1/JnfE6sVuBCKctwxrWf
         XFp+k8BcQz1M24K33pnrlh6wy0CIpbQTWXcwQz+GAQXMS5wdywdqOV3SUdXXKI8UcKir
         xMBtnMSH/GNC5yoqhbnCXcIekpxb48heOosAXc+TyqlY1/M11NNoc1XMP+1wC+xDQGag
         ivsG5e1nyUjKhOXlm7vgs1a8NVjdsolJvAudLk5b5BTgmHzoXJomIHkQ68UkZBKM6z+6
         d77CGVGwzxpJam6ap1uTwPY1zCB19gNOzmPMwVNzRAMLf9DCYudEBnj8TQVAElwnZXP/
         32dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760940; x=1724365740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYNYWrfBb9brsbTpEoKkvZqrdyZOZli6q8goV7oYNrU=;
        b=iAkSlpVAv+u/HHpDynO8I6CvHY3YMEj9RtsauNpMsAOX+OuR6CkqaS/jju0dRZrkzQ
         AhEz+nYhesacmvDExvbUgN6AY5+wSiHoemMk+n6f2SOke/1C8dCLmgJSHOnza78jEJIr
         iv97zGIN4lYTDuLrPPFr2khKusRpB+gHdmiQdOs/iZTHuOZEkCdZVTRlWH6ldhw6aU05
         xSpHD7sb757inID7MDPaVBOcE2rE/zc6b0UQRuibJE8tf5Oy9/Yad+nmUGv9CIgPwX7m
         uhlL8+Lkeph81juQAU9ZOafGNkj/A4s3n519XlgucnfskJ2BXbsi9+50/Vh2BYJyNFdC
         0BtA==
X-Gm-Message-State: AOJu0Yw8Xa5MEjqWvh/STKWL7GT0FCmurSeM1yIaOl+UGMtEMebqBNIz
	JgRQs3XJiWdXsCBQXFAD9SJ1NEJzWC7lsDdwQ35I8W94pN1yTAK3TcDfq/ogxRczhTyKwvxAqxp
	z
X-Google-Smtp-Source: AGHT+IHoCCOTLyXYBaTcgVq0FoJJzoPRDpUb4FnWnQVKKeFzPokqRNKz+kkEHQEzF/y44hjSkGydWA==
X-Received: by 2002:a05:690c:3244:b0:64b:8b8f:7770 with SMTP id 00721157ae682-6b1bb95f379mr10432347b3.23.1723760940140;
        Thu, 15 Aug 2024 15:29:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9e0de828sm4086867b3.130.2024.08.15.15.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:28:59 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:28:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/13] pack-bitmap.c: open and store incremental bitmap
 layers
Message-ID: <43444efc21415b8817522cbd7b590e1ce38636d5.1723760847.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723760847.git.me@ttaylorr.com>

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
 pack-bitmap.c | 63 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0a7039d955..c27383c027 100644
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
-- 
2.46.0.86.ge766d390f0.dirty

