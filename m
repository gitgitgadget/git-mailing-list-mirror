Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732252;
	b=h2aZsxSZGVVAOAk/DKsUei3Z/2AYwNhWqCZns+MhwCA4JPgoEoVbNn3TqW4/4KFv78xI
	 iF1Bq2sKJwkWGwZYHpcAKHkCCzjp3Q0IOWLyIs4r4/4YHAbzPWCwcWbpnAMDHMTYwl8Bk
	 GU8LhGD0iujZDMvFoBw4C9poGvUGPVYVr0xMK0OWPTIhDrnAVX/uFkQKDlUrSYTUSx21c
	 Ev527XT+mTY7W7yPck5f6rjUHNxk8zKbj4eLAlkwBA+FhQv6miM5edmNLudZ9wJWqvD03
	 kIaHXYP4H6gyPHw3qb5aydbcxOa7cxLL2nUag5KzKg1+8RReubaf7uAfeXlnOSzwaUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Wge6Wrb2dKEdXQcWJ8Eq4gxdFPYY5dpNAE5fd0NBJuY=;
	b=SGCvaR8c3c2i6A54xwA+cXA3VLAPrNKS0QHLHNbn8NG4aFaHyhb46AbiHln+5zcxKKE/
	 kWUNZi00UaQoiy41yYU+zlKiLDkGJuPpl2qrRJUh1A1LbQ2dNwbhD0BSDdgbE9bzQce3o
	 4kNXZoPs7xm77vesm7RKGoKfEWHeRkQT7FGS2OG1Uly9UMFcWAouNW6bimzZQslQXlWqH
	 r0J1KDxAJOaEDcrDSGmeUZiZnjku2dabRQ1W//v2nef7RYBRWhAitKEoDrx34Eq7w66Js
	 4F/E9cestj6fP/8XH4ugPEDm83S7xQi2vE+XYG0TsfvmTu39iqqZxbXB/z6R09Lc5/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lNK6JwE0;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6BD606A335
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 18:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E6BD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lNK6JwE0
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f269e335eso577004485a.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 10:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732251; x=1794337051; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wge6Wrb2dKEdXQcWJ8Eq4gxdFPYY5dpNAE5fd0NBJuY=;
        b=lNK6JwE0RvWy9zZsKJUR/3+JFt+U5pBFfQGhSbiyRTylCeCfDqO+vaOJcDAi8fZlPj
         BD6zsP8dH9SRDmQEkqFIwkmtC+sbuutsNnMN0IkKrK/QXxXcAH0z3/tta9OWD3hLDfAk
         SnsPrKHWXUl29rsfbzIHdrIWp1NbL5OGuh1ln8OfufU33JUfPjctohgs8naQfwDUtuG5
         v3VYXpA25dUMLxEpsajZ4qgoyh2O6UMAdWRqZ8iGNHUYQQIvXfCKb8chPJh4FbWU4EQh
         LWVz10GsWjnY5LbcKhgblzVHBG+7Vwo7RyRX39BxeBaOdQiIqgvgkWrEcW9c+z3ibNSn
         A+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732251; x=1794337051;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wge6Wrb2dKEdXQcWJ8Eq4gxdFPYY5dpNAE5fd0NBJuY=;
        b=igcv5w0SqakrqMUMYXzc2gVtvqOMKk1tYZFY11KvtMx+R3ODQru+jXHOEo5xjNO+lw
         jxJmD415G5TiJyN1sjv4SZYY/w6JKAPrhiWiryKEHf5KIlI4ci1NRiChwsyiFd4mHzzF
         BAAeC3QKF+TWe4T9Ke7+rO9g97Q9dQQmzthugyqIQmT0fn37umg7Y1L34FlK29/n3SI3
         Iu+9nIChookWXND0K/3xKnZDkEH8mgXr1fe4CPrC7soc/jQ5G216eFkJsIPDHyEfCxzo
         PRB20pjWbyVGpHGyyYcffteE62iNQ1Q3QYzHqY1S8HLZPe0WLP9xRAsH76SrHRnqSPoT
         mXDQ==
X-Gm-Message-State: APuU4Z//+3PkMMjq5iwXQwt8ZZldrVmyNAfwa9RK/1pz4IZjjFQZEyM3
	FsQu3fG/k1ydJ4FERiE8H13PON8e7QX/rKB1qWWJeZ3myGMou1yyl0ej/TmOkxxisls=
X-Gm-Gg: AYBFou3hGYMCxtZ+a0D6WZki+o1gg90u4aL5vnzRIAB+R5Oe16TDWpeXqvEhsbOOE6o
	fgyV/vaXPDMBHM6WW2SttkndQXI60i/OXgDYnp8m9/GQ6S/TknBPXeZe997c0cGagp1UPsotPd8
	aDeMaV+uVcwLZY/NyuS0bRBZ49XbLSv4RYmOMfsknr5vDRtPzhHLAfCj6RYHLvd7R/mHulOw9rY
	51TF0owVgpqqILeZIDafKRVfhaI0B4KTSE/QaMd9OYKcAEZjJ+5RLOOx9CF5kGApncP+Xl8OsY/
	BM3FedkRUraH4H1kZEHseoU+yU1uQuTBj92T2Tl9JWO7SSA2nyy3NPNvXAJWFaFhyJfO15RW2YR
	DqvqYOCOf5uiW7YfgwmJjEayCVSibsSkWCkm4lo4zYYGQwIX6Fh1soyDcvxF+c7SJ5Zs/XhOTES
	VxYkt7o0eldtiO+y/DOwreo94ISrpszCoRhWHO9W3/ITO2JI0GgXKgyzvYXZvlmrh3jKaCc737c
	LVg8ajH4t/xhCjfbzLqnBBaImNVBI2xQ9wgWPcj9LlJC6JBGjbxvoKco6qiZq0vNJ1ZxD9Wh3IF
	n/awfSExGMSgCfDhSN6TekcwsMz3SusD8NHGZPIKgUSCGuD0XH7vdQ==
X-Received: by 2002:a05:620a:4612:b0:944:14f9:8ef5 with SMTP id af79cd13be357-944216f1f37mr2458798785a.59.1793732250999;
        Tue, 03 Nov 2026 10:57:30 -0800 (PST)
Received: from [127.0.0.1] ([20.124.87.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d479ddb7sm4493985a.9.2026.11.03.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:57:30 -0800 (PST)
Message-Id: <6510dddc39ca61fe1ae2f81cb8e7febd5f82d5ca.1793732247.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 18:57:26 +0000
Subject: [PATCH v2 3/4] http: add http.retryStatusCodes config option
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

