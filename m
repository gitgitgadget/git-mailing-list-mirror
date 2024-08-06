Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F638DC7
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958693; cv=none; b=HA5tiJHjeMkp2/KixedYzof6xsQygQXj2XqZP1utxrT4s9PRfiUXN4E8Q6ltS4cPmpbF2wlbQwQ3QHn7sNRPp5FDg90sMAgwQOnTXgggFvqs2V5kTGGWzmDmc0qS3NVQUv09iRGGLZBsX4PPLMHF7/c2QNBMLsyn76xxP5vbBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958693; c=relaxed/simple;
	bh=Nfct63PBRSjSkPyz31F3sxoIy/lDr2rYxqAMyfcn84o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKfEJ5WH2I4fV/fTe2YyMFokWeYDomi4m9V1WwuBx9oQ0j6jUyY4NlqEUdnY9gS7yz0AByoEBeXyJH9jEtPqSyNYCZPP7+fPrOVCtYVdEo9kkjyCmzxva5T4lhOWn/yfxYYpFfpAmSvLGxIfVefIFOvQEhZA4e+oouM/7cY9Q5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gP6T1oQE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gP6T1oQE"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-690aabe2600so6888907b3.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958689; x=1723563489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LyE1MJqiClcKIcidgeH1tIX2TW7IvdDHmyaZAGljyaw=;
        b=gP6T1oQEPufI2PeWXS3ZupLRbE0Ddl0LX2ihIeSHPgnVbj8yGvpyp64tODdaEebDBq
         AmP6i4883NlXCaWqEKQlyZSw5gLeJ/q7r9EDGVubutatggh1WEyhIZvYLqU8ZKoufSWL
         Tcg9qaAKcy68D0p/5NQ6McAPIUjGnwukfw5D+SVYYgLZlHIDdjUnYB+5+V7xJ5GAClng
         JO1MNFjXXs3ZQXyNwUUDJwjwTtAYI9EbJqzcmJYBQFDfEhlviHwt5+2NmTgwj4SZAIED
         7VUwTc/2+KlpyBbr92An+BfSX9s4ShzlqyyC/Lb70j/16X7XnS+St+MnBk0qpzCleFyK
         b6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958689; x=1723563489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyE1MJqiClcKIcidgeH1tIX2TW7IvdDHmyaZAGljyaw=;
        b=eZqqNfJ7DG0KMuFQbcYcQtP2zvL2AdNliAi2B3HfyblhNQYSCWDA0loazrlx3LQiUk
         gY5SLJ/XLEl4xkjqA37FJwegGwo+wINz37keumD3oir7rHikPRiCcKlErr5ICALFINKp
         bOdM1AbevoPn6gQ9OBOXsf6K9SbVSWxKW7txl4YsEylGHxBra1xcgQndi/ZX3r1V651Z
         62TY8eQFXAL0po/cQ42+u+ezxohxuvyHEpSI8p2UsKasRkGTvVttXVtSDYS1YVGnzAZz
         FQVw07Iu4vDSxDeaXV81ui+RQz14Zzab8+1pNkqmZ4xyagjl9N2MCMD+Bo6jAiJ7YYuo
         Ml5A==
X-Gm-Message-State: AOJu0Yx3KM7uJcG5P7T7InDtblmdOCAK+woPO0rUhvGZThYq//lxpKKO
	83a1YA/NgxqD1xcwMH+jEsCFzJG6XdP4tN35+T849LhjoEa54STiMSwa7aHz0e9vj3j+1vlnysy
	A
X-Google-Smtp-Source: AGHT+IElQu8VInq0F2ceK3NbDU0u7AEunWogXLtx80dViyIVnUqAYK70TpaFlONqIp+r24GhPf9kAA==
X-Received: by 2002:a81:7c0a:0:b0:64b:69f0:f8f2 with SMTP id 00721157ae682-6895f41dfe5mr150586067b3.3.1722958688679;
        Tue, 06 Aug 2024 08:38:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a141568besm15574037b3.140.2024.08.06.08.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:38:08 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:38:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 19/19] midx: implement support for writing incremental
 MIDX chains
Message-ID: <5d467d38a8d454228032610b3506040b63eb6369.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

Now that the rest of the MIDX subsystem and relevant callers have been
updated to learn about how to read and process incremental MIDX chains,
let's finally update the implementation in `write_midx_internal()` to be
able to write incremental MIDX chains.

This new feature is available behind the `--incremental` option for the
`multi-pack-index` builtin, like so:

    $ git multi-pack-index write --incremental

The implementation for doing so is relatively straightforward, and boils
down to a handful of different kinds of changes implemented in this
patch:

  - The `compute_sorted_entries()` function is taught to reject objects
    which appear in any existing MIDX layer.

  - Functions like `write_midx_revindex()` are adjusted to write
    pack_order values which are offset by the number of objects in the
    base MIDX layer.

  - The end of `write_midx_internal()` is adjusted to move
    non-incremental MIDX files when necessary (i.e. when creating an
    incremental chain with an existing non-incremental MIDX in the
    repository).

There are a handful of other changes that are introduced, like new
functions to clear incremental MIDX files that are unrelated to the
current chain (using the same "keep_hash" mechanism as in the
non-incremental case).

