Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6811F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeKJPap (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:30:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37281 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeKJPao (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:30:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id e5-v6so3380583lja.4
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpV8xhNLB/scWysqMZej/wGnQkc4j31hL9ZxATH0HSQ=;
        b=CIGWuwTJmTgInnRG/MX+ebLD4pqYBnpJOWpJOvTdFAfIHzAPcDHjCTkXNNXpCnAsdL
         MeQN9CKMFVUzN5PYpydh7pA5SFWVOUAVfrCxRMNLTsQApX2JMz3UntVg3rG3xP+bCtgz
         ZC95vnYP2lJi7kX8CDrOsFqEVSGDQYVkwfjCTsYMBya4OAiQW84h6qr1v/sDHyuUu8Hv
         6rWBoDv91oDFTeIBt4LEIBFFM+gd03d3rBpAclO/7MaJipvtqptuwUzzoM7lJJBLX5+U
         uav1GYY4ZgSj9nhIFMcPr2JaGQgXILVsDti2OOlSgPAR0F6k1cCf2UsWmOYCK6GQ3oEi
         NQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpV8xhNLB/scWysqMZej/wGnQkc4j31hL9ZxATH0HSQ=;
        b=LxWG5WB8W750Jx5oT8R7M6+U30W7Y9btntuW6zFb/rNRElxwbKirZ0Hgs+WuVgMPPc
         VPRAINf2oyR2Ji1PgDpku3yy9AF7KrerpEJ9Dkm567PfgmOb8nb/7OgzBkh8rAc/NQSQ
         lAGPE9R6LSY7FKg3NjLXbL34Fy1kYLIGpZuCvrRQ1zfk6QHgvTYq/eLDwtj+nHzcMZ0q
         HZ04AUC6yd5EIt+aL7LIaeJFkaMgL+K0U1KnScstDzOqyzQuH1v9m1FWFt0cKdEr/S7d
         W+7jphFnkWo6ZIxhbIbGNmosVnOErNVZMc2U+yUgcZaOmgBwX4wK0e6XrCqj5NPw/yaN
         +Ttg==
X-Gm-Message-State: AGRZ1gJTGLdg4bx5tfT/MoUgt4m4c6UEvPRy2P0Lbhg6B56rbDoOfC4G
        rVvBRuUUI973VsCXEFhZ1IF3IfQv
X-Google-Smtp-Source: AJdET5f4b1ORt1SspFesmpzI496+enXi+QydvMI2tFftXb/6HhwbE957AQXZl/G08DwNdiSQJ2ho/Q==
X-Received: by 2002:a2e:9694:: with SMTP id q20-v6mr7260511lji.173.1541828816956;
        Fri, 09 Nov 2018 21:46:56 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm2441597ljg.9.2018.11.09.21.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:46:56 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/22] list-objects-filter.c: remove implicit dependency on the_index
Date:   Sat, 10 Nov 2018 06:46:27 +0100
Message-Id: <20181110054646.10149-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054646.10149-1-pclouds@gmail.com>
References: <20181110054646.10149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at there, since we have access to struct repository now,
eliminate the only the_repository reference in this file.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 list-objects-filter.c | 10 +++++++---
 list-objects-filter.h |  2 ++
 list-objects.c        |  9 ++++++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 765f3df3b0..a62624a1ce 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -34,6 +34,7 @@ struct filter_blobs_none_data {
 };
 
 static enum list_objects_filter_result filter_blobs_none(
+	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
@@ -88,6 +89,7 @@ struct filter_trees_none_data {
 };
 
 static enum list_objects_filter_result filter_trees_none(
+	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
@@ -144,6 +146,7 @@ struct filter_blobs_limit_data {
 };
 
 static enum list_objects_filter_result filter_blobs_limit(
+	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
@@ -171,7 +174,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
-		t = oid_object_info(the_repository, &obj->oid, &object_length);
+		t = oid_object_info(r, &obj->oid, &object_length);
 		if (t != OBJ_BLOB) { /* probably OBJ_NONE */
 			/*
 			 * We DO NOT have the blob locally, so we cannot
@@ -249,6 +252,7 @@ struct filter_sparse_data {
 };
 
 static enum list_objects_filter_result filter_sparse(
+	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
@@ -268,7 +272,7 @@ static enum list_objects_filter_result filter_sparse(
 		dtype = DT_DIR;
 		val = is_excluded_from_list(pathname, strlen(pathname),
 					    filename, &dtype, &filter_data->el,
-					    &the_index);
+					    r->index);
 		if (val < 0)
 			val = filter_data->array_frame[filter_data->nr].defval;
 
@@ -331,7 +335,7 @@ static enum list_objects_filter_result filter_sparse(
 		dtype = DT_REG;
 		val = is_excluded_from_list(pathname, strlen(pathname),
 					    filename, &dtype, &filter_data->el,
-					    &the_index);
+					    r->index);
 		if (val < 0)
 			val = frame->defval;
 		if (val > 0) {
diff --git a/list-objects-filter.h b/list-objects-filter.h
index 52b4a84da9..1d45a4ad57 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -4,6 +4,7 @@
 struct list_objects_filter_options;
 struct object;
 struct oidset;
+struct repository;
 
 /*
  * During list-object traversal we allow certain objects to be
@@ -60,6 +61,7 @@ enum list_objects_filter_situation {
 };
 
 typedef enum list_objects_filter_result (*filter_object_fn)(
+	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
diff --git a/list-objects.c b/list-objects.c
index c41cc80db5..0cfd646026 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -55,7 +55,8 @@ static void process_blob(struct traversal_context *ctx,
 	pathlen = path->len;
 	strbuf_addstr(path, name);
 	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
-		r = ctx->filter_fn(LOFS_BLOB, obj,
+		r = ctx->filter_fn(ctx->revs->repo,
+				   LOFS_BLOB, obj,
 				   path->buf, &path->buf[pathlen],
 				   ctx->filter_data);
 	if (r & LOFR_MARK_SEEN)
@@ -175,7 +176,8 @@ static void process_tree(struct traversal_context *ctx,
 
 	strbuf_addstr(base, name);
 	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
-		r = ctx->filter_fn(LOFS_BEGIN_TREE, obj,
+		r = ctx->filter_fn(ctx->revs->repo,
+				   LOFS_BEGIN_TREE, obj,
 				   base->buf, &base->buf[baselen],
 				   ctx->filter_data);
 	if (r & LOFR_MARK_SEEN)
@@ -191,7 +193,8 @@ static void process_tree(struct traversal_context *ctx,
 		process_tree_contents(ctx, tree, base);
 
 	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
-		r = ctx->filter_fn(LOFS_END_TREE, obj,
+		r = ctx->filter_fn(ctx->revs->repo,
+				   LOFS_END_TREE, obj,
 				   base->buf, &base->buf[baselen],
 				   ctx->filter_data);
 		if (r & LOFR_MARK_SEEN)
-- 
2.19.1.1231.g84aef82467

