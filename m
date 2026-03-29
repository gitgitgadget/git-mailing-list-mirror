Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279362F6931
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820469; cv=none; b=lmb5jAPjerSExuER0U4ClKBm5yOUJhNNO+/Ih9oFtzN12JGy6FEpq6GXeuksXPTPLgRN9llRAGiusLNHjqr+KSLsjVgPbtyQU2+QuQcsshrHxhDbnEQbFngUJfI/dBfzu2fn0O+eWISm5V18FubWpigwYWz7KWB7wt8GDfINjCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820469; c=relaxed/simple;
	bh=+vTvAZ52eWw1ZF+gZ0bOJQJlUHYQRpwqlDy/ZrfG6dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNh7M7DUcsd+dqH1AIUq8hBvGW7vXYwPIfxM37/2X6aLYq2TA+gOGYqpzep1Vi73bksdkmxlTZyB345dSX5g6+bSyk99+11gLUnRtvdc7SmZWDkCrQHympagIRFb55wDVk53ZokAiPpuffeOeta0o0xfuKz0FqZ2hKaFdgKBmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ftDjbR+4; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ftDjbR+4"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-6500040f128so2823139d50.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820467; x=1775425267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGdcNaVs0kiE9TaGuY8YZ2hNiUyMW5zGK53PetilbcY=;
        b=ftDjbR+4Prf+jxhyvk7tfV0bklFH2k6hfJZ4ng8gOv5djRIGFW8kWYAThcO7Ve6/q6
         1kHTrP0w1V85qxbPwlDxLsnGPilcx+FbDWvRV2PoGWcaxukoBpsoHBQ7dBAL4boQZs6h
         aXqRo2xQtzqCv+HA6WZvOkAz2RfoqF+y0vG/yfoGd2j4iGzNZddx40EQdKElxiHcgCYf
         8NhBoM1pv09BzkoaYuJmwGjMFIPMEZNwlI5M+Bf0cG7AQ0VyFUb5dSinB87bAOssbycZ
         SB6vE3Vh5EEjVDFp9z5na2FlQk83hyQoHURb+QaAOMkkRVQ5Il3NfRsK/eRtgmVgz9ml
         asIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820467; x=1775425267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGdcNaVs0kiE9TaGuY8YZ2hNiUyMW5zGK53PetilbcY=;
        b=T4bUw34g/DwVrfdHkkzVRsqVWnmsfPe4acZd2kHVWHXU8+ECQH3ndanukLmca00lvi
         SLdpADUy5tuQoixiLPG8QFpIJD5CVAhxuRh9wVdT+kGIw9WoSkIWWXZ1vTyVQkwRtcM/
         vfdOLCd2OReRRXhHDfOW26XH7ySAmr7vzsLm2niCrrjqh8ybKpK2KlBnq8a+4u1CkMtU
         gQZbHNlGUuzxHOzKcdsV4vtR64/tYvYvpWeJ93NungQ1horTxfJw7qoghp3RDzu5djVV
         HvM4QF2Fu9gUE5ZhGa4nFL3x9b584bn8Rq8eOhpY6vNcSwUGK4WqpfNdemdutmxmnTPN
         R5rA==
X-Gm-Message-State: AOJu0YyzLoMFAz6xLQE+Lorj3ivtxB0xmoCuDy+MYbCw/Vr0djsYrVHg
	lV8wT/mZE7qC2dlgG5NgJ9k7OSUAQQOSfuEKUEVTf5jSz4Qt22NIq5KO6ibW5kxIR1wGUdfQedV
	xPrLYYWQoepol
X-Gm-Gg: ATEYQzzqYdHpDoATWxw9K0geXPp3D/Tmj4NrQmgA+4Y+Hp39dfti9Gw3WHO2qK/C6IJ
	0qKsq0krrZ1PNclLSj6jmttdceSObqKNITQtus5kNFsoXNmlJEjY81KFXAbKweqj9dlhZCdmV9u
	QtgpFedINWNOHssm4+PwNPhN/EiRnVIiRCRKMgbSyzBP8fELU87UK8LLYSuSogRZrRtKvrd00uj
	Unlh6xlTvGYLy17qYl7PuWJwMK2Ykh7LGc/3SZ5nWT6H8m6/9qY+/v4zMwb84UumSHwCxBSTNPF
	pBPtIdctqaVdresPOKI4ff23/bKU2/OWPw9zKGDsawsVG6qiNU8VmjbGe06HsSgcMijxc2Sr+WV
	SpgtHitiVBUyshrj7GwQYNm4/WCvNO/tvhAwl3Vpr0nBunYvXEHZ+df9wPWUBR1W7nwSVzloPO9
	iRU6OUXrNbqTbF/IX6o4NGQkbFYCs7z6WjidxOlis8Sji0uPTU01vM5EKkPmwtcT9VlEV5Red9k
	GxoPwjoSK+CqynSi2cbSLQ6xp6/vJYmzNTlRDiy
