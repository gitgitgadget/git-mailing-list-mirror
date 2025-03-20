Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC4225403
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493387; cv=none; b=R8/0FSC/FCVnyKJ8qLYvFVj5QID3imxgwDI6u/QRYqO0pEpN24Khejb8zO9wlyzAQWMzG8v35ErXXjQhz9707on4jaBm3wNnNYuHETxYLh1qNLQPukgMdCbFdQPMNrT3WJ7xcHK+KVgdJchiAePiz0EG3ho+SgagT/TP44klYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493387; c=relaxed/simple;
	bh=DaiR7qLpw9erMKzZn9zZfITXh6BtbJKVwKTGlqs0qZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkdnTaCe4OqvFOBVdR7D69oktKFzG7CYKMCmpCRl/2UhcckG078+7iQnJnJxDh8+qKorp0yeyPjD9IW9rrG+KpoKvdGBzNIBbr403wQc7PRYfrebOaBo+y31uiFnwkUpRmezaBWOFuZyI5fjIXqnsWLtEfsMVYYflO7pGzCnIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WosrqUEH; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WosrqUEH"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so8801246d6.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493383; x=1743098183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0+JNJmsMf7NpUL57LK8DMA8mc/V/z25OMrH5vwCJA4=;
        b=WosrqUEH4MNrAjfC4e+Fm1S7y/snjuEwx9tNgxBdprF1vh/eG9LN7mJzhg0pZKTyo/
         RtFJd/xzYa0ACBSvrUrkWSpmWnoFluacVIsCfEHIftloC007+vla2s9P9sYKfzopQVVX
         O+p9ieiX2TL93sR6ISUZxaCZYESfsg2uVuv1cvSPbj00ihjDpSpJmg57as1B/1g1IcAQ
         VXzJHoWfEH7PZJOL5L2tAFjltIaV4+hNY+C6XPRGybfzvHVSHM3a0iy9jScXYUiAtLJR
         KHv7GVsNUumpvTz4XLA3h7BW+YA/+8otbL7u07Md4hOV2M5DiMj5Lz8aJtV/tOm6QfAY
         BBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493383; x=1743098183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0+JNJmsMf7NpUL57LK8DMA8mc/V/z25OMrH5vwCJA4=;
        b=UitarAlp44C8lUkZVMIrXAyVETKMRCOmWpWhwKkhdSM6fUcnbZYKdGZgY3XaF6cc1m
         Zdd6UonNb932o/KLIbUFEdOZc9dM5grcr70D6R6uZ27Jm6x8e6U4AdT4mZCErruHVAR7
         zBAHYgYPSMenxdL8MMLzXrFwp/YcZ+1xrxkYa3OJZP6yypT75xf0pYOSN87XvfrKSZKR
         jrK6LM64pB3ijSAWzHbPZ0WIXDZj/Dpme45S5/LhLkDWH2jPFBr7896TvV+v4S6qPTY7
         a0Sbb6taF5rPBj0LlZmvjHEX5decjuguUNVtcd4d4glhB14UnAKF0ZqeZnClqcJD4kl9
         nX5Q==
X-Gm-Message-State: AOJu0Yyzr48BJIkfJ8P1fDMa4ZmG8Ab6NWaRGU69ajmvz8PkRlcclsDa
	/lw4CgUljqAWc8KCDbtE8kUP5HbiZ+4liTxuZdCEs8IseYgs0lOmw7AE8amZjFqLd+TWcez6rNo
	tyvA=
X-Gm-Gg: ASbGncuqUJGGqsKRYNbBo0WdjeInzzijF5Xkk2+OslJkzSC7pMOkbsZA4p+YJxTrHgu
	MORX8XtAVa/O7bBu+y4Gcp9gNe5DzSWu1kCfAFxbyeCVbZBpGHu9QLCgWeKg3AADtkxV9x3Y6lA
	QT/pyaoSZNFFBs+oxadgvn93BVgr7gn62+yC7sY506NkjvhQn4jG0ClSGjEQHrRSAQfOAvA4q7G
	srx8M3CkZTGSw4eL9JDTdzAaVdO0iOX0oywgCjzGcQBBLWo3sLGfFmZqK1jIK4mNhdkDKZb5iXj
	LJsEdZWcvzmV7uha5T5FIxYdspFHzKfZuM424b028FZnmN+rvWwRKVC49PVA/4S9YuKbjLW1ubs
	ZWMmHLREgF3MZu+hv
