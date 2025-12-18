Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEBB2D8385
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069097; cv=none; b=cFNacsLhMk/oLqs+leaKABt1+HTBr4JZ9+G3YVZOHHCJ3Y0+CXHQh6pHpi0MZfUz5uMSYhxE03HwnZcftJg+i5pFmpQk76c0zEmJCZGOML0EG5AKGjopz4oleupuQZRPW7FeOAhPiCOlqDif25zOY2y7VQIflTNouS6Iq1uU+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069097; c=relaxed/simple;
	bh=wpYjIQlYFA4zh4bUfYV1EJt0oq0xNPUXpPaEZzilvag=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PxQTFGA4Zfe0vq9Z++AckcoH+guBzb2i6frCdn2/L6jyM+mrd9uUSJW8VF7M83LO3opAuWAfFqhzUZiFhbPARsvTod603BBrYXfTd68nkehonmrQz4C027Rjf2CwRucrco9W6DXofR49VcqqyDK6HziFzTFQZR+QUcCcdZhQ7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFJQWplv; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFJQWplv"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-450823a7776so452892b6e.2
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766069093; x=1766673893; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WAVTRN6I8/AKIK/bw/HDgS5+N1hWYHFJA86V25Llac=;
        b=TFJQWplvLoaAAMJkWvk6DHMwk1TqzZHgdI5GR4AcX9lZNk+IkrITguP5mv3zdeS8j9
         VbkmrLQ0Qa4YkKYIn51APQ3ryCT5EO7H9jfgaVGDLUpqW6Y3H6g9EwaWy/O2bAYrg3Pr
         1CpAH5wNio6Rrlm4LHd73gJt4KEuFVhK/Ki0EZ6C7pyIJyfytpMxTenQfaZQBrLCVqH7
         ljZ1CMUqaKbQKBJI0H8zdS841fnlncumMggJDDRoali76rN2p+CPkCSD9BTY9hbNRy14
         WaVX7fc/t5X4W30fDBI+5l9jTS14gTCcMkZWl1RcIHcBAiNs0UJfoFXmM741h2bl5LPT
         tqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766069093; x=1766673893;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0WAVTRN6I8/AKIK/bw/HDgS5+N1hWYHFJA86V25Llac=;
        b=X5ulqUrNhrC95v2aMfcv0RyqQnbwHhqTHc8LoEdVW5kevmQE09ozsAJOmVTUidPgj/
         Z0EVAQsDNWIPQaLua7+UoIvRH4Dez1hM8GqRMX5HC2QKAbW/Ij++fbv4nFzNLEWk0qqL
         W4q32i0dAHfZq+jkTjRLPKrZjs92tZ+uOb4QEk0QURzSe7CeZrjR17CgpgoQemXrvLSm
         mjRfOSSCgCC2sDDXQQPz7RUsJuC8vA5e3RRTaNwBCWhiPdAX2fIkaPOzrH8auyNql5F7
         O/zpbFT1WpU9E76LEKt5yYpS02ZWPN7u+zPvpG700DxdbLkUtLz+ULyt2W6a1Y0u/L8f
         sa4Q==
X-Gm-Message-State: AOJu0YwpQmuJQYy31LT+uFcEutSV6OTW3ifq2nbBCkir7cmF8Fm27Wxx
	LqL9UsHujtpkKUt514waoFs3/EEtuDT8h+usZZaTOn1JddU4mWSK8dcbnrryFfRI
X-Gm-Gg: AY/fxX4JVp8Wd2CQy6SGoGAXJWq8HeVEKUqNcEhKpa39L2GI76hbJtabCuEHktMzZPb
	UlZLhAMPyxM91udztS7xekkuKkx025rrv2d80YaHo+hNvx3NJ+n8qzclOAo13TK0nwh9N+JBXz+
	DrRmEbXjdR2f8kI3TlLI8+XpixvXOH7iM5f6afNSHD4wEnT+1B5dOxs7jx56NAsbIP20mdbp+Ou
	2/95FO5SqSmOyXUcUBqYtVryAhj2kDmyMTvbCzQRih0AaX2rm3RFWHZrVAgtuoWeCcpmeoq/MQr
	qgXvCYAyD8+NIN2/dyHchs07YP89bRj5wk1LNIZI50LeBYMwW4mlYourjRTkvmPAC90IoaYmH4U
	AjnIUzmhR/r39WHM4T8AccoD3Enh3GaETwIsF2NB6dh9L2o5481D4txd47DQ0jZj0y0OOjVI/E7
	tVZsoznoPhtDms6A==
