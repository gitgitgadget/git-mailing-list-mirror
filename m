Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103893;
	b=3TPf0QYjrrXf1j0cFTFjlGxdzOz00rFqoXPO5YVX4IIDhB9x28CTtcvcwnMqoYGxn/4E
	 /LuB3cfa94fZCWKsTmG2aKvmTpsRmJtvMUkYnQAsdsnt0aH88szeUWcw4VwuIncOQkNmT
	 UVVqqKHlE5xxf50gVORTz/ISJeMFBZFMww5qYZ43baL/Uxm2THJNeFhyFBxKpJ/oBMD5l
	 Gl0be7v94IkZi1RVDJOhhiTmbTrvHXcGqLCQbuuZLQZGRInhq5fZzKhjcK1amcOf45XPP
	 LUuUzYKerD9AfIILmHXRJHeDfTaD5P6zizC3w46jTjGOyhfS53tQ30+HVsgk04VpvdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=kafncMdxe9zlXlGCHgLoUUFlPoAtWZbnrDuK9xf8fhQ=;
	b=ybXbdyrQTF9LA6JxMUkhq8/IshgETBDsSh0F96E/dFVii3U5pCTR/lXAEIJH3/p1DfTn
	 2ZcNDEz1qWJTJtcoh+jRWIdMnFpw33D1pVE58Ndo9cAIJj+Xn43t6dHc3QWiGMBASv8ej
	 Lgzdw9/U6244E6mcvY5rFRCHfkpoKybT6FDTc9c/gzGCEEz7Eqy+CAozOkxdYeCblmkwI
	 txeWMltsKXqWLghpiacEzczByIg4NiCcl4xLJ2l14eUFIKJmYmffgduYjf94NBktnLEu7
	 jec0RpPoFLU42qeN0eG6smBg53JcIpVjxDAibItSsd4jBwXjWVapd0P2008/Nk18pKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vLpNC16v;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A0606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 468A0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vLpNC16v
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdab938dc83so1270313a12.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795103891; x=1795708691; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kafncMdxe9zlXlGCHgLoUUFlPoAtWZbnrDuK9xf8fhQ=;
        b=vLpNC16v5UVEqOMY6LIvX84GkRwyBX3pgyrSraAaTa8nAS61Fb5jQhR3QHBau3tR+l
         lvNGXpHSrkJHTzi5wpmu3M2htlJRssJ/r21XlvfoCOXVzd+QAnmK6ZxEyMRqeP4UsUsp
         9blv7n5scFAar8VPy0+5hstcmB6dfR4mLirV3aybT6H9CnRZn1sNwU69H9KoAPgzNVpG
         gs0UXSAQ5hMH3SVV/6mNc7MkdWOGLK6IBZ0pIM6OWa8ESxEw5Ko6POgp4Sb02e5YjDUL
         3gE2VnpQgOdDDyILMdSAL6uO9wwqYz47Dci8fAkU0nM3EiKK14d9i0wEjVJcX5NFWkFo
         8dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103891; x=1795708691;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kafncMdxe9zlXlGCHgLoUUFlPoAtWZbnrDuK9xf8fhQ=;
        b=IY7/sFJPzYFgvL2jDrddunHssGa6TLq28AoLFPygf/3pzcNFmk5f8Y4ERGUphC+rCs
         CZ+GuLpjTkqOJRQZWAt6WzsJe2H1E7o/SzON3XXUB/XREh1I9ulPlrN7B/wwgwKr19ly
         2Uspw4X7Hz8MlQx/ahYkMS6t7lyWTBlfHfG9iWcoOMQru/gANyzcATWNdpUd6CKqm/R4
         az+NPdjB9WfqatgM1jWUQm6ISkORvFUekWFDPEW79H0uCThVIg1fereCKBFOS6H0cH9/
         zPM5q09hEXuYy8rJgXRl+qCfNNkbMzD4ARsIMtNS71xuf00XikPrMVBu3UNMd3dCjxxh
         e40Q==
