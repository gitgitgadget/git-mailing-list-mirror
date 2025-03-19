Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9719B3CB
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401384; cv=none; b=YZ04ZsePkK990x4ATcnNUKj/ct2+gm4Q1YmeW4EH83+pChPx2NhbNKT0/mRGsK7LcVUd+/fgyCEI+lPQxwGYAbnfWzgvtoAAbVkLuW0D5GMJUTvwDLcwPMPpMv+AGr+7ihNLJz1cYGHAm3pWdQmEtH3RMAObEdM2WuT0rqNHl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401384; c=relaxed/simple;
	bh=nr6BJcaeTNqFXJIRtxWfGEMa6oAJEzDnvD2jVbwFHgo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YRTtBfEO3EG9s+MLhQcVMj7hRggTrTm/ZHnTysSkt1Svp3pSmMUCNEDiYz1mso1hfQJhHBktfjeJt8+J6kqHUb7R2x3qtOSXPTm2P/5JZQtLxKPkv0yT+NDxtU6lJJijeUQEpjx28xZuu78eh1BbidJ4YYx0Pm46oj/j98qJf34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od2mrdew; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od2mrdew"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso24137185e9.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742401381; x=1743006181; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tg82WwtUPPveFkWGE+SNOx6eM5efpEsxzXOvnnyMDk=;
        b=Od2mrdewoRIkYbkUcg1vch6XSgDujWWqWMfI/szOXZcZ4e+MFliEQZI/ndKZi/r/9s
         9m2tygvfa12vFq086N5ML/qs3AmtPJOgdzjORezoIy8ngfYWvU2VkHAPe0V+Qk7QKSAu
         Br85oN3nAFpRIc0APYNKLjJm2aiEIydpd7XbfJPMBpnag7e7fNyXj65oRxUdcP9DcXNW
         LB6esMc+BHUPP1TeqQB0llxvxvIYiZQUgUfIbp+aB7hJ4L/PdfO8m6i1xLXoa4z3hznq
         nYinZUrjd6ktKBFA9SAzGDhl15jQlHZnwldnykSF6JnBIW/gt+UBj2sqoldwJSBBavX6
         fx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401381; x=1743006181;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tg82WwtUPPveFkWGE+SNOx6eM5efpEsxzXOvnnyMDk=;
        b=LBL7DnUD20y8+Mj5e03RXeewXuNZFi8JTAPSl0tAHjOZwXhAvhxvIBXczUwrpd1OPC
         pqqPrqquOh3GZzKIto1vvwP+/2NQWK0Q+7gLa64OvqPTxzw6cO+KTiKtNPh3gA8aOsQ9
         GLEOWElc9KGXaeOtaDc9m7UyMaDDaF1dXBHmGq+EFGasnTe01kl9IISm5lezuQOmmWE/
         +UYCLAR8lQ8+8glxytZh3IqqFWHinFtrt+SxVBI5Pf8cU1datNTt1iosHsnDu3l8iGXd
         AN7wFWlC2D2aW5+Vz2hHvcIbTEJYviR7dR1YmcwKUj9/7RkfMv9rcwxi0QyoVi/HbFon
         Zpxg==
X-Gm-Message-State: AOJu0Yx/lFS6uYDj6uZhI6zz/vS0MjUza52VxynXQBBHKu8iOKlpG+gP
	2iPZurzr4SPk90Z2sKYUT2qbRq8bT3nm3AJym6ImKAHhnJC7pmoJyDwD5g==
X-Gm-Gg: ASbGnctmSS0/gohq53zTI5OBXzQXZZBOR2YFU6IGYLQO1LdyLn82HCd6UWMjo1nm+j6
	w4qxKWekoGRmBZurNIw49eD3j1pwySf2n2qRnAV9KYSQrM9mPqOukQcFc9iyor4zr/gcUzb3vJG
	L60uVNTbTKxNwrnDVo8kSXnRi8A7Wv0ST3O0UH16HWRvRU91X3TL1OZ6PntOlItuMI+PYN4svub
	pCRo9cjuK/rPbILZxW77gcqGcFcH5+qzumg2bn5nCTsxd7f80ZKL9HKInlU7wQKcJSI46NsmHTp
	qO2THU5FNfP6UyVdFrkUfkdg3HJhqil9l5Rcxa5bM81lQw==
X-Google-Smtp-Source: AGHT+IH7Yn1TCionKZ4VYjCiJzlOV5fjcDS5rUx3SU+Rcmqgd0mXaHOsNu2QXY3frw7/x2avyIn86w==
X-Received: by 2002:a05:6000:1868:b0:391:3207:2e6f with SMTP id ffacd0b85a97d-399795ddfb1mr64965f8f.42.1742401380820;
        Wed, 19 Mar 2025 09:23:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b90sm21815233f8f.53.2025.03.19.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:23:00 -0700 (PDT)
Message-Id: <d22ff3e3f97dfa1b88e78b81d85d9bc66c6a74d1.1742401378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.v3.git.1742401378.gitgitgadget@gmail.com>
References: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
	<pull.1881.v3.git.1742401378.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Mar 2025 16:22:56 +0000
Subject: [PATCH v3 1/3] git-compat-util: introduce ASSERT() macro
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
    Elijah Newren <newren@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Create a ASSERT() macro which is similar to assert(), but will not be
compiled out when NDEBUG is defined, and is thus safe to use even if its
argument has side-effects.

We will use this new macro in a subsequent commit to convert a few
existing assert() invocations to ASSERT().  In particular, we'll
convert the handful of invocations which cannot be proven to be free of
side effects with a simple compiler/linker hack.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-compat-util.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e123288e8f1..d7f3407128c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1460,6 +1460,8 @@ extern int bug_called_must_BUG;
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
+/* ASSERT: like assert(), but won't be compiled out with NDEBUG */
+#define ASSERT(a) if (!(a)) BUG("Assertion `" #a "' failed.")
 __attribute__((format (printf, 3, 4)))
 void bug_fl(const char *file, int line, const char *fmt, ...);
 #define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
-- 
gitgitgadget

