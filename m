Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628916;
	b=1rdDBYuVyRsId8wF/NyHloGuoGt0SJ+1sAz+UJcNvuAZJHcQ5zrcK4HBpxHfMtXq8k+R
	 rtOx52qnotKBHEi+OzWlFb4ekqQQ04w8jlBYuQuT28CIeLkqg/1gpp0R56Xg7OXTV70F0
	 IX7lejp6Qmq16q+Kz0/9vIq4b7mGbvuTfK2Oe1jOtpoDr2khucp47IR7ziL2Tr3srinvt
	 UY+LGtF6sixSbPCL6T0Xscw3D/s67EYVr5tZ87jfrR8TYGoiPEqH/m+h8pWnZhUHKLUb7
	 qO7dBEI3OsYEV9AWFloDe5drSaH0NNFSPqFWDrEYkypZ7FY2Hav7pWFecX1DbIliJyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=H3/w4Z9Qp9LDIBml2Ec8qhoZnZQvPuLQ53C4B52wtXQ=;
	b=yjFEblfivWo8DCsJC2335KuYJHtMC4u9y8BG5Rz4j5SnVeknbYpIBljF0WRS16Ywr2aj
	 iVkBsIeHg60I/QVtCCbEJFZkiVAryTq5f0EwMoxwy+FwgqAHfXgPpmodZMvWUQy2h8siD
	 HNmkJ+q4c9XHvee14vxTpPWmWpEfiGXTOG0+PXdbdUC9i6fNCzOOx0gwnsE6lqkqFD6+g
	 1FL7HbB1PXrhisFgT7Qf9N7L6C5QCwnNgqetcDD0fBX0ToGZRDQGosFA5nDspsg1ugvdF
	 rf7O8utEHZ/jQSO+kDyowRIPLhRrJ/ZN3OG70xyswyuH8HD9XgtyvKF67hYSTH7KLqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ajE/4075";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167F1606A326
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 167F1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ajE/4075
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f03920c4a0so39163175ad.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 09:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795628915; x=1796233715; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H3/w4Z9Qp9LDIBml2Ec8qhoZnZQvPuLQ53C4B52wtXQ=;
        b=ajE/40757IGZwtDu6XxKy00vc3GPEZvVcke+n6knNJKMJcWT5mX57z2/VqcBlhKvpc
         Zd0n1TyDiYx7oFfIw0LHA4GpSTZGNAq9ZQruM4vwefoWYJZnqfafmFiLmj9R0SBz9NNC
         mRfRsITcKzKxEOqhlNhbGnLcTPM14oZbN3nMkLN8KWEaFu37oThi1I9nDM+XPmNLLS7L
         5OXIbgPzTJSph8GvfoMDhJ48W36TdeFi9uvL/wAYgN8GT180CxzzlseDD4o/0hhT5++x
         zCXavB4hCLxEiqhX4sA/I8uRR/R44A6haqNrJZ323N3Rv+RIhRR4PeGqcRq4hpdUzYaq
         VceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628915; x=1796233715;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H3/w4Z9Qp9LDIBml2Ec8qhoZnZQvPuLQ53C4B52wtXQ=;
        b=RWG8+UQRKgok8l6cvsWT0nWWSDAPhLPq7o0siv1eI4RAORnv+6GBgBP9LZQeCYZpEG
         lWGOSukDBIw5gPyjsxqkDnM9CY4XvEoWamuzpQYZqtHMdp/FZtoTjQrz3W5Tl1Lfagyc
         BsVqnDbF+bVXWWpi9g/IcdrUmFb6TvcRvCNbhafPWN+cFkBgHFHjNT+wg/9UHWv5sgHK
         JnfBKtQKveQ/Ggoe4Uk5j0QdAVzb0IssM8InMVyo8/qnD5QgqtQ4Zly6UQrIXLWSCX4K
         MfXBijBelCxVkJQI0FjMC/tn2DI3//TTSmJjgZMRhZEOhWbXcREhuTWQlCVie6vap6bq
         jM/A==
X-Gm-Message-State: APuU4Z8+Cpo5k4+kiKJtrV6xz3Ukb4wHCq92zyj6bVJwFG6uhKySVYNT
	WrvHuuH1QdRJV0kNgJmuvjB9OMB02DIT4VrGOgsDJqEgSQ0yFTvgG4cxIDXMiw==
X-Gm-Gg: AZFdTZdtykui1Ba4rNZCQLenIbvdzqZROculV8AcEZhxXPsCUvvqKT/TlbFRIbLc2BX
	4TgBa4bW78YqYDzp90MgMZPQn8uaYEX4rzyLBnLNARwAORVhTf+/mq3FEp+PHGtPIfck1GtFAst
	RzVZsY+XhtUc7yQ+kNczgvsnQMsIeJTf8aROLTd3C3WZhJj7lHOTgJo9BhKW/2I9STI1nBZmV+t
	lQdFOlmIl+q7pPCNfsvT2VEzRBkRJOS2FO3kWv0xP+HAwvVGARTmWUbAOTDQz0EUrRrgmIQUSFw
	PUYJSlAe/7QVKMihO1TWksZHipUkSUwhS0k9hLvG5+guw3kF76NQD1U4ozESAzYFR2Y+KWl5g0P
	Dph/wePwa2yPp90EPKbnYkk9Hc8+1/w+gJYT/GMRZtlsR/4Wo7oDKv8A/8du5wiO9SAQJFfzsbn
	CS1lzl50lleuCo3/ySSY1Ep/resMoUxWZvBz85X3cluSdjIRth6pLp1K4znCYR2jIG23IQ+kmWB
	qwdx+U8B+4I4kcafyWa+7wy0JBQXAUTvXhOC42S5teyTg4ev9gM/eblpFXnyUgOQESwA8A0AzlF
	lIPO4JuPPmc5P8Lxv3UCvlbfUSBm
