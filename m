Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16A2F7F0F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524360; cv=none; b=pLqbeMz0Gh8TTleiewfQsq/0HuwWFMruXOiL91visD8lDsOiC1rtrJaCyevjdK6cdZvFHe9Wgai4UdUmeBxNy2pTKUeFHN4Q7gNNIVpWfG9eEoWwasej/2iBLkwiByjSsKSi8Q1fJnbNZ9pLIMPPrMeMyT2+hJuJcV/TSkgwvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524360; c=relaxed/simple;
	bh=EdXrh6jJKbPp+e1tLUHFDD3mnYslrJZNjGER4z6RT24=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DT00HFUmZeelitCVrEKMXcpwRPQMbb9xI2pNFSQ2/0PgzJlYa8crZqHqPzyeHwhhr+wU3Avd53WcNJuZyJyxrumvZ5qjBrP4bdIdlDtH/CJ1p+7lO6HX2c8/EyOX8LEKNFwYm2czmEInZ8fask9TzzJKcYFsBd401snbZktwFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWis3zMJ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWis3zMJ"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so31688886d6.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524358; x=1782129158; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjhhVXYn5PfAx7FoAYcRk4V7gNbvxK8p6qRVosKG2Vo=;
        b=BWis3zMJXyGz46AAauT6NoNvPYRNtID2MV49UJ5AokCMWZXTSAL0vqgM8iL6Ydpc7X
         jCgRg//DgCCyxDKY66eN2KuSk4/uehDW2gKCN2HqnyQzXZvYu5m5F/JczlHF6pMh/b4q
         11KJ1ZEfw+XHg0PTnEzG12KUT/9IsUU0f/S51owqLR6AzFloODT4ayGg57J0VMywcd2V
         tI4WLRBWvSji6y92dJZ+JAAvbT9Zv6AP7ovymOBZVS5PtyMXY1oiTgfZAIg6r70cRJtf
         iC2KDigv9MVqVnYmMP+G41Ru8qDitZiFtOWd5W9VawKBTtgRnl9nQA06l7zILLrIjzhM
         d/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524358; x=1782129158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qjhhVXYn5PfAx7FoAYcRk4V7gNbvxK8p6qRVosKG2Vo=;
        b=XV2FPCHzWNBRfKLvM9ti5wQDWz7B0wczUgHfJFXQSbIrA72VIiDh5j130Pyd9oKC33
         lPotzeVsnDQjACeCdbU3TPuWBdvbmpYK72R/rvH+ra+R4WAM3V9KrmH16Nnp+EtMoPzj
         sv/uUCO4Lnfisd2UWsM2h4658AZJLtMh4g24O3ub0myOLx8yookix/2I0buXulVLRGJp
         6JmphrlewvLENGcgWIsFDTzBL/mNabHqBMBaFlqwZB66wFrIFeNu3fFPevcY9DLYVITY
         y01+Qt6vy9tb+qgR9OFZOhbVpgDQhT6jWcw8jcdSURnVWlEM4W46yOogCq0OtxScITvC
         KG5A==
X-Gm-Message-State: AOJu0YwHZC+JxyfTHakYj9G5z46kfioYyrCwYwNrMDIMhoT1Zx8fsm7K
	ZcadbRsE6gAmkv70EGtDQ3xycXV4qigoy76D0f+kpUcM2f3dMzm0CClkgqYOLA==
X-Gm-Gg: Acq92OF9eMIZMQILsb101KRyweNM8udMxveZKrWZfYl0OnDp3VUAY0oHB02BJ+n/ble
	y1juHpd1ZTjsb7a4OkALHYf44RZbrHTDVDMcN4jxtcPN13J67iZtnc/4KdkuY0C7r0SeSKEt84f
	SZp9q1Meyi3OUptw2tMbNc5g5cjo5Q+kgKWv9E0wGaXncAkggTeyVZQ3F2ajJkpyj+EbUgvyfpV
	+DU2CZ/q+1t+/zrbxxHbQLLUqu3nvQVusdalwOat9AMinedX47TnNsNJxFu99HI75u8DeomAPtZ
	XEAoMG/Aeb+CVlB5N9Jv3cXL2Z4pgfGAbdvvr+tA+yNhjeJ8dvuB0C3748k1p8T31tBhnTQ2Ck+
	2rolnLpil0oXHkW/vAVSBhdZqdRQKXcHBwvhzk56F/HnibCfwfZhjq5CrnYg+3ujFcgRTU8S3U5
	38IGRaUgtpflnTp11yWRAuo5lKY5QGuMmtSqGhDQ==
X-Received: by 2002:a05:6214:3210:b0:8ce:e409:22c5 with SMTP id 6a1803df08f44-8d44f70bcb5mr185833486d6.22.1781524358297;
        Mon, 15 Jun 2026 04:52:38 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d304b5f833sm108657246d6.38.2026.06.15.04.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:52:37 -0700 (PDT)
Message-Id: <01b9209b26335c0c4744e7f76684f823eebb69a5.1781524349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
	<pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 11:52:27 +0000
Subject: [PATCH v2 5/7] pack-objects: use size_t for in-core object sizes
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`pack-objects` stores per-entry object sizes in either the 31-bit
`size_` member of the `struct object_entry` or, when the value does not
fit, the `pack->delta_size[]` spill array.  The accessors (`oe_size`,
`oe_delta_size`, `oe_get_size_slow`, `oe_size_*_than`) and the setters
(`oe_set_size`, `oe_set_delta_size`) used `unsigned long` for the spill
type, which on Windows means the spill silently caps at 4 GiB per entry.
That is what made `upload-pack` die with "object too large to read on
this platform" when serving the >4 GiB blob in `t5608` tests 5 and 6
when run with `GIT_TEST_CLONE_2GB`.

