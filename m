Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563E26C385
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069096; cv=none; b=h/MJKPfekvQAEH4SIzqJNNr2z46xNTFicZ5oDIWhRzlSGxgOaV3MdWHBPJa6bjtJc9IPwXUv6TGk2dkjXLhJkjqcNxTxqASr9AIvtZORV6P2KANDyrzdXid/A/CpR6A91weaGvNyN4wkpfJ/jrzYb/Hr2mClmmbLpJHZEPqw/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069096; c=relaxed/simple;
	bh=abX1KVdBj/MKN2mZLW6ALIK0BoXiFbrFleciufiXYmE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jmJheCCdw503swNWS1xJsBwp3Ycs3H9pGZShQJwEeYxYtdguECi/LryeotBKGGKrdAOR4632zRCDNLaIoUtqPtoOZxz7xuY5hI7qhjr/I3TxL9TNyOcJBGwOqqhVlSFKGc159ut+79f8CW1LNSAqxtA5yDV143QK+XG/EgqwRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CD09OoOr; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD09OoOr"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c7aee74dceso245287a34.2
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766069091; x=1766673891; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdP35ePl6/8ZWj7zO9L+zIsW6EuDdd56rvdQIep9AKk=;
        b=CD09OoOr97Nx7B4gDrebp0WLHsDt6IOTvTKCJhdlmHH4PmWaNr08gPQHhaw8WbST7m
         LO0sbY1qTKi8wTmllfY9sF8KEJ05rwy/1IkNAMhfw8Q2eLe3Q+1Cv3/DpjsZ84uLr2YS
         hJJMSvoWquE8mdrvAQAbvEmpCsBAISZZKZGT8H0xmof0tHCZH4p/cH/nfEaHl7RBM5Fi
         39E88lGUdkmqH8u2KKcE/zQydc0waOerWhaA5kkH9HT55Ji5hMgn59NqSg5PavAhihpE
         69+bMbCZ47d1zm4L20xz3wgfXKUst1tNgDilq4bvw6GFklplraOkcotS30l7nbAeVGcc
         l+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766069091; x=1766673891;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OdP35ePl6/8ZWj7zO9L+zIsW6EuDdd56rvdQIep9AKk=;
        b=h6v/KdS5X481NUPVyYF91dM9XSC8iYcAvgiFeENjxQPhtRNK9sIoeDYhcbZiwGaB7q
         oRpVmRqwHZmgKCCZ0EvJOz0jKdn08c5VST/NMUEh8vlPkIcrun1+Z/ksRIQ/sMXwv3rx
         cmtIX0kcCSWcZ7YBNdgAZ0a03olbRlT7eNwN5K3++MV6Q9lcxO++sgiQ2oibOSBShwXw
         Bvjx+fbLsSeV6IMrGoQnL6/6G5wYSoACDG/m5JXoMBzpEFhp8JvNFCv0mWm25gba2zED
         +HJ1PaHSzQq175HpOkG/wxtufE9P2cosuQ5grM4/qCAL8No9KcmVA2yKpIpyCYXy+U3s
         zVgA==
X-Gm-Message-State: AOJu0YwsXxWIaqckcU62YKz4SVNvHEjWSknOkpP+2hBhol/uD4lSzc/0
	YU88zXLBiDwGnDISoy28Mw0RFvykpk0+y7j7Ns1FT7x6mIz8QpSv3xX+FYGNsMf8
X-Gm-Gg: AY/fxX5T5uRWWHwbM+MSb10aYzKcA7ZKbR//4Q7gXdkrfMcqGBk6yyoL9JRTGxU3tAF
	NmNdhG2EGctGTypsgceWs8BOQ5esKnwemGpRO+IFihwAwiPlloW6wrt3ANYeLe8VGn7pfIY+AT1
	EB2qjp/uSzjDdA9FQ3ot4b8MTAPPp3cK5BhKmC1Smf1R3WgNVRFhazUocHK66gUWWmopVsfSTL3
	i/9gZVk3xfE+omIhPpnv1xpWarvEOesLGwx+G0APSr3ckQkwgTzRfDF6WONpcLTLVNS0pKdMJHb
	Di0RR/IQKV7BVwMB9QUgxgBwHktbkyjOxFvZcJdcjtFvCuFYsz28mdsurrlbKzI9uXYnmLilBYu
	x2F/OWsd9AFXtLT9cxU4IVAlngIvAMXwl9zJXoLUQsGB7nDyAAitnQI4f4t5yMlHo6iEvzcd6Gy
	HuEoO7IsvrxRQlog==
X-Google-Smtp-Source: AGHT+IHQXQaLXMKgr75dAnV6/wa0v6VszzaT7Sy8m4aH89RB9NLmt/K1vgJQQi1CdGfGWRFhq4FGAA==
X-Received: by 2002:a05:6808:1490:b0:442:e596:1189 with SMTP id 5614622812f47-455ac989fb4mr10499713b6e.45.1766069090412;
        Thu, 18 Dec 2025 06:44:50 -0800 (PST)
Received: from [127.0.0.1] ([52.176.125.120])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17f4b879sm1762472fac.14.2025.12.18.06.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 06:44:49 -0800 (PST)
Message-Id: <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 14:44:46 +0000
Subject: [PATCH v2 0/2] http: add support for HTTP 429 rate limit retries
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
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Changes since v1:

 * removed configuration options from commit message
 * marked "rate limited by %s ..." message for translation in http-push.c
 * dropped redundant comments from retry configuration variables
 * renamed "fwrite_wwwauth" to "fwrite_headers". Due to complexity related
   with header continuation handling, I've decide not to split into header
   specific functions.
 * rewritten the sleep logic into non-blocking handling, so that the rest of
   the slots can be processed at the time retry delay is requested
 * renamed "http_request_reauth" to "http_request_recoverable" to better
   reflect that it does not only reauth , but also other recoverable
   handling
 * updated test setup code to use setup script to reduce repetition in the
   test code
 * updated to use test_grep instead of grep
 * dropped memory leak fix patch in afvor to rename of the
   "show_http_message" to "show_http_message_fatal".
 * Adjusted alloc size in "strbuf_reencode" for "strbuf_attach" call, which
   seems to solve the leak problem

The implementation includes:

Patch 1: Core HTTP 429 retry logic with support for RFC-compliant
Retry-After headers (both delay-seconds and HTTP-date formats),
comprehensive configuration options, and fail-fast behavior for excessive
delays. Includes extensive test coverage.

Patch 2: Adds trace2 instrumentation to enable monitoring and debugging of
retry operations in production environments.

Vaidas Pilkauskas (2):
  http: add support for HTTP 429 rate limit retries
  http: add trace2 logging for retry operations

 Documentation/config/http.adoc |  24 +++
 http-push.c                    |   8 +
 http-walker.c                  |   5 +
 http.c                         | 321 +++++++++++++++++++++++++++++----
 http.h                         |   4 +
 remote-curl.c                  |  49 +++--
 strbuf.c                       |   2 +-
 t/lib-httpd.sh                 |   1 +
 t/lib-httpd/apache.conf        |   8 +
 t/lib-httpd/http-429.sh        |  98 ++++++++++
 t/meson.build                  |   1 +
 t/t5584-http-429-retry.sh      | 286 +++++++++++++++++++++++++++++
 12 files changed, 750 insertions(+), 57 deletions(-)
 create mode 100644 t/lib-httpd/http-429.sh
 create mode 100755 t/t5584-http-429-retry.sh


base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2008%2Fvaidas-shopify%2Fretry-after-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2008/vaidas-shopify/retry-after-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2008

