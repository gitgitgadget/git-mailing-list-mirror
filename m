Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022843;
	b=cOXn4xl6hP50xgmUXeI8qkSVsWySh2oTfKsNFxkoRCyn/ZZv/UlkypwDZz3VMwUEI1yw
	 fUlSUkJ7xlXaSCGu0kLVCDpnUvF+khb3eSdym/pJiAcGnrlkjM1rryyNx5pJKUD1KR3bR
	 OTcNVu8UvrL0HsUXZEaUfe72XNcY1f+hBv/sC1PEAFyAfu759EdFkbDabwQk0RXUb98iw
	 nxHeevbcoAE9l0T1vDDSHpHa0Fe1HsQ1N9tqgYhuGQ3Kn6U6btNjAtoWKKH7WyRoHVNSH
	 NiOI8gXSlazAHE44R93z6OsLx8SUqQeWjMPoplj7hLdflaCbHATh53VWWtC7ULaQ+kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Wge6Wrb2dKEdXQcWJ8Eq4gxdFPYY5dpNAE5fd0NBJuY=;
	b=mnkUfya+8A69/Qu/DQ5vJ1hHPjiTjJSZkFVAwLb+wF3fHZGZvHugDC3g7mW4gxz2Mr5n
	 lShT6Jgk2oLSY8f6+sr7/r7gdYgGawfJDc03qteHkuS69qWJw+ZFe/2HzxQsaPbnzv+Uf
	 CFWUzbxsJ4g32up288VxjAWeyXSiO7+2sKxZPpgwircbUQdeLxKZZb2ynaCOtt03rdfUV
	 r6V8ZmPfKeV/j4mL1lv0hlZGiIzBAU2PHMIMkLHvgP2VpuUQYel6XfI8tGxEjjPTTfqC0
	 7W8nT/HTqpc8JQQ02UtD/oTT4OKOCoOX+y5Kh0FWA2RLL0X0jFbjjivUyYYF23s+NWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSxXAx5s;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDCF606A332
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 03:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DDCF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSxXAx5s
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-945ae2daa68so34237285a.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 19:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022842; x=1794627642; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wge6Wrb2dKEdXQcWJ8Eq4gxdFPYY5dpNAE5fd0NBJuY=;
        b=TSxXAx5s04xuatL9+MPpIn2wfctJ8/pMsM20KSf0ROUlXNqDcSywwhMrmlt9mJimV4
         I4qd6o4nlsnj1Z9P8bBI4S05mNtAvlEnGpRtEUT4KPPO9xY3PlWZDL0HwX/B8/HNc5+W
         KfZoWs5r3HI3Rw1RIu99eBBpogaaGIOpTQ7XlgqPCN/q89/0Y6TxD4HvKtE9782Z8Zzl
         1Jd0u9OuG7U/22eFcwrm7cwbwM6rumGlDew/1pHeCcx6M8wavzvFK4l6wyI8b3PdE79J
         4oQbWiNKYzhxHhI7M1fDaQ5N3BKJFN/oTT53k2GBPYHxt/PqXlo1wTZXn87Yh7d2Ddt8
         PLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022842; x=1794627642;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wge6Wrb2dKEdXQcWJ8Eq4gxdFPYY5dpNAE5fd0NBJuY=;
        b=AKHsdlm2weBjs0qZVX7NsHfRUPuqPEtQtBFMD9Z8Gg9H8I1l4/BAXgHvQCbr1i8tYl
         +k8xiyR0O81lygWiB5iEuDoT0paFSudBftHwAJttirciHNkENCXqkXX88yO4UheV8tzC
         r3YkNjpsckXdvI0kSqPTbIBr/kBWLKe6R1AgyQ2gU9ylrAL7zb4UsUB/gf4p23eWxJES
         pxUl7ManAhRSXoTSNh6PGb/HIa+hnzFBvDYHMzQMwiaRSOrwyTLqAOyCCL87TlCRPt/z
         XfG6CwZVCY4wxuMXFerxpLfvDrh7prvV4xXOJ7gU89XGR23PnOAi7e6uFMzwDR2Pm4NY
         B/5w==
