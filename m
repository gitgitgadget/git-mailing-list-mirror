Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86D314B63
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820467; cv=none; b=pedp21+liZOvrOwdl1ja6nIVDKUSSqbmfbM/8B7XErXmWMos0ccRi/0oZBaBtUW0FQ6q1tACMX5jsuj+/rj+PndDCSIJ3riQCzhA5ChyJ9IKISrnPSKNmtQiIn2ilLYtm6AmxpO2/9aTc49qulg1OhJk/vsmqsjAZQk6lI9z924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820467; c=relaxed/simple;
	bh=VUbmKls9rWpDWYimhH+bz1wYHHIyhaHzITJsrdaZqOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTyfIvSBYHoUrAlan8/57BJ+bA1JDySmrM/hunvplrj85fRBgjA0BQOHhy2x0GkCp8oktCCovhhFmu2YlrOR2Ob5dNgTjm9Cv/nrtkZT1AJK5ZAtaKNaXg2jejBTMCCOW4GEjoVF2ujlSTuR2WvCMQSrTWKYYTWn0B4dFORAO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DUE34kWB; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DUE34kWB"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6500eae6d2fso1710524d50.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820464; x=1775425264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k98YaOUCCAh5YH7sUTaEN8VVuxgCfEkpHQ0revIWaAE=;
        b=DUE34kWBVno8UM65pcZtrldoasyDzV1SGZ1omHL5SvYMMmgvqsWb6jV3mPOgGIi2GB
         zUCC/Xqw1jkl2BAE8mPPAbvNIKDzmXl/y18S8fYRK2TwtmZ9cX1M2tx+ruGvhWnwUAr2
         oo6fY1B3LBgIzkLeWN2OgBsXZTnOfdmrCm32u3Zrrc2zzFP8LsUU1vBxNE4++1DNrHWz
         +tWCYZb3l6xFQyRMaGLVOrQqU04TDq1+WS0d8T+risNkulKLf+0Sog/NkwhpoXldL3LE
         zF/gIEMtFdqr+2/2LTE9l2Fh4c24fcgZ3q7A847md5loZay1NuRpmGEJtLtKetgUrVV+
         txrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820464; x=1775425264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k98YaOUCCAh5YH7sUTaEN8VVuxgCfEkpHQ0revIWaAE=;
        b=Ao5Gm8z2kQMwGaNZh7pmfnNp+n0qDIF1c5yiwnqOzj5sxNBgybgP5j5RqUrwuNvoEJ
         JWmwrvAXRjF6ZSJOdxbiia9LKcD75u23ruROglNsOxTWST5enBc/R0w7nwIHMBsrAyx5
         nGVzgkMtPoOlVye9kLqJDhqZcfBFpPuGXZ2/+LhISQ/+PAgd/7Ae84OnfezRWig/Sfeu
         ent3hVrGRpVLaBjhwSsD6vziXHzRm2xWVkde7F5Ls9jCLXr2rxfNX73P54JD90HiqE8l
         FUz4mDuba67Jnm4mqqncPbhoucTviSC1dvBbc51LfgolVnLdWDQtwlGHtV4i203ujtZq
         HvhA==
X-Gm-Message-State: AOJu0Yxm/vVHSxIj+5eoddDBJrwdeYOM7W2tfFkUu9EZE4WurxmRliYD
	s4sdcwZnIjkf1+n9caFVCGINkU++tTKxbGtjDkhf843ErhLu1KW811utc5pw249IR/pXtfDgUFZ
	GlHyRKPrPhQ==
X-Gm-Gg: ATEYQzwWxby/M7MPk+humQ8++jH3wQ7gx7bRxCryoPwNrnLo8mJs0MRzvwzlj6eMRXp
	uw9L903kNXfDNs8izjt7WvK4PqNJL1N2l3xDnmtYl2czCGmmRUBvJKDHnHtSIIO6k+XH1DJiRSC
	O9yXWIRgD9ThZtdzbBbHlYrRty4ioTP5WRUEIh/4gTqMApE+C8BhymgH/LZ8s6fV85S725NkwTF
	7xf949Xhm0Fz6f0/E1MorBm3J21D5hmdDhg8glfPGym4qeW9tjKoJxm7V+bP/2HGJWLIKJGjYfJ
	JSW1A0AT1qTf2zF7zeDbNcd1zcx8W8FGF4ZJlRg+yaE2HkD6VDZ5BcuLOH4z8u9gO6VoaGPr8/S
	YFG1pekAwayyZ07ipLTpTcX6M04PfjALU2Ud+ZM2bhoKG3Tp8USpobQc4zS8Pv76IlNObhNb12p
	s7aacLtfiMFYi5Bil5YXiB+iWaxNx1RsOOHD8A6vTT0WUSbPsAIvcVP3FHDqvV2OQd+q/puTP5c
	Pdf4oIKVVNWt4tVcI0VYcq6zL+5pw==
