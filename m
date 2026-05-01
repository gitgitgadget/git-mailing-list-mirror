Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999FA3CFF56
	for <git@vger.kernel.org>; Fri,  1 May 2026 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662297; cv=none; b=hXM/y0BsfWie9OYOGC2SxsXH9C4VumGRjJmM2FRt3pb0ySJdXzaByFD7gbbRaxT1S0dobssWKoxjGkzmlUD6yIgx6at+0ap+zWwNEpom+Fqkcnp0rZOE/Eeyg05qTEk74azCUg7Ql/rCKeZlLWNxpYkjA1lUZH1HljIaCyczyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662297; c=relaxed/simple;
	bh=Lq7nn95jHIEDZ3R4nCmLV88JWrMu8NsIf6p7WbfPuzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSd0g8Cco7XcLG6yK1M2QZPtv1Wqo/3BcbrK5Cd9kqrOXo/R/EgZkxWCacVGmmFnokkcxiJR2WLPLE6RB1nHpZN57qgKUPtPBqnoxESYiRH7I71UrrBHgAEAeqkSdVjS/JwrYLzfPiGRTZoME8dKqQW/7NY5yPq5TUiIQ4C3OaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu8CE5IZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu8CE5IZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso25042855e9.3
        for <git@vger.kernel.org>; Fri, 01 May 2026 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777662292; x=1778267092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/YREmO7efB+J99rQQO64DXjI3sFNoNa6ncZKjZngi0=;
        b=Nu8CE5IZMF9cd8G3W7euDWIf+QbSOENNYqAY0koV/tLNLMJvXGH7+vQJ1jn2e7OpG4
         7Rtw7+eEiF/rMrB53za+TJk2Mwd9okFEPylyosKOzxJGQMkB+jdftY2/rVER6qyH8N0V
         3Z5Mm31vihP4LBGnOBIcLlxJJSajY6p1nGntRoV2Afl2iO/v6RkYsAz+Zl0s+RoNueYa
         VPQgPrUKGa5uXkjTn1Y+lIH+aS9DPr74S8RV4A2gX10wqdSh0SOIT4qY/9cma4HRVUw1
         XSMdFbHD5BCJVVaKfdeiAyuh9VlwYPu12LlSgGXgc/0SVZlxfyK6twg0QJxoUD4SiJQL
         8hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777662292; x=1778267092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/YREmO7efB+J99rQQO64DXjI3sFNoNa6ncZKjZngi0=;
        b=KejJfpmu+aP2Ewp9/zOwQeTGbYpQ8/DvcG3Kd+uCVm/1HQM95ciheH0lPO3S1e/1+1
         BkUT3Og7HAeN1DeowXwHABoifk8JFQjIDU6lUi9QG3Z0yMiTrsI7GYIWpdN0aAMpHDzt
         ljbQwc0w7QPfq4Iv75l4xOZROzHnyJnlY2gY9V/lsgfxVN5jucs+UB5SdBGpxsw3Dj26
         Uw92+XlzqqHXIng1U0KuOsUFgY0MNb9HaHdR2AsepZEk6LqWmQOKiA6KE6lzdQox/GYx
         2wFdt95gKkhLI7vxCGM+WfjUqtNg7rNCPS8aXkaxL6r/+dyCxw5vpk1lOUFw+beqbkyG
         mWEA==
X-Gm-Message-State: AOJu0YwHd1Bm7lQpI7BH1AnOzAdR+e83tLq8ZowJ7L8uIv2HaP1rxrvi
	7rLJ0Z7cFhU0F/bzueZSgNgWuoy/BS83b6PoOZwVB+fNzxxHbongbqQ1Rw6dicGwbfB/BZ4Ddg4
	=
X-Gm-Gg: AeBDiev2qf3gP744AfSHv5d35mm4bC4pJlIw80F4VKQcqXvnP2r+VcUcxJ3Ch33zKP1
	oEt0CnfV5hX/NogfLelorTEBqUBMzQm2rWfTFFY/g3KeJqzGKCSq4HR2lYJONC+tTrn+asw42wv
	GZrNJxwLrKmm8U+9Q/Sj8UHdkpOpIDLY+3ehj5ZH3XO16aNzm3/QVyu5Ex+cRfuU0j/FImW52W9
	AJZusZjF7fUK9/NtCL+LZJM7vz0c3ZNsfviBU/xv8tvY/Yh2kqqe9En0eaHmbLhMGLWdRz3s5aj
	4CkvK+QCEz9TOBr8Be2UA45qOWqqYQ8pIO6BcZbLt83tlBYNyhaIXw/IM9kKn1YBRJcYO8gb3ut
	nMcGg4MgiXWqxWQIQ5Yh55z0wcUp3SlBDKZ00U6gRN27nKNw1ebB1gfPAe3UXJNv9FR+WUYmD30
	wHBnnphQrb9d8oW/JEY90bS8jho1FMmcM1ahm8VEZVSkxZHW0aaW9zwMKMXQ==
X-Received: by 2002:a05:600c:3f14:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-48a98675809mr5487795e9.27.1777662292261;
        Fri, 01 May 2026 12:04:52 -0700 (PDT)
