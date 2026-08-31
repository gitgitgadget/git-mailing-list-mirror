Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE794AE8B4
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197151; cv=none; b=bVxHGpYCBgIc0qOLjyyAygK1PLu/IAmVqD0PS6LoxlFbcbhxBe2s/jUZgNb7xOAVsQrs30Df/pmDWvemspElf4leDr3iylbsQqwZwRD/DDT6qCPttFR0IQPwXokvVpgERpE7oCEomUfe0dWqVqFnvem086iwU+kbozIOTUYghGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197151; c=relaxed/simple;
	bh=hK5o5g+GvZfRs5fUk3gI4FOEoaQNGHlY6xx/qdgiaxo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JqQFFsROCxxPF2IA7OxNKW+1DJ0mjCRl1GxIO44YAahtqMfNL9kt90W/42Rp073KCgb5+4+kpLbKme3D1RHHERHZORMcWSaX7yIxUBfLNhV4hmoGaUiD3FBfjm4qDjBJQWUO3B8jfohLKh0ZIksNStRqd3MM24eKie4Y5MNnxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzAvo1dy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzAvo1dy"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52e2d1bdbc0so26404941cf.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788197149; x=1788801949; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QnWng7Hl0uzfqHWXqSISIGZH1klzun0TtAA+syc3Xnc=;
        b=XzAvo1dyVCmVr23mOs+KVh8CnMHSN0vUEIWzliLST3hctpAIdggnjhPtpNCV/Hownp
         BrIRRkTb0m0zisnbNYrZBVn5SKRIC3nR/YpeTdh+FiEjd5batOEgxEVKaWPnGhR+ci3h
         TUoMIBph1M2OwunctKGUbZ1vEcT75WBbZErDoRK4wiBXSTx+AlA7j5O4lVWQh5tGte7f
         93wmY46lOnMig+nst029t7EdTGTkBxibGvTF+KCis8CjvaA+kQglWAfP65TRJ/a4KsRm
         3Ty1pnAofR7PovVYGZFjFvWYISjLaJ5FuhkydyA2hPGX7yJbZ/G3RP/UoVO7uKSRpq3f
         zvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788197149; x=1788801949;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QnWng7Hl0uzfqHWXqSISIGZH1klzun0TtAA+syc3Xnc=;
        b=FC8+DUPi4bBoi43IEV7DBWWN0i9TfhgUa68/hw+xECfS+RNwc9zRPnUFDnUvIQ3lkZ
         vmPmnlingJAphUz1tKMNGfcVyN8uZ3frPgTZk9XgjCFSxi7DQ8DWxzGT7r9Vzcx6dTIj
         W6hJZa2mG7hchfAnhMghGe1YkFAh7JIt9ptUogoHoIgzs4nyLyeXUDF99kOkNGe5F2kf
         6F5X7zw4KxbxVo170oZ1nyeTykbm0kWqO9+ReXnx4SB7Cj5SGx6sAPB/BA9gGzAvy+rQ
         cwSblaSeB7zv2jt2lbaIuo5+a+dG/0d00iiF1NfD5NmgagE2Tjx/stLp48TfsY0kq9Bz
         nn2Q==
X-Gm-Message-State: AFuF++lTK9EDObaNX9AwnZ2xVPZLkuJgXiQSJxsZLnMBAAifmbzcjt3/
	/CD6HNR41QO6qlvm9arIOW/Pwu5OaXBOgfd1wkenWn7c0j2VnqEzRA3O7VUqD8tB
X-Gm-Gg: AR+sD12DorkORCzUltlKJ93r00lnT33I738EOS/JHHhgBsZxY7UQDeR8GoW4mfw9CxF
	ThwOuKbVOom9Pd6pLqiFaCCZREWQ/T7yYzRHFXgMF8lm1GbjClR3l+yC6KiqYr07J7t7XGq1cra
	tnSt9ZMSC+fOuCSv37oPXckA+T/vnLHY8YpDDfO0E51KTn8jeJAKvVv3yFNeplaRsIvFBiUjjDh
	PvJwKwl6J3SsNnSb0DtNH96hROYT3rvQz6sJkT0diQqDIVy1/XPKBnfMFhlFF/o/dlyJE/pDE/A
	oTZLNb/fvYbJzn4EHHW2v9kTiRCWEdM3pkP2jXSh3ZbxwxLf9H3vyJwrxwugrdPxTgo3+V4WwfK
	/TGVnqS5URbf75yGq/e9vxgx/Li/w/AU3k+yIWQITXHyU7ZeH6I7gu9sANrGyXWsLkLWJtv3kNZ
	vApnwNdtaH2S1KTyh491xujjks7IxzFpKsIbTVGh74F572Rh8aToEV6vmyjM5KmhRN
X-Received: by 2002:ac8:5f95:0:b0:51c:555:7dea with SMTP id d75a77b69052e-52fb9690435mr315872561cf.30.1788197148684;
        Mon, 31 Aug 2026 10:25:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.223.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe830341sm76135201cf.22.2026.08.31.10.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:25:48 -0700 (PDT)
Message-Id: <87d3f1b557a1cddd08df1e7ba403602d2e8aba9b.1788197143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 17:25:39 +0000
Subject: [PATCH v3 3/7] trace2: remove use of xstrdup()
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
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
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
value with a zero-valued return to halt the config parsing loop. Note
that we don't want to use a negative return here or we would imply to
the config system that the config key or value was somehow invalid; such
an output would mask the real issue that the process failed to allocate
memory.

Second, in tr2_sysenv_get(), the method will return NULL when strdup()
returns NULL. This return is indistinguishable from the environment variable
having no value. That means that all callers know how to handle a NULL
response, but no behavior change will occur between the case of no
environment being set and detecting an environment variable exists but we
fail to duplicate it. This seems an appropriate trade-off, as an allocation
failure at this level will likely lead to failure in another system, but at
least the trace2 API will not cause the process to fail early.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h        | 3 +++
 trace2/tr2_sysenv.c | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/banned-die.h b/banned-die.h
index 589e9cc2bd..bf16ec5ba9 100644
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
index 7fa58eba91..4a9983caf4 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -75,7 +75,9 @@ static int tr2_sysenv_cb(const char *key, const char *value,
 			if (!value)
 				return config_error_nonbool(key);
 			free(tr2_sysenv_settings[k].value);
-			tr2_sysenv_settings[k].value = xstrdup(value);
+			tr2_sysenv_settings[k].value = strdup(value);
+			if (!tr2_sysenv_settings[k].value)
+				return 0;
 			return 0;
 		}
 	}
@@ -111,7 +113,7 @@ const char *tr2_sysenv_get(enum tr2_sysenv_variable var)
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

