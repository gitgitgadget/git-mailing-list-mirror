Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3FD1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbeCCLib (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:31 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38530 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCCLia (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:30 -0500
Received: by mail-pl0-f68.google.com with SMTP id m22-v6so3677778pls.5
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fULQkOlUXZqxSwItAWHYsDD6v6V8TKrdlAhvA0qFgFQ=;
        b=No/rhXwYH13xfDIKMPdOzW6HqAs3hYe0b3zV9dovxPLZGMe5HVlbsIvKTDa6Pyg9Zk
         gWfwgkJiHK/YBOxdLu13G5pnDnJf6d8259K+gBZjtLDmPK6SINpktrm/8cV+ds0TPMox
         JkB1xPDzsEC5VzPz9ycktneiYUImT50gFHXzfWE+1bAa2J6rppaab6wkdf1WMuXUKSdC
         IjpEckVhWoa9fny5iutbfBPDRk62ufINYb0SH16oiB7+IPAHuox9ctC9Hni86fn0hME8
         whdvAIyZ0DLplv54p28AaEdARoUUQMg6Z9jKz65jSzJ4eJ9Y31eekpZfdXz4dEI8i7OQ
         7UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fULQkOlUXZqxSwItAWHYsDD6v6V8TKrdlAhvA0qFgFQ=;
        b=LTcMsCUtY7nxDYs4tC29rlvaE4WgqP3LaqHYBNJ2XApyl+Mt0XxkqM9IUmx3xa/W8B
         OmVaINPe0MlSVarXlVkorMfAXKArCqaDtF12oGQSs6HpyfEYzs0WpzBr8cheuDSuHmMI
         qtSjKmEdq9gwrifk6FIQeBSwrv5hvJWXGrVgos8JAWX+TsF+F8PUGiPHjiHekUH8t4Up
         xoIUzmqSqHATFwQz/yYWR5gIPkAPbGOFz7Wk5tpeEG0E2lNDz8LBG/Ve9sbASTUv792k
         7WzYD6oZaktmQnM9VFyNgE+vjfYLd7s5sC2jrVMGkEUNc5BzYzlzL2ta3vRKSFJrRb+y
         xgwQ==
X-Gm-Message-State: APf1xPAYWxL2cMb7pbANFSuV40WQeQTUmKl27NLBivCkEAYQFhV90/q7
        KjLAaKZvXZ3j0UUEvg7tBPCWbA==
X-Google-Smtp-Source: AG47ELsIxDkh2dAEtHwc5jVgSf87nIW0D6G5Fnca16rdvTTAkm5ovuWdMib9/3BkuhbEsytoLUwzGA==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61-v6mr8121540plr.398.1520077109823;
        Sat, 03 Mar 2018 03:38:29 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id n66sm16508404pfn.111.2018.03.03.03.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/44] sha1_file: add repository argument to sha1_file_name
Date:   Sat,  3 Mar 2018 18:36:14 +0700
Message-Id: <20180303113637.26518-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
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
index 07c2b1af82..2c33969123 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "commit.h"
 #include "walker.h"
 #include "http.h"
@@ -545,7 +546,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		sha1_file_name(&buf, req->sha1);
+		sha1_file_name(the_repository, &buf, req->sha1);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index 31755023a4..df9dbea59c 100644
--- a/http.c
+++ b/http.c
@@ -2246,7 +2246,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
-	sha1_file_name(&filename, sha1);
+	sha1_file_name(the_repository, &filename, sha1);
 	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
 		 "%s.temp", filename.buf);
 
@@ -2395,8 +2395,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile);
 		return -1;
 	}
-
-	sha1_file_name(&filename, freq->sha1);
+	sha1_file_name(the_repository, &filename, freq->sha1);
 	freq->rename = finalize_object_file(freq->tmpfile, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/object-store.h b/object-store.h
index 141455b5b2..f09acfbf5b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -115,4 +115,11 @@ struct raw_object_store {
 void raw_object_store_init(struct raw_object_store *o);
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
index a3e4ef4253..e06d62a451 100644
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
2.16.1.435.g8f24da2e1a