Range-diff vs v1:

 1:  ae0087cd1c ! 1:  d80ce07703 http: add support for HTTP 429 rate limit retries
     @@ Commit message
          both delay-seconds (integer) and HTTP-date (RFC 2822) formats. If a
          past date is provided, Git retries immediately without waiting.
      
     -    Retry behavior is controlled by three new configuration options:
     -
     -      * http.maxRetries: Maximum number of retry attempts (default: 0,
     -        meaning retries are disabled by default). Users must explicitly
     -        opt-in to retry behavior.
     -
     -      * http.retryAfter: Default delay in seconds when the server doesn't
     -        provide a Retry-After header (default: -1, meaning fail if no
     -        header is provided). This serves as a fallback mechanism.
     -
     -      * http.maxRetryTime: Maximum delay in seconds for a single retry
     -        (default: 300). If the server requests a delay exceeding this
     -        limit, Git fails immediately rather than waiting. This prevents
     -        indefinite blocking on unreasonable server requests.
     -
     -    All three options can be overridden via environment variables:
     -    GIT_HTTP_MAX_RETRIES, GIT_HTTP_RETRY_AFTER, and
     -    GIT_HTTP_MAX_RETRY_TIME.
     +    Retry behavior is controlled by three new configuration options
     +    (http.maxRetries, http.retryAfter, and http.maxRetryTime) which are
     +    documented in git-config(1).
      
          The retry logic implements a fail-fast approach: if any delay
          (whether from server header or configuration) exceeds maxRetryTime,
     @@ http-push.c: static int fetch_indices(void)
       		ret = 0;
       		break;
      +	case HTTP_RATE_LIMITED:
     -+		error("rate limited by '%s', please try again later", repo->url);
     ++		error(_("rate limited by '%s', please try again later"), repo->url);
      +		ret = -1;
      +		break;
       	default:
     @@ http-push.c: static int remote_exists(const char *path)
       		ret = 0;
       		break;
      +	case HTTP_RATE_LIMITED:
     -+		error("rate limited by '%s', please try again later", url);
     ++		error(_("rate limited by '%s', please try again later"), url);
      +		ret = -1;
      +		break;
       	case HTTP_ERROR:
     @@ http.c: static char *cached_accept_language;
       
       static int http_schannel_check_revoke = 1;
      +
     -+/* Retry configuration */
     -+static long http_retry_after = -1; /* Default retry-after in seconds when header is missing (-1 means not set, exit with 128) */
     -+static long http_max_retries = 0; /* Maximum number of retry attempts (0 means retries are disabled) */
     -+static long http_max_retry_time = 300; /* Maximum time to wait for a single retry (default 5 minutes) */
     ++static long http_retry_after = -1;
     ++static long http_max_retries = 0;
     ++static long http_max_retry_time = 300;
      +
     -+/* Store retry_after value from 429 responses for retry logic (-1 = not set, 0 = retry immediately, >0 = delay in seconds) */
     -+static long last_retry_after = -1;
       /*
        * With the backend being set to `schannel`, setting sslCAinfo would override
        * the Certificate Store in cURL v7.60.0 and later, which is not what we want
     @@ http.c: static inline int is_hdr_continuation(const char *ptr, const size_t size
       }
       
      -static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UNUSED)
     -+static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
     ++static size_t fwrite_headers(char *ptr, size_t eltsize, size_t nmemb, void *p)
       {
       	size_t size = eltsize * nmemb;
       	struct strvec *values = &http_auth.wwwauth_headers;
     @@ http.c: void http_init(struct remote *remote, const char *url, int proactive_aut
       	curl_default = get_curl_handle();
       }
       
     +@@ http.c: struct active_request_slot *get_active_slot(void)
     + 	slot->finished = NULL;
     + 	slot->callback_data = NULL;
     + 	slot->callback_func = NULL;
     ++	slot->retry_delay_seconds = -1;
     ++	memset(&slot->retry_delay_start, 0, sizeof(slot->retry_delay_start));
     + 
     + 	if (curl_cookie_file && !strcmp(curl_cookie_file, "-")) {
     + 		warning(_("refusing to read cookies from http.cookiefile '-'"));
     +@@ http.c: void run_active_slot(struct active_request_slot *slot)
     + 	fd_set excfds;
     + 	int max_fd;
     + 	struct timeval select_timeout;
     ++	long curl_timeout;
     ++	struct timeval start_time = {0}, current_time, elapsed_time = {0};
     ++	long remaining_seconds;
     + 	int finished = 0;
     ++	int slot_not_started = (slot->finished == NULL);
     ++	int waiting_for_delay = (slot->retry_delay_seconds > 0);
     ++
     ++	if (waiting_for_delay) {
     ++		warning(_("rate limited, waiting %ld seconds before retry"), slot->retry_delay_seconds);
     ++		start_time = slot->retry_delay_start;
     ++	}
     + 
     + 	slot->finished = &finished;
     +-	while (!finished) {
     ++	while (waiting_for_delay || !finished) {
     ++		if (waiting_for_delay) {
     ++			gettimeofday(&current_time, NULL);
     ++			elapsed_time.tv_sec = current_time.tv_sec - start_time.tv_sec;
     ++			elapsed_time.tv_usec = current_time.tv_usec - start_time.tv_usec;
     ++			if (elapsed_time.tv_usec < 0) {
     ++				elapsed_time.tv_sec--;
     ++				elapsed_time.tv_usec += 1000000;
     ++			}
     ++
     ++			if (elapsed_time.tv_sec >= slot->retry_delay_seconds) {
     ++				slot->retry_delay_seconds = -1;
     ++				waiting_for_delay = 0;
     ++
     ++				if (slot_not_started)
     ++					return;
     ++			}
     ++		}
     ++
     + 		step_active_slots();
     + 
     +-		if (slot->in_use) {
     +-			long curl_timeout;
     +-			curl_multi_timeout(curlm, &curl_timeout);
     +-			if (curl_timeout == 0) {
     ++		if (!waiting_for_delay && !slot->in_use)
     ++			continue;
     ++
     ++		curl_multi_timeout(curlm, &curl_timeout);
     ++		if (curl_timeout == 0) {
     ++			if (!waiting_for_delay)
     + 				continue;
     +-			} else if (curl_timeout == -1) {
     +-				select_timeout.tv_sec  = 0;
     +-				select_timeout.tv_usec = 50000;
     ++			select_timeout.tv_sec = 0;
     ++			select_timeout.tv_usec = 50000; /* 50ms */
     ++		} else if (curl_timeout == -1) {
     ++			select_timeout.tv_sec = 0;
     ++			select_timeout.tv_usec = 50000;
     ++		} else {
     ++			long curl_timeout_sec = curl_timeout / 1000;
     ++			long curl_timeout_usec = (curl_timeout % 1000) * 1000;
     ++
     ++			if (waiting_for_delay) {
     ++				remaining_seconds = slot->retry_delay_seconds - elapsed_time.tv_sec;
     ++				if (curl_timeout_sec < remaining_seconds) {
     ++					select_timeout.tv_sec = curl_timeout_sec;
     ++					select_timeout.tv_usec = curl_timeout_usec;
     ++				} else {
     ++					select_timeout.tv_sec = remaining_seconds;
     ++					select_timeout.tv_usec = 0;
     ++				}
     + 			} else {
     +-				select_timeout.tv_sec  =  curl_timeout / 1000;
     +-				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
     ++				select_timeout.tv_sec = curl_timeout_sec;
     ++				select_timeout.tv_usec = curl_timeout_usec;
     + 			}
     ++		}
     + 
     +-			max_fd = -1;
     +-			FD_ZERO(&readfds);
     +-			FD_ZERO(&writefds);
     +-			FD_ZERO(&excfds);
     +-			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
     ++		max_fd = -1;
     ++		FD_ZERO(&readfds);
     ++		FD_ZERO(&writefds);
     ++		FD_ZERO(&excfds);
     ++		curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
     + 
     +-			/*
     +-			 * It can happen that curl_multi_timeout returns a pathologically
     +-			 * long timeout when curl_multi_fdset returns no file descriptors
     +-			 * to read.  See commit message for more details.
     +-			 */
     +-			if (max_fd < 0 &&
     +-			    (select_timeout.tv_sec > 0 ||
     +-			     select_timeout.tv_usec > 50000)) {
     +-				select_timeout.tv_sec  = 0;
     +-				select_timeout.tv_usec = 50000;
     +-			}
     ++		/*
     ++		 * It can happen that curl_multi_timeout returns a pathologically
     ++		 * long timeout when curl_multi_fdset returns no file descriptors
     ++		 * to read.  See commit message for more details.
     ++		 */
     ++		if (max_fd < 0 &&
     ++		    (select_timeout.tv_sec > 0 ||
     ++		     select_timeout.tv_usec > 50000)) {
     ++			select_timeout.tv_sec = 0;
     ++			select_timeout.tv_usec = 50000;
     ++		}
     + 
     +-			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
     ++		/*
     ++		 * If curl_multi_fdset returns no file descriptors but we have
     ++		 * a timeout, still use select() to wait for the timeout period.
     ++		 */
     ++		if (max_fd < 0) {
     ++			/* No file descriptors, just wait for timeout */
     ++			select(0, NULL, NULL, NULL, &select_timeout);
     ++		} else {
     ++			select(max_fd + 1, &readfds, &writefds, &excfds, &select_timeout);
     + 		}
     + 	}
     + 
      @@ http.c: static int handle_curl_result(struct slot_results *results)
       			}
       			return HTTP_REAUTH;
       		}
      +	} else if (results->http_code == 429) {
     -+		/* Store the retry_after value for use in retry logic */
     -+		last_retry_after = results->retry_after;
      +		return HTTP_RATE_LIMITED;
       	} else {
       		if (results->http_connectcode == 407)
     @@ http.c: int run_one_slot(struct active_request_slot *slot,
       	slot->results = results;
      +	/* Initialize retry_after to -1 (not set) */
      +	results->retry_after = -1;
     ++
     ++	/* If there's a retry delay, wait for it before starting the slot */
     ++	if (slot->retry_delay_seconds > 0) {
     ++		run_active_slot(slot);
     ++	}
     ++
       	if (!start_active_slot(slot)) {
       		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
       			  "failed to start HTTP request");
     +@@ http.c: static void http_opt_request_remainder(CURL *curl, off_t pos)
     + #define HTTP_REQUEST_STRBUF	0
     + #define HTTP_REQUEST_FILE	1
     + 
     ++static void sleep_for_retry(struct active_request_slot *slot, long retry_after);
     ++
     + static int http_request(const char *url,
     + 			void *result, int target,
     +-			const struct http_get_options *options)
     ++			const struct http_get_options *options,
     ++			long *retry_after_out,
     ++			long retry_delay)
     + {
     + 	struct active_request_slot *slot;
     + 	struct slot_results results;
      @@ http.c: static int http_request(const char *url,
     + 	int ret;
     + 
     + 	slot = get_active_slot();
     ++	/* Mark slot for delay if retry delay is provided */
     ++	if (retry_delay > 0) {
     ++		sleep_for_retry(slot, retry_delay);
     ++	}
     + 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
     + 
     + 	if (!result) {
     +@@ http.c: static int http_request(const char *url,
     + 					 fwrite_buffer);
       	}
       
     - 	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
     +-	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
     ++	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_headers);
      +	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, slot);
       
       	accept_language = http_get_accept_language_header();
       
     +@@ http.c: static int http_request(const char *url,
     + 
     + 	ret = run_one_slot(slot, &results);
     + 
     ++	/* Store retry_after from slot results if output parameter provided */
     ++	if (retry_after_out)
     ++		*retry_after_out = results.retry_after;
     ++
     + 	if (options && options->content_type) {
     + 		struct strbuf raw = STRBUF_INIT;
     + 		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, &raw);
      @@ http.c: static int update_url_from_redirect(struct strbuf *base,
       	return 1;
       }
       
     +-static int http_request_reauth(const char *url,
      +/*
     -+ * Sleep for the specified number of seconds before retrying.
     ++ * Mark slot to be delayed for retry. The actual delay will be handled
     ++ * in run_active_slot when the slot is executed.
      + */
     -+static void sleep_for_retry(long retry_after)
     ++static void sleep_for_retry(struct active_request_slot *slot, long retry_after)
      +{
     -+	if (retry_after > 0) {
     -+		unsigned int remaining;
     ++	if (retry_after > 0 && slot) {
      +		warning(_("rate limited, waiting %ld seconds before retry"), retry_after);
     -+		remaining = sleep(retry_after);
     -+		while (remaining > 0) {
     -+			/* Sleep was interrupted, continue sleeping */
     -+			remaining = sleep(remaining);
     ++		slot->retry_delay_seconds = retry_after;
     ++		gettimeofday(&slot->retry_delay_start, NULL);
     ++	}
     ++}
     ++
     ++/*
     ++ * Handle rate limiting retry logic for HTTP 429 responses.
     ++ * Uses slot-specific retry_after value to support concurrent slots.
     ++ * Returns a negative value if retries are exhausted or configuration is invalid,
     ++ * otherwise returns the delay value (>= 0) to indicate the retry should proceed.
     ++ */
     ++static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_after)
     ++{
     ++	int retry_attempt = http_max_retries - *rate_limit_retries + 1;
     ++	if (*rate_limit_retries <= 0) {
     ++		/* Retries are disabled or exhausted */
     ++		if (http_max_retries > 0) {
     ++			error(_("too many rate limit retries, giving up"));
     ++		}
     ++		return -1;
     ++	}
     ++
     ++	/* Decrement retries counter */
     ++	(*rate_limit_retries)--;
     ++
     ++	/* Use the slot-specific retry_after value or configured default */
     ++	if (slot_retry_after >= 0) {
     ++		/* Check if retry delay exceeds maximum allowed */
     ++		if (slot_retry_after > http_max_retry_time) {
     ++			error(_("rate limited (HTTP 429) requested %ld second delay, "
     ++				"exceeds http.maxRetryTime of %ld seconds"),
     ++			      slot_retry_after, http_max_retry_time);
     ++			return -1;
     ++		}
     ++		return slot_retry_after;
     ++	} else {
     ++		/* No Retry-After header provided */
     ++		if (http_retry_after < 0) {
     ++			/* Not configured - exit with error */
     ++			error(_("rate limited (HTTP 429) and no Retry-After header provided. "
     ++				"Configure http.retryAfter or set GIT_HTTP_RETRY_AFTER."));
     ++			return -1;
      +		}
     ++		/* Check if configured default exceeds maximum allowed */
     ++		if (http_retry_after > http_max_retry_time) {
     ++			error(_("configured http.retryAfter (%ld seconds) exceeds "
     ++				"http.maxRetryTime (%ld seconds)"),
     ++			      http_retry_after, http_max_retry_time);
     ++			return -1;
     ++		}
     ++
     ++		return http_retry_after;
      +	}
      +}
      +
     - static int http_request_reauth(const char *url,
     ++static int http_request_recoverable(const char *url,
       			       void *result, int target,
       			       struct http_get_options *options)
       {
       	int i = 3;
       	int ret;
      +	int rate_limit_retries = http_max_retries;
     ++	long slot_retry_after = -1; /* Per-slot retry_after value */
       
       	if (always_auth_proactively())
       		credential_fill(the_repository, &http_auth, 1);
       
     - 	ret = http_request(url, result, target, options);
     +-	ret = http_request(url, result, target, options);
     ++	ret = http_request(url, result, target, options, &slot_retry_after, -1);
       
      -	if (ret != HTTP_OK && ret != HTTP_REAUTH)
      +	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_RATE_LIMITED)
       		return ret;
       
     ++	/* If retries are disabled and we got a 429, fail immediately */
     ++	if (ret == HTTP_RATE_LIMITED && http_max_retries == 0)
     ++		return HTTP_ERROR;
     ++
       	if (options && options->effective_url && options->base_url) {
     + 		if (update_url_from_redirect(options->base_url,
     + 					     url, options->effective_url)) {
      @@ http.c: static int http_request_reauth(const char *url,
       		}
       	}
       
      -	while (ret == HTTP_REAUTH && --i) {
      +	while ((ret == HTTP_REAUTH || ret == HTTP_RATE_LIMITED) && --i) {
     ++		long retry_delay = -1;
       		/*
       		 * The previous request may have put cruft into our output stream; we
       		 * should clear it out before making our next request.
      @@ http.c: static int http_request_reauth(const char *url,
     + 		default:
       			BUG("Unknown http_request target");
       		}
     - 
     --		credential_fill(the_repository, &http_auth, 1);
      +		if (ret == HTTP_RATE_LIMITED) {
     -+			/* Handle rate limiting with retry logic */
     -+			int retry_attempt = http_max_retries - rate_limit_retries + 1;
     -+
     -+			if (rate_limit_retries <= 0) {
     -+				/* Retries are disabled or exhausted */
     -+				if (http_max_retries > 0) {
     -+					error(_("too many rate limit retries, giving up"));
     -+				}
     ++			retry_delay = handle_rate_limit_retry(&rate_limit_retries, slot_retry_after);
     ++			if (retry_delay < 0)
      +				return HTTP_ERROR;
     -+			}
     -+
     -+			/* Decrement retries counter */
     -+			rate_limit_retries--;
     -+
     -+			/* Use the stored retry_after value or configured default */
     -+			if (last_retry_after >= 0) {
     -+				/* Check if retry delay exceeds maximum allowed */
     -+				if (last_retry_after > http_max_retry_time) {
     -+					error(_("rate limited (HTTP 429) requested %ld second delay, "
     -+						"exceeds http.maxRetryTime of %ld seconds"),
     -+					      last_retry_after, http_max_retry_time);
     -+					last_retry_after = -1; /* Reset after use */
     -+					return HTTP_ERROR;
     -+				}
     -+				sleep_for_retry(last_retry_after);
     -+				last_retry_after = -1; /* Reset after use */
     -+			} else {
     -+				/* No Retry-After header provided */
     -+				if (http_retry_after < 0) {
     -+					/* Not configured - exit with error */
     -+					error(_("rate limited (HTTP 429) and no Retry-After header provided. "
     -+						"Configure http.retryAfter or set GIT_HTTP_RETRY_AFTER."));
     -+					return HTTP_ERROR;
     -+				}
     -+				/* Check if configured default exceeds maximum allowed */
     -+				if (http_retry_after > http_max_retry_time) {
     -+					error(_("configured http.retryAfter (%ld seconds) exceeds "
     -+						"http.maxRetryTime (%ld seconds)"),
     -+					      http_retry_after, http_max_retry_time);
     -+					return HTTP_ERROR;
     -+				}
     -+				/* Use configured default retry-after value */
     -+				sleep_for_retry(http_retry_after);
     -+			}
     ++			slot_retry_after = -1; /* Reset after use */
      +		} else if (ret == HTTP_REAUTH) {
      +			credential_fill(the_repository, &http_auth, 1);
      +		}
       
     - 		ret = http_request(url, result, target, options);
     +-		credential_fill(the_repository, &http_auth, 1);
     +-
     +-		ret = http_request(url, result, target, options);
     ++		ret = http_request(url, result, target, options, &slot_retry_after, retry_delay);
       	}
     + 	return ret;
     + }
     +@@ http.c: int http_get_strbuf(const char *url,
     + 		    struct strbuf *result,
     + 		    struct http_get_options *options)
     + {
     +-	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
     ++	return http_request_recoverable(url, result, HTTP_REQUEST_STRBUF, options);
     + }
     + 
     + /*
     +@@ http.c: int http_get_file(const char *url, const char *filename,
     + 		goto cleanup;
     + 	}
     + 
     +-	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
     ++	ret = http_request_recoverable(url, result, HTTP_REQUEST_FILE, options);
     + 	fclose(result);
     + 
     + 	if (ret == HTTP_OK && finalize_object_file(the_repository, tmpfile.buf, filename))
      
       ## http.h ##
      @@ http.h: struct slot_results {
     @@ http.h: struct slot_results {
       };
       
       struct active_request_slot {
     +@@ http.h: struct active_request_slot {
     + 	void *callback_data;
     + 	void (*callback_func)(void *data);
     + 	struct active_request_slot *next;
     ++	long retry_delay_seconds;
     ++	struct timeval retry_delay_start;
     + };
     + 
     + struct buffer {
      @@ http.h: struct http_get_options {
       #define HTTP_REAUTH	4
       #define HTTP_NOAUTH	5
     @@ http.h: struct http_get_options {
        * Requests a URL and stores the result in a strbuf.
      
       ## remote-curl.c ##
     +@@ remote-curl.c: static void free_discovery(struct discovery *d)
     + 	}
     + }
     + 
     +-static int show_http_message(struct strbuf *type, struct strbuf *charset,
     +-			     struct strbuf *msg)
     ++static NORETURN void show_http_message_fatal(struct strbuf *type, struct strbuf *charset,
     ++				    struct strbuf *msg, const char *fmt, ...)
     + {
     + 	const char *p, *eol;
     ++	va_list ap;
     ++	report_fn die_message_routine = get_die_message_routine();
     + 
     + 	/*
     + 	 * We only show text/plain parts, as other types are likely
     + 	 * to be ugly to look at on the user's terminal.
     + 	 */
     + 	if (strcmp(type->buf, "text/plain"))
     +-		return -1;
     ++		goto out;
     + 	if (charset->len)
     + 		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
     + 
     + 	strbuf_trim(msg);
     + 	if (!msg->len)
     +-		return -1;
     ++		goto out;
     + 
     + 	p = msg->buf;
     + 	do {
     +@@ remote-curl.c: static int show_http_message(struct strbuf *type, struct strbuf *charset,
     + 		fprintf(stderr, "remote: %.*s\n", (int)(eol - p), p);
     + 		p = eol + 1;
     + 	} while(*eol);
     +-	return 0;
     ++
     ++out:
     ++	strbuf_release(type);
     ++	strbuf_release(charset);
     ++	strbuf_release(msg);
     ++
     ++	va_start(ap, fmt);
     ++	die_message_routine(fmt, ap);
     ++	va_end(ap);
     ++	exit(128);
     + }
     + 
     + static int get_protocol_http_header(enum protocol_version version,
      @@ remote-curl.c: static struct discovery *discover_refs(const char *service, int for_push)
     - 		show_http_message(&type, &charset, &buffer);
     - 		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
     - 		    transport_anonymize_url(url.buf), curl_errorstr);
     + 	case HTTP_OK:
     + 		break;
     + 	case HTTP_MISSING_TARGET:
     +-		show_http_message(&type, &charset, &buffer);
     +-		die(_("repository '%s' not found"),
     +-		    transport_anonymize_url(url.buf));
     ++		show_http_message_fatal(&type, &charset, &buffer,
     ++					_("repository '%s' not found"),
     ++					transport_anonymize_url(url.buf));
     + 	case HTTP_NOAUTH:
     +-		show_http_message(&type, &charset, &buffer);
     +-		die(_("Authentication failed for '%s'"),
     +-		    transport_anonymize_url(url.buf));
     ++		show_http_message_fatal(&type, &charset, &buffer,
     ++					_("Authentication failed for '%s'"),
     ++					transport_anonymize_url(url.buf));
     + 	case HTTP_NOMATCHPUBLICKEY:
     +-		show_http_message(&type, &charset, &buffer);
     +-		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
     +-		    transport_anonymize_url(url.buf), curl_errorstr);
     ++		show_http_message_fatal(&type, &charset, &buffer,
     ++					_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
     ++					transport_anonymize_url(url.buf), curl_errorstr);
      +	case HTTP_RATE_LIMITED:
     -+		show_http_message(&type, &charset, &buffer);
     -+		die(_("rate limited by '%s', please try again later"),
     -+		    transport_anonymize_url(url.buf));
     ++		show_http_message_fatal(&type, &charset, &buffer,
     ++					_("rate limited by '%s', please try again later"),
     ++					transport_anonymize_url(url.buf));
       	default:
     - 		show_http_message(&type, &charset, &buffer);
     - 		die(_("unable to access '%s': %s"),
     +-		show_http_message(&type, &charset, &buffer);
     +-		die(_("unable to access '%s': %s"),
     +-		    transport_anonymize_url(url.buf), curl_errorstr);
     ++		show_http_message_fatal(&type, &charset, &buffer,
     ++					_("unable to access '%s': %s"),
     ++					transport_anonymize_url(url.buf), curl_errorstr);
     + 	}
     + 
     + 	if (options.verbosity && !starts_with(refs_url.buf, url.buf)) {
     +
     + ## strbuf.c ##
     +@@ strbuf.c: int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
     + 	if (!out)
     + 		return -1;
     + 
     +-	strbuf_attach(sb, out, len, len);
     ++	strbuf_attach(sb, out, len, len + 1);
     + 	return 0;
     + }
     + 
     +
     + ## t/lib-httpd.sh ##
     +@@ t/lib-httpd.sh: prepare_httpd() {
     + 	install_script error.sh
     + 	install_script apply-one-time-script.sh
     + 	install_script nph-custom-auth.sh
     ++	install_script http-429.sh
     + 
     + 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
     + 
     +
     + ## t/lib-httpd/apache.conf ##
     +@@ t/lib-httpd/apache.conf: SetEnv PERL_PATH ${PERL_PATH}
     + 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
     + 	SetEnv GIT_HTTP_EXPORT_ALL
     + </LocationMatch>
     ++<LocationMatch /http_429/>
     ++	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
     ++	SetEnv GIT_HTTP_EXPORT_ALL
     ++</LocationMatch>
     + <LocationMatch /smart_v0/>
     + 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
     + 	SetEnv GIT_HTTP_EXPORT_ALL
     +@@ t/lib-httpd/apache.conf: ScriptAlias /broken_smart/ broken-smart-http.sh/
     + ScriptAlias /error_smart/ error-smart-http.sh/
     + ScriptAlias /error/ error.sh/
     + ScriptAliasMatch /one_time_script/(.*) apply-one-time-script.sh/$1
     ++ScriptAliasMatch /http_429/(.*) http-429.sh/$1
     + ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
     + <Directory ${GIT_EXEC_PATH}>
     + 	Options FollowSymlinks
     +@@ t/lib-httpd/apache.conf: ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
     + <Files apply-one-time-script.sh>
     + 	Options ExecCGI
     + </Files>
     ++<Files http-429.sh>
     ++	Options ExecCGI
     ++</Files>
     + <Files ${GIT_EXEC_PATH}/git-http-backend>
     + 	Options ExecCGI
     + </Files>
     +
     + ## t/lib-httpd/http-429.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++# Script to return HTTP 429 Too Many Requests responses for testing retry logic.
     ++# Usage: /http_429/<test-context>/<retry-after-value>/<repo-path>
     ++#
     ++# The test-context is a unique identifier for each test to isolate state files.
     ++# The retry-after-value can be:
     ++#   - A number (e.g., "1", "2", "100") - sets Retry-After header to that many seconds
     ++#   - "none" - no Retry-After header
     ++#   - "invalid" - invalid Retry-After format
     ++#   - "permanent" - always return 429 (never succeed)
     ++#   - An HTTP-date string (RFC 2822 format) - sets Retry-After to that date
     ++#
     ++# On first call, returns 429. On subsequent calls (after retry), forwards to git-http-backend
     ++# unless retry-after-value is "permanent".
     ++
     ++# Extract test context, retry-after value and repo path from PATH_INFO
     ++# PATH_INFO format: /<test-context>/<retry-after-value>/<repo-path>
     ++path_info="${PATH_INFO#/}"  # Remove leading slash
     ++test_context="${path_info%%/*}"  # Get first component (test context)
     ++remaining="${path_info#*/}"  # Get rest
     ++retry_after="${remaining%%/*}"  # Get second component (retry-after value)
     ++repo_path="${remaining#*/}"  # Get rest (repo path)
     ++
     ++# Extract repository name from repo_path (e.g., "repo.git" from "repo.git/info/refs")
     ++# The repo name is the first component before any "/"
     ++repo_name="${repo_path%%/*}"
     ++
     ++# Use current directory (HTTPD_ROOT_PATH) for state file
     ++# Create a safe filename from test_context, retry_after and repo_name
     ++# This ensures all requests for the same test context share the same state file
     ++safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
     ++state_file="http-429-state-${safe_name}"
     ++
     ++# Check if this is the first call (no state file exists)
     ++if test -f "$state_file"
     ++then
     ++	# Already returned 429 once, forward to git-http-backend
     ++	# Set PATH_INFO to just the repo path (without retry-after value)
     ++	# Set GIT_PROJECT_ROOT so git-http-backend can find the repository
     ++	# Use exec to replace this process so git-http-backend gets the updated environment
     ++	PATH_INFO="/$repo_path"
     ++	export PATH_INFO
     ++	# GIT_PROJECT_ROOT points to the document root where repositories are stored
     ++	# The script runs from HTTPD_ROOT_PATH, and www/ is the document root
     ++	if test -z "$GIT_PROJECT_ROOT"
     ++	then
     ++		# Construct path: current directory (HTTPD_ROOT_PATH) + /www
     ++		GIT_PROJECT_ROOT="$(pwd)/www"
     ++		export GIT_PROJECT_ROOT
     ++	fi
     ++	exec "$GIT_EXEC_PATH/git-http-backend"
     ++fi
     ++
     ++# Mark that we've returned 429
     ++touch "$state_file"
     ++
     ++# Output HTTP 429 response
     ++printf "Status: 429 Too Many Requests\r\n"
     ++
     ++# Set Retry-After header based on retry_after value
     ++case "$retry_after" in
     ++	none)
     ++		# No Retry-After header
     ++		;;
     ++	invalid)
     ++		printf "Retry-After: invalid-format-123abc\r\n"
     ++		;;
     ++	permanent)
     ++		# Always return 429, don't set state file for success
     ++		rm -f "$state_file"
     ++		printf "Retry-After: 1\r\n"
     ++		printf "Content-Type: text/plain\r\n"
     ++		printf "\r\n"
     ++		printf "Permanently rate limited\n"
     ++		exit 0
     ++		;;
     ++	*)
     ++		# Check if it's a number
     ++		case "$retry_after" in
     ++			[0-9]*)
     ++				# Numeric value
     ++				printf "Retry-After: %s\r\n" "$retry_after"
     ++				;;
     ++			*)
     ++				# Assume it's an HTTP-date format (passed as-is, URL decoded)
     ++				# Apache may URL-encode the path, so decode common URL-encoded characters
     ++				# %20 = space, %2C = comma, %3A = colon
     ++				retry_value=$(echo "$retry_after" | sed -e 's/%20/ /g' -e 's/%2C/,/g' -e 's/%3A/:/g')
     ++				printf "Retry-After: %s\r\n" "$retry_value"
     ++				;;
     ++		esac
     ++		;;
     ++esac
     ++
     ++printf "Content-Type: text/plain\r\n"
     ++printf "\r\n"
     ++printf "Rate limited\n"
      
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
     @@ t/t5584-http-429-retry.sh (new)
      +	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" config http.receivepack true
      +'
      +
     -+test_expect_success 'HTTP 429 with retries disabled (maxRetries=0) fails immediately' '
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Retry-After: 1\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited\n"
     -+	cat "$1" >/dev/null
     -+	EOF
     ++# This test suite uses a special HTTP 429 endpoint at /http_429/ that simulates
     ++# rate limiting. The endpoint format is:
     ++#   /http_429/<test-context>/<retry-after-value>/<repo-path>
     ++# The http-429.sh script (in t/lib-httpd) returns a 429 response with the
     ++# specified Retry-After header on the first request for each test context,
     ++# then forwards subsequent requests to git-http-backend. Each test context
     ++# is isolated, allowing multiple tests to run independently.
      +
     ++test_expect_success 'HTTP 429 with retries disabled (maxRetries=0) fails immediately' '
      +	# Set maxRetries to 0 (disabled)
      +	test_config http.maxRetries 0 &&
      +	test_config http.retryAfter 1 &&
      +
      +	# Should fail immediately without any retry attempt
     -+	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
     ++	test_must_fail git ls-remote "$HTTPD_URL/http_429/retries-disabled/1/repo.git" 2>err &&
      +
      +	# Verify no retry happened (no "waiting" message in stderr)
     -+	! grep -i "waiting.*retry" err &&
     -+
     -+	# The one-time script will be consumed on first request (not a retry)
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep ! -i "waiting.*retry" err
      +'
      +
      +test_expect_success 'HTTP 429 permanent should fail after max retries' '
     -+	# Install a permanent error script to prove retries are limited
     -+	write_script "$HTTPD_ROOT_PATH/http-429-permanent.sh" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Retry-After: 1\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Permanently rate limited\n"
     -+	EOF
     -+
      +	# Enable retries with a limit
      +	test_config http.maxRetries 2 &&
      +
      +	# Git should retry but eventually fail when 429 persists
     -+	test_must_fail git ls-remote "$HTTPD_URL/error/http-429-permanent.sh/repo.git" 2>err
     ++	test_must_fail git ls-remote "$HTTPD_URL/http_429/permanent-fail/permanent/repo.git" 2>err
      +'
      +
      +test_expect_success 'HTTP 429 with Retry-After is retried and succeeds' '
     -+	# Create a one-time script that returns 429 with Retry-After header
     -+	# on the first request. Subsequent requests will succeed.
     -+	# This contrasts with the permanent 429 above - proving retry works
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	# Return HTTP 429 response instead of git response
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Retry-After: 1\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited - please retry after 1 second\n"
     -+	# Output something different from input so the script gets removed
     -+	cat "$1" >/dev/null
     -+	EOF
     -+
      +	# Enable retries
      +	test_config http.maxRetries 3 &&
      +
      +	# Git should retry after receiving 429 and eventually succeed
     -+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
     -+	test_grep "refs/heads/" output &&
     -+
     -+	# The one-time script should have been consumed (proving retry happened)
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	git ls-remote "$HTTPD_URL/http_429/retry-succeeds/1/repo.git" >output 2>err &&
     ++	test_grep "refs/heads/" output
      +'
      +
      +test_expect_success 'HTTP 429 without Retry-After uses configured default' '
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited - no retry info\n"
     -+	cat "$1" >/dev/null
     -+	EOF
     -+
      +	# Enable retries and configure default delay
      +	test_config http.maxRetries 3 &&
      +	test_config http.retryAfter 1 &&
      +
      +	# Git should retry using configured default and succeed
     -+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
     -+	test_grep "refs/heads/" output &&
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	git ls-remote "$HTTPD_URL/http_429/no-retry-after-header/none/repo.git" >output 2>err &&
     ++	test_grep "refs/heads/" output
      +'
      +
      +test_expect_success 'HTTP 429 retry delays are respected' '
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Retry-After: 2\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited\n"
     -+	cat "$1" >/dev/null
     -+	EOF
     -+
      +	# Enable retries
      +	test_config http.maxRetries 3 &&
      +
      +	# Time the operation - it should take at least 2 seconds due to retry delay
      +	start=$(date +%s) &&
     -+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
     ++	git ls-remote "$HTTPD_URL/http_429/retry-delays-respected/2/repo.git" >output 2>err &&
      +	end=$(date +%s) &&
      +	duration=$((end - start)) &&
      +
      +	# Verify it took at least 2 seconds (allowing some tolerance)
      +	test "$duration" -ge 1 &&
     -+	test_grep "refs/heads/" output &&
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep "refs/heads/" output
      +'
      +
      +test_expect_success 'HTTP 429 fails immediately if Retry-After exceeds http.maxRetryTime' '
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Retry-After: 100\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited with long delay\n"
     -+	cat "$1" >/dev/null
     -+	EOF
     -+
      +	# Configure max retry time to 3 seconds (much less than requested 100)
      +	test_config http.maxRetries 3 &&
      +	test_config http.maxRetryTime 3 &&
      +
      +	# Should fail immediately without waiting
      +	start=$(date +%s) &&
     -+	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
     ++	test_must_fail git ls-remote "$HTTPD_URL/http_429/retry-after-exceeds-max-time/100/repo.git" 2>err &&
      +	end=$(date +%s) &&
      +	duration=$((end - start)) &&
      +
      +	# Should fail quickly (less than 2 seconds, no 100 second wait)
      +	test "$duration" -lt 2 &&
     -+	test_grep "exceeds http.maxRetryTime" err &&
     -+
     -+	# The one-time script will be consumed on first request
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep "exceeds http.maxRetryTime" err
      +'
      +
      +test_expect_success 'HTTP 429 fails if configured http.retryAfter exceeds http.maxRetryTime' '
      +	# Test misconfiguration: retryAfter > maxRetryTime
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited without header\n"
     -+	cat "$1" >/dev/null
     -+	EOF
     -+
      +	# Configure retryAfter larger than maxRetryTime
      +	test_config http.maxRetries 3 &&
      +	test_config http.retryAfter 100 &&
     @@ t/t5584-http-429-retry.sh (new)
      +
      +	# Should fail immediately with configuration error
      +	start=$(date +%s) &&
     -+	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
     ++	test_must_fail git ls-remote "$HTTPD_URL/http_429/config-retry-after-exceeds-max-time/none/repo.git" 2>err &&
      +	end=$(date +%s) &&
      +	duration=$((end - start)) &&
      +
     @@ t/t5584-http-429-retry.sh (new)
      +		test_done
      +	fi &&
      +
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF &&
     -+	printf "Status: 429 Too Many Requests\\r\\n"
     -+	printf "Retry-After: $future_date\\r\\n"
     -+	printf "Content-Type: text/plain\\r\\n"
     -+	printf "\\r\\n"
     -+	printf "Rate limited with HTTP-date\\n"
     -+	cat "\$1" >/dev/null
     -+	EOF
     ++	# URL-encode the date (replace spaces with %20)
     ++	future_date_encoded=$(echo "$future_date" | sed "s/ /%20/g") &&
      +
      +	# Enable retries
      +	test_config http.maxRetries 3 &&
      +
      +	# Git should parse the HTTP-date and retry after the delay
      +	start=$(date +%s) &&
     -+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
     ++	git ls-remote "$HTTPD_URL/http_429/http-date-format/$future_date_encoded/repo.git" >output 2>err &&
      +	end=$(date +%s) &&
      +	duration=$((end - start)) &&
      +
      +	# Should take at least 1 second (allowing tolerance for processing time)
      +	test "$duration" -ge 1 &&
     -+	test_grep "refs/heads/" output &&
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep "refs/heads/" output
      +'
      +
      +test_expect_success 'HTTP 429 with HTTP-date exceeding maxRetryTime fails immediately' '
     @@ t/t5584-http-429-retry.sh (new)
      +		test_done
      +	fi &&
      +
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF &&
     -+	printf "Status: 429 Too Many Requests\\r\\n"
     -+	printf "Retry-After: $future_date\\r\\n"
     -+	printf "Content-Type: text/plain\\r\\n"
     -+	printf "\\r\\n"
     -+	printf "Rate limited with long HTTP-date\\n"
     -+	cat "\$1" >/dev/null
     -+	EOF
     ++	# URL-encode the date (replace spaces with %20)
     ++	future_date_encoded=$(echo "$future_date" | sed "s/ /%20/g") &&
      +
      +	# Configure max retry time much less than the 200 second delay
      +	test_config http.maxRetries 3 &&
     @@ t/t5584-http-429-retry.sh (new)
      +
      +	# Should fail immediately without waiting 200 seconds
      +	start=$(date +%s) &&
     -+	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
     ++	test_must_fail git ls-remote "$HTTPD_URL/http_429/http-date-exceeds-max-time/$future_date_encoded/repo.git" 2>err &&
      +	end=$(date +%s) &&
      +	duration=$((end - start)) &&
      +
      +	# Should fail quickly (not wait 200 seconds)
      +	test "$duration" -lt 2 &&
     -+	test_grep "exceeds http.maxRetryTime" err &&
     -+
     -+	# The one-time script will be consumed on first request
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep "exceeds http.maxRetryTime" err
      +'
      +
      +test_expect_success 'HTTP 429 with past HTTP-date should not wait' '
     @@ t/t5584-http-429-retry.sh (new)
      +		test_done
      +	fi &&
      +
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF &&
     -+	printf "Status: 429 Too Many Requests\\r\\n"
     -+	printf "Retry-After: $past_date\\r\\n"
     -+	printf "Content-Type: text/plain\\r\\n"
     -+	printf "\\r\\n"
     -+	printf "Rate limited with past date\\n"
     -+	cat "\$1" >/dev/null
     -+	EOF
     ++	# URL-encode the date (replace spaces with %20)
     ++	past_date_encoded=$(echo "$past_date" | sed "s/ /%20/g") &&
      +
      +	# Enable retries
      +	test_config http.maxRetries 3 &&
      +
      +	# Git should retry immediately without waiting
      +	start=$(date +%s) &&
     -+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
     ++	git ls-remote "$HTTPD_URL/http_429/past-http-date/$past_date_encoded/repo.git" >output 2>err &&
      +	end=$(date +%s) &&
      +	duration=$((end - start)) &&
      +
      +	# Should complete quickly (less than 2 seconds)
      +	test "$duration" -lt 2 &&
     -+	test_grep "refs/heads/" output &&
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep "refs/heads/" output
      +'
      +
      +test_expect_success 'HTTP 429 with invalid Retry-After format uses configured default' '
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Retry-After: invalid-format-123abc\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited with malformed header\n"
     -+	cat "$1" >/dev/null
     -+	EOF
     -+
      +	# Configure default retry-after
      +	test_config http.maxRetries 3 &&
      +	test_config http.retryAfter 1 &&
      +
      +	# Should use configured default (1 second) since header is invalid
      +	start=$(date +%s) &&
     -+	git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
     ++	git ls-remote "$HTTPD_URL/http_429/invalid-retry-after-format/invalid/repo.git" >output 2>err &&
      +	end=$(date +%s) &&
      +	duration=$((end - start)) &&
      +
      +	# Should take at least 1 second (the configured default)
      +	test "$duration" -ge 1 &&
      +	test_grep "refs/heads/" output &&
     -+	test_grep "waiting.*retry" err &&
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep "waiting.*retry" err
      +'
      +
      +test_expect_success 'HTTP 429 will not be retried without config' '
      +	# Default config means http.maxRetries=0 (retries disabled)
      +	# When 429 is received, it should fail immediately without retry
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Retry-After: 1\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited\n"
     -+	cat "$1" >/dev/null
     -+	EOF
     -+
      +	# Do NOT configure anything - use defaults (http.maxRetries defaults to 0)
      +
      +	# Should fail immediately without retry
     -+	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
     ++	test_must_fail git ls-remote "$HTTPD_URL/http_429/no-retry-without-config/1/repo.git" 2>err &&
      +
      +	# Verify no retry happened (no "waiting" message)
     -+	! grep -i "waiting.*retry" err &&
     ++	test_grep ! -i "waiting.*retry" err &&
      +
      +	# Should get 429 error
     -+	test_grep "429" err &&
     -+
     -+	# The one-time script should be consumed on first request
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep "429" err
      +'
      +
      +test_expect_success 'GIT_HTTP_RETRY_AFTER overrides http.retryAfter config' '
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited - no Retry-After header\n"
     -+	cat "$1" >/dev/null
     -+	EOF
     -+
      +	# Configure retryAfter to 10 seconds
      +	test_config http.maxRetries 3 &&
      +	test_config http.retryAfter 10 &&
      +
      +	# Override with environment variable to 1 second
      +	start=$(date +%s) &&
     -+	GIT_HTTP_RETRY_AFTER=1 git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
     ++	GIT_HTTP_RETRY_AFTER=1 git ls-remote "$HTTPD_URL/http_429/env-retry-after-override/none/repo.git" >output 2>err &&
      +	end=$(date +%s) &&
      +	duration=$((end - start)) &&
      +
     @@ t/t5584-http-429-retry.sh (new)
      +	test "$duration" -ge 1 &&
      +	test "$duration" -lt 5 &&
      +	test_grep "refs/heads/" output &&
     -+	test_grep "waiting.*retry" err &&
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep "waiting.*retry" err
      +'
      +
      +test_expect_success 'GIT_HTTP_MAX_RETRIES overrides http.maxRetries config' '
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Retry-After: 1\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited\n"
     -+	cat "$1" >/dev/null
     -+	EOF
     -+
      +	# Configure maxRetries to 0 (disabled)
      +	test_config http.maxRetries 0 &&
      +	test_config http.retryAfter 1 &&
      +
      +	# Override with environment variable to enable retries
     -+	GIT_HTTP_MAX_RETRIES=3 git ls-remote "$HTTPD_URL/one_time_script/repo.git" >output 2>err &&
     ++	GIT_HTTP_MAX_RETRIES=3 git ls-remote "$HTTPD_URL/http_429/env-max-retries-override/1/repo.git" >output 2>err &&
      +
      +	# Should retry (env var enables it despite config saying disabled)
      +	test_grep "refs/heads/" output &&
     -+	test_grep "waiting.*retry" err &&
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep "waiting.*retry" err
      +'
      +
      +test_expect_success 'GIT_HTTP_MAX_RETRY_TIME overrides http.maxRetryTime config' '
     -+	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
     -+	printf "Status: 429 Too Many Requests\r\n"
     -+	printf "Retry-After: 50\r\n"
     -+	printf "Content-Type: text/plain\r\n"
     -+	printf "\r\n"
     -+	printf "Rate limited with long delay\n"
     -+	cat "$1" >/dev/null
     -+	EOF
     -+
      +	# Configure maxRetryTime to 100 seconds (would accept 50 second delay)
      +	test_config http.maxRetries 3 &&
      +	test_config http.maxRetryTime 100 &&
     @@ t/t5584-http-429-retry.sh (new)
      +	# Override with environment variable to 10 seconds (should reject 50 second delay)
      +	start=$(date +%s) &&
      +	test_must_fail env GIT_HTTP_MAX_RETRY_TIME=10 \
     -+		git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
     ++		git ls-remote "$HTTPD_URL/http_429/env-max-retry-time-override/50/repo.git" 2>err &&
      +	end=$(date +%s) &&
      +	duration=$((end - start)) &&
      +
      +	# Should fail quickly (not wait 50 seconds) because env var limits to 10
      +	test "$duration" -lt 5 &&
     -+	test_grep "exceeds http.maxRetryTime" err &&
     -+	test_path_is_missing "$HTTPD_ROOT_PATH/one-time-script"
     ++	test_grep "exceeds http.maxRetryTime" err
      +'
      +
      +test_expect_success 'verify normal repository access still works' '
 2:  4382237922 < -:  ---------- remote-curl: fix memory leak in show_http_message()
 3:  adbcc0251f ! 2:  ad4495fc94 http: add trace2 logging for retry operations
     @@ http.c
       
       static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
       static int trace_curl_data = 1;
     +@@ http.c: void run_active_slot(struct active_request_slot *slot)
     + 
     + 	if (waiting_for_delay) {
     + 		warning(_("rate limited, waiting %ld seconds before retry"), slot->retry_delay_seconds);
     ++	trace2_data_intmax("http", the_repository, "http/retry-sleep-seconds",
     ++		slot->retry_delay_seconds);
     + 		start_time = slot->retry_delay_start;
     + 	}
     + 
     +@@ http.c: void run_active_slot(struct active_request_slot *slot)
     + 			}
     + 
     + 			if (elapsed_time.tv_sec >= slot->retry_delay_seconds) {
     ++				trace2_region_leave("http", "retry-sleep", the_repository);
     + 				slot->retry_delay_seconds = -1;
     + 				waiting_for_delay = 0;
     + 
      @@ http.c: static int handle_curl_result(struct slot_results *results)
     + 			return HTTP_REAUTH;
     + 		}
       	} else if (results->http_code == 429) {
     - 		/* Store the retry_after value for use in retry logic */
     - 		last_retry_after = results->retry_after;
      +		trace2_data_intmax("http", the_repository, "http/429-retry-after",
     -+				   last_retry_after);
     ++			results->retry_after);
       		return HTTP_RATE_LIMITED;
       	} else {
       		if (results->http_connectcode == 407)
     -@@ http.c: static void sleep_for_retry(long retry_after)
     - 	if (retry_after > 0) {
     - 		unsigned int remaining;
     - 		warning(_("rate limited, waiting %ld seconds before retry"), retry_after);
     -+		trace2_region_enter("http", "retry-sleep", the_repository);
     -+		trace2_data_intmax("http", the_repository, "http/retry-sleep-seconds",
     -+				retry_after);
     - 		remaining = sleep(retry_after);
     - 		while (remaining > 0) {
     - 			/* Sleep was interrupted, continue sleeping */
     - 			remaining = sleep(remaining);
     +@@ http.c: static void sleep_for_retry(struct active_request_slot *slot, long retry_after)
     + static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_after)
     + {
     + 	int retry_attempt = http_max_retries - *rate_limit_retries + 1;
     ++
     ++	trace2_data_intmax("http", the_repository, "http/429-retry-attempt",
     ++		retry_attempt);
     ++
     + 	if (*rate_limit_retries <= 0) {
     + 		/* Retries are disabled or exhausted */
     + 		if (http_max_retries > 0) {
     + 			error(_("too many rate limit retries, giving up"));
     ++			trace2_data_string("http", the_repository,
     ++				"http/429-error", "retries-exhausted");
       		}
     -+		trace2_region_leave("http", "retry-sleep", the_repository);
     + 		return -1;
       	}
     - }
     - 
     -@@ http.c: static int http_request_reauth(const char *url,
     - 			/* Handle rate limiting with retry logic */
     - 			int retry_attempt = http_max_retries - rate_limit_retries + 1;
     - 
     -+			trace2_data_intmax("http", the_repository, "http/429-retry-attempt",
     -+					retry_attempt);
     -+
     - 			if (rate_limit_retries <= 0) {
     - 				/* Retries are disabled or exhausted */
     - 				if (http_max_retries > 0) {
     - 					error(_("too many rate limit retries, giving up"));
     -+					trace2_data_string("http", the_repository,
     -+							"http/429-error", "retries-exhausted");
     - 				}
     - 				return HTTP_ERROR;
     - 			}
     -@@ http.c: static int http_request_reauth(const char *url,
     - 					error(_("rate limited (HTTP 429) requested %ld second delay, "
     - 						"exceeds http.maxRetryTime of %ld seconds"),
     - 					      last_retry_after, http_max_retry_time);
     -+					trace2_data_string("http", the_repository,
     -+							"http/429-error", "exceeds-max-retry-time");
     -+					trace2_data_intmax("http", the_repository,
     -+							"http/429-requested-delay", last_retry_after);
     - 					last_retry_after = -1; /* Reset after use */
     - 					return HTTP_ERROR;
     - 				}
     -@@ http.c: static int http_request_reauth(const char *url,
     - 					/* Not configured - exit with error */
     - 					error(_("rate limited (HTTP 429) and no Retry-After header provided. "
     - 						"Configure http.retryAfter or set GIT_HTTP_RETRY_AFTER."));
     -+					trace2_data_string("http", the_repository,
     -+							"http/429-error", "no-retry-after-config");
     - 					return HTTP_ERROR;
     - 				}
     --				/* Check if configured default exceeds maximum allowed */
     --				if (http_retry_after > http_max_retry_time) {
     --					error(_("configured http.retryAfter (%ld seconds) exceeds "
     --						"http.maxRetryTime (%ld seconds)"),
     --					      http_retry_after, http_max_retry_time);
     --					return HTTP_ERROR;
     --				}
     --				/* Use configured default retry-after value */
     --				sleep_for_retry(http_retry_after);
     -+			/* Check if configured default exceeds maximum allowed */
     -+			if (http_retry_after > http_max_retry_time) {
     -+				error(_("configured http.retryAfter (%ld seconds) exceeds "
     -+					"http.maxRetryTime (%ld seconds)"),
     -+				      http_retry_after, http_max_retry_time);
     -+				trace2_data_string("http", the_repository,
     -+						"http/429-error", "config-exceeds-max-retry-time");
     -+				return HTTP_ERROR;
     -+			}
     -+			/* Use configured default retry-after value */
     +@@ http.c: static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_aft
     + 			error(_("rate limited (HTTP 429) requested %ld second delay, "
     + 				"exceeds http.maxRetryTime of %ld seconds"),
     + 			      slot_retry_after, http_max_retry_time);
      +			trace2_data_string("http", the_repository,
     -+					"http/429-retry-source", "config-default");
     -+			sleep_for_retry(http_retry_after);
     - 			}
     - 		} else if (ret == HTTP_REAUTH) {
     - 			credential_fill(the_repository, &http_auth, 1);
     ++				  "http/429-error", "exceeds-max-retry-time");
     ++			trace2_data_intmax("http", the_repository,
     ++				  "http/429-requested-delay", slot_retry_after);
     + 			return -1;
     + 		}
     + 		return slot_retry_after;
     +@@ http.c: static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_aft
     + 			/* Not configured - exit with error */
     + 			error(_("rate limited (HTTP 429) and no Retry-After header provided. "
     + 				"Configure http.retryAfter or set GIT_HTTP_RETRY_AFTER."));
     ++			trace2_data_string("http", the_repository,
     ++				"http/429-error", "no-retry-after-config");
     + 			return -1;
     + 		}
     + 		/* Check if configured default exceeds maximum allowed */
     +@@ http.c: static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_aft
     + 			error(_("configured http.retryAfter (%ld seconds) exceeds "
     + 				"http.maxRetryTime (%ld seconds)"),
     + 			      http_retry_after, http_max_retry_time);
     ++			trace2_data_string("http", the_repository,
     ++					"http/429-error", "config-exceeds-max-retry-time");
     + 			return -1;
     + 		}
     +-
     ++		trace2_data_string("http", the_repository,
     ++			"http/429-retry-source", "config-default");
     + 		return http_retry_after;
     + 	}
     + }

-- 
gitgitgadget
