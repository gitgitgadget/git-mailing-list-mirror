Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE756C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjAQVsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjAQVpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:45:34 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4C340BC8
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 12:09:15 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q8so11369233wmo.5
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 12:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrSQjIP5OuuOyE9zLF76ew7bPS2otmfQGDHsRoDi3gk=;
        b=NBlfBxpO0HSadSIbXha+XYZ944I/ddruaYAquVzaihAimkapmk7RcofCxjTB7Wc58G
         2IJzH2x1WIeB8nycs5aC7HpHEE4GuLupN6nCQfE/n7rOpb1m23LYxy92crLtLTH4OhSf
         IVJP4Sa+/oUjz5ZSYdi79/q833RGnBZx1iP7hyTEi1ypBKS9PdqgdeSVkXUPJJTj8H8O
         nra93LJfqTLkDKuBkYM3KPsMO4dZ6ydldtAN4CmIT+lt+b84Xl33UUr+cs/1pBxpdEjw
         EoQ1s57dc3ev9UpkJYC3walUZqyh8zARWTnn0shdS1OXPMcWHcPd1Ij+fXFgK9bDT9vd
         JHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrSQjIP5OuuOyE9zLF76ew7bPS2otmfQGDHsRoDi3gk=;
        b=bLSgBAQjpHdSY3GtAhurmYVuNR82yrGCQn6AdhHFXq3rdxU5DvNfiJXtbPJh77esb7
         zhyTHUzAnTeYhVRPn46fdAoXXnT2DxtkNEyUjc4uKpG+bbpX8JOIZrWpBLTbIp9WqCqB
         gAAfGivszCVbhCQO4BzALEEAXqHprnV722dWNi1/McWK8qYVAFJrdaMsniyEE+YNtcg/
         TkzResHuSMY3MIhdH9T06cjMUH7L4loYI/2LBhTWyV5x94OGQ8FfCpNtUCYbuoid81Yj
         7KtLrCRKvCr3ezNLY7W5fCqYaki0yCg86Xh3nXIkaSng5k//1PYXyDxudZ3xKT7tCp26
         JcCQ==
X-Gm-Message-State: AFqh2kqxFibOaTOHrod6YYkedJiWPeSBeNtPJlm97KKI3WfTXZVNlQOf
        LMk/AP0ja1l1z0/UgdrkpR9ZqoSVZdY=
X-Google-Smtp-Source: AMrXdXvMXrz/G+gtj01mj2QoaVQhQUXa7p32ltVkKeb9J/7C7bzTCA0avnCiLgayAawnEF2C9DiQBg==
X-Received: by 2002:a7b:cb01:0:b0:3db:13f:c86c with SMTP id u1-20020a7bcb01000000b003db013fc86cmr4273603wmj.41.1673986154169;
        Tue, 17 Jan 2023 12:09:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17-20020adff511000000b002366553eca7sm6996616wro.83.2023.01.17.12.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:09:13 -0800 (PST)
Message-Id: <pull.1435.v4.git.git.1673986152672.gitgitgadget@gmail.com>
In-Reply-To: <pull.1435.v3.git.git.1673985725868.gitgitgadget@gmail.com>
References: <pull.1435.v3.git.git.1673985725868.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Jan 2023 20:09:12 +0000
Subject: [PATCH v4] curl: resolve deprecated curl declarations
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1435%2FAtariDreams%2Fcurl-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1435/AtariDreams/curl-v4
Pull-Request: https://github.com/git/git/pull/1435

