Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E5320966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbdCZCnj (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:43:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32811 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdCZCni (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:43:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id p189so4074941pfp.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmKrmFUkcC0mupHDIWWb3yy+0luEcfw4NH+KXU3ozQo=;
        b=MDXlEodX5PXmzZtwqf+D6S+3J6gbD0vjoeT9QfFIZq5NeRqrZnljXp4nt7NdbC2cA1
         GRMEj809ZJnnIH/czsHEjRe27G752l441LbrcFXBRmeOx/vQpNzCLhs+L3y6DFjrR/9w
         7RwFf+T5yzOt2PxeBA5ZJK/kG2sPfSxYXyMX1FNP43YlZwnypespxJJO1O/zTNH9Gw4Y
         Ro8/hdACaMZ3mAUN5cNlexiLTW/ZvYEyO69ZJZBORCBQpbY4fZxQ6+WYCWyxlvSskH9o
         zzDtNTgtCPr8+IGK1nmdUum7XRBSS9UwPZ5QozqWdaO65oUKUJhWxGLF59q0yBIDuMzE
         DBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmKrmFUkcC0mupHDIWWb3yy+0luEcfw4NH+KXU3ozQo=;
        b=a4WYKE5ZlG/j5KLDoiS5B8n/ouEjvwKDYS9eeHEWR3lvBOgcYRvY0ECIjO8w8dy6CW
         SXVo3wUX1HME7qadi57+K+4KL04ULg8ypudffX0WybQ/Ha9eXWZa3kfU4A5ncLWZPIBD
         f72hmX60Codp8l88/BX85zOZC2SAKHvXzbTf7HoFmUaQ0gtA/n00BFqGgUMEK4Yfuoyn
         yszFHVkWM5Bzmi0zn1DWGrwS+wpwEtouioW2/uI4ZD+FHlIwklkRtcIbG7qq9mKBPblE
         zjkea4mf6jODrPbYigQd8CGxiWE6fmMz307juu613zxuIslghXWfJ0dwF5jcJ0uPfpOm
         GRfQ==
X-Gm-Message-State: AFeK/H0qQ00mj39aOD7F4cQsQ1feCYkfPLlppIT+8icymf/bdC1U00fTmAwNrbUqNY+7zA==
X-Received: by 10.98.198.138 with SMTP id x10mr18074232pfk.85.1490496201801;
        Sat, 25 Mar 2017 19:43:21 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id p77sm12793719pfj.99.2017.03.25.19.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:43:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:43:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 05/28] files-backend: add and use files_packed_refs_path()
Date:   Sun, 26 Mar 2017 09:42:18 +0700
Message-Id: <20170326024241.31984-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep repo-related path handling in one place. This will make it easier
to add submodule/multiworktree support later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9a9dc4e50c..f17daddffa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -923,6 +923,8 @@ struct files_ref_store {
 	 */
 	const char *submodule;
 
+	char *packed_refs_path;
+
 	struct ref_entry *loose;
 	struct packed_ref_cache *packed;
 };
@@ -985,7 +987,14 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 
 	base_ref_store_init(ref_store, &refs_be_files);
 
-	refs->submodule = xstrdup_or_null(submodule);
+	if (submodule) {
+		refs->submodule = xstrdup(submodule);
+		refs->packed_refs_path = git_pathdup_submodule(
+			refs->submodule, "packed-refs");
+		return ref_store;
+	}
+
+	refs->packed_refs_path = git_pathdup("packed-refs");
 
 	return ref_store;
 }
@@ -1153,19 +1162,18 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	strbuf_release(&line);
 }
 
+static const char *files_packed_refs_path(struct files_ref_store *refs)
+{
+	return refs->packed_refs_path;
+}
+
 /*
  * Get the packed_ref_cache for the specified files_ref_store,
  * creating it if necessary.
  */
 static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *refs)
 {
-	char *packed_refs_file;
-
-	if (refs->submodule)
-		packed_refs_file = git_pathdup_submodule(refs->submodule,
-							 "packed-refs");
-	else
-		packed_refs_file = git_pathdup("packed-refs");
+	const char *packed_refs_file = files_packed_refs_path(refs);
 
 	if (refs->packed &&
 	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
@@ -1184,7 +1192,6 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 			fclose(f);
 		}
 	}
-	free(packed_refs_file);
 	return refs->packed;
 }
 
@@ -2157,7 +2164,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	}
 
 	if (hold_lock_file_for_update_timeout(
-			    &packlock, git_path("packed-refs"),
+			    &packlock, files_packed_refs_path(refs),
 			    flags, timeout_value) < 0)
 		return -1;
 	/*
@@ -2423,7 +2430,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(refs, 0)) {
-		unable_to_lock_message(git_path("packed-refs"), errno, err);
+		unable_to_lock_message(files_packed_refs_path(refs), errno, err);
 		return -1;
 	}
 	packed = get_packed_refs(refs);
-- 
2.11.0.157.gd943d85

