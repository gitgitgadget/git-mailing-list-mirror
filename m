Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B306E2EAF7
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983503; cv=none; b=Xn1X5hw9WyBvTdLb2EKvwIleo3NodtpEVZe94HfZIcxtp3vnBGfmcn8q/Y+yOpX7fbXBWu80Zb+7k+f6x5eS/JrH2AMsgRPGTCvCV0qO24wIKLRT2GunVJYfD1jmhKsbp3zBPnrI9JfM4EYWt1KZASH0zD4FGj7LJd637AdiEz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983503; c=relaxed/simple;
	bh=HVvGh6CzDXN/H41o/szN0WIkcdnOumzNLRvDeR7sSQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdw6k7FNeEXhAmgFbaiuaKbxu5TAkFjiRKs188fw/dpG2Dg9VvKMQUGC/onjfDOwT1NLbkrzV4SnX8cd6c+LJkQVpQAXT1c/86wSP5QNSMuON6m0QdnGvOhXIWe+jK1ipLlE1VcHKn/3mhSmzlqKm4y908e6M9G7bx0u0U8Y9z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UXtLLXu/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UXtLLXu/"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd049b5428so31450106d6.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983499; x=1742588299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LvSs4rbrIYgQa9xSsele1rq6mxAnbvTWFpebXNmvcek=;
        b=UXtLLXu/H7caOvTR8nXo0aR9l3oqWYIEFr9i06bksdekt+FSWUGcapYW/Hd7p83f9N
         95rbRE8bcSfvDcdG+qoSPq5ItB3+LQ2zdfdn1RK85eCe6glE6LjdAiTIKD7KIAIFHwDM
         p8kc5AUGGtRwkh9vVGPcd9UO7ROWv2eApsygebzSiLkb0zTsbQjr2Zuii/4zN5nzeaDZ
         +i0FBQVM2VFqyeq4qWXaFnCLvYk9TeAXS6na6fDqCD9BkITAKKLKmHcSwwvTh0rehHmt
         sFkQiwFZxQEyxwuk4HclvO7A89a2GrLQvdb+O2QtynKhaM90s44wJg8+Shy+2koygDUl
         lTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983499; x=1742588299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvSs4rbrIYgQa9xSsele1rq6mxAnbvTWFpebXNmvcek=;
        b=exTAhrYRfnFQ5o8+9K7Q4zjWLouAGBWfsUpEaUPXlcTx0la3O394o7msd/YcImPRMy
         trZ0l4SdBN/ZF0BIjuETy+0UuAsjVb+emoHPTpiBFLWNjjlLodMcJFxYl2+UxUh9lONu
         9YGlyCSKrPrnUWz8cHH8vI2uBowIWLhlDcditPSKtq1dx43GsIe9RRxLYOtNU4AlEtqe
         W6/y2sg1CfvhhWSEfOJ/NnwM1SUS/Idl8LedPb/XGLN2ntKGu+caUlyquz70+luUuEPm
         IXmowuCCmztmDElVQKMrXaJFiGzOGGRcRANnC/IY/O9bJGZe7+NnNnvpJBozRGPY79h2
         +jXg==
X-Gm-Message-State: AOJu0YwvTGHM+pOAk24oe7A2KxsywxYKtM05+TTcp30FM/s5d2eDT9Ye
	Pc3KdrDnNjLV/d8pS2JogrlWokVo2SVKrR9325aLF33qKGtKDumS1y9BflTG4aHvogQt7YxPG7Z
	1Hu0=
X-Gm-Gg: ASbGnct223Dh0I4+cqFIGpW72i0W00P+BWKZauwmODN3UtLtEmZT4kK5rUwCd/DOiQA
	6MXccDksFErD0YXtbSaen7YC1Mv+WHq+Da3xXgJ53pVPj5XLHdgX+k1mXyBYC8awxRsxInjB21E
	o6mFhXOG8SfdaTe5Q9UTX5beUM2aWJ2bsUw5rhnyIZNLXhh+SS7Jt3J8SYw+tM0hNk1vfKcZ/g5
	zo4dQixkXP/cyMxzICbuM7ZcFAx4b1Yd9J2Rd2bU1x0Zln840gdUBKqTLfUjfWytsvJupdhWmib
	+gzhP8tCePm/fdZbTPXtJIGOrSEPUr2Zzqp6jNVRVSYVvw3cfmyIubitsOF6NAQ5zvdx0Bapzvn
	mK2USdVMz9zsU+dcM6guvopmgQy8=
