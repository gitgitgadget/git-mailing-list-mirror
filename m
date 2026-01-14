Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E434FF55
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420516; cv=none; b=X981VosUrXgXfXjLkKedcbheYt71ErnMcxgxMke0asqmT5n8bsNlYnWE/gtamZOEenwhDzlPtAyc9m7OJKhd4b8dpQEAM6SuHoHmYwhi56imEYV+K7mtoNF3g08ZlaeBm26tLn16lnZPv0Qch7fmC7DZ2tMdNlNzsfTkQ9VxEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420516; c=relaxed/simple;
	bh=QHKSire3xPwSVp9ZYMzOiJo/qTuGW6wxjFaQLm/2lgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkSBGVx12J9unxPw6JUvL/5+PJSvZ3K7iCfk6Eo6omSEDlatlsz9WBv4wUIzN+gLlWY6vxpa3evYcp9UHUpZs4MFa5julqzrIjgEUx2rqWqZw96z/jC0I1gccAB6rijao1XVbzuPhyvYfScVTmGpDaXG8sqeqwZSn+y5sX4iU5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=N2stQ2il; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="N2stQ2il"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-78fc4425b6bso1417377b3.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420512; x=1769025312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLDPTtmOmbrSrRXhNlzl/ZuO1xQfNyq3opLGG63vefM=;
        b=N2stQ2ilqEgajXOcl9uZj1xJdsX0SW39TKkGavGf1d4frWr/nd9PBLAGrrLys2jP56
         Z0onuDiKrkmGdrzkR4iwBWsDF9fxLeEmbpdg3mrBj/o78B//yLPD2kkW0qXfvXHYksiP
         HE70EBFas9XypQnTLSun5/A2rjtph8Ypc9t2VIEjj6FNtwf4PrYdsmFk5Tjf/JD2qz51
         xrOsgkEp1F15TM3ZPKtLPUSRELisy14rAFD9CmMsNUE/rGKTk5j+JoXY5TEjVNrJ9CBr
         4h3X9YXNyvE1oJQ2EE1ucGF9KP2wcAXsTbDle8XlkaM3EAsGMGXe6aHs8rk18FhYQmsl
         KQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420512; x=1769025312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLDPTtmOmbrSrRXhNlzl/ZuO1xQfNyq3opLGG63vefM=;
        b=Z8lU8d5z/aTCmeAqx77yp7qshLUO/saqBaEZS3W3coOFThK+KZ6mJYjyGTAFP9RbyN
         CEGDBjjq1hDoRkwapq5ZPgT4XyztVNvJT1erPoUOZSjeFYCmWwT+hNeuQCSuhHFmQbpf
         PijHZlHdrYX2y+vjSDrm6g+50bUCOeZGcr70d/TwGfQofHInj+c6kEKozLzJ+jVPshb7
         f/IGSfuMS8S+MPw0ugC94DfH4dxIL9j7siri83bYOqUPiYesSLJkmMCGTnrBJOii81XW
         2o+J4UpXOsh9bzNzV2qxyPsKLFKT9RrVSUvCQznoF4IKs6JpEzMM/cuG+tlIj8es3yTJ
         n2Kw==
X-Gm-Message-State: AOJu0Yxf4mNSV1lx2ngJ1R8rtRpBoVS62NXLXaaXPfoYXaLbV4hpTcP2
	06cJ0i0kZ7oMmdHyqt2Dhmz4uayQHGXf/SuBZSdPPufWnCw1glnDcmeRCc7un+xhaTQ7ADg2WJZ
	9ySIlesSulc4N
X-Gm-Gg: AY/fxX6e6NgD2ry3l4M8SL2WX8JEnDJzLN/ZKlNzVqNlMmxRCGyRHW75JEpv6piFYUF
	Pm9onYxAsbLiaRG5r6zeQJMVqf/e/zAmVsch/doQOZWowLSHYYRCk90toc1dPXTJxwqI+IugKU3
	wVV1zwafqVv7cYGxF7yHvg15hPJqQ1Go+aDWGw6O3aD89RHeGf/VQ5OpzvP6lUFRvV/QmvT04mj
	M7x4Q8O8cDMNX2xMApgfpB59X9o9rAX0uHEdhr9CYdo7hiqPDpeInxm+DSYubaBn4ul1gPHbe/0
	cf1KFTNhdVgVY05hOW3LMV+yU++xnhJ8s4hKfL9DJlbZlRDbSn/2OX5LW7BbwqBs638BRWgZiRC
	pJz24bP3uFjCYrfQ5ZhmaUfsllusw4LaMP+0WwxK+mAaRxT/1c8gL3R7fIwwBToY7Q1A1BJesAk
	8yMFgx4jyvX8O2U1vD/K7X5TBjbM62e4jJJyzcp4GzDp8F7vy1ftV+Hlwup1tNTNJztfWveeZuR
	uHEKNioB5Q7GhECcA==
