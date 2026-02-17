Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A02E4274
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326527; cv=none; b=S3biXCyWbgb63bJkzL+PHoLP9/m6PIVl4XkIWjGUSd/gqYA6FLB9YKbpDfSOqmTXP4h24BJtKYCGqY9WNOIuxyznQzC2v2nii6u0XK/7RraIQP2vcpVwSuWC+mob2oq0j/Jf5m6fMoz367ZxaSvzCCAFGpyjSzbLaUY/4Py0Vjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326527; c=relaxed/simple;
	bh=84yTH3k2jdC0BWTy6JUmjv66lKwZ7DFIe/13FwlwXf8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BIDhS8nP5Z0reAM5hX8r3PTKHqwejTsUSINQW1L5p8OzDagF4sxGEDJ3Ty2+osBuD1HprSWaV0qRwIdkBQebKEIer+ynyCjKaxNsX7+ncN5mFSIYyMKusKw0rb1AlLn+O1XH+iS4L/IncVGn5QonFUpaoB2LOXnH8Mn5g3a0Cfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmC4CdwZ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmC4CdwZ"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c7199e7f79so524724385a.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771326523; x=1771931323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U34jnzhOHfctBoTwFVX0MxQp+3zo6i+3U50BOqe53g=;
        b=BmC4CdwZ+aSzjapEpcSUrI1fvJSzPlKorjOSTzMz27lMkpj2RFiQPak+vUaEEzGlFF
         NEb8cpr/kPSnbp+Ba3LwcllyKjiugZGobQxda9/10knnnM4m3kbSgfJsrY/sVdxSpl0w
         OveYHTqVkRjjgEiX5K2aLRdKSMb6b+UJ5m7a4HYXcWCGEQ8cBz+T0qk0Vqk+tgTIAy1j
         n2/oytMcFOrn5fT9TneNOun4FCO3M2sz9eq+78YprZ9unTfDX8m3QX17ySRXOJYzIvEE
         POlRaCtXGsyCyGGBCyWBchvoyEq5XCSy2A0UDtAhc92boUV/UaJDRgxsoCTfZzo+GO3x
         GphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771326523; x=1771931323;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6U34jnzhOHfctBoTwFVX0MxQp+3zo6i+3U50BOqe53g=;
        b=iZHAmf/9w9TMWfL+6YBw27eqenDuKqnN6WOKM/1WfniTi7hbtETFbFZGpiS3z+doxr
         vGfno7N/eE8pbGqwYHCEurXiNPT3mUJv/nFIL9DxIiCM+47VcNEf6zDseUJEjbczZrzS
         xWwYrVqAqehkZ8Gx+5R+V++vzzKzrepuEWsA9IzWhGJGHzliXgS+es0Ff2Auw5fq/XOn
         qMAnWe518NXpAfqfHeRnqjTWXaR8fbvasvRRq+4uI2XWUqwO8ja+M9VennAdEWKSSIs9
         MWfGSFhmHSrIUH1zQMWKgha/NGIv+iPdb+vDaAjJK7W1VKIshDtV5JSAyzCxS2OH0yeK
         IK2A==
X-Gm-Message-State: AOJu0YwvhgFqOgVPvo1oS12EUQ/J6vZFli9dMVmSRqXlEPg2S7kNLiax
	PBfDFfXeQJNSHpOLHGPyAyvGdUCfNp7b4ShIkJm0O7oN9jJkCWWBnV/r33xmxw==
X-Gm-Gg: AZuq6aKRiXqBSU2nbOwZiXAJrJxKEqHYcCsV/8gu9IDwg/CBI0CKBOC9CHdHYEiL0A1
	bLstHUiaz4xEs8UQ3vH01iE8VxVqSaI+vvjkSCadPiSpnAE+FoaF6DPQpmZexPjzVprOLb8kbn/
	nvAynsFXwMKOrsPporGVRTfas3rl64QYMHa0ERD/QUWJ49AqhHDQAqzkiKRw5V2MjFmHTscZObV
	ISDdKXdj+waPaLtRwPgUNeWPItV+cv3QhRyEsd9ae+DM2K5P18kzmSVbtqWBjQ7KIKAgEadFbIf
	FeE8n5pvNuusSzfiI38m0s5EGAtY9AbwXWAyKfHu+ybU3CGGCnDlaN/pxzSXaZyyNbZm8ouBcsi
	/Zemjk3s7ffoTxvmRtrAyL2eb8XmemlKZaLhpbzvc9yQUKpFn6okKCLWc15Cle5hpzkZbOoyZWz
	IMYMwLxNC9grrLS56Z4bU5BzFkRNwRaN271W3v
X-Received: by 2002:a05:620a:4494:b0:8c7:1952:789f with SMTP id af79cd13be357-8cb4c007c10mr1194940185a.71.1771326522798;
        Tue, 17 Feb 2026 03:08:42 -0800 (PST)
