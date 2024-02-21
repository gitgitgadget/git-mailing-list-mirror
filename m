Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE53D540
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506868; cv=none; b=sbHYX/ImbdGhKR1EsGVr2Xc2OnxfsYeNyg6LYRrBEZosgStDMX66LWUO2DahFtzT8bhCgkFikGucN9nA/O+HJpF9xltw987LuyCXU4tq3Rysa0FlfeNdNhGZurHgCw3+hOdNdxcN5fe4G3NsGDTheCC9wJxg0MPrk0HI/AzIpQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506868; c=relaxed/simple;
	bh=mf5sT109lzzl8SP0zmKOrfN/KdCJfoeHuHUSxuhGLlE=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=mz8jgeKGTSobPqQjTUENDFn8gDFF7gHOP5sdtBoGSHeJp2RD1Bl2BYPlmLidEiEAR82fiqtbUIeVXFpX8raRWHOxrcULGcpuBpQrnnjoqqQN2GSHu141ZqoFYRhlgrwtMAMkq0TKHu72q6kYMpN6PdRNtVK7nvBGoukE3uyYnGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOJLPuK7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOJLPuK7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d2710f3acso2914119f8f.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 01:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708506864; x=1709111664; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DlFC7qlHw3JDuw4OfY9EB5sGDRzgiUbxo4YzO21a31w=;
        b=WOJLPuK7/rcxIN1vuKo1E64lhI+14dcmABVO07tLmhm1h3HNrNjzVj7tXiOQ8jsNDx
         nZh4RmFqoyJZZx2NM+4u2Hy9Zsp15K6XqPxrIGkbpz7sWPbI3tcWZgNUzbYmTQw/QES5
         n2LxiUbx7r9ZZ2aRtyXEMT8/cCaK5VvGv0OxSxm+y1+dSTbKqtBNqjetiCgPS/xR1Qpz
         Ev6D6HcgOFlIx9BfmevaKjiruE7m6TEueNFzkI6gJ2YH3t5s0GuJfdRaFvBGNYRPZpHr
         3APC8aeKLtvL2mXoN9V5iwwP1kA1fKyN93ww2ka9pxYG0su9jXfa7JaKZbdiTiM7s8Co
         ByyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708506864; x=1709111664;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlFC7qlHw3JDuw4OfY9EB5sGDRzgiUbxo4YzO21a31w=;
        b=fwP7XKCE5RxZpgvhJqhlqzGFoFlLfMnxUpNmX+NGWR6aVN6Ni0SJJtBbh/a7jL7TN7
         ON3iCtsZmklTv89R+YNokStwxeLLFFoyNBXwmd3Yy8A98Np/02CCWap127UY02RbBetc
         voBuE1n9yyVPpsusZjQJCk81S3jHEhiwuFcECsUHbLKn+LXG2u40U9CaNQ3oAckLe32V
         OI7gMiugrAjddS++aXuoFqt/c0AH6AT7BfOTWQ+gUe/02BzNPBoHLP875K7hdFKXlLPj
         8yGj+ERh5lL17m5F99qRptZRAKsOYmV9facc8HCzAfx6pTSsiWrUHaT27NRyx+BHo+pS
         0m9g==
X-Gm-Message-State: AOJu0Yym43QYkIF7c5xsmXnsVqYz4l9za1tKoA9gJBM8F9UyjzP0nZKF
	kgN+PIZ+ozU62etL7Z8kxm+UxAspWXgohkyoFsQ14KDnSLcyGjKCAy3hk5zr
X-Google-Smtp-Source: AGHT+IE9d5YQ9jNBjGcVz6bEY7qYgS4WsuO98/M51cLKN80qwddP28DUuwlRJcFpMFrjfN/CCiZ14g==
X-Received: by 2002:adf:ce0b:0:b0:33d:72e6:ee9c with SMTP id p11-20020adfce0b000000b0033d72e6ee9cmr2459778wrn.29.1708506864168;
        Wed, 21 Feb 2024 01:14:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5-20020adfe3c5000000b0033b66c2d61esm16001191wrm.48.2024.02.21.01.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:14:23 -0800 (PST)
