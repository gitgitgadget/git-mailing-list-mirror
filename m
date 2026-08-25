Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC8331207
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684193; cv=none; b=qwFwTcMd+me8B1yRysZsroOPAyxW1qs2zTKxwVvYR+P4Z2llp/5t2E3JWjHmA9bm1r1j6UpahydQdhOCvIMUnpO4V5XMsbMSrSVmqGLHEmF1DPBzj7jRxagbAJrm2y0YUEjLwJhdxKdRMFMCjM/y4fk3WeFr8VCPxlNfgwkPp1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684193; c=relaxed/simple;
	bh=Q3qTUhAIsqrXCjASdqvYpxM1pghX6JY5AFBh6nmS89k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lct8fQ85kYdc+UFqNRagrFUeX2wMgN5f2jTLVoPwZyckxWmrV+6kPv2wKJEbnYToKDuK3LHDzOsfVsC3arsHuiahpN8EiqUeqk5PcK0URCrTCRo/JoFkfFz+X1JbogdxhCxYSoQhyzVs/ObaE5iS5N9mTnjfuiWT/dYueH3/Oko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZslUYZG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZslUYZG"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so110484a12.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684188; x=1788288988; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vOMX5+RP5r4fpBI4bR93CMjmPtXTju5wanwA2ywuHwo=;
        b=WZslUYZGwVq6PAwPSQa0BSBDEjjGeEuISH07fPw3E1st7G7o0M8Zx/uhFrjy2ezCIA
         NMykQh0cAD/7pXStDx06OOy8Hpbv/nZt7NSm2dcCz8CxZjzVtB8mXT63THrO14ub2MLL
         /q3LShZQPMPIjYqUs1jzbmBixqKX7oP3eihq7eqj/dG5XTCyntCBoxLlSlGdHeWHIX90
         J+DRPMOLf5frzO+Obnic3L4qBmfqbP6+YPPlsHXbhlcbkhgIzVhdHe9NYv6ngaFYhzZ1
         wpV0q1fN2x8j18B4uu31bRQzbfj8URgtaGe9NzNIa8Xc0aC6sAu98hapDpTgT9GsId3k
         vOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684188; x=1788288988;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vOMX5+RP5r4fpBI4bR93CMjmPtXTju5wanwA2ywuHwo=;
        b=PEUi//wVTQM7X3twqF1N/dvNeMwNzwTq8vwgJmdGFvyyX2bTqcNuf1d27zK0NJie7W
         LA0jeT+kXKJMh9YYUxmMb9eBvE6HdRsgqhpC5MSN6aWpdnlGNw5ZVHh+I68qPFlyHoyp
         ULkXD6WGlq/AkUfvWfgJg4V77EwNiSBya5AzbPu6+x6fgfCMQ5YhS+8PknClIquKyco4
         mvcds6keZCwWUx6M3uHwfUlWsMXLKM0woEYN0uNwS0HtlY2iO3S1J5YJuc4u5cQH5mHY
         IwXE1ngz/EtTQBD6nhfl/jrAVTYOVvv9t1nqvfy8tdaNwmluPBv9MIkxFSpVeCOC5Kr8
         rwrw==
X-Gm-Message-State: AFuF++m2Jty8Mqkj3/ZeyYnrYWCHocqAV4oR0GglCYvPTYMFgVmlWwsi
	oJh1WtsLP8XWeYB9nyqY0Q03U0eLpVbW86NJ7ZKLnIJts2l+ngu4YneP7GJOXqyt
