Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2422CC677F1
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjAQVZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjAQVYT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:24:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493B577F1
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:43:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k16so2481986wms.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms84bYlRr7xSD32q06+mEzloC9pyLqiraakY1pkTy8k=;
        b=elyURk5qLjmxW3Q+85A3hH/x1ysLfIjKUlR4WXdV5nqGpDHJpKKduJVMXIFD2m7+Is
         8v3q9pu0mWPsmb8FEEvIpixDIpToVPGm2PiiGwU3+1A0z0xIBpRBpl986gNrce87Tfis
         PtSEdX3vYBB3sPRrf9zJSUZGUwAtrP5k5fuHz1Hw6yVQKdD/f8MDcvJE2hdWlPYHUMSu
         047t3Id+j6Lnpkgme6/CKFlxxCxvojfWSmJcqJi5sgyAu75VT3VCuF8lnibUyE7Jn3N6
         vwy0GD9snE11wjJTKZMN9ZTQl91P9BT4iriRSqhIL4GRpjyYK4wyvoAlunvqxu3S4GZm
         toNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms84bYlRr7xSD32q06+mEzloC9pyLqiraakY1pkTy8k=;
        b=3fnWAd++AU1TwtfzT2nbeRGWbJ+UT8JaSeKLSkVYBLVagQsBFYVVJLkaYRIEPBb3CA
         Wj2WhfxiaXQmqKC5UajOLFsE0I7w14OfZxJuG+Q41pfoXJ9uiv4wkhp+GORAq59FwjJ2
         PLHtssxzvxG8Vo6sTkTcVMyyVhwhJAzL/xF73EFxT/5DuI4d6TsN72pQcAT622xXx8El
         9xbMx8oL6VO1TUq7iK/xlmTijvHoxny3mN77Zok4yIcM82Cp8OCvDPFz1GU63CTv45es
         +5RG1qIa2VR8x4ScXsOjd62BX6vJ9i25ka7TmX7ir7FYCLFmI8IKaDSccXiz8Z+MCN5D
         j5Hw==
X-Gm-Message-State: AFqh2kpfT3yK9kdsqBzN8byLQFiKHV2ubQJJ3SeQSXjzXJexW+HZSx0I
        Lpogu0iWcVi7R/273soA0IX57ipvWTg=
X-Google-Smtp-Source: AMrXdXvYNOXiuB6V2W/Sgkh9fDWFvtMy9ujPg+7j7ME95O//LrZEaVCVrAa8KvC6kPCaZFoMKCLGNQ==
X-Received: by 2002:a7b:c8cc:0:b0:3d1:ee6c:f897 with SMTP id f12-20020a7bc8cc000000b003d1ee6cf897mr4123284wml.3.1673984592905;
        Tue, 17 Jan 2023 11:43:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m23-20020a05600c3b1700b003db0cab0844sm2201313wms.40.2023.01.17.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:43:12 -0800 (PST)
Message-Id: <pull.1435.v2.git.git.1673984591615.gitgitgadget@gmail.com>
In-Reply-To: <pull.1435.git.git.1673983640663.gitgitgadget@gmail.com>
References: <pull.1435.git.git.1673983640663.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Jan 2023 19:43:11 +0000
Subject: [PATCH v2] curl: resolve deprecated curl declarations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Fix CI-Alpine build by replacing deprecated
declarations with their suggested replacements

Note that this required changing the
callbacks of functions because the replacement
for these deprecations require a different function
signature for the callback and different parameters.

Every change done was made as to minimize
changed behavior as well as get the CI to pass again.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    curl: resolve deprecated curl declarations
    
    Fix CI-Alpine build by replacing deprecated declarations with their
    suggested replacements
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1435%2FAtariDreams%2Fcurl-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1435/AtariDreams/curl-v2
Pull-Request: https://github.com/git/git/pull/1435

