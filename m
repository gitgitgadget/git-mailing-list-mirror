Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628921;
	b=IlzJFjdgvZbGWJBhAa3AAhMJWyiLPSVikw06QuoAZQCLMbbeJvnAYVN+8RFrI0nXR49P
	 qdbDrBsIghiKx+qbA1AW40EnvsOHrwJhCqhfgNqWe4fhjTMCuZ/OWsIoSIbGmYKcHKr5D
	 A0WXm587hxsL28R/3Uk3sLWGa7rGxDeNIVFtu3GK9ThojUpWweeHWY3qEQQ1KIeYyPBGU
	 C4ZvFyVBdTiLN/GmoZd/dOaW6xOjEP8w8PfD9R3DyR9OZ52IfkIWqBmcVBxAbD5znPejk
	 S1jUJoiay1jIGnt+wHMct2mmrKjhwfD2vVm2IxYKi7c2U0wL/zMnKiUr/A8viW71XDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=rYiwa8+Qiqzh+0mCsEARUVic/aLSQWOaiklCEBbuRLg=;
	b=wlWt/tuW5h4zXfBPpOh4BFPtJgRt8zRziDDhcqi8dG5D1QoPc16tJcxnpX2hAaNt2sog
	 rP6vKOzfV9b8hoaByj1lrJ6l/FrcDWavLjYbDu+KVxlPqlUIWdZhvmWI0pXbtoKFJxRdW
	 JF8cQwbWTBo0pQY+Xjsn+ugvvQB0qgdju/Z1nrXtiLdqTbjrb9RVnO5x33aFfC266GpVT
	 qfk1g8JBe7PgVgqmd3tnRqDC8LqNYNyBi9ifzifOnt6+gV+B3u/zumEAVQSivU7Ln1NXx
	 KHVV1MCQG2Ii9h/UT5XSwQT37rbRLHNkHzkWc8/lCrrzbGhmg+b9mXrfPg/BghRsIhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=inXPWYzn;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5E606A32E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54B5E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=inXPWYzn
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so2579138a12.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 09:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795628920; x=1796233720; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rYiwa8+Qiqzh+0mCsEARUVic/aLSQWOaiklCEBbuRLg=;
        b=inXPWYznYxqUKxnD9uNNbjgeplaysr61uQsltFjP59lvlKEVt4+TjqSjDGt0ZlUbXx
         mHNBpxCv1HN7paF1gO+t0WmuDqmhc1iLwxQ1ZYjaSqaVs5puwoIBkyfEbFrYFN8ba5av
         oq7NaF03E6oGKZ5n+7F5OMYit8/AmluzA6SMpOgQSHuJ8RtRlmI+lrbidgP00olAgtti
         K6bSUCSnl5D5EO0mtHaHAl7brE9/ym/VIO9IhRREQjm3p0yrjTrQxbu33pxxsr8RBiGX
         hxqEGgM+gIqzDBix6HRF9VzCK0jy8MvTT7BVNlBeKtAd+104WoJYbTEHyLKBlNgGiKi6
         eHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628920; x=1796233720;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rYiwa8+Qiqzh+0mCsEARUVic/aLSQWOaiklCEBbuRLg=;
        b=KpwibTKdGs53ImyjCWiRZH8OMDh4QJ4z40bh+zpWw3VZ+kPxZ2V4AoiXQnBfO21aKr
         NuBUATMpPtzNInetyWz81kW6jBhA8AsHYiJAJdGKX68W2Zt+BfBkkEu+kOjT5fFenlkd
         yQPCm7JzY9VE5pJ79uSo3A77DNgm8iVNAdQ765CKg+rpdl99xGPbycnmELIB5Sx8qj91
         BcqOYJ6iwbPGaJzAkxSQLn8uaYnYwayH1iTs0ltikhSICb2Cn02ZKOfAoZ/60ovNUV5H
         m6DqVzcVSJXX1DxD4VNzT6ZOXErcSPgUQ7q3DJAtLhdpsicxRMNJS9LIlSFfx5ETtCo1
         tAtw==
X-Gm-Message-State: APuU4Z9aAuaiPDv9AAULuLqCbESa5UIINfJJpIxsnQwL1rGwzgnPQ39w
	Y5gV6SqdsKDP7JN259Le8cEibvx2AC+zO8+T/0js6W3pbv4IbJeTyeDX+Rryor0O
