Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB120DD2
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318111; cv=none; b=I5LHf0KH8qtyCa+V1gEjgv2sdRsJeWKkOU+APTdiIzS0alFoRBuujv77gCgqY0LiCGxltEcLUj6M3D7p6r7Sgm/8p4inXAWI3wTcF5DmW1An2qbAVrMRxZC9hrqmJwI2cf3pgo/TwjoIEvb5k6KarjUrOPPXAhPwvGI3bADozfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318111; c=relaxed/simple;
	bh=mz+vxG3nFMBY9fPhJg2nBCzRems1vikKyknK30Jnzx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdH+jatio1DIZy1Wur/jvHqKvoz2GS0BuNWRNiDr2MOnZr8p2rnpyGUN420DKsxaG5h8QfXhj+f0mYa7p7uxOMYC5RfXXS4uQW49bKESKyltBh4k6eOAQWRxvBH/+x6ErY3Plb9ysksMYPlv9sloxeVEjnPmlgm4C2cJA0LPs68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SJNAexiS; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SJNAexiS"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24542b8607fso2552226fac.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318107; x=1716922907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4Ibs/RmHHCT6zaY7q9i3wmr0xajGLRwiHbVoKgRD0g=;
        b=SJNAexiSrNhKNO6XuZcg6vuP7D0yHkkUP5614EgkN2rIqmzJ4tJ+3mUsK1p6gAWHoV
         6Hlqo+zkyNactmkBx3Lw10DbiALWULBvdcALpvt1G57jGrqC5UwJRBCQwFlIhdPpTsrT
         hdsbltbAORaL+6kah4ictAg6xAGQIltuJL/LrnMPonKt7zUA5Chmkzw4fEL/Vry5X676
         1ThHmGDOY5/GwDd9l45KfRiVTvOiiSOB1YH5XwI3wisJfvdwsKFor57sHUmonZKnKZ9B
         9wzxuuW6Qq2z4wGcuLCuzPAAIa3VXi/DTPsyvtrpbcOFYZUNgXj78HF51uRM0rye2P05
         uTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318107; x=1716922907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4Ibs/RmHHCT6zaY7q9i3wmr0xajGLRwiHbVoKgRD0g=;
        b=T/4DDtbnpZedm9IBfD91UfnEY0v8LtQ5wHC1goOJG6IzHwJ23MXLQNf2QUAV5OlaYi
         Xn8MJ0oRad89V5g/AuzMwYkH6D8v47WcPhFOxIBGCltjA/TebZixjgRi/sgvde0G9ETY
         1TO1jQA2rLcD0kHl+niItNQwHTDvB3MVPTliobe0xpGNczWHUhRzBDm4iwES+YfLUovv
         pqh9sMvSpUSTVmRpCxbaJJXGzSTEbJcBAnnuLeJF7cXJlo55IkfzgL/EhT6+5yvTYU/d
         OIkKdxP32RfUpu9OdWPaojz3pTulEaPBTSrCMfYH87S1n4JnRpBi+lUQ+STW5teqCTIC
         MZJg==
X-Gm-Message-State: AOJu0Yxm98+0GyZfx3bdJulA2D3LCzBzqMikCG7p4iACBdygPDKI8rGa
	ZGDSCvAJMkFbfSYusEk9BflSV+Tqh3Z/9qRujILU2lea7+GIY/yhk75ZScLf79phwhQCu5IkGhe
	6
X-Google-Smtp-Source: AGHT+IFEpXo+f+L3S7ARN2Ojg8tE67zGmj6S7/pvpuq5J7wqL7TdkAO3gasJR90lL5w4xaekJ+lmnQ==
X-Received: by 2002:a05:6870:ac06:b0:24c:5630:b4a3 with SMTP id 586e51a60fabf-24c5630b589mr2441719fac.38.1716318104873;
        Tue, 21 May 2024 12:01:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a8c2d39d7esm34279906d6.95.2024.05.21.12.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:01:43 -0700 (PDT)
Date: Tue, 21 May 2024 15:01:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/30] pack-bitmap: pseudo-merge reachability bitmaps
Message-ID: <cover.1716318088.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Here is another reroll my topic to introduce pseudo-merge bitmaps.

The implementation is relatively unchanged compared to last time, save
for the review that Patrick provided on the first half or so of this
series.

The notable change from last time is a significant reorganization of the
documentation, description, motivation, and examples around what
pseudo-merge bitmaps are why you might want to use them. I took Peff's
suggestion to create a new gitpacking(7) manual page which I hope will
eventually grow to cover many of the more advanced concepts related to
packing objects [^1].

The other change is that this series is now based on
'tb/pack-bitmap-write-cleanups'.

Otherwise, a range-diff is included below for convenience. Thanks in
advance for your review!

[^1]: At present, the new manual page is rather bare :-). I want to
  separate the task of collecting all of the existing documentation
  around advanced packing concepts from pseudo-merge bitmaps and not add
  a new dependency here.

Taylor Blau (30):
  object.h: add flags allocated by pack-bitmap.h
  pack-bitmap-write.c: move commit_positions into commit_pos fields
  pack-bitmap: avoid use of static `bitmap_writer`
  pack-bitmap: drop unused `max_bitmaps` parameter
  pack-bitmap-write.c: avoid uninitialized 'write_as' field
  pack-bitmap: introduce `bitmap_writer_free()`
  Documentation/gitpacking.txt: initial commit
  Documentation/gitpacking.txt: describe pseudo-merge bitmaps
  Documentation/technical: describe pseudo-merge bitmaps format
  ewah: implement `ewah_bitmap_is_subset()`
  pack-bitmap: move some initialization to `bitmap_writer_init()`
  pseudo-merge.ch: initial commit
  pack-bitmap-write: support storing pseudo-merge commits
  pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
  pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
  config: introduce git_config_float()
  pseudo-merge: implement support for selecting pseudo-merge commits
  pack-bitmap-write.c: write pseudo-merge table
  pack-bitmap: extract `read_bitmap()` function
  pseudo-merge: scaffolding for reads
  pack-bitmap.c: read pseudo-merge extension
  pseudo-merge: implement support for reading pseudo-merge commits
  ewah: implement `ewah_bitmap_popcount()`
  pack-bitmap: implement test helpers for pseudo-merge
  t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
  pack-bitmap.c: use pseudo-merges during traversal
  pack-bitmap: extra trace2 information
  ewah: `bitmap_equals_ewah()`
  pseudo-merge: implement support for finding existing merges
  t/perf: implement performace tests for pseudo-merge bitmaps

 Documentation/Makefile                       |   1 +
 Documentation/config.txt                     |   2 +
 Documentation/config/bitmap-pseudo-merge.txt |  90 +++
 Documentation/gitpacking.txt                 | 186 +++++
 Documentation/technical/bitmap-format.txt    | 132 ++++
 Makefile                                     |   1 +
 builtin/pack-objects.c                       |  20 +-
 config.c                                     |   9 +
 config.h                                     |   6 +
 ewah/bitmap.c                                |  76 ++
 ewah/ewok.h                                  |   8 +
 midx-write.c                                 |  17 +-
 object.h                                     |   1 +
 pack-bitmap-write.c                          | 488 ++++++++----
 pack-bitmap.c                                | 359 ++++++++-
 pack-bitmap.h                                |  55 +-
 parse.c                                      |  29 +
 parse.h                                      |   1 +
 pseudo-merge.c                               | 752 +++++++++++++++++++
 pseudo-merge.h                               | 216 ++++++
 t/helper/test-bitmap.c                       |  34 +-
 t/perf/p5333-pseudo-merge-bitmaps.sh         |  32 +
 t/t5333-pseudo-merge-bitmaps.sh              | 387 ++++++++++
 t/test-lib-functions.sh                      |  12 +-
 24 files changed, 2742 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/config/bitmap-pseudo-merge.txt
 create mode 100644 Documentation/gitpacking.txt
 create mode 100644 pseudo-merge.c
 create mode 100644 pseudo-merge.h
 create mode 100755 t/perf/p5333-pseudo-merge-bitmaps.sh
 create mode 100755 t/t5333-pseudo-merge-bitmaps.sh

