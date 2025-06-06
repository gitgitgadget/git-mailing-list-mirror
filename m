Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946827468
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202170; cv=none; b=rHq2wwr9kkByFV4NFNkSXYGIjEDFhi/GrlXg4jcIgwHBL3fQo5tEShbm3ZKXHsiJSWkp18RKekIX6PGQh0CY4Uj4uUt/JdtpPygIrzfivlCaH+NrYGv1rzKh1U0JqrZRN1hU1WJyXvLMdXwpEQzzpH82udhVFxBDCJFDnOAdVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202170; c=relaxed/simple;
	bh=tTNcq04+5yfXexplAbRpyZKErOhmbVsv8cfsLAo/+4w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hr2hzrBZSRJVlltLubsQwMSQaqfmRup6yKqFd6uufdL8EDSAayXpggvPzm41UVeonv30Jnxx8/clvRL89CI0Q040LIsA3qlmhxbiwmgLCUz70YoLNYckwl2Y2MDhVRnXLJYHCnbWYA6Z3haeYieW2r/BIMoXPYP22swwEemwNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA2KSYd2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA2KSYd2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a528243636so1154514f8f.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749202166; x=1749806966; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmV2vh8DTSDa7NX1VOBfrUzfJ+YFz2Wrinq/oV/VIfc=;
        b=LA2KSYd25OMyAXRSjD19raM2atZj0mH/mQbEkVT2NcENPjzDXyjc1qKdHJe6AeGjRL
         5aa8LRq84zbTSI1Rxz3+obBel2Q5ZPotdxOQXEr9EFuBar1LAzjdvkOtQVyWoQOvehAc
         S8Q0333dmNd7BJB+TyHit0mslMutu4lkd9s2QFkKQmxt7HBOu0XCtsZHni+jvf4IlgW6
         Lp77SaSTwgpWk9fP7wxIG1cHm+z0PLeyoND9Koues7beWUl5fLe13dN0RwW8f19pacn8
         TNgbsWqVLxJgS6E64b4L7S3QDNzNwvoqSOO0rVU5AWAaf2pd/D358SY41uHBe5JubN3l
         5szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202166; x=1749806966;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmV2vh8DTSDa7NX1VOBfrUzfJ+YFz2Wrinq/oV/VIfc=;
        b=aksxN/cYDm/mGRLmW5QvPHq3EMKglc5LpN2rCMPYXvybYByGvkwu2LaDoqahMPkqER
         KaYk+tNeVEM15l6CXDhyj13ypczeU5S8G/oAhQNLa4F6/GNGkgwY/PCt/gcqQ+8/Qmeq
         spVQrKpN5YXqSshlaRrib3c1K9XFKmmS8TlPvhRwKdUQE2DVwRpu0iaEsysxRWtPt4sd
         q9ZOJfsunHcIXOTa7lP/CYFVInuRgjhhqPRPgt3DY87gsYl7fOw8p8MmNwDm0ya8CwUN
         MDlJl+6QcojMEFO0Wa9o+cruEgIZUAtj584Sbb6EyddeWTvK0MEWWKjtK981n40IhBzG
         taQA==
X-Gm-Message-State: AOJu0Yy5y+30atPIxgBM1Pv4IcAfbT8dcYoemM+vjEX0HJbUSAIERzvx
	kknu6x80RZN6Lm9lO+2vmX0hbz/08Dt3Ftmw6IMe0Lp7aZXLS9EM/hXqImVITg==
X-Gm-Gg: ASbGncsNaqZVikgMXeX0JQAsliY/KWVQrcCQ92sn7JgaSoqymehHBnSSSGOeSbCHGKM
	CVC+AiSCUDEJkY1ohIQiJ/+u24WvOSP6GHg3xH///gXLrKUj9JYfOn8fnhiZTWoQpdjoO2yg4nJ
	GEw9T9wSjCEtAaLGZR/tFlBzfGX19kQP0OojBYGZ9k6dPYpbT3vDUhmUgjHhXALaG7Fqjhn+30c
	f1EYltUpLXDEeIfqLGNHHlqy9aOu+tQt7o11jM3nGzLVRkTFv9hKL87/Q31pQFo53T6UOqPIhL9
	2WLqMlc93igDB3T+Ew9AanG67M/tTP5tiwiN5TVjkQIuLG0gdmXdYuAiQ8p9e54=
X-Google-Smtp-Source: AGHT+IFqWziZoOu9fv3thvjuDanZrF0qd89bIOLMfDCL3okL2GFLN8A3PKw8kczSUH2pWZ59PoAjEw==
X-Received: by 2002:a05:6000:2512:b0:3a3:67bb:8f46 with SMTP id ffacd0b85a97d-3a531abd9c3mr2245247f8f.57.1749202166229;
        Fri, 06 Jun 2025 02:29:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452ec06d9aesm11112275e9.15.2025.06.06.02.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:29:25 -0700 (PDT)