X-Received: by 2002:a05:690e:419c:b0:646:7b97:ecb7 with SMTP id 956f58d0204a3-64901b1a1ddmr2901040d50.73.1768420511574;
        Wed, 14 Jan 2026 11:55:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa67824esm93315857b3.27.2026.01.14.11.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:55:11 -0800 (PST)
Date: Wed, 14 Jan 2026 14:55:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/18] midx: implement MIDX compaction
Message-ID: <13336e864f4ed3a6954b782f0bcc090d92ac722c.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

When managing a MIDX chain with many layers, it is convenient to combine
a sequence of adjacent layers into a single layer to prevent the chain
from growing too long.

While it is conceptually possible to "compact" a sequence of MIDX layers
together by running "git multi-pack-index write --stdin-packs", there
are a few drawbacks that make this less than desirable:

 - Preserving the MIDX chain is impossible, since there is no way to
   write a MIDX layer that contains objects or packs found in an earlier
   MIDX layer already part of the chain. So callers would have to write
   an entirely new (non-incremental) MIDX containing only the compacted
   layers, discarding all other objects/packs from the MIDX.

 - There is (currently) no way to write a MIDX layer outside of the MIDX
   chain to work around the above, such that the MIDX chain could be
   reassembled substituting the compacted layers with the MIDX that was
   written.

 - The `--stdin-packs` command-line option does not allow us to specify
   the order of packs as they appear in the MIDX. Therefore, even if
   there were workarounds for the previous two challenges, any bitmaps
   belonging to layers which come after the compacted layer(s) would no
   longer be valid.

This commit introduces a way to compact a sequence of adjacent MIDX
layers into a single layer while preserving the MIDX chain, as well as
any bitmap(s) in layers which are newer than the compacted ones.

Implementing MIDX compaction does not require a significant number of
changes to how MIDX layers are written. The main changes are as follows:

 - Instead of calling `fill_packs_from_midx()`, we call a new function
   `fill_packs_from_midx_range()`, which walks backwards along the
   portion of the MIDX chain which we are compacting, and adds packs one
   layer a time.

   In order to preserve the pseudo-pack order, the concatenated pack
   order is preserved, with the exception of preferred packs which are
   always added first.

 - After adding entries from the set of packs in the compaction range,
   `compute_sorted_entries()` must adjust the `pack_int_id`'s for all
   objects added in each fanout layer to match their original
   `pack_int_id`'s (as opposed to the index at which each pack appears
   in `ctx.info`).

 - When writing out the new 'multi-pack-index-chain' file, discard any
   layers in the compaction range, replacing them with the newly written
   layer, instead of keeping them and placing the new layer at the end
   of the chain.

This ends up being sufficient to implement MIDX compaction in such a way
that preserves bitmaps corresponding to more recent layers in the MIDX
chain.

The tests for MIDX compaction are so far fairly spartan, since the main
interesting behavior here is ensuring that the right packs/objects are
selected from each layer, and that the pack order is preserved despite
whether or not they are sorted in lexicographic order in the original
MIDX chain.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc |  13 ++
 builtin/multi-pack-index.c              |  74 +++++++
 midx-write.c                            | 251 ++++++++++++++++++++++--
 midx.h                                  |   5 +
 t/meson.build                           |   1 +
 t/t5335-compact-multi-pack-index.sh     | 175 +++++++++++++++++
 6 files changed, 500 insertions(+), 19 deletions(-)
 create mode 100755 t/t5335-compact-multi-pack-index.sh

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 164cf1f2291..883a0529741 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -12,6 +12,8 @@ SYNOPSIS
 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
 		         [--refs-snapshot=<path>]
