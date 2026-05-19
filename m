Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E964028E5
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206313; cv=none; b=LIDL8yq7PxTd+AlfhZjCDcJnskDLM6QJKjTEb1i3rL8wl/4EjI0D9orxWMPW7Q5DHj0jMwwjXuQxg5TYHG+O3LGr86j5/lBpATJ3QuKJk/ZjoOwbvk/N0Zhzg2zKFgC18QaB2NEOXHm8D6ms06Xbh+iDsG24HPhx5ozTZ+j8yIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206313; c=relaxed/simple;
	bh=vSMviVPjhuok5FY4U788CHNeugC010DucoSFarXeuzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUh6W4bkZOzvNFntTHa4FDccyn+pjannQCV3/5e8CruaScaLaJsmt9n3eFzi7HQn88OdpP12WVxDIwwJ0w6GPbhyU7/wI7Gs/KFQ0nzUYEnE41bwcwxpANvb8f8yq7bM6yiBTpVBK8A9AaeT0CxakVUaFr1y8vQMcXRYwTDLCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bFzFFgS3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bFzFFgS3"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bf1eaba464so32212327b3.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206305; x=1779811105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1A5EesGUXkBilEQXAf0yl6+3vf2A5ebyq2sDihblSUk=;
        b=bFzFFgS3sVeU4mwYx/Mq9mrqSTAqp1yYb0QcFAliFXKtMOgZfC5frMpA7j/bkxsuH2
         WGIvv29PKdSyAsu7DPxekpTBpsMc0ORK523fUJ3US9IxRMO9sol84FPCD0xAiajzZF02
         dEnIIaqp8oeI0UMlky8YHEPZtH8tnFn4BIOZlDbu5JiiqU7f1dV2MDx7SxVkaqJAfdvF
         kASOf+ISLsq7Kc/oSLXffzOxG0cdGNHigX1HCMC+k1sGdCM974ZYGR7zSQKHboiJ9zJa
         fBFiGUPAtiCez4s1kK3iRmo8k/XsNcC/5j4alH9c7Orm1sWzwp9OzMsbAHA0LtRRGfv6
         QYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206305; x=1779811105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A5EesGUXkBilEQXAf0yl6+3vf2A5ebyq2sDihblSUk=;
        b=fYWqKJAVK1kSTPwWnmiL30FAtIrUaSs7B65oJd4Zm7vsnYvXCgKwOn3gPK0OVpMfUZ
         mtmo6dw7f0tbkAZlQLB8JZ0o8Lyb/HgBkk0kAOqLjCU7hjzom6p5YWGw0Olw0VVMf7Up
         i0nB6kUjYUbvWaLdcENpmlYehkru+yvFB5plOS8jXICX2+eOMcenDZrJlI4mmZHRqNUs
         GEYaNw4dH2oUqFlkVRAyX6AA/6SE9Tn8VZunun0dDlvGGQtX8hFzhK636QbU0vZT53c+
         U/0DYQnBOGbRAY97RKv07uugSopT0/4wgk9PLFOt/AN0xcRkPN/49IC9H7Aps+Tui+Cl
         YNog==
X-Gm-Message-State: AOJu0YwhaZcLbcEzEUoaQQgvxXpbxgt+Q+8kWxCq29rRHFxJ7DTb/B4g
	S9w1oOOs7X0smauUddc0cDQkTKD7GZE2GgTzkeEJjJz0Zuhu8ycc3buvyp4ZmJ04ospAVSEs1RA
	lQDtW9yO82A==
X-Gm-Gg: Acq92OGktsoyox08Xm5CTaP887dhAS1QqQhlGQjJC7F4AvzabnMa/RJiLseEbZN1aam
	T4oWRswlJ6MIKsk2fAsgtgxlAvLW8SkOBXhX2S9qtTWZZKWezga5NT+TUadjVQkzZvVXT0rZFQS
	V7rPvI+uWbsOoqtJ1Slp/+rbl1ttcYixIzwvpt84tncvukrk9RvbA/GMpLlBKO/067lWKkLNtg0
	0VUMQacOptrnd3mhhBxKw/YGb2OJaaUQ38h2isDL3V1pQi1r5FGp8VSCiSN3dj0BdIHVNVNnFXf
	lrjef3GS5N7PYg2D4zT+gCm3Rm+QvMMzimgP+GlpykPl1AZ6RbwS+ft3D1nrB+IaVaGLsKog6k1
	ttwTwEJMaXqyb8sBA6h2nAu/poVMiMltsc4sux0H65MPSNDzLHGxiXKcvSLYgxcFgsni4KgNNsF
	PhozORz80f7ZfR9GqwRlsLD+7qRe+LEdq6mqmwQa5u+Lw9xwsKrgy6pZCeGRGWwKMmfeIYJ0b8i
	/n5Fy1Xda2r6SMzdKRbR+qfsHfZHIRRRrwTo36tpZb9hiXkkOTqP4UosAhnURProbRbRvkfwbn3
	tzJNcPdhhCZgd/YwoCxL2ovLSO0=
