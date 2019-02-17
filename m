Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58EED1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfBQKLG (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:11:06 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:43325 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKLF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:11:05 -0500
Received: by mail-pf1-f174.google.com with SMTP id q17so7064821pfh.10
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbokgRJkMgF/9sHbeCDQL1g26TTG3yb/vBRZkif6kHk=;
        b=QwfTjwBCoJb7qfXvb10ZcO193mPJ1dd23aqwWbuROUh86oWWKrvLh6D8GDxIsX4aUl
         QorlSEi0Ng9AhvOvh0+IkMauimDBbx2/Gyi3FUKyZm8f9OWGSTWE9rKNiD2Mn79rqgBd
         1ptXgdbOB2yJS34YXtDz4/h9HmyUr7TntE/AJcPO/2HRJCdiGiCCH64r9Ng9TmtaAsdF
         jNRZO1ZShywlMywrv6jX95OLxl+WpaC8yA0I4grBbqENBGUawu3GWFld6BtZH538qkA3
         Qp7WGlaFfSEEs6YtrcoQ2B6NyOGRGV6swZL+YI5eJPkvV6s85TwPe8N4E/d9iZROCt/x
         ccyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbokgRJkMgF/9sHbeCDQL1g26TTG3yb/vBRZkif6kHk=;
        b=LnVB1u0Akvj7XKNiJe4yCqZmPpGvxY2A8tE5oXdhZS1gNdT3mnzwrZrj/4ngYcngmh
         oha9oJsSfUhWAFzYWuUIgTTFfDmqWeD3nkn5xZ1IxZCfR01niGZ2Yp9axoKRzzxeufKT
         7v/CPO26DJTwIIFLe/yqZdzcPgSxQYdAKLRaSkp91S043BAV9E9aLT4hZxI710yThE+D
         mYcjqyXhz8AL7qRq6dblZhtVUd7mBlw2aJRiutHy+6Gz3lin5LILZyT93DjiU3/xwBQ5
         XiTdFF8ejyjuDSVl9hxJEeBSanxsVrSg4f8N01VpvtLPRhhuIjBvTShCWrTGsUzWqg2l
         G/gw==
X-Gm-Message-State: AHQUAuY+BH9iGzYWHWk6OXswJhNpPbUOqSi4yyHHxh59oFSAE2XWDKwi
        p92JuEhJmPIEKUzkW/eMVktkGhqo
X-Google-Smtp-Source: AHgI3IZ1K4UuW03BxhqjYfIEaf32eNwI3A0S+9o6tiIZN+qssg2L+FxCTaZqmyL2ZTa3GtSv7pm4JQ==
X-Received: by 2002:a63:6a07:: with SMTP id f7mr13660248pgc.118.1550398264489;
        Sun, 17 Feb 2019 02:11:04 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id z18sm11447727pfl.164.2019.02.17.02.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:11:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:11:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 24/31] sha1-name.c: remove the_repo from diagnose_invalid_index_path()
Date:   Sun, 17 Feb 2019 17:09:06 +0700
Message-Id: <20190217100913.4127-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 dir.c       | 8 ++++++++
 dir.h       | 4 +++-
 sha1-name.c | 7 ++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index b2cabadf25..e6d97343f4 100644
--- a/dir.c
+++ b/dir.c
@@ -2315,6 +2315,14 @@ int file_exists(const char *f)
 	return lstat(f, &sb) == 0;
 }
 
+int repo_file_exists(struct repository *repo, const char *path)
+{
+	if (repo != the_repository)
+		BUG("do not know how to check file existence in arbitrary repo");
+
+	return file_exists(path);
+}
+
 static int cmp_icase(char a, char b)
 {
 	if (a == b)
diff --git a/dir.h b/dir.h
index e3ec26143d..47c5409ced 100644
--- a/dir.h
+++ b/dir.h
@@ -269,7 +269,9 @@ extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
 extern void clear_directory(struct dir_struct *dir);
-extern int file_exists(const char *);
+
+int repo_file_exists(struct repository *repo, const char *path);
+int file_exists(const char *);
 
 extern int is_inside_dir(const char *dir);
 extern int dir_inside_of(const char *subdir, const char *dir);
diff --git a/sha1-name.c b/sha1-name.c
index d9050776dd..6caf3f4e3a 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1664,11 +1664,12 @@ static void diagnose_invalid_oid_path(const char *prefix,
 }
 
 /* Must be called only when :stage:filename doesn't exist. */
-static void diagnose_invalid_index_path(struct index_state *istate,
+static void diagnose_invalid_index_path(struct repository *r,
 					int stage,
 					const char *prefix,
 					const char *filename)
 {
+	struct index_state *istate = r->index;
 	const struct cache_entry *ce;
 	int pos;
 	unsigned namelen = strlen(filename);
@@ -1708,7 +1709,7 @@ static void diagnose_invalid_index_path(struct index_state *istate,
 			    ce_stage(ce), filename);
 	}
 
-	if (file_exists(filename))
+	if (repo_file_exists(r, filename))
 		die("Path '%s' exists on disk, but not in the index.", filename);
 	if (is_missing_file_error(errno))
 		die("Path '%s' does not exist (neither on disk nor in the index).",
@@ -1814,7 +1815,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			pos++;
 		}
 		if (only_to_die && name[1] && name[1] != '/')
-			diagnose_invalid_index_path(repo->index, stage, prefix, cp);
+			diagnose_invalid_index_path(repo, stage, prefix, cp);
 		free(new_path);
 		return -1;
 	}
-- 
2.21.0.rc0.328.g0e39304f8d

