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
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B031F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfFXNDZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:03:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39440 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfFXNDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:03:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so6875755pls.6
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PecPMyJROs8IrDFUONUHNmYQPhRzwtbSdECZHEdJ1kg=;
        b=fzLGc79wddlha+wAtuM4SeQ4EXZqVWg+26FHFXigsuvj+VrftHOlHlBBO3jtzLnNCM
         OQ06jKKROtwLiB7Zn6f5xORafnNmdktkuQ5VihuvUm9sWy8AostPPbsmWpmO8HVZTj0I
         c9LMO5UlCcEiUjz3cUe0jSuwg2Ssa1JCGKTH1cGJtv+i6OY1/k209HYxEnfeKkTXPfOu
         EI1sK05DXwgI8ltFlcd3lEltDk7KYYN9sm9PSDPHDtlgUoxAgWNUfTGYuXi26wntlMlD
         HD8DVuCpk7Ri9L9EXCL4x5223U2mcGqWVisDIS38cbC9FVCvxhOg69P/8Kzebfexkqoj
         mJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PecPMyJROs8IrDFUONUHNmYQPhRzwtbSdECZHEdJ1kg=;
        b=ovvwtfcCTnSLugFZMZnfcHyVifhbLdK3nCfzat7lYfep25R5tNvs7jQbC0iCuQH9nm
         bGgXKJEI+QusH9eCCSt85lRF33oITTClusdTajy5gwluPH375leuGbqRkX9AopaBp4qW
         qI2ctgUDbcFysEg/W3C5TwF1CxobZ/4N0aADJIXtOQ5KRiEk9JKTK9U7u1CV7sWKZ0cs
         88qJibjvxMX6n5uoXzIXkg1j8mTsPPSHTb5ENkxUXIuxn8jnpR7Jnnpza4I8kTBAM+TF
         m+t0FZKzTUZ3iedvwiUVsSSD/McKnzE2cEEqakZK7K2T9oSLzg+Q0ycorPJklQusVpum
         Dqqw==
X-Gm-Message-State: APjAAAVrtbwjxknSy3LWizT86HX5N5GFVkw5ke1kclKKmeKDm5cjmuje
        AXrd34BzCK7Fxj/Pjufd+gC8Pw+8
X-Google-Smtp-Source: APXvYqzuIYgcJB45h6knmNKBxoYT3IAhjYHZUYQiQi05FCoT+GBrsKxHiP8SNbFg/6s1zx0fEydu3A==
X-Received: by 2002:a17:902:8c83:: with SMTP id t3mr120534378plo.93.1561381404243;
        Mon, 24 Jun 2019 06:03:24 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id f15sm13292106pje.17.2019.06.24.06.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:03:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:03:19 +0700
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
Subject: [PATCH v2 07/10] resolve-undo.c: dump "REUC" extension as json
Date:   Mon, 24 Jun 2019 20:02:23 +0700
Message-Id: <20190624130226.17293-8-pclouds@gmail.com>
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
 read-cache.c             |  2 +-
 resolve-undo.c           | 30 +++++++++++++++++-
 resolve-undo.h           |  4 ++-
 t/t3011-ls-files-json.sh | 20 ++++++++++++
 t/t3011/rerere (new)     | 66 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a70df4b0a5..e5183636fc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1719,7 +1719,7 @@ static int read_index_extension(struct index_state *istate,
 		istate->cache_tree = cache_tree_read(data, sz, istate->jw);
 		break;
 	case CACHE_EXT_RESOLVE_UNDO:
-		istate->resolve_undo = resolve_undo_read(data, sz);
+		istate->resolve_undo = resolve_undo_read(data, sz, istate->jw);
 		break;
 	case CACHE_EXT_LINK:
 		ret = read_link_extension(istate, data, sz);
diff --git a/resolve-undo.c b/resolve-undo.c
index 236320f179..68921e3dfe 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "json-writer.h"
 #include "resolve-undo.h"
 #include "string-list.h"
 
@@ -49,7 +50,30 @@ void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
 	}
 }
 
