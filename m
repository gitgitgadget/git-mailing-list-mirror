Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F9520248
	for <e@80x24.org>; Sat, 30 Mar 2019 22:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfC3Wti (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 18:49:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41292 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfC3Wti (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 18:49:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so6491905qta.8
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 15:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YUCTh4hKuaIaCiI+7pw9czoTv/o3s2VHTp+oCDfcbu4=;
        b=K5aWVreAl+7xcdoMVEm/5x9Rpn6eZuit60YIrM5gSAV/P5vT9kfkaUAq0J7s3zIN+g
         0HJaRMs7URzj2Xguxmg0TxriCP1Ij68796nxAJfbyANeHHXbuYFx3OQMc7ZU7wepsWSg
         /9YCcPHRSVqavtdoQ6t3WbQNyOj5aZMFs8eKEKHXFnFq43oY0voronHhSEfKWJoaRjFM
         Z85+rchXDdwTOP5thR+6xr8yTJB+piV7fVw2YbO8CXotJOseLgRlD5sfKMWwGHbvhFI/
         TPB/+4XwmV82oZ14CK9WPp3rBwzq44eAbXPeyteHKa5QQfdsOKHGyirHjJNaNKrNIx/r
         W/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YUCTh4hKuaIaCiI+7pw9czoTv/o3s2VHTp+oCDfcbu4=;
        b=rauDUoLJ8ZUfTqmnwmYh7v1ZFnj0u00IVqaS6VZwbYTVNA1vq1BEErWdqkMUuk6tt9
         9CrvXoSD5DiwHq1pOUAhVHWP4xQ17FEsxlDdneKL3uaLrilY8YXP3I/1rJ2ErobnGz+X
         4oCx8jxuF1+53/nsD60FAd5ETxqxHVZYqVhO2TLj7SefWJgdPxRhnmmKDIWXPsPR3dNz
         wVrvl2Gk6DmlnwTjNeloK3xzuiYuhpXr1tuR+Dh9prnGuZQWL7MrZCqS1bregxZV1obh
         flHsOF3+1ctb6AaQVs11LZlpcUcmPG8bmZIqrp6AVAZLzykuapFaCe7fUfiGVke3gxj8
         UHIg==
X-Gm-Message-State: APjAAAVzK8wMl/woLqexN3lcZ3rvPaejE8WZbeY5Ogs6wp5ogAdU1ape
        +BbaJg7vAUIx/w8++aLNZ9UDcA==
X-Google-Smtp-Source: APXvYqzurJqoDIQalye5R6Z7zfYF0GtWDTDbXdoBsCqLvL7ewUB0Afr5DjaD/k4H9mfF4ncE+VGpvg==
X-Received: by 2002:ac8:6b98:: with SMTP id z24mr23495601qts.248.1553986176869;
        Sat, 30 Mar 2019 15:49:36 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::4])
        by smtp.gmail.com with ESMTPSA id x191sm3139943qka.78.2019.03.30.15.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 15:49:36 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v5 6/7] clone: use dir-iterator to avoid explicit dir traversal
Date:   Sat, 30 Mar 2019 19:49:06 -0300
Message-Id: <20190330224907.3277-7-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330224907.3277-1-matheus.bernardino@usp.br>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
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
error on readdir or stat, inside dir_iterator_advance. Previously it
would just print a warning for errors on stat and ignore errors on
readdir, which isn't nice because a local git clone could succeed even
though the .git/objects copy didn't fully succeed.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f348eb02d4..ebe8d83334 100644
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
@@ -463,7 +459,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
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
@@ -481,7 +481,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
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

