Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06561B4223
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890948; cv=none; b=RlFAD7cInbEgpvLKnW1NA7kVX6RKKq55eFj0AGLrFt5K/hA+ZlN88gs+JHLVGHiwT/JYc2V9ge5UgWIoq7dwBc0RYPrDRyIjqmzoN8UQ8Ew+xqCyPloMZ9ZIJL6balThz/Q9nCU7c3pdNUvCPcJkZj6qTfhsALDYqbdaCkwe4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890948; c=relaxed/simple;
	bh=qToJABUNgmEPVNIvmFuvYBbwTuYVoadsgWJxEu3ej2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JffhodefxNe90Pm7iegKKwYVjan6X2P+bHqQlQPs/lAw7VPnGnhTzHVg3Mnb7fuiwv7oL+HpRi0Uiy+VKrwhPQMvleqMLI38DEzayYt6M7UFG1/0Qr3pGAufF27BM/rtugmNZG4XxLv6FTP7UFsi6+mzas+jWTHmKHhBIGWMThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+eXWlG2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+eXWlG2"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43621bf67ceso3942838f8f.2
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890945; x=1771495745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h13z6z1EagKThwRLE2HdIgFELMzGTLUpVedXapjvlRs=;
        b=R+eXWlG234Z1OgXqQwatxVl2kvPA8JUJmDZXiKBvvoRiafLIqtaXDhUPkOsy3hxbDQ
         wYNlTqofENk0uCW6HXt63Y3GL2+e0eWPmVrmpXSW76JGimJ30A56L2blrDg0Kerz4L6F
         CyLgZhTyy0K7g7vqIHV0N01IcmIHp3hkhl6OQMa5lnMsLU3Kgv86BLWGICbwQTS8jFrJ
         NBIauT8UfNyzidfUsp3V+QTUq/PzhsxsWRVBji+md1ecOsVVVpOCeROd19+ZWto4jN5w
         WqvD1KX2gYBGB0ZzwhFgRM7LWVDgpiLu6CLNxcHmOouSvNjKG4fHLEhM8qmxiofmXKYe
         OcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890945; x=1771495745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h13z6z1EagKThwRLE2HdIgFELMzGTLUpVedXapjvlRs=;
        b=lwUoQmRnzJg6PYgC5KdPF8W3Hel2V5YVH9iqIsJC5LbyuqGtjsCJaWyyOV8F929pGm
         KSWS5+mh5ohE4ymkFF1sVttW0GFDSCKYfiwWlYlm9vjUQu1E+bq2gZV9UihaQ/rLA02w
         c0Q1zoVkI7GlMnL/vEwkTjQa4TR+snEqWiFaeqZcKC/NqWVHzHi3PjTnlZSfj3bUo0Q+
         lSg6EePLj2yeBBjP0VGME1m+i+lWZ0PE/Xxfii//Ug7jy4vLfymML7Nge+UltyQ+EPa1
         5BhldG/AIf20pyRIOIB4Ss8ovK+MTgIYJix95ZppRSLpNr+wUjHMTGPP9O0/6aAUU23F
         vzLQ==
X-Gm-Message-State: AOJu0YzaGKQbTBH5O3oKP3hBLtnIJKM6FxHyI3iu3r4IUxn7Xd5q/tUj
	7guBQ/+5uyUpko2sFMPta354aRhEJTC5HGf4OahcEXfU/a4He75aoVBrMuTftQ==
X-Gm-Gg: AZuq6aIoYB3T2/3/RmjyFQ5QVhI0H2qVA6ZVZui0KPqJaGbwNBorjGCKaRy8fOk8KUZ
	hv/AKFx1qJyCDiwm8Zs5GgUYkwjuZy8ZCbDSGuoah394/ficICqPolHWdR6qZmtpn0QqxFXlocQ
	06CTGDqtbA5NhGhWMW1BsGSj9N8VsLUAQeAtL/Bctu9OO+/RnJVsahkvnR3z26tB+UipRHCmTzx
	Dhx5JmrOXX4XYlXh6jmmaZZH9Tu/A+b8EKp7eman4ur0R9yWP3yYzLXuvJ76gV0f7n9kTYCxML1
	alBBS0YOXpsRjlKWyYPw2qHst5xuqHZJripqlhM9KwmDqwSRn8e5R+gvDOWgXKQCWVYQ7Tpiw5I
	H9AByW89Q+Fzx2mkIy/FX/wynHXfJbhW1BJhJleezWV2J4n/akqjxakiEcH1Timx4L8TK45518L
	GNGutDsbJvxJAToQEzttO8tKiL7OCOL91yb2Iw+d5ae5wU029u2zaV4YtHPft7CJiRMJWXvEZuG
	Kd2PAE/VJGpRQ3Rz1JBjuLXa1T2Ym56buNb4Qc=
X-Received: by 2002:a5d:5f82:0:b0:437:70a1:7305 with SMTP id ffacd0b85a97d-4378acd7385mr3938923f8f.62.1770890944473;
        Thu, 12 Feb 2026 02:09:04 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d3464csm12701151f8f.5.2026.02.12.02.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:09:03 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/9] promisor-remote: refactor initialising field lists
Date: Thu, 12 Feb 2026 11:08:32 +0100
Message-ID: <20260212100843.883623-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.70.g3d1fd9d397.dirty
In-Reply-To: <20260212100843.883623-1-christian.couder@gmail.com>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "promisor-remote.c", the fields_sent() and fields_checked()
functions serve similar purposes and contain a small amount of
duplicated code.

As we are going to add a similar function in a following commit,
let's refactor this common code into a new initialize_fields_list()
function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 77ebf537e2..5d8151cedb 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -375,18 +375,24 @@ static char *fields_from_config(struct string_list *fields_list, const char *con
 	return fields;
 }
 
+static struct string_list *initialize_fields_list(struct string_list *fields_list, int *initialized,
+						  const char *config_key)
+{
+	if (!*initialized) {
+		fields_list->cmp = strcasecmp;
+		fields_from_config(fields_list, config_key);
+		*initialized = 1;
+	}
+
+	return fields_list;
+}
+
 static struct string_list *fields_sent(void)
 {
 	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
 	static int initialized;
 
-	if (!initialized) {
-		fields_list.cmp = strcasecmp;
-		fields_from_config(&fields_list, "promisor.sendFields");
-		initialized = 1;
-	}
-
-	return &fields_list;
+	return initialize_fields_list(&fields_list, &initialized, "promisor.sendFields");
 }
 
 static struct string_list *fields_checked(void)
@@ -394,13 +400,7 @@ static struct string_list *fields_checked(void)
 	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
 	static int initialized;
 
-	if (!initialized) {
-		fields_list.cmp = strcasecmp;
-		fields_from_config(&fields_list, "promisor.checkFields");
-		initialized = 1;
-	}
-
-	return &fields_list;
+	return initialize_fields_list(&fields_list, &initialized, "promisor.checkFields");
 }
 
 /*
-- 
2.53.0.70.g3d1fd9d397.dirty