X-Received: by 2002:a05:690c:d95:b0:79d:4f01:5bb5 with SMTP id 00721157ae682-79d4f015fa4mr47604117b3.5.1774820467018;
        Sun, 29 Mar 2026 14:41:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cba46f3ccsm26388257b3.40.2026.03.29.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:06 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 06/16] midx: support custom `--base` for incremental MIDX
 writes
Message-ID: <6b42d284b79a25e97d506e22c709e4dbe6fddd58.1774820449.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

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

For the `write` subcommand, `--base` requires `--checksum-only`. A plain
`write --incremental` appends a new layer to the live chain tip with no
mechanism to atomically replace it; overriding the base would produce a
layer that does not extend the tip, breaking chain invariants. With
`--checksum-only` the chain is left unmodified and the caller is
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
index 657e0639f6a..635105ad801 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -12,8 +12,10 @@ SYNOPSIS
 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
 		         [--refs-snapshot=<path>] [--[no-]checksum-only]
+			 [--base=<checksum>]
 'git multi-pack-index' [<options>] compact [--[no-]incremental]
-		         [--[no-]bitmap] [--[no-]checksum-only] <from> <to>
+		         [--[no-]bitmap] [--base=<checksum>] [--[no-]checksum-only]
+			 <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
@@ -83,6 +85,13 @@ marker).
 		and packs not present in an existing MIDX layer.
 		Migrates non-incremental MIDXs to incremental ones when
 		necessary.
+
+	--base=<checksum>::
+		Specify the checksum of an existing MIDX layer to use
+		as the base when writing a new incremental layer.
+		The special value `none` indicates that the new layer
+		should have no base (i.e., it becomes a root layer).
+		Requires `--checksum-only`.
 --
 
 compact::
@@ -97,6 +106,12 @@ compact::
 
 	--[no-]bitmap::
 		Control whether or not a multi-pack bitmap is written.
+
+	--base=<checksum>::
+		Specify the checksum of an existing MIDX layer to use
+		as the base for the compacted result, instead of using
+		the immediate parent of `<from>`. The special value
+		`none` indicates that the result should have no base.
 --
 
 verify::
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 17ab1525454..3a12baacb56 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -16,11 +16,13 @@
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
-	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]")
+	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]\n" \
+	   "  [--base=<checksum>]")
 
 #define BUILTIN_MIDX_COMPACT_USAGE \
 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
-	   "  [--[no-]bitmap] [--[no-]checksum-only] <from> <to>")
+	   "  [--[no-]bitmap] [--base=<checksum>] [--[no-]checksum-only]\n" \
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
 		OPT_BIT(0, "checksum-only", &opts.flags,
@@ -190,6 +195,13 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 				   options);
 	}
 
+	if (opts.incremental_base &&
+	    !(opts.flags & MIDX_WRITE_CHECKSUM_ONLY)) {
+		error(_("cannot use --base without --checksum-only"));
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
index 2c6905173ba..9298a5140fd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1247,6 +1247,7 @@ struct write_midx_opts {
 
 	const char *preferred_pack_name;
 	const char *refs_snapshot;
+	const char *incremental_base;
 	unsigned flags;
 };
 
@@ -1329,11 +1330,32 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
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
@@ -1846,7 +1868,8 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 int write_midx_file(struct odb_source *source,
 		    const char *preferred_pack_name,
-		    const char *refs_snapshot, unsigned flags)
+		    const char *refs_snapshot,
+		    unsigned flags)
 {
 	struct write_midx_opts opts = {
 		.source = source,
@@ -1861,13 +1884,16 @@ int write_midx_file(struct odb_source *source,
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
 
@@ -1877,12 +1903,14 @@ int write_midx_file_only(struct odb_source *source,
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
index 9f1acd7ace4..e4a75ff2bef 100644
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
index ac249365f2b..7733cafb647 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -113,6 +113,36 @@ test_expect_success 'write non-incremental MIDX layer with --checksum-only' '
 	test_grep "cannot use --checksum-only without --incremental" err
 '
 
+test_expect_success 'write MIDX layer with --base without --checksum-only' '
+	test_must_fail git multi-pack-index write --bitmap --incremental \
+		--base=none 2>err &&
+	test_grep "cannot use --base without --checksum-only" err
+'
+
+test_expect_success 'write MIDX layer with --base=none and --checksum-only' '
+	test_commit base-none &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--checksum-only --base=none)" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
+test_expect_success 'write MIDX layer with --base=<hash> and --checksum-only' '
+	test_commit base-hash &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--checksum-only --base="$(nth_line 1 "$midx_chain")")" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
 for reuse in false single multi
 do
 	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 3ad910a9d1c..d8e1b03669a 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -304,6 +304,7 @@ test_expect_success 'MIDX compaction with --checksum-only' '
 
 		layer="$(git multi-pack-index compact --incremental \
 			--checksum-only \
+			--base="$(nth_line 1 "$midx_chain")" \
 			"$(nth_line 2 "$midx_chain")" \
 			"$(nth_line 3 "$midx_chain")")" &&
 
@@ -326,4 +327,80 @@ test_expect_success 'MIDX compaction with --checksum-only' '
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
2.53.0.729.g817728289e1.dirty

