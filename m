Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022841;
	b=zEv+EFVTt0Gih+K3PYlGcX85TSwGhoCZFinxdH4kPlM0grhmaRBfPZI/pNbv452WL/VV
	 wNL1NfxQIWY2bDxczp9MBLRontwh847GgUjMoLQaPPaiQwninpY5wJK6yRcDuCwc0s8XP
	 5DtEwvx41eybum74HoiQRMKUJRYsgERtxwQc8oxR6dbj/XJeocTk6a426lGZv2cR3ngRl
	 lwBKSMtPh4lN+AwNTa7KGzMD8byYVFUPCcwreFNsff48Z0vdXgBSRn+w2S3RfZ8smuKc1
	 dRE1HR9abmcrYv0C6le7qBAVkVTNpDFosBg/YGqdI/qwN3+geu2dLCCMJ6R7a26BeyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=u9I+SL3jarC/+feCS/fh/oqxVNve8OXkKU5DDQtwln8=;
	b=0t3DB1BAQe2q3P1kwCJIfQANKcVQndwOhU0q7+/aX5lQZGPCEQYTW7aokv+P+Uy3iMTk
	 3k9SpCo+1BSj6dxCFzRF85UklJM6QPjFSwZivi1H25y79JrkeyPrV1OTM4lxw+9cUZF67
	 dxp1Gt60WEDtRKQMJdvdAxeFFGutnAMaFO7WLyLs/n4+OsJZOOSdVFM/oUULbzM0nCtm7
	 3vutHQfz3h22HNQdMjhsflfr7GRZ0cRqX+rC4N+EpLyxmrBOOAy8S4Nuk3VWkHOtyuuiP
	 YYcNvkcmaGPZrzHtN05W//fvE3+kGlTEKgzVltBWtryRgiD9xiO5C2sRSvfz6yzqcWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLBHXLMo;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804E606A332
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 03:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D804E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLBHXLMo
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f3c616c84so115548185a.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 19:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022840; x=1794627640; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u9I+SL3jarC/+feCS/fh/oqxVNve8OXkKU5DDQtwln8=;
        b=MLBHXLMowcvEpyAmZsDE6yFH0tQaJtJdxtrQmiFzUzR9mbnbZASH9DhQskSqKDtupJ
         U8cSFW+nryJg2UquQD8dwh0Hdj/dE8Xcjx1S4tWy3D1tTcEV5RMvdzGtTvoPy9QMnsrU
         kJalHZj8dYEh9UYzCumFk5G3e1t6Y83K62a9Ha7dFwL3WdhF1l5o5nXt3SkGyR0KHMVF
         0ENGLQucPz1mMP9+9UwA46dX6GO3LxF03eu/Ga/BWKHF4myCS+QEBYlqIzE+1i9k5wxz
         lG6jZzAza5FFuSLczXIFxMOLVD5QR2NDZf3ZbPvhoEFl7TzEe0NbWrPE6c3nIgd2BNJC
         amSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022840; x=1794627640;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9I+SL3jarC/+feCS/fh/oqxVNve8OXkKU5DDQtwln8=;
        b=pNjMJJAEZpyMJrQ2UVjn9aBAEMrlTTIMw82eISKUxvdxq6N5dB9J3gOppT2VLl8SEB
         cYzxqjShdQ5uWuonJrqSKs6JurI4ZZCeQDZF007Wi3NW+btoQaJVFWOK573s+a+qNJF/
         4432/6Dt+uHMHNsvci8sMbzZMMdTufb3scbYo635aP+97Wx2oUUzIyFOcAdQHBfWxeuT
         zQB97ipcmVf6p7Ezy/8vLl51rOtcsh+zqXE0bmsOKc+Z3WJakwmbaaLjWbPGHX6RqjNd
         hI/lUk3RaMHrt4SSJKnStgyCzEGgjUFPCMZ8/01nVOTVAaTVRs7PjzaxNVCXzew+H8Gg
         fReQ==
X-Gm-Message-State: APuU4Z/vJQDJ/mGS/yzbYArToIxXe4VIF4FXJ2xH57aD99z9SRixyTPj
	9hGEAjlwML+g81s5h/6pk/Qb0VPT3sZGmaeulGOV1XZPPkoEUxyrYLV3TwRlNPRm
X-Gm-Gg: AYBFou16pGSDHlOSo/YYjpz0kP1iIf+5jAVEJK6O6bs8u2j9xYzGf63/IUOSBTb4w6p
	PKaX8RngI+92XhGcy+ywrNrv5P3dFEl0nkLzn04Ve3cJ4Boeo/A+XNJIciZ99eT9mrMWY0/6Rjz
	W0YK/+qy6Yhn/TONZBtOF7+FgsLVq+WOwmuju0+9Wt/Ed9aDiNBOkWuJGM6AY2LH/Qa9fQhfDt7
	bapMXLOW5y5JtoHkCGTDqRFQuC3PXvuX/BIwauRFa4GMAPShovab105qI+VgrObGwgi54iptL6a
	nDANkgnkxL+boinoH3LKDq5pgbGjVv0PJ0TO28OXpisLtSI2R9aGAJ9ApDKdrXKeufpKHYE21yM
	/2h7wgOP17H7hIKpAG59zvWoJXnFAHnFJcN9RYgmsOsCiYc9W9E2+KuvhkNK0YzUyO2iOBDzg7o
	dbyblRChNuDNzTsllxqM3Je4QEGJbpOqXfvwaN7L5LorSzDA+V38H7RQhTdj/5npIhkoeq0B4fC
	3+IUj2yOzgjz65J+fllCwjyLyWt69aEM9iHTOdooyobuDi/WYjdG3opsTXlY4Y4bHePtl3l0dh5
	p40nrJQJIQvHCOmaAurqciOh+KkpZk9YErVy/oIrYdM2O3CevUzP
X-Received: by 2002:a05:620a:28d6:b0:93f:3163:3e5c with SMTP id af79cd13be357-945f357701fmr722856585a.81.1794022839677;
        Fri, 06 Nov 2026 19:40:39 -0800 (PST)
Received: from [127.0.0.1] ([20.65.86.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f58bdeddsm287133685a.3.2026.11.06.19.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:39 -0800 (PST)
Message-Id: <d53778dd4635bd7dfb5b115a23f3642ea3ae40e8.1794022836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 03:40:32 +0000
Subject: [PATCH v3 1/5] http: fix retry count and Retry-After timing
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