X-Received: by 2002:a05:690e:4842:b0:64a:f1a6:6b0d with SMTP id 956f58d0204a3-64ff71aea11mr8187104d50.14.1774820464449;
        Sun, 29 Mar 2026 14:41:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65019b581e9sm998632d50.4.2026.03.29.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:04 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 05/16] midx: introduce `--checksum-only` for incremental MIDX
 writes
Message-ID: <41cb5471bb96d38a1b9ae75d022e2c5356318939.1774820449.git.me@ttaylorr.com>
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

When writing an incremental MIDX layer, the MIDX machinery writes the
new layer into the multi-pack-index.d directory and then updates the
multi-pack-index-chain file to include the freshly written layer.

Future callers however may not wish to immediately update the MIDX chain
itself, preferring instead to write out new layer(s) themselves before
atomically updating the chain. Concretely, the new incremental
MIDX-based repacking strategy will want to do exactly this (that is,
assemble the new MIDX chain itself before writing a new chain file and
atomically linking it into place).

Introduce a `--checksum-only` flag that:

 * writes the new MIDX layer into the multi-pack-index.d directory

 * prints its checksum

 * does not update the multi-pack-index-chain file.

The MIDX chain file (and thus, the lock protecting it) remain untouched,
allowing callers to assemble the chain themselves. This flag requires
`--incremental`, since the notion of a separate layer only makes sense
for incremental MIDXs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc |  4 +--
 builtin/multi-pack-index.c              | 28 ++++++++++++++++--
 midx-write.c                            | 38 ++++++++++++++++---------
 midx.h                                  |  1 +
 t/t5334-incremental-multi-pack-index.sh | 17 +++++++++++
 t/t5335-compact-multi-pack-index.sh     | 36 +++++++++++++++++++++++
 6 files changed, 107 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 61256830141..657e0639f6a 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -11,9 +11,9 @@ SYNOPSIS
 [verse]
 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
-		         [--refs-snapshot=<path>]
+		         [--refs-snapshot=<path>] [--[no-]checksum-only]
 'git multi-pack-index' [<options>] compact [--[no-]incremental]
-		         [--[no-]bitmap] <from> <to>
+		         [--[no-]bitmap] [--[no-]checksum-only] <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 0f72d96c02d..17ab1525454 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -16,11 +16,11 @@
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
-	   "  [--refs-snapshot=<path>]")
+	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]")
 
 #define BUILTIN_MIDX_COMPACT_USAGE \
 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
-	   "  [--[no-]bitmap] <from> <to>")
+	   "  [--[no-]bitmap] [--[no-]checksum-only] <from> <to>")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -153,6 +153,9 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
+		OPT_BIT(0, "checksum-only", &opts.flags,
+			N_("write a MIDX layer without updating the MIDX chain"),
+			MIDX_WRITE_CHECKSUM_ONLY),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			 N_("write multi-pack index containing only given indexes")),
 		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
@@ -178,6 +181,15 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_write_usage,
 				   options);
+
+	if (opts.flags & MIDX_WRITE_CHECKSUM_ONLY &&
+	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
+		error(_("cannot use %s without %s"),
+		      "--checksum-only", "--incremental");
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
+		OPT_BIT(0, "checksum-only", &opts.flags,
+			N_("write a MIDX layer without updating the MIDX chain"),
+			MIDX_WRITE_CHECKSUM_ONLY),
 		OPT_END(),
 	};
 
@@ -239,6 +254,15 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 	if (argc != 2)
 		usage_with_options(builtin_multi_pack_index_compact_usage,
 				   options);
