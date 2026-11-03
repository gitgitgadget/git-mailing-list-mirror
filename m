Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732250;
	b=ZxoqpsHh0CBo16HlijG5mywCpGTawD9yIh//ukrmbWzpYALVZMNNRSmqvP57vKpS9xXp
	 9fB7m5PWT1rCYtwzuF0P4Q+QaqMiGIRHvoCFXkCwvAYnvxVquxe2mmAcqKP8pw6gfnGq+
	 ql0bBM/0GRe28EhBYxVaoMUh/NJ22COeBkdwM+tf5+6EGQ0j6pSsKaY/HuEQQV7VpyJ3u
	 62CCmnIfg1iPjijFlGJjaRLhwtZm2bnjXN1W0gOwTAE+/zWX1DJkdA8RbnNSzB+wZUeRB
	 ZJ65Ux/HgNFfYjbnQk7fZkYsR76Ii30B7WW7aRJo/RwG+SVb7iPBcQGinZ+PES8+iIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=wAIwSBC1gDCTdDj1AONrZOBHKN1RJbfQ9Fl3/dh0mB8=;
	b=drEvzlS2sSmEjmE9Sc6MjXI3rGAy+hpO+Wve5LAz8OD3TIx5aKotKIKc5Txgi38HhJoM
	 4Mv1z1lMIHh1LHfVfb6YvMRbQ2OiKj6bGgY56qlLUgzalrRiA/bayrOHNE9gPUel3GvMh
	 ZpHC3BAz1nv2iN17X6XPNMOvn21ZFWz3Ag0pESaclWULUzKQZQmxQpREWUXYIWlcfAur0
	 mn7pG/Vw2UmpDcpvDEGGeONxxouTnKY0zIcq5Z5tyEnw/u5R20FkKY5jr7fiQMwDKKamT
	 L06JL7vrhjwObFeYL2dzxu2qf3zMYUi2I68ydVnBAMoyxm5sobq03bgB+IqjJkha85w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7Ma9xWp;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD9606A33A
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 18:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10BD9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X7Ma9xWp
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f1ca4132bso429284485a.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 10:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732249; x=1794337049; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wAIwSBC1gDCTdDj1AONrZOBHKN1RJbfQ9Fl3/dh0mB8=;
        b=X7Ma9xWpuL42ji5sLgHmhMPWvutFu/TVtAS60/nyhdykdCtRro6x9zDtkKP7dyXRPI
         72jeQNEeB1d9jyDVARzuwJgdmHHuybqPyFs36tObzVVBwCF+B9S6SJ/ON4Y6ziAKAWoz
         r7jdSQ6tURoTbHsn2T+MxTNOOGRTmDhdRKKumHzqdpMzjymUrNyX1CLIdNHFvRPlQuL4
         pdpwwrjVTTZtxDQYBTKq0GZ49uIineAHNU50DxN9XVKHtZasE6h1MczcYpiloeNnnCTG
         4COYQkJp0/0uZDlb0yYqVoZlNjNw8HaDZzpdkihZS9MF/9CdRTxOgXWf/Z1CNGW23KRB
         BDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732249; x=1794337049;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wAIwSBC1gDCTdDj1AONrZOBHKN1RJbfQ9Fl3/dh0mB8=;
        b=o/noFq8lxFM7G9rtrukiwovMRgUaR10SRl6+FW1/8Ug4R0LHleNZ5EU8D8yfApzMH9
         wfPbzyKZ3mTKR8RpuN57Ve+j2NC83RbrO1tajBwiFcZK3vgbtmQfiZfN6FEgdjz5za5w
         H3xX0Hjn0Vr5ivcpFuxr6Y34GRax3JlNbjUGU32FshNhMK0sjm1qzCIqNiUmnXrarZD1
         kA1cPmzkBXZEL5KMKsmF3EQbOJj3/KFoFTs0IQPqY1YFUJqkGBFC2qMQTIKH3qoaOTtQ
         Bv8zz73ugrZAf7i1XrZHFV0+8BD7t2iX2RvS76rfC4ztZ5bFTD7zNMQyKk5p7xUUOUnf
         jiDQ==
X-Gm-Message-State: APuU4Z/lodae5su0m0Xtzh0y+pos1fTAvdpPlzGVmfQ36FjCyeckuSuI
	kUyMFN2Vx/JyJ/vF3IonmEzuekZ/EpUhdG4wzTqacL0OxQQwnF/RBJvFSouW0hI7
