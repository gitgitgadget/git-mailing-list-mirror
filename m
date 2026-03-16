Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216839F17F
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674991; cv=none; b=OkpPc9zO+xl/quQamd9pZSF+MvS0s1WW7YMdhm8OdJ56oZDEGhvVgyOfUFk0j+XGzV9HlLVZsejS6Op+KxyNneKXh8aVhOnbJMCYqla8tOaDb16MQDmcvGEDD04vrMDWPSLGIh8l00ssYuIjbxh6zRJk/0dqORhVgKLau5kJme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674991; c=relaxed/simple;
	bh=pSZJS+5Ppli74ToBj7XWdtdY7x9UUUQzAtY2kRF4tz4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tjMNsxI/Mk5c7WBUhLJeky2AFgOV2ow66oGTWJjoXCVFQi68qwXgx/sDGt5Ppo0n8QpltDpiYdkMwsLL5l094JE27ZtYAxaLpn7kB1X6S5YYlGmwJjRoqhLjiDKT1hILAVFjS7rdee4vYeH3VrVXWzb5cmmADSCg5lZPF02pujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1WAh8mI; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1WAh8mI"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd8c6e365eso489624785a.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674988; x=1774279788; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlOXwLIFvF3MIm0E9vuY0I7xHAiyn9ZGJgtfCVJ4xqo=;
        b=E1WAh8mINSaQJGmRuL8tz/B29vrjvb9/1kIg1TByXrsbbTfrnyg/5Gg9cneeHDYDuC
         NV6VA8A0LXHYKJV1cD/cCvTlLrL/lCQzSY7DJFLaJ8uAufR9wf0t7YXC7gL3vdxBW1s1
         dyQsTWZvUztAAXHEIrIijZzBB1k8XoTq+TktsN7Xz9pL0K/BeOHn2lX/umPBaHQCnRB1
         sN7F8pWK5HcpidsfefKOyTPHwRuEk1ZNhmv1cGpm7OSeESXMQE7/3lCU95+V9Al3ePK0
         qBNsrlu13R10bjaPVppHDPIburEoe+a8uXRqa8fc5mOXUZ0KIHzK8ExJdSZYxIrQ3O1w
         SASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674988; x=1774279788;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jlOXwLIFvF3MIm0E9vuY0I7xHAiyn9ZGJgtfCVJ4xqo=;
        b=kZ3vzMEh7vqfKamGTKnXoeN97qEOdZBDbzMlIVJZ1Hb8/zik4U6GYJbas3pvcCt/bW
         VbKRejazWRG7LMhz8CVOYB1CsPJY59/Ie/b3sO1yLHo7qq0blgu48+7tUcQoRVAtH44X
         mXcZMy1BQ6Huk181V3J+wE86BUvXRzgq/Ki1obFUCymJkC3i9mAnl75W/xnekf0mXMNc
         MJU/aaBdMlQPLtS+fRo4FDAv70hys14q3TyjUDmvYIC70LZp4X/G7ceFgP4NppCUFfSq
         PI5YBe17r5FlJrXV8higl2iUNa0B6TcVy3FqzIFDjrGqVbss9J8AoDa+YtoqU3Vp3QJA
         VUIg==
X-Gm-Message-State: AOJu0Yzc2IHipaPfms3RpMd60Hy0wZUb1U/YeKWYgVlDTYJqlpIq1qmI
	biQt0LzYnEJCHzQy8IWGuHvvmiQtBCv9yvx8OeQXzBAWvlwy8q/bh1I5HKk61A==