Message-ID: <pull.1681.git.git.1708506863243.gitgitgadget@gmail.com>
From: "Leslie Cheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Feb 2024 09:14:23 +0000
Subject: [PATCH] Add unix domain socket support to HTTP transport.
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
Cc: Leslie Cheng <leslie@lc.fyi>,
    Leslie Cheng <leslie.cheng5@gmail.com>

From: Leslie Cheng <leslie.cheng5@gmail.com>

This changeset introduces an `http.unixSocket` option so that users can
proxy their git over HTTP remotes to a unix domain socket. In terms of
why, since UDS are local and git already has a local protocol: some
corporate environments use a UDS to proxy requests to internal resources
(ie. source control), so this change would support those use-cases. This
proxy can occasionally be necessary to attach MFA tokens or client
certificates for CLI tools.

The implementation leverages `--unix-socket` option [0] via the
`CURLOPT_UNIX_SOCKET_PATH` flag available with libcurl [1].

`GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH` and `NO_UNIX_SOCKETS` were kept
separate so that we can spit out better error messages for users if git
was compiled with `NO_UNIX_SOCKETS`.

[0] https://curl.se/docs/manpage.html#--unix-socket
[1] https://curl.se/libcurl/c/CURLOPT_UNIX_SOCKET_PATH.html

Signed-off-by: Leslie Cheng <leslie@lc.fyi>
---
    Add unix domain socket support to HTTP transport.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1681%2Flcfyi%2Flcfyi%2Fadd-unix-socket-support-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1681/lcfyi/lcfyi/add-unix-socket-support-v1
Pull-Request: https://github.com/git/git/pull/1681

 Documentation/config/http.txt      |  5 ++
 git-curl-compat.h                  |  7 +++
 http.c                             | 23 +++++++++
 t/t5565-http-unix-domain-socket.sh | 80 ++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)
 create mode 100755 t/t5565-http-unix-domain-socket.sh

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 2d4e0c9b869..bf48cbd599a 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -277,6 +277,11 @@ http.followRedirects::
 	the base for the follow-up requests, this is generally
 	sufficient. The default is `initial`.
 
+http.unixSocket::
+	Connect through this Unix domain socket via HTTP, instead of using the
+	network. If set, this config takes precendence over `http.proxy` and
+	is incompatible with the proxy options (see `curl(1)`).
+
 http.<url>.*::
 	Any of the http.* options above can be applied selectively to some URLs.
 	For a config key to match a URL, each element of the config key is
diff --git a/git-curl-compat.h b/git-curl-compat.h
index fd96b3cdffd..f0f3bec0e17 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -74,6 +74,13 @@
 #define GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH 1
 #endif
 