+'git multi-pack-index' [<options>] compact [--[no-]incremental]
+		         <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
@@ -83,6 +85,17 @@ marker).
 		necessary.
 --
 
+compact::
+	Write a new MIDX layer containing only objects and packs present
+	in the range `<from>` to `<to>`, where both arguments are
+	checksums of existing layers in the MIDX chain.
++
+--
+	--incremental::
+		Write the result to a MIDX chain instead of writing a
+		stand-alone MIDX.
+--
+
 verify::
 	Verify the contents of the MIDX file.
 
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index c0c6c1760c0..043ee8c478a 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -17,6 +17,10 @@
 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
 	   "  [--refs-snapshot=<path>]")
 
+#define BUILTIN_MIDX_COMPACT_USAGE \
+	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
+	   "  <from> <to>")
+
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
 
@@ -30,6 +34,10 @@ static char const * const builtin_multi_pack_index_write_usage[] = {
 	BUILTIN_MIDX_WRITE_USAGE,
 	NULL
 };
+static char const * const builtin_multi_pack_index_compact_usage[] = {
+	BUILTIN_MIDX_COMPACT_USAGE,
+	NULL
+};
 static char const * const builtin_multi_pack_index_verify_usage[] = {
 	BUILTIN_MIDX_VERIFY_USAGE,
 	NULL
@@ -44,6 +52,7 @@ static char const * const builtin_multi_pack_index_repack_usage[] = {
 };
 static char const * const builtin_multi_pack_index_usage[] = {
 	BUILTIN_MIDX_WRITE_USAGE,
+	BUILTIN_MIDX_COMPACT_USAGE,
 	BUILTIN_MIDX_VERIFY_USAGE,
 	BUILTIN_MIDX_EXPIRE_USAGE,
 	BUILTIN_MIDX_REPACK_USAGE,
@@ -195,6 +204,70 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	return ret;
 }
 
+static int cmd_multi_pack_index_compact(int argc, const char **argv,
+					const char *prefix,
+					struct repository *repo)
+{
+	struct multi_pack_index *m, *cur;
+	struct multi_pack_index *from_midx = NULL;
+	struct multi_pack_index *to_midx = NULL;
+	struct odb_source *source;
+	int ret;
+
+	struct option *options;
+	static struct option builtin_multi_pack_index_compact_options[] = {
+		OPT_BIT(0, "incremental", &opts.flags,
+			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
+		OPT_END(),
+	};
+
+	repo_config(repo, git_multi_pack_index_write_config, NULL);
+
+	options = add_common_options(builtin_multi_pack_index_compact_options);
+
+	trace2_cmd_mode(argv[0]);
+
+	if (isatty(2))
+		opts.flags |= MIDX_PROGRESS;
+	argc = parse_options(argc, argv, prefix,
+			     options, builtin_multi_pack_index_compact_usage,
+			     0);
+
+	if (argc != 2)
+		usage_with_options(builtin_multi_pack_index_compact_usage,
+				   options);
+	source = handle_object_dir_option(the_repository);
+
+	FREE_AND_NULL(options);
+
+	m = get_multi_pack_index(source);
+
+	for (cur = m; cur && !(from_midx && to_midx); cur = cur->base_midx) {
+		const char *midx_csum = midx_get_checksum_hex(cur);
+
+		if (!from_midx && !strcmp(midx_csum, argv[0]))
+			from_midx = cur;
+		if (!to_midx && !strcmp(midx_csum, argv[1]))
+			to_midx = cur;
+	}
+
+	if (!from_midx)
+		die(_("could not find MIDX: %s"), argv[0]);
+	if (!to_midx)
+		die(_("could not find MIDX: %s"), argv[1]);
+	if (from_midx == to_midx)
+		die(_("MIDX compaction endpoints must be unique"));
+
+	for (m = from_midx; m; m = m->base_midx) {
+		if (m == to_midx)
+			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
+	}
+
+	ret = write_midx_file_compact(source, from_midx, to_midx, opts.flags);
+
+	return ret;
+}
+
 static int cmd_multi_pack_index_verify(int argc, const char **argv,
 				       const char *prefix,
 				       struct repository *repo UNUSED)
@@ -295,6 +368,7 @@ int cmd_multi_pack_index(int argc,
 	struct option builtin_multi_pack_index_options[] = {
 		OPT_SUBCOMMAND("repack", &fn, cmd_multi_pack_index_repack),
 		OPT_SUBCOMMAND("write", &fn, cmd_multi_pack_index_write),
+		OPT_SUBCOMMAND("compact", &fn, cmd_multi_pack_index_compact),
 		OPT_SUBCOMMAND("verify", &fn, cmd_multi_pack_index_verify),
 		OPT_SUBCOMMAND("expire", &fn, cmd_multi_pack_index_expire),
 		OPT_END(),
diff --git a/midx-write.c b/midx-write.c
index ca2469213e6..afa077a09cc 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -113,6 +113,10 @@ struct write_midx_context {
 	int incremental;
 	uint32_t num_multi_pack_indexes_before;
 
+	struct multi_pack_index *compact_from;
+	struct multi_pack_index *compact_to;
+	int compact;
+
 	struct string_list *to_include;
 
 	struct repository *repo;
@@ -122,6 +126,8 @@ struct write_midx_context {
 static uint32_t midx_pack_perm(struct write_midx_context *ctx,
 			       uint32_t orig_pack_int_id)
 {
+	if (ctx->compact)
+		orig_pack_int_id -= ctx->compact_from->num_packs_in_base;
 	return ctx->pack_perm[orig_pack_int_id];
 }
 
@@ -352,6 +358,21 @@ static void midx_fanout_add(struct midx_fanout *fanout,
 					    cur_fanout);
 }
 
+static void midx_fanout_add_compact(struct midx_fanout *fanout,
+				    struct write_midx_context *ctx,
+				    uint32_t cur_fanout)
+{
+	struct multi_pack_index *m = ctx->compact_to;
+
+	ASSERT(ctx->compact);
+
+	while (m && m != ctx->compact_from->base_midx) {
+		midx_fanout_add_midx_fanout(fanout, m, cur_fanout,
+					    NO_PREFERRED_PACK);
+		m = m->base_midx;
+	}
+}
+
 /*
  * It is possible to artificially get into a state where there are many
  * duplicate copies of objects. That can create high memory pressure if
@@ -370,6 +391,9 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 	size_t alloc_objects, total_objects = 0;
 	struct midx_fanout fanout = { 0 };
 
+	if (ctx->compact)
+		ASSERT(!start_pack);
+
 	for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++)
 		total_objects = st_add(total_objects,
 				       ctx->info[cur_pack].p->num_objects);
@@ -388,7 +412,10 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
-		midx_fanout_add(&fanout, ctx, start_pack, cur_fanout);
+		if (ctx->compact)
+			midx_fanout_add_compact(&fanout, ctx, cur_fanout);
+		else
+			midx_fanout_add(&fanout, ctx, start_pack, cur_fanout);
 		midx_fanout_sort(&fanout);
 
 		/*
@@ -956,6 +983,72 @@ static int fill_packs_from_midx(struct write_midx_context *ctx)
 	return 0;
 }
 
+static uint32_t compactible_packs_between(const struct multi_pack_index *from,
+					  const struct multi_pack_index *to)
+{
+	uint32_t nr;
+
+	ASSERT(from && to);
+
+	nr = u32_add(to->num_packs, to->num_packs_in_base);
+	if (nr < from->num_packs_in_base)
+		BUG("unexpected number of packs in base during compaction: "
+		    "%"PRIu32" < %"PRIu32, nr, from->num_packs_in_base);
+
+	return nr - from->num_packs_in_base;
+}
+
+static int fill_packs_from_midx_range(struct write_midx_context *ctx,
+				      int bitmap_order)
+{
+	struct multi_pack_index *m = ctx->compact_to;
+	uint32_t packs_nr;
+
+	ASSERT(ctx->compact && !ctx->nr);
+	ASSERT(ctx->compact_from);
+	ASSERT(ctx->compact_to);
+
+	packs_nr = compactible_packs_between(ctx->compact_from,
+					     ctx->compact_to);
+
+	ALLOC_GROW(ctx->info, packs_nr, ctx->alloc);
+
+	while (m != ctx->compact_from->base_midx) {
+		uint32_t pack_int_id, preferred_pack_id;
+		uint32_t i;
+
+		if (bitmap_order) {
+			if (midx_preferred_pack(m, &preferred_pack_id) < 0)
+				die(_("could not determine preferred pack"));
+		} else {
+			preferred_pack_id = m->num_packs_in_base;
+		}
+
+		pack_int_id = m->num_packs_in_base - ctx->compact_from->num_packs_in_base;
+
+		if (fill_pack_from_midx(&ctx->info[pack_int_id++], m,
+					preferred_pack_id) < 0)
+			return -1;
+
+		for (i = m->num_packs_in_base;
+		     i < m->num_packs_in_base + m->num_packs; i++) {
+			if (preferred_pack_id == i)
+				continue;
+
+			if (fill_pack_from_midx(&ctx->info[pack_int_id++], m,
+						i) < 0)
+				return -1;
+		}
+
+		ctx->nr += m->num_packs;
+		m = m->base_midx;
+	}
+
+	ASSERT(ctx->nr == packs_nr);
+
+	return 0;
+}
+
 static struct {
 	const char *non_split;
 	const char *split;
@@ -1075,6 +1168,9 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 	if (ctx->incremental)
 		goto out;
 
+	if (ctx->compact)
+		goto out; /* Compaction always requires an update. */
+
 	/*
 	 * Otherwise, we need to verify that the packs covered by the existing
 	 * MIDX match the packs that we already have. The logic to do so is way
@@ -1120,12 +1216,23 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 	return needed;
 }
 
+static int midx_hashcmp(const struct multi_pack_index *a,
+			const struct multi_pack_index *b,
+			const struct git_hash_algo *algop)
+{
+	return hashcmp(midx_get_checksum_hash(a), midx_get_checksum_hash(b),
+		       algop);
+}
+
 struct write_midx_opts {
 	struct odb_source *source; /* non-optional */
 
 	struct string_list *packs_to_include;
 	struct string_list *packs_to_drop;
 
+	struct multi_pack_index *compact_from;
+	struct multi_pack_index *compact_to;
+
 	const char *preferred_pack_name;
 	const char *refs_snapshot;
 	unsigned flags;
@@ -1150,6 +1257,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	int dropped_packs = 0;
 	int result = -1;
 	const char **keep_hashes = NULL;
+	size_t keep_hashes_nr = 0;
 	struct chunkfile *cf;
 
 	trace2_region_enter("midx", "write_midx_internal", r);
@@ -1162,6 +1270,19 @@ static int write_midx_internal(struct write_midx_opts *opts)
 		die(_("unknown MIDX version: %d"), ctx.version);
 
 	ctx.incremental = !!(opts->flags & MIDX_WRITE_INCREMENTAL);
+	ctx.compact = !!(opts->flags & MIDX_WRITE_COMPACT);
+
+	if (ctx.compact) {
+		if (ctx.version != MIDX_VERSION_V2)
+			die(_("cannot perform MIDX compaction with v1 format"));
+		if (!opts->compact_from)
+			BUG("expected non-NULL 'from' MIDX during compaction");
+		if (!opts->compact_to)
+			BUG("expected non-NULL 'to' MIDX during compaction");
+
+		ctx.compact_from = opts->compact_from;
+		ctx.compact_to = opts->compact_to;
+	}
 
 	if (ctx.incremental)
 		strbuf_addf(&midx_name,
@@ -1189,11 +1310,18 @@ static int write_midx_internal(struct write_midx_opts *opts)
 			 */
 			if (ctx.incremental)
 				ctx.base_midx = m;
-			else if (!opts->packs_to_include)
+			if (!opts->packs_to_include)
 				ctx.m = m;
 		}
 	}
 
+	/*
+	 * If compacting MIDX layer(s) in the range [from, to], then the
+	 * compacted MIDX will share the same base MIDX as 'from'.
+	 */
+	if (ctx.compact)
+		ctx.base_midx = ctx.compact_from->base_midx;
+
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs + ctx.m->num_packs_in_base : 16;
 	ctx.info = NULL;
@@ -1210,7 +1338,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 			ctx.num_multi_pack_indexes_before++;
 			m = m->base_midx;
 		}
-	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
+	} else if (ctx.m && !ctx.compact && fill_packs_from_midx(&ctx)) {
 		goto cleanup;
 	}
 
@@ -1223,9 +1351,18 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	else
 		ctx.progress = NULL;
 
-	ctx.to_include = opts->packs_to_include;
+	if (ctx.compact) {
+		int bitmap_order = 0;
+		if (opts->preferred_pack_name)
+			bitmap_order |= 1;
+		else if (opts->flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
+			bitmap_order |= 1;
 
-	for_each_file_in_pack_dir(opts->source->path, add_pack_to_midx, &ctx);
+		fill_packs_from_midx_range(&ctx, bitmap_order);
+	} else {
+		ctx.to_include = opts->packs_to_include;
+		for_each_file_in_pack_dir(opts->source->path, add_pack_to_midx, &ctx);
+	}
 	stop_progress(&ctx.progress);
 
 	if (!opts->packs_to_drop) {
@@ -1354,12 +1491,19 @@ static int write_midx_internal(struct write_midx_opts *opts)
 			ctx.large_offsets_needed = 1;
 	}
 
-	QSORT(ctx.info, ctx.nr, pack_info_compare);
+	if (ctx.compact) {
+		if (ctx.version != MIDX_VERSION_V2)
+			BUG("performing MIDX compaction with v1 MIDX");
+	} else {
+		QSORT(ctx.info, ctx.nr, pack_info_compare);
+	}
 
 	if (opts->packs_to_drop && opts->packs_to_drop->nr) {
 		size_t drop_index = 0;
 		int missing_drops = 0;
 
+		ASSERT(!ctx.compact);
+
 		for (size_t i = 0;
 		     i < ctx.nr && drop_index < opts->packs_to_drop->nr; i++) {
 			int cmp = strcmp(ctx.info[i].pack_name,
@@ -1391,12 +1535,20 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	 */
 	ALLOC_ARRAY(ctx.pack_perm, ctx.nr);
 	for (size_t i = 0; i < ctx.nr; i++) {
+		uint32_t from = ctx.info[i].orig_pack_int_id;
+		uint32_t to;
+
 		if (ctx.info[i].expired) {
+			to = PACK_EXPIRED;
 			dropped_packs++;
-			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = PACK_EXPIRED;
 		} else {
-			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = i - dropped_packs;
+			to = i - dropped_packs;
 		}
+
+		if (ctx.compact)
+			from -= ctx.compact_from->num_packs_in_base;
+
+		ctx.pack_perm[from] = to;
 	}
 
 	for (size_t i = 0; i < ctx.nr; i++) {
@@ -1542,7 +1694,24 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
 		die(_("too many multi-pack-indexes"));
 
-	CALLOC_ARRAY(keep_hashes, ctx.num_multi_pack_indexes_before + 1);
+	if (ctx.compact) {
+		struct multi_pack_index *m;
+
+		/*
+		 * Keep all MIDX layers excluding those in the range [from, to].
+		 */
+		for (m = ctx.base_midx; m; m = m->base_midx)
+			keep_hashes_nr++;
+		for (m = ctx.m;
+		     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
+		     m = m->base_midx)
+			keep_hashes_nr++;
+
+		keep_hashes_nr++; /* include the compacted layer */
+	} else {
+		keep_hashes_nr = ctx.num_multi_pack_indexes_before + 1;
+	}
+	CALLOC_ARRAY(keep_hashes, keep_hashes_nr);
 
 	if (ctx.incremental) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
@@ -1567,17 +1736,47 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 		strbuf_release(&final_midx_name);
 
-		keep_hashes[ctx.num_multi_pack_indexes_before] =
-			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
+		if (ctx.compact) {
+			struct multi_pack_index *m;
+			uint32_t num_layers_before_from = 0;
+			uint32_t i;
 
-		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
-			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
+			for (m = ctx.base_midx; m; m = m->base_midx)
+				num_layers_before_from++;
 
-			keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
-			m = m->base_midx;
+			m = ctx.base_midx;
+			for (i = 0; i < num_layers_before_from; i++) {
+				uint32_t j = num_layers_before_from - i - 1;
+
+				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
+				m = m->base_midx;
+			}
+
+			keep_hashes[i] = xstrdup(hash_to_hex_algop(midx_hash,
+								   r->hash_algo));
+
+			i = 0;
+			for (m = ctx.m;
+			     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
+			     m = m->base_midx) {
+				keep_hashes[keep_hashes_nr - i - 1] =
+					xstrdup(midx_get_checksum_hex(m));
+				i++;
+			}
+		} else {
+			keep_hashes[ctx.num_multi_pack_indexes_before] =
+				xstrdup(hash_to_hex_algop(midx_hash,
+							  r->hash_algo));
+
+			for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
+				uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
+
+				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
+				m = m->base_midx;
+			}
 		}
 
-		for (uint32_t i = 0; i <= ctx.num_multi_pack_indexes_before; i++)
+		for (uint32_t i = 0; i < keep_hashes_nr; i++)
 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
 	} else {
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
@@ -1590,8 +1789,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(opts->source, keep_hashes,
-			 ctx.num_multi_pack_indexes_before + 1,
+	clear_midx_files(opts->source, keep_hashes, keep_hashes_nr,
 			 ctx.incremental);
 	result = 0;
 
@@ -1609,7 +1807,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
 	if (keep_hashes) {
-		for (uint32_t i = 0; i <= ctx.num_multi_pack_indexes_before; i++)
+		for (uint32_t i = 0; i < keep_hashes_nr; i++)
 			free((char *)keep_hashes[i]);
 		free(keep_hashes);
 	}
@@ -1651,6 +1849,21 @@ int write_midx_file_only(struct odb_source *source,
 	return write_midx_internal(&opts);
 }
 
+int write_midx_file_compact(struct odb_source *source,
+			    struct multi_pack_index *from,
+			    struct multi_pack_index *to,
+			    unsigned flags)
+{
+	struct write_midx_opts opts = {
+		.source = source,
+		.compact_from = from,
+		.compact_to = to,
+		.flags = flags | MIDX_WRITE_COMPACT,
+	};
+
+	return write_midx_internal(&opts);
+}
+
 int expire_midx_packs(struct odb_source *source, unsigned flags)
 {
 	uint32_t i, *count, result = 0;
diff --git a/midx.h b/midx.h
index aa99a6cb215..08f3728e520 100644
--- a/midx.h
+++ b/midx.h
@@ -82,6 +82,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
 #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
 #define MIDX_WRITE_INCREMENTAL (1 << 5)
+#define MIDX_WRITE_COMPACT (1 << 6)
 
 #define MIDX_EXT_REV "rev"
 #define MIDX_EXT_BITMAP "bitmap"
@@ -131,6 +132,10 @@ int write_midx_file_only(struct odb_source *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
 			 const char *refs_snapshot, unsigned flags);
+int write_midx_file_compact(struct odb_source *source,
+			    struct multi_pack_index *from,
+			    struct multi_pack_index *to,
+			    unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct odb_source *source, unsigned flags);
 int expire_midx_packs(struct odb_source *source, unsigned flags);
diff --git a/t/meson.build b/t/meson.build
index 459c52a4897..5393322a8d2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -614,6 +614,7 @@ integration_tests = [
   't5332-multi-pack-reuse.sh',
   't5333-pseudo-merge-bitmaps.sh',
   't5334-incremental-multi-pack-index.sh',
+  't5335-compact-multi-pack-index.sh',
   't5351-unpack-large-objects.sh',
   't5400-send-pack.sh',
   't5401-update-hooks.sh',
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
new file mode 100755
index 00000000000..797ae05c3bd
--- /dev/null
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -0,0 +1,175 @@
+#!/bin/sh
+
+test_description='multi-pack-index compaction'
+
+. ./test-lib.sh
+
+GIT_TEST_MULTI_PACK_INDEX=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
+
+objdir=.git/objects
+packdir=$objdir/pack
+midxdir=$packdir/multi-pack-index.d
+midx_chain=$midxdir/multi-pack-index-chain
+
+nth_line() {
+	local n="$1"
+	shift
+	awk "NR==$n" "$@"
+}
+
+write_packs () {
+	for c in "$@"
+	do
+		test_commit "$c" &&
+
+		git pack-objects --all --unpacked $packdir/pack-$c &&
+		git prune-packed &&
+
+		git multi-pack-index write --incremental --bitmap || return 1
+	done
+}
+
+test_midx_layer_packs () {
+	local checksum="$1" &&
+	shift &&
+
+	test-tool read-midx $objdir "$checksum" >out &&
+
+	printf "%s\n" "$@" >expect &&
+	# NOTE: do *not* pipe through sort here, we want to ensure the
+	# order of packs is preserved during compaction.
+	grep "^pack-" out | cut -d"-" -f2 >actual &&
+
+	test_cmp expect actual
+}
+
+test_midx_layer_object_uniqueness () {
+	: >objs.all
+	while read layer
+	do
+		test-tool read-midx --show-objects $objdir "$layer" >out &&
+		grep "\.pack$" out | cut -d" " -f1 | sort >objs.layer &&
+		test_stdout_line_count = 0 comm -12 objs.all objs.layer &&
+		cat objs.all objs.layer | sort >objs.tmp &&
+		mv objs.tmp objs.all || return 1
+	done <$midx_chain
+}
+
+test_expect_success 'MIDX compaction with lex-ordered pack names' '
+	git init midx-compact-lex-order &&
+	(
+		cd midx-compact-lex-order &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C D E &&
+		test_line_count = 5 $midx_chain &&
+
+		git multi-pack-index compact --incremental \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 4 "$midx_chain")" &&
+		test_line_count = 3 $midx_chain &&
+
+		test_midx_layer_packs "$(nth_line 1 "$midx_chain")" A &&
+		test_midx_layer_packs "$(nth_line 2 "$midx_chain")" B C D &&
+		test_midx_layer_packs "$(nth_line 3 "$midx_chain")" E &&
+
+		test_midx_layer_object_uniqueness
+	)
+'
+
+test_expect_success 'MIDX compaction with non-lex-ordered pack names' '
+	git init midx-compact-non-lex-order &&
+	(
+		cd midx-compact-non-lex-order &&
+
+		git config maintenance.auto false &&
+
+		write_packs D C A B E &&
+		test_line_count = 5 $midx_chain &&
+
+		git multi-pack-index compact --incremental \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 4 "$midx_chain")" &&
+		test_line_count = 3 $midx_chain &&
+
+		test_midx_layer_packs "$(nth_line 1 "$midx_chain")" D &&
+		test_midx_layer_packs "$(nth_line 2 "$midx_chain")" C A B &&
+		test_midx_layer_packs "$(nth_line 3 "$midx_chain")" E &&
+
+		test_midx_layer_object_uniqueness
+	)
+'
+
+test_expect_success 'setup for bogus MIDX compaction scenarios' '
+	git init midx-compact-bogus &&
+	(
+		cd midx-compact-bogus &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C
+	)
+'
+
+test_expect_success 'MIDX compaction with missing endpoints' '
+	(
+		cd midx-compact-bogus &&
+
+		test_must_fail git multi-pack-index compact --incremental \
+			"<missing>" "<missing>" 2>err &&
+		test_grep "could not find MIDX: <missing>" err &&
+
+		test_must_fail git multi-pack-index compact --incremental \
+			"<missing>" "$(nth_line 2 "$midx_chain")" 2>err &&
+		test_grep "could not find MIDX: <missing>" err &&
+
+		test_must_fail git multi-pack-index compact --incremental \
+			"$(nth_line 2 "$midx_chain")" "<missing>" 2>err &&
+		test_grep "could not find MIDX: <missing>" err
+	)
+'
+
+test_expect_success 'MIDX compaction with reversed endpoints' '
+	(
+		cd midx-compact-bogus &&
+
+		from="$(nth_line 3 "$midx_chain")" &&
+		to="$(nth_line 1 "$midx_chain")" &&
+
+		test_must_fail git multi-pack-index compact --incremental \
+			"$from" "$to" 2>err &&
+
+		test_grep "MIDX $from must be an ancestor of $to" err
+	)
+'
+
+test_expect_success 'MIDX compaction with identical endpoints' '
+	(
+		cd midx-compact-bogus &&
+
+		from="$(nth_line 3 "$midx_chain")" &&
+		to="$(nth_line 3 "$midx_chain")" &&
+
+		test_must_fail git multi-pack-index compact --incremental \
+			"$from" "$to" 2>err &&
+
+		test_grep "MIDX compaction endpoints must be unique" err
+	)
+'
+
+test_expect_success 'MIDX compaction with midx.version=1' '
+	(
+		cd midx-compact-bogus &&
+
+		test_must_fail git -c midx.version=1 multi-pack-index compact \
+			"$(nth_line 1 "$midx_chain")" \
+			"$(nth_line 2 "$midx_chain")" 2>err &&
+
+		test_grep "fatal: cannot perform MIDX compaction with v1 format" err
+	)
+'
+
+test_done
-- 
2.52.0.457.gb599f1ad4b0

