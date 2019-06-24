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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4511C1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfFXNDJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:03:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45278 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfFXNDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:03:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so6856061plb.12
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mQmITDvZW2CXGzoSuENvM0CTFqjQaG5lFvaTu8HDWV4=;
        b=YFif0D9rGIipysT4x72Qzo4H5kdOtugqUwPMEREorx1/sNGIbIq16LXP1JBi1ELO2m
         e2ih6kwUAqHvuvqnt6QDU73Enw+6xgaa+8zSr1n6Kc4u+eYWjQXtUYK8fleo2778FZ8J
         XtrHuqhM6Twr54lxqKoOr4fIxrL2sCa0lWRdck0bSVRUWpDD7tOEUKsAGSltFXIeZb/6
         AMlFSKxBv0/KoDW2+Q/XSSXuqsOHsc+ke9+oHmwv1zWMeecpn7q4y33+UEM9wgSHW257
         U9AIkYogNKzbgBRtViDOQdvptI01dCiCJVRb9mkuFmmmgeHMnm2v1u5OCw45xfA7cM1Q
         J0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQmITDvZW2CXGzoSuENvM0CTFqjQaG5lFvaTu8HDWV4=;
        b=HSdqLC4U3GRgZThHJjcEcOpCRQKeorpW+vO7qtmCFPHKeadhziEeUw3BYNWyqyElud
         swErijWttYC3j+v5VicKcsWFLj9DW9uP+0fiaCIPv6vPbajaBfbgjPQB6ogrujb3rt1X
         kJfpVRbswS2IM/8ygAHBOwavFL7XrC9wOzKFso6njDDDm19T/JZh1gSPJeSkOo7Zy9X6
         4vk0xr89ZDig9ohcS/EtDrYQhXphNdNOr5LXpV00cB3J7FXnh+8CTPHED7w31782VZKS
         vFa7lOU3RS8CmG+td5dSekpzfYz/i5NdY15Z5OorQekLMqo/wFgRFzFvzalBOMQkTaxg
         /33A==
X-Gm-Message-State: APjAAAVSZ/ZsydztbiUa/0CB9RVrzLkKdqr0QN2XRpJZvTf4/SqsqgEF
        w3u4ifW7K7Yf4do25fxODlq39LMX
X-Google-Smtp-Source: APXvYqxnbd/nLSKMBtMJHSuEtpykls2+AxfPnSKXaeU6GINAX2p4SNJ9gVlHkzM/e3B745yKyX1Bwg==
X-Received: by 2002:a17:902:e65:: with SMTP id 92mr141065909plw.13.1561381388222;
        Mon, 24 Jun 2019 06:03:08 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id x3sm12312646pja.7.2019.06.24.06.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:03:07 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:03:03 +0700
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
Subject: [PATCH v2 04/10] dir.c: dump "UNTR" extension as json
Date:   Mon, 24 Jun 2019 20:02:20 +0700
Message-Id: <20190624130226.17293-5-pclouds@gmail.com>
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

The big part of UNTR extension is dumped at the end instead of dumping
as soon as we read it, because we actually "patch" some fields in
untracked_cache_dir with EWAH bitmaps at the end.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 dir.c                    | 57 +++++++++++++++++++++++++++++++++++++++-
 dir.h                    |  4 ++-
 json-writer.h            |  6 +++++
 read-cache.c             |  2 +-
 t/t3011-ls-files-json.sh |  3 ++-
 t/t3011/basic            | 39 +++++++++++++++++++++++++++
 6 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index ba4a51c296..8808577ea3 100644