X-Google-Smtp-Source: AGHT+IHRYMqZGC+4IywVcKYSkBHauEQScYyiQKE6rEbNEk1zBTbXAuKHS0R6VbFzjuuninNWu+J1LQ==
X-Received: by 2002:a05:6214:2489:b0:6e6:6964:ca77 with SMTP id 6a1803df08f44-6eaeaaaa0afmr59351696d6.28.1741983498876;
        Fri, 14 Mar 2025 13:18:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34d7b6sm27449936d6.115.2025.03.14.13.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:18 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/13] midx: incremental multi-pack indexes, part two
Message-ID: <cover.1741983492.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

This is a new round of my series to implement bitmap support for
incremental multi-pack indexes (MIDXs). It has been rebased on current
'master', which is 683c54c999 (Git 2.49, 2025-03-14) at the time of
writing.

== Changes since last time

This round addresses helpful review from Patrick Steinhardt. It
clarifies a number of concepts which were previously less than clear,
and makes a number of cosmetic changes to align more closely with our
CodingGuidelines in certain areas.

There are a few technical changes which you can see in the range-diff
below, but they are relatively minor. The series is functionally
unchanged since last time.

== Original cover letter

This series is based on 'master', with an additional merge between
tb/incremental-midx-part-1[1] and my newer series to fix a handful of
bugs related to pseudo-merge bitmaps[2].

This is the second of three series to implement support for incremental
multi-pack indexes (MIDXs). This series brings support for bitmaps that
are tied to incremental MIDXs in addition to regular MIDX bitmaps.

The details are laid out in the commits themselves, but the high-level
approach is as follows:

  - Each layer in the incremental MIDX chain has its own corresponding
    *.bitmap file. Each bitmap contains commits / pseudo-merges which
    are selected only from the commits in that layer. Likewise, only
    that layer's objects are written in the type-level bitmaps.

  - The reachability traversal is only conducted on the top-most bitmap
    corresponding to the most recent layer in the incremental MIDX
    chain. Earlier layers may be consulted to retrieve commit /
    pseudo-merge reachability bitmaps, but only the top-most bitmap's
    "result" and "haves" fields are used.

  - In essence, the top-most bitmap is the only one that "matters", and
    earlier bitmaps are merely used to look up commit and pseudo-merge
    bitmaps from that layer.

  - Whenever we need to look at the type-level bitmaps corresponding to
    the whole incremental MIDX chain, a new "ewah_or_iterator" is used.
    This works in concept like a typical ewah_iterator, except works
    over many EWAH bitmaps in parallel, OR-ing their results together
    before returning them to the user.

    In effect, this allows us to treat the union of all type-level
    bitmaps (each of which only stores information about the objects its
    corresponding layer within the incremental MIDX chain) as a single
    type-level bitmap corresponding to all of the objects across every
    layer of the incremental MIDX chain.

The sum total of this series is that we are able to append new commits /
pseudo-merges to a repository's reachability bitmaps without having to
rewrite existing bitmaps, making the operation much cheaper to perform
in large repositories.

The series is laid out roughly as follows:

  - The first patch describes the technical details of incremental MIDX
    bitmaps.

  - The second patch adjusts the pack-revindex internals to prepare for
    incremental MIDX bitmaps.

  - The next seven patches adjust various components of the pack-bitmap
    internals to do the same.

  - The next three patches introduce and adjust callers to use the
    ewah_or_iterator (as above).

  - The final patch implements writing incremental MIDX bitmaps, and
    introduces tests.

After this series, the remaining goals for this project include being
able to compact contiguous runs of incremental MIDX layers into a single
layer to support growing the chain of MIDX layers without the chain
itself becoming too long.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/cover.1722958595.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/cover.1723743050.git.me@ttaylorr.com/

Taylor Blau (13):
  Documentation: describe incremental MIDX bitmaps
  pack-revindex: prepare for incremental MIDX bitmaps
  pack-bitmap.c: open and store incremental bitmap layers
  pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
  pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
  pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
  pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
  pack-bitmap.c: compute disk-usage with incremental MIDXs
  pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
  ewah: implement `struct ewah_or_iterator`
  pack-bitmap.c: keep track of each layer's type bitmaps
  pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
  midx: implement writing incremental MIDX bitmaps

 Documentation/technical/multi-pack-index.adoc |  71 ++++
 builtin/pack-objects.c                        |   3 +-
 ewah/ewah_bitmap.c                            |  33 ++
 ewah/ewok.h                                   |  12 +
 midx-write.c                                  |  57 ++-
 pack-bitmap-write.c                           |  65 +++-
 pack-bitmap.c                                 | 342 ++++++++++++++----
 pack-bitmap.h                                 |   4 +-
 pack-revindex.c                               |  34 +-
 t/t5334-incremental-multi-pack-index.sh       |  84 +++++
 10 files changed, 583 insertions(+), 122 deletions(-)

