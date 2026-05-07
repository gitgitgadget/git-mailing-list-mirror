Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72C2475CB
	for <git@vger.kernel.org>; Thu,  7 May 2026 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778120196; cv=none; b=p9arbYgaLbctIGmmQfNlPTkMocP90kL+nYnZNzn6FqSA+UPT7V98xDvhvdBf05AJAyFGbNFflT1pDeIjoeKP4i993keLnTh69FYbiUhbEA3s+mvpYHTXFmQ9iykNTrs8ScVKtRuMQjedTKb7oRKti3fspPvefyZ+Thh339Mza5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778120196; c=relaxed/simple;
	bh=EguJjkvVEZoKggcTi5ajHCRuOU/ifHKJ//pVfO/6As4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=H02/YG17U29OoIFhKlhgvWp7VghfJ3dwsWx7qu8i5MzRmMC+nT5V2G4DpiL9W3aB3D650C+vjW+sDRv0tyjhoH47m8ITQIjsaHCh9dn+4wOd9WFpPfdzV8feXbChXtWq+nfdZ0edn2tUyxIMKIiwY+04ckdcmfIPv2LToT4DyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tff2fBAE; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tff2fBAE"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso288420eec.0
        for <git@vger.kernel.org>; Wed, 06 May 2026 19:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778120194; x=1778724994; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Av2TT0/u5LnPvPDjiziX2ERKe9cNj+uqyKYXNFjszaw=;
        b=Tff2fBAE2pVvyxeVQ1iLFfVPC8f89NFsPnnoFR7GIiX2y7PNWBMQcyB6Kxej8lZXNt
         Ux6JywnXFGEfxoZSHrn6443us/nWKrn76XLRgo/mqT/zrS7Bqe3j1oxRjLShk4ZLGwxu
         tlBLXdQ5jMnTYl0B3WQNxKYdvYAbe7Q7YDDrwLQrxoMUstkVG5ttMfQlCjbFIoYK3LfU
         RkhfsoLaeT/xwf8mMM00gKY7BixaZPcMaX45VREjaMWjGdm0yhAscM0s4PqsqxZ5qgw8
         OTTYn+uarXEcKdKX+SVrRBtEqL5rasML1Iib6Gmj5jegMrOeytKRu120osfIwUdY6INW
         qH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778120194; x=1778724994;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av2TT0/u5LnPvPDjiziX2ERKe9cNj+uqyKYXNFjszaw=;
        b=qh7VanwQ5FsBe6Gv8mZ9MAvN7NOlW00ZTbpzhEHrSx8ivsHzD6+1yGSJnjcoUUyIV7
         oZQt8Pf7akjbF6uaRTzHeynR3jHPLGfbVnUdiCAGL56gjl4fz+5e4Uj1MTMKFq5FHkrx
         aNhAcCDoPrtXWOEZK034PzGcm4uUahLRWCk+jFZEbZKhF2jeYxgdZwzktPYdn4mVOdUl
         7DgaN2/BubTBp6eA828GyOhkyOVb9qfZ7KOZwBXuO6g6BY++CXIp0cwrPCcrR2oJB5wB
         iwnLscKeN60XhTa9sZgaObZjzdSTnwu1TTJXDmET92yhfbtpfuFHuhwdVgGmC7vDMFhC
         lJaw==
X-Gm-Message-State: AOJu0YwqH+Ak+wVqG/dwJ7KaFFHbl+S8oVZpTcWT7Gc/x7WRTC8+/F2Z
	zfGTZSya+S4KmgbHPV/L1T6PY+5dpAPTmU2dXxShQLudbB8ikMQKaRTgEQCJ2FWM
X-Gm-Gg: AeBDieu6UD8m6qYAtZPGwHVSToS+nMmcksjqfk4fQoPMHfujWBfV+lWOf9Kl80F5Tx4
	bSK3PRxbOIGDtIxtigX94jB8cKbbUMnQ75yHnpK9CIp7HGbb8ruvpsEY/Pk/NAtMOBXRM1dUhqD
	XmHZAIJUtPgpu6nEQuyuIgu5H3w0QR7vl3Dcq6qRyU6sPrzWqxLMtMxgrvCPpU/bvHoC/6qzFwM
	1OJHaxVtyQk4psrDSFTxODJdWDhrznIVUmMCL01bin1Z0MfCUMGIGS9VF4NhVrnhP550T9pI8//
	rR6xQDuqAYvVhoOAqYwPOWxLYMWJdWilUlaC+xXrzCe1J2f5E0+TKgads9/F/JisoXmEplQj8+s
	bfqpBtZ3nFVACUgSMkVWDsaR7pd0jRgkDbw+BydZvumkUbxcWwfYZhGz+ApiZTt+gMykdirA66W
	2mXjtSKJVdCbQM3jST3Xk8tMfW5nPyZ6NpxMyW
X-Received: by 2002:a05:7300:bc83:b0:2f0:c593:986a with SMTP id 5a478bee46e88-2f6debcee11mr374990eec.0.1778120193841;
        Wed, 06 May 2026 19:16:33 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.56.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f88f566sm5551997eec.16.2026.05.06.19.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:16:33 -0700 (PDT)
Message-Id: <pull.2291.git.git.1778120192298.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 May 2026 02:16:32 +0000
Subject: [PATCH] config.mak.dev: suppress C11 extension warning for Clang on
 Linux
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
Cc: Shnatu <snatu@google.com>

From: Shnatu <snatu@google.com>

When building Git with Clang on Linux with DEVELOPER=1, the build fails
because Clang treats C11 features used in glibc headers as extensions
and raises errors due to -std=gnu99, -pedantic, and -Werror.

Specifically, glibc's string.h uses _Generic (a C11 feature) in macros
like strchr. When these macros are expanded in Git's C files, Clang
warns about them being C11 extensions.

GCC does not exhibit this behavior because it suppresses pedantic
warnings for macros defined in system headers.

To fix this, add -Wno-c11-extensions to DEVELOPER_CFLAGS when using
Clang, but restrict it to Linux (uname_S == Linux). This suppresses
the warning for glibc headers while keeping the build strict on other
platforms (like macOS) to catch accidental C11 usage in Git's own code.

Signed-off-by: Shnatu <snatu@google.com>
---
    config.mak.dev: suppress C11 extension warning for Clang on Linux

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2291%2Fkiranani%2Fnext-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2291/kiranani/next-2-v1
Pull-Request: https://github.com/git/git/pull/2291

 config.mak.dev | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index c8dcf78779..f1dcf4329a 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -87,6 +87,9 @@ endif
 # The bug was fixed in Apple clang 12.
 #
 ifneq ($(filter clang1,$(COMPILER_FEATURES)),)     # if we are using clang
+ifeq ($(uname_S),Linux)
+DEVELOPER_CFLAGS += -Wno-c11-extensions
+endif
 ifeq ($(uname_S),Darwin)                           # if we are on darwin
 ifeq ($(filter clang12,$(COMPILER_FEATURES)),)     # if version < 12
 DEVELOPER_CFLAGS += -Wno-missing-braces

base-commit: 4f69b47b940100b02630f745a52f9d9850f122b2
-- 
gitgitgadget
