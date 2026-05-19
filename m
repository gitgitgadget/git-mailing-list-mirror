Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902E3EA952
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206279; cv=none; b=Fq3NYQq1Y5q/J8YTIljvpCc2rZ+y7tkg1DWN4WSKJ5oaSS/Rs86fcFrrNrCvTEWINL4eSBZEaOhlzoWtIgyjj6rhUk1vZuiPr3Cp9sULcjqxYfW2E7U3jhtIZB9sgPuKvDrpH3enSQ8/lAbSF+kXsSzEh0v16Pdyr6o6LrA6hHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206279; c=relaxed/simple;
	bh=X29elcE9mU0NL91NzwnlxCHqUcLEvCRBYf36dgMRdAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udmom4z9vz9TTglUzT21FqeqP9Wo82ZIU4GNG1SHkfW2/Xb0x8nBFlHtTsPIaIWyuecQNzlp9xD/KiGjMNlTLEx/3/6iTY/+konmFE5CZj2X/vHgSYXvdqrBayf1QrMV+MxzHnSXIdwgipS5ZYfgzp9GmmgyJkzmGWp3UCMqSqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Y8PATanC; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Y8PATanC"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7bd5e373d07so35039977b3.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206276; x=1779811076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4R+D37AIpaxCYIbIS8jRP9tx+aZZsHezSZGlJWb5lk=;
        b=Y8PATanChQVqPVygqOlxyaFaxa2YMYe+hvbnAhTG5UErZrE1beuzcXF7sIs9Fv068V
         fu/51UJE/FEMresY69XJTM1cFY8NWOL/B/kXIS4bvCC4ApjLPusOtQ3RyKyzryLV6sc3
         QOW4YIFny0D31RMSzy7AubQtEAWh85wC2kBq30c7JAwWjQtsNaoc1QvADqN+s+hOyEYl
         5eDbOhWDdP/a5G+4gWVNNeU4otceSrBRwmbvQyPSaTKSGCKv25GjRe+UfDXatA1Oyg+x
         trqCCz434cD1Q/9vjioiyGP59Z5de4052CGWiQutbrj0yseLio1tfLnTh+4q6evx0uVD
         RGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206276; x=1779811076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4R+D37AIpaxCYIbIS8jRP9tx+aZZsHezSZGlJWb5lk=;
        b=E0jf5jXcXupEUo6r0uisHrN6oHEgoqIZXD7nUbnx0PiK0ZuW78R7FL5n6q0v2/pDVt
         kcW87TNQnUQh80ycVQgR+E4D9AlqfONWDYbIEJU/L0HSs0sg4oRJzoSF+8N2UQYRnAxT
         VDePGdXnjdgNICgld7oYagpOeNh5F0NAj8cIzJ6iK+60djwxW+jj/Y2msRA+PbPJwyrU
         ljPxZ/JPhaN+328R0j8LTWgA64J4zTIVvbF/ok6KqFsS7do5LRFXmNi5ktvq+6uGC/j2
         TB/12PeMc45ZrjXZzFSJhylq2mJcmamwFOucwer3dndjwJIvJ5bD2oRTdS17zc9MB26A
         +Lxw==
X-Gm-Message-State: AOJu0YxcX0YsTuH9K401PVt6Jfp5OqYUMl4cxIqpYvrpCso2BTsMwyyi
	+Sc5kfnG55dpGF4j6AJq+KiY22+VelJwGQvoaXwLr3COo6+njyQOit36FgVOTtUhxBvp1cSd6br
	u30A/9zOTZAYk
X-Gm-Gg: Acq92OH1Gh/qcHtx0b8MQpSw8SXPZFyLQB4r1Qu5HsJ1pmjxBxF++WfKEuoSK0u9myS
	slLP+oIFAXN+Z5W9W2igSXFIKWJ0GKd9coYmTpRxvReRNyR+XbsncCQSQ+/yPw+qw4BRH9pFomN
	dPjNjFl1lbf1VzOp2zlh/tdi7wz80YDuM7wnfDQJgnJ19Nw8ayVKHwSI1f/BmMg/cTerezIBwa2
	Q4OY6EXLdo5MpgNUc88GCmDw6cRvsas0B9I8hNHG0v3E7EGnbWiu8OCh/hL1rTVTKA/TZFXt7xv
	n0FbFpWs/xu6hLZp4hWntTIgP9NLQFxgaptvh5O6Nn2U5dDt5pTb9BiIy9TdeP72ZdcWCwC7dAc
	ZFlgFa1KqRjzNoH0OgXk2vAaDEBSp5GLZt3KJkpAZwiSxPaD1xr+iYU1mV35U1SYEDqOjQ9EC9I
	3+FEeatTX6m7dlkLslPr2hMo8B6nUTVi+EDCWZF5oZRazhm8g6rtPmO8tOVQraE/TLKkP3nfRHj
	pF3sNlZHzeiwmJo91yzDTPslVeAlEXyava2XZUMz07BpAafc7S4P1WapyXOAq/gJ5jvncXfkQHy
	pDIFLkLceVpWiJlm