Range-diff vs v1:

 1:  d84e7e003da ! 1:  c40fb2de13d curl: resolve deprecated curl declarations
     @@ git-curl-compat.h
       #endif
      +
      +/**
     -+ * CURLOPT_REDIR_PROTOCOLS_STR was added in 7.83.0, released in August
     ++ * CURLOPT_PROTOCOLS_STR was added in 7.83.0, released in August
      + * 2022.
      + */
      +#if LIBCURL_VERSION_NUM >= 0x075500
     -+#define GIT_CURL_HAVE_OPT_REDIR_PROTOCOLS_STR 1
     ++#define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
      +#endif
      
       ## http-push.c ##
     @@ http.c: void setup_curl_trace(CURL *handle)
       	curl_easy_setopt(handle, CURLOPT_DEBUGFUNCTION, curl_trace);
       	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
       }
     -+#ifdef GIT_CURL_HAVE_OPT_REDIR_PROTOCOLS_STR
     ++#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
      +static void get_curl_allowed_protocols(int from_user, char *protocol)
      +{
      +	unsigned int i = 0;
     @@ http.c: static int get_curl_http_version_opt(const char *version_string, long *o
       static CURL *get_curl_handle(void)
       {
       	CURL *result = curl_easy_init();
     -+#ifdef GIT_CURL_HAVE_OPT_REDIR_PROTOCOLS_STR
     ++#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
      +	static char protocol[20], redir_protocol[20];
      +#endif
       
     @@ http.c: static CURL *get_curl_handle(void)
       
       	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
       	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
     -+#ifdef GIT_CURL_HAVE_OPT_REDIR_PROTOCOLS_STR
     ++#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
      +	get_curl_allowed_protocols(0, redir_protocol);
      +	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS_STR, redir_protocol);
      +	get_curl_allowed_protocols(-1, protocol);


 git-curl-compat.h |  8 +++++
 http-push.c       |  6 ++--
 http.c            | 74 ++++++++++++++++++++++++++++++++++++++---------
 http.h            |  2 +-
 remote-curl.c     | 28 +++++++-----------
 5 files changed, 83 insertions(+), 35 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 56a83b6bbd8..38a2237c8fe 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -127,3 +127,11 @@
 #endif
 
 #endif
+
+/**
+ * CURLOPT_PROTOCOLS_STR was added in 7.83.0, released in August
+ * 2022.
+ */
+#if LIBCURL_VERSION_NUM >= 0x075500
+#define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
+#endif
diff --git a/http-push.c b/http-push.c
index 5f4340a36e6..ab458d4d062 100644
--- a/http-push.c
+++ b/http-push.c
@@ -198,13 +198,13 @@ static void curl_setup_http(CURL *curl, const char *url,
 		const char *custom_req, struct buffer *buffer,
 		curl_write_callback write_fn)
 {
-	curl_easy_setopt(curl, CURLOPT_PUT, 1);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
 	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-	curl_easy_setopt(curl, CURLOPT_IOCTLFUNCTION, ioctl_buffer);
-	curl_easy_setopt(curl, CURLOPT_IOCTLDATA, buffer);
+	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, ioctl_buffer);
+	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
 	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
diff --git a/http.c b/http.c
index 8a5ba3f4776..ee5f063e5b0 100644
--- a/http.c
+++ b/http.c
@@ -157,21 +157,12 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return size / eltsize;
 }
 
-curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
+int ioctl_buffer(void *userp, curl_off_t offset, int origin)
 {
-	struct buffer *buffer = clientp;
+	struct buffer *buffer = userp;
 
-	switch (cmd) {
-	case CURLIOCMD_NOP:
-		return CURLIOE_OK;
-
-	case CURLIOCMD_RESTARTREAD:
-		buffer->posn = 0;
-		return CURLIOE_OK;
-
-	default:
-		return CURLIOE_UNKNOWNCMD;
-	}
+	buffer->posn = 0;
+	return CURL_SEEKFUNC_OK;
 }
 
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
@@ -765,7 +756,52 @@ void setup_curl_trace(CURL *handle)
 	curl_easy_setopt(handle, CURLOPT_DEBUGFUNCTION, curl_trace);
 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
 }
