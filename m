Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103889;
	b=mEwrctVmQXNh6E58sSy1ai9RMP89DOhu7EmYejkCYt7y7c3G/DJyOv8JJ8JTyTcvNlDH
	 a5y8B3zAbP/nJdzf9ETx4vXGxkqTWVEiMU1p4n2Xf/agUpL5It/0Abmgiw7EbQEI26qA7
	 XuOmwCJYR+OwQA6gep0D9u2+1aWrbK5PkeaRIHkhEmjSCHROS4tPPHuaxuaxhgIu4hPbM
	 4QCVch9FKYTFbtjL3b6Es3uecUlUhHReIDXNIH36+OCzAcJi17VgvN0htDR+nr8jtjt2+
	 DAh5eZv9glwlVAruFap29HoO3qttzWsNq0mRaUCXcSg7eIedC+PlTXzrqfZzqapdfUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=4J9Vonx7afoKdvySHvczhxBRdGtDAwu6Vcee2rTO310=;
	b=Esz9DJuRrXgyn5NgQvCBIjvRWhOiFQx6M2+5hGIrA8XC+1RX13tEVF+StzeHTqJPmbFS
	 R6qYVCCWKKobGKIzFD6MfYpYZOJo7j10aLiiqwNurfzAkrjxf2XwJrYyatjSw7eqhoYHb
	 bA1Er+ZkJRr7aj/BNWnSI+dPG+EGUpcJE1E4jLJsG2Jzb2JW9+mjAEe6AktUoOA7o1kE4
	 QYMjQ3FSSbmuZhL7BCEkBpeP8jigvtpybdKvPrIp11Jqd8WttEZRMLObIPT5HgFSa30jb
	 BP+50OMOtfhDrb0jB/YuSczUS5X4xV7ubYUPZg3adrIaJoHwZYL1Cemy8c2UzHXQRnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwcrChAT;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53B606A32F
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A53B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwcrChAT
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b40f4d4b5dso264926a91.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795103888; x=1795708688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4J9Vonx7afoKdvySHvczhxBRdGtDAwu6Vcee2rTO310=;
        b=MwcrChATiFdyGOSJK3sSrpASdBqyD3HvK22e2ohYqJlFU2nL0u5JDO9j2em9cJnBNo
         lL235kju8ojq2rIQi4itWs0kcooWCi8WjGgqyWy8y2kMd3X9yRYoLzC58duulfS3euc8
         rGn6GJeu4RuYeapCMydUp6nJUlz38B03D5IU3azPaFchEotuEb688zhegQAzp6r18N+N
         aF56Oky6frqq9ikOx9uMEnxiAoxJ3KS7IdybhmOXHE8Bm+L/+eHPdWYN6lKCBqJYRVcU
         /vVQ6IUFhRpsSDLBaTg/UhhD7mqYaxR3SCuf7ZwwQBcxV4YQUEabTczCe6SJk4LUHZ1C
         flXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103888; x=1795708688;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4J9Vonx7afoKdvySHvczhxBRdGtDAwu6Vcee2rTO310=;
        b=a3jfrQ7kV39yBw7OyNQdga26dLP8dGmgcOgdHdkW4QsmUfPwnW/HW2cE12Dw3J+/mA
         rEl/Y5PJaya9vR+vYq243Lhh3xrsLLklJ/XA4VAXrJbS+G/MeJtASyIR/zm2ArYVxfAl
         tsGArvDvDgpm8+4bSzoJSskkK2V2Hehco2bCMvWyKOXBZ3lviW8ZOTilRFmfR5r6OD4z
         h0gCqgazEbdFVyjEg+QW+uA4roArKgO9if39Su1z7qIBCkBEASQBlL77KN9Vihrae9DO
         qjyNvrzuRkzSDzwfK4UZkWkZT2QzwOza+oMTFWECV47YlPj3RY1OPjqJtaRHsBjWoHMw
         eySA==
X-Gm-Message-State: APuU4Z9K/TBmabooKiVMIqzvXYDWoDHXTLqAeexNRZvfkuU2k8Vd9s/6
	y3IPSe635shdY7d6bdHgr/5BgGUHBVSPIldj32Ax+dOLQAqcrjrUhwUOzes2u2M7
