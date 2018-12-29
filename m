Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35EC1F405
	for <e@80x24.org>; Sat, 29 Dec 2018 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeL2To6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 14:44:58 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:41953 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbeL2To5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 14:44:57 -0500
Received: by mail-oi1-f201.google.com with SMTP id j13so16446024oii.8
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5DeiRigHHiL0FnrVH/WpSF9LS/tnot0Ota5Mem6SZwU=;
        b=DEoHGYDkP1TeG0kftqB6rCnl95Co5TrGxCnXF7xYDgWDQVAGYadwh2EEQEVL2doFHh
         9QoRyMT1ZPNvQDdpjWYYB3ThZIX0nSubQhr/YnPStm6Tm3u6ZUj7d9M/+peeLHFRWznN
         Lfgaa09c8nmOyeRU3yCCFwCnvFODXDck7jFOwxwJApoMdC8ZNoXsziVBfnxkVOk5iTvi
         3yzDTryv43Kd3l6TINATb9qbUzMbpXh7UlCqrVHZ+0M+UwIG24Y1D+Sdy5jONUFLJxPX
         S3KdQOqY4Qmz2yjwKSgjKVngzUV10pJcf3egpWIsOP/eM78dygIah7dkgbLyuGOqLKr6
         yXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5DeiRigHHiL0FnrVH/WpSF9LS/tnot0Ota5Mem6SZwU=;
        b=NLeVIaq/UukTvPOYfohv3NXDccD0SRtepHqacoR7NaNNmnR1cytQiXYbidUyZGxNaU
         IkstoL5742e7byeKBPgCT7ir+k+mw+SMokoq8YTVW6lfoT9ljiRw7VHRhQ800KYPuHtT
         gCEjJ3at5Nw0Fe80WVgYcnYo5vtJ74hy3bjVcbr2c4WSpv9U2CdMfTga6962K3dU/3sA
         tpJNBoPgykjHsOSkw0Oi4Q5BjyyXCARf8MujoZdLO0EbPcMszzJFDOTUg8prJ5KxKMiW
         B6b50tL1sz9Agc/6O441c9m4CAHzabGdJrKx7q/ARl7c9Y2zXXjK3chB1zgrtxmEyF0s
         Afdw==
X-Gm-Message-State: AJcUukfffkriBS1oTbOzmlAd0OVHPDs12UQRtFIFvWztOMSFLfyiNgqh
        PwDevTDVBzeJa33X346/NK6TrO1MTAkkVH/OO7s=
X-Google-Smtp-Source: ALg8bN7d8XOKr1hDh+XG32XZqyCU4AsnzpBb0/eS4HAZNfWqmVMy5Lse97NJiqsSQ4ldvLOXhAyRTyka1XuVtW+Z9PY=
X-Received: by 2002:a54:4e9a:: with SMTP id c26mr26172944oiy.15.1546112696895;
 Sat, 29 Dec 2018 11:44:56 -0800 (PST)
Date:   Sat, 29 Dec 2018 11:44:47 -0800
In-Reply-To: <20181229194447.157763-1-masayasuzuki@google.com>
Message-Id: <20181229194447.157763-3-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20181228014720.206443-1-masayasuzuki@google.com> <20181229194447.157763-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH v2 2/2] Unset CURLOPT_FAILONERROR
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When GIT_CURL_VERBOSE is set, libcurl produces request/response headers
to stderr. However, if the response is an error response and
CURLOPT_FAILONERROR is set, libcurl stops parsing the response, and it
won't dump the headers. Showing HTTP response headers is useful for
debugging, especially for non-OK responses.

This is substantially same as setting http_options.keep_error to all
requests. Hence, remove this option.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 http.c                       |  4 ----
 http.h                       |  1 -
 remote-curl.c                |  1 -
 t/lib-httpd/apache.conf      |  1 +
 t/t5581-http-curl-verbose.sh | 28 ++++++++++++++++++++++++++++
 5 files changed, 29 insertions(+), 6 deletions(-)
 create mode 100755 t/t5581-http-curl-verbose.sh

diff --git a/http.c b/http.c
index d23417670..8f8101da3 100644
--- a/http.c
+++ b/http.c
@@ -1269,7 +1269,6 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
 
 	/*
@@ -1848,8 +1847,6 @@ static int http_request(const char *url,
 	strbuf_addstr(&buf, "Pragma:");
 	if (options && options->no_cache)
 		strbuf_addstr(&buf, " no-cache");
-	if (options && options->keep_error)
-		curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 	if (options && options->initial_request &&
 	    http_follow_config == HTTP_FOLLOW_INITIAL)
 		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
@@ -2415,7 +2412,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	freq->slot = get_active_slot();
 
 	curl_easy_setopt(freq->slot->curl, CURLOPT_FILE, freq);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
diff --git a/http.h b/http.h
index d305ca1dc..eebf40688 100644
--- a/http.h
+++ b/http.h
@@ -146,7 +146,6 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 /* Options for http_get_*() */
 struct http_get_options {
 	unsigned no_cache:1,
-		 keep_error:1,
 		 initial_request:1;
 
 	/* If non-NULL, returns the content-type of the response. */
diff --git a/remote-curl.c b/remote-curl.c
index 48656bf18..43e7a1d80 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -380,7 +380,6 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	http_options.extra_headers = &extra_headers;
 	http_options.initial_request = 1;
 	http_options.no_cache = 1;
-	http_options.keep_error = 1;
 
 	http_ret = http_get_strbuf(refs_url.buf, &buffer, &http_options);
 	switch (http_ret) {
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 581c010d8..cc4b87507 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -115,6 +115,7 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
+ScriptAliasMatch /error_git_upload_pack/(.*)/git-upload-pack error.sh/
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error/ error.sh/
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
new file mode 100755
index 000000000..73148eeba
--- /dev/null
+++ b/t/t5581-http-curl-verbose.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='test GIT_CURL_VERBOSE'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'setup repository' '
+	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" --bare init &&
+	git config push.default matching &&
+	echo content >file &&
+	git add file &&
+	git commit -m one &&
+	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public master:master
+'
+
+test_expect_success 'failure in git-upload-pack is shown' '
+	test_might_fail env GIT_CURL_VERBOSE=1 \
+		git clone "$HTTPD_URL/error_git_upload_pack/smart/repo.git" \
+		2>curl_log &&
+	cat curl_log | grep "< HTTP/1.1 500 Intentional Breakage"
+'
+
+stop_httpd
+
+test_done
-- 
2.20.1.415.g653613c723-goog

