Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1827C16A
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774127; cv=none; b=nXwRBewsHN1PsP0pRkCrajSHupZ+YtpOnhZ+hsQi0zGuyFNcmTifrj3xi2h6es05hIihtdxkx1lH55lWNECO3y3tCPXqYRoYq7lzofkaQNoXE4Qt++Z5LCj54PWnQ2zuUmozFpplGVlaWJ8t+XHXHCheP3nJaV5SjL9qemJditI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774127; c=relaxed/simple;
	bh=f/kM1bwR6x9BPg5lDI53U0htkBdrGL2HIGZZkqhlJxc=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=sj4WQqsUwI9PKmQvKjlK916GtMozsKE6azPHjQQOxoHPNo2KzzMurIGBbE/VjduBHsgeRfhBItYscBkk/V93rdFT4el0Sbt8qjRtYK6rfukuPTzdfLlIpYdZFAJec8cgK4ANb0TMnPqwfixsSLL9TEiT89vRHOm/9tSc8oMDZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAXwdYrs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAXwdYrs"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so3711455e9.0
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750774124; x=1751378924; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=99ras8lPZeyNCMtbGgaI824rpkSKXkMTVRFtum/m/a4=;
        b=TAXwdYrsNrnQePf0R8LlyYqDzLXTPdtOSUvmm4EDpbfX7Ajns9+1NSK3bH0bPMTKE5
         90RB7PW4JNCVniVL199FpQ5QCXI5DnA2ZvIhWNq1TbGX7aZcbYryCOqG0VB0seKDAlrq
         Zv1UUldRwqDixmA9Q3pAwY5/9I6VMrg4xBXnxqia95V9oU6rdpyz+IKLa8Uuf29jJkGf
         ljSXGQlr/ad6+RhfiPxc7M1inokS2t1rPR0OujjfHLTao1+3yV/TwLM3JdeVKxxaFIoD
         XNN5fps9L1Wab5dEaiH1pw+CUGal7Bcl8JESaal7PsWdS11I3O1Axim/A/fAO6BJd+pQ
         VjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750774124; x=1751378924;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99ras8lPZeyNCMtbGgaI824rpkSKXkMTVRFtum/m/a4=;
        b=tx6kqDbPhvoHEIiQbrYCCBAe3HL+cjn7sAUIqtqHRSfIIIwCN4GKFjfEwwroATLaV2
         lsUaK8BcE6aUCdZa5PjLayX5jZyb/NXTY+MU3i3aLq7vqQitvSMgRi9QmhciT6f+spKq
         9XoXazhWdt0JV7VjfRSaGngQx/1zyfGOkTPH2qjvhd00dQwVB9v+KHGWtIGf5ohv9LQJ
         +FfEPPk9wiUWMxxrS+id5nDs4rElQXsgINOQAgPRw4gSCK9tzxweFIb64n12ZqWq33Rx
         19zSsLGfejo3KlGNG+njP73Lbd5f3kLKpVoznQeR+xWQQTMCJpqlD1GjQJHx6YJgrLu0
         pZcw==
X-Gm-Message-State: AOJu0YxFjJDel5xlrPbJ0VQ/arV1/SCKMEcTC7TqbtpxYaPPPEUtCipz
	UrtF3T/NbsOwHlZEkeD5fYCvZlvywZ7KDSHjF690hnWmzRTbPH+zV9g8/V/CZw==
X-Gm-Gg: ASbGncvuVfVDvVWcipK+I8h3/3OazAWP885mCdD2o35xm/OeS5+8wkMjAMnx7g+YvLJ
	mHVfX3Y7CDDHn7fDifqryB8r1Uv39eCBntLdkMiLp6LX8QJs///ofuYluHn5zn8AZsBLzAWPUbx
	BsH2+NJviPspMCsJbj9Rp/S2XZDR6uGc3k/RT8AQkyngZxU/d7GuV+hOSYM0F86PWf4cJX/0Kvf
	kZJXEEZyXRBKVeM3PS1MZlPDIxm1J2M4Aaer0+H7R2dNmAdC3ri/+YEtU3WgD1BWdiZtpawuPeG
	XNyhpVs5Tbt6L9xqEmtea0gMYyrb80tWB74qsKlF7LM7eS3kIjrNG+yHxvgY3NA=
X-Google-Smtp-Source: AGHT+IFpsxRPrVNrXU7LRQOo7y3T+JeT5NyGJ/ABwqdgI+T8sF3+eBLHqN/4ehaeK2LbGkCFt3+y6g==
X-Received: by 2002:a05:600c:4fc1:b0:450:d614:cb with SMTP id 5b1f17b1804b1-453659c3bafmr141653965e9.33.1750774123415;
        Tue, 24 Jun 2025 07:08:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97b501sm174734835e9.2.2025.06.24.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:08:42 -0700 (PDT)
Message-Id: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
From: "Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Jun 2025 14:08:39 +0000
Subject: [PATCH 0/3] daemon: explicitly allow EINTR during poll()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>

This series addresses and ambiguity that is at least visible in OpenBSD,
where zombie proceses would only be cleared after a new connection is
received.

The underlying problem is that when this code was originally introduced,
SA_RESTART was not widely implemented, and the signal() call usually
implemented SysV like semantics, at least until it started being
reimplemented by calling sigaction() internally.

The main change is implemented in the third patch, but the changes to
prepare for it that were done in the second patch, also solve a know crasher
in AIX.

Carlo Marcelo Arenas Belón (3):
  compat/posix.h: track SA_RESTART fallback
  daemon: use sigaction() to install child_handler()
  daemon: explicitly allow EINTR during poll()

 Makefile         |  6 ++++++
 compat/posix.h   |  7 +++++++
 config.mak.uname |  7 ++++---
 configure.ac     |  5 +++++
 daemon.c         | 30 +++++++++++++++++++++++++-----
 meson.build      |  1 +
 6 files changed, 48 insertions(+), 8 deletions(-)


base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2002%2Fcarenas%2Fsiginterrupt-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2002/carenas/siginterrupt-v1
Pull-Request: https://github.com/git/git/pull/2002
-- 
gitgitgadget
