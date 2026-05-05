Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8030EF91
	for <git@vger.kernel.org>; Tue,  5 May 2026 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972820; cv=none; b=VGswGaMEYElmDR36B6+YmXnVqicqEjUFR3T3EdGofvTNZWivXbj0aoa5Sk5JU05dhpNtAmUTYQRt3pDj4CO3Yjx1W2uxuo0DQNcFnf5TlUrxG2pN0VAta84ebgGBIxVDnq+lsH+poDQwLEGRr6wxf393b+m7EhcSI3PE/xVwChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972820; c=relaxed/simple;
	bh=hUhv+blg45GkHxW5PEl1rlFx593W8ZFyrgR15of0yfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K27cBL+Me98VhZjMZT9LgHJmD/IZGaNxccX4SvUKvgwxphUuga+mzX7sYnwzvtWBxOPC2bDBlLqiE/XWM2Y3Olu7Cm2vWxPT1U1+Wx7ahwIzsRgpmk2kSIm3ZlM57+EKJFmHxo38ysZ9hWuNkYztAPkMaX6bKeA2TiyTnVvNCvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKnlXTx9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKnlXTx9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so40342455e9.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777972817; x=1778577617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqaZrCaw8wl3au3ZhFAKV5nvn9zE9SxyiCeSHuFpI6A=;
        b=HKnlXTx9utpEFTFrZZ5tHNFNGHuCxOf6Vtu4ydTvOH2A1ho2HzWUyuf62I+QrvPnIb
         Zj2yw9+JYGnFGeFXDtIMGll/+vC7/ZNRTXz3iZv+R2fYf0l7ieLyuXzdAnX8ey1csYjE
         7aUs+5avDb0MCR+JmphV+U9JelAB8rU/4txlNhAOkHRg6rYDxwTXX/PvnUyUcwKh5sqk
         BwqJijLleFPsBk4bryVAD9o15L1KffFZQg4u3ei6kYg+aLr7QQFVBhDddUs59nlm535l
         ioHGAgbSi1ol7DS4AdXvqNbM2EfD1XwZz+ziFzXgDmrEqGWrxggioRMIykQ0vjMLFpmR
         9mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972817; x=1778577617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqaZrCaw8wl3au3ZhFAKV5nvn9zE9SxyiCeSHuFpI6A=;
        b=WJMJFt3HRduUgqZuqRwyMZNcMzywaoj+3TAH4mvlO8CNO08hQyKD/cmYmU5F+jbgcY
         dHIqKLfTGoqNGJf+FX9KnmwOYjMBZGMIqU+naaVt8lEAMuMISVssiHJOJjGjQsvUTWJJ
         bDgKFFQ3DITgkt2DEkasIZkLd5CAn2AVR7RczyclyxvV/PMt3KjNDP+UvPkV6HSbnhUs
         iw/fzmko03jSJ2ZLysGv5PDOUVnDws27SZWyh6rrj4f76kE1Wfl9U688Ti/7fCZLjT7N
         rIx8ial1YA4me+IdBLdFDsf+loDfwo2puY1E9ee5UPOjNkC2gM7xjJ8SuArCWTRspclx
         e6rg==
X-Gm-Message-State: AOJu0YxDkh+wmIbzPExM4kRegdibNRl6cwMRcqaCi4UlT/c0Yfw60Fan
	lot/VHj5SN7s7hxW89FVzoXMF8w3/xXI1svi5g5URg7Pm8wf0Vk0f6CxjToreUVMUM63mWlvEYw
	=
X-Gm-Gg: AeBDies8OH/J9cd3SyCxVY3mEhUjwxanGfwF9B6pAeQHCkRuVUM2PQZbzrkaeUVkKlb
	Zb31VlePvInRwkPltAAzlBQe5WDZr+EX18GMuB/pr9MnSUI72WhHfVw1644WZuQ4O2fAtS0H6yJ
	Z8ZDyD1KVu1kDMEexB1rd4koteT4ibjFaKTA1qy1VFIRbrYDcJw4fCcsd0gwUv+oG2o06p2ZB4C
	uYQg609LFXkz3qLU/c8uC9voG6bplWR2H7kNESJrZnXaCDR4sCwJL8KzgwFfNgHtqbVjWqhM/q6
	E0pdPoitjrrUYTVvhIKoLJaGLLx0qLC3RUDEU+aB3QTYb5pLfobhyEUA9fGOnOfALIAFzYrM8XU
	9SnXhIPx5L9CEWHVaiG8EUdnLnOZd4ACRejpG3EIPUBCw3jS4SDBosEx5YAdB0w0sATHlaMCyUW
	nLaF5E5Z+hXod6mrZsMnMQ1s6W7heVKxL1HcqCD2Oc8iOAl/YlO4Us8BkIgw==
