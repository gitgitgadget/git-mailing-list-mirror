Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A35C25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 17:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbiHNRAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbiHNQ7p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 12:59:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3C7643F
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h13so6630416wrf.6
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=L5ZDQjNSZODqV5ob6I9yfV1lvKfSzqAUZAjTDsOlzLI=;
        b=jy4DAA/wJ0r9AhLUaP7bDT3gdtdlqyKahnz6eAJ8K8TtSL+94+Mj+8eO9nFS7cOOGN
         yKCKmFrqcdVz+40+M2+Yme3lSfLtraKsGfez3DX8p03+AXVfcMx9Ao7FYLLxAS7VxhRy
         WAz9Ok4VHxca2PjsW3QxvL0xD8Ry19P+r3+TbMs7VkMEwKODov0L5xNODV3oZjQlu7ui
         R0n/YWfosPIrpvEs8uFy6GmJDE9fmq+EBQQ0yCLFWfE/DDI4s4gnVKxSgQDgHpCFBxvH
         oYiZHdafNZwPzOoX8izf1+/Bh/umJrlTU1SxdoGnbYvSkTET9sNi+W21+diTeD9TADHO
         gArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=L5ZDQjNSZODqV5ob6I9yfV1lvKfSzqAUZAjTDsOlzLI=;
        b=CeYiirhwdug+AfZJONzsiKPwPw6ULYPXoVHwod9ghI4f8chnYQYqoKxyfBXdGlWUyT
         Xx49V9mP5xtZktS0gVQEwcRghI0YqU8EoXVI3EiugiBJd7oneg7PGMa8zZzCRFU8keMy
         FQwkFMrd0AMcmoYoJmCg18PaNF7jzQRPkTEdfp4BgrLO+s8l6cEy9DJQ+07z8fQuAt1m
         dv6+oMeimS9WcXStIvpOZwZIpQbJClrjrMa7BYg54HrYGO0HU/LE5qviQD8FuwpXG0cA
         oSuFIttp2u0/2UIHTSmTXqCCnERLvMjVf8mce2LHef9gx73ltKrIbFcrACdL7RLMMWiV
         nlig==
X-Gm-Message-State: ACgBeo2Te2D9fAWH6eVuOuKYufpqm0u9H/8KfdncbQfmz3hlAq8XchIE
        XH6U+4vz75bpT8lLT/iy8cEBDIObh1g=
X-Google-Smtp-Source: AA6agR77X0AUK9jNym6MnmIwQS73YDKk7H3DO2b8i/g3aZTYu7s/bc0zMdpkd0KZrxNTXi3NTyJLXg==
X-Received: by 2002:adf:f2c1:0:b0:223:a7d2:4283 with SMTP id d1-20020adff2c1000000b00223a7d24283mr5733593wrp.485.1660496120478;
        Sun, 14 Aug 2022 09:55:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8-20020a056000008800b0022063e5228bsm4890550wrx.93.2022.08.14.09.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 09:55:19 -0700 (PDT)
Message-Id: <79842ca590c8f3af41d416bfb5d2b0109b1b918e.1660496112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
        <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Aug 2022 16:55:10 +0000
Subject: [PATCH v6 5/6] pack-bitmap: prepare to read lookup table extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Earlier change teaches Git to write bitmap lookup table. But Git
does not know how to parse them.

