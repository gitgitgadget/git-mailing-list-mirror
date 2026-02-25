Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166D022068D
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978929; cv=none; b=GxTfcJpaUG9GBStqLbcFqeyWO+AjYd56wa+ho8wiQK4RfXplzppmp77G8UMUJ3gZcIYndO8uMyXpsQUnx2hkMvkXYywvFGHaeq0soFXZTJ8J4vLjETPEkJ8kNbe/LGhXet+qgl4vpqJAr86pXZhVlnqU06EzrC4RiWueKduZ4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978929; c=relaxed/simple;
	bh=qQI1685rlo7hbhD5XWinJ5mwjFStAQAEHAhfixaRLWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLDmyg+xszOMsCMBc2PQzBUt57sVDz9KOUqoBGm7rIqzfSvMZ8sjtfg3SCOlnqRJQwftzpsi2EGCANL8z6AZaEPRw7hB5KpIdonat9CHUgX8FQbJ7WG+zVzn+oG6W+eIbfiMCQu8PKTGPj4dgNPap0VbnDtz/X35hsm3o5cHQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=TjIjC2KJ; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="TjIjC2KJ"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8954a050c19so77147996d6.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978926; x=1772583726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpfjrOsz1PmZDtCdeihB/P6WNgtsAjP3AbPDXxwHTdM=;
        b=TjIjC2KJurY2wOnquRD6hOb24wWbozWGJ+TjSgljCDcvWWRgUrRduS58AajzlAgISg
         L4cGT+b2pyefgKcjEdS/wXRpGKMXanvAMpLsMIrrHFWbG4unkHJV2WdM4TIGxWfPiCgN
         K4Gxlk95ajb84LXcjdm9jXVoKbvqOV+baQt4286XrE2ck2fVF/6QmYGgg/7xddnEzjjB
         5fwW1R7TDQAbDL0lVgGdkHiwfEJNWxmtdvOA4fVpHhkRJXM4C3drPhHBia/DUx+iHO3Z
         yRNYA3hDvBj646hJ2vjaXpDX/m5wkJWljFNlQa/AoEy4B2VGaUkT/PM3ns+Wmt0T6ZMl
         ak5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978926; x=1772583726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpfjrOsz1PmZDtCdeihB/P6WNgtsAjP3AbPDXxwHTdM=;
        b=xOVuQlBjiCuMCZ2BvifFT2lBxj737DsGvQMzjRx5GNFcKcSnzVsS3BulyhBxWkOsUz
         oizY5BQbrrVKaBMTUP2ykpSagDEcpkxdvJJtsOQUwvsEIiEkuclMkLvl9a9e8c3e+Gtv
         8NS888eZ1/VJiHTCUMVKaSUS7uThsbJrMBX1Cyna3BxPGtxTcVE7ztNfvlnuRvjDHC7M
         EjrrBQjaBaV+AIBRt4pLtdKPcERZe8yPyMAdTYaOzvO9YSpVGTPpfoWq5kXGWYHoX2/j
         wEDVdvJCVTW30MHo6fLa4h181qaibbWk7FKxQ/cHrbcGmmB9ca2o/SzTrF5rX7avhn2C
         l+eQ==
X-Gm-Message-State: AOJu0Yx9EV7qW8xYZHMBnEiOxmFXYJ1H73iG3adKMCyS6TccfAKU3sst
	HLguZJeZNOGaH5xADzZ1CMRtMKmFmBhj+LVBGoHLUQglAM5WXEGAyna7wgWr8smlgXzP8krsERX
	wsIBtzBo9w3md
