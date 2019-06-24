Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9321F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfFXNDg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:03:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33088 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbfFXNDg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:03:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so7506533pfq.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xp1cwjRAIuDvxzU93ORO/vW6D2vOMdcIrfHaIlX//A=;
        b=bLY32SnrHssAsIQ3jnRcIcMEhuG0Tk8hUGcWqFAchxcUlE+W2RfOEuuxZPz8p+ntwx
         mA6h4I65robZG2l5v+fj0+mQLHzOpRLwmZoE8rMi9pHSXkOLlg3uyNfpbWtxAsUg/gdf
         mE9ooulJ0EC1QKGVOrsGXZC4sT3uPpaD7GoVr9VVDrjfzyNX3XCQKttMJ/+JJdGYW78L
         S2nH/TBl29QeplVzvQeNPemn2dUFxVKSLd61lTAnb7WvwBAsaWCJ2XxgwWQ3I86liMay
         gHJCLckKFUPuulkcH55NgIuBVqLdXYs3tnoKGZPJFc0L0cjHQ12fRBUpFI21LLIM3lrH
         o1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xp1cwjRAIuDvxzU93ORO/vW6D2vOMdcIrfHaIlX//A=;
        b=YG0R4UH67TIPGKjvaJLW+EUwpRDQo+EAwXEMrU4vYjr1LGK6ZtamG2SrL4dbHdqjYR
         fN9Sao5zGrapNX2pBbsj2RioyyNWcluHOKmyJEhbqSWlUu/yh3iA5rqU70+XKRPHvGFU
         fISU5ApbRDh+uX8nWiumlDZ0wW+4l34DFUDo5ER+PZ80MD/+xdQMPxINW0soEDnpUgbY
         IKBtu/MvEhGUh6H9tPBaBrucVBFI74GMzwPi9aPcKezGpqWJIEkyZoFahARhlKY9SHpO
         pN92+FVAB3/wA3UngNG2mFsmSdxto7Un8fGpNZgYx+wp2QAqSY59FBW5vx3+hy8huNs4
         baHg==
X-Gm-Message-State: APjAAAWznS2JjiR7+ysasqjEYtN1OUpPfcEjUuP8zVa8TKe6LzeWKT5b
        2u3kGEpnbIDiZJeQmSWGQnrY2Qen
X-Google-Smtp-Source: APXvYqybMjxG4nObQ76mh+1X7/HfCYi57jMhz+NGVLw3c5OT5PrLK4k48tkKA8jeFX/hctdrvZ0QGA==
X-Received: by 2002:a65:55ca:: with SMTP id k10mr71325pgs.14.1561381414683;
        Mon, 24 Jun 2019 06:03:34 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id n98sm14885550pjc.26.2019.06.24.06.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:03:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:03:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 09/10] read-cache.c: dump "IEOT" extension as json
Date:   Mon, 24 Jun 2019 20:02:25 +0700
Message-Id: <20190624130226.17293-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624130226.17293-1-pclouds@gmail.com>
References: <20190624130226.17293-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 43 ++++++++++++++++++++++++++++++++++++-------
 t/t3011/eoie | 13 ++++++++++++-
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 37491dd03d..c26edcc9d9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1693,6 +1693,7 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	return 0;
 }
 
+static struct index_entry_offset_table *do_read_ieot_extension(struct index_state *, const char *, uint32_t);
 static int read_index_extension(struct index_state *istate,
 				const char *map,
 				unsigned long *offset)
@@ -1740,7 +1741,11 @@ static int read_index_extension(struct index_state *istate,
 		/* already handled in do_read_index() */
 		break;
 	case CACHE_EXT_INDEXENTRYOFFSETTABLE:
-		/* already handled in do_read_index() */
+		if (istate->jw) {
+			free(do_read_ieot_extension(istate, data, sz));
+		} else {
+			/* already handled in do_read_index() */
+		}
 		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
@@ -1938,7 +1943,7 @@ struct index_entry_offset_table
 	struct index_entry_offset entries[FLEX_ARRAY];
 };
 
-static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset);
+static struct index_entry_offset_table *read_ieot_extension(struct index_state *istate, const char *mmap, size_t mmap_size, size_t offset);
 static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
 
 static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
@@ -2292,7 +2297,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	 * to multi-thread the reading of the cache entries.
 	 */
 	if (extension_offset && nr_threads > 1)
-		ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
+		ieot = read_ieot_extension(istate, mmap, mmap_size, extension_offset);
 
 	if (ieot) {
 		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);
@@ -3634,12 +3639,13 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
 
 #define IEOT_VERSION	(1)
 
-static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
+static struct index_entry_offset_table *read_ieot_extension(
+		struct index_state *istate,
+		const char *mmap, size_t mmap_size,
+		size_t offset)
 {
 	const char *index = NULL;
-	uint32_t extsize, ext_version;
-	struct index_entry_offset_table *ieot;
-	int i, nr;
+	uint32_t extsize;
 
 	/* find the IEOT extension */
 	if (!offset)
@@ -3655,6 +3661,17 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 	}
 	if (!index)
 		return NULL;
+	return do_read_ieot_extension(istate, index, extsize);
+}
+
+static struct index_entry_offset_table *do_read_ieot_extension(
+		struct index_state *istate,
+		const char *index,
+		uint32_t extsize)
+{
+	uint32_t ext_version;
+	struct index_entry_offset_table *ieot;
+	int i, nr;
 
 	/* validate the version is IEOT_VERSION */
 	ext_version = get_be32(index);
@@ -3670,6 +3687,10 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 		error("invalid number of IEOT entries %d", nr);
 		return NULL;
 	}
+	if (istate->jw) {
+		jw_object_intmax(istate->jw, "version", ext_version);
+		jw_object_inline_begin_array(istate->jw, "entries");
+	}
 	ieot = xmalloc(sizeof(struct index_entry_offset_table)
 		       + (nr * sizeof(struct index_entry_offset)));
 	ieot->nr = nr;
@@ -3678,7 +3699,15 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 		index += sizeof(uint32_t);
 		ieot->entries[i].nr = get_be32(index);
 		index += sizeof(uint32_t);
+
+		if (istate->jw) {
+			jw_array_inline_begin_object(istate->jw);
+			jw_object_intmax(istate->jw, "offset", ieot->entries[i].offset);
+			jw_object_intmax(istate->jw, "count", ieot->entries[i].nr);
+			jw_end(istate->jw);
+		}
 	}
+	jw_end_gently(istate->jw);
 
 	return ieot;
 }
diff --git a/t/t3011/eoie b/t/t3011/eoie
index 85ec61517b..66a0feb3b6 100644
--- a/t/t3011/eoie
+++ b/t/t3011/eoie
@@ -84,7 +84,18 @@
   "extensions": {
     "IEOT": {
       "file_offset": <number>,
-      "ext_size": <number>
+      "ext_size": <number>,
+      "version": 1,
+      "entries": [
+        {
+          "offset": <number>,
+          "count": 2
+        },
+        {
+          "offset": <number>,
+          "count": 2
+        }
+      ]
     },
     "EOIE": {
       "file_offset": <number>,
-- 
2.22.0.rc0.322.g2b0371e29a

