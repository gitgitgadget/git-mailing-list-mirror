Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732251;
	b=EkalMlQhQPrmXpZrJlnH1UlvSAd62znbqrjyHc9OC7FbG03VlH3ESfykJ9IG7eTIxyHM
	 3pDluDtXRJ+C9y6EiVaWMjPemA0IEAAJsSAK4qOK+r4jy9Xr3iKVD4/aG86NlRs6sdH4e
	 +PWg7AJzlPLlx+Z9Wsn/oMduBx/je68mEFYSIoKkqWUCsVr2X4muAM/VaQdjNNmmi6jNH
	 j7VXD6BnIBTMdKij1v0AuXzMRmuH6+3LIciaMz0IWhN/V94HCd3NL91Lu3HkdEUAHRn30
	 AMFdGRcHePFyHhrM6krLaSSLGjt+qnkRSVIyn0yFFnsNWlMFY7A3YHLcqf/NTZRYEzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=u9I+SL3jarC/+feCS/fh/oqxVNve8OXkKU5DDQtwln8=;
	b=PZj7KNxM+QXGekxUgKABxsT0g3iC3XUV+dwzLCqdOaYDQXcGGFj7xWzxsXifdzkrXLlO
	 AuQFkJvnIFpvCdhO5kc6pNahnFODeygvx4eQNyyvfwVakSfKblgxH1XrZaMJa2WXzoyU1
	 /QN05NfMRc4mcl4H7BPJhlAaj/XFVapyRZoKKjfoOPMagaSYKNNXlk+dZsziYUcYi3RwC
	 D77qLAZyfahL/9F1r5ccBIWAX/u+INK73m6tW03eX5EZ6LmiLnB98kP4IugmiBtZxQ01l
	 ZYjAMSD+n4WQ62pzCIbPhJd8bvKqGnIyRwmqTpa1FZdMCaQRSmRJhtTjwEKNZQqKVhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kUkmJAuZ;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB7606D805
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 18:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3FB7606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kUkmJAuZ
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-943e8d35f74so421069085a.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 10:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732250; x=1794337050; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u9I+SL3jarC/+feCS/fh/oqxVNve8OXkKU5DDQtwln8=;
        b=kUkmJAuZsGjmtTF+9oWh9aibtTMwgTlWqPiA+QdwY9dcYnEEFBYqy+lPcbwtUJhuXJ
         /Y/zfWjkhPyxapXS1Q97tVZ4PbFjJ8V1Lql9IMuvy0AdHQbu5gxeaYeRAzcFF1W/yWeq
         7BdcBapQ+EAETf4TFSOy9vjKyE5PGceFqiqQ3VENRG7eUYhU7AufIwaxDwUzO9V4YxIT
         dHA0o9ock1xd3TJXteknU0BIUqUAr06X5+RKp1a3sGularROXxQyfDgPSudsSUdec6CY
         ydaYn7+SoqZ+NBuhxSBH0hMKs22w5BSbBE0HK+Q9M3KgfNa5BLS5x0ZrYLd770TkhEt3
         V/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732250; x=1794337050;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9I+SL3jarC/+feCS/fh/oqxVNve8OXkKU5DDQtwln8=;
        b=I8W8JugswI86VT1jBaW9Bcpl17SCXvBhx3kMPeiRuh7BoNAce3Yci27mITnY6sKG1j
         oxHs82RYRie6VWEfo6mghufjcwF8S9idL/0Tb3XWzCfhPCmA4VCu4L1h6UnkcV9RkE/p
         zQquLbPDrH3D0k8oZWPJBsWh/0Pz36usR4/kAsOIh/OP0eoy6tz8uLMgYx4yo9iQ8/+U
         9i1hXM90DwPOmbpmTD+5chFl41go3bRzng/cmZx7DItIu5o2NCCHQzkqegzlMaX9BbCH
         sUBsUUEKWE9CwfvoHC675I/qZd/lwiotlsR5sbts0slqeFaSeN4Ye7whBqcx28mQrZ8B
         w1Tw==
X-Gm-Message-State: APuU4Z9QdFocv4aKaNo2xXZ/CcQ02/4KTDPh69v/Tu19LImOSwvS9Uuu
	a3j7ECPBSrCnrvZvjLrbJLiYg30WA7APkpuzQO+Ml/21xu+ZvMgyBaddtjwbtQiw
X-Gm-Gg: AYBFou307OrRTvuapUqyQA8lzHNIT4fICnFEShSAzX8d2Yb4te3mxbB6ZvkutSMKT73
	M4yImqeUT2CKWwoe5wkUFzZo+XlAY2QUurH5gx0YQR4bf3lVpwWauYCIzFroYO/5ANnnvkSiJfj
	1fRYQ7Kuo0rdQVAO5HGV7Lt+5ghEblwOlFw5dXrIZMVkYH3fsJ9Byl3O5+UqMoKjosVbiUVrW1y
	00MpvPPdJlg3/MOkqM8qHBdzUTN/ZQg4Myma1LsB0G+otzhy2LEr6IKwkAldP+SkMMOh/GYINEG
	akltmslTi/mjYdyyCjulrDviEe53Kq/1DVD3NN482TnakAis0p8rX3ihVDsfs9OTMfsGUTeYW38
	xtabklN1jNudQt5MdKn/Uc9JkTdYMlvSZiWX4/fqEx/sF/zUyb1hjvNQvWG0ZOl1RWjNxJg3pYi
	xEm/ZsVC97dCkKMikVsxaES0RV6ylsuMSAHZGXnIeNe9CFeJwEWyUmqlM2nSNeo9yA2a6BgJQb7
	/4VW3gcnit1LaSpzp9jngXRoEv6gRrNAQJyQC3wsYIbFwGFaxEFovTl7lLbd1orUyTGTvsFa/1n
	P+r0S1VOSShPow5BD+F253UnUsoS7kEc
X-Received: by 2002:a05:620a:4686:b0:93e:5821:2c5c with SMTP id af79cd13be357-944217f70aemr2325745185a.60.1793732249334;
        Tue, 03 Nov 2026 10:57:29 -0800 (PST)
Received: from [127.0.0.1] ([20.124.87.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48577ebsm3078685a.33.2026.11.03.10.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:57:28 -0800 (PST)
Message-Id: <d53778dd4635bd7dfb5b115a23f3642ea3ae40e8.1793732247.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 18:57:24 +0000
Subject: [PATCH v2 1/4] http: fix retry count and Retry-After timing
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

