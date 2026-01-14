Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83669349B19
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420487; cv=none; b=f5VFUW3Qv9RU3CET2hDmxr1TIgpWnj2YpfUxkkuSZLm94kU2sLOm+/X7zIteGkl0jlu9rLfV8EeCJyBYrSUgJCS3JHz5gyxCmfUGf98KiThgNJ2SLA/qyDrthKc02//qZlPqpNg/gQEfCyWuE1zs+Wg7NRzCOZdsXiWeOsTAAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420487; c=relaxed/simple;
	bh=Tciw4/HonT8MOn1E45tJJ8GgIIS54YIaaxp88jHVqO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2iSTDgEWvItf7J5DpPjqWUw6POX9Cp+P9eThrDygp4s5uwfVrkr4Z5yoIQiz9CYcYD52weIrw8ozu9zKMtc9zg82J840S4DaIuyWs+rvDlChavEil1Nqk1pi0h8SRnQ19rYyYxMyZTIvhJCQnmkCJXzWxrpi0hTLTQrUWMTImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Svoby7p1; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Svoby7p1"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-790992528f6so1402927b3.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420484; x=1769025284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nTWrchs1liRkfhQe4I+Vp061KhGhHpnDbZ2xpq6XVwM=;
        b=Svoby7p1JiEfYuUrPXZnFC1a6HvZjcqHzylcgX9n854PcE9k50ipt6WC1zNI9En2+t
         bFYU9hKo8oF+znNgltsUGanAOLH1ArTw//zTaiM9AAYCPjzDcgUoxeN2mxzRk8qrq2gm
         2H/JHTRNUQV7KpuzRmjVkA/6xPZ8l+YybwkldJLGEXAXYwd+ywcMzC12rt8E6RgxNowc
         xdH8hwtOuSZDI9M6sCRwJ3bYo+QebuvpovWwN7G4t7VrKlqc9UNDWhR/L3wdvz/w6Vhx
         U2RKcAC/6SI4CMqbZBUESxHVpBkmA+9Kh8VDt/oW42Tizfa0CPnjamYUrkZMoqZyXgLi
         OsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420484; x=1769025284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTWrchs1liRkfhQe4I+Vp061KhGhHpnDbZ2xpq6XVwM=;
        b=Wps5Utlvp6UgM5//pHkQfJxOTd/tb+nUZuZ7ZwMlXbrKzmQgWfbRQu1K9xWxrLfluC
         lv2/UJtmZQrLxPU8bf3DJUbuHix6FhZ9sUibZ1Y6cjyMaCh9A4NIHbVin09+kFKupqhu
         W2q3QroMs7wDuYUiJc3Ro2tZcEbmFMOu2zEw43+uRln+fzmaHGPTgqUsIQ1gICeY4B3l
         RxJ2BUSqQfTCUaS4QAE6t2AtokeKS9aOpDciVIauBHQ9NTETv3XgOUN4gRYB047UnyMx
         pAKaGmxVe1F5JEyZfESzdDq18IWKkm/bbHfbixzPMgsgKfElM6jyLHfb6LXvXW45BWqu
         cmTA==
X-Gm-Message-State: AOJu0YzsrSD9pBNPNSkIO75zQM2jcz4i4S6KYl9XyQiFf0cY1jaXA7a0
	nedb3jZVL1C2utm0jbGr4Ji7/P8eofn3jtzzLOIOlFwhMUURP0wwvyNgd2rqvHm4ZZJ42KwmTpB
	03hFc1dC/lTz5