Range-diff vs v3:

 1:  14ca56fe608 ! 1:  ebe36ad23fa curl: resolve deprecated curl declarations
     @@ http-push.c: static void curl_setup_http(CURL *curl, const char *url,
       	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
      
       ## http.c ##
     -@@ http.c: static const char *http_proxy_ssl_ca_info;
     - static struct credential proxy_cert_auth = CREDENTIAL_INIT;
     - static int proxy_ssl_cert_password_required;
     - 
     -+#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
     -+static char protocol_list[20];
     -+#endif
     -+
     - static struct {
     - 	const char *name;
     - 	long curlauth_param;
      @@ http.c: size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
       	return size / eltsize;
       }
     @@ http.c: size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffe
      +int seek_buffer(void *userp, curl_off_t offset, int origin)
       {
      -	struct buffer *buffer = clientp;
     --
     ++	struct buffer *buffer = userp;
     + 
      -	switch (cmd) {
      -	case CURLIOCMD_NOP:
      -		return CURLIOE_OK;
     @@ http.c: size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffe
      -	case CURLIOCMD_RESTARTREAD:
      -		buffer->posn = 0;
      -		return CURLIOE_OK;
     -+	struct buffer *buffer = userp;
     - 
     +-
      -	default:
      -		return CURLIOE_UNKNOWNCMD;
      +	if (origin != SEEK_SET)
     @@ http.c: void setup_curl_trace(CURL *handle)
       	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
       }
      +#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
     -+static void get_curl_allowed_protocols(int from_user)
     ++static void get_curl_allowed_protocols(char* protocol_buff, int from_user)
      +{
      +	unsigned int i = 0;
     - 
     ++
      +	if (is_transport_allowed("http", from_user)) {
     -+		protocol_list[i++] = 'h';
     -+		protocol_list[i++] = 't';
     -+		protocol_list[i++] = 't';
     -+		protocol_list[i++] = 'p';
     ++		protocol_buff[i++] = 'h';
     ++		protocol_buff[i++] = 't';
     ++		protocol_buff[i++] = 't';
     ++		protocol_buff[i++] = 'p';
      +	}
      +
      +	if (is_transport_allowed("https", from_user)) {
      +		if (i != 0) {
     -+			protocol_list[i++] = ',';
     ++			protocol_buff[i++] = ',';
      +		}
      +
     -+		protocol_list[i++] = 'h';
     -+		protocol_list[i++] = 't';
     -+		protocol_list[i++] = 't';
     -+		protocol_list[i++] = 'p';
     -+		protocol_list[i++] = 's';
     ++		protocol_buff[i++] = 'h';
     ++		protocol_buff[i++] = 't';
     ++		protocol_buff[i++] = 't';
     ++		protocol_buff[i++] = 'p';
     ++		protocol_buff[i++] = 's';
      +	}
      +	if (is_transport_allowed("ftp", from_user)) {
      +		if (i != 0) {
     -+			protocol_list[i++] = ',';
     ++			protocol_buff[i++] = ',';
      +		}
      +
     -+		protocol_list[i++] = 'f';
     -+		protocol_list[i++] = 't';
     -+		protocol_list[i++] = 'p';
     ++		protocol_buff[i++] = 'f';
     ++		protocol_buff[i++] = 't';
     ++		protocol_buff[i++] = 'p';
      +	}
      +	if (is_transport_allowed("ftps", from_user)) {
      +		if (i != 0) {
     -+			protocol_list[i++] = ',';
     ++			protocol_buff[i++] = ',';
      +		}
      +
     -+		protocol_list[i++] = 'f';
     -+		protocol_list[i++] = 't';
     -+		protocol_list[i++] = 'p';
     -+		protocol_list[i++] = 's';
     ++		protocol_buff[i++] = 'f';
     ++		protocol_buff[i++] = 't';
     ++		protocol_buff[i++] = 'p';
     ++		protocol_buff[i++] = 's';
      +	}
     -+
     -+	protocol_list[i] = '\0';
     + 
     ++	protocol_buff[i] = '\0';
      +}
      +#else
       static long get_curl_allowed_protocols(int from_user)
     @@ http.c: static long get_curl_allowed_protocols(int from_user)
       
       #ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
       static int get_curl_http_version_opt(const char *version_string, long *opt)
     +@@ http.c: static int get_curl_http_version_opt(const char *version_string, long *opt)
     + 
     + static CURL *get_curl_handle(void)
     + {
     ++
     ++#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
     ++char protocol_buff[20];
     ++#endif
     ++
     + 	CURL *result = curl_easy_init();
     + 
     + 	if (!result)
      @@ http.c: static CURL *get_curl_handle(void)
       
       	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
       	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
      +#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
     -+	get_curl_allowed_protocols(0);
     -+	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS_STR, redir_protocol);
     -+	get_curl_allowed_protocols(-1);
     -+	curl_easy_setopt(result, CURLOPT_PROTOCOLS_STR, protocol);
     ++	get_curl_allowed_protocols(protocol_buff, 0);
     ++	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS_STR, protocol_buff);
     ++	get_curl_allowed_protocols(protocol_buff, -1);
     ++	curl_easy_setopt(result, CURLOPT_PROTOCOLS_STR, protocol_buff);
      +#else
       	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
       			 get_curl_allowed_protocols(0));


 INSTALL           |  2 +-
 git-curl-compat.h |  8 +++++
 http-push.c       |  6 ++--
 http.c            | 81 ++++++++++++++++++++++++++++++++++++++++-------
 http.h            |  2 +-
 remote-curl.c     | 31 +++++++++---------
 6 files changed, 97 insertions(+), 33 deletions(-)

diff --git a/INSTALL b/INSTALL
index 33447883974..d5694f8c470 100644
--- a/INSTALL
+++ b/INSTALL
@@ -139,7 +139,7 @@ Issues of note:
 	  not need that functionality, use NO_CURL to build without
 	  it.
 
-	  Git requires version "7.19.4" or later of "libcurl" to build
+	  Git requires version "7.19.5" or later of "libcurl" to build
 	  without NO_CURL. This version requirement may be bumped in
 	  the future.
 
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
index 5f4340a36e6..7f71316456c 100644
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
+	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, seek_buffer);
+	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
 	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
diff --git a/http.c b/http.c
index 8a5ba3f4776..e51a9a61a20 100644
--- a/http.c
+++ b/http.c
@@ -157,21 +157,19 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return size / eltsize;
 }
 
-curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
+int seek_buffer(void *userp, curl_off_t offset, int origin)
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
+	if (origin != SEEK_SET)
+		BUG("seek_buffer only handles SEEK_SET");
+	if (offset < 0 || offset >= buffer->buf.len) {
+		error("curl seek would be outside of buffer");
+		return CURL_SEEKFUNC_FAIL;
 	}
