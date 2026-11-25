Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628922;
	b=pA9VzAm+uD84nlgJoXZSz50VTFkG1o3QrG9m/VVFZuQEbrC3q5QJTLK2p7YGM+1OzHyO
	 M9d60t7EwY8EVrmlWrbp8SgiLzFQDs+eLbZQKYKQHbbdw89Whw+NvgD10wwxblMpSN/fW
	 MLueM1ZFj9RpKQoMfQoZIFeVZ1TiKRsLkQW8M0fjfDl6CgVMgAyGGDwpiSTRiRxlN3GtW
	 CoGePDAi2mgE1jWCd3S2XES7YazCayST9Gk6/jm21KXgDky6nYHTRP1kN4/ByDWjQsusP
	 +f8ZmyI+yTrMbJLV7fdv7JU+f6FjwDccPR/DmKDWCaS9gbJyc7yxAgjS4LtgoJdTxUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=apIqPIrs1bbUqdWzyLQfe+495GbjuNd7S2sAOsvcm7o=;
	b=HhzwXRYOBjbgm1rcfwNDIz6rSwmAtiaICq1B/JbJYc+vlh09oa28h1aRE1gJt0zuLKiA
	 Cz4FHy6SYgxgvFIkXa4iNytSbP1kVxkweFrMFn/VbYim4OTT1Kd1y0xCjGzHo2Pvp64YS
	 COARG0G6/2LMtSGd828Ix8TgLs9tVe13VLyphQr4QnAy1IMsiuvNcpbCzj47+YCfSAq7x
	 +IFViRktlLmMCE39wQ/tLULJCITv7q1K7cejgTka8zR3k4z4ZV8dLm7uaNghYpx57SOuH
	 JQC8E6/+gWC0+DRTL0Qp5i/BF03kLvG0x0XZiPPwfsF308o7DEvutIM96ZpdJSa3e7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iKwZ6Wec;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EC606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 754EC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iKwZ6Wec
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so2679458b3a.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795628922; x=1796233722; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=apIqPIrs1bbUqdWzyLQfe+495GbjuNd7S2sAOsvcm7o=;
        b=iKwZ6WecschS05W3YJbXZiEkkQX+xiZ5m3LZtZpA3W2qz84ah4XXtNOEuURJbuUkXH
         GW7HQxw0xYfN54Ao2SCHihwwVwYC4FIa5ESJqeKaU/LiicKx90e9t8bVkcnhq4JTx5Kw
         e7p97IOwqqjuuhmo6LmYv7mRvFJcLKf6WYL2nMEpsMquNAUgH92t3fTnNCSXcqegwGkO
         i85PY1fC7oiRMVTA2FF4fxe0rHpcwWXRIwl8/P/xpYXyTPiKOJ8d/LEBTgnNg0p2kkcm
         EQzVd0gOL/w39t9Ml0eadth/1RjP7nExZV2HWYSPsqKbesbUO+m8iAHVv3+gSVXTFzkI
         cCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628922; x=1796233722;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=apIqPIrs1bbUqdWzyLQfe+495GbjuNd7S2sAOsvcm7o=;
        b=VP9ThTWhbRFlojND2u/SdMoQpzscVIIm4crN/lgD55GwBrjvxMHk1PX/thMqa7b4B7
         ABAAVwpAcNWnjzkKBhVSFdmTPh2sBBjk7OT/cnKGg/z083Uc5hwtoxEEeC8krCnjygfq
         vdMu2+xebcQ5F8sz+4d91f3kcg20OIlatxtLIWxHYEMmWhFfF533U/90+fgUCp4fukSJ
         p6rI6W6vIGNCQFZ4krPG2x9ca9F4YhBtkbeFqu7sMwKqktP7IEBYR+Kj27j6uj23Y8hP
         4Gic4zTK9dOsAHRoo6o8j9rJghO7A1AMVhgNkyhrnVt/AxqlpEDqYIo+ZYNUYftuUfs3
         yBBw==