X-Gm-Gg: AZFdTZfiCx86B/y+cm8FDz+AyHZ0K2MDbtGhkJ0Rx4yq3N8TMVlgYhqgjeMIrsZPcxT
	FMNjGINer0xby/fZdXA/0eB0gNguMXEiNJ4OJvZ34bs5JnwOrn9uq5f00gdOEwdXhwE7dCgxDT9
	oHU6EwKlZfwUkqzrb4lmOm33rMR3pe5436gVkDb1thn/Zpoy7zW8z7AgmU+KcCdpA6SyRm2VPat
	5mrV2MWsHbTNvvSrvO6tNQjddkMw62xxrTMMN/JDpiU1zwsn0blPeEVY4KNJqdTMsnT810rMQXC
	9B3RVL54H+WgXFLwY4rAzZqJ6vUK6XXxc0KiNchhSO7SOtbVY4ARmYrc4L7VMS+8HUNwe1ngV1b
	eCuKBoInHrzyJlEMej5jZHz6+xejGDA/ZtFK0OyqLPxw05dBQTX860LlwhN7omH3JJN1PTxoNfQ
	BrE89dehkmlQIO1OL7v17uvRIzEUWAXRjwX9PazxPxO8zBfGpHuj7vM9/RXB28Lz919dy142Owu
	57eRIT1mpbVm8QnpD9Q2fgGoDzj6zJ6ek4CbcAnwU+u6g/tEOkgQ31ZpXfw1t2/KfIxuvM8mJTr
	nJ4xgALeD51LUzf9o51kuGZ6FxmvmWV4CIM=
X-Received: by 2002:a17:90b:224c:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3b3d0645da8mr6371226a91.1.1795103888106;
        Thu, 19 Nov 2026 07:58:08 -0800 (PST)
Received: from [127.0.0.1] ([172.171.119.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde534a4784sm1939340a12.18.2026.11.19.07.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:58:07 -0800 (PST)
Message-Id: <8dc66bfca4f42b1d847cf5e39d5940e0150ef2e4.1795103883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Nov 2026 15:58:01 +0000
Subject: [PATCH v4 3/5] http: add http.retryStatusCodes config option
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
retry. While service providers are expected to return 429 when
rate-limiting or overloaded, in practice reverse proxies, CDNs,
client-side proxies, and servers also return transient 502, 503, or 504
errors when a connection drops, times out, or sheds load.

We should not retry 5xx responses unconditionally by default because in
some setups they point to a permanently broken proxy or server. Keep 429
as the default and introduce an http.retryStatusCodes configuration
option (and corresponding GIT_HTTP_RETRY_STATUS_CODES environment
variable) accepting a comma- or whitespace-separated list of HTTP status
codes in the 400..599 range (for example, "429,502,503,504"), documented
as a temporary workaround while underlying provider or proxy
infrastructure is fixed.

Keep the existing "rate limited" warning and error messages for HTTP
429, and report the numeric status code (e.g., "HTTP 502, waiting <N>
seconds before retry") when retrying other status codes.

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/config/http.adoc | 37 +++++++++++++++++++++-----
 http.c                         | 42 ++++++++++++++++++++++++++---
 http.h                         |  6 +++--
 t/lib-httpd/http-429.sh        | 10 +++++--
 t/t5584-http-429-retry.sh      | 48 ++++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 8e7538ab76..726669e85c 100644
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
@@ -358,7 +367,21 @@ http.maxRetryTime::
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
+	times. Defaults to `429` (Too Many Requests). Can be overridden by
+	the `GIT_HTTP_RETRY_STATUS_CODES` environment variable.
+	See also `http.maxRetries`, `http.retryAfter`, and
+	`http.maxRetryTime`.
++
+Service providers are expected to return HTTP 429 when rate-limiting or
+overloaded. Configuring additional status codes (for example,
+`429,502,503,504`) is intended only as a temporary workaround while the
+underlying provider or proxy infrastructure is fixed.
 
 http.noEPSV::
 	A boolean which disables using of EPSV ftp command by curl.
diff --git a/http.c b/http.c
index b766bbf035..4b92819abd 100644
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
index bd06d94c16..d42feae8ba 100644
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
+*-status-502*) status_line="502 Bad Gateway" ;;
+*-status-503*) status_line="503 Service Unavailable" ;;
+*-status-504*) status_line="504 Gateway Timeout" ;;
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

