Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0B020248
	for <e@80x24.org>; Tue, 26 Feb 2019 00:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfBZA04 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 19:26:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39963 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfBZA0y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 19:26:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so11961717wrp.7
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Vaqn0NYc4sfnkvexQVfNnHA6qePpy/sFPXV9RNmxks=;
        b=Nf2CQsEyCbjksNq5G8PKriFACu9bYokJ3j+/9z4XPJOmw85IbBn++25wNmIGVBVPjB
         YBf0fqXdXJMEDhnKslfZYfh7tXPdZWeAeXBjuFIIkD3KHOIi8kJDstkl/kq3D6lZsmOz
         MokFUJgRdJwp+VZ+JWgRZl9XHB4jc/yFIjVo2odc1bNQqY8k7Sd023i7ozTLjrroDL1Z
         q6NpDrGoRq47BBm0BQr5BUpnepNILe4MFZK6ygD5K1b4MfAODtjr0pLo78GPUPh8Hz8B
         Cv742r21+ielLjs9pWAOxyjhqtUn3QePRbzdtU16jDTV2uDp/xt/67rmd7xcn+lrYpaC
         xbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Vaqn0NYc4sfnkvexQVfNnHA6qePpy/sFPXV9RNmxks=;
        b=tQkQbPxgndGSPmqgW+Pay/5PfR9iN4oGYZZECxDY+Zl6BOvYCH6z3qM6TMIiRW/Of6
         zqmJ1u+3NlKMT45Qs+C6ucIo9iKWbSnJlFTL6S8o2E4SMcle9vcgPcadmATjG8tU7o/m
         SrutR+hT48T/BLN/WhJNQN5e39DdrS6p0at+0QkLgnJ1qRt9QEwANKz1ZRhW/L8qcjKR
         S9zlocK4MCRElVjfwShAqwVZgn59yaclKVMduTId14ti2IYm0OJHnD3fCT0x57obKvt3
         JN7jr+N5GcJPNgtLea1o3UUo8F8bdnNwAKAAK6d0cCyZYe/F4O3+LIoTwud8CdlBvejx
         O8Vw==
X-Gm-Message-State: AHQUAuaxEId/BvrxZgSqyzHW9ZL5HO1Ito+G4o1ImMCNCQHiuE63GZ56
        of61Ygv0c5KGpdbVAGaSRlHj2o5vYwI=
X-Google-Smtp-Source: AHgI3IbeVi179EUyg/5DfLTDGoVrpUgWOtFsewTryDNA+Le5Qbx+CMgQV6TAmSCnZ8sitv2coCMAgA==
X-Received: by 2002:adf:8294:: with SMTP id 20mr14871414wrc.223.1551140811811;
        Mon, 25 Feb 2019 16:26:51 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm11745708wrt.14.2019.02.25.16.26.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 16:26:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [WIP RFC PATCH 5/7] clone: use dir-iterator to avoid explicit dir traversal
Date:   Tue, 26 Feb 2019 01:26:23 +0100
Message-Id: <20190226002625.13022-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
References: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matheus Tavares <matheus.bernardino@usp.br>

Replace usage of opendir/readdir/closedir API to traverse directories
recursively, at copy_or_link_directory function, by the dir-iterator
API. This simplifies the code and avoid recursive calls to
copy_or_link_directory.

[Ævar: This should be bug-compatible with the existing "clone"
behavior. The whole bit here with "iter->relative_path[0] == '.'" is a
dirty hack. We don't copy dot-dirs, and then later on just blindly
ignore ENOENT errors as we descend into them. That case really wants
to be a is_dotdir_or_file_within() test instead]

Now, copy_or_link_directory will call die() in case of an error on
openddir, readdir or lstat, inside dir_iterator_advance. That means it
will abort in case of an error trying to fetch any iteration entry.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c | 55 +++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 862d2ea69c..c32e9022b3 100644
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
@@ -411,42 +413,47 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
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
 
 	mkdir_if_missing(dest->buf, 0777);
 
+	iter = dir_iterator_begin(src->buf, 1);
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
+		strbuf_addstr(dest, iter->relative_path);
+
+		/*
+		 * dir_iterator_advance already calls lstat to populate iter->st
+		 * but, unlike stat, lstat does not checks for permissions on
+		 * the given path.
+		 */
+		if (stat(src->buf, &st)) {
 			warning (_("failed to stat %s\n"), src->buf);
 			continue;
 		}
-		if (S_ISDIR(buf.st_mode)) {
-			if (de->d_name[0] != '.')
-				copy_or_link_directory(src, dest,
-						       src_repo, src_baselen);
+
+		if (S_ISDIR(iter->st.st_mode)) {
+			if (iter->relative_path[0] == '.')
+				continue;
+			mkdir_if_missing(dest->buf, 0777);
 			continue;
 		}
 
 		/* Files that cannot be copied bit-for-bit... */
-		if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
+		if (!strcmp(iter->relative_path, "info/alternates")) {
 			copy_alternates(src, dest, src_repo);
 			continue;
 		}
@@ -456,14 +463,18 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf))
 				continue;
-			if (option_local > 0)
-				die_errno(_("failed to create link '%s'"), dest->buf);
+			if (option_local > 0 && errno != ENOENT)
+				warning_errno(_("failed to create link '%s'"), dest->buf);
 			option_no_hardlinks = 1;
 		}
-		if (copy_file_with_time(dest->buf, src->buf, 0666))
+		if (copy_file_with_time(dest->buf, src->buf, 0666) && errno != ENOENT)
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
@@ -481,7 +492,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 		get_common_dir(&dest, dest_repo);
 		strbuf_addstr(&src, "/objects");
 		strbuf_addstr(&dest, "/objects");
-		copy_or_link_directory(&src, &dest, src_repo, src.len);
+		copy_or_link_directory(&src, &dest, src_repo);
 		strbuf_release(&src);
 		strbuf_release(&dest);
 	}
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