X-Received: by 2002:a05:690c:10d:b0:7bd:5c9e:2397 with SMTP id 00721157ae682-7c95b33f013mr224996737b3.30.1779206276167;
        Tue, 19 May 2026 08:57:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0dafdsm39187777b3.30.2026.05.19.08.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:57:55 -0700 (PDT)
Date: Tue, 19 May 2026 11:57:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 06/16] midx: support custom `--base` for incremental MIDX
 writes
Message-ID: <1bbb387d6b6204045d97882fd8775dbff12dedbb.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

Both `compact` and `write --incremental` fix the base of the resulting
MIDX layer: `compact` always places the compacted result on top of
"from's" immediate parent in the chain, and `write --incremental` always
appends a new layer to the existing tip. In both cases the base is not
configurable.

Future callers need additional flexibility. For instance, the incremental
MIDX-based repacking code may wish to write a layer based on some
intermediate ancestor rather than the current tip, or produce a root
layer when replacing the bottommost entries in the chain.

Introduce a new `--base` option for both subcommands to specify the
checksum of the MIDX layer to use as the base. The given checksum must
refer to a valid layer in the MIDX chain that is an ancestor of the
topmost layer being written or compacted.

The special value "none" is accepted to produce a root layer with no
parent. This will be needed when the incremental repacking machinery
determines that the bottommost layers of the chain should be replaced.

If no `--base` is given, behavior is unchanged: `compact` uses "from's"
immediate parent in the chain, and `write` appends to the existing tip.

For the `write` subcommand, `--base` requires `--no-write-chain-file`. A plain
`write --incremental` appends a new layer to the live chain tip with no
mechanism to atomically replace it; overriding the base would produce a
layer that does not extend the tip, breaking chain invariants. With
`--no-write-chain-file` the chain is left unmodified and the caller is
responsible for assembling a valid chain.

For `compact`, no such restriction applies. The compaction operation
atomically replaces the compacted range in the chain file, so writing
the result on top of any valid ancestor preserves chain invariants.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 17 +++++-
 builtin/multi-pack-index.c              | 24 ++++++--
 midx-write.c                            | 34 ++++++++++-
 midx.h                                  |  5 +-
 t/t5334-incremental-multi-pack-index.sh | 30 ++++++++++
 t/t5335-compact-multi-pack-index.sh     | 77 +++++++++++++++++++++++++
 6 files changed, 178 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index c26196815e2..c6d23aeeb9a 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -12,8 +12,10 @@ SYNOPSIS
 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
 		         [--refs-snapshot=<path>] [--[no-]write-chain-file]
+			 [--base=<checksum>]
 'git multi-pack-index' [<options>] compact [--[no-]incremental]
-		         [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>
+		         [--[no-]bitmap] [--base=<checksum>] [--[no-]write-chain-file]
+			 <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
@@ -90,6 +92,13 @@ marker).
 		The checksum of the new layer is printed to standard
 		output, allowing the caller to assemble and write the
 		chain itself. Requires `--incremental`.
+
+	--base=<checksum>::
+		Specify the checksum of an existing MIDX layer to use
+		as the base when writing a new incremental layer.
+		The special value `none` indicates that the new layer
+		should have no base (i.e., it becomes a root layer).
+		Requires `--no-write-chain-file`.
 --
 
 compact::
@@ -110,6 +119,12 @@ compact::
 		MIDX layer but do not update the multi-pack-index-chain
 		file. The checksum of the new layer is printed to
 		standard output. Requires `--incremental`.
+
+	--base=<checksum>::
+		Specify the checksum of an existing MIDX layer to use
+		as the base for the compacted result, instead of using
+		the immediate parent of `<from>`. The special value
+		`none` indicates that the result should have no base.
 --
 +
 Note that the compact command requires writing a version-2 midx that
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index f861b4b8394..00ffb36394d 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -16,11 +16,13 @@
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
-	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]")
+	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]\n" \
+	   "  [--base=<checksum>]")
 
 #define BUILTIN_MIDX_COMPACT_USAGE \
 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
