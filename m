Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53141F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeKJPdY (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45853 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbeKJPdX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so2811614lfa.12
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZIg0cK1Nls90unQaMMBzrnQ3IUriSYgy1zCqIsRwHA=;
        b=HbKsVN3d82YRGFAp6Y/UjqQti4J4OLhAjgbgA+RTkxGETbmetEwRq1rtSp+DZOxepD
         qKkDQCDG+pUR6pNHgMf5Hv78rtvL925dKokEL3LMkFlXtR3kNCcmTUY5O5yke3cxi+t9
         SqXjbU5ESjCmhyB6gP7q6DteyzYqZpB9P4fd+KBk48/NiBA//QW741/3Y2f90ZeyJswh
         MlVvEaUbp4AGEG3wYfRuX5iG4+kTE247miDbwMeH0wyEdkdOmOucdPmJmTZjGQhHgyOS
         h4Vvi8IhKwuq8SYZLQYWc7hKRdkGNxJymtpYnLwjhKvwedIrj0ocqjgahFdl1qUIM28L
         8Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZIg0cK1Nls90unQaMMBzrnQ3IUriSYgy1zCqIsRwHA=;
        b=fzcQuG6L49f4gTakb9OZGHpyavKrRVamaJ/QysBMV3jk7RItVDabhYzWBUwxykCha4
         nj+i5+y/lQEgzML6G+bEe7KUMc9LCJ5pM7RF2Cju8pXejjKpGUs5dwox+t0Gm2BM6gdy
         EiNvTnTD1qiHueTtX0Lv+/v9TFqJgTK0WMoLI3fP6+SyttFJ9U4jLKa0VbIZc7pI2H4+
         wzLhiMq/76EKIGib+zcGuiY1xVBONNjB52T/8aw+fiyku4/n6uxxPRGI/7OmH8cbnsDt
         9ruzw4Q9+ziIAAdlqs406fWDCh4x2oQYl2SUyr7UuBbW2Z0nbJelsQ4/+8kXfSfOiPGm
         RLJA==
X-Gm-Message-State: AGRZ1gJ4PODHSIwvg3V314IxmRnbe9WlZysSfew3bjlSprewydhKuyxu
        GJriqq/lit8shV9pgh8F93e7TmNQ
X-Google-Smtp-Source: AJdET5dkdI/pPW6eT4lX6Kx+FhSaH7NYLFXWEuM8fp3HNrR//J+PqLmr7LSMBax1vqZG48ePH3+A+g==
X-Received: by 2002:a19:9508:: with SMTP id x8mr7243072lfd.112.1541828975373;
        Fri, 09 Nov 2018 21:49:35 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:34 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 15/22] delta-islands.c: remove the_repository references
Date:   Sat, 10 Nov 2018 06:49:03 +0100
Message-Id: <20181110054910.10568-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c |  4 ++--
 delta-islands.c        | 24 ++++++++++++++----------
 delta-islands.h        |  9 ++++++---
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c99ee79c31..7812c2b1f3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2628,7 +2628,7 @@ static void prepare_pack(int window, int depth)
 	unsigned n;
 
 	if (use_delta_islands)
-		resolve_tree_islands(progress, &to_pack);
+		resolve_tree_islands(the_repository, progress, &to_pack);
 
 	get_object_details();
 
@@ -3143,7 +3143,7 @@ static void get_object_list(int ac, const char **av)
 		return;
 
 	if (use_delta_islands)
-		load_delta_islands();
+		load_delta_islands(the_repository);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
diff --git a/delta-islands.c b/delta-islands.c
index 8e5018e406..191a930705 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -190,13 +190,15 @@ static void set_island_marks(struct object *obj, struct island_bitmap *marks)
 	island_bitmap_or(b, marks);
 }
 
