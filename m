Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B111C433EF
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiFZNKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiFZNK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:10:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823FBE22
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso4057211wml.1
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gv0amNSDvtoIt/mLiEuFr0s39WVzf+RXPe0d+7jRej4=;
        b=jnGbLCqStwS7d0jHHfK6u/UBQKY9HmJnyF15jENuULKUrDKJUVu4mXY7hcJBL9LyMT
         9+LWQwVs0Y7WrYDaxEYOO74ZnileIchckerBLnjx4ZJS14h3Nl8L5YoAdNlV+XavPiSF
         eujOB508kmVrP0z1KknOEuNOc8NQf+ZNMSJkf9iiGWPeIa008NnTfSXa01V6pTmKL8eW
         lUfUab1wnO9EdR34h+NJd8ysr6Ur4tlju1eJDBVKk2zkXYvVW9KSWXG1T65JJKb9RXec
         miYNWSZJNPHmunDN+doC/pyK2EmQ2NgSDM7el0RqgBrwWu+kG2OX4cOk55FISxHQPeWx
         r0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gv0amNSDvtoIt/mLiEuFr0s39WVzf+RXPe0d+7jRej4=;
        b=Yz9sOpKLrGZJ9PCU+3RpRk1bYEJssxfYITQNK4335Z4Dl9GYhhSiCvNGjHzYP0y9wo
         tS/D8D081YmeV0Ey6yWSjK74UQGj1XQQNXo2AcmSGDluAIZ1/r80ot8qWC2RCGH/9nQI
         lqQSjlRc4U8OLpscNsFCwQarFSSQST32E8NA73vXE/f8j865RO2Ym6CgXgbGU+2JkUlH
         Y57laKXkHmonn/D64HQDB4x/R1tSq4L8PjW0F24YEl2S1cSCCi4LaMl+FBLiTtOJRJy4
         I4zqas+GiKYlsMmRmvi9R6TMO/VqxA65Nohzj3N90nFl95sFVqb13dAK07GNop0nlsm5
         Farw==
X-Gm-Message-State: AJIora/LCowrblFfrX5xFjTj+A4KmROBS3tH7X7PgdfxgFA1ksoJJkeP
        98sx+3ZLGIxx9vImb0UX8vX0/ifD+VDvrA==
X-Google-Smtp-Source: AGRyM1vrGDdDltEj6e3GB7HDUH3yN4CySwgvVbqgjsWfA1bBvKZIuLXyS5B6XuSZsTz4Na9oVDKo5g==
X-Received: by 2002:a7b:cd15:0:b0:3a0:26f3:ee7b with SMTP id f21-20020a7bcd15000000b003a026f3ee7bmr9579958wmj.119.1656249019428;
        Sun, 26 Jun 2022 06:10:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c228200b003a03be171b1sm8103729wmf.43.2022.06.26.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 06:10:18 -0700 (PDT)
Message-Id: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Jun 2022 13:10:11 +0000
Subject: [PATCH v2 0/6] [GSoC] bitmap: integrate a lookup table extension to the bitmap format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing the .bitmap file, git loads all the bitmaps one by one even if
some of the bitmaps are not necessary. We can remove this overhead by
loading only the necessary bitmaps. A look up table extension can solve this
issue.

Changes since v1:

This is the second version which addressed all (I think) the reviews. Please
notify me if some reviews are not addressed :)

 * The table size is decreased and the format has also changed. It now
   contains nr_entries triplets of size 4+8+4 bytes. Each triplet contains
   the following things - (1) 4 byte commit position (in the pack-index or
   midx) (2) 8 byte offset and (3) 4 byte xor triplet (i.e. with whose
   bitmap the current triplet's bitmap has to xor) position.
 * Performance tests are splitted into two commits. First contains the
   actual performance tests and second enables the pack.writeReverseIndex
   (as suggested by Taylor).
 * st_*() functions are used.
 * commit order is changed according to Derrick's suggestion.
 * Iterative approach is used instead of recursive approach to parse xor
   bitmaps. (As suggested by Derrick).
 * Some minor bug fixes of previous version.

Initial version:

The proposed table has:

 * a list of nr_entries object ids. These objects are commits that has
   bitmaps. Ids are stored in lexicographic order (for better searching).
 * a list of <offset, xor-offset> pairs (4-byte integers, network-byte
   order). The i'th pair denotes the offset and xor-offset(respectively) of
   the bitmap of i'th commit in the previous list. These two informations
   are necessary because only in this way bitmaps can be found without
   parsing all the bitmap.
 * a 4-byte integer for table specific flags (none exists currently).

Whenever git want to parse the bitmap for a specific commit, it will first
refer to the table and will look for the offset and xor-offset for that
commit. Git will then try to parse the bitmap located at the offset
position. The xor-offset can be used to find the xor-bitmap for the
bitmap(if any).

Abhradeep Chakraborty (6):
  Documentation/technical: describe bitmap lookup table extension
  pack-bitmap-write.c: write lookup table extension
  pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
  pack-bitmap: prepare to read lookup table extension
  bitmap-lookup-table: add performance tests for lookup table
  p5310-pack-bitmaps.sh: enable pack.writeReverseIndex for testing

 Documentation/config/pack.txt             |   7 +
 Documentation/technical/bitmap-format.txt |  41 +++++
 builtin/multi-pack-index.c                |   8 +
 builtin/pack-objects.c                    |  10 +-
 midx.c                                    |   3 +
 midx.h                                    |   1 +
 pack-bitmap-write.c                       |  74 ++++++++-
 pack-bitmap.c                             | 193 ++++++++++++++++++++--
 pack-bitmap.h                             |   5 +-
 t/perf/p5310-pack-bitmaps.sh              |  66 ++++----
 t/perf/p5326-multi-pack-bitmaps.sh        |  93 ++++++-----
 t/t5310-pack-bitmaps.sh                   |  10 +-
 t/t5326-multi-pack-bitmaps.sh             |  14 ++
 13 files changed, 439 insertions(+), 86 deletions(-)


base-commit: 39c15e485575089eb77c769f6da02f98a55905e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1266%2FAbhra303%2Fbitmap-commit-table-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1266/Abhra303/bitmap-commit-table-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1266

Range-diff vs v1:

 1:  2e22ca5069a ! 1:  4d11be66cfa Documentation/technical: describe bitmap lookup table extension
     @@ Commit message
          When reading bitmap file, git loads each and every bitmap one by one
          even if all the bitmaps are not required. A "bitmap lookup table"
          extension to the bitmap format can reduce the overhead of loading
     -    bitmaps which stores a list of bitmapped commit oids, along with their
     -    offset and xor offset. This way git can load only the neccesary bitmaps
     -    without loading the previous bitmaps.
     +    bitmaps which stores a list of bitmapped commit id pos (in the midx
     +    or pack, along with their offset and xor offset. This way git can
     +    load only the neccesary bitmaps without loading the previous bitmaps.
     +
     +    The older version of Git ignores the lookup table extension and doesn't
     +    throw any kind of warning or error while parsing the bitmap file.
      
          Add some information for the new "bitmap lookup table" extension in the
          bitmap-format documentation.
      
     -    Co-Authored-by: Taylor Blau <ttaylorr@github.com>
     -    Mentored-by: Taylor Blau <ttaylorr@github.com>
     +    Co-Authored-by: Taylor Blau <me@ttaylorr.com>
     +    Mentored-by: Taylor Blau <me@ttaylorr.com>
          Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
     @@ Documentation/technical/bitmap-format.txt: MIDXs, both the bit-cache and rev-cac
       			described below.
       
      +			** {empty}
     -+			BITMAP_OPT_LOOKUP_TABLE (0xf) : :::
     ++			BITMAP_OPT_LOOKUP_TABLE (0x10): :::
      +			If present, the end of the bitmap file contains a table
     -+			containing a list of `N` object ids, a list of pairs of
     -+			offset and xor offset of respective objects, and 4-byte
     -+			integer denoting the flags (currently none). The format
     -+			and meaning of the table is described below.
     ++			containing a list of `N` <commit pos, offset, xor offset>
     ++			triplets. The format and meaning of the table is described
     ++			below.
     +++
     ++NOTE: This xor_offset is different from the bitmap's xor_offset.
     ++Bitmap's xor_offset is relative i.e. it tells how many bitmaps we have
     ++to go back from the current bitmap. Lookup table's xor_offset tells the
     ++position of the triplet in the list whose bitmap the current commit's
     ++bitmap have to xor with.
      +
       		4-byte entry count (network byte order)
       
     @@ Documentation/technical/bitmap-format.txt: Note that this hashing scheme is tied
      +Commit lookup table
      +-------------------
      +
     -+If the BITMAP_OPT_LOOKUP_TABLE flag is set, the end of the `.bitmap`
     -+contains a lookup table specifying the positions of commits which have a
     -+bitmap.
     ++If the BITMAP_OPT_LOOKUP_TABLE flag is set, the last `N * (4 + 8 + 4)`
     ++(preceding the name-hash cache and trailing hash) of the `.bitmap` file
     ++contains a lookup table specifying the information needed to get the
     ++desired bitmap from the entries without parsing previous unnecessary
     ++bitmaps.
      +
     -+For a `.bitmap` containing `nr_entries` reachability bitmaps, the format
     -+is as follows:
     ++For a `.bitmap` containing `nr_entries` reachability bitmaps, the table
     ++contains a list of `nr_entries` <commit pos, offset, xor offset> triplets.
     ++The content of i'th triplet is -
      +
     -+	- `nr_entries` object names.
     ++	* {empty}
     ++	commit pos (4 byte integer, network byte order): ::
     ++	It stores the object position of the commit (in the midx or pack index)
     ++	to which the i'th bitmap in the bitmap entries belongs.
      +
     -+	- `nr_entries` pairs of 4-byte integers, each in network order.
     -+	  The first holds the offset from which that commit's bitmap can
     -+	  be read. The second number holds the position of the commit
     -+	  whose bitmap the current bitmap is xor'd with in lexicographic
     -+	  order, or 0xffffffff if the current commit is not xor'd with
     -+	  anything.
     ++	* {empty}
     ++	offset (8 byte integer, network byte order): ::
     ++	The offset from which that commit's bitmap can be read.
      +
     -+	- One 4-byte network byte order integer specifying
     -+	  table-specific flags. None exist currently, so this is always
     -+	  "0".
     ++	* {empty}
     ++	xor offset (4 byte integer, network byte order): ::
     ++	It holds the position of the triplet with whose bitmap the
     ++	current bitmap need to xor. If the current triplet's bitmap
     ++	do not have any xor bitmap, it defaults to 0xffffffff.
 3:  ed91ebf69a8 ! 2:  d118f1d45e6 pack-bitmap-write.c: write lookup table extension
     @@ Metadata
       ## Commit message ##
          pack-bitmap-write.c: write lookup table extension
      
     -    Teach git to write bitmap lookup table extension. The table has the
     -    following information:
     +    The bitmap lookup table extension was documentated by an earlier
     +    change, but Git does not yet knowhow to write that extension.
      
     -        - `N` no of Object ids of each bitmapped commits
     +    Teach git to write bitmap lookup table extension. The table contains
     +    the list of `N` <commit pos, offset, xor offset>` triplets. These
     +    triplets are sorted according to their commit pos (ascending order).
     +    The meaning of each data in the i'th triplet is given below:
      
     -        - A list of offset, xor-offset pair; the i'th pair denotes the
     -          offsets and xor-offsets of i'th commit in the previous list.
     +      - Commit pos is the position of the commit in the pack-index
     +        (or midx) to which the i'th bitmap belongs. It is a 4 byte
     +        network byte order integer.
      
     -        - 4-byte integer denoting the flags
     +      - offset is the position of the i'th bitmap.
      
     -    Co-authored-by: Taylor Blau <ttaylorr@github.com>
     -    Mentored-by: Taylor Blau <ttaylorr@github.com>
     +      - xor offset denotes the position of the triplet with whose
     +        bitmap the current triplet's bitmap need to xor with.
     +
     +    Co-authored-by: Taylor Blau <me@ttaylorr.com>
     +    Mentored-by: Taylor Blau <me@ttaylorr.com>
          Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
     @@ pack-bitmap-write.c: static const struct object_id *oid_access(size_t pos, const
       				      struct pack_idx_entry **index,
      -				      uint32_t index_nr)
      +				      uint32_t index_nr,
     -+				      off_t *offsets)
     ++				      uint64_t *offsets,
     ++				      uint32_t *commit_positions)
       {
       	int i;
       
     @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
       
      +		if (offsets)
      +			offsets[i] = hashfile_total(f);
     ++		if (commit_positions)
     ++			commit_positions[i] = commit_pos;
      +
       		hashwrite_be32(f, commit_pos);
       		hashwrite_u8(f, stored->xor_offset);
     @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
       	}
       }
       
     -+static int table_cmp(const void *_va, const void *_vb)
     ++static int table_cmp(const void *_va, const void *_vb, void *commit_positions)
      +{
     -+	return oidcmp(&writer.selected[*(uint32_t*)_va].commit->object.oid,
     -+		      &writer.selected[*(uint32_t*)_vb].commit->object.oid);
     ++	int8_t result = 0;
     ++	uint32_t *positions = (uint32_t *) commit_positions;
     ++	uint32_t a = positions[*(uint32_t *)_va];
     ++	uint32_t b = positions[*(uint32_t *)_vb];
     ++
     ++	if (a > b)
     ++		result = 1;
     ++	else if (a < b)
     ++		result = -1;
     ++	else
     ++		result = 0;
     ++
     ++	return result;
      +}
      +
      +static void write_lookup_table(struct hashfile *f,
     -+			       off_t *offsets)
     ++			       uint64_t *offsets,
     ++			       uint32_t *commit_positions)
      +{
      +	uint32_t i;
     -+	uint32_t flags = 0;
      +	uint32_t *table, *table_inv;
      +
      +	ALLOC_ARRAY(table, writer.selected_nr);
     @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
      +
      +	for (i = 0; i < writer.selected_nr; i++)
      +		table[i] = i;
     -+	QSORT(table, writer.selected_nr, table_cmp);
     ++
     ++	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
     ++
      +	for (i = 0; i < writer.selected_nr; i++)
      +		table_inv[table[i]] = i;
      +
      +	for (i = 0; i < writer.selected_nr; i++) {
      +		struct bitmapped_commit *selected = &writer.selected[table[i]];
     -+		struct object_id *oid = &selected->commit->object.oid;
     ++		uint32_t xor_offset = selected->xor_offset;
      +
     -+		hashwrite(f, oid->hash, the_hash_algo->rawsz);
     ++		hashwrite_be32(f, commit_positions[table[i]]);
     ++		hashwrite_be64(f, offsets[table[i]]);
     ++		hashwrite_be32(f, xor_offset ?
     ++				table_inv[table[i] - xor_offset]: 0xffffffff);
      +	}
     -+	for (i = 0; i < writer.selected_nr; i++) {
     -+		struct bitmapped_commit *selected = &writer.selected[table[i]];
     -+
     -+		hashwrite_be32(f, offsets[table[i]]);
     -+		hashwrite_be32(f, selected->xor_offset
     -+			       ? table_inv[table[i] - selected->xor_offset]
     -+			       : 0xffffffff);
     -+	}
     -+
     -+	hashwrite_be32(f, flags);
      +
      +	free(table);
      +	free(table_inv);
     @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
       {
       	static uint16_t default_version = 1;
       	static uint16_t flags = BITMAP_OPT_FULL_DAG;
     -+	off_t *offsets = NULL;
     ++	uint64_t *offsets = NULL;
     ++	uint32_t *commit_positions = NULL;
       	struct strbuf tmp_file = STRBUF_INIT;
       	struct hashfile *f;
       
     @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
       	dump_bitmap(f, writer.tags);
      -	write_selected_commits_v1(f, index, index_nr);
       
     -+	if (options & BITMAP_OPT_LOOKUP_TABLE)
     ++	if (options & BITMAP_OPT_LOOKUP_TABLE) {
      +		CALLOC_ARRAY(offsets, index_nr);
     ++		CALLOC_ARRAY(commit_positions, index_nr);
     ++	}
      +
     -+	write_selected_commits_v1(f, index, index_nr, offsets);
     ++	write_selected_commits_v1(f, index, index_nr, offsets, commit_positions);
      +
      +	if (options & BITMAP_OPT_LOOKUP_TABLE)
     -+		write_lookup_table(f, offsets);
     ++		write_lookup_table(f, offsets, commit_positions);
       	if (options & BITMAP_OPT_HASH_CACHE)
       		write_hash_cache(f, index, index_nr);
       
     @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
       
       	strbuf_release(&tmp_file);
      +	free(offsets);
     ++	free(commit_positions);
       }
     +
     + ## pack-bitmap.h ##
     +@@ pack-bitmap.h: struct bitmap_disk_header {
     + #define NEEDS_BITMAP (1u<<22)
     + 
     + enum pack_bitmap_opts {
     +-	BITMAP_OPT_FULL_DAG = 1,
     +-	BITMAP_OPT_HASH_CACHE = 4,
     ++	BITMAP_OPT_FULL_DAG = 0x1,
     ++	BITMAP_OPT_HASH_CACHE = 0x4,
     ++	BITMAP_OPT_LOOKUP_TABLE = 0x10,
     + };
     + 
     + enum pack_bitmap_flags {
 4:  661c1137e1c ! 3:  7786dc879f0 builtin/pack-objects.c: learn pack.writeBitmapLookupTable
     @@
       ## Metadata ##
     -Author: Taylor Blau <ttaylorr@github.com>
     +Author: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## Commit message ##
     -    builtin/pack-objects.c: learn pack.writeBitmapLookupTable
     +    pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
      
          Teach git to provide a way for users to enable/disable bitmap lookup
          table extension by providing a config option named 'writeBitmapLookupTable'.
     +    Default is true.
      
     -    Signed-off-by: Taylor Blau <ttaylorr@github.com>
     +    Also add test to verify writting of lookup table.
     +
     +    Co-Authored-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
     +    Mentored-by: Taylor Blau <me@ttaylorr.com>
     +    Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
      
       ## Documentation/config/pack.txt ##
      @@ Documentation/config/pack.txt: When writing a multi-pack reachability bitmap, no new namehashes are
     @@ Documentation/config/pack.txt: When writing a multi-pack reachability bitmap, no
      +	bitmap index (if one is written). This table is used to defer
      +	loading individual bitmaps as late as possible. This can be
      +	beneficial in repositories which have relatively large bitmap
     -+	indexes. Defaults to false.
     ++	indexes. Defaults to true.
      +
       pack.writeReverseIndex::
       	When true, git will write a corresponding .rev file (see:
       	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
      
     + ## builtin/multi-pack-index.c ##
     +@@ builtin/multi-pack-index.c: static int git_multi_pack_index_write_config(const char *var, const char *value,
     + 			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
     + 	}
     + 
     ++	if (!strcmp(var, "pack.writebitmaplookuptable")) {
     ++		if (git_config_bool(var, value))
     ++			opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
     ++		else
     ++			opts.flags &= ~MIDX_WRITE_BITMAP_LOOKUP_TABLE;
     ++	}
     ++
     + 	/*
     + 	 * We should never make a fall-back call to 'git_default_config', since
     + 	 * this was already called in 'cmd_multi_pack_index()'.
     +@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, const char **argv)
     + 	};
     + 
     + 	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
     ++	opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
     + 
     + 	git_config(git_multi_pack_index_write_config, NULL);
     + 
     +
       ## builtin/pack-objects.c ##
     +@@ builtin/pack-objects.c: static enum {
     + 	WRITE_BITMAP_QUIET,
     + 	WRITE_BITMAP_TRUE,
     + } write_bitmap_index;
     +-static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
     ++static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE | BITMAP_OPT_LOOKUP_TABLE;
     + 
     + static int exclude_promisor_objects;
     + 
      @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v, void *cb)
       		else
       			write_bitmap_options &= ~BITMAP_OPT_HASH_CACHE;
     @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
       	if (!strcmp(k, "pack.usebitmaps")) {
       		use_bitmap_index_default = git_config_bool(k, v);
       		return 0;
     +
     + ## midx.c ##
     +@@ midx.c: static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
     + 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
     + 		options |= BITMAP_OPT_HASH_CACHE;
     + 
     ++	if (flags & MIDX_WRITE_BITMAP_LOOKUP_TABLE)
     ++		options |= BITMAP_OPT_LOOKUP_TABLE;
     ++
     + 	prepare_midx_packing_data(&pdata, ctx);
     + 
     + 	commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, ctx);
     +
     + ## midx.h ##
     +@@ midx.h: struct multi_pack_index {
     + #define MIDX_WRITE_REV_INDEX (1 << 1)
     + #define MIDX_WRITE_BITMAP (1 << 2)
     + #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
     ++#define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
     + 
     + const unsigned char *get_midx_checksum(struct multi_pack_index *m);
     + void get_midx_filename(struct strbuf *out, const char *object_dir);
     +
     + ## pack-bitmap-write.c ##
     +@@ pack-bitmap-write.c: static void write_lookup_table(struct hashfile *f,
     + 	for (i = 0; i < writer.selected_nr; i++)
     + 		table_inv[table[i]] = i;
     + 
     ++	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
     + 	for (i = 0; i < writer.selected_nr; i++) {
     + 		struct bitmapped_commit *selected = &writer.selected[table[i]];
     + 		uint32_t xor_offset = selected->xor_offset;
     +@@ pack-bitmap-write.c: static void write_lookup_table(struct hashfile *f,
     + 
     + 	free(table);
     + 	free(table_inv);
     ++	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", the_repository);
     + }
     + 
     + static void write_hash_cache(struct hashfile *f,
     +
     + ## t/t5310-pack-bitmaps.sh ##
     +@@ t/t5310-pack-bitmaps.sh: test_expect_success 'full repack creates bitmaps' '
     + 	ls .git/objects/pack/ | grep bitmap >output &&
     + 	test_line_count = 1 output &&
     + 	grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
     +-	grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
     ++	grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace &&
     ++	grep "\"label\":\"writing_lookup_table\"" trace
     + '
     + 
     + basic_bitmap_tests
     +
     + ## t/t5326-multi-pack-bitmaps.sh ##
     +@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'graceful fallback when missing reverse index' '
     + 	)
     + '
     + 
     ++test_expect_success 'multi-pack-index write writes lookup table if enabled' '
     ++	rm -fr repo &&
     ++	git init repo &&
     ++	test_when_finished "rm -fr repo" &&
     ++	(
     ++		cd repo &&
     ++		test_commit base &&
     ++		git repack -ad &&
     ++		GIT_TRACE2_EVENT="$(pwd)/trace" \
     ++			git multi-pack-index write --bitmap &&
     ++		grep "\"label\":\"writing_lookup_table\"" trace
     ++	)
     ++'
     + test_done
 2:  d139a4c48aa ! 4:  4fbfcff8a20 pack-bitmap: prepare to read lookup table extension
     @@ Metadata
       ## Commit message ##
          pack-bitmap: prepare to read lookup table extension
      
     -    Bitmap lookup table extension can let git to parse only the necessary
     -    bitmaps without loading the previous bitmaps one by one.
     +    Earlier change teaches Git to write bitmap lookup table. But Git
     +    does not know how to parse them.
      
     -    Teach git to read and use the bitmap lookup table extension.
     +    Teach Git to parse the existing bitmap lookup table. The older
     +    versions of git are not affected by it. Those versions ignore the
     +    lookup table.
      
     -    Co-Authored-by: Taylor Blau <ttaylorr@github.com>
     -    Mentored-by: Taylor Blau <ttaylorr@github.com>
     -    Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
     +    Mentored-by: Taylor Blau <me@ttaylorr.com>
     +    Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
      
       ## pack-bitmap.c ##
     -@@
     - #include "list-objects-filter-options.h"
     - #include "midx.h"
     - #include "config.h"
     -+#include "hash-lookup.h"
     - 
     - /*
     -  * An entry on the bitmap index, representing the bitmap for a given
      @@ pack-bitmap.c: struct bitmap_index {
       	/* The checksum of the packfile or MIDX; points into map. */
       	const unsigned char *checksum;
       
      +	/*
     -+	 * If not NULL, these point into the various commit table sections
     ++	 * If not NULL, this point into the commit table extension
      +	 * (within map).
      +	 */
      +	unsigned char *table_lookup;
     -+	unsigned char *table_offsets;
      +
       	/*
       	 * Extended index.
     @@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *index)
       		}
      +
      +		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
     -+		    git_env_bool("GIT_READ_COMMIT_TABLE", 1)) {
     -+			uint32_t entry_count = ntohl(header->entry_count);
     -+			uint32_t table_size =
     -+				(entry_count * the_hash_algo->rawsz) /* oids */ +
     -+				(entry_count * sizeof(uint32_t)) /* offsets */ +
     -+				(entry_count * sizeof(uint32_t)) /* xor offsets */ +
     -+				(sizeof(uint32_t)) /* flags */;
     ++			git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1)) {
     ++			size_t table_size = 0;
     ++			size_t triplet_sz = st_add3(sizeof(uint32_t),    /* commit position */
     ++							sizeof(uint64_t),    /* offset */
     ++							sizeof(uint32_t));    /* xor offset */
      +
     ++			table_size = st_add(table_size,
     ++					st_mult(ntohl(header->entry_count),
     ++						triplet_sz));
      +			if (table_size > index_end - index->map - header_size)
     -+				return error("corrupted bitmap index file (too short to fit commit table)");
     -+
     ++				return error("corrupted bitmap index file (too short to fit lookup table)");
      +			index->table_lookup = (void *)(index_end - table_size);
     -+			index->table_offsets = index->table_lookup + the_hash_algo->rawsz * entry_count;
     -+
      +			index_end -= table_size;
      +		}
       	}
       
       	index->entry_count = ntohl(header->entry_count);
     +@@ pack-bitmap.c: static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
     + 
     + 	hash_pos = kh_put_oid_map(index->bitmaps, stored->oid, &ret);
     + 
     +-	/* a 0 return code means the insertion succeeded with no changes,
     +-	 * because the SHA1 already existed on the map. this is bad, there
     +-	 * shouldn't be duplicated commits in the index */
     ++	/* A 0 return code means the insertion succeeded with no changes,
     ++	 * because the SHA1 already existed on the map. If lookup table
     ++	 * is NULL, this is bad, there shouldn't be duplicated commits
     ++	 * in the index.
     ++	 *
     ++	 * If table_lookup exists, that means the desired bitmap is already
     ++	 * loaded. Either this bitmap has been stored directly or another
     ++	 * bitmap has a direct or indirect xor relation with it. */
     + 	if (ret == 0) {
     +-		error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
     +-		return NULL;
     ++		if (!index->table_lookup) {
     ++			error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
     ++			return NULL;
     ++		}
     ++		return kh_value(index->bitmaps, hash_pos);
     + 	}
     + 
     + 	kh_value(index->bitmaps, hash_pos) = stored;
      @@ pack-bitmap.c: static int load_bitmap(struct bitmap_index *bitmap_git)
       		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
       		goto failed;
     @@ pack-bitmap.c: struct include_data {
       	struct bitmap *seen;
       };
       
     --struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
     --				      struct commit *commit)
     -+static struct stored_bitmap *stored_bitmap_for_commit(struct bitmap_index *bitmap_git,
     -+						      struct commit *commit,
     -+						      uint32_t *pos_hint);
     -+
     -+static inline const unsigned char *bitmap_oid_pos(struct bitmap_index *bitmap_git,
     -+						  uint32_t pos)
     ++static inline const void *bitmap_get_triplet(struct bitmap_index *bitmap_git, uint32_t xor_pos)
      +{
     -+	return bitmap_git->table_lookup + (pos * the_hash_algo->rawsz);
     ++	size_t triplet_sz = st_add3(sizeof(uint32_t), sizeof(uint64_t), sizeof(uint32_t));
     ++	const void *p = bitmap_git->table_lookup + st_mult(xor_pos, triplet_sz);
     ++	return p;
      +}
      +
     -+static inline const void *bitmap_offset_pos(struct bitmap_index *bitmap_git,
     -+					    uint32_t pos)
     ++static uint64_t triplet_get_offset(const void *triplet)
      +{
     -+	return bitmap_git->table_offsets + (pos * 2 * sizeof(uint32_t));
     ++	const void *p = (unsigned char*) triplet + sizeof(uint32_t);
     ++	return get_be64(p);
      +}
      +
     -+static inline const void *xor_position_pos(struct bitmap_index *bitmap_git,
     -+					   uint32_t pos)
     ++static uint32_t triplet_get_xor_pos(const void *triplet)
      +{
     -+	return (unsigned char*) bitmap_offset_pos(bitmap_git, pos) + sizeof(uint32_t);
     ++	const void *p = (unsigned char*) triplet + st_add(sizeof(uint32_t), sizeof(uint64_t));
     ++	return get_be32(p);
      +}
      +
     -+static int bitmap_lookup_cmp(const void *_va, const void *_vb)
     ++static int triplet_cmp(const void *va, const void *vb)
      +{
     -+	return hashcmp(_va, _vb);
     ++	int result = 0;
     ++	uint32_t *a = (uint32_t *) va;
     ++	uint32_t b = get_be32(vb);
     ++	if (*a > b)
     ++		result = 1;
     ++	else if (*a < b)
     ++		result = -1;
     ++	else
     ++		result = 0;
     ++
     ++	return result;
      +}
      +
     -+static int bitmap_table_lookup(struct bitmap_index *bitmap_git,
     -+			       struct object_id *oid,
     -+			       uint32_t *commit_pos)
     ++static uint32_t bsearch_pos(struct bitmap_index *bitmap_git, struct object_id *oid,
     ++						uint32_t *result)
      +{
     -+	unsigned char *found = bsearch(oid->hash, bitmap_git->table_lookup,
     -+				       bitmap_git->entry_count,
     -+				       the_hash_algo->rawsz, bitmap_lookup_cmp);
     -+	if (found)
     -+		*commit_pos = (found - bitmap_git->table_lookup) / the_hash_algo->rawsz;
     -+	return !!found;
     ++	int found;
     ++
     ++	if (bitmap_git->midx)
     ++		found = bsearch_midx(oid, bitmap_git->midx, result);
     ++	else
     ++		found = bsearch_pack(oid, bitmap_git->pack, result);
     ++
     ++	return found;
      +}
      +
      +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
     -+						    struct object_id *oid,
     -+						    uint32_t commit_pos)
     ++					  struct commit *commit)
      +{
     -+	uint32_t xor_pos;
     -+	off_t bitmap_ofs;
     -+
     ++	uint32_t commit_pos, xor_pos;
     ++	uint64_t offset;
      +	int flags;
     ++	const void *triplet = NULL;
     ++	struct object_id *oid = &commit->object.oid;
      +	struct ewah_bitmap *bitmap;
     -+	struct stored_bitmap *xor_bitmap;
     ++	struct stored_bitmap *xor_bitmap = NULL;
     ++	size_t triplet_sz = st_add3(sizeof(uint32_t), sizeof(uint64_t), sizeof(uint32_t));
      +
     -+	bitmap_ofs = get_be32(bitmap_offset_pos(bitmap_git, commit_pos));
     -+	xor_pos = get_be32(xor_position_pos(bitmap_git, commit_pos));
     ++	int found = bsearch_pos(bitmap_git, oid, &commit_pos);
      +
     -+	/*
     -+	 * Lazily load the xor'd bitmap if required (and we haven't done so
     -+	 * already). Make sure to pass the xor'd bitmap's position along as a
     -+	 * hint to avoid an unnecessary binary search in
     -+	 * stored_bitmap_for_commit().
     -+	 */
     -+	if (xor_pos == 0xffffffff) {
     -+		xor_bitmap = NULL;
     -+	} else {
     -+		struct commit *xor_commit;
     ++	if (!found)
     ++		return NULL;
     ++
     ++	triplet = bsearch(&commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
     ++						triplet_sz, triplet_cmp);
     ++	if (!triplet)
     ++		return NULL;
     ++
     ++	offset = triplet_get_offset(triplet);
     ++	xor_pos = triplet_get_xor_pos(triplet);
     ++
     ++	if (xor_pos != 0xffffffff) {
     ++		int xor_flags;
     ++		uint64_t offset_xor;
     ++		uint32_t *xor_positions;
      +		struct object_id xor_oid;
     ++		size_t size = 0;
      +
     -+		oidread(&xor_oid, bitmap_oid_pos(bitmap_git, xor_pos));
     ++		ALLOC_ARRAY(xor_positions, bitmap_git->entry_count);
     ++		while (xor_pos != 0xffffffff) {
     ++			xor_positions[size++] = xor_pos;
     ++			triplet = bitmap_get_triplet(bitmap_git, xor_pos);
     ++			xor_pos = triplet_get_xor_pos(triplet);
     ++		}
      +
     -+		xor_commit = lookup_commit(the_repository, &xor_oid);
     -+		if (!xor_commit)
     -+			return NULL;
     ++		while (size){
     ++			xor_pos = xor_positions[size - 1];
     ++			triplet = bitmap_get_triplet(bitmap_git, xor_pos);
     ++			commit_pos = get_be32(triplet);
     ++			offset_xor = triplet_get_offset(triplet);
     ++
     ++			if (nth_bitmap_object_oid(bitmap_git, &xor_oid, commit_pos) < 0) {
     ++				free(xor_positions);
     ++				return NULL;
     ++			}
     ++
     ++			bitmap_git->map_pos = offset_xor + sizeof(uint32_t) + sizeof(uint8_t);
     ++			xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
     ++			bitmap = read_bitmap_1(bitmap_git);
     ++
     ++			if (!bitmap){
     ++				free(xor_positions);
     ++				return NULL;
     ++			}
     ++
     ++			xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_oid, xor_bitmap, xor_flags);
     ++			size--;
     ++		}
      +
     -+		xor_bitmap = stored_bitmap_for_commit(bitmap_git, xor_commit,
     -+						      &xor_pos);
     ++		free(xor_positions);
      +	}
      +
     -+	/*
     -+	 * Don't bother reading the commit's index position or its xor
     -+	 * offset:
     -+	 *
     -+	 *   - The commit's index position is irrelevant to us, since
     -+	 *     load_bitmap_entries_v1 only uses it to learn the object
     -+	 *     id which is used to compute the hashmap's key. We already
     -+	 *     have an object id, so no need to look it up again.
     -+	 *
     -+	 *   - The xor_offset is unusable for us, since it specifies how
     -+	 *     many entries previous to ours we should look at. This
     -+	 *     makes sense when reading the bitmaps sequentially (as in
     -+	 *     load_bitmap_entries_v1()), since we can keep track of
     -+	 *     each bitmap as we read them.
     -+	 *
     -+	 *     But it can't work for us, since the bitmap's don't have a
     -+	 *     fixed size. So we learn the position of the xor'd bitmap
     -+	 *     from the commit table (and resolve it to a bitmap in the
     -+	 *     above if-statement).
     -+	 *
     -+	 * Instead, we can skip ahead and immediately read the flags and
     -+	 * ewah bitmap.
     -+	 */
     -+	bitmap_git->map_pos = bitmap_ofs + sizeof(uint32_t) + sizeof(uint8_t);
     ++	bitmap_git->map_pos = offset + sizeof(uint32_t) + sizeof(uint8_t);
      +	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
      +	bitmap = read_bitmap_1(bitmap_git);
     ++
      +	if (!bitmap)
      +		return NULL;
      +
      +	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
      +}
      +
     -+static struct stored_bitmap *stored_bitmap_for_commit(struct bitmap_index *bitmap_git,
     -+						      struct commit *commit,
     -+						      uint32_t *pos_hint)
     + struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
     + 				      struct commit *commit)
       {
       	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
       					   commit->object.oid);
      -	if (hash_pos >= kh_end(bitmap_git->bitmaps))
     +-		return NULL;
      +	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
     -+		uint32_t commit_pos;
     ++		struct stored_bitmap *bitmap = NULL;
      +		if (!bitmap_git->table_lookup)
      +			return NULL;
      +
     -+		/* NEEDSWORK: cache misses aren't recorded. */
     -+		if (pos_hint)
     -+			commit_pos = *pos_hint;
     -+		else if (!bitmap_table_lookup(bitmap_git,
     -+					      &commit->object.oid,
     -+					      &commit_pos))
     ++		/* NEEDSWORK: cache misses aren't recorded */
     ++		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
     ++		if(!bitmap)
      +			return NULL;
     -+		return lazy_bitmap_for_commit(bitmap_git, &commit->object.oid,
     -+					      commit_pos);
     ++		return lookup_stored_bitmap(bitmap);
      +	}
     -+	return kh_value(bitmap_git->bitmaps, hash_pos);
     -+}
     -+
     -+struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
     -+				      struct commit *commit)
     -+{
     -+	struct stored_bitmap *sb = stored_bitmap_for_commit(bitmap_git, commit,
     -+							    NULL);
     -+	if (!sb)
     - 		return NULL;
     --	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
     -+	return lookup_stored_bitmap(sb);
     + 	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
       }
       
     - static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
      @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
       	if (revs->pending.nr != 1)
       		die("you must specify exactly one commit to test");
       
      -	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
     --		bitmap_git->version, bitmap_git->entry_count);
     ++	fprintf(stderr, "Bitmap v%d test (%d entries)\n",
     + 		bitmap_git->version, bitmap_git->entry_count);
     + 
      +	if (!bitmap_git->table_lookup)
      +		fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
      +			bitmap_git->version, bitmap_git->entry_count);
     - 
     ++
       	root = revs->pending.objects[0].item;
       	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
     + 
     +@@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
     + 
     + int test_bitmap_commits(struct repository *r)
     + {
     +-	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
     ++	struct bitmap_index *bitmap_git = NULL;
     + 	struct object_id oid;
     + 	MAYBE_UNUSED void *value;
     + 
     ++	/* As this function is only used to print bitmap selected
     ++	 * commits, we don't have to read the commit table.
     ++	 */
     ++	setenv("GIT_TEST_READ_COMMIT_TABLE", "0", 1);
     ++
     ++	bitmap_git = prepare_bitmap_git(r);
     + 	if (!bitmap_git)
     + 		die("failed to load bitmap indexes");
     + 
     +@@ pack-bitmap.c: int test_bitmap_commits(struct repository *r)
     + 		printf("%s\n", oid_to_hex(&oid));
     + 	});
     + 
     ++	setenv("GIT_TEST_READ_COMMIT_TABLE", "1", 1);
     + 	free_bitmap_index(bitmap_git);
     + 
     + 	return 0;
      
     - ## pack-bitmap.h ##
     -@@ pack-bitmap.h: struct bitmap_disk_header {
     - enum pack_bitmap_opts {
     - 	BITMAP_OPT_FULL_DAG = 1,
     - 	BITMAP_OPT_HASH_CACHE = 4,
     -+	BITMAP_OPT_LOOKUP_TABLE = 16,
     - };
     + ## t/t5310-pack-bitmaps.sh ##
     +@@ t/t5310-pack-bitmaps.sh: test_expect_success 'full repack creates bitmaps' '
     + 	grep "\"label\":\"writing_lookup_table\"" trace
     + '
     + 
     ++test_expect_success 'using lookup table loads only necessary bitmaps' '
     ++	git rev-list --test-bitmap HEAD 2>out &&
     ++	! grep "Bitmap v1 test (106 entries loaded)" out &&
     ++	grep "Found bitmap for" out
     ++'
     ++
     + basic_bitmap_tests
       
     - enum pack_bitmap_flags {
     + test_expect_success 'incremental repack fails when bitmaps are requested' '
     +@@ t/t5310-pack-bitmaps.sh: test_expect_success 'pack reuse respects --incremental' '
     + 
     + test_expect_success 'truncated bitmap fails gracefully (ewah)' '
     + 	test_config pack.writebitmaphashcache false &&
     ++	test_config pack.writebitmaplookuptable false &&
     + 	git repack -ad &&
     + 	git rev-list --use-bitmap-index --count --all >expect &&
     + 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
     +
     + ## t/t5326-multi-pack-bitmaps.sh ##
     +@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'multi-pack-index write writes lookup table if enabled' '
     + 		grep "\"label\":\"writing_lookup_table\"" trace
     + 	)
     + '
     ++
     + test_done
 5:  a404779a30f < -:  ----------- bitmap-commit-table: add tests for the bitmap lookup table
 6:  f5f725a3fe2 ! 5:  96c0041688f bitmap-lookup-table: add performance tests
     @@ Metadata
      Author: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## Commit message ##
     -    bitmap-lookup-table: add performance tests
     +    bitmap-lookup-table: add performance tests for lookup table
      
     -    Add performance tests for bitmap lookup table extension.
     +    Add performance tests to verify the performance of lookup table.
     +
     +    Lookup table makes Git run faster in most of the cases. Below is the
     +    result of `t/perf/p5310-pack-bitmaps.sh`.`perf/p5326-multi-pack-bitmaps.sh`
     +    gives similar result. The repository used in the test is linux kernel.
     +
     +    Test                                                      this tree
     +    --------------------------------------------------------------------------
     +    5310.4: repack to disk (lookup=false)                   295.94(250.45+15.24)
     +    5310.5: simulated clone                                 12.52(5.07+1.40)
     +    5310.6: simulated fetch                                 1.89(2.94+0.24)
     +    5310.7: pack to file (bitmap)                           41.39(20.33+7.20)
     +    5310.8: rev-list (commits)                              0.98(0.59+0.12)
     +    5310.9: rev-list (objects)                              3.40(3.27+0.10)
     +    5310.10: rev-list with tag negated via --not            0.07(0.02+0.04)
     +             --all (objects)
     +    5310.11: rev-list with negative tag (objects)           0.23(0.16+0.06)
     +    5310.12: rev-list count with blob:none                  0.26(0.18+0.07)
     +    5310.13: rev-list count with blob:limit=1k              6.45(5.94+0.37)
     +    5310.14: rev-list count with tree:0                     0.26(0.18+0.07)
     +    5310.15: simulated partial clone                        4.99(3.19+0.45)
     +    5310.19: repack to disk (lookup=true)                   269.67(174.70+21.33)
     +    5310.20: simulated clone                                11.03(5.07+1.11)
     +    5310.21: simulated fetch                                0.79(0.79+0.17)
     +    5310.22: pack to file (bitmap)                          43.03(20.28+7.43)
     +    5310.23: rev-list (commits)                             0.86(0.54+0.09)
     +    5310.24: rev-list (objects)                             3.35(3.26+0.07)
     +    5310.25: rev-list with tag negated via --not            0.05(0.00+0.03)
     +             --all (objects)
     +    5310.26: rev-list with negative tag (objects)           0.22(0.16+0.05)
     +    5310.27: rev-list count with blob:none                  0.22(0.16+0.05)
     +    5310.28: rev-list count with blob:limit=1k              6.45(5.87+0.31)
     +    5310.29: rev-list count with tree:0                     0.22(0.16+0.05)
     +    5310.30: simulated partial clone                        5.17(3.12+0.48)
     +
     +    Test 4-15 are tested without using lookup table. Same tests are
     +    repeated in 16-30 (using lookup table).
      
     -    Mentored-by: Taylor Blau <ttaylorr@github.com>
     -    Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
     +    Mentored-by: Taylor Blau <me@ttaylorr.com>
     +    Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
      
       ## t/perf/p5310-pack-bitmaps.sh ##
     -@@ t/perf/p5310-pack-bitmaps.sh: test_perf_large_repo
     - # since we want to be able to compare bitmap-aware
     - # git versus non-bitmap git
     - #
     --# We intentionally use the deprecated pack.writebitmaps
     -+# We intentionally use the deprecated pack.writeBitmaps
     - # config so that we can test against older versions of git.
     - test_expect_success 'setup bitmap config' '
     --	git config pack.writebitmaps true
     -+	git config pack.writeBitmaps true &&
     -+	git config pack.writeReverseIndex true
     +@@ t/perf/p5310-pack-bitmaps.sh: test_expect_success 'setup bitmap config' '
     + 	git config pack.writebitmaps true
       '
       
     - # we need to create the tag up front such that it is covered by the repack and
     -@@ t/perf/p5310-pack-bitmaps.sh: test_perf 'repack to disk' '
     - 
     - test_full_bitmap
     - 
     +-# we need to create the tag up front such that it is covered by the repack and
     +-# thus by generated bitmaps.
     +-test_expect_success 'create tags' '
     +-	git tag --message="tag pointing to HEAD" perf-tag HEAD
     +-'
     +-
     +-test_perf 'repack to disk' '
     +-	git repack -ad
     +-'
     +-
     +-test_full_bitmap
     +-
      -test_expect_success 'create partial bitmap state' '
      -	# pick a commit to represent the repo tip in the past
      -	cutoff=$(git rev-list HEAD~100 -1) &&
     @@ t/perf/p5310-pack-bitmaps.sh: test_perf 'repack to disk' '
      -	# and now restore our original tip, as if the pushes
      -	# had happened
      -	git update-ref HEAD $orig_tip
     -+test_perf 'use lookup table' '
     -+    git config pack.writeBitmapLookupTable true
     - '
     - 
     +-'
     +-
      -test_partial_bitmap
     -+test_perf 'repack to disk (lookup table)' '
     -+    git repack -adb
     -+'
     ++test_bitmap () {
     ++    local enabled="$1"
      +
     -+test_full_bitmap
     ++	# we need to create the tag up front such that it is covered by the repack and
     ++	# thus by generated bitmaps.
     ++	test_expect_success 'create tags' '
     ++		git tag --message="tag pointing to HEAD" perf-tag HEAD
     ++	'
      +
     -+for i in false true
     -+do
     -+	$i && lookup=" (lookup table)"
     -+	test_expect_success "create partial bitmap state$lookup" '
     -+		git config pack.writeBitmapLookupTable '"$i"' &&
     ++	test_expect_success "use lookup table: $enabled" '
     ++		git config pack.writeBitmapLookupTable '"$enabled"'
     ++	'
     ++
     ++	test_perf "repack to disk (lookup=$enabled)" '
     ++		git repack -ad
     ++	'
     ++
     ++	test_full_bitmap
     ++
     ++    test_expect_success "create partial bitmap state (lookup=$enabled)" '
      +		# pick a commit to represent the repo tip in the past
      +		cutoff=$(git rev-list HEAD~100 -1) &&
      +		orig_tip=$(git rev-parse HEAD) &&
     @@ t/perf/p5310-pack-bitmaps.sh: test_perf 'repack to disk' '
      +		# and now restore our original tip, as if the pushes
      +		# had happened
      +		git update-ref HEAD $orig_tip
     -+	'
     ++    '
     ++}
      +
     -+	test_partial_bitmap
     -+done
     ++test_bitmap false
     ++test_bitmap true
       
       test_done
      
       ## t/perf/p5326-multi-pack-bitmaps.sh ##
     -@@ t/perf/p5326-multi-pack-bitmaps.sh: test_expect_success 'drop pack bitmap' '
     +@@ t/perf/p5326-multi-pack-bitmaps.sh: test_description='Tests performance using midx bitmaps'
       
     - test_full_bitmap
     + test_perf_large_repo
       
     +-# we need to create the tag up front such that it is covered by the repack and
     +-# thus by generated bitmaps.
     +-test_expect_success 'create tags' '
     +-	git tag --message="tag pointing to HEAD" perf-tag HEAD
     +-'
     +-
     +-test_expect_success 'start with bitmapped pack' '
     +-	git repack -adb
     +-'
     +-
     +-test_perf 'setup multi-pack index' '
     +-	git multi-pack-index write --bitmap
     +-'
     +-
     +-test_expect_success 'drop pack bitmap' '
     +-	rm -f .git/objects/pack/pack-*.bitmap
     +-'
     +-
     +-test_full_bitmap
     +-
      -test_expect_success 'create partial bitmap state' '
      -	# pick a commit to represent the repo tip in the past
      -	cutoff=$(git rev-list HEAD~100 -1) &&
     @@ t/perf/p5326-multi-pack-bitmaps.sh: test_expect_success 'drop pack bitmap' '
      -	# and now restore our original tip, as if the pushes
      -	# had happened
      -	git update-ref HEAD $orig_tip
     -+test_expect_success 'use lookup table' '
     -+	git config pack.writeBitmapLookupTable true
     - '
     - 
     +-'
     +-
      -test_partial_bitmap
     -+test_perf 'setup multi-pack-index (lookup table)' '
     -+	git multi-pack-index write --bitmap
     -+'
     ++test_bitmap () {
     ++    local enabled="$1"
     ++
     ++	# we need to create the tag up front such that it is covered by the repack and
     ++	# thus by generated bitmaps.
     ++	test_expect_success 'create tags' '
     ++		git tag --message="tag pointing to HEAD" perf-tag HEAD
     ++	'
      +
     -+test_full_bitmap
     ++	test_expect_success "use lookup table: $enabled" '
     ++		git config pack.writeBitmapLookupTable '"$enabled"'
     ++	'
     ++
     ++	test_expect_success "start with bitmapped pack (lookup=$enabled)" '
     ++		git repack -adb
     ++	'
     ++
     ++	test_perf "setup multi-pack index (lookup=$enabled)" '
     ++		git multi-pack-index write --bitmap
     ++	'
      +
     -+for i in false true
     -+do
     -+	$i && lookup=" (lookup table)"
     -+	test_expect_success "create partial bitmap state$lookup" '
     -+		git config pack.writeBitmapLookupTable '"$i"' &&
     ++	test_expect_success "drop pack bitmap (lookup=$enabled)" '
     ++		rm -f .git/objects/pack/pack-*.bitmap
     ++	'
     ++
     ++	test_full_bitmap
     ++
     ++    test_expect_success "create partial bitmap state (lookup=$enabled)" '
      +		# pick a commit to represent the repo tip in the past
      +		cutoff=$(git rev-list HEAD~100 -1) &&
      +		orig_tip=$(git rev-parse HEAD) &&
     @@ t/perf/p5326-multi-pack-bitmaps.sh: test_expect_success 'drop pack bitmap' '
      +		# and now restore our original tip, as if the pushes
      +		# had happened
      +		git update-ref HEAD $orig_tip
     -+	'
     ++    '
     ++}
      +
     -+	test_partial_bitmap
     -+done
     ++test_bitmap false
     ++test_bitmap true
       
       test_done
 -:  ----------- > 6:  fe556b58814 p5310-pack-bitmaps.sh: enable pack.writeReverseIndex for testing

-- 
gitgitgadget