X-Gm-Gg: AYBFou3C+ZdlMBiRH9TTr05FdRNu0HIkTTwM8V2VLm9SiAOxghc9eGuVfhXpTh/w9N3
	8+40mFQBqakd3+dUosVIHWq3Ddlw/6pS7DIrwErHHGFl9AdJu3/qbLRzYXRm5UQmXAYtYXz4RP5
	XvmvyAD1Fbw5HYqFf8M7rg963Gd2bi9didTZy41Oyki/XWqhWzx5Yajq4baVojESRU49lKxrYr+
	8dI5Zbts39jpqFPvgCkOY3+eWMLV2x/09RwsHWa44YVGppgIJc33IFGp9ifdheeXJIBnPyLzSQC
	BmuRWWULFevtmTYIEQrmI0HX1rjVnuDmCJ9OeYkdS0ba7Ch1M3k2aT8VCaQmPAGziod7jqP72z4
	4HCngpv3n1fVe7V5/it1p4uSmKV85IwVN1MusgqLYzopVlS0utOhrz4niAQWNTYE2ES0I419jcN
	4pwyib2UjSKJGdW8ADYkmPojNIC+FmAT3lKpOP9N2cOukdL+tzCSCy2JPfVe026V+73ox7QJlI7
	dUKuUEp4nhffGI9b/eNm6pQM8aSncemJzf/gePEh2RL+tSl5EjD/vMXi3xGgCugOhJhTi2QkV+r
	nlEzJNu20GGCovumtbgTZW8iLceNBzje
X-Received: by 2002:a05:620a:3954:b0:93e:e2a4:b0fe with SMTP id af79cd13be357-94421744b81mr2313358285a.66.1793732248460;
        Tue, 03 Nov 2026 10:57:28 -0800 (PST)
