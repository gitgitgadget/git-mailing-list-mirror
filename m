Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022842;
	b=E2k1W/mw/WlD9ves2WV/7siCCnih7wGc1B9lExbzpZ6Di6SheIDNXDbXPdfFLmr6Y+vh
	 YdNW3pvOBB3Ojb3VTh2oAvpfxGLAqX3dcc/uHFKKtaxn6IA/zeTxOJDM1+Typ6DEWC0qg
	 crVFHudX9/iUOSExpH/RrPYZKOZOZF7mMZ/qwGpT7A3GVd1EgSbh2lNSWDCnqPZ4QHxQ6
	 TUOKlkECaWdHByfsRTQMLRarNmJ26HQgdn9lYvSNihitjwo7L96/4xF43xpAadkOJlIjW
	 TRo0NV38kvFYl6s3JCcoPpxgJONmbCfsz8wgiE148ijQnPyn0807JUGlsfKMb6kmlnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=D79BsmuWyEYFlsTcLvFTQOAejDaZIM5fe1HP/TpcOxw=;
	b=cPo8TiPg2FJR/YPVpYia8+b/7m2feSNz0BfLbGf84tX92wVLdpQ+rKuU2zHaA6b9+BE/
	 5aZs67GlaPw/4pJyBC5PLyoK//r5J9CxfmMM+k1acTj4VSWP9crMTY26zuX5feZ0cl39b
	 f4mcyul88ZfzaO8yyda19wtF2xq56YZVoVAs+dUUwsTS4JbIOGtGndiqNs9yONAfCobRD
	 0d7kxdVEYDeaJYfFh/4wsRv3gMsK6sjoBq6V9TXeaG7xjqIos7RkvHnncGVqjp8RpMLYL
	 /Ax66W20PTRIn7nWoyYSyLRRXWepGLo6LmSTbp+R9ugptlgPBGhBU8cZrfkopeSxb2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZH84eM6Q;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DA606A32F
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 03:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 246DA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZH84eM6Q
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e4c00d71aso130794585a.3
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 19:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022841; x=1794627641; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D79BsmuWyEYFlsTcLvFTQOAejDaZIM5fe1HP/TpcOxw=;
        b=ZH84eM6QmbuJMiwUL07gWk2MgYhvmnr8WD5SkRCSpU/cpw5cSMgjMJG2BAXePPGHD9
         zOCXtqU4HusZktOKEwg4piv7qAUyWE7fsP79GhW4nAyUsONxhxOnU/thAflX6iDDzlIu
         /oNO2HdGQcs5K3/AGv9VE7qNnQ1IHsjLWqRir7ERJlvy9v4D7VvIE6NfhPg6EBQ5DNOJ
         VZ8hIz5IiwEKj7kjFnJxSQDSt4uPFkgfzhUwHEIWhLxIHvAgA24dfbqhn9p9xs48SX4J
         lrTIdzKqRxJbGi9zSqu9P2FBShnR8+yERlQa7oysDEPjACZknFZqDJnChBuzbVAlpTuU
         ylMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022841; x=1794627641;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D79BsmuWyEYFlsTcLvFTQOAejDaZIM5fe1HP/TpcOxw=;
        b=lB672GSRdboxW7ZxK6g4EtwNasSnNeK5d/PrFZi9+Ecr9C9eiyYM1I4YOHPKP8Es3V
         ssP0SPN3sRr0ZN2mkVUeoiaE1SVKXT9nd7uPa8Q0mnvX1KMNYtQSGe4jdo1IIXoHEy7w
         N0i3Tnz/xRudthlpxv2YcMPTdgNBUN/JlWGYvt3T8lKoXQhMtKsWb0H7ZySVTN2bqVg5
         AXUYp3SNavrAucvNnyBmAV2fVCQyfk8n+TaseQBON0qg5JS8Dv/V80fchAK/p2OX+hJR
         ANqkxYxmZwsU8X7v5/HQXc4NlntUgVZ2OIj1VuouNugCTXEeMonDpcPkYdgfqDuHYGAO
         Ggug==
X-Gm-Message-State: APuU4Z/+0GXsyscg4WjtAyuy+ml6nN3Rzx53f/j2H0Xy7R3iZheiMGcg
	rfVYzIZ0H3r/WJ28HbaVdSbIawgTnj/Qxlf01Ab2L1SbFe1jPre0r4Mr0t87AdYA