Received: from [127.0.0.1] ([64.236.160.198])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb41214801sm1084709485a.45.2026.02.17.03.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:08:41 -0800 (PST)
Message-Id: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
References: <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Feb 2026 11:08:37 +0000
Subject: [PATCH v3 0/3] http: add support for HTTP 429 rate limit retries
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
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Changes since v2:

 * New preparatory patch: Introduced show_http_message_fatal() helper
   function to reduce code duplication in remote-curl.c (suggested by Taylor
   Blau)

 * Removed specific HTTP_RATE_LIMITED error handling from http-push.c and
   http-walker.c for the obsolete "dumb" protocol, allowing generic error
   handling to take over (suggested by Jeff King)

 * Added support for CURLINFO_RETRY_AFTER on curl >= 7.66.0, falling back to
   manual header parsing on older versions

 * Simplified retry/delay architecture: replaced complex non-blocking
   "delayed slot" mechanism with simple blocking sleep() call in the retry
   loop, removing ~66 lines of timing logic (suggested by Jeff King)

 * Fixed Retry-After: 0 handling to allow immediate retry as specified by
   RFC 9110

 * Changed http.retryAfter default from -1 to 0, so Git will retry
   immediately when encountering HTTP 429 without a Retry-After header,
   rather than failing with a configuration error

 * Improved error messages: shortened to be more concise

 * Fixed coding style issues: removed unnecessary curly braces, changed x ==
   0 to !x (per CodingGuidelines)

 * Improved test portability: replaced non-portable date(1) commands with
   test-tool date, added nanosecond-precision timing with getnanos, replaced
   cut(1) with POSIX shell parameter expansion

 * Split out strbuf.c bugfix into separate preparatory patch (the
   strbuf_reencode alloc size fix is unrelated to HTTP 429 support)

 * Squashed separate trace2 logging patch into main HTTP 429 retry support
   commit

 * Kept header_is_last_match assignment for Retry-After to prevent incorrect
   handling of HTTP header continuation lines

The implementation includes:

 1. A bug fix in strbuf_reencode() that corrects the allocation size passed
    to strbuf_attach(), ensuring proper memory management.

 2. A refactoring in remote-curl.c that introduces a
    show_http_message_fatal() helper to reduce code duplication when
    handling fatal HTTP errors.

 3. The main feature: HTTP 429 retry logic with support for the Retry-After
    header (both delay-seconds and HTTP-date formats), configurable via
    http.maxRetries, http.retryAfter, and http.maxRetryTime options.

Vaidas Pilkauskas (3):
  strbuf: fix incorrect alloc size in strbuf_reencode()
  remote-curl: introduce show_http_message_fatal() helper
  http: add support for HTTP 429 rate limit retries

 Documentation/config/http.adoc |  23 +++
 git-curl-compat.h              |   8 +
 http.c                         | 190 +++++++++++++++++++++--
 http.h                         |   2 +
 remote-curl.c                  |  49 +++---
 strbuf.c                       |   2 +-
 t/lib-httpd.sh                 |   1 +
 t/lib-httpd/apache.conf        |   8 +
 t/lib-httpd/http-429.sh        |  98 ++++++++++++
 t/meson.build                  |   1 +
 t/t5584-http-429-retry.sh      | 266 +++++++++++++++++++++++++++++++++
 11 files changed, 618 insertions(+), 30 deletions(-)
 create mode 100644 t/lib-httpd/http-429.sh
 create mode 100755 t/t5584-http-429-retry.sh


base-commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2008%2Fvaidas-shopify%2Fretry-after-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2008/vaidas-shopify/retry-after-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2008

