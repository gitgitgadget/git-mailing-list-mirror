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
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E8B1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfFXNDE (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:03:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39396 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfFXNDD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:03:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so6875195pls.6
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hS84pD7SLtkTGLA9zIhMVzeq4ScnuuDvladmMWsLCRw=;
        b=uw9t6Ggi+ddbwgHQFIy4sh+jT/RYg6m/XlrhXhpXz3ywTCbDGwCxXlHLp2naIvW5tn
         ZaGFkBrM1eAGHsboe/0nYlfo0CZ9YvlHGpSs29tvUGr7AOIodZ80a3SX2XGetbcsqPbK
         gQqqITpvJpPXwhk3J43dHmGYqkiXJ/3fdXWbmyZuJq/4EPDDDBxCdWp92fBWQZeYgQhr
         Cr9f/TJrjP8cG2XiYtXxUYIVAgKRS3Ue/mVXUIjwpBLISC8uwTUuWGCnu6VHiQck3+g9
         YDHr78gNRLIXgT3qFQb7a/McFPXqDo7a9j5umRj4BewMiiaq5Xyzi+QLyqovwHt9kjDE
         2qGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hS84pD7SLtkTGLA9zIhMVzeq4ScnuuDvladmMWsLCRw=;
        b=b5SzWvX0xRQEEaLH4jq30uQiwgZBJAvwko/wUy+ly9/f5BQ/UOH8mQhRWB09BrcKIs
         JS4zU9Q09MBEfEmv6ArS5SrOQEq+lFselfKF9u/FfhbzfDDFNF4gu8mOeif76h95cUDb
         EbXsg0BRiXo+g8tP4TyIuNXKR2rThgyYTLbecp2m+GRgg6UlAsNlNqDUOH5bO0pD1TfJ
         Dc40iXe61xkD2nybi0XVvccuKdDYIsRJqWSBx2Sm+rzUTkV59+KPU7gdNB7JWTAifh4a
         kmKULjfRD7utc4B2WzIpunKkHVkBFJEPlMqzOoPmsfl/lxuRMFDX1DyL6rdH0/Fo7cS8
         Q+ew==
X-Gm-Message-State: APjAAAUfqpze+QdTbnae3S4uzPpnbROJXWHQ4Zt74B4zHtviHQG8CH0G
        iEclCxci70djgiCc8mo3ZQbgHzpa
X-Google-Smtp-Source: APXvYqxkFugBs8DAISh9mLGKwongXU2yPKUSLjip8tf2PLomV5cVaMIo+2J0GhSTCqdr7GuiNeFM2w==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr15259622plc.78.1561381382809;
        Mon, 24 Jun 2019 06:03:02 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id f7sm12067386pfd.43.2019.06.24.06.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:03:02 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:02:56 +0700
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
Subject: [PATCH v2 03/10] cache-tree.c: dump "TREE" extension as json
Date:   Mon, 24 Jun 2019 20:02:19 +0700
Message-Id: <20190624130226.17293-4-pclouds@gmail.com>
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
 cache-tree.c             | 36 +++++++++++++++++++++++++++++++-----
 cache-tree.h             |  5 ++++-
 read-cache.c             |  2 +-
 t/t3011-ls-files-json.sh |  4 +++-
 t/t3011/basic            | 20 +++++++++++++++++++-
 5 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index b13bfaf71e..b6a233307e 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -3,6 +3,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
+#include "json-writer.h"
 #include "object-store.h"
 #include "replace-object.h"
 
@@ -492,7 +493,8 @@ void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
 	write_one(sb, root, "", 0);
 }
 
-static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
+static struct cache_tree *read_one(const char **buffer, unsigned long *size_p,
+				   struct json_writer *jw)
 {
 	const char *buf = *buffer;
 	unsigned long size = *size_p;
@@ -546,6 +548,15 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 			*buffer, subtree_nr);
 #endif
 
