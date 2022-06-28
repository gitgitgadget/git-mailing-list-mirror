Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A34C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 08:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245011AbiF1ITu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbiF1ITG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA9E615D
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:18:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q18so10373667pld.13
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bok6uTmco3tEd0qeAA344P/DWMG2aLZgrZLCXueymzY=;
        b=p5GMGHPtv/qI4HeNIPq8b2/XdUwbGJlqWJ6ESVuiAtQJ5DmJmBeC+ZWc/cM8qS4otw
         hsE1mjhGrDnt/87Mv+RBow8L4Breke4FJYxd/XYBDI1kp4QOgol64ge/K1wJd2faWuaJ
         oG7kb9kMQYXalHe3+fD0nFk+iGuQKNboh5PYwH2xwf2mpNgMc2C9BTN6sccKUfpndU2J
         1x4Zl90vZQ7npfr9Y9bwUCpH2Zb1iNxcKlGpxpyImBdCW79CeFW8YdR9Or1I127vWR75
         UWiUO51d4qp8rUsFLpMVQepMnV9l2wHDda4R7ZC4CgPd/ZCG8jGyfG3iFNPYoSuAq8B1
         0ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bok6uTmco3tEd0qeAA344P/DWMG2aLZgrZLCXueymzY=;
        b=vl2cN97lGBjUPtKM7qqgAG8jMp9KZ71eZQ7l2m3mDVGktTLIJw6k+N+llHDkZNIrnr
         qCx+24zrODattfAHZ7NsjLzQdDqS5nJmO37CnvtsO81u+9Hk90pS37EHNjQEh8HfwRbM
         P9J0esnS+4iK5spbFqro/opd7Kt2WTe//dEU0VJAS2tHRnQl+5SA78+QheGdt8rQp7UQ
         QhkgpRm/U120jR8ID73P1j+9BqWZ8d70NNhzlWaiXCs8JYfG4aF8D1Uq6QcfuABUg5BO
         A6n5Bzwl0Z/+5hCV26yXMYWehYCjxGZER/cSAShSY263BTWhSx7o0zUk3ICovi810XQy
         bnsQ==
X-Gm-Message-State: AJIora8hSixG5UyuleOa34xhNMrSem5QNKRyFV6elRCLfx1spzzmboFB
        GZpb+VlrwzviWQ4UsJBbR2E=
X-Google-Smtp-Source: AGRyM1uH0JupdET28bqIcMBJfgaQy7Gm0HLNQQWlJfC22zSTyRoLx8FHrvZkMo/BkGsxz+wChQ6Wqw==
X-Received: by 2002:a17:902:e888:b0:16a:1b3d:aac4 with SMTP id w8-20020a170902e88800b0016a1b3daac4mr3761229plg.80.1656404288316;
        Tue, 28 Jun 2022 01:18:08 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902f14900b0016368840c41sm8551206plb.14.2022.06.28.01.18.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:18:07 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        git@jeffhostetler.com
Subject: [PATCH v5 4/5] pack-bitmap.c: retrieve missing i18n translations
Date:   Tue, 28 Jun 2022 16:17:49 +0800
Message-Id: <065b7c9ccb5a412526a934f9b67c8be64a40fc7f.1656403084.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.gf3b87a33da
In-Reply-To: <cover.1656403084.git.dyroneteng@gmail.com>
References: <cover.1656403084.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In pack-bitmap.c, some printed texts are translated,some are not.
Let's support the translations of the bitmap related output.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 76 +++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9f60dbf282..922b9cbc54 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -138,7 +138,7 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 		index->map_size - index->map_pos);
 
 	if (bitmap_size < 0) {
-		error("Failed to load bitmap index (corrupted?)");
+		error(_("Failed to load bitmap index (corrupted?)"));
 		ewah_pool_free(b);
 		return NULL;
 	}
@@ -160,14 +160,14 @@ static int load_bitmap_header(struct bitmap_index *index)
 	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
 
 	if (index->map_size < header_size + the_hash_algo->rawsz)
-		return error("Corrupted bitmap index (too small)");
+		return error(_("Corrupted bitmap index (too small)"));
 
 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
-		return error("Corrupted bitmap index file (wrong header)");
+		return error(_("Corrupted bitmap index file (wrong header)"));
 
 	index->version = ntohs(header->version);
 	if (index->version != 1)