X-Gm-Gg: AZFdTZddgBCc3M+ijYsaSm6MReZE+lDrLojMVe2wFJx/QLISfE+ZJjgpxwYfKPZI9Pn
	nDZei45EKNMK2sJW3aclMO/PwrCusNommX0vwWDyVpmAjahleHsdS08CpquzM4cu0JuMHlE5cxP
	V6a4OVzTwG5SPMWuf6EUurB2/C+YMloe/e+qmyOv5TR0LDu3kHOfrr9p2yVsOCPzKUC1r3ik+QZ
	jSW+jcjKrTqdf6/Ygi4v4SAg9GTFtffUOo6C+wVIyFtMtHbpY4wAgfmTxJK5Msev4cVpiZP0+k7
	8buf2X94OYIYwUyV6lTjfNKyEjS6uO/Yhi6GvwV0JDyA80NcdpLNK2ETCOQi46qFZzqgcsTEhUb
	p/ztBDOTmbGfLjL6g0cp3G5CJEcLetqwSrHTvy/aFMpGWNcvlXTBZ8SeYxEy7C+tzIABtI+6srT
	wjCeH5fUXUxfXfKUEoqeW9NxVV9s2Uns3+X+qxMvoQA4E+Eb2DQltGmNzvPL0fFFTVmsTpaUb2V
	uQF2xEIEF1ey7HAa3tMQNHwsB3KTuK7j9J3HIMxrSebveCbhSniH7G75gan9TRIlSSmShaLhxOM
	463H01GsEH6nEkPFcPjVtBrdjC4hM0FQxsq/grijkNGYL0wOUA==
X-Received: by 2002:a05:6a21:4989:b0:3fa:bafe:61ec with SMTP id adf61e73a8af0-4014ce5141cmr14926378637.58.1795628920435;
        Wed, 25 Nov 2026 09:48:40 -0800 (PST)
Received: from [127.0.0.1] ([51.57.86.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdea2aed207sm3321919a12.11.2026.11.25.09.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:48:39 -0800 (PST)
Message-Id: <05ca9adf8a9c48f823ff56ffca70fb32f11187cf.1795628913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v5.git.1795628913.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v5.git.1795628913.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 17:48:32 +0000
Subject: [PATCH v5 4/5] remote-curl: retry transient HTTP errors in post_rpc()
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
shared http_retry_wait() helper and use it in post_rpc() to retry
transient HTTP errors for read-only services ("git-upload-pack" and
"git-upload-archive"). Do not retry "git-receive-pack" (git push), since
retrying a push POST after a 502 or 504 is not safe if the remote
already processed the request. Also defer reporting RPC errors until
retries are exhausted, and re-attach the "Content-Encoding: gzip" header
when retrying a compressed request. Clear the slot results before each
request so that a retried request that fails to start does not report
the status of the previous attempt.

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/config/http.adoc |  4 +-
 http.c                         | 67 ++++++++++++++-------------
 http.h                         |  6 +++
 remote-curl.c                  | 84 +++++++++++++++++++---------------
 t/lib-httpd/http-429.sh        | 50 ++++++++++++++------
 t/t5584-http-429-retry.sh      | 69 ++++++++++++++++++++++++++++
 6 files changed, 196 insertions(+), 84 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index cdbed61e5e..f0fde171e3 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -350,7 +350,9 @@ http.maxRetries::
 	Maximum number of times to retry after receiving a retryable HTTP
 	status code. The set of retryable status codes is configured by
 	`http.retryStatusCodes`, which includes only HTTP 429 (Too Many
-	Requests) by default. Set to 0 (the default) to disable retries.
+	Requests) by default. Retries apply to HTTP GET requests and
+	read-only smart-HTTP POST requests (`git-upload-pack` and
+	`git-upload-archive`). Set to 0 (the default) to disable retries.
 	Can be overridden by the `GIT_HTTP_MAX_RETRIES` environment variable.
 	See also `http.retryAfter`, `http.maxRetryTime`, and
 	`http.retryStatusCodes`.
diff --git a/http.c b/http.c
index 4b92819abd..f7f4af7a31 100644
--- a/http.c
+++ b/http.c
@@ -2479,6 +2479,34 @@ static long handle_rate_limit_retry(long slot_retry_after, size_t attempt)
 	}
 }
 
+int http_retry_wait(long http_code, long slot_retry_after, size_t attempt)
+{
+	long retry_delay;
+
+	if (http_max_retries <= 0)
+		return -1;
+	if (attempt > (size_t)http_max_retries) {
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
+	size_t attempt = 0;
 
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
-				(size_t)(http_max_retries - rate_limit_retries));
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
+	    (http_max_retries <= 0 || attempt <= (size_t)http_max_retries ||
+	     options->http_code != 429))
+		return HTTP_ERROR;
 	return ret;
 }
 