X-Google-Smtp-Source: AGHT+IGCz9KoHUisH1CWO5Q63TeST1EYRZmKqWvFSY88dil8k7lpbiYXFaW9jAdvxDWvMKsGYs8RXw==
X-Received: by 2002:a05:6214:224c:b0:6e8:ffb6:2f8e with SMTP id 6a1803df08f44-6eb3f332a55mr5503486d6.32.1742493383319;
        Thu, 20 Mar 2025 10:56:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef22c26sm1124816d6.47.2025.03.20.10.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:22 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/14] midx: incremental multi-pack indexes, part two
Message-ID: <cover.1742493373.git.me@ttaylorr.com>
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

This is another new round of my series to implement bitmap support for
incremental multi-pack indexes (MIDXs). It is still based on 683c54c999
(Git 2.49, 2025-03-14).

== Changes since last time

This round addresses thorough review from Elijah and Peff. The series
substantively is unchanged, but there are lots of little quality-of-life
and commit message readability improvements throughout. As usual, there
is a range-diff below for convenience.

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

Taylor Blau (14):
  Documentation: remove a "future work" item from the MIDX docs
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

 Documentation/technical/multi-pack-index.adoc |  82 ++++-
 builtin/pack-objects.c                        |   3 +-
 ewah/ewah_bitmap.c                            |  33 ++
 ewah/ewok.h                                   |  12 +
 midx-write.c                                  |  57 ++-
 pack-bitmap-write.c                           |  65 +++-
 pack-bitmap.c                                 | 344 ++++++++++++++----
 pack-bitmap.h                                 |   4 +-
 pack-revindex.c                               |  34 +-
 t/t5334-incremental-multi-pack-index.sh       |  87 +++++
 10 files changed, 589 insertions(+), 132 deletions(-)