X-Gm-Gg: ATEYQzwbY+gXajcS8NBQmVno4ky8BqPDTfV2jwra51YYnBfhnBYC6pb2RL/v14QxhWg
	Q580COGJEUA+lT+wjrT4oRTb1JTDi86nx7bHzwL3ONJdUmkFNNp7hY5qtktTDGqXniFoE9vf6oA
	VJSTAW5s14Lrc/2VaXuPOrtjeL/PjXB8iSGbSUU9LcIz3q3g9929ljA9rxvN3y4iq6TFlVG5JG8
	PpPhAaTrzjdks49RM6+QcdG77wayBgWE49EVgLyn+TVunAkkptEyhbzbItVgYRpAHiJg12S1ryM
	mJlO+OdJLIh7LBeQPyI6b81KwBqrrEh+XT+l/jiv9U35myeHtkp7XQLXnleU2o6Mb2Ps6viYAwa
	EbadVB9Z8hRoc9k/TUz0GNjJjAX5nZeL5w6YcJwWYDz4njxgptIokb7jevvmKOw1kObQq3JeVS0
	X8zeyliZA1wVFpkJAaqWHHK/aIrdZw7+OyzXkH4ade2CTkNAP/mPOyLSHpDax3B88v4ykkiHnDP
	lrDSQfHBA0DutfdyufH6fubD/1Bqw==
X-Received: by 2002:a05:6214:2a49:b0:895:1d59:5aa6 with SMTP id 6a1803df08f44-89979e6383amr189779086d6.24.1771978925369;
        Tue, 24 Feb 2026 16:22:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c8adf68sm102673176d6.20.2026.02.24.16.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:22:04 -0800 (PST)
Date: Tue, 24 Feb 2026 19:22:02 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 13/14] repack: introduce `--write-midx=incremental`
Message-ID: <27d15fd735df9c68e29372678b80b289f1ebca2a.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

