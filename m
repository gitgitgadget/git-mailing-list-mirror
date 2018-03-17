Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CECC1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 14:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeCQOKs (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:10:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42917 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeCQOKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:10:47 -0400
Received: by mail-lf0-f66.google.com with SMTP id a22-v6so19308592lfg.9
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SETSi/g/8hp97N+syRYzo6PzSSkgm5NtD+gSW9RkXJw=;
        b=nkOsQ/iF9MNB4ihP/ywsQnpvAOg22AGkyMWuyJVt0prnnaiePqHrGwf33RimA7ohbp
         2gNJIzXp1ef6YkrxXR4n0MEqIDfJAyO7srPSxUGWXWWbE8bkEpHqoDEcPi1BH7aIJd+3
         LTifYFI+ZKvqTmiXEs5gD04DF5wvR5Uwp5Bi6+h6pstNRXXFIInnnDa0iYmzT0d0Ua1q
         jAIOmCaZsPXD01yhlEnGBMbVSvhg+5um3kepA5sZQYqPWxPBlC23QTZmJVJZHKgqoUkX
         v/8cayscreN1aIGscEcFKmabXM1+HQueu3WdGyEcwOX02X/TiMge1lJFFE5Xot2a6AyQ
         vHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SETSi/g/8hp97N+syRYzo6PzSSkgm5NtD+gSW9RkXJw=;
        b=eGhGVtcfH1uOnm9Kutj9bP9NVXtPkfQaCwYkLwLeJ0ZSthXvqa9xssy9kJpLNO6naj
         +fjtqIVXBwXY7l3R03LRa6iL2TLH8s0vPoLukC3PeyzC8OU7fC9Tz4E8sh3aubDTP4Ek
         C1qtzYm3yRkeqZFa6GyHX9jnxSywaeT06Yp9fPi2AHLKlPNXKXe0B2j4WOgIgF9kbO30
         9NGRlrKvugLSYTS5MmxC544QXwcM2Ujkx4MX0MP1pEG7GYfgwhSNFk8tr483FuBpDPZm
         FEEIbnqqtRTG7XXAkyNx0MryOQyy9LMB9g5QAbZ77/klVIOImljdjMIdcCWM9xRKNnp6
         GMnA==
X-Gm-Message-State: AElRT7Fy3WzqzzHaEqGyleBZEjTfcwsIXQQr+8LYlzI3ebizPEj9tFNs
        gcVvWz6cDggbOmUOn6gXOZo=
X-Google-Smtp-Source: AG47ELtrKiWMr63+j4LReNBq/zmBTTXwIAt5n97g1jrSwz3HUVpRenD192Bo+zNnOu7Yg0Bip1vQRw==
X-Received: by 2002:a19:53cf:: with SMTP id h76-v6mr3869796lfl.87.1521295845731;
        Sat, 17 Mar 2018 07:10:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f7-v6sm625648lfb.2.2018.03.17.07.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 07:10:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v5 00/11] nd/pack-objects-pack-struct updates
