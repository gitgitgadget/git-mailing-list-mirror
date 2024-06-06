Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6313E054
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715128; cv=none; b=i4WD7MC5y0Gp8ir0oGsvYvuHbPDeioN4553YV44uXmiSWL5/GYESHauZfEjRP4pdRplzZ0soiKzDLMV0Tx89ZNtcBtt6doDYqsm2bOHowrr0nJkFm4pDLfQs/3ohxhXUHRmRj+oS1zMvVbxuLfUgdCOczfrNsC6HHPyywnmTRwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715128; c=relaxed/simple;
	bh=ra2i8OOIfJuffgWy5TEhfvFGV06dNU25KYcemND/Uw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOAaDRrLMBw0QbKhJdEuCW+cfgob+WG2Ia8q2goXmYFa4OeGE/YYP4RRiyhQtsN/ugIt3p2cVHUpEXfO+D274i2R0QAIZ6OwCV/avE3f8cIu+02NNp4BMQiyMsC7yQ2DwuhjgaI1LwWssgUYURjd7CZ2X4bx7y4kirGmfxRdSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aN6xyCr/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aN6xyCr/"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7951d0c840bso99900585a.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715124; x=1718319924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtRqTihJITNCsj/gkWdx6EQdKJT+vtESR1aAs0IIqYY=;
        b=aN6xyCr/QLX1fEui4ur2Khv8JeR/EXmxOV/2eJpkwNM91ufHqtzrc3Vk8Qx+J+b2xU
         qHXVMulCbdZKjZFJg2Ayc/98HsdIm+GXSX17J+cs7hQPwz8/SRLC4KB5BVQ6BNzVMdvb
         paAxtUbnakW3dggSTvT6z5k9kHKVx7csM3YkcYSHenqY5zR8AuIqKAbKd2qHespnc+Rm
         9rDUNg7Tb+NGtn4Ys4UKBk4jHjC6LD7FYeke8nVq4fvRs2kab9pbQV+KqRuwi2asspQz
         0c2rk4MAOdGhJl1vo8/SwbgWHCT5CFZ/V6TjTRy2uyQeTm0u0VEKObZTbl82txhxrAbn
         AU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715124; x=1718319924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtRqTihJITNCsj/gkWdx6EQdKJT+vtESR1aAs0IIqYY=;
        b=un+5+3Wj0UTl6bdvs2c/HvvwYE4huabhg+rzKZNVpPUz9h6pe49rXAlqpe9eP77UVS
         flH7g77ZdqbfJjtqWQHE/B601da0SPCUCkAKsQL4nEIs+GEKcosDb4MI3hYaOvHbLtHZ
         j3IUZtNYMOTb7YhYYG4dBJsy5RDRpB5nFnJUrc3l5+N2EiCGxN1QGI8mpuyJvgJSTLaM
         hKl10q9AsinhG7WhCVWVOFdg4Sb7Qw27jzWOsu9NoyEaOmwQ6IiQiW8MH8PoRz/QdT2K
         /IfeXuLEXrAeTcuGGrXsiIVEp7toMklT5mogT+ULkt0hbH7ZhVu/PbaSj+KoJwj4yTOh
         qthg==
X-Gm-Message-State: AOJu0Yw55GgTFhkVOhRY8Mbnm2l++ro9ZwNlPgvdWF0qoO7QKTMTqzq0
	G04uZnyFpYMPNHFwjYd3VjbrHz66Vl6h146gtMcK9sOXSikwMl9pX7KQa1lI4xBvfD3hQy9mf2A
	euOI=
X-Google-Smtp-Source: AGHT+IEjcBy5SBmOxinGl//Vry7xtoI2wWNSM+1VrA9QjDV+IpOoZFYv19bWHBsCFgfkRgp7DdSUrw==
X-Received: by 2002:a05:620a:1a18:b0:794:f8fe:9ec2 with SMTP id af79cd13be357-7953c43ad4emr88050385a.43.1717715124251;
        Thu, 06 Jun 2024 16:05:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532849506sm103458385a.43.2024.06.06.16.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:05:23 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:05:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 19/19] midx: implement support for writing incremental MIDX
 chains
Message-ID: <97b3ea84b92c543c7bd15a2f054d0d3af1b34c67.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

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
 midx-write.c                            | 281 ++++++++++++++++++++----
 midx.c                                  |  62 +++++-
 midx.h                                  |   4 +
 packfile.c                              |  16 +-
 packfile.h                              |   4 +
 t/README                                |   4 +
 t/lib-bitmap.sh                         |   6 +-
 t/lib-midx.sh                           |  28 +++
 t/t5319-multi-pack-index.sh             |  27 +--
 t/t5326-multi-pack-bitmaps.sh           |   1 +
 t/t5327-multi-pack-bitmaps-rev.sh       |   1 +
 t/t5332-multi-pack-reuse.sh             |   2 +
 t/t5334-incremental-multi-pack-index.sh |  46 ++++
 t/t7700-repack.sh                       |  27 +--
 18 files changed, 436 insertions(+), 95 deletions(-)
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
index 8360932d2e..92b86153ba 100644
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
index e2fec16389..e1fab4d809 100644
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
index b148ee443a..241557d03e 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -15,6 +15,8 @@
 #include "refs.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "path.h"
