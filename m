Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793462227;
	b=Ygew3JhQJOWnPdN8mT5ulAKQho3xGA467vpbwEjWijmh6i8nWspIDpIw9s5udZdfu4cI
	 aXM7dImHY2c7kzjQxPViSmeaiGCJ2tq5FEHLfjVWC2bA2dslhar/93oO3BaXySC2qIzqt
	 AE+4FkDuiUw3b2z/PzYGouLYHCdIp4M98p1FmTkUTVf6IWkq16nYZOgwYSLhUvyjGik23
	 h5cUICGEkSh9yoDM8B/S9m1q1a8aHDZWajbZzCXdPVhaiXRdLajyDC5PwZ5u1tuCzIIVC
	 Xbtti3adv7Ymywjor9YgAZdTloMv9mW7EyrWC0ug/0PQfgFvBsh/oJabUYaAjet8/jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=9Fw/11y+MTSS/vakYn8qZI97ELFnp453j2ehlMfK7QA=;
	b=3wQfv7k8pHi0NNqbx4Wa+zWxNnPOja00rVzdedlNRHH+ggfNSsKbijv5RlM1tPiY+ciO
	 sbgubrKb2gUD9FAhdWX86btYqomVZYZmcTQDXPReolBw8CKzG77d56PhEkLk3Aqvy8fhc
	 yiYpeUxXxdNxCzvcQvFUZuzkaIo0cHfCQXKnnl8Pd7DTu3cXzOgdgRhsfOheN3O50Kack
	 LZGC7e8GX6Qsv9t8FUCEEluaimxhE8KVOoB4La3nI5oZx6FxyyzjfPWlF3MMqB6YfxCo0
	 4kP232ANr9yRvuCHWpvbmqAKA6z94JRD3yx4EveoJu4Uyxx1f2e7DHgEz0GhFxAPs1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n2GRzfp3;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D4606A31F
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 15:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F9D4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n2GRzfp3
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53639b8903bso23783581cf.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793462226; x=1794067026; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9Fw/11y+MTSS/vakYn8qZI97ELFnp453j2ehlMfK7QA=;
        b=n2GRzfp3U7Tqk51O5zQ8j3CrVIzACqntkTD+So3wyvYxv04wipi8ldspZUYw967i8U
         OooaQbGhfDbr8FOhhW8YaknMOaIBtURsKpMAMNJEg8ezXCK+7oQGe9w4u+9cdmYNE0Bg
         Vw4fmgXDVbPT3+b6NB3bGnTYZgSlc76bJA+aophnZIap9GSsjLrUz+uwNAYKDgHMydTK
         hcCssq2Crp+iWbLRBIA5961rcxJl8IRYSERWFOFkyFxKGAJSNiM+vs6sFI2/wUuFo6+E
         +v01VkpPzUz8xutMmmg2ty7h2qGxTHek6T8JRb0kpTU5tifUuMlR1Tu+a/BQnw8XGzwq
         Aiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793462226; x=1794067026;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Fw/11y+MTSS/vakYn8qZI97ELFnp453j2ehlMfK7QA=;
        b=ELn3BJ3iwOlD3RWrwkQxz9OfvrPRp8xXt65Bx2dHrorPXZz7dJdBOq9cOdKhZHrqnX
         BugzDpd5pz6NtprBdLQUfbREzq6ZIPcBqQZOy+82726ncezl3eMwAgxJ75/Qep4gQMg0
         73mbMFsg3VCvn9BMf29UhIUngvsCRTbNjceEo/efhPoZjtHDFSssbDB65bAQZM9W4SNR
         mZpSa/u2LgXQTdTg0VHVcvHru9sLfyls90c8hEuDOD2DChRiC/op3avitMLNvQM4rJ3P
         7Ol0Y+ZmevH1wDEDdmkqjLEEoo5Fx/gIH60CCuyxeRASxJF5KF0c0VtH+3QNhoJbf0Tq
         UqFw==
X-Gm-Message-State: AFq9FYKjAe68tggMkhxEIX+mWVzsrm8gIirHrIormv766YWCACfnrni1
	lQJBMZDv2unbAAZEuGlqVHS77wtK48dQhPyHw3SLNFRr3TBpY2M6egukslhGefK9oA0=
X-Gm-Gg: AYBFou06N453gafS7ur+tjnloGUcpvGxIEMs+t38cgGBcdoP1AbmGjl9T2qruYGXEso
	ldrq1H2vn1fwG+kxHqClgouRL3IVjYQb2ijuIIAPmamrowWjUVu3ISdNylDF05SuflPEY4JNWwA
	1TEOtKpWDJCmOECqTOzv3TKkbWa+Qdzd3Pj5ERVN19TVZ2PRS+oYzLYPkElN0um9nJjpc9Rl/GC
	tVW13V48Ye3kgqGRKr5TRZV2NcdjZ/NHm6WqFFIsb2cAdRL5snnXYvC/z79ZIwEcXnt7brwqlYK
	jbnPvOsMa4u3SoVW9x41Wp8GbfllYTCOCTuJGMXPCyDtJfFgM3Q7JtYjKXQN7/QLxx0OGeScBdE
	V5xwBmOHHXWByeRXPTKfBzI5K/TvHnuODBsQ5HNd3Q6EPlD1hXAlvX2nCRcjf8vSXQ6bJm8EeFW
	FhU/BF0YMVLVkZ9h4NTtjMnyfkE1dp1wvD4swZlVO1EoOuirELEpk69WaXLw2WBn9UTptp5/S8H
	W7FStSPC8ZXvIWvZwnONylsNFhMpPA4MLkzS3aECnhX4tm7xdUSZbJbyfdK20KivhlI4ZkWuZ0i
	cVhtXR/GpeXmsaLxPa5mB/H3hFx6t3pJ06s=
X-Received: by 2002:a05:622a:4c13:b0:535:1740:d334 with SMTP id d75a77b69052e-542b4059965mr80133471cf.3.1793462226136;
        Sat, 31 Oct 2026 08:57:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.126.192])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5430cb79c85sm41457301cf.0.2026.10.31.08.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 08:57:05 -0700 (PDT)
Message-Id: <80b7f207f42cff0a3dfe23181ee315fdc90e50ff.1793462224.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 15:57:01 +0000
Subject: [PATCH 1/4] http: fix retry count and Retry-After timing
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
   in the loop condition and returning HTTP_ERROR when
   http_max_retries <= 0.

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
index 1a5d7987db..5537fb7ac4 100644
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
+	*-fail-2*) max_fails=2 ;;
+	*-fail-3*) max_fails=3 ;;
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