Date:   Sat, 17 Mar 2018 15:10:22 +0100
Message-Id: <20180317141033.21545-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180316183200.31014-1-pclouds@gmail.com>
References: <20180316183200.31014-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5 changes are small enough that the interdiff is pretty self
explanatory (there's also a couple commit msg updates).

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c388d87c3e..fb2aba80bf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1611,7 +1611,7 @@ static void drop_reused_delta(struct object_entry *entry)
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
-		 * And if that fails, the error will be recorded in entry->type
+		 * And if that fails, the error will be recorded in oe_type(entry)
 		 * and dealt with in prepare_pack().
 		 */
 		oe_set_type(entry, sha1_object_info(entry->idx.oid.hash,
@@ -1968,7 +1968,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
-	if (delta_size >= maximum_unsigned_value_of_type(uint32_t))
+	if (delta_size >= (1 << OE_DELTA_SIZE_BITS))
 		return 0;
 
 	if (DELTA(trg_entry)) {
@@ -2125,8 +2125,8 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 			unsigned long size;
 
 			size = do_compress(&entry->delta_data, DELTA_SIZE(entry));
-			entry->z_delta_size = size;
-			if (entry->z_delta_size == size) {
+			if (size < (1 << OE_Z_DELTA_BITS)) {
+				entry->z_delta_size = size;
 				cache_lock();
 				delta_cache_size -= DELTA_SIZE(entry);
 				delta_cache_size += entry->z_delta_size;
diff --git a/pack-objects.h b/pack-objects.h
index 0fa0c83294..8979289f5f 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -27,14 +27,15 @@ enum dfs_state {
  *
  * basic object info
  * -----------------
- * idx.oid is filled up before delta searching starts. idx.crc32 and
- * is only valid after the object is written out and will be used for
+ * idx.oid is filled up before delta searching starts. idx.crc32 is
+ * only valid after the object is written out and will be used for
  * generating the index. idx.offset will be both gradually set and
  * used in writing phase (base objects get offset first, then deltas
  * refer to them)
  *
- * "size" is the uncompressed object size. Compressed size is not
- * cached (ie. raw data in a pack) but available via revindex.
+ * "size" is the uncompressed object size. Compressed size of the raw
+ * data for an object in a pack is not stored anywhere but is computed
+ * and made available when reverse .idx is made.
  *
  * "hash" contains a path name hash which is used for sorting the
  * delta list and also during delta searching. Once prepare_pack()
@@ -42,16 +43,16 @@ enum dfs_state {
  *
  * source pack info
  * ----------------
- * The (in_pack, in_pack_offset, in_pack_header_size) tuple contains
- * the location of the object in the source pack, with or without
- * header.
+ * The (in_pack, in_pack_offset) tuple contains the location of the
+ * object in the source pack. in_pack_header_size allows quickly
+ * skipping the header and going straight to the zlib stream.
  *
  * "type" and "in_pack_type" both describe object type. in_pack_type
  * may contain a delta type, while type is always the canonical type.
  *
  * deltas
  * ------
- * Delta links (delta, delta_child and delta_sibling) are created
+ * Delta links (delta, delta_child and delta_sibling) are created to
  * reflect that delta graph from the source pack then updated or added
  * during delta searching phase when we find better deltas.
  *
@@ -59,7 +60,7 @@ enum dfs_state {
  * compute_write_order(). "delta" and "delta_size" must remain valid
  * at object writing phase in case the delta is not cached.
  *
- * If a delta is cached in memory and is compressed delta_data points
+ * If a delta is cached in memory and is compressed, delta_data points
  * to the data and z_delta_size contains the compressed size. If it's
  * uncompressed [1], z_delta_size must be zero. delta_size is always
  * the uncompressed size and must be valid even if the delta is not
@@ -274,12 +275,19 @@ static inline unsigned long oe_size(const struct object_entry *e)
 	}
 }
 
+static inline int contains_in_32bits(unsigned long limit)
+{
+	uint32_t truncated_limit = (uint32_t)limit;
+
+	return limit == truncated_limit;
+}
+
 static inline int oe_size_less_than(const struct object_entry *e,
 				    unsigned long limit)
 {
 	if (e->size_valid)
 		return e->size_ < limit;
-	if (limit > maximum_unsigned_value_of_type(uint32_t))
+	if (contains_in_32bits(limit))
 		return 1;
 	return oe_size(e) < limit;
 }
@@ -289,8 +297,8 @@ static inline int oe_size_greater_than(const struct object_entry *e,
 {
 	if (e->size_valid)
 		return e->size_ > limit;
-	if (limit <= maximum_unsigned_value_of_type(uint32_t))
-		return 1;
+	if (contains_in_32bits(limit))
+		return 0;
 	return oe_size(e) > limit;
 }
 
@@ -314,7 +322,7 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 				     unsigned long size)
 {
 	e->delta_size_ = size;
-	e->delta_size_valid =e->delta_size_ == size;
+	e->delta_size_valid = e->delta_size_ == size;
 	if (!e->delta_size_valid && size != oe_size(e))
 		die("BUG: this can only happen in check_object() "
 		    "where delta size is the same as entry size");

-- 
2.17.0.rc0.347.gf9cf61673a

