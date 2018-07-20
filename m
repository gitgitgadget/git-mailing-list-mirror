Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6051F597
	for <e@80x24.org>; Fri, 20 Jul 2018 15:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbeGTQ2q (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 12:28:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43366 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbeGTQ2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 12:28:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id m12-v6so2105219lfc.10
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujORwrPz72g9GSx5nitTzbKO9GVvM6qabpeWCiTj4v4=;
        b=jCLX31yG+Ftga7vjfE+pzV4Ox1DEVt5zHJ4pZhO3YjoovPYss6nkLxzqNIxwtq8iWU
         RZTCu0WLMuxQaoubcuQCjqhhQ6GkBV+0LR1ZbZHqQkiErsbNYw9zu2LKiq/xaXNgvwhB
         FcgPBvBMXRrLx/ev5QqEYLTnbKbEl+e97EbcgrgFbDItYOTNyvRv8QOaXNMslORRjeYX
         hqNBpgj7N87f9FlZxiJW6bWs2lYvx51A5YLSDR3gr/AxPaD/pbd1cucQAVKA9BqLOuLB
         gAmx8b1l/rR+OIWFT1aPx3XnUB4K0UPdqUavOCiI/pl5T5xwyP3v9POwMfBoVgjZ89Yq
         Cv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujORwrPz72g9GSx5nitTzbKO9GVvM6qabpeWCiTj4v4=;
        b=N+CWhAZz/e/MR6L6/evLcif2TWwOK3ObUeEhpUG2oExGzm3OwhpD+iFPl7jrBXoI0l
         MDgOfqAvmbHt+dvC8TxpSam4pt9Ng5/MqW4TFO8u0A+rdCBSla2R4Z8qm2rv3QHRrrqY
         /Lqj2S9lMHcNuouZyYQqtN2mQSkmj/C5/+Y3qziHduALdC9NzMV6b79Jd1IfQJrKMIQm
         nWt5bS1xT2DiTF4cORfKoPDYQkgOCWRZVGIfN3uLh113sOwD4TGowlKBSDead72G2itq
         LY69dVHedJFjzOX6K5jRJlLN+R5NkWrnuk4t+WTdJ86wtgNfhru3OwrZ+EZOHubacj8c
         +ifw==
X-Gm-Message-State: AOUpUlFrfGUusLUJNnzFrFbXoP8ZATmBEnrrJvlIHwuA5+dEUG5+2bRp
        K3CzZl3dVo0aaW1lm/8YAh8UMQF2
X-Google-Smtp-Source: AAOMgpcYqeXUclovjQ1eVvwBSSSCmlf+3CvaZy2j0binxT06EugNgh1+AJskmezvoxVCon2EdOrh5Q==
X-Received: by 2002:a19:6801:: with SMTP id d1-v6mr1819232lfc.8.1532101192443;
        Fri, 20 Jul 2018 08:39:52 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm414962lje.1.2018.07.20.08.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 08:39:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] pack-objects: fix performance issues on packing large deltas
Date:   Fri, 20 Jul 2018 17:39:43 +0200
Message-Id: <20180720153943.575-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718225110.17639-1-newren@gmail.com>
References: <20180718225110.17639-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's start with some background about oe_delta_size() and
oe_set_delta_size(). If you already know, skip the next paragraph.

These two are added in 0aca34e826 (pack-objects: shrink delta_size
field in struct object_entry - 2018-04-14) to help reduce 'struct
object_entry' size. The delta size field in this struct is reduced to
only contain max 2MB. So if any new delta is produced and larger than
2MB, it's dropped because we can't really save such a large size
anywhere. Fallback is provided in case existingpackfiles already have
large deltas, then we can retrieve it from the pack.

While this should help small machines repacking large repos (i.e. less
memory pressure), dropping large deltas during the delta selection
process could end up with worse pack files. And if existing packfiles
already have >2MB delta and pack-objects is instructed to not reuse
deltas, all of them will be dropped on the floor, and the resulting
pack would be definitely bigger.

There is also a regression in terms of CPU/IO if we have large on-disk
deltas because fallback code needs to parse the pack every time the
delta size is needed and just access to the mmap'd pack data is enough
for extra page faults when memory is under pressure.

Both of these issues were reported on the mailing list. Here's some
numbers for comparison.

    Version  Pack (MB)  MaxRSS(kB)  Time (s)
    -------  ---------  ----------  --------
     2.17.0     5498     43513628    2494.85
     2.18.0    10531     40449596    4168.94

This patch provides a better fallback that is

