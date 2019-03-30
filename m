Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57A320248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfC3LW3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:22:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38298 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbfC3LW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:22:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so2221770plb.5
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HRwL2T7MODfcXrlBYA8wLAi07ntXHgzSLd7OPKp/jk=;
        b=mvl3z5EVfCDeyesZvt5ajaTcwI4ZdJaDpntH3F+zg4HtypIbMcv19tcrOn/+amvqgj
         HF3F40wO40UDDMenZCvCc0UIPIurCUBAsEn39dvYtDCuQUH8QSWwIFc9KtHS1wL+CPXv
         fuVUzL+QlWsTEFEGpHNOXQK+Sou3rFrBbqbHMuL9xOpcJpyzrB0+4AqKoyqchNrXeCsf
         fNZUXe/f5XneqEV9OcwstQA78cCkyGlCsRbaY8lNGEks5qOcpxZq19jwfbjlyIKbZwOK
         t329tGgwlUsbJsefXykuZoaUp6ibH1hwHv0qXwju4mwM1q722nqvnHaPuqe7NtX1Hm+E
         LQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HRwL2T7MODfcXrlBYA8wLAi07ntXHgzSLd7OPKp/jk=;
        b=ChVR7MZ+xWuoFifa6ve9YX2JIv+eAXm5fDt1fXJ5whioVaFoLvqiFn7FWh1cJhLKr5
         ZC74Jaka1n+6HXnYXMAEkVYg5W3S2+AfnSKztqyU9MgstsKk4oDPWJKOfgxPD88S/m4o
         pXNuommExe0vBHbEVnwfKjnj/gAgWoZp3ukHmKMB9qHdTYHmAewiafJTF9eXdZE+s56e
         EIPeU4PpOnr8/Kks83ZK9LXdxJXLtcr177Mz0QLssw5rBxlqsjEYjTBLdBH0ga8glFPX
         8QEaxaSJUdc81rjXu7SlfL+Wsd+H3wiRrr/0HFYaDXC2qAu/0XYmAQ0KixqEiC3fYTvO
         Emfg==
X-Gm-Message-State: APjAAAXDLW4u2sbcp9YUAGFKdaw8uAvcpxsXXNSEsWpZtO0Wel0yDkY3
        lolLyir4SXtpxW6hANcPs53Yxpdw
X-Google-Smtp-Source: APXvYqzka7lp/DbMNl9R2VsXNK70YAGujy3fm+Y6VqkiPhuYOCtFwN/qZ/CkJ5PJCS23ck9JD5r0Zg==
X-Received: by 2002:a17:902:a612:: with SMTP id u18mr53316220plq.145.1553944948677;
        Sat, 30 Mar 2019 04:22:28 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id 139sm11127355pfw.98.2019.03.30.04.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:22:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:22:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 24/31] sha1-name.c: remove the_repo from diagnose_invalid_index_path()
Date:   Sat, 30 Mar 2019 18:19:20 +0700
Message-Id: <20190330111927.18645-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

