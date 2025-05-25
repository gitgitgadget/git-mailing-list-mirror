Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53C25E823
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748198528; cv=none; b=MLSuRGnuHMbgi5FyXri/XvckdYk9tZaif6UV3suOOPBqDLagdsBh8idiKYOqqNd2zgiWdyYok9q4/VXjLBAvBj2HxJMKWxpsFyqVj1L54oJ1ExwQ08Y4VLFtlPYle2AYIEhHhvNQzy5ArgtoqUppoT2HMgvpUeg89LapYCEgAWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748198528; c=relaxed/simple;
	bh=iKWnl4O0zsfhZ4G8waJ8Z0A8/3c1cohYpfoGt6Z1WPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctyJIjeinNQwTeOay5H/KBnNz8mByu+FYcoMF/f+b+kHf4Ux6zHC7XjqGwC2d5rBNxwAsoiUGlePxJWtot26Ntr/E9EChvTc1x5XqGq2yd+esBCsUR+5sT72Z5z6emsM5XtpjK1uEeMAuaM1vNDqdVODLekZ0bczmMU2IPWthsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GVz4ed4m; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GVz4ed4m"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ecf99dd567so17223996d6.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748198525; x=1748803325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oUX4+pM/WYRDb7IfxorNc4GHAM6TTWTIPea+1XJc0vM=;
        b=GVz4ed4mXIR+LSIl/RUMqUE2QXjK1utipjY65VXPKHOsr+Sx/x8pYyn0B2/ulUTaIW
         34tDri/p+K72ObLm+YMb+zXfRDnyKs6kTrZeOteYyvfBolR4qmQGYPo+aPo6A/hQuFUO
         2aAEYY0h/rLlNxhhr+VS4LnPdfIicpRJiyFhoU/nq0aVKgrKY73S1mFol7lKgC/vMyh8
         RNnaZi7Rp9u84ErlTuY6SXEgr7eELBLXZjyD1OirYT+ONPcXhq/e3rMlG1sOcrtzX6DT
         auqjNB/TkFjiWl54BW0Jb5iVmnZorxoVqzWUGl28ksgo3FZglOw7kmoQPDO4+XtKcmin
         2jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748198525; x=1748803325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUX4+pM/WYRDb7IfxorNc4GHAM6TTWTIPea+1XJc0vM=;
        b=YDWbsg4DUTdRzUFWOJgo+mkVYgVH9j9EjJlGqOwjYETHo+n852ZtuPqGYlRDpJFvJp
         s0KPTVwLzd01z7lIdFo7iS/ILl+ifSetIZqv2UNsHwI8RbYpt7FLMJ+9Vn37KCA1V8T1
         50HHLncHo7fBAyth6GPSHbH5NpY/tGvrAJaJ7SeyzH49DhynDpChoJ9KfIq8v35fY5yT
         ognn2SHMgkFjbrraQ8fHtvGP/zT1PquyKzOsNG+Dj6LNrDyIP75u2p79e57HP9fFBJ/I
         tl5zKfcTUWZO3f/5n8oStvK2TzFNEPNWgMD8W97buB9iQSO0+Z02ark4176DoiaN5fpi
         gaIw==
X-Gm-Message-State: AOJu0YzC0bcsWTKiy7ij4fNUtgZYNDY66bw9rGH8Oq1Q5gE+OQeOPu1Q
	3v8/nkph7Q6rETLgyr7Amlw/UOCSLsN5zvZJREUl4nfjy1ZISlxK7FM5aVdc798mnypjfb8PLIZ
	qTji/
X-Gm-Gg: ASbGnctakigCh7x3ndaj48ZDIIamUiChAIJKdCFlN1AH5EKLck5n9x9AY69Vz4uFTGp
	rvlJglLSxPin0ierZINUrfjQR2uwmpBGL52Mz1pOqwGxcDOeeyF17TSIH1KteY+wUeQheeTukrH
	WATQWKWaFHSwSrQ0ax4e7gJYUV0FqLzK0ZpdmB3SeE59q4LqEvkhcwx2155LHJ4zVqd5jjcSv6B
	C7xbzHjVwkbhEbXvUsgvW9O4m7x5dmzdinVk23IiycPCSxhtHJ7laI1pMVI4uQlgnMjHBL1EL6F
	BTeKwvZviSInclx10v01WpyraBNb9Dlx5vKbekwKjRbNaOWXXGBqaV5gG7iL1z8Y/4hNi+EaGEi
	LxrV2KACYBfJE00WzgaeBVPg=