The tests explicitly exercising the new incremental MIDX feature are
relatively limited for two reasons:

  1. Most of the "interesting" behavior is already thoroughly covered in
     t5319-multi-pack-index.sh, which handles the core logic of reading
     objects through a MIDX.

     The new tests in t5334-incremental-multi-pack-index.sh are mostly
     focused on creating and destroying incremental MIDXs, as well as
     stitching their results together across layers.

  2. A new GIT_TEST environment variable is added called
     "GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL", which modifies the
     entire test suite to write incremental MIDXs after repacking when
     combined with the "GIT_TEST_MULTI_PACK_INDEX" variable.

     This exercises the long tail of other interesting behavior that is
     defined implicitly throughout the rest of the CI suite. It is
     likewise added to the linux-TEST-vars job.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt  |  11 +-
 builtin/multi-pack-index.c              |   2 +
 builtin/repack.c                        |   8 +-
 ci/run-build-and-tests.sh               |   1 +
 midx-write.c                            | 314 ++++++++++++++++++++----
 midx.c                                  |  62 ++++-
 midx.h                                  |   4 +
 packfile.c                              |  16 +-
 packfile.h                              |   4 +
 t/README                                |   4 +
 t/lib-bitmap.sh                         |   6 +-
 t/lib-midx.sh                           |  28 +++
 t/t5319-multi-pack-index.sh             |  27 +-
 t/t5326-multi-pack-bitmaps.sh           |   1 +
 t/t5327-multi-pack-bitmaps-rev.sh       |   1 +
 t/t5332-multi-pack-reuse.sh             |   2 +
 t/t5334-incremental-multi-pack-index.sh |  46 ++++
 t/t7700-repack.sh                       |  27 +-
 18 files changed, 460 insertions(+), 104 deletions(-)
 create mode 100755 t/t5334-incremental-multi-pack-index.sh

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 3696506eb3..631d5c7d15 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -64,6 +64,12 @@ The file given at `<path>` is expected to be readable, and can contain
 duplicates. (If a given OID is given more than once, it is marked as
 preferred if at least one instance of it begins with the special `+`
 marker).
+
+	--incremental::
+		Write an incremental MIDX file containing only objects
+		and packs not present in an existing MIDX layer.
+		Migrates non-incremental MIDXs to incremental ones when
+		necessary. Incompatible with `--bitmap`.
 --
 
 verify::
@@ -74,6 +80,8 @@ expire::
 	have no objects referenced by the MIDX (with the exception of
 	`.keep` packs and cruft packs). Rewrite the MIDX file afterward
 	to remove all references to these pack-files.
++
+NOTE: this mode is incompatible with incremental MIDX files.
 
 repack::
 	Create a new pack-file containing objects in small pack-files
@@ -95,7 +103,8 @@ repack::
 +
 If `repack.packKeptObjects` is `false`, then any pack-files with an
 associated `.keep` file will not be selected for the batch to repack.
-
++
+NOTE: this mode is incompatible with incremental MIDX files.
 
 EXAMPLES
 --------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 9cf1a32d65..8805cbbeb3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -129,6 +129,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "progress", &opts.flags,
 			N_("force progress reporting"), MIDX_PROGRESS),
+		OPT_BIT(0, "incremental", &opts.flags,
+			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			 N_("write multi-pack index containing only given indexes")),
 		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
diff --git a/builtin/repack.c b/builtin/repack.c
index 8499bf0e12..7608430a37 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1514,8 +1514,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (run_update_server_info)
 		update_server_info(0);
 
-	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
-		write_midx_file(get_object_directory(), NULL, NULL, 0);
+	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0)) {
+		unsigned flags = 0;
+		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
+			flags |= MIDX_WRITE_INCREMENTAL;
+		write_midx_file(get_object_directory(), NULL, NULL, flags);
+	}
 
 cleanup:
 	string_list_clear(&names, 1);
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index e6fd68630c..2e28d02b20 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -25,6 +25,7 @@ linux-TEST-vars)
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
+	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_NO_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
diff --git a/midx-write.c b/midx-write.c
index 0accbdbb04..e74b3d82fa 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -17,6 +17,8 @@
 #include "refs.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "path.h"
+#include "pack-revindex.h"
 
 #define PACK_EXPIRED UINT_MAX
 #define BITMAP_POS_UNKNOWN (~((uint32_t)0))
@@ -25,7 +27,11 @@
 
 extern int midx_checksum_valid(struct multi_pack_index *m);
 extern void clear_midx_files_ext(const char *object_dir, const char *ext,
-				 unsigned char *keep_hash);
+				 const char *keep_hash);
+extern void clear_incremental_midx_files_ext(const char *object_dir,
+					     const char *ext,
+					     const char **keep_hashes,
+					     uint32_t hashes_nr);
 extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 				const char *idx_name);
 
