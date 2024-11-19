Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC81D47BC
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054081; cv=none; b=sX28zlHVhMPieFotFnBlv0tHiR9RBUFqogol5m2Y0QhhTU3ZoxARhM3gVLC56ewjkJpnU3CLxv+YlE/PlLPyQrgF/BCkIiFHaofk0uoPnW1TQJfWQedNdB1a/Xc6QP6MXHKBxTp/Zp3tXraK0w7csLHNGBRe7mcFWXFZwCsXFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054081; c=relaxed/simple;
	bh=AHMJsOXufHCHK3o1VaRd663rUkae2bG92RGTzHtHqbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPU56jsfoDB3/kUF2JXRRnnre4C4ARe1Uo2f5fPw8CHC+yIgOOkspUheo42VEna1N9ReFqfwKA0CGua/IUySF8fSkZo5TNZRgw0hHwEjFhHIUOjMRaKjW7Ty/uoU8IjFAi0QfQsSZRI4VYKH2QhYUNjeVxY0ia9JFQoqAuO+nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IRwBIFSr; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IRwBIFSr"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3824e1adcdso3269097276.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054078; x=1732658878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqKtPZKd854qaZKx7qMx+TDjU3UkRS8Ukn9P91XTGzM=;
        b=IRwBIFSryNNVEh2Peqw307JFlYfVRzoriYiBY6Fx1iE/F4jeFF6Vrys0TBhwjHCkYi
         CUnntFEWCZf3d7GSLxic/uC3jP+z/Rrr20pC/baDwD/Dmdkqsqk6vFB+4qnvn1L09xoY
         eJhNS/ObOhaBD1utj/eQzfs1CChnZFpfeP3cFgQqPocLcZqI0cKn1alu/P4JBRP0TzML
         o7GF/FuCsPAEIpsA7o4jPvpADX8K3nTk0skwwslTgwQsdMOT0praQ/8uTJRyCWhLqVAO
         LjRr9Qj7k4RuRIoxVztlObKkwOJ0BHSUN5hMLRC9gYIK4yG0tZW4P94bNb/TsJhyhe90
         ztHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054078; x=1732658878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqKtPZKd854qaZKx7qMx+TDjU3UkRS8Ukn9P91XTGzM=;
        b=N2O7KCoY3BE7TCbmtlrK/wiW+twypNwke0SOQ7mhU0DkS5ZpeOen8u0EgiGPPyv8hE
         2YpwfRjIip4au6Oxk1jxU9zP+vq+ysPQk7BF3cjxpoiO4mcoypbJvrG+AvYAaiKZaiGt
         A099V6f2Lt1P1nHvkKlQACoSVliGttcVfHUMEvlBKN3Hs7r7V0hePMrlEbSlVEYtQDtG
         CECfRZqcmec9uaI4zTGTvCxYWhz3rbLQxzAJ7OPtAtW80DzNG35gsMIhtA7VtwWtHqeE
         NXWugnBHU+GWNJ4dEY/8msyQTUDDnpKqEnLtgOwcELR5s869egJQ8yBkXxE3JwCjgYeN
         VqBg==
X-Gm-Message-State: AOJu0Yy2ZgmSnsnU+IumZIuTSWFbPjwcmm+RYQiJ7U3JcdKeX+4PFJcj
	Wm0S2aOUlTjiVg4JUzi70byYmXHhMH0isc12TWNsYGqdu3lGVJLt0dEFSlr6afWqF8K0+5o8WrV
	f85s=
X-Google-Smtp-Source: AGHT+IF+EOEk5H15Z6G45Oz/7WWB/SiSiEO2RQLNHOCTtJtO4OBCsmHkw4uL0Jci5BNxF9tkJAdmbA==
X-Received: by 2002:a05:6902:12c9:b0:e38:bf0:dab0 with SMTP id 3f1490d57ef6-e38cb5bef63mr375008276.24.1732054078328;
        Tue, 19 Nov 2024 14:07:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e72252fsm2641840276.1.2024.11.19.14.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:57 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/13] midx: implement writing incremental MIDX bitmaps
Message-ID: <77ddd1170f9178849b5dbfd9cd16a14ae96cfa87.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

Now that the pack-bitmap machinery has learned how to read and interact
with an incremental MIDX bitmap, teach the pack-bitmap-write.c machinery
(and relevant callers from within the MIDX machinery) to write such
bitmaps.