X-Google-Smtp-Source: AGHT+IHSf7TZ3wVZuDi173eBbVyWoH5QIfwR6I5Z3Z5/w/mxbUso5ayhBYFLn+XoS2wXIrSDmszSAw==
X-Received: by 2002:a0c:c549:0:b0:6fa:a0ac:8d63 with SMTP id 6a1803df08f44-6faa0ac8ff2mr66044976d6.39.1748198524829;
        Sun, 25 May 2025 11:42:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fa9a3dbd03sm31497256d6.47.2025.05.25.11.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 11:42:04 -0700 (PDT)
Date: Sun, 25 May 2025 14:42:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] midx: return a `packed_git` pointer from
 `prepare_midx_pack()`
Message-ID: <80699bb3ee35f8c4728e7efe8dc53d17134a5fe5.1748198489.git.me@ttaylorr.com>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748198489.git.me@ttaylorr.com>

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
 midx-write.c  | 37 +++++++++++------------
 midx.c        | 81 +++++++++++++++++++++++++--------------------------
 midx.h        |  4 ++-
 pack-bitmap.c |  2 +-
 4 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 2afb67d728..e8dc771665 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -943,6 +943,8 @@ static int fill_packs_from_midx_1(struct write_midx_context *ctx,
 				  uint32_t flags)
 {
 	for (uint32_t i = 0; i < m->num_packs; i++) {
+		struct packed_git *p = NULL;
+
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
 		/*
@@ -951,18 +953,19 @@ static int fill_packs_from_midx_1(struct write_midx_context *ctx,
 		 * mtimes and object count.
 		 */
 		if (flags & MIDX_WRITE_REV_INDEX) {
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
+		fill_pack_info(&ctx->info[ctx->nr++], p,
 			       m->pack_names[i],
 			       m->num_packs_in_base + i);
 	}
@@ -1596,20 +1599,19 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
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
@@ -1657,9 +1659,9 @@ static int want_included_pack(struct repository *r,
 
 	ASSERT(m && !m->base_midx);
 
-	if (prepare_midx_pack(r, m, pack_int_id))
+	p = prepare_midx_pack(r, m, pack_int_id);
+	if (!p)
 		return 0;
-	p = m->packs[pack_int_id];
 	if (!pack_kept_objects && p->pack_keep)
 		return 0;
 	if (p->is_cruft)
@@ -1705,12 +1707,11 @@ static void fill_included_packs_batch(struct repository *r,
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
index fbce88bd46..f7f509cf46 100644
--- a/midx.c
+++ b/midx.c
@@ -449,50 +449,48 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
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
 
-	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
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
-		m->packs[pack_int_id] = (void *)(intptr_t)-1;
-		return 1;
+		m->packs[pack_pos] = p ? p : (void *)(intptr_t)-1;
+		if (p)
+			p->multi_pack_index = 1;
 	}
 
-	p->multi_pack_index = 1;
-	m->packs[pack_int_id] = p;
-
-	return 0;
+	if (m->packs[pack_pos] == (void *)(intptr_t)-1)
+		return NULL;
+	return m->packs[pack_pos];
 }
 
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
@@ -514,10 +512,11 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
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
@@ -614,9 +613,9 @@ int fill_midx_entry(struct repository *r,
 	midx_for_object(&m, pos);
 	pack_int_id = nth_midxed_pack_int_id(m, pos);
 
-	if (prepare_midx_pack(r, m, pack_int_id))
+	p = prepare_midx_pack(r, m, pack_int_id);
+	if (!p)
 		return 0;
-	p = m->packs[pack_int_id - m->num_packs_in_base];
 
 	/*
 	* We are about to tell the caller where they can locate the
@@ -917,7 +916,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 						  _("Looking for referenced packfiles"),
 						  m->num_packs + m->num_packs_in_base);
 	for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
-		if (prepare_midx_pack(r, m, i))
+		if (!prepare_midx_pack(r, m, i))
 			midx_report("failed to load pack in position %d", i);
 
 		display_progress(progress, i + 1);
diff --git a/midx.h b/midx.h
index 9d1374cbd5..612999fe6a 100644
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
 int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 99c4927e9c..648b9c0212 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -488,7 +488,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	}
 
 	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
-		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
+		if (!prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
 			warning(_("could not open pack %s"),
 				bitmap_git->midx->pack_names[i - bitmap_git->midx->num_packs_in_base]);
 			goto cleanup;
-- 
2.49.0.641.gb9c9c4c3bd