@@ -86,6 +92,7 @@ struct write_midx_context {
 	size_t nr;
 	size_t alloc;
 	struct multi_pack_index *m;
+	struct multi_pack_index *base_midx;
 	struct progress *progress;
 	unsigned pack_paths_checked;
 
@@ -99,6 +106,9 @@ struct write_midx_context {
 
 	int preferred_pack_idx;
 
+	int incremental;
+	uint32_t num_multi_pack_indexes_before;
+
 	struct string_list *to_include;
 };
 
@@ -122,6 +132,9 @@ static int should_include_pack(const struct write_midx_context *ctx,
 	 */
 	if (ctx->m && midx_contains_pack(ctx->m, file_name))
 		return 0;
+	else if (ctx->base_midx && midx_contains_pack(ctx->base_midx,
+						      file_name))
+		return 0;
 	else if (ctx->to_include &&
 		 !string_list_has_string(ctx->to_include, file_name))
 		return 0;
@@ -338,7 +351,7 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
-		if (ctx->m)
+		if (ctx->m && !ctx->incremental)
 			midx_fanout_add_midx_fanout(&fanout, ctx->m, cur_fanout,
 						    ctx->preferred_pack_idx);
 
@@ -364,6 +377,10 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 			if (cur_object && oideq(&fanout.entries[cur_object - 1].oid,
 						&fanout.entries[cur_object].oid))
 				continue;
+			if (ctx->incremental && ctx->base_midx &&
+			    midx_has_oid(ctx->base_midx,
+					 &fanout.entries[cur_object].oid))
+				continue;
 
 			ALLOC_GROW(ctx->entries, st_add(ctx->entries_nr, 1),
 				   alloc_objects);
@@ -547,10 +564,16 @@ static int write_midx_revindex(struct hashfile *f,
 			       void *data)
 {
 	struct write_midx_context *ctx = data;
-	uint32_t i;
+	uint32_t i, nr_base;
+
+	if (ctx->incremental && ctx->base_midx)
+		nr_base = ctx->base_midx->num_objects +
+			ctx->base_midx->num_objects_in_base;
+	else
+		nr_base = 0;
 
 	for (i = 0; i < ctx->entries_nr; i++)
-		hashwrite_be32(f, ctx->pack_order[i]);
+		hashwrite_be32(f, ctx->pack_order[i] + nr_base);
 
 	return 0;
 }
@@ -579,12 +602,18 @@ static int midx_pack_order_cmp(const void *va, const void *vb)
 static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 {
 	struct midx_pack_order_data *data;
-	uint32_t *pack_order;
+	uint32_t *pack_order, base_objects = 0;
 	uint32_t i;
 
 	trace2_region_enter("midx", "midx_pack_order", the_repository);
 
+	if (ctx->incremental && ctx->base_midx)
+		base_objects = ctx->base_midx->num_objects +
+			ctx->base_midx->num_objects_in_base;
+
+	ALLOC_ARRAY(pack_order, ctx->entries_nr);
 	ALLOC_ARRAY(data, ctx->entries_nr);
+
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *e = &ctx->entries[i];
 		data[i].nr = i;
@@ -596,12 +625,11 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 
 	QSORT(data, ctx->entries_nr, midx_pack_order_cmp);
 
-	ALLOC_ARRAY(pack_order, ctx->entries_nr);
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *e = &ctx->entries[data[i].nr];
 		struct pack_info *pack = &ctx->info[ctx->pack_perm[e->pack_int_id]];
 		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
-			pack->bitmap_pos = i;
+			pack->bitmap_pos = i + base_objects;
 		pack->bitmap_nr++;
 		pack_order[i] = data[i].nr;
 	}
@@ -649,7 +677,8 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 	prepare_packing_data(the_repository, pdata);
 
 	for (i = 0; i < ctx->entries_nr; i++) {
-		struct pack_midx_entry *from = &ctx->entries[ctx->pack_order[i]];
+		uint32_t pos = ctx->pack_order[i];
+		struct pack_midx_entry *from = &ctx->entries[pos];
 		struct object_entry *to = packlist_alloc(pdata, &from->oid);
 
 		oe_set_in_pack(pdata, to,
@@ -897,37 +926,130 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 static int fill_packs_from_midx(struct write_midx_context *ctx,
 				const char *preferred_pack_name, uint32_t flags)
 {
-	uint32_t i;
+	struct multi_pack_index *m;
 
-	for (i = 0; i < ctx->m->num_packs; i++) {
-		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
+	for (m = ctx->m; m; m = m->base_midx) {
+		uint32_t i;
+
+		for (i = 0; i < m->num_packs; i++) {
+			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
-		if (flags & MIDX_WRITE_REV_INDEX || preferred_pack_name) {
 			/*
 			 * If generating a reverse index, need to have
 			 * packed_git's loaded to compare their
 			 * mtimes and object count.
 			 *
-			 *
 			 * If a preferred pack is specified, need to
 			 * have packed_git's loaded to ensure the chosen
 			 * preferred pack has a non-zero object count.
 			 */
-			if (prepare_midx_pack(the_repository, ctx->m, i))
-				return error(_("could not load pack"));
+			if (flags & MIDX_WRITE_REV_INDEX ||
+			    preferred_pack_name) {
+				if (prepare_midx_pack(the_repository, m,
+						      m->num_packs_in_base + i)) {
+					error(_("could not load pack"));
+					return 1;
+				}
 
-			if (open_pack_index(ctx->m->packs[i]))
-				die(_("could not open index for %s"),
-				    ctx->m->packs[i]->pack_name);
+				if (open_pack_index(m->packs[i]))
+					die(_("could not open index for %s"),
+					    m->packs[i]->pack_name);
+			}
+
+			fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
+				       m->pack_names[i],
+				       m->num_packs_in_base + i);
 		}
-
-		fill_pack_info(&ctx->info[ctx->nr++], ctx->m->packs[i],
-			       ctx->m->pack_names[i], i);
 	}
-
 	return 0;
 }
 
+static struct {
+	const char *non_split;
+	const char *split;
+} midx_exts[] = {
+	{NULL, MIDX_EXT_MIDX},
+	{MIDX_EXT_BITMAP, MIDX_EXT_BITMAP},
+	{MIDX_EXT_REV, MIDX_EXT_REV},
+};
+
+static int link_midx_to_chain(struct multi_pack_index *m)
+{
+	struct strbuf from = STRBUF_INIT;
+	struct strbuf to = STRBUF_INIT;
+	int ret = 0;
+	size_t i;
+
+	if (!m || m->has_chain) {
+		/*
+		 * Either no MIDX previously existed, or it was already
+		 * part of a MIDX chain. In both cases, we have nothing
+		 * to link, so return early.
+		 */
+		goto done;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
+		const unsigned char *hash = get_midx_checksum(m);
+
+		get_midx_filename_ext(&from, m->object_dir, hash,
+				      midx_exts[i].non_split);
+		get_split_midx_filename_ext(&to, m->object_dir, hash,
+					    midx_exts[i].split);
+
+		if (link(from.buf, to.buf) < 0 && errno != ENOENT) {
+			ret = error_errno(_("unable to link '%s' to '%s'"),
+					  from.buf, to.buf);
+			goto done;
+		}
+
+		strbuf_reset(&from);
+		strbuf_reset(&to);
+	}
+
+done:
+	strbuf_release(&from);
+	strbuf_release(&to);
+	return ret;
+}
+
+static void clear_midx_files(const char *object_dir,
+			     const char **hashes,
+			     uint32_t hashes_nr,
+			     unsigned incremental)
+{
+	/*
+	 * if incremental:
+	 *   - remove all non-incremental MIDX files
+	 *   - remove any incremental MIDX files not in the current one
+	 *
+	 * if non-incremental:
+	 *   - remove all incremental MIDX files
+	 *   - remove any non-incremental MIDX files not matching the current
+	 *     hash
+	 */
+	struct strbuf buf = STRBUF_INIT;
+	const char *exts[] = { MIDX_EXT_BITMAP, MIDX_EXT_REV, MIDX_EXT_MIDX };
+	uint32_t i, j;
+
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		clear_incremental_midx_files_ext(object_dir, exts[i],
+						 hashes, hashes_nr);
+		for (j = 0; j < hashes_nr; j++)
+			clear_midx_files_ext(object_dir, exts[i], hashes[j]);
+	}
+
+	if (incremental)
+		get_midx_filename(&buf, object_dir);
+	else
+		get_midx_chain_filename(&buf, object_dir);
+
+	if (unlink(buf.buf) && errno != ENOENT)
+		die_errno(_("failed to clear multi-pack-index at %s"), buf.buf);
+
+	strbuf_release(&buf);
+}
+
 static int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
@@ -940,42 +1062,66 @@ static int write_midx_internal(const char *object_dir,
 	uint32_t i, start_pack;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
+	struct tempfile *incr;
 	struct write_midx_context ctx = { 0 };
 	int bitmapped_packs_concat_len = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
+	const char **keep_hashes = NULL;
 	struct chunkfile *cf;
 
 	trace2_region_enter("midx", "write_midx_internal", the_repository);
 
-	get_midx_filename(&midx_name, object_dir);
+	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
+	if (ctx.incremental && (flags & MIDX_WRITE_BITMAP))
+		die(_("cannot write incremental MIDX with bitmap"));
+
+	if (ctx.incremental)
+		strbuf_addf(&midx_name,
+			    "%s/pack/multi-pack-index.d/tmp_midx_XXXXXX",
+			    object_dir);
+	else
+		get_midx_filename(&midx_name, object_dir);
 	if (safe_create_leading_directories(midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
 
-	if (!packs_to_include) {
-		/*
-		 * Only reference an existing MIDX when not filtering which
-		 * packs to include, since all packs and objects are copied
-		 * blindly from an existing MIDX if one is present.
-		 */
-		ctx.m = lookup_multi_pack_index(the_repository, object_dir);
-	}
+	if (!packs_to_include || ctx.incremental) {
+		struct multi_pack_index *m = lookup_multi_pack_index(the_repository,
+								     object_dir);
+		if (m && !midx_checksum_valid(m)) {
+			warning(_("ignoring existing multi-pack-index; checksum mismatch"));
+			m = NULL;
+		}
 
-	if (ctx.m && !midx_checksum_valid(ctx.m)) {
-		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
-		ctx.m = NULL;
+		if (m) {
+			/*
+			 * Only reference an existing MIDX when not filtering
+			 * which packs to include, since all packs and objects
+			 * are copied blindly from an existing MIDX if one is
+			 * present.
+			 */
+			if (ctx.incremental)
+				ctx.base_midx = m;
+			else if (!packs_to_include)
+				ctx.m = m;
+		}
 	}
 
 	ctx.nr = 0;
-	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
+	ctx.alloc = ctx.m ? ctx.m->num_packs + ctx.m->num_packs_in_base : 16;
 	ctx.info = NULL;
 	ALLOC_ARRAY(ctx.info, ctx.alloc);
 
-	if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
-					  flags) < 0) {
-		result = 1;
+	if (ctx.incremental) {
+		struct multi_pack_index *m = ctx.base_midx;
+		while (m) {
+			ctx.num_multi_pack_indexes_before++;
+			m = m->base_midx;
+		}
+	} else if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
+						 flags) < 0) {
 		goto cleanup;
 	}
 
@@ -992,7 +1138,8 @@ static int write_midx_internal(const char *object_dir,
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-	if ((ctx.m && ctx.nr == ctx.m->num_packs) &&
+	if ((ctx.m && ctx.nr == ctx.m->num_packs + ctx.m->num_packs_in_base) &&
+	    !ctx.incremental &&
 	    !(packs_to_include || packs_to_drop)) {
 		struct bitmap_index *bitmap_git;
 		int bitmap_exists;
@@ -1008,12 +1155,14 @@ static int write_midx_internal(const char *object_dir,
 			 * corresponding bitmap (or one wasn't requested).
 			 */
 			if (!want_bitmap)
-				clear_midx_files_ext(object_dir, ".bitmap",
-						     NULL);
+				clear_midx_files_ext(object_dir, "bitmap", NULL);
 			goto cleanup;
 		}
 	}
 
+	if (ctx.incremental && !ctx.nr)
+		goto cleanup; /* nothing to do */
+
 	if (preferred_pack_name) {
 		ctx.preferred_pack_idx = -1;
 
@@ -1159,8 +1308,30 @@ static int write_midx_internal(const char *object_dir,
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
 					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
 
-	hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR);
-	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
+	if (ctx.incremental) {
+		struct strbuf lock_name = STRBUF_INIT;
+
+		get_midx_chain_filename(&lock_name, object_dir);
+		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
+		strbuf_release(&lock_name);
+
+		incr = mks_tempfile_m(midx_name.buf, 0444);
+		if (!incr) {
+			error(_("unable to create temporary MIDX layer"));
+			return -1;
+		}
+
+		if (adjust_shared_perm(get_tempfile_path(incr))) {
+			error(_("unable to adjust shared permissions for '%s'"),
+			      get_tempfile_path(incr));
+			return -1;
+		}
+
+		f = hashfd(get_tempfile_fd(incr), get_tempfile_path(incr));
+	} else {
+		hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR);
+		f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
+	}
 
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
@@ -1253,14 +1424,55 @@ static int write_midx_internal(const char *object_dir,
 	 * have been freed in the previous if block.
 	 */
 
-	if (ctx.m)
+	CALLOC_ARRAY(keep_hashes, ctx.num_multi_pack_indexes_before + 1);
+
+	if (ctx.incremental) {
+		FILE *chainf = fdopen_lock_file(&lk, "w");
+		struct strbuf final_midx_name = STRBUF_INIT;
+		struct multi_pack_index *m = ctx.base_midx;
+
+		if (!chainf) {
+			error_errno(_("unable to open multi-pack-index chain file"));
+			return -1;
+		}
+
+		if (link_midx_to_chain(ctx.base_midx) < 0)
+			return -1;
+
+		get_split_midx_filename_ext(&final_midx_name, object_dir,
+					    midx_hash, MIDX_EXT_MIDX);
+
+		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
+			error_errno(_("unable to rename new multi-pack-index layer"));
+			return -1;
+		}
+
+		keep_hashes[ctx.num_multi_pack_indexes_before] =
+			xstrdup(hash_to_hex(midx_hash));
+
+		for (i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
+			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
+
+			keep_hashes[j] = xstrdup(hash_to_hex(get_midx_checksum(m)));
+			m = m->base_midx;
+		}
+
+		for (i = 0; i < ctx.num_multi_pack_indexes_before + 1; i++)
+			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
+	} else {
+		keep_hashes[ctx.num_multi_pack_indexes_before] =
+			xstrdup(hash_to_hex(midx_hash));
+	}
+
+	if (ctx.m || ctx.base_midx)
 		close_object_store(the_repository->objects);
 
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files_ext(object_dir, ".bitmap", midx_hash);
-	clear_midx_files_ext(object_dir, ".rev", midx_hash);
+	clear_midx_files(object_dir, keep_hashes,
+			 ctx.num_multi_pack_indexes_before + 1,
+			 ctx.incremental);
 
 cleanup:
 	for (i = 0; i < ctx.nr; i++) {
@@ -1275,6 +1487,11 @@ static int write_midx_internal(const char *object_dir,
 	free(ctx.entries);
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
+	if (keep_hashes) {
+		for (i = 0; i < ctx.num_multi_pack_indexes_before + 1; i++)
+			free((char *)keep_hashes[i]);
+		free(keep_hashes);
+	}
 	strbuf_release(&midx_name);
 
 	trace2_region_leave("midx", "write_midx_internal", the_repository);
@@ -1311,6 +1528,9 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	if (!m)
 		return 0;
 
+	if (m->base_midx)
+		die(_("cannot expire packs from an incremental multi-pack-index"));
+
 	CALLOC_ARRAY(count, m->num_packs);
 
 	if (flags & MIDX_PROGRESS)
@@ -1485,6 +1705,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 
 	if (!m)
 		return 0;
+	if (m->base_midx)
+		die(_("cannot repack an incremental multi-pack-index"));
 
 	CALLOC_ARRAY(include_pack, m->num_packs);
 
diff --git a/midx.c b/midx.c
index a53d65702d..c867b2b6c2 100644
--- a/midx.c
+++ b/midx.c
@@ -16,7 +16,10 @@
 
 int midx_checksum_valid(struct multi_pack_index *m);
 void clear_midx_files_ext(const char *object_dir, const char *ext,
-			  unsigned char *keep_hash);
+			  const char *keep_hash);
+void clear_incremental_midx_files_ext(const char *object_dir, const char *ext,
+				      char **keep_hashes,
+				      uint32_t hashes_nr);
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
@@ -521,6 +524,11 @@ int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m,
 	return 0;
 }
 
+int midx_has_oid(struct multi_pack_index *m, const struct object_id *oid)
+{
+	return bsearch_midx(oid, m, NULL);
+}
+
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n)
@@ -723,7 +731,8 @@ int midx_checksum_valid(struct multi_pack_index *m)
 }
 
 struct clear_midx_data {
-	char *keep;
+	char **keep;
+	uint32_t keep_nr;
 	const char *ext;
 };
 
@@ -731,32 +740,63 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
 				const char *file_name, void *_data)
 {
 	struct clear_midx_data *data = _data;
+	uint32_t i;
 
 	if (!(starts_with(file_name, "multi-pack-index-") &&
 	      ends_with(file_name, data->ext)))
 		return;
-	if (data->keep && !strcmp(data->keep, file_name))
-		return;
-
+	for (i = 0; i < data->keep_nr; i++) {
+		if (!strcmp(data->keep[i], file_name))
+			return;
+	}
 	if (unlink(full_path))
 		die_errno(_("failed to remove %s"), full_path);
 }
 
 void clear_midx_files_ext(const char *object_dir, const char *ext,
-			  unsigned char *keep_hash)
+			  const char *keep_hash)
 {
 	struct clear_midx_data data;
 	memset(&data, 0, sizeof(struct clear_midx_data));
 
-	if (keep_hash)
-		data.keep = xstrfmt("multi-pack-index-%s%s",
-				    hash_to_hex(keep_hash), ext);
+	if (keep_hash) {
+		ALLOC_ARRAY(data.keep, 1);
+
+		data.keep[0] = xstrfmt("multi-pack-index-%s.%s", keep_hash, ext);
+		data.keep_nr = 1;
+	}
 	data.ext = ext;
 
 	for_each_file_in_pack_dir(object_dir,
 				  clear_midx_file_ext,
 				  &data);
 
+	if (keep_hash)
+		free(data.keep[0]);
+	free(data.keep);
+}
+
+void clear_incremental_midx_files_ext(const char *object_dir, const char *ext,
+				      char **keep_hashes,
+				      uint32_t hashes_nr)
+{
+	struct clear_midx_data data;
+	uint32_t i;
+
+	memset(&data, 0, sizeof(struct clear_midx_data));
+
+	ALLOC_ARRAY(data.keep, hashes_nr);
+	for (i = 0; i < hashes_nr; i++)
+		data.keep[i] = xstrfmt("multi-pack-index-%s.%s", keep_hashes[i],
+				       ext);
+	data.keep_nr = hashes_nr;
+	data.ext = ext;
+
+	for_each_file_in_pack_subdir(object_dir, "multi-pack-index.d",
+				     clear_midx_file_ext, &data);
+
+	for (i = 0; i < hashes_nr; i++)
+		free(data.keep[i]);
 	free(data.keep);
 }
 
@@ -774,8 +814,8 @@ void clear_midx_file(struct repository *r)
 	if (remove_path(midx.buf))
 		die(_("failed to clear multi-pack-index at %s"), midx.buf);
 
-	clear_midx_files_ext(r->objects->odb->path, ".bitmap", NULL);
-	clear_midx_files_ext(r->objects->odb->path, ".rev", NULL);
+	clear_midx_files_ext(r->objects->odb->path, MIDX_EXT_BITMAP, NULL);
+	clear_midx_files_ext(r->objects->odb->path, MIDX_EXT_REV, NULL);
 
 	strbuf_release(&midx);
 }
diff --git a/midx.h b/midx.h
index 3714cad2cc..42d4f8d149 100644
--- a/midx.h
+++ b/midx.h
@@ -29,6 +29,8 @@ struct bitmapped_pack;
 #define MIDX_LARGE_OFFSET_NEEDED 0x80000000
 
 #define GIT_TEST_MULTI_PACK_INDEX "GIT_TEST_MULTI_PACK_INDEX"
+#define GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL \
+	"GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL"
 
 struct multi_pack_index {
 	struct multi_pack_index *next;
@@ -77,6 +79,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP (1 << 2)
 #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
 #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
+#define MIDX_WRITE_INCREMENTAL (1 << 5)
 
 #define MIDX_EXT_REV "rev"
 #define MIDX_EXT_BITMAP "bitmap"
@@ -101,6 +104,7 @@ int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
 		     uint32_t *result);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m,
 		 uint32_t *result);
+int midx_has_oid(struct multi_pack_index *m, const struct object_id *oid);
 off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos);
 uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
diff --git a/packfile.c b/packfile.c
index 1eb18e3041..cf12a539ea 100644
--- a/packfile.c
+++ b/packfile.c
@@ -815,9 +815,10 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-void for_each_file_in_pack_dir(const char *objdir,
-			       each_file_in_pack_dir_fn fn,
-			       void *data)
+void for_each_file_in_pack_subdir(const char *objdir,
+				  const char *subdir,
+				  each_file_in_pack_dir_fn fn,
+				  void *data)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -826,6 +827,8 @@ void for_each_file_in_pack_dir(const char *objdir,
 
 	strbuf_addstr(&path, objdir);
 	strbuf_addstr(&path, "/pack");
+	if (subdir)
+		strbuf_addf(&path, "/%s", subdir);
 	dir = opendir(path.buf);
 	if (!dir) {
 		if (errno != ENOENT)
@@ -847,6 +850,13 @@ void for_each_file_in_pack_dir(const char *objdir,
 	strbuf_release(&path);
 }
 
+void for_each_file_in_pack_dir(const char *objdir,
+			       each_file_in_pack_dir_fn fn,
+			       void *data)
+{
+	for_each_file_in_pack_subdir(objdir, NULL, fn, data);
+}
+
 struct prepare_pack_data {
 	struct repository *r;
 	struct string_list *garbage;
diff --git a/packfile.h b/packfile.h
index eb18ec15db..0f78658229 100644
--- a/packfile.h
+++ b/packfile.h
@@ -55,6 +55,10 @@ struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
 				      const char *file_name, void *data);
+void for_each_file_in_pack_subdir(const char *objdir,
+				  const char *subdir,
+				  each_file_in_pack_dir_fn fn,
+				  void *data);
 void for_each_file_in_pack_dir(const char *objdir,
 			       each_file_in_pack_dir_fn fn,
 			       void *data);
diff --git a/t/README b/t/README
index 3cee0c05e2..44c02d8129 100644
--- a/t/README
+++ b/t/README
@@ -445,6 +445,10 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
 index to be written after every 'git repack' command, and overrides the
 'core.multiPackIndex' setting to true.
 
+GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=<boolean>, when true, sets
+the '--incremental' option on all invocations of 'git multi-pack-index
+write'.
+
 GIT_TEST_SIDEBAND_ALL=<boolean>, when true, overrides the
 'uploadpack.allowSidebandAll' setting to true, and when false, forces
 fetch-pack to not request sideband-all (even if the server advertises
diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index f595937094..62aa6744a6 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -1,6 +1,8 @@
 # Helpers for scripts testing bitmap functionality; see t5310 for
 # example usage.
 
+. "$TEST_DIRECTORY"/lib-midx.sh
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
@@ -264,10 +266,6 @@ have_delta () {
 	test_cmp expect actual
 }
 
-midx_checksum () {
-	test-tool read-midx --checksum "$1"
-}
-
 # midx_pack_source <obj>
 midx_pack_source () {
 	test-tool read-midx --show-objects .git/objects | grep "^$1 " | cut -f2
diff --git a/t/lib-midx.sh b/t/lib-midx.sh
index 1261994744..e38c609604 100644
--- a/t/lib-midx.sh
+++ b/t/lib-midx.sh
@@ -6,3 +6,31 @@ test_midx_consistent () {
 	test_cmp expect actual &&
 	git multi-pack-index --object-dir=$1 verify
 }
+
+midx_checksum () {
+	test-tool read-midx --checksum "$1"
+}
+
+midx_git_two_modes () {
+	git -c core.multiPackIndex=false $1 >expect &&
+	git -c core.multiPackIndex=true $1 >actual &&
+	if [ "$2" = "sorted" ]
+	then
+		sort <expect >expect.sorted &&
+		mv expect.sorted expect &&
+		sort <actual >actual.sorted &&
+		mv actual.sorted actual
+	fi &&
+	test_cmp expect actual
+}
+
+compare_results_with_midx () {
+	MSG=$1
+	test_expect_success "check normal git operations: $MSG" '
+		midx_git_two_modes "rev-list --objects --all" &&
+		midx_git_two_modes "log --raw" &&
+		midx_git_two_modes "count-objects --verbose" &&
+		midx_git_two_modes "cat-file --batch-all-objects --batch-check" &&
+		midx_git_two_modes "cat-file --batch-all-objects --batch-check --unordered" sorted
+	'
+}
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 8c54fc0655..ce1b58c732 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -3,8 +3,11 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
+. "$TEST_DIRECTORY"/lib-midx.sh
 
 GIT_TEST_MULTI_PACK_INDEX=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
 objdir=.git/objects
 
 HASH_LEN=$(test_oid rawsz)
@@ -107,30 +110,6 @@ test_expect_success 'write midx with one v1 pack' '
 	midx_read_expect 1 18 4 $objdir
 '
 
-midx_git_two_modes () {
-	git -c core.multiPackIndex=false $1 >expect &&
-	git -c core.multiPackIndex=true $1 >actual &&
-	if [ "$2" = "sorted" ]
-	then
-		sort <expect >expect.sorted &&
-		mv expect.sorted expect &&
-		sort <actual >actual.sorted &&
-		mv actual.sorted actual
-	fi &&
-	test_cmp expect actual
-}
-
-compare_results_with_midx () {
-	MSG=$1
-	test_expect_success "check normal git operations: $MSG" '
-		midx_git_two_modes "rev-list --objects --all" &&
-		midx_git_two_modes "log --raw" &&
-		midx_git_two_modes "count-objects --verbose" &&
-		midx_git_two_modes "cat-file --batch-all-objects --batch-check" &&
-		midx_git_two_modes "cat-file --batch-all-objects --batch-check --unordered" sorted
-	'
-}
-
 test_expect_success 'write midx with one v2 pack' '
 	git pack-objects --index-version=2,0x40 $objdir/pack/test <obj-list &&
 	git multi-pack-index --object-dir=$objdir write &&
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 1cb3e3ff08..832b92619c 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -7,6 +7,7 @@ test_description='exercise basic multi-pack bitmap functionality'
 # We'll be writing our own MIDX, so avoid getting confused by the
 # automatic ones.
 GIT_TEST_MULTI_PACK_INDEX=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
 
 # This test exercise multi-pack bitmap functionality where the object order is
 # stored and read from a special chunk within the MIDX, so use the default
diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
index 23db949c20..9cac03a94b 100755
--- a/t/t5327-multi-pack-bitmaps-rev.sh
+++ b/t/t5327-multi-pack-bitmaps-rev.sh
@@ -8,6 +8,7 @@ test_description='exercise basic multi-pack bitmap functionality (.rev files)'
 # We'll be writing our own MIDX, so avoid getting confused by the automatic
 # ones.
 GIT_TEST_MULTI_PACK_INDEX=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
 
 # Unlike t5326, this test exercise multi-pack bitmap functionality where the
 # object order is stored in a separate .rev file.
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index ed823f37bc..941e73d354 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -6,6 +6,8 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
+GIT_TEST_MULTI_PACK_INDEX=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
 objdir=.git/objects
 packdir=$objdir/pack
 
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
new file mode 100755
index 0000000000..c3b08acc73
--- /dev/null
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='incremental multi-pack-index'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-midx.sh
+
+GIT_TEST_MULTI_PACK_INDEX=0
+export GIT_TEST_MULTI_PACK_INDEX
+
+objdir=.git/objects
+packdir=$objdir/pack
+midxdir=$packdir/multi-pack-index.d
+midx_chain=$midxdir/multi-pack-index-chain
+
+test_expect_success 'convert non-incremental MIDX to incremental' '
+	test_commit base &&
+	git repack -ad &&
+	git multi-pack-index write &&
+
+	test_path_is_file $packdir/multi-pack-index &&
+	old_hash="$(midx_checksum $objdir)" &&
+
+	test_commit other &&
+	git repack -d &&
+	git multi-pack-index write --incremental &&
+
+	test_path_is_missing $packdir/multi-pack-index &&
+	test_path_is_file $midx_chain &&
+	test_line_count = 2 $midx_chain &&
+	grep $old_hash $midx_chain
+'
+
+compare_results_with_midx 'incremental MIDX'
+
+test_expect_success 'convert incremental to non-incremental' '
+	test_commit squash &&
+	git repack -d &&
+	git multi-pack-index write &&
+
+	test_path_is_file $packdir/multi-pack-index &&
+	test_dir_is_empty $midxdir
+'
+
+compare_results_with_midx 'non-incremental MIDX conversion'
+
+test_done
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 8f34f05087..be1188e736 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -7,6 +7,9 @@ test_description='git repack works correctly'
 . "${TEST_DIRECTORY}/lib-midx.sh"
 . "${TEST_DIRECTORY}/lib-terminal.sh"
 
+GIT_TEST_MULTI_PACK_INDEX=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
+
 commit_and_pack () {
 	test_commit "$@" 1>&2 &&
 	incrpackid=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
@@ -117,7 +120,7 @@ test_expect_success '--local disables writing bitmaps when connected to alternat
 	(
 		cd member &&
 		test_commit "object" &&
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adl --write-bitmap-index 2>err &&
+		git repack -Adl --write-bitmap-index 2>err &&
 		cat >expect <<-EOF &&
 		warning: disabling bitmap writing, as some objects are not being packed
 		EOF
@@ -533,11 +536,11 @@ test_expect_success 'setup for --write-midx tests' '
 test_expect_success '--write-midx unchanged' '
 	(
 		cd midx &&
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack &&
+		git repack &&
 		test_path_is_missing $midx &&
 		test_path_is_missing $midx-*.bitmap &&
 
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack --write-midx &&
+		git repack --write-midx &&
 
 		test_path_is_file $midx &&
 		test_path_is_missing $midx-*.bitmap &&
@@ -550,7 +553,7 @@ test_expect_success '--write-midx with a new pack' '
 		cd midx &&
 		test_commit loose &&
 
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack --write-midx &&
+		git repack --write-midx &&
 
 		test_path_is_file $midx &&
 		test_path_is_missing $midx-*.bitmap &&
@@ -561,7 +564,7 @@ test_expect_success '--write-midx with a new pack' '
 test_expect_success '--write-midx with -b' '
 	(
 		cd midx &&
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack -mb &&
+		git repack -mb &&
 
 		test_path_is_file $midx &&
 		test_path_is_file $midx-*.bitmap &&
@@ -574,7 +577,7 @@ test_expect_success '--write-midx with -d' '
 		cd midx &&
 		test_commit repack &&
 
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Ad --write-midx &&
+		git repack -Ad --write-midx &&
 
 		test_path_is_file $midx &&
 		test_path_is_missing $midx-*.bitmap &&
@@ -587,21 +590,21 @@ test_expect_success 'cleans up MIDX when appropriate' '
 		cd midx &&
 
 		test_commit repack-2 &&
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb --write-midx &&
+		git repack -Adb --write-midx &&
 
 		checksum=$(midx_checksum $objdir) &&
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$checksum.bitmap &&
 
 		test_commit repack-3 &&
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb --write-midx &&
+		git repack -Adb --write-midx &&
 
 		test_path_is_file $midx &&
 		test_path_is_missing $midx-$checksum.bitmap &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
 
 		test_commit repack-4 &&
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb &&
+		git repack -Adb &&
 
 		find $objdir/pack -type f -name "multi-pack-index*" >files &&
 		test_must_be_empty files
@@ -622,7 +625,6 @@ test_expect_success '--write-midx with preferred bitmap tips' '
 		git log --format="create refs/tags/%s/%s %H" HEAD >refs &&
 		git update-ref --stdin <refs &&
 
-		GIT_TEST_MULTI_PACK_INDEX=0 \
 		git repack --write-midx --write-bitmap-index &&
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
@@ -714,13 +716,13 @@ test_expect_success '--write-midx removes stale pack-based bitmaps' '
 	(
 		cd repo &&
 		test_commit base &&
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Ab &&
+		git repack -Ab &&
 
 		pack_bitmap=$(ls $objdir/pack/pack-*.bitmap) &&
 		test_path_is_file "$pack_bitmap" &&
 
 		test_commit tip &&
-		GIT_TEST_MULTI_PACK_INDEX=0 git repack -bm &&
+		git repack -bm &&
 
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
@@ -743,7 +745,6 @@ test_expect_success '--write-midx with --pack-kept-objects' '
 		keep="$objdir/pack/pack-$one.keep" &&
 		touch "$keep" &&
 
-		GIT_TEST_MULTI_PACK_INDEX=0 \
 		git repack --write-midx --write-bitmap-index --geometric=2 -d \
 			--pack-kept-objects &&
 
-- 
2.46.0.46.g406f326d27.dirty
