Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793462228;
	b=tVkeotK2YegsYb7nxWvn/lX3kG7sVANT/V86w7FJ+yt9DeB0jZeqVCYmt4e3MT7XYONf
	 DUuHnBisZRA5HQIOBwHZIu+5PHHIgPC/Ls1n/S4b06hWk4Gq0WP+QY3jOM7DSyqD1mcEU
	 COOxr/iPULkGeFLXZS0KePyd2N5FrdiN2hR1TLuQgsSLyjYqw9L8NJ4ysS5RtYcJTK9Z4
	 PjD3S5LHuoB+tYent+5zJgXq+elbeExiD8WiLtC4V+hDws6aEqhINkMmiK16/2gw6V+kv
	 QoQ+1Zfp4Mk56xlFldvQGt2xtlnM6eFJWDZDptO/D6Fc8/k+E0Yf/p1O/edtfbuWlcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=BzCLYAYz2pKqtN0uuv/9z9s6cdMDIYegotJJXAvg7wo=;
	b=s4KP3SFBL4lUWlmvCjfuSrXWzscM0ytqGfaD8yC/gccLEpWU3C/uBzO88zClcaP9citc
	 orOsGvzDw1KejXdLJi4Fu3Rr6NdXp80TeaaoJOsD9eE/pkcHiaQKvrB6PYOF+L1HIvpFV
	 dHcP8Fkdc8W0a4Sb6DmdBRRHuf2V4vkusrU1LCf9emEVgsp8IPvUJa0sL4HgZEtNTsjpc
	 qn2HAce4Z3WAKwbukP/QpZUBiegReW4QzK0/QLg1CdZgKrE2Xoo3ue44ghUu62rviMXL3
	 H8bsKKt7Lyu+3ZXWjKtebyzorpUb8qaLBFGidIRjnflvzb+6U2UXZ59ak8dh2Mnbxzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9lzudjl;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16671606A32A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 15:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16671606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9lzudjl
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53bb57f1310so21381651cf.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793462227; x=1794067027; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BzCLYAYz2pKqtN0uuv/9z9s6cdMDIYegotJJXAvg7wo=;
        b=F9lzudjlw4o/0JuCQVGqDkYzpUxQgrrWUloqRUh0S18BsipGRvZKkEv1ca6hRHc9ot
         pRVeexfBgYqOPM9s832NPH592AfG7QALZGvCaQ/yFMqYF2T6n9TZfKHxEnPfUMYwss79
         xnktUpsv6EZLGQZXtmSNaV5VbRZiC5eD40IyYXDKQvOXbJxn16dPZzOWI9HLcFuayRw8
         qxCVTVHVAfcrYQJJs2k9B/RM20yYlHoTOTUChaHqDk100oRTSL0jNlCaSJ8aSvGczkfW
         mqCYhkEQQ8hXtc3PPCPeCFO6vOikY8XMiBSIdLDjS2lmx4SzvOqRB3vGtFJSghP/+M2Q
         nH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793462227; x=1794067027;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BzCLYAYz2pKqtN0uuv/9z9s6cdMDIYegotJJXAvg7wo=;
        b=0e9974xjzRoko0ixbPGAJ2zhHxyrdUnZ47w8rfhT6+vQVsqzbJOu/k5xZSO7CPhu/S
         9vMNTPxBUqDLNQgLuVU3u1IhE1YZk0aymsjI5Su1xsCQ1I1nqxptCbZQZ8js9qceYXp8
         Mv5yg6T2Wc28RwdCslFL3Th25erzaAvSM8r/jxhu7hB827oVLpfSDZ4PBDhVLROilgXk
         Ip24Mj0bhtbIMM3KCHL/KHAxlOOqSC9+3M21LLocKPmeWSDKOzP9oIP4bfpGpdj6TAc2
         ueJcO9wi45Mmb03MajUkLqRp+Q7/0JNhgPMV1HxfuaY0nM295NrYWKsx16H6nC89bk15
         ZotQ==
X-Gm-Message-State: AFq9FYL5zG9g46Uk3oT6BqRuxmfKf+HvcZ9IgudJhg1y3JKHyOEDjQE/
	J3tQcsrQOwzjeSFIVZbX1xl/CTan9QzVzQZidut4xszX7BvpU7h/zNNB9htTBkvYWRM=