X-Gm-Message-State: APuU4Z/pwXW/hD84oKJJ6jlRnM6Poy+vNOG8iPwkaXiGyttVWdVmsIIA
	CFzIE38RkbXAzhwv25jm9nDK0QjfGXMonrPFkQfY+bmCQ+JZ3lUpBreSBJYzk5cf
X-Gm-Gg: AZFdTZc+KeO6F3WjUblUxpbwCpiPHAHnmApjmkhE5K9wmJ9cVSKuSEfcuaBkNJhIzXs
	Rm50MkIimNdxRadKvY7Kh299vIYA3b4qjwbvJL50g6tPNeXvbjO2KnxAmhHM5RhJTifKXQGIDjM
	hv08NWDATLuiS+TsOY2RAhFxquF5YWyhNPxF6suhwxgto4SvRkS6wtaGc8uAsWCFp6NTZKqtlGZ
	olbFzu5X67538MEh+5G6Ki+DzWGxW1q+tmQvk8o/ZUdyjx0fMrHIv0f1WvUy5pJPFpYdiD9LJsf
	G9cYamxfA+ol31JV6maR+13L7VpBj6RQ1zn8h+7EI1ayPHvbxP5sOeazRJNIXzC5pOPwTm72mjC
	olCeYy0uD60qx6K+a2j3X7tjqmfvaelD4l/8WSYNO27lzOvAmN0xRsp5zTXP5+eAcEjHGpTg/B2
	ZUM2vtUlHvYL/mQ8GlNoY1ytYcFwyVSHi+WOWgYKlk9hxGewxREapTTfMCOPOoFevGcbv5BQ29e
	kD0dxJ40NZ/WrAOW2/nKNA38ynsz6GnYNC3v2GdjInoIAIZa9eSfAFi5bxHur1f0p6VR/Lo4+TJ
	c38xioD9nPBgrK+A52OOA0B0CLkgUXqAMyqn2M74+6LMoyx7dg==
X-Received: by 2002:a05:6a00:1c97:b0:8b5:7fc8:866f with SMTP id d2e1a72fcca58-8c87d32b004mr15925190b3a.44.1795628921711;
        Wed, 25 Nov 2026 09:48:41 -0800 (PST)
