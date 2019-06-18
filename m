Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26ED21F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfFRX3n (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:29:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35970 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX3n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:29:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id p15so17696450qtl.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fu0ZaITrLpRzB5mU/BeP7aSo/y6+b2a/VCRECbfe91I=;
        b=h3wUSK8me4YYLUU6UKJgPmGcJoZX0hZcgWAHreeNS+/aoWcDLHGE7iSvsGKm3aYhSx
         RruZ4kSipvYEYtkLikURNHD5c5AfC2Y5Tfw0k8wWCou/XHo1+7FRiIxaRFj/N+0AHDkg
         lQrzzdfGEyHnEh6ofBab7ZOcJTPPkwfCwjBxnjggaG5XD26yLmArXwys1yvIi7+jYxNT
         mwyd8vN/FJkcYMidn//pe1/onyJ54pKlhbSnwzVNCAfRSSjBLseppD0IO+Y/9kOjLrny
         cwnGcnBsOMMk2dCivKm/ZRer+47cs9Jqo9J8Ffw/OpvBovr1RFdjcglTd3YBmHowM4VQ
         yXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fu0ZaITrLpRzB5mU/BeP7aSo/y6+b2a/VCRECbfe91I=;
        b=qWq2Bu3DVquiqk8cPWEleWv5/j1Yh0WyGrlo4WuTXn1f2cNHIWLEpk+DVcJUrmr3dz
         LyJkz5mBtsHZXnu3GiUNWs67Mlo3yjKKN16P0x2V1NddkQUnOMq2qKo3LJXHqjfKkN65
         DgH9bzUqh91NRiCwLEksjmOaMxE+yGIyvR9ceptnjlKhvWJCZwOFpTPj/8qeG7JshFX4
         8YsMvLY7mAVYu4JJJQiFp8gdJSRpwk/ZaJsyluN3WelaLiOVH1dsJ4UyvZ9eQJTVYPro
         zujBT23k+zd3WR6r5ls2R7QHvZhOyDvRMaTli3poJkmUqRFhdZhJPG+V7RbdQcVj8arh
         mfeQ==
X-Gm-Message-State: APjAAAXBe349JpFysKje5VvFNG38CR2NeLWq19aieFAgi7KfDQU5AFTk
        YYRH6N5I3KTplT85u0tnm9t3QZUsNJo=
X-Google-Smtp-Source: APXvYqzrHcs8CylTXfFySeAKJDCyd5AAZr0kQUgAp7o60Q28n8HsUmd+42K0PNkmke9u9s/pZXrWcg==
X-Received: by 2002:ac8:82a:: with SMTP id u39mr45966759qth.370.1560900581616;
        Tue, 18 Jun 2019 16:29:41 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e18sm4828997qkm.49.2019.06.18.16.29.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:29:41 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: [GSoC][PATCH v7 09/10] clone: use dir-iterator to avoid explicit dir traversal
Date:   Tue, 18 Jun 2019 20:27:46 -0300
Message-Id: <47ccb3be1a92a30cbe084730e4a139f049da1351.1560898723.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br>
References: <cover.1560898723.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace usage of opendir/readdir/closedir API to traverse directories
recursively, at copy_or_link_directory function, by the dir-iterator
API. This simplifies the code and avoids recursive calls to
copy_or_link_directory.

This process also makes copy_or_link_directory call die() in case of an
error on readdir or stat inside dir_iterator_advance. Previously it
would just print a warning for errors on stat and ignore errors on
readdir, which isn't nice because a local git clone could succeed even
though the .git/objects copy didn't fully succeed. Also, with the
dir-iterator API, recursive symlinks will be detected and skipped. This
is another behavior improvement, since the current version would
continue to copy the same content over and over until stat() returned an
ELOOP error.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 96566c1bab..47cb4a2a8e 100644
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
@@ -410,42 +412,39 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
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
+	unsigned int flags;
 
 	mkdir_if_missing(dest->buf, 0777);
 
+	flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_FOLLOW_SYMLINKS;
+	iter = dir_iterator_begin(src->buf, flags);
+
+	if (!iter)
+		die_errno(_("failed to start iterator over '%s'"), src->buf);
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
 			copy_alternates(src, src_repo);
 			continue;
 		}
@@ -462,7 +461,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
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
@@ -480,7 +483,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 		get_common_dir(&dest, dest_repo);
 		strbuf_addstr(&src, "/objects");
 		strbuf_addstr(&dest, "/objects");
-		copy_or_link_directory(&src, &dest, src_repo, src.len);
+		copy_or_link_directory(&src, &dest, src_repo);
 		strbuf_release(&src);
 		strbuf_release(&dest);
 	}
-- 
2.22.0