+
+	buffer->posn = offset;
+	return CURL_SEEKFUNC_OK;
 }
 
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
@@ -765,7 +763,52 @@ void setup_curl_trace(CURL *handle)
 	curl_easy_setopt(handle, CURLOPT_DEBUGFUNCTION, curl_trace);
 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
 }
+#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
+static void get_curl_allowed_protocols(char* protocol_buff, int from_user)
+{
+	unsigned int i = 0;
+
+	if (is_transport_allowed("http", from_user)) {
+		protocol_buff[i++] = 'h';
+		protocol_buff[i++] = 't';
+		protocol_buff[i++] = 't';
+		protocol_buff[i++] = 'p';
+	}
+
+	if (is_transport_allowed("https", from_user)) {
+		if (i != 0) {
+			protocol_buff[i++] = ',';
+		}
+
+		protocol_buff[i++] = 'h';
+		protocol_buff[i++] = 't';
+		protocol_buff[i++] = 't';
+		protocol_buff[i++] = 'p';
+		protocol_buff[i++] = 's';
+	}
+	if (is_transport_allowed("ftp", from_user)) {
+		if (i != 0) {
+			protocol_buff[i++] = ',';
+		}
+
+		protocol_buff[i++] = 'f';
+		protocol_buff[i++] = 't';
+		protocol_buff[i++] = 'p';
+	}
+	if (is_transport_allowed("ftps", from_user)) {
+		if (i != 0) {
+			protocol_buff[i++] = ',';
+		}
+
+		protocol_buff[i++] = 'f';
+		protocol_buff[i++] = 't';
+		protocol_buff[i++] = 'p';
+		protocol_buff[i++] = 's';
+	}
 
+	protocol_buff[i] = '\0';
+}
+#else
 static long get_curl_allowed_protocols(int from_user)
 {
 	long allowed_protocols = 0;
@@ -781,6 +824,7 @@ static long get_curl_allowed_protocols(int from_user)
 
 	return allowed_protocols;
 }
+#endif
 
 #ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
 static int get_curl_http_version_opt(const char *version_string, long *opt)
@@ -809,6 +853,11 @@ static int get_curl_http_version_opt(const char *version_string, long *opt)
 
 static CURL *get_curl_handle(void)
 {
+
+#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
+char protocol_buff[20];
+#endif
+
 	CURL *result = curl_easy_init();
 
 	if (!result)
@@ -923,10 +972,18 @@ static CURL *get_curl_handle(void)
 
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
+#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
+	get_curl_allowed_protocols(protocol_buff, 0);
+	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS_STR, protocol_buff);
+	get_curl_allowed_protocols(protocol_buff, -1);
+	curl_easy_setopt(result, CURLOPT_PROTOCOLS_STR, protocol_buff);
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
index 3c94c479100..0be9400ef53 100644
--- a/http.h
+++ b/http.h
@@ -40,7 +40,7 @@ struct buffer {
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
-curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
+int seek_buffer(void *userp, curl_off_t offset, int origin);
 
 /* Slot lifecycle functions */
 struct active_request_slot *get_active_slot(void);
diff --git a/remote-curl.c b/remote-curl.c
index 72dfb8fb86a..540da2b7989 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -717,25 +717,24 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	return avail;
 }
 
-static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
+static int rpc_seek(void *userp, curl_off_t offset, int origin)
 {
-	struct rpc_state *rpc = clientp;
+	struct rpc_state *rpc = userp;
 
-	switch (cmd) {
-	case CURLIOCMD_NOP:
-		return CURLIOE_OK;
+	if (origin != SEEK_SET)
+		BUG("rpc_seek only handles SEEK_SET, not %d", origin);
 
-	case CURLIOCMD_RESTARTREAD:
-		if (rpc->initial_buffer) {
-			rpc->pos = 0;
-			return CURLIOE_OK;
+	if (rpc->initial_buffer) {
+		if (offset < 0 || offset > rpc->len) {
+			error("curl seek would be outside of rpc buffer");
+			return CURL_SEEKFUNC_FAIL;
 		}
-		error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
-		return CURLIOE_FAILRESTART;
-
-	default:
-		return CURLIOE_UNKNOWNCMD;
+		rpc->pos = offset;
+		return CURL_SEEKFUNC_OK;
 	}
+
+	error(_("unable to rewind rpc post data - try increasing http.postBuffer"));
+	return CURL_SEEKFUNC_FAIL;
 }
 
 struct check_pktline_state {
@@ -959,8 +958,8 @@ retry:
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
-		curl_easy_setopt(slot->curl, CURLOPT_IOCTLFUNCTION, rpc_ioctl);
-		curl_easy_setopt(slot->curl, CURLOPT_IOCTLDATA, rpc);
+		curl_easy_setopt(slot->curl, CURLOPT_SEEKFUNCTION, rpc_seek);
+		curl_easy_setopt(slot->curl, CURLOPT_SEEKDATA, rpc);
 		if (options.verbosity > 1) {
 			fprintf(stderr, "POST %s (chunked)\n", rpc->service_name);
 			fflush(stderr);

base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
-- 
gitgitgadget