+	if (jw) {
+		if (it->entry_count >= 0) {
+			jw_object_string(jw, "oid", oid_to_hex(&it->oid));
+			jw_object_intmax(jw, "entry_count", it->entry_count);
+		} else {
+			jw_object_null(jw, "oid");
+		}
+		jw_object_inline_begin_array(jw, "subdirs");
+	}
 	/*
 	 * Just a heuristic -- we do not add directories that often but
 	 * we do not want to have to extend it immediately when we do,
@@ -559,12 +570,18 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 		struct cache_tree_sub *subtree;
 		const char *name = buf;
 
-		sub = read_one(&buf, &size);
+		if (jw) {
+			jw_array_inline_begin_object(jw);
+			jw_object_string(jw, "name", name);
+		}
+		sub = read_one(&buf, &size, jw);
+		jw_end_gently(jw);
 		if (!sub)
 			goto free_return;
 		subtree = cache_tree_sub(it, name);
 		subtree->cache_tree = sub;
 	}
+	jw_end_gently(jw);
 	if (subtree_nr != it->subtree_nr)
 		die("cache-tree: internal error");
 	*buffer = buf;
@@ -576,11 +593,20 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	return NULL;
 }
 
-struct cache_tree *cache_tree_read(const char *buffer, unsigned long size)
+struct cache_tree *cache_tree_read(const char *buffer, unsigned long size,
+				   struct json_writer *jw)
 {
+	struct cache_tree *ret;
+
+	if (jw) {
+		jw_object_inline_begin_object(jw, "root");
+	}
 	if (buffer[0])
-		return NULL; /* not the whole tree */
-	return read_one(&buffer, &size);
+		ret = NULL; /* not the whole tree */
+	else
+		ret = read_one(&buffer, &size, jw);
+	jw_end_gently(jw);
+	return ret;
 }
 
 static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *path)
diff --git a/cache-tree.h b/cache-tree.h
index 757bbc48bc..fc3c73284b 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -6,6 +6,8 @@
 #include "tree-walk.h"
 
 struct cache_tree;
+struct json_writer;
+
 struct cache_tree_sub {
 	struct cache_tree *cache_tree;
 	int count;		/* internally used by update_one() */
@@ -28,7 +30,8 @@ void cache_tree_invalidate_path(struct index_state *, const char *);
 struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
-struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
+struct cache_tree *cache_tree_read(const char *buffer, unsigned long size,
+				   struct json_writer *jw);
 
 int cache_tree_fully_valid(struct cache_tree *);
 int cache_tree_update(struct index_state *, int);
diff --git a/read-cache.c b/read-cache.c
index 4accd8bb08..d09ce42b9a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1716,7 +1716,7 @@ static int read_index_extension(struct index_state *istate,
 
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
-		istate->cache_tree = cache_tree_read(data, sz);
+		istate->cache_tree = cache_tree_read(data, sz, istate->jw);
 		break;
 	case CACHE_EXT_RESOLVE_UNDO:
 		istate->resolve_undo = resolve_undo_read(data, sz);
diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
index 97bcd814be..fc313f2c9a 100755
--- a/t/t3011-ls-files-json.sh
+++ b/t/t3011-ls-files-json.sh
@@ -29,6 +29,8 @@ test_expect_success 'setup' '
 	echo 2 >sub/two &&
 	git add sub/two &&
 
+	git commit -m first &&
+
 	echo intent-to-add >ita &&
 	git add -N ita &&
 
@@ -37,7 +39,7 @@ test_expect_success 'setup' '
 	strip_string oid ident
 '
 
-test_expect_success 'ls-files --json, main entries' '
+test_expect_success 'ls-files --json, main entries and TREE' '
 	compare_json basic
 '
 
diff --git a/t/t3011/basic b/t/t3011/basic
index 9436445d90..e27f5be5ff 100644
--- a/t/t3011/basic
+++ b/t/t3011/basic
@@ -63,5 +63,23 @@
       },
       "file_offset": <number>
     }
-  ]
+  ],
+  "extensions": {
+    "TREE": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "root": {
+        "oid": null,
+        "subdirs": [
+          {
+            "name": "sub",
+            "oid": <string>,
+            "entry_count": 1,
+            "subdirs": [
+            ]
+          }
+        ]
+      }
+    }
+  }
 }
-- 
2.22.0.rc0.322.g2b0371e29a

