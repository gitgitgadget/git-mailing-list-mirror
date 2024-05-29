Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064D1CB31B
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023321; cv=none; b=ud1hrgTUKA5gQ6v7fMfuYq+65oAssq+c+Jkb6rhFbKDwT6pSZJsfn5L7J5JlWMBZlNRLEO4MG4tLlMB3TZKe9jFsUdVSVZ5juFr0WYrXYjBh7wpwVQruhgcJmQp3FECfRYX6lDUV9mrlRDxCpSKYvEpWM8kfuMHLE/thcz4nl+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023321; c=relaxed/simple;
	bh=QQRq9+6kGhCXmSFSac7HwnzvhlNUzqKEbsg/t+6OcUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgFMF9KOlm3ttuLUVDfR7s9dBgMTyeO+VmJVOV6zB834pNs98BcgHuWCk0G+qLJNe0ItxTB1vbpyuW2DDJ84nwPthBKe+yK/x+5nSrPA+AEPFdLlpy/EKwdN1jVYtUtstzNtETcNZhJi6QPj5/zBiCCXramua6H5da6YLkmK2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hPETcojO; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hPETcojO"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9c36db8eeso98861b6e.0
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717023318; x=1717628118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aWrTDzpfH3DlDgj3DjGnv9katUcguzJ/b4UHMQPWvWw=;
        b=hPETcojOPU1TuUwU76TmgsXPeSXk8gC1ZhvJmOfs7bvhov71iKo5gsaCdArjcKp1NG
         k5a/xvyHCTuwUUEzBtq/W4Hk3WpPPrWJDkC61vzRVLQRtL2SLoDZ+eT4+wwfF4p4pomH
         iW4LOLyJPS43z3+gV1efeqYZe8icCkW6mwndM4jx8OJLZoDrjIelH54SoDu0zcO7w1Y8
         dX5CtyfJBhXG9PsPahzmxj9Uxtp5mYlryQRCoYo3YpzL/hfg4Gw/zBf0wHyzjTq2P2cr
         CtoObaL0gnSLvX6O8+Ht2rPZifXTkv0d/+nD7MRWm5H3Y90robYXeU6Hn049ut4t5unJ
         fZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717023318; x=1717628118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWrTDzpfH3DlDgj3DjGnv9katUcguzJ/b4UHMQPWvWw=;
        b=SoFgine12MNdPayqaYYzFSiejSaxe5Q49g9ixrFtPMvOsMR1MzsMSx0V8W7JbGt8Ui
         p7W3aW0/JKTNto3guq8LD0n4470uRMAFkRu8ps7b/ODeiM/gjYJ/737q0n6e9p0IWGsQ
         Rk649yPDpHtczeamhsa8GNgk15eq0LQIiHZzL1y52kwYLR8rGcytHbIFJ7IUmgBSabng
         IQyqkVPNRqEDqXLy1yIve4q1kf4orc2yHrOPxR2ElBu5Z+ghbTxMdP9/Dpo/lwBOwR57
         EBG00187tEaVokpeMFagI9tKZ0g14D0qD3KAggwwmfyC2q7RfTJiT742+aS+4Y/BiV9+
         OcsQ==
X-Gm-Message-State: AOJu0Yy4mPxVkXzNIpreAZDHdtX9oRuNeuCkyuTA+UYatejWhGNUIchr
	cr5zOV+CZxyXfGPwHAsLSwSNx2reeigrd+DiE6zKZSazqWQ8DXo0LhpqGD/OXXXrCVBKViKHmj2
	1sfI=
X-Google-Smtp-Source: AGHT+IEN1o1MsQ2eKFDl0wieEWx/CS2j7DThqC8psqeiSFqbxjzZSO0E8HNozDUwro/crmGLqSiytw==
X-Received: by 2002:a05:6808:159d:b0:3c9:91d8:ae1e with SMTP id 5614622812f47-3d1dcc9bc01mr536436b6e.2.1717023317998;
        Wed, 29 May 2024 15:55:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad766b860bsm41436926d6.30.2024.05.29.15.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:55:16 -0700 (PDT)
Date: Wed, 29 May 2024 18:55:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/8] midx-write: miscellaneous clean-ups for incremental
 MIDXs
Message-ID: <cover.1717023301.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716482279.git.me@ttaylorr.com>

This is a small reroll of my series which has a grab-bag of midx-write
related cleanups that I pulled out of a larger series to implement
incremental MIDX chains.

This series is mostly the same as last time, but notable changes
include:

  - renamed `get_sorted_entries()` to `compute_sorted_entries()` to
    avoid confusion that the function performs a side-effecting write to
    `ctx->entries_nr`.

  - fixed a handful of typos

  - add explanations in a couple of the patches to better motivate the
    change.

Thanks to Patrick Steinhardt for his careful review on the previous
round!

