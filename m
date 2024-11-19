Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED0199FDD
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054042; cv=none; b=VtOwQOWLzzzY6CoAlfgdAsQ7tORpU/H1SqxYVY94VA7nHSwX73rjggSOw5SobUT+MhBfr0g8gIFVSjCIKjrCvT1qo01oFMt0xE971uY5v5Ve4PhV+e0SA0pHURZVwnV4Hm8a8USCpBYqJSfqN2ZjNCvkO5g2smVyDy+OKu1hY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054042; c=relaxed/simple;
	bh=bLhqkyUqgjh4JqzjWn/YqQevwSnFXj/7+lYRRN0XOFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuB31CPPThsTS6Gzje6A7EA4Sc9rJlZSbzqae8a6MbJimL+ypu02MCLwU2pfO1eVjE/CMSOdL4sTXQPCbgOU1x59pCa184i9ZF7n/sbqslWHAeiV8UzWh6f/6YjJOf7L9D/lMwFFSAKDaYUXQLxuGvM9PmzfA75IHqrAeO+Lttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kvnLwXWo; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kvnLwXWo"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso1514042276.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054038; x=1732658838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Q3HhsCXu+FPClVUemP+wLS1S40lA2VqXNM653vF6WA=;
        b=kvnLwXWoUGR+LzC7uOtA95r8l20MQs3yZaPFPDNHd7f4V8xVM7T2wgndsu2Whci2sv
         WyW4hD7qMXpEQFc1yGxYS9lCJYxffXNE72gWr3d7Pp8CisesRyntW7r4L0Ugf3wV93Ye
         e6ADL7AAVAMLWD1aQgxng+QFIr727ZSkGLk1kHLdNdxtpQaasVRLhXOAtMhpjs3H6HVA
         cMhVuQAHq6Vy7i0SVi1pIWod8rjWnNnbLM8XGY+qQyLNi4RniPSF2nUtvOzPCoNnHmjm
         qk87m5dfszUtK4h/pQLt7+MWAGvgJg8vinTiLnejITTTXD+/sf74BUK9Iuj4LJMatDPu
         1RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054038; x=1732658838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q3HhsCXu+FPClVUemP+wLS1S40lA2VqXNM653vF6WA=;
        b=I2zL+y39TZsVJpLiNjBO6pYHl5SRbH+cDW0mPDnBkv4eKA8Wvs0zUN3RZ3zWLOo+Xe
         oxbQLGcEWmyBJoeTucsmXt+Y/wTqKnPsPROd7OpBsXUTJRJoa3i8sJuqh9wFFBuqWWE0
         9jIAiR1ODCsgjFKsTl6p0rMj1sjEAj+S3pDJTKwciqE2plmGHTLLBy58+HOEfuag1xmR
         h/T/IT3zXhujMCDaDZpMU3D0FylfKYvz9kmiJgT+bFeGKaO+7yx0dcUmw9tpVFmKq+zn
         adnbAez9ubLx/kWyCyLdBkqpshGbbLDpn2YqKrKMg/7HmNPHhqMOYhVOhWdLD8UJKZEa
         19tw==
X-Gm-Message-State: AOJu0YyggZLfpZYe9CvFBQZ8rbfLf4YonJM9brMDjxV8e3NqiYwRzc7+
	xzBj0HXpRS8joU1Kxkb2FcWINhV/t4vwVxEbU0Q22sPV0B8MAPZlExpNQbeOw0XohiQnsy/kkKe
	5zO0=
X-Google-Smtp-Source: AGHT+IF+f5dKD19j/l29RM8MpBF8to9CFvDWbVL3bidRrTHmkJL3/YUD5HBgMKxGYRrG9cDTPfUVuQ==
X-Received: by 2002:a05:6902:1b88:b0:e29:2466:c813 with SMTP id 3f1490d57ef6-e38cb56ef60mr381953276.19.1732054038038;
        Tue, 19 Nov 2024 14:07:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e7e7718sm2716056276.40.2024.11.19.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:17 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:16 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/13] midx: incremental multi-pack indexes, part two
Message-ID: <cover.1732054032.git.me@ttaylorr.com>
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