-		return error("Unsupported version for bitmap index file (%d)", index->version);
+		return error(_("Unsupported version for bitmap index file (%d)"), index->version);
 
 	/* Parse known bitmap format options */
 	{
@@ -176,12 +176,12 @@ static int load_bitmap_header(struct bitmap_index *index)
 		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
 
 		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
-			return error("Unsupported options for bitmap index file "
-				"(Git requires BITMAP_OPT_FULL_DAG)");
+			return error(_("Unsupported options for bitmap index file "
+				"(Git requires BITMAP_OPT_FULL_DAG)"));
 
 		if (flags & BITMAP_OPT_HASH_CACHE) {
 			if (cache_size > index_end - index->map - header_size)
-				return error("corrupted bitmap index file (too short to fit hash cache)");
+				return error(_("corrupted bitmap index file (too short to fit hash cache)"));
 			index->hashes = (void *)(index_end - cache_size);
 			index_end -= cache_size;
 		}
@@ -215,7 +215,7 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	 * because the SHA1 already existed on the map. this is bad, there
 	 * shouldn't be duplicated commits in the index */
 	if (ret == 0) {
-		error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
+		error(_("Duplicate entry in bitmap index: %s"), oid_to_hex(oid));
 		return NULL;
 	}
 
@@ -259,14 +259,14 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		struct object_id oid;
 
 		if (index->map_size - index->map_pos < 6)
-			return error("corrupt ewah bitmap: truncated header for entry %d", i);
+			return error(_("corrupt ewah bitmap: truncated header for entry %d)"), i);
 
 		commit_idx_pos = read_be32(index->map, &index->map_pos);
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
 
 		if (nth_bitmap_object_oid(index, &oid, commit_idx_pos) < 0)
-			return error("corrupt ewah bitmap: commit index %u out of range",
+			return error(_("corrupt ewah bitmap: commit index %u out of range"),
 				     (unsigned)commit_idx_pos);
 
 		bitmap = read_bitmap_1(index);
@@ -274,13 +274,13 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 			return -1;
 
 		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
-			return error("Corrupted bitmap pack index");
+			return error(_("Corrupted bitmap pack index"));
 
 		if (xor_offset > 0) {
 			xor_bitmap = recent_bitmaps[(i - xor_offset) % MAX_XOR_OFFSET];
 
 			if (xor_bitmap == NULL)
-				return error("Invalid XOR offset in bitmap pack index");
+				return error(_("Invalid XOR offset in bitmap pack index"));
 		}
 
 		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
@@ -305,7 +305,7 @@ char *pack_bitmap_filename(struct packed_git *p)
 	size_t len;
 
 	if (!strip_suffix(p->pack_name, ".pack", &len))
-		BUG("pack_name does not end in .pack");
+		BUG(_("pack_name does not end in .pack"));
 	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
 }
 
@@ -330,7 +330,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", buf.buf);
+		warning(_("ignoring extra bitmap file: %s"), buf.buf);
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -387,7 +387,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (bitmap_git->pack || bitmap_git->midx) {
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", packfile->pack_name);
+		warning(_("ignoring extra bitmap file: %s"), packfile->pack_name);
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
@@ -1134,7 +1134,7 @@ static void filter_bitmap_tree_depth(struct bitmap_index *bitmap_git,
 				     unsigned long limit)
 {
 	if (limit)
-		BUG("filter_bitmap_tree_depth given non-zero limit");
+		BUG(_("filter_bitmap_tree_depth given non-zero limit"));
 
 	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
 				   OBJ_TREE);
@@ -1148,7 +1148,7 @@ static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
 				      enum object_type object_type)
 {
 	if (object_type < OBJ_COMMIT || object_type > OBJ_TAG)
-		BUG("filter_bitmap_object_type given invalid object");
+		BUG(_("filter_bitmap_object_type given invalid object"));
 
 	if (object_type != OBJ_TAG)
 		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_TAG);
@@ -1304,14 +1304,14 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 		revs->ignore_missing_links = 0;
 
 		if (haves_bitmap == NULL)
-			BUG("failed to perform bitmap walk");
+			BUG(_("failed to perform bitmap walk"));
 	}
 
 	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap,
 				    filter);
 
 	if (!wants_bitmap)
-		BUG("failed to perform bitmap walk");
+		BUG(_("failed to perform bitmap walk"));
 
 	if (haves_bitmap)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