-	   "  [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>")
+	   "  [--[no-]bitmap] [--base=<checksum>] [--[no-]write-chain-file]\n" \
+	   "  <from> <to>")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -63,6 +65,7 @@ static char const * const builtin_multi_pack_index_usage[] = {
 static struct opts_multi_pack_index {
 	char *object_dir;
 	const char *preferred_pack;
+	const char *incremental_base;
 	char *refs_snapshot;
 	unsigned long batch_size;
 	unsigned flags;
@@ -151,6 +154,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			   N_("pack for reuse when computing a multi-pack bitmap")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
+		OPT_STRING(0, "base", &opts.incremental_base, N_("checksum"),
+			   N_("base MIDX for incremental writes")),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
 		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
@@ -190,6 +195,13 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 				   options);
 	}
 
+	if (opts.incremental_base &&
+	    !(opts.flags & MIDX_WRITE_NO_CHAIN)) {
+		error(_("cannot use --base without --no-write-chain-file"));
+		usage_with_options(builtin_multi_pack_index_write_usage,
+				   options);
+	}
+
 	source = handle_object_dir_option(repo);
 
 	FREE_AND_NULL(options);
@@ -201,7 +213,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		ret = write_midx_file_only(source, &packs,
 					   opts.preferred_pack,
-					   opts.refs_snapshot, opts.flags);
+					   opts.refs_snapshot,
+					   opts.incremental_base, opts.flags);
 
 		string_list_clear(&packs, 0);
 		free(opts.refs_snapshot);
@@ -229,6 +242,8 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 
 	struct option *options;
 	static struct option builtin_multi_pack_index_compact_options[] = {
+		OPT_STRING(0, "base", &opts.incremental_base, N_("checksum"),
+			   N_("base MIDX for incremental writes")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
@@ -290,7 +305,8 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
 	}
 
-	ret = write_midx_file_compact(source, from_midx, to_midx, opts.flags);
+	ret = write_midx_file_compact(source, from_midx, to_midx,
+				      opts.incremental_base, opts.flags);
 
 	return ret;
 }
diff --git a/midx-write.c b/midx-write.c
index 38c898e5ff5..561e9eedc0e 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1247,6 +1247,7 @@ struct write_midx_opts {
 
 	const char *preferred_pack_name;
 	const char *refs_snapshot;
+	const char *incremental_base;
 	unsigned flags;
 };
 
@@ -1330,11 +1331,32 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 	/*
 	 * If compacting MIDX layer(s) in the range [from, to], then the
-	 * compacted MIDX will share the same base MIDX as 'from'.
+	 * compacted MIDX will share the same base MIDX as 'from',
+	 * unless a custom --base is specified (see below).
 	 */
 	if (ctx.compact)
 		ctx.base_midx = ctx.compact_from->base_midx;
 
+	if (opts->incremental_base) {
+		if (!strcmp(opts->incremental_base, "none")) {
+			ctx.base_midx = NULL;
+		} else {
+			while (ctx.base_midx) {
+				const char *cmp = midx_get_checksum_hex(ctx.base_midx);
+				if (!strcmp(opts->incremental_base, cmp))
+					break;
+
+				ctx.base_midx = ctx.base_midx->base_midx;
+			}
+
+			if (!ctx.base_midx) {
+				error(_("could not find base MIDX '%s'"),
+				      opts->incremental_base);
+				goto cleanup;
+			}
+		}
+	}
+
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs + ctx.m->num_packs_in_base : 16;
 	ctx.info = NULL;
