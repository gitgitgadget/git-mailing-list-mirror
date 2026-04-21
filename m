Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281453DDDC3
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803851; cv=none; b=p98IzCcDzczR2eiwA0ColsAwF+K39/XlYDJB0sb3uTN0oJ3uCv6mv8gjHQuBHL0aINVud/se+lkMq/femD2c+La28/LSztJD7XgNYreHIPYGTG818FX2soV6WQ741sVnJmHyRwx9RiwWVwTnP8Ui67EuaY30n/cy3BIgjB+Eb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803851; c=relaxed/simple;
	bh=TIqk3v5T6V3G6dzCbPMK7oi6+rmwUrGzfmsGI7Usexc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUSs3jhcvSi4bLTlJfhWBMNBiFSG8eTiRWbIuaRmUwO2+2NWn4c1WPfg8Qd+3BcF9IWb5U/+aIzDLE+sjsj5YV5WDVAfzOHAXcr0ey9mP0kByLuUB/W9UScOc2/CXlUkl0VD4zCelFea+Wi6Ia+kECL+iywKsTi6yxVXIapSI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CLw0GtOx; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CLw0GtOx"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-479fc1fc048so301366b6e.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803849; x=1777408649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyS6d03YsOkB5DyFCoxn2J+3t+h57QpL+iSIssO5UAc=;
        b=CLw0GtOxi7FmtHVPKCJuIbqAsD7zXisa4ZSj0Qg/t6dozGWZtj9CReWiRU2lTW1x3e
         S5slQnuoeiLwHWRxTjbO72Nr9yYf2Lq1dM70886w2zSO1iU0kxzpeUEQITE5lmE2zJL0
         kC9/bAiWyP3+wh8TWkm7KGvEUFNg6uxB7f4y6XeB9a1vd6N0piopw/IInKXIbVxbMybP
         +hVmngZYRbNQm4I0RZerXyDqezkB/qB8DwklI2uYrcXy2MrU/fPn+7X65aH4yCqec8HZ
         Nddrn121CGKO9lCgbK8tvfxGr+XVXOXsb3vTYyuujYyguplHsGKKNMn6KpHA8y9ovMg1
         iAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803849; x=1777408649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyS6d03YsOkB5DyFCoxn2J+3t+h57QpL+iSIssO5UAc=;
        b=G+q3zvfLLeXyN9Ge6TNdTvJh3qaArgSpmuhk82hCkfyk+cc3uG2dp7x7lPW49HCF0t
         15nehV3Om+msUuWFcgFabGfWbvRHEndSQeIN9P1ZZu3wDR4FAjnnoyoQnD9WG7glHurT
         s13T/CmsXe5xG4lu26oCc3dYAHr+hH2Dx+/17TRoTDa/Fplx6msYv89gQHUnh43LGiM0
         evcHknOrWS6szStRKbDvAyhOXn0yDMceal8clA509LSBuin0dTopz3/ycWEMkFJfjXix
         EFYR2lXfbRiMGvTONZVtwIcOxupq7yuoa3onyrmdOfcnUZCbeTsJc+QrtmcNKeUVxuZ5
         zdeA==
X-Gm-Message-State: AOJu0YygJv9wIslWAEczzrEkgP3L5mfp+AWx1tffjd/Cq4VLXJ9Hhxfd
	GKpz1vMLW/xHXXcWP/aLsQZbAHJRT1AViXk3O2LcESGRNA71E3kz7+3rnmQbWfR7wvOmp10Joxp
	FIFpcaz4=