+#include "pack-revindex.h"
 
 #define PACK_EXPIRED UINT_MAX
 #define BITMAP_POS_UNKNOWN (~((uint32_t)0))
@@ -23,7 +25,11 @@
 
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
 
@@ -97,6 +103,9 @@ struct write_midx_context {
 
 	int preferred_pack_idx;
 
+	int incremental;
+	uint32_t num_multi_pack_indexes_before;
+
 	struct string_list *to_include;
 };
 
@@ -322,7 +331,7 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
-		if (ctx->m)
+		if (ctx->m && !ctx->incremental)
 			midx_fanout_add_midx_fanout(&fanout, ctx->m, cur_fanout,
 						    ctx->preferred_pack_idx);
 
@@ -348,6 +357,9 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 			if (cur_object && oideq(&fanout.entries[cur_object - 1].oid,
 						&fanout.entries[cur_object].oid))
 				continue;
+			if (ctx->incremental && ctx->m &&
+			    midx_has_oid(ctx->m, &fanout.entries[cur_object].oid))
+				continue;
 
 			ALLOC_GROW(ctx->entries, st_add(ctx->entries_nr, 1),
 				   alloc_objects);
@@ -531,10 +543,15 @@ static int write_midx_revindex(struct hashfile *f,
 			       void *data)
 {
 	struct write_midx_context *ctx = data;
-	uint32_t i;
+	uint32_t i, nr_base;
+
+	if (ctx->m && ctx->incremental)
+		nr_base = ctx->m->num_objects + ctx->m->num_objects_in_base;
+	else
+		nr_base = 0;
 
 	for (i = 0; i < ctx->entries_nr; i++)
-		hashwrite_be32(f, ctx->pack_order[i]);
+		hashwrite_be32(f, ctx->pack_order[i] + nr_base);
 
 	return 0;
 }
