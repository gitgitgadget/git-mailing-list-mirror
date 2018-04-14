Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44991F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeDNPfu (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:50 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41893 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeDNPfn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id o102-v6so16362127lfg.8
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mo1XOv4DUQGDdHC6E+25RSqnmrWIECsQJVrdvTh9C/A=;
        b=YTXMqETMKBqUrLQBSbzGdOo8WN7f/DTM/KEWVBIYH1HqR/SJraHbC59NjnIucWRYgn
         6nJF2jrl8w4Ig3yaIoqKPTseIMYrJVN8K/i7NCQUyF60J9kFfVeQi95sFZPdzzcB1R+B
         dPhqqTHxJBsBq+YCLTHp2xl1Zzo+ryy8fVXsLHnXX5TiTtV+t8CAmYawmQJNa9dEK6DP
         V/ajqSdpnZZtEla3/atI2C7/20vvkn6GkcjSMulsOoUEB9tY99ADnUe9/V7nAPrFi5bT
         OMpSTjXtUzpmT0Hzja/iaxvxUWKCT5nUtj+iqd/AYN43AJ5+vIli8hyiVzyOvfvuEXe4
         4VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mo1XOv4DUQGDdHC6E+25RSqnmrWIECsQJVrdvTh9C/A=;
        b=s8XN1ztGQh/JJ+AfAM3m8ClnjUv++Vr4Bfr9Hp7oC0HIjgKSdX0VzJ77tf6I+X3irn
         RS6zqmu+c05cFDye3s1+VCzg1dCkfwx5IS9aUWiQ5hNakfl/Hvkaf7tNnVforuTFHJS9
         6VDGxx8SNwmYEgPyyoZciNBuEB4gtiGKgDc6s66U81zZl559uzqpcKt+BALN4z7xekMl
         azieGNKaHejQ5vwRizoC6oNdc226t8Sk5i0K7jTi0I9+9UEMJsHYx8Tvcrpvb5xhRm55
         CytG3Ifob8yVyHFE2wFfoGWP2oHzcLqzIa8Z51djy3UWVVE1LxrGbGsqkbbMk8+k9j6o
         eWLA==
X-Gm-Message-State: ALQs6tCd39O0Kz88pdXDQR+bXRhki3+Xm94B34q189qJV3mwKH++HgZu
        bu+QLKrsVW3B0srKnIuQ06cxNQ==
X-Google-Smtp-Source: AIpwx4+GPLlL7Gb8xQ4B1jzBHNHrDaJYGdfMgP+PhAgmQVYAVM8MrvuBx6dJ5tODz2VLrWSE7Gv7KA==
X-Received: by 2002:a19:d911:: with SMTP id q17-v6mr9521138lfg.99.1523720141156;
        Sat, 14 Apr 2018 08:35:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/15] pack-objects: shrink delta_size field in struct object_entry
Date:   Sat, 14 Apr 2018 17:35:11 +0200
Message-Id: <20180414153513.9902-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414153513.9902-1-pclouds@gmail.com>
References: <20180414153513.9902-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allowing a delta size of 64 bits is crazy. Shrink this field down to
20 bits with one overflow bit.

If we find an existing delta larger than 1MB, we do not cache
delta_size at all and will get the value from oe_size(), potentially
from disk if it's larger than 4GB.

Note, since DELTA_SIZE() is used in try_delta() code, it must be
thread-safe. Luckily oe_size() does guarantee this so we it is
thread-safe.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 26 ++++++++++++++++----------
 pack-objects.h         | 23 ++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cccd0f8040..88d2bb8153 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -34,10 +34,12 @@
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
 #define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
+#define DELTA_SIZE(obj) oe_delta_size(&to_pack, obj)
 #define DELTA(obj) oe_delta(&to_pack, obj)
 #define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
 #define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
 #define SET_DELTA(obj, val) oe_set_delta(&to_pack, obj, val)
+#define SET_DELTA_SIZE(obj, val) oe_set_delta_size(&to_pack, obj, val)
 #define SET_DELTA_CHILD(obj, val) oe_set_delta_child(&to_pack, obj, val)
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
@@ -144,7 +146,7 @@ static void *get_delta(struct object_entry *entry)
 		    oid_to_hex(&DELTA(entry)->idx.oid));
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
-	if (!delta_buf || delta_size != entry->delta_size)
+	if (!delta_buf || delta_size != DELTA_SIZE(entry))
 		die("delta size changed");
 	free(buf);
 	free(base_buf);
