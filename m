Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3F4C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiKBWJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKBWJk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:09:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872DD391
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:09:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j15so231224wrq.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mn8tDBArbwI/tAY1Pw3Q63iPh3NTnaW/V+1ZlLZfZo=;
        b=i62WAmaG57tTBv3PH5t96ObDmHkTW6x1VvwnF/3bZSsVjdNBWtm8pi/m4qQs0vRVpb
         x+wTbqaVgF/yPtG0+42ePoyWQ0pMACrMpPrCYBs5voFxc9ZFsfFZnPbF2+pk2W+vqkLk
         5Qw9qc6/3VrosnM3QTuIvDx+pVLRPYbpEn+a1V5qqboRBl9Uou9e3xjqrX+ntFXxRL8H
         j4T50p9LQiLCiSYRQyIgGC8IjcmrBWKHZfANMyTPinWXQdSrvAJSA/PLxs8mAVTg/WKD
         6G6BLDpnvJ8xEiyZOFiV+DbxamnTnb6PfO0A7vPq+Jf3b5bXcoi02SYSTsJglJ4IQ4Q9
         VYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mn8tDBArbwI/tAY1Pw3Q63iPh3NTnaW/V+1ZlLZfZo=;
        b=bZ/TfeZzFuZehhI6upij4TQiCL5hEqBkijZmGgoAZ38xhJH3AwpXVMdi4v1BPo/PWz
         RrU2nwvkZtFpJJNVN1/p6T2jOcx9kSjoHMz99zpkU1HgzEfJmWvHumdHP2pmbZbKoHe5
         eKisCB5WjnfEXqgtdAkOwXpw/BNPI41jg3RL1szSoIiWoGv5k4F74DgC7EVS2K6gqnCJ
         qdmzDCPKnCZXuWf1MwfEKgOFZIFhXQdD+3ol2m/H1NaeYIIAnZnNlpCSi1ETJovmSAYj
         IArgVwfTlWZLJIzpdnW8MJBPnrB84uLO713/a2aciBJcoyxOSp/6CF0mihPCA1sJm96t
         uRhQ==
X-Gm-Message-State: ACrzQf3HeGFMbBWW0XT1mGNpZqQaS2fvRetqyywJ9eTBukJwREDbk6PL
        ru8DVdjENocfchtzvez7s3bgNGHzCGw=
X-Google-Smtp-Source: AMsMyM6c3vNwY/r3S9CDZjzswuMgySGG7/XdXqMmKCcE+Sgm2EBWlGadFSZssbIJgh4i8PMfl0IgUg==
X-Received: by 2002:a05:6000:1361:b0:236:9ab7:8e3b with SMTP id q1-20020a056000136100b002369ab78e3bmr16565653wrz.707.1667426977880;
        Wed, 02 Nov 2022 15:09:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4fdbb6319sm3246969wmi.21.2022.11.02.15.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:09:37 -0700 (PDT)
Message-Id: <2f38427aa8db188060d153d8ece9503e1b604e91.1667426970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
        <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 22:09:23 +0000
Subject: [PATCH v3 05/11] http: set specific auth scheme depending on
 credential
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
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
 Documentation/git-credential.txt | 12 ++++++++++++
 credential.c                     |  5 +++++
 credential.h                     |  1 +
 git-curl-compat.h                | 10 ++++++++++
 http.c                           | 24 +++++++++++++++++++++---
 5 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 791a57dddfb..9069bfb2d50 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -175,6 +175,18 @@ username in the example above) will be left unset.
 	attribute 'wwwauth[]', where the order of the attributes is the same as
 	they appear in the HTTP response.
 
+`authtype`::
+
+	Indicates the type of authentication scheme that should be used by Git.
+	Credential helpers may reply to a request from Git with this attribute,
+	such that subsequent authenticated requests include the correct
+	`Authorization` header.
+	If this attribute is not present, the default value is "Basic".
+	Known values include "Basic", "Digest", and "Bearer".
+	If an unknown value is provided, this is taken as the authentication
+	scheme for the `Authorization` header, and the `password` field is
+	used as the raw unencoded authorization parameters of the same header.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/credential.c b/credential.c
index 8a3ad6c0ae2..a556f9f375a 100644
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
index 6f2e5bc610b..8d580b054d0 100644
--- a/credential.h
+++ b/credential.h
@@ -140,6 +140,7 @@ struct credential {
 	char *protocol;
 	char *host;
 	char *path;
+	char *authtype;
 };
 
 #define CREDENTIAL_INIT { \
diff --git a/git-curl-compat.h b/git-curl-compat.h
index 56a83b6bbd8..839049f6dfe 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -126,4 +126,14 @@
 #define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
 #endif
 
+/**
+ * CURLAUTH_BEARER was added in 7.61.0, released in July 2018.
+ * However, only 7.69.0 fixes a bug where Bearer headers were not
+ * actually sent with reused connections on subsequent transfers
+ * (curl/curl@dea17b519dc1).
+ */
+#if LIBCURL_VERSION_NUM >= 0x074500
+#define GIT_CURL_HAVE_CURLAUTH_BEARER
+#endif
+
 #endif
diff --git a/http.c b/http.c
index 17b47195d22..ac620bcbf0c 100644
--- a/http.c
+++ b/http.c
@@ -517,7 +517,8 @@ static int curl_empty_auth_enabled(void)
 
 static void init_curl_http_auth(struct active_request_slot *slot)
 {
-	if (!http_auth.username || !*http_auth.username) {
+	if (!http_auth.authtype &&
+		(!http_auth.username || !*http_auth.username)) {
 		if (curl_empty_auth_enabled())
 			curl_easy_setopt(slot->curl, CURLOPT_USERPWD, ":");
 		return;
@@ -525,8 +526,25 @@ static void init_curl_http_auth(struct active_request_slot *slot)
 
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