Range-diff against v3:
 1:  caed2c6ec3 !  1:  f565f2fff1 Documentation: describe incremental MIDX bitmaps
    @@ Commit message
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## Documentation/technical/multi-pack-index.txt ##
    -@@ Documentation/technical/multi-pack-index.txt: objects_nr($H2) + objects_nr($H1) + i
    + ## Documentation/technical/multi-pack-index.adoc ##
    +@@ Documentation/technical/multi-pack-index.adoc: objects_nr($H2) + objects_nr($H1) + i
      (in the C implementation, this is often computed as `i +
      m->num_objects_in_base`).
      
    @@ Documentation/technical/multi-pack-index.txt: objects_nr($H2) + objects_nr($H1)
     +
     +1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
     +  `o1` is considered less than `o2`.
    ++
     +2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
    -+  MIDX layer has no base, then If one of `pack(o1)` and `pack(o2)` is
    -+  preferred and the other is not, then the preferred one sorts first. If
    -+  there is a base layer (i.e. the MIDX layer is not the first layer in
    -+  the chain), then if `pack(o1)` appears earlier in that MIDX layer's
    -+  pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
    -+  appears earlier, than the opposite is true.
    ++   MIDX layer has no base, then if one of `pack(o1)` and `pack(o2)` is
    ++   preferred and the other is not, then the preferred one sorts first. If
    ++   there is a base layer (i.e. the MIDX layer is not the first layer in
    ++   the chain), then if `pack(o1)` appears earlier in that MIDX layer's
    ++   pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
    ++   appears earlier, than the opposite is true.
    ++
     +3. Otherwise, `o1` and `o2` appear in the same pack, and thus in the
    -+  same MIDX layer. Sort `o1` and `o2` by their offset within their
    -+  containing packfile.
    ++   same MIDX layer. Sort `o1` and `o2` by their offset within their
    ++   containing packfile.
    ++
    ++Note that the preferred pack is a property of the MIDX chain, not the
    ++individual layers themselves. Fundamentally we could introduce a
    ++per-layer preferred pack, but this is less relevant now that we can
    ++perform multi-pack reuse across the set of packs in a MIDX.
     +
     +=== Reachability bitmaps and incremental MIDXs
     +
 2:  b902513f43 !  2:  f2a232e556 pack-revindex: prepare for incremental MIDX bitmaps
    @@ pack-bitmap.c: static int ext_index_add_object(struct bitmap_index *bitmap_git,
      }
      
      struct bitmap_show_data {
    +@@ pack-bitmap.c: struct ewah_bitmap *pseudo_merge_bitmap_for_commit(struct bitmap_index *bitmap_g
    + 		if (pos < 0 || pos >= bitmap_num_objects(bitmap_git))
    + 			goto done;
    + 
    ++		/*
    ++		 * Use bitmap-relative positions instead of offsetting
    ++		 * by bitmap_git->num_objects_in_base because we use
    ++		 * this to find a match in pseudo_merge_for_parents(),
    ++		 * and pseudo-merge groups cannot span multiple bitmap
    ++		 * layers.
    ++		 */
    + 		bitmap_set(parents, pos);
    + 	}
    + 
    +-	match = pseudo_merge_for_parents(&bitmap_git->pseudo_merges,
    +-						parents);
    ++	match = pseudo_merge_for_parents(&bitmap_git->pseudo_merges, parents);
    + 
    + done:
    + 	bitmap_free(parents);
     @@ pack-bitmap.c: static void show_extended_objects(struct bitmap_index *bitmap_git,
      	for (i = 0; i < eindex->count; ++i) {
      		struct object *obj;
    @@ pack-bitmap.c: static unsigned long get_size_by_pos(struct bitmap_index *bitmap_
      		struct eindex *eindex = &bitmap_git->ext_index;
     -		struct object *obj = eindex->objects[pos - bitmap_num_objects(bitmap_git)];
     +		struct object *obj = eindex->objects[pos - bitmap_non_extended_bits(bitmap_git)];
    - 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
    + 		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
    + 					     &oi, 0) < 0)
      			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
    - 	}
     @@ pack-bitmap.c: static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
      	uint32_t objects_nr;
      	size_t i, pos;
    @@ pack-bitmap.c: static off_t get_disk_usage_for_extended(struct bitmap_index *bit
     +				st_add(bitmap_non_extended_bits(bitmap_git), i)))
      			continue;
      
    - 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
    + 		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
     
      ## pack-revindex.c ##
     @@ pack-revindex.c: int load_midx_revindex(struct multi_pack_index *m)
      	trace2_data_string("load_midx_revindex", the_repository,
      			   "source", "rev");
      
    --	get_midx_filename_ext(&revindex_name, m->object_dir,
    +-	get_midx_filename_ext(m->repo->hash_algo, &revindex_name, m->object_dir,
     -			      get_midx_checksum(m), MIDX_EXT_REV);
     +	if (m->has_chain)
    -+		get_split_midx_filename_ext(&revindex_name, m->object_dir,
    -+					    get_midx_checksum(m), MIDX_EXT_REV);
    ++		get_split_midx_filename_ext(m->repo->hash_algo, &revindex_name,
    ++					    m->object_dir, get_midx_checksum(m),
    ++					    MIDX_EXT_REV);
     +	else
    -+		get_midx_filename_ext(&revindex_name, m->object_dir,
    -+				      get_midx_checksum(m), MIDX_EXT_REV);
    ++		get_midx_filename_ext(m->repo->hash_algo, &revindex_name,
    ++				      m->object_dir, get_midx_checksum(m),
    ++				      MIDX_EXT_REV);
      
      	ret = load_revindex_from_disk(revindex_name.buf,
      				      m->num_objects,
    @@ pack-revindex.c: static int midx_pack_order_cmp(const void *va, const void *vb)
      	struct multi_pack_index *midx = key->midx;
      
     -	uint32_t versus = pack_pos_to_midx(midx, (uint32_t*)vb - (const uint32_t *)midx->revindex_data);
    -+	size_t pos = (uint32_t*)vb - (const uint32_t *)midx->revindex_data;
    ++	size_t pos = (uint32_t *)vb - (const uint32_t *)midx->revindex_data;
     +	uint32_t versus = pack_pos_to_midx(midx, pos + midx->num_objects_in_base);
      	uint32_t versus_pack = nth_midxed_pack_int_id(midx, versus);
      	off_t versus_offset;
 3:  5b5d625cbe !  3:  aca0318fb1 pack-bitmap.c: open and store incremental bitmap layers
    @@ pack-bitmap.c: struct bitmap_index {
     +	/*
     +	 * If using a multi-pack index chain, 'base' points to the
     +	 * bitmap index corresponding to this bitmap's midx->base_midx.
    ++	 *
    ++	 * base_nr indicates how many layers precede this one, and is
    ++	 * zero when base is NULL.
     +	 */
     +	struct bitmap_index *base;
     +	uint32_t base_nr;
    @@ pack-bitmap.c: static int load_bitmap_entries_v1(struct bitmap_index *index)
      char *midx_bitmap_filename(struct multi_pack_index *midx)
      {
      	struct strbuf buf = STRBUF_INIT;
    --	get_midx_filename_ext(&buf, midx->object_dir, get_midx_checksum(midx),
    --			      MIDX_EXT_BITMAP);
    +-	get_midx_filename_ext(midx->repo->hash_algo, &buf, midx->object_dir,
    +-			      get_midx_checksum(midx), MIDX_EXT_BITMAP);
     +	if (midx->has_chain)
    -+		get_split_midx_filename_ext(&buf, midx->object_dir,
    ++		get_split_midx_filename_ext(midx->repo->hash_algo, &buf,
    ++					    midx->object_dir,
     +					    get_midx_checksum(midx),
     +					    MIDX_EXT_BITMAP);
     +	else
    -+		get_midx_filename_ext(&buf, midx->object_dir,
    -+				      get_midx_checksum(midx), MIDX_EXT_BITMAP);
    ++		get_midx_filename_ext(midx->repo->hash_algo, &buf,
    ++				      midx->object_dir, get_midx_checksum(midx),
    ++				      MIDX_EXT_BITMAP);
      
      	return strbuf_detach(&buf, NULL);
      }
    -@@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    - {
    - 	struct stat st;
    - 	char *bitmap_name = midx_bitmap_filename(midx);
    --	int fd = git_open(bitmap_name);
    -+	int fd;
    - 	uint32_t i, preferred_pack;
    - 	struct packed_git *preferred;
    - 
    -+	fd = git_open(bitmap_name);
    -+	if (fd < 0 && errno == ENOENT) {
    -+		FREE_AND_NULL(bitmap_name);
    -+		bitmap_name = midx_bitmap_filename(midx);
    -+		fd = git_open(bitmap_name);
    -+	}
    -+
    - 	if (fd < 0) {
    - 		if (errno != ENOENT)
    - 			warning_errno("cannot open '%s'", bitmap_name);
     @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      		goto cleanup;
      	}
      
     -	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
    +-		if (prepare_midx_pack(bitmap_repo(bitmap_git),
    +-				      bitmap_git->midx,
    +-				      i)) {
     +	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
    - 		if (prepare_midx_pack(the_repository, bitmap_git->midx, i)) {
    ++		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
      			warning(_("could not open pack %s"),
      				bitmap_git->midx->pack_names[i]);
    -@@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    - 		goto cleanup;
    - 	}
    - 
    --	preferred = bitmap_git->midx->packs[preferred_pack];
    -+	preferred = nth_midxed_pack(bitmap_git->midx, preferred_pack);
    - 	if (!is_pack_valid(preferred)) {
    - 		warning(_("preferred pack (%s) is invalid"),
    - 			preferred->pack_name);
    - 		goto cleanup;
    + 			goto cleanup;
    + 		}
      	}
      
     +	if (midx->base_midx) {
     +		bitmap_git->base = prepare_midx_bitmap_git(midx->base_midx);
     +		bitmap_git->base_nr = bitmap_git->base->base_nr + 1;
     +	} else {
    -+		bitmap_git->base_nr = 1;
    ++		bitmap_git->base_nr = 0;
     +	}
     +
      	return 0;
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
      	bitmap_git->map_size = xsize_t(st.st_size);
      	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
      	bitmap_git->map_pos = 0;
    -+	bitmap_git->base_nr = 1;
    ++	bitmap_git->base_nr = 0;
      	close(fd);
      
      	if (load_bitmap_header(bitmap_git) < 0) {
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_git(struct repository *r)
      
      struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
      {
    --	struct repository *r = the_repository;
    +-	struct repository *r = midx->repo;
      	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
      
     -	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
 4:  16259667fb =  4:  832fd0e8dc pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 5:  b7a45d7eff =  5:  c7c9f89956 pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
 6:  c8401fa0fb =  6:  14d3d80c3d pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
 7:  17ab23dd76 !  7:  b45a9ccbc2 pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
    @@ pack-bitmap.c: static void test_show_commit(struct commit *commit, void *data)
     +	return total;
     +}
     +
    -+static void prepare_bitmap_test_data(struct bitmap_test_data *tdata,
    ++static void bitmap_test_data_prepare(struct bitmap_test_data *tdata,
     +				     struct bitmap_index *bitmap_git)
     +{
     +	memset(tdata, 0, sizeof(struct bitmap_test_data));
    @@ pack-bitmap.c: static void test_show_commit(struct commit *commit, void *data)
     +
     +	if (bitmap_git->base) {
     +		CALLOC_ARRAY(tdata->base_tdata, 1);
    -+		prepare_bitmap_test_data(tdata->base_tdata, bitmap_git->base);
    ++		bitmap_test_data_prepare(tdata->base_tdata, bitmap_git->base);
     +	}
     +}
     +
    -+static void free_bitmap_test_data(struct bitmap_test_data *tdata)
    ++static void bitmap_test_data_release(struct bitmap_test_data *tdata)
     +{
     +	if (!tdata)
     +		return;
     +
    -+	free_bitmap_test_data(tdata->base_tdata);
    ++	bitmap_test_data_release(tdata->base_tdata);
     +	free(tdata->base_tdata);
     +
     +	bitmap_free(tdata->base);
    @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
     +
     +		if (bitmap_is_midx(found))
     +			fprintf_ln(stderr, "Located via MIDX '%s'.",
    -+				   hash_to_hex(get_midx_checksum(found->midx)));
    ++				   hash_to_hex_algop(get_midx_checksum(found->midx),
    ++						     revs->repo->hash_algo));
     +		else
     +			fprintf_ln(stderr, "Located via pack '%s'.",
    -+				   hash_to_hex(found->pack->hash));
    ++				   hash_to_hex_algop(found->pack->hash,
    ++						     revs->repo->hash_algo));
      
      		result = ewah_to_bitmap(bm);
      	}
    @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
     -	tdata.trees = ewah_to_bitmap(bitmap_git->trees);
     -	tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
     -	tdata.tags = ewah_to_bitmap(bitmap_git->tags);
    -+	prepare_bitmap_test_data(&tdata, bitmap_git);
    - 	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
    ++	bitmap_test_data_prepare(&tdata, bitmap_git);
    + 	tdata.prg = start_progress(revs->repo,
    + 				   "Verifying bitmap entries",
    + 				   result_popcnt);
     -	tdata.seen = 0;
      
      	traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);
    @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
     -	bitmap_free(tdata.trees);
     -	bitmap_free(tdata.blobs);
     -	bitmap_free(tdata.tags);
    -+	free_bitmap_test_data(&tdata);
    ++	bitmap_test_data_release(&tdata);
      	free_bitmap_index(bitmap_git);
      }
      
 8:  75d170ce07 =  8:  c1eefeae99 pack-bitmap.c: compute disk-usage with incremental MIDXs
 9:  0b4fcfcecb =  9:  11c4b7b949 pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
10:  e1b5f6181e = 10:  cb08ad6a62 ewah: implement `struct ewah_or_iterator`
11:  9ab8fb472f ! 11:  a29f4ee60d pack-bitmap.c: keep track of each layer's type bitmaps
    @@ pack-bitmap.c: static int load_reverse_index(struct repository *r, struct bitmap
     +static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
     +{
     +	struct bitmap_index *curr = bitmap_git;
    -+	size_t i = bitmap_git->base_nr - 1;
    ++	size_t i = bitmap_git->base_nr;
     +
    -+	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr);
    -+	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr);
    -+	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr);
    -+	ALLOC_ARRAY(bitmap_git->tags_all, bitmap_git->base_nr);
    ++	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr + 1);
    ++	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr + 1);
    ++	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr + 1);
    ++	ALLOC_ARRAY(bitmap_git->tags_all, bitmap_git->base_nr + 1);
     +
     +	while (curr) {
     +		bitmap_git->commits_all[i] = curr->commits;
    @@ pack-bitmap.c: static int load_reverse_index(struct repository *r, struct bitmap
     +		bitmap_git->tags_all[i] = curr->tags;
     +
     +		curr = curr->base;
    ++		if (curr && !i)
    ++			BUG("unexpected number of bitmap layers, expected %"PRIu32,
    ++			    bitmap_git->base_nr + 1);
     +		i -= 1;
     +	}
     +}