X-Gm-Message-State: APuU4Z9V2PNQKzcg7hrkVRv2RRL3sqG/xeftoBk4bjUEIJFYW0NFuVpa
	zEqFczIzMr+iRQzAxvXPubf22QCU4dIBCZbLdshSn+nRZat2uROGeoXQ84Qfx8ID
X-Gm-Gg: AYBFou0PcaiFZ0OC5NsDcbDVK67JNdU4llrZc1W0y2ULdC3cBJuiYum/M+IrKTz5uA9
	d7WufSmaRHhW+guFSJyHzLDkMA05DwgrC+J8CnJiS+fZxfUdjPqTTXfneDbMNtzWh1NMv+qjNor
	UmlnJbQqc/BYpUZ9rD3R8dVR45/ByLu/XMkHdhfIYrfajKm7Bb1B77uL/TukWNpVCe+nbnnrmxd
	ms4PAi0NKP5/Mf9hJK7PvpizZQirj/SF3jrGHJPOhlZMiQ0Q1RDW9gwQLywOfhlRx9VskEU7qFk
	qU23oQod4fhEeXajI8UoBojTXNHbH1CRlMXkoJKv0a9sWbFhJZ76WC8ZGztfPV4i7u3PVernuek
	8DS+JB2Vk6Fh+3J1w1rPnAJUuKimEuY6X+x19iF77SqQpG7DrKYtVeVQtqEQIrAPI4GjALJ2NL+
	QkSekQ1qneG52w7hkOLVZ7HiVmKFCb1PRJkh7X5c5eIkKdXGGYi0sThNVkxzu8EjMyb+dnlvTfB
	6BgcRKSH84y1uRDOZ9KgP7xLBLEEyP9HFFj0lq0wAJAk9b2yAkHJtOp5gWuUgUb4CfBxpX9dsZ4
	TDdxqpN18O/xnxMVGG3iC8O8bi7mcqA=
X-Received: by 2002:a05:620a:26a3:b0:93c:3863:ff7f with SMTP id af79cd13be357-946049d62f5mr147485885a.0.1794022841920;
        Fri, 06 Nov 2026 19:40:41 -0800 (PST)