X-Received: by 2002:a05:690c:7681:b0:7b4:1ffe:f9f9 with SMTP id 00721157ae682-7c95a472520mr191838307b3.16.1779206304135;
        Tue, 19 May 2026 08:58:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c97absm39250117b3.8.2026.05.19.08.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:58:23 -0700 (PDT)
Date: Tue, 19 May 2026 11:58:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 15/16] repack: introduce `--write-midx=incremental`
Message-ID: <95bf8b21fff6a29a09bdb784323b794cdd2777c3.1779206240.git.me@ttaylorr.com>
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

Expose the incremental MIDX repacking mode (implemented in an earlier
commit) via a new --write-midx=incremental option for `git repack`.

Add "incremental" as a recognized argument to the --write-midx
OPT_CALLBACK, mapping it to REPACK_WRITE_MIDX_INCREMENTAL. When this
mode is active and --geometric is in use, set the midx_layer_threshold
on the pack geometry so that only packs in sufficiently large tip layers
are considered for repacking.

Two new configuration options control the compaction behavior:

 - repack.midxSplitFactor (default: 2): the factor used in the
   geometric merging condition for MIDX layers.

 - repack.midxNewLayerThreshold (default: 8): the minimum number of
   packs in the tip MIDX layer before its packs are considered as
   candidates for geometric repacking.

Add tests exercising the new mode across a variety of scenarios
including basic geometric violations, multi-round chain integrity,
branching and merging histories, cross-layer object uniqueness, and
threshold-based compaction.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/repack.adoc   |  18 ++
 Documentation/git-repack.adoc      |  39 ++-
 builtin/repack.c                   |  49 ++-
 midx.c                             |  29 ++
 midx.h                             |   3 +
 repack-geometry.c                  |  13 +-
 repack-midx.c                      |   5 +
 repack.c                           |  56 +++-
 repack.h                           |  10 +-
 t/meson.build                      |   1 +
 t/t7705-repack-incremental-midx.sh | 470 +++++++++++++++++++++++++++++
 11 files changed, 669 insertions(+), 24 deletions(-)
 create mode 100755 t/t7705-repack-incremental-midx.sh

diff --git a/Documentation/config/repack.adoc b/Documentation/config/repack.adoc
index e9e78dcb198..4c22a499f62 100644
--- a/Documentation/config/repack.adoc
+++ b/Documentation/config/repack.adoc
@@ -46,3 +46,21 @@ repack.midxMustContainCruft::
 	`--write-midx`. When false, cruft packs are only included in the MIDX
 	when necessary (e.g., because they might be required to form a
 	reachability closure with MIDX bitmaps). Defaults to true.
+
+repack.midxSplitFactor::
+	The factor used in the geometric merging condition when
+	compacting incremental MIDX layers during `git repack` when
+	invoked with the `--write-midx=incremental` option.
++
+Adjacent layers are merged when the accumulated object count of the
+newer layer exceeds `1/<N>` of the object count of the next deeper
+layer. Must be at least 2. Defaults to 2.
+
+repack.midxNewLayerThreshold::
+	The minimum number of packs in the tip MIDX layer before those
+	packs are considered as candidates for geometric repacking
+	during `git repack --write-midx=incremental`.
++
+When the tip layer has fewer packs than this threshold, those packs are
+excluded from the geometric repack entirely, and are thus left
+unmodified. Must be at least 1. Defaults to 8.
diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 673ce910837..27a99cc46f4 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
 	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
-	[--write-midx] [--name-hash-version=<n>] [--path-walk]
+	[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
 
 DESCRIPTION
 -----------
@@ -250,9 +250,42 @@ pack as the preferred pack for object selection by the MIDX (see
 linkgit:git-multi-pack-index[1]).
 
 -m::
---write-midx::
+--write-midx[=<mode>]::
 	Write a multi-pack index (see linkgit:git-multi-pack-index[1])
-	containing the non-redundant packs.
+	containing the non-redundant packs. The following modes are
+	available:
++
+--
+	`default`;;
+		Write a single MIDX covering all packs. This is the
+		default when `--write-midx` is given without an
+		explicit mode.
+
+	`incremental`;;
+		Write an incremental MIDX chain instead of a single
+		flat MIDX. This mode requires `--geometric`.
++
+The incremental mode maintains a chain of MIDX layers that is compacted
+over time using a geometric merging strategy. Each repack creates a new
+tip layer containing the newly written pack(s). Adjacent layers are then
+merged whenever the newer layer's object count exceeds
+`1/repack.midxSplitFactor` of the next deeper layer's count. Layers
+that do not meet this condition are retained as-is.
++
+The result is that newer (tip) layers tend to contain many small packs
+with relatively few objects, while older (deeper) layers contain fewer,
+larger packs covering more objects. Because compaction is driven by the
+tip of the chain, newer layers are also rewritten more frequently than
+older ones, which are only touched when enough objects have accumulated
+to justify merging into them. This keeps the total number of layers
+logarithmic relative to the total number of objects.
++
+Only packs in the tip MIDX layer are considered as candidates for the
+geometric repack; packs in deeper layers are left untouched. If the tip
+layer contains fewer packs than `repack.midxNewLayerThreshold`, those
+packs are excluded from the geometry entirely, and a new layer is
+created for any new pack(s) without disturbing the existing chain.
+--
 
 --name-hash-version=<n>::
 	Provide this argument to the underlying `git pack-objects` process.
diff --git a/builtin/repack.c b/builtin/repack.c
index 75c57736780..5ffa18e085e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -33,7 +33,7 @@ static int midx_must_contain_cruft = 1;
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
 	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
-	   "[--write-midx] [--name-hash-version=<n>] [--path-walk]"),
+	   "[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]"),
 	NULL
 };
 
