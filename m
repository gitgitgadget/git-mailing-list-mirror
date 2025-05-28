Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372C2222A8
	for <git@vger.kernel.org>; Wed, 28 May 2025 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473153; cv=none; b=RcEzzWh2SGNspen35muuKbnV5Cq3hpOBEkEvJA+I/bzCw0LovqKIAM0zlTDFKwIBd9N7va0bTjTplX+2l7kk8XkgfXcvwa8kwDXB4plmIAvZ3faDS8lD/RvHp1XspgQsTQsvLp3afSNNaF0tbhpPohoBJRn550c8Q45ea9Z/fNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473153; c=relaxed/simple;
	bh=o95eCdOQd/7lU8FxNlGa6c0Z++v9OI1AcG9w9UyrwBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WecDVekgqvsB31Qhjq5uJdiWLSUG8lB9/V9Onw5Q2GCEnbFGRHZtNYb7TJ2Gqh/ok93iBNLwDy0lucwHiX8lrXIcBv9r6MtoTib/28yY9qvDd3K+nSQTWf1lV8ybTaLEwRs/EXm0wjhdSToJeZxXMk5izrLetltanrCzfwxGvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DeQQyp7/; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DeQQyp7/"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e767ce72eso4332897b3.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748473150; x=1749077950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3XysZ9i3zhuX4QgkjVGsIzm/j0mgZ2BjKKZseCHvgM=;
        b=DeQQyp7/5087q0EEb0ZNzJJ+OqYYNg5dS91kR+nvuXJOzpsdnXXeghBrAR9C5ySkLG
         e5c9uoWUGLNwoLnZwUVcOQkjvPJWeQJKLYYA92n5uLfCwFAxPZbguKOw1MDzzw3X/3c6
         Hz/e02fJF45QYv4fktGiye1A9Doxeb9r4Mj+TupqMxxT0UaV7FfwJ1IN7ifxHShlJm5H
         5hBIOXkPJB5Avp1EW3KU30GlfiycpOf8t2ckJDwnkjO60MzTq1u7t/rAjXkltbLC2uGH
         mjsmNIXdDP8CAYARwf+z9YFxPqXnxLcA/UOSw9+JM2BO9N6ROyiJZ1H3bkaF+6d+5HUD
         XCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748473150; x=1749077950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3XysZ9i3zhuX4QgkjVGsIzm/j0mgZ2BjKKZseCHvgM=;
        b=MsPxBO0GZBoEP9vTqG7dEV+JKmF3KUbWFaZX4TQSbf9LFfvOc6+OoMlv8Oi/fx0XzG
         dCduIdmmByxKzU3sClf016Y7IUfDqGQ46ICRGo/mNuMyc9dix8c9BWSkRx+vVDqwIbtN
         oIOMmDy+dqsDcVSAXJVUQwNr4cTouQtstY52ZGJOEX00aTWqvBAlnk10Qwp4zIMw8T8t
         W/ByPSf9Xq+T24or6K3EnoQtXbPq9IJqOFRImCjKsOLcTM25zVQM8JOoSNkNe35CUwDf
         ZbEPMlVL1vc4CVoHPwHr9NzlKNiTb+0zXDWFcYgJ2maNcFb0hLwjJGLrzV/2Q6r9jW1B
         grzQ==
X-Gm-Message-State: AOJu0YyEF2sjoEdlW8BTxuP4kA2IfJNlh8BDCHYVooiqqk30KcXWDnNF
	zc6t7A1/G0vmiqvKjPS9AHnbQi5Rb94orxtSYgQpBsbPHH3XmnY7IZ4VqpK2P4Y7dKZNgqMEsuP
	YsEO7
X-Gm-Gg: ASbGncs4Ysq2QhksDAFsgCmzL9dqf3FwNVRC2ZpknmL++BEnFqZlHr3cCojjvn2K0uR
	J3VAzRruHMLBShodjhuXhZRBgt//VfE8Jm2RczjDOv5zTKX4WtcW8RJntqsu74yOLOkOpiXN7SV
	HqRzAuHy6YiYsD1Zgz24E+17t1Jo92CznwSWYr2EARnxSlJSPeAErW2vLjW+Sy63blxKR1rbIKr
	AVjW3fzmA+HsdIvegrPp3K9c2G9k/tYTB5H4FtAnzidkX26DH6MAvAzlzZqZStXMjAAt4sMYqUV
	LGcLi801M0Cj2ErXKzjP0F792MA1KAeLTlmccpvg84ddWDGd/R9Pd3FcuoRtDYnbXHDD1dnyaO9
	NA3tpbb/rrQl3Yz7UbU1p+v4=
