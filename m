Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444BE1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeDNPgD (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:36:03 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34351 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeDNPfe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id r7-v6so9294715lfr.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0Oz3M1606W5Fl7R/3v/LrQZlp5SnXxQkLNTaqUvcp4=;
        b=m56j+RdAoULGI5vFBt1BvyRwtVkoBHdmsM66NPKPr1HWWy0k7KVpETZoko2vLE3xol
         OkWp0ATcp0RunO50uzf3c+pnRRrbe3zKXJng6qJQ1+yApEZ3JZPoB2qwJV5BAIpA3/GX
         13+xk/Zk9Ui51p8qLr1Y/tZuYLFTieXh3ZQ/Uo6+vqbl4Fym/+sLfz9BgZtVxtuXKyXG
         lS99olNpXOMnOB6mXHeFL3XZeyKkURMiC/apMvWsRekfGFFikud/B1xk+OoEEB7RGb9k
         +wOJE12IxPDrSmV3mB8QhS41gKZfCubEzbaszj9//0BiVBse04PkOt5kh1bK9WyXqr4v
         JsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0Oz3M1606W5Fl7R/3v/LrQZlp5SnXxQkLNTaqUvcp4=;
        b=nrSdOX3bmSOx5QPWgQzWLQjasiC5D+nmly/+AWgIKa5xWx41Dx1tg6H7MWmfgqu8Ir
         JURAMb1IC3cB8SrNqxuKlPy+FADFi0zCqzjSpV/jTZL09h/JrNOrkuARr35qSTXl7ppd
         asjn5bMa8tdpd2DwkrPL11gb8bWz+DwlBMbotbbHcjJ6N8b4ATw6B/s3AnfoVETOyh+L
         W3XnbnNwBQOSMCzeINa88ij24aUpPK+L5qCyAppDxWQhO+6VespLjPdeXlLxFv8JQYfS
         7GSFpsbTEmO5eUQqGcpdtnU8NQx13ytRaTxlgTayz3JlousZVziIyoydEiGXs88w4A/f
         TWzQ==
X-Gm-Message-State: ALQs6tAdXhainP4Ml61hEHmG+qSCWfuJP9UDcUH3t2wjG8+1lLhzWin7
        VFgsRqcU7YsOEng1dtKkd7l9/A==
X-Google-Smtp-Source: AIpwx49hylOO6bms8eceigicjuOHKtwrJTFxb3eVuF9wfUfVvSD6ARDAY+//MVQDAGijk7P/zQfp4g==
X-Received: by 2002:a19:d34c:: with SMTP id k73-v6mr2983390lfg.118.1523720132292;
        Sat, 14 Apr 2018 08:35:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/15] pack-objects: move in_pack_pos out of struct object_entry
Date:   Sat, 14 Apr 2018 17:35:04 +0200
Message-Id: <20180414153513.9902-7-pclouds@gmail.com>
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

This field is only need for pack-bitmap, which is an optional
feature. Move it to a separate array that is only allocated when
pack-bitmap is used (like objects[], it is not freed, since we need it
until the end of the process)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c |  3 ++-
 pack-bitmap-write.c    |  8 +++++---
 pack-bitmap.c          |  2 +-
 pack-bitmap.h          |  4 +++-
 pack-objects.h         | 16 +++++++++++++++-
 5 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b231e80f17..d9c89e87cd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -879,7 +879,8 @@ static void write_pack_file(void)
 
 			if (write_bitmap_index) {
 				bitmap_writer_set_checksum(oid.hash);
-				bitmap_writer_build_type_index(written_list, nr_written);
+				bitmap_writer_build_type_index(
+					&to_pack, written_list, nr_written);
 			}
 
 			finish_tmp_packfile(&tmpname, pack_tmp_name,
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 2df7b3e144..d707fc9ea2 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -48,7 +48,8 @@ void bitmap_writer_show_progress(int show)
 /**
  * Build the initial type index for the packfile
  */
-void bitmap_writer_build_type_index(struct pack_idx_entry **index,
+void bitmap_writer_build_type_index(struct packing_data *to_pack,
+				    struct pack_idx_entry **index,
 				    uint32_t index_nr)
 {
 	uint32_t i;
@@ -57,12 +58,13 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 	writer.trees = ewah_new();
 	writer.blobs = ewah_new();
 	writer.tags = ewah_new();
+	ALLOC_ARRAY(to_pack->in_pack_pos, to_pack->nr_objects);
 
 	for (i = 0; i < index_nr; ++i) {
 		struct object_entry *entry = (struct object_entry *)index[i];
 		enum object_type real_type;
 
-		entry->in_pack_pos = i;
+		oe_set_in_pack_pos(to_pack, entry, i);
 
 		switch (oe_type(entry)) {
 		case OBJ_COMMIT:
@@ -146,7 +148,7 @@ static uint32_t find_object_pos(const unsigned char *sha1)
 			"(object %s is missing)", sha1_to_hex(sha1));
 	}
 
-	return entry->in_pack_pos;
+	return oe_in_pack_pos(writer.to_pack, entry);
 }
 
 static void show_object(struct object *object, const char *name, void *data)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3f2dab340f..c9e90d1bb5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1033,7 +1033,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 		oe = packlist_find(mapping, sha1, NULL);
 
 		if (oe)
-			reposition[i] = oe->in_pack_pos + 1;
+			reposition[i] = oe_in_pack_pos(mapping, oe) + 1;
 	}
 
 	rebuild = bitmap_new();
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3742a00e14..5ded2f139a 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -44,7 +44,9 @@ int rebuild_existing_bitmaps(struct packing_data *mapping, khash_sha1 *reused_bi
 
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(unsigned char *sha1);
-void bitmap_writer_build_type_index(struct pack_idx_entry **index, uint32_t index_nr);
+void bitmap_writer_build_type_index(struct packing_data *to_pack,
+				    struct pack_idx_entry **index,
+				    uint32_t index_nr);
 void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
diff --git a/pack-objects.h b/pack-objects.h
index cdce1648de..71ea992c3c 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -79,7 +79,6 @@ struct object_entry {
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned type_valid:1;
 	uint32_t hash;			/* name hint hash */
-	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size;
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
@@ -99,6 +98,8 @@ struct packing_data {
 
 	int32_t *index;
 	uint32_t index_size;
+
+	unsigned int *in_pack_pos;
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -144,4 +145,17 @@ static inline void oe_set_type(struct object_entry *e,
 	e->type_ = (unsigned)type;
 }
 
+static inline unsigned int oe_in_pack_pos(const struct packing_data *pack,
+					  const struct object_entry *e)
+{
+	return pack->in_pack_pos[e - pack->objects];
+}
+
+static inline void oe_set_in_pack_pos(const struct packing_data *pack,
+				      const struct object_entry *e,
+				      unsigned int pos)
+{
+	pack->in_pack_pos[e - pack->objects] = pos;
+}
+
 #endif
-- 
2.17.0.367.g5dd2e386c3

