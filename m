Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC02EBDC0
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069096; cv=none; b=SYQk2fARkms++FOq6kRYGdODOlZjpBs4t8rnkeP8FewlE8tYoryGg2robFUF2NyhfTU2BBK+vzY8GeD/4tAwtdJeBYSt0/vK8BD4yv5TATymw3rUphp9kQuWOWvPyvAygqmCav4nUmU2IbMTGcWDRLOpxo1ivR96jOJzh+AZHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069096; c=relaxed/simple;
	bh=9nPcnPKe46L9U1AyLN//9t2YCrsJ29iujBlhZ6cDII4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rhAD3noAB4lH5bowopXvolR5SixJ+8MGlfZQytKVoMHbf0q2ETK/t7kXK7Kz8IJ2Wy8lTrMZATIfgbAN8R/VvRKxoMfhwal+7D5qVTekNPVh90wDzSQ41fiJ/Pusk3eJ2kIvroY/vDVaxvAj3pV2kKdHXpredgiQzwV2Yw6CE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+5oZ5Cy; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+5oZ5Cy"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c6e815310aso507839a34.0
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766069094; x=1766673894; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNHsq21gRl9WQcEk0u3QQS5FhQ/0isud1ofcCMFLeio=;
        b=I+5oZ5CyX7VmekQfujrSm+qrSecxtdVuGqvZVAm2PLggW9qeahJXLUQisA6idGjgFB
         jWLoO1qsenwM1o0M9xSExYidtJRQ3ag9e6+bxY6iTA3t2x0auVwiYpeVsVOldBDXkTmt
         dffsYpUMOo5SbDGfn4uZqcChOLC/Iz3BkpHKVjB8giqypb3ootslHwISxGWfqQymCAVj
         PDkUoBgo6KnW4nT3gn1vKPuYwIz84WkXQUOUnCYq7Fr4mnX2hrF//xJOOdQSQLGBnb00
         gzR0KN6ivzXj7cHbQlyhsWCp3rMILLYGg7owLspPtqlOIbw1mZM48y/bOOMXi2WStbp2
         oazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766069094; x=1766673894;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GNHsq21gRl9WQcEk0u3QQS5FhQ/0isud1ofcCMFLeio=;
        b=ibVljqFy2rVFSXiD+B4Mz8IWhpFeW6va0oPhbpKTeai9OPADJwv0ASM5mDxz46zG//
         LXkvSZg6ne1BO+Qk0YxhwATJOIazyNOd4M8av4nqjVsR5cCFefekt/pPKVOsQ3eIx6yP
         J4RGAxjhKSuBtRreiakqxzXkq6P1lAtslhadrcKuPllEUrZYyw0qqIRuoujMAmZlfKYz
         TkZ4At/kQ9Tjg696HhJ089uFB0RLksEh3ihmkgRL+qNB38RaIdM2VIzFuE0SK7Ly+MNl
         SySu4C3Q86mCgBJrQbOCsnk8j4/D/m5qDVPMh647lZbM2gzriw4mmuDtTcHK02ic10CO
         DyLA==
X-Gm-Message-State: AOJu0YwsE3zbIwHPfOQ8Ph4TaUmvou6Xm73Jn5PsRko5WImGDXm9IIeM
	1p2jVHiAZAwFgxvhUDTxpdeaAx5Zo7H+sUj3GImhw/9DnnYPxMZHLofeWij+x9ao
X-Gm-Gg: AY/fxX7S5dGO61uXlI1IyVSlgl2lwJSLRFIj10RrXMss1XKABjKnM/3/ByOzgyNOZup
	mq6sJ/2Xvt15nwg/fyegNnElsVhZ0U39COBnrHcTyKObVrZQHbJE4sQVxIdbRSaPQPJFAOzdSMV
	t2zlzOOuHrhAyg/8YukgHJOJf8F2Ch8Z+H2GD+U+gROLdn3grQ+wJJ3J5JmsjbrwitQfTMNkii9
	iDSev9wx8WjYZuRZi28sanNLrJXvcpMywP3utat5NbwrUkm8ZcMRMSOYN/ePsn9z/0j5AVHK3Y+
	xQ+X7cjWTNDAROQKuWJwRY2PE0buOUE3vXvVijI5BQDc7sUAw8mSCJHLueX3/9/Eey99rBq9FBG
	oUkDZgbxEjaG5Tck6osV62sT2I8PW4++qdy+QkJILiF+bY5jIzolh0gtyzK1XK+ygCVOaaXB7Oy
	YQjZlTz1mmlj8HruDePQhOqf91
X-Google-Smtp-Source: AGHT+IGPi8EPhWubk4v8/Snixszq4JJeV36Ib/jeR/PJVHiYZxucrZsS/fhAL4p3BadYlKKnxyAiww==
X-Received: by 2002:a9d:51c5:0:b0:7c7:da3:ed27 with SMTP id 46e09a7af769-7cae83a511fmr7399702a34.35.1766069093707;
        Thu, 18 Dec 2025 06:44:53 -0800 (PST)
