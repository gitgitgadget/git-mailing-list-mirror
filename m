Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732252;
	b=xbNi/+US2TUOLqf0Xa+A4+ynLeBx2s0+KO25i8Qxh+AmUWCXY6wZuYa4YEQRyXuJjXhC
	 Foe17G0FvgF96TZeKBVmsIsdLx1i20XklYOJSaOr+6F0dI4Ge2iAoGWIdgsjOKL4fkh2T
	 2zZhPb7SGDBzixPzsSTp6Vt53Pd9s+YKk0WAqLP7LL+HxNh4lLlGcxgegez9mLjC9ccK7
	 x+B1qyK4uFvXLCUnoujMOs2E4ud2GfsJho0UIMD1dXlE/jJCAKP8CeN6fLMjfY8U7XqhS
	 JuSOFCeudLNjG7kA/jo4w1MrmufI1IpUF2dYlvrfhlW+l9zYcWv71oQYABRNCEsvBkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=D79BsmuWyEYFlsTcLvFTQOAejDaZIM5fe1HP/TpcOxw=;
	b=Rase3aBdLxN60xP3GQP36dHED6+NeekIT7wLErusaBnNtBY6SQhkfq5cjhUgHiWYrpjI
	 huECM17tLirTsXcZvmFi1muY5utET7EO++ek2+q6sazhzmtDDV2wJhji61xgEKcozSqBG
	 zYSxR8nedZPbz5ajQoq+f4fX/iaz1L7pENgAUH0ICIhQK4ywq6NbarKfvHKBVBrtgMQK9
	 Trh9PbwgXwWzvAz5VPyU6WvVZ0tm2es/n3lrvnsD7fiJk6gvm+Ts6mXbudvD8jCpOJFxm
	 EcEhAit+Gg8rC1Pf6+TCl1yQvEEpmdDjgRwzU0eTqRtKZvFh59JBM/zWZpWAyNJ5XKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AwM+CPSD;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85828606D819
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 18:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85828606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AwM+CPSD
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f1e5d7450so413677585a.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 10:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732250; x=1794337050; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D79BsmuWyEYFlsTcLvFTQOAejDaZIM5fe1HP/TpcOxw=;
        b=AwM+CPSDiqhEwzR4+RQCWOjouRd3w3o/OGy/KmxsrcKS0Gulb6Cg/ShSkF5XTrZ0IZ
         4gMguMnCAPvY6zw5BXosplKFxdNIEoOHE7aWr7CgGFqXLkQkrOV917pFwWHI4sch1ojB
         HKmYlswZRCEWbp8qczSCWI+sPDwVMKOQruhFTjDBSV6RMVeoS0fMsB8v3tkAi5D3DX+d
         GWBizNN+nNmihDNZqPgM2u0Mriy3gWIWU6ELss4tOeEEwiBd9xxCBOP0+rKvjUcfEUrB
         rgrdFBQSmbt2Dg/fLbwLCDdkzAAJg/mMAEU9FtpzovWgfsAm3VWdovv2Goq92Pcb+X6Y
         6ZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732250; x=1794337050;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D79BsmuWyEYFlsTcLvFTQOAejDaZIM5fe1HP/TpcOxw=;
        b=mOeq6d5/ZgUCVzPvLaPWQM+mIrruKyGF05ciqedTTGnNLAOazAqrjGo1oRvcpy/UlZ
         1ZQJ4rbb1QnhnGTl3g93BVWSeSQXPyGsqLAzuNPKgmAauR8IUtAxsyM0MNN3CrVHeTe3
         H/HDBcST8n8M4qpP1DRTMBP3VbX5wERyob31PTil1Hr6ld0+7bzgstr1VRq6DxoS2iha
         lDSJ/fX4XcBzfyudMytAsfy9SbYZZXqin2IL2ZDK133hzvRULIOpYYtbYi5c+cH33oyV
         SWq+QXoYObqZsko3D5hIt2vw6/YlkzefnDBnnU6UN0QuseBV6dIihEEeT3b4PStXW+z4
         cHjQ==
X-Gm-Message-State: APuU4Z/xkhSrbvwvWLlX/aD50wR4SgOfE5sc9D47ACFv7VlIoSwdBh5a
	3VW3wzJn/TyBQqJd0q7mgcQCInf3g5/Le6IFzFVqpcedpmMixGMdeJ26ylqciIQpvfY=
