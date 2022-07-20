Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4603C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 14:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiGTOF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiGTOFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 10:05:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE821C1C
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 07:05:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b6so10403869wmq.5
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 07:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=px+caxeDig1uTABCyh658/SzRxGT4WoP0z249axkb3U=;
        b=BnsYVopBUralUpAIu2qLx+HgSBjiWBgaUYN2EQxiyN5aeNp454AwOz7LD7W7mP0LFf
         vodFG3sesao5jxe8Fi7YcHG1SmmKMhwAVpCoKzgufLa8VkzDO4bLNoPIxPbgp9kBG7uE
         y9XZIl0+g94hklODhK0SD50GlmBXfHXYj53sdHmR2/6QdNgGIvcnAnOegxXmk/8uYYra
         s/aAtIu/GfpVUzO/RH5aobxIUKFNoGSILL5BRv/ThHFw5Y4sVjYaUD2YruHscmfyjlHQ
         HEE3j6XlkjNOP4TO2zLAsueBVCI7hD+nKQ7IbmN0OaUFnxwIfzjpn/lSGGNWS/iD3WeG
         XnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=px+caxeDig1uTABCyh658/SzRxGT4WoP0z249axkb3U=;
        b=rLcg4KWg3V4NtRJlMhdsKhanuJ6zxkniobxrELKYGJVxYbC36eLSq0tDOan/Y8+Vop
         YHEMvAJ95S8dLbelSRuIdCRrFP9tPbgol5Jn+CgFQJmtw1KroY3UyAtceCUn9MxUSu6l
         3OPZfVVApbLl1C/8Ab2iu+Y3SC3vELGaJr8uFK4jiWb0Ih1KaLG+dk7k4UXPWWxHjqIC
         mrW2KduLArxwunjhNbbScyUUb9CRAxwjqulGfsBeR+2QI9jlc/8qXkZFCd90iMai72ni
         toJ90KHbIeVuSxh5cZRSeO7REX73P9I4c2ne0iuxyp1clBLErU6Sqoob5kabWvDiSIJe
         PFcw==
X-Gm-Message-State: AJIora/taH6WiE6kL1iyWqXfy5lWqbSy/LdC7yZTNQ52S8riF38UVsnX
        btccuAqksqHi+s/kLNVafbqAt/nilCU=
X-Google-Smtp-Source: AGRyM1uAlATjAj6KRTQQqqrrb8FGH/qqc7UfWcbS6Z2v6iP5DkMEtBSyU261OKiXLhGZ0kzFWqf78Q==
X-Received: by 2002:a05:600c:3586:b0:3a3:2c03:1088 with SMTP id p6-20020a05600c358600b003a32c031088mr2111985wmq.64.1658325915512;
        Wed, 20 Jul 2022 07:05:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020adff083000000b0021d928d2388sm10383499wro.85.2022.07.20.07.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:05:15 -0700 (PDT)
Message-Id: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
References: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 14:05:07 +0000
Subject: [PATCH v4 0/6] [GSoC] bitmap: integrate a lookup table extension to the bitmap format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing the .bitmap file, git loads all the bitmaps one by one even if
some of the bitmaps are not necessary. We can remove this overhead by
loading only the necessary bitmaps. A look up table extension can solve this
issue.

Changes since v3:

 * The common code from both lookup_table_get_triplet() and
   bsearch_triplet_by_pos are moved to lookup_table_get_triplet_by_pointer
   function
 * parameter names of triplet_cmp function is changes (as suggested by
   Martin)
 * xor_items array is now work as reusable static buffer.
 * I moved the filling commit_positions array part (from
   pack-bitmap-write.c) to bitmap_writer_finish function. Because we had to
   iterate two times for commit positions - one in write_selected_commits_v1
   and another in write_lookup_table function. Hope this is acceptable :)
 * changes in performance tests (as suggested by Taylor)