Widen them all to `size_t` (including `pack->delta_size`) and drop the
three `cast_size_t_to_ulong()` calls in `check_object()` that guarded
`in_pack_size`.  The two `SET_SIZE(entry, canonical_size)` calls in the
same function stay cast-free as before, since `canonical_size` is still
`unsigned long` until a later commit widens `object_info::sizep`.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 35 ++++++++++++++++++-----------------
 pack-objects.h         |  2 +-
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 56d1bb498d..961d547ef2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -66,8 +66,8 @@ static inline struct object_entry *oe_delta(
 		return &pack->objects[e->delta_idx - 1];
 }
 
-static inline unsigned long oe_delta_size(struct packing_data *pack,
-					  const struct object_entry *e)
+static inline size_t oe_delta_size(struct packing_data *pack,
+				   const struct object_entry *e)
 {
 	if (e->delta_size_valid)
 		return e->delta_size_;
@@ -83,11 +83,11 @@ static inline unsigned long oe_delta_size(struct packing_data *pack,
 	return pack->delta_size[e - pack->objects];
 }
 
-unsigned long oe_get_size_slow(struct packing_data *pack,
-			       const struct object_entry *e);
+size_t oe_get_size_slow(struct packing_data *pack,
+			const struct object_entry *e);
 
-static inline unsigned long oe_size(struct packing_data *pack,
-				    const struct object_entry *e)
+static inline size_t oe_size(struct packing_data *pack,
+			     const struct object_entry *e)
 {
 	if (e->size_valid)
 		return e->size_;
@@ -145,7 +145,7 @@ static inline void oe_set_delta_sibling(struct packing_data *pack,
 
 static inline void oe_set_size(struct packing_data *pack,
 			       struct object_entry *e,
-			       unsigned long size)
+			       size_t size)
 {
 	if (size < pack->oe_size_limit) {
 		e->size_ = size;
@@ -159,7 +159,7 @@ static inline void oe_set_size(struct packing_data *pack,
 
 static inline void oe_set_delta_size(struct packing_data *pack,
 				     struct object_entry *e,
-				     unsigned long size)
+				     size_t size)
 {
 	if (size < pack->oe_delta_size_limit) {
 		e->delta_size_ = size;
@@ -496,7 +496,7 @@ static void copy_pack_data(struct hashfile *f,
 
 static inline int oe_size_greater_than(struct packing_data *pack,
 				       const struct object_entry *lhs,
-				       unsigned long rhs)
+				       size_t rhs)
 {
 	if (lhs->size_valid)
 		return lhs->size_ > rhs;
@@ -2279,7 +2279,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		default:
 			/* Not a delta hence we've already got all we need. */
 			oe_set_type(entry, entry->in_pack_type);
-			SET_SIZE(entry, cast_size_t_to_ulong(in_pack_size));
+			SET_SIZE(entry, in_pack_size);
 			entry->in_pack_header_size = used;
 			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
@@ -2333,8 +2333,8 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		if (have_base &&
 		    can_reuse_delta(&base_ref, entry, &base_entry)) {
 			oe_set_type(entry, entry->in_pack_type);
-			SET_SIZE(entry, cast_size_t_to_ulong(in_pack_size)); /* delta size */
-			SET_DELTA_SIZE(entry, cast_size_t_to_ulong(in_pack_size));
+			SET_SIZE(entry, in_pack_size); /* delta size */
+			SET_DELTA_SIZE(entry, in_pack_size);
 
 			if (base_entry) {
 				SET_DELTA(entry, base_entry);
@@ -2357,7 +2357,8 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 			 * object size from the delta header.
 			 */
 			delta_pos = entry->in_pack_offset + entry->in_pack_header_size;
-			canonical_size = get_size_from_delta(p, &w_curs, delta_pos);
+			canonical_size = get_size_from_delta(p, &w_curs,
+							     delta_pos);
 			if (canonical_size == 0)
 				goto give_up;
 			SET_SIZE(entry, canonical_size);
@@ -2713,7 +2714,7 @@ static pthread_mutex_t progress_mutex;
 
 static inline int oe_size_less_than(struct packing_data *pack,
 				    const struct object_entry *lhs,
-				    unsigned long rhs)
+				    size_t rhs)
 {
 	if (lhs->size_valid)
 		return lhs->size_ < rhs;
@@ -2736,8 +2737,8 @@ static inline void oe_set_tree_depth(struct packing_data *pack,
  * reconstruction (so non-deltas are true object sizes, but deltas
  * return the size of the delta data).
  */
-unsigned long oe_get_size_slow(struct packing_data *pack,
-			       const struct object_entry *e)
+size_t oe_get_size_slow(struct packing_data *pack,
+			const struct object_entry *e)
 {
 	struct packed_git *p;
 	struct pack_window *w_curs;
@@ -2771,7 +2772,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 
 	unuse_pack(&w_curs);
 	packing_data_unlock(&to_pack);
-	return cast_size_t_to_ulong(size);
+	return size;
 }
 
 static int try_delta(struct unpacked *trg, struct unpacked *src,
diff --git a/pack-objects.h b/pack-objects.h
index 83299d4732..e97e84ddcb 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -141,7 +141,7 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
-	unsigned long *delta_size;
+	size_t *delta_size;
 
 	/*
 	 * Only one of these can be non-NULL and they have different
-- 
gitgitgadget