Received: from [127.0.0.1] ([20.65.86.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945fdcdfa64sm194325085a.26.2026.11.06.19.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:41 -0800 (PST)
Message-Id: <6510dddc39ca61fe1ae2f81cb8e7febd5f82d5ca.1794022836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 03:40:34 +0000
Subject: [PATCH v3 3/5] http: add http.retryStatusCodes config option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Patrick Steinhardt <ps@pks.im>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Ravi Mistry <rmistry@google.com>,
    Ravi Mistry <rmistry@google.com>

From: Ravi Mistry <rmistry@google.com>

Commit 640657ffd0 (http: add support for HTTP 429 rate limit retries,
2026-03-17) hardcoded HTTP 429 as the only status code eligible for
retry. In practice, reverse proxies, load balancers, and Git hosting
backends also return transient 5xx responses such as 502 Bad Gateway,
503 Service Unavailable (which RFC 9110 section 10.2.3 defines to
support Retry-After), and 504 Gateway Timeout during load shedding or
upstream connection resets.

Because 5xx responses are not universally transient across all
environments, keep 429 as the default and introduce a new
http.retryStatusCodes configuration option (and corresponding
GIT_HTTP_RETRY_STATUS_CODES environment variable) accepting a comma- or
whitespace-separated list of HTTP status codes in the 400..599 range
(for example, "429,502,503,504").

Keep the existing "rate limited" warning and error messages for HTTP
429, and report the numeric status code (e.g., "HTTP 502, waiting <N>
seconds before retry") when retrying other status codes.

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/config/http.adoc | 34 +++++++++++++++++++-----
 http.c                         | 42 ++++++++++++++++++++++++++---
 http.h                         |  6 +++--
 t/lib-httpd/http-429.sh        | 10 +++++--
 t/t5584-http-429-retry.sh      | 48 ++++++++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 8e7538ab76..e7fa251b65 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -328,7 +328,10 @@ http.keepAliveCount::
 
 http.retryAfter::
 	Initial wait time in seconds before retrying when a server returns
-	HTTP 429 (Too Many Requests) without a Retry-After header.
+	a retryable HTTP status code without a Retry-After header. The
+	set of retryable status codes is configured by
+	`http.retryStatusCodes`, which includes only HTTP 429 (Too Many
+	Requests) by default.
 	Defaults to 0, which retries immediately without waiting on every
 	attempt (unless a Retry-After header is present). When set to a
 	positive value and no Retry-After header is present, the first
@@ -340,17 +343,23 @@ http.retryAfter::
 	libcurl 7.66.0 or later. On older versions, configure this setting
 	manually to control the retry delay. Can be overridden by the
 	`GIT_HTTP_RETRY_AFTER` environment variable.
-	See also `http.maxRetries` and `http.maxRetryTime`.
+	See also `http.maxRetries`, `http.maxRetryTime`, and
+	`http.retryStatusCodes`.
 
 http.maxRetries::
-	Maximum number of times to retry after receiving HTTP 429 (Too Many
-	Requests) responses. Set to 0 (the default) to disable retries.
+	Maximum number of times to retry after receiving a retryable HTTP
+	status code. The set of retryable status codes is configured by
+	`http.retryStatusCodes`, which includes only HTTP 429 (Too Many
+	Requests) by default. Set to 0 (the default) to disable retries.
 	Can be overridden by the `GIT_HTTP_MAX_RETRIES` environment variable.
-	See also `http.retryAfter` and `http.maxRetryTime`.
+	See also `http.retryAfter`, `http.maxRetryTime`, and
+	`http.retryStatusCodes`.
 
 http.maxRetryTime::
 	Maximum time in seconds to wait for a single retry attempt when
-	handling HTTP 429 (Too Many Requests) responses.
+	handling a retryable HTTP status code. The set of retryable
+	status codes is configured by `http.retryStatusCodes`, which
+	includes only HTTP 429 (Too Many Requests) by default.
 	If the server requests a delay (via Retry-After header) or if the
 	configured `http.retryAfter` value itself exceeds this maximum,
 	Git will fail immediately rather than waiting. Exponentially
@@ -358,7 +367,18 @@ http.maxRetryTime::
 	capped at this maximum rather than causing an immediate failure.
 	Default is 300 seconds (5 minutes).
 	Can be overridden by the `GIT_HTTP_MAX_RETRY_TIME` environment
-	variable. See also `http.retryAfter` and `http.maxRetries`.
+	variable. See also `http.retryAfter`, `http.maxRetries`, and
+	`http.retryStatusCodes`.
+
+http.retryStatusCodes::
+	Comma- or whitespace-separated list of HTTP status codes (in the
+	400..599 range) that should be retried up to `http.maxRetries`
+	times. Defaults to `429` (Too Many Requests). For example, setting
+	this to `429,502,503,504` also retries transient `5xx` gateway and
+	service-unavailable errors. Can be overridden by the
+	`GIT_HTTP_RETRY_STATUS_CODES` environment variable.
+	See also `http.maxRetries`, `http.retryAfter`, and
+	`http.maxRetryTime`.
 
 http.noEPSV::
 	A boolean which disables using of EPSV ftp command by curl.
diff --git a/http.c b/http.c
index 8a28cd0fb3..fc9384353c 100644
--- a/http.c
+++ b/http.c
@@ -156,6 +156,7 @@ static int http_schannel_check_revoke = 1;
 static long http_retry_after = 0;
 static long http_max_retries = 0;
 static long http_max_retry_time = 300;
+static char *http_retry_status_codes;
 
 /*
  * With the backend being set to `schannel`, setting sslCAinfo would override
@@ -607,6 +608,11 @@ static int http_options(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp("http.retrystatuscodes", var)) {
+		FREE_AND_NULL(http_retry_status_codes);
+		return git_config_string(&http_retry_status_codes, var, value);
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, ctx, data);
 }
@@ -1518,6 +1524,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	set_long_from_env(&http_retry_after, "GIT_HTTP_RETRY_AFTER");
 	set_long_from_env(&http_max_retries, "GIT_HTTP_MAX_RETRIES");
 	set_long_from_env(&http_max_retry_time, "GIT_HTTP_MAX_RETRY_TIME");
+	set_from_env(&http_retry_status_codes, "GIT_HTTP_RETRY_STATUS_CODES");
 
 	curl_default = get_curl_handle();
 }
@@ -1579,6 +1586,7 @@ void http_cleanup(void)
 	proxy_ssl_cert_password_required = 0;
 
 	FREE_AND_NULL(cached_accept_language);
+	FREE_AND_NULL(http_retry_status_codes);
 }
 
 struct active_request_slot *get_active_slot(void)
@@ -1928,6 +1936,26 @@ void normalize_curl_result(CURLcode *result, long http_code,
 	}
 }
 
+static int is_retryable_http_code(long code)
+{
+	const char *p = http_retry_status_codes ? http_retry_status_codes : "429";
+	char *end;
+
+	if (code < 400 || code >= 600)
+		return 0;
+
+	for (; *p; p = end) {
+		while (*p == ',' || isspace(*p))
+			p++;
+		if (strtol(p, &end, 10) == code && end > p &&
+		    (!*end || *end == ',' || isspace(*end)))
+			return 1;
+		while (*end && *end != ',' && !isspace(*end))
+			end++;
+	}
+	return 0;
+}
+
 static int handle_curl_result(struct slot_results *results)
 {
 	normalize_curl_result(&results->curl_result, results->http_code,
@@ -1981,7 +2009,7 @@ static int handle_curl_result(struct slot_results *results)
 			}
 			return HTTP_REAUTH;
 		}
-	} else if (results->http_code == 429) {
+	} else if (is_retryable_http_code(results->http_code)) {
 		trace2_data_intmax("http", the_repository, "http/429-retry-after",
 			results->retry_after);
 		return HTTP_RATE_LIMITED;
@@ -2296,6 +2324,7 @@ static int http_request(const char *url,
 	ret = run_one_slot(slot, &results);
 
 	options->retry_after = results.retry_after;
+	options->http_code = results.http_code;
 
 	if (options->content_type) {
 		struct strbuf raw = STRBUF_INIT;
@@ -2407,7 +2436,7 @@ static int update_url_from_redirect(struct strbuf *base,
 }
 
 /*
- * Compute the retry delay for an HTTP 429 response.
+ * Compute the retry delay for a retryable HTTP response.
  * Returns a negative value if configuration is invalid (delay exceeds
  * http.maxRetryTime), otherwise returns the delay in seconds (>= 0).
  */
@@ -2514,7 +2543,12 @@ static int http_request_recoverable(const char *url,
 				return HTTP_ERROR;
 
 			if (retry_delay > 0) {
-				warning(_("rate limited, waiting %ld seconds before retry"), retry_delay);
+				if (options->http_code == 429)
+					warning(_("rate limited, waiting %ld seconds before retry"),
+						retry_delay);
+				else
+					warning(_("HTTP %ld, waiting %ld seconds before retry"),
+						options->http_code, retry_delay);
 				trace2_data_intmax("http", the_repository,
 						   "http/retry-sleep-seconds", retry_delay);
 				sleep(retry_delay);
@@ -2530,7 +2564,7 @@ static int http_request_recoverable(const char *url,
 			return HTTP_ERROR;
 		trace2_data_string("http", the_repository,
 				   "http/429-error", "retries-exhausted");
-		return HTTP_RATE_LIMITED;
+		return options->http_code == 429 ? HTTP_RATE_LIMITED : HTTP_ERROR;
 	}
 	return ret;
 }
diff --git a/http.h b/http.h
index 729c51904d..5985a0f71f 100644
--- a/http.h
+++ b/http.h
@@ -167,10 +167,12 @@ struct http_get_options {
 
 	/*
 	 * After a request completes, contains the Retry-After delay in seconds
-	 * if the server returned HTTP 429 with a Retry-After header (requires
-	 * libcurl 7.66.0 or later), or -1 if no such header was present.
+	 * if the server returned a retryable status code with a Retry-After
+	 * header (requires libcurl 7.66.0 or later), or -1 if no such header
+	 * was present.
 	 */
 	long retry_after;
+	long http_code;
 };
 
 /* Return values for http_get_*() */
diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
index 5537fb7ac4..5c7d58a75f 100644
--- a/t/lib-httpd/http-429.sh
+++ b/t/lib-httpd/http-429.sh
@@ -75,8 +75,14 @@ then
 	exec "$GIT_EXEC_PATH/git-http-backend"
 fi
 
-# Output HTTP 429 response
-printf "Status: 429 Too Many Requests\r\n"
+# Output HTTP 429 (or configured status) response
+status_line="429 Too Many Requests"
+case "$test_context" in
+	*-status-502*) status_line="502 Bad Gateway" ;;
+	*-status-503*) status_line="503 Service Unavailable" ;;
+	*-status-504*) status_line="504 Gateway Timeout" ;;
+esac
+printf "Status: %s\r\n" "$status_line"
 
 # Set Retry-After header based on retry_after value
 case "$retry_after" in
diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
index f0c3cc3b61..f3e7dbaaa4 100755
--- a/t/t5584-http-429-retry.sh
+++ b/t/t5584-http-429-retry.sh
@@ -317,4 +317,52 @@ test_expect_success 'verify normal repository access still works' '
 	test_grep "refs/heads/" output
 '
 
+test_expect_success 'HTTP 502/503/504 are not retried by default' '
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/default-no-retry-status-502/none/repo.git" 2>err &&
+	test_grep ! -i "waiting.*retry" err &&
+	test_grep "The requested URL returned error: 502" err
+'
+
+test_expect_success 'http.retryStatusCodes retries configured 502, 503, and 504 errors' '
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+	test_config http.retryStatusCodes "429, 502, 503, 504" &&
+	git ls-remote "$HTTPD_URL/http_429/retry-status-502/none/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_grep "HTTP 502, waiting 1 seconds before retry" err &&
+	test_config http.retryAfter 0 &&
+	git ls-remote "$HTTPD_URL/http_429/retry-status-503/none/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	git ls-remote "$HTTPD_URL/http_429/retry-status-504/none/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'HTTP 503 honors Retry-After header when present' '
+	test_config http.maxRetries 2 &&
+	test_config http.retryStatusCodes "429,503" &&
+	git ls-remote "$HTTPD_URL/http_429/header-status-503/1/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_grep "HTTP 503, waiting 1 seconds before retry" err
+'
+
+test_expect_success 'exhausted 502 retries report HTTP 502 error, not rate limited' '
+	test_config http.maxRetries 2 &&
+	test_config http.retryStatusCodes "429,502" &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/exhausted-fail-3-status-502/none/repo.git" 2>err &&
+	test_grep "The requested URL returned error: 502" err &&
+	test_grep ! "rate limited" err
+'
+
+test_expect_success 'GIT_HTTP_RETRY_STATUS_CODES and urlmatch http.<url>.retryStatusCodes' '
+	test_config http.maxRetries 2 &&
+	GIT_HTTP_RETRY_STATUS_CODES="429,502" \
+		git ls-remote "$HTTPD_URL/http_429/env-status-502/none/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_config "http.$HTTPD_URL.retryStatusCodes" "429,503" &&
+	git ls-remote "$HTTPD_URL/http_429/urlmatch-status-503/none/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output
+'
+
 test_done
-- 
gitgitgadget

