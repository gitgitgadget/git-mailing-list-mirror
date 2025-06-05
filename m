Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C681F30C3
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112311; cv=none; b=O3eqD7cmSgqOn5Dgq0E4172GGwyA7Y9ikA81g43MrahfXv8kyqgqw9094PkN/JI0SWX+zd+oKVvB637cnahjHy5lwNB5zBPFKadw/nDz8F+IhnXCxbVbUbH9t8/a6AZzirH4a5UofA67B1YD6Pmyds6gacrMQ9nPt4mdyc4h4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112311; c=relaxed/simple;
	bh=1DR/WlCUW7agsbsdUE5O4/kXqjJQhuPZw/cZXM+XpYQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=tfw1TukXlkcu5RmobJSsS1s6HpDvMfWRAk0yaXrir70d8sTwDtWBBc4eGUc1L/EPB0GFhqYHcXaoAsTOKJ7h9Eq2HelMRSbqVRd32vHzPWabZdc4jWX459ENOCp5DnddWVpQ/mkZeAkUBzmZdVVBqHwJC1jHjnPgW7dUTfTJNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG2EXKL1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG2EXKL1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so5971445e9.3
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749112305; x=1749717105; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b4EouZMGK+R72/Y98IqEDLMMCFHY6l5sM62OTZgN+2g=;
        b=SG2EXKL17v3qE+RXvce5+hrkK4fEu37FwLuSSjWWVT2LM3GNZj2ANrwoL/y7A0PqeX
         rD5ag1/S1lL2w9k44VZGL/2wx0qt7I9fF9n8REaWzt6MCNrLPKwADWsKRaH50HChft1L
         pGjD31z5eXALuHjgsJ3QNGwe9Hrdq6Jz0ymCyTeAIS9cNSr35WGYojla8a/8vDB8me/K
         W2IGN0x30K29l4yVufWH34jjUVsROsmTiwubFdqzQCBPCfJIr/dzNn/dxf/C1IuONapB
         udQ5cpte442/wGRf9oHqPWKAM5SxcXLx7r/tA0SK+1V/K3MU19+Qb7QYc1agYQuJfhE1
         vdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749112305; x=1749717105;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4EouZMGK+R72/Y98IqEDLMMCFHY6l5sM62OTZgN+2g=;
        b=qx0jjRbv/Er3wcsMWBYRSW+xd2HQtDOSFw7QPnc34yEI9HQ6G8nGWfr0BgKMeD4Pi3
         eQoTsanz7uCysV4zVFUpHV03LNwpOe2gzPmuNnosVl9o2p485dZYPea4qAKkHnRKsqoW
         MPRv+/vByYqi5H+SWOnEY1ChuHcuBnVcvxo6YdpDncErP7d5QfTcNMCJx/TaazSx0Yoj
         cjF9y18NHc5/4nl1tf+JMQh+2nTC00d17sAI1FcNEgSg5N0AFCmbNGVeGcpQ1Vv12v+E
         xJHbcdgriiuGtFe9J7SjyOD65w4DVaGxw4mE4ipc6sOkGqL16SuyslX6i4nQ2rIuKj0m
         3Muw==
X-Gm-Message-State: AOJu0Yz+algwb+mbHRGwH/eBj+g81zrRzUuki0uxlz44JAvwDvWBfkjc
	tnykh2N/TA7iqKiQeVaEDTZaxJF9PXaAsRcqHhdEQOAvGnTrODS6TWHD5cCk0w==
X-Gm-Gg: ASbGncvgHD/BXxWBSagXlLby5oBNOELJ1GwoHQkd4yoUi7Gzp35SpjFdbQa83tz3/Fi
	TRH3vBOx7UfN53HTAHvlrYE6c4CPgzkbQG9MWZ+0P4XhzSV3R3Q5WE3LxMCJHA0K5+hZQU+1+k1
	qB0XsGKNK3K4DcbAVqbWXEB4WblQeS/t34Be1u7cTaO0LyF9mPGC08TVvQ7382Z/WjbwxgiW08M
	1rQYpI83qdQkWw1ExRcePWP8WhDp7eVt7eE+pUmobanfOYPQg9GrAahaqvGpLZTlG+fMkESNSot
	/8kCrDPUQCkZppvMBu7itr/lq3btGRPZX61soq0TqfZS/G6HNMfi
