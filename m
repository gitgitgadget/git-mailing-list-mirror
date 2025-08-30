Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9C2E62CE
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589018; cv=none; b=Ojfmb3t5XRb2O+Zrt4RalJgXZoQnVtlzyGpQBFCfFyniDoUNAJeKWhQZCykZulqqVaHl5TGQNMgSmzGh0IgZagIa4o83sMUKnktHJ8EpeHqxHCh2WHpB8gjDMeOV5jVaHRr6dDey3ZV6LhCola9ZFrEoF0sGW1Lro0MJZwN9GJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589018; c=relaxed/simple;
	bh=yh3gqAmlWBO3dj5d5X8Sm8rRf/Hlla+qRxqTavFqnOg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Hutx7Kmn85YFTbrfJ4alAgYxLRh08JtwOkRoJF6BXMqJuoUXMoAb4PvR4oZRDqOcZpz1WmXnpY+rq2Qhech9IXArscZenit/xzhzHwPwnmz+I6xGfQgcTq6JMqA3Y4N6QQfLowLwgNKArIB3A4V3aqVvPrQYKKcCx/6N30FfIxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTFRpcn/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTFRpcn/"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70de9ffcfffso30450776d6.2
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756589016; x=1757193816; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuTKWm/rrStZbMRiCkQpsQFPQ54/3B+GPUFxMqHz7s4=;
        b=mTFRpcn/4ivf1xb0dpuX1nZ3nBD9/gdENHFNw8DsY+4m55f0V0s2QLb15kBiMvRpYW
         UJ3kMmfVOZzqr5Fi+xpyfskkuV70IJ41k7cSInqxKaLy2gh9SMwwdff79XVUQTPCrIeF
         ElZ29zoMYjQ6w/OOQmL+hxQixs7sDn62pnC/OK01rqRVZ2t2yOj7XOpvJpBTcIuGuJDk
         C69DGkcgF2rJBbDKJY2oNOiqdEBrMYxw8LhyyNktWKRioh1SMs1D4hakwV/MtFhrh0vv
         c6dzhvHg5zXdNl5+a5ohWlo63m7LJo/pv4UTsD4KFI7dm8GxrPXBBWpESDdW84/nhjZP
         VuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756589016; x=1757193816;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuTKWm/rrStZbMRiCkQpsQFPQ54/3B+GPUFxMqHz7s4=;
        b=IyjHmTf/5wb9H917uZHTegbNN1JfFy/rmILTX6ckTMlaCNJ3zi9clPEM1xPDDk7fcw
         mkePMd6WyLJQsygaDfmYLf3hsc8qdx7WNR5M7KbQ8tClPSSlSNAa2jE/qm8uCI+PcN/N
         2efIitiXJgDulFreOXDCLe5rj5JSz+5AFtsYGn6uZhV++Hd0L2vISggJRV50d9sLFC69
         VguUeSSnhVKKVcavWQFOnvlrPh9G2yCX32VFScTu8a7meLD6HJCjLFgb9JHrTKdyhQgV
         WTRJlAbuWKmGuckrTYnypuO4w6oNj9dnPwCTUxPIVk5ID10dz76aqpS9fL4VBI7pADCy
         /cnQ==
X-Gm-Message-State: AOJu0YwNLXJvrr8rH2GRZDFKWAJZbdsHPFmGo2ZhMVU5/We5anQcbmm+
	S5N7PsO+zjNCWth2e9F9Y53R6aj2V/PZ95TQqitJ8fI1Ptab2EmhMph4q+Kzb3GR
X-Gm-Gg: ASbGncvAq0YEXIy9TmnTv8twmTCD+5od9OVWBo1/aIz4C8ogks+1CutbXiRi8G3n9so
	28y1yyJBzU/vouyYBuGsaa2YFTd0GwnsqDT7c9prmR03+O90j0FCx+nHFlhtkXHnY2J6YBOWTrq
	0y+0C4lmT0RAHbJ+eIEmhGL/YefJmOJQ7y/iCbxD6DU5TE2adVMl+S+PZ5GFSBgxJMOV3AnGHVf
	buugcj99jLx4veg9TNQeSvSic9GrlE/t6dokVGCz9hVUENV9H7L/pn7p93VXnYoK3jEB1SYH1eY
	ycBlKLXUcDanKuawm6dEEjqBkRhHaZ3wpneAPmEf1Oyf/TKY/d0uZ1BoA+6HmsYfOibfOupUS3W
	vS3mPzYg7WGeTwRmsxNSibiZQ8Q==
