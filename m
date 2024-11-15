Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424261CF5CB
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678159; cv=none; b=TvST2t85qacI5rTXb2OyiTZvgsqxS0tlv2R6uIHhdhax1247wxjIjWrkpnRaOss9d+fVKcYqRq6gONCeU/SSVEud1ZEkYXcxgzA1fXOrUeMRLH64/w9iWL7XZiXFCAT3SHjrRC3eY4UHamfJ5VroU/mxo7FLrqdxFA24t0iXrRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678159; c=relaxed/simple;
	bh=aqnzIqfQ9Q/2Lga8N+m93w2pRkd9qRAElYeuZ6Yj6Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJqwFLHt1qZk6zUnf7OzPgGt53Ulfb1r15DFtvlNB/nKODBQoP1GWOaw5H/8ZUK7TYM+6dJFvRNpWoDPyTSTRzP7RuFT4760CP9NRzsI2JVZFdaoUuuperybk8ohog0untj+tqERB3WpsnRB+lj4NDo2ipRYr7GWpFHYSgoJt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xmik89NA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xmik89NA"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa1f73966a5so349140766b.2
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731678155; x=1732282955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+htfvT+o2F1nEtNcEZjC1+AFmm0hfW6zBIW8BVMW5Y=;
        b=Xmik89NAPmbWFpatNzESudl1Ee16VqiBKaxWv+hxtMshC0/xXvExwxE/2sRXweCLAQ
         484oqhNYuuoyLo/BcCRtlvsmOm+363CkEbYyvwl/TDpwM+D8GwT8pwyY423d6mJTfocw
         hFOIfKUtMKx2gzsdqZF2SHqGozUF7rP839FuEeOOkmBaMnuruC71QH/Q1ISOZviX6MvT
         oTPBoMo33woDncRxb1kFUmZH2NO5oBvHlqL2Azs0zUWr/nmWpEtNXJfMWtWrM3mZowBk
         XV5cIpY0X6aan+t8Y37eAp2Uc49ssg/s7tofabo7ttWrzAqI3WeJJKw4I72WdKPTXx8k
         0HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678155; x=1732282955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+htfvT+o2F1nEtNcEZjC1+AFmm0hfW6zBIW8BVMW5Y=;
        b=Ox0x1mISZ8Ibw024l2bz7xWZM0KcQofG05fpr8eOUXLVxz3ENmX7xhjSyMDw+zrkck
         snlyxtjVQ4S3cNFAgdZuy3Y801IQAENHmqIUeAdqsfU65bxM9L1HHCk+pbpdlD1m7hEC
         +YD709u594O38wtAlPY7DI1VflUOKUIt1HNYztz+hxEA7VIarVXuhqz/eu3KvGBkiMDW
         zL47TuSbu2hxpV7YekPho0IF0el9gnyCWDxBFUcBv2ah8/yTijh8KVRD8jImOvBO7nif
         7Am4nMPrXgG9EX+xkqyX2aytCef+CFAXKODEfuxRDvVv7u2xOyYtXceSpKVgHtsHP0wg
         gpnA==
X-Gm-Message-State: AOJu0YyKxGAoeq9BxMUA9YEXwyRpIW9eExMy+fmy/V9Oy2ccgIDYJYhk
	MrePsdBb0eUYtHVs7XmpnjH4osaWnOEmpUgLt5PwneBJpO5jdDQk
X-Google-Smtp-Source: AGHT+IFoK4aZYXWHvgHgcpbUtBoY6dY8OTIN+PsTb4En9pRIflZCneCyc9UtRqY/t9IWDYySUE6kDg==
X-Received: by 2002:a17:907:7f8a:b0:a77:c30c:341 with SMTP id a640c23a62f3a-aa48324aa26mr213565566b.0.1731678155053;
        Fri, 15 Nov 2024 05:42:35 -0800 (PST)