X-Gm-Gg: ATEYQzz4onsuzlqDOePCuRf/63GyPBaJ/rqhxOVz45t7WeBXZLyj1iTysLB7aDNWTVt
	H5Y6VvSp1QPb58InNJ3K0ee32eHlllwgrQHRMIluchlEtkbZXjv232U0rNuc4reeu14M1zgBqss
	738q1G6fVvtbt/rcoCg4W7jNpUReoFMv5KlrwVexacVpotajQZ/Sccxud3WNpC4+UKtvSI237Xy
	OCRzZDCiSkHU5Lxi+NVSf33JuddsJprYnsBzRN/fZrL3KeY7hHnXZ6X7fBvOTQoJXQGR8kWNS9o
	T8jkMUKXG/bPSrzClUGDAkqoaQACWhump0x2m8aK2FjJK8qwHCjVVmhxZlYvz7VXoWnBO+ibhhU
	aHAjde5xP0y2DjpYVjWwFW7cukJxQynv2fzs5mOsNv3KhyNSs8Fr0UIM2iy7ZVc0DSXsfGi2RPa
	lEJVgJtXr5MYBd0xuknTswLoqZ
X-Received: by 2002:a05:620a:44ce:b0:8cb:b0f1:cf29 with SMTP id af79cd13be357-8cdb5b5a94bmr1747382385a.37.1773674987645;
        Mon, 16 Mar 2026 08:29:47 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.99.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda20192b1sm1226780885a.22.2026.03.16.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:29:47 -0700 (PDT)
Message-Id: <a8303b1427a41fd4b3ca107eabc49e8ac6d02410.1773674983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2068.git.1773674983.gitgitgadget@gmail.com>
References: <pull.2068.git.1773674983.gitgitgadget@gmail.com>
From: "Aaron Paterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Mar 2026 15:29:43 +0000
Subject: [PATCH 2/2] odb: use odb_source_files_try() in source-chain
 iterations
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Aaron Paterson <apaterson@pm.me>,
    Aaron Paterson <apaterson@pm.me>

From: Aaron Paterson <apaterson@pm.me>

Convert all source-chain iteration sites that access
files-specific internals (pack store, loose cache, MIDX) to use
odb_source_files_try() instead of odb_source_files_downcast().

These loops iterate the full source chain, which may include
alternates. When a non-files backend is added to the chain (as an
alternate or additional source), these sites must skip it rather
than abort. The _try() helper returns NULL for non-files sources,
and each site checks for NULL before accessing files-specific
members.

Call sites that access odb->sources directly (the primary source,
which is always a files backend) or that are inside files-backend
vtable callbacks continue to use odb_source_files_downcast() with
its BUG() safety guarantee.

Sites converted (22 across 11 files):

  - loose.c: loose object map loading and oid lookup
  - midx.c: multi-pack-index access and cleanup
  - object-file.c: loose cache and reprepare
  - object-name.c: short object filename search
  - packfile.c: window/fd management, pack entry lookup
  - packfile.h: repo_for_each_pack iterator macros
  - commit-graph.c: packed object enumeration
  - builtin/cat-file.c: batch object iteration
  - builtin/fast-import.c: pack lookup in store/stream
  - builtin/grep.c: pack preparation
  - builtin/pack-objects.c: cruft/kept pack enumeration

Add a unit test verifying odb_source_files_try() returns the
correct backend for ODB_SOURCE_FILES and NULL for other types.

Note: repo_approximate_object_count() and has_object_pack() will
not account for objects in non-files sources. These are
display and optimization functions respectively, and a follow-up
series can add vtable callbacks to address this.

Signed-off-by: Aaron Paterson <apaterson@pm.me>
---
 Makefile                    |  1 +
 builtin/cat-file.c          |  9 ++++++---
 builtin/fast-import.c       |  8 ++++++--
 builtin/grep.c              |  4 +++-
 builtin/pack-objects.c      | 15 +++++++++++----
 commit-graph.c              |  4 +++-
 loose.c                     | 12 +++++++++---
 midx.c                      |  8 ++++++--
 object-file.c               | 20 ++++++++++++++------
 object-name.c               |  8 +++++---
 packfile.c                  | 23 +++++++++++++++++------
 packfile.h                  | 14 ++++++++++----
 t/meson.build               |  1 +
 t/unit-tests/u-odb-source.c | 25 +++++++++++++++++++++++++
 14 files changed, 117 insertions(+), 35 deletions(-)
 create mode 100644 t/unit-tests/u-odb-source.c