@@ -1827,7 +1849,8 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 int write_midx_file(struct odb_source *source,
 		    const char *preferred_pack_name,
-		    const char *refs_snapshot, unsigned flags)
+		    const char *refs_snapshot,
+		    unsigned flags)
 {
 	struct write_midx_opts opts = {
 		.source = source,
@@ -1842,13 +1865,16 @@ int write_midx_file(struct odb_source *source,
 int write_midx_file_only(struct odb_source *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot, unsigned flags)
+			 const char *refs_snapshot,
+			 const char *incremental_base,
+			 unsigned flags)
 {
 	struct write_midx_opts opts = {
 		.source = source,
 		.packs_to_include = packs_to_include,
 		.preferred_pack_name = preferred_pack_name,
 		.refs_snapshot = refs_snapshot,
+		.incremental_base = incremental_base,
 		.flags = flags,
 	};
 
@@ -1858,12 +1884,14 @@ int write_midx_file_only(struct odb_source *source,
 int write_midx_file_compact(struct odb_source *source,
 			    struct multi_pack_index *from,
 			    struct multi_pack_index *to,
+			    const char *incremental_base,
 			    unsigned flags)
 {
 	struct write_midx_opts opts = {
 		.source = source,
 		.compact_from = from,
 		.compact_to = to,
+		.incremental_base = incremental_base,
 		.flags = flags | MIDX_WRITE_COMPACT,
 	};
 
diff --git a/midx.h b/midx.h
index 5b193882dcf..77dd66de02b 100644
--- a/midx.h
+++ b/midx.h
@@ -132,10 +132,13 @@ int write_midx_file(struct odb_source *source,
 int write_midx_file_only(struct odb_source *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot, unsigned flags);
+			 const char *refs_snapshot,
+			 const char *incremental_base,
+			 unsigned flags);
 int write_midx_file_compact(struct odb_source *source,
 			    struct multi_pack_index *from,
 			    struct multi_pack_index *to,
+			    const char *incremental_base,
 			    unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct odb_source *source, unsigned flags);
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 66d6894761b..68a103d13d2 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -113,6 +113,36 @@ test_expect_success 'write non-incremental MIDX layer with --no-write-chain-file
 	test_grep "cannot use --no-write-chain-file without --incremental" err
 '
 
+test_expect_success 'write MIDX layer with --base without --no-write-chain-file' '
+	test_must_fail git multi-pack-index write --bitmap --incremental \
+		--base=none 2>err &&
+	test_grep "cannot use --base without --no-write-chain-file" err
+'
+
+test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file' '
+	test_commit base-none &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--no-write-chain-file --base=none)" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
+test_expect_success 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
+	test_commit base-hash &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--no-write-chain-file --base="$(nth_line 1 "$midx_chain")")" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
 for reuse in false single multi
 do
 	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 1a65d48b62b..ec1dafe89fc 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -304,6 +304,7 @@ test_expect_success 'MIDX compaction with --no-write-chain-file' '
 
 		layer="$(git multi-pack-index compact --incremental \
 			--no-write-chain-file \
+			--base="$(nth_line 1 "$midx_chain")" \
 			"$(nth_line 2 "$midx_chain")" \
 			"$(nth_line 3 "$midx_chain")")" &&
 
@@ -326,4 +327,80 @@ test_expect_success 'MIDX compaction with --no-write-chain-file' '
 	)
 '
 
+test_expect_success 'MIDX compaction with --base' '
+	git init midx-compact-with--base &&
+	(
+		cd midx-compact-with--base &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C D &&
+
+		test_line_count = 4 "$midx_chain" &&
+
+		cp "$midx_chain" "$midx_chain.bak" &&
+
+		git multi-pack-index compact --incremental \
+			--base="$(nth_line 1 "$midx_chain")" \
+			"$(nth_line 3 "$midx_chain")" \
+			"$(nth_line 4 "$midx_chain")" &&
+		test_line_count = 2 $midx_chain &&
+
+		nth_line 1 "$midx_chain.bak" >expect &&
+		nth_line 1 "$midx_chain" >actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'MIDX compaction with --base=none' '
+	git init midx-compact-base-none &&
+	(
+		cd midx-compact-base-none &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C D &&
+
+		test_line_count = 4 $midx_chain &&
+
+		cp "$midx_chain" "$midx_chain".bak &&
+
+		# Compact the two bottommost layers (A and B) into a new
+		# root layer with no parent.
+		git multi-pack-index compact --incremental \
+			--base=none \
+			"$(nth_line 1 "$midx_chain")" \
+			"$(nth_line 2 "$midx_chain")" &&
+
+		test_line_count = 3 $midx_chain &&
+
+		# The upper layers (C and D) should be preserved
+		# unchanged.
+		nth_line 3 "$midx_chain.bak" >expect &&
+		nth_line 4 "$midx_chain.bak" >>expect &&
+		nth_line 2 "$midx_chain" >actual &&
+		nth_line 3 "$midx_chain" >>actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'MIDX compaction with bogus --base checksum' '
+	git init midx-compact-bogus-base &&
+	(
+		cd midx-compact-bogus-base &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C &&
+
+		test_must_fail git multi-pack-index compact --incremental \
+			--base=deadbeef \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 3 "$midx_chain")" 2>err &&
+		test_grep "could not find base MIDX" err
+	)
+'
+
 test_done
-- 
2.54.0.175.g8bd0ec98dc3

