Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628918;
	b=ym1MMJ3zFXnNNL8HDBlOQ7TpCIoXdy+twKKTbaWa59yZzJjXqHsP2jTkJEd3EhRZgVsK
	 0TKpQqfnpbhlIAySeqQ720HcfBg+nLPd3s8EYQmZrtmMNnZpPlzipNUFDgseE/r9O3fBo
	 QRtE9R27T1kaXJ+OxZIIbCB4zikYjwLGyWwGaQbyr4ywqxD5/h1T9xdGhQNUqesIdkShD
	 p65Z/Rm3TQmpsSiQhqM1sjd4Yuy0jwE/PI223gRNu4/5wTjZiAzwK0q8wa9eZK2Fe4DnG
	 NRFEwOimZuGmrViJNbSBc/Y7S6+s8A6zPS1z2qezzpIewjT0mUv7sVVJOb+s41EL8bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=XOdKqHLalfsSK9oJ+SkKlzuNriadJuqgSXDagCNckF0=;
	b=1EtzpSXYYD3V9Yu0VhjZ0gFtpI3YY32nSh9pwtD2Wh2wnW5Q+9p+/stl9PxE4dkSPoh+
	 QmU2OoVJ1w2LVR0Dpg6MpxndW794EgpZLDouhN3wCOC8UVjBC/DEJBiX9xeh+5N8x1zJc
	 2E1dqn22PtDQ7e0oORt8WrE9KOJlUD11r5JtPOViRjs28jNBgPBK5QMgmWRyG5++uxYhX
	 NjFe305tyFA4YviQOzRmSHeFFUab6cIOrObuijDJL2S5AqEb/LSBkeaVzKdP3EHhJmmD8
	 zacz6hCm9qzWVV/OguIg4D4pKSqj+jX/WMKkWjgYM7BgLGneKEfJFlG7Lq4D6PwnnXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXMbWjMN;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8754D606A323
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8754D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXMbWjMN
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f02ee04378so48703875ad.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795628918; x=1796233718; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XOdKqHLalfsSK9oJ+SkKlzuNriadJuqgSXDagCNckF0=;
        b=DXMbWjMNxf30WGEcbM8dgNM9QwJ56VJE2KcSwIE2OTfAmJfySfAkvxlFi9jqvQfE2t
         3lAkU4WygXnQFmLjywLk+ucjCuVRPWED+5kZXmfKX8J7/lCrhrnD+jfvp8fcHIb4+H9Z
         glb+0DlzyEKnCzEd5eJO+rl3umF2VicmMqvO1SbE/oZMXkkjXoTQEyJRO7uPCb0BMflq
         ZamENoFa9D80e8K+mcarNUYhlp+aVZvdbmKd+Ks3H7RKW/dKbjhfXBucwbp+IrMK6CRe
         W21hbGm5Z132PxDHzhplWSDxReQhwLjV91mWDvRSAlwIXb+s3s7Q1csRh5V5yOlwNLeF
         9E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628918; x=1796233718;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XOdKqHLalfsSK9oJ+SkKlzuNriadJuqgSXDagCNckF0=;
        b=ZV1oEl1UByayzyTFjcBNzHKw64YpvoTI1nY5v9llQBdnfrwIBoZYyqfsK/0TX0tC3+
         JkTFWvuGNu5AUdD51HoZkioFuQ3sY3v4GRTa1ucisk6oeTSTj1X0p1vdGgyqFF46EMN0
         XEE9a838BlarSAWc57qv4zW47IyL4eIF9I+lkv3ekp4bzmazVdvhFDGSFP7zPGFpy8r0
         AVjQ3AKN6QblBPq55LirLVplYlZzoRz1Kc9jAoMBF2DBu2kd4D2cXnLdAJom17e2AGU/
         VzXyEKQVUvhW1xsAUf+6eimFBnRfzYqM1y3Vjtg2EYsaIetpRMO3oWtuhU3IXp8sM60A
         fl7A==
X-Gm-Message-State: APuU4Z9RvRa7DYnDY+w3k137kLvJkxkymY9MJ+VP8lHSS5Jj4gDCpAvy
	/X+CbyR2U7tFyczfyPw3b+StD9GLfpkfYE/NNgVP6qV3DbD6c+fPCbQ1U82/2w==
X-Gm-Gg: AZFdTZfKKguIHc+3I3HPfH4BaEjtrAn6GFRBYizvKTFweuaXkgu+gSOFhfL40gLaDec
	MPi0Nmz/66K/F1T524E0YiDNXxiRnyDz9tQ1ajgjFMjssnyGcQHi+HdFeMJmM0QnW944Wb6aBT4
	WLYtcny0U08vybHQzx5XvP6aNyHItOHJw4nEdSm6KBySnJoJJu2CS9d0Hvya4gI6ivLGGL+U0Bk
	NVvmOGhLMtqVuDtdmZV+6w3VjekSPQzxaBx5feZ+p/COYw58w4vc4PwWlZ7lpcHcjFfqfOYylNd
	SMg9XeH307mcfnnaCyxr/2rnv+jAFPTJdqkD7khproFiq+cZJ7Pln5aFSRvIYDQUWz5dQSqZQ4K
	PSPmyLIXqX5bO5sBBb7h7GBpbkyJmoLxt7+MQ/3YKOzU3LpTvKCKAZRc3BYPEPgJ168r00PV5qv
	VpTQsmOFYOH/+uBoVHVSs2B93yOPCJpT3rIDvw+p7Mktk6MQp17bE0hnKkuXZ+jv7DbMpRXFJy5
	CtQf1KWn5lGlNVQRklXPJVcicOntfB2OnNHFQacjspY2ZQBGxj0CV7Du/B3eGIvUjciPwUw9rCX
	LQeFffHOBlqFLylUdI+pDdk+hff2
X-Received: by 2002:a17:903:2285:b0:2f0:41c7:9a40 with SMTP id d9443c01a7336-2f041c7b268mr194548195ad.4.1795628917738;
        Wed, 25 Nov 2026 09:48:37 -0800 (PST)
Received: from [127.0.0.1] ([51.57.86.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14fc8csm88802655ad.74.2026.11.25.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:48:37 -0800 (PST)
Message-Id: <fc5dbf8aea6cce544e091b578b585098849d0d71.1795628913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v5.git.1795628913.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v5.git.1795628913.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 17:48:30 +0000
Subject: [PATCH v5 2/5] http: add exponential backoff without Retry-After
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
index 0308f973a6..b766bbf035 100644
--- a/http.c
+++ b/http.c
@@ -2411,7 +2411,7 @@ static int update_url_from_redirect(struct strbuf *base,
  * Returns a negative value if configuration is invalid (delay exceeds
  * http.maxRetryTime), otherwise returns the delay in seconds (>= 0).
  */
-static long handle_rate_limit_retry(long slot_retry_after)
+static long handle_rate_limit_retry(long slot_retry_after, size_t attempt)
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
+		for (size_t a = 1; a < attempt && delay > 0; a++) {
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
+				(size_t)(http_max_retries - rate_limit_retries));
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