Range-diff against v4:
 -:  ---------- >  1:  6af65fdaac Documentation: remove a "future work" item from the MIDX docs
 1:  f565f2fff1 !  2:  0897359506 Documentation: describe incremental MIDX bitmaps
    @@ Documentation/technical/multi-pack-index.adoc: objects_nr($H2) + objects_nr($H1)
     +`o1` and `o2` are compared as follows:
     +
     +1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
    -+  `o1` is considered less than `o2`.
    ++  `o1` sorts ahead of `o2`.
     +
     +2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
     +   MIDX layer has no base, then if one of `pack(o1)` and `pack(o2)` is
    -+   preferred and the other is not, then the preferred one sorts first. If
    -+   there is a base layer (i.e. the MIDX layer is not the first layer in
    -+   the chain), then if `pack(o1)` appears earlier in that MIDX layer's
    -+   pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
    -+   appears earlier, than the opposite is true.
    ++   preferred and the other is not, then the preferred one sorts ahead of
    ++   the non-preferred one. If there is a base layer (i.e. the MIDX layer
    ++   is not the first layer in the chain), then if `pack(o1)` appears
    ++   earlier in that MIDX layer's pack order, then `o1` sorts ahead of
    ++   `o2`. Likewise if `pack(o2)` appears earlier, then the opposite is
    ++   true.
     +
     +3. Otherwise, `o1` and `o2` appear in the same pack, and thus in the
     +   same MIDX layer. Sort `o1` and `o2` by their offset within their
    @@ Documentation/technical/multi-pack-index.adoc: objects_nr($H2) + objects_nr($H1)
     +The structure of a `*.bitmap` file belonging to an incremental MIDX
     +chain is identical to that of a non-incremental MIDX bitmap, or a
     +classic single-pack bitmap. Since objects are added to the end of the
    -+incremental MIDX's pseudo-pack order (see: above), it is possible to
    ++incremental MIDX's pseudo-pack order (see above), it is possible to
     +extend a bitmap when appending to the end of a MIDX chain.
     +
     +(Note: it is possible likewise to compress a contiguous sequence of MIDX
    -+incremental layers, and their `*.bitmap`(s) into a single layer and
    ++incremental layers, and their `*.bitmap` files into a single layer and
     +`*.bitmap`, but this is not yet implemented.)
     +
     +The object positions used are global within the pseudo-pack order, so
 2:  f2a232e556 !  3:  5eac0d1485 pack-revindex: prepare for incremental MIDX bitmaps
    @@ Commit message
             incremental or not.
     
           - pack_pos_to_midx() and midx_to_pack_pos() now both take in a global
    -        object position in the MIDX pseudo-pack order, and finds the
    +        object position in the MIDX pseudo-pack order, and find the
             earliest containing MIDX (similar to midx.c::midx_for_object().
     
           - midx_pack_order_cmp() adjusts its call to pack_pos_to_midx() by the
    @@ pack-bitmap.c: static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *ind
      	return read_bitmap(index->map, index->map_size, &index->map_pos);
      }
      
    -+static uint32_t bitmap_non_extended_bits(struct bitmap_index *index)
    ++static uint32_t bitmap_num_objects_total(struct bitmap_index *index)
     +{
     +	if (index->midx) {
     +		struct multi_pack_index *m = index->midx;
    @@ pack-bitmap.c: static inline int bitmap_position_extended(struct bitmap_index *b
      	if (pos < kh_end(positions)) {
      		int bitmap_pos = kh_value(positions, pos);
     -		return bitmap_pos + bitmap_num_objects(bitmap_git);
    -+		return bitmap_pos + bitmap_non_extended_bits(bitmap_git);
    ++		return bitmap_pos + bitmap_num_objects_total(bitmap_git);
      	}
      
      	return -1;
    @@ pack-bitmap.c: static int ext_index_add_object(struct bitmap_index *bitmap_git,
      	}
      
     -	return bitmap_pos + bitmap_num_objects(bitmap_git);
    -+	return bitmap_pos + bitmap_non_extended_bits(bitmap_git);
    ++	return bitmap_pos + bitmap_num_objects_total(bitmap_git);
      }
      
      struct bitmap_show_data {
    @@ pack-bitmap.c: static void show_extended_objects(struct bitmap_index *bitmap_git
      
     -		if (!bitmap_get(objects, st_add(bitmap_num_objects(bitmap_git), i)))
     +		if (!bitmap_get(objects,
    -+				st_add(bitmap_non_extended_bits(bitmap_git), i)))
    ++				st_add(bitmap_num_objects_total(bitmap_git),
    ++				       i)))
      			continue;
      
      		obj = eindex->objects[i];
    @@ pack-bitmap.c: static void filter_bitmap_exclude_type(struct bitmap_index *bitma
      	 */
      	for (i = 0; i < eindex->count; i++) {
     -		size_t pos = st_add(i, bitmap_num_objects(bitmap_git));
    -+		size_t pos = st_add(i, bitmap_non_extended_bits(bitmap_git));
    ++		size_t pos = st_add(i, bitmap_num_objects_total(bitmap_git));
      		if (eindex->objects[i]->type == type &&
      		    bitmap_get(to_filter, pos) &&
      		    !bitmap_get(tips, pos))
    @@ pack-bitmap.c: static unsigned long get_size_by_pos(struct bitmap_index *bitmap_
      	oi.sizep = &size;
      
     -	if (pos < bitmap_num_objects(bitmap_git)) {
    -+	if (pos < bitmap_non_extended_bits(bitmap_git)) {
    ++	if (pos < bitmap_num_objects_total(bitmap_git)) {
      		struct packed_git *pack;
      		off_t ofs;
      
     @@ pack-bitmap.c: static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
    + 			die(_("unable to get size of %s"), oid_to_hex(&oid));
      		}
      	} else {
    ++		size_t eindex_pos = pos - bitmap_num_objects_total(bitmap_git);
      		struct eindex *eindex = &bitmap_git->ext_index;
     -		struct object *obj = eindex->objects[pos - bitmap_num_objects(bitmap_git)];
    -+		struct object *obj = eindex->objects[pos - bitmap_non_extended_bits(bitmap_git)];
    ++		struct object *obj = eindex->objects[eindex_pos];
      		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
      					     &oi, 0) < 0)
      			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
    @@ pack-bitmap.c: static void filter_packed_objects_from_bitmap(struct bitmap_index
      	size_t i, pos;
      
     -	objects_nr = bitmap_num_objects(bitmap_git);
    -+	objects_nr = bitmap_non_extended_bits(bitmap_git);
    ++	objects_nr = bitmap_num_objects_total(bitmap_git);
      	pos = objects_nr / BITS_IN_EWORD;
      
      	if (pos > result->word_alloc)
    @@ pack-bitmap.c: static uint32_t count_object_type(struct bitmap_index *bitmap_git
      		if (eindex->objects[i]->type == type &&
      		    bitmap_get(objects,
     -			       st_add(bitmap_num_objects(bitmap_git), i)))
    -+			       st_add(bitmap_non_extended_bits(bitmap_git), i)))
    ++			       st_add(bitmap_num_objects_total(bitmap_git), i)))
      			count++;
      	}
      
    @@ pack-bitmap.c: uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
      		    "extension");
      
     -	num_objects = bitmap_num_objects(bitmap_git);
    -+	num_objects = bitmap_non_extended_bits(bitmap_git);
    ++	num_objects = bitmap_num_objects_total(bitmap_git);
      	CALLOC_ARRAY(reposition, num_objects);
      
      	for (i = 0; i < num_objects; ++i) {
    @@ pack-bitmap.c: static off_t get_disk_usage_for_extended(struct bitmap_index *bit
      
      		if (!bitmap_get(result,
     -				st_add(bitmap_num_objects(bitmap_git), i)))
    -+				st_add(bitmap_non_extended_bits(bitmap_git), i)))
    ++				st_add(bitmap_num_objects_total(bitmap_git),
    ++				       i)))
      			continue;
      
      		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
 3:  aca0318fb1 !  4:  922ea2f607 pack-bitmap.c: open and store incremental bitmap layers
    @@ Commit message
         with the previous MIDX layer.
     
         The changes in this commit are mostly boilerplate to open the correct
    -    bitmap(s), add them to the chain bitmap layers along the "base" pointer,
    -    ensures that the correct packs and their reverse indexes are loaded
    -    across MIDX layers, etc.
    +    bitmap(s), add them to the chain of bitmap layers along the "base"
    +    pointer, ensure that the correct packs and their reverse indexes are
    +    loaded across MIDX layers, etc.
     
         While we're at it, keep track of a base_nr field to indicate how many
         bitmap layers (including the current bitmap) exist. This will be used in
 4:  832fd0e8dc =  5:  8fedd96614 pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 5:  c7c9f89956 =  6:  dccc1b2d2e pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
 6:  14d3d80c3d !  7:  e31bddd240 pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
    @@ Commit message
     
         Likewise, in reuse_partial_packfile_from_bitmap(), when reusing only a
         single pack from a MIDX, use the oldest layer's preferred pack as it is
    -    likely to contain the most amount of reusable sections.
    +    likely to contain the largest number of reusable sections.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
 7:  b45a9ccbc2 !  8:  d9dfcb5a1b pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
    @@ pack-bitmap.c: static void test_show_commit(struct commit *commit, void *data)
     +	tdata->tags = ewah_to_bitmap(bitmap_git->tags);
     +
     +	if (bitmap_git->base) {
    -+		CALLOC_ARRAY(tdata->base_tdata, 1);
    ++		tdata->base_tdata = xmalloc(sizeof(struct bitmap_test_data));
     +		bitmap_test_data_prepare(tdata->base_tdata, bitmap_git->base);
     +	}
     +}
 8:  c1eefeae99 =  9:  b1bd60d25d pack-bitmap.c: compute disk-usage with incremental MIDXs
 9:  11c4b7b949 = 10:  7477a8ac03 pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
