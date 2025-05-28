Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A301F9A8B
	for <git@vger.kernel.org>; Wed, 28 May 2025 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473142; cv=none; b=o9tZZ0opgFYi73Zweb4ZLkGS6bFE4tz1LCpLKB3F+THwHZzhO6CPFERh/yn+hUbuu7cEST8LpbqV01KTHh9gXMOt3x2g5/+c8m/q9Q+0KfzOzF5kg5QPD4z/fmiQRDnAD5meXmC0wvBnwODOd6OXGrW6ZlK7poz9UumJyFwKi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473142; c=relaxed/simple;
	bh=c7R83h5izX+kHjAA7GCVf4zC5v9eHbPHE0Ypgo1KhqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTyt4CKrqxgQyYUhjzQacZXNjwrAicv/DshqK5Hwm61fZpczyNmaxMBUNWyGdfsWibde2bLwqswMZ5yo3ihZGR+/+Uqv9LhJx/0R26bkIfujJAXqsqzeYNB/IgE+vNqxzyV0lXUkKYaOHiEbQTYsZlgpn+FLxRDEhvFm5mNtCJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CVkZl/jm; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CVkZl/jm"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70e2b601a6bso4299467b3.0
        for <git@vger.kernel.org>; Wed, 28 May 2025 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748473139; x=1749077939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzHjXVcx9LpdtYx7b3TOg545ITEGd6Sw6fKTi/Mt2bY=;
        b=CVkZl/jm73WvgxatqtEyLQBdEph84oBCX0cXHhajyDUD85mixCFU7Z4zTDAFcYAoEJ
         4j6G/H3wK4+XHuSWX5A7homc3+I4/SwaDUqeg6t0hsmMTzKQjT/xcnP8Q1L8FR67cRpA
         Xn+p6+tb+gPSfRVClh+owI50huerKrwplhB8uL1QMr8LfU8D342P/73YPbWMhAykJH08
         3xK2np7Tva0vX7tvxVuibo9It26Oh/QJOOrbDOsTeaEP4JfeXEiOWlVz2hcO13nPS4rc
         QcJt6NABWEeCN1QKtgMbsPgJxGKXXOQ6rVFhDH04pjb3Ibi3wR6Askry0vsImogO3bQy
         miHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748473139; x=1749077939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzHjXVcx9LpdtYx7b3TOg545ITEGd6Sw6fKTi/Mt2bY=;
        b=m0g5uGl5cH/iG6/hLbHQmK/xbrcZhkZa7JeNDLcoObsE8332JAulpfAY+vG+6VfBJf
         V65GYD6b0yFCgrParc8fxf2udK1zUaqmtmQ5Ai1CzaqZmJ13zcB3U9nKyka3OplF1TrE
         yq6RyAm8rILs80MUPn/sSHI7zv5jJLWA0rOUFurCVyztrxeQ9wkeToUWgIn+f1b9erDr
         /hGo347ImYQq+GChh2q1e3YswMNkoKtQD33jdwhpjeemy0/6KN2vIW4FCnBt/rBpprIP
         purA+j+M5ZatgAc0Vy+tMFCl+FWPpbNCE8bXDx6Y25JuJEk9ATQ0r2XemA0xrIOnUeRV
         b1og==
X-Gm-Message-State: AOJu0YzXDZzcOmZVE6fCZPzK7q2aIkyeW/bXaltqJcz1mJAXv20YmiO8
	rQxkTx2PoN5BA+uxtSVzEGEEVCGypeL3D9TSw2C0F/6AwkQ+UzYTw4tEJwAbJsrNlIAs24gPd9Z
	fu1Bg
X-Gm-Gg: ASbGncvr6AOzoE6bZeNedyrdNEIN1EW4kO8BZUmJuhQiexauvyIm+j21YSsi/NKmOF+
	T/r56xP4Y+WBUBUBu1j2fIx7BPfj+fC1YP4bWyr/Th5ob8zkybKfYhNRwJjWLwQcN0/vyTy9syM
	MHBEkwgSssxWjCEwlw611yGR+7/lGrXu9WYU8g5GSSG22uQg1SXund7K4xtXtGW8LIkzN6ZYpMx
	rWktjvDJ2yEC3IcA1nBcYzSeMOIxAPvaf4CY5u4ErN8udmXJQsi4qv3jg8IzukBdPhtqXyTPM7p
	bASoPGkQ+Pm4DnZBFpmiydhFx6kag+QAXwhmgN6diEy6WN4e6m4Gf8TRx/hK5l1TcNDtmkMUFgx
	KCiI+OlLU7w5E06N6E+Im5X8=