@@ -48,6 +48,8 @@ static const char incremental_bitmap_conflict_error[] = N_(
 struct repack_config_ctx {
 	struct pack_objects_args *po_args;
 	struct pack_objects_args *cruft_po_args;
+	int midx_split_factor;
+	int midx_new_layer_threshold;
 };
 
 static int repack_config(const char *var, const char *value,
@@ -97,6 +99,16 @@ static int repack_config(const char *var, const char *value,
 		midx_must_contain_cruft = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "repack.midxsplitfactor")) {
+		repack_ctx->midx_split_factor = git_config_int(var, value,
+							       ctx->kvi);
+		return 0;
+	}
+	if (!strcmp(var, "repack.midxnewlayerthreshold")) {
+		repack_ctx->midx_new_layer_threshold = git_config_int(var, value,
+								      ctx->kvi);
+		return 0;
+	}
 	return git_default_config(var, value, ctx, cb);
 }
 
@@ -112,6 +124,8 @@ static int option_parse_write_midx(const struct option *opt, const char *arg,
 
 	if (!arg || !*arg)
 		*cfg = REPACK_WRITE_MIDX_DEFAULT;
+	else if (!strcmp(arg, "incremental"))
+		*cfg = REPACK_WRITE_MIDX_INCREMENTAL;
 	else
 		return error(_("unknown value for %s: %s"), opt->long_name, arg);
 
@@ -226,6 +240,8 @@ int cmd_repack(int argc,
 	memset(&config_ctx, 0, sizeof(config_ctx));
 	config_ctx.po_args = &po_args;
 	config_ctx.cruft_po_args = &cruft_po_args;
+	config_ctx.midx_split_factor = DEFAULT_MIDX_SPLIT_FACTOR;
+	config_ctx.midx_new_layer_threshold = DEFAULT_MIDX_NEW_LAYER_THRESHOLD;
 
 	repo_config(repo, repack_config, &config_ctx);
 
@@ -247,6 +263,9 @@ int cmd_repack(int argc,
 	if (pack_everything & PACK_CRUFT)
 		pack_everything |= ALL_INTO_ONE;
 
+	if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL && !geometry.split_factor)
+		die(_("--write-midx=incremental requires --geometric"));
+
 	if (write_bitmaps < 0) {
 		if (write_midx == REPACK_WRITE_MIDX_NONE &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
@@ -273,6 +292,13 @@ int cmd_repack(int argc,
 		write_bitmaps = 0;
 	}
 
+	if (config_ctx.midx_split_factor < 2)
+		die(_("invalid value for %s: %d"), "--midx-split-factor",
+		    config_ctx.midx_split_factor);
+	if (config_ctx.midx_new_layer_threshold < 1)
+		die(_("invalid value for %s: %d"), "--midx-new-layer-threshold",
+		    config_ctx.midx_new_layer_threshold);
+
 	if (write_midx != REPACK_WRITE_MIDX_NONE && write_bitmaps) {
 		struct strbuf path = STRBUF_INIT;
 
@@ -296,6 +322,10 @@ int cmd_repack(int argc,
 	if (geometry.split_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
+		if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL) {
+			geometry.midx_layer_threshold = config_ctx.midx_new_layer_threshold;
+			geometry.midx_layer_threshold_set = true;
+		}
 		pack_geometry_init(&geometry, &existing, &po_args);
 		pack_geometry_split(&geometry);
 	}
@@ -545,8 +575,11 @@ int cmd_repack(int argc,
 				       packtmp);
 	/* End of pack replacement. */
 
-	if (delete_redundant && pack_everything & ALL_INTO_ONE)
+	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
+		if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL)
+			existing_packs_retain_midx_packs(&existing);
 		existing_packs_mark_for_deletion(&existing, &names);
+	}
 
 	if (write_midx != REPACK_WRITE_MIDX_NONE) {
 		struct repack_write_midx_opts opts = {
@@ -558,8 +591,8 @@ int cmd_repack(int argc,
 			.show_progress = show_progress,
 			.write_bitmaps = write_bitmaps > 0,
 			.midx_must_contain_cruft = midx_must_contain_cruft,
-			.midx_split_factor = DEFAULT_MIDX_SPLIT_FACTOR,
-			.midx_new_layer_threshold = DEFAULT_MIDX_NEW_LAYER_THRESHOLD,
+			.midx_split_factor = config_ctx.midx_split_factor,
+			.midx_new_layer_threshold = config_ctx.midx_new_layer_threshold,
 			.mode = write_midx,
 		};
 
@@ -572,11 +605,15 @@ int cmd_repack(int argc,
 
 	if (delete_redundant) {
 		int opts = 0;
-		existing_packs_remove_redundant(&existing, packdir);
+		bool wrote_incremental_midx = write_midx == REPACK_WRITE_MIDX_INCREMENTAL;
+
+		existing_packs_remove_redundant(&existing, packdir,
+						wrote_incremental_midx);
 
 		if (geometry.split_factor)
 			pack_geometry_remove_redundant(&geometry, &names,
-						       &existing, packdir);
+						       &existing, packdir,
+						       wrote_incremental_midx);
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
diff --git a/midx.c b/midx.c
index dc86c8e7fee..efbfbb13f41 100644
--- a/midx.c
+++ b/midx.c
@@ -850,6 +850,35 @@ void clear_midx_file(struct repository *r)
 	strbuf_release(&midx);
 }
 
+void clear_incremental_midx_files(struct repository *r,
+				  const struct strvec *keep_hashes)
+{
+	struct odb_source *source = r->objects->sources;
+	struct strbuf chain = STRBUF_INIT;
+
+	get_midx_chain_filename(source, &chain);
+
+	for (; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		if (files->packed->midx)
+			close_midx(files->packed->midx);
+		files->packed->midx = NULL;
+	}
+
+	if (!keep_hashes && remove_path(chain.buf))
+		die(_("failed to clear multi-pack-index chain at %s"),
+		    chain.buf);
+
+	clear_incremental_midx_files_ext(r->objects->sources, MIDX_EXT_BITMAP,
+					 keep_hashes);
+	clear_incremental_midx_files_ext(r->objects->sources, MIDX_EXT_REV,
+					 keep_hashes);
+	clear_incremental_midx_files_ext(r->objects->sources, MIDX_EXT_MIDX,
+					 keep_hashes);
+
+	strbuf_release(&chain);
+}
+
 static int verify_midx_error;
 
 __attribute__((format (printf, 1, 2)))
diff --git a/midx.h b/midx.h
index 3ee12dd08ec..63853a03a47 100644
--- a/midx.h
+++ b/midx.h
@@ -9,6 +9,7 @@ struct repository;
 struct bitmapped_pack;
 struct git_hash_algo;
 struct odb_source;
+struct strvec;
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION_V1 1
@@ -143,6 +144,8 @@ int write_midx_file_compact(struct odb_source *source,
 			    const char *incremental_base,
 			    unsigned flags);
 void clear_midx_file(struct repository *r);
+void clear_incremental_midx_files(struct repository *r,
+				  const struct strvec *keep_hashes);
 int verify_midx_file(struct odb_source *source, unsigned flags);
 int expire_midx_packs(struct odb_source *source, unsigned flags);
 int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags);
diff --git a/repack-geometry.c b/repack-geometry.c
index 2408b8a3cc2..2064683dcfe 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -249,7 +249,8 @@ static void remove_redundant_packs(struct packed_git **pack,
 				   uint32_t pack_nr,
 				   struct string_list *names,
 				   struct existing_packs *existing,
-				   const char *packdir)
+				   const char *packdir,
+				   bool wrote_incremental_midx)
 {
 	const struct git_hash_algo *algop = existing->repo->hash_algo;
 	struct strbuf buf = STRBUF_INIT;
@@ -269,7 +270,8 @@ static void remove_redundant_packs(struct packed_git **pack,
 		    (string_list_has_string(&existing->kept_packs, buf.buf)))
 			continue;
 
-		repack_remove_redundant_pack(existing->repo, packdir, buf.buf);
+		repack_remove_redundant_pack(existing->repo, packdir, buf.buf,
+					     wrote_incremental_midx);
 	}
 
 	strbuf_release(&buf);
@@ -278,12 +280,13 @@ static void remove_redundant_packs(struct packed_git **pack,
 void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 				    struct string_list *names,
 				    struct existing_packs *existing,
-				    const char *packdir)
+				    const char *packdir,
+				    bool wrote_incremental_midx)
 {
 	remove_redundant_packs(geometry->pack, geometry->split,
-			       names, existing, packdir);
+			       names, existing, packdir, wrote_incremental_midx);
 	remove_redundant_packs(geometry->promisor_pack, geometry->promisor_split,
-			       names, existing, packdir);
+			       names, existing, packdir, wrote_incremental_midx);
 }
 
 void pack_geometry_release(struct pack_geometry *geometry)