-static void mark_remote_island_1(struct remote_island *rl, int is_core_island)
+static void mark_remote_island_1(struct repository *r,
+				 struct remote_island *rl,
+				 int is_core_island)
 {
 	uint32_t i;
 
 	for (i = 0; i < rl->oids.nr; ++i) {
 		struct island_bitmap *marks;
-		struct object *obj = parse_object(the_repository, &rl->oids.oid[i]);
+		struct object *obj = parse_object(r, &rl->oids.oid[i]);
 
 		if (!obj)
 			continue;
@@ -211,7 +213,7 @@ static void mark_remote_island_1(struct remote_island *rl, int is_core_island)
 		while (obj && obj->type == OBJ_TAG) {
 			obj = ((struct tag *)obj)->tagged;
 			if (obj) {
-				parse_object(the_repository, &obj->oid);
+				parse_object(r, &obj->oid);
 				marks = create_or_get_island_marks(obj);
 				island_bitmap_set(marks, island_counter);
 			}
@@ -237,7 +239,9 @@ static int tree_depth_compare(const void *a, const void *b)
 	return todo_a->depth - todo_b->depth;
 }
 
-void resolve_tree_islands(int progress, struct packing_data *to_pack)
+void resolve_tree_islands(struct repository *r,
+			  int progress,
+			  struct packing_data *to_pack)
 {
 	struct progress *progress_state = NULL;
 	struct tree_islands_todo *todo;
@@ -281,7 +285,7 @@ void resolve_tree_islands(int progress, struct packing_data *to_pack)
 
 		root_marks = kh_value(island_marks, pos);
 
-		tree = lookup_tree(the_repository, &ent->idx.oid);
+		tree = lookup_tree(r, &ent->idx.oid);
 		if (!tree || parse_tree(tree) < 0)
 			die(_("bad tree object %s"), oid_to_hex(&ent->idx.oid));
 
@@ -292,7 +296,7 @@ void resolve_tree_islands(int progress, struct packing_data *to_pack)
 			if (S_ISGITLINK(entry.mode))
 				continue;
 
-			obj = lookup_object(the_repository, entry.oid->hash);
+			obj = lookup_object(r, entry.oid->hash);
 			if (!obj)
 				continue;
 
@@ -415,7 +419,7 @@ static struct remote_island *get_core_island(void)
 	return NULL;
 }
 
-static void deduplicate_islands(void)
+static void deduplicate_islands(struct repository *r)
 {
 	struct remote_island *island, *core = NULL, **list;
 	unsigned int island_count, dst, src, ref, i = 0;
@@ -444,20 +448,20 @@ static void deduplicate_islands(void)
 	core = get_core_island();
 
 	for (i = 0; i < island_count; ++i) {
-		mark_remote_island_1(list[i], core && list[i]->hash == core->hash);
+		mark_remote_island_1(r, list[i], core && list[i]->hash == core->hash);
 	}
 
 	free(list);
 }
 
-void load_delta_islands(void)
+void load_delta_islands(struct repository *r)
 {
 	island_marks = kh_init_sha1();
 	remote_islands = kh_init_str();
 
 	git_config(island_config_callback, NULL);
 	for_each_ref(find_island_for_ref, NULL);
-	deduplicate_islands();
+	deduplicate_islands(r);
 
 	fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);
 }
diff --git a/delta-islands.h b/delta-islands.h
index b635cd07d8..3ac8045d8c 100644
--- a/delta-islands.h
+++ b/delta-islands.h
@@ -1,14 +1,17 @@
 #ifndef DELTA_ISLANDS_H
 #define DELTA_ISLANDS_H
 
+struct commit;
 struct object_id;
 struct packing_data;
-struct commit;
+struct repository;
 
 int island_delta_cmp(const struct object_id *a, const struct object_id *b);
 int in_same_island(const struct object_id *, const struct object_id *);
-void resolve_tree_islands(int progress, struct packing_data *to_pack);
-void load_delta_islands(void);
+void resolve_tree_islands(struct repository *r,
+			  int progress,
+			  struct packing_data *to_pack);
+void load_delta_islands(struct repository *r);
 void propagate_island_marks(struct commit *commit);
 int compute_pack_layers(struct packing_data *to_pack);
 
-- 
2.19.1.1231.g84aef82467

