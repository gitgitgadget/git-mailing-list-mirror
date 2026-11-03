Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732253;
	b=JdfYHtnDmw3dIR2WTiYGvZ9D+tJzHvIlWiyYE9IKpHFRYHCZ/bdblZzruhhu2aetBr2z
	 QLRJuTJNpQKSfHVg7IwcbWj0Ps2A3ORMm8s4V9+s/MrKXr8gW+ukiQHmW7fjQX6HsJCg2
	 ga4OLnUJvz2cXK5oJ4IAqvpCLsG/uLOB4oLI3ub8gL7osAIV0f2Zapc2l6DI2qn6bU2FY
	 wmIg4SbPb6fr2s3URrRpWkLUfGWEJrM6vlowPfVJ5/QyJq+vM0Tza4NPrkX3/C5+Blpgv
	 HDD5AX4sUx/bcz9eq4pgn1+j/Fk33uYq0NpD5xmlV9ZVFco/TSoVq4hMjYXR/oirNLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=BSeOsN3Tf1nG6771Gr3OV3CeCAbQSJA+Ev52MqcP9zw=;
	b=lPu7QOClfjqtUTPeCeN5CUxKqug289fFP3pCfVi8SgyFkjSkj1yVJ9l0HXWwqq/lClzF
	 PIDuaivsbggfo0ZmCOVN4Jk6q2Xa0Zu2L+HC4Jkyuuu6U+pRU94UyG96O/DxmcxvYUZIW
	 w/082pm+uItpwd6SJL0nqrgsGO56UJS1tXhbu1UmUxm+K8wCKV6aqYRyux6Mhxkw3yxf+
	 QCGNUXHEunCLCfLqPR5jHw8ZhHv7iyYKmgweni+DjTnueygtAmiornLh/WDLsVnUpZW8d
	 pOYvVx2TNjJNzUr5GjmgybODl8PMrlWD0SLCOaZ1q5PC71WLAsiu3Wn45NgVMGbR4iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=joy6OUpV;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B498606D825
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 18:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B498606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=joy6OUpV
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917a707f37eso47708886d6.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 10:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732252; x=1794337052; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BSeOsN3Tf1nG6771Gr3OV3CeCAbQSJA+Ev52MqcP9zw=;
        b=joy6OUpVY16uC3HA8rGfXNDOmyKYmQWTnw2GwM0QyWkxpvxT5gqHkTqseLKzte8p/8
         jEHlvEQyFbsL5VgRiq4ysL2m2ZmliZT+RWONTAajwkjn1JpCkHmuSkKfOwOzXOsYGIfF
         DC5aGnhGr2ZdrIN1RFX/mvYj3TEV11L0fC7jYcSp+pYW6oEzdcgu8PGDRGkppGozARkT
         fTBeeupgIBEsj2L4gya/asXTwgF3FK32qNFW2msJjhRmgK5YqVSl3/NJKX5R8MCJluGL
         F9f9hZ5ON+On3vNkxwDDYJAIo5Ng7EU3MdWeFcwTrCSevFP7qxCy+ema+d9qGWV+lPbM
         /quA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732252; x=1794337052;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSeOsN3Tf1nG6771Gr3OV3CeCAbQSJA+Ev52MqcP9zw=;
        b=0aD6zeJHb79gw6FCxyLB+Hksg7CswrQa32/neAMzD2alGuj7/8o+dpS+3YqNqBIkzu
         oaRblCBUkmvdbcgAyP/WO5ZPCyHnd5mTCwOo6rEK/YGCXHJr69qjNJ7CZPJpLPeZk+K+
         bc7Tn7WbNhR5TMFCX0+gIe2M5VDpsdFicRtTV7K//8lr8csOAoj7hePpmPMMfkA7RFk1
         In4Wo/KB5NpQsXKvMNtyz1pEFC3vEjlaPPgoWdrJshqKPCiMv0WRIDm0vzbdtyBP3ApO
         2hHHLOPK1e2djNVSACjJ1qRoG+KafEHSRxM04PRKIQPfolKNAZxJxqSpUEnkHCfYvwwV
         Eo/w==
X-Gm-Message-State: APuU4Z+pZ23parKUM1eLOZpGxDH5nXBWEdZ0flzi9RxNIe7DRd3Oova6
	3S39/uF1q/FY4xrRrZeNojB7bqj8FvpbOneVWKpTZZUKVaKIX3cXbdiiCj6+WquG8IA=
