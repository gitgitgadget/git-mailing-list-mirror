Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84516C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 19:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIMT0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIMT0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 15:26:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83FB7963C
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g3so1475014wrq.13
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=c+t8BXpaVe7agqU9QWWg3rEcJMGswM19s/qehasi/Dg=;
        b=W/AuDUcQoSKNwmJ0aAhXav075W0fbl87e1iZje3bsGthCQZt1SId/tcUFGWGIa0HnK
         eiQR2Q/vAJjbqkUG5hTnkXJ6rWJQjZUDZESpMgVJrqGcgU5isMX1e1C87eLfDpBeXFsq
         Ry6rVfZKTB1PBbNQ9AHPpJjvg1Y5oPkHRazqB9Y+Z8Qw/p9Lf3x+KzOoREzZsgNca2Pa
         jMzdqIgePT2HqkL6ZQSMMplqgW09X5vyQH7KMPG25dGYb630r9Cz0sI2/sq28PRoCmrt
         wXfTlskJBuoBP9fMeUR3gVNmjP/XbxPtV9d/sqSU80GfZaLnkwmn/Q/lzh5wDq+VvZcO
         SCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c+t8BXpaVe7agqU9QWWg3rEcJMGswM19s/qehasi/Dg=;
        b=NKVZOWtJ5orqrSdlPA3/0NsDzHIoq6x7Y8oxy52jRWoEGOgLQrQbPfaKHIvByk8L5l
         dtyRPUL0xilOtke5qnLRrKdcnilZAtI/pBXK0EO9wpswf15j69R50z+ZCsL1yuqyBhYc
         7wJvGLOvn2uL2Bt2fekc6G1S73b97IXhpXAAyn4Y8weYN/AcftCgEUmNGg2ORKXQVRHY
         USi/oSNQP+Drs1oSwEy6221T8YYO+2E6Ldw9XHDIFXSmgAlGGwbuwRjFDQyB6v9gIYtp
         5g0DnXd40HPrvUq6ct/LKUkOFUXi+gc5rK7ZthU/KPGmj5/oqzh4t4z6AdPM/Gb4bdxG
         n04Q==
X-Gm-Message-State: ACgBeo2EH+4tMPWoXEt2ehj5g436vYOIbVlahBFWXzXifVYVlgvOWHHG
        uf+JVHeGTnU64bqF0Thb07QjMB22+uQ=
X-Google-Smtp-Source: AA6agR7sWgoDj2KvU9R/1/DFEDgOKyRAToPPeyLnGUYrZhMAr9v3/GSaeW3XVrTsDtlytCLsxlrX0Q==
X-Received: by 2002:adf:fbd2:0:b0:21e:e983:165f with SMTP id d18-20020adffbd2000000b0021ee983165fmr19087841wrs.517.1663097165860;
        Tue, 13 Sep 2022 12:26:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g7-20020adfa487000000b0022917d58603sm11562077wrb.32.2022.09.13.12.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:26:05 -0700 (PDT)
Message-Id: <7f827067f55d596284eb2ad764e59d402c75be18.1663097156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 19:25:56 +0000
Subject: [PATCH 8/8] http: set specific auth scheme depending on credential
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Introduce a new credential field `authtype` that can be used by
credential helpers to indicate the type of the credential or
authentication mechanism to use for a request.

Modify http.c to now specify the correct authentication scheme or
credential type when authenticating the curl handle. If the new
`authtype` field in the credential structure is `NULL` or "Basic" then
use the existing username/password options. If the field is "Bearer"
then use the OAuth bearer token curl option. Otherwise, the `authtype`
field is the authentication scheme and the `password` field is the
raw, unencoded value.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Documentation/git-credential.txt |  9 +++++++++
 credential.c                     |  5 +++++
 credential.h                     |  1 +
 git-curl-compat.h                |  7 +++++++
 http.c                           | 24 +++++++++++++++++++++---
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 7d4a788c63d..3b6ef6f4906 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -152,6 +152,15 @@ Git understands the following attributes:
 	`protocol=https` and `host=example.com` had been provided). This
 	can help callers avoid parsing URLs themselves.
 