X-Gm-Gg: AY/fxX4bOty64XKCCywPUhLJ2gZK69xDDK+Mu2sVw46jvXcW8pnmYYmlVLuHK13bqyI
	taHRsi1+m1DuwDGWxBHpciXDIivDgnS3KnME1QK7RuFQfmvuex7DZA6HEV62IiQDtg4jg5a3Y8W
	4AxScXWwvXXaBSMbElP0z2HPSiRh9T3VC6Ix14JmJj231Y2jYQWCFs1oAi0dxOrMU2cZ/ri1+8d
	J25PPf2uoGY5WFZg8vDXOzkYJSscaoqwFxz9BPFFj/8T6Z8lliMocqZCU+NHhFZB/i2fyk3TMXi
	iJ/brLXTDFweUR06tb4S0gdL50XgARz8/HlxWj0P0wyoVDv/fhTBDxpXF+IJsEd5v92faZX+ybf
	supLX42UU+IsFvlXyZ6GDIbDPHwH3CcfjH4S15O2vGFL6u/RhF42NkBSiCtvFeXLOKPRyIOC6uO
	ytv6ZwzkylNG2qEAWKf0W9Es1XJSBrCPcKznhn2mjz8mlCaSnU/QDX3ydcrlR29/VkqwtzOI816
	hq9HBfclnKu/y9+hw==
X-Received: by 2002:a05:690e:4184:b0:644:60d9:864c with SMTP id 956f58d0204a3-64901b35e56mr3034975d50.91.1768420484098;
        Wed, 14 Jan 2026 11:54:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa58afa3sm93480657b3.22.2026.01.14.11.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:43 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/18] midx-write.c: introduce `struct write_midx_opts`
Message-ID: <af174e22e1e3c59956b5f554b3515bb4b3f2cdba.1768420450.git.me@ttaylorr.com>
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

In the MIDX writing code, there are four functions which perform some
sort of MIDX write operation. They are:

 - write_midx_file()
 - write_midx_file_only()
 - expire_midx_packs()
 - midx_repack()

All of these functions are thin wrappers over `write_midx_internal()`,
which implements the bulk of these routines. As a result, the
`write_midx_internal()` function takes six arguments.

Future commits in this series will want to add additional arguments, and
in general this function's signature will be the union of parameters
among *all* possible ways to write a MIDX.

Instead of adding yet more arguments to this function to support MIDX
compaction, introduce a `struct write_midx_opts`, which has the same
struct members as `write_midx_internal()`'s arguments.

Adding additional fields to the `write_midx_opts` struct is preferable
to adding additional arguments to `write_midx_internal()`. This is
because the callers below all zero-initialize the struct, so each time
we add a new piece of information, we do not have to pass the zero value
for it in all other call-sites that do not care about it.

For now, no functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 135 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 81 insertions(+), 54 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index da9c5a7c295..8a54644e427 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1078,14 +1078,20 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 	return needed;
 }
 