X-Gm-Gg: AYBFou0B/EnzVyCflfz/LycYtgqsjrDdhE/D2T8JWF35PoOGAeLIZG5ZsBaUQJwmR3h
	pL7DEG7JKPgVKSNpBYnnNMOd1RzRD4huATfdfqa5m9L4O9Z619HQGZIicdi8FN/RELH2AI8v5+m
	j0gGXIlm18wZtbK2AM4EKLdKOKwrH894q34KpbDNGRrpw+s83sA4+coPui86bkI9ieIL4tmHo/K
	1eX2LJIPaWXbpOz4S0szyuwnBYCM3N195kgw1t7iTVChjC96T81QnRXBkFGIXEUOZgzooNKZ4tu
	lYoIb0AYFZEhAPd2xwpzZ67EhtNDfNewpoD9mvux5iRU1BtvwbPvsTaxfBPLyVPjHHVCGYpPU7o
	VuZxDxX1Fhi57/xXbsCX9fi6XFNpcMNi1CTtmeKm+irrOCHP68gfj1s8lDKQ2NpemhC/crxhdrN
	VtygPGAJdRJoROY3t4axBnGKQH7SggmxHxLwj32V4ejwqf6gBYZKQXSc8H9qdMkquk3JPp875/b
	W5DeRc8wEEe4W0TSX94+RhZ5KKyOL7JG7F4aOk94LeCz+Y0u3pMH4HCqDpZE0IFrZFBB4vfwq1W
	o81sVuUulZ+KkznIS99iGCkpvuUwOzzS
X-Received: by 2002:a05:620a:2995:b0:93f:1936:b20a with SMTP id af79cd13be357-944217eea5fmr2207984085a.76.1793732250186;
        Tue, 03 Nov 2026 10:57:30 -0800 (PST)
