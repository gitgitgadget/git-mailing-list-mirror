Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022840;
	b=L2Yy02J3D109eUL0FLsfdlUDNdNrGCDVyG1jdpoHBJlqfqFUZ6TWAshW+mNjGBZjILcB
	 b3K9WvwWavHneehjWIQQIYT9yE/9l0Jkvd4UN3dk1b4EaxbjuNiyjWPY1SvEplM6rX8ng
	 r2zbuMd8CWfw4NsgyRsyhjulX4bYbEoKFbn86h1pm8UCYSTx8dENNuVOQm5RVutykWi5r
	 1KAhviH0UrYMGmqmuzVJSrSTRSqUEu8tyVuECZ8Tmy4QNzlvVVhqMv+FLRklPnScBKJlI
	 7YHSoFeuT7m/UqYTtqQC5V2n3lytN8jAbcA54NTuwc37Wh3Sk34dNQkDncBaXn/ISOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=41ZZiNPUcm17yyO3gVnYUNO1rsudfDFB1xWvjy+aIn8=;
	b=5BUaxAVK0n3NitloUixVEjePEk8KT1c560qdzK0vpi47fOQs1kZBr4+8ewJWj2Tt2ysI
	 bjET/lsI70BWCFc5iJg5WANUY3L6IFYocDKL/K/Y5h1CjJUwzMQcPqiklYfpbRMQxBQO0
	 A/BsuQ+6QmSVhP9THxtrJ2ATJnNUCK9ViEMnqSFdA4X7cNdJxcf2mNNjp2X8fR/N6/zzo
	 yktsK+hMQzjv7zO4sS9FaHfJ4RvFu+6XYUxg26YTrjFq86vC3HW2HXM8rLeLlCdOKxz3m
	 ikMc+QTrgovaU1/fOKrQ/kcKPaMuHJtOlkyculCkx30D6wbWs6CJRrRzHyVbjUrd5nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+gNpr2A;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F0606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 03:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A88F0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+gNpr2A
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5364042eecfso16841251cf.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 19:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022839; x=1794627639; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=41ZZiNPUcm17yyO3gVnYUNO1rsudfDFB1xWvjy+aIn8=;
        b=i+gNpr2ALklSErF6K3+vIE621Diu9n7c0dHm835wH/pX16TkWMwcHYbH59Q60soxFN
         GBx6T5AlboM2PTEEUSLnBPCkk6zCqPgo4uzlzVBJSXujI1PUxQT+iH82q/QaolM9yXLF
         Zu00H6GsQlZY4kwk/+bgRLkVO7C/FKEuGexRrdAMWXtrnWUiFs6Ud2tJuzQ1Hn+2wAbJ
         lY67IJFuEHLHHYHY4J7LFVk9+D0RGlvqQjtlqZkpDiUFaexam2tJc6sqVjPxzWAhEGRf
         n/LofNYOoYtedX+HncxXH6NtoAICW9zXHuKcd1aQVWIy6UkucomCF6T3ZfkkNfS4/9La
         N4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022839; x=1794627639;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41ZZiNPUcm17yyO3gVnYUNO1rsudfDFB1xWvjy+aIn8=;
        b=1g4AcWkyqYdHj0ZjZm2dgX0nOVKC7mDbou3PV8U3SmkOfqavLtU86EWBnurc6LZ+GY
         Pjx/uICTvjONgefVorh8r9fR9uzR8DNbAVCd893Zn9sWCgcbPcjXIHMoCN+Cvf3OvkxB
         Nert2gKJXRS6hdrOW6ary4+Vy4l/UaUPuyKFS31i4uunCyGAWx3eOgVXwMWgHRzDsQa5
         F/CsGRJS/56FqZK/eAKnOjH3Y1DHYjjb1XJXcobw+dpBEtttZ8m5G8Y+HEBO2/iMQAFB
         c+Mqh9wD/WsYL2t/hdYk1kFbVESZorSic17tqIYS6nUoWX51TXc+uLXeXP1J4EYLrHVb
         eSjA==
X-Gm-Message-State: APuU4Z/BM1uia+v4OHwilACz63QxU5iu1n32BYzsMJcvhNRMi45CtoxW
	1bAv6uMW6dzcrEYenzVvs4gBeiWOgEwQKhRj8VEWWpQuEl3Wp/lYb3eXQKcHzs9z
