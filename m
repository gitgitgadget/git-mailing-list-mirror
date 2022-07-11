Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34304CCA47B
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 12:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiGKMoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiGKMoc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868D261D92
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 72so4682098pge.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3Tr6soU1NU8ORkEpmKHQgXT/C87uEL2t+Pv5fLyRFA=;
        b=RHU9dlKinxlvOpSMZbc5s8T13mbYo40rrg7Q4976mf8KDczCtyTdlpKBKIF1eZaFvV
         +1awIN+zOCuj4J4hMc43rOAwROMK6w2hDZY6UxeMgGGfC3hPFEKJ7JfDd/41jvaVxBBo
         CtlO5lnLooC6kaKcjF2M1Son9bWK4F73Maicu29B4nlV8T1DIQsXQbGlsq9A8lA+3m3D
         Tz637fr47uq1E+CTxdZTJV5DEinCkJ2+VSU6mH2//K8Iz4NljN+JiolpP6FdFeCgqVMK
         pVhiqlIACxoijySKuxlKn9HQ/YfjscTr+9hWNz86a0vRT2208NLRb+utkiW7XG3E0VyJ
         hTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3Tr6soU1NU8ORkEpmKHQgXT/C87uEL2t+Pv5fLyRFA=;
        b=CQBdSnOEvPwGt5TUEFVyZ9Vv/BKXIVLO+O1tGxQifwbD9C0gXBiEbe3f+A/v6wtfPi
         ik5lUn2OENMoO5RbaV4M9rm6k/fkNppTzPSkEhcWnbRmXcycuA/6HJF5pj1xURyZwu9x
         DWfB6sUW7t0HJiwxVErGhzhsksw6t7YyLJCkpTI9dQQjU3hK24mHNol295bH3GmrX7WX
         NATIAEBnLVi+LoN/C+Xmlo/9HCtBLAswpbDue+hnvwq7Nl/k02Lpx9TRljiQkgwCPi1g
         Nvvr89RMJ7oeqwhBKTdnSBUtS4y3uk/xLyp2Buw+jvV/a8qR2UkXAA8BmArGD4ucH0Rk
         kqxg==
X-Gm-Message-State: AJIora+qxhDFuC0OcKxWNZPL6/gaVrQyFBTerjbzWIh6RYGjiyStwKc5
        CLO6x9t8EeKMEiXTTVc4mmk=
X-Google-Smtp-Source: AGRyM1sBhAygIO/RY4Z0yKbahCnxKB6ckqC7C/N4OOHZqa1pWPN8W+2oyoNKFnBycAFiG7qo38KH2Q==
X-Received: by 2002:a63:87c6:0:b0:415:e6bf:1fa6 with SMTP id i189-20020a6387c6000000b00415e6bf1fa6mr8204309pge.406.1657543462839;
        Mon, 11 Jul 2022 05:44:22 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a02d600b001ef95232570sm6866084pjd.52.2022.07.11.05.44.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:44:22 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v6 2/7] pack-bitmap.c: mark more strings for translations
Date:   Mon, 11 Jul 2022 20:43:58 +0800
Message-Id: <cadecd6b8461e5e993d7b07d3bbeb8c44cf2b2d2.1657540174.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <cover.1657540174.git.dyroneteng@gmail.com>
References: <cover.1657540174.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In pack-bitmap.c, some printed texts are translated, some are not.
Let's support the translations of the bitmap related output.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0fdba5e8c5..c970ab46dd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -139,7 +139,7 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 		index->map_size - index->map_pos);
 
 	if (bitmap_size < 0) {
-		error("failed to load bitmap index (corrupted?)");
+		error(_("failed to load bitmap index (corrupted?)"));
 		ewah_pool_free(b);
 		return NULL;
 	}
@@ -161,14 +161,14 @@ static int load_bitmap_header(struct bitmap_index *index)
 	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
 
 	if (index->map_size < header_size + the_hash_algo->rawsz)
-		return error("corrupted bitmap index (too small)");
+		return error(_("corrupted bitmap index (too small)"));
 
 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
-		return error("corrupted bitmap index file (wrong header)");
+		return error(_("corrupted bitmap index file (wrong header)"));
 
 	index->version = ntohs(header->version);
 	if (index->version != 1)
