Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFFB32E6BA
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423764; cv=none; b=Zo0GL7UHmI8ylQZ7ueeRv1OCD2zMtVyi3Ca4ggez7nFs4wPFVH1YCdenwMvLQsj35u+4RDN80bMYXIDTpGzFXgaegjaHbOEUqE24ExyPuZVNmkaI4h/GKWNsEp3co2XSZe8azw1mL3ngW35xDXbzVQkFVGAS161co/2iQxXTqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423764; c=relaxed/simple;
	bh=ctpTHnUYGJCbL9xUHRQhKKlJGsHTo+uBtpCl6HSgH6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TplOsfvZf5PIEIWO3lTOFUBfw3XzDM+Ej9MfIzWU6msy/2D5HqegXhmTL4FfVAPBZODHaFVPo1icrkjyZI+wwGjhfiQUTNVmD9qAKG3HKrMavmQN+u7aVo20rP0zuqnJXZplrehSwuFqdcgayFoZgafGmXDfysDnU4Str8tAiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiHeyGqE; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiHeyGqE"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2baab3137bcso4981299eec.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771423761; x=1772028561; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flIgoj5XDuv6+9ckqYjYRGzBY8zXvAYcCvkywmrAqvE=;
        b=GiHeyGqEzC0dR4F/22oaja0JqB/qylfMpFBhyjeXV8ZO0OxDETJ5v/cm8W4GzehNX7
         5cqJvp7P/tHh0Z45D6TqggewJSfA6/4bQeaWmvxQnngl0X0aa7HeF4qKNZTMCHCxAVe7
         0oc+RJSePSauch+oBBgg1FotdhCgqJo/n4EICkEyo9rGIDLiRk0yC37ipc6Oc+b2Ymkp
         BhGFaviAf0UlhVTlLUQutfpBTMt21fDgc0GcTC7HPPK4h/pmyArW4v2Pp2v1Fc1XWS/P
         v9g9mszi5/o9FDzpBO1XaCD+CCWoGMYzJpRLyWwIIe/fm92RdF+IPDGfORfjoefbeaNO
         qpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423761; x=1772028561;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=flIgoj5XDuv6+9ckqYjYRGzBY8zXvAYcCvkywmrAqvE=;
        b=Xr0r6OI2HlKsUwoRana/PFtVUs4NHUB2Xm9/OQOpJYu94b/ado7N9Z9+31G0/ikwLG
         12TpHgwts/l0qE8r2qQQhSqH2n8/K3TkNif3M5VGubiwoJf3ObTL3O8G0eXtPOm7gN36
         abTvkZ14K2BlvD7OCxJMf4VESanyLUWxdVWELyBYBztvvWoy32QVLUSsGmGv2J60S/Vx
         vOd5O8/IfULuuPdALk844bGGeECTMMVGEanWSP5bcJKpRRGNf+ICD2ay9B7ovdDyw670
         53LNptxfSTl1NH9O4bDADvtQvy2R7fIHv2CXY17l2EcoH4DXHXH7jmBZRvajcI8eI4KE
         gILg==
X-Gm-Message-State: AOJu0YymBMaGOTod+ds996kS7X/H5pesCF1U44cBK01YXLuXfrJ94J6q
	OtWsdTo2LnWva6uHbB/l3puEWGD9rWZoqZVyRAADRmXxGLUchPvet04d5IcDSqJ/
X-Gm-Gg: AZuq6aKZalhFvRsv7rk10ydPZQuRHSBcqLNEOfU4OaWVhQzUOl5yPs+cmRXOEVFf3gc
	Od9U1dh3wPkE+aWzIKWVkej2RLUwlEAsx93mu3Va06ma2DyRqVgtPfTc52O4UoAb5REBjRxyADY
	lzwKebZDEWy8VbNjSsaah/t/aqsphUsXZN4CaRiMx+QUziI+RbLQBTZRpsGlPhi2YgRvXueU/dZ
	/HRsKaeAqKVO8vhv5iWUhMhZ0TxblKxk3Ntj2vzv7eQzYnidK24eMjIm/NwYbilpSqHnVx1HfJn
	MVsNdbrMGifYySqceG8oGpL+ZrLAXc274qFv4AD+ShTgjPvRfTVs2pjkGK9p6VSOmdLJL7RWHBh
	8uR4TioYQz7m0+xSMb9glRhbOYYx0p9TGMEtf28H5A0urfpa2AmGxsikyJmU+ZVhXthB9SxIKY4
	ldHAATRFMMRXT8knZeDBX7jbyrgg==
X-Received: by 2002:a05:7300:7fa3:b0:2b7:f809:9c31 with SMTP id 5a478bee46e88-2bac97d5a2bmr4504184eec.34.1771423760025;
        Wed, 18 Feb 2026 06:09:20 -0800 (PST)