X-Gm-Gg: AYBFou3FUB3Z6CiPNsPIkZVr73H3bixW458C6BsbJlBQr5Z8+Ln5TvnH2ci59RfgqCa
	X3zyxxTY5TqN/rUc8J9nVP8Ow8DkjPtOQhfQO0cfriWomW07zugpgENn7xmFtqr2RYjUuXa8KF4
	4lCKwfbGrcmeHzLr0rGm7EyexArb2A2cw+dS/LxPJdS3cpAsPAkyA1YNiIPWmxcBdO6nu/XrlNs
	oWqBOTFcDVRqVKPYyEsveKSJT0eJXIEWV3jkMZbbED93w2tntVyIGa2XGHB0U31vrXtzp6+pFPD
	93wOYovw7dms2d0NP1s1qpUSfZXMyULTFtSzGX8zQu5MMFAV9YPU/u43d/c3qH5Twjo0DLx/bpN
	+Kq8pzZursI6bwvEEpBHIBxYcy1bGMeLWd/f7GE172Voth9K/D2Cdy+PpcxGlypgHzXQD+w9ds6
	+MW2Bj+4Oskd1lmHwzJWvz5tUmv0rjPYRPP+OLujMmkTIlYZhWi3Da8sF4NQqFX+k2/HzdGRkTK
	GtiNX8z9HkqJvp/WeZ8WvVQWLFTWNvkkds3UTBqav/cuFnR4TDMDksIYYJSUSB7cwtUce31OlLU
	JNHDUKzV8emJrSHNe2/MkfB1GGZISQU=
X-Received: by 2002:a05:622a:1212:b0:535:84e3:b165 with SMTP id d75a77b69052e-54e0fdf3bb0mr73750621cf.9.1794022838647;
        Fri, 06 Nov 2026 19:40:38 -0800 (PST)
Received: from [127.0.0.1] ([20.65.86.218])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e257862bfsm35990491cf.6.2026.11.06.19.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:37 -0800 (PST)
Message-Id: <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 03:40:31 +0000
Subject: [PATCH v3 0/5] http: exponential backoff, configurable status codes, and post_rpc() retries
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

This 5-patch series addresses all four gaps:

 * Patch 1/5 fixes the off-by-one retry count bug and extracts Retry-After
   in finish_active_slot() before Trace2 logging runs.
 * Patch 2/5 doubles http.retryAfter on each subsequent retry attempt
   (capped at http.maxRetryTime) when Retry-After is absent.
 * Patch 3/5 adds http.retryStatusCodes (and GIT_HTTP_RETRY_STATUS_CODES),
   defaulting to "429", so environments can opt into retrying codes like
   "429,502,503,504".
 * Patch 4/5 extracts a shared http_retry_wait() helper and extends retry
   support to HTTP POST requests in probe_rpc() and post_rpc() (while fixing
   a missing Content-Encoding: gzip header on retry).
 * Patch 5/5 changes the default of http.retryAfter from 0 to 10 seconds so
   Git does not immediately hammer a rate-limiting server when no
   Retry-After header is provided.

Prior discussions:

 * https://lore.kernel.org/git/20201012184806.166251-3-smcallis@google.com/
 * https://lore.kernel.org/git/pull.2008.v6.git.1773752435.gitgitgadget@gmail.com/

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

 Documentation/config/http.adoc |  61 ++++++++---
 http.c                         | 129 +++++++++++++++--------
 http.h                         |  12 ++-
 remote-curl.c                  |  75 +++++++-------
 t/lib-httpd/http-429.sh        |  63 ++++++++++--
 t/t5584-http-429-retry.sh      | 181 +++++++++++++++++++++++++++++++--
 6 files changed, 412 insertions(+), 109 deletions(-)


base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2287%2Frmistry%2Fhttp-exponential-retries-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2287/rmistry/http-exponential-retries-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2287

Range-diff vs v2:

 1:  d53778dd46 = 1:  d53778dd46 http: fix retry count and Retry-After timing
 2:  fe1e847ded = 2:  fe1e847ded http: add exponential backoff without Retry-After
 3:  6510dddc39 = 3:  6510dddc39 http: add http.retryStatusCodes config option
 4:  786964ff00 = 4:  786964ff00 remote-curl: retry transient HTTP errors in post_rpc()
 -:  ---------- > 5:  61e3ffe9ab http: default http.retryAfter to 10 seconds

-- 
gitgitgadget
