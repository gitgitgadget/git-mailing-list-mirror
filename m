Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793462229;
	b=OcoM7UE1AV7exHc3Xr7oDJuUnijXBZYHI5Xi3NNwOQNq5SEgC+KXO5KGFyiHnVoSWlpZ
	 IZJX7+bEcPqOeKt3mjAT2p2q6fGC3bcJSWWhzz1i46INSVn5o+x0mxou0lzZHAtkOkdq5
	 N72Xk5dUQNMOZk2W1It8YGec6nq5llGSbABM2fZ+TVe9AM9O9EqAeFlU7HoZhMFQVXmzE
	 seIMPTVGaD25OALFAQRkbyoBbKT3dGQWIUt5suaY+uXXHoF9aSa68jtflKdslABEfWKZN
	 bXO5lI/XVlYqOGJBbfS2C6MY39WPqauex73qRxM8yal/Skl0ck8uV27wd6CbpPFSlaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=HVL9tugA0Ms1nYK+QDLoVDlSifg9k0S2ioCqhmkpU6g=;
	b=AeSntCGIK+cjtzFS+XZ97BdO/Asy9oHUqgTXj9+VuaK/U6cQLkCQAbUsED6v02tAUrXp
	 BFgKvdzIgR44XpHicNycItZlgx80dxhmO/s1GTN2uyYLYlsXLDc76zZf8cJYw7NxQq5KU
	 fOCWCYqYn+NiZvXiwNTaQ7fIVRuDBSCwRjpxEfUfsF5HC930e6uV5MY14Cu67aEM/CXe4
	 xC7OU4cOVAiGhtnsLfSJnoMzAZN1zjswL88UyDSVhRI0SbCfRYblyp5s3/YxQaBMsWB7d
	 +Qa3ShljCuevnpgDPxH+D0QLbJlSnPKpIQQq2nuQLwAWnHGxj3WtvbFQM3pO+j/dgFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EZM4ayHc;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18974606A334
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 15:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18974606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EZM4ayHc
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53394bffe0fso28640231cf.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793462228; x=1794067028; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HVL9tugA0Ms1nYK+QDLoVDlSifg9k0S2ioCqhmkpU6g=;
        b=EZM4ayHcPu+zYiTMZqhJDFjqijDBi6SsoXu1VtHty3GTnmmRQpbWr8frTYzZiGn5JB
         2m2wSPfzm2nadsHchJ/cgFCcXoyJn6u2jyXCtQ9rIOdkg+dDWw8luMMgQTaP6PpADjmE
         khpCYk+mpyM1bNTJX/O75pldztAMOQ9YIZoieCCcig/TdtGKYrtMxoWarUz34pl6nj4Q
         Nr8n8HtNffVH8vVunjx+loZjXvYhftL+FxaBEBBImYkQk6r90PKrOWmE+stxeabid9Bj
         VjnRbpd0/M0q4KJ/DgvfP3gILJud0sUXsuzHwQFZD7KcfsxlQNf9KqC5v4cNph3SIEfM
         p12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793462228; x=1794067028;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVL9tugA0Ms1nYK+QDLoVDlSifg9k0S2ioCqhmkpU6g=;
        b=UMKGABHrQDeElemNsB4/rSshlyeA5p6uvmbQZCyQAznWK3g05QYVp8svDLwVWXvVQV
         tJFEo5r1iyXlAdyKjW+nuVE8Q/cX2gRHMbTUZC2pG6MxuIsLBTEm3ax32vnDz9O16zI2
         dpAYk3VUNM9Kl/A+TUg6gATLjKY62P5Q3ZNRUFCvHz3JKAglmCWNFoSiZ4itzzMooEWF
         T+7hFSX5NIWPY7Wm8Q7MyigDyShzARHZ983Vvo5nebjpZZBiSN61qZQp0RKXEsGpEGv4
         86xrDX93dXBn6s2oPlwjzYYy8hkSeLdUEkZEtbAMxGWdwC5Co0TAA+fFAWzwudnNHn5o
         dJ8A==
X-Gm-Message-State: AFq9FYLo2YuccUyzdc5NhNurKWOfwq9lRa5tTVKF1nnKKN2BM5LTDNTy
	lmQnvTQutJqjcueapeqRw4+ZvP9FjK8+mHYB97wQJnR4e+oVDuj+7aRL/rd/EXAt7Hw=
X-Gm-Gg: AYBFou3NPDGw7jaUEeDlryvU/y5BtDT5OoKGEfeQqGg1rpNG88mR5fxSERpS4BF8/nP
	y7ywQrI2C0eJf2L9VA0ulGQe4g8Txt32FXjWiP2bCB3TDYtWm/eG0T3f6D6TX3PSKnlCvLbsY9C
	wmOrdpTO1QmC49KcsMuxktykzGGVD3kpZ/ENkXAHjpedji8caQRbg8/jqQlp/+vSkffQYw5Eegi
	Py3lF6ld++WsEEpNxPUDMxLJAPU7R2zQN65PuMStTB/1Mls3yiwgd/SK4GKxAyLTbMC5EZ/oyrp
	sncipUFNdElb1KkdpqXWR16ZTAaUmu3mlJQ6zghJItfndsyQL+pD1+XSS/n/0ScNEIxJ7jbPj4x
	fgyaTDZgFId6bNqnqyfMbZg910px8EM8sPCb12sBet95L2x8FRkvALFIGdjrCBhzygEKAeM+VlY
	ja8oJXdLdvccvAr5bifuOF6pic43A8FCoGS32c3/xtcN+9j3r5WzkWLLIXsa5sCkHf6Y8Kw3rPe
	Cxpv9loNwh0CX25kHcivKRrEYtEwTVe76u4x1x1BVB9MBJ0Fu3Bm2nxK8DJfZWsvnLw/akNB17i
	Twa0Qy3dY8dE72ivEvTDS9s576lbEy90u2Y=
