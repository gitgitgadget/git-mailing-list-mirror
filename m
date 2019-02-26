Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D25C20248
	for <e@80x24.org>; Tue, 26 Feb 2019 05:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfBZFSc (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 00:18:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46284 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfBZFS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 00:18:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id z25so13472690qti.13
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 21:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVm1/NUY9NbnABf9WlDCR44AvDf3yo7MK5/rODO+KJs=;
        b=lDga0dgNCdnxWCbq/sfSr4oRQv+IeCoy+UCAY36euL8vJu4mtYeobqd7UOrPJ7dlxL
         /8KaTTLuLacmnt8FCnm/FxcUzu5JTPa19VmeDASQIPWfax5Gh9gaAZkvFqJFZd2TEwLo
         GjBFOlYOb0+p9X18XG22+Lcd5zfBLLnZNQjdhrirp18ljAmQnSv6dHkzzw+AIQege4+H
         OsNBjjlC6XmigIwKEJigWisTlFfys+/CynHGjc9awf7D38O9Hq+ISu5yNWZT6iXoIi6K
         qJkWvhDe+GcO0W+/UNOBJL2KjYlrB8GCPghe62uhmrepap5PqvsNp/MMl1sjlmQ9RKAH
         LjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVm1/NUY9NbnABf9WlDCR44AvDf3yo7MK5/rODO+KJs=;
        b=gYuKLFXgco83C9S85JM5B/ZsTNlOjoH0q8Y7OVnoFRT8OMycXDJsn4euC9Mb+H4o9g
         +C6WUHvID/w4ZHJsleHV6NymRbxZXNJn9iEQmqAcLX+10xrnmkTUgv1jJhrCpEa0tn0k
         77990VmX1Y6NwoZl2PgC719jkj9rujDP6iuFusfyHChSMahPhZHU+1jFRQ0TiNJf4iuk
         r7EbPBvQ3J0fDiEqAKOoWy2JkxUp3MajAy1K8Emtgkmsh7oA4rQ5GiNXiue07IsADcpi
         JLOUGVQTS4TQ6wanXLAVX49ip8ip+FS32FU07nHnlGqevoYSHV5K7T/14qxlGt/59J0u
         MDow==
X-Gm-Message-State: AHQUAuaCYlCSleVIleevczhI8sF+ln5YlM6LXqxbWsXiRW3f7UL52CX4
        0UVhbYingJPi3mI9NMu24ARJQPVM8Q8=
X-Google-Smtp-Source: AHgI3IZxgdg1YuynNx3r7dO/UYYX/9KcLx+trc/ObHIqfDgAc7MJXhiQW4FIBBSUb/kYO5bKAmt/pA==
X-Received: by 2002:ac8:3559:: with SMTP id z25mr10097073qtb.336.1551158307113;
        Mon, 25 Feb 2019 21:18:27 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id k39sm7698738qtb.37.2019.02.25.21.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 21:18:26 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [WIP RFC PATCH v2 5/5] clone: use dir-iterator to avoid explicit dir traversal
Date:   Tue, 26 Feb 2019 02:18:04 -0300
Message-Id: <20190226051804.10631-6-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226051804.10631-1-matheus.bernardino@usp.br>
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
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
I can also make the change described in the last paragraph in a separate
patch before this one, but I would have to undo it in this patch because
dir-iterator already implements it. So, IMHO, it would be just noise
and not worthy.

 builtin/clone.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fd580fa98d..b23ba64c94 100644
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
@@ -411,42 +413,37 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
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
+	struct stat st;
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
@@ -463,7 +460,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
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
@@ -481,7 +482,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
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

