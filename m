Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD703C6A56
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752448; cv=none; b=thV5oMjpbY7IsyYDg3Chgx3ak0XbBYMNw4wpb64CynC1ZioaIG42++oB2t85UQdr8lczy8KuPWFtbubrU7WtvNYmxP4Ql8E7LkLQ0p1ozqC83jEOpsQUXz5tbJjv/SfkNYIE6Z+xFU/e768Di+Pw34LKjpzklRgRM4YkQ7VnYf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752448; c=relaxed/simple;
	bh=nj/0zGZoT416l+3i6tIfAo00E0aCjMQOy6+PGj7dCQE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JL+oQun+0blzKh1s59xX7r8ALDT/SrHQcmj4k+UKS/hFFDyVTMDK/NFsCL/M5G9QMF2gc9YMJQTyd3JROLY28wtLU8IC4jUy/HX7ovS6d8lryuW4xq0OQ+Q680DHgvuRERAK0iZxlZ1DjAzdGKqLgkxnfTtNzHmWGW3AlZLR2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Feb3JTEt; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Feb3JTEt"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd830404c2so592640585a.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773752445; x=1774357245; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zXtwl7q1itejmzIqmz6YfLG58ThZ5HX1Vp0YSmexnY=;
        b=Feb3JTEtwdDMWgjmlJuFklKcONJcLC3H1ojVlguYsHbf5ncEHuUphn34cUxAk5AL0j
         bIryO5753iIxgADO3W4lRCoCOoxhDeY785oMYJP+rMeCheTytLTJ9+cd6ONBkF3zGSFF
         aKAFeFvS1FhX+7T/0utpEy4/6SW05PbzUiAgIHfFkEzp0ZiPExOZke1j+eObLEcArg20
         zncraYToLFPqYI2+ndlMNRzBlogPkCEAskPRkQeJdY7RTELQKT+sUel5x2I3uIYsm3M6
         or6oNXWvgsVH8sMeBNU5UyO+GH3YW3VPYsdi5M4WFoaAXb4CY7D8b+x8opHQy2jgIi5X
         cSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752445; x=1774357245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8zXtwl7q1itejmzIqmz6YfLG58ThZ5HX1Vp0YSmexnY=;
        b=Ak/uw/VFMghOxQu0i4rMx3NMFOd1RP+2tygZGWyUNI7rc8wsNjauKB3naUyL+I0/Kf
         iLCgugzyR9lq9qeAMz0o0vfUa2CqKOtzkan9zoqCP6ePs3BbLjKolDSXr7t8NvXEnNvA
         xX7utyIUVxO4qlZ3SpeZ5i9zScYBmKR3nPAhZxRTHDiKXXo5cnIdOl338UnMr7qw0M3B
         hlzDpCMG4NkwUbTGEYbggkCM/wvsFo2y0y3+AhAZj6ENaqmZQvNhD1Vvrgyr6kACdl5b
         xLxtO2qXCsAxiqRyQYWQmWy1XFvSi/qZffaOaJ0EvrfVEpvqGUSncJW+YAFGkOB1A5P4
         cnvw==
X-Gm-Message-State: AOJu0Yw0qawQIZ3+Wv+MCue/VPleebhvN/npJHbHLhVoh2bnJDlTdm8Q
	Eu2bW+EKBbnfqqwznidRMzbE0NXh/TJkiir9jrfJMvEwU5gYoL6j4o3UC59ICw==
X-Gm-Gg: ATEYQzzYDVbqtR2H3mPnmdXV2T3uFKfvxnELwUjJBtTC8sjgmoWzvQyi//VM3VY373Y
	eMS7g7YDhVG+oHnbxH39R84YuBQMHAefH6ZkvNIIWBJ5MfVhJGcc9u4sxHCYqreMh8AEYQP21mM
	N5nTTP/uJZ8Vcg/vPZRamA9xOeGLAAIDjtrNoYO7bJI+VnFTl+G1DhqyvqK8Ke2REsCEBXcI4b3
	36z4L83NTNpgafaZX3nwvG/Id8Ph5i2flJ2MiAklSKBSKNetjY/F8lsJ8pARZ3Ci2bFWEaCsZMb
	C3+BTylhdUMTEOt0neGR0NZq8PKNKqO1VJNOmft5mNQA3PPku8SVMwlPSF4GyrrgEy4fjdlYH/m
	/7+LdYfXwCzPd+luCh56oBC0+7j5lLEP4tFO1Ko81DS+GB1rETB5fzWK3ySnSN1YBB4plJeN4n7
	yVkwxB+um0Zq56fSHq5qf6qqYDnmc2mgqYVg==
