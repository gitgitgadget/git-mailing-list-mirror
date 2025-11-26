Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514F32827E
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160236; cv=none; b=pP1ksgad3bTAbRizCQe80eM9mGjqM/Jo5Ce9X623JPNeLsdjLOTW9lm+n2o4if8eiS06GNBo/o1vXtQ4V0RANcxYm8GketwsXoFMfUuMv5j8LBD9opL5cohkvq4tzRpMrmqJ9mGjKU0zL7a9DTSrnfxzQlC76VFrrrgjtS6+4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160236; c=relaxed/simple;
	bh=j3hGpaAHw315LzMtmmbvpt93Jg01KHfHeymvdFX6faI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W2I4/sVr+UHEsF6203s3/x9eJVXYxJ2pm69qHPFm5NnGujFklKt4krVDHW/XdBlpFiH70cecieGrrnc7pHU/ItuWiWfUYoo6rl019ULrDuQ72PVrsJ7dQlnxILWM7dcjaZzpl/fZaPXr2BkYF5Z13Xu2+C5DZJAPdG/roX2mALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHOVYfUr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHOVYfUr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297e982506fso93120175ad.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 04:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764160233; x=1764765033; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK7tW67D0/lXzZLPvj9IQdZfErDZOPjvMEN9e5D+RZ0=;
        b=FHOVYfUreT6yjBqWwEwB01KjwlnpLxWKBJYYYZFethEjv0odMnn0emYW6S2K+y31y/
         LuNELQLs5MzaReTEwX7XKk2v40+zK5OpOQ9gZUd1a6vcP2cnrV7WZE7AwwwDo7t3LxX0
         vuRl1laB5BHRi9BWfcIt8P62qC+2NwaGp/jh5+n08fqsM3S5mu4hscOFLJLviZ0uZEFd
         d8QUhsRb4U4cTbxTt4Jmej1+kw/iUnfca4OzHasQX7eKz2mBcnGTN3zknDtbLSAWl+Q6
         O1z5ZoCl/p7m6v5CcQJL/mOjbAH+QTvzl4zoJuZ9U6qXtEmhOdV2Ug8oMHOX45cB5sjl
         zVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764160233; x=1764765033;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IK7tW67D0/lXzZLPvj9IQdZfErDZOPjvMEN9e5D+RZ0=;
        b=elun/kwXWUFM+5G1joRjL5xusn0kTjLVcrgH+4a8uhPK2yDuPnvmGoyTddrzn4g0NG
         w+szYkOg6q7MsqQBWLxJso7USD+fBbQARjq5SoKBaShL7o5vcypG7oTbxgmT49NlACO4
         QwFA46klS9tjwNjgAr44WOjYiptikQClOPJ0DT+NiF2nvMzpvF4GKyYSg66B/rXtBxIZ
         LzMaJpu/I+lVKTBMsHDdziF83kQgDQMlE+UdocbXITdmuvaUhBOdy+ArFx92FtEoH5To
         gLgW09Onvl2+k2ls+S20zMS0yc0mrNnnGow8BB5KI9h2tjG0EkOz9sbACNFLkf9LZCKN
         39Tw==
X-Gm-Message-State: AOJu0Yx+CctqHyDfBbkio+9bGPfkNvzXaZMe/RzPm8zBChCdaQqbToTF
	hNsxDRdUgkjObtsXQWGsVHXsTx2GVIV0sOcjXRZ8d7ZeqqQoMLfEd1T0N1spmA==
X-Gm-Gg: ASbGnctoNMXDzP+DL4IpPsDgWMV8J20dEYWqB7xAfWRQtj7dMrmgsbBCuBPg6Lsh6uT
	XdjppaX9VC548ktkeRb8XsSnLYYMETyoIoM4fohaN+YP1M36OnNu9j6EysVilGh6Tht7LiAiYXy
	ZO7e5OHwBgw4gHwGRweRSN7daPviZHvwB0klUdyOkRa4fuMznLaJ3uiO+qZhoGluH6tjt/EwWoS
	0x/k3u1l8MtpYGee75I9HGCwsHHnaTP2OGd+owmR195HTRSwlhYw85kCyQCHuu7srpQspRgPCZb
	HfHLCQusrb2+VwACg2aY+HL49x6ObYck1AsWJFOf2zPUxZsyDkhO2taBZN+g1XnK4OmoUrrcycn
	Q9qkt0BPb5fN0SS6bosafw6RU/2YLlwR3b5h5YBH/k50UbZ9josWnQR8agDKJUJhK15DKw+8kyD
	Z2msljqD0ZxdUbHTU1Md/bgBSqtg==
