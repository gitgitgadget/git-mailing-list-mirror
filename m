Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3833CEB7
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402805; cv=none; b=j4nM+rlgzri+lvE1x6FVGrqOQCsGbQD/2Gorf9K8Z9VjpDk77tL26q6jFx71/9vAn3+kW63pvb3PB83BJB5ao+maEXUIoVdiKINkCCJghTX7JhNQYh988vGIGXvNwt8qrJ4UlFNcLxhqr6uifTmLZ0El8DpY/0R/++5Bh2tdUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402805; c=relaxed/simple;
	bh=HAiydJh+t8yvjZy4DOvKSaHpH7vhyiH7nbuqdq2STbE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MTPNUj43Rel/MZwjtKOVmrryJQ4dnDFy76VO1qT1pUsQA+TzeNNC87K/5hpCzyErGe6nlM/g2NjCvKHSi4m5qX/rWyLoTWllM9211dp3tCsjFBDEDiX89DOvap2SQrlQkWXRPBIygQpXkHL+pogf8nR388zniA+guA/5I8GOF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUaTazPf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUaTazPf"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c4af9eso10215491cf.3
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756402802; x=1757007602; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MROEH+g+wvQGNHerC0aOWa1cPUKd3GbXuA7Nbdw+a7c=;
        b=CUaTazPfK5bTd12OUO23GeEO6LQ1199ViTEV+WO6mLrpRN9JZoSGF00vJQJqn1nJlT
         b7LslIviao9DRWFDBQewCoGs5J5tDUISUi6kEhnpoyek6R+uhzAzPDCAJDSyeVwvzQfJ
         VWPOAeqmnogRzi06mEZSxgsT7srDT9BGCwiA68BfJ9QJMfkeSIGxPmsd7Um+Sl69LErL
         vIUepgMHiRK21ySkpQugSe7QsKnf0/RzqNTp1KisnDxZXeB2sSIdqtQ7QcDrR5AQ1V+J
         ow64npW3cxISQbCvvu+31QdbhRd+YZp33ejgsjSllUiJDD4XxFzvmXcZwtksm9a3oUg7
         tE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756402802; x=1757007602;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MROEH+g+wvQGNHerC0aOWa1cPUKd3GbXuA7Nbdw+a7c=;
        b=YQgRGwj0PLmj1ftIY5w3xA5PVZqV2JrRTeh4Sq5hL9wf7gmnc9nUSwxF5SKO6/cTPZ
         fEkXYK/vztuFLHiyOYCSrl9cyFFCaf9yFjdiHDciWDZJV09pStdG83sWAc++l/N7CWD6
         1YaTEu5QIPCbXRzPn1cAgnfKIxS/c+2f8wqMASjF3orR5sgcM3lB3Fm+P5oUvvOFMBJ2
         gH6oE1PKxFWGTomeUuGW2WtwLYQXahBpXQn6ArRp62FbFTE0b6mS8EGP8IUysGwjAbTu
         EO1Bumh7YTG9tbcuy92RJhlBt7eHBUD005ojDAbBme262IgNdlkmXq8vtQ9EXfpyxgjf
         cyNA==
X-Gm-Message-State: AOJu0YyGlrCadygTQjQuJ4zHtg0gsqkj3Kuf8eph+b49ItvZggT62+rV
	hWtWCwVmbFRXe8kRduC2cUZozTZH/wo8kvg6JAYWsFIeLr3ZOMZ4Ui/o/G3VyL1A
X-Gm-Gg: ASbGncu1H9ouaTFldCYiicPGDMPxL6AZKhP4oeZ/MqwHBafq2I+owWYPoaDjFjeiaiz
	5agHR7u8BfobJkHigY9v0snVljhIE1NpVb92FYsdVcl59lzReyi7Q5BSvXqNt8bskmDySwjD7Y/
	wB7kZHEeMgPoW9r0fQ0bhXnWjxbkFUT2iNzQFBnYoFJRMPHl+fv+5jJqdCdGnf9PEa9kdziUylW
	XB5IxTZ2u4jjOg4Fge2PrqG+HYKa+mVMMhmsDeKtip1nLlxbkAZWwiPsE3/3+E+84HaJxCFhFGY
	nHydMfV4iAwbIKnrvNogvXL5UtJeyz/89lJAd6IVhQxvTUX359VGE1V+IXNpbupenM15n5GMnvs
	ew0lvsb/7BnI3WVL8gff3wzIg
X-Google-Smtp-Source: AGHT+IEB1KKB79MKtJMAUgaJHZf5kVvtd/vUkfpxawzldOMGwAKkwYuRmT4dXH3+5NkBG+4r0na9xw==
X-Received: by 2002:a05:622a:4183:b0:4b2:d683:adc1 with SMTP id d75a77b69052e-4b2d683bdf3mr166105801cf.60.1756402802220;
        Thu, 28 Aug 2025 10:40:02 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.244.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0e507130sm21701785a.18.2025.08.28.10.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:40:01 -0700 (PDT)
Message-Id: <eb1abdca32c64cdabbc92008bf318c7ed67b2c1f.1756402795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 17:39:55 +0000
Subject: [PATCH 5/5] midx-write: reenable signed comparison errors
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Remove the remaining signed comparison warnings in midx-write.c so that
they can be enforced as errors in the future. After the previous change,
the remaining errors are due to iterator variables named 'i'.

