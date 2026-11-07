Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022845;
	b=EaUeIMI7xncsi9VQI+HDPwH68uxnjv2ygxEk6vUSKTZGfNMcI/igwncC3UpURU6MlFsz
	 C4uZAwuR+sMYlqnV2HPrD/ntcT7IjnmCgiyppj0ZVldjVQEeqiFjB1N+KmF6DzJ2h0BvJ
	 hH2ekw7yROIez4BdflEyho7wEGjGhP+dkjFK0FqhYvdA0k0+wg/MOGDSnZtfWA9MLON8s
	 JsbUuhQLTQ7e/+IgCBO5Ogo3/6a1NStj3u8eHqldZUVmc1qiY76861U8rnx/yx45cr/if
	 mqLKGa9WFmPFqfyI3B0j8sLVgK3pJoGAeMLSKKOa1+wlMhB7RQ+8iPTBaAIcufIcCfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=q3SE8hxdQhZ/IZaZCd7fi6XRB6ChVjLllkOZicHBJfE=;
	b=abGg8Lj2hM79N5j2Ht1bQAUKeG94Oebf61spAJSXwR8uQd8X8ZMFPDGUPMf6M1hO8eL6
	 7d/bVyxgV9HvYusRuj9kL7n0LpMRj82uFHtcM9ZzFKbGRG2J/DuaLKzCZ+cBRuEhh6zHW
	 GnSo/7GE3fHoGo+FsRtINZgQOkCIHnaUOL1zS9epiZJbZHu21bQrJmiLl1BnOoVvmR6KG
	 MpBDv0u1ZLo/T+HMWyMnmwusTA9fbuy1DEA/zS+u4F4T9qm3m99tpiXBCbp8Eoh9waUTf
	 Axk1HkhC9MGds9wVBO7N/KgToyL8AGf+3zlaeDaCEkJ8DWyGYIdTRi7OHrEjpkxUMvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QNKEin0E;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE29606A32F
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 03:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCE29606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QNKEin0E
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-535179e995bso13386291cf.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 19:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022844; x=1794627644; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q3SE8hxdQhZ/IZaZCd7fi6XRB6ChVjLllkOZicHBJfE=;
        b=QNKEin0E4LsJ8azCZ6FXIZZv0+i0tYPwf981S6VBOIsqaJcphGz6vXex/r3by19gn2
         aTRvwn56wE9lU/eAr8kkBky1St6oYRwuoTIYstx3Z+pqYCHXNJicGAhdmS3+oO5qh3LJ
         +UtAiKylvd53PNJPmG23MOQ+PO4I0IGB+3ipZImlzNN0ptqZ81v86gM2GOF7t5ZEOvFc
         0b5/xQ+F5fjlQtFaFeGEgSco76dCzyaTDfyruAHGGuWxYEtnkZqiTIMeSa4n++nKEUHR
         cicziaPUma2c6D2XXwgieZXAFzz6gbTJosmYXg+n6z4a+oZbh/IFZj4ToDYPxL2Cywl+
         nYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022844; x=1794627644;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q3SE8hxdQhZ/IZaZCd7fi6XRB6ChVjLllkOZicHBJfE=;
        b=XUmdFTz5tqQo/BhXSNdw1Uvkun+oBFyPIP9a3sNcqzBT+gG4R8eZV7waQ6XCQd7e2o
         Uq+T2RwgPwT+gWGZlsuzUxaJeO0Eu/Q96Us/M8wgDtaQzO14EcS237R7wp67adZIRQOo
         qyTkGh45HalBkKA9LQ0OI0febw8bN0TSWKW5bKRjXHGGCeodt8MWxcHx0YHhomwF24rM
         NlsHUNI/GdKwIYLlTLFzUPTS68ejPgnHQVJWRQpKy2O0IX7XmS1dGqgXFIMPsFuU046T
         +2i2dl0eLkfRVVFlHDdwXei/yXhSF4/loUPnkR4ogcCv8MvIVmZjGceDpvhhwXqRvObf
         yr+g==
