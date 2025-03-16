Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092D1514E4
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742107328; cv=none; b=gpSfICe7dmeWA7r1GrUc3YyfKs2djOQj/xmTMg57qRW9FbwHgzxSSJ5fmfvi0CHh5ntACjeLKNiDuYwgCzwI5lz9h4I8VS40t1Sy90G17kLv9JdJB+dVbCPA+aCBh1lZisK4rno0x2p+e57jHQy+AKKF5omS6nZQXVesBBjUTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742107328; c=relaxed/simple;
	bh=9jjz5F1a8/dNZiM277C1aeXpMRBIIEehRF47/i0JKOs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GVUrVTuaKmq4o+fIvq48VJBiPRF/XqODHOKwyvsYr7L6H1HrrtzwPC1mfVZJuczico+TrP7o081IL0w12D27Cpj0HRM1RZNZvt8K7Wo3RHeeyTbLWidXtzVSnNxNOkx9GxVhLiIIUEhj8it/aM3k//3ltdnJwXZDGZR+r3MA7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kyw3QqZh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kyw3QqZh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso6210575e9.0
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742107325; x=1742712125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZpoFSg52lF4whc6ZSEX42NfZUMdvuxvhsh6l6nJHN0=;
        b=Kyw3QqZhp6mySnmzpAqQLe6WewIgCBw0cvyXqFRAXTEE037rz8jpxd4RbCVRRDxSiJ
         eMUKtmHhZEO+47H6Tgym2+7B62jWLbgfwtwsHNLL3beol9WGlYme3R/to/2stWJeWXUV
         /XH4bvThArwA0W+O8NiM5G7LWY09pjBZdTUaU5ikbU1VfA/+5OksVewqT40I17UysVw2
         vwD5PG6aZZIIS8NG8G25JVonDx1M3oV27OetBMfQhjOQC4ysh2N49FiG43z/zH2zcSjZ
         eUtkYZUq7uN9IxIrgZQ20a353YvmD0szpopCRWE00783a1SkH5Ie787YlfL3WBTnoNpL
         yDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742107325; x=1742712125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZpoFSg52lF4whc6ZSEX42NfZUMdvuxvhsh6l6nJHN0=;
        b=rrS4Gm2c0kF3jWLbD1mW3xjbaU7s78dKlbgNEOzDiNYJ6R/Nz4gb9583jTJ3x5J9Wa
         fKK/Kvbjommvi4fOi+fueSedEmtesOrP4ipHG3A1XJWo/ymou4I4xSU8B5UMjFcXRbcP
         KHsFrlP4Ayru1Xh9jZqfRpvsqL2HtN25/w3xtTjT+SKzbI2Dh0wZj4KksGsjvr8KTPaA
         aUbwYAxnbGaIVWLA7kKj2gDi9zQqk2Te1HrtQYwxM6BSZOq9TLtWmVIFitHrtNImIRZX
         Veq9iTvGyuAggjLWJs/pSyiQ9nfTosgPC5Of02RA+Cr4fSGXXorInsUrLDcefnsLjoch
         FCkQ==
X-Gm-Message-State: AOJu0YyBdOe9lVv5l/1LXivtRgfFcVvc+WByqXt/kMgiYIGHsJTnx2dr
	BR2fVu+0CDdf+i9ZVYVWSn40OyIScIe/Imf7esPWLmSZ3D1IT0GPEi3QSQ==
X-Gm-Gg: ASbGncs5EFLKqypDAX0x19RSRJXOMfV6hnno2EPB49ogWV3gKSaZIHGUFPuQPiH9OXO
	Er0KA0KelP6fzHf51VQAghCoc8kOg2cMhj5yup61/Dv81ABvaUNvfpqfE5mOI2VxQ+Y4C67Fodu
	GRYgF7Jxslc68k5aGFMLpkh0PKsrfPL5u2XtRCtjS8uByUUCTRwiBHUg4t9iG/O2jjM3pzpd3Mx
	EWPtjhICFHn2r6lbxfjGiBWZ/IFwRMAHyfWZ1GznqeV+KcZBN3vuLSAbSAkoPm+0MXGNPQwSuRP
	KaWnRPZ1ETwJZMUrVt6G0Q482F44lK/O/Haib/3/fyC3TA==
X-Google-Smtp-Source: AGHT+IFOZYpMUIQMlCghi6MXURMtKqUYmiY0YtnnfwtWa5WHLczw+EEOLk9ndNcZyNZU2JnPN7wV1g==
X-Received: by 2002:a05:600c:1550:b0:43d:1bf6:15e1 with SMTP id 5b1f17b1804b1-43d1f1d2bc1mr92684015e9.1.1742107324654;
        Sat, 15 Mar 2025 23:42:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e2d6sm69236775e9.38.2025.03.15.23.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:42:04 -0700 (PDT)
Message-Id: <109060ccb8665c73aa0c4f73e3cbbddcd135bde4.1742107322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
	<pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 06:42:00 +0000
Subject: [PATCH v2 1/3] git-compat-util: introduce BUG_IF_NOT() macro
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Create a BUG_IF_NOT() macro which is similar to assert(), but will not be
compiled out when NDEBUG is defined, and is thus safe to use even if its
argument has side-effects.

We will use this new macro in a subsequent commit to convert a few
existing assert() invocations to BUG_IF_NOT().  In particular, we'll
convert the handful of invocations which cannot be proven to be free of
side effects with a simple compiler/linker hack.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-compat-util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e123288e8f1..c3415ad7e0a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1460,6 +1460,7 @@ extern int bug_called_must_BUG;
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define BUG_IF_NOT(a) if (!(a)) BUG("Assertion `" #a "' failed.")
 __attribute__((format (printf, 3, 4)))
 void bug_fl(const char *file, int line, const char *fmt, ...);
 #define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
-- 
gitgitgadget