-struct string_list *resolve_undo_read(const char *data, unsigned long size)
+static void dump_resolve_undo(struct json_writer *jw,
+			      const char *path,
+			      const struct resolve_undo_info *ui)
+{
+	int i;
+
+	if (!jw)
+		return;
+
+	jw_array_inline_begin_object(jw);
+	jw_object_string(jw, "path", path);
+
+	jw_object_inline_begin_array(jw, "stages");
+	for (i = 0; i < 3; i++) {
+		jw_array_inline_begin_object(jw);
+		jw_object_filemode(jw, "mode", ui->mode[i]);
+		jw_object_string(jw, "oid", oid_to_hex(&ui->oid[i]));
+		jw_end(jw);
+	}
+	jw_end(jw);
+}
+
+struct string_list *resolve_undo_read(const char *data, unsigned long size,
+				      struct json_writer *jw)
 {
 	struct string_list *resolve_undo;
 	size_t len;
@@ -59,6 +83,7 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 
 	resolve_undo = xcalloc(1, sizeof(*resolve_undo));
 	resolve_undo->strdup_strings = 1;
+	jw_object_inline_begin_array_gently(jw, "entries");
 
 	while (size) {
 		struct string_list_item *lost;
@@ -94,7 +119,10 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 			size -= rawsz;
 			data += rawsz;
 		}
+
+		dump_resolve_undo(jw, lost->string, ui);
 	}
+	jw_end_gently(jw);
 	return resolve_undo;
 
 error:
diff --git a/resolve-undo.h b/resolve-undo.h
index 2b3f0f901e..46b4e93a7e 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -3,6 +3,8 @@
 
 #include "cache.h"
 
+struct json_writer;
+
 struct resolve_undo_info {
 	unsigned int mode[3];
 	struct object_id oid[3];
@@ -10,7 +12,7 @@ struct resolve_undo_info {
 
 void record_resolve_undo(struct index_state *, struct cache_entry *);
 void resolve_undo_write(struct strbuf *, struct string_list *);
-struct string_list *resolve_undo_read(const char *, unsigned long);
+struct string_list *resolve_undo_read(const char *, unsigned long, struct json_writer *);
 void resolve_undo_clear_index(struct index_state *);
 int unmerge_index_entry_at(struct index_state *, int);
 void unmerge_index(struct index_state *, const struct pathspec *);
diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
index 25215f83ae..dc57138f5b 100755
--- a/t/t3011-ls-files-json.sh
+++ b/t/t3011-ls-files-json.sh
@@ -70,4 +70,24 @@ test_expect_success 'ls-files --json, fsmonitor extension ' '
 	)
 '
 
+test_expect_success 'ls-files --json, rerere extension' '
+	git init rerere &&
+	(
+		cd rerere &&
+		mkdir fi &&
+		test_commit initial fi/le first &&
+		git branch side &&
+		test_commit second fi/le second &&
+		git checkout side &&
+		test_commit third fi/le third &&
+		git checkout master &&
+		git config rerere.enabled true &&
+		test_must_fail git merge side &&
+		echo resolved >fi/le &&
+		git add fi/le &&
+		cp ../filter.sed . &&
+		compare_json rerere
+	)
+'
+
 test_done
diff --git a/t/t3011/rerere b/t/t3011/rerere
new file mode 100644
index 0000000000..a8ec4b16ee
--- /dev/null
+++ b/t/t3011/rerere
@@ -0,0 +1,66 @@
+{
+  "version": 2,
+  "oid": <string>,
+  "mtime_sec": <number>,
+  "mtime_nsec": <number>,
+  "entries": [
+    {
+      "id": 0,
+      "name": "fi/le",
+      "mode": "100644",
+      "flags": 0,
+      "oid": <string>,
+      "stat": {
+        "ctime_sec": <number>,
+        "ctime_nsec": <number>,
+        "mtime_sec": <number>,
+        "mtime_nsec": <number>,
+        "device": <number>,
+        "inode": <number>,
+        "uid": <number>,
+        "gid": <number>,
+        "size": 9
+      },
+      "file_offset": <number>
+    }
+  ],
+  "extensions": {
+    "TREE": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "root": {
+        "oid": null,
+        "subdirs": [
+          {
+            "name": "fi",
+            "oid": null,
+            "subdirs": [
+            ]
+          }
+        ]
+      }
+    },
+    "REUC": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "entries": [
+        {
+          "path": "fi/le",
+          "stages": [
+            {
+              "mode": "100644",
+              "oid": <string>
+            },
+            {
+              "mode": "100644",
+              "oid": <string>
+            },
+            {
+              "mode": "100644",
+              "oid": <string>
+            }
+          ]
+        }
+      ]
+    }
+  }
-- 
2.22.0.rc0.322.g2b0371e29a

