Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103888;
	b=FJrsisb8Jbf2T5tguMO0ED1kgyor2En0GCBCj7StLqkm+9d/jZIqU9ucG9j2XMrK30gy
	 6IGeKOafLvlY5JwTAlVWHvqgAnOg2o5RTMmJBofkPODx+HdGfJFGnxi5J6pLpSFpuukIA
	 A+Yjg0lcscXbjY36jSMWFVljqUEDhp6v8lG6ZUDtY8MW8L8vkxW6dJWAX0/DBr1AZweMW
	 Hz6brYcDtNrcfhOadXdoK59TsvH6+JOoVThqjOAfGR9Pezivy9wsLDO8ORVmCJKfC/iTg
	 vnoeOuVkBGGkcP5gwwmeaJaFxqAalcuLx3OYttl9J9iQrZ9WfAvnkrktvk9mnHWnCYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=XOdKqHLalfsSK9oJ+SkKlzuNriadJuqgSXDagCNckF0=;
	b=sbjjCdwlc0ggqkPCDQOGDGAEqdV3uKaL1eBW6cdwbfFgjqKOk1pgKu7eALeiay0e4n0C
	 IFZnjnspDgXBEly2KEt3eHp5C2qlgVHMG0mvnSYpHhdzBt+8Jo7IZfRV0OKDMLY5FI+nP
	 huikdqEB3ciCK+XzD0GxAv51RtXh2ZrqfuH1QMNLBXM0u1XfM88MFUNDuNnyjAXF4MZRA
	 DEC6/BbwV4VqoWj3n2Jz8e/Jc1F4YwrBN06eZCyEOTYjmwyP5PjGEcplkTkZJlVQSMoge
	 zPSLSWgiKXMRswogaQXHFoB54YwZjphPgEqWK5sGVIfL83sot3oX5c6lgQSL+Z4fQ0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uX0hQAGh;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243E60A2601
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B243E60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uX0hQAGh
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9ae391a05so7913875ad.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795103887; x=1795708687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XOdKqHLalfsSK9oJ+SkKlzuNriadJuqgSXDagCNckF0=;
        b=uX0hQAGhMchxEhlibankLETMAgR/11ApZu+8nrysvk7YdkQeefe6WBhlA+isHJnqXX
         kwT+giwdYyhhKvB9hjTH9TOWUOvpvd3NEH34y5frfxbEr9QHKXsPtl61p1eKPZBreZDX
         nEx8ycVyDj4MtbwoBNCWqWR1RbhdN+8t8rmiOhtLN/i3NKPpnl3/5RT4qNjlp+DkEDBk
         Da1j4vSk567m5kpAgYnRnCAU+1bD0myTzpSNycCBPJJv/Je92acpTAgBUKcSgWl+LfnM
         p1893vaJN/mW7PNc1PvyBFxVK7oMn/I1rZifOAfSAT4VHMRdGpFyN0wBjqok7FCiaryj
         BKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103887; x=1795708687;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XOdKqHLalfsSK9oJ+SkKlzuNriadJuqgSXDagCNckF0=;
        b=Uh15ALr6jolCBh0LZ0Mx9HJAQz22TkLD2NMfhwZZKB6MDfVgbjGsbBEkiv43H1iYrq
         t4EEawLMPla+q8udyrZ97ToA8vQZP8eq0Wber/QfrrMyAiBXLSMf1Jyo2Morbk8Cqsji
         tZ4kiysHgEioUlptxYqYOKgmC9fnIpq7TbxwI22Q8AXY3a1c7STUvPM7MgSsBR9ZhGS7
         UB44Fe9d7/TAioMBUZoNhpIxSfrl1R5TYK41I84Aavx5A5gv7Xwq9kluLexVXJMZVFks
         KEVmasNjTyV+Kg8IA9RiFDridyhdiYH7TnS4a1UnypS4DiYNY2P0MKB7GeoAQk5BnM7e
         Ycmw==
X-Gm-Message-State: APuU4Z/93qBoohu1hQgryNt46bpgBIMcGy+JagvR83160mB6l3B6lnjR
	WX0XsH4MsRZxQ8NFfiZW+/VQQP3NkOJH8CIxfY62bw9EAizpT2nNLmWkJJR0OfbM
X-Gm-Gg: AZFdTZeaDny0QEfoVQW6Pp+zhAqVs40KdlyQz6p43hMLY7evUXCxA+PZGeJdgAL+Bkn
	ab1m8qSFgxqrsSuQJw0MQ+wNiW6mdNNfMNIRmA7SeFWJH3+0VQj/Irlv/Q3DgiTNEqbLH1oPrjQ
	Ju9UIv3mLDthlOiFfseRZZlI4KX5tyOAwnghp1FfNLxo00i0psv9gBIaGjRgrnlHRe+9vgozbu2
	TgrZi/Ech1pfBU2wXAFFpsgTgE54Io8w4ucsBvtptwMiKA3mjaZmvV1LyTEgFfouEz301ubjTtO
	MTjZG+qnKC9KGQikDSX3ghPXpX7NMOxAB7ahpmXw37eB6zF1EiUM/xrQAcS5/dsquAoClxLeIGN
	tnX5BX1A+Kb3FpBfBXz3I3hIyue+vqW4GWpYgwrFIGk8EPx1PPs3m6+3C7F66+bN+xCfXjtKsMe
	J9K6gyTZ8toCfONwxt/jQm+meMVYKkHQyKvM9AupN9Agax8DUxXHDqiNieW7wA6cts524DlAoY1
	bkk5+Y1q7+yDA1cbq5lmV4/kYC24bA1YxfUB852i3tYoILFmNICd8Vf4PDKQt+Vt9xLer2YGwNH
	R8yulXlppVH8sXA3ZenxNwx+0LJ6022Y6uhA6DXk0wFvzT/WeWSoyveaMA==
X-Received: by 2002:a17:903:1590:b0:2e6:1c24:d5f2 with SMTP id d9443c01a7336-2f03202e08bmr10524565ad.36.1795103886970;
        Thu, 19 Nov 2026 07:58:06 -0800 (PST)
Received: from [127.0.0.1] ([172.171.119.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120016sm1670065ad.58.2026.11.19.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:58:06 -0800 (PST)
Message-Id: <fc5dbf8aea6cce544e091b578b585098849d0d71.1795103883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Nov 2026 15:58:00 +0000
Subject: [PATCH v4 2/5] http: add exponential backoff without Retry-After
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