X-Google-Smtp-Source: AGHT+IEI3OauczCRR8KT67M7PyKUKSmRjS2/0g5edHeJU6zl70j3Yx5TnlP4JhQiwLTdxxeHTlLJ9g==
X-Received: by 2002:a05:690c:4901:b0:70f:88e2:c4ae with SMTP id 00721157ae682-70f8b922b83mr820837b3.37.1748473138653;
        Wed, 28 May 2025 15:58:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8acd8bffsm281907b3.77.2025.05.28.15.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:58:58 -0700 (PDT)
Date: Wed, 28 May 2025 18:58:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] midx: improve prepare_midx_pack() ergonomics
Message-ID: <cover.1748473122.git.me@ttaylorr.com>
References: <cover.1748198489.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748198489.git.me@ttaylorr.com>

This series has been updated to be based on v3 of
ps/midx-negative-packfile-cache, which is 1f34bf3e08 (midx: stop
repeatedly looking up nonexistent packfiles, 2025-05-28) at the time of
writing.

There are a couple of minor changes from last time, including:

 - using the new MIDX_PACK_ERROR macro instead of casting '-1' to a void
   pointer

 - converting some direct m->pack_names lookups (outside of midx.c and
   midx-write.c with one exception) to use a similar pattern to access
   the nth pack name

As usual, a range-diff against v1 is below for convenience.

Thanks again for your review!

Taylor Blau (4):
  midx: access pack names through `nth_midxed_pack_name()`
  midx-write.c: guard against incremental MIDXs in want_included_pack()
  midx-write.c: extract inner loop from fill_packs_from_midx()
  midx: return a `packed_git` pointer from `prepare_midx_pack()`

 midx-write.c              | 101 +++++++++++++++++++++-----------------
 midx.c                    |  88 +++++++++++++++++----------------
 midx.h                    |   6 ++-
 pack-bitmap.c             |   6 +--
 t/helper/test-read-midx.c |   7 +--
 5 files changed, 116 insertions(+), 92 deletions(-)

Range-diff against v1:
1:  a7082dc7f0 < -:  ---------- packfile: explain ordering of how we look up auxiliary pack files
2:  73fe0882ee < -:  ---------- midx: stop repeatedly looking up nonexistent packfiles
3:  ad7295b11b < -:  ---------- pack-bitmap.c: fix broken warning() when missing MIDX'd pack
5:  5d97b706e1 ! 1:  d3508d3cfb midx-write.c: simplify fill_packs_from_midx()
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    midx-write.c: simplify fill_packs_from_midx()
    +    midx: access pack names through `nth_midxed_pack_name()`
     
    -    When enumerating packs within fill_packs_from_midx(), we open the pack's
    -    index iff we are either writing a reverse index, have a preferred pack
    -    (by name) or both.
    +    Accessing a MIDX's 'pack_names' array is somewhat error-prone when
    +    dealing with incremental MIDX chains, where the (global) pack_int_id for
    +    some pack may differ from the containing layer's index for that pack.
     
    -    Let's simplify this into a single case by setting the
    -    MIDX_WRITE_REV_INDEX flag bit when we have a preferred_pack_name. This
    -    is a little bit of a shortcut to reduce the line length in the loop
    -    below. But it sets us up nicely to extract the inner loop of this
    -    function out into its own function, where we will no longer have to pass
    -    the preferred_pack_name.
    +    Introduce `nth_midxed_pack_name()` in an effort to reduce a common
    +    source of errors by discouraging external callers from accessing a
    +    layer's `pack_names` array directly.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## midx-write.c ##
    -@@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx,
    - {
    - 	struct multi_pack_index *m;
    + ## midx.c ##
    +@@ midx.c: struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
    + 	return m->packs[local_pack_int_id];
    + }
      
    -+	if (preferred_pack_name) {
    -+		/*
    -+		 * If a preferred pack is specified, need to have
    -+		 * packed_git's loaded to ensure the chosen preferred
    -+		 * pack has a non-zero object count.
    -+		 *
    -+		 * Trick ourselves into thinking that we're writing a
    -+		 * reverse index in this case in order to open up the
    -+		 * pack index file.
    -+		 */
    -+		flags |= MIDX_WRITE_REV_INDEX;
    -+	}
    ++const char *nth_midxed_pack_name(struct multi_pack_index *m,
    ++				 uint32_t pack_int_id)
    ++{
    ++	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
    ++	return m->pack_names[local_pack_int_id];
    ++}
     +
    - 	for (m = ctx->m; m; m = m->base_midx) {
    - 		uint32_t i;
    + #define MIDX_CHUNK_BITMAPPED_PACKS_WIDTH (2 * sizeof(uint32_t))
      
    -@@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx,
    - 			 * If generating a reverse index, need to have
    - 			 * packed_git's loaded to compare their
    - 			 * mtimes and object count.
    --			 *
    --			 * If a preferred pack is specified, need to
    --			 * have packed_git's loaded to ensure the chosen
    --			 * preferred pack has a non-zero object count.
    - 			 */
    --			if (flags & MIDX_WRITE_REV_INDEX ||
    --			    preferred_pack_name) {
    -+			if (flags & MIDX_WRITE_REV_INDEX) {
    - 				if (prepare_midx_pack(ctx->repo, m,
    - 						      m->num_packs_in_base + i)) {
    - 					error(_("could not load pack"));
    + int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
    +
    + ## midx.h ##
    +@@ midx.h: struct multi_pack_index *load_multi_pack_index(struct repository *r,
    + int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
    + struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
    + 				   uint32_t pack_int_id);
    ++const char *nth_midxed_pack_name(struct multi_pack_index *m,
    ++				 uint32_t pack_int_id);
    + int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
    + 		       struct bitmapped_pack *bp, uint32_t pack_int_id);
    + int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
    +
    + ## pack-bitmap.c ##
    +@@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    + 	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
    + 		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
    + 			warning(_("could not open pack %s"),
    +-				bitmap_git->midx->pack_names[i]);
    ++				nth_midxed_pack_name(bitmap_git->midx, i));
    + 			goto cleanup;
    + 		}
    + 	}
    +@@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
    + 			struct bitmapped_pack pack;
    + 			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
    + 				warning(_("unable to load pack: '%s', disabling pack-reuse"),
    +-					bitmap_git->midx->pack_names[i]);
    ++					nth_midxed_pack_name(bitmap_git->midx, i));
    + 				free(packs);
    + 				return;
    + 			}
    +
    + ## t/helper/test-read-midx.c ##
    +@@ t/helper/test-read-midx.c: static int read_midx_file(const char *object_dir, const char *checksum,
    + 	printf("\nnum_objects: %d\n", m->num_objects);
    + 
    + 	printf("packs:\n");
    +-	for (i = 0; i < m->num_packs; i++)
    +-		printf("%s\n", m->pack_names[i]);
    ++	for (i = m->num_packs_in_base; i < m->num_packs + m->num_packs_in_base;
    ++	     i++)
    ++		printf("%s\n", nth_midxed_pack_name(m, i));
    + 
    + 	printf("object-dir: %s\n", m->object_dir);
    + 
    +@@ t/helper/test-read-midx.c: static int read_midx_preferred_pack(const char *object_dir)
    + 		return 1;
    + 	}
    + 
    +-	printf("%s\n", midx->pack_names[preferred_pack]);
    ++	printf("%s\n", nth_midxed_pack_name(midx, preferred_pack));
    + 	close_midx(midx);
    + 	return 0;
    + }
