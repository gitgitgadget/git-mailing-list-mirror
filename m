Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580551420A8
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720904912; cv=none; b=Ki0aJfdDgZ+3kLY04oORhl3xX9gyVdSl+FGidBAk1YbLZ1VoWN71kC27PEj7wK5+aZwHy027VWqkbOOYqqqgQ493R/p6yFUnpFfdv5dSBj8f0dl0jAWQxsf6ueR4Df4a+GCXZcrkGMdghVB+5k8AYf3RxjKxFmY16D08yzUJqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720904912; c=relaxed/simple;
	bh=MIwsxKQCc6L1ypFrSWOoIhAUtc7BOba8IDgNM12CZxk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JC/4iUSxgLPJbLAXWX9aB2H2aWm6cAhNfzZ3QcHdyluHhPa+oyyOgT/m7WhnAI7SuGc/pDQg9uf22lb7iDRxg595hYABbWEk4u6bHpRjk2IdeVYkYaia9rHf8zzvllAwd51s+ZhxODHdwUvncDyuIihMLMtYaD6jU7YXFdSatio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG6qCyPZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG6qCyPZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-426717a2d12so18284375e9.0
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720904908; x=1721509708; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpbfQ6cIUNHUjgSnKnj7SnzmfwlwJBl0mHg3GxACDxI=;
        b=hG6qCyPZIvzepR3rFlhxHvilvp10sJZx947/P4VXsFZBzkIuj8n9O30GHOLiN2bK3X
         AZLUXNr/vqMn8pF4R78nF2+nUUYA4opuBDlwEL197Zzi+pzKreoBrjd6PPWGAbGX7vSm
         Eqx8ixDE8tr6U03xWQUTMr3IF9teDQqgoq9NVq8ORO+z3q5r3MhSdGlejQL69CnLhzfu
         /zqk2GhuNMGPdsFpFkwsSE6zbBX8K7zyMG1u6CnTyzlZtn3ROGKfRg7061j9k3V3Hy4V
         eCoQfqxokcVuJQoSHN+UgYrI2UElBuX/9dnSzIuikOtPvaWKOf1/PyjHQPnAhakymwM1
         Z6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720904908; x=1721509708;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpbfQ6cIUNHUjgSnKnj7SnzmfwlwJBl0mHg3GxACDxI=;
        b=MsnLPoL19/v8QChpQi57WJD0mboHLoJvsaiC5Nye1y+8hbYXM2sqwm0/LEFDpWBjjF
         uyDg+I3X1btonZCzo86FkwTi3wQg3YZaK7eZosUv3ZRyVvCjmTSDnlQ6J1JDra5pyY7L
         0AD8mKinwmUzybcYLCt5S+NhXQA9723AGLL7AgBDg2mVJl9VDasINMETkAQAPPb2c93u
         3VTc5Jfh7WUz3upHcrFXMbRtwEnaD/tgj8rWCIDCdGnjLOymFrCWWWv8XsuNdrLCsj9/
         05Eeci+47DbZqYlYYRpn20L7ZPavWJ9WIVpnli3zcnX3MN309zuXa7GWN1esN33/VyLP
         xlJw==
X-Gm-Message-State: AOJu0Yx/D/VLJjMt1le9J0lvGOzNYz5Kewogak4kopg9EbkhZNNySOv0
	CqCqsjPhKl/aK+IcKGex5ATG6ZbB6ceDQJdpCJW4NrlsbksVSgxNgqQ2aw==
X-Google-Smtp-Source: AGHT+IGESz23EecRfOvwPqkK7HxiPPr0LOxbP8hOXUd3pzec8QaWOVfgJp3Moj7ljqAGRXjdmgsxFA==
X-Received: by 2002:a05:600c:4793:b0:426:67f9:a7d8 with SMTP id 5b1f17b1804b1-4279dae2aedmr58167215e9.9.1720904908378;
        Sat, 13 Jul 2024 14:08:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc42esm67891135e9.32.2024.07.13.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:08:28 -0700 (PDT)
Message-Id: <91ebccbc39f21fa73af8bc8c81af721f1ca201bd.1720904905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
	<pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jul 2024 21:08:19 +0000
Subject: [PATCH v3 2/7] strvec: declare the `strvec_push_nodup()` function
 globally
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function differs from `strvec_push()` in that it takes ownership of
the allocated string that is passed as second argument.

This is useful when appending elements to the string array that have
been freshly allocated and serve no further other purpose after that.

Without declaring this function globally, call sites would allocate the
memory, only to have `strvec_push()` duplicate the string, and then the
first copy would need to be released. Having this function globally
avoids that kind of unnecessary work.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 strvec.c | 2 +-
 strvec.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/strvec.c b/strvec.c
index d4073ec9fa2..f712070f574 100644
--- a/strvec.c
+++ b/strvec.c
@@ -10,7 +10,7 @@ void strvec_init(struct strvec *array)
 	memcpy(array, &blank, sizeof(*array));
 }
 
-static void strvec_push_nodup(struct strvec *array, const char *value)
+void strvec_push_nodup(struct strvec *array, char *value)
 {
 	if (array->v == empty_strvec)
 		array->v = NULL;
diff --git a/strvec.h b/strvec.h
index 6c7e8b7d503..4b73c1f092e 100644
--- a/strvec.h
+++ b/strvec.h
@@ -46,6 +46,9 @@ void strvec_init(struct strvec *);
 /* Push a copy of a string onto the end of the array. */
 const char *strvec_push(struct strvec *, const char *);
 
+/* Push an allocated string onto the end of the array, taking ownership. */
+void strvec_push_nodup(struct strvec *array, char *value);
+
 /**
  * Format a string and push it onto the end of the array. This is a
  * convenience wrapper combining `strbuf_addf` and `strvec_push`.
-- 
gitgitgadget

