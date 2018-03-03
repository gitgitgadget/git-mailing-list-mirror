Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71E71F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeCCLiv (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:51 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34647 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCCLiu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:50 -0500
Received: by mail-pg0-f67.google.com with SMTP id m19so4870411pgn.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y3ka6F2iRHg/OnIy05eMhzZOMizkCYie/x1/uCZ4AXw=;
        b=tbR0IJ6YnMILdhxiF+jmjgLB+/6jQpWerPGMZAckDXokTmYV2T0gDXhzUNmd0/Wiwm
         wKp6nXmz0eQL3GWOBqIdmRoCRxWeRjYFKLFd5SWqEQVydgXNiEIHhib5IHb73liOSxa9
         OGuR2jOtcTTxOcf3Cstp90QyurZOnj/mSEJeulIDGAJ/WN9wNvLcnwfefIt/DCynzh0B
         FjNwiKTZC/u7tNwYezfkKw6jt8DXvnbzs9JMJY6s+rZUPz9KAfvL550nzWrbpqdPdfgS
         aqFimJxeM2Ay9Ix/f6R9YTuniejDSpLKNDabAaxh/+sIK4urRiUDMM/wBvHbZpBw2/8J
         wfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y3ka6F2iRHg/OnIy05eMhzZOMizkCYie/x1/uCZ4AXw=;
        b=ouBkFbv40RwxZu4y6uvbADceLufgC+BFrhJLEgRL9R0hFH9dRyRhIViFx3ipT51ZRX
         X0k5Qte/prABIxJ7Glf/3/kQRVP38uimBA4j098k6UDCLqmJecNw+yTzWXSncgFtGCez
         O3g4epf6tk5LXWzLFV7g4+LnZbAbk5GkpotdPncfr8ePLISOKMVe9Sma1u3BxLL18kEm
         gVoBBCsRYmmWT/A577xEJsYMx+SRThvlD5oDRbVIrXCXn7u+cn0o9qyd+cqk+bY6XzpP
         2wCk/BBBMBe/unqGoIfvs9fd5o5gvukOZU+0anZVRgc/JsynDOJFCPpx8kNFEaDoztgg
         1OHg==
X-Gm-Message-State: APf1xPBM7fb4cEV/3mn7Hu7jfXWSohy9HcylmwmO16SdnHBLlGvbfESZ
        4n3lUEc6JWTqtk2jHuOsgtT1jQ==
X-Google-Smtp-Source: AG47ELsGROFZkW4Ud6XW/h1tQeT+NuOBmyE/BlqbHG5a+hCrwboJ8KmAK9W5Dw73daoA7VnV/SFpww==
X-Received: by 10.98.166.85 with SMTP id t82mr8720933pfe.237.1520077129301;
        Sat, 03 Mar 2018 03:38:49 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id n7sm14792093pgd.87.2018.03.03.03.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 25/44] sha1_file: add repository argument to map_sha1_file
Date:   Sat,  3 Mar 2018 18:36:18 +0700
Message-Id: <20180303113637.26518-26-pclouds@gmail.com>
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

Add a repository argument to allow map_sha1_file callers to be more
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
 cache.h        | 1 -
 object-store.h | 3 +++
 sha1_file.c    | 4 ++--
 streaming.c    | 5 ++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index cbec0ecd23..720664e394 100644
--- a/cache.h
+++ b/cache.h
@@ -1242,7 +1242,6 @@ extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned c
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
diff --git a/object-store.h b/object-store.h
index f09acfbf5b..ad4c7501d7 100644
--- a/object-store.h
+++ b/object-store.h
@@ -122,4 +122,7 @@ void raw_object_store_clear(struct raw_object_store *o);
 #define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
 void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
 
+#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 78d5ffe876..536c45589b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -961,7 +961,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	return map;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
 {
 	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
@@ -1185,7 +1185,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return 0;
 	}
 
-	map = map_sha1_file(sha1, &mapsize);
+	map = map_sha1_file(the_repository, sha1, &mapsize);
 	if (!map)
 		return -1;
 
diff --git a/streaming.c b/streaming.c
index 5892b50bd8..22d27df55e 100644
--- a/streaming.c
+++ b/streaming.c
@@ -3,6 +3,8 @@
  */
 #include "cache.h"
 #include "streaming.h"
+#include "repository.h"
+#include "object-store.h"
 #include "packfile.h"
 
 enum input_source {
@@ -335,7 +337,8 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
-	st->u.loose.mapped = map_sha1_file(sha1, &st->u.loose.mapsize);
+	st->u.loose.mapped = map_sha1_file(the_repository,
+					   sha1, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
 	if ((unpack_sha1_header(&st->z,
-- 
2.16.1.435.g8f24da2e1a