+
+	if (opts.flags & MIDX_WRITE_CHECKSUM_ONLY &&
+	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
+		error(_("cannot use %s without %s"),
+		      "--checksum-only", "--incremental");
+		usage_with_options(builtin_multi_pack_index_compact_usage,
+				   options);
+	}
+
 	source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
diff --git a/midx-write.c b/midx-write.c
index 9f7d2bbf4cb..2c6905173ba 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1600,11 +1600,14 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	}
 
 	if (ctx.incremental) {
-		struct strbuf lock_name = STRBUF_INIT;
+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
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
@@ -1725,14 +1728,19 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	}
 	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
 
+	if (opts->flags & MIDX_WRITE_CHECKSUM_ONLY)
+		printf("%s\n", hash_to_hex_algop(midx_hash, r->hash_algo));
+
 	if (ctx.incremental) {
-		FILE *chainf = fdopen_lock_file(&lk, "w");
 		struct strbuf final_midx_name = STRBUF_INIT;
 		struct multi_pack_index *m = ctx.base_midx;
 
-		if (!chainf) {
-			error_errno(_("unable to open multi-pack-index chain file"));
-			goto cleanup;
+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
+			FILE *chainf = fdopen_lock_file(&lk, "w");
+			if (!chainf) {
+				error_errno(_("unable to open multi-pack-index chain file"));
+				goto cleanup;
+			}
 		}
 
 		if (link_midx_to_chain(ctx.base_midx) < 0)
@@ -1793,8 +1801,10 @@ static int write_midx_internal(struct write_midx_opts *opts)
 			}
 		}
 
-		for (uint32_t i = 0; i < keep_hashes_nr; i++)
-			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY))
+			for (uint32_t i = 0; i < keep_hashes_nr; i++)
+				fprintf(get_lock_file_fp(&lk), "%s\n",
+					keep_hashes.v[i]);
 	} else {
 		keep_hashes.v[ctx.num_multi_pack_indexes_before] =
 			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
@@ -1804,10 +1814,12 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.m || ctx.base_midx)
 		odb_close(ctx.repo->objects);
 
-	if (commit_lock_file(&lk) < 0)
-		die_errno(_("could not write multi-pack-index"));
+	if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
+		if (commit_lock_file(&lk) < 0)
+			die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
+		clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
+	}
 	result = 0;
 
 cleanup:
diff --git a/midx.h b/midx.h
index 08f3728e520..9f1acd7ace4 100644
--- a/midx.h
+++ b/midx.h
@@ -83,6 +83,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
 #define MIDX_WRITE_INCREMENTAL (1 << 5)
 #define MIDX_WRITE_COMPACT (1 << 6)
+#define MIDX_WRITE_CHECKSUM_ONLY (1 << 7)
 
 #define MIDX_EXT_REV "rev"
 #define MIDX_EXT_BITMAP "bitmap"
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index c9f5b4e87aa..ac249365f2b 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -96,6 +96,23 @@ test_expect_success 'show object from second pack' '
 	git cat-file -p 2.2
 '
 
+test_expect_success 'write MIDX layer with --checksum-only' '
+	test_commit checksum-only &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--checksum-only)" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
+test_expect_success 'write non-incremental MIDX layer with --checksum-only' '
+	test_must_fail git multi-pack-index write --bitmap --checksum-only 2>err &&
+	test_grep "cannot use --checksum-only without --incremental" err
+'
+
 for reuse in false single multi
 do
 	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 40f3844282f..3ad910a9d1c 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -290,4 +290,40 @@ test_expect_success 'MIDX compaction with bitmaps (non-trivial)' '
 	)
 '
 
+test_expect_success 'MIDX compaction with --checksum-only' '
+	git init midx-compact-with--checksum-only &&
+	(
+		cd midx-compact-with--checksum-only &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C D &&
+
+		test_line_count = 4 $midx_chain &&
+		cp "$midx_chain" "$midx_chain".bak &&
+
+		layer="$(git multi-pack-index compact --incremental \
+			--checksum-only \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 3 "$midx_chain")")" &&
+
+		test_cmp "$midx_chain.bak" "$midx_chain" &&
+
+		# After writing the new layer, insert it into the chain
+		# manually. This is done in order to make $layer visible
+		# to the read-midx test helper below, and matches what
+		# the MIDX command would do without --checksum-only.
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
2.53.0.729.g817728289e1.dirty