X-Gm-Message-State: APuU4Z9dgaFYpqA5jyOpwxatU0UVP8y2xE68qa4sohMEks3k4LxIJBWq
	xFIALhVPWD1w8Hsp9bQIeecYBqkT8k7fpADvUDB7ItpdgLyFLYrvNhcadKnDDsWr
X-Gm-Gg: AYBFou3c8rgS+hK5fkfK5O7hju5oUgzw7OyBvUpnpdygvKynNyJ2cC2nyYsbObaLZG8
	wVV1P6BQd4JIHwS/Cn10FzJ+NCNpxVaQjVoPSrtcaM/WS70qOfzcHs3JXi7UO4tEmcd8P9hk+Ve
	mge0y0SGxCYk2xJNrmo1Sxzb21eePJ/4XSeuMp9vB+dBE30I7VASUubtcTs0Y1GPzwgfgVov8Ye
	lAxU4A4BQTdB8gDK1i+VPQD54UNkxF8lg64V1gsFLodUsVbgMZqpNuZ+xVNQHu8kkSqYHqvPnSP
	T1FDSP8PMwBQ+JJUWhpy4F2huotRc0+sbNd8HaIEkRuBbHq12lfJer/lwoKz2r1ARtGoE0X8nxB
	fu8UR9raAg36Yh2V4A5C9+4X9e589syFovSlPU1l5+oV51mZkxVBT5aFFcpEva/re3LxhVWh6gX
	3CSc6JjGKhD4fOI99+gj5YbVRC62yZ2XpXySSrQP5Fej8C8LQgOLzUwvCjnINRbHV5HLXSo92AZ
	3VzdNwvVjPJrI//EMCapWM7FaVm3Aoc60KYVMk4ccCP9XzCO8qgYZhG/SfQX0wHfXKZf8ru0yjB
	xW3+5nx8y+POBlX2GnA22MJxmdeCkK8=
X-Received: by 2002:a05:622a:1f89:b0:538:689:553e with SMTP id d75a77b69052e-54e14371f42mr62395151cf.42.1794022843874;
        Fri, 06 Nov 2026 19:40:43 -0800 (PST)
Received: from [127.0.0.1] ([20.65.86.218])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6aa7a97sm34748866d6.35.2026.11.06.19.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:43 -0800 (PST)
Message-Id: <61e3ffe9ab8890908eb76c37fcdf4e44654d1bd9.1794022836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 03:40:36 +0000
Subject: [PATCH v3 5/5] http: default http.retryAfter to 10 seconds
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

When http.maxRetries is enabled and a server returns HTTP 429 (or an
opt-in status code via http.retryStatusCodes) without a Retry-After
header, http.retryAfter currently defaults to 0. That causes Git to
retry immediately in a tight loop on every attempt, defeating
exponential backoff and continuing to hammer a rate-limiting server
right after it asked the client to back off.

Default http.retryAfter to 10 seconds (backing off as 10s, 20s, 40s,
..., capped at http.maxRetryTime) so that overloaded Git servers get
meaningful breathing room while keeping interactive commands reasonably
responsive. Callers or tests that want immediate retries can still set
http.retryAfter=0 explicitly.

Because http.retryAfter can now exceed a lowered http.maxRetryTime even
when http.retryAfter itself was not explicitly configured, drop the word
"configured" from the error message and config documentation. Also
update the past HTTP-date test in t5584: CURLINFO_RETRY_AFTER only
yields a positive delay for future timestamps, so past dates fall back
to http.retryAfter (which previously waited 0s only because the default
was 0).

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/config/http.adoc | 25 +++++++++++++------------
 http.c                         |  4 ++--
 t/t5584-http-429-retry.sh      | 26 ++++++++++++++++++++------
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index e7fa251b65..aa86bc68d5 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -332,16 +332,17 @@ http.retryAfter::
 	set of retryable status codes is configured by
 	`http.retryStatusCodes`, which includes only HTTP 429 (Too Many
 	Requests) by default.
