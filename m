Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EEA1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 02:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935849AbeCCCr0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:47:26 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45586 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935847AbeCCCrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:47:25 -0500
Received: by mail-pl0-f67.google.com with SMTP id v9-v6so6729908plp.12
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jlF+en7UryXSuSCqQjL5UgSmAGHyUQv9NZCFzrljDE=;
        b=ea71yYtvZRUhmd7RPUMMF1bxo6WJEuk7hSq7q+wePNsdD+jTRMPnVco65z12tcRS7I
         p8YBHy0dyX5rO0LqnCpL4T3FO5+ywgi/XKkritoVsCBVmPG0snQ8NWuWRClRnf0VwZOC
         YSQY0h2XFjEq80XcQW4ZJxKo37sc8Ul14gtJ+lHYQUBpFqZe+ZL/Q7JpFKhjYMQRJtBH
         0rCpAE+M/0lhxci5M6Zl+O74k2xcZjS+cNTgQP3z6qyDeTYVV3NouJDdU9ex0ZeHt0DW
         GwTsrtFDwgttyruEhJsHyHuvsEmkyNgBwPmVBcVyt1j2tAtoxar8SQW/TfEXKTdy7krc
         apDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jlF+en7UryXSuSCqQjL5UgSmAGHyUQv9NZCFzrljDE=;
        b=a2+tKfB4BhL80tzYjKhrXlp+WrlJYotf51jo6UBrL7OsJgE6xiZNiDx+tBSwGvvWyY
         3OU1blZbu1MMjr6ZRBfZaDDnaeRYNPYqBPbGAABaUJ2xYQcmcE5XuRcIRpAl/GEdwxXg
         cVC+xmb+6r70WlJ2Wrb8DlkXC2Q/8ZIstec41ALZMN7hlNJJObddQMJesWsIuITlTrif
         jI93WuszWwkLCsrMWYCZ5BEUOXPEBenD3TdX9Z8dHq9HSV/7d2kHGV2NSR+MN9c51LWk
         M5rnqnltG3COVFcdHc86I7XgtucEtOus9Hh1A5nnTmxqgqV+rLxjePDtGYmSt9zLLU+8
         1QNQ==
X-Gm-Message-State: APf1xPBIX/cA8LDAIZbdwk3wc3jbtM1gpAbTrMylu9EPqPk/j4Wgb+0W
        o8sPlnVQmfkPBRD+AQpFlsDuhw==
X-Google-Smtp-Source: AG47ELvFMD10a8TAfNmS3xxXT4VhQuxziytI7ydsWU6r+4Vn7MveRGypm9Q/3BCPaHxYegykY9cUdw==
X-Received: by 2002:a17:902:6041:: with SMTP id a1-v6mr6939645plt.225.1520045245065;
        Fri, 02 Mar 2018 18:47:25 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id o18sm9812934pgd.26.2018.03.02.18.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 18:47:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:47:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC v2 2/9] pack-objects: turn type and in_pack_type to bitfields
Date:   Sat,  3 Mar 2018 09:46:59 +0700
Message-Id: <20180303024706.31465-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303024706.31465-1-pclouds@gmail.com>
References: <20180301091052.32267-1-pclouds@gmail.com>
 <20180303024706.31465-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This saves 8 bytes in sizeof(struct object_entry). On a large
repository like linux-2.6.git (6.5M objects), this saves us 52MB
memory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 14 ++++++++++++--
 cache.h                |  2 ++
 object.h               |  1 -
 pack-objects.h         |  8 ++++----
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c674b2843..fd217cb51f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1407,6 +1407,7 @@ static void check_object(struct object_entry *entry)
 		unsigned long avail;
 		off_t ofs;
 		unsigned char *buf, c;
+		enum object_type type;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -1415,11 +1416,15 @@ static void check_object(struct object_entry *entry)
 		 * since non-delta representations could still be reused.
 		 */
 		used = unpack_object_header_buffer(buf, avail,
-						   &entry->in_pack_type,
+						   &type,
 						   &entry->size);
 		if (used == 0)
 			goto give_up;
 
+		if (type < 0)
+			die("BUG: invalid type %d", type);
+		entry->in_pack_type = type;
+
 		/*
 		 * Determine if this is a delta and if so whether we can
 		 * reuse it or not.  Otherwise let's find out as cheaply as
@@ -1559,6 +1564,7 @@ static void drop_reused_delta(struct object_entry *entry)
 {
 	struct object_entry **p = &entry->delta->delta_child;
 	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type type;
 
 	while (*p) {
 		if (*p == entry)
@@ -1570,7 +1576,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	entry->depth = 0;
 
 	oi.sizep = &entry->size;
-	oi.typep = &entry->type;
+	oi.typep = &type;
 	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
@@ -1580,6 +1586,10 @@ static void drop_reused_delta(struct object_entry *entry)
 		 */
 		entry->type = sha1_object_info(entry->idx.oid.hash,
 					       &entry->size);
+	} else {
+		if (type < 0)
+			die("BUG: invalid type %d", type);
+		entry->type = type;
 	}
 }
 
diff --git a/cache.h b/cache.h
index 21fbcc2414..862bdff83a 100644
--- a/cache.h
+++ b/cache.h
@@ -373,6 +373,8 @@ extern void free_name_hash(struct index_state *istate);
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
 #endif
 
+#define TYPE_BITS 3
+
 enum object_type {
 	OBJ_BAD = -1,
 	OBJ_NONE = 0,
diff --git a/object.h b/object.h
index 87563d9056..8ce294d6ec 100644
--- a/object.h
+++ b/object.h
@@ -25,7 +25,6 @@ struct object_array {
 
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
 
-#define TYPE_BITS   3
 /*
  * object flag allocation:
  * revision.h:      0---------10                                26
diff --git a/pack-objects.h b/pack-objects.h
index 720a8e8756..f8b06e2521 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -14,11 +14,11 @@ struct object_entry {
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
-	enum object_type type;
-	enum object_type in_pack_type;	/* could be delta */
 	uint32_t hash;			/* name hint hash */
 	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size;
+	unsigned type:TYPE_BITS;
+	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
@@ -28,7 +28,7 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 
-	/* XXX 28 bits hole, try to pack */
+	/* XXX 22 bits hole, try to pack */
 	/*
 	 * State flags for depth-first search used for analyzing delta cycles.
 	 *
@@ -41,7 +41,7 @@ struct object_entry {
 		DFS_DONE
 	} dfs_state;
 	int depth;
-	/* size: 136, padding: 4 */
+	/* size: 128, padding: 4 */
 };
 
 struct packing_data {
-- 
2.16.1.435.g8f24da2e1a