X-Received: by 2002:a05:620a:1983:b0:8cd:972d:324 with SMTP id af79cd13be357-8cdb5b60325mr2162031885a.54.1773752444150;
        Tue, 17 Mar 2026 06:00:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.23.161])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda213cba5sm1406618685a.37.2026.03.17.06.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:00:43 -0700 (PDT)
Message-Id: <3418f4553d246c797697c80f439c77fee293f7e0.1773752435.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>
References: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
	<pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 13:00:35 +0000
Subject: [PATCH v6 3/3] http: add support for HTTP 429 rate limit retries
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
 Documentation/config/http.adoc |  26 ++++
 git-curl-compat.h              |   8 +
 http.c                         | 144 +++++++++++++++---
 http.h                         |   9 ++
 remote-curl.c                  |  11 ++
 t/lib-httpd.sh                 |   1 +
 t/lib-httpd/apache.conf        |   8 +
 t/lib-httpd/http-429.sh        |  98 ++++++++++++
 t/meson.build                  |   1 +
 t/t5584-http-429-retry.sh      | 266 +++++++++++++++++++++++++++++++++
 10 files changed, 551 insertions(+), 21 deletions(-)
 create mode 100644 t/lib-httpd/http-429.sh
 create mode 100755 t/t5584-http-429-retry.sh

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 9da5c298cc..849c89f36c 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -315,6 +315,32 @@ http.keepAliveCount::
 	unset, curl's default value is used. Can be overridden by the
 	`GIT_HTTP_KEEPALIVE_COUNT` environment variable.
 