Received: from [127.0.0.1] ([20.124.87.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c75c5dbsm301906d6.28.2026.11.03.10.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:57:29 -0800 (PST)
Message-Id: <fe1e847dede7579da911b5a9ba16c806b5332723.1793732247.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 18:57:25 +0000
Subject: [PATCH v2 2/4] http: add exponential backoff without Retry-After
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
    Ravi Mistry <rmistry@google.com>,
    Ravi Mistry <rmistry@google.com>

From: Ravi Mistry <rmistry@google.com>

When a server returns HTTP 429 without a Retry-After header, Git waits
the same fixed http.retryAfter delay on every retry. If that delay is
short (e.g., 1s), Git burns through all of its retries in just a few
seconds before a busy server can recover. If that delay is long, even a
brief glitch has to wait a long time on the first retry.

Pass the 1-based retry attempt count to handle_rate_limit_retry() and
double http.retryAfter on each subsequent retry (1s, 2s, 4s, ..., via
http.retryAfter * 2^(attempt - 1)), clamping the delay at
http.maxRetryTime. This keeps the first retry fast while giving the
server more time to recover on later attempts, matching curl's own
--retry behavior (while keeping http.retryAfter's existing default of 0
for immediate retries when unconfigured). When the server provides an
explicit Retry-After header, continue to honor the server-provided delay
(or fail fast if it exceeds http.maxRetryTime).

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/config/http.adoc | 20 ++++++++++++++------
 http.c                         | 17 ++++++++++++++---
 t/t5584-http-429-retry.sh      | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..8e7538ab76 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -327,9 +327,14 @@ http.keepAliveCount::
 	`GIT_HTTP_KEEPALIVE_COUNT` environment variable.
 
 http.retryAfter::
-	Default wait time in seconds before retrying when a server returns
+	Initial wait time in seconds before retrying when a server returns
 	HTTP 429 (Too Many Requests) without a Retry-After header.
-	Defaults to 0 (retry immediately). When a Retry-After header is
+	Defaults to 0, which retries immediately without waiting on every
+	attempt (unless a Retry-After header is present). When set to a
+	positive value and no Retry-After header is present, the first
+	retry waits `http.retryAfter` seconds and the delay doubles on
+	each subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
+	capped at `http.maxRetryTime`. When a Retry-After header is
 	present, its value takes precedence over this setting; however,
 	automatic use of the server-provided `Retry-After` header requires
 	libcurl 7.66.0 or later. On older versions, configure this setting
@@ -345,10 +350,13 @@ http.maxRetries::
 
 http.maxRetryTime::
 	Maximum time in seconds to wait for a single retry attempt when
-	handling HTTP 429 (Too Many Requests) responses. If the server
-	requests a delay (via Retry-After header) or if `http.retryAfter`
-	is configured with a value that exceeds this maximum, Git will fail
-	immediately rather than waiting. Default is 300 seconds (5 minutes).
+	handling HTTP 429 (Too Many Requests) responses.
+	If the server requests a delay (via Retry-After header) or if the
+	configured `http.retryAfter` value itself exceeds this maximum,
+	Git will fail immediately rather than waiting. Exponentially
+	backed-off delays computed from `http.retryAfter`, however, are
+	capped at this maximum rather than causing an immediate failure.
+	Default is 300 seconds (5 minutes).
 	Can be overridden by the `GIT_HTTP_MAX_RETRY_TIME` environment
 	variable. See also `http.retryAfter` and `http.maxRetries`.
 
diff --git a/http.c b/http.c
index 0308f973a6..8a28cd0fb3 100644
--- a/http.c
+++ b/http.c
@@ -2411,7 +2411,7 @@ static int update_url_from_redirect(struct strbuf *base,
  * Returns a negative value if configuration is invalid (delay exceeds
  * http.maxRetryTime), otherwise returns the delay in seconds (>= 0).
  */
-static long handle_rate_limit_retry(long slot_retry_after)
+static long handle_rate_limit_retry(long slot_retry_after, int attempt)
 {
 	/* Use the slot-specific retry_after value or configured default */
 	if (slot_retry_after >= 0) {
@@ -2427,6 +2427,8 @@ static long handle_rate_limit_retry(long slot_retry_after)
 		}
 		return slot_retry_after;
 	} else {
+		long delay = http_retry_after;
+
 		/* No Retry-After header provided, use configured default */
 		if (http_retry_after > http_max_retry_time) {
 			error(_("configured http.retryAfter exceeds http.maxRetryTime (%ld > %ld seconds)"),
@@ -2437,7 +2439,14 @@ static long handle_rate_limit_retry(long slot_retry_after)
 		}
 		trace2_data_string("http", the_repository,
 			"http/429-retry-source", "config-default");
-		return http_retry_after;
+		for (int a = 1; a < attempt && delay > 0; a++) {
+			if (delay >= http_max_retry_time - delay) {
+				delay = http_max_retry_time;
+				break;
+			}
+			delay *= 2;
+		}
+		return delay;
 	}
 }
 
@@ -2498,7 +2507,9 @@ static int http_request_recoverable(const char *url,
 			BUG("Unknown http_request target");
 		}
 		if (ret == HTTP_RATE_LIMITED) {
-			retry_delay = handle_rate_limit_retry(options->retry_after);
+			retry_delay = handle_rate_limit_retry(
+				options->retry_after,
+				http_max_retries - rate_limit_retries);
 			if (retry_delay < 0)
 				return HTTP_ERROR;
 
diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
index d92a26893d..f0c3cc3b61 100755
--- a/t/t5584-http-429-retry.sh
+++ b/t/t5584-http-429-retry.sh
@@ -82,6 +82,39 @@ test_expect_success 'HTTP 429 without Retry-After uses configured default' '
 	test_grep "refs/heads/" output
 '
 
+test_expect_success 'exponential backoff doubles http.retryAfter without Retry-After header' '
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+	git ls-remote "$HTTPD_URL/http_429/exp-backoff-fail-3/none/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_grep "waiting 1 seconds before retry" err &&
+	test_grep "waiting 2 seconds before retry" err &&
+	test_grep "waiting 4 seconds before retry" err
+'
+
+test_expect_success 'exponential backoff clamps delay at http.maxRetryTime' '
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+	test_config http.maxRetryTime 2 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-clamp.event" \
+		git ls-remote "$HTTPD_URL/http_429/exp-clamp-fail-3/none/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_grep "waiting 1 seconds before retry" err &&
+	test_grep "waiting 2 seconds before retry" err &&
+	test_grep ! "waiting 4 seconds before retry" err &&
+	grep "\"key\":\"http/retry-sleep-seconds\",\"value\":\"2\"" trace-clamp.event >clamped &&
+	test_line_count = 2 clamped
+'
+
+test_expect_success 'server Retry-After header overrides exponential backoff' '
+	test_config http.maxRetries 2 &&
+	test_config http.retryAfter 1 &&
+	git ls-remote "$HTTPD_URL/http_429/header-override-fail-2/1/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_grep "waiting 1 seconds before retry" err &&
+	test_grep ! "waiting 2 seconds before retry" err
+'
+
 test_expect_success 'HTTP 429 retry delays are respected' '
 	# Enable retries
 	test_config http.maxRetries 3 &&
-- 
gitgitgadget