Message-Id: <pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
In-Reply-To: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Jun 2025 09:29:20 +0000
Subject: [PATCH v2 0/4] curl: pass long values where expected
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

This came up during the release process of Git for Windows v2.50.0-rc1.

Changes since v1:

 * Rebased on top of jk/curl-easy-setopt-typefix.

Jeff King (3):
  curl: fix integer constant typechecks with curl_easy_setopt()
  curl: fix integer variable typechecks with curl_easy_setopt()
  curl: fix symbolic constant typechecks with curl_easy_setopt()

Johannes Schindelin (1):
  curl: pass `long` values where expected

 http-push.c   |  8 ++++----
 http.c        | 50 +++++++++++++++++++++++++-------------------------
 imap-send.c   |  6 +++---
 remote-curl.c | 12 ++++++------
 4 files changed, 38 insertions(+), 38 deletions(-)


base-commit: 0bd2d791cc9f745ebaedafc0e1cbebdebe41343e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1931%2Fdscho%2Fcurl-options-want-long-instead-of-int-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1931/dscho/curl-options-want-long-instead-of-int-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1931

Range-diff vs v1:

 -:  ----------- > 1:  6f11c42e8ed curl: fix integer constant typechecks with curl_easy_setopt()
 -:  ----------- > 2:  30325e23ba0 curl: fix integer variable typechecks with curl_easy_setopt()
 -:  ----------- > 3:  4558c8f84b2 curl: fix symbolic constant typechecks with curl_easy_setopt()
 1:  803e235837e ! 4:  80de7491d24 curl: pass `long` values where expected
     @@ Commit message
          The most likely explanation is the entry "typecheck-gcc.h: fix the
          typechecks" in cURL's release notes (https://curl.se/ch/8.14.0.html).
      
     -    Let's explicitly convert all `int` parameters in `curl_easy_setopt()`
     -    calls to `long` parameters.
     +    Nearly identical compile errors afflicted recently-updated Debian
     +    setups, which have been addressed by `jk/curl-easy-setopt-typefix`.
     +
     +    However, on macOS Git is built with different build options, which
     +    uncovered more instances of `int` values that need to be cast to
     +    constants, which were not covered by 6f11c42e8edc (curl: fix integer
     +    constant typechecks with curl_easy_setopt(), 2025-06-04). Let's
     +    explicitly convert even those remaining `int` constants in
     +    `curl_easy_setopt()` calls to `long` parameters.
     +
     +    In addition to looking at the compile errors of the `osx-gcc` job, I
     +    verified that there are no other instances of the same issue that need
     +    to be handled in this manner (and that might not be caught by our CI
     +    builds because of yet other build options that might skip those code
     +    parts), I ran the following command and inspected all 23 results
     +    manually to ensure that the fix is now actually complete:
     +
     +      git grep -n curl_easy_setopt |
     +      grep -ve ',.*, *[A-Za-z_"&]' \
     +        -e ',.*, *[-0-9]*L)' \
     +        -e ',.*,.* (long)'
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## http-push.c ##
     -@@ http-push.c: static char *xml_entities(const char *s)
     - static void curl_setup_http_get(CURL *curl, const char *url,
     - 		const char *custom_req)
     - {
     --	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1);
     -+	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1l);
     - 	curl_easy_setopt(curl, CURLOPT_URL, url);
     - 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
     - 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_null);
      @@ http-push.c: static void curl_setup_http(CURL *curl, const char *url,
       		const char *custom_req, struct buffer *buffer,
       		curl_write_callback write_fn)
       {
      -	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
     -+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1l);
     ++	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
       	curl_easy_setopt(curl, CURLOPT_URL, url);
       	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
       	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
     @@ http-push.c: static void curl_setup_http(CURL *curl, const char *url,
       	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
       	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
      -	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
     -+	curl_easy_setopt(curl, CURLOPT_NOBODY, 0l);
     ++	curl_easy_setopt(curl, CURLOPT_NOBODY, 0L);
       	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
      -	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
     -+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1l);
     ++	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
       }
       
       static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
      
       ## http.c ##
     -@@ http.c: static CURL *get_curl_handle(void)
     - 		die("curl_easy_init failed");
     - 
     - 	if (!curl_ssl_verify) {
     --		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
     --		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
     -+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0l);
     -+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0l);
     - 	} else {
     - 		/* Verify authenticity of the peer's certificate */
     --		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1);
     -+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1l);
     - 		/* The name in the cert must match whom we tried to connect */
     --		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
     -+		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2l);
     - 	}
     - 
     -     if (curl_http_version) {
     -@@ http.c: static CURL *get_curl_handle(void)
     - 
     - 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
     - 	    !http_schannel_check_revoke) {
     --		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
     -+		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, (long)CURLSSLOPT_NO_REVOKE);
     - 	}
     - 
     - 	if (http_proactive_auth != PROACTIVE_AUTH_NONE)
     -@@ http.c: static CURL *get_curl_handle(void)
     - 				 curl_low_speed_time);
     - 	}
     - 
     --	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
     --	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
     -+	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20l);
     -+	curl_easy_setopt(result, CURLOPT_POSTREDIR, (long)CURL_REDIR_POST_ALL);
     - 
     - #ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
     - 	{
     -@@ http.c: static CURL *get_curl_handle(void)
     - 		user_agent ? user_agent : git_user_agent());
     - 
     - 	if (curl_ftp_no_epsv)
     --		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
     -+		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0l);
     - 
     - 	if (curl_ssl_try)
     - 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
     -@@ http.c: static CURL *get_curl_handle(void)
     - 
     - 		if (starts_with(curl_http_proxy, "socks5h"))
     - 			curl_easy_setopt(result,
     --				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
     -+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS5_HOSTNAME);
     - 		else if (starts_with(curl_http_proxy, "socks5"))
     - 			curl_easy_setopt(result,
     --				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
     -+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS5);
     - 		else if (starts_with(curl_http_proxy, "socks4a"))
     - 			curl_easy_setopt(result,
     --				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4A);
     -+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS4A);
     - 		else if (starts_with(curl_http_proxy, "socks"))
     - 			curl_easy_setopt(result,
     --				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
     -+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS4);
     - 		else if (starts_with(curl_http_proxy, "https")) {
     --			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
     -+			curl_easy_setopt(result, CURLOPT_PROXYTYPE, (long)CURLPROXY_HTTPS);
     - 
     - 			if (http_proxy_ssl_cert)
     - 				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
     -@@ http.c: static CURL *get_curl_handle(void)
     - 	}
     - 	init_curl_proxy_auth(result);
     - 
     --	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1);
     -+	curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1l);
     - 
     - 	if (curl_tcp_keepidle > -1)
     - 		curl_easy_setopt(result, CURLOPT_TCP_KEEPIDLE,
      @@ http.c: struct active_request_slot *get_active_slot(void)
       	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
       	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
     @@ http.c: struct active_request_slot *get_active_slot(void)
      -	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
      -	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
      -	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
     -+	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0l);
     -+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1l);
     -+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1l);
     ++	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0L);
     ++	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
     ++	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1L);
       	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
       
       	/*
     @@ http.c: struct active_request_slot *get_active_slot(void)
       	 */
       	if (http_follow_config == HTTP_FOLLOW_ALWAYS)
      -		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
     -+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1l);
     ++		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
       	else
      -		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0);
     -+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0l);
     ++		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0L);
       
       	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
       	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
     @@ http.c: static int http_request(const char *url,
       
       	slot = get_active_slot();
      -	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
     -+	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1l);
     ++	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
       
       	if (!result) {
      -		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
     -+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1l);
     ++		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1L);
       	} else {
      -		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
     -+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0l);
     ++		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
       		curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, result);
       
       		if (target == HTTP_REQUEST_FILE) {
     @@ http.c: static int http_request(const char *url,
       	if (options && options->initial_request &&
       	    http_follow_config == HTTP_FOLLOW_INITIAL)
      -		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
     -+		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1l);
     ++		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
       
       	headers = curl_slist_append(headers, buf.buf);
       
     @@ http.c: static int http_request(const char *url,
       	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
       	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
      -	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
     -+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0l);
     ++	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0L);
       
       	ret = run_one_slot(slot, &results);
       
     @@ http.c: struct http_object_request *new_http_object_request(const char *base_url
       
       	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
      -	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
     -+	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0l);
     ++	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0L);
       	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
       	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
       	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
      
     - ## imap-send.c ##
     -@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
     - 
     - 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
     - 	strbuf_release(&path);
     --	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
     -+	curl_easy_setopt(curl, CURLOPT_PORT, (long)srvc->port);
     - 
     - 	if (srvc->auth_method) {
     - 		struct strbuf auth = STRBUF_INIT;
     -@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
     - 	if (!srvc->use_ssl)
     - 		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_TRY);
     - 
     --	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
     --	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
     -+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, (long)srvc->ssl_verify);
     -+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, (long)srvc->ssl_verify);
     - 
     - 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
     - 
     -
       ## remote-curl.c ##
     -@@ remote-curl.c: static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
     - 	headers = curl_slist_append(headers, rpc->hdr_content_type);
     - 	headers = curl_slist_append(headers, rpc->hdr_accept);
     - 
     --	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
     --	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
     -+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0l);
     -+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1l);
     - 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
     - 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
     - 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
     --	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
     -+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4l);
     - 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
     - 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
     - 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
      @@ remote-curl.c: retry:
       
       	slot = get_active_slot();
       
      -	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
      -	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
     -+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0l);
     -+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1l);
     ++	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
     ++	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
       	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
       	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
       
     @@ remote-curl.c: retry:
       	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state));
       	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &rpc_in_data);
      -	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
     -+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0l);
     ++	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0L);
       
       
       	rpc->any_written = 0;

-- 
gitgitgadget
