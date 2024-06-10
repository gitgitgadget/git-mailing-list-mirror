Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A961B812
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050253; cv=none; b=K4eNF4iKtFLxRiv5qj/wZwBZMo1+IslPE5a2Sd/6lStXsX2D5TUpMGMyzzxhibNCqEihqeZe1oVlgZ83PhW9A+HkfBJsHxrUi+bXaIa3R3UV3vAackwl7ioIr6118n4LOXYYjlzjl33fgwl4nzf27ffccGnKPgKXfHlELBCHCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050253; c=relaxed/simple;
	bh=Y3SIA/2w+Te9Jgn1O7sVyhjVgANHU1PqKzaj8XDmOjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+u++Vg0rb/5Wpjhq157H7BprfY1ygkxOWFcMR/pubyMZrUFIU0cRJYaxXSka54LIEF2q6Op6rxQ4e+W5CeuN7VrGTtfafBpH1BqWDrvisxiwPHmyeyYP/bhBgAYBPFBP2aN2OYUCxYfQhTX15PwhgXGGwr9JeZmJu3O/p99I+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=I7I7Ua61; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="I7I7Ua61"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9cc681e4fso167198b6e.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718050250; x=1718655050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uh2MOsWt6RyK1vYLd1rjnbGamLR1mnF3QxRMl9F6+bU=;
        b=I7I7Ua61EcbUm8GEGpfk47GQJBAkbCZ8+iwJtAuGJ3C3hGdtEbnrm1/ByF1mDyR9qG
         NJB3KBph+mqsIY2fNNANXBhv9frSDTklFnjJ79vnnqd2Y8nLtRIb1/Y+vhiTz/CAuZq4
         EmoRsYWvevVIKo3GPcbaLYzsyeHxC4i4ph0gm0sTDXEA1aPz+QIygP6vUaBEREzi3m+R
         V0DvbaehAZ6LW2kJ46cWMO/fJR6y1tm5T9+azsX/cVHiF2HAxeKV5vAVMbWDt02u64lZ
         k8TiINJla8+sAbY+utM7PT8JcFcWP21bHBTfPcqRUeUJL3Z2QXnVeog5DnioxDjnaR1J
         SkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718050250; x=1718655050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh2MOsWt6RyK1vYLd1rjnbGamLR1mnF3QxRMl9F6+bU=;
        b=F41MEqgvtfs4pJS+CHO02553ZRU6uJR/1dtxLnM2X8AztsHF8iUL9Kf3ZnOzKbjlsy
         6+Lm0UqLMBJJhalXlU1lZVbSk5mL3MBOYxENK1Z0/Bb9Ct1t+rBnIU1AWMgBPnW9fV9K
         pCGsYgkW+SgO+Jk71S8dJLN2qBiT9wbFw/jg8IgTyw1Gwx3MaJ6pG9QCioEEQ6a4ywx0
         Km87Gu3Jk43OXiMgS8An6r+SFFWSoVg1Vn0mR+GuDcuDjezcF5anAWUtTyKVPkwK9x5T
         asiTDwEPPFa8kjlNfBvrL3cdryv4sjKm46+fzPGmWg4Pxq/l5ZydHogMkAPbX73gDaql
         PfrQ==
X-Gm-Message-State: AOJu0YxSloguXE5Y5eGdRpoYU01ZqW7vMS6LJX3d0qFtGwkrJ7eewSRm
	GbEwbMJU/W1pmAkosCPsAXhi7tHR1L06GgguqDCtPgdKp5oTa2M7xbf+GK0xYXZlQlz2MChcTmw
	zo9A=
X-Google-Smtp-Source: AGHT+IGxxaJIDiCcp4u1oq5vOURTHo3FsJojQ0UoRGy+/MgabtXYfYWe6rc9R8OUH5nRpArJVTwRvg==
X-Received: by 2002:a05:6871:295:b0:254:de02:4c65 with SMTP id 586e51a60fabf-254de0254d6mr2445932fac.6.1718050248232;
        Mon, 10 Jun 2024 13:10:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954d9be952sm303715485a.102.2024.06.10.13.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:10:47 -0700 (PDT)
Date: Mon, 10 Jun 2024 16:10:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/3] midx: various brown paper bag fixes
Message-ID: <cover.1718050244.git.me@ttaylorr.com>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>

This series fixes a couple of brown paper bag bugs in the MIDX/bitmap
code.

This started as a single patch to address the MSan issue pointing to
uninitialized memory being used as a pack ID when trying to reject
cross-pack deltas during verbatim pack reuse.