X-Google-Smtp-Source: AGHT+IHFNRveOapqJXkqF3KYn+75c/jHY1StpsvrAfg1a0G4Jh0ENhcOXzL5WCWbjvaDBZMppH0t6g==
X-Received: by 2002:a05:600c:3b1c:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-451f6506aeamr32112675e9.20.1749112305215;
        Thu, 05 Jun 2025 01:31:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f9662cd1sm17042835e9.0.2025.06.05.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:31:44 -0700 (PDT)
Message-Id: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Jun 2025 08:31:43 +0000
Subject: [PATCH] curl: pass `long` values where expected
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of Homebrew's update to cURL v8.14.0, there are new compile errors to
be observed in the `osx-gcc` job of Git's CI builds:

  In file included from http.h:8,
                   from imap-send.c:36:
  In function 'setup_curl',
      inlined from 'curl_append_msgs_to_imap' at imap-send.c:1460:9,
      inlined from 'cmd_main' at imap-send.c:1581:9:
  /usr/local/Cellar/curl/8.14.0/include/curl/typecheck-gcc.h:50:15: error: call to '_curl_easy_setopt_err_long' declared with attribute warning: curl_easy_setopt expects a long argument [-Werror=attribute-warning]
     50 |               _curl_easy_setopt_err_long();                             \
        |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /usr/local/Cellar/curl/8.14.0/include/curl/curl.h:54:7: note: in definition of macro 'CURL_IGNORE_DEPRECATION'
     54 |       statements \
        |       ^~~~~~~~~~
  imap-send.c:1423:9: note: in expansion of macro 'curl_easy_setopt'
   1423 |         curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
        |         ^~~~~~~~~~~~~~~~
  [... many more instances of nearly identical warnings...]

See for example this CI workflow run:
https://github.com/git/git/actions/runs/15454602308/job/43504278284#step:4:307

The most likely explanation is the entry "typecheck-gcc.h: fix the
typechecks" in cURL's release notes (https://curl.se/ch/8.14.0.html).

Let's explicitly convert all `int` parameters in `curl_easy_setopt()`
calls to `long` parameters.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    curl: pass long values where expected
    
    This came up during the release process of Git for Windows v2.50.0-rc1.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1931%2Fdscho%2Fcurl-options-want-long-instead-of-int-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1931/dscho/curl-options-want-long-instead-of-int-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1931

 http-push.c   |  8 ++++----
 http.c        | 50 +++++++++++++++++++++++++-------------------------
 imap-send.c   |  6 +++---
 remote-curl.c | 12 ++++++------
 4 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/http-push.c b/http-push.c
index f9e67cabd4b..56db9ce8edf 100644
--- a/http-push.c
+++ b/http-push.c
@@ -195,7 +195,7 @@ static char *xml_entities(const char *s)
 static void curl_setup_http_get(CURL *curl, const char *url,
 		const char *custom_req)
 {
-	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1l);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_null);
@@ -205,7 +205,7 @@ static void curl_setup_http(CURL *curl, const char *url,
 		const char *custom_req, struct buffer *buffer,
 		curl_write_callback write_fn)
 {
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1l);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
 	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
@@ -213,9 +213,9 @@ static void curl_setup_http(CURL *curl, const char *url,
 	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, seek_buffer);
 	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
-	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(curl, CURLOPT_NOBODY, 0l);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1l);
 }
 
 static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
diff --git a/http.c b/http.c
index 3c029cf8947..91ac7a74f26 100644
--- a/http.c
+++ b/http.c
@@ -1019,13 +1019,13 @@ static CURL *get_curl_handle(void)
 		die("curl_easy_init failed");
 
 	if (!curl_ssl_verify) {
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0l);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0l);
 	} else {
 		/* Verify authenticity of the peer's certificate */
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1l);
 		/* The name in the cert must match whom we tried to connect */