+http.retryAfter::
+	Default wait time in seconds before retrying when a server returns
+	HTTP 429 (Too Many Requests) without a Retry-After header.
+	Defaults to 0 (retry immediately). When a Retry-After header is
+	present, its value takes precedence over this setting; however,
+	automatic use of the server-provided `Retry-After` header requires
+	libcurl 7.66.0 or later. On older versions, configure this setting
+	manually to control the retry delay. Can be overridden by the
+	`GIT_HTTP_RETRY_AFTER` environment variable.
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
index 8ea1b9d1f6..d8d016891b 100644
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
+static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p MAYBE_UNUSED)
 {
 	size_t size = eltsize * nmemb;
 	struct strvec *values = &http_auth.wwwauth_headers;
@@ -575,6 +582,21 @@ static int http_options(const char *var, const char *value,
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
@@ -1422,6 +1444,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	set_long_from_env(&curl_tcp_keepintvl, "GIT_TCP_KEEPINTVL");
 	set_long_from_env(&curl_tcp_keepcnt, "GIT_TCP_KEEPCNT");
 
+	set_long_from_env(&http_retry_after, "GIT_HTTP_RETRY_AFTER");
+	set_long_from_env(&http_max_retries, "GIT_HTTP_MAX_RETRIES");
+	set_long_from_env(&http_max_retry_time, "GIT_HTTP_MAX_RETRY_TIME");
+
 	curl_default = get_curl_handle();
 }
 
@@ -1871,6 +1897,10 @@ static int handle_curl_result(struct slot_results *results)
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
@@ -1886,6 +1916,7 @@ int run_one_slot(struct active_request_slot *slot,
 		 struct slot_results *results)
 {
 	slot->results = results;
+
 	if (!start_active_slot(slot)) {
 		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
 			  "failed to start HTTP request");
@@ -2119,10 +2150,10 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
 
 static int http_request(const char *url,
 			void *result, int target,
-			const struct http_get_options *options)
+			struct http_get_options *options)
 {
 	struct active_request_slot *slot;
-	struct slot_results results;
+	struct slot_results results = { .retry_after = -1 };
 	struct curl_slist *headers = http_copy_default_headers();
 	struct strbuf buf = STRBUF_INIT;
 	const char *accept_language;
@@ -2156,22 +2187,19 @@ static int http_request(const char *url,
 		headers = curl_slist_append(headers, accept_language);
 
 	strbuf_addstr(&buf, "Pragma:");
-	if (options && options->no_cache)
+	if (options->no_cache)
 		strbuf_addstr(&buf, " no-cache");
-	if (options && options->initial_request &&
+	if (options->initial_request &&
 	    http_follow_config == HTTP_FOLLOW_INITIAL)
 		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
 
 	headers = curl_slist_append(headers, buf.buf);
 
 	/* Add additional headers here */
-	if (options && options->extra_headers) {
+	if (options->extra_headers) {
 		const struct string_list_item *item;
-		if (options && options->extra_headers) {
-			for_each_string_list_item(item, options->extra_headers) {
-				headers = curl_slist_append(headers, item->string);
-			}
-		}
+		for_each_string_list_item(item, options->extra_headers)
+			headers = curl_slist_append(headers, item->string);
 	}
 
 	headers = http_append_auth_header(&http_auth, headers);
@@ -2183,7 +2211,18 @@ static int http_request(const char *url,
 
 	ret = run_one_slot(slot, &results);
 
-	if (options && options->content_type) {
+#ifdef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
+	if (ret == HTTP_RATE_LIMITED) {
+		curl_off_t retry_after;
+		if (curl_easy_getinfo(slot->curl, CURLINFO_RETRY_AFTER,
+				      &retry_after) == CURLE_OK && retry_after > 0)
+			results.retry_after = (long)retry_after;
+	}
+#endif
+
+	options->retry_after = results.retry_after;
+
+	if (options->content_type) {
 		struct strbuf raw = STRBUF_INIT;
 		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, &raw);
 		extract_content_type(&raw, options->content_type,
@@ -2191,7 +2230,7 @@ static int http_request(const char *url,
 		strbuf_release(&raw);
 	}
 
-	if (options && options->effective_url)
+	if (options->effective_url)
 		curlinfo_strbuf(slot->curl, CURLINFO_EFFECTIVE_URL,
 				options->effective_url);
 
@@ -2253,22 +2292,66 @@ static int update_url_from_redirect(struct strbuf *base,
 	return 1;
 }
 
-static int http_request_reauth(const char *url,
+/*
+ * Compute the retry delay for an HTTP 429 response.
+ * Returns a negative value if configuration is invalid (delay exceeds
+ * http.maxRetryTime), otherwise returns the delay in seconds (>= 0).
+ */
+static long handle_rate_limit_retry(long slot_retry_after)
+{
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
+	static struct http_get_options empty_opts;
 	int i = 3;
 	int ret;
+	int rate_limit_retries = http_max_retries;
+
+	if (!options)
+		options = &empty_opts;
 
 	if (always_auth_proactively())
 		credential_fill(the_repository, &http_auth, 1);
 
 	ret = http_request(url, result, target, options);
 
-	if (ret != HTTP_OK && ret != HTTP_REAUTH)
+	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_RATE_LIMITED)
 		return ret;
 
-	if (options && options->effective_url && options->base_url) {
+	/* If retries are disabled and we got a 429, fail immediately */
+	if (ret == HTTP_RATE_LIMITED && !http_max_retries)
+		return HTTP_ERROR;
+
+	if (options->effective_url && options->base_url) {
 		if (update_url_from_redirect(options->base_url,
 					     url, options->effective_url)) {
 			credential_from_url(&http_auth, options->base_url->buf);
@@ -2276,7 +2359,9 @@ static int http_request_reauth(const char *url,
 		}
 	}
 
-	while (ret == HTTP_REAUTH && --i) {
+	while ((ret == HTTP_REAUTH && --i) ||
+	       (ret == HTTP_RATE_LIMITED && --rate_limit_retries)) {
+		long retry_delay = -1;
 		/*
 		 * The previous request may have put cruft into our output stream; we
 		 * should clear it out before making our next request.
@@ -2301,11 +2386,28 @@ static int http_request_reauth(const char *url,
 		default:
 			BUG("Unknown http_request target");
 		}
-
-		credential_fill(the_repository, &http_auth, 1);
+		if (ret == HTTP_RATE_LIMITED) {
+			retry_delay = handle_rate_limit_retry(options->retry_after);
+			if (retry_delay < 0)
+				return HTTP_ERROR;
+
+			if (retry_delay > 0) {
+				warning(_("rate limited, waiting %ld seconds before retry"), retry_delay);
+				trace2_data_intmax("http", the_repository,
+						   "http/retry-sleep-seconds", retry_delay);
+				sleep(retry_delay);
+			}
+		} else if (ret == HTTP_REAUTH) {
+			credential_fill(the_repository, &http_auth, 1);
+		}
 
 		ret = http_request(url, result, target, options);
 	}
+	if (ret == HTTP_RATE_LIMITED) {
+		trace2_data_string("http", the_repository,
+				   "http/429-error", "retries-exhausted");
+		return HTTP_RATE_LIMITED;
+	}
 	return ret;
 }
 
@@ -2313,7 +2415,7 @@ int http_get_strbuf(const char *url,
 		    struct strbuf *result,
 		    struct http_get_options *options)
 {
-	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
+	return http_request_recoverable(url, result, HTTP_REQUEST_STRBUF, options);
 }
 
 /*
@@ -2337,7 +2439,7 @@ int http_get_file(const char *url, const char *filename,
 		goto cleanup;
 	}
 
-	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
+	ret = http_request_recoverable(url, result, HTTP_REQUEST_FILE, options);
 	fclose(result);
 
 	if (ret == HTTP_OK && finalize_object_file(the_repository, tmpfile.buf, filename))
diff --git a/http.h b/http.h
index f9d4593404..f9ee888c3e 100644
--- a/http.h
+++ b/http.h
@@ -20,6 +20,7 @@ struct slot_results {
 	long http_code;
 	long auth_avail;
 	long http_connectcode;
+	long retry_after;
 };
 
 struct active_request_slot {
@@ -157,6 +158,13 @@ struct http_get_options {
 	 * request has completed.
 	 */
 	struct string_list *extra_headers;
+
+	/*
+	 * After a request completes, contains the Retry-After delay in seconds
+	 * if the server returned HTTP 429 with a Retry-After header (requires
+	 * libcurl 7.66.0 or later), or -1 if no such header was present.
+	 */
+	long retry_after;
 };
 
 /* Return values for http_get_*() */
@@ -167,6 +175,7 @@ struct http_get_options {
 #define HTTP_REAUTH	4
 #define HTTP_NOAUTH	5
 #define HTTP_NOMATCHPUBLICKEY	6
+#define HTTP_RATE_LIMITED	7
 
 /*
  * Requests a URL and stores the result in a strbuf.
diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..57a3e9db62 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -529,6 +529,17 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		show_http_message(&type, &charset, &buffer);
 		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
 		    transport_anonymize_url(url.buf), curl_errorstr);
+	case HTTP_RATE_LIMITED:
+		if (http_options.retry_after > 0) {
+			show_http_message(&type, &charset, &buffer);
+			die(_("rate limited by '%s', please try again in %ld seconds"),
+				transport_anonymize_url(url.buf),
+				http_options.retry_after);
+		} else {
+			show_http_message(&type, &charset, &buffer);
+			die(_("rate limited by '%s', please try again later"),
+				transport_anonymize_url(url.buf));
+		}
 	default:
 		show_http_message(&type, &charset, &buffer);
 		die(_("unable to access '%s': %s"),
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5f42c311c2..4c76e813e3 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -167,6 +167,7 @@ prepare_httpd() {
 	install_script error.sh
 	install_script apply-one-time-script.sh
 	install_script nph-custom-auth.sh
+	install_script http-429.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 6b8c50a51a..40a690b0bb 100644
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
index 9b2fa4dee8..cba123af81 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -709,6 +709,7 @@ integration_tests = [
   't5581-http-curl-verbose.sh',
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
+  't5584-http-429-retry.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
new file mode 100755
index 0000000000..a22007b2cf
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
+	# Should fail quickly (no 100 second wait)
+	duration_int=${duration%.*} &&
+	test "$duration_int" -lt 99 &&
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
+	# Should fail quickly (no 100 second wait)
+	duration_int=${duration%.*} &&
+	test "$duration_int" -lt 99 &&
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
+	test "$duration_int" -lt 199 &&
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
+	# Should complete quickly (no wait for a past-date Retry-After)
+	duration_int=${duration%.*} &&
+	test "$duration_int" -lt 5 &&
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
+	test "$duration_int" -lt 49 &&
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