X-Received: by 2002:a17:903:b4b:b0:2df:4dc5:e12e with SMTP id d9443c01a7336-2f03f18fedcmr182538045ad.27.1795628915117;
        Wed, 25 Nov 2026 09:48:35 -0800 (PST)
Received: from [127.0.0.1] ([51.57.86.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f08164dacbsm60915885ad.68.2026.11.25.09.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:48:34 -0800 (PST)
Message-Id: <pull.2287.v5.git.1795628913.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 17:48:28 +0000
Subject: [PATCH v5 0/5] http: exponential backoff, configurable status codes, and post_rpc() retries
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

Changes since v4 (thanks to Junio C Hamano for the review):

 * Patches 1/5, 2/5, 5/5: Unchanged from v4.
 * Patch 3/5: Documented in http.retryStatusCodes that an empty value (from
   the configuration or the environment variable) disables retries for all
   status codes instead of restoring the default, and that listing 401 or
   404 has no effect. Added a test for the empty value.
 * Patch 4/5: Cleared results before each run_one_slot() call in post_rpc()
   and probe_rpc() so that a request that fails to start does not report the
   status of a previous attempt.

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

 Documentation/config/http.adoc |  72 ++++++++---
 git-curl-compat.h              |   8 ++
 http.c                         | 169 +++++++++++++++++++------
 http.h                         |  12 +-
 remote-curl.c                  |  84 +++++++------
 t/lib-httpd/http-429.sh        |  63 ++++++++--
 t/t5584-http-429-retry.sh      | 217 ++++++++++++++++++++++++++++++++-
 7 files changed, 521 insertions(+), 104 deletions(-)


base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2287%2Frmistry%2Fhttp-exponential-retries-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2287/rmistry/http-exponential-retries-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2287

Range-diff vs v4:

 1:  d4d3407728 = 1:  d4d3407728 http: fix retry count and Retry-After timing
 2:  fc5dbf8aea = 2:  fc5dbf8aea http: add exponential backoff without Retry-After
 3:  8dc66bfca4 ! 3:  b7d25ce7d4 http: add http.retryStatusCodes config option
     @@ Documentation/config/http.adoc: http.maxRetryTime::
      +	400..599 range) that should be retried up to `http.maxRetries`
      +	times. Defaults to `429` (Too Many Requests). Can be overridden by
      +	the `GIT_HTTP_RETRY_STATUS_CODES` environment variable.
     ++	An empty value, whether from the configuration or from the
     ++	environment variable, disables retries for all status codes; it
     ++	does not restore the default. HTTP 401 and 404 are handled
     ++	separately (as authentication and "not found" responses), so
     ++	listing them has no effect.
      +	See also `http.maxRetries`, `http.retryAfter`, and
      +	`http.maxRetryTime`.
      ++
     @@ t/t5584-http-429-retry.sh: test_expect_success 'verify normal repository access
      +	test_grep "The requested URL returned error: 502" err
      +'
      +
     ++test_expect_success 'empty http.retryStatusCodes disables retries' '
     ++	test_config http.maxRetries 3 &&
     ++	test_config http.retryAfter 0 &&
     ++	test_config http.retryStatusCodes "" &&
     ++	test_must_fail git ls-remote "$HTTPD_URL/http_429/empty-status-codes/none/repo.git" 2>err &&
     ++	test_grep "The requested URL returned error: 429" err &&
     ++	test_config http.retryStatusCodes "429,502" &&
     ++	test_must_fail env GIT_HTTP_RETRY_STATUS_CODES= \
     ++		git ls-remote "$HTTPD_URL/http_429/env-empty-status-codes/none/repo.git" 2>err &&
     ++	test_grep "The requested URL returned error: 429" err
     ++'
     ++
      +test_expect_success 'http.retryStatusCodes retries configured 502, 503, and 504 errors' '
      +	test_config http.maxRetries 3 &&
      +	test_config http.retryAfter 1 &&
 4:  ca247f390c ! 4:  05ca9adf8a remote-curl: retry transient HTTP errors in post_rpc()
     @@ Commit message
          retrying a push POST after a 502 or 504 is not safe if the remote
          already processed the request. Also defer reporting RPC errors until
          retries are exhausted, and re-attach the "Content-Encoding: gzip" header
     -    when retrying a compressed request.
     +    when retrying a compressed request. Clear the slot results before each
     +    request so that a retried request that fails to start does not report
     +    the status of the previous attempt.
      
          Signed-off-by: Ravi Mistry <rmistry@google.com>
      
     @@ remote-curl.c: static int probe_rpc(struct rpc_state *rpc, struct slot_results *
       	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
       
      -	err = run_slot(slot, results);
     ++	memset(results, 0, sizeof(*results));
      +	err = run_one_slot(slot, results);
       
       	curl_slist_free_all(headers);
     @@ remote-curl.c: retry:
      -	err = run_slot(slot, NULL);
      -	if (err == HTTP_REAUTH && !large_request) {
      -		http_reauth_prepare(0);
     ++	memset(&results, 0, sizeof(results));
      +	err = run_one_slot(slot, &results);
      +	if (!large_request && !rpc->any_written &&
      +	    (err == HTTP_REAUTH ||
 5:  7d4335839d = 5:  b6af8c5f92 http: default http.retryAfter to 10 seconds

-- 
gitgitgadget