diff --git a/repack-midx.c b/repack-midx.c
index f97331fb1b7..4f5deeb97bf 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -887,6 +887,7 @@ static int write_midx_incremental(struct repack_write_midx_opts *opts)
 	struct midx_compaction_step *steps = NULL;
 	struct strbuf lock_name = STRBUF_INIT;
 	struct lock_file lf;
+	struct strvec keep_hashes = STRVEC_INIT;
 	size_t steps_nr = 0;
 	size_t i;
 	int ret = 0;
@@ -932,11 +933,15 @@ static int write_midx_incremental(struct repack_write_midx_opts *opts)
 			BUG("missing result for compaction step %"PRIuMAX,
 			    (uintmax_t)i);
 		fprintf(get_lock_file_fp(&lf), "%s\n", step->csum);
+		strvec_push(&keep_hashes, step->csum);
 	}
 
 	commit_lock_file(&lf);
 
+	clear_incremental_midx_files(opts->existing->repo, &keep_hashes);
+
 done:
+	strvec_clear(&keep_hashes);
 	strbuf_release(&lock_name);
 	for (i = 0; i < steps_nr; i++)
 		midx_compaction_step_release(&steps[i]);
diff --git a/repack.c b/repack.c
index 2ee6b51420a..571dabb665e 100644
--- a/repack.c
+++ b/repack.c
@@ -55,14 +55,18 @@ void pack_objects_args_release(struct pack_objects_args *args)
 }
 
 void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