X-Gm-Gg: AeBDiesD97nx8IxanqYCJsp8JucRuWMCjS+bf2z06LO3ksUtvbkAOtJdRiY1P9YWaRF
	lBCOEQpDFHkTs7U7+3sVbs7lJBTpfQB1GNYK2pxS0pND1vQBFXrWuCMjtmg3UWE5erqfjEBm1bZ
	esqjIgpoDITx8q5jrHTpYIqNj2uGPAITjPImA0Es2eFs09Vl1Bif7ETdVSgiNpRBiHaphLsMq1c
	BQn5FR3w06YQnMY5ZkdxD7VH7ALOKeP5rXMj7EZl4fI54qlVBmuNHpr8utAcjiMq3Tc9BnnFRb1
	05aSjRdgA3/lOU6dbsdFSNPOr+tbQZvP6IQkRwwQe1jhLB8PUoF2pS/k4lvOBzbENJ+ZGJaEhpn
	9fDYiZvgAUX6bTM6Hcr1frMqsbHkcDa0509oF48oCzAgCNSdArGGx/adb7b0ophhkP6F7DEa7AW
	HlnBe2ospOBfIhAZozMCGW6jDDHoyK/jawrj37cXmpl2mJ4ExkK8GbinXZ+maISkkGiua0yA6Dp
	c37mD8DgujI9AhFO7a0Ux/Ikp5i0ZLKQnCw3mtc2FDJNzSURjqc0VgdsGbmyuSrz82gGcu2IA0D
	06/+KK5aRPm4DvmQ61/QQMaXBK8=
X-Received: by 2002:a05:6808:d4c:b0:45e:f443:dc3d with SMTP id 5614622812f47-4799c9424e2mr11203668b6e.13.1776803848943;
        Tue, 21 Apr 2026 13:37:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799feaabf2sm9489648b6e.4.2026.04.21.13.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:28 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 05/16] midx: introduce `--no-write-chain-file` for
 incremental MIDX writes
Message-ID: <2c80aa34fac76a7755d3cdcd0d9bdc659b5d3795.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

When writing an incremental MIDX layer, the MIDX machinery writes the
new layer into the multi-pack-index.d directory and then updates the
multi-pack-index-chain file to include the freshly written layer.

Future callers however may not wish to immediately update the MIDX chain
itself, preferring instead to write out new layer(s) themselves before
atomically updating the chain. Concretely, the new incremental
MIDX-based repacking strategy will want to do exactly this (that is,
assemble the new MIDX chain itself before writing a new chain file and
atomically linking it into place).

Introduce a `--no-write-chain-file` flag that:

 * writes the new MIDX layer into the multi-pack-index.d directory

 * prints its checksum

 * does not update the multi-pack-index-chain file.

The MIDX chain file (and thus, the lock protecting it) remain untouched,
allowing callers to assemble the chain themselves. This flag requires
`--incremental`, since the notion of a separate layer only makes sense
for incremental MIDXs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 17 ++++++++--
 builtin/multi-pack-index.c              | 28 +++++++++++++++--
 midx-write.c                            | 42 ++++++++++++++++---------
 midx.h                                  |  1 +
 t/t5334-incremental-multi-pack-index.sh | 17 ++++++++++
 t/t5335-compact-multi-pack-index.sh     | 36 +++++++++++++++++++++
 6 files changed, 123 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 3a5aa227784..c26196815e2 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -11,9 +11,9 @@ SYNOPSIS
 [verse]
 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
-		         [--refs-snapshot=<path>]
+		         [--refs-snapshot=<path>] [--[no-]write-chain-file]
 'git multi-pack-index' [<options>] compact [--[no-]incremental]
-		         [--[no-]bitmap] <from> <to>
+		         [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
@@ -83,6 +83,13 @@ marker).
 		and packs not present in an existing MIDX layer.
 		Migrates non-incremental MIDXs to incremental ones when
 		necessary.
+
+	--[no-]write-chain-file::
+		When used with `--incremental`, write a new MIDX layer
+		but do not update the multi-pack-index-chain file.
+		The checksum of the new layer is printed to standard
+		output, allowing the caller to assemble and write the
+		chain itself. Requires `--incremental`.
 --
 
 compact::
@@ -97,6 +104,12 @@ compact::
 
 	--[no-]bitmap::
 		Control whether or not a multi-pack bitmap is written.
