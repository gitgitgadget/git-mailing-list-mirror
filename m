Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CF2C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 13:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCSNvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 09:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCSNvT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 09:51:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66925903A
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 06:51:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v1so2024682wrv.1
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679233877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n2ld0gGNLJY5ZPFhlZFLaZzNXBkhyn2KPKYfbpP/uOE=;
        b=k22QcZn7H68iBZaYf0tS1juO+w2rFJOm7cZLueHJLNJ5VTHwL2oMpdVMWc3w5U/r+8
         TEbg0bfvbc/8OmRj2e++vWLTIYqd//ggJC0GSLwv9O0WiDN1QQh5ykunJWDUtjNx7LUv
         ftqBIf6PKq8zML96+qdQgcX9TWgTkmLQV89uS2t5n1rtw5MTOCekawwQ9Wr41eMnF6xY
         oScTBluwxNfo0yQPDJXGyQkB+ZGHGOJWxz7iC1Rf5EMio3+rj/XNjAX4AIchCwESKsKC
         c8n6B6H2sqRzt8rwKavBdAqfEmeZYas8YDbSqNYjYLZMaNmyNnBt3RxoccPmdA9Lc21G
         x0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679233877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2ld0gGNLJY5ZPFhlZFLaZzNXBkhyn2KPKYfbpP/uOE=;
        b=ZzcHaZIkcNqpOGQ55nDMhUJrrSPNqQ+rYdFoakp0KBJeqrZ40s3TV0kYx/q5hlILUY
         Bxs+TIgblVy361/0luVVtXLqw4ZJ7W+0tW8zjQCuqApLnC50tXhpsezoBrzisJLfri+r
         pjwuDb9o4H/fp3b8DdMx584TmNw5qZBXkfGyb32DBbMmMih4gxHz0CtruECGYJhLIy2f
         KxN1vSbo2s6jydSKfxEeQZyfjbX0Q6sqzMRI17wnA3dQE2/VpKWydyiwwnezXLZAm8dY
         AZL5QZEs6HdVGQw1I0vTjHkJIH7bLiseu7r53gydpdPMthTUmy7TiHMbhpcqTAZQQuqg
         O00A==
X-Gm-Message-State: AO0yUKW9AJh3yBv4CNhiNrq3xmqP0MJwyz3bom9vLVCrunuVY1Nn6lRU
        ARDJh/FbBCD1/oue4icEpalM7SbFEyg=
X-Google-Smtp-Source: AK7set8oLxjL0SDEAKqE1jjYlXMYZkQ5FdrC6H9Fyaw1Jjqy8Kzg/gYg9JGRe0jK5km3HDr24qcDnw==
X-Received: by 2002:adf:fc50:0:b0:2ce:a9e9:490b with SMTP id e16-20020adffc50000000b002cea9e9490bmr11464451wrs.31.1679233876643;
        Sun, 19 Mar 2023 06:51:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d4e84000000b002ceac2ccc4asm6620515wru.23.2023.03.19.06.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 06:51:16 -0700 (PDT)
Message-Id: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
From:   "Stanislav Malishevskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 13:51:15 +0000
Subject: [PATCH] That change for support different sslcert and sslkey types.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stanislav Malishevskiy <s.malishevskiy@auriga.com>

Basically git work with default curl ssl type - PEM. But for support
eTokens like SafeNet tokens via pksc11 need setup 'ENG' as sslcert type
and as sslkey type. So there added additional options for http for make
that possible.

Signed-off-by: Stanislav Malishevskiy stanislav.malishevskiy@gmail.com
---
    That change for support different sslcert and sslkey types.
    
    Basically git work with default curl ssl type - PEM. But for support
    eTokens like SafeNet tokens via pksc11 need setup 'ENG' as sslcert type
    and as sslkey type. So there added additional options for http for make
    that possible.
    
    Signed-off-by: Stanislav Malishevskiy stanislav.malishevskiy@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1474%2Fsmalishevskiy%2Fssl_types_support-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1474/smalishevskiy/ssl_types_support-v1
Pull-Request: https://github.com/git/git/pull/1474

 http.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/http.c b/http.c
index dbe4d29ef7a..d5d82c5230f 100644
--- a/http.c
+++ b/http.c
@@ -40,6 +40,7 @@ static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *curl_http_version = NULL;
 static const char *ssl_cert;
+static const char *ssl_cert_type;
 static const char *ssl_cipherlist;
 static const char *ssl_version;
 static struct {
@@ -59,6 +60,7 @@ static struct {
 #endif
 };
 static const char *ssl_key;
+static const char *ssl_key_type;
 static const char *ssl_capath;
 static const char *curl_no_proxy;
 #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
@@ -374,8 +376,12 @@ static int http_options(const char *var, const char *value, void *cb)
 		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
 		return git_config_pathname(&ssl_cert, var, value);
+	if (!strcmp("http.sslcerttype", var))
+		return git_config_string(&ssl_cert_type, var, value);
 	if (!strcmp("http.sslkey", var))
 		return git_config_pathname(&ssl_key, var, value);
+	if (!strcmp("http.sslkeytype", var))
+		return git_config_string(&ssl_key_type, var, value);
 	if (!strcmp("http.sslcapath", var))
 		return git_config_pathname(&ssl_capath, var, value);
 	if (!strcmp("http.sslcainfo", var))
@@ -1014,10 +1020,14 @@ static CURL *get_curl_handle(void)
 
 	if (ssl_cert)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
+	if (ssl_cert_type)
+		curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_cert_type);
 	if (has_cert_password())
 		curl_easy_setopt(result, CURLOPT_KEYPASSWD, cert_auth.password);
 	if (ssl_key)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
+	if (ssl_key_type)
+		curl_easy_setopt(result, CURLOPT_SSLKEYTYPE, ssl_key_type);
 	if (ssl_capath)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
 #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
@@ -1252,7 +1262,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		curl_ssl_verify = 0;
 
 	set_from_env(&ssl_cert, "GIT_SSL_CERT");
+	set_from_env(&ssl_cert_type, "GIT_SSL_CERT_TYPE");
 	set_from_env(&ssl_key, "GIT_SSL_KEY");
+	set_from_env(&ssl_key_type, "GIT_SSL_KEY_TYPE");
 	set_from_env(&ssl_capath, "GIT_SSL_CAPATH");
 	set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
 

base-commit: 950264636c68591989456e3ba0a5442f93152c1a
-- 
gitgitgadget