X-Google-Smtp-Source: AGHT+IH1hcr6bkNwfpgTOW6BQ7g8yxmwn7SS9nteByQBRmaJ388TYnPE1sd9CA1nJitO1YJbPFGGow==
X-Received: by 2002:a05:6214:21cd:b0:709:9b8e:da0c with SMTP id 6a1803df08f44-70fac89a518mr30611916d6.44.1756589015641;
        Sat, 30 Aug 2025 14:23:35 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.103.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb2831b57sm11555386d6.47.2025.08.30.14.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 14:23:35 -0700 (PDT)
Message-Id: <35302f52285d98c3e7ed7ab4140b4721375bc8a3.1756589007.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 30 Aug 2025 21:23:26 +0000
Subject: [PATCH v2 5/6] midx-write: reenable signed comparison errors
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
index 1822268ce2..14a0947c46 100644
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
@@ -1038,7 +1036,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 {
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
-	uint32_t i, start_pack;
+	uint32_t start_pack;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct tempfile *incr;
@@ -1154,7 +1152,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	if (preferred_pack_name) {
 		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 
-		for (i = 0; i < ctx.nr; i++) {
+		for (size_t i = 0; i < ctx.nr; i++) {
 			if (!cmp_idx_or_pack_name(preferred_pack_name,
 						  ctx.info[i].pack_name)) {
 				ctx.preferred_pack_idx = i;
@@ -1186,7 +1184,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		 * pack-order has all of its objects selected from that pack
 		 * (and not another pack containing a duplicate)
 		 */
-		for (i = 1; i < ctx.nr; i++) {
+		for (size_t i = 1; i < ctx.nr; i++) {
 			struct packed_git *p = ctx.info[i].p;
 
 			if (!oldest->num_objects || p->mtime < oldest->mtime) {
@@ -1231,7 +1229,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	compute_sorted_entries(&ctx, start_pack);
 
 	ctx.large_offsets_needed = 0;
-	for (i = 0; i < ctx.entries_nr; i++) {
+	for (size_t i = 0; i < ctx.entries_nr; i++) {
 		if (ctx.entries[i].offset > 0x7fffffff)
 			ctx.num_large_offsets++;
 		if (ctx.entries[i].offset > 0xffffffff)
@@ -1241,10 +1239,10 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	QSORT(ctx.info, ctx.nr, pack_info_compare);
 
 	if (packs_to_drop && packs_to_drop->nr) {
-		int drop_index = 0;
+		size_t drop_index = 0;
 		int missing_drops = 0;
 
-		for (i = 0; i < ctx.nr && drop_index < packs_to_drop->nr; i++) {
+		for (size_t i = 0; i < ctx.nr && drop_index < packs_to_drop->nr; i++) {
 			int cmp = strcmp(ctx.info[i].pack_name,
 					 packs_to_drop->items[drop_index].string);
 
@@ -1275,7 +1273,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	 * pack_perm[old_id] = new_id
 	 */
 	ALLOC_ARRAY(ctx.pack_perm, ctx.nr);
-	for (i = 0; i < ctx.nr; i++) {
+	for (size_t i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].expired) {
 			dropped_packs++;
 			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = PACK_EXPIRED;
@@ -1284,7 +1282,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		}
 	}
 
-	for (i = 0; i < ctx.nr; i++) {
+	for (size_t i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].expired)
 			continue;
 		pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
@@ -1430,6 +1428,9 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	 * have been freed in the previous if block.
 	 */
 
+	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
+		die("too many multi-pack-indexes");
+
 	CALLOC_ARRAY(keep_hashes, ctx.num_multi_pack_indexes_before + 1);
 
 	if (ctx.incremental) {
@@ -1462,7 +1463,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
 			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
 
-		for (i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
+		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
 			keep_hashes[j] = xstrdup(hash_to_hex_algop(get_midx_checksum(m),
@@ -1470,7 +1471,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			m = m->base_midx;
 		}
 
-		for (i = 0; i < ctx.num_multi_pack_indexes_before + 1; i++)
+		for (uint32_t i = 0; i <= ctx.num_multi_pack_indexes_before; i++)
 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
 	} else {
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
@@ -1488,7 +1489,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			 ctx.incremental);
 
 cleanup:
-	for (i = 0; i < ctx.nr; i++) {
+	for (size_t i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].p) {
 			close_pack(ctx.info[i].p);
 			free(ctx.info[i].p);
@@ -1501,7 +1502,7 @@ cleanup:
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

