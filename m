Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452F01F461
	for <e@80x24.org>; Mon, 24 Jun 2019 09:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfFXJ4B (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:56:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33493 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfFXJ4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:56:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4so6227835pgk.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMaBu+OyQySzr/SGJEEBkGIwN5Peo2j+BEvW2ufgvHY=;
        b=B0aDPPUYAgxWC/oOpCPZFL8akc0z/A2Zw/RRWWthzVkdlZkI709qz+BzXESs5ZRjvm
         n8UvVpZhjyW8Rv+NIOo13fxUf2YDpct5/pTlZIljs//xWZFqSfpWuyOc9DpERlsyTw8J
         NMJM+oCutRCRiUNBlxbdiQn5m2pfUiVSj2JQHcjREyTBuGHqRJJkT7d9NLqSlDnRSDUv
         luBr79+e5v1hcgkF+cLhcT+8vOyw5VRnAtgkXe/Kb+bl3PixmZk36cd2P6pZxuq5msHz
         AU2a74pDGG26pnuudxPbIavYlYLxpCMXFwBhuYI2sLs4YWkESkWwQ24P9uzdoynmZUuJ
         LTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMaBu+OyQySzr/SGJEEBkGIwN5Peo2j+BEvW2ufgvHY=;
        b=Zml2Yi83rDRk4uOhktY5et2YR/KinvVSVEpGghWSburspWtiqdew0h5baMaBmymw9x
         QofBWynl3QL6482pxa6FAFVllSamFsSL8inqJxYO7LJTOgzIG6ysD954zPEi4GGM5GpW
         R6DIQyPipWWwW66Q9VIV8iixLBTgkW4m0UPIwz8ZHYMcLQoihnglqX1NS2REdsmRJX47
         cEpUleqCUu0QGBz677VPuzCip3DDK2GdBrWAa7ISmIEwWnOWHPvEC78pP9BKHGzxQ2px
         2TRQLveGsjtVehJpMIRpwi+J2JL1PUjz+0iWb/t1wGH0Wig2/O10117w7fYo1Y3RWwHO
         ts+g==
X-Gm-Message-State: APjAAAUcD7U4125xbPLvO9WaAppy1sLLRC/SUX1yIm600mbm5eW/zYmj
        ahEc3PKiZuInNe6LPByt8m5i9yc1
X-Google-Smtp-Source: APXvYqxU8iqQ8jPOCmBTezrRuKEaPcMLs8kYaCMOtZEv2D7WigCR+RyQGbl5hl0N6B5qZKIlQ2UFvg==
X-Received: by 2002:a63:e4a:: with SMTP id 10mr1008609pgo.348.1561370160278;
        Mon, 24 Jun 2019 02:56:00 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id 14sm15855570pfj.36.2019.06.24.02.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:55:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 16:55:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/6] tree-walk.c: remove the_repo from get_tree_entry_follow_symlinks()
Date:   Mon, 24 Jun 2019 16:55:31 +0700
Message-Id: <20190624095533.22162-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624095533.22162-1-pclouds@gmail.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 10 +---------
 tree-walk.c | 12 ++++++++----
 tree-walk.h |  2 +-
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index e8fb215e5c..3c9fa10af8 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1890,16 +1890,8 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			new_filename = resolve_relative_path(repo, filename);
 			if (new_filename)
 				filename = new_filename;
-			/*
-			 * NEEDSWORK: Eventually get_tree_entry*() should
-			 * learn to take struct repository directly and we
-			 * would not need to inject submodule odb to the
-			 * in-core odb.
-			 */
-			if (repo != the_repository)
-				add_to_alternates_memory(repo->objects->odb->path);
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
-				ret = get_tree_entry_follow_symlinks(&tree_oid,
+				ret = get_tree_entry_follow_symlinks(repo, &tree_oid,
 					filename, oid, &oc->symlink_path,
 					&oc->mode);
 			} else {
diff --git a/tree-walk.c b/tree-walk.c
index 506e12a031..c20b62f49e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -593,7 +593,10 @@ int get_tree_entry(struct repository *r,
  * See the code for enum get_oid_result for a description of
  * the return values.
  */
-enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned short *mode)
+enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
+		struct object_id *tree_oid, const char *name,
+		struct object_id *result, struct strbuf *result_path,
+		unsigned short *mode)
 {
 	int retval = MISSING_OBJECT;
 	struct dir_state *parents = NULL;
@@ -617,7 +620,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, c
 			void *tree;
 			struct object_id root;
 			unsigned long size;
-			tree = read_object_with_reference(the_repository,
+			tree = read_object_with_reference(r,
 							  &current_tree_oid,
 							  tree_type, &size,
 							  &root);
@@ -687,7 +690,7 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, c
 		}
 
 		/* Look up the first (or only) path component in the tree. */
-		find_result = find_tree_entry(the_repository, &t, namebuf.buf,
+		find_result = find_tree_entry(r, &t, namebuf.buf,
 					      &current_tree_oid, mode);
 		if (find_result) {
 			goto done;
@@ -731,7 +734,8 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, c
 			 */
 			retval = DANGLING_SYMLINK;
 
-			contents = read_object_file(&current_tree_oid, &type,
+			contents = repo_read_object_file(r,
+						    &current_tree_oid, &type,
 						    &link_len);
 
 			if (!contents)
diff --git a/tree-walk.h b/tree-walk.h
index 639f79187f..2a5db29e8f 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -53,7 +53,7 @@ struct traverse_info;
 typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
 int traverse_trees(struct index_state *istate, int n, struct tree_desc *t, struct traverse_info *info);
 
-enum get_oid_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned short *mode);
+enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r, struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned short *mode);
 
 struct traverse_info {
 	const char *traverse_path;
-- 
2.22.0.rc0.322.g2b0371e29a