Received: from [127.0.0.1] ([52.159.225.192])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543e50sm18118511eec.3.2026.02.18.06.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 06:09:19 -0800 (PST)
Message-Id: <5e0f4a56efb45dfceddb74feadd11ca9e3453ebb.1771423748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
References: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
	<pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 14:09:08 +0000
Subject: [PATCH v4 5/5] http: add support for HTTP 429 rate limit retries
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Add retry logic for HTTP 429 (Too Many Requests) responses to handle
server-side rate limiting gracefully. When Git's HTTP client receives
a 429 response, it can now automatically retry the request after an
appropriate delay, respecting the server's rate limits.

The implementation supports the RFC-compliant Retry-After header in
both delay-seconds (integer) and HTTP-date (RFC 2822) formats. If a
past date is provided, Git retries immediately without waiting.

Retry behavior is controlled by three new configuration options
(http.maxRetries, http.retryAfter, and http.maxRetryTime) which are
documented in git-config(1).

The retry logic implements a fail-fast approach: if any delay
(whether from server header or configuration) exceeds maxRetryTime,
Git fails immediately with a clear error message rather than capping
the delay. This provides better visibility into rate limiting issues.

The implementation includes extensive test coverage for basic retry
behavior, Retry-After header formats (integer and HTTP-date),
configuration combinations, maxRetryTime limits, invalid header
handling, environment variable overrides, and edge cases.

Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 Documentation/config/http.adoc |  23 +++
 git-curl-compat.h              |   8 +
 http.c                         | 190 +++++++++++++++++++++--
 http.h                         |   2 +
 remote-curl.c                  |   4 +
 t/lib-httpd.sh                 |   1 +
 t/lib-httpd/apache.conf        |   8 +
 t/lib-httpd/http-429.sh        |  98 ++++++++++++
 t/meson.build                  |   1 +
 t/t5584-http-429-retry.sh      | 266 +++++++++++++++++++++++++++++++++
 10 files changed, 589 insertions(+), 12 deletions(-)
 create mode 100644 t/lib-httpd/http-429.sh
 create mode 100755 t/t5584-http-429-retry.sh

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 9da5c298cc..7d9a90dcba 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -315,6 +315,29 @@ http.keepAliveCount::
 	unset, curl's default value is used. Can be overridden by the
 	`GIT_HTTP_KEEPALIVE_COUNT` environment variable.
 
+http.retryAfter::
+	Default wait time in seconds before retrying when a server returns
+	HTTP 429 (Too Many Requests) without a Retry-After header.
+	Defaults to 0 (retry immediately). When a Retry-After header is
+	present, its value takes precedence over this setting. Can be
+	overridden by the `GIT_HTTP_RETRY_AFTER` environment variable.
+	See also `http.maxRetries` and `http.maxRetryTime`.
+
+http.maxRetries::
+	Maximum number of times to retry after receiving HTTP 429 (Too Many
+	Requests) responses. Set to 0 (the default) to disable retries.
+	Can be overridden by the `GIT_HTTP_MAX_RETRIES` environment variable.
+	See also `http.retryAfter` and `http.maxRetryTime`.
+
+http.maxRetryTime::
+	Maximum time in seconds to wait for a single retry attempt when
+	handling HTTP 429 (Too Many Requests) responses. If the server
+	requests a delay (via Retry-After header) or if `http.retryAfter`
+	is configured with a value that exceeds this maximum, Git will fail
+	immediately rather than waiting. Default is 300 seconds (5 minutes).
+	Can be overridden by the `GIT_HTTP_MAX_RETRY_TIME` environment
+	variable. See also `http.retryAfter` and `http.maxRetries`.
+
 http.noEPSV::
 	A boolean which disables using of EPSV ftp command by curl.
 	This can be helpful with some "poor" ftp servers which don't
diff --git a/git-curl-compat.h b/git-curl-compat.h
index 659e5a3875..dccdd4d6e5 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -37,6 +37,14 @@
 #define GIT_CURL_NEED_TRANSFER_ENCODING_HEADER
 #endif
 
