Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B151F597
	for <e@80x24.org>; Sun, 22 Jul 2018 08:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeGVJAV (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 05:00:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34019 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeGVJAV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 05:00:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id n96-v6so4370104lfi.1
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7WuGUkXY2QZmCb0tEFME7CtAewwU/uxITaaTTfkTg0=;
        b=sRqo0/qJAJxfeEPs8XCal3GlDugYwV6G/8urZgA84JeoUjIo3LHCCbTH49Rs0QSwly
         dJ1rJsWI7mb1k4lasheuXct+y+0/xh+QnpDhofwbSZ+f5NcCsoOf3iqXaMOVoBhLnGpk
         glO3jGRW6UJhAshQ9nRNvhCnTFR9lIghWxoyMp97yb7nSiQJm3r8BoDdK4yrshQQEdA1
         FQiXf5SmTozXFOciyroFkpyHDGiW/whgO7VvyTzpmPIcxvwzY5DeThCiPksInrexwyW4
         r234BYgBroUmXKohBZvjWIXJ53ukD8h1ZgmuVTWsXn0nIvVrgEU56zXtiDegea1kX5eF
         up/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7WuGUkXY2QZmCb0tEFME7CtAewwU/uxITaaTTfkTg0=;
        b=O8N5PjsdYDD9zTnlppboEsePMVuurD3syMHTGbN9YSnsjMm5Wz4XmkJBYt/bT69Vzm
         sokl5xo8pFtFuWSQ6JEZ5K0FHRBMwBnbYQnvwv+0757lTiBJci5+ivyF8bJtC265/Z76
         NWOJ6+3fNEq07vH3NgCiR0gEo9y0uL6NJtLcL+B0S/CBxnWzbQfLQk8S76vn5qVpkksZ
         CiNNf30jyABAVYiHC1ZatsA5YZBbDHKcpg6lzZWoTgGwkqF2gviBI0Uox3lhPdI0/3jZ
         0daPtv37Tlj1YvJwHC0rxv4T9do7sm12UXUZiR9m9r0RcnHeFytPZhqgOeZsVT6QJmOu
         7/KA==
X-Gm-Message-State: AOUpUlG6aMbSWS+VaPgbUVbVrB9Yy+grO+mznvy1T2TcAfUGvn11fJpP
        AEYqbl6SI/77iqq9Z4qhGaZXxUvY
X-Google-Smtp-Source: AAOMgpeyNMhsLOebvVzI3qGHQ1KqDBc5+XyUgGZYe61+XwBJCqvzkSKUaxuXG5l5y5ek9YqCZzg8iQ==
X-Received: by 2002:a19:14dc:: with SMTP id 89-v6mr4654538lfu.45.1532246668787;
        Sun, 22 Jul 2018 01:04:28 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 1-v6sm1239970ljd.11.2018.07.22.01.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 01:04:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] pack-objects: fix performance issues on packing large deltas
Date:   Sun, 22 Jul 2018 10:04:21 +0200
Message-Id: <20180722080421.12887-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
In-Reply-To: <20180720153943.575-1-pclouds@gmail.com>
References: <20180720153943.575-1-pclouds@gmail.com>
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
only contain max 1MB. So if any new delta is produced and larger than
1MB, it's dropped because we can't really save such a large size
anywhere. Fallback is provided in case existing packfiles already have
large deltas, then we can retrieve it from the pack.

While this should help small machines repacking large repos without
large deltas (i.e. less memory pressure), dropping large deltas during
the delta selection process could end up with worse pack files. And if
existing packfiles already have >1MB delta and pack-objects is
instructed to not reuse deltas, all of them will be dropped on the
floor, and the resulting pack would be definitely bigger.

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
that is larger than the 1MB limit, we stop using delta_size_ field for
this because it can't contain such size anyway. A new array of delta
size is dynamically allocated and can hold all the deltas that 2.17.0
can. This array only contains delta sizes that delta_size_ can't
contain.

With this, we do not have to drop deltas in try_delta() anymore. Of
course the downside is we use slightly more memory, even compared to
2.17.0. But since this is considered an uncommon case, a bit more
memory consumption should not be a problem.

Delta size limit is also raised from 1MB to 16MB to better cover
common case and avoid that extra memory consumption (99.999% deltas in
this reported repo are under 12MB; Jeff noted binary artifacts topped
out at about 3MB in some other private repos). Other fields are
shuffled around to keep this struct packed tight. We don't use more
memory in common case even with this limit update.

A note about thread synchronization. Since this code can be run in
parallel during delta searching phase, we need a mutex. The realloc
part in packlist_alloc() is not protected because it only happens
during the object counting phase, which is always single-threaded.

