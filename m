Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669ED18C2C
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508000; cv=none; b=XvHoIhtfbzQk77JRb16lZ/uINYXQePqbgJHIWWUduztcVmbvlKT27R/t/atpGNqv5f010AUZgQi69rt6cpa1NgjndJOz5pOLXw9ryWhwGYcG/Ozsh1uuIUNC/sJhcTO3zIFNw3lBfSG0EGpY/gNbeSSUXP1l0oVYNWB2v7kL5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508000; c=relaxed/simple;
	bh=Uwnfq/FdD/oFBGtaNi3jCokAmnO8kA4t6eS0yfkbtHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmArkhBKEY+nwGuMNTlHr29LGm/6seYrkCOxNR75PWeUl3RMeNxce4TzF5PTa0ABqnKISuWBZTFOvhZs4JCJIucBzhP6fACBXN4COHbtCwDZMEiR6cr95aWtyNYlq/0/C+EZrSgk5r90vH4XashhAVCmxTjPl2WjEtLPsKoEYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Nnm56mX1; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Nnm56mX1"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-79a7109f568so3962177b3.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777507998; x=1778112798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNPRX3jHmclMNmOlVHLFxMVO0CkNEvwoo4Ee51H1qAQ=;
        b=Nnm56mX1bVwJCrsndQTnFzSsiWnZAr/js6kH6aMnKYBeOKp+jDkaDAuWY0I9b6CS25
         k07cem+lDK41KxTWpypf/PRCrZ8nYt9PHrXMGwQKpwSp8jzzN+tHbAnkDDEU9iWEcD0r
         Dr17iGIN1ISaNhbRLeds8reVMomS4AqPJDfGgrzp9Iz8y9Jaj7sUZVoWFhWgp846zjbY
         oGwL3RzpSEB5Bq8if3ICQTMcYdGIlbReAM+9UCoVjnv3jnTDkZEF1/LjCcsbWd8wRUo7
         b3wa6gJm5IAhRr74OkhUYtxo6H9BsmoIyRqeLMmHEIjV1Gn748laH7i2yxY48pEn9KgU
         2hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777507998; x=1778112798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNPRX3jHmclMNmOlVHLFxMVO0CkNEvwoo4Ee51H1qAQ=;
        b=HMq2c88kNZN41WcNkwZaKZmF4tfpsgj67mdsfkarAvtqU1R2pY3FwJm22TM+9ArIdS
         s9nYA/JqEup+81u2xdBgMRMpixPsbGGp30HcZYCgD1ZMxtgRJlVGBvr/hOlEupBrkL8e
         xVy0rjQK2pm/0K3unkvprXrwASfXl1zFopxwH0s/J42b+iWktlE240sH5KtDwBOZVr/q
         2Z65q5KxG5m3FNiEZBc2XN0zXb8hhG1C78XQdK/1n8t5EuyJEDsy3k+ifjumRP96prZP
         wh/X+qmWVDV0CDi7pagzN25GDaBqrjBOat2oaBojxhv+9B692zVMu/dao1Cxrc3SaXxU
         bfYQ==
X-Gm-Message-State: AOJu0Yyx1OblyNXI4gxydLPOOjE8rQU3NAC1GytUhNKWRavABSkXw6oI
	L2UP5MYfrLU0UDuPi+cI0wq4nIsGxtDbrb5+/52yMT20VEueQYcTedVNRZklVvkmFUkIqYNWUkU
	qCztLARR4ZQJ3
X-Gm-Gg: AeBDietRumtHDqP9H+CfaIGtF2vuYT9SnLDEelJ8wjRFA509NssDr5guakKzMAPVyVy
	UdL0XJjeoDuPt4gYrZAV6Qu/RAASOYGjL/AYPdiezqq+CeogZRqDW4SDnmFcx87+5xyxUyeOFSG
	0OKeHl3CRxwIpxcmv3sU894fwkUODnU8tAVIi2rX3/3Bi3rY92hUOWKFmmSXluXpFPlLjtOmuA1
	IK9GMuZqJUcaR/R5uUJZpt2S1DH5uxibQ3/tJMtOIohl2GyD+uvzZnK3s7siBsDfLRRM2aPpAvD
	ri0Kt9Rupvt+TrSXUjjq1ToaBPrt6aRylaVm6nt/cVdxafd7qUe2dL75GM8FYTVsV12xsjyYdIt
	PwDlM5sN1vUZ9IfqxXwAmYNZSu0INAp2yB0KS7L+FFN9fDvYqZsE00HU/8AxMZNF+plsvcPvu91
	hd16HaSTvEQaVC78R3Fkj9SfvJx/Ry4z5iJ7+oOVpRqyga9ISeK25p1nSuU1xbbDaai5l0JUqpS
	d72sKIxFgnn4Rw1AUU7k7/2FeOrS1q7AzRv9++PL8fbU3Vlh+vaiKHfXTmABbI98IF7sBVxbtzh
	rz4Acf6X3X+u3wGh1jM1Whx+ews=
