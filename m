Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103887;
	b=KEFrYUmG8yH3kQ6rjHJtk0m7Bbu3lrQ6eR3qibwgZXnaGhWWhFrRzzxxP3z1q4fOOaGW
	 Mye1B2yk0QgYE4i4dR28M/DuozbTxuR9qVaZKbiayU/vISDNR9QQ8V8rvNeUUjmOW/tg7
	 LPKiql2MVdq274UjGseLCga97jFxkkSERoZoGFgOOUj7ELBZPx3mQVqNZf4Dorsoq/Ejk
	 rU5mwP4KVz/jeCiaBpfUqiiKMJox9Dqe4cjZI0Cbh16mWrxAQRzgYRP0PjtEWzsJtv/1v
	 u80zNWmtRtOH2/yIUELsXY8ObvvfzHqo4zd24QGlPKezB0cRtWQJwYVbM7VpJAqktkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=UDp3PI/TMlQSH4xcRUFNiwFphbLraNKrIR4v6YllvJY=;
	b=yyiYz7yz4Bqyw2eE/6vKcGEGSn05xlQYg2PLsKmMTS/eBTzIvB380lXSBdCwqig08jts
	 1gP+lMIjhRFrKRFEEH2f7uYMP6ohGL9k+8rGXTvYBO8FKxB8Wy1GfhrYHF/uWZVox4zJI
	 T/n2+TOMgS63fIFKKp8srSo6f2MBx8Ff7W2Y9zBX5uhwnjrm7sGKL4vbinCw43/6cUQhZ
	 YpwiKlgfw1V9zNvSYRG2vXE2bvaMHhKdx4EQm/LZJixXj5rcPV2VJoLUrd+OSb5vW2dPY
	 ZzpmsMNFnl5qAJWz0VDZaHccFOpLu/2Sw9jBxqdJ8Lpjl3jSUQtXqLAgf0nWodxKzqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1CfDsEW;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7052606A331
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7052606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1CfDsEW
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so787620b3a.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795103886; x=1795708686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UDp3PI/TMlQSH4xcRUFNiwFphbLraNKrIR4v6YllvJY=;
        b=F1CfDsEWIl22jpN7LQgQL/NUFO3B+ZLdbc7LcdBqIzt9TJz1sK4QuvhyV7C/R36zpW
         TzOqdrYTI7IANdTZxp8OpxnCb5/c66EVtJxm1aBd+I+8d4vbi5EgNePR5l1UvgmgpZyt
         ybc9cIGA48Ujmx6BikovBhDFO1/nDXvXkNlk/yKhv1VC3FdnC4T/S7fa4ZYxRHwHsaJV
         R6tLiVswTe8xa7SUBnXC8Lwv67wKPRZIT1SbbYpKat3xbE73Hp69oS8G6bbXMN+VoNy7
         jlwa7044+NI7Uu/x3FcIajEhIKBOY5ZZIbm1lxmd9AkRYNcz2xsRHMnDHj2t+P9wi8Oi
         kaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103886; x=1795708686;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDp3PI/TMlQSH4xcRUFNiwFphbLraNKrIR4v6YllvJY=;
        b=N6djZm+PIThMwChDRZKafkH4DAdJ2C7y4V+D09XRYTz1ASVzij/6+v+Hc59MEv5jKH
         qEP/Yut9r2nrjc77S7nBkJCc06wiEIThJJEr/OaQTM1ogzlVWq6RgU3j4Rem9hzfkH6+
         5IRzK660j7zICYf0ns7uQeW9mRU4eETwCXX61z/8Yqd87HCm5O1ZBiseXtN3bxS4h3pa
         vTHQXnMI6h3gPcAm0+/H0GJ3iaRoTyY0Tl5RZiQdMDUMx0ChXdJPd+azLoJ3vczmUNg8
         QTCf4mh8CoycvJ2rhkAME7QHu6lSJu2DexFoReGqI7K2XvN0qcbqrpZQtAJICKIpNVDl
         H0lA==
X-Gm-Message-State: APuU4Z+wW0ukdoSP+v8hzvruXY7xu+CZEhinvXS/0pWhPwm3zw6nSGiB
	VWkHFK0hKk/av1hlRJzVofAV8rWvssE8lL4r/8O5R+0qJFTTPFfDTtJCR0OyWw==