Taylor Blau (8):
  midx-write.c: tolerate `--preferred-pack` without bitmaps
  midx-write.c: reduce argument count for `get_sorted_entries()`
  midx-write.c: pass `start_pack` to `compute_sorted_entries()`
  midx-write.c: extract `should_include_pack()`
  midx-write.c: extract `fill_packs_from_midx()`
  midx-write.c: support reading an existing MIDX with `packs_to_include`
  midx: replace `get_midx_rev_filename()` with a generic helper
  pack-bitmap.c: reimplement `midx_bitmap_filename()` with helper

 midx-write.c                | 161 ++++++++++++++++++------------------
 midx.c                      |  14 ++--
 midx.h                      |   6 +-
 pack-bitmap.c               |   5 +-
 pack-revindex.c             |   3 +-
 t/t5319-multi-pack-index.sh |  23 ++++++
 6 files changed, 119 insertions(+), 93 deletions(-)

Range-diff against v1:
1:  c753bc379b ! 1:  ad268bd264 midx-write.c: tolerate `--preferred-pack` without bitmaps
    @@ Commit message
         unreferenced packs via 'git multi-pack-index expire').
     
         In practice, this isn't possible to trigger when running `git
    -    multi-pack-index write` from via `git repack`, as the latter always
    -    passes `--stdin-packs`, which prevents us from loading an existing MIDX,
    -    as it forces all packs to be read from disk.
    +    multi-pack-index write` from `git repack`, as the latter always passes
    +    `--stdin-packs`, which prevents us from loading an existing MIDX, as it
    +    forces all packs to be read from disk.
     
         But a future commit in this series will change that behavior to
         unconditionally load an existing MIDX, even with `--stdin-packs`, making
