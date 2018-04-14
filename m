Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADE01F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeDNP1M (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:27:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36201 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbeDNP1I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:27:08 -0400
Received: by mail-lf0-f68.google.com with SMTP id d20-v6so16388079lfe.3
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtOX0tAz7pqRLBhn8U2jsGGLvPj4TzYcPgLjw5PWwck=;
        b=tCJNGw+VkDNEbJPizS2HGxA1HSZ7RWgpIz2cxwb2yJ4IfrhjubSPKxLvCwKyyTN2wn
         Vuw+rOskId9+5tJCLLdAzlW2agOnw0FqQK4iBUceqcrtw0FkUJTHAX4MSzr3jq55mN0V
         JQgRoEwY2iIym/VXLnsz1nA9r2w18YFq7WaJ9BGkwBvBWzf1i9YGNd0gvQKpjAkIDbUS
         7UpyCEXjBtMhecHVNgfbBfbeo3mEd2njgP8W8t57R5mB6LqLm0AWF9I9evbTkBBopvju
         0NJetbyf+HHamow8N6thTe8Zn470JxeNhuhOQ+9oy0L1UdOKqnlXqhRAZien1CsYitz6
         oYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtOX0tAz7pqRLBhn8U2jsGGLvPj4TzYcPgLjw5PWwck=;
        b=p2LwQVGhvahF/U3MFL1z/awRJqj++nXKGqIdoyU1pd46r7J10p5vIOx4KvRsBGf5co
         xIQxIf8oX0oyiCJXFEto4KttOmye3RA8OqkwDIyZM8fDoV8Yx/gkfEZ3EYkFnYn/1gkP
         pj3xYKQ7cGe+6Ma4q2uvTVEvGfA1r5FD1RFD4wMt/HmO6SSnRMg8KaJgb0phxOemmc8J
         sSzpLqtUPIfmLtEoOMiWXJBXm8bgKQpdy/yHMxoaTXP7H9SV/5yjNnbyJ8WKQWhUk3Bp
         5wHJF7+EP11r+2Vuf6/sTyGAZHN2Gct4oGt75BqG+pWAulFT/McqzmHXPw9brJdJD/U7
         hU+Q==
X-Gm-Message-State: ALQs6tDvH2pfgqNkJBI0KSrIy9No4J8UDO9ZowFPSruX8FbKUqgQmczS
        6bLuDIs4xnE3lXX4uQRHtNjqzA==
X-Google-Smtp-Source: AIpwx48smLapV8r1zxTc7tn7dDuuHIrkQ0/FOig8REqAyC4DZrujdc6y76IzOaERjdFhA3Lr8FT2/w==
X-Received: by 2002:a19:921a:: with SMTP id u26-v6mr10291043lfd.112.1523719626730;
        Sat, 14 Apr 2018 08:27:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f133-v6sm1803378lfg.28.2018.04.14.08.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:27:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 7/7] pack-objects: show some progress when counting kept objects
Date:   Sat, 14 Apr 2018 17:26:42 +0200
Message-Id: <20180414152642.4666-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414152642.4666-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only show progress when there are new objects to be packed. But
when --keep-pack is specified on the base pack, we will exclude most
of objects. This makes 'pack-objects' stay silent for a long time
while the counting phase is going.

Let's show some progress whenever we visit an object instead. The old
"Counting objects" is renamed to "Enumerating objects" and a new
progress "Counting objects" line is added.

This new "Counting objects" line should progress pretty quick when the
system is beefy. But when the system is under pressure, the reading
object header done in this phase could be slow and showing progress is
an improvement over staying silent in the current code.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c77bea404d..6a1346c41f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -46,7 +46,7 @@ static const char *pack_usage[] = {
 static struct packing_data to_pack;
 
 static struct pack_idx_entry **written_list;
-static uint32_t nr_result, nr_written;
+static uint32_t nr_result, nr_written, nr_seen;
 
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
@@ -1096,6 +1096,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	off_t found_offset = 0;
 	uint32_t index_pos;
 
+	display_progress(progress_state, ++nr_seen);
+
 	if (have_duplicate_entry(oid, exclude, &index_pos))
 		return 0;
 
@@ -1111,8 +1113,6 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	create_object_entry(oid, type, pack_name_hash(name),
 			    exclude, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
-
-	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -1123,6 +1123,8 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 {
 	uint32_t index_pos;
 
+	display_progress(progress_state, ++nr_seen);
+
 	if (have_duplicate_entry(oid, 0, &index_pos))
 		return 0;
 
@@ -1130,8 +1132,6 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, index_pos, pack, offset);
-
-	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -1716,6 +1716,10 @@ static void get_object_details(void)
 	uint32_t i;
 	struct object_entry **sorted_by_offset;
 
+	if (progress)
+		progress_state = start_progress(_("Counting objects"),
+						to_pack.nr_objects);
+
 	sorted_by_offset = xcalloc(to_pack.nr_objects, sizeof(struct object_entry *));
 	for (i = 0; i < to_pack.nr_objects; i++)
 		sorted_by_offset[i] = to_pack.objects + i;
@@ -1726,7 +1730,9 @@ static void get_object_details(void)
 		check_object(entry);
 		if (big_file_threshold < entry->size)
 			entry->no_try_delta = 1;
+		display_progress(progress_state, i + 1);
 	}
+	stop_progress(&progress_state);
 
 	/*
 	 * This must happen in a second pass, since we rely on the delta
@@ -3209,7 +3215,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 
 	if (progress)
-		progress_state = start_progress(_("Counting objects"), 0);
+		progress_state = start_progress(_("Enumerating objects"), 0);
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
-- 
2.17.0.367.g5dd2e386c3

