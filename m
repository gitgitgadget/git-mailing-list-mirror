Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EDB3B0ACD
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632960; cv=none; b=NOjOBDHe8BMMluYLAj/pwVdTTJ9pY3h3O0BdBlZo41g7l1jkg5Nw2yaIwx613hagRAIHOU3D1yk8NPKgC7sjkg0l8htghwLR4nVY84Um/fBtJpe9bk5t8fGkna/Kh1BbzHhfCgzWZBpkZUwj9DMp2Kbv5G7cMo/hbVkyebqwrEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632960; c=relaxed/simple;
	bh=konrPPYOT4brJInfRsJr75zeZ7egIbcXdTQ9pqVj90c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f/3lnozmsDYnmmclMFgm8Nan4Wpa5Cetk/Z8qFQ245zQMPZ9yaFk6N7TPv4/e4aw62q5IQCQq05c76xi89bZwQYp7k2A9lT7jBz8dImrpg2TF/RcFjBMuodD/9MP94GOWQvxPES4d9sb0zEyj9i6eOLsN37JzcfrrssltOavs0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaH/3ZUL; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaH/3ZUL"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb9b427da2so644583a34.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632957; x=1787237757; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D/gQTFCkTLGi5bHlHRcI005NqLz1LHcSzKymkzQTM8Q=;
        b=EaH/3ZULM2ZN50vmdhUOPQ0Wi3Tlylo0DUuD+L+ZLTCLhwIyEW4hkL5jaLJWxItIit
         uR/ZrLFR22T9jO0XGSnxK3PQCfa4qwObpoG17u/A0fGxyZF+cEy2sK/13IxqDou7JcVK
         tS2K/+XnserpMcN/GovOEQGwsmrtQumLn+B50ANt+hLPpUXoQ3UY/G7EhMo/ZGeJPfCA
         9jPZBTZcdMpKevoMm5fLERicNlgfTmuSLf6UytWJJyWPbP0gsqH5ihZ4rKRxPavNpXs2
         kd36AB7KW+/8EQZ3ZYDHQZOMVL63sgEP6XshNlc7/oWLr6Knume1Sn1SXNkc2WsLCVTe
         9/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632957; x=1787237757;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/gQTFCkTLGi5bHlHRcI005NqLz1LHcSzKymkzQTM8Q=;
        b=qpi3yt9tB9ZG2Z0nBmsP2hOTzWY9oXHJLVm1sQhsf5mWBns1/n/U/rKM1lY4uGv0Vz
         pJdqfHKWjR+h/jqWEjyY84RPITRTBkTo1lG5N27YkDSJTeRxHnF2Etcyh5A4sGVJhEoT
         vm1owIkossMODyMW2eWAblWhNAXcOxfBMTGXfD6dFB80VxYVfj/Ygi5aq2Mz0KNqegZQ
         QDdqtEmQO6v3vr1udsjo+rAjuw0aEFOG7bOc7oBYs4Vq3IWuree0vRSRJWp0OODN9ZlZ
         GqZMDjKbaB/raYhEIgVjQolRwGTLFDpOm+LpL2PKNS65N7N/7y+AsfaUcIgINNpm7XcP
         hTsQ==
X-Gm-Message-State: AOJu0Yx3VB++IJ60JhFz7pJavmROUnfLVjeGSmhlG0W6cdC5oCYvPb43
	wPAmeCZNfcJRzaQQVFLdWmW4IDnquPAzffvCRW+9LV2OmNVUdjQH8c3POWMcUw==
X-Gm-Gg: AR+sD137xCrwfLnbADe+31vNbV+B9PKI6cy34O5fX7eMo4qr3diHKp0o3LKfeH9DJm9
	3Kx3ZxhcLAqCgLpA/iMvS623uHK4SOx2b3D+GHxHVnjcEL3SqEN0wvyaQt0cvtvPOr3a4MsyIzQ
	2jwj6OJTXO/vbdhBm4EnsSgDSkutTsQ+ALbUXLpL+UIygudmMPnxgYR6aL0pQNqc6xjkVEPBRRC
	g6f577S4d33BkVP1bS4/apYFRzb+iRuOY1SFy62B91aFNWd8gD+O33FLFnECRmm/f8DmCWPrQM6
	WkYS/LHWsM9oQSI7bmbAKkLdj/MEL99JncUPxv7eH0N82wLpF4OqbO4pPWH/3qwrFpE6Qlg2+GV
	h15FZDH17zsKG1MEf/OVjzbhbcSulDoaKqJQMRmiMlnSUbHMnYGaCOt75oHx/i2+u3yMQVNx0qw
	q8Rv0RXRta47t5WFZMXHGJ9MvRxLvY60mtNj30CY7v3BRuDII0/yU9Joalw7V0REz7
X-Received: by 2002:a05:6808:c178:b0:495:f643:763f with SMTP id 5614622812f47-4b2286ed61cmr2057011b6e.7.1786632957228;
        Thu, 13 Aug 2026 07:55:57 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b22cd237bfsm1748666b6e.8.2026.08.13.07.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:55:56 -0700 (PDT)
Message-Id: <75500c5abbaf5356869f6e465925f2c397c66626.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:40 +0000
Subject: [PATCH v3 02/13] delta: widen `create_delta_index()` parameter to
 `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The sole caller (`try_delta()` in builtin/pack-objects.c) passes an
`unsigned long`, which promotes safely, so no caller fixups are needed.
Splitting it out keeps the `diff_delta()`/`create_delta()` widening,
which does ripple to several callers, in its own commit.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h      | 2 +-
 diff-delta.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/delta.h b/delta.h
index ab0279168c..12075c54c5 100644
--- a/delta.h
+++ b/delta.h
@@ -14,7 +14,7 @@ struct delta_index;
  * using free_delta_index().
  */
 struct delta_index *
-create_delta_index(const void *buf, unsigned long bufsize);
+create_delta_index(const void *buf, size_t bufsize);
 
 /*
  * free_delta_index: free the index created by create_delta_index()
diff --git a/diff-delta.c b/diff-delta.c
index 9e1f9e6f95..bcc331af3e 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -132,7 +132,7 @@ struct delta_index {
 	struct index_entry *hash[FLEX_ARRAY];
 };
 
-struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
+struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 {
 	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
 	const unsigned char *data, *buffer = buf;
-- 
gitgitgadget