Received: from [127.0.0.1] ([20.124.87.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d468c574sm6249785a.6.2026.11.03.10.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:57:27 -0800 (PST)
Message-Id: <pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 18:57:23 +0000
Subject: [PATCH v2 0/4] http: exponential backoff, configurable status codes, and post_rpc() retries
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
    Ravi Mistry <rmistry@google.com>

Commit 640657ffd0 (http: add support for HTTP 429 rate limit retries,
2026-03-17) added HTTP 429 retry support using http.maxRetries,
http.retryAfter, and http.maxRetryTime.

In practice, when running Git against hosting backends and reverse proxies
under high concurrency, four gaps remain:

 1. Off-by-one retry count and Retry-After Trace2 timing: Because
    http_request_recoverable() pre-decrements the retry counter
    (--rate_limit_retries) in its loop condition, setting http.maxRetries=1
    performs 0 retries (and N configured retries performs N-1 retries). In
    addition, the Retry-After header is extracted after Trace2 logging has
    already run, so the http/429-retry-after Trace2 event always logs -1.

 2. No exponential backoff when Retry-After is absent: When a server does
    not send a Retry-After header, Git waits the same fixed http.retryAfter
    delay on every retry. If that delay is short (e.g., 1s), Git burns
    through all of its retries in just a few seconds before a busy server
    can recover. If that delay is long, even a brief glitch has to wait a
    long time on the first retry. Doubling the delay on each attempt (1s,
    2s, 4s, ...) keeps the first retry fast while giving the server more
    time to recover on later attempts, matching curl's own --retry behavior.

 3. Transient 5xx errors cannot be retried: Reverse proxies, load balancers,
    and Git backends frequently surface transient overload or connection
    resets as 502 Bad Gateway, 503 Service Unavailable, or 504 Gateway
    Timeout. Because 5xx errors are not universally transient across all
    environments, 429 should remain the default, with an opt-in config to
    specify additional status codes.

 4. HTTP POST requests are not retried: Git's existing 429 retry logic only
    covers HTTP GET requests (such as the initial /info/refs handshake).
    However, the actual data transfer during fetch and clone, as well as
    on-demand blob downloads in partial clones (during checkout, diff, or
    blame), are sent as HTTP POST requests (/git-upload-pack) via
    post_rpc(), which only retries authentication and immediately aborts on
    429 or 5xx.

This 4-patch series addresses all four gaps:

 * Patch 1/4 fixes the off-by-one retry count bug and extracts Retry-After
   in finish_active_slot() before Trace2 logging runs.
 * Patch 2/4 doubles http.retryAfter on each subsequent retry attempt (1s,
   2s, 4s, capped at http.maxRetryTime) when Retry-After is absent.
 * Patch 3/4 adds http.retryStatusCodes (and GIT_HTTP_RETRY_STATUS_CODES),
   defaulting to "429", so environments can opt into retrying codes like
   "429,502,503,504".
 * Patch 4/4 extracts a shared http_retry_wait() helper and extends retry
   support to HTTP POST requests in probe_rpc() and post_rpc() (while fixing
   a missing Content-Encoding: gzip header on retry).

Prior discussions:

 * https://lore.kernel.org/git/20201012184806.166251-3-smcallis@google.com/
 * https://lore.kernel.org/git/pull.2008.v6.git.1773752435.gitgitgadget@gmail.com/

Changes since v1:

 * Patch 1/4: Clarified in the commit message why the http_max_retries <= 0
   check was moved after the retry loop.
 * Patch 2/4: Passed http_max_retries - rate_limit_retries instead of adding
   a separate attempt counter, and clarified the http.retryAfter and
   http.maxRetryTime docs.
 * Patch 3/4: Restored (Too Many Requests) and clarified
   http.retryStatusCodes in the config docs, and moved the 400..599 range
   check to the top of is_retryable_http_code().
 * Patch 4/4: Added the attempt counter here when replacing
   rate_limit_retries with http_retry_wait().

Ravi Mistry (4):
  http: fix retry count and Retry-After timing
  http: add exponential backoff without Retry-After
  http: add http.retryStatusCodes config option
  remote-curl: retry transient HTTP errors in post_rpc()

 Documentation/config/http.adoc |  52 ++++++++---
 http.c                         | 125 ++++++++++++++++++--------
 http.h                         |  12 ++-
 remote-curl.c                  |  75 ++++++++--------
 t/lib-httpd/http-429.sh        |  63 ++++++++++++--
 t/t5584-http-429-retry.sh      | 155 +++++++++++++++++++++++++++++++++
 6 files changed, 385 insertions(+), 97 deletions(-)


base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2287%2Frmistry%2Fhttp-exponential-retries-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2287/rmistry/http-exponential-retries-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2287

Range-diff vs v1:

 1:  80b7f207f4 ! 1:  d53778dd46 http: fix retry count and Retry-After timing
     @@ Commit message
             --rate_limit_retries wraps from 0 to -1 (truthy in C).
      
             Fix this by checking http_max_retries > 0 && rate_limit_retries-- > 0
     -       in the loop condition and returning HTTP_ERROR when
     -       http_max_retries <= 0.
     +       in the loop condition and checking http_max_retries <= 0 after the
     +       loop (which handles both an initial 429 and a 429 after 401 re-auth
     +       without logging "retries-exhausted", making the pre-loop check
     +       redundant).
      
          2. In http_request(), CURLINFO_RETRY_AFTER is queried after
             run_one_slot() has already called handle_curl_result(), which logs
 2:  36cef34668 ! 2:  fe1e847ded http: add exponential backoff without Retry-After
     @@ Commit message
          http.retryAfter * 2^(attempt - 1)), clamping the delay at
          http.maxRetryTime. This keeps the first retry fast while giving the
          server more time to recover on later attempts, matching curl's own
     -    --retry behavior. When the server provides an explicit Retry-After
     -    header, continue to honor the server-provided delay (or fail fast if it
     -    exceeds http.maxRetryTime).
     +    --retry behavior (while keeping http.retryAfter's existing default of 0
     +    for immediate retries when unconfigured). When the server provides an
     +    explicit Retry-After header, continue to honor the server-provided delay
     +    (or fail fast if it exceeds http.maxRetryTime).
      
          Signed-off-by: Ravi Mistry <rmistry@google.com>
      
     @@ Documentation/config/http.adoc: http.keepAliveCount::
      +	Initial wait time in seconds before retrying when a server returns
       	HTTP 429 (Too Many Requests) without a Retry-After header.
      -	Defaults to 0 (retry immediately). When a Retry-After header is
     -+	Defaults to 0 (retry immediately). When set to a positive value and
     -+	no Retry-After header is present, the delay doubles on each
     -+	subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
     ++	Defaults to 0, which retries immediately without waiting on every
     ++	attempt (unless a Retry-After header is present). When set to a
     ++	positive value and no Retry-After header is present, the first
     ++	retry waits `http.retryAfter` seconds and the delay doubles on
     ++	each subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
      +	capped at `http.maxRetryTime`. When a Retry-After header is
       	present, its value takes precedence over this setting; however,
       	automatic use of the server-provided `Retry-After` header requires
       	libcurl 7.66.0 or later. On older versions, configure this setting
     -@@ Documentation/config/http.adoc: http.maxRetryTime::
     - 	handling HTTP 429 (Too Many Requests) responses. If the server
     - 	requests a delay (via Retry-After header) or if `http.retryAfter`
     - 	is configured with a value that exceeds this maximum, Git will fail
     +@@ Documentation/config/http.adoc: http.maxRetries::
     + 
     + http.maxRetryTime::
     + 	Maximum time in seconds to wait for a single retry attempt when
     +-	handling HTTP 429 (Too Many Requests) responses. If the server
     +-	requests a delay (via Retry-After header) or if `http.retryAfter`
     +-	is configured with a value that exceeds this maximum, Git will fail
      -	immediately rather than waiting. Default is 300 seconds (5 minutes).
     -+	immediately rather than waiting. Exponentially backed-off delays
     -+	computed from `http.retryAfter` are capped at this maximum. Default
     -+	is 300 seconds (5 minutes).
     ++	handling HTTP 429 (Too Many Requests) responses.
     ++	If the server requests a delay (via Retry-After header) or if the
     ++	configured `http.retryAfter` value itself exceeds this maximum,
     ++	Git will fail immediately rather than waiting. Exponentially
     ++	backed-off delays computed from `http.retryAfter`, however, are
     ++	capped at this maximum rather than causing an immediate failure.
     ++	Default is 300 seconds (5 minutes).
       	Can be overridden by the `GIT_HTTP_MAX_RETRY_TIME` environment
       	variable. See also `http.retryAfter` and `http.maxRetries`.
       
     @@ http.c: static long handle_rate_limit_retry(long slot_retry_after)
       	}
       }
       
     -@@ http.c: static int http_request_recoverable(const char *url,
     - 	int i = 3;
     - 	int ret;
     - 	int rate_limit_retries = http_max_retries;
     -+	int attempt = 0;
     - 
     - 	if (!options)
     - 		options = &empty_opts;
      @@ http.c: static int http_request_recoverable(const char *url,
       			BUG("Unknown http_request target");
       		}
       		if (ret == HTTP_RATE_LIMITED) {
      -			retry_delay = handle_rate_limit_retry(options->retry_after);
     -+			retry_delay = handle_rate_limit_retry(options->retry_after, ++attempt);
     ++			retry_delay = handle_rate_limit_retry(
     ++				options->retry_after,
     ++				http_max_retries - rate_limit_retries);
       			if (retry_delay < 0)
       				return HTTP_ERROR;
       
 3:  f56ab2afaa ! 3:  6510dddc39 http: add http.retryStatusCodes config option
     @@ Documentation/config/http.adoc: http.keepAliveCount::
       http.retryAfter::
       	Initial wait time in seconds before retrying when a server returns
      -	HTTP 429 (Too Many Requests) without a Retry-After header.
     -+	a retryable HTTP status code (HTTP 429 by default) without a
     -+	Retry-After header.
     - 	Defaults to 0 (retry immediately). When set to a positive value and
     - 	no Retry-After header is present, the delay doubles on each
     - 	subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
     ++	a retryable HTTP status code without a Retry-After header. The
     ++	set of retryable status codes is configured by
     ++	`http.retryStatusCodes`, which includes only HTTP 429 (Too Many
     ++	Requests) by default.
     + 	Defaults to 0, which retries immediately without waiting on every
     + 	attempt (unless a Retry-After header is present). When set to a
     + 	positive value and no Retry-After header is present, the first
      @@ Documentation/config/http.adoc: http.retryAfter::
       	libcurl 7.66.0 or later. On older versions, configure this setting
       	manually to control the retry delay. Can be overridden by the
     @@ Documentation/config/http.adoc: http.retryAfter::
      -	Maximum number of times to retry after receiving HTTP 429 (Too Many
      -	Requests) responses. Set to 0 (the default) to disable retries.
      +	Maximum number of times to retry after receiving a retryable HTTP
     -+	status code (HTTP 429 by default). Set to 0 (the default) to disable
     -+	retries.
     ++	status code. The set of retryable status codes is configured by
     ++	`http.retryStatusCodes`, which includes only HTTP 429 (Too Many
     ++	Requests) by default. Set to 0 (the default) to disable retries.
       	Can be overridden by the `GIT_HTTP_MAX_RETRIES` environment variable.
      -	See also `http.retryAfter` and `http.maxRetryTime`.
      +	See also `http.retryAfter`, `http.maxRetryTime`, and
     @@ Documentation/config/http.adoc: http.retryAfter::
       
       http.maxRetryTime::
       	Maximum time in seconds to wait for a single retry attempt when
     --	handling HTTP 429 (Too Many Requests) responses. If the server
     --	requests a delay (via Retry-After header) or if `http.retryAfter`
     -+	handling a retryable HTTP status code (HTTP 429 by default). If the
     -+	server requests a delay (via Retry-After header) or if `http.retryAfter`
     - 	is configured with a value that exceeds this maximum, Git will fail
     - 	immediately rather than waiting. Exponentially backed-off delays
     - 	computed from `http.retryAfter` are capped at this maximum. Default
     - 	is 300 seconds (5 minutes).
     +-	handling HTTP 429 (Too Many Requests) responses.
     ++	handling a retryable HTTP status code. The set of retryable
     ++	status codes is configured by `http.retryStatusCodes`, which
     ++	includes only HTTP 429 (Too Many Requests) by default.
     + 	If the server requests a delay (via Retry-After header) or if the
     + 	configured `http.retryAfter` value itself exceeds this maximum,
     + 	Git will fail immediately rather than waiting. Exponentially
     +@@ Documentation/config/http.adoc: http.maxRetryTime::
     + 	capped at this maximum rather than causing an immediate failure.
     + 	Default is 300 seconds (5 minutes).
       	Can be overridden by the `GIT_HTTP_MAX_RETRY_TIME` environment
      -	variable. See also `http.retryAfter` and `http.maxRetries`.
      +	variable. See also `http.retryAfter`, `http.maxRetries`, and
     @@ Documentation/config/http.adoc: http.retryAfter::
      +http.retryStatusCodes::
      +	Comma- or whitespace-separated list of HTTP status codes (in the
      +	400..599 range) that should be retried up to `http.maxRetries`
     -+	times. Defaults to `429`. For example, setting this to
     -+	`429,502,503,504` also retries transient `5xx` gateway and
     ++	times. Defaults to `429` (Too Many Requests). For example, setting
     ++	this to `429,502,503,504` also retries transient `5xx` gateway and
      +	service-unavailable errors. Can be overridden by the
      +	`GIT_HTTP_RETRY_STATUS_CODES` environment variable.
      +	See also `http.maxRetries`, `http.retryAfter`, and
     @@ http.c: void normalize_curl_result(CURLcode *result, long http_code,
      +	const char *p = http_retry_status_codes ? http_retry_status_codes : "429";
      +	char *end;
      +
     -+	for (; code >= 400 && code < 600 && *p; p = end) {
     ++	if (code < 400 || code >= 600)
     ++		return 0;
     ++
     ++	for (; *p; p = end) {
      +		while (*p == ',' || isspace(*p))
      +			p++;
      +		if (strtol(p, &end, 10) == code && end > p &&
 4:  52819accc8 ! 4:  786964ff00 remote-curl: retry transient HTTP errors in post_rpc()
     @@ http.c: static int http_request_recoverable(const char *url,
       	int i = 3;
       	int ret;
      -	int rate_limit_retries = http_max_retries;
     - 	int attempt = 0;
     ++	int attempt = 0;
       
       	if (!options)
     + 		options = &empty_opts;
      @@ http.c: static int http_request_recoverable(const char *url,
       	}
       
     @@ http.c: static int http_request_recoverable(const char *url,
       			BUG("Unknown http_request target");
       		}
      -		if (ret == HTTP_RATE_LIMITED) {
     --			retry_delay = handle_rate_limit_retry(options->retry_after, ++attempt);
     +-			retry_delay = handle_rate_limit_retry(
     +-				options->retry_after,
     +-				http_max_retries - rate_limit_retries);
      -			if (retry_delay < 0)
      -				return HTTP_ERROR;
      -

-- 
gitgitgadget