Range-diff against v2:
 -:  ----------- >  1:  38c96fc1909 object.h: add flags allocated by pack-bitmap.h
 -:  ----------- >  2:  cbedff02ed1 pack-bitmap-write.c: move commit_positions into commit_pos fields
 -:  ----------- >  3:  65ee69acfeb pack-bitmap: avoid use of static `bitmap_writer`
 -:  ----------- >  4:  b38dd5464d5 pack-bitmap: drop unused `max_bitmaps` parameter
 -:  ----------- >  5:  f16175295f5 pack-bitmap-write.c: avoid uninitialized 'write_as' field
 -:  ----------- >  6:  bf65967764f pack-bitmap: introduce `bitmap_writer_free()`
 -:  ----------- >  7:  0f20c9becf4 Documentation/gitpacking.txt: initial commit
 -:  ----------- >  8:  528b591bd84 Documentation/gitpacking.txt: describe pseudo-merge bitmaps
 1:  43fd5e35971 !  9:  12f318b3d7e Documentation/technical: describe pseudo-merge bitmaps format
    @@ Commit message
         format, making it compatible with previous versions of Git, as well as
         the original .bitmap implementation within JGit.
     
    -    The format (as well as a general description of pseudo-merge bitmaps,
    -    and motivating use-case(s)) is described in detail in the patch contents
    -    below, but the high-level description is as follows:
    +    The format is described in detail in the patch contents below, but the
    +    high-level description is as follows:
     
           - An array of pseudo-merge bitmaps, each containing a pair of EWAH
             bitmaps: one describing the set of pseudo-merge "parents", and
    @@ Documentation/technical/bitmap-format.txt: triplet is -
     +bytes (preceding the name-hash cache, commit lookup table, and trailing
     +checksum) of the `.bitmap` file is used to store pseudo-merge bitmaps.
     +
    -+A "pseudo-merge bitmap" is used to refer to a pair of bitmaps, as
    -+follows:
    -+
    -+Commit bitmap::
    -+
    -+  A bitmap whose set bits describe the set of commits included in the
    -+  pseudo-merge's "merge" bitmap (as below).
    -+
    -+Merge bitmap::
    -+
    -+  A bitmap whose set bits describe the reachability closure over the set
    -+  of commits in the pseudo-merge's "commits" bitmap (as above). An
    -+  identical bitmap would be generated for an octopus merge with the same
    -+  set of parents as described in the commits bitmap.
    -+
    -+Pseudo-merge bitmaps can accelerate bitmap traversals when all commits
    -+for a given pseudo-merge are listed on either side of the traversal,
    -+either directly (by explicitly asking for them as part of the `HAVES`
    -+or `WANTS`) or indirectly (by encountering them during a fill-in
    -+traversal).
    -+
    -+=== Use-cases
    -+
    -+For example, suppose there exists a pseudo-merge bitmap with a large
    -+number of commits, all of which are listed in the `WANTS` section of
    -+some bitmap traversal query. When pseudo-merge bitmaps are enabled, the
    -+bitmap machinery can quickly determine there is a pseudo-merge which
    -+satisfies some subset of the wanted objects on either side of the query.
    -+Then, we can inflate the EWAH-compressed bitmap, and `OR` it in to the
    -+resulting bitmap. By contrast, without pseudo-merge bitmaps, we would
    -+have to repeat the decompression and `OR`-ing step over a potentially
    -+large number of individual bitmaps, which can take proportionally more
    -+time.
    -+
    -+Another benefit of pseudo-merges arises when there is some combination
    -+of (a) a large number of references, with (b) poor bitmap coverage, and
    -+(c) deep, nested trees, making fill-in traversal relatively expensive.
    -+For example, suppose that there are a large enough number of tags where
    -+bitmapping each of the tags individually is infeasible. Without
    -+pseudo-merge bitmaps, computing the result of, say, `git rev-list
    -+--use-bitmap-index --count --objects --tags` would likely require a
    -+large amount of fill-in traversal. But when a large quantity of those
    -+tags are stored together in a pseudo-merge bitmap, the bitmap machinery
    -+can take advantage of the fact that we only care about the union of
    -+objects reachable from all of those tags, and answer the query much
    -+faster.
    ++For more information on what pseudo-merges are, why they are useful, and
    ++how to configure them, see the information in linkgit:gitpacking[7].
     +
     +=== File format
     +
    @@ Documentation/technical/bitmap-format.txt: triplet is -
     ++-------------------------------------------+
     +|                                           |
     +|  Lookup Table                             |
    -+|  +------------+--------------+            |
    -+|  | commit_pos |    offset    |            |
    -+|  +------------+--------------+            |
    -+|  |  4 bytes   |   8 bytes    |            |
    ++|  +---------------------------+            |
    ++|  | commit_pos (4 bytes)      |            |
    ++|  +---------------------------+            |
    ++|  | offset (8 bytes)          |            |
     +|  +------------+--------------+            |
     +|                                           |
     +|  Offset Cases:                            |
    @@ Documentation/technical/bitmap-format.txt: triplet is -
     ++-------------------------------------------+
     +|                                           |
     +|  Extended Lookup Table (Optional)         |
    -+|                                           |
     +|  +----+----------+----------+----------+  |
     +|  | N  | Offset 1 |   ....   | Offset N |  |
     +|  +----+----------+----------+----------+  |
    @@ Documentation/technical/bitmap-format.txt: triplet is -
     ++-------------------------------------------+
     +|                                           |
     +|  Pseudo-merge Metadata                    |
    -+|  +------------------+----------------+    |
    -+|  | # pseudo-merges  | # Commits      |    |
    -+|  +------------------+----------------+    |
    -+|  | 4 bytes          | 4 bytes        |    |
    -+|  +------------------+----------------+    |
    -+|                                           |
    -+|  +------------------+----------------+    |
    -+|  | Lookup offset    | Extension size |    |
    -+|  +------------------+----------------+    |
    -+|  | 8 bytes          | 8 bytes        |    |
    -+|  +------------------+----------------+    |
    ++|  +-----------------------------------+    |
    ++|  | # pseudo-merges (4 bytes)         |    |
    ++|  +-----------------------------------+    |
    ++|  | # commits (4 bytes)               |    |
    ++|  +-----------------------------------+    |
    ++|  | Lookup offset (8 bytes)           |    |
    ++|  +-----------------------------------+    |
    ++|  | Extension size (8 bytes)          |    |
    ++|  +-----------------------------------+    |
     +|                                           |
     ++-------------------------------------------+
     +....
    @@ Documentation/technical/bitmap-format.txt: triplet is -
     +
     +* Positions for all pseudo-merges, each stored as an 8-byte unsigned
     +  value (in network byte-order) containing the offset (relative to the
    -+  beginnign of the `.bitmap` file) of each consecutive pseudo-merge.
    ++  beginning of the `.bitmap` file) of each consecutive pseudo-merge.
     +
     +* A 4-byte unsigned value (in network byte-order) equal to the number of
     +  pseudo-merges.
 2:  290d928325d = 10:  40eb6137618 ewah: implement `ewah_bitmap_is_subset()`
 3:  5160859f7f3 <  -:  ----------- pack-bitmap: drop unused `max_bitmaps` parameter
 4:  3d7d930b1c5 <  -:  ----------- pack-bitmap: move some initialization to `bitmap_writer_init()`
 -:  ----------- > 11:  487fb7c6e9c pack-bitmap: move some initialization to `bitmap_writer_init()`
 5:  e7a87cf7d4e = 12:  827732acf99 pseudo-merge.ch: initial commit
 6:  ee33a703245 ! 13:  8608dd1860f pack-bitmap-write: support storing pseudo-merge commits
    @@ Commit message
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## object.h ##
    +@@ object.h: void object_array_init(struct object_array *array);
    +  * reflog.c:                           10--12
    +  * builtin/show-branch.c:    0-------------------------------------------26
    +  * builtin/unpack-objects.c:                                 2021
    +- * pack-bitmap.h:                                                22
    ++ * pack-bitmap.h:                                              2122
    +  */
    + #define FLAG_BITS  28
    + 
    +
      ## pack-bitmap-write.c ##
     @@ pack-bitmap-write.c: struct bitmapped_commit {
    - 	struct ewah_bitmap *write_as;
      	int flags;
      	int xor_offset;
    --	uint32_t commit_pos;
    + 	uint32_t commit_pos;
     +	unsigned pseudo_merge : 1;
      };
      
    - struct bitmap_writer {
    -@@ pack-bitmap-write.c: struct bitmap_writer {
    - 	struct bitmapped_commit *selected;
    - 	unsigned int selected_nr, selected_alloc;
    - 
    -+	uint32_t pseudo_merges_nr;
    -+
    - 	struct progress *progress;
    - 	int show_progress;
    - 	unsigned char pack_checksum[GIT_MAX_RAWSZ];
    -@@ pack-bitmap-write.c: struct bitmap_writer {
    - 
    - static struct bitmap_writer writer;
    - 
    -+static inline int bitmap_writer_selected_nr(void)
    ++static inline int bitmap_writer_nr_selected_commits(struct bitmap_writer *writer)
     +{
    -+	return writer.selected_nr - writer.pseudo_merges_nr;
    ++	return writer->selected_nr - writer->pseudo_merges_nr;
     +}
     +
    - void bitmap_writer_init(struct repository *r)
    + void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r)
      {
    - 	writer.bitmaps = kh_init_oid_map();
    -@@ pack-bitmap-write.c: void bitmap_writer_build_type_index(struct packing_data *to_pack,
    -  * Compute the actual bitmaps
    + 	memset(writer, 0, sizeof(struct bitmap_writer));
    +@@ pack-bitmap-write.c: void bitmap_writer_build_type_index(struct bitmap_writer *writer,
       */
      
    --static inline void push_bitmapped_commit(struct commit *commit)
    -+static void bitmap_writer_push_bitmapped_commit(struct commit *commit,
    -+						unsigned pseudo_merge)
    + static inline void push_bitmapped_commit(struct bitmap_writer *writer,
    +-					 struct commit *commit)
    ++					 struct commit *commit,
    ++					 unsigned pseudo_merge)
      {
     -	int hash_ret;
     -	khiter_t hash_pos;
     -
    - 	if (writer.selected_nr >= writer.selected_alloc) {
    - 		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
    - 		REALLOC_ARRAY(writer.selected, writer.selected_alloc);
    + 	if (writer->selected_nr >= writer->selected_alloc) {
    + 		writer->selected_alloc = (writer->selected_alloc + 32) * 2;
    + 		REALLOC_ARRAY(writer->selected, writer->selected_alloc);
      	}
      
    --	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
    +-	hash_pos = kh_put_oid_map(writer->bitmaps, commit->object.oid,
    +-				  &hash_ret);
     -	if (!hash_ret)
     -		die(_("duplicate entry when writing bitmap index: %s"),
     -		    oid_to_hex(&commit->object.oid));
    --	kh_value(writer.bitmaps, hash_pos) = NULL;
    +-	kh_value(writer->bitmaps, hash_pos) = NULL;
     +	if (!pseudo_merge) {
     +		int hash_ret;
    -+		khiter_t hash_pos = kh_put_oid_map(writer.bitmaps,
    ++		khiter_t hash_pos = kh_put_oid_map(writer->bitmaps,
     +						   commit->object.oid,
     +						   &hash_ret);
     +
     +		if (!hash_ret)
     +			die(_("duplicate entry when writing bitmap index: %s"),
     +			    oid_to_hex(&commit->object.oid));
    -+		kh_value(writer.bitmaps, hash_pos) = NULL;
    ++		kh_value(writer->bitmaps, hash_pos) = NULL;
     +	}
      
    - 	writer.selected[writer.selected_nr].commit = commit;
    - 	writer.selected[writer.selected_nr].bitmap = NULL;
    - 	writer.selected[writer.selected_nr].flags = 0;
    -+	writer.selected[writer.selected_nr].pseudo_merge = pseudo_merge;
    + 	writer->selected[writer->selected_nr].commit = commit;
    + 	writer->selected[writer->selected_nr].bitmap = NULL;
    + 	writer->selected[writer->selected_nr].write_as = NULL;
    + 	writer->selected[writer->selected_nr].flags = 0;
    ++	writer->selected[writer->selected_nr].pseudo_merge = pseudo_merge;
      
    - 	writer.selected_nr++;
    + 	writer->selected_nr++;
      }
    -@@ pack-bitmap-write.c: static void compute_xor_offsets(void)
    +@@ pack-bitmap-write.c: static void compute_xor_offsets(struct bitmap_writer *writer)
      
    - 	while (next < writer.selected_nr) {
    - 		struct bitmapped_commit *stored = &writer.selected[next];
    + 	while (next < writer->selected_nr) {
    + 		struct bitmapped_commit *stored = &writer->selected[next];
     -
      		int best_offset = 0;
      		struct ewah_bitmap *best_bitmap = stored->bitmap;
    @@ pack-bitmap-write.c: static void compute_xor_offsets(void)
      
      			if (curr < 0)
      				break;
    -+			if (writer.selected[curr].pseudo_merge)
    ++			if (writer->selected[curr].pseudo_merge)
     +				continue;
      
      			test_xor = ewah_pool_new();
    - 			ewah_xor(writer.selected[curr].bitmap, stored->bitmap, test_xor);
    -@@ pack-bitmap-write.c: static void compute_xor_offsets(void)
    + 			ewah_xor(writer->selected[curr].bitmap, stored->bitmap, test_xor);
    +@@ pack-bitmap-write.c: static void compute_xor_offsets(struct bitmap_writer *writer)
      			}
      		}
      
    @@ pack-bitmap-write.c: static void bitmap_builder_init(struct bitmap_builder *bb,
      	}
      
      	if (prepare_revision_walk(&revs))
    -@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bb_commit *ent,
    +@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bitmap_writer *writer,
      		struct commit *c = prio_queue_get(queue);
      
      		if (old_bitmap && mapping) {
    @@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bb_commit *ent,
      			/*
      			 * If this commit has an old bitmap, then translate that
      			 * bitmap and add its bits to this one. No need to walk
    -@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bb_commit *ent,
    +@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bitmap_writer *writer,
      		 * Mark ourselves and queue our tree. The commit
      		 * walk ensures we cover all parents.
      		 */
    --		pos = find_object_pos(&c->object.oid, &found);
    +-		pos = find_object_pos(writer, &c->object.oid, &found);
     -		if (!found)
     -			return -1;
     -		bitmap_set(ent->bitmap, pos);
     -		prio_queue_put(tree_queue,
     -			       repo_get_commit_tree(the_repository, c));
     +		if (!(c->object.flags & BITMAP_PSEUDO_MERGE)) {
    -+			pos = find_object_pos(&c->object.oid, &found);
    ++			pos = find_object_pos(writer, &c->object.oid, &found);
     +			if (!found)
     +				return -1;
     +			bitmap_set(ent->bitmap, pos);
    @@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bb_commit *ent,
     +		}
      
      		for (p = c->parents; p; p = p->next) {
    - 			pos = find_object_pos(&p->item->object.oid, &found);
    -@@ pack-bitmap-write.c: static void store_selected(struct bb_commit *ent, struct commit *commit)
    + 			pos = find_object_pos(writer, &p->item->object.oid,
    +@@ pack-bitmap-write.c: static void store_selected(struct bitmap_writer *writer,
      
      	stored->bitmap = bitmap_to_ewah(ent->bitmap);
      
     +	if (ent->pseudo_merge)
     +		return;
     +
    - 	hash_pos = kh_get_oid_map(writer.bitmaps, commit->object.oid);
    - 	if (hash_pos == kh_end(writer.bitmaps))
    + 	hash_pos = kh_get_oid_map(writer->bitmaps, commit->object.oid);
    + 	if (hash_pos == kh_end(writer->bitmaps))
      		die(_("attempted to store non-selected commit: '%s'"),
    -@@ pack-bitmap-write.c: void bitmap_writer_select_commits(struct commit **indexed_commits,
    +@@ pack-bitmap-write.c: void bitmap_writer_select_commits(struct bitmap_writer *writer,
      
      	if (indexed_commits_nr < 100) {
      		for (i = 0; i < indexed_commits_nr; ++i)
    --			push_bitmapped_commit(indexed_commits[i]);
    -+			bitmap_writer_push_bitmapped_commit(indexed_commits[i], 0);
    +-			push_bitmapped_commit(writer, indexed_commits[i]);
    ++			push_bitmapped_commit(writer, indexed_commits[i], 0);
      		return;
      	}
      
    -@@ pack-bitmap-write.c: void bitmap_writer_select_commits(struct commit **indexed_commits,
    +@@ pack-bitmap-write.c: void bitmap_writer_select_commits(struct bitmap_writer *writer,
      			}
      		}
      
    --		push_bitmapped_commit(chosen);
    -+		bitmap_writer_push_bitmapped_commit(chosen, 0);
    +-		push_bitmapped_commit(writer, chosen);
    ++		push_bitmapped_commit(writer, chosen, 0);
      
      		i += next + 1;
    - 		display_progress(writer.progress, i);
    -@@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
    + 		display_progress(writer->progress, i);
    +@@ pack-bitmap-write.c: static void write_selected_commits_v1(struct bitmap_writer *writer,
      {
      	int i;
      
    --	for (i = 0; i < writer.selected_nr; ++i) {
    -+	for (i = 0; i < bitmap_writer_selected_nr(); ++i) {
    - 		struct bitmapped_commit *stored = &writer.selected[i];
    +-	for (i = 0; i < writer->selected_nr; ++i) {
    ++	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); ++i) {
    + 		struct bitmapped_commit *stored = &writer->selected[i];
     +		if (stored->pseudo_merge)
     +			BUG("unexpected pseudo-merge among selected: %s",
     +			    oid_to_hex(&stored->commit->object.oid));
      
      		if (offsets)
      			offsets[i] = hashfile_total(f);
    -@@ pack-bitmap-write.c: static void write_lookup_table(struct hashfile *f,
    +@@ pack-bitmap-write.c: static void write_lookup_table(struct bitmap_writer *writer, struct hashfile *f,
      	uint32_t i;
      	uint32_t *table, *table_inv;
      
    --	ALLOC_ARRAY(table, writer.selected_nr);
    --	ALLOC_ARRAY(table_inv, writer.selected_nr);
    -+	ALLOC_ARRAY(table, bitmap_writer_selected_nr());
    -+	ALLOC_ARRAY(table_inv, bitmap_writer_selected_nr());
    +-	ALLOC_ARRAY(table, writer->selected_nr);
    +-	ALLOC_ARRAY(table_inv, writer->selected_nr);
    ++	ALLOC_ARRAY(table, bitmap_writer_nr_selected_commits(writer));
    ++	ALLOC_ARRAY(table_inv, bitmap_writer_nr_selected_commits(writer));
      
    --	for (i = 0; i < writer.selected_nr; i++)
    -+	for (i = 0; i < bitmap_writer_selected_nr(); i++)
    +-	for (i = 0; i < writer->selected_nr; i++)
    ++	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++)
      		table[i] = i;
      
      	/*
    -@@ pack-bitmap-write.c: static void write_lookup_table(struct hashfile *f,
    +@@ pack-bitmap-write.c: static void write_lookup_table(struct bitmap_writer *writer, struct hashfile *f,
      	 * bitmap corresponds to j'th bitmapped commit (among the selected
      	 * commits) in lex order of OIDs.
      	 */
    --	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
    -+	QSORT_S(table, bitmap_writer_selected_nr(), table_cmp, commit_positions);
    +-	QSORT_S(table, writer->selected_nr, table_cmp, writer);
    ++	QSORT_S(table, bitmap_writer_nr_selected_commits(writer), table_cmp, writer);
      
      	/* table_inv helps us discover that relationship (i'th bitmap
      	 * to j'th commit by j = table_inv[i])
      	 */
    --	for (i = 0; i < writer.selected_nr; i++)
    -+	for (i = 0; i < bitmap_writer_selected_nr(); i++)
    +-	for (i = 0; i < writer->selected_nr; i++)
    ++	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++)
      		table_inv[table[i]] = i;
      
      	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
    --	for (i = 0; i < writer.selected_nr; i++) {
    -+	for (i = 0; i < bitmap_writer_selected_nr(); i++) {
    - 		struct bitmapped_commit *selected = &writer.selected[table[i]];
    +-	for (i = 0; i < writer->selected_nr; i++) {
    ++	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++) {
    + 		struct bitmapped_commit *selected = &writer->selected[table[i]];
      		uint32_t xor_offset = selected->xor_offset;
      		uint32_t xor_row;
    -@@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
    +@@ pack-bitmap-write.c: void bitmap_writer_finish(struct bitmap_writer *writer,
      	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
      	header.version = htons(default_version);
      	header.options = htons(flags | options);
    --	header.entry_count = htonl(writer.selected_nr);
    -+	header.entry_count = htonl(bitmap_writer_selected_nr());
    - 	hashcpy(header.checksum, writer.pack_checksum);
    +-	header.entry_count = htonl(writer->selected_nr);
    ++	header.entry_count = htonl(bitmap_writer_nr_selected_commits(writer));
    + 	hashcpy(header.checksum, writer->pack_checksum);
      
      	hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz);
    -@@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
    +@@ pack-bitmap-write.c: void bitmap_writer_finish(struct bitmap_writer *writer,
      	if (options & BITMAP_OPT_LOOKUP_TABLE)
      		CALLOC_ARRAY(offsets, index_nr);
      
    --	ALLOC_ARRAY(commit_positions, writer.selected_nr);
    -+	ALLOC_ARRAY(commit_positions, bitmap_writer_selected_nr());
    - 
    --	for (i = 0; i < writer.selected_nr; i++) {
    -+	for (i = 0; i < bitmap_writer_selected_nr(); i++) {
    - 		struct bitmapped_commit *stored = &writer.selected[i];
    - 		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
    - 
    +-	for (i = 0; i < writer->selected_nr; i++) {
    ++	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++) {
    + 		struct bitmapped_commit *stored = &writer->selected[i];
    + 		int commit_pos = oid_pos(&stored->commit->object.oid, index,
    + 					 index_nr, oid_access);
     
      ## pack-bitmap.h ##
     @@ pack-bitmap.h: struct bitmap_disk_header {
    @@ pack-bitmap.h: struct bitmap_disk_header {
      #define NEEDS_BITMAP (1u<<22)
      
      /*
    +@@ pack-bitmap.h: struct bitmap_writer {
    + 	struct bitmapped_commit *selected;
    + 	unsigned int selected_nr, selected_alloc;
    + 
    ++	uint32_t pseudo_merges_nr;
    ++
    + 	struct progress *progress;
    + 	int show_progress;
    + 	unsigned char pack_checksum[GIT_MAX_RAWSZ];
 7:  9c6d09bf874 <  -:  ----------- pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 8:  dfd4b73d12e <  -:  ----------- pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 -:  ----------- > 14:  99d2b6872ba pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 -:  ----------- > 15:  e7209c60fa5 pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 -:  ----------- > 16:  3070135eb4b config: introduce git_config_float()
 9:  86a1e4b8b9b ! 17:  3029473c094 pseudo-merge: implement support for selecting pseudo-merge commits
    @@ Commit message
         for inclusion in different pseudo-merge group(s) based on a handful of
         criteria.
     
    -    Pseudo-merges are derived first from named pseudo-merge groups (see the
    -    `bitmapPseudoMerge.<name>.*` configuration options). They are
    -    (optionally) further segmented within an individual pseudo-merge group
    -    based on any capture group(s) within the pseudo-merge group's pattern.
    -
    -    For example, a configuration like so:
    -
    -        [bitmapPseudoMerge "all"]
    -            pattern = "refs/"
    -            threshold = now
    -            stableThreshold = never
    -            sampleRate = 100
    -            maxMerges = 64
    -
    -    would group all non-bitmapped commits into up to 64 individual
    -    pseudo-merge commits.
    -
    -    If you wanted to separate tags from branches when generating
    -    pseudo-merge commits, and further segment them by which fork they
    -    originate from (using the same "refs/virtual/" scheme as in the delta
    -    islands documentation), you would instead write something like:
    -
    -        [bitmapPseudoMerge "all"]
    -            pattern = "refs/virtual/([0-9]+)/(heads|tags)/"
    -            threshold = now
    -            stableThreshold = never
    -            sampleRate = 100
    -            maxMerges = 64
    -
    -    Which would generate pseudo-merge group identifiers like "1234-heads",
    -    and "5678-tags" (for branches in fork "1234", and tags in remote "5678",
    -    respectively).
    -
    -    Within pseudo-merge groups, there are a handful of other options used to
    -    control the distribution of matching commits among individual
    -    pseudo-merge commits:
    -
    -      - bitmapPseudoMerge.<name>.decay
    -      - bitmapPseudoMerge.<name>.sampleRate
    -      - bitmapPseudoMerge.<name>.threshold
    -      - bitmapPseudoMerge.<name>.maxMerges
    -      - bitmapPseudoMerge.<name>.stableThreshold
    -      - bitmapPseudoMerge.<name>.stableSize
    -
    -    The decay parameter roughly corresponds to "k" in `f(n) = C*n^(-k/100)`,
    -    where `f(n)` describes the size of the `n`-th pseudo-merge group. The
    -    sample rate controls what percentage of eligible commits are considered
    -    as candidates. The threshold parameter indicates the minimum age (so as
    -    to avoid including too-recent commits in a pseudo-merge group, making it
    -    less likely to be valid). The "maxMerges" parameter sets an upper-bound
    -    on the number of pseudo-merge commits an individual group
    -
    -    The latter two "stable"-related parameters control "stable" pseudo-merge
    -    groups, comprised of a fixed number of commits which are older than the
    -    configured "stable threshold" value and may be grouped together in
    -    chunks of "stableSize" in order of age.
    -
    -    This patch implements the aforementioned selection routine, as well as
    -    parsing the relevant configuration options.
    +    Note that the selected pseudo-merge commits aren't actually used or
    +    written anywhere yet. This will be done in the following commit.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## Documentation/config.txt ##
    +@@ Documentation/config.txt: include::config/apply.txt[]
    + 
    + include::config/attr.txt[]
    + 
    ++include::config/bitmap-pseudo-merge.txt[]
    ++
    + include::config/blame.txt[]
    + 
    + include::config/branch.txt[]
    +
    + ## Documentation/config/bitmap-pseudo-merge.txt (new) ##
    +@@
    ++NOTE: The configuration options in `bitmapPseudoMerge.*` are considered
    ++EXPERIMENTAL and may be subject to change or be removed entirely in the
    ++future.
    ++
    ++bitmapPseudoMerge.<name>.pattern::
    ++	Regular expression used to match reference names. Commits
    ++	pointed to by references matching this pattern (and meeting
    ++	the below criteria, like `bitmapPseudoMerge.<name>.sampleRate`
    ++	and `bitmapPseudoMerge.<name>.threshold`) will be considered
    ++	for inclusion in a pseudo-merge bitmap.
    +++
    ++Commits are grouped into pseudo-merge groups based on whether or not
    ++any reference(s) that point at a given commit match the pattern, which
    ++is an extended regular expression.
    +++
    ++Within a pseudo-merge group, commits may be further grouped into
    ++sub-groups based on the capture groups in the pattern. These
    ++sub-groupings are formed from the regular expressions by concatenating
    ++any capture groups from the regular expression, with a '-' dash in
    ++between.
    +++
    ++For example, if the pattern is `refs/tags/`, then all tags (provided
    ++they meet the below criteria) will be considered candidates for the
    ++same pseudo-merge group. However, if the pattern is instead
    ++`refs/remotes/([0-9])+/tags/`, then tags from different remotes will
    ++be grouped into separate pseudo-merge groups, based on the remote
    ++number.
    ++
    ++bitmapPseudoMerge.<name>.decay::
    ++	Determines the rate at which consecutive pseudo-merge bitmap
    ++	groups decrease in size. Must be non-negative. This parameter
    ++	can be thought of as `k` in the function `f(n) = C * n^-k`,
    ++	where `f(n)` is the size of the `n`th group.
    +++
    ++Setting the decay rate equal to `0` will cause all groups to be the
    ++same size. Setting the decay rate equal to `1` will cause the `n`th
    ++group to be `1/n` the size of the initial group.  Higher values of the
    ++decay rate cause consecutive groups to shrink at an increasing rate.
    ++The default is `1`.
    +++
    ++If all groups are the same size, it is possible that groups containing
    ++newer commits will be able to be used less often than earlier groups,
    ++since it is more likely that the references pointing at newer commits
    ++will be updated more often than a reference pointing at an old commit.
    ++
    ++bitmapPseudoMerge.<name>.sampleRate::
    ++	Determines the proportion of non-bitmapped commits (among
    ++	reference tips) which are selected for inclusion in an
    ++	unstable pseudo-merge bitmap. Must be between `0` and `1`
    ++	(inclusive). The default is `1`.
    ++
    ++bitmapPseudoMerge.<name>.threshold::
    ++	Determines the minimum age of non-bitmapped commits (among
    ++	reference tips, as above) which are candidates for inclusion
    ++	in an unstable pseudo-merge bitmap. The default is
    ++	`1.week.ago`.
    ++
    ++bitmapPseudoMerge.<name>.maxMerges::
    ++	Determines the maximum number of pseudo-merge commits among
    ++	which commits may be distributed.
    +++
    ++For pseudo-merge groups whose pattern does not contain any capture
    ++groups, this setting is applied for all commits matching the regular
    ++expression. For patterns that have one or more capture groups, this
    ++setting is applied for each distinct capture group.
    +++
    ++For example, if your capture group is `refs/tags/`, then this setting
    ++will distribute all tags into a maximum of `maxMerges` pseudo-merge
    ++commits. However, if your capture group is, say,
    ++`refs/remotes/([0-9]+)/tags/`, then this setting will be applied to
    ++each remote's set of tags individually.
    +++
    ++Must be non-negative. The default value is 64.
    ++
    ++bitmapPseudoMerge.<name>.stableThreshold::
    ++	Determines the minimum age of commits (among reference tips,
    ++	as above, however stable commits are still considered
    ++	candidates even when they have been covered by a bitmap) which
    ++	are candidates for a stable a pseudo-merge bitmap. The default
    ++	is `1.month.ago`.
    +++
    ++Setting this threshold to a smaller value (e.g., 1.week.ago) will cause
    ++more stable groups to be generated (which impose a one-time generation
    ++cost) but those groups will likely become stale over time. Using a
    ++larger value incurs the opposite penalty (fewer stable groups which are
    ++more useful).
    ++
    ++bitmapPseudoMerge.<name>.stableSize::
    ++	Determines the size (in number of commits) of a stable
    ++	psuedo-merge bitmap. The default is `512`.
    +
    + ## Documentation/gitpacking.txt ##
    +@@ Documentation/gitpacking.txt: can take advantage of the fact that we only care about the union of
    + objects reachable from all of those tags, and answer the query much
    + faster.
    + 
    ++=== Configuration
    ++
    ++Reference tips are grouped into different pseudo-merge groups according
    ++to two criteria. A reference name matches one or more of the defined
    ++pseudo-merge patterns, and optionally one or more capture groups within
    ++that pattern which further partition the group.
    ++
    ++Within a group, commits may be considered "stable", or "unstable"
    ++depending on their age. These are adjusted by setting the
    ++`bitmapPseudoMerge.<name>.stableThreshold` and
    ++`bitmapPseudoMerge.<name>.threshold` configuration values, respectively.
    ++
    ++All stable commits are grouped into pseudo-merges of equal size
    ++(`bitmapPseudoMerge.<name>.stableSize`). If the `stableSize`
    ++configuration is set to, say, 100, then the first 100 commits (ordered
    ++by committer date) which are older than the `stableThreshold` value will
    ++form one group, the next 100 commits will form another group, and so on.
    ++
    ++Among unstable commits, the pseudo-merge machinery will attempt to
    ++combine older commits into large groups as opposed to newer commits
    ++which will appear in smaller groups. This is based on the heuristic that
    ++references whose tip commit is older are less likely to be modified to
    ++point at a different commit than a reference whose tip commit is newer.
    ++
    ++The size of groups is determined by a power-law decay function, and the
    ++decay parameter roughly corresponds to "k" in `f(n) = C*n^(-k/100)`,
    ++where `f(n)` describes the size of the `n`-th pseudo-merge group. The
    ++sample rate controls what percentage of eligible commits are considered
    ++as candidates. The threshold parameter indicates the minimum age (so as
    ++to avoid including too-recent commits in a pseudo-merge group, making it
    ++less likely to be valid). The "maxMerges" parameter sets an upper-bound
    ++on the number of pseudo-merge commits an individual group
    ++
    ++The "stable"-related parameters control "stable" pseudo-merge groups,
    ++comprised of a fixed number of commits which are older than the
    ++configured "stable threshold" value and may be grouped together in
    ++chunks of "stableSize" in order of age.
    ++
    ++The exact configuration for pseudo-merges is as follows:
    ++
    ++include::config/bitmap-pseudo-merge.txt[]
    ++
    ++=== Examples
    ++
    ++Suppose that you have a repository with a large number of references,
    ++and you want a bare-bones configuration of pseudo-merge bitmaps that
    ++will enhance bitmap coverage of the `refs/` namespace. You may start
    ++wiht a configuration like so:
    ++
    ++    [bitmapPseudoMerge "all"]
    ++	pattern = "refs/"
    ++	threshold = now
    ++	stableThreshold = never
    ++	sampleRate = 100
    ++	maxMerges = 64
    ++
    ++This will create pseudo-merge bitmaps for all references, regardless of
    ++their age, and group them into 64 pseudo-merge commits.
    ++
    ++If you wanted to separate tags from branches when generating
    ++pseudo-merge commits, you would instead define the pattern with a
    ++capture group, like so:
    ++
    ++    [bitmapPseudoMerge "all"]
    ++	pattern = "refs/(heads/tags)/"
    ++
    ++Suppose instead that you are working in a fork-network repository, with
    ++each fork specified by some numeric ID, and whose refs reside in
    ++`refs/virtual/NNN/` (where `NNN` is the numeric ID corresponding to some
    ++fork) in the network. In this instance, you may instead write something
    ++like:
    ++
    ++    [bitmapPseudoMerge "all"]
    ++	pattern = "refs/virtual/([0-9]+)/(heads|tags)/"
    ++	threshold = now
    ++	stableThreshold = never
    ++	sampleRate = 100
    ++	maxMerges = 64
    ++
    ++Which would generate pseudo-merge group identifiers like "1234-heads",
    ++and "5678-tags" (for branches in fork "1234", and tags in remote "5678",
    ++respectively).
    ++
    + SEE ALSO
    + --------
    + linkgit:git-pack-objects[1]
    +
    + ## pack-bitmap-write.c ##
    +@@
    + #include "trace2.h"
    + #include "tree.h"
    + #include "tree-walk.h"
    ++#include "pseudo-merge.h"
    + 
    + struct bitmapped_commit {
    + 	struct commit *commit;
    +@@ pack-bitmap-write.c: void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r)
    + 	if (writer->bitmaps)
    + 		BUG("bitmap writer already initialized");
    + 	writer->bitmaps = kh_init_oid_map();
    ++	writer->pseudo_merge_commits = kh_init_oid_map();
    ++
    ++	string_list_init_dup(&writer->pseudo_merge_groups);
    ++
    ++	load_pseudo_merges_from_config(&writer->pseudo_merge_groups);
    ++}
    ++
    ++static void free_pseudo_merge_commit_idx(struct pseudo_merge_commit_idx *idx)
    ++{
    ++	if (!idx)
    ++		return;
    ++	free(idx->pseudo_merge);
    ++	free(idx);
    + }
    + 
    + void bitmap_writer_free(struct bitmap_writer *writer)
    + {
    + 	uint32_t i;
    ++	struct pseudo_merge_commit_idx *idx;
    + 
    + 	if (!writer)
    + 		return;
    +@@ pack-bitmap-write.c: void bitmap_writer_free(struct bitmap_writer *writer)
    + 
    + 	kh_destroy_oid_map(writer->bitmaps);
    + 
    ++	kh_foreach_value(writer->pseudo_merge_commits, idx,
    ++			 free_pseudo_merge_commit_idx(idx));
    ++	kh_destroy_oid_map(writer->pseudo_merge_commits);
    ++
    + 	for (i = 0; i < writer->selected_nr; i++) {
    + 		struct bitmapped_commit *bc = &writer->selected[i];
    + 		if (bc->write_as != bc->bitmap)
    +@@ pack-bitmap-write.c: void bitmap_writer_select_commits(struct bitmap_writer *writer,
    + 	}
    + 
    + 	stop_progress(&writer->progress);
    ++
    ++	select_pseudo_merges(writer, indexed_commits, indexed_commits_nr);
    + }
    + 
    + 
    +
    + ## pack-bitmap.h ##
    +@@ pack-bitmap.h: struct bitmap_writer {
    + 	struct bitmapped_commit *selected;
    + 	unsigned int selected_nr, selected_alloc;
    + 
    ++	struct string_list pseudo_merge_groups;
    ++	kh_oid_map_t *pseudo_merge_commits; /* oid -> pseudo merge(s) */
    + 	uint32_t pseudo_merges_nr;
    + 
    + 	struct progress *progress;
    +
      ## pseudo-merge.c ##
     @@
      #include "git-compat-util.h"
    @@ pseudo-merge.c
     +
     +#define DEFAULT_PSEUDO_MERGE_DECAY 1.0f
     +#define DEFAULT_PSEUDO_MERGE_MAX_MERGES 64
    -+#define DEFAULT_PSEUDO_MERGE_SAMPLE_RATE 100
    ++#define DEFAULT_PSEUDO_MERGE_SAMPLE_RATE 1
     +#define DEFAULT_PSEUDO_MERGE_THRESHOLD approxidate("1.week.ago")
     +#define DEFAULT_PSEUDO_MERGE_STABLE_THRESHOLD approxidate("1.month.ago")
     +#define DEFAULT_PSEUDO_MERGE_STABLE_SIZE 512
    @@ pseudo-merge.c
     +		C += 1.0f / gitexp(n + 1, group->decay);
     +	C = matches->unstable_nr / C;
     +
    -+	return (int)((C / gitexp(i + 1, group->decay)) + 0.5);
    ++	return (uint32_t)((C / gitexp(i + 1, group->decay)) + 0.5);
     +}
     +
    -+static void init_pseudo_merge_group(struct pseudo_merge_group *group)
    ++static void pseudo_merge_group_init(struct pseudo_merge_group *group)
     +{
     +	memset(group, 0, sizeof(struct pseudo_merge_group));
     +
    @@ pseudo-merge.c
     +	struct strbuf buf = STRBUF_INIT;
     +	const char *sub, *key;
     +	size_t sub_len;
    ++	int ret = 0;
     +
     +	if (parse_config_key(var, "bitmappseudomerge", &sub, &sub_len, &key))
    -+		return 0;
    ++		goto done;
     +
     +	if (!sub_len)
    -+		return 0;
    ++		goto done;
     +
     +	strbuf_add(&buf, sub, sub_len);
     +
    @@ pseudo-merge.c
     +		item = string_list_insert(list, buf.buf);
     +
     +		item->util = xmalloc(sizeof(struct pseudo_merge_group));
    -+		init_pseudo_merge_group(item->util);
    ++		pseudo_merge_group_init(item->util);
     +	}
     +
     +	group = item->util;
    @@ pseudo-merge.c
     +
     +		strbuf_release(&re);
     +	} else if (!strcmp(key, "decay")) {
    -+		group->decay = git_config_int(var, value, ctx->kvi);
    ++		group->decay = git_config_float(var, value, ctx->kvi);
     +		if (group->decay < 0) {
     +			warning(_("%s must be non-negative, using default"), var);
     +			group->decay = DEFAULT_PSEUDO_MERGE_DECAY;
     +		}
     +	} else if (!strcmp(key, "samplerate")) {
    -+		group->sample_rate = git_config_int(var, value, ctx->kvi);
    -+		if (!(0 <= group->sample_rate && group->sample_rate <= 100)) {
    -+			warning(_("%s must be between 0 and 100, using default"), var);
    ++		group->sample_rate = git_config_float(var, value, ctx->kvi);
    ++		if (!(0 <= group->sample_rate && group->sample_rate <= 1)) {
    ++			warning(_("%s must be between 0 and 1, using default"), var);
     +			group->sample_rate = DEFAULT_PSEUDO_MERGE_SAMPLE_RATE;
     +		}
     +	} else if (!strcmp(key, "threshold")) {
     +		if (git_config_expiry_date(&group->threshold, var, value)) {
    -+			strbuf_release(&buf);
    -+			return -1;
    ++			ret = -1;
    ++			goto done;
     +		}
     +	} else if (!strcmp(key, "maxmerges")) {
     +		group->max_merges = git_config_int(var, value, ctx->kvi);
    @@ pseudo-merge.c
     +		}
     +	} else if (!strcmp(key, "stablethreshold")) {
     +		if (git_config_expiry_date(&group->stable_threshold, var, value)) {
    -+			strbuf_release(&buf);
    -+			return -1;
    ++			ret = -1;
    ++			goto done;
     +		}
     +	} else if (!strcmp(key, "stablesize")) {
     +		group->stable_size = git_config_int(var, value, ctx->kvi);
    @@ pseudo-merge.c
     +		}
     +	}
     +
    ++done:
     +	strbuf_release(&buf);
     +
    -+	return 0;
    ++	return ret;
     +}
     +
     +void load_pseudo_merges_from_config(struct string_list *list)
    @@ pseudo-merge.c
     +					   int flags UNUSED,
     +					   void *_data)
     +{
    -+	struct string_list *list = _data;
    ++	struct bitmap_writer *writer = _data;
     +	struct object_id peeled;
     +	struct commit *c;
     +	uint32_t i;
    @@ pseudo-merge.c
     +	if (!c)
     +		return 0;
     +
    -+	has_bitmap = bitmap_writer_has_bitmapped_object_id(oid);
    ++	has_bitmap = bitmap_writer_has_bitmapped_object_id(writer, oid);
     +
    -+	for (i = 0; i < list->nr; i++) {
    ++	for (i = 0; i < writer->pseudo_merge_groups.nr; i++) {
     +		struct pseudo_merge_group *group;
     +		struct pseudo_merge_matches *matches;
     +		struct strbuf group_name = STRBUF_INIT;
     +		regmatch_t captures[16];
     +		size_t j;
     +
    -+		group = list->items[i].util;
    ++		group = writer->pseudo_merge_groups.items[i].util;
     +		if (regexec(group->pattern, refname, ARRAY_SIZE(captures),
     +			    captures, 0))
     +			continue;
    @@ pseudo-merge.c
     +
     +{
     +	struct pseudo_merge_commit_idx *pmc;
    -+	khiter_t hash_pos;
    -+
    -+	hash_pos = kh_get_oid_map(pseudo_merge_commits, *oid);
    -+	if (hash_pos == kh_end(pseudo_merge_commits)) {
    -+		int hash_ret;
    -+		hash_pos = kh_put_oid_map(pseudo_merge_commits, *oid, &hash_ret);
    ++	int hash_ret;
    ++	khiter_t hash_pos = kh_put_oid_map(pseudo_merge_commits, *oid,
    ++					   &hash_ret);
     +
    ++	if (hash_ret) {
     +		CALLOC_ARRAY(pmc, 1);
    -+
     +		kh_value(pseudo_merge_commits, hash_pos) = pmc;
     +	} else {
     +		pmc = kh_value(pseudo_merge_commits, hash_pos);
    @@ pseudo-merge.c
     +
     +#define MIN_PSEUDO_MERGE_SIZE 8
     +
    -+static void select_pseudo_merges_1(struct pseudo_merge_group *group,
    -+				   struct pseudo_merge_matches *matches,
    -+				   kh_oid_map_t *pseudo_merge_commits,
    -+				   uint32_t *pseudo_merges_nr)
    ++static void select_pseudo_merges_1(struct bitmap_writer *writer,
    ++				   struct pseudo_merge_group *group,
    ++				   struct pseudo_merge_matches *matches)
     +{
     +	uint32_t i, j;
     +	uint32_t stable_merges_nr;
    @@ pseudo-merge.c
     +		merge = push_pseudo_merge(group);
     +		p = &merge->parents;
     +
    ++		/*
    ++		 * For each pseudo-merge created above, add parents to the
    ++		 * allocated commit node from the stable set of commits
    ++		 * (un-bitmapped, newer than the stable threshold).
    ++		 */
     +		do {
     +			struct commit *c;
     +			struct pseudo_merge_commit_idx *pmc;
    @@ pseudo-merge.c
     +				break;
     +
     +			c = matches->stable[j++];
    -+			pmc = pseudo_merge_idx(pseudo_merge_commits,
    ++			/*
    ++			 * Here and below, make sure that we keep our mapping of
    ++			 * commits -> pseudo-merge(s) which include the key'd
    ++			 * commit up-to-date.
    ++			 */
    ++			pmc = pseudo_merge_idx(writer->pseudo_merge_commits,
     +					       &c->object.oid);
     +
     +			ALLOC_GROW(pmc->pseudo_merge, pmc->nr + 1, pmc->alloc);
     +
    -+			pmc->pseudo_merge[pmc->nr++] = *pseudo_merges_nr;
    ++			pmc->pseudo_merge[pmc->nr++] = writer->pseudo_merges_nr;
     +			p = commit_list_append(c, p);
     +		} while (j % group->stable_size);
     +
    -+		bitmap_writer_push_bitmapped_commit(merge, 1);
    -+		(*pseudo_merges_nr)++;
    ++		bitmap_writer_push_commit(writer, merge, 1);
    ++		writer->pseudo_merges_nr++;
     +	}
     +
     +	/* make up to group->max_merges pseudo merges for unstable commits */
    @@ pseudo-merge.c
     +		size = pseudo_merge_group_size(group, matches, i);
     +		end = size < MIN_PSEUDO_MERGE_SIZE ? matches->unstable_nr : j + size;
     +
    ++		/*
    ++		 * For each pseudo-merge commit created above, add parents to
    ++		 * the allocated commit node from the unstable set of commits
    ++		 * (newer than the stable threshold).
    ++		 *
    ++		 * Account for the sample rate, since not every candidate from
    ++		 * the set of stable commits will be included as a pseudo-merge
    ++		 * parent.
    ++		 */
     +		for (; j < end && j < matches->unstable_nr; j++) {
     +			struct commit *c = matches->unstable[j];
     +			struct pseudo_merge_commit_idx *pmc;
     +
    -+			if (j % (100 / group->sample_rate))
    ++			if (j % (uint32_t)(1.0f / group->sample_rate))
     +				continue;
     +
    -+			pmc = pseudo_merge_idx(pseudo_merge_commits,
    ++			pmc = pseudo_merge_idx(writer->pseudo_merge_commits,
     +					       &c->object.oid);
     +
     +			ALLOC_GROW(pmc->pseudo_merge, pmc->nr + 1, pmc->alloc);
     +
    -+			pmc->pseudo_merge[pmc->nr++] = *pseudo_merges_nr;
    ++			pmc->pseudo_merge[pmc->nr++] = writer->pseudo_merges_nr;
     +			p = commit_list_append(c, p);
     +		}
     +
    -+		bitmap_writer_push_bitmapped_commit(merge, 1);
    -+		(*pseudo_merges_nr)++;
    ++		bitmap_writer_push_commit(writer, merge, 1);
    ++		writer->pseudo_merges_nr++;
     +		if (end >= matches->unstable_nr)
     +			break;
     +	}
    @@ pseudo-merge.c
     +	QSORT(matches->unstable, matches->unstable_nr, commit_date_cmp);
     +}
     +
    -+void select_pseudo_merges(struct string_list *list,
    -+			  struct commit **commits, size_t commits_nr,
    -+			  kh_oid_map_t *pseudo_merge_commits,
    -+			  uint32_t *pseudo_merges_nr,
    -+			  unsigned show_progress)
    ++void select_pseudo_merges(struct bitmap_writer *writer,
    ++			  struct commit **commits, size_t commits_nr)
     +{
     +	struct progress *progress = NULL;
     +	uint32_t i;
     +
    -+	if (!list->nr)
    ++	if (!writer->pseudo_merge_groups.nr)
     +		return;
     +
    -+	if (show_progress)
    -+		progress = start_progress("Selecting pseudo-merge commits", list->nr);
    ++	if (writer->show_progress)
    ++		progress = start_progress("Selecting pseudo-merge commits",
    ++					  writer->pseudo_merge_groups.nr);
     +
    -+	for_each_ref(find_pseudo_merge_group_for_ref, list);
    ++	for_each_ref(find_pseudo_merge_group_for_ref, writer);
     +
    -+	for (i = 0; i < list->nr; i++) {
    ++	for (i = 0; i < writer->pseudo_merge_groups.nr; i++) {
     +		struct pseudo_merge_group *group;
     +		struct hashmap_iter iter;
     +		struct strmap_entry *e;
     +
    -+		group = list->items[i].util;
    ++		group = writer->pseudo_merge_groups.items[i].util;
     +		strmap_for_each_entry(&group->matches, &iter, e) {
     +			struct pseudo_merge_matches *matches = e->value;
     +
     +			sort_pseudo_merge_matches(matches);
     +
    -+			select_pseudo_merges_1(group, matches,
    -+					       pseudo_merge_commits,
    -+					       pseudo_merges_nr);
    ++			select_pseudo_merges_1(writer, group, matches);
     +		}
     +
     +		display_progress(progress, i + 1);
    @@ pseudo-merge.h
     +struct commit;
     +struct string_list;
     +struct bitmap_index;
    ++struct bitmap_writer;
     +
     +/*
     + * A pseudo-merge group tracks the set of non-bitmapped reference tips
    @@ pseudo-merge.h
     +	 */
     +	float decay;
     +	int max_merges;
    -+	int sample_rate;
    ++	float sample_rate;
     +	int stable_size;
     +	timestamp_t threshold;
     +	timestamp_t stable_threshold;
    @@ pseudo-merge.h
     + *
     + * Optionally shows a progress meter.
     + */
    -+void select_pseudo_merges(struct string_list *list,
    -+			  struct commit **commits, size_t commits_nr,
    -+			  kh_oid_map_t *pseudo_merge_commits,
    -+			  uint32_t *pseudo_merges_nr,
    -+			  unsigned show_progress);
    ++void select_pseudo_merges(struct bitmap_writer *writer,
    ++			  struct commit **commits, size_t commits_nr);
      
      #endif
10:  12b432e3a8a <  -:  ----------- pack-bitmap-write.c: select pseudo-merge commits
11:  6ce805d061e ! 18:  311226f65c2 pack-bitmap-write.c: write pseudo-merge table
    @@ pack-bitmap-write.c
      
      struct bitmapped_commit {
      	struct commit *commit;
    -@@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
    +@@ pack-bitmap-write.c: static void write_selected_commits_v1(struct bitmap_writer *writer,
      	}
      }
      
    -+static void write_pseudo_merges(struct hashfile *f)
    ++static void write_pseudo_merges(struct bitmap_writer *writer,
    ++				struct hashfile *f)
     +{
     +	struct oid_array commits = OID_ARRAY_INIT;
     +	struct bitmap **commits_bitmap = NULL;
     +	off_t *pseudo_merge_ofs = NULL;
     +	off_t start, table_start, next_ext;
     +
    -+	uint32_t base = bitmap_writer_selected_nr();
    ++	uint32_t base = bitmap_writer_nr_selected_commits(writer);
     +	size_t i, j = 0;
     +
    -+	CALLOC_ARRAY(commits_bitmap, writer.pseudo_merges_nr);
    -+	CALLOC_ARRAY(pseudo_merge_ofs, writer.pseudo_merges_nr);
    ++	CALLOC_ARRAY(commits_bitmap, writer->pseudo_merges_nr);
    ++	CALLOC_ARRAY(pseudo_merge_ofs, writer->pseudo_merges_nr);
     +
    -+	for (i = 0; i < writer.pseudo_merges_nr; i++) {
    -+		struct bitmapped_commit *merge = &writer.selected[base + i];
    ++	for (i = 0; i < writer->pseudo_merges_nr; i++) {
    ++		struct bitmapped_commit *merge = &writer->selected[base + i];
     +		struct commit_list *p;
     +
     +		if (!merge->pseudo_merge)
    @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
     +
     +		for (p = merge->commit->parents; p; p = p->next)
     +			bitmap_set(commits_bitmap[i],
    -+				   find_object_pos(&p->item->object.oid, NULL));
    ++				   find_object_pos(writer, &p->item->object.oid,
    ++						   NULL));
     +	}
     +
     +	start = hashfile_total(f);
     +
    -+	for (i = 0; i < writer.pseudo_merges_nr; i++) {
    ++	for (i = 0; i < writer->pseudo_merges_nr; i++) {
     +		struct ewah_bitmap *commits_ewah = bitmap_to_ewah(commits_bitmap[i]);
     +
     +		pseudo_merge_ofs[i] = hashfile_total(f);
     +
     +		dump_bitmap(f, commits_ewah);
    -+		dump_bitmap(f, writer.selected[base+i].write_as);
    ++		dump_bitmap(f, writer->selected[base+i].write_as);
     +
     +		ewah_free(commits_ewah);
     +	}
     +
     +	next_ext = st_add(hashfile_total(f),
    -+			  st_mult(kh_size(writer.pseudo_merge_commits),
    ++			  st_mult(kh_size(writer->pseudo_merge_commits),
     +				  sizeof(uint64_t)));
     +
     +	table_start = hashfile_total(f);
     +
    -+	commits.alloc = kh_size(writer.pseudo_merge_commits);
    ++	commits.alloc = kh_size(writer->pseudo_merge_commits);
     +	CALLOC_ARRAY(commits.oid, commits.alloc);
     +
    -+	for (i = kh_begin(writer.pseudo_merge_commits); i != kh_end(writer.pseudo_merge_commits); i++) {
    -+		if (!kh_exist(writer.pseudo_merge_commits, i))
    ++	for (i = kh_begin(writer->pseudo_merge_commits); i != kh_end(writer->pseudo_merge_commits); i++) {
    ++		if (!kh_exist(writer->pseudo_merge_commits, i))
     +			continue;
    -+		oid_array_append(&commits, &kh_key(writer.pseudo_merge_commits, i));
    ++		oid_array_append(&commits, &kh_key(writer->pseudo_merge_commits, i));
     +	}
     +
     +	oid_array_sort(&commits);
    @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
     +		int hash_pos;
     +		struct pseudo_merge_commit_idx *c;
     +
    -+		hash_pos = kh_get_oid_map(writer.pseudo_merge_commits,
    ++		hash_pos = kh_get_oid_map(writer->pseudo_merge_commits,
     +					  commits.oid[i]);
    -+		if (hash_pos == kh_end(writer.pseudo_merge_commits))
    ++		if (hash_pos == kh_end(writer->pseudo_merge_commits))
     +			BUG("could not find pseudo-merge commit %s",
     +			    oid_to_hex(&commits.oid[i]));
     +
    -+		c = kh_value(writer.pseudo_merge_commits, hash_pos);
    ++		c = kh_value(writer->pseudo_merge_commits, hash_pos);
     +
    -+		hashwrite_be32(f, find_object_pos(&commits.oid[i], NULL));
    ++		hashwrite_be32(f, find_object_pos(writer, &commits.oid[i],
    ++						  NULL));
     +		if (c->nr == 1)
     +			hashwrite_be64(f, pseudo_merge_ofs[c->pseudo_merge[0]]);
     +		else if (c->nr > 1) {
    @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
     +		int hash_pos;
     +		struct pseudo_merge_commit_idx *c;
     +
    -+		hash_pos = kh_get_oid_map(writer.pseudo_merge_commits,
    ++		hash_pos = kh_get_oid_map(writer->pseudo_merge_commits,
     +					  commits.oid[i]);
    -+		if (hash_pos == kh_end(writer.pseudo_merge_commits))
    ++		if (hash_pos == kh_end(writer->pseudo_merge_commits))
     +			BUG("could not find pseudo-merge commit %s",
     +			    oid_to_hex(&commits.oid[i]));
     +
    -+		c = kh_value(writer.pseudo_merge_commits, hash_pos);
    ++		c = kh_value(writer->pseudo_merge_commits, hash_pos);
     +		if (c->nr == 1)
     +			continue;
     +
    @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
     +	}
     +
     +	/* write positions for all pseudo merges */
    -+	for (i = 0; i < writer.pseudo_merges_nr; i++)
    ++	for (i = 0; i < writer->pseudo_merges_nr; i++)
     +		hashwrite_be64(f, pseudo_merge_ofs[i]);
     +
    -+	hashwrite_be32(f, writer.pseudo_merges_nr);
    -+	hashwrite_be32(f, kh_size(writer.pseudo_merge_commits));
    ++	hashwrite_be32(f, writer->pseudo_merges_nr);
    ++	hashwrite_be32(f, kh_size(writer->pseudo_merge_commits));
     +	hashwrite_be64(f, table_start - start);
     +	hashwrite_be64(f, hashfile_total(f) - start + sizeof(uint64_t));
     +
    -+	for (i = 0; i < writer.pseudo_merges_nr; i++)
    ++	for (i = 0; i < writer->pseudo_merges_nr; i++)
     +		bitmap_free(commits_bitmap[i]);
     +
     +	free(pseudo_merge_ofs);
    @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
     +
      static int table_cmp(const void *_va, const void *_vb, void *_data)
      {
    - 	uint32_t *commit_positions = _data;
    -@@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
    + 	struct bitmap_writer *writer = _data;
    +@@ pack-bitmap-write.c: void bitmap_writer_finish(struct bitmap_writer *writer,
      
      	int fd = odb_mkstemp(&tmp_file, "pack/tmp_bitmap_XXXXXX");
      
    -+	if (writer.pseudo_merges_nr)
    ++	if (writer->pseudo_merges_nr)
     +		options |= BITMAP_OPT_PSEUDO_MERGES;
     +
      	f = hashfd(fd, tmp_file.buf);
      
      	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
    -@@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
    +@@ pack-bitmap-write.c: void bitmap_writer_finish(struct bitmap_writer *writer,
      
    - 	write_selected_commits_v1(f, commit_positions, offsets);
    + 	write_selected_commits_v1(writer, f, offsets);
      
     +	if (options & BITMAP_OPT_PSEUDO_MERGES)
    -+		write_pseudo_merges(f);
    ++		write_pseudo_merges(writer, f);
     +
      	if (options & BITMAP_OPT_LOOKUP_TABLE)
    - 		write_lookup_table(f, commit_positions, offsets);
    + 		write_lookup_table(writer, f, offsets);
      
     
      ## pack-bitmap.h ##
12:  60f6b310213 = 19:  55dd7a8023e pack-bitmap: extract `read_bitmap()` function
13:  9465313691b ! 20:  3cc5434e44e pseudo-merge: scaffolding for reads
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## pseudo-merge.c ##
    -@@ pseudo-merge.c: void select_pseudo_merges(struct string_list *list,
    +@@ pseudo-merge.c: void select_pseudo_merges(struct bitmap_writer *writer,
      
      	stop_progress(&progress);
      }
    @@ pseudo-merge.c: void select_pseudo_merges(struct string_list *list,
     +}
     
      ## pseudo-merge.h ##
    -@@ pseudo-merge.h: void select_pseudo_merges(struct string_list *list,
    - 			  uint32_t *pseudo_merges_nr,
    - 			  unsigned show_progress);
    +@@ pseudo-merge.h: struct pseudo_merge_commit_idx {
    + void select_pseudo_merges(struct bitmap_writer *writer,
    + 			  struct commit **commits, size_t commits_nr);
      
     +/*
     + * Represents a serialized view of a file containing pseudo-merge(s)
14:  5894f3d5369 = 21:  7664f5f9648 pack-bitmap.c: read pseudo-merge extension
15:  7dbee8bcbdf = 22:  8ba0a9c5402 pseudo-merge: implement support for reading pseudo-merge commits
16:  09650aa53e9 = 23:  2c02f303b6f ewah: implement `ewah_bitmap_popcount()`
17:  7b5ea56d053 = 24:  82cce72bf55 pack-bitmap: implement test helpers for pseudo-merge
18:  006abdd1698 = 25:  890f6c4b9de t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
19:  3f85e5b90f5 ! 26:  41691824f78 pack-bitmap.c: use pseudo-merges during traversal
    @@ t/t5333-pseudo-merge-bitmaps.sh (new)
     +
     +test_expect_success 'bitmapPseudoMerge.sampleRate adjusts commit selection rate' '
     +	test_config bitmapPseudoMerge.test.pattern "refs/tags/" &&
    -+	test_config bitmapPseudoMerge.test.maxMerges 8 &&
    ++	test_config bitmapPseudoMerge.test.maxMerges 1 &&
     +	test_config bitmapPseudoMerge.test.stableThreshold never &&
     +
     +	commits_nr=$(git rev-list --all --count) &&
     +
    -+	for rate in 100 50 10
    ++	for rate in 1.0 0.5 0.25
     +	do
     +		git -c bitmapPseudoMerge.test.sampleRate=$rate repack -adb &&
     +
     +		test_pseudo_merges >merges &&
    -+		for i in $(test_seq 0 $(($(wc -l <merges)-1)))
    -+		do
    -+			test_pseudo_merge_commits $i || return 1
    -+		done >commits &&
    ++		test_line_count = 1 merges &&
    ++		test_pseudo_merge_commits 0 >commits &&
     +
     +		test-tool bitmap list-commits >bitmaps &&
     +		bitmaps_nr="$(wc -l <bitmaps)" &&
     +
    -+		perl -MPOSIX -e "print ceil((\$ARGV[0]/100)*(\$ARGV[1]-\$ARGV[2]))" \
    ++		perl -MPOSIX -e "print ceil(\$ARGV[0]*(\$ARGV[1]-\$ARGV[2]))" \
     +			"$rate" "$commits_nr" "$bitmaps_nr" >expect &&
     +
     +		test $(cat expect) -eq $(wc -l <commits) || return 1
20:  5fac186df64 = 27:  a34a60c3ef8 pack-bitmap: extra trace2 information
21:  b5aea8e57f8 = 28:  da2fb5b4b48 ewah: `bitmap_equals_ewah()`
22:  61ddb574285 ! 29:  ff21247281f pseudo-merge: implement support for finding existing merges
    @@ pack-bitmap-write.c
      
      struct bitmapped_commit {
      	struct commit *commit;
    -@@ pack-bitmap-write.c: static int fill_bitmap_tree(struct bitmap *bitmap,
    +@@ pack-bitmap-write.c: static int fill_bitmap_tree(struct bitmap_writer *writer,
      }
      
      static int reused_bitmaps_nr;
     +static int reused_pseudo_merge_bitmaps_nr;
      
    - static int fill_bitmap_commit(struct bb_commit *ent,
    - 			      struct commit *commit,
    -@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bb_commit *ent,
    + static int fill_bitmap_commit(struct bitmap_writer *writer,
    + 			      struct bb_commit *ent,
    +@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bitmap_writer *writer,
      			struct bitmap *remapped = bitmap_new();
      
      			if (commit->object.flags & BITMAP_PSEUDO_MERGE)
    @@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bb_commit *ent,
      			else
      				old = bitmap_for_commit(old_bitmap, c);
      			/*
    -@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bb_commit *ent,
    +@@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bitmap_writer *writer,
      			if (old && !rebuild_bitmap(mapping, old, remapped)) {
      				bitmap_or(ent->bitmap, remapped);
      				bitmap_free(remapped);
    @@ pack-bitmap-write.c: static int fill_bitmap_commit(struct bb_commit *ent,
      				continue;
      			}
      			bitmap_free(remapped);
    -@@ pack-bitmap-write.c: int bitmap_writer_build(struct packing_data *to_pack)
    +@@ pack-bitmap-write.c: int bitmap_writer_build(struct bitmap_writer *writer,
      			    the_repository);
      	trace2_data_intmax("pack-bitmap-write", the_repository,
      			   "building_bitmaps_reused", reused_bitmaps_nr);
    @@ pack-bitmap-write.c: int bitmap_writer_build(struct packing_data *to_pack)
     +			   "building_bitmaps_pseudo_merge_reused",
     +			   reused_pseudo_merge_bitmaps_nr);
      
    - 	stop_progress(&writer.progress);
    + 	stop_progress(&writer->progress);
      
     
      ## pack-bitmap.c ##
    @@ pack-bitmap.h: int rebuild_bitmap(const uint32_t *reposition,
      				      struct commit *commit);
     +struct ewah_bitmap *pseudo_merge_bitmap_for_commit(struct bitmap_index *bitmap_git,
     +						   struct commit *commit);
    - void bitmap_writer_select_commits(struct commit **indexed_commits,
    + void bitmap_writer_select_commits(struct bitmap_writer *writer,
    + 				  struct commit **indexed_commits,
      				  unsigned int indexed_commits_nr);
    - int bitmap_writer_build(struct packing_data *to_pack);
     
      ## pseudo-merge.c ##
     @@ pseudo-merge.c: int cascade_pseudo_merges(const struct pseudo_merge_map *pm,
23:  2bd830d35dd = 30:  6a6d88fa512 t/perf: implement performace tests for pseudo-merge bitmaps
-- 
2.45.1.175.gbea44add9db