+/**
+ * CURLINFO_RETRY_AFTER was added in 7.66.0, released in September 2019.
+ * It allows curl to automatically parse Retry-After headers.
+ */
+#if LIBCURL_VERSION_NUM >= 0x074200
+#define GIT_CURL_HAVE_CURLINFO_RETRY_AFTER 1
+#endif
+
 /**
  * CURLOPT_PROTOCOLS_STR and CURLOPT_REDIR_PROTOCOLS_STR were added in 7.85.0,
  * released in August 2022.
diff --git a/http.c b/http.c
index 7815f144de..11ea9f38f7 100644
--- a/http.c
+++ b/http.c
@@ -22,6 +22,8 @@
 #include "object-file.h"
 #include "odb.h"
 #include "tempfile.h"
+#include "date.h"
+#include "trace2.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
@@ -149,6 +151,11 @@ static char *cached_accept_language;
 static char *http_ssl_backend;
 
 static int http_schannel_check_revoke = 1;
+
+static long http_retry_after = 0;
+static long http_max_retries = 0;
+static long http_max_retry_time = 300;
+
 /*
  * With the backend being set to `schannel`, setting sslCAinfo would override
  * the Certificate Store in cURL v7.60.0 and later, which is not what we want
@@ -209,7 +216,7 @@ static inline int is_hdr_continuation(const char *ptr, const size_t size)
 	return size && (*ptr == ' ' || *ptr == '\t');
 }
 
-static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UNUSED)
+static size_t fwrite_headers(char *ptr, size_t eltsize, size_t nmemb, void *p MAYBE_UNUSED)
 {
 	size_t size = eltsize * nmemb;
 	struct strvec *values = &http_auth.wwwauth_headers;
@@ -257,6 +264,50 @@ static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UN
 		goto exit;
 	}
 
+#ifndef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
+	/* Parse Retry-After header for rate limiting (for curl < 7.66.0) */
+	if (skip_iprefix_mem(ptr, size, "retry-after:", &val, &val_len)) {
+		struct active_request_slot *slot = (struct active_request_slot *)p;
+
+		strbuf_add(&buf, val, val_len);
+		strbuf_trim(&buf);
+
+		if (slot && slot->results) {
+			/* Parse the retry-after value (delay-seconds or HTTP-date) */
+			char *endptr;
+			long retry_after;
+
+			errno = 0;
+			retry_after = strtol(buf.buf, &endptr, 10);
+
+		/* Check if it's a valid integer (delay-seconds format) */
+		if (endptr != buf.buf && *endptr == '\0' &&
+		    errno != ERANGE && retry_after >= 0) {
+			slot->results->retry_after = retry_after;
+		} else {
+				/* Try parsing as HTTP-date format */
+				timestamp_t timestamp;
+				int offset;
+				if (!parse_date_basic(buf.buf, &timestamp, &offset)) {
+					/* Successfully parsed as date, calculate delay from now */
+					timestamp_t now = time(NULL);
+					if (timestamp > now) {
+						slot->results->retry_after = (long)(timestamp - now);
+					} else {
+						/* Past date means retry immediately */
+						slot->results->retry_after = 0;
+					}
+				} else {
+					/* Failed to parse as either delay-seconds or HTTP-date */
+					warning(_("unable to parse Retry-After header value: '%s'"), buf.buf);
+				}
+			}
+		}
+
+		goto exit;
+	}
+#endif
+
 	/*
 	 * This line could be a continuation of the previously matched header
 	 * field. If this is the case then we should append this value to the
@@ -342,6 +393,17 @@ static void finish_active_slot(struct active_request_slot *slot)
 
 		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
 			&slot->results->http_connectcode);
+
+#ifdef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
+		if (slot->results->http_code == 429) {
+			curl_off_t retry_after;
+			CURLcode res = curl_easy_getinfo(slot->curl,
+							  CURLINFO_RETRY_AFTER,
+							  &retry_after);
+			if (res == CURLE_OK && retry_after > 0)
+				slot->results->retry_after = (long)retry_after;
+		}
+#endif
 	}
 
 	/* Run callback if appropriate */
@@ -575,6 +637,21 @@ static int http_options(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp("http.retryafter", var)) {
+		http_retry_after = git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+
+	if (!strcmp("http.maxretries", var)) {
+		http_max_retries = git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+
+	if (!strcmp("http.maxretrytime", var)) {
+		http_max_retry_time = git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, ctx, data);
 }
@@ -1422,6 +1499,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	set_long_from_env(&curl_tcp_keepintvl, "GIT_TCP_KEEPINTVL");
 	set_long_from_env(&curl_tcp_keepcnt, "GIT_TCP_KEEPCNT");
 
+	set_long_from_env(&http_retry_after, "GIT_HTTP_RETRY_AFTER");
+	set_long_from_env(&http_max_retries, "GIT_HTTP_MAX_RETRIES");
+	set_long_from_env(&http_max_retry_time, "GIT_HTTP_MAX_RETRY_TIME");
+
 	curl_default = get_curl_handle();
 }
 
@@ -1871,6 +1952,10 @@ static int handle_curl_result(struct slot_results *results)
 			}
 			return HTTP_REAUTH;
 		}