X-Google-Smtp-Source: AGHT+IE8QHPoEX0Up3unL8XCz7weh2676hcjtourvY9P88ew7Sf2UDKy4rSFBHg6/8/BH1Qz9N7G2A==
X-Received: by 2002:a05:690c:7106:b0:70e:2c7f:2ed4 with SMTP id 00721157ae682-70e2d78ebe8mr240959937b3.0.1748473150422;
        Wed, 28 May 2025 15:59:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8abecb85sm321137b3.37.2025.05.28.15.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:59:10 -0700 (PDT)
Date: Wed, 28 May 2025 18:59:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] midx: return a `packed_git` pointer from
 `prepare_midx_pack()`
Message-ID: <e3e21db673f3ae6e574333d4678a0450fa44fb9c.1748473122.git.me@ttaylorr.com>
References: <cover.1748198489.git.me@ttaylorr.com>
 <cover.1748473122.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473122.git.me@ttaylorr.com>

The prepare_midx_pack() function is designed to convert a MIDX-specific
pack_int_id for a given pack into a pointer into an actual `packed_git`
structure.

In general, these calls look something like:

    struct packed_git *p;
    if (prepare_midx_pack(the_repository, some_midx, some_pack_int_id))
        die("could not load pack xyz");
    p = some_midx->packs[some_pack_int_id];

, and in a pre-incremental MIDX world, this pattern works well. However,
in a post-incremental MIDX world, this pattern is a little more prone to
errors.

These errors can happen when the given 'pack_int_id' is not usable as an
index into the 'm->packs' array. And this happens in all layers but the
bottom-most one in an incremental MIDX chain. Each layer stores only the
packs that are local to that layer of the chain, and offsets them by the
total number of packs in the base MIDX(s).

But there is other awkwardness here. Thinking back to the above snippet,
suppose that the pack with ID 'some_pack_int_id' is in a layer in the
middle of the MIDX chain. Then it is still invalid to do:

    p = some_midx->packs[some_pack_int_id - some_midx->num_packs_in_base];

, becuase the top-most layer (here 'some_midx') may not even have that
pack! So we would have to chase down the '->base_midx' pointer in order
to get the correct result. midx.c has a helper to do this (called
'midx_for_pack()'), but it is meant only for internal use.

That means that a full, working version of the above adjusted to handle
incremental MIDXs would look something like:

    struct packed_git *p;
    if (prepare_midx_pack(the_repository, some_midx, some_pack_int_id))
        die("could not load pack xyz");

    while (m && pack_int_id < m->num_packs_in_base)
        m = m->base_midx;

    if (!m)
        BUG("broken midx?");
    if (pack_int_id >= m->num_packs + m->num_packs_in_base)
        BUG("broken pack_int_id?");

    p = m->packs[pack_int_id - m->num_packs_in_base];

, which is far too verbose to access a single pack by its pack_int_id in
a MIDX chain.

Let's instead have prepare_midx_pack() return a pointer to the
packed_git structure itself, hiding the above as an implementation
detail of prepare_midx_pack(). This patch turns the above snippet into:

    struct packed_git *p = prepare_midx_pack(the_repository, some_midx,
                                             some_pack_int_id);
    if (!p)
        die("could not load pack xyz");

making it far easier and less error-prone to access packs by their
pack_int_id in a MIDX chain.