Access to e->delta_size_ (and by extension
pack->delta_size[e - pack->objects]) is unprotected as before, the
thread scheduler in pack-objects must make sure "e" is never updated
by two different threads.

The area under the new lock is as small as possible, avoiding locking
at all in common case, since lock contention with high thread count
could be expensive (most blobs are small enough that delta compute
time is short and we end up taking the lock very often). The previous
attempt to always hold a lock in oe_delta_size() and
oe_set_delta_size() increases execution time by 33% when repacking
linux.git with with 40 threads.

Reported-by: Elijah Newren <newren@gmail.com>
Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 should keep execution time back to 2.17.0 range (I never thought
 locks are that expensive..). Changes since v1:

 - oe_delta_size() and oe_set_delta_size() rewritten to keep locking
   to minimum. This also brings back delta_size_valid field so that
   we avoid accessing shared data as much as possible.
 - delta_size[] is now an array of unsigned long instead of uint32_t
   (i.e. 64-bit on linux, 32-bit on windows, like in 2.17.0)
 - delta size limit is reduced to 16 MB
 - lock_initialized field is removed

 builtin/pack-objects.c    |  5 +---
 ci/run-build-and-tests.sh |  1 +
 pack-objects.c            |  4 +++
 pack-objects.h            | 59 +++++++++++++++++++++++++++++++--------
 t/README                  |  4 +++
 5 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ebc8cefb53..a77659f9ce 100644
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
@@ -2278,6 +2274,7 @@ static void init_threaded_search(void)
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
+	pthread_mutex_init(&to_pack.lock, NULL);
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
index 92708522e7..6ef87e5683 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -146,6 +146,8 @@ void prepare_packing_data(struct packing_data *pdata)
 
 	pdata->oe_size_limit = git_env_ulong("GIT_TEST_OE_SIZE",
 					     1U << OE_SIZE_BITS);
+	pdata->oe_delta_size_limit = git_env_ulong("GIT_TEST_OE_DELTA_SIZE",
+						   1UL << OE_DELTA_SIZE_BITS);
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -160,6 +162,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 		if (!pdata->in_pack_by_idx)
 			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
+		if (pdata->delta_size)
+			REALLOC_ARRAY(pdata->delta_size, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
diff --git a/pack-objects.h b/pack-objects.h
index edf74dabdd..d9c144bf62 100644
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
+#define OE_DELTA_SIZE_BITS	23
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -94,11 +95,12 @@ struct object_entry {
 				     */
 	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
 	unsigned delta_size_valid:1;
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
@@ -108,17 +110,16 @@ struct object_entry {
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
 
@@ -130,6 +131,7 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
+	unsigned long *delta_size;
 
 	/*
 	 * Only one of these can be non-NULL and they have different
@@ -140,10 +142,29 @@ struct packing_data {
 	struct packed_git **in_pack_by_idx;
 	struct packed_git **in_pack;
 
+#ifndef NO_PTHREADS
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
+	pthread_mutex_lock(&pdata->lock);
+#endif
+}
+static inline void packing_data_unlock(struct packing_data *pdata)
+{
+#ifndef NO_PTHREADS
+	pthread_mutex_unlock(&pdata->lock);
+#endif
+}
+
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const unsigned char *sha1,
 				    uint32_t index_pos);
@@ -332,18 +353,34 @@ static inline unsigned long oe_delta_size(struct packing_data *pack,
 {
 	if (e->delta_size_valid)
 		return e->delta_size_;
-	return oe_size(pack, e);
+
+	/*
+	 * pack->detla_size[] can't be NULL because oe_set_delta_size()
+	 * must have been called when a new delta is saved with
+	 * oe_set_delta().
+	 * If oe_delta() returns NULL (i.e. default state, which means
+	 * delta_size_valid is also false), then the caller must never
+	 * call oe_delta_size().
+	 */
+	return pack->delta_size[e - pack->objects];
 }
 
 static inline void oe_set_delta_size(struct packing_data *pack,
 				     struct object_entry *e,
 				     unsigned long size)
 {
-	e->delta_size_ = size;
-	e->delta_size_valid = e->delta_size_ == size;
-	if (!e->delta_size_valid && size != oe_size(pack, e))
-		BUG("this can only happen in check_object() "
-		    "where delta size is the same as entry size");
+	if (size < pack->oe_delta_size_limit) {
+		e->delta_size_ = size;
+		e->delta_size_valid = 1;
+	} else {
+		packing_data_lock(pack);
+		if (!pack->delta_size)
+			ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
+		packing_data_unlock(pack);
+
+		pack->delta_size[e - pack->objects] = size;
+		e->delta_size_valid = 0;
+	}
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
2.18.0.656.gda699b98b3

