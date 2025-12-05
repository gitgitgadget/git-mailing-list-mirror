Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942F325720
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946966; cv=none; b=m0XmrqFRqdn30ywfyHZDu7wFFzEJrVrK963psuEAMt9mRVLX7MSBugxknnaIjPBy6gaDaRL2tekELYdtxF9vpAt2XV4YuNd5rQBpELRL60Wi1Y2QSqCGOaRNx62gKJUhD5KtDIN75ELxi38A17V19qpB/RWeB7KlwpDDOfhnTtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946966; c=relaxed/simple;
	bh=O6EElKeKhS/+ysBMW1WfpuWyFSwKhNdEdQuMPUOF9X8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ekY7WDOPqh/VWW1DV2DNx3JCorVg564HAxXDhnO+9cUf7DwUnvEe7vMqOn7fCeiqZE0Aj4s76cLR6Vkkhqd2b+vpyV7l/LXdmDwhdAUbgz0EBcnJteBc9vvSEmPtWGNeLdWWCaEb8/ScnYfYf5raX1aJm3uhUuzs63TT1zkPUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST7pYf/C; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST7pYf/C"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2da83f721so238244985a.1
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946960; x=1765551760; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v95A+ZphT0efPuJgA2huEtwXQ34whmACedkSr3ysbY=;
        b=ST7pYf/CEGXuFWf7f9dxQYOnD9QqobEyW/ZrrJ6EgtMiIBwKuvB4wmZAppHE0/Ef2f
         WOzFB1G09Bw/r8UEb70QPty1iaU/rkcGrPKLpBoeyVIvydjRHmDhXLjZHXWTi9fW5Tpf
         U4LpTRz2wjAUVCMkhGFGkHqFjRV0e+Ug5wzDbbZfcm3oX9vU0NHPMUm2FYUQTzv5+t8u
         r3UU7rQ8QpfxISy0b1FD+W4e1w5/eCGs5MZueFecad6LH5k4RBsxB1CO6fSTuOU+OymL
         hmxB2R6UEFll78KHRatS7evb6cE/VqLYkckdI0g9B2ljYBVlgC5yBXALkppGagSodttV
         2+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946960; x=1765551760;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1v95A+ZphT0efPuJgA2huEtwXQ34whmACedkSr3ysbY=;
        b=MDUxm80jrArP2dVDg/mMwE/2UL4OPe++UPXeS1lyMlAwqSAq2hTiPArbx4L6aFAqlg
         aPd6b6R7n2SqCbJqiTlzWW5FeP7mUlyI1QgidIQp8YebZIy0frgDMaOqOmsA/vb4oLdl
         FZi0PL9NB2m9IrAz95yxw/11XjgbVLD5H6YW7r3XnA+aA4OHn4GpUIlrSgM5afE+gj1B
         QOxDSSQMxjQRU3idj3cUYHBW4oBo+l6SaM9aB3SGXEIFaPIVXYq9BlMpF1zX7bYzOmsX
         jn/dWNsck1p4amYrnsnTt0uS9Kr9ZNzOFpfkS30oTcixad+bAsYHHBEtOBHpfnT7sk3Q
         JYPQ==
X-Gm-Message-State: AOJu0YziQiqkUl/BUaOq3irwxpCI4XZqr8UG3kcHvf+NoMxnf5F1IcLO
	r5C6QsUmHuYdYhqC8qH8NY8g5dlnSO3300kc4w+ldndvb0U4O2K0Y6NwiWPLpA==
X-Gm-Gg: ASbGncuxwDKGDZMja8bOe3BHaVCDbs3zbyt1d7Uyu98w7S21qOi9AlrBEzYQS8c/OH7
	JUDtYi+ZhzNzywkFkivCAdSGmEhOJHjoe57gTgEXVDkqJ3hD1WdvNhitfQI51Uzqt9ovRjlCmKW
	KwbWQPk4yQxiPE8IcqFsNzXW46ar0H+Y3cwCAT9n0oHaqaEx6U8mIgJ0wgPt/SgGL5+j4VCCCHV
	XPj2Mstp7Mi48/EKjHONT/UwsvdRjLQpjRVrBddKCquKcZCq0meW+eEUXhED0zOn81nSq5A+Zl7
	s2h17cA2PxDRqHfxJrRWaE3WGMSrN4P4VTnjBAhRxC3XQh1GUr3eg3h9N/dfzgrVclGSsUl7k/4
	zny4zhHHblO3sYbDrPCvEgBm6gi48+uqkGMnYjhEAerU5PD6HLzVXGHECkP924KMRWGqAIboRrH
	r7qK8/eTxJ9OWH
X-Google-Smtp-Source: AGHT+IHMgQLwAkcJ6Bi//ujvylPQUw5iXeyw7tKttYYhVoaQBbG4Ker7GaH6DEKWC/Y4cFUdlcs7UA==
X-Received: by 2002:a05:620a:4092:b0:8b5:a07b:3c66 with SMTP id af79cd13be357-8b614858dd6mr969553085a.21.1764946959757;
        Fri, 05 Dec 2025 07:02:39 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b62529f08asm404501485a.11.2025.12.05.07.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:39 -0800 (PST)
Message-Id: <1619ea4a3b0767e6879f41bff6430512b3e8fcbf.1764946945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:23 +0000
Subject: [PATCH v2 08/10] t1305: skip symlink tests that do not apply to
 Windows
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In Git for Windows, the gitdir is canonicalized so that even when the
gitdir is specified via a symbolic link, the `gitdir:` conditional
include will only match the real directory path.

Unfortunately, t1305 codifies a different behavior in two test cases,
which are hereby skipped on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1305-config-include.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 8ff2b0c232..6e51f892f3 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -286,7 +286,7 @@ test_expect_success SYMLINKS 'conditional include, relative path with symlinks'
 	)
 '
 
-test_expect_success SYMLINKS 'conditional include, gitdir matching symlink' '
+test_expect_success SYMLINKS,!MINGW 'conditional include, gitdir matching symlink' '
 	ln -s foo bar &&
 	(
 		cd bar &&
@@ -298,7 +298,7 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink' '
 	)
 '
 
-test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icase' '
+test_expect_success SYMLINKS,!MINGW 'conditional include, gitdir matching symlink, icase' '
 	(
 		cd bar &&
 		echo "[includeIf \"gitdir/i:BAR/\"]path=bar8" >>.git/config &&
-- 
gitgitgadget