-	Defaults to 0, which retries immediately without waiting on every
-	attempt (unless a Retry-After header is present). When set to a
-	positive value and no Retry-After header is present, the first
-	retry waits `http.retryAfter` seconds and the delay doubles on
-	each subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
-	capped at `http.maxRetryTime`. When a Retry-After header is
-	present, its value takes precedence over this setting; however,
-	automatic use of the server-provided `Retry-After` header requires
-	libcurl 7.66.0 or later. On older versions, configure this setting
-	manually to control the retry delay. Can be overridden by the
+	Defaults to 10. When positive and no Retry-After header is
+	present, the first retry waits `http.retryAfter` seconds and the
+	delay doubles on each subsequent retry attempt
+	(`http.retryAfter * 2^(attempt - 1)`), capped at
+	`http.maxRetryTime`. Set to 0 to retry immediately without waiting
+	on every attempt (unless a Retry-After header is present). When a
+	Retry-After header with a positive delay is present, its value
+	takes precedence over this setting; however, automatic use of the
+	server-provided `Retry-After` header requires libcurl 7.66.0 or
+	later. On older versions, `Retry-After` headers are ignored and
+	`http.retryAfter` is always used. Can be overridden by the
 	`GIT_HTTP_RETRY_AFTER` environment variable.
 	See also `http.maxRetries`, `http.maxRetryTime`, and
 	`http.retryStatusCodes`.
@@ -360,8 +361,8 @@ http.maxRetryTime::
 	handling a retryable HTTP status code. The set of retryable
 	status codes is configured by `http.retryStatusCodes`, which
 	includes only HTTP 429 (Too Many Requests) by default.
-	If the server requests a delay (via Retry-After header) or if the
-	configured `http.retryAfter` value itself exceeds this maximum,
+	If the server requests a delay (via Retry-After header) or if
+	`http.retryAfter` itself exceeds this maximum,
 	Git will fail immediately rather than waiting. Exponentially
 	backed-off delays computed from `http.retryAfter`, however, are
 	capped at this maximum rather than causing an immediate failure.
diff --git a/http.c b/http.c
index ea4f9245c4..4ce662ffe4 100644
--- a/http.c
+++ b/http.c
@@ -153,7 +153,7 @@ static char *http_ssl_backend;
 
 static int http_schannel_check_revoke = 1;
 
-static long http_retry_after = 0;
+static long http_retry_after = 10;
 static long http_max_retries = 0;
 static long http_max_retry_time = 300;
 static char *http_retry_status_codes;