-		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2l);
 	}
 
     if (curl_http_version) {
@@ -1057,7 +1057,7 @@ static CURL *get_curl_handle(void)
 
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_check_revoke) {
-		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
+		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, (long)CURLSSLOPT_NO_REVOKE);
 	}
 
 	if (http_proactive_auth != PROACTIVE_AUTH_NONE)
@@ -1117,8 +1117,8 @@ static CURL *get_curl_handle(void)
 				 curl_low_speed_time);
 	}
 
-	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
-	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
+	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20l);
+	curl_easy_setopt(result, CURLOPT_POSTREDIR, (long)CURL_REDIR_POST_ALL);
 
 #ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
 	{
@@ -1151,7 +1151,7 @@ static CURL *get_curl_handle(void)
 		user_agent ? user_agent : git_user_agent());
 
 	if (curl_ftp_no_epsv)
-		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
+		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0l);
 
 	if (curl_ssl_try)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
@@ -1193,18 +1193,18 @@ static CURL *get_curl_handle(void)
 
 		if (starts_with(curl_http_proxy, "socks5h"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS5_HOSTNAME);
 		else if (starts_with(curl_http_proxy, "socks5"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS5);
 		else if (starts_with(curl_http_proxy, "socks4a"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4A);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS4A);
 		else if (starts_with(curl_http_proxy, "socks"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS4);
 		else if (starts_with(curl_http_proxy, "https")) {
-			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
+			curl_easy_setopt(result, CURLOPT_PROXYTYPE, (long)CURLPROXY_HTTPS);
 
 			if (http_proxy_ssl_cert)
 				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
@@ -1254,7 +1254,7 @@ static CURL *get_curl_handle(void)
 	}
 	init_curl_proxy_auth(result);
 
-	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1);
+	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1l);
 
 	if (curl_tcp_keepidle > -1)
 		curl_easy_setopt(result, CURLOPT_TCP_KEEPIDLE,
@@ -1540,9 +1540,9 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, -1L);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0l);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1l);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1l);
 	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
 
 	/*
@@ -1551,9 +1551,9 @@ struct active_request_slot *get_active_slot(void)
 	 * HTTP_FOLLOW_* cases themselves.
 	 */
 	if (http_follow_config == HTTP_FOLLOW_ALWAYS)
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1l);
 	else
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0l);
 
 	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
@@ -2120,12 +2120,12 @@ static int http_request(const char *url,
 	int ret;
 
 	slot = get_active_slot();
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1l);
 
 	if (!result) {
-		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1l);
 	} else {
-		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0l);
 		curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, result);
 
 		if (target == HTTP_REQUEST_FILE) {
@@ -2151,7 +2151,7 @@ static int http_request(const char *url,
 		strbuf_addstr(&buf, " no-cache");
 	if (options && options->initial_request &&
 	    http_follow_config == HTTP_FOLLOW_INITIAL)
-		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1l);
 
 	headers = curl_slist_append(headers, buf.buf);
 
@@ -2170,7 +2170,7 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0l);
 
 	ret = run_one_slot(slot, &results);
 
@@ -2750,7 +2750,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	freq->headers = object_request_headers();
 
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0l);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f8..2e812f5a6e9 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1420,7 +1420,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
-	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
+	curl_easy_setopt(curl, CURLOPT_PORT, (long)srvc->port);
 
 	if (srvc->auth_method) {
 		struct strbuf auth = STRBUF_INIT;
@@ -1433,8 +1433,8 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	if (!srvc->use_ssl)
 		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_TRY);
 
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, (long)srvc->ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, (long)srvc->ssl_verify);
 
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
 
diff --git a/remote-curl.c b/remote-curl.c
index 590b228f67f..0c229e39ae1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -877,12 +877,12 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
 
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0l);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1l);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
-	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4l);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
@@ -970,8 +970,8 @@ retry:
 
 	slot = get_active_slot();
 
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0l);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1l);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 
@@ -1058,7 +1058,7 @@ retry:
 	rpc_in_data.check_pktline = stateless_connect;
 	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state));
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &rpc_in_data);
-	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0l);
 
 
 	rpc->any_written = 0;

base-commit: 0d42fbd9a1f30c63cf0359a1c5aaa77020972f72
-- 
gitgitgadget