-static int write_midx_internal(struct odb_source *source,
-			       struct string_list *packs_to_include,
-			       struct string_list *packs_to_drop,
-			       const char *preferred_pack_name,
-			       const char *refs_snapshot,
-			       unsigned flags)
+struct write_midx_opts {
+	struct odb_source *source; /* non-optional */
+
+	struct string_list *packs_to_include;
+	struct string_list *packs_to_drop;
+
+	const char *preferred_pack_name;
+	const char *refs_snapshot;
+	unsigned flags;
+};
+
+static int write_midx_internal(struct write_midx_opts *opts)
 {
-	struct repository *r = source->odb->repo;
+	struct repository *r = opts->source->odb->repo;
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t start_pack;
@@ -1106,22 +1112,22 @@ static int write_midx_internal(struct odb_source *source,
 	trace2_region_enter("midx", "write_midx_internal", r);
 
 	ctx.repo = r;
-	ctx.source = source;
+	ctx.source = opts->source;
 
-	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
+	ctx.incremental = !!(opts->flags & MIDX_WRITE_INCREMENTAL);
 
 	if (ctx.incremental)
 		strbuf_addf(&midx_name,
 			    "%s/pack/multi-pack-index.d/tmp_midx_XXXXXX",
-			    source->path);
+			    opts->source->path);
 	else
-		get_midx_filename(source, &midx_name);
+		get_midx_filename(opts->source, &midx_name);
 	if (safe_create_leading_directories(r, midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
 
-	if (!packs_to_include || ctx.incremental) {
-		struct multi_pack_index *m = get_multi_pack_index(source);
+	if (!opts->packs_to_include || ctx.incremental) {
+		struct multi_pack_index *m = get_multi_pack_index(opts->source);
 		if (m && !midx_checksum_valid(m)) {
 			warning(_("ignoring existing multi-pack-index; checksum mismatch"));
 			m = NULL;
@@ -1136,7 +1142,7 @@ static int write_midx_internal(struct odb_source *source,
 			 */
 			if (ctx.incremental)
 				ctx.base_midx = m;
-			else if (!packs_to_include)
+			else if (!opts->packs_to_include)
 				ctx.m = m;
 		}
 	}
@@ -1149,7 +1155,7 @@ static int write_midx_internal(struct odb_source *source,
 	if (ctx.incremental) {
 		struct multi_pack_index *m = ctx.base_midx;
 		while (m) {
-			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
+			if (opts->flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
 				error(_("could not load reverse index for MIDX %s"),
 				      midx_get_checksum_hex(m));
 				goto cleanup;
@@ -1164,18 +1170,18 @@ static int write_midx_internal(struct odb_source *source,
 	start_pack = ctx.nr;
 
 	ctx.pack_paths_checked = 0;
-	if (flags & MIDX_PROGRESS)
+	if (opts->flags & MIDX_PROGRESS)
 		ctx.progress = start_delayed_progress(r,
 						      _("Adding packfiles to multi-pack-index"), 0);
 	else
 		ctx.progress = NULL;
 
-	ctx.to_include = packs_to_include;
+	ctx.to_include = opts->packs_to_include;
 
-	for_each_file_in_pack_dir(source->path, add_pack_to_midx, &ctx);
+	for_each_file_in_pack_dir(opts->source->path, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-	if (!packs_to_drop) {
+	if (!opts->packs_to_drop) {
 		/*
 		 * If there is no MIDX then either it doesn't exist, or we're
 		 * doing a geometric repack. Try to load it from the source to
@@ -1188,7 +1194,7 @@ static int write_midx_internal(struct odb_source *source,
 		if (midx && !midx_needs_update(midx, &ctx)) {
 			struct bitmap_index *bitmap_git;
 			int bitmap_exists;
-			int want_bitmap = flags & MIDX_WRITE_BITMAP;
+			int want_bitmap = opts->flags & MIDX_WRITE_BITMAP;
 
 			bitmap_git = prepare_midx_bitmap_git(midx);
 			bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
@@ -1200,7 +1206,7 @@ static int write_midx_internal(struct odb_source *source,
 				 * corresponding bitmap (or one wasn't requested).
 				 */
 				if (!want_bitmap)
-					clear_midx_files_ext(source, "bitmap", NULL);
+					clear_midx_files_ext(ctx.source, "bitmap", NULL);
 				result = 0;
 				goto cleanup;
 			}
@@ -1215,11 +1221,11 @@ static int write_midx_internal(struct odb_source *source,
 		goto cleanup; /* nothing to do */
 	}
 
-	if (preferred_pack_name) {
+	if (opts->preferred_pack_name) {
 		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 
 		for (size_t i = 0; i < ctx.nr; i++) {
-			if (!cmp_idx_or_pack_name(preferred_pack_name,
+			if (!cmp_idx_or_pack_name(opts->preferred_pack_name,
 						  ctx.info[i].pack_name)) {
 				ctx.preferred_pack_idx = i;
 				break;
@@ -1228,9 +1234,9 @@ static int write_midx_internal(struct odb_source *source,
 
 		if (ctx.preferred_pack_idx == NO_PREFERRED_PACK)
 			warning(_("unknown preferred pack: '%s'"),
-				preferred_pack_name);
+				opts->preferred_pack_name);
 	} else if (ctx.nr &&
-		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
+		   (opts->flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
 		struct packed_git *oldest = ctx.info[0].p;
 		ctx.preferred_pack_idx = 0;
 
@@ -1241,7 +1247,7 @@ static int write_midx_internal(struct odb_source *source,
 		 */
 		open_pack_index(oldest);
 
-		if (packs_to_drop && packs_to_drop->nr)
+		if (opts->packs_to_drop && opts->packs_to_drop->nr)
 			BUG("cannot write a MIDX bitmap during expiration");
 
 		/*
@@ -1303,20 +1309,21 @@ static int write_midx_internal(struct odb_source *source,
 
 	QSORT(ctx.info, ctx.nr, pack_info_compare);
 
-	if (packs_to_drop && packs_to_drop->nr) {
+	if (opts->packs_to_drop && opts->packs_to_drop->nr) {
 		size_t drop_index = 0;
 		int missing_drops = 0;
 
-		for (size_t i = 0; i < ctx.nr && drop_index < packs_to_drop->nr; i++) {
+		for (size_t i = 0;
+		     i < ctx.nr && drop_index < opts->packs_to_drop->nr; i++) {
 			int cmp = strcmp(ctx.info[i].pack_name,
-					 packs_to_drop->items[drop_index].string);
+					 opts->packs_to_drop->items[drop_index].string);
 
 			if (!cmp) {
 				drop_index++;
 				ctx.info[i].expired = 1;
 			} else if (cmp > 0) {
 				error(_("did not see pack-file %s to drop"),
-				      packs_to_drop->items[drop_index].string);
+				      opts->packs_to_drop->items[drop_index].string);
 				drop_index++;
 				missing_drops++;
 				i--;
@@ -1353,8 +1360,8 @@ static int write_midx_internal(struct odb_source *source,
 	}
 
 	/* Check that the preferred pack wasn't expired (if given). */
-	if (preferred_pack_name) {
-		struct pack_info *preferred = bsearch(preferred_pack_name,
+	if (opts->preferred_pack_name) {
+		struct pack_info *preferred = bsearch(opts->preferred_pack_name,
 						      ctx.info, ctx.nr,
 						      sizeof(*ctx.info),
 						      idx_or_pack_name_cmp);
@@ -1362,7 +1369,7 @@ static int write_midx_internal(struct odb_source *source,
 			uint32_t perm = ctx.pack_perm[preferred->orig_pack_int_id];
 			if (perm == PACK_EXPIRED)
 				warning(_("preferred pack '%s' is expired"),
-					preferred_pack_name);
+					opts->preferred_pack_name);
 		}
 	}
 
@@ -1376,15 +1383,15 @@ static int write_midx_internal(struct odb_source *source,
 	}
 
 	if (!ctx.entries_nr) {
-		if (flags & MIDX_WRITE_BITMAP)
+		if (opts->flags & MIDX_WRITE_BITMAP)
 			warning(_("refusing to write multi-pack .bitmap without any objects"));
-		flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
+		opts->flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
 	}
 
 	if (ctx.incremental) {
 		struct strbuf lock_name = STRBUF_INIT;
 
-		get_midx_chain_filename(source, &lock_name);
+		get_midx_chain_filename(opts->source, &lock_name);
 		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
 		strbuf_release(&lock_name);
 
@@ -1427,7 +1434,7 @@ static int write_midx_internal(struct odb_source *source,
 				MIDX_CHUNK_LARGE_OFFSET_WIDTH),
 			write_midx_large_offsets);
 
-	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP)) {
+	if (opts->flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP)) {
 		ctx.pack_order = midx_pack_order(&ctx);
 		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
 			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
@@ -1445,11 +1452,11 @@ static int write_midx_internal(struct odb_source *source,
 			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 
-	if (flags & MIDX_WRITE_REV_INDEX &&
+	if (opts->flags & MIDX_WRITE_REV_INDEX &&
 	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
 		write_midx_reverse_index(&ctx, midx_hash);
 
-	if (flags & MIDX_WRITE_BITMAP) {
+	if (opts->flags & MIDX_WRITE_BITMAP) {
 		struct packing_data pdata;
 		struct commit_stack commits = COMMIT_STACK_INIT;
 
@@ -1458,7 +1465,7 @@ static int write_midx_internal(struct odb_source *source,
 
 		prepare_midx_packing_data(&pdata, &ctx);
 
-		find_commits_for_midx_bitmap(&commits, refs_snapshot, &ctx);
+		find_commits_for_midx_bitmap(&commits, opts->refs_snapshot, &ctx);
 
 		/*
 		 * The previous steps translated the information from
@@ -1469,8 +1476,8 @@ static int write_midx_internal(struct odb_source *source,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr = 0;
 
-		if (write_midx_bitmap(&ctx, midx_hash, &pdata,
-				      commits.items, commits.nr, flags) < 0) {
+		if (write_midx_bitmap(&ctx, midx_hash, &pdata, commits.items,
+				      commits.nr, opts->flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			clear_packing_data(&pdata);
 			commit_stack_clear(&commits);
@@ -1503,7 +1510,7 @@ static int write_midx_internal(struct odb_source *source,
 		if (link_midx_to_chain(ctx.base_midx) < 0)
 			goto cleanup;
 
-		get_split_midx_filename_ext(source, &final_midx_name,
+		get_split_midx_filename_ext(opts->source, &final_midx_name,
 					    midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
@@ -1536,7 +1543,7 @@ static int write_midx_internal(struct odb_source *source,
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(source, keep_hashes,
+	clear_midx_files(opts->source, keep_hashes,
 			 ctx.num_multi_pack_indexes_before + 1,
 			 ctx.incremental);
 	result = 0;
@@ -1571,9 +1578,14 @@ int write_midx_file(struct odb_source *source,
 		    const char *preferred_pack_name,
 		    const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(source, NULL, NULL,
-				   preferred_pack_name, refs_snapshot,
-				   flags);
+	struct write_midx_opts opts = {
+		.source = source,
+		.preferred_pack_name = preferred_pack_name,
+		.refs_snapshot = refs_snapshot,
+		.flags = flags,
+	};
+
+	return write_midx_internal(&opts);
 }
 
 int write_midx_file_only(struct odb_source *source,
@@ -1581,8 +1593,15 @@ int write_midx_file_only(struct odb_source *source,
 			 const char *preferred_pack_name,
 			 const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(source, packs_to_include, NULL,
-				   preferred_pack_name, refs_snapshot, flags);
+	struct write_midx_opts opts = {
+		.source = source,
+		.packs_to_include = packs_to_include,
+		.preferred_pack_name = preferred_pack_name,
+		.refs_snapshot = refs_snapshot,
+		.flags = flags,
+	};
+
+	return write_midx_internal(&opts);
 }
 
 int expire_midx_packs(struct odb_source *source, unsigned flags)
@@ -1641,9 +1660,14 @@ int expire_midx_packs(struct odb_source *source, unsigned flags)
 
 	free(count);
 
-	if (packs_to_drop.nr)
-		result = write_midx_internal(source, NULL,
-					     &packs_to_drop, NULL, NULL, flags);
+	if (packs_to_drop.nr) {
+		struct write_midx_opts opts = {
+			.source = source,
+			.packs_to_drop = &packs_to_drop,
+			.flags = flags & MIDX_PROGRESS,
+		};
+		result = write_midx_internal(&opts);
+	}
 
 	string_list_clear(&packs_to_drop, 0);
 
@@ -1776,6 +1800,10 @@ int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
 	struct multi_pack_index *m = get_multi_pack_index(source);
+	struct write_midx_opts opts = {
+		.source = source,
+		.flags = flags,
+	};
 
 	/*
 	 * When updating the default for these configuration
@@ -1850,8 +1878,7 @@ int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
 		goto cleanup;
 	}
 
-	result = write_midx_internal(source, NULL, NULL, NULL, NULL,
-				     flags);
+	result = write_midx_internal(&opts);
 
 cleanup:
 	free(include_pack);
-- 
2.52.0.457.gb599f1ad4b0