Teach Git to parse the existing bitmap lookup table. The older
versions of Git are not affected by it. Those versions ignore the
lookup table.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 pack-bitmap.c           | 290 ++++++++++++++++++++++++++++++++++++++--
 pack-bitmap.h           |   9 ++
 t/t5310-pack-bitmaps.sh |  22 +++
 3 files changed, 312 insertions(+), 9 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ef580be9e3f..9a208abc1fd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -83,6 +83,12 @@ struct bitmap_index {
 	/* The checksum of the packfile or MIDX; points into map. */
 	const unsigned char *checksum;
 
+	/*
+	 * If not NULL, this point into the commit table extension
+	 * (within the memory mapped region `map`).
+	 */
+	unsigned char *table_lookup;
+
 	/*
 	 * Extended index.
 	 *
@@ -186,6 +192,16 @@ static int load_bitmap_header(struct bitmap_index *index)
 			index->hashes = (void *)(index_end - cache_size);
 			index_end -= cache_size;
 		}
+
+		if (flags & BITMAP_OPT_LOOKUP_TABLE) {
+			size_t table_size = st_mult(ntohl(header->entry_count),
+						    BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
+			if (table_size > index_end - index->map - header_size)
+				return error(_("corrupted bitmap index file (too short to fit lookup table)"));
+			if (git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1))
+				index->table_lookup = (void *)(index_end - table_size);
+			index_end -= table_size;
+		}
 	}
 
 	index->entry_count = ntohl(header->entry_count);
@@ -212,9 +228,11 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 
 	hash_pos = kh_put_oid_map(index->bitmaps, stored->oid, &ret);
 
-	/* a 0 return code means the insertion succeeded with no changes,
-	 * because the SHA1 already existed on the map. this is bad, there
-	 * shouldn't be duplicated commits in the index */
+	/*
+	 * A 0 return code means the insertion succeeded with no changes,
+	 * because the SHA1 already existed on the map. This is bad, there
+	 * shouldn't be duplicated commits in the index.
+	 */
 	if (ret == 0) {
 		error(_("duplicate entry in bitmap index: '%s'"), oid_to_hex(oid));
 		return NULL;
@@ -482,7 +500,7 @@ static int load_bitmap(struct bitmap_index *bitmap_git)
 		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
 		goto failed;
 
-	if (load_bitmap_entries_v1(bitmap_git) < 0)
+	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
 		goto failed;
 
 	return 0;
@@ -570,13 +588,256 @@ struct include_data {
 	struct bitmap *seen;
 };
 
+struct bitmap_lookup_table_triplet {
+	uint32_t commit_pos;
+	uint64_t offset;
+	uint32_t xor_row;
+};
+
+struct bitmap_lookup_table_xor_item {
+	struct object_id oid;
+	uint64_t offset;
+};
+
+/*
+ * Given a `triplet` struct pointer and pointer `p`, this
+ * function reads the triplet beginning at `p` into the struct.
+ * Note that this function assumes that there is enough memory
+ * left for filling the `triplet` struct from `p`.
+ */
+static int bitmap_lookup_table_get_triplet_by_pointer(struct bitmap_lookup_table_triplet *triplet,
+						      const unsigned char *p)
+{
+	if (!triplet)
+		return -1;
+
+	triplet->commit_pos = get_be32(p);
+	p += sizeof(uint32_t);
+	triplet->offset = get_be64(p);
+	p += sizeof(uint64_t);
+	triplet->xor_row = get_be32(p);
+	return 0;
+}
+
+/*
+ * This function gets the raw triplet from `row`'th row in the
+ * lookup table and fills that data to the `triplet`.
+ */
+static int bitmap_lookup_table_get_triplet(struct bitmap_index *bitmap_git,
+					   uint32_t pos,
+					   struct bitmap_lookup_table_triplet *triplet)
+{
+	unsigned char *p = NULL;
+	if (pos >= bitmap_git->entry_count)
+		return error(_("corrupt bitmap lookup table: triplet position out of index"));
+
+	p = bitmap_git->table_lookup + st_mult(pos, BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
+
+	return bitmap_lookup_table_get_triplet_by_pointer(triplet, p);
+}
+
+/*
+ * Searches for a matching triplet. `commit_pos` is a pointer
+ * to the wanted commit position value. `table_entry` points to
+ * a triplet in lookup table. The first 4 bytes of each
+ * triplet (pointed by `table_entry`) are compared with `*commit_pos`.
+ */
+static int triplet_cmp(const void *commit_pos, const void *table_entry)
+{
+
+	uint32_t a = *(uint32_t *)commit_pos;
+	uint32_t b = get_be32(table_entry);
+	if (a > b)
+		return 1;
+	else if (a < b)
+		return -1;
+
+	return 0;
+}
+
+static uint32_t bitmap_bsearch_pos(struct bitmap_index *bitmap_git,
+			    struct object_id *oid,
+			    uint32_t *result)
+{
+	int found;
+
+	if (bitmap_is_midx(bitmap_git))
+		found = bsearch_midx(oid, bitmap_git->midx, result);
+	else
+		found = bsearch_pack(oid, bitmap_git->pack, result);
+
+	return found;
+}
+
+/*
+ * `bsearch_triplet_by_pos` function searches for the raw triplet
+ * having commit position same as `commit_pos` and fills `triplet`
+ * object from the raw triplet. Returns 1 on success and 0 on
+ * failure.
+ */
+static int bitmap_bsearch_triplet_by_pos(uint32_t commit_pos,
+				  struct bitmap_index *bitmap_git,
+				  struct bitmap_lookup_table_triplet *triplet)
+{
+	unsigned char *p = bsearch(&commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
+				   BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH, triplet_cmp);
+
+	if (!p)
+		return -1;
+
+	return bitmap_lookup_table_get_triplet_by_pointer(triplet, p);
+}
+
+static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
+						    struct commit *commit)
+{
+	uint32_t commit_pos, xor_row;
+	uint64_t offset;
+	int flags;
+	struct bitmap_lookup_table_triplet triplet;
+	struct object_id *oid = &commit->object.oid;
+	struct ewah_bitmap *bitmap;
+	struct stored_bitmap *xor_bitmap = NULL;
+	const int bitmap_header_size = 6;
+	static struct bitmap_lookup_table_xor_item *xor_items = NULL;
+	static size_t xor_items_nr = 0, xor_items_alloc = 0;
+	static int is_corrupt = 0;
+	int xor_flags;
+	khiter_t hash_pos;
+	struct bitmap_lookup_table_xor_item *xor_item;
+
+	if (is_corrupt)
+		return NULL;
+
+	if (!bitmap_bsearch_pos(bitmap_git, oid, &commit_pos))
+		return NULL;
+
+	if (bitmap_bsearch_triplet_by_pos(commit_pos, bitmap_git, &triplet) < 0)
+		return NULL;
+
+	xor_items_nr = 0;
+	offset = triplet.offset;
+	xor_row = triplet.xor_row;
+
+	while (xor_row != 0xffffffff) {
+		ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
+
+		if (xor_items_nr + 1 >= bitmap_git->entry_count) {
+			error(_("corrupt bitmap lookup table: xor chain exceed entry count"));
+			goto corrupt;
+		}
+
+		if (bitmap_lookup_table_get_triplet(bitmap_git, xor_row, &triplet) < 0)
+			goto corrupt;
+
+		xor_item = &xor_items[xor_items_nr];
+		xor_item->offset = triplet.offset;
+
+		if (nth_bitmap_object_oid(bitmap_git, &xor_item->oid, triplet.commit_pos) < 0) {
+			error(_("corrupt bitmap lookup table: commit index %u out of range"),
+				triplet.commit_pos);
+			goto corrupt;
+		}
+
+		hash_pos = kh_get_oid_map(bitmap_git->bitmaps, xor_item->oid);
+
+		/*
+		 * If desired bitmap is already stored, we don't need
+		 * to iterate further. Because we know that bitmaps
+		 * that are needed to be parsed to parse this bitmap
+		 * has already been stored. So, assign this stored bitmap
+		 * to the xor_bitmap.
+		 */
+		if (hash_pos < kh_end(bitmap_git->bitmaps) &&
+			(xor_bitmap = kh_value(bitmap_git->bitmaps, hash_pos)))
+			break;
+		xor_items_nr++;
+		xor_row = triplet.xor_row;
+	}
+
+	while (xor_items_nr) {
+		xor_item = &xor_items[xor_items_nr - 1];
+		bitmap_git->map_pos = xor_item->offset;
+		if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
+			error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
+				oid_to_hex(&xor_item->oid));
+			goto corrupt;
+		}
+
+		bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
+		xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
+		bitmap = read_bitmap_1(bitmap_git);
+
+		if (!bitmap)
+			goto corrupt;
+
+		xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid, xor_bitmap, xor_flags);
+		xor_items_nr--;
+	}
+
+	bitmap_git->map_pos = offset;
+	if (bitmap_git->map_size - bitmap_git->map_pos < bitmap_header_size) {
+		error(_("corrupt ewah bitmap: truncated header for bitmap of commit \"%s\""),
+			oid_to_hex(oid));
+		goto corrupt;
+	}
+
+	/*
+	 * Don't bother reading the commit's index position or its xor
+	 * offset:
+	 *
+	 *   - The commit's index position is irrelevant to us, since
+	 *     load_bitmap_entries_v1 only uses it to learn the object
+	 *     id which is used to compute the hashmap's key. We already
+	 *     have an object id, so no need to look it up again.
+	 *
+	 *   - The xor_offset is unusable for us, since it specifies how
+	 *     many entries previous to ours we should look at. This
+	 *     makes sense when reading the bitmaps sequentially (as in
+	 *     load_bitmap_entries_v1()), since we can keep track of
+	 *     each bitmap as we read them.
+	 *
+	 *     But it can't work for us, since the bitmap's don't have a
+	 *     fixed size. So we learn the position of the xor'd bitmap
+	 *     from the commit table (and resolve it to a bitmap in the
+	 *     above if-statement).
+	 *
+	 * Instead, we can skip ahead and immediately read the flags and
+	 * ewah bitmap.
+	 */
+	bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
+	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
+	bitmap = read_bitmap_1(bitmap_git);
+
+	if (!bitmap)
+		goto corrupt;
+
+	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
+
+corrupt:
+	free(xor_items);
+	is_corrupt = 1;
+	return NULL;
+}
+
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit)
 {
 	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
 					   commit->object.oid);