X-Received: by 2002:a05:600c:a11:b0:48a:53ea:1408 with SMTP id 5b1f17b1804b1-48d187d95b8mr35594825e9.8.1777972817090;
        Tue, 05 May 2026 02:20:17 -0700 (PDT)
Received: from localhost.localdomain ([85.121.183.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb2fa5sm291828175e9.12.2026.05.05.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 02:20:16 -0700 (PDT)
From: aminnimaj@gmail.com
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ryan.hendrickson@alum.mit.edu,
	Aliwoto <aminnimaj@gmail.com>
Subject: [PATCH v2 1/1] http: reject unsupported proxy URL schemes
Date: Tue,  5 May 2026 09:19:40 +0000
Message-ID: <20260505091941.1825-2-aminnimaj@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260505091941.1825-1-aminnimaj@gmail.com>
References: <20260501190401.1580-1-aminnimaj@gmail.com>
 <20260505091941.1825-1-aminnimaj@gmail.com>
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

Implement the SOCKS proxy handling with a shared table-driven mapping.

Add a regression test to cover the unsupported-scheme case.

Signed-off-by: Aliwoto <aminnimaj@gmail.com>
---
 http.c                | 93 +++++++++++++++++++++++++++++++------------
 t/t5564-http-proxy.sh |  6 +++
 2 files changed, 74 insertions(+), 25 deletions(-)

diff --git a/http.c b/http.c
index 7815f144de..b945267c9c 100644
--- a/http.c
+++ b/http.c
@@ -722,6 +722,69 @@ static int has_proxy_cert_password(void)
 	return 1;
 }
 
+static const struct socks_proxy_type {
+	const char *name;
+	long curlsym;
+} socks_proxy_types[] = {
+	{ "socks", CURLPROXY_SOCKS4 },
+	{ "socks4", CURLPROXY_SOCKS4 },
+	{ "socks4a", CURLPROXY_SOCKS4A },
+	{ "socks5", CURLPROXY_SOCKS5 },
+	{ "socks5h", CURLPROXY_SOCKS5_HOSTNAME },
+};
+
+static const struct socks_proxy_type *find_socks_proxy_type(const char *protocol)
+{
+	int i;
+
+	if (!protocol)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(socks_proxy_types); i++) {
+		if (!strcmp(socks_proxy_types[i].name, protocol))
+			return &socks_proxy_types[i];
+	}
+
+	return NULL;
+}
+
+static int is_socks_proxy_protocol(const char *protocol)
+{
+	return !!find_socks_proxy_type(protocol);
+}
+
+static int set_curl_proxy_type(CURL *result, const char *protocol)
+{
+	const struct socks_proxy_type *socks_proxy_type;
+
+	if (!protocol || !strcmp(protocol, "http"))
+		return 0;
+
+	socks_proxy_type = find_socks_proxy_type(protocol);
+	if (socks_proxy_type) {
+		curl_easy_setopt(result, CURLOPT_PROXYTYPE, socks_proxy_type->curlsym);
+		return 0;
+	}
+
+	if (!strcmp(protocol, "https")) {
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
+	}
+
+	return -1;
+}
+
 /* Return 1 if redactions have been made, 0 otherwise. */
 static int redact_sensitive_header(struct strbuf *header, size_t offset)
 {
@@ -1192,30 +1255,6 @@ static CURL *get_curl_handle(void)
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
@@ -1225,6 +1264,10 @@ static CURL *get_curl_handle(void)
 			strbuf_release(&url);
 		}
 
+		if (set_curl_proxy_type(result, proxy_auth.protocol) < 0)
+			die("Invalid proxy URL '%s': unsupported proxy scheme '%s'",
+			    curl_http_proxy, proxy_auth.protocol);
+
 		if (!proxy_auth.host)
 			die("Invalid proxy URL '%s'", curl_http_proxy);
 
@@ -1235,7 +1278,7 @@ static CURL *get_curl_handle(void)
 			if (ver->version_num < 0x075400)
 				die("libcurl 7.84 or later is required to support paths in proxy URLs");
 
-			if (!starts_with(proxy_auth.protocol, "socks"))
+			if (!is_socks_proxy_protocol(proxy_auth.protocol))
 				die("Invalid proxy URL '%s': only SOCKS proxies support paths",
 				    curl_http_proxy);
 
diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index 3bcbdef409..5669ce37d8 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -95,4 +95,10 @@ test_expect_success 'Unix socket requires localhost' - <<\EOT
 	}
 EOT
 
+test_expect_success 'unknown proxy scheme is rejected' '
+	test_must_fail git clone -c http.proxy=htpp://127.0.0.1 \
+		https://example.com/repo.git 2>err &&
+	test_grep "unsupported proxy scheme '\''htpp'\''" err
+'
+
 test_done
-- 
2.49.0.windows.1