diff --git a/http.h b/http.h
index 5985a0f71f..ec96b6d2c7 100644
--- a/http.h
+++ b/http.h
@@ -201,6 +201,12 @@ int http_get_strbuf(const char *url, struct strbuf *result, struct http_get_opti
 int http_get_file(const char *url, const char *filename,
 		  struct http_get_options *options);
 
+/*
+ * Wait before retrying a transient HTTP error (1-based attempt count).
+ * Returns 0 if the caller should retry, or -1 to stop retrying.
+ */
+int http_retry_wait(long http_code, long slot_retry_after, size_t attempt);
+
 int http_fetch_ref(const char *base, struct ref *ref);
 
 struct curl_slist *http_append_auth_header(const struct credential *c,
diff --git a/remote-curl.c b/remote-curl.c
index 2c35dd5240..1b745cd71b 100644
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
@@ -899,13 +886,20 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
 
-	err = run_slot(slot, results);
+	memset(results, 0, sizeof(*results));
+	err = run_one_slot(slot, results);
 
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
 	return err;
 }
 
+static int can_retry_rpc(const struct rpc_state *rpc)
+{
+	return !strcmp(rpc->service_name, "git-upload-pack") ||
+	       !strcmp(rpc->service_name, "git-upload-archive");
+}
+
 /*
  * If flush_received is true, do not attempt to read any more; just use what's
  * in rpc->buf.
@@ -913,12 +907,15 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
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
+	int can_retry = can_retry_rpc(rpc);
+	size_t attempt = 0;
 	struct rpc_in_data rpc_in_data;
 
 	/* Try to load the entire request, if we can fit it into the
@@ -941,15 +938,18 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
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
+			 (can_retry && err == HTTP_RATE_LIMITED &&
+			  !http_retry_wait(results.http_code,
+					   results.retry_after, ++attempt)));
+		if (err != HTTP_OK) {
+			report_rpc_error(&results);
 			return -1;
+		}
 
 		if (results.auth_avail & CURLAUTH_GSSNEGOTIATE || http_auth.authtype)
 			needs_100_continue = 1;
@@ -998,10 +998,11 @@ retry:
 
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
 
@@ -1066,14 +1067,21 @@ retry:
 
 
 	rpc->any_written = 0;
-	err = run_slot(slot, NULL);
-	if (err == HTTP_REAUTH && !large_request) {
-		http_reauth_prepare(0);
+	memset(&results, 0, sizeof(results));
+	err = run_one_slot(slot, &results);
+	if (!large_request && !rpc->any_written &&
+	    (err == HTTP_REAUTH ||
+	     (can_retry && err == HTTP_RATE_LIMITED &&
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
index d42feae8ba..4e23a0007d 100644
--- a/t/lib-httpd/http-429.sh
+++ b/t/lib-httpd/http-429.sh
@@ -39,21 +39,36 @@ case "$test_context" in
 esac
 
 should_fail=0
-if test "$retry_after" = permanent
+case "$test_context,$REQUEST_METHOD" in
+*-post-only*,POST)
+	can_fail=1
+	;;
+*-post-only*,*)
+	can_fail=0
+	;;
+*)
+	can_fail=1
+	;;
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
index 369d318c95..79b98fae08 100755
--- a/t/t5584-http-429-retry.sh
+++ b/t/t5584-http-429-retry.sh
@@ -377,4 +377,73 @@ test_expect_success 'GIT_HTTP_RETRY_STATUS_CODES and urlmatch http.<url>.retrySt
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
+test_expect_success 'POST /git-receive-pack (git push) is not retried on 429 or 502' '
+	test_config http.maxRetries 3 &&
+	test_config http.retryAfter 1 &&
+	test_config http.retryStatusCodes "429,502" &&
+	test_must_fail git push \
+		"$HTTPD_URL/http_429/push-post-only-429/1/repo.git" \
+		HEAD:refs/heads/push-429 2>err &&
+	test_grep ! -i "waiting.*retry" err &&
+	test_grep "RPC failed; HTTP 429" err &&
+	test_must_fail git push \
+		"$HTTPD_URL/http_429/push-post-only-status-502/1/repo.git" \
+		HEAD:refs/heads/push-502 2>err &&
+	test_grep ! -i "waiting.*retry" err &&
+	test_grep "RPC failed; HTTP 502" err
+'
+
 test_done
-- 
gitgitgadget