Changes since v2:

 * Log messages related issues are fixed.
 * pack.writeBitmapLookupTable is now by default disabled.
 * Documentations are improved.
 * xor_row is used instead of xor_pos in triplets.
 * In pack-bitmap-write.c, off_t * is used for offsets array (Instead of
   uint64_t *).
 * struct bitmap_lookup_table_triplet is introduced and functions Like
   triplet_get_offset() and triplet_get_xor_pos() are removed.
 * table_size is getting subtracted from index_end irrespective of the value
   of GIT_TEST_READ_COMMIT_TABLE.
 * xor stack filling loop will stop iterating if a xor bitmap is already
   stored/parsed.
 * The stack will now store bitmap_lookup_table_xor_item items Of plain
   xor_row.
 * bitmap related test files are reformatted to allow repeating of tests
   with bitmap extension enabled.
 * comments are added.

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
  p5310-pack-bitmaps.sh: enable `pack.writeReverseIndex`
  bitmap-lookup-table: add performance tests for lookup table

 Documentation/config/pack.txt             |   7 +
 Documentation/technical/bitmap-format.txt |  39 ++
 builtin/multi-pack-index.c                |   7 +
 builtin/pack-objects.c                    |   8 +
 midx.c                                    |   3 +
 midx.h                                    |   1 +
 pack-bitmap-write.c                       | 112 ++-
 pack-bitmap.c                             | 278 +++++++-
 pack-bitmap.h                             |  14 +-
 t/perf/p5310-pack-bitmaps.sh              |  68 +-
 t/perf/p5326-multi-pack-bitmaps.sh        |  95 +--
 t/t5310-pack-bitmaps.sh                   | 786 ++++++++++++----------
 t/t5311-pack-bitmaps-shallow.sh           |  53 +-
 t/t5326-multi-pack-bitmaps.sh             | 421 +++++++-----
 t/t5327-multi-pack-bitmaps-rev.sh         |   9 +
 15 files changed, 1244 insertions(+), 657 deletions(-)


base-commit: 39c15e485575089eb77c769f6da02f98a55905e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1266%2FAbhra303%2Fbitmap-commit-table-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1266/Abhra303/bitmap-commit-table-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1266