diff --git a/Makefile b/Makefile
index 58fb895f4e..3d65093d5a 100644
--- a/Makefile
+++ b/Makefile
@@ -1544,6 +1544,7 @@ CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_SUITES += u-urlmatch-normalization
 CLAR_TEST_SUITES += u-utf8-width
+CLAR_TEST_SUITES += u-odb-source
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b6f12f41d6..0c63705b72 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -882,9 +882,12 @@ static void batch_each_object(struct batch_options *opt,
 		struct object_info oi = { 0 };
 
 		for (source = the_repository->objects->sources; source; source = source->next) {
-			struct odb_source_files *files = odb_source_files_downcast(source);
-			int ret = packfile_store_for_each_object(files->packed, &oi,
-								 batch_one_object_oi, &payload, flags);
+			struct odb_source_files *files = odb_source_files_try(source);
+			int ret;
+			if (!files)
+				continue;
+			ret = packfile_store_for_each_object(files->packed, &oi,
+							     batch_one_object_oi, &payload, flags);
 			if (ret)
 				break;
 		}
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index a41f95191e..cef77ac937 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -982,7 +982,9 @@ static int store_object(
 	}
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct odb_source_files *files = odb_source_files_try(source);
+		if (!files)
+			continue;
 
 		if (!packfile_list_find_oid(packfile_store_get_packs(files->packed), &oid))
 			continue;
@@ -1189,7 +1191,9 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	}
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct odb_source_files *files = odb_source_files_try(source);
+		if (!files)
+			continue;
 
 		if (!packfile_list_find_oid(packfile_store_get_packs(files->packed), &oid))
 			continue;