X-Gm-Gg: AR+sD129tSAsdb10tvMqeA4hx7vKHVzy/18the4sXcXYRo2n6Nk6Z+VH56s88bcuRFG
	vLEYkRo2B6aNMx61nVmpR0JOzbzRCLoYA/SKSbGCFFvubSj8fwoLR5ER87bYXvM+u4n1ChC3CjV
	JGFx+iAiDajjX6MQeBBfTFzTlkzDwU+DjHmGjMu58zbfPHATwNdwObfUN+Hs6nM6AS94TrCQKw5
	azHdu0NqxBGCd4nxsP4FjIv7zwLPBBOyEGReMJ8a94Jx6A7iQsanYyqM8PvB+vuS5npsWu2GUue
	sYsoEn4DemW6WOCPc8XmC20oPnw2qjqNanpA3CAeIfFP69WCf5AQqwChb7xhXE3tgfT0lOuYkDr
	ahSXJ8iyF2G1OBQSzt/tHr/UXjh/2A8TJF9AFR0Ada0svu/DuHidnEsGiNx1f3YLA8VV3QcsyD/
	mINFvntZYKCTjL7kOeUG6+gO0YhTRy2XjtrGeL9f2hXowGg47ZONP/l3cUUM20/g==
X-Received: by 2002:a05:6a21:a383:b0:3c4:1916:9d3c with SMTP id adf61e73a8af0-3cf85467e50mr1074887637.15.1787684187760;
        Tue, 25 Aug 2026 11:56:27 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283fa89e8fsm427233eec.8.2026.08.25.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:56:27 -0700 (PDT)
Message-Id: <ec447a6a778a5c49344346df54b434a96c792082.1787684181.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 18:56:17 +0000
Subject: [PATCH v2 3/7] trace2: remove use of xstrdup()
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
Cc: gitster@pobox.com,
    Taylor Blau <ttaylorr@openai.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In the previous change, we removed a use of xsprintf() that caused a
recursive die() loop when failing to allocate memory. The trace2 library is
too low-level to be calling die(), especially because of these recursive
loops that can occur during the die handler.

For full defense in depth, we remove the xstrdup() calls from
trace2/tr2_sysenv.c.

First, in tr2_sysenv_cb(), we need to handle a failed assignment of the
value with a negative return to halt the config parsing loop.

Second, in tr2_sysenv_get(), the method will return NULL when strdup()
returns NULL. This return is indistinguishable from the environment variable
having no value. That means that all callers know how to handle a NULL
response, but no behavior change will occur between the case of no
environment being set and detecting an environment variable exists but we
fail to duplicate it. This seems an appropriate trade-off, as an allocation
failure at this level will likely lead to failure in another system, but at
least the trace2 API will not cause the process to fail early.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h        | 3 +++
 trace2/tr2_sysenv.c | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/banned-die.h b/banned-die.h
index 0e0a794e5d..2e16c4899c 100644
--- a/banned-die.h
+++ b/banned-die.h
@@ -14,4 +14,7 @@
 #undef xsnprintf
 #define xsnprintf(...) BANNED(xsnprintf)
 
+#undef xstrdup
+#define xstrdup(str) BANNED(xstrdup)
+
 #endif /* BANNED_DIE_H */
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index deb3fabff4..4ee273a4ae 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -74,7 +74,9 @@ static int tr2_sysenv_cb(const char *key, const char *value,
 			if (!value)
 				return config_error_nonbool(key);
 			free(tr2_sysenv_settings[k].value);
-			tr2_sysenv_settings[k].value = xstrdup(value);
+			tr2_sysenv_settings[k].value = strdup(value);
+			if (!tr2_sysenv_settings[k].value)
+				return -1;
 			return 0;
 		}
 	}
@@ -110,7 +112,7 @@ const char *tr2_sysenv_get(enum tr2_sysenv_variable var)
 		const char *v = getenv(tr2_sysenv_settings[var].env_var_name);
 		if (v && *v) {
 			free(tr2_sysenv_settings[var].value);
-			tr2_sysenv_settings[var].value = xstrdup(v);
+			tr2_sysenv_settings[var].value = strdup(v);
 		}
 		tr2_sysenv_settings[var].getenv_called = 1;
 	}
-- 
gitgitgadget