- cheaper in terms of cpu and io because we won't have to read
  existing pack files as much

- better in terms of pack size because the pack heuristics is back to
  2.17.0 time, we do not drop large deltas at all

If we encounter any delta (on-disk or created during try_delta phase)
that is larger than the 2MB limit, we stop using delta_size_ field for
this because it can't contain such size anyway. A new array of delta
size is dynamically allocated and can hold all the deltas that 2.17.0
can [1]. All current delta sizes are migrated over.

With this, we do not have to drop deltas in try_delta() anymore. Of
course the downside is we use slightly more memory, even compared to
2.17.0. But since this is considered an uncommon case, a bit more
memory consumption should not be a problem.

Delta size limit is also raised from 2MB to 32 MB to better cover
common case and avoid that extra memory consumption (99.999% deltas in
this reported repo are under 12MB). Other fields are shuffled around
to keep this struct packed tight. We don't use more memory in common
case even with this limit update.

A note about thread synchronization. Since this code can be run in
parallel during delta searching phase, we need a mutex. The realloc
part in packlist_alloc() is not protected because it only happens
during the object counting phase, which is always single-threaded.

The locking in oe_delta_size() could also be dropped if we make sure
the pack->delta_size pointer assignment in oe_set_delta_size() is
atomic. But let's keep the lock for now to be on the safe side. Lock
contention should not be that high for this lock.

[1] With a small tweak. 2.17.0 on 64-bit linux can hold 2^64 byte
    deltas, which is absolutely insane. But windows builds, even
    64-bit version, only hold 2^32. So reducing it to 2^32 should be
    quite safe.

Reported-by: Elijah Newren <newren@gmail.com>
Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I'm optimistic that the slowness on linux repo is lock contention
 (because if it's not then I have no clue what is). So let's start
 doing proper patches.

 If we want a quick fix for 2.18.1. I suggest bumping up
 OE_DELTA_SIZE_BITS like Elijah did in his second option. I don't
 think it's safe to fast track this patch.

 builtin/pack-objects.c    |  6 ++--
 ci/run-build-and-tests.sh |  1 +
 pack-objects.c            | 21 ++++++++++++
 pack-objects.h            | 68 +++++++++++++++++++++++++++++++--------
 t/README                  |  4 +++
 5 files changed, 82 insertions(+), 18 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ebc8cefb53..3bc182b1b6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2023,10 +2023,6 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
-	if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
-		free(delta_buf);
-		return 0;
-	}
 
 	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
@@ -2278,6 +2274,8 @@ static void init_threaded_search(void)
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
+	pthread_mutex_init(&to_pack.lock, NULL);
+	to_pack.lock_initialized = 1;
 	old_try_to_free_routine = set_try_to_free_routine(try_to_free_from_threads);
 }
 
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 4b04c75b7f..2a5bff4a1c 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -14,6 +14,7 @@ then
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
 	export GIT_TEST_OE_SIZE=10
+	export GIT_TEST_OE_DELTA_SIZE=5
 	make --quiet test
 fi
 
diff --git a/pack-objects.c b/pack-objects.c
index 92708522e7..eef344b7c1 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -88,6 +88,23 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 	return &pdata->objects[pdata->index[i] - 1];
 }
 