X-Gm-Gg: AYBFou0Sb2MDMksZsoJXbRLA4evEeZc6EqQrYX3Jzjv0OjaWIgi4yfncmbfjiV/YyZ1
	+1vMJA/DRPcmIR5Bbx3Kxsqami2vCMnPGlHp0xdogak2R21++Axiq/FRWLNbc7Qq+b8LiJ8GZP4
	/de+22p4aWwPh6RmX5l2V1KbuhYMEOIVMlXrxhdtxPsRP5MAO6eUJ+zLKyd9XPQ7k/FeoSZ1vCw
	EB6YYi8rHLyKFAPqA2PFU7Gail1LcPfPiYmAM7Brnfzi5In2eHRZgo2FhMyVOgDMOsZ6PUeRzLO
	ZVsi9egBVpRCDcfZWuVKJMuppg4HvB7y3fq8suEy+9wATtUi2LdFAiMFhBuj5kK8xfgwanVIi73
	ZRaUC7LSLxSP5My7HY26P/NE7x8e5Pvqixpx66hogrb5EmfMAuWIOBgPLJn3vQOZr3LeBLYAgup
	STzhBuSjmxiP2RtMro5KnX7arOwHjAiujGHwbPjGusl+YF+SL6D3seLd2XhkOGu/8/cp3dbJVWZ
	S1pthL8N9HAibogXfST+sDo6/WxhaCYVfbvxIXvekkXjeYIPWTwtJS6xZmhJACJxwQ97Wc135SF
	3ee+NFSA2VWQosIYWphqxmoJ+ZCRe7IpNlM=
X-Received: by 2002:a05:622a:17ce:b0:532:cad2:539f with SMTP id d75a77b69052e-542b7b0a59bmr92195331cf.53.1793462226977;
        Sat, 31 Oct 2026 08:57:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.126.192])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca95caf90sm42225606d6.30.2026.10.31.08.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 08:57:06 -0700 (PDT)
Message-Id: <36cef34668b6e2ceb867ca99029e8bc11d9cd63f.1793462224.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 15:57:02 +0000
Subject: [PATCH 2/4] http: add exponential backoff without Retry-After
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
--retry behavior. When the server provides an explicit Retry-After
header, continue to honor the server-provided delay (or fail fast if it
exceeds http.maxRetryTime).

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/config/http.adoc | 11 ++++++++---
 http.c                         | 16 +++++++++++++---
 t/t5584-http-429-retry.sh      | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..b387b0ad6a 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -327,9 +327,12 @@ http.keepAliveCount::
 	`GIT_HTTP_KEEPALIVE_COUNT` environment variable.
 
 http.retryAfter::
-	Default wait time in seconds before retrying when a server returns
+	Initial wait time in seconds before retrying when a server returns
 	HTTP 429 (Too Many Requests) without a Retry-After header.
-	Defaults to 0 (retry immediately). When a Retry-After header is
+	Defaults to 0 (retry immediately). When set to a positive value and
+	no Retry-After header is present, the delay doubles on each
+	subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
+	capped at `http.maxRetryTime`. When a Retry-After header is
 	present, its value takes precedence over this setting; however,
 	automatic use of the server-provided `Retry-After` header requires
 	libcurl 7.66.0 or later. On older versions, configure this setting
@@ -348,7 +351,9 @@ http.maxRetryTime::
 	handling HTTP 429 (Too Many Requests) responses. If the server
 	requests a delay (via Retry-After header) or if `http.retryAfter`
 	is configured with a value that exceeds this maximum, Git will fail
-	immediately rather than waiting. Default is 300 seconds (5 minutes).
+	immediately rather than waiting. Exponentially backed-off delays
+	computed from `http.retryAfter` are capped at this maximum. Default
+	is 300 seconds (5 minutes).
 	Can be overridden by the `GIT_HTTP_MAX_RETRY_TIME` environment
 	variable. See also `http.retryAfter` and `http.maxRetries`.
 
diff --git a/http.c b/http.c
index 0308f973a6..0dec6377dd 100644
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
 
@@ -2449,6 +2458,7 @@ static int http_request_recoverable(const char *url,
 	int i = 3;
 	int ret;
 	int rate_limit_retries = http_max_retries;
+	int attempt = 0;
 
 	if (!options)
 		options = &empty_opts;
@@ -2498,7 +2508,7 @@ static int http_request_recoverable(const char *url,
 			BUG("Unknown http_request target");
 		}
 		if (ret == HTTP_RATE_LIMITED) {
-			retry_delay = handle_rate_limit_retry(options->retry_after);
+			retry_delay = handle_rate_limit_retry(options->retry_after, ++attempt);
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

