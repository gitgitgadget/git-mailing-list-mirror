Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9613863A9
	for <git@vger.kernel.org>; Wed,  7 May 2025 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585208; cv=none; b=RLK0PjxBt7whvjZUkwbjxFt1ADVuWfcVpt6HMnImMGKa3fi1v//U5KOk1bdCjCavnFyhp7Qu6iANENOxJ02VIZBW1H0geUsFHmgnfllLip7bBa3dxFpVgLFyZo42AfFahq+4i2WSsP6xHOgz9CORrew5Gl/ukuvhJPdJxLsEgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585208; c=relaxed/simple;
	bh=eoqty9NyQ/HfQgyhjlMler+GTrJVMGj1K1fluamDyn8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ag9TMV/MMKbSuE2GyWa5MtP5ZAaGUk49ZQVEKQeKnevByJXcFfYSo55i9/a4yGwv7GWM5V4vQ7VLDlWneXBAFWnCGObHchN6ftk7v3d41gxdBp6Xo1n5hQ3YWPrX4i1R21PUsARXbBNQekbPx1lSOnR7dSPUqQA50hXvX9dhquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVu1lZrH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVu1lZrH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so55774515e9.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 19:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746585204; x=1747190004; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KigjYxVubOHCWu4YMnODkW+yHc7+NdIO2e9r5kSWlvc=;
        b=nVu1lZrHgz292HYPfAZLfbx7YUiJGsXO0Xvr8K5qMo/NC9aCbrJVh4gd3sGmr0JBAY
         gZmuN5u6w/mvaYx+sOqmT+9tJWeqeec9nECnpv1xx8SpODAw0MfpbEtTNLCRmKsOEVoy
         XmiFPj2Mpo5sZmjiKdGHE30yEpfrERxg78rcD8ehCcuAW7BhF2WYc/apF+DfxWT89GYu
         90A12/yhBWqYbCA49LroX4Syr/UvxpFjuisuaF2R8XU+Ph7gx5IeFl/MeNhemAYq8Ky7
         7ySeLw3/LFelbHG0WAznfty6U3lfQytiGq1+t4Ue6h5/m1OAkaep5+COiBWZfRsUcE9y
         WMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746585204; x=1747190004;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KigjYxVubOHCWu4YMnODkW+yHc7+NdIO2e9r5kSWlvc=;
        b=d5aTitctdpcqH/TQE57rDC8bKjahg/+tqPtF7e6iL4WwXbbrOjZJYCD5G0L87UEXJa
         BxykdR/1jJo9nvRuCkEmNjnJIZ+tfgpakRJSDER5UJ2HyD01tKE0oDgn+OF299T7dsUe
         HXHpYnBXVnkBBShQiXEjVq4JgEmh77ECia/ybhFawDIwUD4WrEVciRnib1O9OPCiNy5l
         wh5yOhI6ips5uOq/DGHfKYlSWgLNJ3DO7wIe+mLzr2xVHJoK3pmYVHDeWVN29YQrQUJC
         3xaVB3+tiekGtBlY0e/3cxUrciodMbnXR9du3ZWX3FrcGuumxKk1+kqqmmDGaVMKw4AG
         4znw==
X-Gm-Message-State: AOJu0YyOsvbctWyWiZIKddjBpcGlVpElG77xMkI/PX877MQY1SuQ/kat
	5G3NeTccA3YJF1Ob5G4NSNQ2nOTY91PSfJ3D41Gb+tIgdLYd6wQr3jZRNA==
X-Gm-Gg: ASbGncsJeFfNcw/HZwiNpMLpEoz7bORDtXJV1tlX0h9M3BcS5LRUZLBkianzRvdB9/r
	4WriYQd9nYUQdGJZlw6enbmotxHJ+eyCoCsL6uncTzRXgnwGcUEcIqHUpaB1RJa8SXMNpW1LeEn
	tEQJmBaxPtqrvfzK7lyREgSBurru4TJ84gG3ifuiC6CEWkGMKu3Dxtyysjqsb6RcPaKG34e/SDS
	f4l/3gJ+QwW9sDnq9tQ68Hu4fYEz25FTOcibsUaq8fVXXQvkMbwAxDE9OICsyFZ8QBX3TaeYl/M
	WWgYThOxDJjXf5gwn7YV7Qh7dz/wHnaWy63oHe+Erg==
X-Google-Smtp-Source: AGHT+IGOSa0cFmuKUZu4/g0PNXE3DLTgwhiXr8qg1k7vqSptXrwlUag5Ctc5uhari/b7244SRLp2jw==
X-Received: by 2002:a05:600c:4503:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-441d44d8b4cmr7147395e9.33.1746585204319;
        Tue, 06 May 2025 19:33:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0af3255afsm3514547f8f.66.2025.05.06.19.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 19:33:24 -0700 (PDT)
Message-Id: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 02:33:20 +0000
Subject: [PATCH 0/3] fix xstrdup leak in parse_short_opt
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>

Pass a usered defined strdup-like function a parse_opt_ctx to avoid memory
leak.

Lidong Yan (3):
  fix xstrdup leak in parse_short_opt
  fix: replace bug where int was incorrectly used as bool
  fix: use strvec_push_wrapper to prevent ubsan failure

 Makefile                             |  1 +
 parse-options.c                      | 23 ++++++++++++++-
 parse-options.h                      | 12 ++++++++
 t/helper/meson.build                 |  1 +
 t/helper/test-free-unknown-options.c | 42 ++++++++++++++++++++++++++++
 t/helper/test-tool.c                 |  1 +
 t/helper/test-tool.h                 |  1 +
 t/t0040-parse-options.sh             | 14 ++++++++++
 8 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-free-unknown-options.c


base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1954%2Fbrandb97%2Ffix-parse-option-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1954/brandb97/fix-parse-option-leak-v1
Pull-Request: https://github.com/git/git/pull/1954
-- 
gitgitgadget