Range-diff vs v3:

 1:  f72bf11e6ef = 1:  f72bf11e6ef Documentation/technical: describe bitmap lookup table extension
 2:  5e9b985e39b ! 2:  04244fadf5c pack-bitmap-write.c: write lookup table extension
     @@ Commit message
      
       ## pack-bitmap-write.c ##
      @@ pack-bitmap-write.c: static const struct object_id *oid_access(size_t pos, const void *table)
     - 	return &index[pos]->oid;
     - }
       
     -+static int commit_bitmap_writer_pos(struct object_id *oid,
     -+				    struct pack_idx_entry **index,
     -+				    uint32_t index_nr)
     -+{
     -+	return oid_pos(oid, index, index_nr, oid_access);
     -+}
     -+
       static void write_selected_commits_v1(struct hashfile *f,
       				      struct pack_idx_entry **index,
      -				      uint32_t index_nr)
      +				      uint32_t index_nr,
     -+				      off_t *offsets)
     ++				      off_t *offsets,
     ++				      uint32_t *commit_positions)
       {
       	int i;
       
     -@@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
     + 	for (i = 0; i < writer.selected_nr; ++i) {
       		struct bitmapped_commit *stored = &writer.selected[i];
       
     - 		int commit_pos =
     +-		int commit_pos =
      -			oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
     -+			commit_bitmap_writer_pos(&stored->commit->object.oid, index, index_nr);
     - 
     - 		if (commit_pos < 0)
     - 			BUG("trying to write commit not in index");
     - 
      +		if (offsets)
      +			offsets[i] = hashfile_total(f);
     -+
     - 		hashwrite_be32(f, commit_pos);
     + 
     +-		if (commit_pos < 0)
     +-			BUG("trying to write commit not in index");
     +-
     +-		hashwrite_be32(f, commit_pos);
     ++		hashwrite_be32(f, commit_positions[i]);
       		hashwrite_u8(f, stored->xor_offset);
       		hashwrite_u8(f, stored->flags);
     + 
      @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
       	}
       }
     @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
      +static void write_lookup_table(struct hashfile *f,
      +			       struct pack_idx_entry **index,
      +			       uint32_t index_nr,
     -+			       off_t *offsets)
     ++			       off_t *offsets,
     ++			       uint32_t *commit_positions)
      +{
      +	uint32_t i;
     -+	uint32_t *table, *table_inv, *commit_positions;
     ++	uint32_t *table, *table_inv;
      +
      +	ALLOC_ARRAY(table, writer.selected_nr);
      +	ALLOC_ARRAY(table_inv, writer.selected_nr);
     -+	ALLOC_ARRAY(commit_positions, writer.selected_nr);
     -+
     -+	/* store the index positions of the commits */
     -+	for (i = 0; i < writer.selected_nr; i++) {
     -+		int pos = commit_bitmap_writer_pos(&writer.selected[i].commit->object.oid,
     -+						   index, index_nr);
     -+		if (pos < 0)
     -+			BUG(_("trying to write commit not in index"));
     -+
     -+		commit_positions[i] = pos;
     -+	}
      +
      +	for (i = 0; i < writer.selected_nr; i++)
      +		table[i] = i;
      +
      +	/*
      +	 * At the end of this sort table[j] = i means that the i'th
     -+	 * bitmap corresponds to j'th bitmapped commit in lex order of
     -+	 * OIDs.
     ++	 * bitmap corresponds to j'th bitmapped commit (among the selected
     ++	 * commits) in lex order of OIDs.
      +	 */
      +	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
      +
     @@ pack-bitmap-write.c: static void write_selected_commits_v1(struct hashfile *f,
      +
      +	free(table);
      +	free(table_inv);
     -+	free(commit_positions);
      +}
      +
       static void write_hash_cache(struct hashfile *f,
     @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
      +	off_t *offsets = NULL;
       	struct strbuf tmp_file = STRBUF_INIT;
       	struct hashfile *f;
     ++	uint32_t *commit_positions = NULL;
     + 
     + 	struct bitmap_disk_header header;
       
      @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
       	dump_bitmap(f, writer.trees);
     @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
       	dump_bitmap(f, writer.tags);
      -	write_selected_commits_v1(f, index, index_nr);
      +
     ++	ALLOC_ARRAY(commit_positions, writer.selected_nr);
     ++	for (uint32_t i = 0; i < writer.selected_nr; ++i) {
     ++		struct bitmapped_commit *stored = &writer.selected[i];
     ++		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
     ++
     ++		if (commit_pos < 0)
     ++			BUG(_("trying to write commit not in index"));
     ++
     ++		commit_positions[i] = commit_pos;
     ++	}
     ++
      +	if (options & BITMAP_OPT_LOOKUP_TABLE)
      +		CALLOC_ARRAY(offsets, index_nr);
      +
     -+	write_selected_commits_v1(f, index, index_nr, offsets);
     ++	write_selected_commits_v1(f, index, index_nr, offsets, commit_positions);
      +
      +	if (options & BITMAP_OPT_LOOKUP_TABLE)
     -+		write_lookup_table(f, index, index_nr, offsets);
     ++		write_lookup_table(f, index, index_nr, offsets, commit_positions);
       
       	if (options & BITMAP_OPT_HASH_CACHE)
       		write_hash_cache(f, index, index_nr);
     @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
       
       	strbuf_release(&tmp_file);
      +	free(offsets);
     ++	free(commit_positions);
       }
      
       ## pack-bitmap.h ##
 3:  3dc40cc7f73 = 3:  8bd7639e4b9 pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
 4:  e64362621d2 ! 4:  afc8c660ac1 pack-bitmap: prepare to read lookup table extension
     @@ pack-bitmap.c: struct include_data {
      +};
      +
      +/*
     ++ * Given a `triplet` struct pointer and pointer `p`, this
     ++ * function reads the triplet beginning at `p` into the struct.
     ++ * Note that this function assumes that there is enough memory
     ++ * left for filling the `triplet` struct from `p`.
     ++ */
     ++static int lookup_table_get_triplet_by_pointer(struct bitmap_lookup_table_triplet *triplet,
     ++					       const unsigned char *p)
     ++{
     ++	if (!triplet)
     ++		return -1;
     ++
     ++	triplet->commit_pos = get_be32(p);
     ++	p += sizeof(uint32_t);
     ++	triplet->offset = get_be64(p);
     ++	p += sizeof(uint64_t);
     ++	triplet->xor_row = get_be32(p);
     ++	return 0;
     ++}
     ++
     ++/*
      + * This function gets the raw triplet from `row`'th row in the
      + * lookup table and fills that data to the `triplet`.
      + */
     @@ pack-bitmap.c: struct include_data {
      +
      +	p = bitmap_git->table_lookup + st_mult(pos, BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
      +
     -+	triplet->commit_pos = get_be32(p);
     -+	p += sizeof(uint32_t);
     -+	triplet->offset = get_be64(p);
     -+	p += sizeof(uint64_t);
     -+	triplet->xor_row = get_be32(p);
     -+	return 0;
     ++	return lookup_table_get_triplet_by_pointer(triplet, p);
      +}
      +
      +/*
     -+ * Searches for a matching triplet. `va` is a pointer
     -+ * to the wanted commit position value. `vb` points to
     ++ * Searches for a matching triplet. `commit_pos` is a pointer
     ++ * to the wanted commit position value. `table_entry` points to
      + * a triplet in lookup table. The first 4 bytes of each
     -+ * triplet (pointed by `vb`) are compared with `*va`.
     ++ * triplet (pointed by `table_entry`) are compared with `*commit_pos`.
      + */
     -+static int triplet_cmp(const void *va, const void *vb)
     ++static int triplet_cmp(const void *commit_pos, const void *table_entry)
      +{
      +
     -+	uint32_t a = *(uint32_t *)va;
     -+	uint32_t b = get_be32(vb);
     ++	uint32_t a = *(uint32_t *)commit_pos;
     ++	uint32_t b = get_be32(table_entry);
      +	if (a > b)
      +		return 1;
      +	else if (a < b)
     @@ pack-bitmap.c: struct include_data {
      +}
      +
      +/*
     -+ * `bsearch_triplet` function searches for the raw triplet having
     -+ * commit position same as `commit_pos` and fills `triplet`
     -+ * object from the raw triplet. Returns 1 on success and 0
     -+ * on failure.
     ++ * `bsearch_triplet_by_pos` function searches for the raw triplet
     ++ * having commit position same as `commit_pos` and fills `triplet`
     ++ * object from the raw triplet. Returns 1 on success and 0 on
     ++ * failure.
      + */
     -+static int bsearch_triplet(uint32_t *commit_pos,
     -+			   struct bitmap_index *bitmap_git,
     -+			   struct bitmap_lookup_table_triplet *triplet)
     ++static int bsearch_triplet_by_pos(uint32_t commit_pos,
     ++				  struct bitmap_index *bitmap_git,
     ++				  struct bitmap_lookup_table_triplet *triplet)
      +{
     -+	unsigned char *p = bsearch(commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
     ++	unsigned char *p = bsearch(&commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
      +				   BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH, triplet_cmp);
      +
      +	if (!p)
     -+		return 0;
     -+	triplet->commit_pos = get_be32(p);
     -+	p += sizeof(uint32_t);
     -+	triplet->offset = get_be64(p);
     -+	p += sizeof(uint64_t);
     -+	triplet->xor_row = get_be32(p);
     -+	return 1;
     ++		return -1;
     ++
     ++	return lookup_table_get_triplet_by_pointer(triplet, p);
      +}
      +
      +static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
     @@ pack-bitmap.c: struct include_data {
      +{
      +	uint32_t commit_pos, xor_row;
      +	uint64_t offset;
     -+	int flags;
     ++	int flags, found;
      +	struct bitmap_lookup_table_triplet triplet;
      +	struct object_id *oid = &commit->object.oid;
      +	struct ewah_bitmap *bitmap;
      +	struct stored_bitmap *xor_bitmap = NULL;
     ++	const int bitmap_header_size = 6;
     ++	static struct bitmap_lookup_table_xor_item *xor_items = NULL;
     ++	static size_t xor_items_nr = 0, xor_items_alloc = 0;
     ++	static int is_corrupt = 0;
     ++
     ++	if (is_corrupt)
     ++		return NULL;
      +
     -+	int found = bsearch_pos(bitmap_git, oid, &commit_pos);
     ++	found = bsearch_pos(bitmap_git, oid, &commit_pos);
      +
      +	if (!found)
      +		return NULL;
      +
     -+	if (!bsearch_triplet(&commit_pos, bitmap_git, &triplet))
     ++	if (bsearch_triplet_by_pos(commit_pos, bitmap_git, &triplet) < 0)
      +		return NULL;
      +
     ++	xor_items_nr = 0;
      +	offset = triplet.offset;
      +	xor_row = triplet.xor_row;
      +
     @@ pack-bitmap.c: struct include_data {
      +		int xor_flags;
      +		khiter_t hash_pos;
      +		uint64_t offset_xor;
     -+		struct bitmap_lookup_table_xor_item *xor_items;
     -+		struct bitmap_lookup_table_xor_item xor_item;
     -+		size_t xor_items_nr = 0, xor_items_alloc = 64;
     ++		struct bitmap_lookup_table_xor_item *xor_item;
      +
     -+		ALLOC_ARRAY(xor_items, xor_items_alloc);
      +		while (xor_row != 0xffffffff) {
     -+			struct object_id xor_oid;
     ++			ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
      +
      +			if (xor_items_nr + 1 >= bitmap_git->entry_count) {
     -+				free(xor_items);
      +				error(_("corrupt bitmap lookup table: xor chain exceed entry count"));
     -+				return NULL;
     ++				goto corrupt;
      +			}
      +
      +			if (lookup_table_get_triplet(bitmap_git, xor_row, &triplet) < 0)
     -+				return NULL;
     ++				goto corrupt;
      +
     -+			offset_xor = triplet.offset;
     ++			xor_item = &xor_items[xor_items_nr];
     ++			xor_item->offset = triplet.offset;
      +
     -+			if (nth_bitmap_object_oid(bitmap_git, &xor_oid, triplet.commit_pos) < 0) {
     -+				free(xor_items);
     ++			if (nth_bitmap_object_oid(bitmap_git, &xor_item->oid, triplet.commit_pos) < 0) {
      +				error(_("corrupt bitmap lookup table: commit index %u out of range"),
      +					triplet.commit_pos);
     -+				return NULL;
     ++				goto corrupt;
      +			}
      +
     -+			hash_pos = kh_get_oid_map(bitmap_git->bitmaps, xor_oid);
     ++			hash_pos = kh_get_oid_map(bitmap_git->bitmaps, xor_item->oid);
      +
      +			/*
      +			 * If desired bitmap is already stored, we don't need
     @@ pack-bitmap.c: struct include_data {
      +			if (hash_pos < kh_end(bitmap_git->bitmaps) &&
      +			    (xor_bitmap = kh_value(bitmap_git->bitmaps, hash_pos)))
      +				break;
     -+
     -+			ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
     -+			xor_items[xor_items_nr++] = (struct bitmap_lookup_table_xor_item) {.oid = xor_oid,
     -+											   .offset = offset_xor};
     ++			xor_items_nr++;
      +			xor_row = triplet.xor_row;
      +		}
      +
      +		while (xor_items_nr) {
     -+			xor_item = xor_items[xor_items_nr - 1];
     -+			offset_xor = xor_item.offset;
     ++			xor_item = &xor_items[xor_items_nr - 1];
     ++			offset_xor = xor_item->offset;
      +
      +			bitmap_git->map_pos = offset_xor;
     -+			if (bitmap_git->map_size - bitmap_git->map_pos < 6) {
     ++			if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
      +				error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
     -+					oid_to_hex(&xor_item.oid));
     -+				free(xor_items);
     -+				return NULL;
     ++					oid_to_hex(&xor_item->oid));
     ++				goto corrupt;
      +			}
      +
      +			bitmap_git->map_pos = bitmap_git->map_pos + sizeof(uint32_t) + sizeof(uint8_t);
      +			xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
      +			bitmap = read_bitmap_1(bitmap_git);
      +
     -+			if (!bitmap) {
     -+				free(xor_items);
     -+				return NULL;
     -+			}
     ++			if (!bitmap)
     ++				goto corrupt;
      +
     -+			xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item.oid, xor_bitmap, xor_flags);
     ++			xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid, xor_bitmap, xor_flags);
      +			xor_items_nr--;
      +		}
     -+
     -+		free(xor_items);
      +	}
      +
      +	bitmap_git->map_pos = offset;
     -+	if (bitmap_git->map_size - bitmap_git->map_pos < 6) {
     ++	if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
      +		error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
      +			oid_to_hex(oid));
     -+		return NULL;
     ++		goto corrupt;
      +	}
      +
      +	bitmap_git->map_pos = bitmap_git->map_pos + sizeof(uint32_t) + sizeof(uint8_t);
     @@ pack-bitmap.c: struct include_data {
      +	bitmap = read_bitmap_1(bitmap_git);
      +
      +	if (!bitmap)
     -+		return NULL;
     ++		goto corrupt;
      +
      +	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
     ++
     ++corrupt:
     ++	free(xor_items);
     ++	is_corrupt = 1;
     ++	return NULL;
      +}
      +
       struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 6:  4f9f1049485 ! 5:  fc69489e395 p5310-pack-bitmaps.sh: remove pack.writeReverseIndex
     @@ Metadata
      Author: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## Commit message ##
     -    p5310-pack-bitmaps.sh: remove pack.writeReverseIndex
     +    p5310-pack-bitmaps.sh: enable `pack.writeReverseIndex`
      
     -    The previous change enables the `pack.writereverseindex` to see
     -    the effect of writing reverse index in the performance test.
     +    Enable `pack.writeReverseIndex` before running pack-bitmap related
     +    performance tests.
      
     -    Remove the `pack.writeReverseIndex` configuration.
     +    The performance difference with `pack.writeReverseIndex` enabled and
     +    with disabled are given below -
      
     -    Below is the result of performance test. Output format is in
     -    seconds.
     +    With `pack.writeReverseIndex`
     +    -------------------------------
     +
     +    Test                                                 this tree
     +    -------------------------------------------------------------------------
     +    5310.3: repack to disk                                 296.55(256.53+14.52)
     +    5310.4: simulated clone                                15.64(8.88+1.39)
     +    5310.5: simulated fetch                                1.65(2.75+0.20)
     +    5310.6: pack to file (bitmap)                          48.71(30.20+7.58)
     +    5310.7: rev-list (commits)                             0.61(0.41+0.08)
     +    5310.8: rev-list (objects)                             4.38(4.26+0.09)
     +    5310.9: rev-list with tag negated via --not            0.07(0.02+0.04)
     +             --all (objects)
     +    5310.10: rev-list with negative tag (objects)          0.05(0.01+0.03)
     +    5310.11: rev-list count with blob:none                 0.08(0.03+0.04)
     +    5310.12: rev-list count with blob:limit=1k             7.29(6.92+0.30)
     +    5310.13: rev-list count with tree:0                    0.08(0.03+0.04)
     +    5310.14: simulated partial clone                       9.45(8.12+0.41)
     +    5310.16: clone (partial bitmap)                        17.02(10.61+2.67)
     +    5310.17: pack to file (partial bitmap)                 51.91(28.57+7.48)
     +    5310.18: rev-list with tree filter (partial bitmap)    1.00(0.22+0.24)
     +
     +    Without `pack.writeReverseIndex`:
     +    -----------------------------
      
          Test                                                  this tree
          ------------------------------------------------------------------------
     -    5310.4: repack to disk (lookup=false)               293.80(251.30+14.30)
     -    5310.5: simulated clone                             12.50(5.15+1.36)
     -    5310.6: simulated fetch                             1.83(2.90+0.23)
     -    5310.7: pack to file (bitmap)                       39.70(20.25+7.14)
     -    5310.8: rev-list (commits)                          1.00(0.60+0.13)
     -    5310.9: rev-list (objects)                          4.11(4.00+0.10)
     -    5310.10: rev-list with tag negated via --not        0.07(0.02+0.05)
     +    5310.3: repack to disk                              293.80(251.30+14.30)
     +    5310.4: simulated clone                             12.50(5.15+1.36)
     +    5310.5: simulated fetch                             1.83(2.90+0.23)
     +    5310.6: pack to file (bitmap)                       39.70(20.25+7.14)
     +    5310.7: rev-list (commits)                          1.00(0.60+0.13)
     +    5310.8: rev-list (objects)                          4.11(4.00+0.10)
     +    5310.9: rev-list with tag negated via --not         0.07(0.02+0.05)
                   --all (objects)
     -    5310.11: rev-list with negative tag (objects)       0.23(0.16+0.06)
     -    5310.12: rev-list count with blob:none              0.27(0.18+0.08)
     -    5310.13: rev-list count with blob:limit=1k          6.41(5.98+0.41)
     -    5310.14: rev-list count with tree:0                 0.26(0.18+0.07)
     -    5310.15: simulated partial clone                    4.34(3.29+0.37)
     -    5310.19: repack to disk (lookup=true)               250.93(171.97+20.78)
     -    5310.20: simulated clone                            10.80(5.14+1.06)
     -    5310.21: simulated fetch                            0.71(0.79+0.16)
     -    5310.22: pack to file (bitmap)                      39.49(20.19+6.98)
     -    5310.23: rev-list (commits)                         0.81(0.48+0.09)
     -    5310.24: rev-list (objects)                         3.48(3.38+0.09)
     -    5310.25: rev-list with tag negated via --not        0.04(0.00+0.03)
     -             --all (objects)
     -    5310.26: rev-list with negative tag (objects)       0.22(0.16+0.05)
     -    5310.27: rev-list count with blob:none              0.22(0.16+0.05)
     -    5310.28: rev-list count with blob:limit=1k          6.21(5.76+0.29)
     -    5310.29: rev-list count with tree:0                 0.23(0.16+0.06)
     -    5310.30: simulated partial clone                    4.53(3.14+0.39)
     -
     -    Tests 4-15 are without the use of lookup table. The rests are
     -    repeatation of the previous tests but using lookup table.
     +    5310.10: rev-list with negative tag (objects)       0.23(0.16+0.06)
     +    5310.11: rev-list count with blob:none              0.27(0.18+0.08)
     +    5310.12: rev-list count with blob:limit=1k          6.41(5.98+0.41)
     +    5310.13: rev-list count with tree:0                 0.26(0.18+0.07)
     +    5310.14: simulated partial clone                    4.34(3.29+0.37)
     +    5310.16: clone (partial bitmap)                     21.48(15.12+2.42)
     +    5310.17: pack to file (partial bitmap)              47.35(37.80+4.84)
     +    5310.18: rev-list with tree filter (partial bitmap) 0.73(0.07+0.21)
      
     -    Mentored-by: Taylor Blau <me@ttaylorr.com>
     -    Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## t/perf/p5310-pack-bitmaps.sh ##
     @@ t/perf/p5310-pack-bitmaps.sh: test_perf_large_repo
       # We intentionally use the deprecated pack.writebitmaps
       # config so that we can test against older versions of git.
       test_expect_success 'setup bitmap config' '
     --	git config pack.writebitmaps true &&
     --	git config pack.writeReverseIndex true
     -+	git config pack.writebitmaps true
     +-	git config pack.writebitmaps true
     ++	git config pack.writebitmaps true &&
     ++	git config pack.writeReverseIndex true
       '
       
     - test_bitmap () {
     + # we need to create the tag up front such that it is covered by the repack and
 5:  a155c1e2eba ! 6:  52f7d8359ee bitmap-lookup-table: add performance tests for lookup table
     @@ Commit message
          5310.13: rev-list count with blob:limit=1k              7.29(6.92+0.30)
          5310.14: rev-list count with tree:0                     0.08(0.03+0.04)
          5310.15: simulated partial clone                        9.45(8.12+0.41)
     -    5310.19: repack to disk (lookup=true)                   255.92(188.13+20.47)
     -    5310.20: simulated clone                                13.78(8.84+1.09)
     -    5310.21: simulated fetch                                0.52(0.63+0.14)
     -    5310.22: pack to file (bitmap)                          44.34(28.94+6.84)
     -    5310.23: rev-list (commits)                             0.48(0.31+0.06)
     -    5310.24: rev-list (objects)                             4.02(3.93+0.07)
     -    5310.25: rev-list with tag negated via --not            0.04(0.00+0.03)
     +    5310.17: clone (partial bitmap)                         21.00(15.04+2.39)
     +    5310.18: pack to file (partial bitmap)                  47.98(38.13+5.23)
     +    5310.19: rev-list with tree filter (partial bitmap)     0.70(0.07+0.20)
     +    5310.22: repack to disk (lookup=true)                   255.92(188.13+20.47)
     +    5310.23: simulated clone                                13.78(8.84+1.09)
     +    5310.24: simulated fetch                                0.52(0.63+0.14)
     +    5310.25: pack to file (bitmap)                          44.34(28.94+6.84)
     +    5310.26: rev-list (commits)                             0.48(0.31+0.06)
     +    5310.27: rev-list (objects)                             4.02(3.93+0.07)
     +    5310.28: rev-list with tag negated via --not            0.04(0.00+0.03)
                   --all (objects)
     -    5310.26: rev-list with negative tag (objects)           0.04(0.00+0.03)
     -    5310.27: rev-list count with blob:none                  0.04(0.01+0.03)
     -    5310.28: rev-list count with blob:limit=1k              6.48(6.23+0.22)
     -    5310.29: rev-list count with tree:0                     0.04(0.01+0.03)
     -    5310.30: simulated partial clone                        8.30(7.21+0.36)
     +    5310.29: rev-list with negative tag (objects)           0.04(0.00+0.03)
     +    5310.30: rev-list count with blob:none                  0.04(0.01+0.03)
     +    5310.31: rev-list count with blob:limit=1k              6.48(6.23+0.22)
     +    5310.32: rev-list count with tree:0                     0.04(0.01+0.03)
     +    5310.33: simulated partial clone                        8.30(7.21+0.36)
     +    5310.35: clone (partial bitmap)                         20.34(15.00+2.41)
     +    5310.36: pack to file (partial bitmap)                  46.45(38.05+5.20)
     +    5310.37: rev-list with tree filter (partial bitmap)     0.61(0.06+0.20)
      
          Test 4-15 are tested without using lookup table. Same tests are
          repeated in 16-30 (using lookup table).
     @@ Commit message
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## t/perf/p5310-pack-bitmaps.sh ##
     -@@ t/perf/p5310-pack-bitmaps.sh: test_perf_large_repo
     - # We intentionally use the deprecated pack.writebitmaps
     - # config so that we can test against older versions of git.
     - test_expect_success 'setup bitmap config' '
     --	git config pack.writebitmaps true
     -+	git config pack.writebitmaps true &&
     -+	git config pack.writeReverseIndex true
     +@@ t/perf/p5310-pack-bitmaps.sh: test_expect_success 'setup bitmap config' '
     + 	git config pack.writeReverseIndex true
       '
       
      -# we need to create the tag up front such that it is covered by the repack and
     @@ t/perf/p5310-pack-bitmaps.sh: test_perf_large_repo
      +		# had happened
      +		git update-ref HEAD $orig_tip
      +	'
     ++
     ++	test_partial_bitmap
      +}
       
      -test_partial_bitmap
     @@ t/perf/p5326-multi-pack-bitmaps.sh: test_description='Tests performance using mi
      +		# had happened
      +		git update-ref HEAD $orig_tip
      +	'
     ++
     ++	test_partial_bitmap
      +}
      +
      +test_bitmap false

-- 
gitgitgadget