The details for doing so are mostly straightforward. The main changes
are as follows:

  - find_object_pos() now makes use of an extra MIDX parameter which is
    used to locate the bit positions of objects which are from previous
    layers (and thus do not exist in the current layer's pack_order
    field).

    (Note also that the pack_order field is moved into struct
    write_midx_context to further simplify the callers for
    write_midx_bitmap()).

  - bitmap_writer_build_type_index() first determines how many objects
    precede the current bitmap layer and offsets the bits it sets in
    each respective type-level bitmap by that amount so they can be OR'd
    together.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c                  |  3 +-
 midx-write.c                            | 49 ++++++++++-----
 pack-bitmap-write.c                     | 65 ++++++++++++++-----
 pack-bitmap.h                           |  4 +-
 t/t5334-incremental-multi-pack-index.sh | 84 +++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 34 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 08007142671..09d9ef62055 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1370,7 +1370,8 @@ static void write_pack_file(void)
 
 			if (write_bitmap_index) {
 				bitmap_writer_init(&bitmap_writer,
-						   the_repository, &to_pack);
+						   the_repository, &to_pack,
+						   NULL);
 				bitmap_writer_set_checksum(&bitmap_writer, hash);
 				bitmap_writer_build_type_index(&bitmap_writer,
 							       written_list);
diff --git a/midx-write.c b/midx-write.c
index b3a5f6c5166..6f7a8e045fd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -645,15 +645,21 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	return pack_order;
 }
 
-static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
-				     struct write_midx_context *ctx)
+static void write_midx_reverse_index(struct write_midx_context *ctx,
+				     const char *object_dir,
+				     unsigned char *midx_hash)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *tmp_file;
 
 	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
 
-	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
+	if (ctx->incremental)
+		get_split_midx_filename_ext(&buf, object_dir, midx_hash,
+					    MIDX_EXT_REV);
+	else
+		get_midx_filename_ext(&buf, object_dir, midx_hash,
+				      MIDX_EXT_REV);
 
 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
 					midx_hash, WRITE_REV);
@@ -827,20 +833,26 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	return cb.commits;
 }
 