X-Gm-Gg: AYBFou20jQgIU0TkrGslz71L/ozyqZ69cZVhM2dhhpQs47KCbQeAjgYZlzrBjFNKiqD
	MBCwEq6lM+HwICMgFFMoC7M7fhBH6YNS0lLRLgsAhsfM8esZdYAKZMopxu/1A5EcRd+ZfzMNN+3
	irzsiLLehm70Ly/mU4Vm4yJGE2NbkYR5hJvewvEh3Ojc73jivZR83klrCx4Wnl9EN/hsTPkiGgh
	2lVc1zRd5PF+c4eW3V9ep1nT+IR/LbhoeN2ACkyx0soMX6utgle9lZItvpa2AqMXTtfT7Gyt4tD
	Io05l10qTxREqcEBtyc5OcE3qYT1rfzaNS5bVPIJ8DSbp+vK6Y4rkEmd+GL2DjdtRRfsPzE0aPL
	BpnS/RiNjbZWj6l02RPNqMewdZ+fSaTHdk/j3uVJ55peP/mU85TwavVHoCPMOZmb0jZuS9pQk0w
	VeEzmyJw69xJeLhbTl2MEW2cCJvuPklsc3DeBijLJWb9waNGy/FTz396KWq3ybi+X6fYlmwhxR2
	idJJ58/YbZX9/dyfTyWaEP/61Lqh+0mPFBuPq9eGEhKWy0Xjql4nM9PdvI7n5UIqp22bg+FIce7
	AqDcy9gNW2XTd09fEaEsS40Tg8JGVcYt
X-Received: by 2002:ad4:5ae5:0:b0:91c:7037:cb8 with SMTP id 6a1803df08f44-91ca4a16683mr236387586d6.4.1793732251896;
        Tue, 03 Nov 2026 10:57:31 -0800 (PST)
Received: from [127.0.0.1] ([20.124.87.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c700574sm356356d6.24.2026.11.03.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:57:31 -0800 (PST)
Message-Id: <786964ff00368648e5bd0fd4c5889f7c105d0a51.1793732247.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 18:57:27 +0000
Subject: [PATCH v2 4/4] remote-curl: retry transient HTTP errors in post_rpc()
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

Git's existing retry logic only covers HTTP GET requests. However, the
actual data transfer during fetch and clone, as well as on-demand blob
downloads in partial clones, are sent as HTTP POST requests via
post_rpc(), which only retries authentication and immediately aborts on
429 or 5xx.

Extract the retry wait logic from http_request_recoverable() into a
shared http_retry_wait() helper and use it to retry transient HTTP
errors in probe_rpc() and post_rpc(). Also defer reporting RPC errors
until retries are exhausted, and re-attach the "Content-Encoding: gzip"
header when retrying a compressed request.

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 http.c                    | 67 ++++++++++++++++++----------------
 http.h                    |  6 ++++
 remote-curl.c             | 75 +++++++++++++++++++--------------------
 t/lib-httpd/http-429.sh   | 50 ++++++++++++++++++--------
 t/t5584-http-429-retry.sh | 53 +++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 83 deletions(-)

diff --git a/http.c b/http.c
index fc9384353c..ea4f9245c4 100644
--- a/http.c
+++ b/http.c
@@ -2479,6 +2479,34 @@ static long handle_rate_limit_retry(long slot_retry_after, int attempt)
 	}
 }
 
+int http_retry_wait(long http_code, long slot_retry_after, int attempt)
+{
+	long retry_delay;
+
+	if (http_max_retries <= 0)
+		return -1;
+	if (attempt > http_max_retries) {
+		trace2_data_string("http", the_repository,
+				   "http/429-error", "retries-exhausted");
+		return -1;
+	}
+	retry_delay = handle_rate_limit_retry(slot_retry_after, attempt);
+	if (retry_delay < 0)
+		return -1;
+	if (retry_delay > 0) {
+		if (http_code == 429)
+			warning(_("rate limited, waiting %ld seconds before retry"),
+				retry_delay);
+		else
+			warning(_("HTTP %ld, waiting %ld seconds before retry"),
+				http_code, retry_delay);
+		trace2_data_intmax("http", the_repository,
+				   "http/retry-sleep-seconds", retry_delay);
+		sleep(retry_delay);
+	}
+	return 0;
+}
+
 static int http_request_recoverable(const char *url,
 			       void *result, int target,
 			       struct http_get_options *options)