-				  const char *base_name)
+				  const char *base_name,
+				  bool wrote_incremental_midx)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct odb_source *source = repo->objects->sources;
 	struct multi_pack_index *m = get_multi_pack_index(source);
 	strbuf_addf(&buf, "%s.pack", base_name);
-	if (m && source->local && midx_contains_pack(m, buf.buf))
+	if (m && source->local && midx_contains_pack(m, buf.buf)) {
 		clear_midx_file(repo);
+		if (!wrote_incremental_midx)
+			clear_incremental_midx_files(repo, NULL);
+	}
 	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
 	strbuf_release(&buf);
@@ -250,25 +254,63 @@ void existing_packs_mark_for_deletion(struct existing_packs *existing,
 					   &existing->cruft_packs);
 }
 
+/*
+ * Mark every pack that is referenced by the existing MIDX chain as
+ * retained, so that a subsequent call to
+ * existing_packs_mark_for_deletion() will not mark them for deletion.
+ *
+ * This is used when writing an incremental MIDX layer on top of an
+ * existing chain: retained layers continue to reference the same
+ * packs on disk, so those packs must not be unlinked even if the
+ * freshly-written pack supersedes them.
+ */
+void existing_packs_retain_midx_packs(struct existing_packs *existing)
+{
+	struct string_list_item *item;
+	struct strbuf buf = STRBUF_INIT;
+
+	for_each_string_list_item(item, &existing->midx_packs) {
+		struct string_list_item *found;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, item->string);
+		strbuf_strip_suffix(&buf, ".pack");
+		strbuf_strip_suffix(&buf, ".idx");
+
+		found = string_list_lookup(&existing->non_kept_packs, buf.buf);
+		if (found)
+			existing_packs_mark_retained(found);
+
+		found = string_list_lookup(&existing->cruft_packs, buf.buf);
+		if (found)
+			existing_packs_mark_retained(found);
+	}
+
+	strbuf_release(&buf);
+}
+
 static void remove_redundant_packs_1(struct repository *repo,
 				     struct string_list *packs,
-				     const char *packdir)
+				     const char *packdir,
+				     bool wrote_incremental_midx)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, packs) {
 		if (!existing_pack_is_marked_for_deletion(item))
 			continue;
-		repack_remove_redundant_pack(repo, packdir, item->string);
+		repack_remove_redundant_pack(repo, packdir, item->string,
+					     wrote_incremental_midx);
 	}
 }
 
 void existing_packs_remove_redundant(struct existing_packs *existing,
-				     const char *packdir)
+				     const char *packdir,
+				     bool wrote_incremental_midx)
 {
 	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs,
-				 packdir);
+				 packdir, wrote_incremental_midx);
 	remove_redundant_packs_1(existing->repo, &existing->cruft_packs,
-				 packdir);
+				 packdir, wrote_incremental_midx);
 }
 
 void existing_packs_release(struct existing_packs *existing)
diff --git a/repack.h b/repack.h
index 831ccfb1c6c..f9fbc895f02 100644
--- a/repack.h
+++ b/repack.h
@@ -34,7 +34,8 @@ void prepare_pack_objects(struct child_process *cmd,
 void pack_objects_args_release(struct pack_objects_args *args);
 
 void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
-				  const char *base_name);
+				  const char *base_name,
+				  bool wrote_incremental_midx);
 
 struct write_pack_opts {
 	struct pack_objects_args *po_args;
@@ -83,8 +84,10 @@ void existing_packs_retain_cruft(struct existing_packs *existing,
 				 struct packed_git *cruft);
 void existing_packs_mark_for_deletion(struct existing_packs *existing,
 				      struct string_list *names);
+void existing_packs_retain_midx_packs(struct existing_packs *existing);
 void existing_packs_remove_redundant(struct existing_packs *existing,
-				     const char *packdir);
+				     const char *packdir,
+				     bool wrote_incremental_midx);
 void existing_packs_release(struct existing_packs *existing);
 
 struct generated_pack;