-static int write_midx_bitmap(const char *midx_name,
+static int write_midx_bitmap(struct write_midx_context *ctx,
+			     const char *object_dir,
 			     const unsigned char *midx_hash,
 			     struct packing_data *pdata,
 			     struct commit **commits,
 			     uint32_t commits_nr,
-			     uint32_t *pack_order,
 			     unsigned flags)
 {
 	int ret, i;
 	uint16_t options = 0;
 	struct bitmap_writer writer;
 	struct pack_idx_entry **index;
-	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
-					hash_to_hex(midx_hash));
+	struct strbuf bitmap_name = STRBUF_INIT;
+
+	if (ctx->incremental)
+		get_split_midx_filename_ext(&bitmap_name, object_dir, midx_hash,
+					    MIDX_EXT_BITMAP);
+	else
+		get_midx_filename_ext(&bitmap_name, object_dir, midx_hash,
+				      MIDX_EXT_BITMAP);
 
 	trace2_region_enter("midx", "write_midx_bitmap", the_repository);
 
@@ -859,7 +871,8 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
-	bitmap_writer_init(&writer, the_repository, pdata);
+	bitmap_writer_init(&writer, the_repository, pdata,
+			   ctx->incremental ? ctx->base_midx : NULL);
 	bitmap_writer_show_progress(&writer, flags & MIDX_PROGRESS);
 	bitmap_writer_build_type_index(&writer, index);
 
@@ -877,7 +890,7 @@ static int write_midx_bitmap(const char *midx_name,
 	 * bitmap_writer_finish().
 	 */
 	for (i = 0; i < pdata->nr_objects; i++)
-		index[pack_order[i]] = &pdata->objects[i].idx;
+		index[ctx->pack_order[i]] = &pdata->objects[i].idx;
 
 	bitmap_writer_select_commits(&writer, commits, commits_nr);
 	ret = bitmap_writer_build(&writer);
@@ -885,11 +898,11 @@ static int write_midx_bitmap(const char *midx_name,
 		goto cleanup;
 
 	bitmap_writer_set_checksum(&writer, midx_hash);
-	bitmap_writer_finish(&writer, index, bitmap_name, options);
+	bitmap_writer_finish(&writer, index, bitmap_name.buf, options);
 
 cleanup:
 	free(index);
-	free(bitmap_name);
+	strbuf_release(&bitmap_name);
 	bitmap_writer_free(&writer);
 
 	trace2_region_leave("midx", "write_midx_bitmap", the_repository);
@@ -1073,8 +1086,6 @@ static int write_midx_internal(const char *object_dir,
 	trace2_region_enter("midx", "write_midx_internal", the_repository);
 
 	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
-	if (ctx.incremental && (flags & MIDX_WRITE_BITMAP))
-		die(_("cannot write incremental MIDX with bitmap"));
 
 	if (ctx.incremental)
 		strbuf_addf(&midx_name,
@@ -1116,6 +1127,12 @@ static int write_midx_internal(const char *object_dir,
 	if (ctx.incremental) {
 		struct multi_pack_index *m = ctx.base_midx;
 		while (m) {
+			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
+				error(_("could not load reverse index for MIDX %s"),
+				      hash_to_hex(get_midx_checksum(m)));
+				result = 1;
+				goto cleanup;
+			}
 			ctx.num_multi_pack_indexes_before++;
 			m = m->base_midx;
 		}
@@ -1382,7 +1399,7 @@ static int write_midx_internal(const char *object_dir,
 
 	if (flags & MIDX_WRITE_REV_INDEX &&
 	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
-		write_midx_reverse_index(midx_name.buf, midx_hash, &ctx);
+		write_midx_reverse_index(&ctx, object_dir, midx_hash);
 
 	if (flags & MIDX_WRITE_BITMAP) {
 		struct packing_data pdata;
@@ -1405,8 +1422,8 @@ static int write_midx_internal(const char *object_dir,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr = 0;
 
-		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
-				      commits, commits_nr, ctx.pack_order,
+		if (write_midx_bitmap(&ctx, object_dir,
+				      midx_hash, &pdata, commits, commits_nr,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			result = 1;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 49758e2525f..1fbebe84479 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -25,6 +25,8 @@
 #include "alloc.h"
 #include "refs.h"
 #include "strmap.h"
+#include "midx.h"
+#include "pack-revindex.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
@@ -42,7 +44,8 @@ static inline int bitmap_writer_nr_selected_commits(struct bitmap_writer *writer
 }
 
 void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r,
-			struct packing_data *pdata)
+			struct packing_data *pdata,
+			struct multi_pack_index *midx)
 {
 	memset(writer, 0, sizeof(struct bitmap_writer));
 	if (writer->bitmaps)
@@ -50,6 +53,7 @@ void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r,
 	writer->bitmaps = kh_init_oid_map();
 	writer->pseudo_merge_commits = kh_init_oid_map();
 	writer->to_pack = pdata;
+	writer->midx = midx;
 
 	string_list_init_dup(&writer->pseudo_merge_groups);
 
@@ -112,6 +116,11 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 				    struct pack_idx_entry **index)
 {
 	uint32_t i;
+	uint32_t base_objects = 0;
+
+	if (writer->midx)
+		base_objects = writer->midx->num_objects +
+			writer->midx->num_objects_in_base;
 
 	writer->commits = ewah_new();
 	writer->trees = ewah_new();
@@ -141,19 +150,19 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 
 		switch (real_type) {
 		case OBJ_COMMIT:
-			ewah_set(writer->commits, i);
+			ewah_set(writer->commits, i + base_objects);
 			break;
 
 		case OBJ_TREE:
-			ewah_set(writer->trees, i);
+			ewah_set(writer->trees, i + base_objects);
 			break;
 
 		case OBJ_BLOB:
-			ewah_set(writer->blobs, i);
+			ewah_set(writer->blobs, i + base_objects);
 			break;
 
 		case OBJ_TAG:
-			ewah_set(writer->tags, i);
+			ewah_set(writer->tags, i + base_objects);
 			break;
 
 		default:
@@ -206,19 +215,37 @@ void bitmap_writer_push_commit(struct bitmap_writer *writer,
 static uint32_t find_object_pos(struct bitmap_writer *writer,
 				const struct object_id *oid, int *found)
 {
-	struct object_entry *entry = packlist_find(writer->to_pack, oid);
+	struct object_entry *entry;
+
+	entry = packlist_find(writer->to_pack, oid);
+	if (entry) {
+		uint32_t base_objects = 0;
+		if (writer->midx)
+			base_objects = writer->midx->num_objects +
+				writer->midx->num_objects_in_base;
+
+		if (found)
+			*found = 1;
+		return oe_in_pack_pos(writer->to_pack, entry) + base_objects;
+	} else if (writer->midx) {
+		uint32_t at, pos;
+
+		if (!bsearch_midx(oid, writer->midx, &at))
+			goto missing;
+		if (midx_to_pack_pos(writer->midx, at, &pos) < 0)
+			goto missing;
 
-	if (!entry) {
 		if (found)
-			*found = 0;
-		warning("Failed to write bitmap index. Packfile doesn't have full closure "
-			"(object %s is missing)", oid_to_hex(oid));
-		return 0;
+			*found = 1;
+		return pos;
 	}
 
+missing:
 	if (found)
-		*found = 1;
-	return oe_in_pack_pos(writer->to_pack, entry);
+		*found = 0;
+	warning("Failed to write bitmap index. Packfile doesn't have full closure "
+		"(object %s is missing)", oid_to_hex(oid));
+	return 0;
 }
 
 static void compute_xor_offsets(struct bitmap_writer *writer)
@@ -585,7 +612,7 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct prio_queue tree_queue = { NULL };
 	struct bitmap_index *old_bitmap;
-	uint32_t *mapping;
+	uint32_t *mapping = NULL;
 	int closed = 1; /* until proven otherwise */
 
 	if (writer->show_progress)
@@ -1018,7 +1045,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
 	off_t *offsets = NULL;
-	uint32_t i;
+	uint32_t i, base_objects;
 
 	struct bitmap_disk_header header;
 
@@ -1044,6 +1071,12 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
 		CALLOC_ARRAY(offsets, writer->to_pack->nr_objects);
 
+	if (writer->midx)
+		base_objects = writer->midx->num_objects +
+			writer->midx->num_objects_in_base;
+	else
+		base_objects = 0;
+
 	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++) {
 		struct bitmapped_commit *stored = &writer->selected[i];
 		int commit_pos = oid_pos(&stored->commit->object.oid, index,
@@ -1052,7 +1085,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 
 		if (commit_pos < 0)
 			BUG(_("trying to write commit not in index"));
-		stored->commit_pos = commit_pos;
+		stored->commit_pos = commit_pos + base_objects;
 	}
 
 	write_selected_commits_v1(writer, f, offsets);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index d7f4b8b8e95..dd0951088f6 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -111,6 +111,7 @@ struct bitmap_writer {
 
 	kh_oid_map_t *bitmaps;
 	struct packing_data *to_pack;
+	struct multi_pack_index *midx; /* if appending to a MIDX chain */
 
 	struct bitmapped_commit *selected;
 	unsigned int selected_nr, selected_alloc;
@@ -125,7 +126,8 @@ struct bitmap_writer {
 };
 
 void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r,
-			struct packing_data *pdata);
+			struct packing_data *pdata,
+			struct multi_pack_index *midx);
 void bitmap_writer_show_progress(struct bitmap_writer *writer, int show);
 void bitmap_writer_set_checksum(struct bitmap_writer *writer,
 				const unsigned char *sha1);
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 471994c4bc8..3aac7ccdfe2 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -45,4 +45,88 @@ test_expect_success 'convert incremental to non-incremental' '
 
 compare_results_with_midx 'non-incremental MIDX conversion'
 
+write_midx_layer () {
+	n=1
+	if test -f $midx_chain
+	then
+		n="$(($(wc -l <$midx_chain) + 1))"
+	fi
+
+	for i in 1 2
+	do
+		test_commit $n.$i &&
+		git repack -d || return 1
+	done &&
+	git multi-pack-index write --bitmap --incremental
+}
+
+test_expect_success 'write initial MIDX layer' '
+	git repack -ad &&
+	write_midx_layer
+'
+
+test_expect_success 'read bitmap from first MIDX layer' '
+	git rev-list --test-bitmap 1.2
+'
+
+test_expect_success 'write another MIDX layer' '
+	write_midx_layer
+'
+
+test_expect_success 'midx verify with multiple layers' '
+	git multi-pack-index verify
+'
+
+test_expect_success 'read bitmap from second MIDX layer' '
+	git rev-list --test-bitmap 2.2
+'
+
+test_expect_success 'read earlier bitmap from second MIDX layer' '
+	git rev-list --test-bitmap 1.2
+'
+
+test_expect_success 'show object from first pack' '
+	git cat-file -p 1.1
+'
+
+test_expect_success 'show object from second pack' '
+	git cat-file -p 2.2
+'
+
+for reuse in false single multi
+do
+	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
+		rm -fr clone.git &&
+
+		git config pack.allowPackReuse $reuse &&
+		git clone --no-local --bare . clone.git
+	'
+done
+
+test_expect_success 'relink existing MIDX layer' '
+	rm -fr "$midxdir" &&
+
+	GIT_TEST_MIDX_WRITE_REV=1 git multi-pack-index write --bitmap &&
+
+	midx_hash="$(test-tool read-midx --checksum $objdir)" &&
+
+	test_path_is_file "$packdir/multi-pack-index" &&
+	test_path_is_file "$packdir/multi-pack-index-$midx_hash.bitmap" &&
+	test_path_is_file "$packdir/multi-pack-index-$midx_hash.rev" &&
+
+	test_commit another &&
+	git repack -d &&
+	git multi-pack-index write --bitmap --incremental &&
+
+	test_path_is_missing "$packdir/multi-pack-index" &&
+	test_path_is_missing "$packdir/multi-pack-index-$midx_hash.bitmap" &&
+	test_path_is_missing "$packdir/multi-pack-index-$midx_hash.rev" &&
+
+	test_path_is_file "$midxdir/multi-pack-index-$midx_hash.midx" &&
+	test_path_is_file "$midxdir/multi-pack-index-$midx_hash.bitmap" &&
+	test_path_is_file "$midxdir/multi-pack-index-$midx_hash.rev" &&
+	test_line_count = 2 "$midx_chain"
+
+'
+
 test_done
-- 
2.47.0.301.g77ddd1170f9