@@ -2486,7 +2514,7 @@ static int http_request_recoverable(const char *url,
 	static struct http_get_options empty_opts;
 	int i = 3;
 	int ret;
-	int rate_limit_retries = http_max_retries;
+	int attempt = 0;
 
 	if (!options)
 		options = &empty_opts;
@@ -2508,9 +2536,8 @@ static int http_request_recoverable(const char *url,
 	}
 
 	while ((ret == HTTP_REAUTH && --i) ||
-	       (ret == HTTP_RATE_LIMITED && http_max_retries > 0 &&
-		rate_limit_retries-- > 0)) {
-		long retry_delay = -1;
+	       (ret == HTTP_RATE_LIMITED &&
+		!http_retry_wait(options->http_code, options->retry_after, ++attempt))) {
 		/*
 		 * The previous request may have put cruft into our output stream; we
 		 * should clear it out before making our next request.
@@ -2535,37 +2562,15 @@ static int http_request_recoverable(const char *url,
 		default:
 			BUG("Unknown http_request target");
 		}
-		if (ret == HTTP_RATE_LIMITED) {
-			retry_delay = handle_rate_limit_retry(
-				options->retry_after,
-				http_max_retries - rate_limit_retries);
-			if (retry_delay < 0)
-				return HTTP_ERROR;
-
-			if (retry_delay > 0) {
-				if (options->http_code == 429)
-					warning(_("rate limited, waiting %ld seconds before retry"),
-						retry_delay);
-				else
-					warning(_("HTTP %ld, waiting %ld seconds before retry"),
-						options->http_code, retry_delay);
-				trace2_data_intmax("http", the_repository,
-						   "http/retry-sleep-seconds", retry_delay);
-				sleep(retry_delay);
-			}
-		} else if (ret == HTTP_REAUTH) {
+		if (ret == HTTP_REAUTH)
 			http_reauth_prepare(1);
-		}
 
 		ret = http_request(url, result, target, options);
 	}
-	if (ret == HTTP_RATE_LIMITED) {
-		if (http_max_retries <= 0)
-			return HTTP_ERROR;
-		trace2_data_string("http", the_repository,
-				   "http/429-error", "retries-exhausted");
-		return options->http_code == 429 ? HTTP_RATE_LIMITED : HTTP_ERROR;
-	}
+	if (ret == HTTP_RATE_LIMITED &&
+	    (http_max_retries <= 0 || attempt <= http_max_retries ||
+	     options->http_code != 429))
+		return HTTP_ERROR;
 	return ret;
 }
 
diff --git a/http.h b/http.h
index 5985a0f71f..fa9f46a11b 100644
--- a/http.h
+++ b/http.h
@@ -201,6 +201,12 @@ int http_get_strbuf(const char *url, struct strbuf *result, struct http_get_opti
 int http_get_file(const char *url, const char *filename,
 		  struct http_get_options *options);
 
+/*
+ * Wait before retrying a transient HTTP error (1-based attempt count).
+ * Returns 0 if the caller should retry, or -1 to stop retrying.
+ */
+int http_retry_wait(long http_code, long slot_retry_after, int attempt);
+
 int http_fetch_ref(const char *base, struct ref *ref);
 
 struct curl_slist *http_append_auth_header(const struct credential *c,
diff --git a/remote-curl.c b/remote-curl.c
index 2c35dd5240..d73aaebadb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -845,35 +845,22 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 	return size;
 }
 
-static int run_slot(struct active_request_slot *slot,
-		    struct slot_results *results)
+static void report_rpc_error(struct slot_results *results)
 {
-	int err;
-	struct slot_results results_buf;
-
-	if (!results)
-		results = &results_buf;
-
-	err = run_one_slot(slot, results);
-
-	if (err != HTTP_OK && err != HTTP_REAUTH) {
-		struct strbuf msg = STRBUF_INIT;
-		if (results->http_code && results->http_code != 200)
-			strbuf_addf(&msg, "HTTP %ld", results->http_code);
-		if (results->curl_result != CURLE_OK) {
-			if (msg.len)
-				strbuf_addch(&msg, ' ');
-			strbuf_addf(&msg, "curl %d", results->curl_result);
-			if (curl_errorstr[0]) {
-				strbuf_addch(&msg, ' ');
-				strbuf_addstr(&msg, curl_errorstr);
-			}
+	struct strbuf msg = STRBUF_INIT;
+	if (results->http_code && results->http_code != 200)
+		strbuf_addf(&msg, "HTTP %ld", results->http_code);
+	if (results->curl_result != CURLE_OK) {
+		if (msg.len)
+			strbuf_addch(&msg, ' ');
+		strbuf_addf(&msg, "curl %d", results->curl_result);
+		if (curl_errorstr[0]) {
+			strbuf_addch(&msg, ' ');
+			strbuf_addstr(&msg, curl_errorstr);
 		}
-		error(_("RPC failed; %s"), msg.buf);
-		strbuf_release(&msg);
 	}
-
-	return err;
+	error(_("RPC failed; %s"), msg.buf);
+	strbuf_release(&msg);
 }
 
 static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
@@ -899,7 +886,7 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
 
-	err = run_slot(slot, results);
+	err = run_one_slot(slot, results);
 
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
@@ -913,12 +900,14 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_received)
 {
 	struct active_request_slot *slot;
+	struct slot_results results = { 0 };
 	struct curl_slist *headers = NULL;
 	int use_gzip = rpc->gzip_request;
 	char *gzip_body = NULL;
 	size_t gzip_size = 0;
 	int err, large_request = 0;
 	int needs_100_continue = 0;
+	int attempt = 0;
 	struct rpc_in_data rpc_in_data;
 
 	/* Try to load the entire request, if we can fit it into the
@@ -941,15 +930,18 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	}
 
 	if (large_request) {
-		struct slot_results results;
-
 		do {
 			err = probe_rpc(rpc, &results);
 			if (err == HTTP_REAUTH)
 				http_reauth_prepare(0);
-		} while (err == HTTP_REAUTH);
-		if (err != HTTP_OK)
+		} while (err == HTTP_REAUTH ||
+			 (err == HTTP_RATE_LIMITED &&
+			  !http_retry_wait(results.http_code,
+					   results.retry_after, ++attempt)));
+		if (err != HTTP_OK) {
+			report_rpc_error(&results);
 			return -1;
+		}
 
 		if (results.auth_avail & CURLAUTH_GSSNEGOTIATE || http_auth.authtype)
 			needs_100_continue = 1;
@@ -998,10 +990,11 @@ retry:
 
 	} else if (gzip_body) {
 		/*
-		 * If we are looping to retry authentication, then the previous
-		 * run will have set up the headers and gzip buffer already,
-		 * and we just need to send it.
+		 * If we are looping to retry, then the previous run will
+		 * have set up the gzip buffer already, and we just need to
+		 * send it.
 		 */
+		headers = curl_slist_append(headers, "Content-Encoding: gzip");
 		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
 		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, cast_size_t_to_curl_off_t(gzip_size));
 
@@ -1066,14 +1059,20 @@ retry:
 
 
 	rpc->any_written = 0;
-	err = run_slot(slot, NULL);
-	if (err == HTTP_REAUTH && !large_request) {
-		http_reauth_prepare(0);
+	err = run_one_slot(slot, &results);
+	if (!large_request && !rpc->any_written &&
+	    (err == HTTP_REAUTH ||
+	     (err == HTTP_RATE_LIMITED &&
+	      !http_retry_wait(results.http_code, results.retry_after, ++attempt)))) {
+		if (err == HTTP_REAUTH)
+			http_reauth_prepare(0);
 		curl_slist_free_all(headers);
 		goto retry;
 	}
-	if (err != HTTP_OK)
+	if (err != HTTP_OK) {
+		report_rpc_error(&results);
 		err = -1;
+	}
 
 	if (!rpc->any_written)
 		err = -1;
diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
index 5c7d58a75f..ec70a4e9d1 100644
--- a/t/lib-httpd/http-429.sh
+++ b/t/lib-httpd/http-429.sh
@@ -39,21 +39,36 @@ case "$test_context" in
 esac
 
 should_fail=0
-if test "$retry_after" = permanent
+case "$test_context,$REQUEST_METHOD" in
+	*-post-only*,POST)
+		can_fail=1
+		;;
+	*-post-only*,*)
+		can_fail=0
+		;;
+	*)
+		can_fail=1
+		;;
+esac
+
+if test $can_fail -eq 1
 then
-	should_fail=1
-else
-	mkdir -p "$state" 2>/dev/null
-	i=1
-	while test $i -le $max_fails
-	do
-		if mkdir "$state/$i" 2>/dev/null
-		then
-			should_fail=1
-			break
-		fi
-		i=$((i + 1))
-	done
+	if test "$retry_after" = permanent
+	then
+		should_fail=1
+	else
+		mkdir -p "$state" 2>/dev/null
+		i=1
+		while test $i -le $max_fails
+		do
+			if mkdir "$state/$i" 2>/dev/null
+			then
+				should_fail=1
+				break
+			fi
+			i=$((i + 1))
+		done
+	fi
 fi
 
 if test $should_fail -eq 0
@@ -75,6 +90,13 @@ then
 	exec "$GIT_EXEC_PATH/git-http-backend"
 fi
 
+# Drain POST request body before returning synthetic error so Apache mod_cgi
+# does not reset the TCP connection.
+if test "$REQUEST_METHOD" = POST
+then
+	cat >/dev/null
+fi
+
 # Output HTTP 429 (or configured status) response
 status_line="429 Too Many Requests"
 case "$test_context" in
diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
index f3e7dbaaa4..e627aa2b63 100755
--- a/t/t5584-http-429-retry.sh
+++ b/t/t5584-http-429-retry.sh
@@ -365,4 +365,57 @@ test_expect_success 'GIT_HTTP_RETRY_STATUS_CODES and urlmatch http.<url>.retrySt
 	test_grep "refs/heads/" output
 '
 
+test_expect_success 'Protocol v2 POST /git-upload-pack retries 429 and 502' '
+	test_when_finished "rm -rf clone-v2-429 clone-v2-502 clone-v2-fail" &&
+	test_config_global protocol.version 2 &&
+	test_config_global http.maxRetries 3 &&
+	test_config_global http.retryAfter 1 &&
+	test_config_global http.retryStatusCodes "429,502" &&
+	git clone "$HTTPD_URL/http_429/v2-post-only-429/1/repo.git" clone-v2-429 2>err &&
+	test_grep "rate limited, waiting 1 seconds before retry" err &&
+	test_grep ! "RPC failed" err &&
+	git clone "$HTTPD_URL/http_429/v2-post-only-status-502/1/repo.git" clone-v2-502 2>err &&
+	test_grep "HTTP 502, waiting 1 seconds before retry" err &&
+	test_grep ! "RPC failed" err &&
+	test_config_global http.maxRetries 1 &&
+	test_config_global http.retryAfter 0 &&
+	test_must_fail git clone \
+		"$HTTPD_URL/http_429/v2-post-only-fail-2-status-502/none/repo.git" \
+		clone-v2-fail 2>err &&
+	test_grep "RPC failed; HTTP 502" err
+'
+
+test_expect_success 'partial clone lazy blob fetch (promisor-remote) retries transient 502' '
+	test_when_finished "rm -rf partial" &&
+	test_config -C "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" uploadpack.allowfilter 1 &&
+	test_config -C "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" uploadpack.allowanysha1inwant 1 &&
+	git clone --filter=blob:none --no-checkout "$HTTPD_URL/smart/repo.git" partial &&
+	git -C partial config remote.origin.url \
+		"$HTTPD_URL/http_429/promisor-post-only-status-502/1/repo.git" &&
+	git -C partial config http.maxRetries 3 &&
+	git -C partial config http.retryAfter 1 &&
+	git -C partial config http.retryStatusCodes "429,502" &&
+	git -C partial checkout HEAD 2>err &&
+	test_grep "HTTP 502, waiting 1 seconds before retry" err &&
+	test_grep ! "RPC failed" err
+'
+
+test_expect_success 'gzipped POST /git-upload-pack preserves Content-Encoding: gzip on retry' '
+	test_when_finished "rm -f curl.log gzip.headers" &&
+	test_config protocol.version 2 &&
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+	set -- &&
+	for i in $(test_seq 30)
+	do
+		set -- "$@" -o "very-long-server-option-to-exceed-1024-bytes-$i" || return 1
+	done &&
+	GIT_TRACE_CURL="$(pwd)/curl.log" git ls-remote "$@" \
+		"$HTTPD_URL/http_429/gzip-post-only-429/1/repo.git" >output 2>err &&
+	test_grep "refs/heads/" output &&
+	test_grep "rate limited, waiting 1 seconds before retry" err &&
+	grep "Content-Encoding: gzip" curl.log >gzip.headers &&
+	test_line_count = 2 gzip.headers
+'
+
 test_done
-- 
gitgitgadget
