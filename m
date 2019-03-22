Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A49C20248
	for <e@80x24.org>; Fri, 22 Mar 2019 23:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfCVXXJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 19:23:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33918 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfCVXXI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 19:23:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id n68so2259772qka.1
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 16:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+PBpvo64IKr3yBPeTcCw2yZHKIa9a/SpKxRmBnM4yo=;
        b=Y88FikOCdjLPP6iY+pffNEAdUCBTaWK2i3Phh2E6o+EVfBKNsDQnv4ufqQLk8PhGOI
         Daf95rezm3D6pYjUyekMNibA8U8+ih0LuL6ZdK/G7saPQmniMDoPE+15AgnS229dntvf
         z1APM55NyzqUmfIj92eqkIAK//09pfEWmXjK76btEdrgVoAZmyjKA5O5mqoZYvK9hUsr
         EMPkteJS7kq2M75qJOADOV+ArZs8FCB68KaPLJLpjTKjaBHq7vLjwTW2FcK6oQPYQWCr
         EJTYhE4Y5G9Iy6f2gsFzRhhpyIbaFnr90fHHnDXgKaYRLK9zZZQqWdEXKm5D2mq5ZT3H
         TOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+PBpvo64IKr3yBPeTcCw2yZHKIa9a/SpKxRmBnM4yo=;
        b=e3d7JzWKhJl0k9JucyfsYqzzUHWDgG+BTBsMy/uKJ7BAxWYuj661tYQjDOTMz/mUro
         8Rm4pnyBIQpGWsgPiCp8pOzDnk12f3T8ajbJrMpfCheFN9wESN6kG+pIaln2rWdAC2sv
         OrXFcwS7dKHI1AQIkQcO1/2vCBjKXx8yqi/YvG+cy6pvdSuUsadu7pQ+pn65QIstybyM
         cxdbbU2k65kgO5Qz29JkpBtDEt73WYTKNl+vo+J7yGqhl9v/Plc562SkcdtFvrAIpudk
         P31pbcT9Z2eypHC4R6jAMAsHqgSx5MByBoo+Ygk7Xl0a5EVChXAA/nSIF+Um3/CXgS4B
         610A==
X-Gm-Message-State: APjAAAXBiTnHSIQz5m6trHmNn1tJP7b2ZOZQpRKdtc3VLxrvm8pkITS8
        oDt7FYkvtSjsN+CPNymYTvo2y839uSM=
X-Google-Smtp-Source: APXvYqyGwmZC6Q3njEWNET/yP2BZU+/AjoZafHcLM3D6UX07E4lAp6QECQDuEpxjl6glQup7a+6czw==
X-Received: by 2002:a37:bd81:: with SMTP id n123mr9979686qkf.249.1553296987452;
        Fri, 22 Mar 2019 16:23:07 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id i68sm5002765qkf.42.2019.03.22.16.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:23:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v4 6/7] clone: use dir-iterator to avoid explicit dir traversal
Date:   Fri, 22 Mar 2019 20:22:36 -0300
Message-Id: <20190322232237.13293-7-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322232237.13293-1-matheus.bernardino@usp.br>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace usage of opendir/readdir/closedir API to traverse directories
recursively, at copy_or_link_directory function, by the dir-iterator
API. This simplifies the code and avoid recursive calls to
copy_or_link_directory.

This process also makes copy_or_link_directory call die() in case of an
error on readdir or stat, inside dir_iterator_advance. Previously it
would just print a warning for errors on stat and ignore errors on
readdir, which isn't nice because a local git clone would end up
successfully even though the .git/objects copy didn't fully succeeded.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c17bbf1bfc..4ee45e7862 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,6 +23,8 @@
 #include "transport.h"
 #include "strbuf.h"
 #include "dir.h"
+#include "dir-iterator.h"
+#include "iterator.h"
 #include "sigchain.h"
 #include "branch.h"
 #include "remote.h"
@@ -408,42 +410,36 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
 }
 
 static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
-				   const char *src_repo, int src_baselen)
+				   const char *src_repo)
 {
-	struct dirent *de;
-	struct stat buf;
 	int src_len, dest_len;
-	DIR *dir;
-
-	dir = opendir(src->buf);
-	if (!dir)
-		die_errno(_("failed to open '%s'"), src->buf);
+	struct dir_iterator *iter;
+	int iter_status;
+	unsigned flags;
 
 	mkdir_if_missing(dest->buf, 0777);
 
+	flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_FOLLOW_SYMLINKS;
+	iter = dir_iterator_begin(src->buf, flags);
+
 	strbuf_addch(src, '/');
 	src_len = src->len;
 	strbuf_addch(dest, '/');
 	dest_len = dest->len;
 
-	while ((de = readdir(dir)) != NULL) {
+	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
 		strbuf_setlen(src, src_len);
-		strbuf_addstr(src, de->d_name);
+		strbuf_addstr(src, iter->relative_path);
 		strbuf_setlen(dest, dest_len);
-		strbuf_addstr(dest, de->d_name);
-		if (stat(src->buf, &buf)) {
-			warning (_("failed to stat %s\n"), src->buf);
-			continue;
-		}
-		if (S_ISDIR(buf.st_mode)) {
-			if (!is_dot_or_dotdot(de->d_name))
-				copy_or_link_directory(src, dest,
-						       src_repo, src_baselen);
+		strbuf_addstr(dest, iter->relative_path);
+
+		if (S_ISDIR(iter->st.st_mode)) {
+			mkdir_if_missing(dest->buf, 0777);
 			continue;
 		}
 
 		/* Files that cannot be copied bit-for-bit... */
-		if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
+		if (!strcmp(iter->relative_path, "info/alternates")) {
 			copy_alternates(src, dest, src_repo);
 			continue;
 		}
@@ -460,7 +456,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (copy_file_with_time(dest->buf, src->buf, 0666))
 			die_errno(_("failed to copy file to '%s'"), dest->buf);
 	}
-	closedir(dir);
+
+	if (iter_status != ITER_DONE) {
+		strbuf_setlen(src, src_len);
+		die(_("failed to iterate over '%s'"), src->buf);
+	}
 }
 
 static void clone_local(const char *src_repo, const char *dest_repo)
@@ -478,7 +478,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 		get_common_dir(&dest, dest_repo);
 		strbuf_addstr(&src, "/objects");
 		strbuf_addstr(&dest, "/objects");
-		copy_or_link_directory(&src, &dest, src_repo, src.len);
+		copy_or_link_directory(&src, &dest, src_repo);
 		strbuf_release(&src);
 		strbuf_release(&dest);
 	}
-- 
2.20.1