X-Gm-Gg: AYBFou2qn4phVZ2ISB0Xicw5HaQiljqt+CmaHItgLaFXK5NquAvFJZsWmib/2nGasSt
	ZLhAI/28i0rFqe78lPLkJOizahclLeF7k6zW7qBE628aHwGUX6Drjq40IziW9sMzh/fOVck48tj
	XJ3/oArym5cmV7wGV6TQNW5vMGqx/kC3F/XULidAJmVmuoM+A9MzcPvNxYtcy6r8DtZYpIjglm8
	DocHgCFKXDZCe7SlNiclSo5OIWx1aJFbL6cLPr1z3884z5XNSxYONQOEU3Tf/4h1EA74Rddk1w0
	OQxf+k5Wdzocn+TYuKOMAnatHh6A/Ct/5U1+0S+/FqzaQE+u0WIeBz+gVM9wDqySC2D/Xwl1imm
	5e4IadyUGgdodBCjm3wd5dFtsI2IzvzlDm4xe9dX1eg20yRnAcx6Fi8esbZ5ekLkoNnx53tkCHt
	40JmDttDkfmX2HmkGU0QsJ8mTqtyRd+JnDDJy6x0MLnqvJf04P1sbBx5bNBk9siKSKlvNP9rCH7
	M1JuEFkmrL0Hu/2ROJhVtxM0JJyprhFBR/kuLHiS2rvpIbi/VB+a5dK0jMgcxT7WHPg1stHTrcS
	Hnye4Exuv6Pl5GJZNEtCBkR0rqHxYnc=
X-Received: by 2002:a05:620a:4804:b0:93f:12d4:6760 with SMTP id af79cd13be357-945f360af88mr709960585a.68.1794022841005;
        Fri, 06 Nov 2026 19:40:41 -0800 (PST)
Received: from [127.0.0.1] ([20.65.86.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5bac07csm288630585a.17.2026.11.06.19.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:40 -0800 (PST)
Message-Id: <fe1e847dede7579da911b5a9ba16c806b5332723.1794022836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 03:40:33 +0000
Subject: [PATCH v3 2/5] http: add exponential backoff without Retry-After
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
--retry behavior (while keeping http.retryAfter's existing default of 0
for immediate retries when unconfigured). When the server provides an
explicit Retry-After header, continue to honor the server-provided delay
(or fail fast if it exceeds http.maxRetryTime).

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 Documentation/config/http.adoc | 20 ++++++++++++++------
 http.c                         | 17 ++++++++++++++---
 t/t5584-http-429-retry.sh      | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..8e7538ab76 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -327,9 +327,14 @@ http.keepAliveCount::
 	`GIT_HTTP_KEEPALIVE_COUNT` environment variable.
 
 http.retryAfter::
-	Default wait time in seconds before retrying when a server returns
+	Initial wait time in seconds before retrying when a server returns
 	HTTP 429 (Too Many Requests) without a Retry-After header.
-	Defaults to 0 (retry immediately). When a Retry-After header is
+	Defaults to 0, which retries immediately without waiting on every
+	attempt (unless a Retry-After header is present). When set to a
+	positive value and no Retry-After header is present, the first
+	retry waits `http.retryAfter` seconds and the delay doubles on
+	each subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
+	capped at `http.maxRetryTime`. When a Retry-After header is
 	present, its value takes precedence over this setting; however,
 	automatic use of the server-provided `Retry-After` header requires
 	libcurl 7.66.0 or later. On older versions, configure this setting
@@ -345,10 +350,13 @@ http.maxRetries::
 
 http.maxRetryTime::
 	Maximum time in seconds to wait for a single retry attempt when
-	handling HTTP 429 (Too Many Requests) responses. If the server
-	requests a delay (via Retry-After header) or if `http.retryAfter`
-	is configured with a value that exceeds this maximum, Git will fail
-	immediately rather than waiting. Default is 300 seconds (5 minutes).
+	handling HTTP 429 (Too Many Requests) responses.
+	If the server requests a delay (via Retry-After header) or if the
+	configured `http.retryAfter` value itself exceeds this maximum,
+	Git will fail immediately rather than waiting. Exponentially
+	backed-off delays computed from `http.retryAfter`, however, are
+	capped at this maximum rather than causing an immediate failure.
+	Default is 300 seconds (5 minutes).
 	Can be overridden by the `GIT_HTTP_MAX_RETRY_TIME` environment
 	variable. See also `http.retryAfter` and `http.maxRetries`.
 
diff --git a/http.c b/http.c
index 0308f973a6..8a28cd0fb3 100644
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
 
@@ -2498,7 +2507,9 @@ static int http_request_recoverable(const char *url,
 			BUG("Unknown http_request target");
 		}
 		if (ret == HTTP_RATE_LIMITED) {
-			retry_delay = handle_rate_limit_retry(options->retry_after);
+			retry_delay = handle_rate_limit_retry(
+				options->retry_after,
+				http_max_retries - rate_limit_retries);
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

