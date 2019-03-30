Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE37720248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfC3LUt (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:20:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43469 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbfC3LUs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so2246678pfd.10
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PazlTtVfhEjw1y44qBaTCCffQGEbZCrOeMwdGeo05I=;
        b=f+dDijMuC9YLQFhdcP46dJZ3XWscK83PQzuMIFdjll++ZxWXtb78DiZEMyHVX8uqJc
         v6EgARun5u9CPcKFfzc625EMyI0QoipNeNAYJSk0XyksQ2W++sklljGsNe5iI5s4FVZw
         Eb9495dORJOflZqkSsfUujPapgeKrfvt95N0O67K/6gkgJq2qaK2eIErOiwOiW9hoKV7
         epgp7OeoeX6sxNrzPaWV2JOsF5fvCA8wo9XvMHAGQnK79B2nE2CVqpLMzdtX5NSvINfG
         Gc0F9JyQ0ZE4AgncQD7kKr5d/0Vt50emv/froSWd/919TpkzPYOgZDRpOkAhn4pSxrZP
         wn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PazlTtVfhEjw1y44qBaTCCffQGEbZCrOeMwdGeo05I=;
        b=kqmoJO0CdkrZuQCFo9cJwqpGDx4lEeYcm1VMCwrpIRRagr1p++QqUz7hLBQ5l7hTOC
         wU/veBbL/GYZH7u9ZBwF2aSd+UpkTW3H/dgkONpTP75Vg5+gLK/MYd1LKlrLW3sjZBC6
         jhOsc4VL1SmBNEleopZsZlBjbSaZ9qjl8WJjgiKzlNxOMzXubcpzUCo4aarIXddsfXFy
         Kr7HYXBo5nXfcPUccxtubA5gWKkCrfFbqCPkG2+WfXpT+H3u5DcHSp79pDhlydHGBzKX
         00rASyukH6Cm6axS8iCRYPWzzzZIbb0tSVZmaTf/6xe1lSzGbOgbdgmVKcE2BRy/cl6T
         JT6w==
X-Gm-Message-State: APjAAAUKi5EREBxktVv+KIXfRdh3OX1bPI91ZlF5hEea2rYvzVHc3/Am
        UZJlD1wFtch6W7MbRWBER4E4rLeG
X-Google-Smtp-Source: APXvYqzPYp6ROKdgFtrRFuX5fZSsGmwnaDqSWdJt7up0yXPR0IK1kve35BKk6K3MeceEFFQ/bG6yww==
X-Received: by 2002:aa7:8092:: with SMTP id v18mr36403919pff.35.1553944847949;
        Sat, 30 Mar 2019 04:20:47 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id h65sm8583065pgc.93.2019.03.30.04.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:20:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:20:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/31] refs.c: remove the_repo from substitute_branch_name()
Date:   Sat, 30 Mar 2019 18:19:00 +0700
Message-Id: <20190330111927.18645-5-pclouds@gmail.com>
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
 cache.h     | 8 ++++++--
 refs.c      | 9 +++++----
 sha1-name.c | 8 ++++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index ac92421f3a..fcb24b5781 100644
--- a/cache.h
+++ b/cache.h
@@ -1468,8 +1468,12 @@ extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **en
 #define INTERPRET_BRANCH_LOCAL (1<<0)
 #define INTERPRET_BRANCH_REMOTE (1<<1)
 #define INTERPRET_BRANCH_HEAD (1<<2)
-extern int interpret_branch_name(const char *str, int len, struct strbuf *,
-				 unsigned allowed);
+int repo_interpret_branch_name(struct repository *r,
+			       const char *str, int len,
+			       struct strbuf *buf,
+			       unsigned allowed);
+#define interpret_branch_name(str, len, buf, allowed) \
+	repo_interpret_branch_name(the_repository, str, len, buf, allowed)
 extern int get_oid_mb(const char *str, struct object_id *oid);
 
 extern int validate_headref(const char *ref);
diff --git a/refs.c b/refs.c
index 3dde824aab..44df049796 100644
--- a/refs.c
+++ b/refs.c
@@ -539,10 +539,11 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
  * later free()ing) if the string passed in is a magic short-hand form
  * to name a branch.
  */
-static char *substitute_branch_name(const char **string, int *len)
+static char *substitute_branch_name(struct repository *r,
+				    const char **string, int *len)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int ret = interpret_branch_name(*string, *len, &buf, 0);
+	int ret = repo_interpret_branch_name(r, *string, *len, &buf, 0);
 
 	if (ret == *len) {
 		size_t size;
@@ -556,7 +557,7 @@ static char *substitute_branch_name(const char **string, int *len)
 
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 {
-	char *last_branch = substitute_branch_name(&str, &len);
+	char *last_branch = substitute_branch_name(the_repository, &str, &len);
 	int   refs_found  = expand_ref(str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
@@ -596,7 +597,7 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 
 int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 {
-	char *last_branch = substitute_branch_name(&str, &len);
+	char *last_branch = substitute_branch_name(the_repository, &str, &len);
 	const char **p;
 	int logs_found = 0;
 	struct strbuf path = STRBUF_INIT;
diff --git a/sha1-name.c b/sha1-name.c
index 6dda2c16df..d535bb82f7 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1427,13 +1427,17 @@ static int interpret_branch_mark(const char *name, int namelen,
 	return len + at;
 }
 
-int interpret_branch_name(const char *name, int namelen, struct strbuf *buf,
-			  unsigned allowed)
+int repo_interpret_branch_name(struct repository *r,
+			       const char *name, int namelen,
+			       struct strbuf *buf,
+			       unsigned allowed)
 {
 	char *at;
 	const char *start;
 	int len;
 
+	if (r != the_repository)
+		BUG("interpret_branch_name() does not really use 'r' yet");
 	if (!namelen)
 		namelen = strlen(name);
 
-- 
2.21.0.479.g47ac719cd3