X-Received: by 2002:a05:690c:39a:b0:7b5:a17a:6f55 with SMTP id 00721157ae682-7bd52892ebcmr9665967b3.21.1777507998272;
        Wed, 29 Apr 2026 17:13:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd5512b818sm1488767b3.38.2026.04.29.17.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:17 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 04/16] midx: use `strvec` for `keep_hashes`
Message-ID: <42d76c7006096125a741faa7edb1286f5ea20612.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

The `keep_hashes` array in `write_midx_internal()` accumulates the
checksums of MIDX files that should be retained when pruning stale
entries from the MIDX chain. For similar reasons as in a previous
commit, rewrite this using a strvec, requiring us to pass one fewer
parameter.

Unlike the aforementioned previous commit, use a `strvec` instead of a
`string_list`, which provides a more ergonomic interface to adjust the
values at a particular index. The ordering is important here, as this
value is used to determine the contents of the resulting
`multi-pack-index-chain` file when writing with "--incremental".

Since the previous commit already builds the array in forward order, the
conversion is straightforward: replace indexed assignments with
`strvec_push()`, drop the pre-counting and `CALLOC_ARRAY()`, and
simplify cleanup via `strvec_clear()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 84 ++++++++++++++++++----------------------------------
 midx.c       | 20 ++++++-------
 2 files changed, 38 insertions(+), 66 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 55c778a97cb..5d9409a9741 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -29,8 +29,7 @@ extern void clear_midx_files_ext(struct odb_source *source, const char *ext,
 				 const char *keep_hash);
 extern void clear_incremental_midx_files_ext(struct odb_source *source,
 					     const char *ext,
-					     const char **keep_hashes,
-					     uint32_t hashes_nr);
+					     const struct strvec *keep_hashes);
 extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 				const char *idx_name);
 
@@ -1109,8 +1108,7 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 }
 
 static void clear_midx_files(struct odb_source *source,
-			     const char **hashes, uint32_t hashes_nr,
-			     unsigned incremental)
+			     const struct strvec *hashes, unsigned incremental)
 {
 	/*
 	 * if incremental:
@@ -1124,13 +1122,15 @@ static void clear_midx_files(struct odb_source *source,
 	 */
 	struct strbuf buf = STRBUF_INIT;
 	const char *exts[] = { MIDX_EXT_BITMAP, MIDX_EXT_REV, MIDX_EXT_MIDX };
-	uint32_t i, j;
+	uint32_t i;
 
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
-		clear_incremental_midx_files_ext(source, exts[i],
-						 hashes, hashes_nr);
-		for (j = 0; j < hashes_nr; j++)
-			clear_midx_files_ext(source, exts[i], hashes[j]);
+		clear_incremental_midx_files_ext(source, exts[i], hashes);
+		if (hashes) {
+			for (size_t j = 0; j < hashes->nr; j++)
+				clear_midx_files_ext(source, exts[i],
+						     hashes->v[j]);
+		}
 	}
 
 	if (incremental)
@@ -1267,8 +1267,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = -1;
-	const char **keep_hashes = NULL;
-	size_t keep_hashes_nr = 0;
+	struct strvec keep_hashes = STRVEC_INIT;
 	struct chunkfile *cf;
 
 	trace2_region_enter("midx", "write_midx_internal", r);
@@ -1708,32 +1707,12 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
 		die(_("too many multi-pack-indexes"));
 
-	if (ctx.compact) {
-		struct multi_pack_index *m;
-
-		/*
-		 * Keep all MIDX layers excluding those in the range [from, to].
-		 */
-		for (m = ctx.base_midx; m; m = m->base_midx)
-			keep_hashes_nr++;
-		for (m = ctx.m;
-		     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
-		     m = m->base_midx)
-			keep_hashes_nr++;
-
-		keep_hashes_nr++; /* include the compacted layer */
-	} else {
-		keep_hashes_nr = ctx.num_multi_pack_indexes_before + 1;
-	}
-	CALLOC_ARRAY(keep_hashes, keep_hashes_nr);
-
 	if (ctx.incremental) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
 		struct strbuf final_midx_name = STRBUF_INIT;
 		struct multi_pack_index *m = ctx.base_midx;
 		struct multi_pack_index **layers = NULL;
 		size_t layers_nr = 0, layers_alloc = 0;
-		size_t j = 0;
 
 		if (!chainf) {
 			error_errno(_("unable to open multi-pack-index chain file"));
@@ -1761,12 +1740,12 @@ static int write_midx_internal(struct write_midx_opts *opts)
 				layers[layers_nr++] = mp;
 			}
 			while (layers_nr)
-				keep_hashes[j++] =
-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
+				strvec_push(&keep_hashes,
+					    midx_get_checksum_hex(layers[--layers_nr]));
 
-			keep_hashes[j++] =
-				xstrdup(hash_to_hex_algop(midx_hash,
-							  r->hash_algo));
+			strvec_push(&keep_hashes,
+				    hash_to_hex_algop(midx_hash,
+						     r->hash_algo));
 
 			for (mp = ctx.m;
 			     mp && midx_hashcmp(mp, ctx.compact_to,
@@ -1776,31 +1755,29 @@ static int write_midx_internal(struct write_midx_opts *opts)
 				layers[layers_nr++] = mp;
 			}
 			while (layers_nr)
-				keep_hashes[j++] =
-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
+				strvec_push(&keep_hashes,
+					    midx_get_checksum_hex(layers[--layers_nr]));
 		} else {
 			for (; m; m = m->base_midx) {
 				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
 				layers[layers_nr++] = m;
 			}
 			while (layers_nr)
-				keep_hashes[j++] =
-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
+				strvec_push(&keep_hashes,
+					    midx_get_checksum_hex(layers[--layers_nr]));
 
-			keep_hashes[j++] =
-				xstrdup(hash_to_hex_algop(midx_hash,
-							  r->hash_algo));
+			strvec_push(&keep_hashes,
+				    hash_to_hex_algop(midx_hash,
+						     r->hash_algo));
 		}
 
-		ASSERT(j == keep_hashes_nr);
-
 		free(layers);
 
-		for (uint32_t i = 0; i < j; i++)
-			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
+		for (size_t i = 0; i < keep_hashes.nr; i++)
+			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
 	} else {
-		keep_hashes[ctx.num_multi_pack_indexes_before] =
-			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
+		strvec_push(&keep_hashes,
+			    hash_to_hex_algop(midx_hash, r->hash_algo));
 	}
 
 	if (ctx.m || ctx.base_midx)
@@ -1809,8 +1786,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(opts->source, keep_hashes, keep_hashes_nr,
-			 ctx.incremental);
+	clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
 	result = 0;
 
 cleanup:
@@ -1826,11 +1802,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	free(ctx.entries);
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
-	if (keep_hashes) {
-		for (uint32_t i = 0; i < keep_hashes_nr; i++)
-			free((char *)keep_hashes[i]);
-		free(keep_hashes);
-	}
+	strvec_clear(&keep_hashes);
 	strbuf_release(&midx_name);
 	close_midx(midx_to_free);
 
diff --git a/midx.c b/midx.c
index f75e3c9fa6d..bcb8c999015 100644
--- a/midx.c
+++ b/midx.c
@@ -12,6 +12,7 @@
 #include "chunk-format.h"
 #include "pack-bitmap.h"
 #include "pack-revindex.h"
+#include "strvec.h"
 
 #define MIDX_PACK_ERROR ((void *)(intptr_t)-1)
 
@@ -19,8 +20,7 @@ int midx_checksum_valid(struct multi_pack_index *m);
 void clear_midx_files_ext(struct odb_source *source, const char *ext,
 			  const char *keep_hash);
 void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
-				      char **keep_hashes,
-				      uint32_t hashes_nr);
+				      const struct strvec *keep_hashes);
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
@@ -799,22 +799,22 @@ void clear_midx_files_ext(struct odb_source *source, const char *ext,
 }
 
 void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
-				      char **keep_hashes,
-				      uint32_t hashes_nr)
+				      const struct strvec *keep_hashes)
 {
 	struct clear_midx_data data = {
 		.keep = STRSET_INIT,
 		.ext = ext,
 	};
 	struct strbuf buf = STRBUF_INIT;
-	uint32_t i;
 
-	for (i = 0; i < hashes_nr; i++) {
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "multi-pack-index-%s.%s", keep_hashes[i],
-			    ext);
+	if (keep_hashes) {
+		for (size_t i = 0; i < keep_hashes->nr; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "multi-pack-index-%s.%s",
+				    keep_hashes->v[i], ext);
 
-		strset_add(&data.keep, buf.buf);
+			strset_add(&data.keep, buf.buf);
+		}
 	}
 
 	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
-- 
2.54.0.16.g1c05dfce579

