Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A426F47D
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395316; cv=none; b=YEBLmV/BkiXgcsC22i/wAOaJ0gCYgq8w7kH/0i+4d2wZwPGuXOjioRgJZZb3aBBLjEu7TqVvIEWdoZ+tPby5lyRAuquTGD0dKcg+FurC01zpMpYJkbgqcl6ZnD/HBxJlPBX5/nObffODFdhPmUH8v538H/A2azo58fBztC8zXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395316; c=relaxed/simple;
	bh=sTs4kOwkKbzUA6iMhfksaZjlX/a4lp0VqmYwnoOFmCw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rDoosnYafQNGkCdRN5FznSCRdiMISA37wdn+nWUBrvE3ebPY/RN89cxcazJhZaZa2+S0HAJr64tPDp/VHlNBMciH58ffrkhwFdYPHt4cuw8aOsu1v8wJsRpqOFT+R5FTmkgxkKNatxW0+SHQ99TGzD2Ynp9AOx0TYFf96+4IyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfydD7HA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfydD7HA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso70471665e9.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745395311; x=1746000111; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA49juF+s0FpDp0EVxWh4LgqWdP7t03stnxoTZ8SwxY=;
        b=TfydD7HAB/bOEmoyJsz+vIBMmMBzl2zagCiWZk0B95u3T79mqZ0hyuFXxEB9QthnpM
         hS4capgfdoRCVdq4YfGzvrJpZ7ARXpEcXi4LPhCZBup0mM/vPhHxJhjzazAvxwC0cLmG
         mb9ovldvr2bbf0Gz3tmoSrPkUJBenK8DEE1d7trJK6qBshMNPLnLLZhbMJcXc2J3/Ki9
         8O+u2XnAypTbqIr4dMDmGKMeiSravoYZQK11YYuQMwm2VAFPK9jYFwzpSIJ1PIDSQV7R
         tPulgxGhHM4ZCIfhB9y79TeEbdfNcGfYtWiX8zHm+B6PH9HI4MfdQNBcgeezUR6viLIB
         lwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745395311; x=1746000111;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA49juF+s0FpDp0EVxWh4LgqWdP7t03stnxoTZ8SwxY=;
        b=b1CXmFwKqcEHAi5ijJfLEA8fVJy5IxoPJ3mPMtU2ImzcXN4ly7pX4/Jvi6Ae8VlnhS
         2pyQ3JOVHZkT+00z4oqGfh5WG/gGlRkyImS7nNDRnr28JQ8ni2DrvcrQfURiGFWgFf8P
         48foDvWVbVQxOszLudokmkRJBP8IVmXoZzuEssAqcnT0yAgBxYFSa3udvCAjBlS2HTCv
         Ejm194VxARNRQ4W+iog3ALABB+2qqJsj7tOCABbcIPW16UNrt3NnZO4pwPSJwMok2KEH
         GZZj2F7XGpvtyrNl8+/YZPhvpyS04Dfp1r43zMCwhDizqSm2967NqPab+q3pP7yyNhIk
         ecVg==
X-Gm-Message-State: AOJu0YyDE5kSLC32Tye8Dg8F4EQEYH810SsdVpJE26PcK/guJyanpLLu
	t2YanHp/tFRJ7+//S0MrRB1AMwRE0Kb4N63cSyjnXlD2jRUo9iDAakGpMQ==
X-Gm-Gg: ASbGnctFEFMUzvaf470oK48YAR7teeFSprTgtqvJVWqi3WbDmn+HbxbEdhheCv2s3fA
	G6FG7ImhLr5OSbT7IQy1O5PrTnJ7iFsLoob7LPnk5eiEqbwwEEXXre3sutcQO08I7Wq/D7CSUPc
	nu5qVmlTyxCu+z/xvEYtXGZR0+Np7/KIAqmn4cTNxp+1CCLlg/f4w4Hos29GsvpUtnhk/6ZdsNj
	R8wjazbW3N/+n/7yWgLLFcDDFDpLwTrSdgqz/QQu8MucUomzCJDSAQbaOHrkoAfeXNUoPRlD3pc
	oCmVe1P9sMwHbz3WOJSVD9XdqlXvRPOthxT/1O4R1g==
X-Google-Smtp-Source: AGHT+IEmcb14PUa1xFysJ/N0xFHpVZv9XoXXdZEjetkTkdfWwbnMvxk/+Lu2OWtoIRGe/85L72NVJA==
X-Received: by 2002:a05:600c:3b8c:b0:43a:b0ac:b10c with SMTP id 5b1f17b1804b1-4406abfabc9mr151200875e9.26.1745395310910;
        Wed, 23 Apr 2025 01:01:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4f2dsm18021154f8f.95.2025.04.23.01.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:01:50 -0700 (PDT)
Message-Id: <b89f39cbac6abb23ce1f6a987dc864181af2f395.1745395308.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
	<pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
From: "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 08:01:43 +0000
Subject: [PATCH v2 1/6] bswap.h: add support for built-in bswap functions
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
    Dennis Ameling <dennis@dennisameling.com>

From: Dennis Ameling <dennis@dennisameling.com>

Newer compiler versions, like GCC 10 and Clang 12, have built-in
functions for bswap32 and bswap64. This comes in handy, for example,
when targeting CLANGARM64 on Windows, which would not be supported
without this logic.

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
---
 compat/bswap.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index b34054f2bd7..9e0f98e00b9 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -35,7 +35,19 @@ static inline uint64_t default_bswap64(uint64_t val)
 #undef bswap32
 #undef bswap64
 
-#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
+/**
+ * __has_builtin is available since Clang 10 and GCC 10.
+ * Below is a fallback for older compilers.
+ */
+#ifndef __has_builtin
+	#define __has_builtin(x) 0
+#endif
+
+#if __has_builtin(__builtin_bswap32) && __has_builtin(__builtin_bswap64)
+#define bswap32(x) __builtin_bswap32((x))
+#define bswap64(x) __builtin_bswap64((x))
+
+#elif defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
 
 #define bswap32 git_bswap32
 static inline uint32_t git_bswap32(uint32_t x)
-- 
gitgitgadget