Received: from localhost.localdomain ([85.121.183.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7cfd2sm6475075f8f.2.2026.05.01.12.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 12:04:51 -0700 (PDT)
From: aminnimaj@gmail.com
To: git@vger.kernel.org
Cc: peff@peff.net,
	ryan.hendrickson@alum.mit.edu,
	Aliwoto <aminnimaj@gmail.com>
Subject: [PATCH 1/1] http: reject unsupported proxy URL schemes
Date: Fri,  1 May 2026 19:04:01 +0000
Message-ID: <20260501190401.1580-2-aminnimaj@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260501190401.1580-1-aminnimaj@gmail.com>
References: <20260501190401.1580-1-aminnimaj@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aliwoto <aminnimaj@gmail.com>

An explicit proxy URL with an unrecognized scheme such as
htpp://127.0.0.1 is currently accepted.

Git parses the URL, extracts the host part, and then passes only that
host to libcurl. Because no proxy type is selected for the unknown
scheme, Git leaves libcurl at its default HTTP proxy type, so the typo
is silently treated as an HTTP proxy.

Reject proxy URLs with explicit unsupported schemes instead of silently
accepting them. Keep the existing host:port-without-scheme behavior
unchanged.

Add a regression test to cover the unsupported-scheme case.

Signed-off-by: Aliwoto <aminnimaj@gmail.com>
---
 http.c                | 79 +++++++++++++++++++++++++++++--------------
 t/t5564-http-proxy.sh |  5 +++
 2 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/http.c b/http.c
index 7815f144de..0628dc5aab 100644
--- a/http.c
+++ b/http.c
@@ -722,6 +722,55 @@ static int has_proxy_cert_password(void)
 	return 1;
 }
 
+static int is_socks_proxy_protocol(const char *protocol)
+{
+	return protocol &&
+		(!strcmp(protocol, "socks") ||
+		 !strcmp(protocol, "socks4") ||
+		 !strcmp(protocol, "socks4a") ||
+		 !strcmp(protocol, "socks5") ||
+		 !strcmp(protocol, "socks5h"));
+}
+
+static int set_curl_proxy_type(CURL *result, const char *protocol)
+{
+	if (!protocol || !strcmp(protocol, "http"))
+		return 0;
+
+	if (!strcmp(protocol, "socks5h"))
+		curl_easy_setopt(result, CURLOPT_PROXYTYPE,
+				 (long)CURLPROXY_SOCKS5_HOSTNAME);
+	else if (!strcmp(protocol, "socks5"))
+		curl_easy_setopt(result, CURLOPT_PROXYTYPE,
+				 (long)CURLPROXY_SOCKS5);
+	else if (!strcmp(protocol, "socks4a"))
+		curl_easy_setopt(result, CURLOPT_PROXYTYPE,
+				 (long)CURLPROXY_SOCKS4A);
+	else if (!strcmp(protocol, "socks") ||
+		 !strcmp(protocol, "socks4"))
+		curl_easy_setopt(result, CURLOPT_PROXYTYPE,
+				 (long)CURLPROXY_SOCKS4);
+	else if (!strcmp(protocol, "https")) {
+		curl_easy_setopt(result, CURLOPT_PROXYTYPE, (long)CURLPROXY_HTTPS);
+
+		if (http_proxy_ssl_cert)
+			curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT,
+					 http_proxy_ssl_cert);
+
+		if (http_proxy_ssl_key)
+			curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY,
+					 http_proxy_ssl_key);
+
+		if (has_proxy_cert_password())
+			curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD,
+					 proxy_cert_auth.password);
+	} else {
+		return -1;
+	}
+
+	return 0;
+}
+
 /* Return 1 if redactions have been made, 0 otherwise. */
 static int redact_sensitive_header(struct strbuf *header, size_t offset)
 {
@@ -1192,30 +1241,6 @@ static CURL *get_curl_handle(void)
 	} else if (curl_http_proxy) {
 		struct strbuf proxy = STRBUF_INIT;
 
-		if (starts_with(curl_http_proxy, "socks5h"))
-			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS5_HOSTNAME);
-		else if (starts_with(curl_http_proxy, "socks5"))
-			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS5);
-		else if (starts_with(curl_http_proxy, "socks4a"))
-			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS4A);
-		else if (starts_with(curl_http_proxy, "socks"))
-			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS4);
-		else if (starts_with(curl_http_proxy, "https")) {
-			curl_easy_setopt(result, CURLOPT_PROXYTYPE, (long)CURLPROXY_HTTPS);
-
-			if (http_proxy_ssl_cert)
-				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
-
-			if (http_proxy_ssl_key)
-				curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
-
-			if (has_proxy_cert_password())
-				curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, proxy_cert_auth.password);
-		}
 		if (strstr(curl_http_proxy, "://"))
 			credential_from_url(&proxy_auth, curl_http_proxy);
 		else {
@@ -1225,6 +1250,10 @@ static CURL *get_curl_handle(void)
 			strbuf_release(&url);
 		}
 
+		if (set_curl_proxy_type(result, proxy_auth.protocol) < 0)
+			die("Invalid proxy URL '%s': unsupported proxy scheme '%s'",
+			    curl_http_proxy, proxy_auth.protocol);
+
 		if (!proxy_auth.host)
 			die("Invalid proxy URL '%s'", curl_http_proxy);
 
@@ -1235,7 +1264,7 @@ static CURL *get_curl_handle(void)
 			if (ver->version_num < 0x075400)
 				die("libcurl 7.84 or later is required to support paths in proxy URLs");
 
-			if (!starts_with(proxy_auth.protocol, "socks"))
+			if (!is_socks_proxy_protocol(proxy_auth.protocol))
 				die("Invalid proxy URL '%s': only SOCKS proxies support paths",
 				    curl_http_proxy);
 
diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index 3bcbdef409..db69aa2295 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -95,4 +95,9 @@ test_expect_success 'Unix socket requires localhost' - <<\EOT
 	}
 EOT
 
+test_expect_success 'unknown proxy scheme is rejected' '
+	! git clone -c http.proxy=htpp://127.0.0.1 https://example.com/repo.git 2>err &&
+	grep -Fx "fatal: Invalid proxy URL '\''htpp://127.0.0.1'\'': unsupported proxy scheme '\''htpp'\''" err
+'
+
 test_done
-- 
2.49.0.windows.1

