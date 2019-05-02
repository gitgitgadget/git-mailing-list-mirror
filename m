Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9666D1F453
	for <e@80x24.org>; Thu,  2 May 2019 14:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfEBOtO (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 10:49:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34643 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEBOtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 10:49:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id j6so2809580qtq.1
        for <git@vger.kernel.org>; Thu, 02 May 2019 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lPjxZkJsQDvJPO172O4AQCR9eAPcBvA1hjIQrPgUKzM=;
        b=L1cg9lbTAFW6SUDgps+IuRyY9EnSGzUGW90KTWPv45vmzmMfGTILCOaAXXiDiKjRR4
         YsrZYC/pXnH1kmInXArFET7RxjFpCs9uB2Vbp/3jsHtpGIxuTESai4FT1E/60f305zfl
         RZD0XqWTxjbzVguwN5+HVP6+FYy1ohAEqE3ulhjTE1wzEW5Lk7TZWUQUGytk3vCV/yi1
         cPXqV0qaV4o9rDc8HmvUkOVz3/3iMe+08N0DlH1L443V+9TQ4uazH/6S4YJdVnr1xBr2
         MQHwqZPznggegWhy8hz6/xyDMh8gVGrqqFDS651b3mR5tjb+ql2veexwr++QW/TqqAkC
         Bsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lPjxZkJsQDvJPO172O4AQCR9eAPcBvA1hjIQrPgUKzM=;
        b=J1E17ybIJ2HLlrtEacf2qDYg3tZh/5oyO0IPU8lhH1nSEXwlxYi1o6yc72INLGSnuM
         m6Lwxu0D8yCD58+gR8LvX8fK/P0uOtql/7ucwhR/fSsnPLBObnGMVJ/twK9xkh9jxWQD
         CLr/cz7H2MbdOnqZKrfwBuOpM36JPlCe2EsOAa8lhOK4Zvjx5S492LZ4rf+YeIkJvmIJ
         uJwMNe32ZK0S1c93WMnxl58+BsxXSBRNDMgbnmmFLxKFLf3DWVCgFJsBF4CPlIcQ2HhO
         s9a+XHIcF2uGfiJMpC5VsdSXOblfxwHC165bUrXnvUCdrJirMI3slqCxuF8ND5HrJ14Y
         XF6g==
X-Gm-Message-State: APjAAAWmmQZB3mR9S+BB4/C3Qnh2wIJwoOFZ+CcpSKyPVwvza1+dSNUT
        Z0GJB38DHTJsF8/ybpx7nIXQsqIkB6c=
X-Google-Smtp-Source: APXvYqwUjYU2nFffV0uW6V5SAoOAX5veuvorFA7yiQoqjE32UWTMX6n3BR+VuJhoTyy7t7iZJFhcqQ==
X-Received: by 2002:a0c:9b01:: with SMTP id b1mr3459235qve.100.1556808552576;
        Thu, 02 May 2019 07:49:12 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id s64sm22002880qkc.39.2019.05.02.07.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:49:12 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v6 09/10] clone: use dir-iterator to avoid explicit dir traversal
Date:   Thu,  2 May 2019 11:48:28 -0300
Message-Id: <20190502144829.4394-10-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502144829.4394-1-matheus.bernardino@usp.br>
References: <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190502144829.4394-1-matheus.bernardino@usp.br>
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
index 1ee6d6050e..f99acd878f 100644
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
@@ -408,42 +410,39 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
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
 			copy_alternates(src, dest, src_repo);
 			continue;
 		}
@@ -460,7 +459,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
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
@@ -478,7 +481,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
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