@@ -129,7 +132,8 @@ struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry);
 void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 				    struct string_list *names,
 				    struct existing_packs *existing,
-				    const char *packdir);
+				    const char *packdir,
+				    bool wrote_incremental_midx);
 void pack_geometry_release(struct pack_geometry *geometry);
 
 struct tempfile;
diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5f..25f0d823d8e 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -951,6 +951,7 @@ integration_tests = [
   't7702-repack-cyclic-alternate.sh',
   't7703-repack-geometric.sh',
   't7704-repack-cruft.sh',
+  't7705-repack-incremental-midx.sh',
   't7800-difftool.sh',
   't7810-grep.sh',
   't7811-grep-open.sh',
diff --git a/t/t7705-repack-incremental-midx.sh b/t/t7705-repack-incremental-midx.sh
new file mode 100755
index 00000000000..9e317ff6e8f
--- /dev/null
+++ b/t/t7705-repack-incremental-midx.sh
@@ -0,0 +1,470 @@
+#!/bin/sh
+
+test_description='git repack --write-midx=incremental'
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
+# incrementally_repack N
+#
+# Make "N" new commits, each stored in their own pack, and then repacked
+# with the --write-midx=incremental strategy.
+incrementally_repack () {
+	for i in $(test_seq 1 "$1")
+	do
+		test_commit "$i" &&
+
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+		git multi-pack-index verify || return 1
+	done
+}
+
+# Create packs with geometrically increasing sizes so that they
+# satisfy the geometric progression and survive a --geometric=2
+# repack without being rolled up. Creates 3 packs containing 1,
+# 2, and 6 commits (3, 6, and 18 objects) respectively.
+create_geometric_packs () {
+	test_commit "small" &&
+	git repack -d &&
+
+	test_commit_bulk --message="medium" 2 &&
+	test_commit_bulk --message="large" 6 &&
+
+	git repack --geometric=2 -d --write-midx=incremental \
+		--write-bitmap-index
+}
+
+# create_layer <test_commit_bulk args>
+#
+# Creates a new MIDX layer with the contents of "test_commit_bulk $@".
+create_layer () {
+	test_commit_bulk "$@" &&
+
+	git multi-pack-index write --incremental --bitmap
+}
+
+# create_layers
+#
+# Reads lines of "<message> <nr>" from stdin and creates a new MIDX
+# layer for each line. See create_layer above for more.
+create_layers () {
+	while read msg nr
+	do
+		create_layer --message="$msg" "$nr" || return 1
+	done
+}
+
+test_expect_success '--write-midx=incremental requires --geometric' '
+	test_must_fail git repack --write-midx=incremental 2>err &&
+
+	test_grep -- "--write-midx=incremental requires --geometric" err
+'
+
+test_expect_success 'below layer threshold, tip packs excluded' '
+	git init below-layer-threshold-tip-packs-excluded &&
+	(
+		cd below-layer-threshold-tip-packs-excluded &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 4 &&
+		git config repack.midxsplitfactor 2 &&
+
+		# Create 3 packs forming a geometric progression by
+		# object count such that they are unmodified by the
+		# initial repack. The MIDX chain thusly contains a
+		# single layer with three packs.
+		create_geometric_packs &&
+		ls $packdir/pack-*.idx | sort >packs.before &&
+		test_line_count = 1 $midx_chain &&
+		cp $midx_chain $midx_chain.before &&
+
+		# Repack a new commit. Since the layer threshold is
+		# unmet, a new MIDX layer is added on top of the
+		# existing one.
+		test_commit extra &&
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+		git multi-pack-index verify &&
+
+		ls $packdir/pack-*.idx | sort >packs.after &&
+		comm -13 packs.before packs.after >packs.new &&
+		test_line_count = 1 packs.new &&
+
+		test_line_count = 2 "$midx_chain" &&
+		head -n 1 "$midx_chain.before" >expect &&
+		head -n 1 "$midx_chain" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'above layer threshold, tip packs repacked' '
+	git init above-layer-threshold-tip-packs-repacked &&
+	(
+		cd above-layer-threshold-tip-packs-repacked &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 2 &&
+		git config repack.midxsplitfactor 2 &&
+
+		# Same setup, but with the layer threshold set to 2.
+		# Since the tip MIDX layer meets that threshold, its
+		# packs are considered repack candidates.
+		create_geometric_packs &&
+		cp $midx_chain $midx_chain.before &&
+
+		# Perturb the existing progression such that it is
+		# rolled up into a single new pack, invalidating the
+		# existing MIDX layer and replacing it with a new one.
+		test_commit extra &&
+		git repack -d &&
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+
+		! test_cmp $midx_chain.before $midx_chain &&
+		test_line_count = 1 $midx_chain &&
+
+		git multi-pack-index verify
+	)
+'
+
+test_expect_success 'above layer threshold, tip layer preserved' '
+	git init above-layer-threshold-tip-layer-preserved &&
+	(
+		cd above-layer-threshold-tip-layer-preserved &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 2 &&
+		git config repack.midxsplitfactor 2 &&
+
+		test_commit_bulk --message="medium" 2 &&
+		test_commit_bulk --message="large" 6 &&
+
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+
+		test_line_count = 1 "$midx_chain" &&
+		ls $packdir/pack-*.idx | sort >packs.before &&
+		cp $midx_chain $midx_chain.before &&
+
+		# Create objects to form a pack satisfying the geometric
+		# progression (thus preserving the tip layer), but not
+		# so large that it meets the layer merging condition.
+		test_commit_bulk --message="small" 1 &&
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+
+		ls $packdir/pack-*.idx | sort >packs.after &&
+		comm -13 packs.before packs.after >packs.new &&
+
+		test_line_count = 1 packs.new &&
+		test_line_count = 3 packs.after &&
+		test_line_count = 2 "$midx_chain" &&
+		head -n 1 "$midx_chain.before" >expect &&
+		head -n 1 "$midx_chain" >actual &&
+		test_cmp expect actual &&
+
+		git multi-pack-index verify
+	)
+'
+
+test_expect_success 'above layer threshold, tip packs preserved' '
+	git init above-layer-threshold-tip-packs-preserved &&
+	(
+		cd above-layer-threshold-tip-packs-preserved &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 2 &&
+		git config repack.midxsplitfactor 2 &&
+
+		create_geometric_packs &&
+		ls $packdir/pack-*.idx | sort >packs.before &&
+		cp $midx_chain $midx_chain.before &&
+
+		# Same setup as above, but this time the new objects do
+		# not satisfy the new layer merging condition, resulting
+		# in a new tip layer.
+		test_commit_bulk --message="huge" 18 &&
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+
+		ls $packdir/pack-*.idx | sort >packs.after &&
+		comm -13 packs.before packs.after >packs.new &&
+
+		! test_cmp $midx_chain.before $midx_chain &&
+		test_line_count = 1 $midx_chain &&
+		test_line_count = 1 packs.new &&
+
+		git multi-pack-index verify
+	)
+'
+
+test_expect_success 'new tip absorbs multiple layers' '
+	git init new-tip-absorbs-multiple-layers &&
+	(
+		cd new-tip-absorbs-multiple-layers &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 1 &&
+		git config repack.midxsplitfactor 2 &&
+
+		# Build a 4-layer chain where each layer is too small to
+		# absorb the one below it. The sizes must satisfy L(n) <
+		# L(n-1)/2 for each adjacent pair:
+		#
+		#   L0 (oldest): 75 obj (25 commits)
+		#   L1:          21 obj  (7 commits, 21 < 75/2)
+		#   L2:           9 obj  (3 commits,  9 < 21/2)
+		#   L3 (tip):     3 obj  (1 commit,   3 <  9/2)
+		create_layers <<-\EOF &&
+		L0 25
+		L1 7
+		L2 3
+		L3 1
+		EOF
+
+		test_line_count = 4 "$midx_chain" &&
+		cp $midx_chain $midx_chain.before &&
+
+		# Now add a new commit. The merging condition is
+		# satisfied between L3-L1, but violated at L0, which is
+		# too large relative to the accumulated size.
+		#
+		# As a result, the chain shrinks from 4 to 2 layers.
+		test_commit new &&
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+
+		! test_cmp $midx_chain.before $midx_chain &&
+		test_line_count = 2 "$midx_chain" &&
+		git multi-pack-index verify
+	)
+'
+
+test_expect_success 'compaction of older layers' '
+	git init compaction-of-older-layers &&
+	(
+		cd compaction-of-older-layers &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 1 &&
+		git config repack.midxsplitfactor 2 &&
+
+		# Build a chain with two small layers at the bottom
+		# and a larger barrier layer on top, producing a
+		# chain that violates the compaction invariant, since
+		# the two small layers would normally have been merged.
+		create_layers <<-\EOF &&
+		one 2
+		two 4
+		barrier 54
+		EOF
+
+		cp $midx_chain $midx_chain.before &&
+
+		# Running an incremental repack compacts the two
+		# small layers at the bottom of the chain as a
+		# separate step in the compaction plan.
+		test_commit another &&
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+
+		test_line_count = 2 "$midx_chain" &&
+		git multi-pack-index verify
+	)
+'
+
+test_expect_success 'geometric rollup with surviving tip packs' '
+	git init geometric-rollup-with-surviving-tip-packs &&
+	(
+		cd geometric-rollup-with-surviving-tip-packs &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 1 &&
+		git config repack.midxsplitfactor 2 &&
+
+		# Create a pack large enough to anchor the geometric
+		# progression when small packs are added alongside it.
+		create_layer --message="big" 5 &&
+
+		test_line_count = 1 "$midx_chain" &&
+		cp $midx_chain $midx_chain.before &&
+
+		# Repack a small number of objects such that the
+		# progression is unbothered. Note that the existing pack
+		# is considered a repack candidate as the new layer
+		# threshold is set to 1.
+		test_commit small-1 &&
+		git repack -d &&
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+
+		! test_cmp $midx_chain.before $midx_chain &&
+		cp $midx_chain $midx_chain.before
+	)
+'
+
+test_expect_success 'kept packs are excluded from repack' '
+	git init kept-packs-excluded-from-repack &&
+	(
+		cd kept-packs-excluded-from-repack &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 1 &&
+		git config repack.midxsplitfactor 2 &&
+
+		# Create two equal-sized packs, marking one as kept.
+		for i in A B
+		do
+			test_commit "$i" && git repack -d || return 1
+		done &&
+
+		keep=$(ls $packdir/pack-*.idx | head -n 1) &&
+		touch "${keep%.idx}.keep" &&
+
+		# The kept pack is excluded as a repacking candidate
+		# entirely, so no rollup occurs as there is only one
+		# non-kept pack. A new MIDX layer is written containing
+		# that pack.
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+
+		test-tool read-midx $objdir >actual &&
+		grep "^pack-.*\.idx$" actual >actual.packs &&
+		test_line_count = 1 actual.packs &&
+		test_grep ! "$keep" actual.packs &&
+
+		git multi-pack-index verify &&
+
+		# All objects (from both kept and non-kept packs)
+		# must still be accessible.
+		git fsck
+	)
+'
+
+test_expect_success 'incremental MIDX with --max-pack-size' '
+	git init incremental-midx-with--max-pack-size &&
+	(
+		cd incremental-midx-with--max-pack-size &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 1 &&
+		git config repack.midxsplitfactor 2 &&
+
+		create_layer --message="base" 1 &&
+
+		# Now add enough data that a small --max-pack-size will
+		# cause pack-objects to split its output. Create objects
+		# large enough to fill multiple packs.
+		test-tool genrandom foo 1M >big1 &&
+		test-tool genrandom bar 1M >big2 &&
+		git add big1 big2 &&
+		test_tick &&
+		git commit -a -m "big blobs" &&
+		git repack -d &&
+
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index --max-pack-size=1M &&
+
+		test_line_count = 1 "$midx_chain" &&
+		test-tool read-midx $objdir >actual &&
+		grep "^pack-.*\.idx$" actual >actual.packs &&
+		test_line_count -gt 1 actual.packs &&
+
+		git multi-pack-index verify
+	)
+'
+
+test_expect_success 'noop repack preserves valid MIDX chain' '
+	git init noop-repack-preserves-valid-midx-chain &&
+	(
+		cd noop-repack-preserves-valid-midx-chain &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 1 &&
+		git config repack.midxsplitfactor 2 &&
+
+		create_layer --message="base" 1 &&
+
+		git multi-pack-index verify &&
+		cp $midx_chain $midx_chain.before &&
+
+		# Running again with no new objects should not break
+		# the MIDX chain. It produces "Nothing new to pack."
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
+
+		test_cmp $midx_chain.before $midx_chain &&
+
+		git multi-pack-index verify &&
+		git fsck
+	)
+'
+
+test_expect_success 'repack -ad removes stale incremental chain' '
+	git init repack--ad-removes-stale-incremental-chain &&
+	(
+		cd repack--ad-removes-stale-incremental-chain &&
+
+		git config maintenance.auto false &&
+		git config repack.midxnewlayerthreshold 1 &&
+		git config repack.midxsplitfactor 2 &&
+
+		create_layers <<-\EOF &&
+		one 1
+		two 1
+		EOF
+
+		test_path_is_file $midx_chain &&
+		test_line_count = 2 $midx_chain &&
+
+		git repack -ad &&
+
+		test_path_is_missing $packdir/multi-pack-index &&
+		test_dir_is_empty $midxdir
+	)
+'
+
+test_expect_success 'repack rejects invalid midxSplitFactor' '
+	test_when_finished "rm -fr bad-split-factor" &&
+	git init bad-split-factor &&
+	(
+		cd bad-split-factor &&
+		test_commit base &&
+
+		for v in 0 1 -1
+		do
+			test_must_fail git -c repack.midxSplitFactor=$v \
+				repack -d --geometric=2 --write-midx=incremental 2>err &&
+			test_grep "invalid value for --midx-split-factor" err ||
+			return 1
+		done
+	)
+'
+
+test_expect_success 'repack rejects invalid midxNewLayerThreshold' '
+	test_when_finished "rm -fr bad-layer-threshold" &&
+	git init bad-layer-threshold &&
+	(
+		cd bad-layer-threshold &&
+		test_commit base &&
+
+		for v in 0 -1
+		do
+			test_must_fail git -c repack.midxNewLayerThreshold=$v \
+				repack -d --geometric=2 --write-midx=incremental 2>err &&
+			test_grep "invalid value for --midx-new-layer-threshold" err ||
+			return 1
+		done
+	)
+'
+
+test_done
-- 
2.54.0.175.g8bd0ec98dc3