Received: from [10.82.5.93] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26a69sm180753966b.34.2024.11.15.05.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:42:34 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 15 Nov 2024 14:42:15 +0100
Subject: [PATCH 2/8] midx-write: add repository field to
 `write_midx_context`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-2-761f8a2c7775@gmail.com>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, peff@peff.net
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14111;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=aqnzIqfQ9Q/2Lga8N+m93w2pRkd9qRAElYeuZ6Yj6Qs=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnN0/HKO+URYUHjGFcypDF89INHWa5GBxU3j2GG
 mcHZzMz3uOJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzdPxwAKCRA+1Z8kjkaM
 f6KiDACUX5Ow7GOqTCyfbr09BZLUevA8vT3TTl490fBB8z0BopM5KE+P3T46kEJb32yIvVWkgz8
 RbwR3KWcjhlLOME/TzSJlsB31sJj+exHd/g+ih1EDj+Fi8dhOLQze6vKr9iVXpYqgXmnVaemw/4
 21NeA7OodKwU09I4tr2qw7dbH8wn5AUR4GRzAscmL0/RF9p+XwOcPievuxHtVsSc6YRjTEgpt4X
 96rqh0sYG7pgKT7YKtNlWc0FHguebt30UGZHFPlxDit/6Ec6Juh29Yj7DPG+k+IQb4CSwElvBmI
 qeLLIBjX1JUszSzR3rzvfQOCuYiF1Is0pEcyNGocO/zVw249h+N4PZYxvIKyA+scELEjuQz64wW
 FlI3nLkrsIuAF01pwqkm5ySD4jo19ihY8jl2vNbFIraDus9ZjBUHrI0L8nFTuge9R5ybYLQuqfC
 JKigymNeY36hxOAXWzReY9OR/1GLI4NPaYMupwkn/PLokt/lhSYS9+wdApQq6nfbJrPEs=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The struct `write_midx_context` is used to pass context for creating
MIDX files. Adding the repository field here ensures that most functions
within `midx-write.c` have access to the field and can use that instead
of the global `repository` variable. This involves passing the
`repository` field to `write_midx_internal`. To do this, we add
`the_repository` usage to two non-static functions, which we'll remove
in upcoming commits.

With this, modify the static functions in `midx-write.c` to not use
global variables. This means, either we use existing alternatives (like
`repository` struct), or we pass down required fields from other
functions.

Signed-off-by: default avatarKarthik Nayak <karthik.188@gmail.com>
---
 midx-write.c | 97 ++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index c57726ef9475df693890d61627ce91409c1def7c..a384f7ddc8a396d0cffd528132bb8fcdc6b37e24 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -35,13 +35,13 @@ extern void clear_incremental_midx_files_ext(const char *object_dir,
 extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 				const char *idx_name);
 
-static size_t write_midx_header(struct hashfile *f,
-				unsigned char num_chunks,
+static size_t write_midx_header(const struct git_hash_algo *hash_algo,
+				struct hashfile *f, unsigned char num_chunks,
 				uint32_t num_packs)
 {
 	hashwrite_be32(f, MIDX_SIGNATURE);
 	hashwrite_u8(f, MIDX_VERSION);
-	hashwrite_u8(f, oid_version(the_hash_algo));
+	hashwrite_u8(f, oid_version(hash_algo));
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, 0); /* unused */
 	hashwrite_be32(f, num_packs);
@@ -110,6 +110,8 @@ struct write_midx_context {
 	uint32_t num_multi_pack_indexes_before;
 
 	struct string_list *to_include;
+
+	struct repository *repo;
 };
 
 static int should_include_pack(const struct write_midx_context *ctx,
@@ -154,7 +156,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-		p = add_packed_git(the_repository, full_path, full_path_len, 0);
+		p = add_packed_git(ctx->repo, full_path, full_path_len, 0);
 		if (!p) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
@@ -480,7 +482,7 @@ static int write_midx_oid_lookup(struct hashfile *f,
 				 void *data)
 {
 	struct write_midx_context *ctx = data;
-	unsigned char hash_len = the_hash_algo->rawsz;
+	unsigned char hash_len = ctx->repo->hash_algo->rawsz;
 	struct pack_midx_entry *list = ctx->entries;
 	uint32_t i;
 
@@ -605,7 +607,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	uint32_t *pack_order, base_objects = 0;
 	uint32_t i;
 
-	trace2_region_enter("midx", "midx_pack_order", the_repository);
+	trace2_region_enter("midx", "midx_pack_order", ctx->repo);
 
 	if (ctx->incremental && ctx->base_midx)
 		base_objects = ctx->base_midx->num_objects +
@@ -640,7 +642,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	}
 	free(data);
 
-	trace2_region_leave("midx", "midx_pack_order", the_repository);
+	trace2_region_leave("midx", "midx_pack_order", ctx->repo);
 
 	return pack_order;
 }
@@ -651,9 +653,10 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	struct strbuf buf = STRBUF_INIT;
 	char *tmp_file;
 
-	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
+	trace2_region_enter("midx", "write_midx_reverse_index", ctx->repo);
 
-	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
+	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
+								    ctx->repo->hash_algo));
 
 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
 					midx_hash, WRITE_REV);
@@ -664,7 +667,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	strbuf_release(&buf);
 	free(tmp_file);
 