+/**
+ * CURLOPT_UNIX_SOCKET_PATH was added in 7.40.0, released in January 2015.
+ */
+#if LIBCURL_VERSION_NUM >= 0x074000
+#define GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH 1
+#endif
+
 /**
  * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
  *
diff --git a/http.c b/http.c
index e73b136e589..8cfdcaeac82 100644
--- a/http.c
+++ b/http.c
@@ -79,6 +79,9 @@ static const char *http_proxy_ssl_ca_info;
 static struct credential proxy_cert_auth = CREDENTIAL_INIT;
 static int proxy_ssl_cert_password_required;
 
+#if defined(GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH) && !defined(NO_UNIX_SOCKETS)
+static const char *curl_unix_socket_path;
+#endif
 static struct {
 	const char *name;
 	long curlauth_param;
@@ -455,6 +458,20 @@ static int http_options(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp("http.unixsocket", var)) {
+#ifdef GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH
+#ifndef NO_UNIX_SOCKETS
+		return git_config_string(&curl_unix_socket_path, var, value);
+#else
+		warning(_("Unix socket support unavailable in this build of Git"));
+		return 0;
+#endif
+#else
+		warning(_("Unix socket support is not supported with cURL < 7.40.0"));
+		return 0;
+#endif
+	}
+
 	if (!strcmp("http.cookiefile", var))
 		return git_config_pathname(&curl_cookie_file, var, value);
 	if (!strcmp("http.savecookies", var)) {
@@ -1203,6 +1220,12 @@ static CURL *get_curl_handle(void)
 	}
 	init_curl_proxy_auth(result);
 
+#if defined(GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH) && !defined(NO_UNIX_SOCKETS)
+	if (curl_unix_socket_path) {
+		curl_easy_setopt(result, CURLOPT_UNIX_SOCKET_PATH, curl_unix_socket_path);
+	}
+#endif
+
 	set_curl_keepalive(result);
 
 	return result;
diff --git a/t/t5565-http-unix-domain-socket.sh b/t/t5565-http-unix-domain-socket.sh
new file mode 100755
index 00000000000..4ebcdfaa515
--- /dev/null
+++ b/t/t5565-http-unix-domain-socket.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description="test fetching through http via unix domain socket"
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+test -z "$NO_UNIX_SOCKETS" || {
+	skip_all='skipping http-unix-socket tests, unix sockets not available'
+	test_done
+}
+
+UDS_TO_TCP_FIFO=uds_to_tcp
+TCP_TO_UDS_FIFO=tcp_to_uds
+UDS_PID=
+TCP_PID=
+UDS_SOCKET="$(pwd)/uds.sock"
+UNRESOLVABLE_ENDPOINT=http://localhost:4242
+
+start_proxy_unix_to_tcp() {
+    local socket_path="$UDS_SOCKET"
+    local host=127.0.0.1
+    local port=$LIB_HTTPD_PORT
+
+    rm -f "$UDS_TO_TCP_FIFO"
+    rm -f "$TCP_TO_UDS_FIFO"
+    rm -f "$socket_path"
+    mkfifo "$UDS_TO_TCP_FIFO"
+    mkfifo "$TCP_TO_UDS_FIFO"
+    nc -klU "$socket_path" <tcp_to_uds >uds_to_tcp &
+    UDS_PID=$!
+
+    nc "$host" "$port" >tcp_to_uds <uds_to_tcp &
+    TCP_PID=$!
+
+    test_atexit 'stop_proxy_unix_to_tcp'
+}
+
+stop_proxy_unix_to_tcp() {
+    kill "$UDS_PID"
+    kill "$TCP_PID"
+    rm -f "$UDS_TO_TCP_FIFO"
+    rm -f "$TCP_TO_UDS_FIFO"
+}
+
+start_httpd
+start_proxy_unix_to_tcp
+
+test_expect_success 'setup repository' '
+	test_commit foo &&
+	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
+'
+
+# sanity check that we can't clone normally
+test_expect_success 'cloning without UDS fails' '
+    test_must_fail git clone "$UNRESOLVABLE_ENDPOINT/smart/repo.git" clone
+'
+
+test_expect_success 'cloning with UDS succeeds' '
+    test_when_finished "rm -rf clone" &&
+	test_config_global http.unixsocket "$UDS_SOCKET" &&
+	git clone "$UNRESOLVABLE_ENDPOINT/smart/repo.git" clone
+'
+
+test_expect_success 'cloning with a non-existent http proxy fails' '
+    git clone $HTTPD_URL/smart/repo.git clone &&
+    rm -rf clone &&
+    test_config_global http.proxy 127.0.0.1:0 &&
+    test_must_fail git clone $HTTPD_URL/smart/repo.git clone
+'
+
+test_expect_success 'UDS socket takes precedence over http proxy' '
+    test_when_finished "rm -rf clone" &&
+    test_config_global http.proxy 127.0.0.1:0 &&
+    test_config_global http.unixsocket "$UDS_SOCKET" &&
+    git clone $HTTPD_URL/smart/repo.git clone
+'
+
+test_done

base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b
-- 
gitgitgadget
