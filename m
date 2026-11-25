Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628917;
	b=fCL0YGpQAbMQo5IUmVkRYAKMGnbKTLO4bpykLM9S+KdunfHnMXruW4MrCpUy+jujblFL
	 QJlG2Dm9cZVf0Qg8Ri1xl/NJC0ERnvSD95f1kx6KyDccdcdv5Y+TslOT4Uj2X1bYywvVA
	 YnIci6geOcvLW5Hi97VMlnd+Kk08VxLdqyrnzX8RjTokiEjw5uTO5kHmbV6/L5e5kVLuQ
	 nx6KfUC8/yScf4FVKVut+ibSHDznMfybKq9BP38N6y3AUbnH+GpoOPta34LdqY6ir5RSt
	 XMA3BpCiw3bxsaUa1XSonoLHGXmZumoCvEwuv4hh2I4VUh1EwAVysEVBpd8SlMSwnIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=UDp3PI/TMlQSH4xcRUFNiwFphbLraNKrIR4v6YllvJY=;
	b=znf1m7uVUHiUK3QNtdApRd7EmAGgaGY2ybzryMUjTACIvHxu0P4TwiO0UyU1l/UolHWJ
	 UOLy11Eul5wltVfDWv3T86rwlN/AyXmA8TKULC5paWUgCHB2uVHjSslfM+ZUVf6KsiBSS
	 NRTMiLLCNVB4Y0S2x+31JI0K5XNDpN9HboamXB95+r9pOKeojdr8KrgEONK0+sQNUECxi
	 vWONnqAatDO8+0l5ZAbbMuNB7FMFSzA6XvVagqWbbrydq8F8xTM1xVNsO+1Dp1t1WflID
	 Kb8Nm9trsKGCrfKbTGHj84afuv4qfAFw8WE249RJqHZRBoiX23CTOTXrmGDjgQbpp3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVVXT2hQ;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDAB606A339
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDAB606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVVXT2hQ
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdeaf4ea5e0so634272a12.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 09:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795628916; x=1796233716; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UDp3PI/TMlQSH4xcRUFNiwFphbLraNKrIR4v6YllvJY=;
        b=iVVXT2hQuBANvKiHrYkO43J5vVHa63xtutQDnfOpJurCts8/yI04DjhhEw666rwBxv
         1tmlEGJyPEzcc6ZFYBHg6Ig1TcrV4FJ8X7l5EMsFlvHymVFP4W1XpFK3TfUL+uXMdsdO
         dqvRSg25POCyrUrtvwRpK+PyPnZZsjhTnU70Tl3/FQARrXG43Gzb3/0esYQ3zoTZrb+t
         suMUOhFIVMDB+RWoU/n4zqfVtoENv0sH0wtDZN+cRZ+dSezLSyMKLCjPMoKyV2eDOc8p
         s54z21C9ez3eJAEQVGcNsDiXfOVdd4eD+LGejcS8GGb6eiZMNelTTXGBP/VG7kM+vr7u
         79jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628916; x=1796233716;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDp3PI/TMlQSH4xcRUFNiwFphbLraNKrIR4v6YllvJY=;
        b=AP0HynXoT06VpemSjfEf4o6dGg41mM286qmkKElvV4OWjW5PQWnJuaa6WW+f0MiYOp
         6XLgxBIs6kaX8iGZAZeD1RNZqJVcfFRzTNZ28keuYtiBq5isGF7mbnkwMLif5R7kv6oV
         4cEOx9RzLxRfuWOEvZM4SjLFGhLLirCXHEuPiVqkNX6HeOEgapLSCXl2fvLTUX4GyRop
         DPhBlrXehJ6r+1lz+EoNUk9OXbOri4CZPikkyvzpVzgtBGsbvsucxWZXkmOMc/fY40d5
         L0ufG5SM3OSMeNo71MaNMKQxQopIiCqAdtD4cutcYJMfP1jR99q2yYoZ0ZvVbUxu1nz/
         jjTw==
X-Gm-Message-State: APuU4Z8PHn044Rs38qvMWpYFZJOoyyfB/8okDD0pfVt+BXo6O04GwTFe
	BszI6qc76YN5pj4LN3PrN4PDogLeTGA0z4CWGn7D3X1U6RT88aiLLa+vctxkHQ==
X-Gm-Gg: AZFdTZf1RXaDxor9hIj9hotAcVrN/MAUodXdprm66k9MU6F4W9YG9Gmn6PFpq9eOOUq
	Pjp6rrl3NH+nK2gd0jsz17M0etUz2wzsezViLXeAR5AbhniJfUIZvmeMpQ9vUhMvymSl8oOpEJ3
	mX4rTPyNItdUe6pb5mw4CS3asjFmzkTMiYo2qZbeufP+cv8b7x/CCtZ4o3wNBCHeWaQnCkcD2rW
	FUouQgZZLt61MSKG9FoqG/N6vSQyYpIxKz0P4OzyaHQCkIBEEKin0arAsSF9QCEUaX8AZ/U7wWr
	hV8eWAlQtXmuUPDyDh20bOc8nqLQZnLTqV1bX67xeT8oD3bnI3gI2wGyVdQbZ95sWYVP0aLOuP4
	UwlJQNNSqyRw9NRUw1i2XnTQ3T8634TprJcq/YHu1yrlWNUSE505ADaaeWEJETCWcFb4UrxJUL9
	GtPJg+7guixBR3ombBG3Ls47K6aD0ITCunn899oeFe0O+TJgoOzy8t/F1apcLi8H0P9KX8YP4UN
	L5C6R+eCiL6UNgCBEHE/bBgxphXT37DZyQ0Xepj256kGTD7fZcqXhzGZMSPVotTwCBTlGBH20XW
	85S+hhDppwBSATUumXnc8NtciUdU
X-Received: by 2002:a17:903:32ca:b0:2e5:41d6:178c with SMTP id d9443c01a7336-2f03f20f8d0mr135771225ad.33.1795628916335;
        Wed, 25 Nov 2026 09:48:36 -0800 (PST)
Received: from [127.0.0.1] ([51.57.86.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42b1sm89661775ad.17.2026.11.25.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:48:35 -0800 (PST)
Message-Id: <d4d34077283370cfa22e9d8f57edfb35de9c692a.1795628913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v5.git.1795628913.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v5.git.1795628913.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 17:48:29 +0000
Subject: [PATCH v5 1/5] http: fix retry count and Retry-After timing
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