+	} else if (results->http_code == 429) {
+		trace2_data_intmax("http", the_repository, "http/429-retry-after",
+			results->retry_after);
+		return HTTP_RATE_LIMITED;
 	} else {
 		if (results->http_connectcode == 407)
 			credential_reject(the_repository, &proxy_auth);
@@ -1886,6 +1971,9 @@ int run_one_slot(struct active_request_slot *slot,
 		 struct slot_results *results)
 {
 	slot->results = results;
+	/* Initialize retry_after to -1 (not set) */
+	results->retry_after = -1;
+
 	if (!start_active_slot(slot)) {
 		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
 			  "failed to start HTTP request");
@@ -2119,7 +2207,8 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
 
 static int http_request(const char *url,
 			void *result, int target,
-			const struct http_get_options *options)
+			const struct http_get_options *options,
+			long *retry_after_out)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -2148,7 +2237,8 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
-	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_headers);
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, slot);
 
 	accept_language = http_get_accept_language_header();
 
@@ -2183,6 +2273,10 @@ static int http_request(const char *url,
 
 	ret = run_one_slot(slot, &results);
 
+	/* Store retry_after from slot results if output parameter provided */
+	if (retry_after_out)
+		*retry_after_out = results.retry_after;
+
 	if (options && options->content_type) {
 		struct strbuf raw = STRBUF_INIT;
 		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, &raw);
@@ -2253,21 +2347,79 @@ static int update_url_from_redirect(struct strbuf *base,
 	return 1;
 }
 
-static int http_request_reauth(const char *url,
+/*
+ * Handle rate limiting retry logic for HTTP 429 responses.
+ * Returns a negative value if retries are exhausted or configuration is invalid,
+ * otherwise returns the delay value (>= 0) to indicate the retry should proceed.
+ */
+static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_after)
+{
+	int retry_attempt = http_max_retries - *rate_limit_retries + 1;
+
+	trace2_data_intmax("http", the_repository, "http/429-retry-attempt",
+		retry_attempt);
+
+	if (*rate_limit_retries <= 0) {
+		/* Retries are disabled or exhausted */
+		if (http_max_retries > 0) {
+			error(_("too many rate limit retries, giving up"));
+			trace2_data_string("http", the_repository,
+					   "http/429-error", "retries-exhausted");
+		}
+		return -1;
+	}
+
+	(*rate_limit_retries)--;
+
+	/* Use the slot-specific retry_after value or configured default */
+	if (slot_retry_after >= 0) {
+		/* Check if retry delay exceeds maximum allowed */
+		if (slot_retry_after > http_max_retry_time) {
+			error(_("response requested a delay greater than http.maxRetryTime (%ld > %ld seconds)"),
+			      slot_retry_after, http_max_retry_time);
+			trace2_data_string("http", the_repository,
+				  "http/429-error", "exceeds-max-retry-time");
+			trace2_data_intmax("http", the_repository,
+				  "http/429-requested-delay", slot_retry_after);
+			return -1;
+		}
+		return slot_retry_after;
+	} else {
+		/* No Retry-After header provided, use configured default */
+		if (http_retry_after > http_max_retry_time) {
+			error(_("configured http.retryAfter exceeds http.maxRetryTime (%ld > %ld seconds)"),
+			      http_retry_after, http_max_retry_time);
+			trace2_data_string("http", the_repository,
+					"http/429-error", "config-exceeds-max-retry-time");
+			return -1;
+		}
+		trace2_data_string("http", the_repository,
+			"http/429-retry-source", "config-default");
+		return http_retry_after;
+	}
+}
+
+static int http_request_recoverable(const char *url,
 			       void *result, int target,
 			       struct http_get_options *options)
 {
 	int i = 3;
 	int ret;
+	int rate_limit_retries = http_max_retries;
+	long slot_retry_after = -1; /* Per-slot retry_after value */
 
 	if (always_auth_proactively())
 		credential_fill(the_repository, &http_auth, 1);
 
-	ret = http_request(url, result, target, options);
+	ret = http_request(url, result, target, options, &slot_retry_after);
 
-	if (ret != HTTP_OK && ret != HTTP_REAUTH)
+	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_RATE_LIMITED)
 		return ret;
 
+	/* If retries are disabled and we got a 429, fail immediately */
+	if (ret == HTTP_RATE_LIMITED && !http_max_retries)
+		return HTTP_ERROR;
+
 	if (options && options->effective_url && options->base_url) {
 		if (update_url_from_redirect(options->base_url,
 					     url, options->effective_url)) {
@@ -2276,7 +2428,8 @@ static int http_request_reauth(const char *url,
 		}
 	}
 
-	while (ret == HTTP_REAUTH && --i) {
+	while ((ret == HTTP_REAUTH || ret == HTTP_RATE_LIMITED) && --i) {
+		long retry_delay = -1;
 		/*
 		 * The previous request may have put cruft into our output stream; we
 		 * should clear it out before making our next request.
@@ -2301,10 +2454,23 @@ static int http_request_reauth(const char *url,
 		default:
 			BUG("Unknown http_request target");
 		}
+		if (ret == HTTP_RATE_LIMITED) {
+			retry_delay = handle_rate_limit_retry(&rate_limit_retries, slot_retry_after);
+			if (retry_delay < 0)
+				return HTTP_ERROR;
+
+			if (retry_delay > 0) {
+				warning(_("rate limited, waiting %ld seconds before retry"), retry_delay);
+				trace2_data_intmax("http", the_repository,
+						   "http/retry-sleep-seconds", retry_delay);
+				sleep(retry_delay);
+			}
+			slot_retry_after = -1; /* Reset after use */
+		} else if (ret == HTTP_REAUTH) {
+			credential_fill(the_repository, &http_auth, 1);
+		}
 
-		credential_fill(the_repository, &http_auth, 1);
-
-		ret = http_request(url, result, target, options);
+		ret = http_request(url, result, target, options, &slot_retry_after);
 	}
 	return ret;
 }
@@ -2313,7 +2479,7 @@ int http_get_strbuf(const char *url,
 		    struct strbuf *result,
 		    struct http_get_options *options)
 {
-	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
+	return http_request_recoverable(url, result, HTTP_REQUEST_STRBUF, options);
 }
 
 /*
@@ -2337,7 +2503,7 @@ int http_get_file(const char *url, const char *filename,
 		goto cleanup;
 	}
 
-	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
+	ret = http_request_recoverable(url, result, HTTP_REQUEST_FILE, options);
 	fclose(result);
 
 	if (ret == HTTP_OK && finalize_object_file(the_repository, tmpfile.buf, filename))
diff --git a/http.h b/http.h
index f9d4593404..eb40456450 100644
--- a/http.h
+++ b/http.h
@@ -20,6 +20,7 @@ struct slot_results {
 	long http_code;
 	long auth_avail;
 	long http_connectcode;
+	long retry_after;
 };
 
 struct active_request_slot {
@@ -167,6 +168,7 @@ struct http_get_options {
 #define HTTP_REAUTH	4
 #define HTTP_NOAUTH	5
 #define HTTP_NOMATCHPUBLICKEY	6
+#define HTTP_RATE_LIMITED	7
 
 /*
  * Requests a URL and stores the result in a strbuf.
diff --git a/remote-curl.c b/remote-curl.c
index 21c96f2ca9..b80d2adb95 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -540,6 +540,10 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		show_http_message_fatal(&type, &charset, &buffer,
 					_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
 					transport_anonymize_url(url.buf), curl_errorstr);
+	case HTTP_RATE_LIMITED:
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("rate limited by '%s', please try again later"),
+					transport_anonymize_url(url.buf));
 	default:
 		show_http_message_fatal(&type, &charset, &buffer,
 					_("unable to access '%s': %s"),
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5091db949b..8a43261ffc 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -167,6 +167,7 @@ prepare_httpd() {
 	install_script error.sh
 	install_script apply-one-time-script.sh
 	install_script nph-custom-auth.sh
+	install_script http-429.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index e631ab0eb5..6bdef603cd 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -139,6 +139,10 @@ SetEnv PERL_PATH ${PERL_PATH}
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
+<LocationMatch /http_429/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</LocationMatch>
 <LocationMatch /smart_v0/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
@@ -160,6 +164,7 @@ ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error_smart/ error-smart-http.sh/
 ScriptAlias /error/ error.sh/
 ScriptAliasMatch /one_time_script/(.*) apply-one-time-script.sh/$1
+ScriptAliasMatch /http_429/(.*) http-429.sh/$1
 ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
@@ -185,6 +190,9 @@ ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
 <Files apply-one-time-script.sh>
 	Options ExecCGI
 </Files>
+<Files http-429.sh>
+	Options ExecCGI
+</Files>
 <Files ${GIT_EXEC_PATH}/git-http-backend>
 	Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
new file mode 100644
index 0000000000..c97b16145b
--- /dev/null
+++ b/t/lib-httpd/http-429.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+
+# Script to return HTTP 429 Too Many Requests responses for testing retry logic.
+# Usage: /http_429/<test-context>/<retry-after-value>/<repo-path>
+#
+# The test-context is a unique identifier for each test to isolate state files.
+# The retry-after-value can be:
+#   - A number (e.g., "1", "2", "100") - sets Retry-After header to that many seconds
+#   - "none" - no Retry-After header
+#   - "invalid" - invalid Retry-After format
+#   - "permanent" - always return 429 (never succeed)
+#   - An HTTP-date string (RFC 2822 format) - sets Retry-After to that date
+#
+# On first call, returns 429. On subsequent calls (after retry), forwards to git-http-backend
+# unless retry-after-value is "permanent".
+
+# Extract test context, retry-after value and repo path from PATH_INFO
+# PATH_INFO format: /<test-context>/<retry-after-value>/<repo-path>
+path_info="${PATH_INFO#/}"  # Remove leading slash
+test_context="${path_info%%/*}"  # Get first component (test context)
+remaining="${path_info#*/}"  # Get rest
+retry_after="${remaining%%/*}"  # Get second component (retry-after value)
+repo_path="${remaining#*/}"  # Get rest (repo path)
+
+# Extract repository name from repo_path (e.g., "repo.git" from "repo.git/info/refs")
+# The repo name is the first component before any "/"
+repo_name="${repo_path%%/*}"
+
+# Use current directory (HTTPD_ROOT_PATH) for state file
+# Create a safe filename from test_context, retry_after and repo_name
+# This ensures all requests for the same test context share the same state file
+safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
+state_file="http-429-state-${safe_name}"
+
+# Check if this is the first call (no state file exists)
+if test -f "$state_file"
+then
+	# Already returned 429 once, forward to git-http-backend
+	# Set PATH_INFO to just the repo path (without retry-after value)
+	# Set GIT_PROJECT_ROOT so git-http-backend can find the repository
+	# Use exec to replace this process so git-http-backend gets the updated environment
+	PATH_INFO="/$repo_path"
+	export PATH_INFO
+	# GIT_PROJECT_ROOT points to the document root where repositories are stored
+	# The script runs from HTTPD_ROOT_PATH, and www/ is the document root
+	if test -z "$GIT_PROJECT_ROOT"
+	then
+		# Construct path: current directory (HTTPD_ROOT_PATH) + /www
+		GIT_PROJECT_ROOT="$(pwd)/www"
+		export GIT_PROJECT_ROOT
+	fi
+	exec "$GIT_EXEC_PATH/git-http-backend"
+fi
+
+# Mark that we've returned 429
+touch "$state_file"
+
+# Output HTTP 429 response
+printf "Status: 429 Too Many Requests\r\n"
+
+# Set Retry-After header based on retry_after value
+case "$retry_after" in
+	none)
+		# No Retry-After header
+		;;
+	invalid)
+		printf "Retry-After: invalid-format-123abc\r\n"
+		;;
+	permanent)
+		# Always return 429, don't set state file for success
+		rm -f "$state_file"
+		printf "Retry-After: 1\r\n"
+		printf "Content-Type: text/plain\r\n"
+		printf "\r\n"
+		printf "Permanently rate limited\n"
+		exit 0
+		;;
+	*)
+		# Check if it's a number
+		case "$retry_after" in
+			[0-9]*)
+				# Numeric value
+				printf "Retry-After: %s\r\n" "$retry_after"
+				;;
+			*)
+				# Assume it's an HTTP-date format (passed as-is, URL decoded)
+				# Apache may URL-encode the path, so decode common URL-encoded characters
+				# %20 = space, %2C = comma, %3A = colon
+				retry_value=$(echo "$retry_after" | sed -e 's/%20/ /g' -e 's/%2C/,/g' -e 's/%3A/:/g')
+				printf "Retry-After: %s\r\n" "$retry_value"
+				;;
+		esac
+		;;
+esac
+
+printf "Content-Type: text/plain\r\n"
+printf "\r\n"
+printf "Rate limited\n"
diff --git a/t/meson.build b/t/meson.build
index f80e366cff..44f72e0f07 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -704,6 +704,7 @@ integration_tests = [
   't5581-http-curl-verbose.sh',
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
+  't5584-http-429-retry.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
new file mode 100755
index 0000000000..f3a9439f51
--- /dev/null
+++ b/t/t5584-http-429-retry.sh
@@ -0,0 +1,266 @@
+#!/bin/sh
+
+test_description='test HTTP 429 Too Many Requests retry logic'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+start_httpd
+
+test_expect_success 'setup test repository' '
+	test_commit initial &&
+	git clone --bare . "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" config http.receivepack true
+'
+
+# This test suite uses a special HTTP 429 endpoint at /http_429/ that simulates
+# rate limiting. The endpoint format is:
+#   /http_429/<test-context>/<retry-after-value>/<repo-path>
+# The http-429.sh script (in t/lib-httpd) returns a 429 response with the
+# specified Retry-After header on the first request for each test context,
+# then forwards subsequent requests to git-http-backend. Each test context
+# is isolated, allowing multiple tests to run independently.
+
+test_expect_success 'HTTP 429 with retries disabled (maxRetries=0) fails immediately' '
+	# Set maxRetries to 0 (disabled)
+	test_config http.maxRetries 0 &&
+	test_config http.retryAfter 1 &&
+
+	# Should fail immediately without any retry attempt
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/retries-disabled/1/repo.git" 2>err &&
+
+	# Verify no retry happened (no "waiting" message in stderr)
+	test_grep ! -i "waiting.*retry" err
+'
+
+test_expect_success 'HTTP 429 permanent should fail after max retries' '
+	# Enable retries with a limit
+	test_config http.maxRetries 2 &&
+
+	# Git should retry but eventually fail when 429 persists
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/permanent-fail/permanent/repo.git" 2>err
+'
+
+test_expect_success 'HTTP 429 with Retry-After is retried and succeeds' '
+	# Enable retries
+	test_config http.maxRetries 3 &&
+
+	# Git should retry after receiving 429 and eventually succeed
+	git ls-remote "$HTTPD_URL/http_429/retry-succeeds/1/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'HTTP 429 without Retry-After uses configured default' '
+	# Enable retries and configure default delay
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+
+	# Git should retry using configured default and succeed
+	git ls-remote "$HTTPD_URL/http_429/no-retry-after-header/none/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'HTTP 429 retry delays are respected' '
+	# Enable retries
+	test_config http.maxRetries 3 &&
+
+	# Time the operation - it should take at least 2 seconds due to retry delay
+	start=$(test-tool date getnanos) &&
+	git ls-remote "$HTTPD_URL/http_429/retry-delays-respected/2/repo.git" >output 2>err &&
+	duration=$(test-tool date getnanos $start) &&
+
+	# Verify it took at least 2 seconds (allowing some tolerance)
+	duration_int=${duration%.*} &&
+	test "$duration_int" -ge 1 &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'HTTP 429 fails immediately if Retry-After exceeds http.maxRetryTime' '
+	# Configure max retry time to 3 seconds (much less than requested 100)
+	test_config http.maxRetries 3 &&
+	test_config http.maxRetryTime 3 &&
+
+	# Should fail immediately without waiting
+	start=$(test-tool date getnanos) &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/retry-after-exceeds-max-time/100/repo.git" 2>err &&
+	duration=$(test-tool date getnanos $start) &&
+
+	# Should fail quickly (less than 2 seconds, no 100 second wait)
+	duration_int=${duration%.*} &&
+	test "$duration_int" -lt 2 &&
+	test_grep "greater than http.maxRetryTime" err
+'
+
+test_expect_success 'HTTP 429 fails if configured http.retryAfter exceeds http.maxRetryTime' '
+	# Test misconfiguration: retryAfter > maxRetryTime
+	# Configure retryAfter larger than maxRetryTime
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 100 &&
+	test_config http.maxRetryTime 5 &&
+
+	# Should fail immediately with configuration error
+	start=$(test-tool date getnanos) &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/config-retry-after-exceeds-max-time/none/repo.git" 2>err &&
+	duration=$(test-tool date getnanos $start) &&
+
+	# Should fail quickly
+	duration_int=${duration%.*} &&
+	test "$duration_int" -lt 2 &&
+	test_grep "configured http.retryAfter.*exceeds.*http.maxRetryTime" err
+'
+
+test_expect_success 'HTTP 429 with Retry-After HTTP-date format' '
+	# Test HTTP-date format (RFC 2822) in Retry-After header
+	raw=$(test-tool date timestamp now) &&
+	now="${raw#* -> }" &&
+	future_time=$((now + 2)) &&
+	raw=$(test-tool date show:rfc2822 $future_time) &&
+	future_date="${raw#* -> }" &&
+	future_date_encoded=$(echo "$future_date" | sed "s/ /%20/g") &&
+
+	# Enable retries
+	test_config http.maxRetries 3 &&
+
+	# Git should parse the HTTP-date and retry after the delay
+	start=$(test-tool date getnanos) &&
+	git ls-remote "$HTTPD_URL/http_429/http-date-format/$future_date_encoded/repo.git" >output 2>err &&
+	duration=$(test-tool date getnanos $start) &&
+
+	# Should take at least 1 second (allowing tolerance for processing time)
+	duration_int=${duration%.*} &&
+	test "$duration_int" -ge 1 &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'HTTP 429 with HTTP-date exceeding maxRetryTime fails immediately' '
+	raw=$(test-tool date timestamp now) &&
+	now="${raw#* -> }" &&
+	future_time=$((now + 200)) &&
+	raw=$(test-tool date show:rfc2822 $future_time) &&
+	future_date="${raw#* -> }" &&
+	future_date_encoded=$(echo "$future_date" | sed "s/ /%20/g") &&
+
+	# Configure max retry time much less than the 200 second delay
+	test_config http.maxRetries 3 &&
+	test_config http.maxRetryTime 10 &&
+
+	# Should fail immediately without waiting 200 seconds
+	start=$(test-tool date getnanos) &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/http-date-exceeds-max-time/$future_date_encoded/repo.git" 2>err &&
+	duration=$(test-tool date getnanos $start) &&
+
+	# Should fail quickly (not wait 200 seconds)
+	duration_int=${duration%.*} &&
+	test "$duration_int" -lt 2 &&
+	test_grep "http.maxRetryTime" err
+'
+
+test_expect_success 'HTTP 429 with past HTTP-date should not wait' '
+	raw=$(test-tool date timestamp now) &&
+	now="${raw#* -> }" &&
+	past_time=$((now - 10)) &&
+	raw=$(test-tool date show:rfc2822 $past_time) &&
+	past_date="${raw#* -> }" &&
+	past_date_encoded=$(echo "$past_date" | sed "s/ /%20/g") &&
+
+	# Enable retries
+	test_config http.maxRetries 3 &&
+
+	# Git should retry immediately without waiting
+	start=$(test-tool date getnanos) &&
+	git ls-remote "$HTTPD_URL/http_429/past-http-date/$past_date_encoded/repo.git" >output 2>err &&
+	duration=$(test-tool date getnanos $start) &&
+
+	# Should complete quickly (less than 2 seconds)
+	duration_int=${duration%.*} &&
+	test "$duration_int" -lt 2 &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'HTTP 429 with invalid Retry-After format uses configured default' '
+	# Configure default retry-after
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+
+	# Should use configured default (1 second) since header is invalid
+	start=$(test-tool date getnanos) &&
+	git ls-remote "$HTTPD_URL/http_429/invalid-retry-after-format/invalid/repo.git" >output 2>err &&
+	duration=$(test-tool date getnanos $start) &&
+
+	# Should take at least 1 second (the configured default)
+	duration_int=${duration%.*} &&
+	test "$duration_int" -ge 1 &&
+	test_grep "refs/heads/" output &&
+	test_grep "waiting.*retry" err
+'
+
+test_expect_success 'HTTP 429 will not be retried without config' '
+	# Default config means http.maxRetries=0 (retries disabled)
+	# When 429 is received, it should fail immediately without retry
+	# Do NOT configure anything - use defaults (http.maxRetries defaults to 0)
+
+	# Should fail immediately without retry
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/no-retry-without-config/1/repo.git" 2>err &&
+
+	# Verify no retry happened (no "waiting" message)
+	test_grep ! -i "waiting.*retry" err &&
+
+	# Should get 429 error
+	test_grep "429" err
+'
+
+test_expect_success 'GIT_HTTP_RETRY_AFTER overrides http.retryAfter config' '
+	# Configure retryAfter to 10 seconds
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 10 &&
+
+	# Override with environment variable to 1 second
+	start=$(test-tool date getnanos) &&
+	GIT_HTTP_RETRY_AFTER=1 git ls-remote "$HTTPD_URL/http_429/env-retry-after-override/none/repo.git" >output 2>err &&
+	duration=$(test-tool date getnanos $start) &&
+
+	# Should use env var (1 second), not config (10 seconds)
+	duration_int=${duration%.*} &&
+	test "$duration_int" -ge 1 &&
+	test "$duration_int" -lt 5 &&
+	test_grep "refs/heads/" output &&
+	test_grep "waiting.*retry" err
+'
+
+test_expect_success 'GIT_HTTP_MAX_RETRIES overrides http.maxRetries config' '
+	# Configure maxRetries to 0 (disabled)
+	test_config http.maxRetries 0 &&
+	test_config http.retryAfter 1 &&
+
+	# Override with environment variable to enable retries
+	GIT_HTTP_MAX_RETRIES=3 git ls-remote "$HTTPD_URL/http_429/env-max-retries-override/1/repo.git" >output 2>err &&
+
+	# Should retry (env var enables it despite config saying disabled)
+	test_grep "refs/heads/" output &&
+	test_grep "waiting.*retry" err
+'
+
+test_expect_success 'GIT_HTTP_MAX_RETRY_TIME overrides http.maxRetryTime config' '
+	# Configure maxRetryTime to 100 seconds (would accept 50 second delay)
+	test_config http.maxRetries 3 &&
+	test_config http.maxRetryTime 100 &&
+
+	# Override with environment variable to 10 seconds (should reject 50 second delay)
+	start=$(test-tool date getnanos) &&
+	test_must_fail env GIT_HTTP_MAX_RETRY_TIME=10 \
+		git ls-remote "$HTTPD_URL/http_429/env-max-retry-time-override/50/repo.git" 2>err &&
+	duration=$(test-tool date getnanos $start) &&
+
+	# Should fail quickly (not wait 50 seconds) because env var limits to 10
+	duration_int=${duration%.*} &&
+	test "$duration_int" -lt 5 &&
+	test_grep "greater than http.maxRetryTime" err
+'
+
+test_expect_success 'verify normal repository access still works' '
+	git ls-remote "$HTTPD_URL/smart/repo.git" >output &&
+	test_grep "refs/heads/" output
+'
+
+test_done
-- 
gitgitgadget
