Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793462226;
	b=NLdxumFIMbRmmSrl7xinn4736CiXdla054C1p69z3kstaY30h6/x7miGNuz6GyP7TT64
	 mZYDqEGhfu3x1mAwHJ3nkWlcY4GXy5gCiYrk6XC/qg5yNuLwkQXeX/6WlNDFz5tqZrOf0
	 FT1aZRJqUFMQP/m/q6ESYmH2EOGrx4GjKjeS7GNiBo2d+zpUZsJauHpvAu5i3je8mvFF0
	 mUbnr8xlHTF1TDJE0swns+xGoBCYklUI8/DOqf47HKcWXHIJXHtxYIUBqKeX5ls5Tt9Vr
	 a8qSxXyDD919bo9+FH8wDIMDnHyebkQgAPm9bGglFDc1dsGUpmPEGdaULa8d4FUA57w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=VyLkubNtJGswnwHRGo9CKS5HE1tXcY3u84rdqVUtnkc=;
	b=NYEm/Ukh3vbfjXvpiYgsrfBqZk+hQjXjo94r/8wn+ROlRaGfZdyOHWpQiETulGKXyRb+
	 6RWZdd25MAv8db0GEq132N3FsJTaZdd/pmucrvLrOWiNYYAN0IJc7RScbhh4ebIJyX3yP
	 sUcRoEv8P5JP6AAZpVbGygy7lM7sKP62osjYLKAl/I1nhxROXMLCUFgsHky2E7xi1+VxX
	 2gRMTKtD4eVyQ/KnrO5YygpmPZkDm+vv0cRH34F0TTbOFFbPEa1pq7qQhWHq6j2+m2rZ2
	 hURIwmXB8OcZh/35c1Q9Q1Tul6RlP9T1G3SfWqLX1Lbl1bGPmCbN0Kzl8VALEVh9Vkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPPzkico;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D93606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 15:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D93606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPPzkico
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533778ab0bdso23241591cf.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793462225; x=1794067025; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VyLkubNtJGswnwHRGo9CKS5HE1tXcY3u84rdqVUtnkc=;
        b=cPPzkicoggn2mGQzUkU2NoJe8vZSkVfKvqkIMSfOmKrIFlM6LN/XGBKWZRRzGm7vOl
         8qw23fN/enQuHWTx9bjS1oqRnH0mhQnxpueKoZXqb0ql0Sr6GLMzSGkKRB/Sr9ocMmrP
         3iLM4XmcW0jZBxFoSiYWg2WJxiMoNom3J14MgSRBk2HfcGkwhMLYOSWeSttq1JWC64Ub
         DiVBjIUSduv6V8AhRpwqmNk+f1CMTWnz+rIZTLEVq90nm7K2GElxDDnDgUe6GFf6mMC8
         OgkF4CREBoELjIiWLPVnoPxMcWwmiBnsZkxyZ7bRJyRubrDFQGQeo4uWNKidfYQ415df
         gCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793462225; x=1794067025;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VyLkubNtJGswnwHRGo9CKS5HE1tXcY3u84rdqVUtnkc=;
        b=HhlUZeH+mry3R4sxVh5G5H11Di8yRIMFXdhQu4ebifuRL+ZKE8IkpNJide+5zFLitO
         jWXSCquAXVU3bVbfY16vXoGmnw1SJBO75E+Hu/mY/uYoaMXIfYF2NNaLtZQLyq3luUyc
         yC3oGSIdEHw5rf6vV3WiWnvbxfd0SVQtYla8wttkH78A/zRF1Q4vdEjS0HKLF8OVjh7+
         0LzjGg0oEQNZ8cdHJTorEDREpVi4k6VC/mcSEmFWoPZYCFrthRmXhnzOLnyhlB9VItGI
         zpFwa6TSfEHZzTLwQxEtkKffo2AE6gtqkDoNxMm4hhj0AQZaKlOlUdFchs7nHuwICCmE
         RnAw==
X-Gm-Message-State: AFq9FYKM+X080cCW1m6BnmN/7/ne6YaWKOyn9XQnDZe7HvZ40DE32Kja
	CtizJd3ymtCDMFYHRPfefqRKL7l1MESebU24fL5UAtzfF5rkaOD1wHolXMiNFcq7
X-Gm-Gg: AYBFou2IgjMnbxhf7OSVTzkCNLGfWMM+WikH3bhyNFXDeFXp7Svq66VceVSm+0JiSkm
	FDq2PcMy0ZX2VYzZiC1U0B8wNVK9l0+LQ6U3PnVbcBWVQRd734nSc5S+HMMhbBruQI0biMczNOh
	11YLRuv3Q+iyEEb2TnA2pmcullB5NRWy2lJ69FkHIqYYBQgJ8rKwOGs80PZGmNRBEss6k/0qErC
	ZnH9F+dvVWAZ/x8veIvXzrA0cbv+Fn+ZEgz3GSPVFDrBdSv2/UiWgoZ4wKu57PwSRxltYiiiteH
	fjM9fnBmLSr34iURQDBbVWkLL825vftYGnGhGfXfvJ1gN9FNKyHKhlANy6Yw9iynskHHGCmis5y
	pC4rvbST5UYhZGLsT1bnWvcFh33hYaAFv8FaFn/aa0uqhoGQumFZ7HAm5TxvqKZL9QZGn7TLkfU
	418cRKviJ5JQ6OdujnVXTZ/BA7l9w7g+38NleEaKMKdhf75rgRBpp8fVqB7KBhx6fyrIFXO2Eqe
	fUXS40nqidIrrR4pGV7YFB4dHwoyLrzKBhme+u1ScpVVVsn/3TBaOOF3sUV0pATKNn2kuR//149
	/gJlHktZGMOKE+3OH1Ebgj47bL83gtxPMco=
X-Received: by 2002:a05:622a:2515:b0:537:5488:ac63 with SMTP id d75a77b69052e-542b6e55bdfmr90010961cf.34.1793462225291;
        Sat, 31 Oct 2026 08:57:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.126.192])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5431246c7casm41691181cf.19.2026.10.31.08.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 08:57:04 -0700 (PDT)
Message-Id: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 15:57:00 +0000
Subject: [PATCH 0/4] http: exponential backoff, configurable status codes, and post_rpc() retries
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

Ravi Mistry (4):
  http: fix retry count and Retry-After timing
  http: add exponential backoff without Retry-After
  http: add http.retryStatusCodes config option
  remote-curl: retry transient HTTP errors in post_rpc()

 Documentation/config/http.adoc |  42 ++++++---
 http.c                         | 122 ++++++++++++++++++--------
 http.h                         |  12 ++-
 remote-curl.c                  |  75 ++++++++--------
 t/lib-httpd/http-429.sh        |  63 ++++++++++++--
 t/t5584-http-429-retry.sh      | 155 +++++++++++++++++++++++++++++++++
 6 files changed, 373 insertions(+), 96 deletions(-)


base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2287%2Frmistry%2Fhttp-exponential-retries-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2287/rmistry/http-exponential-retries-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2287
-- 
gitgitgadget