@@ -294,14 +296,14 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		FREE_AND_NULL(entry->delta_data);
 		entry->z_delta_size = 0;
 	} else if (entry->delta_data) {
-		size = entry->delta_size;
+		size = DELTA_SIZE(entry);
 		buf = entry->delta_data;
 		entry->delta_data = NULL;
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	} else {
 		buf = get_delta(entry);
-		size = entry->delta_size;
+		size = DELTA_SIZE(entry);
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	}
@@ -1509,7 +1511,7 @@ static void check_object(struct object_entry *entry)
 			oe_set_type(entry, entry->in_pack_type);
 			SET_SIZE(entry, in_pack_size); /* delta size */
 			SET_DELTA(entry, base_entry);
-			entry->delta_size = in_pack_size;
+			SET_DELTA_SIZE(entry, in_pack_size);
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
 			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
@@ -1937,7 +1939,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
 	} else {
-		max_size = trg_entry->delta_size;
+		max_size = DELTA_SIZE(trg_entry);
 		ref_depth = trg->depth;
 	}
 	max_size = (uint64_t)max_size * (max_depth - src->depth) /
@@ -2006,10 +2008,14 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
+	if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
+		free(delta_buf);
+		return 0;
+	}
 
 	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
-		if (delta_size == trg_entry->delta_size &&
+		if (delta_size == DELTA_SIZE(trg_entry) &&
 		    src->depth + 1 >= trg->depth) {
 			free(delta_buf);
 			return 0;
@@ -2024,7 +2030,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	free(trg_entry->delta_data);
 	cache_lock();
 	if (trg_entry->delta_data) {
-		delta_cache_size -= trg_entry->delta_size;
+		delta_cache_size -= DELTA_SIZE(trg_entry);
 		trg_entry->delta_data = NULL;
 	}
 	if (delta_cacheable(src_size, trg_size, delta_size)) {
@@ -2037,7 +2043,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 
 	SET_DELTA(trg_entry, src_entry);
-	trg_entry->delta_size = delta_size;
+	SET_DELTA_SIZE(trg_entry, delta_size);
 	trg->depth = src->depth + 1;
 
 	return 1;
@@ -2160,11 +2166,11 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		if (entry->delta_data && !pack_to_stdout) {
 			unsigned long size;
 
-			size = do_compress(&entry->delta_data, entry->delta_size);
+			size = do_compress(&entry->delta_data, DELTA_SIZE(entry));
 			if (size < (1U << OE_Z_DELTA_BITS)) {
 				entry->z_delta_size = size;
 				cache_lock();
-				delta_cache_size -= entry->delta_size;
+				delta_cache_size -= DELTA_SIZE(entry);
 				delta_cache_size += entry->z_delta_size;
 				cache_unlock();
 			} else {
diff --git a/pack-objects.h b/pack-objects.h
index ee2c7ab382..1c588184b2 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -12,6 +12,7 @@
  * above this limit. Don't lower it too much.
  */
 #define OE_SIZE_BITS		31
+#define OE_DELTA_SIZE_BITS	20
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -85,7 +86,8 @@ struct object_entry {
 				     * uses the same base as me
 				     */
 	void *delta_data;	/* cached delta (uncompressed) */
-	unsigned long delta_size;	/* delta data size (uncompressed) */
+	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
+	unsigned delta_size_valid:1;
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
@@ -309,4 +311,23 @@ static inline void oe_set_size(struct packing_data *pack,
 	}
 }
 
+static inline unsigned long oe_delta_size(struct packing_data *pack,
+					  const struct object_entry *e)
+{
+	if (e->delta_size_valid)
+		return e->delta_size_;
+	return oe_size(pack, e);
+}
+
+static inline void oe_set_delta_size(struct packing_data *pack,
+				     struct object_entry *e,
+				     unsigned long size)
+{
+	e->delta_size_ = size;
+	e->delta_size_valid = e->delta_size_ == size;
+	if (!e->delta_size_valid && size != oe_size(pack, e))
+		BUG("this can only happen in check_object() "
+		    "where delta size is the same as entry size");
+}
+
 #endif
-- 
2.17.0.367.g5dd2e386c3