The latter two patches of this series address that issue. The middle
patch squashes the bug and hardens against further regressions in that
area with a test. The last patch further hardens us by ensuring that the
"pack" input to midx_key_to_pack_pos() is bounded by the number of packs
in the MIDX.

The first patch in this series fixes another bug I noticed while writing
the test in the second patch which bisects to my d6a8c58675
(midx-write.c: support reading an existing MIDX with `packs_to_include`,
2024-05-29).

I would like to address the more fundamental issues that are described
in the first patch, but I think the reality is that doing so is much
more involved than a short series during week 6 of the release cycle
warrants. So instead, the first patch is a revert of d6a8c58675 (plus a
test to demonstrate the issue with it) which buys us some time to teach
the MIDX code how to handle not every pack being carried forward from an
existing MIDX.

Thanks in advance for your review, and sorry for these embarrassing
bugs.

Taylor Blau (3):
  midx-write.c: do not read existing MIDX with `packs_to_include`
  pack-bitmap.c: avoid uninitialized `pack_int_id` during reuse
  pack-revindex.c: guard against out-of-bounds pack lookups

 midx-write.c                  | 42 ++++++++++++++++++++++++++---------
 pack-bitmap.c                 | 10 +++++++++
 pack-revindex.c               |  3 +++
 t/t5326-multi-pack-bitmaps.sh | 30 +++++++++++++++++++++++++
 t/t5332-multi-pack-reuse.sh   | 26 ++++++++++++++++++++++
 5 files changed, 100 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  4aceb9233e ! 1:  0bdf925366 pack-bitmap.c: avoid uninitialized `pack_int_id` during reuse
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    pack-bitmap.c: avoid uninitialized `pack_int_id` during reuse
    -
    -    When performing multi-pack reuse, reuse_partial_packfile_from_bitmap()
    -    is responsible for generating an array of bitmapped_pack structs from
    -    which to perform reuse.
    -
    -    In the multi-pack case, we loop over the MIDXs packs and copy the result
    -    of calling `nth_bitmapped_pack()` to construct the list of reusable
    -    paths.
    -
    -    But we may also want to do pack-reuse over a single pack, either because
    -    we only had one pack to perform reuse over (in the case of single-pack
    -    bitmaps), or because we explicitly asked to do single pack reuse even
    -    with a MIDX[^1].
    -
    -    When this is the case, the array we generate of reusable packs contains
    -    only a single element, which is either (a) the pack attached to the
    -    single-pack bitmap, or (b) the MIDX's preferred pack.
    -
    -    In 795006fff4 (pack-bitmap: gracefully handle missing BTMP chunks,
    -    2024-04-15), we refactored the reuse_partial_packfile_from_bitmap()
    -    function and stopped assigning the pack_int_id field when reusing only
    -    the MIDX's preferred pack. This results in an uninitialized read down in
    -    try_partial_reuse() like so:
    -
    -        ==7474==WARNING: MemorySanitizer: use-of-uninitialized-value
    -        #0 0x55c5cd191dde in try_partial_reuse pack-bitmap.c:1887:8
    -        #1 0x55c5cd191dde in reuse_partial_packfile_from_bitmap_1 pack-bitmap.c:2001:8
    -        #2 0x55c5cd191dde in reuse_partial_packfile_from_bitmap pack-bitmap.c:2105:3
    -        #3 0x55c5cce0bd0e in get_object_list_from_bitmap builtin/pack-objects.c:4043:3
    -        #4 0x55c5cce0bd0e in get_object_list builtin/pack-objects.c:4156:27
    -        #5 0x55c5cce0bd0e in cmd_pack_objects builtin/pack-objects.c:4596:3
    -        #6 0x55c5ccc8fac8 in run_builtin git.c:474:11
    -
    -    which happens when try_partial_reuse() tries to call
    -    midx_pair_to_pack_pos() when it tries to reject cross-pack deltas.
    -
    -    Avoid the uninitialized read by ensuring that the pack_int_id field is
    -    set in the single-pack reuse case by setting it to either the MIDX
    -    preferred pack's pack_int_id, or '0', in the case of single-pack
    -    bitmaps.  In the latter case, we never read the pack_int_id field, so
    -    the choice of '0' is arbitrary.
    -
    -    [^1]: This can happen for a couple of reasons, either because the
    -      repository is configured with 'pack.allowPackReuse=(true|single)', or
    -      because the MIDX was generated prior to the introduction of the BTMP
    -      chunk, which contains information necessary to perform multi-pack
    -      reuse.
    -
    -    Reported-by: Kyle Lippincott <spectral@google.com>
    +    midx-write.c: do not read existing MIDX with `packs_to_include`
    +
    +    Commit d6a8c58675 (midx-write.c: support reading an existing MIDX with
    +    `packs_to_include`, 2024-05-29) changed the MIDX generation machinery to
    +    support reading from an existing MIDX when writing a new one.
    +
    +    Unfortunately, the rest of the MIDX generation machinery is not prepared
    +    to deal with such a change. For instance, the function responsible for
    +    adding to the object ID fanout table from a MIDX source
    +    (midx_fanout_add_midx_fanout()) will gladly add objects from an existing
    +    MIDX for some fanout level regardless of whether or not those objects
    +    came from packs that are to be included in the subsequent MIDX write.
    +
    +    This results in broken pseudo-pack object order (leading to incorrect
    +    object traversal results) and segmentation faults, like so (generated by
    +    running the added test prior to the changes in midx-write.c):
    +
    +        #0  0x000055ee31393f47 in midx_pack_order (ctx=0x7ffdde205c70) at midx-write.c:590
    +        #1  0x000055ee31395a69 in write_midx_internal (object_dir=0x55ee32570440 ".git/objects",
    +            packs_to_include=0x7ffdde205e20, packs_to_drop=0x0, preferred_pack_name=0x0,
    +            refs_snapshot=0x0, flags=15) at midx-write.c:1171
    +        #2  0x000055ee31395f38 in write_midx_file_only (object_dir=0x55ee32570440 ".git/objects",
    +            packs_to_include=0x7ffdde205e20, preferred_pack_name=0x0, refs_snapshot=0x0, flags=15)
    +            at midx-write.c:1274
    +        [...]
    +
    +    In stack frame #0, the code on midx-write.c:590 is using the new pack ID
    +    corresponding to some object which was added from the existing MIDX.
    +    Importantly, the pack from which that object was selected in the
    +    existing MIDX does not appear in the new MIDX as it was excluded via
    +    `--stdin-packs`.
    +
    +    In this instance, the pack in question had pack ID "1" in the existing
    +    MIDX, but since it was excluded from the new MIDX, we never filled in
    +    that entry in the pack_perm table, resulting in:
    +
    +        (gdb) p *ctx->pack_perm@2
    +        $1 = {0, 1515870810}
    +
    +    Which is what causes the segfault above when we try and read:
    +
    +        struct pack_info *pack = &ctx->info[ctx->pack_perm[i]];
    +        if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
    +            pack->bitmap_pos = 0;
    +
    +    Fundamentally, we should be able to read information from an existing
    +    MIDX when generating a new one. But in practice the midx-write.c code
    +    assumes that we won't run into issues like the above with incongruent
    +    pack IDs, and often makes those assumptions in extremely subtle and
    +    fragile ways.
    +
    +    Instead, let's avoid reading from an existing MIDX altogether, and stick
    +    with the pre-d6a8c58675 implementation. Harden against any regressions
    +    in this area by adding a test which demonstrates these issues.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## pack-bitmap.c ##
    -@@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
    - 		QSORT(packs, packs_nr, bitmapped_pack_cmp);
    - 	} else {
    - 		struct packed_git *pack;
    -+		uint32_t pack_int_id;
    - 
    - 		if (bitmap_is_midx(bitmap_git)) {
    - 			uint32_t preferred_pack_pos;
    -@@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
    - 			}
    - 
    - 			pack = bitmap_git->midx->packs[preferred_pack_pos];
    -+			pack_int_id = preferred_pack_pos;
    - 		} else {
    - 			pack = bitmap_git->pack;
    -+			/*
    -+			 * Any value for 'pack_int_id' will do here. When we
    -+			 * process the pack via try_partial_reuse(), we won't
    -+			 * use the `pack_int_id` field since we have a non-MIDX
    -+			 * bitmap.
    -+			 */
    -+			pack_int_id = 0;
    - 		}
    - 
    - 		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
    - 		packs[packs_nr].p = pack;
    -+		packs[packs_nr].pack_int_id = pack_int_id;
    - 		packs[packs_nr].bitmap_nr = pack->num_objects;
    - 		packs[packs_nr].bitmap_pos = 0;
    + ## midx-write.c ##
    +@@ midx-write.c: struct write_midx_context {
    + };
      
    + static int should_include_pack(const struct write_midx_context *ctx,
    +-			       const char *file_name,
    +-			       int exclude_from_midx)
    ++			       const char *file_name)
    + {
    +-	if (exclude_from_midx && ctx->m && midx_contains_pack(ctx->m, file_name))
    ++	/*
    ++	 * Note that at most one of ctx->m and ctx->to_include are set,
    ++	 * so we are testing midx_contains_pack() and
    ++	 * string_list_has_string() independently (guarded by the
    ++	 * appropriate NULL checks).
    ++	 *
    ++	 * We could support passing to_include while reusing an existing
    ++	 * MIDX, but don't currently since the reuse process drags
    ++	 * forward all packs from an existing MIDX (without checking
    ++	 * whether or not they appear in the to_include list).
    ++	 *
    ++	 * If we added support for that, these next two conditional
    ++	 * should be performed independently (likely checking
    ++	 * to_include before the existing MIDX).
    ++	 */
    ++	if (ctx->m && midx_contains_pack(ctx->m, file_name))
    + 		return 0;
    +-	if (ctx->to_include && !string_list_has_string(ctx->to_include,
    +-						       file_name))
    ++	else if (ctx->to_include &&
    ++		 !string_list_has_string(ctx->to_include, file_name))
    + 		return 0;
    + 	return 1;
    + }
    +@@ midx-write.c: static void add_pack_to_midx(const char *full_path, size_t full_path_len,
    + 	if (ends_with(file_name, ".idx")) {
    + 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
    + 
    +-		if (!should_include_pack(ctx, file_name, 1))
    ++		if (!should_include_pack(ctx, file_name))
    + 			return;
    + 
    + 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
    +@@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx,
    + 	uint32_t i;
    + 
    + 	for (i = 0; i < ctx->m->num_packs; i++) {
    +-		if (!should_include_pack(ctx, ctx->m->pack_names[i], 0))
    +-			continue;
    +-
    + 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
    + 
    + 		if (flags & MIDX_WRITE_REV_INDEX || preferred_pack_name) {
    +@@ midx-write.c: static int write_midx_internal(const char *object_dir,
    + 		die_errno(_("unable to create leading directories of %s"),
    + 			  midx_name.buf);
    + 
    +-	ctx.m = lookup_multi_pack_index(the_repository, object_dir);
    ++	if (!packs_to_include) {
    ++		/*
    ++		 * Only reference an existing MIDX when not filtering which
    ++		 * packs to include, since all packs and objects are copied
    ++		 * blindly from an existing MIDX if one is present.
    ++		 */
    ++		ctx.m = lookup_multi_pack_index(the_repository, object_dir);
    ++	}
    ++
    + 	if (ctx.m && !midx_checksum_valid(ctx.m)) {
    + 		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
    + 		ctx.m = NULL;
    +@@ midx-write.c: static int write_midx_internal(const char *object_dir,
    + 	ctx.nr = 0;
    + 	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
    + 	ctx.info = NULL;
    +-	ctx.to_include = packs_to_include;
    + 	ALLOC_ARRAY(ctx.info, ctx.alloc);
    + 
    + 	if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
    +@@ midx-write.c: static int write_midx_internal(const char *object_dir,
    + 	else
    + 		ctx.progress = NULL;
    + 
    ++	ctx.to_include = packs_to_include;
    ++
    + 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
    + 	stop_progress(&ctx.progress);
    + 
    +
    + ## t/t5326-multi-pack-bitmaps.sh ##
    +@@ t/t5326-multi-pack-bitmaps.sh: do
    + 	'
    + done
    + 
    ++test_expect_success 'remove one packfile between MIDX bitmap writes' '
    ++	git init remove-pack-between-writes &&
    ++	(
    ++		cd remove-pack-between-writes &&
    ++
    ++		test_commit A &&
    ++		test_commit B &&
    ++		test_commit C &&
    ++
    ++		# Create packs with the prefix "pack-A", "pack-B",
    ++		# "pack-C" to impose a lexicographic order on these
    ++		# packs so the pack being removed is always from the
    ++		# middle.
    ++		packdir=.git/objects/pack &&
    ++		A="$(echo A | git pack-objects $packdir/pack-A --revs)" &&
    ++		B="$(echo B | git pack-objects $packdir/pack-B --revs)" &&
    ++		C="$(echo C | git pack-objects $packdir/pack-C --revs)" &&
    ++
    ++		git multi-pack-index write --bitmap &&
    ++
    ++		cat >in <<-EOF &&
    ++		pack-A-$A.idx
    ++		pack-C-$C.idx
    ++		EOF
    ++		git multi-pack-index write --bitmap --stdin-packs <in &&
    ++
    ++		git rev-list --test-bitmap HEAD
    ++	)
    ++'
    ++
    + test_done
-:  ---------- > 2:  a3c28f1202 pack-bitmap.c: avoid uninitialized `pack_int_id` during reuse
-:  ---------- > 3:  dadcf96c06 pack-revindex.c: guard against out-of-bounds pack lookups

base-commit: 1b76f065085811104b5f4adff001956d7e5c5d1c
-- 
2.45.2.447.g6b4ffca7ec.dirty