+
+	--[no-]write-chain-file::
+		When used with `--incremental`, write a new compacted
+		MIDX layer but do not update the multi-pack-index-chain
+		file. The checksum of the new layer is printed to
+		standard output. Requires `--incremental`.
 --
 +
 Note that the compact command requires writing a version-2 midx that
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 0f72d96c02d..f861b4b8394 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -16,11 +16,11 @@
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
-	   "  [--refs-snapshot=<path>]")
+	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]")
 
 #define BUILTIN_MIDX_COMPACT_USAGE \
 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
-	   "  [--[no-]bitmap] <from> <to>")
+	   "  [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -153,6 +153,9 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
+		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
+			N_("write the multi-pack-index chain file"),
+			MIDX_WRITE_NO_CHAIN),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			 N_("write multi-pack index containing only given indexes")),
 		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
@@ -178,6 +181,15 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_write_usage,
 				   options);
+
+	if (opts.flags & MIDX_WRITE_NO_CHAIN &&
+	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
+		error(_("cannot use %s without %s"),
+		      "--no-write-chain-file", "--incremental");
+		usage_with_options(builtin_multi_pack_index_write_usage,
+				   options);
+	}
+
 	source = handle_object_dir_option(repo);
 
 	FREE_AND_NULL(options);
@@ -221,6 +233,9 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
+		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
+			N_("write the multi-pack-index chain file"),
+			MIDX_WRITE_NO_CHAIN),
 		OPT_END(),
 	};
 
@@ -239,6 +254,15 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 	if (argc != 2)
 		usage_with_options(builtin_multi_pack_index_compact_usage,
 				   options);
+
+	if (opts.flags & MIDX_WRITE_NO_CHAIN &&
+	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
+		error(_("cannot use %s without %s"),
+		      "--no-write-chain-file", "--incremental");
+		usage_with_options(builtin_multi_pack_index_compact_usage,
+				   options);
+	}
+
 	source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
diff --git a/midx-write.c b/midx-write.c
index 5d9409a9741..38c898e5ff5 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1257,7 +1257,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t start_pack;
 	struct hashfile *f = NULL;