X-Gm-Message-State: APuU4Z8i2/xYKHbRJX2Hi3EiA8h1L9U2zbgpC2PQ7hxVAq7pHlclns4r
	ULcJK+FLhNg2s6FVWSq0cw/CJQJUps5zXtBRvWVX9tAs7OKUgJIPpj7wUnmoligo
X-Gm-Gg: AZFdTZd6UBZlDfZd1b4t1+T19MfWX9SxZlEYyvp5TFFeZT5mgiDFgcNVwGL7nPd1+In
	HJQpX59x34hGydWieVW9EyMiS2/vruDiZQ9P8DM4qvHeQotBm52ighvdxLdGfRjK4LNtxZ8J/Zb
	aJok8Szg6RcAqd6n4M/VITqBFmBDjlGGxlP65sD1d+H7sxGdlsYZqZgnCNmqPB2E0AdrZHwuM86
	KDr8p8hV/ZMOLesKzDWe0/Lc0hYkQ5hA9cDX7lVzY7DXKYIZmApCuzQXP06GLkFBwM+/+Mv+LJP
	UcYvo+rsudANxMz35v/hsYfHBmT/WrYwrxSBb8a4uHhWXh3+T6PKwemaV0+qjTiGBY0bNVRDWRm
	DJDLlVq7IO4nAxXAwDBNdndrvCppQ11vFz3ogGo7WS/6+daJWScbfZ1aHl7HockzEHZvh8VZ52D
	wLtQy7FrxXaikXMRT3BCmcUrIjUwe8zt+wRj6UCm3Z8hPrPKiNS4i9+bD2hgpTZm4/a30C8Hn1i
	FfemR3aungukEmuZqgVi04yJAOLXY3RMEJJJ63FBwUw8xs+H+tQeLoXBVWGajtq9/e+369lvBdt
	ycOOrQk8dPcR9E+9COe+/tlHCh4v/b0XkX008Kai30tQJM/yNByTpy4z
X-Received: by 2002:a17:90b:3889:b0:3b3:b92a:aff9 with SMTP id 98e67ed59e1d1-3b3d07e0c4amr6518813a91.56.1795103890479;
        Thu, 19 Nov 2026 07:58:10 -0800 (PST)
Received: from [127.0.0.1] ([172.171.119.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8e93asm25519a91.11.2026.11.19.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:58:09 -0800 (PST)
Message-Id: <ca247f390c8ecd2df20f7054f3357bf8da86bee2.1795103883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Nov 2026 15:58:02 +0000
Subject: [PATCH v4 4/5] remote-curl: retry transient HTTP errors in post_rpc()
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
when retrying a compressed request.

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/config/http.adoc |  4 +-
 http.c                         | 67 ++++++++++++++-------------
 http.h                         |  6 +++
 remote-curl.c                  | 82 ++++++++++++++++++----------------
 t/lib-httpd/http-429.sh        | 50 +++++++++++++++------
 t/t5584-http-429-retry.sh      | 69 ++++++++++++++++++++++++++++
 6 files changed, 194 insertions(+), 84 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 726669e85c..72e9bf011d 100644
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
index 2c35dd5240..b92f33609d 100644
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
@@ -899,13 +886,19 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
 
-	err = run_slot(slot, results);
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
@@ -913,12 +906,15 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
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
@@ -941,15 +937,18 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
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
@@ -998,10 +997,11 @@ retry:
 
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
 
@@ -1066,14 +1066,20 @@ retry:
 
 
 	rpc->any_written = 0;
-	err = run_slot(slot, NULL);
-	if (err == HTTP_REAUTH && !large_request) {
-		http_reauth_prepare(0);
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
index f3e7dbaaa4..afdea04b4e 100755
--- a/t/t5584-http-429-retry.sh
+++ b/t/t5584-http-429-retry.sh
@@ -365,4 +365,73 @@ test_expect_success 'GIT_HTTP_RETRY_STATUS_CODES and urlmatch http.<url>.retrySt
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