12:  87cb011e7f ! 12:  a1cf65bedc pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
    @@ pack-bitmap.c: static void show_extended_objects(struct bitmap_index *bitmap_git
      	case OBJ_COMMIT:
     -		ewah_iterator_init(it, bitmap_git->commits);
     +		ewah_or_iterator_init(it, bitmap_git->commits_all,
    -+				      bitmap_git->base_nr);
    ++				      bitmap_git->base_nr + 1);
      		break;
      
      	case OBJ_TREE:
     -		ewah_iterator_init(it, bitmap_git->trees);
     +		ewah_or_iterator_init(it, bitmap_git->trees_all,
    -+				      bitmap_git->base_nr);
    ++				      bitmap_git->base_nr + 1);
      		break;
      
      	case OBJ_BLOB:
     -		ewah_iterator_init(it, bitmap_git->blobs);
     +		ewah_or_iterator_init(it, bitmap_git->blobs_all,
    -+				      bitmap_git->base_nr);
    ++				      bitmap_git->base_nr + 1);
      		break;
      
      	case OBJ_TAG:
     -		ewah_iterator_init(it, bitmap_git->tags);
     +		ewah_or_iterator_init(it, bitmap_git->tags_all,
    -+				      bitmap_git->base_nr);
    ++				      bitmap_git->base_nr + 1);
      		break;
      
      	default:
13:  77ddd1170f ! 13:  d0d564685b midx: implement writing incremental MIDX bitmaps
    @@ builtin/pack-objects.c: static void write_pack_file(void)
      				bitmap_writer_build_type_index(&bitmap_writer,
      							       written_list);
     
    + ## ewah/ewah_bitmap.c ##
    +@@ ewah/ewah_bitmap.c: int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it)
    + 	return ret;
    + }
    + 
    +-void ewah_or_iterator_free(struct ewah_or_iterator *it)
    ++void ewah_or_iterator_release(struct ewah_or_iterator *it)
    + {
    + 	free(it->its);
    + }
    +
    + ## ewah/ewok.h ##
    +@@ ewah/ewok.h: void ewah_or_iterator_init(struct ewah_or_iterator *it,
    + 
    + int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it);
    + 
    +-void ewah_or_iterator_free(struct ewah_or_iterator *it);
    ++void ewah_or_iterator_release(struct ewah_or_iterator *it);
    + 
    + void ewah_xor(
    + 	struct ewah_bitmap *ewah_i,
    +
      ## midx-write.c ##
     @@ midx-write.c: static uint32_t *midx_pack_order(struct write_midx_context *ctx)
      	return pack_order;
    @@ midx-write.c: static uint32_t *midx_pack_order(struct write_midx_context *ctx)
      	struct strbuf buf = STRBUF_INIT;
      	char *tmp_file;
      
    - 	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
    + 	trace2_region_enter("midx", "write_midx_reverse_index", ctx->repo);
      
    --	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
    +-	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
    +-								    ctx->repo->hash_algo));
     +	if (ctx->incremental)
    -+		get_split_midx_filename_ext(&buf, object_dir, midx_hash,
    ++		get_split_midx_filename_ext(ctx->repo->hash_algo, &buf,
    ++					    object_dir, midx_hash,
     +					    MIDX_EXT_REV);
     +	else
    -+		get_midx_filename_ext(&buf, object_dir, midx_hash,
    -+				      MIDX_EXT_REV);
    ++		get_midx_filename_ext(ctx->repo->hash_algo, &buf, object_dir,
    ++				      midx_hash, MIDX_EXT_REV);
      
    - 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
    - 					midx_hash, WRITE_REV);
    + 	tmp_file = write_rev_file_order(ctx->repo->hash_algo, NULL, ctx->pack_order,
    + 					ctx->entries_nr, midx_hash, WRITE_REV);
     @@ midx-write.c: static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
      	return cb.commits;
      }
      
    --static int write_midx_bitmap(const char *midx_name,
    +-static int write_midx_bitmap(struct repository *r, const char *midx_name,
     +static int write_midx_bitmap(struct write_midx_context *ctx,
     +			     const char *object_dir,
      			     const unsigned char *midx_hash,
    @@ midx-write.c: static struct commit **find_commits_for_midx_bitmap(uint32_t *inde
      	struct bitmap_writer writer;
      	struct pack_idx_entry **index;
     -	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
    --					hash_to_hex(midx_hash));
    +-				    hash_to_hex_algop(midx_hash, r->hash_algo));
     +	struct strbuf bitmap_name = STRBUF_INIT;
    + 
    +-	trace2_region_enter("midx", "write_midx_bitmap", r);
    ++	trace2_region_enter("midx", "write_midx_bitmap", ctx->repo);
     +
     +	if (ctx->incremental)
    -+		get_split_midx_filename_ext(&bitmap_name, object_dir, midx_hash,
    ++		get_split_midx_filename_ext(ctx->repo->hash_algo, &bitmap_name,
    ++					    object_dir, midx_hash,
     +					    MIDX_EXT_BITMAP);
     +	else
    -+		get_midx_filename_ext(&bitmap_name, object_dir, midx_hash,
    -+				      MIDX_EXT_BITMAP);
    ++		get_midx_filename_ext(ctx->repo->hash_algo, &bitmap_name,
    ++				      object_dir, midx_hash, MIDX_EXT_BITMAP);
      
    - 	trace2_region_enter("midx", "write_midx_bitmap", the_repository);
    - 
    -@@ midx-write.c: static int write_midx_bitmap(const char *midx_name,
    + 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
    + 		options |= BITMAP_OPT_HASH_CACHE;
    +@@ midx-write.c: static int write_midx_bitmap(struct repository *r, const char *midx_name,
      	for (i = 0; i < pdata->nr_objects; i++)
      		index[i] = &pdata->objects[i].idx;
      
    --	bitmap_writer_init(&writer, the_repository, pdata);
    -+	bitmap_writer_init(&writer, the_repository, pdata,
    +-	bitmap_writer_init(&writer, r, pdata);
    ++	bitmap_writer_init(&writer, ctx->repo, pdata,
     +			   ctx->incremental ? ctx->base_midx : NULL);
      	bitmap_writer_show_progress(&writer, flags & MIDX_PROGRESS);
      	bitmap_writer_build_type_index(&writer, index);
      
    -@@ midx-write.c: static int write_midx_bitmap(const char *midx_name,
    +@@ midx-write.c: static int write_midx_bitmap(struct repository *r, const char *midx_name,
      	 * bitmap_writer_finish().
      	 */
      	for (i = 0; i < pdata->nr_objects; i++)
    @@ midx-write.c: static int write_midx_bitmap(const char *midx_name,
      
      	bitmap_writer_select_commits(&writer, commits, commits_nr);
      	ret = bitmap_writer_build(&writer);
    -@@ midx-write.c: static int write_midx_bitmap(const char *midx_name,
    +@@ midx-write.c: static int write_midx_bitmap(struct repository *r, const char *midx_name,
      		goto cleanup;
      
      	bitmap_writer_set_checksum(&writer, midx_hash);
    @@ midx-write.c: static int write_midx_bitmap(const char *midx_name,
     +	strbuf_release(&bitmap_name);
      	bitmap_writer_free(&writer);
      
    - 	trace2_region_leave("midx", "write_midx_bitmap", the_repository);
    -@@ midx-write.c: static int write_midx_internal(const char *object_dir,
    - 	trace2_region_enter("midx", "write_midx_internal", the_repository);
    +-	trace2_region_leave("midx", "write_midx_bitmap", r);
    ++	trace2_region_leave("midx", "write_midx_bitmap", ctx->repo);
    + 
    + 	return ret;
    + }
    +@@ midx-write.c: static int write_midx_internal(struct repository *r, const char *object_dir,
    + 	ctx.repo = r;
      
      	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
     -	if (ctx.incremental && (flags & MIDX_WRITE_BITMAP))
    @@ midx-write.c: static int write_midx_internal(const char *object_dir,
      
      	if (ctx.incremental)
      		strbuf_addf(&midx_name,
    -@@ midx-write.c: static int write_midx_internal(const char *object_dir,
    +@@ midx-write.c: static int write_midx_internal(struct repository *r, const char *object_dir,
      	if (ctx.incremental) {
      		struct multi_pack_index *m = ctx.base_midx;
      		while (m) {
     +			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
     +				error(_("could not load reverse index for MIDX %s"),
    -+				      hash_to_hex(get_midx_checksum(m)));
    ++				      hash_to_hex_algop(get_midx_checksum(m),
    ++							m->repo->hash_algo));
     +				result = 1;
     +				goto cleanup;
     +			}
      			ctx.num_multi_pack_indexes_before++;
      			m = m->base_midx;
      		}
    -@@ midx-write.c: static int write_midx_internal(const char *object_dir,
    +@@ midx-write.c: static int write_midx_internal(struct repository *r, const char *object_dir,
      
      	if (flags & MIDX_WRITE_REV_INDEX &&
      	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
    @@ midx-write.c: static int write_midx_internal(const char *object_dir,
      
      	if (flags & MIDX_WRITE_BITMAP) {
      		struct packing_data pdata;
    -@@ midx-write.c: static int write_midx_internal(const char *object_dir,
    +@@ midx-write.c: static int write_midx_internal(struct repository *r, const char *object_dir,
      		FREE_AND_NULL(ctx.entries);
      		ctx.entries_nr = 0;
      
    --		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
    +-		if (write_midx_bitmap(r, midx_name.buf, midx_hash, &pdata,
     -				      commits, commits_nr, ctx.pack_order,
     +		if (write_midx_bitmap(&ctx, object_dir,
     +				      midx_hash, &pdata, commits, commits_nr,
    @@ pack-bitmap-write.c: void bitmap_writer_finish(struct bitmap_writer *writer,
      
      	write_selected_commits_v1(writer, f, offsets);
     
    + ## pack-bitmap.c ##
    +@@ pack-bitmap.c: static void show_objects_for_type(
    + 		}
    + 	}
    + 
    +-	ewah_or_iterator_free(&it);
    ++	ewah_or_iterator_release(&it);
    + }
    + 
    + static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
    +@@ pack-bitmap.c: static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
    + 			bitmap_unset(to_filter, pos);
    + 	}
    + 
    +-	ewah_or_iterator_free(&it);
    ++	ewah_or_iterator_release(&it);
    + 	bitmap_free(tips);
    + }
    + 
    +@@ pack-bitmap.c: static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
    + 			bitmap_unset(to_filter, pos);
    + 	}
    + 
    +-	ewah_or_iterator_free(&it);
    ++	ewah_or_iterator_release(&it);
    + 	bitmap_free(tips);
    + }
    + 
    +@@ pack-bitmap.c: static uint32_t count_object_type(struct bitmap_index *bitmap_git,
    + 			count++;
    + 	}
    + 
    +-	ewah_or_iterator_free(&it);
    ++	ewah_or_iterator_release(&it);
    + 
    + 	return count;
    + }
    +@@ pack-bitmap.c: static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
    + 		}
    + 	}
    + 
    +-	ewah_or_iterator_free(&it);
    ++	ewah_or_iterator_release(&it);
    + 
    + 	return total;
    + }
    +
      ## pack-bitmap.h ##
     @@ pack-bitmap.h: struct bitmap_writer {
      

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0.13.gd0d564685b
