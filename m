Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103887;
	b=tzTQ8/TdDExuZOu72lmAxwOSx20A+qvMa/sZTQMQolooNoHj2tLi50ncK4QAuH2bmuv7
	 A1XG9vcFuYmEZyebw/MphVWd6lFMfyVMzc+0hFPXoMiaIA2oa93CY1Y5wILImaiWC8tQR
	 0QqaLQc+T8D6QpOnp9OastcbLsqUvXeTB0teoLSg29B7ldLJJ2OkQxJgn8IUmB5tDvYiH
	 bf/wfEwia5rR0/QwvzUh3psI0jmy2i5LOVnkFDayzYMUmn67ZfwxzIHHBa8kzsJCHxvsA
	 HtKgIFt6xgzZCMSVqsy01eTCJHxGwPTDUSv+mPxnV6YfmhvMcpohne/pTxfQoeB4YjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=1II0VfIzP0w9ny005rS1vVlSVcJALLZpxawqLXfkFi4=;
	b=4Lgfw6KCZum04LpDG50D+K+mGYkr4aDwhICl1g6GPLR+cjO4uzD98nxasxrvkS8JUOjc
	 qXfO2brc6Q8Rt+nVo1e9bvhmfylxFYb0cd9o4a7Z5tdSyGFDuDzGqizDhYZ1cM4ViHAET
	 AZ6OijQLum6k8Rd3P4rYEPWmYeX5o0OKk0hi7V2aQMQuH6JqIY5QYIJ8PP1cNmYLgJRcA
	 aU1/nWdTPYCo8eS1Q6FoNauk8JsPke+ZBfzDN5fKpq/EBLvIrzW36237DM+d0jlIul3kb
	 gq7+tKkYnmKeOR0p/Qmw2lUvTF235gyejNj7rsHuHOep/0vVIMyOtCxT9jtG1Aoj6oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hIG1rIsA;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07691606A33A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07691606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hIG1rIsA
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2eff29ca765so9693295ad.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795103885; x=1795708685; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1II0VfIzP0w9ny005rS1vVlSVcJALLZpxawqLXfkFi4=;
        b=hIG1rIsAZBLOly+H8CD604sBrGm8E+I7jtJD6g/pDbkJs3DMenCp9jat/NFTfNnRHu
         FSoOpnit1QIrUej/o1jFlKSnRYLwwv4Dz9CNo9A/K25aN/wYiLUyY+sPqgHjlwXCX1Yk
         NckXqNXJpMcJ7yme4TNnXuS+cBcirzlvzYJh+0W3KFAV8qJPX0PLcJJUriSAVq7UBqQs
         h9NWimM1y8WGGAlAhP1rEHyKtKAcvtZeH3BT1Yv0dMZNd6Ra1ahOerezSbKdsyO4Jia3
         +m7tOvHUYmEZ/toC5woSDamr3tlI8MTWX6ePyPsd/WOg/bOcI4JrAGb1pZh7prnyQKUL
         IhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103885; x=1795708685;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1II0VfIzP0w9ny005rS1vVlSVcJALLZpxawqLXfkFi4=;
        b=EnrQQDFNwPDM1f6nQckRPCt/aClLgPoWQS5zOgKJnEnQ01bG1QetCkWN3JjJzZTWDy
         2PXvei4Cz1d1dsxYJstVJcJgzlz1Mbv7BjpmVZpD3JCGglBLCVtIuIzs3lCEB6kbNXSU
         n66xSJz+c3+yNGPltd4dA4swMuAOFcqaIIIzV4FgglLMaoEhZ8nA2a0zXuWHhmFvP9nP
         jnAgDvwSVuBObzGR4WDmux0rOdPNmXeZNNNEkSgFDAYEp41FkvlpYpQRCvK+2SRMzWJ5
         jmEJGhcj+oCeISO00Evy5WdUUd5HXFAbOfFDfaIi9xuQIjWVP8mi7G9w2oEiw+t5M7BN
         e6jQ==
X-Gm-Message-State: APuU4Z9FGhSE3WpHI5DFrdZ6VCztyM5RPk+k8Eo2sTaviZmEKthMiO/r
	6+YkncQa0tjFYQqUCkc5vDb67LLJZrlDymURP6tLLUSeY4G7wlE/iY1lubZ5cQ==