X-Received: by 2002:ac8:5a82:0:b0:536:33bd:b50a with SMTP id d75a77b69052e-542b40595e8mr88117061cf.4.1793462227862;
        Sat, 31 Oct 2026 08:57:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.126.192])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5431199514bsm41231411cf.5.2026.10.31.08.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 08:57:07 -0700 (PDT)
Message-Id: <f56ab2afaaecfbd64c4460be5d95637054623e4a.1793462224.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 15:57:03 +0000
Subject: [PATCH 3/4] http: add http.retryStatusCodes config option
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
 Documentation/config/http.adoc | 31 ++++++++++++++++------
 http.c                         | 39 ++++++++++++++++++++++++---
 http.h                         |  6 +++--
 t/lib-httpd/http-429.sh        | 10 +++++--
 t/t5584-http-429-retry.sh      | 48 ++++++++++++++++++++++++++++++++++
 5 files changed, 118 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index b387b0ad6a..8e02a1d754 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -328,7 +328,8 @@ http.keepAliveCount::
 
 http.retryAfter::
 	Initial wait time in seconds before retrying when a server returns
-	HTTP 429 (Too Many Requests) without a Retry-After header.
+	a retryable HTTP status code (HTTP 429 by default) without a
+	Retry-After header.
 	Defaults to 0 (retry immediately). When set to a positive value and
 	no Retry-After header is present, the delay doubles on each
 	subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
@@ -338,24 +339,38 @@ http.retryAfter::
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
+	status code (HTTP 429 by default). Set to 0 (the default) to disable
+	retries.
 	Can be overridden by the `GIT_HTTP_MAX_RETRIES` environment variable.
-	See also `http.retryAfter` and `http.maxRetryTime`.
+	See also `http.retryAfter`, `http.maxRetryTime`, and
+	`http.retryStatusCodes`.
 
 http.maxRetryTime::
 	Maximum time in seconds to wait for a single retry attempt when
-	handling HTTP 429 (Too Many Requests) responses. If the server
-	requests a delay (via Retry-After header) or if `http.retryAfter`
+	handling a retryable HTTP status code (HTTP 429 by default). If the
+	server requests a delay (via Retry-After header) or if `http.retryAfter`
 	is configured with a value that exceeds this maximum, Git will fail
 	immediately rather than waiting. Exponentially backed-off delays
 	computed from `http.retryAfter` are capped at this maximum. Default
 	is 300 seconds (5 minutes).
 	Can be overridden by the `GIT_HTTP_MAX_RETRY_TIME` environment
-	variable. See also `http.retryAfter` and `http.maxRetries`.
+	variable. See also `http.retryAfter`, `http.maxRetries`, and
+	`http.retryStatusCodes`.
+
+http.retryStatusCodes::
+	Comma- or whitespace-separated list of HTTP status codes (in the
+	400..599 range) that should be retried up to `http.maxRetries`
+	times. Defaults to `429`. For example, setting this to
+	`429,502,503,504` also retries transient `5xx` gateway and
+	service-unavailable errors. Can be overridden by the
+	`GIT_HTTP_RETRY_STATUS_CODES` environment variable.
+	See also `http.maxRetries`, `http.retryAfter`, and
+	`http.maxRetryTime`.
 
 http.noEPSV::
 	A boolean which disables using of EPSV ftp command by curl.
diff --git a/http.c b/http.c
index 0dec6377dd..950e2bbffa 100644
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
@@ -1928,6 +1936,23 @@ void normalize_curl_result(CURLcode *result, long http_code,
 	}
 }
 
+static int is_retryable_http_code(long code)
+{
+	const char *p = http_retry_status_codes ? http_retry_status_codes : "429";
+	char *end;
+
+	for (; code >= 400 && code < 600 && *p; p = end) {
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
@@ -1981,7 +2006,7 @@ static int handle_curl_result(struct slot_results *results)
 			}
 			return HTTP_REAUTH;
 		}
-	} else if (results->http_code == 429) {
+	} else if (is_retryable_http_code(results->http_code)) {
 		trace2_data_intmax("http", the_repository, "http/429-retry-after",
 			results->retry_after);
 		return HTTP_RATE_LIMITED;
@@ -2296,6 +2321,7 @@ static int http_request(const char *url,
 	ret = run_one_slot(slot, &results);
 
 	options->retry_after = results.retry_after;
+	options->http_code = results.http_code;
 
 	if (options->content_type) {
 		struct strbuf raw = STRBUF_INIT;
@@ -2407,7 +2433,7 @@ static int update_url_from_redirect(struct strbuf *base,
 }
 
 /*
- * Compute the retry delay for an HTTP 429 response.
+ * Compute the retry delay for a retryable HTTP response.
  * Returns a negative value if configuration is invalid (delay exceeds
  * http.maxRetryTime), otherwise returns the delay in seconds (>= 0).
  */
@@ -2513,7 +2539,12 @@ static int http_request_recoverable(const char *url,
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
@@ -2529,7 +2560,7 @@ static int http_request_recoverable(const char *url,
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