10:  cb08ad6a62 ! 11:  0fbef17acc ewah: implement `struct ewah_or_iterator`
    @@ ewah/ewah_bitmap.c: void ewah_iterator_init(struct ewah_iterator *it, struct ewa
     +	return ret;
     +}
     +
    -+void ewah_or_iterator_free(struct ewah_or_iterator *it)
    ++void ewah_or_iterator_release(struct ewah_or_iterator *it)
     +{
     +	free(it->its);
     +}
    @@ ewah/ewok.h: void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitma
     +
     +int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it);
     +
    -+void ewah_or_iterator_free(struct ewah_or_iterator *it);
    ++void ewah_or_iterator_release(struct ewah_or_iterator *it);
     +
      void ewah_xor(
      	struct ewah_bitmap *ewah_i,
11:  a29f4ee60d ! 12:  439e743fd5 pack-bitmap.c: keep track of each layer's type bitmaps
    @@ pack-bitmap.c: struct bitmap_index {
     +	 * commits_all[n-2] is the commits field of this bitmap's
     +	 * 'base', and so on.
     +	 *
    -+	 * When either associated either with a non-incremental MIDX, or
    -+	 * a single packfile, these arrays each contain a single
    -+	 * element.
    ++	 * When associated either with a non-incremental MIDX or a
    ++	 * single packfile, these arrays each contain a single element.
     +	 */
     +	struct ewah_bitmap **commits_all;
     +	struct ewah_bitmap **trees_all;
12:  a1cf65bedc ! 13:  dcb45e349e pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
    @@ pack-bitmap.c: static void show_objects_for_type(
      		}
      	}
     +
    -+	ewah_or_iterator_free(&it);
    ++	ewah_or_iterator_release(&it);
      }
      
      static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
    @@ pack-bitmap.c: static void filter_bitmap_exclude_type(struct bitmap_index *bitma
      			bitmap_unset(to_filter, pos);
      	}
      
    -+	ewah_or_iterator_free(&it);
    ++	ewah_or_iterator_release(&it);
      	bitmap_free(tips);
      }
      
    @@ pack-bitmap.c: static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_
      			bitmap_unset(to_filter, pos);
      	}
      
    -+	ewah_or_iterator_free(&it);
    ++	ewah_or_iterator_release(&it);
      	bitmap_free(tips);
      }
      
    @@ pack-bitmap.c: static uint32_t count_object_type(struct bitmap_index *bitmap_git
      			count++;
      	}
      
    -+	ewah_or_iterator_free(&it);
    ++	ewah_or_iterator_release(&it);
     +
      	return count;
      }
    @@ pack-bitmap.c: static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_
      		}
      	}
      
    -+	ewah_or_iterator_free(&it);
    ++	ewah_or_iterator_release(&it);
     +
      	return total;
      }