== Changes since last time

This round fixes a small issue when writing legacy ".rev" files outside
of the MIDX in '--incremental' mode.

The rest of the series is unchanged, and re-submitted to solicit review
now that I have more time to focus on this series.

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

 Documentation/technical/multi-pack-index.txt |  64 ++++
 builtin/pack-objects.c                       |   3 +-
 ewah/ewah_bitmap.c                           |  33 ++
 ewah/ewok.h                                  |  12 +
 midx-write.c                                 |  49 ++-
 pack-bitmap-write.c                          |  65 +++-
 pack-bitmap.c                                | 329 +++++++++++++++----
 pack-bitmap.h                                |   4 +-
 pack-revindex.c                              |  32 +-
 t/t5334-incremental-multi-pack-index.sh      |  84 +++++
 10 files changed, 559 insertions(+), 116 deletions(-)

Range-diff against v2:
 1:  90b21b11ed7 <  -:  ----------- Documentation: describe incremental MIDX format
 2:  0d3b19c59ff <  -:  ----------- midx: add new fields for incremental MIDX chains
 3:  5cd742b6776 <  -:  ----------- midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
 4:  372104c73de <  -:  ----------- midx: teach `prepare_midx_pack()` about incremental MIDXs
 5:  e68a3ceff9a <  -:  ----------- midx: teach `nth_midxed_object_oid()` about incremental MIDXs
 6:  ff2d7bc5ca0 <  -:  ----------- midx: teach `nth_bitmapped_pack()` about incremental MIDXs
 7:  32c3fceada7 <  -:  ----------- midx: introduce `bsearch_one_midx()`
 8:  16db6c98cec <  -:  ----------- midx: teach `bsearch_midx()` about incremental MIDXs
 9:  761c7c59ba1 <  -:  ----------- midx: teach `nth_midxed_offset()` about incremental MIDXs
10:  8366456d29b <  -:  ----------- midx: teach `fill_midx_entry()` about incremental MIDXs
11:  909d927c470 <  -:  ----------- midx: remove unused `midx_locate_pack()`
12:  71127601b5d <  -:  ----------- midx: teach `midx_contains_pack()` about incremental MIDXs
13:  2f98ebb141e <  -:  ----------- midx: teach `midx_preferred_pack()` about incremental MIDXs
14:  550ae2dc933 <  -:  ----------- midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
15:  9ae1bc415e9 <  -:  ----------- midx: support reading incremental MIDX chains
16:  3d4181df518 <  -:  ----------- midx: implement verification support for incremental MIDXs
17:  3b268f91bf3 <  -:  ----------- t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
18:  09d74f89423 <  -:  ----------- t/t5313-pack-bounds-checks.sh: prepare for sub-directories
19:  5d467d38a8d <  -:  ----------- midx: implement support for writing incremental MIDX chains
20:  9d322fc5399 <  -:  ----------- pack-bitmap: initialize `bitmap_writer_init()` with packing_data
21:  238ca46998e <  -:  ----------- pack-bitmap: drop redundant args from `bitmap_writer_build_type_index()`
22:  5e198489fa8 <  -:  ----------- pack-bitmap: drop redundant args from `bitmap_writer_build()`
23:  819a0765f38 <  -:  ----------- pack-bitmap: drop redundant args from `bitmap_writer_finish()`
24:  0fea7803d86 <  -:  ----------- pack-bitmap-write.c: select pseudo-merges even for small bitmaps
25:  228553e412f <  -:  ----------- t/t5333-pseudo-merge-bitmaps.sh: demonstrate empty pseudo-merge groups
26:  c7e0ee07120 <  -:  ----------- pseudo-merge.c: do not generate empty pseudo-merge commits
27:  c9a64b1d2a9 <  -:  ----------- pseudo-merge.c: ensure pseudo-merge groups are closed
28:  d1b8d11b37f =  1:  caed2c6ec34 Documentation: describe incremental MIDX bitmaps
29:  f5d0866e5cb =  2:  b902513f436 pack-revindex: prepare for incremental MIDX bitmaps
30:  43444efc214 !  3:  5b5d625cbe0 pack-bitmap.c: open and store incremental bitmap layers
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_git(struct repository *r)
      		return bitmap_git;
      
      	free_bitmap_index(bitmap_git);
    +@@ pack-bitmap.c: void free_bitmap_index(struct bitmap_index *b)
    + 		close_midx_revindex(b->midx);
    + 	}
    + 	free_pseudo_merge_map(&b->pseudo_merges);
    ++	free_bitmap_index(b->base);
    + 	free(b);
    + }
    + 