Received: from [127.0.0.1] ([51.57.86.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c272sm9604645b3a.19.2026.11.25.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:48:41 -0800 (PST)
Message-Id: <b6af8c5f9221a4d3033e62ee59419a66e1d54aac.1795628913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v5.git.1795628913.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v5.git.1795628913.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 17:48:33 +0000
Subject: [PATCH v5 5/5] http: default http.retryAfter to 10 seconds
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

Because libcurl's CURLINFO_RETRY_AFTER returns 0 when Retry-After is
absent or malformed and <= 0 when the server sends "Retry-After: 0" or a
past HTTP-date, inspect the Retry-After response header via
curl_easy_header() (enabled by default since libcurl 7.84.0) when
CURLINFO_RETRY_AFTER <= 0 so that an explicit "Retry-After: 0" or past
HTTP-date continues to retry immediately rather than falling back to the
new 10-second default.

Also drop the word "configured" from the http.maxRetryTime error message
and config documentation, since http.retryAfter can now exceed a lowered
http.maxRetryTime even when http.retryAfter was not explicitly set.

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/config/http.adoc | 26 +++++++++---------
 git-curl-compat.h              |  8 ++++++
 http.c                         | 48 +++++++++++++++++++++++++++++++---
 t/t5584-http-429-retry.sh      | 34 +++++++++++++++++++++++-
 4 files changed, 99 insertions(+), 17 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index f0fde171e3..59f96351f6 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -332,16 +332,18 @@ http.retryAfter::
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
+	Retry-After header is present, its value takes precedence over
+	this setting; however, automatic use of the server-provided
+	`Retry-After` header requires libcurl 7.66.0 or later (7.84.0 or
+	later for `Retry-After: 0`). On versions older than 7.66.0,
+	`Retry-After` headers are ignored and `http.retryAfter` is always
+	used. Can be overridden by the
 	`GIT_HTTP_RETRY_AFTER` environment variable.
 	See also `http.maxRetries`, `http.maxRetryTime`, and
 	`http.retryStatusCodes`.
@@ -362,8 +364,8 @@ http.maxRetryTime::
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
diff --git a/git-curl-compat.h b/git-curl-compat.h
index 25678b5dbd..c72a2a766c 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -52,6 +52,14 @@
 #define GIT_CURL_HAVE_CURLINFO_RETRY_AFTER 1
 #endif
 
+/**
+ * curl_easy_header() was added in 7.83.0 and enabled by default in 7.84.0,
+ * released in June 2022.
+ */
+#if LIBCURL_VERSION_NUM >= 0x075400
+#define GIT_CURL_HAVE_CURL_EASY_HEADER 1
+#endif
+
 /**
  * CURLOPT_PROTOCOLS_STR and CURLOPT_REDIR_PROTOCOLS_STR were added in 7.85.0,
  * released in August 2022.
diff --git a/http.c b/http.c
index f7f4af7a31..1db5f7a69a 100644
--- a/http.c
+++ b/http.c
@@ -153,7 +153,7 @@ static char *http_ssl_backend;
 
 static int http_schannel_check_revoke = 1;
 
-static long http_retry_after = 0;
+static long http_retry_after = 10;
 static long http_max_retries = 0;
 static long http_max_retry_time = 300;
 static char *http_retry_status_codes;
@@ -334,6 +334,37 @@ static void closedown_active_slot(struct active_request_slot *slot)
 	slot->in_use = 0;
 }
 
+#ifdef GIT_CURL_HAVE_CURL_EASY_HEADER
+static int has_zero_or_past_retry_after(CURL *curl)
+{
+	struct curl_header *hdr;
+	const char *p;
+
+	if (curl_easy_header(curl, "Retry-After", 0, CURLH_HEADER, -1,
+			     &hdr) != CURLHE_OK)
+		return 0;
+	if (hdr->amount > 1 &&
+	    curl_easy_header(curl, "Retry-After", hdr->amount - 1,
+			     CURLH_HEADER, -1, &hdr) != CURLHE_OK)
+		return 0;
+
+	p = hdr->value;
+	while (isspace(*p))
+		p++;
+	if (!*p)
+		return 0;
+	if (curl_getdate(p, NULL) != (time_t)-1)
+		return 1;
+	if (*p != '0')
+		return 0;
+	while (*p == '0')
+		p++;
+	while (isspace(*p))
+		p++;
+	return !*p;
+}
+#endif
+
 static void finish_active_slot(struct active_request_slot *slot)
 {
 	closedown_active_slot(slot);
@@ -356,8 +387,17 @@ static void finish_active_slot(struct active_request_slot *slot)
 		{
 			curl_off_t retry_after;
 			if (curl_easy_getinfo(slot->curl, CURLINFO_RETRY_AFTER,
-					      &retry_after) == CURLE_OK && retry_after > 0)
-				slot->results->retry_after = (long)retry_after;
+					      &retry_after) == CURLE_OK) {
+				if (retry_after > 0)
+					slot->results->retry_after = (long)retry_after;
+				else if (retry_after < 0)
+					slot->results->retry_after = 0;
+#ifdef GIT_CURL_HAVE_CURL_EASY_HEADER
+				else if (slot->http_code >= 400 &&
+					 has_zero_or_past_retry_after(slot->curl))
+					slot->results->retry_after = 0;
+#endif
+			}
 		}
 #endif
 	}
@@ -2460,7 +2500,7 @@ static long handle_rate_limit_retry(long slot_retry_after, size_t attempt)
 
 		/* No Retry-After header provided, use configured default */
 		if (http_retry_after > http_max_retry_time) {
-			error(_("configured http.retryAfter exceeds http.maxRetryTime (%ld > %ld seconds)"),
+			error(_("http.retryAfter exceeds http.maxRetryTime (%ld > %ld seconds)"),
 			      http_retry_after, http_max_retry_time);
 			trace2_data_string("http", the_repository,
 					"http/429-error", "config-exceeds-max-retry-time");
diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
index 79b98fae08..8fc44ad11f 100755
--- a/t/t5584-http-429-retry.sh
+++ b/t/t5584-http-429-retry.sh
@@ -8,6 +8,14 @@ test_description='test HTTP 429 Too Many Requests retry logic'
 
 start_httpd
 
+test_lazy_prereq CURL_EASY_HEADER - <<\EOT
+	build_option libcurl |
+	awk -F. '
+		$1 > 7 || ($1 == 7 && $2 >= 84) { ok = 1 }
+		END { exit !ok }
+	'
+EOT
+
 test_expect_success 'setup test repository' '
 	test_commit initial &&
 	git clone --bare . "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
@@ -53,12 +61,14 @@ test_expect_success 'HTTP 429 with Retry-After is retried and succeeds' '
 
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
@@ -72,6 +82,26 @@ test_expect_success 'Trace2 logs actual CURLINFO_RETRY_AFTER value instead of -1
 	test_grep "\"key\":\"http/429-retry-after\",\"value\":\"1\"" trace-retry-after.event
 '
 
+test_expect_success 'http.retryAfter defaults to 10 seconds when unset' '
+	test_config http.maxRetries 1 &&
+	test_config http.maxRetryTime 9 &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/default-retry-after-10/none/repo.git" 2>err &&
+	test_grep "http.retryAfter exceeds http.maxRetryTime (10 > 9 seconds)" err
+'
+
+test_expect_success CURL_EASY_HEADER 'HTTP 429 with Retry-After: 0 retries immediately' '
+	test_config http.maxRetries 3 &&
+	start=$(test-tool date getnanos) &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-retry-zero.event" \
+		git ls-remote "$HTTPD_URL/http_429/retry-after-zero/0/repo.git" >output 2>err &&
+	duration=$(test-tool date getnanos $start) &&
+	duration_int=${duration%.*} &&
+	test "$duration_int" -lt 5 &&
+	test_grep "refs/heads/" output &&
+	test_grep ! -i "waiting.*retry" err &&
+	test_grep "\"key\":\"http/429-retry-after\",\"value\":\"0\"" trace-retry-zero.event
+'
+
 test_expect_success 'HTTP 429 without Retry-After uses configured default' '
 	# Enable retries and configure default delay
 	test_config http.maxRetries 3 &&
@@ -161,7 +191,7 @@ test_expect_success 'HTTP 429 fails if configured http.retryAfter exceeds http.m
 	# Should fail quickly (no 100 second wait)
 	duration_int=${duration%.*} &&
 	test "$duration_int" -lt 99 &&
-	test_grep "configured http.retryAfter.*exceeds.*http.maxRetryTime" err
+	test_grep "http.retryAfter.*exceeds.*http.maxRetryTime" err
 '
 
 test_expect_success 'HTTP 429 with Retry-After HTTP-date format' '
@@ -361,6 +391,7 @@ test_expect_success 'HTTP 503 honors Retry-After header when present' '
 
 test_expect_success 'exhausted 502 retries report HTTP 502 error, not rate limited' '
 	test_config http.maxRetries 2 &&
+	test_config http.retryAfter 0 &&
 	test_config http.retryStatusCodes "429,502" &&
 	test_must_fail git ls-remote "$HTTPD_URL/http_429/exhausted-fail-3-status-502/none/repo.git" 2>err &&
 	test_grep "The requested URL returned error: 502" err &&
@@ -369,6 +400,7 @@ test_expect_success 'exhausted 502 retries report HTTP 502 error, not rate limit
 
 test_expect_success 'GIT_HTTP_RETRY_STATUS_CODES and urlmatch http.<url>.retryStatusCodes' '
 	test_config http.maxRetries 2 &&
+	test_config http.retryAfter 0 &&
 	GIT_HTTP_RETRY_STATUS_CODES="429,502" \
 		git ls-remote "$HTTPD_URL/http_429/env-status-502/none/repo.git" >output 2>err &&
 	test_grep "refs/heads/" output &&
-- 
gitgitgadget