@@ -563,12 +580,17 @@ static int midx_pack_order_cmp(const void *va, const void *vb)
 static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 {
 	struct midx_pack_order_data *data;
-	uint32_t *pack_order;
+	uint32_t *pack_order, base_objects = 0;
 	uint32_t i;
 
 	trace2_region_enter("midx", "midx_pack_order", the_repository);
 
+	if (ctx->incremental && ctx->m)
+		base_objects = ctx->m->num_objects + ctx->m->num_objects_in_base;
+
+	ALLOC_ARRAY(pack_order, ctx->entries_nr);
 	ALLOC_ARRAY(data, ctx->entries_nr);
+
 	for (i = 0; i < ctx->entries_nr; i++) {
 		struct pack_midx_entry *e = &ctx->entries[i];
 		data[i].nr = i;
@@ -580,12 +602,11 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 
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
@@ -633,7 +654,8 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 	prepare_packing_data(the_repository, pdata);
 
 	for (i = 0; i < ctx->entries_nr; i++) {
-		struct pack_midx_entry *from = &ctx->entries[ctx->pack_order[i]];
+		uint32_t pos = ctx->pack_order[i];
+		struct pack_midx_entry *from = &ctx->entries[pos];
 		struct object_entry *to = packlist_alloc(pdata, &from->oid);
 
 		oe_set_in_pack(pdata, to,
@@ -881,40 +903,133 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 static int fill_packs_from_midx(struct write_midx_context *ctx,
 				const char *preferred_pack_name, uint32_t flags)
 {
-	uint32_t i;
+	struct multi_pack_index *m;
 
-	for (i = 0; i < ctx->m->num_packs; i++) {
-		if (!should_include_pack(ctx, ctx->m->pack_names[i], 0))
-			continue;
+	for (m = ctx->m; m; m = m->base_midx) {
+		uint32_t i;
 
-		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-
-		if (flags & MIDX_WRITE_REV_INDEX || preferred_pack_name) {
+		for (i = 0; i < m->num_packs; i++) {
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
+			if (!should_include_pack(ctx, m->pack_names[i], 0))
+				continue;
 
-			if (open_pack_index(ctx->m->packs[i]))
-				die(_("could not open index for %s"),
-				    ctx->m->packs[i]->pack_name);
+			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
+
+			if (flags & MIDX_WRITE_REV_INDEX ||
+			    preferred_pack_name) {
+				if (prepare_midx_pack(the_repository, m,
+						      m->num_packs_in_base + i)) {
+					error(_("could not load pack"));
+					return 1;
+				}
+
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
@@ -927,16 +1042,27 @@ static int write_midx_internal(const char *object_dir,
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
@@ -948,14 +1074,19 @@ static int write_midx_internal(const char *object_dir,
 	}
 
 	ctx.nr = 0;
-	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
+	ctx.alloc = ctx.m ? ctx.m->num_packs + ctx.m->num_packs_in_base : 16;
 	ctx.info = NULL;
 	ctx.to_include = packs_to_include;
 	ALLOC_ARRAY(ctx.info, ctx.alloc);
 
-	if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
-					  flags) < 0) {
-		result = 1;
+	if (ctx.incremental) {
+		struct multi_pack_index *m = ctx.m;
+		while (m) {
+			ctx.num_multi_pack_indexes_before++;
+			m = m->base_midx;
+		}
+	} else if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
+						 flags) < 0) {
 		goto cleanup;
 	}
 
@@ -970,7 +1101,8 @@ static int write_midx_internal(const char *object_dir,
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-	if ((ctx.m && ctx.nr == ctx.m->num_packs) &&
+	if ((ctx.m && ctx.nr == ctx.m->num_packs + ctx.m->num_packs_in_base) &&
+	    !ctx.incremental &&
 	    !(packs_to_include || packs_to_drop)) {
 		struct bitmap_index *bitmap_git;
 		int bitmap_exists;
@@ -986,12 +1118,14 @@ static int write_midx_internal(const char *object_dir,
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
 
@@ -1137,8 +1271,30 @@ static int write_midx_internal(const char *object_dir,
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
@@ -1231,14 +1387,55 @@ static int write_midx_internal(const char *object_dir,
 	 * have been freed in the previous if block.
 	 */
 
+	CALLOC_ARRAY(keep_hashes, ctx.num_multi_pack_indexes_before + 1);
+
+	if (ctx.incremental) {
+		FILE *chainf = fdopen_lock_file(&lk, "w");
+		struct strbuf final_midx_name = STRBUF_INIT;
+		struct multi_pack_index *m = ctx.m;
+
+		if (!chainf) {
+			error_errno(_("unable to open multi-pack-index chain file"));
+			return -1;
+		}
+
+		if (link_midx_to_chain(ctx.m) < 0)
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
 	if (ctx.m)
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
@@ -1253,6 +1450,11 @@ static int write_midx_internal(const char *object_dir,
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
@@ -1289,6 +1491,9 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	if (!m)
 		return 0;
 
+	if (m->base_midx)
+		die(_("cannot expire packs from an incremental multi-pack-index"));
+
 	CALLOC_ARRAY(count, m->num_packs);
 
 	if (flags & MIDX_PROGRESS)
@@ -1463,6 +1668,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 
 	if (!m)
 		return 0;
+	if (m->base_midx)
+		die(_("cannot repack an incremental multi-pack-index"));
 
 	CALLOC_ARRAY(include_pack, m->num_packs);
 
diff --git a/midx.c b/midx.c
index ae3e30a062..5aa7e2a6e6 100644
--- a/midx.c
+++ b/midx.c
@@ -14,7 +14,10 @@
 
 int midx_checksum_valid(struct multi_pack_index *m);
 void clear_midx_files_ext(const char *object_dir, const char *ext,
-			  unsigned char *keep_hash);
+			  const char *keep_hash);
+void clear_incremental_midx_files_ext(const char *object_dir, const char *ext,
+				      char **keep_hashes,
+				      uint32_t hashes_nr);
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
@@ -518,6 +521,11 @@ int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m,
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
@@ -719,7 +727,8 @@ int midx_checksum_valid(struct multi_pack_index *m)
 }
 
 struct clear_midx_data {
-	char *keep;
+	char **keep;
+	uint32_t keep_nr;
 	const char *ext;
 };
 
@@ -727,32 +736,63 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
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
 
@@ -770,8 +810,8 @@ void clear_midx_file(struct repository *r)
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
index 85f0345435..2c335f4c4d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -813,9 +813,10 @@ static void report_pack_garbage(struct string_list *list)
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
@@ -824,6 +825,8 @@ void for_each_file_in_pack_dir(const char *objdir,
 
 	strbuf_addstr(&path, objdir);
 	strbuf_addstr(&path, "/pack");
+	if (subdir)
+		strbuf_addf(&path, "/%s", subdir);
 	dir = opendir(path.buf);
 	if (!dir) {
 		if (errno != ENOENT)
@@ -845,6 +848,13 @@ void for_each_file_in_pack_dir(const char *objdir,
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
index 28c8fd3e39..07ba2c0be0 100644
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
index e8a11926e4..e93a29de1b 100644
--- a/t/README
+++ b/t/README
@@ -469,6 +469,10 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
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
index 6e9ee23398..4b0b5a5c9f 100755
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
index dff3b26849..5836187170 100755
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
index 3c20738bce..517617d59d 100755
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
2.45.2.437.gecb9450a0e