31:  44871306487 =  4:  16259667fb4 pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
32:  b720fe56da8 =  5:  b7a45d7eff8 pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
33:  9716d022e0b =  6:  c8401fa0fbd pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
34:  6baece31750 =  7:  17ab23dd76d pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
35:  5c909df38ad =  8:  75d170ce078 pack-bitmap.c: compute disk-usage with incremental MIDXs
36:  f9ae10fce90 =  9:  0b4fcfcecb6 pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
37:  04042981c1a = 10:  e1b5f6181e3 ewah: implement `struct ewah_or_iterator`
38:  c4d543d43dc = 11:  9ab8fb472f4 pack-bitmap.c: keep track of each layer's type bitmaps
39:  c6730b4107e = 12:  87cb011e7fc pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
40:  afefb455575 ! 13:  77ddd1170f9 midx: implement writing incremental MIDX bitmaps
    @@ builtin/pack-objects.c: static void write_pack_file(void)
      							       written_list);
     
      ## midx-write.c ##
    +@@ midx-write.c: static uint32_t *midx_pack_order(struct write_midx_context *ctx)
    + 	return pack_order;
    + }
    + 
    +-static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
    +-				     struct write_midx_context *ctx)
    ++static void write_midx_reverse_index(struct write_midx_context *ctx,
    ++				     const char *object_dir,
    ++				     unsigned char *midx_hash)
    + {
    + 	struct strbuf buf = STRBUF_INIT;
    + 	char *tmp_file;
    + 
    + 	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
    + 
    +-	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
    ++	if (ctx->incremental)
    ++		get_split_midx_filename_ext(&buf, object_dir, midx_hash,
    ++					    MIDX_EXT_REV);
    ++	else
    ++		get_midx_filename_ext(&buf, object_dir, midx_hash,
    ++				      MIDX_EXT_REV);
    + 
    + 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
    + 					midx_hash, WRITE_REV);
     @@ midx-write.c: static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
      	return cb.commits;
      }
      
     -static int write_midx_bitmap(const char *midx_name,
     +static int write_midx_bitmap(struct write_midx_context *ctx,
    -+			     const char *object_dir, const char *midx_name,
    ++			     const char *object_dir,
      			     const unsigned char *midx_hash,
      			     struct packing_data *pdata,
      			     struct commit **commits,
    @@ midx-write.c: static int write_midx_internal(const char *object_dir,
      			m = m->base_midx;
      		}
     @@ midx-write.c: static int write_midx_internal(const char *object_dir,
    + 
    + 	if (flags & MIDX_WRITE_REV_INDEX &&
    + 	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
    +-		write_midx_reverse_index(midx_name.buf, midx_hash, &ctx);
    ++		write_midx_reverse_index(&ctx, object_dir, midx_hash);
    + 
    + 	if (flags & MIDX_WRITE_BITMAP) {
    + 		struct packing_data pdata;
    +@@ midx-write.c: static int write_midx_internal(const char *object_dir,
      		FREE_AND_NULL(ctx.entries);
      		ctx.entries_nr = 0;
      
     -		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
     -				      commits, commits_nr, ctx.pack_order,
    -+		if (write_midx_bitmap(&ctx, object_dir, midx_name.buf,
    ++		if (write_midx_bitmap(&ctx, object_dir,
     +				      midx_hash, &pdata, commits, commits_nr,
      				      flags) < 0) {
      			error(_("could not write multi-pack bitmap"));

base-commit: 090d24e9af6e9f59c3f7bee97c42bb1ae3c7f559
-- 
2.47.0.301.g77ddd1170f9