X-Google-Smtp-Source: AGHT+IGJBaTvW3cFZpT8zelFje7yZNwt30Md4grl/is8HVg1AZN/zMtqFqvmkw7nhBTJuHCEeK/zew==
X-Received: by 2002:a05:6808:238e:b0:44f:6d70:45af with SMTP id 5614622812f47-455ac82269amr9433111b6e.9.1766069092407;
        Thu, 18 Dec 2025 06:44:52 -0800 (PST)
Received: from [127.0.0.1] ([52.176.125.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457a4538f69sm1254099b6e.12.2025.12.18.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 06:44:51 -0800 (PST)
Message-Id: <d80ce077038bab96aca26b0b0ad706c91ea1d8a8.1766069088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
	<pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 14:44:47 +0000
Subject: [PATCH v2 1/2] http: add support for HTTP 429 rate limit retries
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
 Documentation/config/http.adoc |  24 +++
 http-push.c                    |   8 +
 http-walker.c                  |   5 +
 http.c                         | 300 ++++++++++++++++++++++++++++-----
 http.h                         |   4 +
 remote-curl.c                  |  49 ++++--
 strbuf.c                       |   2 +-
 t/lib-httpd.sh                 |   1 +
 t/lib-httpd/apache.conf        |   8 +
 t/lib-httpd/http-429.sh        |  98 +++++++++++
 t/meson.build                  |   1 +
 t/t5584-http-429-retry.sh      | 286 +++++++++++++++++++++++++++++++
 12 files changed, 729 insertions(+), 57 deletions(-)
 create mode 100644 t/lib-httpd/http-429.sh
 create mode 100755 t/t5584-http-429-retry.sh

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 9da5c298cc..9e3c888df4 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -315,6 +315,30 @@ http.keepAliveCount::
 	unset, curl's default value is used. Can be overridden by the
 	`GIT_HTTP_KEEPALIVE_COUNT` environment variable.
 
+http.retryAfter::
+	Default wait time in seconds before retrying when a server returns
+	HTTP 429 (Too Many Requests) without a Retry-After header. If set
+	to -1 (the default), Git will fail immediately when encountering
+	a 429 response without a Retry-After header. When a Retry-After
+	header is present, its value takes precedence over this setting.
+	Can be overridden by the `GIT_HTTP_RETRY_AFTER` environment variable.
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
diff --git a/http-push.c b/http-push.c
index 60a9b75620..ddb9948352 100644
--- a/http-push.c
+++ b/http-push.c
@@ -716,6 +716,10 @@ static int fetch_indices(void)
 	case HTTP_MISSING_TARGET:
 		ret = 0;
 		break;
+	case HTTP_RATE_LIMITED:
+		error(_("rate limited by '%s', please try again later"), repo->url);
+		ret = -1;
+		break;
 	default:
 		ret = -1;
 	}
@@ -1548,6 +1552,10 @@ static int remote_exists(const char *path)
 	case HTTP_MISSING_TARGET:
 		ret = 0;
 		break;
+	case HTTP_RATE_LIMITED:
+		error(_("rate limited by '%s', please try again later"), url);
+		ret = -1;
+		break;
 	case HTTP_ERROR:
 		error("unable to access '%s': %s", url, curl_errorstr);
 		/* fallthrough */
diff --git a/http-walker.c b/http-walker.c
index e886e64866..9f06f47de1 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -414,6 +414,11 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 		repo->got_indices = 1;
 		ret = 0;
 		break;
+	case HTTP_RATE_LIMITED:
+		error("rate limited by '%s', please try again later", repo->base);
+		repo->got_indices = 0;
+		ret = -1;
+		break;
 	default:
 		repo->got_indices = 0;
 		ret = -1;
diff --git a/http.c b/http.c
index 41f850db16..60e0364f57 100644
--- a/http.c
+++ b/http.c
@@ -22,6 +22,7 @@
 #include "object-file.h"
 #include "odb.h"
 #include "tempfile.h"
+#include "date.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
@@ -149,6 +150,11 @@ static char *cached_accept_language;
 static char *http_ssl_backend;
 
 static int http_schannel_check_revoke = 1;
+
+static long http_retry_after = -1;
+static long http_max_retries = 0;
+static long http_max_retry_time = 300;
+
 /*
  * With the backend being set to `schannel`, setting sslCAinfo would override
  * the Certificate Store in cURL v7.60.0 and later, which is not what we want
@@ -209,13 +215,14 @@ static inline int is_hdr_continuation(const char *ptr, const size_t size)
 	return size && (*ptr == ' ' || *ptr == '\t');
 }
 
-static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UNUSED)
+static size_t fwrite_headers(char *ptr, size_t eltsize, size_t nmemb, void *p)
 {
 	size_t size = eltsize * nmemb;
 	struct strvec *values = &http_auth.wwwauth_headers;
 	struct strbuf buf = STRBUF_INIT;
 	const char *val;
 	size_t val_len;
+	struct active_request_slot *slot = (struct active_request_slot *)p;
 
 	/*
 	 * Header lines may not come NULL-terminated from libcurl so we must
@@ -257,6 +264,47 @@ static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UN
 		goto exit;
 	}
 
+	/* Parse Retry-After header for rate limiting */
+	if (skip_iprefix_mem(ptr, size, "retry-after:", &val, &val_len)) {
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
+			/* Check if it's a valid integer (delay-seconds format) */
+			if (endptr != buf.buf && *endptr == '\0' &&
+			    errno != ERANGE && retry_after > 0) {
+				slot->results->retry_after = retry_after;
+			} else {
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
+		http_auth.header_is_last_match = 1;
+		goto exit;
+	}
+
 	/*
 	 * This line could be a continuation of the previously matched header
 	 * field. If this is the case then we should append this value to the
@@ -575,6 +623,21 @@ static int http_options(const char *var, const char *value,
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
@@ -1422,6 +1485,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	set_long_from_env(&curl_tcp_keepintvl, "GIT_TCP_KEEPINTVL");
 	set_long_from_env(&curl_tcp_keepcnt, "GIT_TCP_KEEPCNT");
 
+	set_long_from_env(&http_retry_after, "GIT_HTTP_RETRY_AFTER");
+	set_long_from_env(&http_max_retries, "GIT_HTTP_MAX_RETRIES");
+	set_long_from_env(&http_max_retry_time, "GIT_HTTP_MAX_RETRY_TIME");
+
 	curl_default = get_curl_handle();
 }
 
@@ -1529,6 +1596,8 @@ struct active_request_slot *get_active_slot(void)
 	slot->finished = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
+	slot->retry_delay_seconds = -1;
+	memset(&slot->retry_delay_start, 0, sizeof(slot->retry_delay_start));
 
 	if (curl_cookie_file && !strcmp(curl_cookie_file, "-")) {
 		warning(_("refusing to read cookies from http.cookiefile '-'"));
@@ -1660,44 +1729,98 @@ void run_active_slot(struct active_request_slot *slot)
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
+	long curl_timeout;
+	struct timeval start_time = {0}, current_time, elapsed_time = {0};
+	long remaining_seconds;
 	int finished = 0;
+	int slot_not_started = (slot->finished == NULL);
+	int waiting_for_delay = (slot->retry_delay_seconds > 0);
+
+	if (waiting_for_delay) {
+		warning(_("rate limited, waiting %ld seconds before retry"), slot->retry_delay_seconds);
+		start_time = slot->retry_delay_start;
+	}
 
 	slot->finished = &finished;
-	while (!finished) {
+	while (waiting_for_delay || !finished) {
+		if (waiting_for_delay) {
+			gettimeofday(&current_time, NULL);
+			elapsed_time.tv_sec = current_time.tv_sec - start_time.tv_sec;
+			elapsed_time.tv_usec = current_time.tv_usec - start_time.tv_usec;
+			if (elapsed_time.tv_usec < 0) {
+				elapsed_time.tv_sec--;
+				elapsed_time.tv_usec += 1000000;
+			}
+
+			if (elapsed_time.tv_sec >= slot->retry_delay_seconds) {
+				slot->retry_delay_seconds = -1;
+				waiting_for_delay = 0;
+
+				if (slot_not_started)
+					return;
+			}
+		}
+
 		step_active_slots();
 
-		if (slot->in_use) {
-			long curl_timeout;
-			curl_multi_timeout(curlm, &curl_timeout);
-			if (curl_timeout == 0) {
+		if (!waiting_for_delay && !slot->in_use)
+			continue;
+
+		curl_multi_timeout(curlm, &curl_timeout);
+		if (curl_timeout == 0) {
+			if (!waiting_for_delay)
 				continue;
-			} else if (curl_timeout == -1) {
-				select_timeout.tv_sec  = 0;
-				select_timeout.tv_usec = 50000;
+			select_timeout.tv_sec = 0;
+			select_timeout.tv_usec = 50000; /* 50ms */
+		} else if (curl_timeout == -1) {
+			select_timeout.tv_sec = 0;
+			select_timeout.tv_usec = 50000;
+		} else {
+			long curl_timeout_sec = curl_timeout / 1000;
+			long curl_timeout_usec = (curl_timeout % 1000) * 1000;
+
+			if (waiting_for_delay) {
+				remaining_seconds = slot->retry_delay_seconds - elapsed_time.tv_sec;
+				if (curl_timeout_sec < remaining_seconds) {
+					select_timeout.tv_sec = curl_timeout_sec;
+					select_timeout.tv_usec = curl_timeout_usec;
+				} else {
+					select_timeout.tv_sec = remaining_seconds;
+					select_timeout.tv_usec = 0;
+				}
 			} else {
-				select_timeout.tv_sec  =  curl_timeout / 1000;
-				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
+				select_timeout.tv_sec = curl_timeout_sec;
+				select_timeout.tv_usec = curl_timeout_usec;
 			}
+		}
 
-			max_fd = -1;
-			FD_ZERO(&readfds);
-			FD_ZERO(&writefds);
-			FD_ZERO(&excfds);
-			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
+		max_fd = -1;
+		FD_ZERO(&readfds);
+		FD_ZERO(&writefds);
+		FD_ZERO(&excfds);
+		curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
 
-			/*
-			 * It can happen that curl_multi_timeout returns a pathologically
-			 * long timeout when curl_multi_fdset returns no file descriptors
-			 * to read.  See commit message for more details.
-			 */
-			if (max_fd < 0 &&
-			    (select_timeout.tv_sec > 0 ||
-			     select_timeout.tv_usec > 50000)) {
-				select_timeout.tv_sec  = 0;
-				select_timeout.tv_usec = 50000;
-			}
+		/*
+		 * It can happen that curl_multi_timeout returns a pathologically
+		 * long timeout when curl_multi_fdset returns no file descriptors
+		 * to read.  See commit message for more details.
+		 */
+		if (max_fd < 0 &&
+		    (select_timeout.tv_sec > 0 ||
+		     select_timeout.tv_usec > 50000)) {
+			select_timeout.tv_sec = 0;
+			select_timeout.tv_usec = 50000;
+		}
 
-			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
+		/*
+		 * If curl_multi_fdset returns no file descriptors but we have
+		 * a timeout, still use select() to wait for the timeout period.
+		 */
+		if (max_fd < 0) {
+			/* No file descriptors, just wait for timeout */
+			select(0, NULL, NULL, NULL, &select_timeout);
+		} else {
+			select(max_fd + 1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
 
@@ -1871,6 +1994,8 @@ static int handle_curl_result(struct slot_results *results)
 			}
 			return HTTP_REAUTH;
 		}
+	} else if (results->http_code == 429) {
+		return HTTP_RATE_LIMITED;
 	} else {
 		if (results->http_connectcode == 407)
 			credential_reject(the_repository, &proxy_auth);
@@ -1886,6 +2011,14 @@ int run_one_slot(struct active_request_slot *slot,
 		 struct slot_results *results)
 {
 	slot->results = results;
+	/* Initialize retry_after to -1 (not set) */
+	results->retry_after = -1;
+
+	/* If there's a retry delay, wait for it before starting the slot */
+	if (slot->retry_delay_seconds > 0) {
+		run_active_slot(slot);
+	}
+
 	if (!start_active_slot(slot)) {
 		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
 			  "failed to start HTTP request");
@@ -2117,9 +2250,13 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
 
+static void sleep_for_retry(struct active_request_slot *slot, long retry_after);
+
 static int http_request(const char *url,
 			void *result, int target,
-			const struct http_get_options *options)
+			const struct http_get_options *options,
+			long *retry_after_out,
+			long retry_delay)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -2129,6 +2266,10 @@ static int http_request(const char *url,
 	int ret;
 
 	slot = get_active_slot();
+	/* Mark slot for delay if retry delay is provided */
+	if (retry_delay > 0) {
+		sleep_for_retry(slot, retry_delay);
+	}
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
 
 	if (!result) {
@@ -2148,7 +2289,8 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
-	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_headers);
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, slot);
 
 	accept_language = http_get_accept_language_header();
 
@@ -2183,6 +2325,10 @@ static int http_request(const char *url,
 
 	ret = run_one_slot(slot, &results);
 
+	/* Store retry_after from slot results if output parameter provided */
+	if (retry_after_out)
+		*retry_after_out = results.retry_after;
+
 	if (options && options->content_type) {
 		struct strbuf raw = STRBUF_INIT;
 		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, &raw);
@@ -2253,21 +2399,90 @@ static int update_url_from_redirect(struct strbuf *base,
 	return 1;
 }
 
-static int http_request_reauth(const char *url,
+/*
+ * Mark slot to be delayed for retry. The actual delay will be handled
+ * in run_active_slot when the slot is executed.
+ */
+static void sleep_for_retry(struct active_request_slot *slot, long retry_after)
+{
+	if (retry_after > 0 && slot) {
+		warning(_("rate limited, waiting %ld seconds before retry"), retry_after);
+		slot->retry_delay_seconds = retry_after;
+		gettimeofday(&slot->retry_delay_start, NULL);
+	}
+}
+
+/*
+ * Handle rate limiting retry logic for HTTP 429 responses.
+ * Uses slot-specific retry_after value to support concurrent slots.
+ * Returns a negative value if retries are exhausted or configuration is invalid,
+ * otherwise returns the delay value (>= 0) to indicate the retry should proceed.
+ */
+static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_after)
+{
+	int retry_attempt = http_max_retries - *rate_limit_retries + 1;
+	if (*rate_limit_retries <= 0) {
+		/* Retries are disabled or exhausted */
+		if (http_max_retries > 0) {
+			error(_("too many rate limit retries, giving up"));
+		}
+		return -1;
+	}
+
+	/* Decrement retries counter */
+	(*rate_limit_retries)--;
+
+	/* Use the slot-specific retry_after value or configured default */
+	if (slot_retry_after >= 0) {
+		/* Check if retry delay exceeds maximum allowed */
+		if (slot_retry_after > http_max_retry_time) {
+			error(_("rate limited (HTTP 429) requested %ld second delay, "
+				"exceeds http.maxRetryTime of %ld seconds"),
+			      slot_retry_after, http_max_retry_time);
+			return -1;
+		}
+		return slot_retry_after;
+	} else {
+		/* No Retry-After header provided */
+		if (http_retry_after < 0) {
+			/* Not configured - exit with error */
+			error(_("rate limited (HTTP 429) and no Retry-After header provided. "
+				"Configure http.retryAfter or set GIT_HTTP_RETRY_AFTER."));
+			return -1;
+		}
+		/* Check if configured default exceeds maximum allowed */
+		if (http_retry_after > http_max_retry_time) {
+			error(_("configured http.retryAfter (%ld seconds) exceeds "
+				"http.maxRetryTime (%ld seconds)"),
+			      http_retry_after, http_max_retry_time);
+			return -1;
+		}
+
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
+	ret = http_request(url, result, target, options, &slot_retry_after, -1);
 
-	if (ret != HTTP_OK && ret != HTTP_REAUTH)
+	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_RATE_LIMITED)
 		return ret;
 
+	/* If retries are disabled and we got a 429, fail immediately */
+	if (ret == HTTP_RATE_LIMITED && http_max_retries == 0)
+		return HTTP_ERROR;
+
 	if (options && options->effective_url && options->base_url) {
 		if (update_url_from_redirect(options->base_url,
 					     url, options->effective_url)) {
@@ -2276,7 +2491,8 @@ static int http_request_reauth(const char *url,
 		}
 	}
 
-	while (ret == HTTP_REAUTH && --i) {
+	while ((ret == HTTP_REAUTH || ret == HTTP_RATE_LIMITED) && --i) {
+		long retry_delay = -1;
 		/*
 		 * The previous request may have put cruft into our output stream; we
 		 * should clear it out before making our next request.
@@ -2301,10 +2517,16 @@ static int http_request_reauth(const char *url,
 		default:
 			BUG("Unknown http_request target");
 		}
+		if (ret == HTTP_RATE_LIMITED) {
+			retry_delay = handle_rate_limit_retry(&rate_limit_retries, slot_retry_after);
+			if (retry_delay < 0)
+				return HTTP_ERROR;
+			slot_retry_after = -1; /* Reset after use */
+		} else if (ret == HTTP_REAUTH) {
+			credential_fill(the_repository, &http_auth, 1);
+		}
 
-		credential_fill(the_repository, &http_auth, 1);
-
-		ret = http_request(url, result, target, options);
+		ret = http_request(url, result, target, options, &slot_retry_after, retry_delay);
 	}
 	return ret;
 }
@@ -2313,7 +2535,7 @@ int http_get_strbuf(const char *url,
 		    struct strbuf *result,
 		    struct http_get_options *options)
 {
-	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
+	return http_request_recoverable(url, result, HTTP_REQUEST_STRBUF, options);
 }
 
 /*
@@ -2337,7 +2559,7 @@ int http_get_file(const char *url, const char *filename,
 		goto cleanup;
 	}
 
-	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
+	ret = http_request_recoverable(url, result, HTTP_REQUEST_FILE, options);
 	fclose(result);
 
 	if (ret == HTTP_OK && finalize_object_file(the_repository, tmpfile.buf, filename))
diff --git a/http.h b/http.h
index f9d4593404..6ee809ec01 100644
--- a/http.h
+++ b/http.h
@@ -20,6 +20,7 @@ struct slot_results {
 	long http_code;
 	long auth_avail;
 	long http_connectcode;
+	long retry_after;
 };
 
 struct active_request_slot {
@@ -32,6 +33,8 @@ struct active_request_slot {
 	void *callback_data;
 	void (*callback_func)(void *data);
 	struct active_request_slot *next;
+	long retry_delay_seconds;
+	struct timeval retry_delay_start;
 };
 
 struct buffer {
@@ -167,6 +170,7 @@ struct http_get_options {
 #define HTTP_REAUTH	4
 #define HTTP_NOAUTH	5
 #define HTTP_NOMATCHPUBLICKEY	6
+#define HTTP_RATE_LIMITED	7
 
 /*
  * Requests a URL and stores the result in a strbuf.
diff --git a/remote-curl.c b/remote-curl.c
index 69f919454a..c122dcedaa 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -367,23 +367,25 @@ static void free_discovery(struct discovery *d)
 	}
 }
 
-static int show_http_message(struct strbuf *type, struct strbuf *charset,
-			     struct strbuf *msg)
+static NORETURN void show_http_message_fatal(struct strbuf *type, struct strbuf *charset,
+				    struct strbuf *msg, const char *fmt, ...)
 {
 	const char *p, *eol;
+	va_list ap;
+	report_fn die_message_routine = get_die_message_routine();
 
 	/*
 	 * We only show text/plain parts, as other types are likely
 	 * to be ugly to look at on the user's terminal.
 	 */
 	if (strcmp(type->buf, "text/plain"))
-		return -1;
+		goto out;
 	if (charset->len)
 		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
 
 	strbuf_trim(msg);
 	if (!msg->len)
-		return -1;
+		goto out;
 
 	p = msg->buf;
 	do {
@@ -391,7 +393,16 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 		fprintf(stderr, "remote: %.*s\n", (int)(eol - p), p);
 		p = eol + 1;
 	} while(*eol);
-	return 0;
+
+out:
+	strbuf_release(type);
+	strbuf_release(charset);
+	strbuf_release(msg);
+
+	va_start(ap, fmt);
+	die_message_routine(fmt, ap);
+	va_end(ap);
+	exit(128);
 }
 
 static int get_protocol_http_header(enum protocol_version version,
@@ -518,21 +529,25 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	case HTTP_OK:
 		break;
 	case HTTP_MISSING_TARGET:
-		show_http_message(&type, &charset, &buffer);
-		die(_("repository '%s' not found"),
-		    transport_anonymize_url(url.buf));
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("repository '%s' not found"),
+					transport_anonymize_url(url.buf));
 	case HTTP_NOAUTH:
-		show_http_message(&type, &charset, &buffer);
-		die(_("Authentication failed for '%s'"),
-		    transport_anonymize_url(url.buf));
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("Authentication failed for '%s'"),
+					transport_anonymize_url(url.buf));
 	case HTTP_NOMATCHPUBLICKEY:
-		show_http_message(&type, &charset, &buffer);
-		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
-		    transport_anonymize_url(url.buf), curl_errorstr);
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
+					transport_anonymize_url(url.buf), curl_errorstr);
+	case HTTP_RATE_LIMITED:
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("rate limited by '%s', please try again later"),
+					transport_anonymize_url(url.buf));
 	default:
-		show_http_message(&type, &charset, &buffer);
-		die(_("unable to access '%s': %s"),
-		    transport_anonymize_url(url.buf), curl_errorstr);
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("unable to access '%s': %s"),
+					transport_anonymize_url(url.buf), curl_errorstr);
 	}
 
 	if (options.verbosity && !starts_with(refs_url.buf, url.buf)) {
diff --git a/strbuf.c b/strbuf.c
index 6c3851a7f8..1d3860869e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -168,7 +168,7 @@ int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 	if (!out)
 		return -1;
 
-	strbuf_attach(sb, out, len, len);
+	strbuf_attach(sb, out, len, len + 1);
 	return 0;
 }
 
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
index 459c52a489..ee82450333 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -700,6 +700,7 @@ integration_tests = [
   't5581-http-curl-verbose.sh',
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
+  't5584-http-429-retry.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
new file mode 100755
index 0000000000..c0d30c5387
--- /dev/null
+++ b/t/t5584-http-429-retry.sh
@@ -0,0 +1,286 @@
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
+	start=$(date +%s) &&
+	git ls-remote "$HTTPD_URL/http_429/retry-delays-respected/2/repo.git" >output 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Verify it took at least 2 seconds (allowing some tolerance)
+	test "$duration" -ge 1 &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'HTTP 429 fails immediately if Retry-After exceeds http.maxRetryTime' '
+	# Configure max retry time to 3 seconds (much less than requested 100)
+	test_config http.maxRetries 3 &&
+	test_config http.maxRetryTime 3 &&
+
+	# Should fail immediately without waiting
+	start=$(date +%s) &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/retry-after-exceeds-max-time/100/repo.git" 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should fail quickly (less than 2 seconds, no 100 second wait)
+	test "$duration" -lt 2 &&
+	test_grep "exceeds http.maxRetryTime" err
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
+	start=$(date +%s) &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/config-retry-after-exceeds-max-time/none/repo.git" 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should fail quickly
+	test "$duration" -lt 2 &&
+	test_grep "configured http.retryAfter.*exceeds.*http.maxRetryTime" err
+'
+
+test_expect_success 'HTTP 429 with Retry-After HTTP-date format' '
+	# Test HTTP-date format (RFC 2822) in Retry-After header
+	# Generate a date 2 seconds in the future
+	future_date=$(TZ=GMT date -d "+2 seconds" "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
+		      TZ=GMT date -v+2S "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
+		      echo "skip") &&
+
+	if test "$future_date" = "skip"
+	then
+		skip_all="date command does not support required format" &&
+		test_done
+	fi &&
+
+	# URL-encode the date (replace spaces with %20)
+	future_date_encoded=$(echo "$future_date" | sed "s/ /%20/g") &&
+
+	# Enable retries
+	test_config http.maxRetries 3 &&
+
+	# Git should parse the HTTP-date and retry after the delay
+	start=$(date +%s) &&
+	git ls-remote "$HTTPD_URL/http_429/http-date-format/$future_date_encoded/repo.git" >output 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should take at least 1 second (allowing tolerance for processing time)
+	test "$duration" -ge 1 &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'HTTP 429 with HTTP-date exceeding maxRetryTime fails immediately' '
+	# Generate a date 200 seconds in the future
+	future_date=$(TZ=GMT date -d "+200 seconds" "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
+		      TZ=GMT date -v+200S "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
+		      echo "skip") &&
+
+	if test "$future_date" = "skip"
+	then
+		skip_all="date command does not support required format" &&
+		test_done
+	fi &&
+
+	# URL-encode the date (replace spaces with %20)
+	future_date_encoded=$(echo "$future_date" | sed "s/ /%20/g") &&
+
+	# Configure max retry time much less than the 200 second delay
+	test_config http.maxRetries 3 &&
+	test_config http.maxRetryTime 10 &&
+
+	# Should fail immediately without waiting 200 seconds
+	start=$(date +%s) &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/http-date-exceeds-max-time/$future_date_encoded/repo.git" 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should fail quickly (not wait 200 seconds)
+	test "$duration" -lt 2 &&
+	test_grep "exceeds http.maxRetryTime" err
+'
+
+test_expect_success 'HTTP 429 with past HTTP-date should not wait' '
+	past_date=$(TZ=GMT date -d "-10 seconds" "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
+		    TZ=GMT date -v-10S "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
+		    echo "skip") &&
+
+	if test "$past_date" = "skip"
+	then
+		skip_all="date command does not support required format" &&
+		test_done
+	fi &&
+
+	# URL-encode the date (replace spaces with %20)
+	past_date_encoded=$(echo "$past_date" | sed "s/ /%20/g") &&
+
+	# Enable retries
+	test_config http.maxRetries 3 &&
+
+	# Git should retry immediately without waiting
+	start=$(date +%s) &&
+	git ls-remote "$HTTPD_URL/http_429/past-http-date/$past_date_encoded/repo.git" >output 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should complete quickly (less than 2 seconds)
+	test "$duration" -lt 2 &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'HTTP 429 with invalid Retry-After format uses configured default' '
+	# Configure default retry-after
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+
+	# Should use configured default (1 second) since header is invalid
+	start=$(date +%s) &&
+	git ls-remote "$HTTPD_URL/http_429/invalid-retry-after-format/invalid/repo.git" >output 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should take at least 1 second (the configured default)
+	test "$duration" -ge 1 &&
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
+	start=$(date +%s) &&
+	GIT_HTTP_RETRY_AFTER=1 git ls-remote "$HTTPD_URL/http_429/env-retry-after-override/none/repo.git" >output 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should use env var (1 second), not config (10 seconds)
+	test "$duration" -ge 1 &&
+	test "$duration" -lt 5 &&
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
+	start=$(date +%s) &&
+	test_must_fail env GIT_HTTP_MAX_RETRY_TIME=10 \
+		git ls-remote "$HTTPD_URL/http_429/env-max-retry-time-override/50/repo.git" 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should fail quickly (not wait 50 seconds) because env var limits to 10
+	test "$duration" -lt 5 &&
+	test_grep "exceeds http.maxRetryTime" err
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