X-Gm-Gg: AZFdTZfdoULVD6EHkFH+18TKF/3dnNV9nNEEKu7hoH6d2rJKfwQTEuhSlbI8sXFrMG4
	/DGkg9NKJu89k1UzOTSjc51Kh9SjqRCMY3IRSJBzxlq/GhhNXt/ybuYLGN1nAxcsL8MZn3nRpVv
	GAHr/r1rACapPUhIz3s4V1Epdp/e+tGUQcAo/icRPxo5TC0x8cwMicwJ0su4etv91iajwfH+JZR
	vPlwGx5WzoydD3IZo35hLtrg1alVLiZyQ37iD6K4y+Wjedxq8Bce/C7yXq4HP6A8IDWh45mRYtB
	akZHoZTYcT6IeGRDPwYj3gH3K8jQ7VruSvbxzI7jg3CNqOPZoka+xucu0Ah4xU83jmiOm5gMhL1
	opTIC96nmqji/lvfoDW8FRPrVX/eC8yEPIbvTs+LDzO8vAyt2Rc+4YsHWgxv8Evao9lKyxICeYV
	u19fQVGxTMxyWIFSxa1TIPwBCCO7suXKqLDU057SV0cB3ym3sfOx1aL5tDeQDeRqWMHMmEgRiEk
	nQU8NW+lIV65TqcURYZoKYiPwUHuGd1BS4N7bV8vkvoIQXP8LtC9JQixmd1WgggilSgjGF3uP96
	5eDbcMOURF1cEVvSQSHE1OSBwa9BQy30HGM=
X-Received: by 2002:a17:902:ebd2:b0:2e9:970c:2c9 with SMTP id d9443c01a7336-2f03f1c75bdmr2854855ad.42.1795103884869;
        Thu, 19 Nov 2026 07:58:04 -0800 (PST)