13:  d0d564685b ! 14:  13568cfa3b midx: implement writing incremental MIDX bitmaps
    @@ builtin/pack-objects.c: static void write_pack_file(void)
      				bitmap_writer_build_type_index(&bitmap_writer,
      							       written_list);
     
    - ## ewah/ewah_bitmap.c ##
    -@@ ewah/ewah_bitmap.c: int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it)
    - 	return ret;
    - }
    - 
    --void ewah_or_iterator_free(struct ewah_or_iterator *it)
    -+void ewah_or_iterator_release(struct ewah_or_iterator *it)
    - {
    - 	free(it->its);
    - }
    -
    - ## ewah/ewok.h ##
    -@@ ewah/ewok.h: void ewah_or_iterator_init(struct ewah_or_iterator *it,
    - 
    - int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it);
    - 
    --void ewah_or_iterator_free(struct ewah_or_iterator *it);
    -+void ewah_or_iterator_release(struct ewah_or_iterator *it);
    - 
    - void ewah_xor(
    - 	struct ewah_bitmap *ewah_i,
    -
      ## midx-write.c ##
     @@ midx-write.c: static uint32_t *midx_pack_order(struct write_midx_context *ctx)
      	return pack_order;
    @@ pack-bitmap-write.c: void bitmap_writer_finish(struct bitmap_writer *writer,
      
      	write_selected_commits_v1(writer, f, offsets);
     
    - ## pack-bitmap.c ##
    -@@ pack-bitmap.c: static void show_objects_for_type(
    - 		}
    - 	}
    - 
    --	ewah_or_iterator_free(&it);
    -+	ewah_or_iterator_release(&it);
    - }
    - 
    - static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
    -@@ pack-bitmap.c: static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
    - 			bitmap_unset(to_filter, pos);
    - 	}
    - 
    --	ewah_or_iterator_free(&it);
    -+	ewah_or_iterator_release(&it);
    - 	bitmap_free(tips);
    - }
    - 
    -@@ pack-bitmap.c: static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
    - 			bitmap_unset(to_filter, pos);
    - 	}
    - 
    --	ewah_or_iterator_free(&it);
    -+	ewah_or_iterator_release(&it);
    - 	bitmap_free(tips);
    - }
    - 
    -@@ pack-bitmap.c: static uint32_t count_object_type(struct bitmap_index *bitmap_git,
    - 			count++;
    - 	}
    - 
    --	ewah_or_iterator_free(&it);
    -+	ewah_or_iterator_release(&it);
    - 
    - 	return count;
    - }
    -@@ pack-bitmap.c: static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
    - 		}
    - 	}
    - 
    --	ewah_or_iterator_free(&it);
    -+	ewah_or_iterator_release(&it);
    - 
    - 	return total;
    - }
    -
      ## pack-bitmap.h ##
     @@ pack-bitmap.h: struct bitmap_writer {
      
    @@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'convert incrementa
     +'
     +
     +test_expect_success 'midx verify with multiple layers' '
    ++	test_path_is_file "$midx_chain" &&
    ++	test_line_count = 2 "$midx_chain" &&
    ++
     +	git multi-pack-index verify
     +'
     +

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0.14.g88b49c1b34
