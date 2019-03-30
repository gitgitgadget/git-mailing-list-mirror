Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E078C20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfC3LWy (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:22:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36781 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbfC3LWy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:22:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so2438585pgc.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WiTcqjXHjS0GDmkL0Ayotb8v1V1CzkGfFwAIuM5mr9Q=;
        b=RAX7GIj8DB4AP+vtj6a47L2WJYwpJlYoSbzand/wrZyGN10VRaAVH5lEGhsMev+lKz
         m+TOZQ7VuZgbAux7arrV7Bmi+48J0excc+LDaOQjnRa1Z7oWaqLVhBGTVtoydw0t0ac7
         dS76tstdgSuWmuZZg4Anfo6k8ZAAJN8hJrH+FI0PyW6dxmsVrnryI/ZoeL2mpAhixT/B
         9dY515F5Sz8MWNeNM2GrFgFMYXqs/40hYl5PXQFbl0Ya0RDUOQgV29LiEhPcqx4mTgCx
         I7oEOO6b8xwTaOSDIsO4SZbeweTojoK0tn29aT4bZk/bkBKhw0Q1nptbGL/4kgupdDFW
         IAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WiTcqjXHjS0GDmkL0Ayotb8v1V1CzkGfFwAIuM5mr9Q=;
        b=YVgfJ0SucRDCe+0FONxysyU3n2hSU7WD6nGjQH1ZOFyeW2Nlk07t7vBuGRdFGWewSA
         GK1Bq4LNzEX5lnUw6vdcjBcP0QhUdP1WoqJG5JpBBcRzBrUUGfwKDI4TBL5kc1xvDYvs
         PZPrGHOTwsExdq5rKKRK98KwOP5TcTKpogzXKhk5x97Fd4ySV3C23RcCrR8kYIgTR9UO
         3MHFx0h/gqLcmIzn/G9PZXLCac/bc0zxTomMQcGs7cYaJAtwUNKofxaNnSikd8m5ez/X
         n48BQDbC8zo0K8jqaf2Z/tHxnaaMUAbqnR39yiZsWjHNVRe8hRDcTRvULKWHWVmRQXGU
         OqWg==
X-Gm-Message-State: APjAAAXQ2qx7IyqSVHC9WBsQGAdBq4JCP3TWLP4pMn/UNLvJ5vHT6wxT
        kh4+wdyhp5vi8DnVDrwwLcUHY73b
X-Google-Smtp-Source: APXvYqzAY3QGpDy8G0KOFqQr4pPhnNIiGf9lVRDACyZmnUNqvu9AaXvWKCAqyqjJX/65+89OF7LCjg==
X-Received: by 2002:a63:ed11:: with SMTP id d17mr50563845pgi.211.1553944973247;
        Sat, 30 Mar 2019 04:22:53 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id o5sm19479549pfa.135.2019.03.30.04.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:22:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:22:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 29/31] sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
Date:   Sat, 30 Mar 2019 18:19:25 +0700
Message-Id: <20190330111927.18645-30-pclouds@gmail.com>
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
 cache.h     | 4 +++-
 setup.c     | 7 ++++---
 sha1-name.c | 6 ++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index f6e87194d0..3718b3db8a 100644
--- a/cache.h
+++ b/cache.h
@@ -1387,7 +1387,9 @@ extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
 extern int get_oid_treeish(const char *str, struct object_id *oid);
 extern int get_oid_blob(const char *str, struct object_id *oid);
-extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
+void maybe_die_on_misspelt_object_name(struct repository *repo,
+				       const char *name,
+				       const char *prefix);
 extern enum get_oid_result get_oid_with_context(struct repository *repo, const char *str,
 				unsigned flags, struct object_id *oid,
 				struct object_context *oc);
diff --git a/setup.c b/setup.c
index d0c958c3b2..8dcb4631f7 100644
--- a/setup.c
+++ b/setup.c
@@ -164,7 +164,8 @@ int check_filename(const char *prefix, const char *arg)
 	die_errno(_("failed to stat '%s'"), arg);
 }
 
-static void NORETURN die_verify_filename(const char *prefix,
+static void NORETURN die_verify_filename(struct repository *r,
+					 const char *prefix,
 					 const char *arg,
 					 int diagnose_misspelt_rev)
 {
@@ -179,7 +180,7 @@ static void NORETURN die_verify_filename(const char *prefix,
 	 * let maybe_die_on_misspelt_object_name() even trigger.
 	 */
 	if (!(arg[0] == ':' && !isalnum(arg[1])))
-		maybe_die_on_misspelt_object_name(arg, prefix);
+		maybe_die_on_misspelt_object_name(r, arg, prefix);
 
 	/* ... or fall back the most general message. */
 	die(_("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
@@ -234,7 +235,7 @@ void verify_filename(const char *prefix,
 		die(_("option '%s' must come before non-option arguments"), arg);
 	if (looks_like_pathspec(arg) || check_filename(prefix, arg))
 		return;
-	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
+	die_verify_filename(the_repository, prefix, arg, diagnose_misspelt_rev);
 }
 
 /*
diff --git a/sha1-name.c b/sha1-name.c
index 953df0d692..b94d381bef 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1885,11 +1885,13 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
  * exist in 'HEAD'" when given "HEAD:doc", or it may return in which case
  * you have a chance to diagnose the error further.
  */
-void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
+void maybe_die_on_misspelt_object_name(struct repository *r,
+				       const char *name,
+				       const char *prefix)
 {
 	struct object_context oc;
 	struct object_id oid;
-	get_oid_with_context_1(the_repository, name, GET_OID_ONLY_TO_DIE,
+	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE,
 			       prefix, &oid, &oc);
 }
 
-- 
2.21.0.479.g47ac719cd3