Received: from [127.0.0.1] ([172.171.119.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c192asm1785995ad.19.2026.11.19.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:58:04 -0800 (PST)
Message-Id: <pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Nov 2026 15:57:58 +0000
Subject: [PATCH v4 0/5] http: exponential backoff, configurable status codes, and post_rpc() retries
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

 2. No exponential backoff (and 0s default) when Retry-After is absent: When
    a server does not send a Retry-After header, Git defaults
    http.retryAfter to 0 (retrying immediately in a tight loop) and waits
    the same fixed delay on every retry when configured. Doubling the delay
    on each attempt and defaulting http.retryAfter to 10 seconds (10s, 20s,
    40s, ...) gives overloaded servers breathing room while keeping
    interactive commands reasonably responsive.

 3. Transient 5xx errors cannot be retried: While service providers are
    expected to return 429 when rate-limiting or overloaded, reverse
    proxies, CDNs, client-side proxies, and servers also surface transient
    connection drops, timeouts, or load shedding as 502, 503, or 504.
    Because 5xx errors are not universally transient across all setups, 429
    should remain the default, with an opt-in config to specify additional
    status codes as a temporary workaround while underlying infrastructure
    is fixed.

 4. Read-only HTTP POST requests are not retried: Git's existing 429 retry
    logic only covers HTTP GET requests (such as the initial /info/refs
    handshake). However, the actual data transfer during fetch and clone, as
    well as on-demand blob downloads in partial clones (during checkout,
    diff, or blame), are sent as HTTP POST requests (/git-upload-pack) via
    post_rpc(), which only retries authentication and immediately aborts on
    429 or 5xx.

This 5-patch series addresses all four gaps:

 * Patch 1/5 fixes the off-by-one retry count bug and extracts Retry-After
   in finish_active_slot() before Trace2 logging runs.
 * Patch 2/5 doubles http.retryAfter on each subsequent retry attempt
   (capped at http.maxRetryTime) when Retry-After is absent.
 * Patch 3/5 adds http.retryStatusCodes (and GIT_HTTP_RETRY_STATUS_CODES),
   defaulting to "429", so environments can opt into retrying codes like
   "429,502,503,504".
 * Patch 4/5 extracts a shared http_retry_wait() helper and extends retry
   support in post_rpc() to read-only services ("git-upload-pack" and
   "git-upload-archive") without retrying "git-receive-pack" (git push),
   while fixing a missing Content-Encoding: gzip header on retry.
 * Patch 5/5 changes the default of http.retryAfter from 0 to 10 seconds so
   Git does not immediately hammer a rate-limiting server when no
   Retry-After header is provided.

Prior discussions:

 * https://lore.kernel.org/git/20201012184806.166251-3-smcallis@google.com/
 * https://lore.kernel.org/git/pull.2008.v6.git.1773752435.gitgitgadget@gmail.com/

Changes since v3 (thanks to Patrick Steinhardt for the review):

 * Patches 1/5, 3/5, 4/5: Un-indented shell case arms in
   t/lib-httpd/http-429.sh to match CodingGuidelines.
 * Patches 2/5, 4/5: Changed the retry attempt counter from int to size_t.
 * Patch 3/5: Documented in http.retryStatusCodes that providers are
   expected to return 429 when rate-limiting or overloaded, and that
   configuring additional status codes is a temporary workaround while
   underlying provider or proxy infrastructure is fixed.
 * Patch 4/5: Restricted retries in post_rpc() to read-only services
   ("git-upload-pack" and "git-upload-archive") so "git-receive-pack" (git
   push) is not retried, documented the retried request types in
   http.maxRetries, and added a test covering push.
 * Patch 5/5: Inspected the Retry-After header via curl_easy_header() when
   CURLINFO_RETRY_AFTER <= 0 so an explicit "Retry-After: 0" or past
   HTTP-date retries immediately instead of falling back to the 10-second
   default, restored the past HTTP-date test in t5584, and added a test for
   "Retry-After: 0".

Changes since v2:

 * Patches 1/5..4/5: Unchanged from v2.
 * Added Patch 5/5 to default http.retryAfter to 10 seconds instead of 0
   when Retry-After is absent (per feedback from Junio C Hamano and brian m.
   carlson).

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

Ravi Mistry (5):
  http: fix retry count and Retry-After timing
  http: add exponential backoff without Retry-After
  http: add http.retryStatusCodes config option
  remote-curl: retry transient HTTP errors in post_rpc()
  http: default http.retryAfter to 10 seconds

 Documentation/config/http.adoc |  67 ++++++++---
 git-curl-compat.h              |   8 ++
 http.c                         | 169 ++++++++++++++++++++-------
 http.h                         |  12 +-
 remote-curl.c                  |  82 +++++++------
 t/lib-httpd/http-429.sh        |  63 ++++++++--
 t/t5584-http-429-retry.sh      | 205 ++++++++++++++++++++++++++++++++-
 7 files changed, 502 insertions(+), 104 deletions(-)


base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2287%2Frmistry%2Fhttp-exponential-retries-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2287/rmistry/http-exponential-retries-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2287

Range-diff vs v3:

 1:  d53778dd46 ! 1:  d4d3407728 http: fix retry count and Retry-After timing
     @@ t/lib-httpd/http-429.sh: repo_name="${repo_path%%/*}"
      -if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
      +max_fails=1
      +case "$test_context" in
     -+	*-fail-2*) max_fails=2 ;;
     -+	*-fail-3*) max_fails=3 ;;
     ++*-fail-2*) max_fails=2 ;;
     ++*-fail-3*) max_fails=3 ;;
      +esac
      +
      +should_fail=0
 2:  fe1e847ded ! 2:  fc5dbf8aea http: add exponential backoff without Retry-After
     @@ http.c: static int update_url_from_redirect(struct strbuf *base,
        * http.maxRetryTime), otherwise returns the delay in seconds (>= 0).
        */
      -static long handle_rate_limit_retry(long slot_retry_after)
     -+static long handle_rate_limit_retry(long slot_retry_after, int attempt)
     ++static long handle_rate_limit_retry(long slot_retry_after, size_t attempt)
       {
       	/* Use the slot-specific retry_after value or configured default */
       	if (slot_retry_after >= 0) {
     @@ http.c: static long handle_rate_limit_retry(long slot_retry_after)
       		trace2_data_string("http", the_repository,
       			"http/429-retry-source", "config-default");
      -		return http_retry_after;
     -+		for (int a = 1; a < attempt && delay > 0; a++) {
     ++		for (size_t a = 1; a < attempt && delay > 0; a++) {
      +			if (delay >= http_max_retry_time - delay) {
      +				delay = http_max_retry_time;
      +				break;
     @@ http.c: static int http_request_recoverable(const char *url,
      -			retry_delay = handle_rate_limit_retry(options->retry_after);
      +			retry_delay = handle_rate_limit_retry(
      +				options->retry_after,
     -+				http_max_retries - rate_limit_retries);
     ++				(size_t)(http_max_retries - rate_limit_retries));
       			if (retry_delay < 0)
       				return HTTP_ERROR;
       
 3:  6510dddc39 ! 3:  8dc66bfca4 http: add http.retryStatusCodes config option
     @@ Commit message
      
          Commit 640657ffd0 (http: add support for HTTP 429 rate limit retries,
          2026-03-17) hardcoded HTTP 429 as the only status code eligible for
     -    retry. In practice, reverse proxies, load balancers, and Git hosting
     -    backends also return transient 5xx responses such as 502 Bad Gateway,
     -    503 Service Unavailable (which RFC 9110 section 10.2.3 defines to
     -    support Retry-After), and 504 Gateway Timeout during load shedding or
     -    upstream connection resets.
     +    retry. While service providers are expected to return 429 when
     +    rate-limiting or overloaded, in practice reverse proxies, CDNs,
     +    client-side proxies, and servers also return transient 502, 503, or 504
     +    errors when a connection drops, times out, or sheds load.
      
     -    Because 5xx responses are not universally transient across all
     -    environments, keep 429 as the default and introduce a new
     -    http.retryStatusCodes configuration option (and corresponding
     -    GIT_HTTP_RETRY_STATUS_CODES environment variable) accepting a comma- or
     -    whitespace-separated list of HTTP status codes in the 400..599 range
     -    (for example, "429,502,503,504").
     +    We should not retry 5xx responses unconditionally by default because in
     +    some setups they point to a permanently broken proxy or server. Keep 429
     +    as the default and introduce an http.retryStatusCodes configuration
     +    option (and corresponding GIT_HTTP_RETRY_STATUS_CODES environment
     +    variable) accepting a comma- or whitespace-separated list of HTTP status
     +    codes in the 400..599 range (for example, "429,502,503,504"), documented
     +    as a temporary workaround while underlying provider or proxy
     +    infrastructure is fixed.
      
          Keep the existing "rate limited" warning and error messages for HTTP
          429, and report the numeric status code (e.g., "HTTP 502, waiting <N>
     @@ Documentation/config/http.adoc: http.maxRetryTime::
      +http.retryStatusCodes::
      +	Comma- or whitespace-separated list of HTTP status codes (in the
      +	400..599 range) that should be retried up to `http.maxRetries`
     -+	times. Defaults to `429` (Too Many Requests). For example, setting
     -+	this to `429,502,503,504` also retries transient `5xx` gateway and
     -+	service-unavailable errors. Can be overridden by the
     -+	`GIT_HTTP_RETRY_STATUS_CODES` environment variable.
     ++	times. Defaults to `429` (Too Many Requests). Can be overridden by
     ++	the `GIT_HTTP_RETRY_STATUS_CODES` environment variable.
      +	See also `http.maxRetries`, `http.retryAfter`, and
      +	`http.maxRetryTime`.
     +++
     ++Service providers are expected to return HTTP 429 when rate-limiting or
     ++overloaded. Configuring additional status codes (for example,
     ++`429,502,503,504`) is intended only as a temporary workaround while the
     ++underlying provider or proxy infrastructure is fixed.
       
       http.noEPSV::
       	A boolean which disables using of EPSV ftp command by curl.
     @@ t/lib-httpd/http-429.sh: then
      +# Output HTTP 429 (or configured status) response
      +status_line="429 Too Many Requests"
      +case "$test_context" in
     -+	*-status-502*) status_line="502 Bad Gateway" ;;
     -+	*-status-503*) status_line="503 Service Unavailable" ;;
     -+	*-status-504*) status_line="504 Gateway Timeout" ;;
     ++*-status-502*) status_line="502 Bad Gateway" ;;
     ++*-status-503*) status_line="503 Service Unavailable" ;;
     ++*-status-504*) status_line="504 Gateway Timeout" ;;
      +esac
      +printf "Status: %s\r\n" "$status_line"
       
 4:  786964ff00 ! 4:  ca247f390c remote-curl: retry transient HTTP errors in post_rpc()
     @@ Commit message
          429 or 5xx.
      
          Extract the retry wait logic from http_request_recoverable() into a
     -    shared http_retry_wait() helper and use it to retry transient HTTP
     -    errors in probe_rpc() and post_rpc(). Also defer reporting RPC errors
     -    until retries are exhausted, and re-attach the "Content-Encoding: gzip"
     -    header when retrying a compressed request.
     +    shared http_retry_wait() helper and use it in post_rpc() to retry
     +    transient HTTP errors for read-only services ("git-upload-pack" and
     +    "git-upload-archive"). Do not retry "git-receive-pack" (git push), since
     +    retrying a push POST after a 502 or 504 is not safe if the remote
     +    already processed the request. Also defer reporting RPC errors until
     +    retries are exhausted, and re-attach the "Content-Encoding: gzip" header
     +    when retrying a compressed request.
      
          Signed-off-by: Ravi Mistry <rmistry@google.com>
      
     + ## Documentation/config/http.adoc ##
     +@@ Documentation/config/http.adoc: http.maxRetries::
     + 	Maximum number of times to retry after receiving a retryable HTTP
     + 	status code. The set of retryable status codes is configured by
     + 	`http.retryStatusCodes`, which includes only HTTP 429 (Too Many
     +-	Requests) by default. Set to 0 (the default) to disable retries.
     ++	Requests) by default. Retries apply to HTTP GET requests and
     ++	read-only smart-HTTP POST requests (`git-upload-pack` and
     ++	`git-upload-archive`). Set to 0 (the default) to disable retries.
     + 	Can be overridden by the `GIT_HTTP_MAX_RETRIES` environment variable.
     + 	See also `http.retryAfter`, `http.maxRetryTime`, and
     + 	`http.retryStatusCodes`.
     +
       ## http.c ##
     -@@ http.c: static long handle_rate_limit_retry(long slot_retry_after, int attempt)
     +@@ http.c: static long handle_rate_limit_retry(long slot_retry_after, size_t attempt)
       	}
       }
       
     -+int http_retry_wait(long http_code, long slot_retry_after, int attempt)
     ++int http_retry_wait(long http_code, long slot_retry_after, size_t attempt)
      +{
      +	long retry_delay;
      +
      +	if (http_max_retries <= 0)
      +		return -1;
     -+	if (attempt > http_max_retries) {
     ++	if (attempt > (size_t)http_max_retries) {
      +		trace2_data_string("http", the_repository,
      +				   "http/429-error", "retries-exhausted");
      +		return -1;
     @@ http.c: static int http_request_recoverable(const char *url,
       	int i = 3;
       	int ret;
      -	int rate_limit_retries = http_max_retries;
     -+	int attempt = 0;
     ++	size_t attempt = 0;
       
       	if (!options)
       		options = &empty_opts;
     @@ http.c: static int http_request_recoverable(const char *url,
      -		if (ret == HTTP_RATE_LIMITED) {
      -			retry_delay = handle_rate_limit_retry(
      -				options->retry_after,
     --				http_max_retries - rate_limit_retries);
     +-				(size_t)(http_max_retries - rate_limit_retries));
      -			if (retry_delay < 0)
      -				return HTTP_ERROR;
      -
     @@ http.c: static int http_request_recoverable(const char *url,
      -		return options->http_code == 429 ? HTTP_RATE_LIMITED : HTTP_ERROR;
      -	}
      +	if (ret == HTTP_RATE_LIMITED &&
     -+	    (http_max_retries <= 0 || attempt <= http_max_retries ||
     ++	    (http_max_retries <= 0 || attempt <= (size_t)http_max_retries ||
      +	     options->http_code != 429))
      +		return HTTP_ERROR;
       	return ret;
     @@ http.h: int http_get_strbuf(const char *url, struct strbuf *result, struct http_
      + * Wait before retrying a transient HTTP error (1-based attempt count).
      + * Returns 0 if the caller should retry, or -1 to stop retrying.
      + */
     -+int http_retry_wait(long http_code, long slot_retry_after, int attempt);
     ++int http_retry_wait(long http_code, long slot_retry_after, size_t attempt);
      +
       int http_fetch_ref(const char *base, struct ref *ref);
       
     @@ remote-curl.c: static int probe_rpc(struct rpc_state *rpc, struct slot_results *
       
       	curl_slist_free_all(headers);
       	strbuf_release(&buf);
     + 	return err;
     + }
     + 
     ++static int can_retry_rpc(const struct rpc_state *rpc)
     ++{
     ++	return !strcmp(rpc->service_name, "git-upload-pack") ||
     ++	       !strcmp(rpc->service_name, "git-upload-archive");
     ++}
     ++
     + /*
     +  * If flush_received is true, do not attempt to read any more; just use what's
     +  * in rpc->buf.
      @@ remote-curl.c: static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
       static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_received)
       {
     @@ remote-curl.c: static int probe_rpc(struct rpc_state *rpc, struct slot_results *
       	size_t gzip_size = 0;
       	int err, large_request = 0;
       	int needs_100_continue = 0;
     -+	int attempt = 0;
     ++	int can_retry = can_retry_rpc(rpc);
     ++	size_t attempt = 0;
       	struct rpc_in_data rpc_in_data;
       
       	/* Try to load the entire request, if we can fit it into the
     @@ remote-curl.c: static int post_rpc(struct rpc_state *rpc, int stateless_connect,
      -		} while (err == HTTP_REAUTH);
      -		if (err != HTTP_OK)
      +		} while (err == HTTP_REAUTH ||
     -+			 (err == HTTP_RATE_LIMITED &&
     ++			 (can_retry && err == HTTP_RATE_LIMITED &&
      +			  !http_retry_wait(results.http_code,
      +					   results.retry_after, ++attempt)));
      +		if (err != HTTP_OK) {
     @@ remote-curl.c: retry:
      +	err = run_one_slot(slot, &results);
      +	if (!large_request && !rpc->any_written &&
      +	    (err == HTTP_REAUTH ||
     -+	     (err == HTTP_RATE_LIMITED &&
     ++	     (can_retry && err == HTTP_RATE_LIMITED &&
      +	      !http_retry_wait(results.http_code, results.retry_after, ++attempt)))) {
      +		if (err == HTTP_REAUTH)
      +			http_reauth_prepare(0);
     @@ t/lib-httpd/http-429.sh: case "$test_context" in
       should_fail=0
      -if test "$retry_after" = permanent
      +case "$test_context,$REQUEST_METHOD" in
     -+	*-post-only*,POST)
     -+		can_fail=1
     -+		;;
     -+	*-post-only*,*)
     -+		can_fail=0
     -+		;;
     -+	*)
     -+		can_fail=1
     -+		;;
     ++*-post-only*,POST)
     ++	can_fail=1
     ++	;;
     ++*-post-only*,*)
     ++	can_fail=0
     ++	;;
     ++*)
     ++	can_fail=1
     ++	;;
      +esac
      +
      +if test $can_fail -eq 1
     @@ t/t5584-http-429-retry.sh: test_expect_success 'GIT_HTTP_RETRY_STATUS_CODES and
      +	grep "Content-Encoding: gzip" curl.log >gzip.headers &&
      +	test_line_count = 2 gzip.headers
      +'
     ++
     ++test_expect_success 'POST /git-receive-pack (git push) is not retried on 429 or 502' '
     ++	test_config http.maxRetries 3 &&
     ++	test_config http.retryAfter 1 &&
     ++	test_config http.retryStatusCodes "429,502" &&
     ++	test_must_fail git push \
     ++		"$HTTPD_URL/http_429/push-post-only-429/1/repo.git" \
     ++		HEAD:refs/heads/push-429 2>err &&
     ++	test_grep ! -i "waiting.*retry" err &&
     ++	test_grep "RPC failed; HTTP 429" err &&
     ++	test_must_fail git push \
     ++		"$HTTPD_URL/http_429/push-post-only-status-502/1/repo.git" \
     ++		HEAD:refs/heads/push-502 2>err &&
     ++	test_grep ! -i "waiting.*retry" err &&
     ++	test_grep "RPC failed; HTTP 502" err
     ++'
      +
       test_done
 5:  61e3ffe9ab ! 5:  7d4335839d http: default http.retryAfter to 10 seconds
     @@ Commit message
          responsive. Callers or tests that want immediate retries can still set
          http.retryAfter=0 explicitly.
      
     -    Because http.retryAfter can now exceed a lowered http.maxRetryTime even
     -    when http.retryAfter itself was not explicitly configured, drop the word
     -    "configured" from the error message and config documentation. Also
     -    update the past HTTP-date test in t5584: CURLINFO_RETRY_AFTER only
     -    yields a positive delay for future timestamps, so past dates fall back
     -    to http.retryAfter (which previously waited 0s only because the default
     -    was 0).
     +    Because libcurl's CURLINFO_RETRY_AFTER returns 0 when Retry-After is
     +    absent or malformed and <= 0 when the server sends "Retry-After: 0" or a
     +    past HTTP-date, inspect the Retry-After response header via
     +    curl_easy_header() (enabled by default since libcurl 7.84.0) when
     +    CURLINFO_RETRY_AFTER <= 0 so that an explicit "Retry-After: 0" or past
     +    HTTP-date continues to retry immediately rather than falling back to the
     +    new 10-second default.
     +
     +    Also drop the word "configured" from the http.maxRetryTime error message
     +    and config documentation, since http.retryAfter can now exceed a lowered
     +    http.maxRetryTime even when http.retryAfter was not explicitly set.
      
          Signed-off-by: Ravi Mistry <rmistry@google.com>
      
     @@ Documentation/config/http.adoc: http.retryAfter::
      +	(`http.retryAfter * 2^(attempt - 1)`), capped at
      +	`http.maxRetryTime`. Set to 0 to retry immediately without waiting
      +	on every attempt (unless a Retry-After header is present). When a
     -+	Retry-After header with a positive delay is present, its value
     -+	takes precedence over this setting; however, automatic use of the
     -+	server-provided `Retry-After` header requires libcurl 7.66.0 or
     -+	later. On older versions, `Retry-After` headers are ignored and
     -+	`http.retryAfter` is always used. Can be overridden by the
     ++	Retry-After header is present, its value takes precedence over
     ++	this setting; however, automatic use of the server-provided
     ++	`Retry-After` header requires libcurl 7.66.0 or later (7.84.0 or
     ++	later for `Retry-After: 0`). On versions older than 7.66.0,
     ++	`Retry-After` headers are ignored and `http.retryAfter` is always
     ++	used. Can be overridden by the
       	`GIT_HTTP_RETRY_AFTER` environment variable.
       	See also `http.maxRetries`, `http.maxRetryTime`, and
       	`http.retryStatusCodes`.
     @@ Documentation/config/http.adoc: http.maxRetryTime::
       	backed-off delays computed from `http.retryAfter`, however, are
       	capped at this maximum rather than causing an immediate failure.
      
     + ## git-curl-compat.h ##
     +@@
     + #define GIT_CURL_HAVE_CURLINFO_RETRY_AFTER 1
     + #endif
     + 
     ++/**
     ++ * curl_easy_header() was added in 7.83.0 and enabled by default in 7.84.0,
     ++ * released in June 2022.
     ++ */
     ++#if LIBCURL_VERSION_NUM >= 0x075400
     ++#define GIT_CURL_HAVE_CURL_EASY_HEADER 1
     ++#endif
     ++
     + /**
     +  * CURLOPT_PROTOCOLS_STR and CURLOPT_REDIR_PROTOCOLS_STR were added in 7.85.0,
     +  * released in August 2022.
     +
       ## http.c ##
      @@ http.c: static char *http_ssl_backend;
       
     @@ http.c: static char *http_ssl_backend;
       static long http_max_retries = 0;
       static long http_max_retry_time = 300;
       static char *http_retry_status_codes;
     -@@ http.c: static long handle_rate_limit_retry(long slot_retry_after, int attempt)
     +@@ http.c: static void closedown_active_slot(struct active_request_slot *slot)
     + 	slot->in_use = 0;
     + }
     + 
     ++#ifdef GIT_CURL_HAVE_CURL_EASY_HEADER
     ++static int has_zero_or_past_retry_after(CURL *curl)
     ++{
     ++	struct curl_header *hdr;
     ++	const char *p;
     ++
     ++	if (curl_easy_header(curl, "Retry-After", 0, CURLH_HEADER, -1,
     ++			     &hdr) != CURLHE_OK)
     ++		return 0;
     ++	if (hdr->amount > 1 &&
     ++	    curl_easy_header(curl, "Retry-After", hdr->amount - 1,
     ++			     CURLH_HEADER, -1, &hdr) != CURLHE_OK)
     ++		return 0;
     ++
     ++	p = hdr->value;
     ++	while (isspace(*p))
     ++		p++;
     ++	if (!*p)
     ++		return 0;
     ++	if (curl_getdate(p, NULL) != (time_t)-1)
     ++		return 1;
     ++	if (*p != '0')
     ++		return 0;
     ++	while (*p == '0')
     ++		p++;
     ++	while (isspace(*p))
     ++		p++;
     ++	return !*p;
     ++}
     ++#endif
     ++
     + static void finish_active_slot(struct active_request_slot *slot)
     + {
     + 	closedown_active_slot(slot);
     +@@ http.c: static void finish_active_slot(struct active_request_slot *slot)
     + 		{
     + 			curl_off_t retry_after;
     + 			if (curl_easy_getinfo(slot->curl, CURLINFO_RETRY_AFTER,
     +-					      &retry_after) == CURLE_OK && retry_after > 0)
     +-				slot->results->retry_after = (long)retry_after;
     ++					      &retry_after) == CURLE_OK) {
     ++				if (retry_after > 0)
     ++					slot->results->retry_after = (long)retry_after;
     ++				else if (retry_after < 0)
     ++					slot->results->retry_after = 0;
     ++#ifdef GIT_CURL_HAVE_CURL_EASY_HEADER
     ++				else if (slot->http_code >= 400 &&
     ++					 has_zero_or_past_retry_after(slot->curl))
     ++					slot->results->retry_after = 0;
     ++#endif
     ++			}
     + 		}
     + #endif
     + 	}
     +@@ http.c: static long handle_rate_limit_retry(long slot_retry_after, size_t attempt)
       
       		/* No Retry-After header provided, use configured default */
       		if (http_retry_after > http_max_retry_time) {
     @@ http.c: static long handle_rate_limit_retry(long slot_retry_after, int attempt)
       					"http/429-error", "config-exceeds-max-retry-time");
      
       ## t/t5584-http-429-retry.sh ##
     +@@ t/t5584-http-429-retry.sh: test_description='test HTTP 429 Too Many Requests retry logic'
     + 
     + start_httpd
     + 
     ++test_lazy_prereq CURL_EASY_HEADER - <<\EOT
     ++	build_option libcurl |
     ++	awk -F. '
     ++		$1 > 7 || ($1 == 7 && $2 >= 84) { ok = 1 }
     ++		END { exit !ok }
     ++	'
     ++EOT
     ++
     + test_expect_success 'setup test repository' '
     + 	test_commit initial &&
     + 	git clone --bare . "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
      @@ t/t5584-http-429-retry.sh: test_expect_success 'HTTP 429 with Retry-After is retried and succeeds' '
       
       test_expect_success 'http.maxRetries=1 retries once and succeeds' '
     @@ t/t5584-http-429-retry.sh: test_expect_success 'Trace2 logs actual CURLINFO_RETR
      +	test_must_fail git ls-remote "$HTTPD_URL/http_429/default-retry-after-10/none/repo.git" 2>err &&
      +	test_grep "http.retryAfter exceeds http.maxRetryTime (10 > 9 seconds)" err
      +'
     ++
     ++test_expect_success CURL_EASY_HEADER 'HTTP 429 with Retry-After: 0 retries immediately' '
     ++	test_config http.maxRetries 3 &&
     ++	start=$(test-tool date getnanos) &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace-retry-zero.event" \
     ++		git ls-remote "$HTTPD_URL/http_429/retry-after-zero/0/repo.git" >output 2>err &&
     ++	duration=$(test-tool date getnanos $start) &&
     ++	duration_int=${duration%.*} &&
     ++	test "$duration_int" -lt 5 &&
     ++	test_grep "refs/heads/" output &&
     ++	test_grep ! -i "waiting.*retry" err &&
     ++	test_grep "\"key\":\"http/429-retry-after\",\"value\":\"0\"" trace-retry-zero.event
     ++'
      +
       test_expect_success 'HTTP 429 without Retry-After uses configured default' '
       	# Enable retries and configure default delay
     @@ t/t5584-http-429-retry.sh: test_expect_success 'HTTP 429 fails if configured htt
       '
       
       test_expect_success 'HTTP 429 with Retry-After HTTP-date format' '
     -@@ t/t5584-http-429-retry.sh: test_expect_success 'HTTP 429 with HTTP-date exceeding maxRetryTime fails immedi
     - 	test_grep "http.maxRetryTime" err
     - '
     - 
     --test_expect_success 'HTTP 429 with past HTTP-date should not wait' '
     -+test_expect_success 'HTTP 429 with past HTTP-date falls back to http.retryAfter' '
     - 	raw=$(test-tool date timestamp now) &&
     - 	now="${raw#* -> }" &&
     - 	past_time=$((now - 10)) &&
     -@@ t/t5584-http-429-retry.sh: test_expect_success 'HTTP 429 with past HTTP-date should not wait' '
     - 	past_date="${raw#* -> }" &&
     - 	past_date_encoded=$(echo "$past_date" | sed "s/ /%20/g") &&
     - 
     --	# Enable retries
     -+	# Enable retries with a short fallback delay
     - 	test_config http.maxRetries 3 &&
     -+	test_config http.retryAfter 1 &&
     - 
     --	# Git should retry immediately without waiting
     -+	# CURLINFO_RETRY_AFTER does not report a positive delay for past dates,
     -+	# so Git falls back to http.retryAfter rather than retrying immediately
     - 	start=$(test-tool date getnanos) &&
     - 	git ls-remote "$HTTPD_URL/http_429/past-http-date/$past_date_encoded/repo.git" >output 2>err &&
     - 	duration=$(test-tool date getnanos $start) &&
     - 
     --	# Should complete quickly (no wait for a past-date Retry-After)
     - 	duration_int=${duration%.*} &&
     -+	test "$duration_int" -ge 1 &&
     - 	test "$duration_int" -lt 5 &&
     --	test_grep "refs/heads/" output
     -+	test_grep "refs/heads/" output &&
     -+	test_grep "waiting 1 seconds before retry" err
     - '
     - 
     - test_expect_success 'HTTP 429 with invalid Retry-After format uses configured default' '
      @@ t/t5584-http-429-retry.sh: test_expect_success 'HTTP 503 honors Retry-After header when present' '
       
       test_expect_success 'exhausted 502 retries report HTTP 502 error, not rate limited' '

-- 
gitgitgadget
