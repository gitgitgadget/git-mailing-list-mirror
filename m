Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA44D1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfBQKLg (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:11:36 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:42559 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKLf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:11:35 -0500
Received: by mail-pf1-f176.google.com with SMTP id n74so7069520pfi.9
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUWmu3SYh+C+hk+Q0YRtcHkEN0UG8bOFTUlr/9XrEhU=;
        b=cjr/CLwgZ9b9RdkwKF057MyPu4Qo3s3gUpFXdzeCeKzMu6YBwO5LpIr0vdEnhqarys
         LbhHa+OzLMTEeZIOMG69vnmk1WTxC3Ki+xFJtky6nEjtC3TXywPALI4eMN/7xDWYQLd9
         2X+/cov4/aQmmOONu40rLyWMT15RFqBq9Ta88HFsaKNtwM9nyUp8HY9oOSGYt9K+KJWI
         UVaHX4XCFffjJMcQZp9r14EfKvU/JfmD+BGKq735nIE0rAM+f+eotoISkzl38CQJRtzS
         stpG/lUPtsWIVR9sRf/Vckwl5UH5WWaEYCmmoL2g4qnW4ll9S3ksxVLz3FLbF+U0LumJ
         jshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUWmu3SYh+C+hk+Q0YRtcHkEN0UG8bOFTUlr/9XrEhU=;
        b=b/1/O1w9eiUBwVq1ANtUiEbt5VWafqLHZ8KJiRAgpuiYUbxM1fjub6iy5UAXm9Gxb3
         /zBk+4aPM6+BZITH1MyNkvsLUUCVk7RGwrVrhOgcTuPLyXYru+FSonTSDeuFqXr0PnXq
         jQ/OzO0DX8igqIj4Hgs5E0E9WQL8xHrmE0DWbSWfzf/ll8uL/F7+MkKnL0/NupVzNuQB
         J9W6JuvMVPy463TMEoB6PE+xH1uZ/T8//1QPFqOTtm8eyBSt7s4HDC/2q+W+xzjMMBsD
         cdRomveVxbRwZEt+AsS1sXOb7xR/yB5PlHMhJRQFkw6tO+DjT49wMHlgeg5wY5B+h7I8
         H+MA==
X-Gm-Message-State: AHQUAubQxwTBFTZfcel0sySKpRfu4rwpldCbjk+ThMqxugtNF1gFoXf7
        Ed0iS/NjXVdCbxN2yZm9cl+7mMOD
X-Google-Smtp-Source: AHgI3IYKFEFkv1FGembHxjjvJolGTP6wP37tvrCgN1kGTIzBDPDPpRcIzJOv2kovW6cJjvcwpcwfMg==
X-Received: by 2002:a62:f54d:: with SMTP id n74mr18393415pfh.98.1550398294721;
        Sun, 17 Feb 2019 02:11:34 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s73sm27192722pfi.124.2019.02.17.02.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:11:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:11:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 31/31] sha1-name.c: remove the_repo from get_oid_mb()
Date:   Sun, 17 Feb 2019 17:09:13 +0700
Message-Id: <20190217100913.4127-32-pclouds@gmail.com>
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
 cache.h     |  3 ++-
 sha1-name.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 7ce8c566fc..24fbff94f7 100644
--- a/cache.h
+++ b/cache.h
@@ -1360,6 +1360,7 @@ int repo_get_oid_committish(struct repository *r, const char *str, struct object
 int repo_get_oid_tree(struct repository *r, const char *str, struct object_id *oid);
 int repo_get_oid_treeish(struct repository *r, const char *str, struct object_id *oid);
 int repo_get_oid_blob(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_mb(struct repository *r, const char *str, struct object_id *oid);
 void maybe_die_on_misspelt_object_name(struct repository *repo,
 				       const char *name,
 				       const char *prefix);
@@ -1373,6 +1374,7 @@ extern enum get_oid_result get_oid_with_context(struct repository *repo, const c
 #define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, oid)
 #define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, str, oid)
 #define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, oid)
+#define get_oid_mb(str, oid) 		repo_get_oid_mb(the_repository, str, oid)
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
 int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
@@ -1460,7 +1462,6 @@ int repo_interpret_branch_name(struct repository *r,
 			       unsigned allowed);
 #define interpret_branch_name(str, len, buf, allowed) \
 	repo_interpret_branch_name(the_repository, str, len, buf, allowed)
-extern int get_oid_mb(const char *str, struct object_id *oid);
 
 extern int validate_headref(const char *ref);
 
diff --git a/sha1-name.c b/sha1-name.c
index d49496397d..cf314ebb29 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1338,7 +1338,9 @@ static int interpret_nth_prior_checkout(struct repository *r,
 	return retval;
 }
 
-int get_oid_mb(const char *name, struct object_id *oid)
+int repo_get_oid_mb(struct repository *r,
+		    const char *name,
+		    struct object_id *oid)
 {
 	struct commit *one, *two;
 	struct commit_list *mbs;
@@ -1348,27 +1350,29 @@ int get_oid_mb(const char *name, struct object_id *oid)
 
 	dots = strstr(name, "...");
 	if (!dots)
-		return get_oid(name, oid);
+		return repo_get_oid(r, name, oid);
 	if (dots == name)
-		st = get_oid("HEAD", &oid_tmp);
+		st = repo_get_oid(r, "HEAD", &oid_tmp);
 	else {
 		struct strbuf sb;
 		strbuf_init(&sb, dots - name);
 		strbuf_add(&sb, name, dots - name);
-		st = get_oid_committish(sb.buf, &oid_tmp);
+		st = repo_get_oid_committish(r, sb.buf, &oid_tmp);
 		strbuf_release(&sb);
 	}
 	if (st)
 		return st;
-	one = lookup_commit_reference_gently(the_repository, &oid_tmp, 0);
+	one = lookup_commit_reference_gently(r, &oid_tmp, 0);
 	if (!one)
 		return -1;
 
-	if (get_oid_committish(dots[3] ? (dots + 3) : "HEAD", &oid_tmp))
+	if (repo_get_oid_committish(r, dots[3] ? (dots + 3) : "HEAD", &oid_tmp))
 		return -1;
-	two = lookup_commit_reference_gently(the_repository, &oid_tmp, 0);
+	two = lookup_commit_reference_gently(r, &oid_tmp, 0);
 	if (!two)
 		return -1;
+	if (r != the_repository)
+		BUG("sorry get_merge_bases() can't take struct repository yet");
 	mbs = get_merge_bases(one, two);
 	if (!mbs || mbs->next)
 		st = -1;
-- 
2.21.0.rc0.328.g0e39304f8d