4:  d2f9645aa1 ! 2:  cf3ab81a08 midx-write.c: guard against incremental MIDXs in want_included_pack()
    @@ Commit message
             if (m->base_midx)
                 die(_("cannot repack an incremental multi-pack-index"));
     
    -    So want_included_pack() is OK becuase it will never encounter a
    +    So want_included_pack() is OK because it will never encounter a
         situation where it has to chase backwards through the '->base_midx'
         pointer. But that is not immediately clear from reading the code, and is
         too fragile for my comfort. Make this more clear by adding an ASSERT()
6:  a4080c12df ! 3:  e54988bfea midx-write.c: extract inner loop from fill_packs_from_midx()
    @@ midx-write.c: static struct multi_pack_index *lookup_multi_pack_index(struct rep
      
     +static int fill_packs_from_midx_1(struct write_midx_context *ctx,
     +				  struct multi_pack_index *m,
    -+				  uint32_t flags)
    ++				  int prepare_packs)
     +{
     +	for (uint32_t i = 0; i < m->num_packs; i++) {
    -+		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
    -+
     +		/*
     +		 * If generating a reverse index, need to have
     +		 * packed_git's loaded to compare their
     +		 * mtimes and object count.
     +		 */
    -+		if (flags & MIDX_WRITE_REV_INDEX) {
    ++		if (prepare_packs) {
     +			if (prepare_midx_pack(ctx->repo, m,
     +					      m->num_packs_in_base + i)) {
     +				error(_("could not load pack"));
    @@ midx-write.c: static struct multi_pack_index *lookup_multi_pack_index(struct rep
      static int fill_packs_from_midx(struct write_midx_context *ctx,
      				const char *preferred_pack_name, uint32_t flags)
      {
    -@@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx,
    - 	}
    + 	struct multi_pack_index *m;
    ++	int prepare_packs;
    ++
    ++	/*
    ++	 * If generating a reverse index, need to have packed_git's
    ++	 * loaded to compare their mtimes and object count.
    ++	 */
    ++	prepare_packs = !!(flags & MIDX_WRITE_REV_INDEX || preferred_pack_name);
      
      	for (m = ctx->m; m; m = m->base_midx) {
     -		uint32_t i;
    @@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx,
     -			 * If generating a reverse index, need to have
     -			 * packed_git's loaded to compare their
     -			 * mtimes and object count.
    +-			 *
    +-			 * If a preferred pack is specified, need to
    +-			 * have packed_git's loaded to ensure the chosen
    +-			 * preferred pack has a non-zero object count.
     -			 */
    --			if (flags & MIDX_WRITE_REV_INDEX) {
    +-			if (flags & MIDX_WRITE_REV_INDEX ||
    +-			    preferred_pack_name) {
     -				if (prepare_midx_pack(ctx->repo, m,
     -						      m->num_packs_in_base + i)) {
     -					error(_("could not load pack"));
    @@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx,
     -				       m->pack_names[i],
     -				       m->num_packs_in_base + i);
     -		}
    -+		int ret = fill_packs_from_midx_1(ctx, m, flags);
    ++		int ret = fill_packs_from_midx_1(ctx, m, prepare_packs);
     +		if (ret)
     +			return ret;
      	}
7:  80699bb3ee ! 4:  e3e21db673 midx: return a `packed_git` pointer from `prepare_midx_pack()`
    @@ Commit message
     
      ## midx-write.c ##
     @@ midx-write.c: static int fill_packs_from_midx_1(struct write_midx_context *ctx,
    - 				  uint32_t flags)
    + 				  int prepare_packs)
      {
      	for (uint32_t i = 0; i < m->num_packs; i++) {
    +-		/*
    +-		 * If generating a reverse index, need to have
    +-		 * packed_git's loaded to compare their
    +-		 * mtimes and object count.
    +-		 */
     +		struct packed_git *p = NULL;
     +
    - 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
    - 
    - 		/*
    -@@ midx-write.c: static int fill_packs_from_midx_1(struct write_midx_context *ctx,
    - 		 * mtimes and object count.
    - 		 */
    - 		if (flags & MIDX_WRITE_REV_INDEX) {
    ++		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
    + 		if (prepare_packs) {
     -			if (prepare_midx_pack(ctx->repo, m,
     -					      m->num_packs_in_base + i)) {
     +			p = prepare_midx_pack(ctx->repo, m,
    @@ midx-write.c: static int fill_packs_from_midx_1(struct write_midx_context *ctx,
      		}
      
     -		fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
    -+		fill_pack_info(&ctx->info[ctx->nr++], p,
    - 			       m->pack_names[i],
    +-			       m->pack_names[i],
    ++		fill_pack_info(&ctx->info[ctx->nr++], p, m->pack_names[i],
      			       m->num_packs_in_base + i);
      	}
    + 
     @@ midx-write.c: int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
      					  _("Finding and deleting unreferenced packfiles"),
      					  m->num_packs);
    @@ midx.c: static uint32_t midx_for_pack(struct multi_pack_index **_m,
     +		struct strbuf key = STRBUF_INIT;
     +		struct packed_git *p;
      
    --	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
    +-	if (m->packs[pack_int_id] == MIDX_PACK_ERROR)
     -		return 1;
     -	if (m->packs[pack_int_id])
     -		return 0;
    @@ midx.c: static uint32_t midx_for_pack(struct multi_pack_index **_m,
     +		strbuf_release(&key);
      
     -	if (!p) {
    --		m->packs[pack_int_id] = (void *)(intptr_t)-1;
    +-		m->packs[pack_int_id] = MIDX_PACK_ERROR;
     -		return 1;
    -+		m->packs[pack_pos] = p ? p : (void *)(intptr_t)-1;
    ++		m->packs[pack_pos] = p ? p : MIDX_PACK_ERROR;
     +		if (p)
     +			p->multi_pack_index = 1;
      	}
    @@ midx.c: static uint32_t midx_for_pack(struct multi_pack_index **_m,
     -	m->packs[pack_int_id] = p;
     -
     -	return 0;
    -+	if (m->packs[pack_pos] == (void *)(intptr_t)-1)
    ++	if (m->packs[pack_pos] == MIDX_PACK_ERROR)
     +		return NULL;
     +	return m->packs[pack_pos];
      }
    @@ midx.h: void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
     +				     uint32_t pack_int_id);
      struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
      				   uint32_t pack_int_id);
    - int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
    + const char *nth_midxed_pack_name(struct multi_pack_index *m,
     
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
     -		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
     +		if (!prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
      			warning(_("could not open pack %s"),
    - 				bitmap_git->midx->pack_names[i - bitmap_git->midx->num_packs_in_base]);
    + 				nth_midxed_pack_name(bitmap_git->midx, i));
      			goto cleanup;

base-commit: 1f34bf3e082741e053d25b76a0ffe31d9d967594
-- 
2.49.0.640.ga4de40e6a8