(In the future, we may want to consider similar treatment for, e.g., the
pack_names array. Likewise, it might make sense to rename the "packs"
member of the MIDX structure to suggest that it shouldn't be accessed
directly outside of midx.c.)

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c  | 44 +++++++++++++---------------
 midx.c        | 81 +++++++++++++++++++++++++--------------------------
 midx.h        |  4 ++-
 pack-bitmap.c |  2 +-
 4 files changed, 64 insertions(+), 67 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index ca2384e291..fc74be813d 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -943,25 +943,23 @@ static int fill_packs_from_midx_1(struct write_midx_context *ctx,
 				  int prepare_packs)
 {
 	for (uint32_t i = 0; i < m->num_packs; i++) {
-		/*
-		 * If generating a reverse index, need to have
-		 * packed_git's loaded to compare their
-		 * mtimes and object count.
-		 */
+		struct packed_git *p = NULL;
+
+		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 		if (prepare_packs) {
-			if (prepare_midx_pack(ctx->repo, m,
-					      m->num_packs_in_base + i)) {
+			p = prepare_midx_pack(ctx->repo, m,
+					      m->num_packs_in_base + i);
+			if (!p) {
 				error(_("could not load pack"));
 				return 1;
 			}
 
-			if (open_pack_index(m->packs[i]))
+			if (open_pack_index(p))
 				die(_("could not open index for %s"),
-				    m->packs[i]->pack_name);
+				    p->pack_name);
 		}
 
-		fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
-			       m->pack_names[i],
+		fill_pack_info(&ctx->info[ctx->nr++], p, m->pack_names[i],
 			       m->num_packs_in_base + i);
 	}
 
@@ -1588,20 +1586,19 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 					  _("Finding and deleting unreferenced packfiles"),
 					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
+		struct packed_git *p;
 		char *pack_name;
 		display_progress(progress, i + 1);
 
 		if (count[i])
 			continue;
 
-		if (prepare_midx_pack(r, m, i))
+		p = prepare_midx_pack(r, m, i);
+		if (!p || p->pack_keep || p->is_cruft)
 			continue;
 
-		if (m->packs[i]->pack_keep || m->packs[i]->is_cruft)
-			continue;
-
-		pack_name = xstrdup(m->packs[i]->pack_name);
-		close_pack(m->packs[i]);
+		pack_name = xstrdup(p->pack_name);
+		close_pack(p);
 
 		string_list_insert(&packs_to_drop, m->pack_names[i]);
 		unlink_pack_path(pack_name, 0);
@@ -1649,9 +1646,9 @@ static int want_included_pack(struct repository *r,
 
 	ASSERT(m && !m->base_midx);
 
-	if (prepare_midx_pack(r, m, pack_int_id))
+	p = prepare_midx_pack(r, m, pack_int_id);
+	if (!p)
 		return 0;
-	p = m->packs[pack_int_id];
 	if (!pack_kept_objects && p->pack_keep)
 		return 0;
 	if (p->is_cruft)
@@ -1697,12 +1694,11 @@ static void fill_included_packs_batch(struct repository *r,
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
 
 	for (i = 0; i < m->num_packs; i++) {
+		struct packed_git *p = prepare_midx_pack(r, m, i);
+
 		pack_info[i].pack_int_id = i;
-
-		if (prepare_midx_pack(r, m, i))
-			continue;
-
-		pack_info[i].mtime = m->packs[i]->mtime;
+		if (p)
+			pack_info[i].mtime = p->mtime;
 	}
 
 	for (i = 0; i < m->num_objects; i++) {
diff --git a/midx.c b/midx.c
index 6705e77881..a2e7a3ec0e 100644
--- a/midx.c
+++ b/midx.c
@@ -451,50 +451,48 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
 	return pack_int_id - m->num_packs_in_base;
 }
 
-int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
-		      uint32_t pack_int_id)
+struct packed_git *prepare_midx_pack(struct repository *r,
+				     struct multi_pack_index *m,
+				     uint32_t pack_int_id)
 {
-	struct strbuf pack_name = STRBUF_INIT;
-	struct strbuf key = STRBUF_INIT;
-	struct packed_git *p;
+	uint32_t pack_pos = midx_for_pack(&m, pack_int_id);
 
-	pack_int_id = midx_for_pack(&m, pack_int_id);
+	if (!m->packs[pack_pos]) {
+		struct strbuf pack_name = STRBUF_INIT;
+		struct strbuf key = STRBUF_INIT;
+		struct packed_git *p;
 
-	if (m->packs[pack_int_id] == MIDX_PACK_ERROR)
-		return 1;
-	if (m->packs[pack_int_id])
-		return 0;
+		strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
+			    m->pack_names[pack_pos]);
 
-	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
-		    m->pack_names[pack_int_id]);
-
-	/* pack_map holds the ".pack" name, but we have the .idx */
-	strbuf_addbuf(&key, &pack_name);
-	strbuf_strip_suffix(&key, ".idx");
-	strbuf_addstr(&key, ".pack");
-	p = hashmap_get_entry_from_hash(&r->objects->pack_map,
-					strhash(key.buf), key.buf,
-					struct packed_git, packmap_ent);
-	if (!p) {
-		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
-		if (p) {
-			install_packed_git(r, p);
-			list_add_tail(&p->mru, &r->objects->packed_git_mru);
+		/* pack_map holds the ".pack" name, but we have the .idx */
+		strbuf_addbuf(&key, &pack_name);
+		strbuf_strip_suffix(&key, ".idx");
+		strbuf_addstr(&key, ".pack");
+		p = hashmap_get_entry_from_hash(&r->objects->pack_map,
+						strhash(key.buf), key.buf,
+						struct packed_git, packmap_ent);
+		if (!p) {
+			p = add_packed_git(r, pack_name.buf, pack_name.len,
+					   m->local);
+			if (p) {
+				install_packed_git(r, p);
+				list_add_tail(&p->mru,
+					      &r->objects->packed_git_mru);
+			}
 		}
-	}
 
-	strbuf_release(&pack_name);
-	strbuf_release(&key);
+		strbuf_release(&pack_name);
+		strbuf_release(&key);
 
-	if (!p) {
-		m->packs[pack_int_id] = MIDX_PACK_ERROR;
-		return 1;
+		m->packs[pack_pos] = p ? p : MIDX_PACK_ERROR;
+		if (p)
+			p->multi_pack_index = 1;
 	}
 
-	p->multi_pack_index = 1;
-	m->packs[pack_int_id] = p;
-
-	return 0;
+	if (m->packs[pack_pos] == MIDX_PACK_ERROR)
+		return NULL;
+	return m->packs[pack_pos];
 }
 
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
@@ -523,10 +521,11 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 	if (!m->chunk_bitmapped_packs)
 		return error(_("MIDX does not contain the BTMP chunk"));
 
-	if (prepare_midx_pack(r, m, pack_int_id))
-		return error(_("could not load bitmapped pack %"PRIu32), pack_int_id);
+	bp->p = prepare_midx_pack(r, m, pack_int_id);
+	if (!bp->p)
+		return error(_("could not load bitmapped pack %"PRIu32),
+			     pack_int_id);
 
-	bp->p = m->packs[local_pack_int_id];
 	bp->bitmap_pos = get_be32((char *)m->chunk_bitmapped_packs +
 				  MIDX_CHUNK_BITMAPPED_PACKS_WIDTH * local_pack_int_id);
 	bp->bitmap_nr = get_be32((char *)m->chunk_bitmapped_packs +
@@ -623,9 +622,9 @@ int fill_midx_entry(struct repository *r,
 	midx_for_object(&m, pos);
 	pack_int_id = nth_midxed_pack_int_id(m, pos);
 
-	if (prepare_midx_pack(r, m, pack_int_id))
+	p = prepare_midx_pack(r, m, pack_int_id);
+	if (!p)
 		return 0;
-	p = m->packs[pack_int_id - m->num_packs_in_base];
 
 	/*
 	* We are about to tell the caller where they can locate the
@@ -926,7 +925,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 						  _("Looking for referenced packfiles"),
 						  m->num_packs + m->num_packs_in_base);
 	for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
-		if (prepare_midx_pack(r, m, i))
+		if (!prepare_midx_pack(r, m, i))
 			midx_report("failed to load pack in position %d", i);
 
 		display_progress(progress, i + 1);
diff --git a/midx.h b/midx.h
index 0fb490f4d4..4ac05b8234 100644
--- a/midx.h
+++ b/midx.h
@@ -104,7 +104,9 @@ void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
 struct multi_pack_index *load_multi_pack_index(struct repository *r,
 					       const char *object_dir,
 					       int local);
-int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
+struct packed_git *prepare_midx_pack(struct repository *r,
+				     struct multi_pack_index *m,
+				     uint32_t pack_int_id);
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 				   uint32_t pack_int_id);
 const char *nth_midxed_pack_name(struct multi_pack_index *m,
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8ddc150778..1f72e605d4 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -488,7 +488,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	}
 
 	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
-		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
+		if (!prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
 			warning(_("could not open pack %s"),
 				nth_midxed_pack_name(bitmap_git->midx, i));
 			goto cleanup;
-- 
2.49.0.640.ga4de40e6a8