-	trace2_region_leave("midx", "write_midx_reverse_index", the_repository);
+	trace2_region_leave("midx", "write_midx_reverse_index", ctx->repo);
 }
 
 static void prepare_midx_packing_data(struct packing_data *pdata,
@@ -672,10 +675,10 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 {
 	uint32_t i;
 
-	trace2_region_enter("midx", "prepare_midx_packing_data", the_repository);
+	trace2_region_enter("midx", "prepare_midx_packing_data", ctx->repo);
 
 	memset(pdata, 0, sizeof(struct packing_data));
-	prepare_packing_data(the_repository, pdata);
+	prepare_packing_data(ctx->repo, pdata);
 
 	for (i = 0; i < ctx->entries_nr; i++) {
 		uint32_t pos = ctx->pack_order[i];
@@ -686,7 +689,7 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
 	}
 
-	trace2_region_leave("midx", "prepare_midx_packing_data", the_repository);
+	trace2_region_leave("midx", "prepare_midx_packing_data", ctx->repo);
 }
 
 static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
@@ -702,7 +705,7 @@ static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
 		return 0;
 	}
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
+	if (!peel_iterated_oid(revs->repo, oid, &peeled))
 		oid = &peeled;
 
 	object = parse_object_or_die(oid, refname);
@@ -760,7 +763,7 @@ static int read_refs_snapshot(const char *refs_snapshot,
 			hex = &buf.buf[1];
 		}
 
-		if (parse_oid_hex(hex, &oid, &end) < 0)
+		if (parse_oid_hex_algop(hex, &oid, &end, revs->repo->hash_algo) < 0)
 			die(_("could not parse line: %s"), buf.buf);
 		if (*end)
 			die(_("malformed line: %s"), buf.buf);
@@ -783,17 +786,16 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	struct rev_info revs;
 	struct bitmap_commit_cb cb = {0};
 
-	trace2_region_enter("midx", "find_commits_for_midx_bitmap",
-			    the_repository);
+	trace2_region_enter("midx", "find_commits_for_midx_bitmap", ctx->repo);
 
 	cb.ctx = ctx;
 
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(ctx->repo, &revs, NULL);
 	if (refs_snapshot) {
 		read_refs_snapshot(refs_snapshot, &revs);
 	} else {
 		setup_revisions(0, NULL, &revs, NULL);
-		refs_for_each_ref(get_main_ref_store(the_repository),
+		refs_for_each_ref(get_main_ref_store(ctx->repo),
 				  add_ref_to_pending, &revs);
 	}
 
@@ -821,13 +823,12 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 
 	release_revisions(&revs);
 
-	trace2_region_leave("midx", "find_commits_for_midx_bitmap",
-			    the_repository);
+	trace2_region_leave("midx", "find_commits_for_midx_bitmap", ctx->repo);
 
 	return cb.commits;
 }
 