+#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
+static void get_curl_allowed_protocols(int from_user, char *protocol)
+{
+	unsigned int i = 0;
+
+	if (is_transport_allowed("http", from_user)) {
+		protocol[i++] = 'h';
+		protocol[i++] = 't';
+		protocol[i++] = 't';
+		protocol[i++] = 'p';
+	}
+
+	if (is_transport_allowed("https", from_user)) {
+		if (i != 0) {
+			protocol[i++] = ',';
+		}
+
+		protocol[i++] = 'h';
+		protocol[i++] = 't';
+		protocol[i++] = 't';
+		protocol[i++] = 'p';
+		protocol[i++] = 's';
+	}
+	if (is_transport_allowed("ftp", from_user)) {
+		if (i != 0) {
+			protocol[i++] = ',';
+		}
 
+		protocol[i++] = 'f';
+		protocol[i++] = 't';
+		protocol[i++] = 'p';
+	}
+	if (is_transport_allowed("ftps", from_user)) {
+		if (i != 0) {
+			protocol[i++] = ',';
+		}
+
+		protocol[i++] = 'f';
+		protocol[i++] = 't';
+		protocol[i++] = 'p';
+		protocol[i++] = 's';
+	}
+
+	protocol[i] = '\0';
+}
+#else
 static long get_curl_allowed_protocols(int from_user)
 {
 	long allowed_protocols = 0;
@@ -781,6 +817,7 @@ static long get_curl_allowed_protocols(int from_user)
 
 	return allowed_protocols;
 }
+#endif
 
 #ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
 static int get_curl_http_version_opt(const char *version_string, long *opt)
@@ -810,6 +847,9 @@ static int get_curl_http_version_opt(const char *version_string, long *opt)
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
+#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
+	static char protocol[20], redir_protocol[20];
+#endif
 
 	if (!result)
 		die("curl_easy_init failed");
@@ -923,10 +963,18 @@ static CURL *get_curl_handle(void)
 
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
+#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
+	get_curl_allowed_protocols(0, redir_protocol);
+	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS_STR, redir_protocol);
+	get_curl_allowed_protocols(-1, protocol);
+	curl_easy_setopt(result, CURLOPT_PROTOCOLS_STR, protocol);
+#else
 	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
 			 get_curl_allowed_protocols(0));
 	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
 			 get_curl_allowed_protocols(-1));
+#endif
+
 	if (getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(result);
diff --git a/http.h b/http.h
index 3c94c479100..0ec572d4a06 100644
--- a/http.h
+++ b/http.h
@@ -40,7 +40,7 @@ struct buffer {
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
-curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
+int ioctl_buffer(void *userp, curl_off_t offset, int origin);
 
 /* Slot lifecycle functions */
 struct active_request_slot *get_active_slot(void);
diff --git a/remote-curl.c b/remote-curl.c
index 72dfb8fb86a..ae69dcb70d5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -717,25 +717,17 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	return avail;
 }
 
-static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
+static int rpc_ioctl(void *userp, curl_off_t offset, int origin)
 {
-	struct rpc_state *rpc = clientp;
+	struct rpc_state *rpc = userp;
 
-	switch (cmd) {
-	case CURLIOCMD_NOP:
-		return CURLIOE_OK;
-
-	case CURLIOCMD_RESTARTREAD:
-		if (rpc->initial_buffer) {
-			rpc->pos = 0;
-			return CURLIOE_OK;
-		}
-		error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
-		return CURLIOE_FAILRESTART;
-
-	default:
-		return CURLIOE_UNKNOWNCMD;
+	if (rpc->initial_buffer) {
+		rpc->pos = 0;
+		return CURL_SEEKFUNC_OK;
 	}
+
+	error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
+	return CURL_SEEKFUNC_FAIL;
 }
 
 struct check_pktline_state {
@@ -959,8 +951,8 @@ retry:
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
-		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, rpc_ioctl);
-		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, rpc);
+		curl_easy_setopt(slot->curl, CURLOPT_SEEKFUNCTION, rpc_ioctl);
+		curl_easy_setopt(slot->curl, CURLOPT_SEEKDATA, rpc);
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (chunked)\n", rpc->service_name);
 			fflush(stderr);

base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
-- 
gitgitgadget