X-Google-Smtp-Source: AGHT+IG4AptbxfZMYbk1xk5gONWaZGFPxv6OyhOjwvXznVLiMqynysdc31ZGRFQ5t7oZaCawyUP42Q==
X-Received: by 2002:a17:903:1b10:b0:298:485d:5576 with SMTP id d9443c01a7336-29b6be91657mr177838465ad.8.1764160232132;
        Wed, 26 Nov 2025 04:30:32 -0800 (PST)
Received: from [127.0.0.1] ([172.182.195.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a5a3099sm2488996a91.11.2025.11.26.04.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:30:31 -0800 (PST)
Message-Id: <ae0087cd1c7fbb6b748d6767b476c1bd1a19996f.1764160227.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 12:30:25 +0000
Subject: [PATCH 1/3] http: add support for HTTP 429 rate limit retries
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
Cc: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Add retry logic for HTTP 429 (Too Many Requests) responses to handle
server-side rate limiting gracefully. When Git's HTTP client receives
a 429 response, it can now automatically retry the request after an
appropriate delay, respecting the server's rate limits.

The implementation supports the RFC-compliant Retry-After header in
both delay-seconds (integer) and HTTP-date (RFC 2822) formats. If a
past date is provided, Git retries immediately without waiting.

Retry behavior is controlled by three new configuration options:

  * http.maxRetries: Maximum number of retry attempts (default: 0,
    meaning retries are disabled by default). Users must explicitly
    opt-in to retry behavior.

  * http.retryAfter: Default delay in seconds when the server doesn't
    provide a Retry-After header (default: -1, meaning fail if no
    header is provided). This serves as a fallback mechanism.

  * http.maxRetryTime: Maximum delay in seconds for a single retry
    (default: 300). If the server requests a delay exceeding this
    limit, Git fails immediately rather than waiting. This prevents
    indefinite blocking on unreasonable server requests.

All three options can be overridden via environment variables:
GIT_HTTP_MAX_RETRIES, GIT_HTTP_RETRY_AFTER, and
GIT_HTTP_MAX_RETRY_TIME.

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
 Documentation/config/http.adoc |  24 ++
 http-push.c                    |   8 +
 http-walker.c                  |   5 +
 http.c                         | 149 +++++++++++-
 http.h                         |   2 +
 remote-curl.c                  |   4 +
 t/meson.build                  |   1 +
 t/t5584-http-429-retry.sh      | 429 +++++++++++++++++++++++++++++++++
 8 files changed, 618 insertions(+), 4 deletions(-)
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
index d86ce77119..a602a302ec 100644
--- a/http-push.c
+++ b/http-push.c
@@ -716,6 +716,10 @@ static int fetch_indices(void)
 	case HTTP_MISSING_TARGET:
 		ret = 0;
 		break;
+	case HTTP_RATE_LIMITED:
+		error("rate limited by '%s', please try again later", repo->url);
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
+		error("rate limited by '%s', please try again later", url);
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
index 41f850db16..212805cad5 100644
--- a/http.c
+++ b/http.c
@@ -22,6 +22,7 @@
 #include "object-file.h"
 #include "odb.h"
 #include "tempfile.h"
+#include "date.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
@@ -149,6 +150,14 @@ static char *cached_accept_language;
 static char *http_ssl_backend;
 
 static int http_schannel_check_revoke = 1;
+
+/* Retry configuration */
+static long http_retry_after = -1; /* Default retry-after in seconds when header is missing (-1 means not set, exit with 128) */
+static long http_max_retries = 0; /* Maximum number of retry attempts (0 means retries are disabled) */
+static long http_max_retry_time = 300; /* Maximum time to wait for a single retry (default 5 minutes) */
+
+/* Store retry_after value from 429 responses for retry logic (-1 = not set, 0 = retry immediately, >0 = delay in seconds) */
+static long last_retry_after = -1;
 /*
  * With the backend being set to `schannel`, setting sslCAinfo would override
  * the Certificate Store in cURL v7.60.0 and later, which is not what we want
@@ -209,13 +218,14 @@ static inline int is_hdr_continuation(const char *ptr, const size_t size)
 	return size && (*ptr == ' ' || *ptr == '\t');
 }
 
-static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UNUSED)
+static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
 {
 	size_t size = eltsize * nmemb;
 	struct strvec *values = &http_auth.wwwauth_headers;
 	struct strbuf buf = STRBUF_INIT;
 	const char *val;
 	size_t val_len;
+	struct active_request_slot *slot = (struct active_request_slot *)p;
 
 	/*
 	 * Header lines may not come NULL-terminated from libcurl so we must
@@ -257,6 +267,47 @@ static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UN
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
@@ -575,6 +626,21 @@ static int http_options(const char *var, const char *value,
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
@@ -1422,6 +1488,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	set_long_from_env(&curl_tcp_keepintvl, "GIT_TCP_KEEPINTVL");
 	set_long_from_env(&curl_tcp_keepcnt, "GIT_TCP_KEEPCNT");
 
+	set_long_from_env(&http_retry_after, "GIT_HTTP_RETRY_AFTER");
+	set_long_from_env(&http_max_retries, "GIT_HTTP_MAX_RETRIES");
+	set_long_from_env(&http_max_retry_time, "GIT_HTTP_MAX_RETRY_TIME");
+
 	curl_default = get_curl_handle();
 }
 
@@ -1871,6 +1941,10 @@ static int handle_curl_result(struct slot_results *results)
 			}
 			return HTTP_REAUTH;
 		}
+	} else if (results->http_code == 429) {
+		/* Store the retry_after value for use in retry logic */
+		last_retry_after = results->retry_after;
+		return HTTP_RATE_LIMITED;
 	} else {
 		if (results->http_connectcode == 407)
 			credential_reject(the_repository, &proxy_auth);
@@ -1886,6 +1960,8 @@ int run_one_slot(struct active_request_slot *slot,
 		 struct slot_results *results)
 {
 	slot->results = results;
+	/* Initialize retry_after to -1 (not set) */
+	results->retry_after = -1;
 	if (!start_active_slot(slot)) {
 		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
 			  "failed to start HTTP request");
@@ -2149,6 +2225,7 @@ static int http_request(const char *url,
 	}
 
 	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, slot);
 
 	accept_language = http_get_accept_language_header();
 
@@ -2253,19 +2330,36 @@ static int update_url_from_redirect(struct strbuf *base,
 	return 1;
 }
 
+/*
+ * Sleep for the specified number of seconds before retrying.
+ */
+static void sleep_for_retry(long retry_after)
+{
+	if (retry_after > 0) {
+		unsigned int remaining;
+		warning(_("rate limited, waiting %ld seconds before retry"), retry_after);
+		remaining = sleep(retry_after);
+		while (remaining > 0) {
+			/* Sleep was interrupted, continue sleeping */
+			remaining = sleep(remaining);
+		}
+	}
+}
+
 static int http_request_reauth(const char *url,
 			       void *result, int target,
 			       struct http_get_options *options)
 {
 	int i = 3;
 	int ret;
+	int rate_limit_retries = http_max_retries;
 
 	if (always_auth_proactively())
 		credential_fill(the_repository, &http_auth, 1);
 
 	ret = http_request(url, result, target, options);
 
-	if (ret != HTTP_OK && ret != HTTP_REAUTH)
+	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_RATE_LIMITED)
 		return ret;
 
 	if (options && options->effective_url && options->base_url) {
@@ -2276,7 +2370,7 @@ static int http_request_reauth(const char *url,
 		}
 	}
 
-	while (ret == HTTP_REAUTH && --i) {
+	while ((ret == HTTP_REAUTH || ret == HTTP_RATE_LIMITED) && --i) {
 		/*
 		 * The previous request may have put cruft into our output stream; we
 		 * should clear it out before making our next request.
@@ -2302,7 +2396,54 @@ static int http_request_reauth(const char *url,
 			BUG("Unknown http_request target");
 		}
 
-		credential_fill(the_repository, &http_auth, 1);
+		if (ret == HTTP_RATE_LIMITED) {
+			/* Handle rate limiting with retry logic */
+			int retry_attempt = http_max_retries - rate_limit_retries + 1;
+
+			if (rate_limit_retries <= 0) {
+				/* Retries are disabled or exhausted */
+				if (http_max_retries > 0) {
+					error(_("too many rate limit retries, giving up"));
+				}
+				return HTTP_ERROR;
+			}
+
+			/* Decrement retries counter */
+			rate_limit_retries--;
+
+			/* Use the stored retry_after value or configured default */
+			if (last_retry_after >= 0) {
+				/* Check if retry delay exceeds maximum allowed */
+				if (last_retry_after > http_max_retry_time) {
+					error(_("rate limited (HTTP 429) requested %ld second delay, "
+						"exceeds http.maxRetryTime of %ld seconds"),
+					      last_retry_after, http_max_retry_time);
+					last_retry_after = -1; /* Reset after use */
+					return HTTP_ERROR;
+				}
+				sleep_for_retry(last_retry_after);
+				last_retry_after = -1; /* Reset after use */
+			} else {
+				/* No Retry-After header provided */
+				if (http_retry_after < 0) {
+					/* Not configured - exit with error */
+					error(_("rate limited (HTTP 429) and no Retry-After header provided. "
+						"Configure http.retryAfter or set GIT_HTTP_RETRY_AFTER."));
+					return HTTP_ERROR;
+				}
+				/* Check if configured default exceeds maximum allowed */
+				if (http_retry_after > http_max_retry_time) {
+					error(_("configured http.retryAfter (%ld seconds) exceeds "
+						"http.maxRetryTime (%ld seconds)"),
+					      http_retry_after, http_max_retry_time);
+					return HTTP_ERROR;
+				}
+				/* Use configured default retry-after value */
+				sleep_for_retry(http_retry_after);
+			}
+		} else if (ret == HTTP_REAUTH) {
+			credential_fill(the_repository, &http_auth, 1);
+		}
 
 		ret = http_request(url, result, target, options);
 	}
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
index 69f919454a..5959461cd3 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -529,6 +529,10 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		show_http_message(&type, &charset, &buffer);
 		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
 		    transport_anonymize_url(url.buf), curl_errorstr);
+	case HTTP_RATE_LIMITED:
+		show_http_message(&type, &charset, &buffer);
+		die(_("rate limited by '%s', please try again later"),
+		    transport_anonymize_url(url.buf));
 	default:
 		show_http_message(&type, &charset, &buffer);
 		die(_("unable to access '%s': %s"),
diff --git a/t/meson.build b/t/meson.build
index dc43d69636..98bd6949e6 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -698,6 +698,7 @@ integration_tests = [
   't5581-http-curl-verbose.sh',
   't5582-fetch-negative-refspec.sh',
   't5583-push-branches.sh',
+  't5584-http-429-retry.sh',
   't5600-clone-fail-cleanup.sh',
   't5601-clone.sh',
   't5602-clone-remote-exec.sh',
diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
new file mode 100755
index 0000000000..8bcc382763
--- /dev/null
+++ b/t/t5584-http-429-retry.sh
@@ -0,0 +1,429 @@
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
+test_expect_success 'HTTP 429 with retries disabled (maxRetries=0) fails immediately' '
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Retry-After: 1\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited\n"
+	cat "$1" >/dev/null
+	EOF
+
+	# Set maxRetries to 0 (disabled)
+	test_config http.maxRetries 0 &&
+	test_config http.retryAfter 1 &&
+
+	# Should fail immediately without any retry attempt
+	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
+
+	# Verify no retry happened (no "waiting" message in stderr)
+	! grep -i "waiting.*retry" err &&
+
+	# The one-time script will be consumed on first request (not a retry)
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
+'
+
+test_expect_success 'HTTP 429 permanent should fail after max retries' '
+	# Install a permanent error script to prove retries are limited
+	write_script "$HTTPD_ROOT_PATH/http-429-permanent.sh" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Retry-After: 1\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Permanently rate limited\n"
+	EOF
+
+	# Enable retries with a limit
+	test_config http.maxRetries 2 &&
+
+	# Git should retry but eventually fail when 429 persists
+	test_must_fail git ls-remote "$HTTPD_URL/error/http-429-permanent.sh/repo.git" 2>err
+'
+
+test_expect_success 'HTTP 429 with Retry-After is retried and succeeds' '
+	# Create a one-time script that returns 429 with Retry-After header
+	# on the first request. Subsequent requests will succeed.
+	# This contrasts with the permanent 429 above - proving retry works
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	# Return HTTP 429 response instead of git response
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Retry-After: 1\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited - please retry after 1 second\n"
+	# Output something different from input so the script gets removed
+	cat "$1" >/dev/null
+	EOF
+
+	# Enable retries
+	test_config http.maxRetries 3 &&
+
+	# Git should retry after receiving 429 and eventually succeed
+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+
+	# The one-time script should have been consumed (proving retry happened)
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
+'
+
+test_expect_success 'HTTP 429 without Retry-After uses configured default' '
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited - no retry info\n"
+	cat "$1" >/dev/null
+	EOF
+
+	# Enable retries and configure default delay
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+
+	# Git should retry using configured default and succeed
+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
+'
+
+test_expect_success 'HTTP 429 retry delays are respected' '
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Retry-After: 2\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited\n"
+	cat "$1" >/dev/null
+	EOF
+
+	# Enable retries
+	test_config http.maxRetries 3 &&
+
+	# Time the operation - it should take at least 2 seconds due to retry delay
+	start=$(date +%s) &&
+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Verify it took at least 2 seconds (allowing some tolerance)
+	test "$duration" -ge 1 &&
+	test_grep "refs/heads/" output &&
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
+'
+
+test_expect_success 'HTTP 429 fails immediately if Retry-After exceeds http.maxRetryTime' '
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Retry-After: 100\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited with long delay\n"
+	cat "$1" >/dev/null
+	EOF
+
+	# Configure max retry time to 3 seconds (much less than requested 100)
+	test_config http.maxRetries 3 &&
+	test_config http.maxRetryTime 3 &&
+
+	# Should fail immediately without waiting
+	start=$(date +%s) &&
+	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should fail quickly (less than 2 seconds, no 100 second wait)
+	test "$duration" -lt 2 &&
+	test_grep "exceeds http.maxRetryTime" err &&
+
+	# The one-time script will be consumed on first request
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
+'
+
+test_expect_success 'HTTP 429 fails if configured http.retryAfter exceeds http.maxRetryTime' '
+	# Test misconfiguration: retryAfter > maxRetryTime
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited without header\n"
+	cat "$1" >/dev/null
+	EOF
+
+	# Configure retryAfter larger than maxRetryTime
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 100 &&
+	test_config http.maxRetryTime 5 &&
+
+	# Should fail immediately with configuration error
+	start=$(date +%s) &&
+	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
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
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF &&
+	printf "Status: 429 Too Many Requests\\r\\n"
+	printf "Retry-After: $future_date\\r\\n"
+	printf "Content-Type: text/plain\\r\\n"
+	printf "\\r\\n"
+	printf "Rate limited with HTTP-date\\n"
+	cat "\$1" >/dev/null
+	EOF
+
+	# Enable retries
+	test_config http.maxRetries 3 &&
+
+	# Git should parse the HTTP-date and retry after the delay
+	start=$(date +%s) &&
+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should take at least 1 second (allowing tolerance for processing time)
+	test "$duration" -ge 1 &&
+	test_grep "refs/heads/" output &&
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
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
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF &&
+	printf "Status: 429 Too Many Requests\\r\\n"
+	printf "Retry-After: $future_date\\r\\n"
+	printf "Content-Type: text/plain\\r\\n"
+	printf "\\r\\n"
+	printf "Rate limited with long HTTP-date\\n"
+	cat "\$1" >/dev/null
+	EOF
+
+	# Configure max retry time much less than the 200 second delay
+	test_config http.maxRetries 3 &&
+	test_config http.maxRetryTime 10 &&
+
+	# Should fail immediately without waiting 200 seconds
+	start=$(date +%s) &&
+	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should fail quickly (not wait 200 seconds)
+	test "$duration" -lt 2 &&
+	test_grep "exceeds http.maxRetryTime" err &&
+
+	# The one-time script will be consumed on first request
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
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
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF &&
+	printf "Status: 429 Too Many Requests\\r\\n"
+	printf "Retry-After: $past_date\\r\\n"
+	printf "Content-Type: text/plain\\r\\n"
+	printf "\\r\\n"
+	printf "Rate limited with past date\\n"
+	cat "\$1" >/dev/null
+	EOF
+
+	# Enable retries
+	test_config http.maxRetries 3 &&
+
+	# Git should retry immediately without waiting
+	start=$(date +%s) &&
+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should complete quickly (less than 2 seconds)
+	test "$duration" -lt 2 &&
+	test_grep "refs/heads/" output &&
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
+'
+
+test_expect_success 'HTTP 429 with invalid Retry-After format uses configured default' '
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Retry-After: invalid-format-123abc\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited with malformed header\n"
+	cat "$1" >/dev/null
+	EOF
+
+	# Configure default retry-after
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+
+	# Should use configured default (1 second) since header is invalid
+	start=$(date +%s) &&
+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should take at least 1 second (the configured default)
+	test "$duration" -ge 1 &&
+	test_grep "refs/heads/" output &&
+	test_grep "waiting.*retry" err &&
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
+'
+
+test_expect_success 'HTTP 429 will not be retried without config' '
+	# Default config means http.maxRetries=0 (retries disabled)
+	# When 429 is received, it should fail immediately without retry
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Retry-After: 1\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited\n"
+	cat "$1" >/dev/null
+	EOF
+
+	# Do NOT configure anything - use defaults (http.maxRetries defaults to 0)
+
+	# Should fail immediately without retry
+	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
+
+	# Verify no retry happened (no "waiting" message)
+	! grep -i "waiting.*retry" err &&
+
+	# Should get 429 error
+	test_grep "429" err &&
+
+	# The one-time script should be consumed on first request
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
+'
+
+test_expect_success 'GIT_HTTP_RETRY_AFTER overrides http.retryAfter config' '
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited - no Retry-After header\n"
+	cat "$1" >/dev/null
+	EOF
+
+	# Configure retryAfter to 10 seconds
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 10 &&
+
+	# Override with environment variable to 1 second
+	start=$(date +%s) &&
+	GIT_HTTP_RETRY_AFTER=1 git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should use env var (1 second), not config (10 seconds)
+	test "$duration" -ge 1 &&
+	test "$duration" -lt 5 &&
+	test_grep "refs/heads/" output &&
+	test_grep "waiting.*retry" err &&
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
+'
+
+test_expect_success 'GIT_HTTP_MAX_RETRIES overrides http.maxRetries config' '
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Retry-After: 1\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited\n"
+	cat "$1" >/dev/null
+	EOF
+
+	# Configure maxRetries to 0 (disabled)
+	test_config http.maxRetries 0 &&
+	test_config http.retryAfter 1 &&
+
+	# Override with environment variable to enable retries
+	GIT_HTTP_MAX_RETRIES=3 git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
+
+	# Should retry (env var enables it despite config saying disabled)
+	test_grep "refs/heads/" output &&
+	test_grep "waiting.*retry" err &&
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
+'
+
+test_expect_success 'GIT_HTTP_MAX_RETRY_TIME overrides http.maxRetryTime config' '
+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
+	printf "Status: 429 Too Many Requests\r\n"
+	printf "Retry-After: 50\r\n"
+	printf "Content-Type: text/plain\r\n"
+	printf "\r\n"
+	printf "Rate limited with long delay\n"
+	cat "$1" >/dev/null
+	EOF
+
+	# Configure maxRetryTime to 100 seconds (would accept 50 second delay)
+	test_config http.maxRetries 3 &&
+	test_config http.maxRetryTime 100 &&
+
+	# Override with environment variable to 10 seconds (should reject 50 second delay)
+	start=$(date +%s) &&
+	test_must_fail env GIT_HTTP_MAX_RETRY_TIME=10 \
+		git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
+	end=$(date +%s) &&
+	duration=$((end - start)) &&
+
+	# Should fail quickly (not wait 50 seconds) because env var limits to 10
+	test "$duration" -lt 5 &&
+	test_grep "exceeds http.maxRetryTime" err &&
+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
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

