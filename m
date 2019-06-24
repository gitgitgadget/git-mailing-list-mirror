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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB841F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfFXNDP (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:03:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42860 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfFXNDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:03:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id k13so925295pgq.9
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ilEyhx7a3dmSnJVVCND1Jd0Y+WKmiJh5t+FI6c13Jg=;
        b=AAZt3xgNaOHS5ruROcwMEi//m+LZnKmTMkH3dshNRslcO1AODwKTgiOFHbTQLy8XUg
         XCcpW/ftnoHRy3rB7F+zNuUWGoSWg5HtM/hhhY7dDj7E8P6mbnwq4lizeURa0fEt1XkB
         xe8bTNlKhKLH23HPyVymLNsosPKWSTp3pSr1CFnn9LHscWAt4CSD/dnrU+zCBOxWIufr
         Ow6DO5VEGeVr+cmWiMypswjzmn0R8is+ELzSR5Cued9m3m+ZnEuJl5JP2r88LAeM/ddV
         tEGtAvOypo87dvLCepiR9Mb9ybR1U+iCJo6WehCq9nbNzSHUG/gKPlUVrQXXQjsLsQh5
         JEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ilEyhx7a3dmSnJVVCND1Jd0Y+WKmiJh5t+FI6c13Jg=;
        b=sTuV93ZHjbDmA5Ix4ZR2RSm2UnYmzusBDWFiZ+SsOnHfI9wiavrilE9GxeN+EGJzt7
         LjTW2P5UmajizBZs19K/oXNVAKvD1S6nCvzv70xhUd205DtxkJ38gmqNvzf0kODnPG4H
         T40s3Y8GIJx8PoUr2eOsCh6L8cdWdNvqCxq/qwPwF6fbpLX+sQqB6VrTix2QaDcCvxcz
         OYSZ4x7D7Y+AV8ktMYo7G3MzGpQkoaCPf8BVLyCNfopmA1IG3/aiDZCnHP9UZb+GudWh
         OWfahfMlhFMnP18VuZW0KEzEEayMJGznaUnsosuzxowynmJdy8weo6f7lzgaEPL0w5az
         IOaw==
X-Gm-Message-State: APjAAAXQb8yEuYKST28IwB45sBLxEquh5Ule3Ouh1FnyZiHf0ifWWUUa
        eGHm5WaQQk9P7XRtezB7p3OBmlpt
X-Google-Smtp-Source: APXvYqxULM3dIksRhyvAuLTZ7/MrZ6FOKEUbxOB9BSVHhxRa+hm4j459RgIQ6WWLb51Qy6ZqVPmb7Q==
X-Received: by 2002:a63:6b46:: with SMTP id g67mr25169313pgc.45.1561381393608;
        Mon, 24 Jun 2019 06:03:13 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id y5sm10998397pgv.12.2019.06.24.06.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:03:12 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:03:08 +0700
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
Subject: [PATCH v2 05/10] split-index.c: dump "link" extension as json
Date:   Mon, 24 Jun 2019 20:02:21 +0700
Message-Id: <20190624130226.17293-6-pclouds@gmail.com>
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
 json-writer.c             | 14 ++++++++++++++
 json-writer.h             |  3 +++
 split-index.c             |  9 ++++++++-
 t/t3011-ls-files-json.sh  | 14 ++++++++++++++
 t/t3011/split-index (new) | 39 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/json-writer.c b/json-writer.c
index 0608726512..c0bd302e4e 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "ewah/ewok.h"
 #include "json-writer.h"
 
 void jw_init(struct json_writer *jw)
@@ -224,6 +225,19 @@ void jw_object_stat_data(struct json_writer *jw, const char *name,
 	jw_end(jw);
 }
 
+static void dump_ewah_one(size_t pos, void *jw)
+{
+	jw_array_intmax(jw, pos);
+}
+
+void jw_object_ewah(struct json_writer *jw, const char *key,
+		    struct ewah_bitmap *ewah)
+{
+	jw_object_inline_begin_array(jw, key);
+	ewah_each_bit(ewah, dump_ewah_one, jw);
+	jw_end(jw);
+}
+
 static void increase_indent(struct strbuf *sb,
 			    const struct json_writer *jw,
 			    int indent)
diff --git a/json-writer.h b/json-writer.h
index c3d0fbd1ef..07d841d52a 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -45,6 +45,7 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 
+struct ewah_bitmap;
 struct stat_data;
 
 struct json_writer
@@ -87,6 +88,8 @@ void jw_object_null(struct json_writer *jw, const char *key);
 void jw_object_filemode(struct json_writer *jw, const char *key, mode_t value);
 void jw_object_stat_data(struct json_writer *jw, const char *key,
 			 const struct stat_data *sd);
+void jw_object_ewah(struct json_writer *jw, const char *key,
+		    struct ewah_bitmap *ewah);
 void jw_object_sub_jw(struct json_writer *jw, const char *key,
 		      const struct json_writer *value);
 
diff --git a/split-index.c b/split-index.c
index e6154e4ea9..41552bf771 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "json-writer.h"
 #include "split-index.h"
 #include "ewah/ewok.h"
 
@@ -25,7 +26,7 @@ int read_link_extension(struct index_state *istate,
 	data += the_hash_algo->rawsz;
 	sz -= the_hash_algo->rawsz;
 	if (!sz)
-		return 0;
+		goto done;
 	si->delete_bitmap = ewah_new();
 	ret = ewah_read_mmap(si->delete_bitmap, data, sz);
 	if (ret < 0)
@@ -38,6 +39,12 @@ int read_link_extension(struct index_state *istate,
 		return error("corrupt replace bitmap in link extension");
 	if (ret != sz)
 		return error("garbage at the end of link extension");
+done:
+	if (istate->jw) {
+		jw_object_string(istate->jw, "oid", oid_to_hex(&si->base_oid));
+		jw_object_ewah(istate->jw, "delete_bitmap", si->delete_bitmap);
+		jw_object_ewah(istate->jw, "replace_bitmap", si->replace_bitmap);
+	}
 	return 0;
 }
 
diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
index 082fe8e966..dbb572ce9d 100755
--- a/t/t3011-ls-files-json.sh
+++ b/t/t3011-ls-files-json.sh
@@ -44,4 +44,18 @@ test_expect_success 'ls-files --json, main entries, UNTR and TREE' '
 	compare_json basic
 '
 
+test_expect_success 'ls-files --json, split index' '
+	git init split &&
+	(
+		cd split &&
+		echo one >one &&
+		git add one &&
+		git update-index --split-index &&
+		echo updated >>one &&
+		test_must_fail git -c splitIndex.maxPercentChange=100 update-index --refresh &&
+		cp ../filter.sed . &&
+		compare_json split-index
+	)
+'
+
 test_done
diff --git a/t/t3011/split-index b/t/t3011/split-index
new file mode 100644
index 0000000000..cdcc4ddded
--- /dev/null
+++ b/t/t3011/split-index
@@ -0,0 +1,39 @@
+{
+  "version": 2,
+  "oid": <string>,
+  "mtime_sec": <number>,
+  "mtime_nsec": <number>,
+  "entries": [
+    {
+      "id": 0,
+      "name": "",
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
+        "size": 4
+      },
+      "file_offset": <number>
+    }
+  ],
+  "extensions": {
+    "link": {
+      "file_offset": <number>,
+      "ext_size": <number>,
+      "oid": <string>,
+      "delete_bitmap": [
+      ],
+      "replace_bitmap": [
+        0
+      ]
+    }
+  }
+}
-- 
2.22.0.rc0.322.g2b0371e29a