@@ -1432,7 +1432,7 @@ uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
 {
 	struct multi_pack_index *m = bitmap_git->midx;
 	if (!m)
-		BUG("midx_preferred_pack: requires non-empty MIDX");
+		BUG(_("midx_preferred_pack: requires non-empty MIDX"));
 	return nth_midxed_pack_int_id(m, pack_pos_to_midx(bitmap_git->midx, 0));
 }
 
@@ -1629,15 +1629,15 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
 	}
 
 	if (bitmap_type == OBJ_NONE)
-		die("object %s not found in type bitmaps",
+		die(_("object %s not found in type bitmaps"),
 		    oid_to_hex(&obj->oid));
 
 	if (bitmaps_nr > 1)
-		die("object %s does not have a unique type",
+		die(_("object %s does not have a unique type"),
 		    oid_to_hex(&obj->oid));
 
 	if (bitmap_type != obj->type)
-		die("object %s: real type %s, expected: %s",
+		die(_("object %s: real type %s, expected: %s"),
 		    oid_to_hex(&obj->oid),
 		    type_name(obj->type),
 		    type_name(bitmap_type));
@@ -1651,7 +1651,7 @@ static void test_show_object(struct object *object, const char *name,
 
 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
 	if (bitmap_pos < 0)
-		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
+		die(_("Object not in bitmap: %s\n"), oid_to_hex(&object->oid));
 	test_bitmap_type(tdata, object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
@@ -1666,7 +1666,7 @@ static void test_show_commit(struct commit *commit, void *data)
 	bitmap_pos = bitmap_position(tdata->bitmap_git,
 				     &commit->object.oid);
 	if (bitmap_pos < 0)
-		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
+		die(_("Object not in bitmap: %s\n"), oid_to_hex(&commit->object.oid));
 	test_bitmap_type(tdata, &commit->object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
@@ -1683,26 +1683,26 @@ void test_bitmap_walk(struct rev_info *revs)
 	struct ewah_bitmap *bm;
 
 	if (!(bitmap_git = prepare_bitmap_git(revs->repo)))
-		die("failed to load bitmap indexes");
+		die(_("failed to load bitmap indexes"));
 
 	if (revs->pending.nr != 1)
-		die("you must specify exactly one commit to test");
+		die(_("you must specify exactly one commit to test"));
 
-	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
+	fprintf(stderr, _("Bitmap v%d test (%d entries loaded)\n"),
 		bitmap_git->version, bitmap_git->entry_count);
 
 	root = revs->pending.objects[0].item;
 	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
 
 	if (bm) {
-		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
+		fprintf(stderr, _("Found bitmap for %s. %d bits / %08x checksum\n"),
 			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
 
 		result = ewah_to_bitmap(bm);
 	}
 
 	if (result == NULL)
-		die("Commit %s doesn't have an indexed bitmap", oid_to_hex(&root->oid));
+		die(_("Commit %s doesn't have an indexed bitmap"), oid_to_hex(&root->oid));
 
 	revs->tag_objects = 1;
 	revs->tree_objects = 1;
@@ -1711,7 +1711,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	result_popcnt = bitmap_popcount(result);
 
 	if (prepare_revision_walk(revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 
 	tdata.bitmap_git = bitmap_git;
 	tdata.base = bitmap_new();
@@ -1719,7 +1719,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	tdata.trees = ewah_to_bitmap(bitmap_git->trees);
 	tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
 	tdata.tags = ewah_to_bitmap(bitmap_git->tags);
-	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
+	tdata.prg = start_progress(_("Verifying bitmap entries"), result_popcnt);
 	tdata.seen = 0;
 
 	traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);
@@ -1727,9 +1727,9 @@ void test_bitmap_walk(struct rev_info *revs)
 	stop_progress(&tdata.prg);
 
 	if (bitmap_equals(result, tdata.base))
-		fprintf(stderr, "OK!\n");
+		fprintf(stderr, _("OK!\n"));
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
 		printf("%s\n", oid_to_hex(&oid));
@@ -1825,8 +1825,8 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 	if (!bitmap_is_midx(bitmap_git))
 		load_reverse_index(bitmap_git);
 	else if (load_midx_revindex(bitmap_git->midx) < 0)
-		BUG("rebuild_existing_bitmaps: missing required rev-cache "
-		    "extension");
+		BUG(_("rebuild_existing_bitmaps: missing required rev-cache "
+		    "extension"));
 
 	num_objects = bitmap_num_objects(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
-- 
2.35.1.582.gf3b87a33da