Received: from [127.0.0.1] ([52.176.125.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc59b791a7sm1704225a34.15.2025.12.18.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 06:44:53 -0800 (PST)
Message-Id: <ad4495fc94a4bcdcf7f299ffd8514afce88f2d6c.1766069088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
	<pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 14:44:48 +0000
Subject: [PATCH v2 2/2] http: add trace2 logging for retry operations
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Add trace2 instrumentation to HTTP 429 retry operations to enable
monitoring and debugging of rate limit scenarios in production
environments.

The trace2 logging captures:

  * Retry attempt numbers (http/429-retry-attempt) to track retry
    progression and identify how many attempts were needed

  * Retry-After header values (http/429-retry-after) from server
    responses to understand server-requested delays

  * Actual sleep durations (http/retry-sleep-seconds) within trace2
    regions (http/retry-sleep) to measure time spent waiting

  * Error conditions (http/429-error) such as "retries-exhausted",
    "exceeds-max-retry-time", "no-retry-after-config", and
    "config-exceeds-max-retry-time" for diagnosing failures

  * Retry source (http/429-retry-source) indicating whether delay
    came from server header or config default

This instrumentation provides complete visibility into retry behavior,
enabling operators to monitor rate limiting patterns, diagnose retry
failures, and optimize retry configuration based on real-world data.

Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 http.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 60e0364f57..ded791af87 100644
--- a/http.c
+++ b/http.c
@@ -23,6 +23,7 @@
 #include "odb.h"
 #include "tempfile.h"
 #include "date.h"
+#include "trace2.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
@@ -1738,6 +1739,8 @@ void run_active_slot(struct active_request_slot *slot)
 
 	if (waiting_for_delay) {
 		warning(_("rate limited, waiting %ld seconds before retry"), slot->retry_delay_seconds);
+	trace2_data_intmax("http", the_repository, "http/retry-sleep-seconds",
+		slot->retry_delay_seconds);
 		start_time = slot->retry_delay_start;
 	}
 
@@ -1753,6 +1756,7 @@ void run_active_slot(struct active_request_slot *slot)
 			}
 
 			if (elapsed_time.tv_sec >= slot->retry_delay_seconds) {
+				trace2_region_leave("http", "retry-sleep", the_repository);
 				slot->retry_delay_seconds = -1;
 				waiting_for_delay = 0;
 
@@ -1995,6 +1999,8 @@ static int handle_curl_result(struct slot_results *results)
 			return HTTP_REAUTH;
 		}
 	} else if (results->http_code == 429) {
+		trace2_data_intmax("http", the_repository, "http/429-retry-after",
+			results->retry_after);
 		return HTTP_RATE_LIMITED;
 	} else {
 		if (results->http_connectcode == 407)
@@ -2421,10 +2427,16 @@ static void sleep_for_retry(struct active_request_slot *slot, long retry_after)
 static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_after)
 {
 	int retry_attempt = http_max_retries - *rate_limit_retries + 1;
+
+	trace2_data_intmax("http", the_repository, "http/429-retry-attempt",
+		retry_attempt);
+
 	if (*rate_limit_retries <= 0) {
 		/* Retries are disabled or exhausted */
 		if (http_max_retries > 0) {
 			error(_("too many rate limit retries, giving up"));
+			trace2_data_string("http", the_repository,
+				"http/429-error", "retries-exhausted");
 		}
 		return -1;
 	}
@@ -2439,6 +2451,10 @@ static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_aft
 			error(_("rate limited (HTTP 429) requested %ld second delay, "
 				"exceeds http.maxRetryTime of %ld seconds"),
 			      slot_retry_after, http_max_retry_time);
+			trace2_data_string("http", the_repository,
+				  "http/429-error", "exceeds-max-retry-time");
+			trace2_data_intmax("http", the_repository,
+				  "http/429-requested-delay", slot_retry_after);
 			return -1;
 		}
 		return slot_retry_after;
@@ -2448,6 +2464,8 @@ static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_aft
 			/* Not configured - exit with error */
 			error(_("rate limited (HTTP 429) and no Retry-After header provided. "
 				"Configure http.retryAfter or set GIT_HTTP_RETRY_AFTER."));
+			trace2_data_string("http", the_repository,
+				"http/429-error", "no-retry-after-config");
 			return -1;
 		}
 		/* Check if configured default exceeds maximum allowed */
@@ -2455,9 +2473,12 @@ static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_aft
 			error(_("configured http.retryAfter (%ld seconds) exceeds "
 				"http.maxRetryTime (%ld seconds)"),
 			      http_retry_after, http_max_retry_time);
+			trace2_data_string("http", the_repository,
+					"http/429-error", "config-exceeds-max-retry-time");
 			return -1;
 		}
-
+		trace2_data_string("http", the_repository,
+			"http/429-retry-source", "config-default");
 		return http_retry_after;
 	}
 }
-- 
gitgitgadget