2:  07dad5a581 ! 2:  9d422efe6e midx-write.c: reduce argument count for `get_sorted_entries()`
    @@ Commit message
     
         Simplify the declaration of this function by taking a single pointer to
         the whole `struct write_midx_context` instead of various members within
    -    it.
    +    it. Since this function is now computing the entire result (populating
    +    both `ctx->entries`, and `ctx->entries_nr`), rename it to something that
    +    doesn't start with "get_" to make clear that this function has a
    +    side-effect.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ midx-write.c: static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout
     -						  uint32_t nr_packs,
     -						  size_t *nr_objects,
     -						  int preferred_pack)
    -+static struct pack_midx_entry *get_sorted_entries(struct write_midx_context *ctx)
    ++static void compute_sorted_entries(struct write_midx_context *ctx)
      {
      	uint32_t cur_fanout, cur_pack, cur_object;
      	size_t alloc_objects, total_objects = 0;
      	struct midx_fanout fanout = { 0 };
    - 	struct pack_midx_entry *deduplicated_entries = NULL;
    +-	struct pack_midx_entry *deduplicated_entries = NULL;
     -	uint32_t start_pack = m ? m->num_packs : 0;
     +	uint32_t start_pack = ctx->m ? ctx->m->num_packs : 0;
      
    @@ midx-write.c: static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout
      	/*
      	 * As we de-duplicate by fanout value, we expect the fanout
     @@ midx-write.c: static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
    + 	alloc_objects = fanout.alloc = total_objects > 3200 ? total_objects / 200 : 16;
      
      	ALLOC_ARRAY(fanout.entries, fanout.alloc);
    - 	ALLOC_ARRAY(deduplicated_entries, alloc_objects);
    +-	ALLOC_ARRAY(deduplicated_entries, alloc_objects);
     -	*nr_objects = 0;
    ++	ALLOC_ARRAY(ctx->entries, alloc_objects);
     +	ctx->entries_nr = 0;
      
      	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
    @@ midx-write.c: static struct pack_midx_entry *get_sorted_entries(struct multi_pac
      				continue;
      
     -			ALLOC_GROW(deduplicated_entries, st_add(*nr_objects, 1),
    -+			ALLOC_GROW(deduplicated_entries, st_add(ctx->entries_nr, 1),
    ++			ALLOC_GROW(ctx->entries, st_add(ctx->entries_nr, 1),
      				   alloc_objects);
     -			memcpy(&deduplicated_entries[*nr_objects],
    -+			memcpy(&deduplicated_entries[ctx->entries_nr],
    ++			memcpy(&ctx->entries[ctx->entries_nr],
      			       &fanout.entries[cur_object],
      			       sizeof(struct pack_midx_entry));
     -			(*nr_objects)++;
    @@ midx-write.c: static struct pack_midx_entry *get_sorted_entries(struct multi_pac
      		}
      	}
      
    + 	free(fanout.entries);
    +-	return deduplicated_entries;
    + }
    + 
    + static int write_midx_pack_names(struct hashfile *f, void *data)
     @@ midx-write.c: static int write_midx_internal(const char *object_dir,
      		}
      	}
      
     -	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
     -					 ctx.preferred_pack_idx);
    -+	ctx.entries = get_sorted_entries(&ctx);
    ++	compute_sorted_entries(&ctx);
      
      	ctx.large_offsets_needed = 0;
      	for (i = 0; i < ctx.entries_nr; i++) {
3:  7acf4557dc ! 3:  e81296f8cc midx-write.c: pass `start_pack` to `get_sorted_entries()`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    midx-write.c: pass `start_pack` to `get_sorted_entries()`
    +    midx-write.c: pass `start_pack` to `compute_sorted_entries()`
     
    -    The function `get_sorted_entries()` is broadly responsible for
    +    The function `compute_sorted_entries()` is broadly responsible for
         building an array of the objects to be written into a MIDX based on the
         provided list of packs.
     
    @@ Commit message
     
         The existing implementation simply skips past the first
         ctx->m->num_packs (if ctx->m is non-NULL, indicating that we loaded an
    -    existing MIDX). Future changes (outside the scope of this patch series)
    -    to the MIDX code will require us to skip *at most* that number[^1].
    +    existing MIDX). This is because we read objects in packs from an
    +    existing MIDX via the MIDX itself, rather than from the pack-level
    +    fanout to guarantee a de-duplicated result (see: a40498a1265 (midx: use
    +    existing midx when writing new one, 2018-07-12)).
    +
    +    Future changes (outside the scope of this patch series) to the MIDX code
    +    will require us to skip *at most* that number[^1].
     
         We could tag each pack with a bit that indicates the pack's contents
         should be included in the MIDX. But we can just as easily determine the
    @@ midx-write.c: static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout
       * Copy only the de-duplicated entries (selected by most-recent modified time
       * of a packfile containing the object).
       */
    --static struct pack_midx_entry *get_sorted_entries(struct write_midx_context *ctx)
    -+static struct pack_midx_entry *get_sorted_entries(struct write_midx_context *ctx,
    -+						  uint32_t start_pack)
    +-static void compute_sorted_entries(struct write_midx_context *ctx)
    ++static void compute_sorted_entries(struct write_midx_context *ctx,
    ++				   uint32_t start_pack)
      {
      	uint32_t cur_fanout, cur_pack, cur_object;
      	size_t alloc_objects, total_objects = 0;
      	struct midx_fanout fanout = { 0 };
    - 	struct pack_midx_entry *deduplicated_entries = NULL;
     -	uint32_t start_pack = ctx->m ? ctx->m->num_packs : 0;
      
      	for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++)
    @@ midx-write.c: static int write_midx_internal(const char *object_dir,
      		}
      	}
      
    --	ctx.entries = get_sorted_entries(&ctx);
    -+	ctx.entries = get_sorted_entries(&ctx, start_pack);
    +-	compute_sorted_entries(&ctx);
    ++	compute_sorted_entries(&ctx, start_pack);
      
      	ctx.large_offsets_needed = 0;
      	for (i = 0; i < ctx.entries_nr; i++) {
4:  3908546ea8 ! 4:  9cd9257465 midx-write.c: extract `should_include_pack()`
    @@ Commit message
           - or, appear in the "to_include" list, if invoking the MIDX write
             machinery with the `--stdin-packs` command-line argument.
     
    -    In a future commit will want to call a slight variant of these checks
    -    from the code that reuses all packs from an existing MIDX, as well as
    -    the current location via add_pack_to_midx(). The latter will be
    -    modified in subsequent commits to only reuse packs which appear in the
    -    to_include list, if one was given.
    +    A future commit will want to call a slight variant of these checks from
    +    the code that reuses all packs from an existing MIDX, as well as the
    +    current location via add_pack_to_midx(). The latter will be modified in
    +    subsequent commits to only reuse packs which appear in the to_include
    +    list, if one was given.
     
         Prepare for that step by extracting these checks as a subroutine that
         may be called from both places.
5:  dc813ea1ca = 5:  1bb890e87c midx-write.c: extract `fill_packs_from_midx()`
6:  61268114c6 ! 6:  fe187b1939 midx-write.c: support reading an existing MIDX with `packs_to_include`
    @@ Commit message
         reject all of the packs it provided since they appear in an existing
         MIDX by definition.
     
    +    The sum total of this change is that we are now able to read and
    +    reference objects in an existing MIDX even when given a non-NULL
    +    `packs_to_include`. This is a prerequisite step for incremental MIDXs,
    +    which need to load any existing MIDX (if one is present) in order to
    +    determine whether or not an object already appears in an earlier portion
    +    of the MIDX to avoid duplicating it across multiple portions.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## midx-write.c ##
7:  f4c0167f43 = 7:  f4f977c1c7 midx: replace `get_midx_rev_filename()` with a generic helper
8:  79e3f7f83f = 8:  bcadaf9278 pack-bitmap.c: reimplement `midx_bitmap_filename()` with helper

base-commit: 3a57aa566a21e7a510c64881bc6bdff7eb397988
-- 
2.45.1.321.gbcadaf92783