X-Gm-Gg: AYBFou26Fj3QMjdXbCV86v2JOzAn42EWg72ByR7u8wrFQruivy91wWl7ORKhzzBkjWG
	lyh+zFo+jduR+L13k7dYOzYfwNDH6A7qqRq7KZDx8Hoi2aJeKjV1I98ShvDpVLCOUSy30Cy4YXp
	AJlSP7Qrb4ozqtUze4/tTpYRNGS5Nr9EP345plfckzl6guqggH67F8ev75tActEp4oMAvsfPJtG
	cgZE4WrbCR3GoyRNtWMjHAKlNxLsRiWIqKrmZixLAquIwcFHgHTIIlM6uPE6dESH1wfJQWB0jFb
	Ts3dAZ1MklG0tsWzDIUmZtPsvIkBJwlnWOMvrJaW4B50BKLzygVPJO3ZgTgxtqhyJHeMpf9aWA8
	QH8VyvTlGg3YqAJbJqYSvGfbrPp6Qebn8YwAyvdFv9nidIauU4YKUyIvyz8CdRPsIMEhNqabw3d
	AoNx3U620Cpekjhnfy9XF0LgzK6wcUrKM8njeQkXmQThrYjJ8tblysorYGPHLnru+K3zIPIJORr
	YDyK5z2YNLA6wwQq94LnvJyKAhpDMSjogts906fP3HrLx3Vx75yokrbMN7MbBryHBDtVJzegUhi
	srVHqqMd7gopgty9Dp72Yg1FkCCuHEfpaUI=
X-Received: by 2002:a05:6a00:2e1e:b0:8b9:227b:c0a with SMTP id d2e1a72fcca58-8c7db1ecac6mr1087301b3a.5.1795103885910;
        Thu, 19 Nov 2026 07:58:05 -0800 (PST)
Received: from [127.0.0.1] ([172.171.119.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872d50fcesm118912b3a.23.2026.11.19.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:58:05 -0800 (PST)
Message-Id: <d4d34077283370cfa22e9d8f57edfb35de9c692a.1795103883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Nov 2026 15:57:59 +0000
Subject: [PATCH v4 1/5] http: fix retry count and Retry-After timing
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

Commit 640657ffd0 (http: add support for HTTP 429 rate limit retries,
2026-03-17) introduced two small bugs in HTTP 429 retry handling:

1. In http_request_recoverable(), rate_limit_retries is initialized to
   http_max_retries (the number of retries to perform after the initial
   failed request) and decremented with pre-decrement
   (--rate_limit_retries) in the while condition. Because of the
   pre-decrement, setting http.maxRetries=1 performs 0 retries, and
   more generally N configured retries only retries N-1 times. In
   addition, if the first request returns 401 (HTTP_REAUTH) and the
   re-authenticated request returns 429 when http.maxRetries is 0,
   --rate_limit_retries wraps from 0 to -1 (truthy in C).

   Fix this by checking http_max_retries > 0 && rate_limit_retries-- > 0
   in the loop condition and checking http_max_retries <= 0 after the
   loop (which handles both an initial 429 and a 429 after 401 re-auth
   without logging "retries-exhausted", making the pre-loop check
   redundant).

2. In http_request(), CURLINFO_RETRY_AFTER is queried after
   run_one_slot() has already called handle_curl_result(), which logs
   results->retry_after to Trace2 ("http/429-retry-after") while it is
   still -1. Move the CURLINFO_RETRY_AFTER extraction into
   finish_active_slot() (initializing slot->results->retry_after = -1
   first) so that both handle_curl_result() and callers of
   run_one_slot() observe the parsed Retry-After value.

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 http.c                    | 27 +++++++++++++--------------
 t/lib-httpd/http-429.sh   | 31 ++++++++++++++++++++++++++-----
 t/t5584-http-429-retry.sh | 21 +++++++++++++++++++++
 3 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/http.c b/http.c
index d79678d01f..0308f973a6 100644
--- a/http.c
+++ b/http.c
@@ -345,11 +345,20 @@ static void finish_active_slot(struct active_request_slot *slot)
 	if (slot->results) {
 		slot->results->curl_result = slot->curl_result;
 		slot->results->http_code = slot->http_code;
+		slot->results->retry_after = -1;
 		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
 				  &slot->results->auth_avail);
 
 		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
 			&slot->results->http_connectcode);
+#ifdef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
+		{
+			curl_off_t retry_after;
+			if (curl_easy_getinfo(slot->curl, CURLINFO_RETRY_AFTER,
+					      &retry_after) == CURLE_OK && retry_after > 0)
+				slot->results->retry_after = (long)retry_after;
+		}
+#endif
 	}
 
 	/* Run callback if appropriate */