+uint32_t *new_delta_size_array(struct packing_data *pack)
+{
+	uint32_t *delta_size;
+	uint32_t i;
+
+	/*
+	 * nr_alloc, not nr_objects to align with realloc() strategy in
+	 * packlist_alloc()
+	 */
+	ALLOC_ARRAY(delta_size, pack->nr_alloc);
+
+	for (i = 0; i < pack->nr_objects; i++)
+		delta_size[i] = pack->objects[i].delta_size_;
+
+	return delta_size;
+}
+
 static void prepare_in_pack_by_idx(struct packing_data *pdata)
 {
 	struct packed_git **mapping, *p;
@@ -146,6 +163,8 @@ void prepare_packing_data(struct packing_data *pdata)
 
 	pdata->oe_size_limit = git_env_ulong("GIT_TEST_OE_SIZE",
 					     1U << OE_SIZE_BITS);
+	pdata->oe_delta_size_limit = git_env_ulong("GIT_TEST_OE_DELTA_SIZE",
+						   1U << OE_DELTA_SIZE_BITS);
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -160,6 +179,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 		if (!pdata->in_pack_by_idx)
 			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
+		if (pdata->delta_size)
+			REALLOC_ARRAY(pdata->delta_size, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
diff --git a/pack-objects.h b/pack-objects.h
index edf74dabdd..9f977ae800 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -2,6 +2,7 @@
 #define PACK_OBJECTS_H
 
 #include "object-store.h"
+#include "thread-utils.h"
 
 #define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
 
@@ -14,7 +15,7 @@
  * above this limit. Don't lower it too much.
  */
 #define OE_SIZE_BITS		31
-#define OE_DELTA_SIZE_BITS	20
+#define OE_DELTA_SIZE_BITS	24
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -93,12 +94,12 @@ struct object_entry {
 				     * uses the same base as me
 				     */
 	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
-	unsigned delta_size_valid:1;
+	unsigned char in_pack_header_size;
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_valid:1;
-	unsigned type_:TYPE_BITS;
 	unsigned no_try_delta:1;
+	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
@@ -108,17 +109,16 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
-	unsigned char in_pack_header_size;
 	unsigned depth:OE_DEPTH_BITS;
 
 	/*
 	 * pahole results on 64-bit linux (gcc and clang)
 	 *
-	 *   size: 80, bit_padding: 20 bits, holes: 8 bits
+	 *   size: 80, bit_padding: 9 bits
 	 *
 	 * and on 32-bit (gcc)
 	 *
-	 *   size: 76, bit_padding: 20 bits, holes: 8 bits
+	 *   size: 76, bit_padding: 9 bits
 	 */
 };
 
@@ -130,6 +130,7 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
+	uint32_t *delta_size;
 
 	/*
 	 * Only one of these can be non-NULL and they have different
@@ -140,10 +141,32 @@ struct packing_data {
 	struct packed_git **in_pack_by_idx;
 	struct packed_git **in_pack;
 
+#ifndef NO_PTHREADS
+	int lock_initialized;
+	pthread_mutex_t lock;
+#endif
+
 	uintmax_t oe_size_limit;
+	uintmax_t oe_delta_size_limit;
 };
 
 void prepare_packing_data(struct packing_data *pdata);
+
+static inline void packing_data_lock(struct packing_data *pdata)
+{
+#ifndef NO_PTHREADS
+	if (pdata->lock_initialized)
+		pthread_mutex_lock(&pdata->lock);
+#endif
+}
+static inline void packing_data_unlock(struct packing_data *pdata)
+{
+#ifndef NO_PTHREADS
+	if (pdata->lock_initialized)
+		pthread_mutex_unlock(&pdata->lock);
+#endif
+}
+
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
 				    uint32_t index_pos);
@@ -330,20 +353,37 @@ static inline void oe_set_size(struct packing_data *pack,
 static inline unsigned long oe_delta_size(struct packing_data *pack,
 					  const struct object_entry *e)
 {
-	if (e->delta_size_valid)
-		return e->delta_size_;
-	return oe_size(pack, e);
+	unsigned long size;
+
+	packing_data_lock(pack);
+	if (pack->delta_size)
+		size = pack->delta_size[e - pack->objects];
+	else
+		size = e->delta_size_;
+	packing_data_unlock(pack);
+	return size;
 }
 
+uint32_t *new_delta_size_array(struct packing_data *pdata);
 static inline void oe_set_delta_size(struct packing_data *pack,
 				     struct object_entry *e,
 				     unsigned long size)
 {
-	e->delta_size_ = size;
-	e->delta_size_valid = e->delta_size_ == size;
-	if (!e->delta_size_valid && size != oe_size(pack, e))
-		BUG("this can only happen in check_object() "
-		    "where delta size is the same as entry size");
+	packing_data_lock(pack);
+	if (!pack->delta_size && size < pack->oe_delta_size_limit) {
+		packing_data_unlock(pack);
+		e->delta_size_ = size;
+		return;
+	}
+	/*
+	 * We have had at least one delta size exceeding OE_DELTA_SIZE_BITS
+	 * limit. delta_size_ will not be used anymore. All delta sizes are
+	 * now from the delta_size[] array.
+	 */
+	if (!pack->delta_size)
+		pack->delta_size = new_delta_size_array(pack);
+	pack->delta_size[e - pack->objects] = size;
+	packing_data_unlock(pack);
 }
 
 #endif
diff --git a/t/README b/t/README
index 8373a27fea..9028b47d92 100644
--- a/t/README
+++ b/t/README
@@ -315,6 +315,10 @@ packs on demand. This normally only happens when the object size is
 over 2GB. This variable forces the code path on any object larger than
 <n> bytes.
 
+GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
+path where deltas larger than this limit require extra memory
+allocation for bookkeeping.
+
 Naming Tests
 ------------
 
-- 
2.18.0.rc2.476.g39500d3211