+`authtype`::
+
+	Indicates the type of authentication scheme used. If this is not
+	present the default is "Basic".
+	Known values include "Basic", "Digest", and "Bearer".
+	If an unknown value is provided, this is taken as the authentication
+	scheme for the `Authorization` header, and the `password` field is
+	used as the raw unencoded authorization parameters of the same header.
+
 `wwwauth[n]`::
 
 	When an HTTP response is received that includes one or more
diff --git a/credential.c b/credential.c
index 4ad40323fc7..9d4a0f3fd51 100644
--- a/credential.c
+++ b/credential.c
@@ -21,6 +21,7 @@ void credential_clear(struct credential *c)
 	free(c->path);
 	free(c->username);
 	free(c->password);
+	free(c->authtype);
 	string_list_clear(&c->helpers, 0);
 	strvec_clear(&c->wwwauth_headers);
 
@@ -235,6 +236,9 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "path")) {
 			free(c->path);
 			c->path = xstrdup(value);
+		} else if (!strcmp(key, "authtype")) {
+			free(c->authtype);
+			c->authtype = xstrdup(value);
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
 		} else if (!strcmp(key, "quit")) {
@@ -281,6 +285,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	credential_write_item(fp, "authtype", c->authtype, 0);
 	credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);
 }
 
diff --git a/credential.h b/credential.h
index 6a9d4e3de07..a6572aacf1d 100644
--- a/credential.h
+++ b/credential.h
@@ -135,6 +135,7 @@ struct credential {
 	char *protocol;
 	char *host;
 	char *path;
+	char *authtype;
 };
 
 #define CREDENTIAL_INIT { \
diff --git a/git-curl-compat.h b/git-curl-compat.h
index 56a83b6bbd8..74732500a9f 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -126,4 +126,11 @@
 #define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
 #endif
 
+/**
+ * CURLAUTH_BEARER was added in 7.61.0, released in July 2018.
+ */
+#if LIBCURL_VERSION_NUM >= 0x073D00
+#define GIT_CURL_HAVE_CURLAUTH_BEARER
+#endif
+
 #endif
diff --git a/http.c b/http.c
index 8e107ff19b8..d8913b2c641 100644
--- a/http.c
+++ b/http.c
@@ -516,7 +516,8 @@ static int curl_empty_auth_enabled(void)
 
 static void init_curl_http_auth(struct active_request_slot *slot)
 {
-	if (!http_auth.username || !*http_auth.username) {
+	if (!http_auth.authtype &&
+		(!http_auth.username || !*http_auth.username)) {
 		if (curl_empty_auth_enabled())
 			curl_easy_setopt(slot->curl, CURLOPT_USERPWD, ":");
 		return;
@@ -524,8 +525,25 @@ static void init_curl_http_auth(struct active_request_slot *slot)
 
 	credential_fill(&http_auth);
 
-	curl_easy_setopt(slot->curl, CURLOPT_USERNAME, http_auth.username);
-	curl_easy_setopt(slot->curl, CURLOPT_PASSWORD, http_auth.password);
+	if (!http_auth.authtype || !strcasecmp(http_auth.authtype, "basic")
+				|| !strcasecmp(http_auth.authtype, "digest")) {
+		curl_easy_setopt(slot->curl, CURLOPT_USERNAME,
+			http_auth.username);
+		curl_easy_setopt(slot->curl, CURLOPT_PASSWORD,
+			http_auth.password);
+#ifdef GIT_CURL_HAVE_CURLAUTH_BEARER
+	} else if (!strcasecmp(http_auth.authtype, "bearer")) {
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, CURLAUTH_BEARER);
+		curl_easy_setopt(slot->curl, CURLOPT_XOAUTH2_BEARER,
+			http_auth.password);
+#endif
+	} else {
+		struct strbuf auth = STRBUF_INIT;
+		strbuf_addf(&auth, "Authorization: %s %s",
+			http_auth.authtype, http_auth.password);
+		slot->headers = curl_slist_append(slot->headers, auth.buf);
+		strbuf_release(&auth);
+	}
 }
 
 /* *var must be free-able */
-- 
gitgitgadget
