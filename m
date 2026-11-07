Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022844;
	b=p2K/aH69yr0M9eKfrGmpJc+0t7qhsdI4IStH5UChPmyVTQKsfDxjkVf3FDOeXFxQ9L1W
	 9fAKdBmLHTRXrnWwXbf3Wt9d6pFBlXVTNvOW2rmj2AVDjqivaLy+ZG7KP3kS3Z5WPthWs
	 az71N7jtXiNGDvW5GiVpcWPd1RviQBGRjKwDkNNZqoLH6arUylGBP6w5dLbN0wOGesBWi
	 wZxLWXeP4pqcruA8PY7tWypbjOSlrNckcTwLs0lCr8CCuBR6InvlPZc+FTe7FXs74J6G7
	 8AznqxKwNViuTE25pYt9ZOT7FqJFDael/rF5DRPauNcV/HZNyGWAv0WDyvHWcyqonDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=BSeOsN3Tf1nG6771Gr3OV3CeCAbQSJA+Ev52MqcP9zw=;
	b=wbl2RhP2+X6Ru8ggiURXZtJJLqInVUtt6+9ZQwfcKtWADj0tGsDLZ3d1nIcqg3BrdsEP
	 ztgmAZMOJh+BjoOrtFcapvSpHwC8JaTq+kdx76RouRujAOh+VBqK8+i+xutLZRqJmiOuN
	 /nAnqFpxKZh4FJ55JrZBYLxAphs2zMVtjuMy1Hrlxz3NCJbj3zrEL6TQ700h+OYwPn9ia
	 iQVAo6DGOldzxI585a/QrBOpBSo3gStGL1mA3gYLslPNG5uhGVkEQmo2H5vMwT/xHwdBr
	 I2o5pBl52YbRAvvNMMaCyEQFUJGcliu0E8rcz5SpCFTZhhLqqc72kAHFZ69go8BoOHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKr8+Zqd;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385EA606A336
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 03:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 385EA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKr8+Zqd
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e63ee7b4cso138680285a.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 19:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022843; x=1794627643; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BSeOsN3Tf1nG6771Gr3OV3CeCAbQSJA+Ev52MqcP9zw=;
        b=FKr8+Zqd41Msm5s9lrIU0FG10LCu+WFUDCXENi332BW2HiRK+7LmBrLCa429ct7bzh
         JcQJ8SeV3upfFGl/33NX96voTnRsbj3dm7e0e/8XUajLCP7Fr3Bw22akH8wude92ePFM
         0AEfD8oXYHwTVBGvcAuRr2Kq/sgLLJH09HjPDlPHyk+rnxSayLrb/a/L3eryUdgKBzTz
         mBDerBDcPYwKAnAQ4fR/8K7q8g3Keo4nC67e6vEbMMQxjen4K9gsUvuhYIrKhHWs3TcW
         nnnb52i+BkdEHDYM0bMRQiP3o8VDts/Ofq8fbfoPMhgRqqcdGLw9LAcG1UCpT0zl0lVQ
         TfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022843; x=1794627643;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSeOsN3Tf1nG6771Gr3OV3CeCAbQSJA+Ev52MqcP9zw=;
        b=dln0fnhs8SBU2/emrg/104vt8s2JEj6lD1dB8lOSZfd+sKBumIM+DdGFEX3Kbubl9O
         6ektfMjjSeon4ngI1siJFLk1NDf6cwtlSbSRZYC8Dfaz4iBji1D3DuzSzJGD1Y6PvacV
         xEZjaMiz+I/nco4/VUOYGuzVJnhzKStne6tQ0Qj9V9+lj/XdWFJUqO0z8SiB74Hh89BT
         W0797bw4DEXVYSXlH8ND6MEsJReWzakftGGSZ4WBqjffRhvYeKEb4eICtsumyCj4u/4h
         l7UBhJXUaPXfm6o3zFEdp9uRbD6wgkrg49fsyiTy4ZhoJ5jHeteQ0KkAW3UP0Zinqxal
         vxwg==
X-Gm-Message-State: APuU4Z/3P4FkCRKSeZoopyo2kzZL3aeZhqUyIRBwEHm7fgQaEMFqE0/W
	1WWauz7KXYnDQRoBJhTrJ7d/c5OXYzuFQwlcWG9nQQ5w2tPayj7YTkiZxDCOzeKF
X-Gm-Gg: AYBFou3m5A87C/mdACofflnWxwkdrNTqCg+7gsHYsaQ3qBnLKISEOyDXHhYJw5X/jJA
	PCfMER8NcXEz4plJnkX3hepH4pLf/28KeYmMlipygSSdKvGHPebb654x49cpkg/Xo/kWlmJNvS9
	+8yLtDj9/CMnZs+Z8BKNM+CRV2UxclUJizahKZKTiH2gCfk6Mj2sjBqspizhEM2QiRD5oZULZYD
	WGe/LoIjWhh8Ep4PGeyx5AwOj9s1CPQeW7TGYGY+ZKKi02PExcLgLuTBGed+6UND1bYX9WGkGiN
	6rz1MSajcn95U5CiMdx/cRTzNxzUoPBfaViwAwhdRUwzLT+1H9MgORyyNIVDe/spwoexoI3vrf3
	44cZSWNYKT5YGMcHZJhAaSkobbkutkKg4CWhDdHEfQQ6ln2RTXxkQ5ZlQcWsZYX4KDvL5uXiV+W
	Wdl1Ti8REkZjetEjuOklu3xoOGQ78aJZhVhKpXLE6jmooBh0Y3C0bUBiHvaK8p56LcKPGUkqKmF
	LaA0jztnbqAqWZNAHy0RJ2bOgpJjhFWzqN4bo8KbrVXijsPoIbm3WW4OkO/fBCZ7OabhQRssVuG
	Mms1LSKIVH9qpzi5mloFyQdde5BpFwM=
X-Received: by 2002:a05:620a:3726:b0:93e:cd74:33b with SMTP id af79cd13be357-945f34ec8admr787375985a.27.1794022842849;
        Fri, 06 Nov 2026 19:40:42 -0800 (PST)
Received: from [127.0.0.1] ([20.65.86.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5bc20absm286248785a.21.2026.11.06.19.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:42 -0800 (PST)
Message-Id: <786964ff00368648e5bd0fd4c5889f7c105d0a51.1794022836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 03:40:35 +0000
Subject: [PATCH v3 4/5] remote-curl: retry transient HTTP errors in post_rpc()
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