The strategy here involves defining the variable within the for loop
syntax to make sure we use the appropriate bitness for the loop
sentinel. This matters in at least one method where the variable was
compared to uint32_t in some loops and size_t in others.

While adjusting these loops, there were some where the loop boundary was
checking against a uint32_t value _plus one_. These were replaced with
non-strict comparisons, but also the value is checked to not be
UINT32_MAX. Since the value is the number of incremental multi-pack-
indexes, this is not a meaningful restriction. The new die() is about
defensive programming more than it being realistically possible.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index ea1b3a199c..93f33e5baa 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
@@ -845,7 +843,7 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 			     uint32_t commits_nr,
 			     unsigned flags)
 {
-	int ret, i;
+	int ret;
 	uint16_t options = 0;
 	struct bitmap_writer writer;
 	struct pack_idx_entry **index;
@@ -873,7 +871,7 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 	 * this order).
 	 */
 	ALLOC_ARRAY(index, pdata->nr_objects);
-	for (i = 0; i < pdata->nr_objects; i++)
+	for (uint32_t i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
 	bitmap_writer_init(&writer, ctx->repo, pdata,
@@ -894,7 +892,7 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 	 * happens between bitmap_writer_build_type_index() and
 	 * bitmap_writer_finish().
 	 */
-	for (i = 0; i < pdata->nr_objects; i++)
+	for (uint32_t i = 0; i < pdata->nr_objects; i++)
 		index[ctx->pack_order[i]] = &pdata->objects[i].idx;
 
 	bitmap_writer_select_commits(&writer, commits, commits_nr);
@@ -1040,7 +1038,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 {
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
-	uint32_t i, start_pack;
+	uint32_t start_pack;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct tempfile *incr;
@@ -1156,7 +1154,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	if (preferred_pack_name) {
 		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 
-		for (i = 0; i < ctx.nr; i++) {
+		for (size_t i = 0; i < ctx.nr; i++) {
 			if (!cmp_idx_or_pack_name(preferred_pack_name,
 						  ctx.info[i].pack_name)) {
 				ctx.preferred_pack_idx = i;
@@ -1181,7 +1179,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		 * pack-order has all of its objects selected from that pack
 		 * (and not another pack containing a duplicate)
 		 */
-		for (i = 1; i < ctx.nr; i++) {
+		for (size_t i = 1; i < ctx.nr; i++) {
 			struct packed_git *p = ctx.info[i].p;
 
 			if (!oldest->num_objects || p->mtime < oldest->mtime) {
@@ -1225,7 +1223,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	compute_sorted_entries(&ctx, start_pack);
 
 	ctx.large_offsets_needed = 0;
-	for (i = 0; i < ctx.entries_nr; i++) {
+	for (size_t i = 0; i < ctx.entries_nr; i++) {
 		if (ctx.entries[i].offset > 0x7fffffff)
 			ctx.num_large_offsets++;
 		if (ctx.entries[i].offset > 0xffffffff)
@@ -1235,10 +1233,10 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	QSORT(ctx.info, ctx.nr, pack_info_compare);
 
 	if (packs_to_drop && packs_to_drop->nr) {
-		int drop_index = 0;
+		size_t drop_index = 0;
 		int missing_drops = 0;
 
-		for (i = 0; i < ctx.nr && drop_index < packs_to_drop->nr; i++) {
+		for (size_t i = 0; i < ctx.nr && drop_index < packs_to_drop->nr; i++) {
 			int cmp = strcmp(ctx.info[i].pack_name,
 					 packs_to_drop->items[drop_index].string);
 
@@ -1269,7 +1267,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	 * pack_perm[old_id] = new_id
 	 */
 	ALLOC_ARRAY(ctx.pack_perm, ctx.nr);
-	for (i = 0; i < ctx.nr; i++) {
+	for (size_t i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].expired) {
 			dropped_packs++;
 			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = PACK_EXPIRED;
@@ -1278,7 +1276,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		}
 	}
 
-	for (i = 0; i < ctx.nr; i++) {
+	for (size_t i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].expired)
 			continue;
 		pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
@@ -1424,6 +1422,9 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	 * have been freed in the previous if block.
 	 */
 
+	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
+		die("too many multi-pack-indexes");
+
 	CALLOC_ARRAY(keep_hashes, ctx.num_multi_pack_indexes_before + 1);
 
 	if (ctx.incremental) {
@@ -1456,7 +1457,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
 			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
 
-		for (i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
+		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
 			keep_hashes[j] = xstrdup(hash_to_hex_algop(get_midx_checksum(m),
@@ -1464,7 +1465,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			m = m->base_midx;
 		}
 
-		for (i = 0; i < ctx.num_multi_pack_indexes_before + 1; i++)
+		for (uint32_t i = 0; i <= ctx.num_multi_pack_indexes_before; i++)
 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
 	} else {
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
@@ -1482,7 +1483,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			 ctx.incremental);
 
 cleanup:
-	for (i = 0; i < ctx.nr; i++) {
+	for (size_t i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].p) {
 			close_pack(ctx.info[i].p);
 			free(ctx.info[i].p);
@@ -1495,7 +1496,7 @@ cleanup:
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
 	if (keep_hashes) {
-		for (i = 0; i < ctx.num_multi_pack_indexes_before + 1; i++)
+		for (uint32_t i = 0; i <= ctx.num_multi_pack_indexes_before; i++)
 			free((char *)keep_hashes[i]);
 		free(keep_hashes);
 	}
-- 
gitgitgadget