@@ -2460,7 +2460,7 @@ static long handle_rate_limit_retry(long slot_retry_after, int attempt)
 
 		/* No Retry-After header provided, use configured default */
 		if (http_retry_after > http_max_retry_time) {
-			error(_("configured http.retryAfter exceeds http.maxRetryTime (%ld > %ld seconds)"),
+			error(_("http.retryAfter exceeds http.maxRetryTime (%ld > %ld seconds)"),
 			      http_retry_after, http_max_retry_time);
 			trace2_data_string("http", the_repository,
 					"http/429-error", "config-exceeds-max-retry-time");
diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
index e627aa2b63..388c5db1b6 100755
--- a/t/t5584-http-429-retry.sh
+++ b/t/t5584-http-429-retry.sh
@@ -53,12 +53,14 @@ test_expect_success 'HTTP 429 with Retry-After is retried and succeeds' '
 
 test_expect_success 'http.maxRetries=1 retries once and succeeds' '
 	test_config http.maxRetries 1 &&
+	test_config http.retryAfter 0 &&
 	git ls-remote "$HTTPD_URL/http_429/max-retries-one/none/repo.git" >output 2>err &&
 	test_grep "refs/heads/" output
 '
 
 test_expect_success 'http.maxRetries=2 fails after 3 failures and succeeds on 2 failures' '
 	test_config http.maxRetries 2 &&
+	test_config http.retryAfter 0 &&
 	test_must_fail git ls-remote "$HTTPD_URL/http_429/max-retries-two-fail-3/none/repo.git" 2>err &&
 	test_grep "rate limited" err &&
 	git ls-remote "$HTTPD_URL/http_429/max-retries-two-fail-2/none/repo.git" >output 2>err &&
@@ -72,6 +74,13 @@ test_expect_success 'Trace2 logs actual CURLINFO_RETRY_AFTER value instead of -1
 	test_grep "\"key\":\"http/429-retry-after\",\"value\":\"1\"" trace-retry-after.event
 '
 
+test_expect_success 'http.retryAfter defaults to 10 seconds when unset' '
+	test_config http.maxRetries 1 &&
+	test_config http.maxRetryTime 9 &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/default-retry-after-10/none/repo.git" 2>err &&
+	test_grep "http.retryAfter exceeds http.maxRetryTime (10 > 9 seconds)" err
+'
+
 test_expect_success 'HTTP 429 without Retry-After uses configured default' '
 	# Enable retries and configure default delay
 	test_config http.maxRetries 3 &&
@@ -161,7 +170,7 @@ test_expect_success 'HTTP 429 fails if configured http.retryAfter exceeds http.m
 	# Should fail quickly (no 100 second wait)
 	duration_int=${duration%.*} &&
 	test "$duration_int" -lt 99 &&
-	test_grep "configured http.retryAfter.*exceeds.*http.maxRetryTime" err
+	test_grep "http.retryAfter.*exceeds.*http.maxRetryTime" err
 '
 
 test_expect_success 'HTTP 429 with Retry-After HTTP-date format' '
@@ -210,7 +219,7 @@ test_expect_success 'HTTP 429 with HTTP-date exceeding maxRetryTime fails immedi
 	test_grep "http.maxRetryTime" err
 '
 
-test_expect_success 'HTTP 429 with past HTTP-date should not wait' '
+test_expect_success 'HTTP 429 with past HTTP-date falls back to http.retryAfter' '
 	raw=$(test-tool date timestamp now) &&
 	now="${raw#* -> }" &&
 	past_time=$((now - 10)) &&
@@ -218,18 +227,21 @@ test_expect_success 'HTTP 429 with past HTTP-date should not wait' '
 	past_date="${raw#* -> }" &&
 	past_date_encoded=$(echo "$past_date" | sed "s/ /%20/g") &&
 
-	# Enable retries
+	# Enable retries with a short fallback delay
 	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
 
-	# Git should retry immediately without waiting
+	# CURLINFO_RETRY_AFTER does not report a positive delay for past dates,
+	# so Git falls back to http.retryAfter rather than retrying immediately
 	start=$(test-tool date getnanos) &&
 	git ls-remote "$HTTPD_URL/http_429/past-http-date/$past_date_encoded/repo.git" >output 2>err &&
 	duration=$(test-tool date getnanos $start) &&
 
-	# Should complete quickly (no wait for a past-date Retry-After)
 	duration_int=${duration%.*} &&
+	test "$duration_int" -ge 1 &&
 	test "$duration_int" -lt 5 &&
-	test_grep "refs/heads/" output
+	test_grep "refs/heads/" output &&
+	test_grep "waiting 1 seconds before retry" err
 '
 
 test_expect_success 'HTTP 429 with invalid Retry-After format uses configured default' '
@@ -349,6 +361,7 @@ test_expect_success 'HTTP 503 honors Retry-After header when present' '
 
 test_expect_success 'exhausted 502 retries report HTTP 502 error, not rate limited' '
 	test_config http.maxRetries 2 &&
+	test_config http.retryAfter 0 &&
 	test_config http.retryStatusCodes "429,502" &&
 	test_must_fail git ls-remote "$HTTPD_URL/http_429/exhausted-fail-3-status-502/none/repo.git" 2>err &&
 	test_grep "The requested URL returned error: 502" err &&
@@ -357,6 +370,7 @@ test_expect_success 'exhausted 502 retries report HTTP 502 error, not rate limit
 
 test_expect_success 'GIT_HTTP_RETRY_STATUS_CODES and urlmatch http.<url>.retryStatusCodes' '
 	test_config http.maxRetries 2 &&
+	test_config http.retryAfter 0 &&
 	GIT_HTTP_RETRY_STATUS_CODES="429,502" \
 		git ls-remote "$HTTPD_URL/http_429/env-status-502/none/repo.git" >output 2>err &&
 	test_grep "refs/heads/" output &&
-- 
gitgitgadget
