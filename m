Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A226B20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfC3LXE (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:23:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45188 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbfC3LXE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:23:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so2244841pfi.12
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHihulZqB9t7pgfq8tjomSTv/8DEfubw/edGbtbh7Pk=;
        b=YoRZ+KKVXMbi9tpM0H57m4NaWb4YQdyu/IeuHASamjHbxFDHjke2qlw5zx5KyC+bjR
         onuS1E4VZrlJ57cpH7qqgORSufAsCQ8KUhksL3izrWmoc8uN4Zb1RMp4JhGDd55chifL
         oiwe5HKh7ww1ZwbRKT5ht9DjGOUZXPPMg2bL3yMKesNCoyMr6Ky1+vCaqRm8tj0wfX6d
         qde0fyG8YeIg7ayXT49shEISeYhA4ekiiAoL4NvZyIGlu7PJRkb3QYEXqoFucsoGdM0L
         JQH1eTH4rNFXpioNth/qvKUvxNa6p5r7SBlfM550Of8BgG1yONyqgAiYmS799INULpsQ
         +E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHihulZqB9t7pgfq8tjomSTv/8DEfubw/edGbtbh7Pk=;
        b=QXwVsMwXIhT6WVe0QYDzeSbJoxHCaGSoXj8I1zYHjFTlWkQRMxjqFqLXo70p5fscpi
         W+6soQYXGg0zukbpJok1du3zjCq7Xt20qAhC8Bt+3M+HXrT5nNjULb6+DTSYe1zcbXYa
         h37/iYY4/i30/QDQKnaRl+RztOVeDhfxd4OBuTT8mtyo+FUQIBmNpF3gO5mq/FtxxdSS
         opJGef6pRQcKjDDwJckl/lAKPMgYFDxCwrlU+nJ1H736hnMb0IYeUnpQzpsr6eGOOplZ
         5IzAVqEkxe+Aahf47wsWlPTc9jv+4pPyRMBai7rmn8kTyWL3GyFFNyaqhFcxXwqTc+Tr
         eG5A==
X-Gm-Message-State: APjAAAX4MVFxrET1oF8JzM6t3FoJ1IKd3Kr0f6tMQWiRT9uXX9h32LWc
        9CsTPEH41G5aqbip90v9eNYmlPgn
X-Google-Smtp-Source: APXvYqxsY1AU2gebN98s4m0LLJ9DFgoF8xfKC4LWpSWK78bK51Du/tSzua8/QGhWrxYJBjR+AAe+dw==
X-Received: by 2002:a65:664a:: with SMTP id z10mr7479447pgv.443.1553944983484;
        Sat, 30 Mar 2019 04:23:03 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id a17sm7051085pgd.30.2019.03.30.04.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:23:02 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:22:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 31/31] sha1-name.c: remove the_repo from get_oid_mb()
Date:   Sat, 30 Mar 2019 18:19:27 +0700
Message-Id: <20190330111927.18645-32-pclouds@gmail.com>
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
 cache.h     |  3 ++-
 sha1-name.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 871a167bf8..9a600a8b50 100644
--- a/cache.h
+++ b/cache.h
@@ -1386,6 +1386,7 @@ int repo_get_oid_committish(struct repository *r, const char *str, struct object
 int repo_get_oid_tree(struct repository *r, const char *str, struct object_id *oid);
 int repo_get_oid_treeish(struct repository *r, const char *str, struct object_id *oid);
 int repo_get_oid_blob(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_mb(struct repository *r, const char *str, struct object_id *oid);
 void maybe_die_on_misspelt_object_name(struct repository *repo,
 				       const char *name,
 				       const char *prefix);
@@ -1399,6 +1400,7 @@ extern enum get_oid_result get_oid_with_context(struct repository *repo, const c
 #define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, oid)
 #define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, str, oid)
 #define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, oid)
+#define get_oid_mb(str, oid) 		repo_get_oid_mb(the_repository, str, oid)
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
 int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
@@ -1486,7 +1488,6 @@ int repo_interpret_branch_name(struct repository *r,
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
2.21.0.479.g47ac719cd3