-	struct lock_file lk;
+	struct lock_file lk = LOCK_INIT;
 	struct tempfile *incr;
 	struct write_midx_context ctx = {
 		.preferred_pack_idx = NO_PREFERRED_PACK,
@@ -1601,11 +1601,14 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	}
 
 	if (ctx.incremental) {
-		struct strbuf lock_name = STRBUF_INIT;
+		if (!(opts->flags & MIDX_WRITE_NO_CHAIN)) {
+			struct strbuf lock_name = STRBUF_INIT;
 
-		get_midx_chain_filename(opts->source, &lock_name);
-		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
-		strbuf_release(&lock_name);
+			get_midx_chain_filename(opts->source, &lock_name);
+			hold_lock_file_for_update(&lk, lock_name.buf,
+						  LOCK_DIE_ON_ERROR);
+			strbuf_release(&lock_name);
+		}
 
 		incr = mks_tempfile_m(midx_name.buf, 0444);
 		if (!incr) {
@@ -1707,16 +1710,23 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
 		die(_("too many multi-pack-indexes"));
 
+	if (!is_lock_file_locked(&lk))
+		printf("%s\n", hash_to_hex_algop(midx_hash, r->hash_algo));
+	else if (opts->flags & MIDX_WRITE_NO_CHAIN)
+		BUG("lockfile held with MIDX_WRITE_NO_CHAIN set?");
+
 	if (ctx.incremental) {
-		FILE *chainf = fdopen_lock_file(&lk, "w");
 		struct strbuf final_midx_name = STRBUF_INIT;
 		struct multi_pack_index *m = ctx.base_midx;
 		struct multi_pack_index **layers = NULL;
 		size_t layers_nr = 0, layers_alloc = 0;
 
-		if (!chainf) {
-			error_errno(_("unable to open multi-pack-index chain file"));
-			goto cleanup;
+		if (is_lock_file_locked(&lk)){
+			FILE *chainf = fdopen_lock_file(&lk, "w");
+			if (!chainf) {
+				error_errno(_("unable to open multi-pack-index chain file"));
+				goto cleanup;
+			}
 		}
 
 		if (link_midx_to_chain(ctx.base_midx) < 0)
@@ -1773,8 +1783,10 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 		free(layers);
 
-		for (size_t i = 0; i < keep_hashes.nr; i++)
-			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
+		if (is_lock_file_locked(&lk))
+			for (size_t i = 0; i < keep_hashes.nr; i++)
+				fprintf(get_lock_file_fp(&lk), "%s\n",
+					keep_hashes.v[i]);
 	} else {
 		strvec_push(&keep_hashes,
 			    hash_to_hex_algop(midx_hash, r->hash_algo));
@@ -1783,10 +1795,12 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.m || ctx.base_midx)
 		odb_close(ctx.repo->objects);
 
-	if (commit_lock_file(&lk) < 0)
-		die_errno(_("could not write multi-pack-index"));
+	if (is_lock_file_locked(&lk)) {
+		if (commit_lock_file(&lk) < 0)
+			die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
+		clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
+	}
 	result = 0;
 
 cleanup:
diff --git a/midx.h b/midx.h
index 08f3728e520..5b193882dcf 100644
--- a/midx.h
+++ b/midx.h
@@ -83,6 +83,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
 #define MIDX_WRITE_INCREMENTAL (1 << 5)
 #define MIDX_WRITE_COMPACT (1 << 6)
+#define MIDX_WRITE_NO_CHAIN (1 << 7)
 
 #define MIDX_EXT_REV "rev"
 #define MIDX_EXT_BITMAP "bitmap"
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index c9f5b4e87aa..66d6894761b 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -96,6 +96,23 @@ test_expect_success 'show object from second pack' '
 	git cat-file -p 2.2
 '
 
+test_expect_success 'write MIDX layer with --no-write-chain-file' '
+	test_commit no-write-chain-file &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--no-write-chain-file)" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
+test_expect_success 'write non-incremental MIDX layer with --no-write-chain-file' '
+	test_must_fail git multi-pack-index write --bitmap --no-write-chain-file 2>err &&
+	test_grep "cannot use --no-write-chain-file without --incremental" err
+'
+
 for reuse in false single multi
 do
 	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 40f3844282f..1a65d48b62b 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -290,4 +290,40 @@ test_expect_success 'MIDX compaction with bitmaps (non-trivial)' '
 	)
 '
 
+test_expect_success 'MIDX compaction with --no-write-chain-file' '
+	git init midx-compact-with--no-write-chain-file &&
+	(
+		cd midx-compact-with--no-write-chain-file &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C D &&
+
+		test_line_count = 4 $midx_chain &&
+		cp "$midx_chain" "$midx_chain".bak &&
+
+		layer="$(git multi-pack-index compact --incremental \
+			--no-write-chain-file \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 3 "$midx_chain")")" &&
+
+		test_cmp "$midx_chain.bak" "$midx_chain" &&
+
+		# After writing the new layer, insert it into the chain
+		# manually. This is done in order to make $layer visible
+		# to the read-midx test helper below, and matches what
+		# the MIDX command would do without --no-write-chain-file.
+		{
+			nth_line 1 "$midx_chain.bak" &&
+			echo $layer &&
+			nth_line 4 "$midx_chain.bak"
+		} >$midx_chain &&
+
+		test-tool read-midx $objdir $layer >midx.data &&
+		grep "^pack-B-.*\.idx" midx.data &&
+		grep "^pack-C-.*\.idx" midx.data
+
+	)
+'
+
 test_done
-- 
2.54.0.9.gb905fd5d0ae

