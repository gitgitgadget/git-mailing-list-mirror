Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44B51FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeCWRWI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42905 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeCWRWC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:22:02 -0400
Received: by mail-lf0-f65.google.com with SMTP id a22-v6so19371145lfg.9
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRjnhaaPyXIFFerIDO7JFHv+jBU5odt4uLh7FWIwyp0=;
        b=dPMUbGTu47ffZbijTUVvqsQOUXFdOROZYf4ky8qrfQBQFLDDtRCyjlUz1NPnHTaw6a
         508xd4xP3qPmTu9/BnvJLLL/tUCXP46SEOhXZXz75dOBme1KciUR61Hi+XtvLI6SW1Hm
         HI4JLWJQnwERGa3+2R03gdoaJQxEuRX32qaPLLMxePLFfVT+iI4SFXuls5PEtovtR0+2
         5uueLx9FLS+WIfUaEkfO335pApit3w0Q0X2FjSWPsN4/Meh0yVvlyvFdLnlgaw8xl1Xa
         ywy0SmwPu0qmgrN/oVSR5tOm3rdPJ3l1obcnspMf1MA0T80sEpKrxE4+pXs4HHM/SfeI
         FhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRjnhaaPyXIFFerIDO7JFHv+jBU5odt4uLh7FWIwyp0=;
        b=WSt70NUxewB7ae0kbZdE8LPFLQgsq2g8Iiimn6o3dVtJEaX2rppVXX1hBCDWMucvEW
         EsXR9dLKL/6QF984ro/bapDqd5QqsmP7Jl2kwiPd5QikXkLzN1bQ8U8KEpV4n2U3uCHV
         pEAs7pft0peDqy6oWB6krE5GgnQwGueJ45zP4M0AymhgBwu/pgCeB16Od1l7y6cGbZmk
         VLJNykjRKa2MDE/UPW7sUwUA9Hew6Qx1lF0Qu+ZY8Pgjh6hAjgJx60EW1M+zqF21htOb
         25a2nPFNTQsHAvtxsXWsngEjZv6sG1YdlXtF4WQp3xM2AjLTTX3v6Xa5NwqfrX3UJiHK
         E+tg==
X-Gm-Message-State: AElRT7HjC+xgEMhHJ3GH/1Nev7VK9mTsnnbyFbi/OIWcN8cEdHd18/xy
        zpvH/rwdQV8oTNuBnAvVAfc=
X-Google-Smtp-Source: AG47ELvdrOodw9e/G5iGWeTSnkS4SJGF9wG6jx3TWiqVYDhR9EEgE4/dMjpkj+DZ2ProbiKKbDQhZw==
X-Received: by 10.46.137.138 with SMTP id c10mr9054710lji.0.1521825721121;
        Fri, 23 Mar 2018 10:22:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:22:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/27] sha1_file: add repository argument to sha1_file_name
Date:   Fri, 23 Mar 2018 18:21:10 +0100
Message-Id: <20180323172121.17725-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow sha1_file_name callers to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

While at it, move the declaration to object-store.h, where it should
be easier to find.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h        |  6 ------
 http-walker.c  |  3 ++-
 http.c         |  5 ++---
 object-store.h |  7 +++++++
 sha1_file.c    | 10 +++++-----
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index d3429a0d48..cbec0ecd23 100644
--- a/cache.h
+++ b/cache.h
@@ -961,12 +961,6 @@ extern void check_repository_format(void);
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
-/*
- * Put in `buf` the name of the file in the local object database that
- * would be used to store a loose object with the specified sha1.
- */
-extern void sha1_file_name(struct strbuf *buf, const unsigned char *sha1);
-
 /*
  * Return an abbreviated sha1 unique within this repository's object database.
  * The result will be at least `len` characters long, and will be NUL
diff --git a/http-walker.c b/http-walker.c
index d850408d18..75d55d42a9 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "commit.h"
 #include "walker.h"
 #include "http.h"
@@ -546,7 +547,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		sha1_file_name(&buf, req->sha1);
+		sha1_file_name(the_repository, &buf, req->sha1);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index efa977112a..4d613d5f6b 100644
--- a/http.c
+++ b/http.c
@@ -2247,7 +2247,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
-	sha1_file_name(&filename, sha1);
+	sha1_file_name(the_repository, &filename, sha1);
 	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
 		 "%s.temp", filename.buf);
 
@@ -2396,8 +2396,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile);
 		return -1;
 	}
-
-	sha1_file_name(&filename, freq->sha1);
+	sha1_file_name(the_repository, &filename, freq->sha1);
 	freq->rename = finalize_object_file(freq->tmpfile, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/object-store.h b/object-store.h
index f54bc0b951..3707f3c495 100644
--- a/object-store.h
+++ b/object-store.h
@@ -121,4 +121,11 @@ struct raw_object_store {
 struct raw_object_store *raw_object_store_new(void);
 void raw_object_store_clear(struct raw_object_store *o);
 
+/*
+ * Put in `buf` the name of the file in the local object database that
+ * would be used to store a loose object with the specified sha1.
+ */
+#define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
+void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
+
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 04118f331c..fe16d30f66 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,7 +323,7 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
+void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1)
 {
 	strbuf_addstr(buf, get_object_directory());
 	strbuf_addch(buf, '/');
@@ -713,7 +713,7 @@ static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(the_repository, &buf, sha1);
 
 	return check_and_freshen_file(buf.buf, freshen);
 }
@@ -874,7 +874,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(the_repository, &buf, sha1);
 	*path = buf.buf;
 
 	if (!lstat(*path, st))
@@ -903,7 +903,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(&buf, sha1);
+	sha1_file_name(the_repository, &buf, sha1);
 	*path = buf.buf;
 
 	fd = git_open(*path);
@@ -1588,7 +1588,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	static struct strbuf filename = STRBUF_INIT;
 
 	strbuf_reset(&filename);
-	sha1_file_name(&filename, sha1);
+	sha1_file_name(the_repository, &filename, sha1);
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
-- 
2.17.0.rc0.348.gd5a49e0b6f