Expose the incremental MIDX repacking mode (implemented in the previous
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
 builtin/repack.c                   |  38 ++-
 midx.c                             |  30 ++
 midx.h                             |   3 +
 repack-geometry.c                  |  13 +-
 repack-midx.c                      | 113 +++++++-
 repack.c                           |  21 +-
 repack.h                           |   9 +-
 t/meson.build                      |   1 +
 t/t7705-repack-incremental-midx.sh | 436 +++++++++++++++++++++++++++++
 11 files changed, 692 insertions(+), 29 deletions(-)
 create mode 100755 t/t7705-repack-incremental-midx.sh

diff --git a/Documentation/config/repack.adoc b/Documentation/config/repack.adoc
index e9e78dcb198..054de9f8795 100644
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
+layer. Defaults to 2.
+
+repack.midxNewLayerThreshold::
+	The minimum number of packs in the tip MIDX layer before those
+	packs are considered as candidates for geometric repacking
+	during `git repack --write-midx=incremental`.
++
+When the tip layer has fewer packs than this threshold, those packs are
+excluded from the geometric repack entirely, and are thus left
+unmodified. Defaults to 8.
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
index 3a5042491d6..9e070f35868 100644
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
 
@@ -42,9 +42,14 @@ static const char incremental_bitmap_conflict_error[] = N_(
 "--no-write-bitmap-index or disable the pack.writeBitmaps configuration."
 );
 
+#define DEFAULT_MIDX_SPLIT_FACTOR 2
+#define DEFAULT_MIDX_NEW_LAYER_THRESHOLD 8
+
 struct repack_config_ctx {
 	struct pack_objects_args *po_args;
 	struct pack_objects_args *cruft_po_args;
+	int midx_split_factor;
+	int midx_new_layer_threshold;
 };
 
 static int repack_config(const char *var, const char *value,
@@ -94,6 +99,16 @@ static int repack_config(const char *var, const char *value,
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
 
@@ -109,6 +124,8 @@ static int option_parse_write_midx(const struct option *opt, const char *arg,
 
 	if (!arg || !*arg)
 		*cfg = REPACK_WRITE_MIDX_DEFAULT;
+	else if (!strcmp(arg, "incremental"))
+		*cfg = REPACK_WRITE_MIDX_INCREMENTAL;
 	else
 		return error(_("unknown value for %s: %s"), opt->long_name, arg);
 
@@ -223,6 +240,8 @@ int cmd_repack(int argc,
 	memset(&config_ctx, 0, sizeof(config_ctx));
 	config_ctx.po_args = &po_args;
 	config_ctx.cruft_po_args = &cruft_po_args;
+	config_ctx.midx_split_factor = DEFAULT_MIDX_SPLIT_FACTOR;
+	config_ctx.midx_new_layer_threshold = DEFAULT_MIDX_NEW_LAYER_THRESHOLD;
 
 	repo_config(repo, repack_config, &config_ctx);
 
@@ -244,6 +263,9 @@ int cmd_repack(int argc,
 	if (pack_everything & PACK_CRUFT)
 		pack_everything |= ALL_INTO_ONE;
 
+	if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL && !geometry.split_factor)
+		die(_("--write-midx=incremental requires --geometric"));
+
 	if (write_bitmaps < 0) {
 		if (write_midx == REPACK_WRITE_MIDX_NONE &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
@@ -293,6 +315,10 @@ int cmd_repack(int argc,
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
@@ -540,6 +566,8 @@ int cmd_repack(int argc,
 			.show_progress = show_progress,
 			.write_bitmaps = write_bitmaps > 0,
 			.midx_must_contain_cruft = midx_must_contain_cruft,
+			.midx_split_factor = config_ctx.midx_split_factor,
+			.midx_new_layer_threshold = config_ctx.midx_new_layer_threshold,
 			.mode = write_midx,
 		};
 
@@ -552,11 +580,15 @@ int cmd_repack(int argc,
 
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
index 709fe7c3fd7..5f024d061e6 100644
--- a/midx.c
+++ b/midx.c
@@ -837,6 +837,36 @@ void clear_midx_file(struct repository *r)
 	strbuf_release(&midx);
 }
 
+void clear_incremental_midx_files(struct repository *r,
+				  const struct strvec *keep_hashes)
+{
+	struct strbuf chain = STRBUF_INIT;
+
+	get_midx_chain_filename(r->objects->sources, &chain);
+
+	if (r->objects) {
+		struct odb_source *source = r->objects->sources;
+		for (; source; source = source->next) {
+			if (source->packfiles->midx)
+				close_midx(source->packfiles->midx);
+			source->packfiles->midx = NULL;
+		}
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
index f211a38b9e7..b45da0a3144 100644
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
index d2065205f87..5b554da89f1 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -251,7 +251,8 @@ static void remove_redundant_packs(struct packed_git **pack,
 				   uint32_t pack_nr,
 				   struct string_list *names,
 				   struct existing_packs *existing,
-				   const char *packdir)
+				   const char *packdir,
+				   bool wrote_incremental_midx)
 {
 	const struct git_hash_algo *algop = existing->repo->hash_algo;
 	struct strbuf buf = STRBUF_INIT;
@@ -271,7 +272,8 @@ static void remove_redundant_packs(struct packed_git **pack,
 		    (string_list_has_string(&existing->kept_packs, buf.buf)))
 			continue;
 
-		repack_remove_redundant_pack(existing->repo, packdir, buf.buf);
+		repack_remove_redundant_pack(existing->repo, packdir, buf.buf,
+					     wrote_incremental_midx);
 	}
 
 	strbuf_release(&buf);
@@ -280,12 +282,13 @@ static void remove_redundant_packs(struct packed_git **pack,
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
index ad78a10378b..5da67f854c7 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -11,6 +11,7 @@
 #include "refs.h"
 #include "run-command.h"
 #include "tempfile.h"
+#include "trace2.h"
 
 struct midx_snapshot_ref_data {
 	struct repository *repo;
@@ -567,6 +568,9 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 	uint32_t i;
 	int ret = 0;
 
+	trace2_region_enter("repack", "make_midx_compaction_plan",
+			    opts->existing->repo);
+
 	odb_reprepare(opts->existing->repo->objects);
 	m = get_multi_pack_index(opts->existing->source);
 
@@ -578,6 +582,8 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 		}
 	}
 
+	trace2_region_enter("repack", "steps:write", opts->existing->repo);
+
 	/*
 	 * The first MIDX in the resulting chain is always going to be
 	 * new.
@@ -593,13 +599,16 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 	 * was *not* rewritten) or the old tip's base MIDX layer
 	 * (otherwise).
 	 */
-
 	step.type = MIDX_COMPACTION_STEP_WRITE;
 	string_list_init_nodup(&step.u.write);
 
 	for (i = 0; i < opts->names->nr; i++) {
 		strbuf_addf(&buf, "pack-%s.idx", opts->names->items[i].string);
 		string_list_append(&step.u.write, strbuf_detach(&buf, NULL));
+
+		trace2_data_string("repack", opts->existing->repo,
+				   "include:fresh",
+				   step.u.write.items[step.u.write.nr - 1].string);
 	}
 	for (i = 0; i < opts->geometry->split; i++) {
 		struct packed_git *p = opts->geometry->pack[i];
@@ -610,6 +619,9 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 
 		step.objects_nr += p->num_objects;
 	}
+	trace2_data_intmax("repack", opts->existing->repo,
+			   "include:fresh:objects_nr",
+			   (uintmax_t)step.objects_nr);
 
 	/*
 	 * Now handle any existing packs which were *not* rewritten.
@@ -638,8 +650,18 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 		strbuf_strip_suffix(&buf, ".pack");
 		strbuf_addstr(&buf, ".idx");
 
-		if (p->multi_pack_index && !opts->geometry->midx_tip_rewritten)
+		if (p->multi_pack_index &&
+		    !opts->geometry->midx_tip_rewritten) {
+			trace2_data_string("repack", opts->existing->repo,
+					   "exclude:unmodified", buf.buf);
 			continue;
+		}
+
+		trace2_data_string("repack", opts->existing->repo,
+				   "include:unmodified", buf.buf);
+		trace2_data_string("repack", opts->existing->repo,
+				   "include:unmodified:midx",
+				   p->multi_pack_index ? "true" : "false");
 
 		item = string_list_append(&step.u.write,
 					  strbuf_detach(&buf, NULL));
@@ -650,8 +672,12 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 			ret = error(_("too many objects in MIDX compaction step"));
 			goto out;
 		}
+
 		step.objects_nr += p->num_objects;
 	}
+	trace2_data_intmax("repack", opts->existing->repo,
+			   "include:unmodified:objects_nr",
+			   (uintmax_t)step.objects_nr);
 
 	/*
 	 * If the MIDX tip was rewritten, then we no longer consider it
@@ -661,6 +687,11 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 	if (opts->geometry->midx_tip_rewritten)
 		m = m->base_midx;
 
+	trace2_data_string("repack", opts->existing->repo, "midx:rewrote-tip",
+			   opts->geometry->midx_tip_rewritten ? "true" : "false");
+
+	trace2_region_enter("repack", "compact", opts->existing->repo);
+
 	/*
 	 * Compact additional MIDX layers into this proposed one until
 	 * the merging condition is violated.
@@ -668,12 +699,27 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 	while (m) {
 		uint32_t preferred_pack_idx;
 
+		trace2_data_string("repack", opts->existing->repo,
+				   "candidate", midx_get_checksum_hex(m));
+
 		if (step.objects_nr < m->num_objects / opts->midx_split_factor) {
 			/*
 			 * Stop compacting MIDX layer as soon as the
 			 * merged size is less than half the size of the
 			 * next layer in the chain.
 			 */
+			trace2_data_string("repack", opts->existing->repo,
+					   "compact", "violated");
+			trace2_data_intmax("repack", opts->existing->repo,
+					   "objects_nr",
+					   (uintmax_t)step.objects_nr);
+			trace2_data_intmax("repack", opts->existing->repo,
+					   "next_objects_nr",
+					   (uintmax_t)m->num_objects);
+			trace2_data_intmax("repack", opts->existing->repo,
+					   "split_factor",
+					   (uintmax_t)opts->midx_split_factor);
+
 			break;
 		}
 
@@ -693,6 +739,9 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 			strbuf_strip_suffix(&buf, ".pack");
 			strbuf_addstr(&buf, ".idx");
 
+			trace2_data_string("repack", opts->existing->repo,
+					   "midx:pack", buf.buf);
+
 			item = string_list_append(&step.u.write,
 						  strbuf_detach(&buf, NULL));
 			if (pack_int_id == preferred_pack_idx)
@@ -717,6 +766,16 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 		steps[steps_nr++] = step;
 	}
 
+	trace2_data_intmax("repack", opts->existing->repo,
+			   "step:objects_nr", (uintmax_t)step.objects_nr);
+	trace2_data_intmax("repack", opts->existing->repo,
+			   "step:packs_nr", (uintmax_t)step.u.write.nr);
+
+	trace2_region_leave("repack", "compact", opts->existing->repo);
+	trace2_region_leave("repack", "steps:write", opts->existing->repo);
+
+	trace2_region_enter("repack", "steps:rest", opts->existing->repo);
+
 	/*
 	 * Then start over, repeat, and either compact or keep as-is
 	 * each MIDX layer until we have exhausted the chain.
@@ -734,18 +793,29 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 		memset(&step, 0, sizeof(step));
 		step.type = MIDX_COMPACTION_STEP_UNKNOWN;
 
+		trace2_region_enter("repack", "step", opts->existing->repo);
+
+		trace2_data_string("repack", opts->existing->repo,
+				   "from", midx_get_checksum_hex(m));
+
 		while (next) {
-			struct multi_pack_index *base = next->base_midx;
 			uint32_t proposed_objects_nr;
-
 			if (unsigned_add_overflows(step.objects_nr, next->num_objects)) {
 				ret = error(_("too many objects in MIDX compaction step"));
+				trace2_region_leave("repack", "step", opts->existing->repo);
 				goto out;
 			}
 
 			proposed_objects_nr = step.objects_nr + next->num_objects;
 
-			if (!base) {
+			trace2_data_string("repack", opts->existing->repo,
+					   "proposed",
+					   midx_get_checksum_hex(next));
+			trace2_data_intmax("repack", opts->existing->repo,
+					   "proposed:objects_nr",
+					   (uintmax_t)next->num_objects);
+
+			if (!next->base_midx) {
 				/*
 				 * If we are at the end of the MIDX
 				 * chain, there is nothing to compact,
@@ -755,7 +825,7 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 				break;
 			}
 
-			if (proposed_objects_nr < base->num_objects / opts->midx_split_factor) {
+			if (proposed_objects_nr < next->base_midx->num_objects / opts->midx_split_factor) {
 				/*
 				 * If there is a MIDX following this
 				 * one, but our accumulated size is less
@@ -763,6 +833,13 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 				 * them would violate the merging
 				 * condition, so stop here.
 				 */
+
+				trace2_data_string("repack", opts->existing->repo,
+						   "compact:violated:at",
+						   midx_get_checksum_hex(next->base_midx));
+				trace2_data_intmax("repack", opts->existing->repo,
+						   "compact:violated:at:objects_nr",
+						   (uintmax_t)next->base_midx->num_objects);
 				break;
 			}
 
@@ -772,27 +849,43 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 			 * through the remainder of the chain.
 			 */
 			step.objects_nr = proposed_objects_nr;
-			next = base;
+			trace2_data_intmax("repack", opts->existing->repo,
+					   "step:objects_nr",
+					   (uintmax_t)step.objects_nr);
+			next = next->base_midx;
 		}
 
 		if (m == next) {
 			step.type = MIDX_COMPACTION_STEP_COPY;
 			step.u.copy = m;
+
+			trace2_data_string("repack", opts->existing->repo,
+					   "type", "copy");
 		} else {
 			step.type = MIDX_COMPACTION_STEP_COMPACT;
 			step.u.compact.from = next;
 			step.u.compact.to = m;
+
+			trace2_data_string("repack", opts->existing->repo,
+					   "to", midx_get_checksum_hex(m));
+			trace2_data_string("repack", opts->existing->repo,
+					   "type", "compact");
 		}
 
 		m = next->base_midx;
-
 		steps[steps_nr++] = step;
+		trace2_region_leave("repack", "step", opts->existing->repo);
 	}
 
+	trace2_region_leave("repack", "steps:rest", opts->existing->repo);
+
 out:
 	*steps_p = steps;
 	*steps_nr_p = steps_nr;
 
+	trace2_region_leave("repack", "make_midx_compaction_plan",
+			    opts->existing->repo);
+
 	return ret;
 }
 
@@ -801,6 +894,7 @@ static int write_midx_incremental(struct repack_write_midx_opts *opts)
 	struct midx_compaction_step *steps = NULL;
 	struct strbuf lock_name = STRBUF_INIT;
 	struct lock_file lf;
+	struct strvec keep_hashes = STRVEC_INIT;
 	size_t steps_nr = 0;
 	size_t i;
 	int ret = 0;
@@ -846,10 +940,13 @@ static int write_midx_incremental(struct repack_write_midx_opts *opts)
 			BUG("missing result for compaction step %"PRIuMAX,
 			    (uintmax_t)i);
 		fprintf(get_lock_file_fp(&lf), "%s\n", step->csum);
+		strvec_push(&keep_hashes, step->csum);
 	}
 
 	commit_lock_file(&lf);
 
+	clear_incremental_midx_files(opts->existing->repo, &keep_hashes);
+
 done:
 	strbuf_release(&lock_name);
 	free(steps);
diff --git a/repack.c b/repack.c
index 2ee6b51420a..be2cc0e9d44 100644
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
@@ -252,23 +256,26 @@ void existing_packs_mark_for_deletion(struct existing_packs *existing,
 
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
index 831ccfb1c6c..d2876f569a6 100644
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
@@ -84,7 +85,8 @@ void existing_packs_retain_cruft(struct existing_packs *existing,
 void existing_packs_mark_for_deletion(struct existing_packs *existing,
 				      struct string_list *names);
 void existing_packs_remove_redundant(struct existing_packs *existing,
-				     const char *packdir);
+				     const char *packdir,
+				     bool wrote_incremental_midx);
 void existing_packs_release(struct existing_packs *existing);
 
 struct generated_pack;
@@ -129,7 +131,8 @@ struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry);
 void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 				    struct string_list *names,
 				    struct existing_packs *existing,
-				    const char *packdir);
+				    const char *packdir,
+				    bool wrote_incremental_midx);
 void pack_geometry_release(struct pack_geometry *geometry);
 
 struct tempfile;
diff --git a/t/meson.build b/t/meson.build
index 2421220917a..4f7c7d5691d 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -941,6 +941,7 @@ integration_tests = [
   't7702-repack-cyclic-alternate.sh',
   't7703-repack-geometric.sh',
   't7704-repack-cruft.sh',
+  't7705-repack-incremental-midx.sh',
   't7800-difftool.sh',
   't7810-grep.sh',
   't7811-grep-open.sh',
diff --git a/t/t7705-repack-incremental-midx.sh b/t/t7705-repack-incremental-midx.sh
new file mode 100755
index 00000000000..f81c2c67060
--- /dev/null
+++ b/t/t7705-repack-incremental-midx.sh
@@ -0,0 +1,436 @@
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
+test_done
-- 
2.53.0.185.g29bc4dff628