-	if (hash_pos >= kh_end(bitmap_git->bitmaps))
-		return NULL;
+	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
+		struct stored_bitmap *bitmap = NULL;
+		if (!bitmap_git->table_lookup)
+			return NULL;
+
+		trace2_region_enter("pack-bitmap", "reading_lookup_table", the_repository);
+		/* NEEDSWORK: cache misses aren't recorded */
+		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
+		trace2_region_leave("pack-bitmap", "reading_lookup_table", the_repository);
+		if (!bitmap)
+			return NULL;
+		return lookup_stored_bitmap(bitmap);
+	}
 	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
 }
 
@@ -1712,8 +1973,10 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (revs->pending.nr != 1)
 		die(_("you must specify exactly one commit to test"));
 
-	fprintf_ln(stderr, "Bitmap v%d test (%d entries loaded)",
-		bitmap_git->version, bitmap_git->entry_count);
+	fprintf_ln(stderr, "Bitmap v%d test (%d entries%s)",
+		bitmap_git->version,
+		bitmap_git->entry_count,
+		bitmap_git->table_lookup ? "" : " loaded");
 
 	root = revs->pending.objects[0].item;
 	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
@@ -1766,13 +2029,22 @@ void test_bitmap_walk(struct rev_info *revs)
 
 int test_bitmap_commits(struct repository *r)
 {
-	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
 	struct object_id oid;
 	MAYBE_UNUSED void *value;
+	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
 
 	if (!bitmap_git)
 		die(_("failed to load bitmap indexes"));
 
+	/*
+	 * As this function is only used to print bitmap selected
+	 * commits, we don't have to read the commit table.
+	 */
+	if (bitmap_git->table_lookup) {
+		if (load_bitmap_entries_v1(bitmap_git) < 0)
+			die(_("failed to load bitmap indexes"));
+	}
+
 	kh_foreach(bitmap_git->bitmaps, oid, value, {
 		printf_ln("%s", oid_to_hex(&oid));
 	});
diff --git a/pack-bitmap.h b/pack-bitmap.h
index cb065a263cb..f0180b5276b 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -23,6 +23,15 @@ struct bitmap_disk_header {
 
 #define NEEDS_BITMAP (1u<<22)
 
+/*
+ * The width in bytes of a single triplet in the lookup table
+ * extension:
+ *     (commit_pos, offset, xor_row)
+ *
+ * whose fields ar 32-, 64-, 32- bits wide, respectively.
+ */
+#define BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH (16)
+
 enum pack_bitmap_opts {
 	BITMAP_OPT_FULL_DAG = 0x1,
 	BITMAP_OPT_HASH_CACHE = 0x4,
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index c0607172827..7e50f8e7653 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -258,6 +258,7 @@ test_bitmap_cases () {
 
 	test_expect_success 'truncated bitmap fails gracefully (ewah)' '
 		test_config pack.writebitmaphashcache false &&
+		test_config pack.writebitmaplookuptable false &&
 		git repack -ad &&
 		git rev-list --use-bitmap-index --count --all >expect &&
 		bitmap=$(ls .git/objects/pack/*.bitmap) &&
@@ -270,6 +271,7 @@ test_bitmap_cases () {
 	'
 
 	test_expect_success 'truncated bitmap fails gracefully (cache)' '
+		git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
 		git repack -ad &&
 		git rev-list --use-bitmap-index --count --all >expect &&
 		bitmap=$(ls .git/objects/pack/*.bitmap) &&
@@ -453,4 +455,24 @@ test_expect_success 'verify writing bitmap lookup table when enabled' '
 	grep "\"label\":\"writing_lookup_table\"" trace2
 '
 
+test_expect_success 'lookup table is actually used to traverse objects' '
+	git repack -adb &&
+	GIT_TRACE2_EVENT="$(pwd)/trace3" \
+		git rev-list --use-bitmap-index --count --all &&
+	grep "\"label\":\"reading_lookup_table\"" trace3
+'
+
+test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
+	test_config pack.writebitmaphashcache false &&
+	git repack -adb &&
+	git rev-list --use-bitmap-index --count --all >expect &&
+	bitmap=$(ls .git/objects/pack/*.bitmap) &&
+	test_when_finished "rm -f $bitmap" &&
+	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
+	mv -f $bitmap.tmp $bitmap &&
+	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
+	test_cmp expect actual &&
+	test_i18ngrep corrupted.bitmap.index stderr
+'
+
 test_done
-- 
gitgitgadget