-static int write_midx_bitmap(const char *midx_name,
+static int write_midx_bitmap(struct repository *r, const char *midx_name,
 			     const unsigned char *midx_hash,
 			     struct packing_data *pdata,
 			     struct commit **commits,
@@ -840,9 +841,9 @@ static int write_midx_bitmap(const char *midx_name,
 	struct bitmap_writer writer;
 	struct pack_idx_entry **index;
 	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
-					hash_to_hex(midx_hash));
+				    hash_to_hex_algop(midx_hash, r->hash_algo));
 
-	trace2_region_enter("midx", "write_midx_bitmap", the_repository);
+	trace2_region_enter("midx", "write_midx_bitmap", r);
 
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
@@ -859,7 +860,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
-	bitmap_writer_init(&writer, the_repository, pdata);
+	bitmap_writer_init(&writer, r, pdata);
 	bitmap_writer_show_progress(&writer, flags & MIDX_PROGRESS);
 	bitmap_writer_build_type_index(&writer, index);
 
@@ -892,7 +893,7 @@ static int write_midx_bitmap(const char *midx_name,
 	free(bitmap_name);
 	bitmap_writer_free(&writer);
 
-	trace2_region_leave("midx", "write_midx_bitmap", the_repository);
+	trace2_region_leave("midx", "write_midx_bitmap", r);
 
 	return ret;
 }
@@ -944,7 +945,7 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 			 */
 			if (flags & MIDX_WRITE_REV_INDEX ||
 			    preferred_pack_name) {
-				if (prepare_midx_pack(the_repository, m,
+				if (prepare_midx_pack(ctx->repo, m,
 						      m->num_packs_in_base + i)) {
 					error(_("could not load pack"));
 					return 1;
@@ -1049,7 +1050,7 @@ static void clear_midx_files(const char *object_dir,
 	strbuf_release(&buf);
 }
 
-static int write_midx_internal(const char *object_dir,
+static int write_midx_internal(struct repository *r, const char *object_dir,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
@@ -1070,7 +1071,9 @@ static int write_midx_internal(const char *object_dir,
 	const char **keep_hashes = NULL;
 	struct chunkfile *cf;
 
-	trace2_region_enter("midx", "write_midx_internal", the_repository);
+	trace2_region_enter("midx", "write_midx_internal", r);
+
+	ctx.repo = r;
 
 	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
 	if (ctx.incremental && (flags & MIDX_WRITE_BITMAP))
@@ -1087,8 +1090,7 @@ static int write_midx_internal(const char *object_dir,
 			  midx_name.buf);
 
 	if (!packs_to_include || ctx.incremental) {
-		struct multi_pack_index *m = lookup_multi_pack_index(the_repository,
-								     object_dir);
+		struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
 		if (m && !midx_checksum_valid(m)) {
 			warning(_("ignoring existing multi-pack-index; checksum mismatch"));
 			m = NULL;
@@ -1351,7 +1353,7 @@ static int write_midx_internal(const char *object_dir,
 	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT, MIDX_CHUNK_FANOUT_SIZE,
 		  write_midx_oid_fanout);
 	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
-		  st_mult(ctx.entries_nr, the_hash_algo->rawsz),
+		  st_mult(ctx.entries_nr, r->hash_algo->rawsz),
 		  write_midx_oid_lookup);
 	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
 		  st_mult(ctx.entries_nr, MIDX_CHUNK_OFFSET_WIDTH),
@@ -1373,7 +1375,8 @@ static int write_midx_internal(const char *object_dir,
 			  write_midx_bitmapped_packs);
 	}
 
-	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
+	write_midx_header(r->hash_algo, f, get_num_chunks(cf),
+			  ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
 
 	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
@@ -1405,7 +1408,7 @@ static int write_midx_internal(const char *object_dir,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr = 0;
 
-		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
+		if (write_midx_bitmap(r, midx_name.buf, midx_hash, &pdata,
 				      commits, commits_nr, ctx.pack_order,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
@@ -1449,12 +1452,13 @@ static int write_midx_internal(const char *object_dir,
 		strbuf_release(&final_midx_name);
 
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
-			xstrdup(hash_to_hex(midx_hash));
+			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
 
 		for (i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
-			keep_hashes[j] = xstrdup(hash_to_hex(get_midx_checksum(m)));
+			keep_hashes[j] = xstrdup(hash_to_hex_algop(get_midx_checksum(m),
+								   r->hash_algo));
 			m = m->base_midx;
 		}
 
@@ -1462,11 +1466,11 @@ static int write_midx_internal(const char *object_dir,
 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
 	} else {
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
-			xstrdup(hash_to_hex(midx_hash));
+			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
 	}
 
 	if (ctx.m || ctx.base_midx)
-		close_object_store(the_repository->objects);
+		close_object_store(ctx.repo->objects);
 
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
@@ -1495,7 +1499,7 @@ static int write_midx_internal(const char *object_dir,
 	}
 	strbuf_release(&midx_name);
 
-	trace2_region_leave("midx", "write_midx_internal", the_repository);
+	trace2_region_leave("midx", "write_midx_internal", r);
 
 	return result;
 }
@@ -1505,8 +1509,8 @@ int write_midx_file(const char *object_dir,
 		    const char *refs_snapshot,
 		    unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
-				   refs_snapshot, flags);
+	return write_midx_internal(the_repository, object_dir, NULL, NULL,
+				   preferred_pack_name, refs_snapshot, flags);
 }
 
 int write_midx_file_only(const char *object_dir,
@@ -1515,8 +1519,9 @@ int write_midx_file_only(const char *object_dir,
 			 const char *refs_snapshot,
 			 unsigned flags)
 {
-	return write_midx_internal(object_dir, packs_to_include, NULL,
-				   preferred_pack_name, refs_snapshot, flags);
+	return write_midx_internal(the_repository, object_dir, packs_to_include,
+				   NULL, preferred_pack_name, refs_snapshot,
+				   flags);
 }
 
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
@@ -1572,7 +1577,8 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, NULL, flags);
+		result = write_midx_internal(r, object_dir, NULL,
+					     &packs_to_drop, NULL, NULL, flags);
 
 	string_list_clear(&packs_to_drop, 0);
 
@@ -1769,7 +1775,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
+	result = write_midx_internal(r, object_dir, NULL, NULL, NULL, NULL,
+				     flags);
 
 cleanup:
 	free(include_pack);

-- 
2.47.0