diff --git a/builtin/grep.c b/builtin/grep.c
index e33285e5e6..ea41236ce5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1219,7 +1219,9 @@ int cmd_grep(int argc,
 
 			odb_prepare_alternates(the_repository->objects);
 			for (source = the_repository->objects->sources; source; source = source->next) {
-				struct odb_source_files *files = odb_source_files_downcast(source);
+				struct odb_source_files *files = odb_source_files_try(source);
+				if (!files)
+					continue;
 				packfile_store_prepare(files->packed);
 			}
 		}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cd013c0b68..229e3e40b0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1531,8 +1531,11 @@ static int want_cruft_object_mtime(struct repository *r,
 	struct odb_source *source;
 
 	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packed_git **cache = packfile_store_get_kept_pack_cache(files->packed, flags);
+		struct odb_source_files *files = odb_source_files_try(source);
+		struct packed_git **cache;
+		if (!files)
+			continue;
+		cache = packfile_store_get_kept_pack_cache(files->packed, flags);
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
@@ -1754,7 +1757,9 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 	}
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct odb_source_files *files = odb_source_files_try(source);
+		if (!files)
+			continue;
 
 		for (e = files->packed->packs.head; e; e = e->next) {
 			struct packed_git *p = e->pack;
@@ -4350,7 +4355,9 @@ static void add_objects_in_unpacked_packs(void)
 
 	odb_prepare_alternates(to_pack.repo->objects);
 	for (source = to_pack.repo->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct odb_source_files *files = odb_source_files_try(source);
+		if (!files)
+			continue;
 
 		if (!source->local)
 			continue;
diff --git a/commit-graph.c b/commit-graph.c
index f8e24145a5..b425417735 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1981,7 +1981,9 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 
 	odb_prepare_alternates(ctx->r->objects);
 	for (source = ctx->r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct odb_source_files *files = odb_source_files_try(source);
+		if (!files)
+			continue;
 		packfile_store_for_each_object(files->packed, &oi, add_packed_commits_oi,
 					       ctx, ODB_FOR_EACH_OBJECT_PACK_ORDER);
 	}
diff --git a/loose.c b/loose.c
index 07333be696..1f036a8c2b 100644
--- a/loose.c
+++ b/loose.c
@@ -64,10 +64,13 @@ static int insert_loose_map(struct odb_source *source,
 
 static int load_one_loose_object_map(struct repository *repo, struct odb_source *source)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct odb_source_files *files = odb_source_files_try(source);
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
 
+	if (!files)
+		return 0;
+
 	if (!files->loose->map)
 		loose_object_map_init(&files->loose->map);
 	if (!files->loose->cache) {
@@ -235,8 +238,11 @@ int repo_loose_object_map_oid(struct repository *repo,
 	khiter_t pos;
 
 	for (source = repo->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct loose_object_map *loose_map = files->loose->map;
+		struct odb_source_files *files = odb_source_files_try(source);
+		struct loose_object_map *loose_map;
+		if (!files)
+			continue;
+		loose_map = files->loose->map;
 		if (!loose_map)
 			continue;
 		map = (to == repo->compat_hash_algo) ?
diff --git a/midx.c b/midx.c
index ab8e2611d1..d29b72f8d9 100644
--- a/midx.c
+++ b/midx.c
@@ -95,7 +95,9 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct odb_source_files *files = odb_source_files_try(source);
+	if (!files)
+		return NULL;
 	packfile_store_prepare(files->packed);
 	return files->packed->midx;
 }
@@ -806,7 +808,9 @@ void clear_midx_file(struct repository *r)
 		struct odb_source *source;
 
 		for (source = r->objects->sources; source; source = source->next) {
-			struct odb_source_files *files = odb_source_files_downcast(source);
+			struct odb_source_files *files = odb_source_files_try(source);
+			if (!files)
+				continue;
 			if (files->packed->midx)
 				close_midx(files->packed->midx);
 			files->packed->midx = NULL;
diff --git a/object-file.c b/object-file.c
index a3ff7f586c..11136ee199 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1879,14 +1879,20 @@ static int append_loose_object(const struct object_id *oid,
 struct oidtree *odb_source_loose_cache(struct odb_source *source,
 				       const struct object_id *oid)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	int subdir_nr = oid->hash[0];
+	struct odb_source_files *files = odb_source_files_try(source);
+	int subdir_nr;
 	struct strbuf buf = STRBUF_INIT;
-	size_t word_bits = bitsizeof(files->loose->subdir_seen[0]);
-	size_t word_index = subdir_nr / word_bits;
-	size_t mask = (size_t)1u << (subdir_nr % word_bits);
+	size_t word_bits, word_index, mask;
 	uint32_t *bitmap;
 
+	if (!files)
+		return NULL;
+
+	subdir_nr = oid->hash[0];
+	word_bits = bitsizeof(files->loose->subdir_seen[0]);
+	word_index = subdir_nr / word_bits;
+	mask = (size_t)1u << (subdir_nr % word_bits);
+
 	if (subdir_nr < 0 ||
 	    (size_t) subdir_nr >= bitsizeof(files->loose->subdir_seen))
 		BUG("subdir_nr out of range");
@@ -1919,7 +1925,9 @@ static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 
 void odb_source_loose_reprepare(struct odb_source *source)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct odb_source_files *files = odb_source_files_try(source);
+	if (!files)
+		return;
 	odb_source_loose_clear_cache(files->loose);
 }
 
diff --git a/object-name.c b/object-name.c
index 7b14c3bf9b..09835a3225 100644
--- a/object-name.c
+++ b/object-name.c
@@ -115,9 +115,11 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	struct odb_source *source;
 
-	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		oidtree_each(odb_source_loose_cache(source, &ds->bin_pfx),
-				&ds->bin_pfx, ds->len, match_prefix, ds);
+	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next) {
+		struct oidtree *tree = odb_source_loose_cache(source, &ds->bin_pfx);
+		if (tree)
+			oidtree_each(tree, &ds->bin_pfx, ds->len, match_prefix, ds);
+	}
 }
 
 static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
diff --git a/packfile.c b/packfile.c
index 215a23e42b..d7416e577f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -363,7 +363,9 @@ static int unuse_one_window(struct object_database *odb)
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
 	for (source = odb->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct odb_source_files *files = odb_source_files_try(source);
+		if (!files)
+			continue;
 		for (e = files->packed->packs.head; e; e = e->next)
 			scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
 	}
@@ -539,7 +541,9 @@ static int close_one_pack(struct repository *r)
 	int accept_windows_inuse = 1;
 
 	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct odb_source_files *files = odb_source_files_try(source);
+		if (!files)
+			continue;
 		for (e = files->packed->packs.head; e; e = e->next) {
 			if (e->pack->pack_fd == -1)
 				continue;
@@ -1251,8 +1255,10 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 	struct odb_source *source;
 
 	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct odb_source_files *files = odb_source_files_try(source);
 		struct packfile_list_entry *e;
+		if (!files)
+			continue;
 
 		for (e = files->packed->packs.head; e; e = e->next)
 			if (oidset_contains(&e->pack->bad_objects, oid))
@@ -2268,8 +2274,11 @@ int has_object_pack(struct repository *r, const struct object_id *oid)
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		int ret = find_pack_entry(files->packed, oid, &e);
+		struct odb_source_files *files = odb_source_files_try(source);
+		int ret;
+		if (!files)
+			continue;
+		ret = find_pack_entry(files->packed, oid, &e);
 		if (ret)
 			return ret;
 	}
@@ -2284,8 +2293,10 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 	struct pack_entry e;
 
 	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct odb_source_files *files = odb_source_files_try(source);
 		struct packed_git **cache;
+		if (!files)
+			continue;
 
 		cache = packfile_store_get_kept_pack_cache(files->packed, flags);
 
diff --git a/packfile.h b/packfile.h
index 8b04a258a7..3859415e4f 100644
--- a/packfile.h
+++ b/packfile.h
@@ -193,8 +193,11 @@ static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct
 	odb_prepare_alternates(repo->objects);
 
 	for (struct odb_source *source = repo->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packfile_list_entry *entry = packfile_store_get_packs(files->packed);
+		struct odb_source_files *files = odb_source_files_try(source);
+		struct packfile_list_entry *entry;
+		if (!files)
+			continue;
+		entry = packfile_store_get_packs(files->packed);
 		if (!entry)
 			continue;
 		data.source = source;
@@ -214,8 +217,11 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 		return;
 
 	for (source = data->source->next; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packfile_list_entry *entry = packfile_store_get_packs(files->packed);
+		struct odb_source_files *files = odb_source_files_try(source);
+		struct packfile_list_entry *entry;
+		if (!files)
+			continue;
+		entry = packfile_store_get_packs(files->packed);
 		if (!entry)
 			continue;
 		data->source = source;
diff --git a/t/meson.build b/t/meson.build
index f66a73f8a0..e689ee49c7 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -6,6 +6,7 @@ clar_test_suites = [
   'unit-tests/u-hashmap.c',
   'unit-tests/u-list-objects-filter-options.c',
   'unit-tests/u-mem-pool.c',
+  'unit-tests/u-odb-source.c',
   'unit-tests/u-oid-array.c',
   'unit-tests/u-oidmap.c',
   'unit-tests/u-oidtree.c',
diff --git a/t/unit-tests/u-odb-source.c b/t/unit-tests/u-odb-source.c
new file mode 100644
index 0000000000..6f11c5342c
--- /dev/null
+++ b/t/unit-tests/u-odb-source.c
@@ -0,0 +1,25 @@
+#include "unit-test.h"
+#include "odb/source.h"
+#include "odb/source-files.h"
+
+/*
+ * Verify that odb_source_files_try() returns the files backend
+ * for ODB_SOURCE_FILES and NULL for other source types.
+ */
+void test_odb_source__try_returns_files_for_files_type(void)
+{
+	struct odb_source_files files_src;
+	memset(&files_src, 0, sizeof(files_src));
+	files_src.base.type = ODB_SOURCE_FILES;
+
+	cl_assert(odb_source_files_try(&files_src.base) == &files_src);
+}
+
+void test_odb_source__try_returns_null_for_unknown_type(void)
+{
+	struct odb_source other_src;
+	memset(&other_src, 0, sizeof(other_src));
+	other_src.type = ODB_SOURCE_UNKNOWN;
+
+	cl_assert(odb_source_files_try(&other_src) == NULL);
+}
-- 
gitgitgadget
