Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3461F92E
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206509; cv=none; b=lHyJA94sXkML9Be7fWIpTvN1PZmoi9Vt24ITakEV1v1BAH/9rQYY2en0RTMJdDlG8wXDoTimuVDVEJGFcShVkVLTsXCAdQwnL5ktodjQL+TCWET0WeMxu0hQD/aUUjy/54+WKZhGcJizABWrUtNw6eDjfPOApB5DsomUibAGing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206509; c=relaxed/simple;
	bh=VPY5f/mlDUFuCVw70ED3RUAN23zXONSeg3IZtLjWO/A=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Pd0WGZSqlx35VIxf+1BoAIFRGXAW+X7Xf/WC2J3t/lgHtF8hr/pejh1Co2zs8zzglpgdns1fSic9LDvdZY/3SU+n5sxte6iyHboyZd7p39JAFmDrMNxew6TsVZmqsI/wEYB+02R2aTSA4lKCTvWPf5DnnBTy8RgcsxQOE9MeL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt57s89s; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt57s89s"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40946982a78so630479fac.2
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775206505; x=1775811305; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=505oDZhSRB7DA546ZMZTN3L+RGle/p74ZxbeO6+p2uI=;
        b=Nt57s89sCy0s0aw0hERtZ+c84mH3ZMmve3q+oSK18FaM/F5vJZ9hT5E0OH2tEofu43
         tRapsSl0vNlqVNRoDuarNFBeJs9dVVZDPb6IuGRFrRMsP2ALwQ6YTmgQexmt3Ldgz2tK
         nbC9mIgBAPwl1KrLA9/RUq518mYcq9JU86lVeRKCLM3WyMfDnSXik/kGezuT5VKXNIM8
         TnVFRv6fSLSO9T2Kp1ehibcbR/Qrn5B5BNTnvNGlFFF9SVrI1dmgAgdtTpQs4bqscdnC
         mFRUTX7J5HpJgsVFUjRr82rWDCn7H7BXkNGjBgi4NtorGgNNQ0av3+PqLjVviMDqgXIg
         DSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775206505; x=1775811305;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=505oDZhSRB7DA546ZMZTN3L+RGle/p74ZxbeO6+p2uI=;
        b=q957rTZdA1JwGv9UyaJk7KMyKVAnVl+o0V8lobualVhvNYqyzVvovToldesCGFO5C6
         TcjoUjcrzRZs3nV4AIUUXqXP2oWsqASMg4UrCtvtRu3iQgEXwOmKOx+Th01biLR8h65B
         TlxN6tJ3dybi1lY1qvK4BDOwAc3Iskm/rgf2gRWMya69+T+lvFQKJLHvbFp3/S+17TLk
         tfEVGufysXvFIQ1YyL4J5USDmasqUbI5OqavDNIyTlxRVMjQt36ssMcmON5dOEBrEFjV
         c6IXOM5UKH+hX1dSzdAieeJJa64rg3Y1Tv/v+Cvx+bjfdVEbuxqkqBxqyK/UGxOpr87E
         nTMg==
X-Gm-Message-State: AOJu0YxIF9d+1bmOg6qs4g7TrGy1ThmEKYrwzfE3FPkXfhUHb9e3pmnP
	FeU+SSWbDi2zxEwA4B3Nccu16kfHLUftMwuMl7f0ejxL3ECIUS6umNI2Izp06fYz
X-Gm-Gg: AeBDiesegHVL0SFGzzR7puoeFPRivnaCEaL/J9vQ4anxiZ2gLvaX5v/t7llM6M7wEm+
	PT7bE5snSamJtdCFDqnEumi70xRxAL4Q6C8FucRjrSyj+pJjGXiiGem4ZMFc4FUO3TQ97es3162
	Wyopn0huKJMwmmnNAgNEEVmnR7MWwfmBOHN/Y1KHy1wzdm86s+7N1c/OFIMY71j55ZchR/hsHOB
	Q7OtAfKqJU2xtmWlRDf2AM0ojSL10ylvpn9xKj7IyzpBRfi0visAZRSSQylLOnUrzLpfxmzLux/
	O/jEr+V2IoC2i9s97tktoYDV/RfMfX1SqnSo03fwj7u3YLnDCN3zQLe2OOXljhF1SmjbnTDxx3l
	CmleR0lQ3v9XyG+k7yyN21cj23qXVGpOCMV5TSVKnyVtevPTCqi02+8msKVpsE48wmTdcKWLGug
	9/xu188VAebTcTCkB0uGJnix1g
X-Received: by 2002:a05:6870:670d:b0:408:9c83:5b1a with SMTP id 586e51a60fabf-4230fcb1c75mr1097519fac.4.1775206505025;
        Fri, 03 Apr 2026 01:55:05 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.21.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb3c8282sm4331301fac.13.2026.04.03.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:55:03 -0700 (PDT)
Message-Id: <pull.2078.git.1775206502134.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Apr 2026 08:55:02 +0000
Subject: [PATCH] cmake: use writev(3p) wrapper as needed
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a companion patch of 3b9b2c2a29a (compat/posix: introduce
writev(3p) wrapper, 2026-03-13) where support for using the `writev()`
wrapper was introduced in the `Makefile` and the Meson-based build, but
the CMake build still needs that treatment, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake: use writev(3p) wrapper as needed
    
    This was necessary to get Git for Windows v2.54.0-rc0's CI builds to
    pass successfully.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2078%2Fdscho%2Fwritev-vs-cmake-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2078/dscho/writev-vs-cmake-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2078

 contrib/buildsystems/CMakeLists.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index c6cfb874ef..dce9c84d0b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -376,7 +376,7 @@ endif()
 #function checks
 set(function_checks
 	strcasestr memmem strlcpy strtoimax strtoumax strtoull
-	setenv mkdtemp poll pread memmem)
+	setenv mkdtemp poll pread memmem writev)
 
 #unsetenv,hstrerror are incompatible with windows build
 if(NOT WIN32)
@@ -421,6 +421,10 @@ if(NOT HAVE_MEMMEM)
 	list(APPEND compat_SOURCES compat/memmem.c)
 endif()
 
+if(NOT HAVE_WRITEV)
+	list(APPEND compat_SOURCES compat/writev.c)
+endif()
+
 if(NOT WIN32)
 	if(NOT HAVE_UNSETENV)
 		list(APPEND compat_SOURCES compat/unsetenv.c)

base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
-- 
gitgitgadget