-		return error("unsupported version '%d' for bitmap index file", index->version);
+		return error(_("unsupported version '%d' for bitmap index file"), index->version);
 
 	/* Parse known bitmap format options */
 	{
@@ -182,7 +182,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 
 		if (flags & BITMAP_OPT_HASH_CACHE) {
 			if (cache_size > index_end - index->map - header_size)
-				return error("corrupted bitmap index file (too short to fit hash cache)");
+				return error(_("corrupted bitmap index file (too short to fit hash cache)"));
 			index->hashes = (void *)(index_end - cache_size);
 			index_end -= cache_size;
 		}
@@ -216,7 +216,7 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	 * because the SHA1 already existed on the map. this is bad, there
 	 * shouldn't be duplicated commits in the index */
 	if (ret == 0) {
-		error("duplicate entry in bitmap index: '%s'", oid_to_hex(oid));
+		error(_("duplicate entry in bitmap index: '%s'"), oid_to_hex(oid));
 		return NULL;
 	}
 
@@ -260,14 +260,14 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		struct object_id oid;
 
 		if (index->map_size - index->map_pos < 6)
-			return error("corrupt ewah bitmap: truncated header for entry %d", i);
+			return error(_("corrupt ewah bitmap: truncated header for entry %d"), i);
 
 		commit_idx_pos = read_be32(index->map, &index->map_pos);
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
 
 		if (nth_bitmap_object_oid(index, &oid, commit_idx_pos) < 0)
-			return error("corrupt ewah bitmap: commit index %u out of range",
+			return error(_("corrupt ewah bitmap: commit index %u out of range"),
 				     (unsigned)commit_idx_pos);
 
 		bitmap = read_bitmap_1(index);
@@ -275,13 +275,13 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 			return -1;
 
 		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
-			return error("corrupted bitmap pack index");
+			return error(_("corrupted bitmap pack index"));
 
 		if (xor_offset > 0) {
 			xor_bitmap = recent_bitmaps[(i - xor_offset) % MAX_XOR_OFFSET];
 
 			if (xor_bitmap == NULL)
-				return error("invalid XOR offset in bitmap pack index");
+				return error(_("invalid XOR offset in bitmap pack index"));
 		}
 
 		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
@@ -331,7 +331,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: '%s'", buf.buf);
+		warning(_("ignoring extra bitmap file: '%s'"), buf.buf);
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -388,7 +388,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (bitmap_git->pack || bitmap_git->midx) {
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: '%s'", packfile->pack_name);
+		warning(_("ignoring extra bitmap file: '%s'"), packfile->pack_name);
 		close(fd);
 		return -1;
 	}
@@ -819,7 +819,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		revs->include_check_data = &incdata;
 
 		if (prepare_revision_walk(revs))
-			die("revision walk setup failed");
+			die(_("revision walk setup failed"));
 
 		show_data.bitmap_git = bitmap_git;
 		show_data.base = base;
@@ -1629,15 +1629,15 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
 	}
 
 	if (bitmap_type == OBJ_NONE)
-		die("object '%s' not found in type bitmaps",
+		die(_("object '%s' not found in type bitmaps"),
 		    oid_to_hex(&obj->oid));
 
 	if (bitmaps_nr > 1)
-		die("object '%s' does not have a unique type",
+		die(_("object '%s' does not have a unique type"),
 		    oid_to_hex(&obj->oid));
 
 	if (bitmap_type != obj->type)
-		die("object '%s': real type '%s', expected: '%s'",
+		die(_("object '%s': real type '%s', expected: '%s'"),
 		    oid_to_hex(&obj->oid),
 		    type_name(obj->type),
 		    type_name(bitmap_type));
@@ -1651,7 +1651,7 @@ static void test_show_object(struct object *object, const char *name,
 
 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
 	if (bitmap_pos < 0)
-		die("object not in bitmap: '%s'", oid_to_hex(&object->oid));
+		die(_("object not in bitmap: '%s'"), oid_to_hex(&object->oid));
 	test_bitmap_type(tdata, object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
@@ -1666,7 +1666,7 @@ static void test_show_commit(struct commit *commit, void *data)
 	bitmap_pos = bitmap_position(tdata->bitmap_git,
 				     &commit->object.oid);
 	if (bitmap_pos < 0)
-		die("object not in bitmap: '%s'", oid_to_hex(&commit->object.oid));
+		die(_("object not in bitmap: '%s'"), oid_to_hex(&commit->object.oid));
 	test_bitmap_type(tdata, &commit->object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
@@ -1683,10 +1683,10 @@ void test_bitmap_walk(struct rev_info *revs)
 	struct ewah_bitmap *bm;
 
 	if (!(bitmap_git = prepare_bitmap_git(revs->repo)))
-		die("failed to load bitmap indexes");
+		die(_("failed to load bitmap indexes"));
 
 	if (revs->pending.nr != 1)
-		die("you must specify exactly one commit to test");
+		die(_("you must specify exactly one commit to test"));
 
 	fprintf_ln(stderr, "Bitmap v%d test (%d entries loaded)",
 		bitmap_git->version, bitmap_git->entry_count);
@@ -1702,7 +1702,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	}
 
 	if (result == NULL)
-		die("commit '%s' doesn't have an indexed bitmap", oid_to_hex(&root->oid));
+		die(_("commit '%s' doesn't have an indexed bitmap"), oid_to_hex(&root->oid));
 
 	revs->tag_objects = 1;
 	revs->tree_objects = 1;
@@ -1711,7 +1711,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	result_popcnt = bitmap_popcount(result);
 
 	if (prepare_revision_walk(revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 
 	tdata.bitmap_git = bitmap_git;
 	tdata.base = bitmap_new();
@@ -1729,7 +1729,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (bitmap_equals(result, tdata.base))
 		fprintf_ln(stderr, "OK!");
 	else
-		die("mismatch in bitmap results");
+		die(_("mismatch in bitmap results"));
 
 	bitmap_free(result);
 	bitmap_free(tdata.base);
@@ -1747,7 +1747,7 @@ int test_bitmap_commits(struct repository *r)
 	MAYBE_UNUSED void *value;
 
 	if (!bitmap_git)
-		die("failed to load bitmap indexes");
+		die(_("failed to load bitmap indexes"));
 
 	kh_foreach(bitmap_git->bitmaps, oid, value, {
 		printf_ln("%s", oid_to_hex(&oid));
-- 
2.35.0.rc0.676.g60105b7097.dirty