@@ -2286,15 +2295,6 @@ static int http_request(const char *url,
 
 	ret = run_one_slot(slot, &results);
 
-#ifdef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
-	if (ret == HTTP_RATE_LIMITED) {
-		curl_off_t retry_after;
-		if (curl_easy_getinfo(slot->curl, CURLINFO_RETRY_AFTER,
-				      &retry_after) == CURLE_OK && retry_after > 0)
-			results.retry_after = (long)retry_after;
-	}
-#endif
-
 	options->retry_after = results.retry_after;
 
 	if (options->content_type) {
@@ -2461,10 +2461,6 @@ static int http_request_recoverable(const char *url,
 	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_RATE_LIMITED)
 		return ret;
 
-	/* If retries are disabled and we got a 429, fail immediately */
-	if (ret == HTTP_RATE_LIMITED && !http_max_retries)
-		return HTTP_ERROR;
-
 	if (options->effective_url && options->base_url) {
 		if (update_url_from_redirect(options->base_url,
 					     url, options->effective_url)) {
@@ -2474,7 +2470,8 @@ static int http_request_recoverable(const char *url,
 	}
 
 	while ((ret == HTTP_REAUTH && --i) ||
-	       (ret == HTTP_RATE_LIMITED && --rate_limit_retries)) {
+	       (ret == HTTP_RATE_LIMITED && http_max_retries > 0 &&
+		rate_limit_retries-- > 0)) {
 		long retry_delay = -1;
 		/*
 		 * The previous request may have put cruft into our output stream; we
@@ -2518,6 +2515,8 @@ static int http_request_recoverable(const char *url,
 		ret = http_request(url, result, target, options);
 	}
 	if (ret == HTTP_RATE_LIMITED) {
+		if (http_max_retries <= 0)
+			return HTTP_ERROR;
 		trace2_data_string("http", the_repository,
 				   "http/429-error", "retries-exhausted");
 		return HTTP_RATE_LIMITED;
diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
index 1a5d7987db..bd06d94c16 100644
--- a/t/lib-httpd/http-429.sh
+++ b/t/lib-httpd/http-429.sh
@@ -32,12 +32,33 @@ repo_name="${repo_path%%/*}"
 safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
 state="http-429-state-${safe_name}"
 
-# Check if this is the first call (no state directory exists), or if
-# the retry-after-value is "permanent", which indicates a 429 must be
-# returned for every request (even if the state directory exists).
-if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
+max_fails=1
+case "$test_context" in
+*-fail-2*) max_fails=2 ;;
+*-fail-3*) max_fails=3 ;;
+esac
+
+should_fail=0
+if test "$retry_after" = permanent
+then
+	should_fail=1
+else
+	mkdir -p "$state" 2>/dev/null
+	i=1
+	while test $i -le $max_fails
+	do
+		if mkdir "$state/$i" 2>/dev/null
+		then
+			should_fail=1
+			break
+		fi
+		i=$((i + 1))
+	done
+fi
+
+if test $should_fail -eq 0
 then
-	# Already returned 429 once, forward to git-http-backend
+	# Already returned 429 max_fails times, forward to git-http-backend
 	# Set PATH_INFO to just the repo path (without retry-after value)
 	# Set GIT_PROJECT_ROOT so git-http-backend can find the repository
 	# Use exec to replace this process so git-http-backend gets the updated environment
diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
index a22007b2cf..d92a26893d 100755
--- a/t/t5584-http-429-retry.sh
+++ b/t/t5584-http-429-retry.sh
@@ -51,6 +51,27 @@ test_expect_success 'HTTP 429 with Retry-After is retried and succeeds' '
 	test_grep "refs/heads/" output
 '
 
+test_expect_success 'http.maxRetries=1 retries once and succeeds' '
+	test_config http.maxRetries 1 &&
+	git ls-remote "$HTTPD_URL/http_429/max-retries-one/none/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'http.maxRetries=2 fails after 3 failures and succeeds on 2 failures' '
+	test_config http.maxRetries 2 &&
+	test_must_fail git ls-remote "$HTTPD_URL/http_429/max-retries-two-fail-3/none/repo.git" 2>err &&
+	test_grep "rate limited" err &&
+	git ls-remote "$HTTPD_URL/http_429/max-retries-two-fail-2/none/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output
+'
+
+test_expect_success 'Trace2 logs actual CURLINFO_RETRY_AFTER value instead of -1' '
+	test_config http.maxRetries 1 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace-retry-after.event" \
+		git ls-remote "$HTTPD_URL/http_429/trace2-retry-after/1/repo.git" >output 2>err &&
+	test_grep "\"key\":\"http/429-retry-after\",\"value\":\"1\"" trace-retry-after.event
+'
+
 test_expect_success 'HTTP 429 without Retry-After uses configured default' '
 	# Enable retries and configure default delay
 	test_config http.maxRetries 3 &&
-- 
gitgitgadget