Range-diff vs v2:

 -:  ---------- > 1:  821043c664 strbuf: fix incorrect alloc size in strbuf_reencode()
 -:  ---------- > 2:  3653067f0e remote-curl: introduce show_http_message_fatal() helper
 1:  d80ce07703 ! 3:  3cece62a63 http: add support for HTTP 429 rate limit retries
     @@ Documentation/config/http.adoc: http.keepAliveCount::
       
      +http.retryAfter::
      +	Default wait time in seconds before retrying when a server returns
     -+	HTTP 429 (Too Many Requests) without a Retry-After header. If set
     -+	to -1 (the default), Git will fail immediately when encountering
     -+	a 429 response without a Retry-After header. When a Retry-After
     -+	header is present, its value takes precedence over this setting.
     -+	Can be overridden by the `GIT_HTTP_RETRY_AFTER` environment variable.
     ++	HTTP 429 (Too Many Requests) without a Retry-After header.
     ++	Defaults to 0 (retry immediately). When a Retry-After header is
     ++	present, its value takes precedence over this setting. Can be
     ++	overridden by the `GIT_HTTP_RETRY_AFTER` environment variable.
      +	See also `http.maxRetries` and `http.maxRetryTime`.
      +
      +http.maxRetries::
     @@ Documentation/config/http.adoc: http.keepAliveCount::
       	A boolean which disables using of EPSV ftp command by curl.
       	This can be helpful with some "poor" ftp servers which don't
      
     - ## http-push.c ##
     -@@ http-push.c: static int fetch_indices(void)
     - 	case HTTP_MISSING_TARGET:
     - 		ret = 0;
     - 		break;
     -+	case HTTP_RATE_LIMITED:
     -+		error(_("rate limited by '%s', please try again later"), repo->url);
     -+		ret = -1;
     -+		break;
     - 	default:
     - 		ret = -1;
     - 	}
     -@@ http-push.c: static int remote_exists(const char *path)
     - 	case HTTP_MISSING_TARGET:
     - 		ret = 0;
     - 		break;
     -+	case HTTP_RATE_LIMITED:
     -+		error(_("rate limited by '%s', please try again later"), url);
     -+		ret = -1;
     -+		break;
     - 	case HTTP_ERROR:
     - 		error("unable to access '%s': %s", url, curl_errorstr);
     - 		/* fallthrough */
     -
     - ## http-walker.c ##
     -@@ http-walker.c: static int fetch_indices(struct walker *walker, struct alt_base *repo)
     - 		repo->got_indices = 1;
     - 		ret = 0;
     - 		break;
     -+	case HTTP_RATE_LIMITED:
     -+		error("rate limited by '%s', please try again later", repo->base);
     -+		repo->got_indices = 0;
     -+		ret = -1;
     -+		break;
     - 	default:
     - 		repo->got_indices = 0;
     - 		ret = -1;
     + ## git-curl-compat.h ##
     +@@
     + #define GIT_CURL_NEED_TRANSFER_ENCODING_HEADER
     + #endif
     + 
     ++/**
     ++ * CURLINFO_RETRY_AFTER was added in 7.66.0, released in September 2019.
     ++ * It allows curl to automatically parse Retry-After headers.
     ++ */
     ++#if LIBCURL_VERSION_NUM >= 0x074200
     ++#define GIT_CURL_HAVE_CURLINFO_RETRY_AFTER 1
     ++#endif
     ++
     + /**
     +  * CURLOPT_PROTOCOLS_STR and CURLOPT_REDIR_PROTOCOLS_STR were added in 7.85.0,
     +  * released in August 2022.
      
       ## http.c ##
      @@
     @@ http.c
       #include "odb.h"
       #include "tempfile.h"
      +#include "date.h"
     ++#include "trace2.h"
       
       static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
       static int trace_curl_data = 1;
     @@ http.c: static char *cached_accept_language;
       
       static int http_schannel_check_revoke = 1;
      +
     -+static long http_retry_after = -1;
     ++static long http_retry_after = 0;
      +static long http_max_retries = 0;
      +static long http_max_retry_time = 300;
      +
     @@ http.c: static inline int is_hdr_continuation(const char *ptr, const size_t size
       }
       
      -static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UNUSED)
     -+static size_t fwrite_headers(char *ptr, size_t eltsize, size_t nmemb, void *p)
     ++static size_t fwrite_headers(char *ptr, size_t eltsize, size_t nmemb, void *p MAYBE_UNUSED)
       {
       	size_t size = eltsize * nmemb;
       	struct strvec *values = &http_auth.wwwauth_headers;
     - 	struct strbuf buf = STRBUF_INIT;
     - 	const char *val;
     - 	size_t val_len;
     -+	struct active_request_slot *slot = (struct active_request_slot *)p;
     - 
     - 	/*
     - 	 * Header lines may not come NULL-terminated from libcurl so we must
      @@ http.c: static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UN
       		goto exit;
       	}
       
     -+	/* Parse Retry-After header for rate limiting */
     ++#ifndef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
     ++	/* Parse Retry-After header for rate limiting (for curl < 7.66.0) */
      +	if (skip_iprefix_mem(ptr, size, "retry-after:", &val, &val_len)) {
     ++		struct active_request_slot *slot = (struct active_request_slot *)p;
     ++
      +		strbuf_add(&buf, val, val_len);
      +		strbuf_trim(&buf);
      +
     @@ http.c: static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, vo
      +			errno = 0;
      +			retry_after = strtol(buf.buf, &endptr, 10);
      +
     -+			/* Check if it's a valid integer (delay-seconds format) */
     -+			if (endptr != buf.buf && *endptr == '\0' &&
     -+			    errno != ERANGE && retry_after > 0) {
     -+				slot->results->retry_after = retry_after;
     -+			} else {
     ++		/* Check if it's a valid integer (delay-seconds format) */
     ++		if (endptr != buf.buf && *endptr == '\0' &&
     ++		    errno != ERANGE && retry_after >= 0) {
     ++			slot->results->retry_after = retry_after;
     ++		} else {
      +				/* Try parsing as HTTP-date format */
      +				timestamp_t timestamp;
      +				int offset;
     @@ http.c: static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, vo
      +			}
      +		}
      +
     -+		http_auth.header_is_last_match = 1;
      +		goto exit;
      +	}
     ++#endif
      +
       	/*
       	 * This line could be a continuation of the previously matched header
       	 * field. If this is the case then we should append this value to the
     +@@ http.c: static void finish_active_slot(struct active_request_slot *slot)
     + 
     + 		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
     + 			&slot->results->http_connectcode);
     ++
     ++#ifdef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
     ++		if (slot->results->http_code == 429) {
     ++			curl_off_t retry_after;
     ++			CURLcode res = curl_easy_getinfo(slot->curl,
     ++							  CURLINFO_RETRY_AFTER,
     ++							  &retry_after);
     ++			if (res == CURLE_OK && retry_after > 0)
     ++				slot->results->retry_after = (long)retry_after;
     ++		}
     ++#endif
     + 	}
     + 
     + 	/* Run callback if appropriate */
      @@ http.c: static int http_options(const char *var, const char *value,
       		return 0;
       	}
     @@ http.c: void http_init(struct remote *remote, const char *url, int proactive_aut
       	curl_default = get_curl_handle();
       }
       
     -@@ http.c: struct active_request_slot *get_active_slot(void)
     - 	slot->finished = NULL;
     - 	slot->callback_data = NULL;
     - 	slot->callback_func = NULL;
     -+	slot->retry_delay_seconds = -1;
     -+	memset(&slot->retry_delay_start, 0, sizeof(slot->retry_delay_start));
     - 
     - 	if (curl_cookie_file && !strcmp(curl_cookie_file, "-")) {
     - 		warning(_("refusing to read cookies from http.cookiefile '-'"));
     -@@ http.c: void run_active_slot(struct active_request_slot *slot)
     - 	fd_set excfds;
     - 	int max_fd;
     - 	struct timeval select_timeout;
     -+	long curl_timeout;
     -+	struct timeval start_time = {0}, current_time, elapsed_time = {0};
     -+	long remaining_seconds;
     - 	int finished = 0;
     -+	int slot_not_started = (slot->finished == NULL);
     -+	int waiting_for_delay = (slot->retry_delay_seconds > 0);
     -+
     -+	if (waiting_for_delay) {
     -+		warning(_("rate limited, waiting %ld seconds before retry"), slot->retry_delay_seconds);
     -+		start_time = slot->retry_delay_start;
     -+	}
     - 
     - 	slot->finished = &finished;
     --	while (!finished) {
     -+	while (waiting_for_delay || !finished) {
     -+		if (waiting_for_delay) {
     -+			gettimeofday(&current_time, NULL);
     -+			elapsed_time.tv_sec = current_time.tv_sec - start_time.tv_sec;
     -+			elapsed_time.tv_usec = current_time.tv_usec - start_time.tv_usec;
     -+			if (elapsed_time.tv_usec < 0) {
     -+				elapsed_time.tv_sec--;
     -+				elapsed_time.tv_usec += 1000000;
     -+			}
     -+
     -+			if (elapsed_time.tv_sec >= slot->retry_delay_seconds) {
     -+				slot->retry_delay_seconds = -1;
     -+				waiting_for_delay = 0;
     -+
     -+				if (slot_not_started)
     -+					return;
     -+			}
     -+		}
     -+
     - 		step_active_slots();
     - 
     --		if (slot->in_use) {
     --			long curl_timeout;
     --			curl_multi_timeout(curlm, &curl_timeout);
     --			if (curl_timeout == 0) {
     -+		if (!waiting_for_delay && !slot->in_use)
     -+			continue;
     -+
     -+		curl_multi_timeout(curlm, &curl_timeout);
     -+		if (curl_timeout == 0) {
     -+			if (!waiting_for_delay)
     - 				continue;
     --			} else if (curl_timeout == -1) {
     --				select_timeout.tv_sec  = 0;
     --				select_timeout.tv_usec = 50000;
     -+			select_timeout.tv_sec = 0;
     -+			select_timeout.tv_usec = 50000; /* 50ms */
     -+		} else if (curl_timeout == -1) {
     -+			select_timeout.tv_sec = 0;
     -+			select_timeout.tv_usec = 50000;
     -+		} else {
     -+			long curl_timeout_sec = curl_timeout / 1000;
     -+			long curl_timeout_usec = (curl_timeout % 1000) * 1000;
     -+
     -+			if (waiting_for_delay) {
     -+				remaining_seconds = slot->retry_delay_seconds - elapsed_time.tv_sec;
     -+				if (curl_timeout_sec < remaining_seconds) {
     -+					select_timeout.tv_sec = curl_timeout_sec;
     -+					select_timeout.tv_usec = curl_timeout_usec;
     -+				} else {
     -+					select_timeout.tv_sec = remaining_seconds;
     -+					select_timeout.tv_usec = 0;
     -+				}
     - 			} else {
     --				select_timeout.tv_sec  =  curl_timeout / 1000;
     --				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
     -+				select_timeout.tv_sec = curl_timeout_sec;
     -+				select_timeout.tv_usec = curl_timeout_usec;
     - 			}
     -+		}
     - 
     --			max_fd = -1;
     --			FD_ZERO(&readfds);
     --			FD_ZERO(&writefds);
     --			FD_ZERO(&excfds);
     --			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
     -+		max_fd = -1;
     -+		FD_ZERO(&readfds);
     -+		FD_ZERO(&writefds);
     -+		FD_ZERO(&excfds);
     -+		curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
     - 
     --			/*
     --			 * It can happen that curl_multi_timeout returns a pathologically
     --			 * long timeout when curl_multi_fdset returns no file descriptors
     --			 * to read.  See commit message for more details.
     --			 */
     --			if (max_fd < 0 &&
     --			    (select_timeout.tv_sec > 0 ||
     --			     select_timeout.tv_usec > 50000)) {
     --				select_timeout.tv_sec  = 0;
     --				select_timeout.tv_usec = 50000;
     --			}
     -+		/*
     -+		 * It can happen that curl_multi_timeout returns a pathologically
     -+		 * long timeout when curl_multi_fdset returns no file descriptors
     -+		 * to read.  See commit message for more details.
     -+		 */
     -+		if (max_fd < 0 &&
     -+		    (select_timeout.tv_sec > 0 ||
     -+		     select_timeout.tv_usec > 50000)) {
     -+			select_timeout.tv_sec = 0;
     -+			select_timeout.tv_usec = 50000;
     -+		}
     - 
     --			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
     -+		/*
     -+		 * If curl_multi_fdset returns no file descriptors but we have
     -+		 * a timeout, still use select() to wait for the timeout period.
     -+		 */
     -+		if (max_fd < 0) {
     -+			/* No file descriptors, just wait for timeout */
     -+			select(0, NULL, NULL, NULL, &select_timeout);
     -+		} else {
     -+			select(max_fd + 1, &readfds, &writefds, &excfds, &select_timeout);
     - 		}
     - 	}
     - 
      @@ http.c: static int handle_curl_result(struct slot_results *results)
       			}
       			return HTTP_REAUTH;
       		}
      +	} else if (results->http_code == 429) {
     ++		trace2_data_intmax("http", the_repository, "http/429-retry-after",
     ++			results->retry_after);
      +		return HTTP_RATE_LIMITED;
       	} else {
       		if (results->http_connectcode == 407)
     @@ http.c: int run_one_slot(struct active_request_slot *slot,
       	slot->results = results;
      +	/* Initialize retry_after to -1 (not set) */
      +	results->retry_after = -1;
     -+
     -+	/* If there's a retry delay, wait for it before starting the slot */
     -+	if (slot->retry_delay_seconds > 0) {
     -+		run_active_slot(slot);
     -+	}
      +
       	if (!start_active_slot(slot)) {
       		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
       			  "failed to start HTTP request");
      @@ http.c: static void http_opt_request_remainder(CURL *curl, off_t pos)
     - #define HTTP_REQUEST_STRBUF	0
     - #define HTTP_REQUEST_FILE	1
       
     -+static void sleep_for_retry(struct active_request_slot *slot, long retry_after);
     -+
       static int http_request(const char *url,
       			void *result, int target,
      -			const struct http_get_options *options)
      +			const struct http_get_options *options,
     -+			long *retry_after_out,
     -+			long retry_delay)
     ++			long *retry_after_out)
       {
       	struct active_request_slot *slot;
       	struct slot_results results;
     -@@ http.c: static int http_request(const char *url,
     - 	int ret;
     - 
     - 	slot = get_active_slot();
     -+	/* Mark slot for delay if retry delay is provided */
     -+	if (retry_delay > 0) {
     -+		sleep_for_retry(slot, retry_delay);
     -+	}
     - 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
     - 
     - 	if (!result) {
      @@ http.c: static int http_request(const char *url,
       					 fwrite_buffer);
       	}
     @@ http.c: static int update_url_from_redirect(struct strbuf *base,
       
      -static int http_request_reauth(const char *url,
      +/*
     -+ * Mark slot to be delayed for retry. The actual delay will be handled
     -+ * in run_active_slot when the slot is executed.
     -+ */
     -+static void sleep_for_retry(struct active_request_slot *slot, long retry_after)
     -+{
     -+	if (retry_after > 0 && slot) {
     -+		warning(_("rate limited, waiting %ld seconds before retry"), retry_after);
     -+		slot->retry_delay_seconds = retry_after;
     -+		gettimeofday(&slot->retry_delay_start, NULL);
     -+	}
     -+}
     -+
     -+/*
      + * Handle rate limiting retry logic for HTTP 429 responses.
     -+ * Uses slot-specific retry_after value to support concurrent slots.
      + * Returns a negative value if retries are exhausted or configuration is invalid,
      + * otherwise returns the delay value (>= 0) to indicate the retry should proceed.
      + */
      +static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_after)
      +{
      +	int retry_attempt = http_max_retries - *rate_limit_retries + 1;
     ++
     ++	trace2_data_intmax("http", the_repository, "http/429-retry-attempt",
     ++		retry_attempt);
     ++
      +	if (*rate_limit_retries <= 0) {
      +		/* Retries are disabled or exhausted */
      +		if (http_max_retries > 0) {
      +			error(_("too many rate limit retries, giving up"));
     ++			trace2_data_string("http", the_repository,
     ++					   "http/429-error", "retries-exhausted");
      +		}
      +		return -1;
      +	}
      +
     -+	/* Decrement retries counter */
      +	(*rate_limit_retries)--;
      +
      +	/* Use the slot-specific retry_after value or configured default */
      +	if (slot_retry_after >= 0) {
      +		/* Check if retry delay exceeds maximum allowed */
      +		if (slot_retry_after > http_max_retry_time) {
     -+			error(_("rate limited (HTTP 429) requested %ld second delay, "
     -+				"exceeds http.maxRetryTime of %ld seconds"),
     ++			error(_("response requested a delay greater than http.maxRetryTime (%ld > %ld seconds)"),
      +			      slot_retry_after, http_max_retry_time);
     ++			trace2_data_string("http", the_repository,
     ++				  "http/429-error", "exceeds-max-retry-time");
     ++			trace2_data_intmax("http", the_repository,
     ++				  "http/429-requested-delay", slot_retry_after);
      +			return -1;
      +		}
      +		return slot_retry_after;
      +	} else {
     -+		/* No Retry-After header provided */
     -+		if (http_retry_after < 0) {
     -+			/* Not configured - exit with error */
     -+			error(_("rate limited (HTTP 429) and no Retry-After header provided. "
     -+				"Configure http.retryAfter or set GIT_HTTP_RETRY_AFTER."));
     -+			return -1;
     -+		}
     -+		/* Check if configured default exceeds maximum allowed */
     ++		/* No Retry-After header provided, use configured default */
      +		if (http_retry_after > http_max_retry_time) {
     -+			error(_("configured http.retryAfter (%ld seconds) exceeds "
     -+				"http.maxRetryTime (%ld seconds)"),
     ++			error(_("configured http.retryAfter exceeds http.maxRetryTime (%ld > %ld seconds)"),
      +			      http_retry_after, http_max_retry_time);
     ++			trace2_data_string("http", the_repository,
     ++					"http/429-error", "config-exceeds-max-retry-time");
      +			return -1;
      +		}
     -+
     ++		trace2_data_string("http", the_repository,
     ++			"http/429-retry-source", "config-default");
      +		return http_retry_after;
      +	}
      +}
     @@ http.c: static int update_url_from_redirect(struct strbuf *base,
       		credential_fill(the_repository, &http_auth, 1);
       
      -	ret = http_request(url, result, target, options);
     -+	ret = http_request(url, result, target, options, &slot_retry_after, -1);
     ++	ret = http_request(url, result, target, options, &slot_retry_after);
       
      -	if (ret != HTTP_OK && ret != HTTP_REAUTH)
      +	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_RATE_LIMITED)
       		return ret;
       
      +	/* If retries are disabled and we got a 429, fail immediately */
     -+	if (ret == HTTP_RATE_LIMITED && http_max_retries == 0)
     ++	if (ret == HTTP_RATE_LIMITED && !http_max_retries)
      +		return HTTP_ERROR;
      +
       	if (options && options->effective_url && options->base_url) {
     @@ http.c: static int http_request_reauth(const char *url,
      +			retry_delay = handle_rate_limit_retry(&rate_limit_retries, slot_retry_after);
      +			if (retry_delay < 0)
      +				return HTTP_ERROR;
     ++
     ++			if (retry_delay > 0) {
     ++				warning(_("rate limited, waiting %ld seconds before retry"), retry_delay);
     ++				trace2_data_intmax("http", the_repository,
     ++						   "http/retry-sleep-seconds", retry_delay);
     ++				sleep(retry_delay);
     ++			}
      +			slot_retry_after = -1; /* Reset after use */
      +		} else if (ret == HTTP_REAUTH) {
      +			credential_fill(the_repository, &http_auth, 1);
     @@ http.c: static int http_request_reauth(const char *url,
      -		credential_fill(the_repository, &http_auth, 1);
      -
      -		ret = http_request(url, result, target, options);
     -+		ret = http_request(url, result, target, options, &slot_retry_after, retry_delay);
     ++		ret = http_request(url, result, target, options, &slot_retry_after);
       	}
       	return ret;
       }
     @@ http.h: struct slot_results {
       };
       
       struct active_request_slot {
     -@@ http.h: struct active_request_slot {
     - 	void *callback_data;
     - 	void (*callback_func)(void *data);
     - 	struct active_request_slot *next;
     -+	long retry_delay_seconds;
     -+	struct timeval retry_delay_start;
     - };
     - 
     - struct buffer {
      @@ http.h: struct http_get_options {
       #define HTTP_REAUTH	4
       #define HTTP_NOAUTH	5
     @@ http.h: struct http_get_options {
        * Requests a URL and stores the result in a strbuf.
      
       ## remote-curl.c ##
     -@@ remote-curl.c: static void free_discovery(struct discovery *d)
     - 	}
     - }
     - 
     --static int show_http_message(struct strbuf *type, struct strbuf *charset,
     --			     struct strbuf *msg)
     -+static NORETURN void show_http_message_fatal(struct strbuf *type, struct strbuf *charset,
     -+				    struct strbuf *msg, const char *fmt, ...)
     - {
     - 	const char *p, *eol;
     -+	va_list ap;
     -+	report_fn die_message_routine = get_die_message_routine();
     - 
     - 	/*
     - 	 * We only show text/plain parts, as other types are likely
     - 	 * to be ugly to look at on the user's terminal.
     - 	 */
     - 	if (strcmp(type->buf, "text/plain"))
     --		return -1;
     -+		goto out;
     - 	if (charset->len)
     - 		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
     - 
     - 	strbuf_trim(msg);
     - 	if (!msg->len)
     --		return -1;
     -+		goto out;
     - 
     - 	p = msg->buf;
     - 	do {
     -@@ remote-curl.c: static int show_http_message(struct strbuf *type, struct strbuf *charset,
     - 		fprintf(stderr, "remote: %.*s\n", (int)(eol - p), p);
     - 		p = eol + 1;
     - 	} while(*eol);
     --	return 0;
     -+
     -+out:
     -+	strbuf_release(type);
     -+	strbuf_release(charset);
     -+	strbuf_release(msg);
     -+
     -+	va_start(ap, fmt);
     -+	die_message_routine(fmt, ap);
     -+	va_end(ap);
     -+	exit(128);
     - }
     - 
     - static int get_protocol_http_header(enum protocol_version version,
      @@ remote-curl.c: static struct discovery *discover_refs(const char *service, int for_push)
     - 	case HTTP_OK:
     - 		break;
     - 	case HTTP_MISSING_TARGET:
     --		show_http_message(&type, &charset, &buffer);
     --		die(_("repository '%s' not found"),
     --		    transport_anonymize_url(url.buf));
     -+		show_http_message_fatal(&type, &charset, &buffer,
     -+					_("repository '%s' not found"),
     -+					transport_anonymize_url(url.buf));
     - 	case HTTP_NOAUTH:
     --		show_http_message(&type, &charset, &buffer);
     --		die(_("Authentication failed for '%s'"),
     --		    transport_anonymize_url(url.buf));
     -+		show_http_message_fatal(&type, &charset, &buffer,
     -+					_("Authentication failed for '%s'"),
     -+					transport_anonymize_url(url.buf));
     - 	case HTTP_NOMATCHPUBLICKEY:
     --		show_http_message(&type, &charset, &buffer);
     --		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
     --		    transport_anonymize_url(url.buf), curl_errorstr);
     -+		show_http_message_fatal(&type, &charset, &buffer,
     -+					_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
     -+					transport_anonymize_url(url.buf), curl_errorstr);
     + 		show_http_message_fatal(&type, &charset, &buffer,
     + 					_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
     + 					transport_anonymize_url(url.buf), curl_errorstr);
      +	case HTTP_RATE_LIMITED:
      +		show_http_message_fatal(&type, &charset, &buffer,
      +					_("rate limited by '%s', please try again later"),
      +					transport_anonymize_url(url.buf));
       	default:
     --		show_http_message(&type, &charset, &buffer);
     --		die(_("unable to access '%s': %s"),
     --		    transport_anonymize_url(url.buf), curl_errorstr);
     -+		show_http_message_fatal(&type, &charset, &buffer,
     -+					_("unable to access '%s': %s"),
     -+					transport_anonymize_url(url.buf), curl_errorstr);
     - 	}
     - 
     - 	if (options.verbosity && !starts_with(refs_url.buf, url.buf)) {
     -
     - ## strbuf.c ##
     -@@ strbuf.c: int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
     - 	if (!out)
     - 		return -1;
     - 
     --	strbuf_attach(sb, out, len, len);
     -+	strbuf_attach(sb, out, len, len + 1);
     - 	return 0;
     - }
     - 
     + 		show_http_message_fatal(&type, &charset, &buffer,
     + 					_("unable to access '%s': %s"),
      
       ## t/lib-httpd.sh ##
      @@ t/lib-httpd.sh: prepare_httpd() {
     @@ t/t5584-http-429-retry.sh (new)
      +	test_config http.maxRetries 3 &&
      +
      +	# Time the operation - it should take at least 2 seconds due to retry delay
     -+	start=$(date +%s) &&
     ++	start=$(test-tool date getnanos) &&
      +	git ls-remote "$HTTPD_URL/http_429/retry-delays-respected/2/repo.git" >output 2>err &&
     -+	end=$(date +%s) &&
     -+	duration=$((end - start)) &&
     ++	duration=$(test-tool date getnanos $start) &&
      +
      +	# Verify it took at least 2 seconds (allowing some tolerance)
     -+	test "$duration" -ge 1 &&
     ++	duration_int=${duration%.*} &&
     ++	test "$duration_int" -ge 1 &&
      +	test_grep "refs/heads/" output
      +'
      +
     @@ t/t5584-http-429-retry.sh (new)
      +	test_config http.maxRetryTime 3 &&
      +
      +	# Should fail immediately without waiting
     -+	start=$(date +%s) &&
     ++	start=$(test-tool date getnanos) &&
      +	test_must_fail git ls-remote "$HTTPD_URL/http_429/retry-after-exceeds-max-time/100/repo.git" 2>err &&
     -+	end=$(date +%s) &&
     -+	duration=$((end - start)) &&
     ++	duration=$(test-tool date getnanos $start) &&
      +
      +	# Should fail quickly (less than 2 seconds, no 100 second wait)
     -+	test "$duration" -lt 2 &&
     -+	test_grep "exceeds http.maxRetryTime" err
     ++	duration_int=${duration%.*} &&
     ++	test "$duration_int" -lt 2 &&
     ++	test_grep "greater than http.maxRetryTime" err
      +'
      +
      +test_expect_success 'HTTP 429 fails if configured http.retryAfter exceeds http.maxRetryTime' '
     @@ t/t5584-http-429-retry.sh (new)
      +	test_config http.maxRetryTime 5 &&
      +
      +	# Should fail immediately with configuration error
     -+	start=$(date +%s) &&
     ++	start=$(test-tool date getnanos) &&
      +	test_must_fail git ls-remote "$HTTPD_URL/http_429/config-retry-after-exceeds-max-time/none/repo.git" 2>err &&
     -+	end=$(date +%s) &&
     -+	duration=$((end - start)) &&
     ++	duration=$(test-tool date getnanos $start) &&
      +
      +	# Should fail quickly
     -+	test "$duration" -lt 2 &&
     ++	duration_int=${duration%.*} &&
     ++	test "$duration_int" -lt 2 &&
      +	test_grep "configured http.retryAfter.*exceeds.*http.maxRetryTime" err
      +'
      +
      +test_expect_success 'HTTP 429 with Retry-After HTTP-date format' '
      +	# Test HTTP-date format (RFC 2822) in Retry-After header
     -+	# Generate a date 2 seconds in the future
     -+	future_date=$(TZ=GMT date -d "+2 seconds" "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
     -+		      TZ=GMT date -v+2S "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
     -+		      echo "skip") &&
     -+
     -+	if test "$future_date" = "skip"
     -+	then
     -+		skip_all="date command does not support required format" &&
     -+		test_done
     -+	fi &&
     -+
     -+	# URL-encode the date (replace spaces with %20)
     ++	raw=$(test-tool date timestamp now) &&
     ++	now="${raw#* -> }" &&
     ++	future_time=$((now + 2)) &&
     ++	raw=$(test-tool date show:rfc2822 $future_time) &&
     ++	future_date="${raw#* -> }" &&
      +	future_date_encoded=$(echo "$future_date" | sed "s/ /%20/g") &&
      +
      +	# Enable retries
      +	test_config http.maxRetries 3 &&
      +
      +	# Git should parse the HTTP-date and retry after the delay
     -+	start=$(date +%s) &&
     ++	start=$(test-tool date getnanos) &&
      +	git ls-remote "$HTTPD_URL/http_429/http-date-format/$future_date_encoded/repo.git" >output 2>err &&
     -+	end=$(date +%s) &&
     -+	duration=$((end - start)) &&
     ++	duration=$(test-tool date getnanos $start) &&
      +
      +	# Should take at least 1 second (allowing tolerance for processing time)
     -+	test "$duration" -ge 1 &&
     ++	duration_int=${duration%.*} &&
     ++	test "$duration_int" -ge 1 &&
      +	test_grep "refs/heads/" output
      +'
      +
      +test_expect_success 'HTTP 429 with HTTP-date exceeding maxRetryTime fails immediately' '
     -+	# Generate a date 200 seconds in the future
     -+	future_date=$(TZ=GMT date -d "+200 seconds" "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
     -+		      TZ=GMT date -v+200S "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
     -+		      echo "skip") &&
     -+
     -+	if test "$future_date" = "skip"
     -+	then
     -+		skip_all="date command does not support required format" &&
     -+		test_done
     -+	fi &&
     -+
     -+	# URL-encode the date (replace spaces with %20)
     ++	raw=$(test-tool date timestamp now) &&
     ++	now="${raw#* -> }" &&
     ++	future_time=$((now + 200)) &&
     ++	raw=$(test-tool date show:rfc2822 $future_time) &&
     ++	future_date="${raw#* -> }" &&
      +	future_date_encoded=$(echo "$future_date" | sed "s/ /%20/g") &&
      +
      +	# Configure max retry time much less than the 200 second delay
     @@ t/t5584-http-429-retry.sh (new)
      +	test_config http.maxRetryTime 10 &&
      +
      +	# Should fail immediately without waiting 200 seconds
     -+	start=$(date +%s) &&
     ++	start=$(test-tool date getnanos) &&
      +	test_must_fail git ls-remote "$HTTPD_URL/http_429/http-date-exceeds-max-time/$future_date_encoded/repo.git" 2>err &&
     -+	end=$(date +%s) &&
     -+	duration=$((end - start)) &&
     ++	duration=$(test-tool date getnanos $start) &&
      +
      +	# Should fail quickly (not wait 200 seconds)
     -+	test "$duration" -lt 2 &&
     -+	test_grep "exceeds http.maxRetryTime" err
     ++	duration_int=${duration%.*} &&
     ++	test "$duration_int" -lt 2 &&
     ++	test_grep "http.maxRetryTime" err
      +'
      +
      +test_expect_success 'HTTP 429 with past HTTP-date should not wait' '
     -+	past_date=$(TZ=GMT date -d "-10 seconds" "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
     -+		    TZ=GMT date -v-10S "+%a, %d %b %Y %H:%M:%S GMT" 2>/dev/null || \
     -+		    echo "skip") &&
     -+
     -+	if test "$past_date" = "skip"
     -+	then
     -+		skip_all="date command does not support required format" &&
     -+		test_done
     -+	fi &&
     -+
     -+	# URL-encode the date (replace spaces with %20)
     ++	raw=$(test-tool date timestamp now) &&
     ++	now="${raw#* -> }" &&
     ++	past_time=$((now - 10)) &&
     ++	raw=$(test-tool date show:rfc2822 $past_time) &&
     ++	past_date="${raw#* -> }" &&
      +	past_date_encoded=$(echo "$past_date" | sed "s/ /%20/g") &&
      +
      +	# Enable retries
      +	test_config http.maxRetries 3 &&
      +
      +	# Git should retry immediately without waiting
     -+	start=$(date +%s) &&
     ++	start=$(test-tool date getnanos) &&
      +	git ls-remote "$HTTPD_URL/http_429/past-http-date/$past_date_encoded/repo.git" >output 2>err &&
     -+	end=$(date +%s) &&
     -+	duration=$((end - start)) &&
     ++	duration=$(test-tool date getnanos $start) &&
      +
      +	# Should complete quickly (less than 2 seconds)
     -+	test "$duration" -lt 2 &&
     ++	duration_int=${duration%.*} &&
     ++	test "$duration_int" -lt 2 &&
      +	test_grep "refs/heads/" output
      +'
      +
     @@ t/t5584-http-429-retry.sh (new)
      +	test_config http.retryAfter 1 &&
      +
      +	# Should use configured default (1 second) since header is invalid
     -+	start=$(date +%s) &&
     ++	start=$(test-tool date getnanos) &&
      +	git ls-remote "$HTTPD_URL/http_429/invalid-retry-after-format/invalid/repo.git" >output 2>err &&
     -+	end=$(date +%s) &&
     -+	duration=$((end - start)) &&
     ++	duration=$(test-tool date getnanos $start) &&
      +
      +	# Should take at least 1 second (the configured default)
     -+	test "$duration" -ge 1 &&
     ++	duration_int=${duration%.*} &&
     ++	test "$duration_int" -ge 1 &&
      +	test_grep "refs/heads/" output &&
      +	test_grep "waiting.*retry" err
      +'
     @@ t/t5584-http-429-retry.sh (new)
      +	test_config http.retryAfter 10 &&
      +
      +	# Override with environment variable to 1 second
     -+	start=$(date +%s) &&
     ++	start=$(test-tool date getnanos) &&
      +	GIT_HTTP_RETRY_AFTER=1 git ls-remote "$HTTPD_URL/http_429/env-retry-after-override/none/repo.git" >output 2>err &&
     -+	end=$(date +%s) &&
     -+	duration=$((end - start)) &&
     ++	duration=$(test-tool date getnanos $start) &&
      +
      +	# Should use env var (1 second), not config (10 seconds)
     -+	test "$duration" -ge 1 &&
     -+	test "$duration" -lt 5 &&
     ++	duration_int=${duration%.*} &&
     ++	test "$duration_int" -ge 1 &&
     ++	test "$duration_int" -lt 5 &&
      +	test_grep "refs/heads/" output &&
      +	test_grep "waiting.*retry" err
      +'
     @@ t/t5584-http-429-retry.sh (new)
      +	test_config http.maxRetryTime 100 &&
      +
      +	# Override with environment variable to 10 seconds (should reject 50 second delay)
     -+	start=$(date +%s) &&
     ++	start=$(test-tool date getnanos) &&
      +	test_must_fail env GIT_HTTP_MAX_RETRY_TIME=10 \
      +		git ls-remote "$HTTPD_URL/http_429/env-max-retry-time-override/50/repo.git" 2>err &&
     -+	end=$(date +%s) &&
     -+	duration=$((end - start)) &&
     ++	duration=$(test-tool date getnanos $start) &&
      +
      +	# Should fail quickly (not wait 50 seconds) because env var limits to 10
     -+	test "$duration" -lt 5 &&
     -+	test_grep "exceeds http.maxRetryTime" err
     ++	duration_int=${duration%.*} &&
     ++	test "$duration_int" -lt 5 &&
     ++	test_grep "greater than http.maxRetryTime" err
      +'
      +
      +test_expect_success 'verify normal repository access still works' '
 2:  ad4495fc94 < -:  ---------- http: add trace2 logging for retry operations

-- 
gitgitgadget
