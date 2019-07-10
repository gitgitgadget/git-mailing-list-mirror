Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5391F461
	for <e@80x24.org>; Thu, 11 Jul 2019 00:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfGKAAd (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 20:00:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35670 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGKAAd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 20:00:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so4493622qto.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 17:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVkq6cenj1ZapQF1Fr1X5AkjZwd58aekWv74Ku8RjIg=;
        b=LOUWGg9uNKDBH9dPxD2wn5q+COAEWdZ7SX3Eo3mlypm7dzoso1pnooIowj7v83aLQt
         ZYHucljH1CSAl2/ToLOwiub7wKo30VJ8utX+z0ER5v5gmpt/Wi4MTGQ78EVZylxuqxeF
         Un1MsrLOosOEhGnasDqu+JcjonlXhu/z8c9utEOyfaWHG35WWhhMRiS580h1MCERe7xf
         JCGedmmzScaSLSKg1gOMeqPBMrsAtz7yuYfcN5yfrB8kxU9WkgExnF7+emiD36J5gelr
         MLwOBGHBUnuBn2T18OsfEn1xNZIVb9HMW7o+sdegI/v4PiUBUTeqCuW2JP03Hl86oqIe
         IMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVkq6cenj1ZapQF1Fr1X5AkjZwd58aekWv74Ku8RjIg=;
        b=JDNhC3Q5WZbnUzhOtC/XScnVJARJa7wC0k6f2W35PID27gjPQvI8e8+aCgnfjZi+t2
         7X4VOJgzd8RRBm+XrLWlTpNv3VM/bQ14Yh8bGr9y4ej2+7bxFz5B8QOGBhohMZuCXHiZ
         tzWmY7h+ou40Ycx25pYoKYn2u8v793D6ftV+91UvAPlFby6d7hNWF6aKIQGT1lqX3cBd
         Las7uPBt/8fmg7j9Up/3SZYmkcJ4wTcFDghx6zHLTN6WSqSWjZFkUNUcC0WnZ+ANO32N
         LLsZ9WqIpZ+qlezjkMVS8qlrMJ19T2vpms5Vz1lgFkU70pD3EmD5mzbBLbw6PQ0q9ooi
         gUIA==
X-Gm-Message-State: APjAAAW8oDg7V5znFPBeMiwGhjOHisouX4iiXeXpyorxx9g+slIjzVxJ
        RVEuu5Ld2z/carR58Cz/HTixRQ==
X-Google-Smtp-Source: APXvYqwN0q1zSg99W/Bf/lmFltIEddz628AWsSUEhb/+tOpZnAdLlMRyBrQthkTWKtnkNdQyPLVpMA==
X-Received: by 2002:ac8:30d2:: with SMTP id w18mr624948qta.296.1562803231734;
        Wed, 10 Jul 2019 17:00:31 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id x8sm1714546qkl.27.2019.07.10.17.00.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 17:00:31 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        kernel-usp@googlegroups.com, Jeff King <peff@peff.net>
Subject: [GSoC][PATCH v8 09/10] clone: use dir-iterator to avoid explicit dir traversal
Date:   Wed, 10 Jul 2019 20:59:03 -0300
Message-Id: <e8308c74085689876e25cc88e5628cfd68fc1606.1562801255.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562801254.git.matheus.bernardino@usp.br>
References: <cover.1562801254.git.matheus.bernardino@usp.br>
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
though the .git/objects copy didn't fully succeed.

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