--- a/dir.c
+++ b/dir.c
@@ -19,6 +19,7 @@
 #include "varint.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "json-writer.h"
 #include "submodule-config.h"
 
 /*
@@ -2826,7 +2827,42 @@ static void load_oid_stat(struct oid_stat *oid_stat, const unsigned char *data,
 	oid_stat->valid = 1;
 }
 
-struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
+static void jw_object_oid_stat(struct json_writer *jw, const char *key,
+			       const struct oid_stat *oid_stat)
+{
+	jw_object_inline_begin_object(jw, key);
+	jw_object_bool(jw, "valid", oid_stat->valid);
+	jw_object_string(jw, "oid", oid_to_hex(&oid_stat->oid));
+	jw_object_stat_data(jw, "stat", &oid_stat->stat);
+	jw_end(jw);
+}
+
+static void jw_object_untracked_cache_dir(struct json_writer *jw,
+					  const struct untracked_cache_dir *ucd)
+{
+	int i;
+
+	jw_object_bool(jw, "valid", ucd->valid);
+	jw_object_bool(jw, "check-only", ucd->check_only);
+	jw_object_stat_data(jw, "stat", &ucd->stat_data);
+	jw_object_string(jw, "exclude-oid", oid_to_hex(&ucd->exclude_oid));
+	jw_object_inline_begin_array(jw, "untracked");
+	for (i = 0; i < ucd->untracked_nr; i++)
+		jw_array_string(jw, ucd->untracked[i]);
+	jw_end(jw);
+
+	jw_object_inline_begin_object(jw, "dirs");
+	for (i = 0; i < ucd->dirs_nr; i++) {
+		jw_object_inline_begin_object(jw, ucd->dirs[i]->name);
+		jw_object_untracked_cache_dir(jw, ucd->dirs[i]);
+		jw_end(jw);
+	}
+	jw_end(jw);
+}
+
+struct untracked_cache *read_untracked_extension(const void *data,
+						 unsigned long sz,
+						 struct json_writer *jw)
 {
 	struct untracked_cache *uc;
 	struct read_data rd;
@@ -2864,6 +2900,19 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	uc->dir_flags = get_be32(next + ouc_offset(dir_flags));
 	exclude_per_dir = (const char *)next + exclude_per_dir_offset;
 	uc->exclude_per_dir = xstrdup(exclude_per_dir);
+
+	if (jw) {
+		jw_object_string(jw, "ident", ident);
+		jw_object_oid_stat(jw, "info_exclude", &uc->ss_info_exclude);
+		jw_object_oid_stat(jw, "excludes_file", &uc->ss_excludes_file);
+		jw_object_intmax(jw, "flags", uc->dir_flags);
+		if (uc->dir_flags & DIR_SHOW_OTHER_DIRECTORIES)
+			jw_object_bool(jw, "show_other_directories", 1);
+		if (uc->dir_flags & DIR_HIDE_EMPTY_DIRECTORIES)
+			jw_object_bool(jw, "hide_empty_directories", 1);
+		jw_object_string(jw, "excludes_per_dir", uc->exclude_per_dir);
+	}
+
 	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
 	next += exclude_per_dir_offset + strlen(exclude_per_dir) + 1;
 	if (next >= end)
@@ -2905,6 +2954,12 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	ewah_each_bit(rd.sha1_valid, read_oid, &rd);
 	next = rd.data;
 
+	if (jw) {
+		jw_object_inline_begin_object(jw, "root");
+		jw_object_untracked_cache_dir(jw, uc->root);
+		jw_end(jw);
+	}
+
 done:
 	free(rd.ucd);
 	ewah_free(rd.valid);
diff --git a/dir.h b/dir.h
index 680079bbe3..80efdd05c4 100644
--- a/dir.h
+++ b/dir.h
@@ -6,6 +6,8 @@
 #include "cache.h"
 #include "strbuf.h"
 
+struct json_writer;
+
 struct dir_entry {
 	unsigned int len;
 	char name[FLEX_ARRAY]; /* more */
@@ -362,7 +364,7 @@ void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
 
 void free_untracked_cache(struct untracked_cache *);
-struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
+struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz, struct json_writer *jw);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
diff --git a/json-writer.h b/json-writer.h
index c48c4cbf33..c3d0fbd1ef 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -121,6 +121,12 @@ static inline void jw_object_inline_begin_array_gently(struct json_writer *jw,
 		jw_object_inline_begin_array(jw, name);
 }
 
+static inline void jw_array_inline_begin_object_gently(struct json_writer *jw)
+{
+	if (jw)
+		jw_array_inline_begin_object(jw);
+}
+
 static inline void jw_end_gently(struct json_writer *jw)
 {
 	if (jw)
diff --git a/read-cache.c b/read-cache.c
index d09ce42b9a..a70df4b0a5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1725,7 +1725,7 @@ static int read_index_extension(struct index_state *istate,
 		ret = read_link_extension(istate, data, sz);
 		break;
 	case CACHE_EXT_UNTRACKED:
-		istate->untracked = read_untracked_extension(data, sz);
+		istate->untracked = read_untracked_extension(data, sz, istate->jw);
 		break;
 	case CACHE_EXT_FSMONITOR:
 		read_fsmonitor_extension(istate, data, sz);
diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
index fc313f2c9a..082fe8e966 100755
--- a/t/t3011-ls-files-json.sh
+++ b/t/t3011-ls-files-json.sh
@@ -30,6 +30,7 @@ test_expect_success 'setup' '
 	git add sub/two &&
 
 	git commit -m first &&
+	git update-index --untracked-cache &&
 
 	echo intent-to-add >ita &&
 	git add -N ita &&
@@ -39,7 +40,7 @@ test_expect_success 'setup' '
 	strip_string oid ident
 '
 
-test_expect_success 'ls-files --json, main entries and TREE' '
+test_expect_success 'ls-files --json, main entries, UNTR and TREE' '
 	compare_json basic
 '
 
diff --git a/t/t3011/basic b/t/t3011/basic
index e27f5be5ff..8e049f5350 100644
--- a/t/t3011/basic
+++ b/t/t3011/basic
@@ -80,6 +80,45 @@
           }
         ]
       }
+    },
+    "UNTR": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "ident": <string>,
+      "info_exclude": {
+        "valid": true,
+        "oid": <string>,
+        "stat": {
+          "ctime_sec": <number>,
+          "ctime_nsec": <number>,
+          "mtime_sec": <number>,
+          "mtime_nsec": <number>,
+          "device": <number>,
+          "inode": <number>,
+          "uid": <number>,
+          "gid": <number>,
+          "size": 0
+        }
+      },
+      "excludes_file": {
+        "valid": true,
+        "oid": <string>,
+        "stat": {
+          "ctime_sec": <number>,
+          "ctime_nsec": <number>,
+          "mtime_sec": <number>,
+          "mtime_nsec": <number>,
+          "device": <number>,
+          "inode": <number>,
+          "uid": <number>,
+          "gid": <number>,
+          "size": 0
+        }
+      },
+      "flags": 6,
+      "show_other_directories": true,
+      "hide_empty_directories": true,
+      "excludes_per_dir": ".gitignore"
     }
   }
 }
-- 
2.22.0.rc0.322.g2b0371e29a

