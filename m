Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C11F9AB6
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274448; cv=none; b=ZAib+WdhbxBOlJbKXUvV0+zEuYp0SXEk2RDVAeQDol2l8rJQX/chWBXD6Gt9V8DiC+WisnHThW1hCblKxMYtZYUT2ISEWTI9A3Gml+7GXPM4gsLr7UncMiH2/IxLz0kLJuCtlij36iOFhmq0SnRSX2BUC50jBuPNO5cScx76GBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274448; c=relaxed/simple;
	bh=gJ3xDE/3zfoHByaxQ0BmmfNtR2qb9F6q3PHLWvJge+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lEVskIHL2j6gUPrtGOKoZwQYexcLazB5ZPa4ggH0W2PS/F8f8qogodDU3zbEzKHXxmE0HkQhv84dQAAOmLSiULd3l4oykzVnlGSuG7v0Nx7p34UpaR59LZDU6DmstttJM5POCtWdF2ch+z+qsJ1d3ZiC6s3ZbLzPaqZDSHN2HLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehFZtCmO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehFZtCmO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f2339dcfdso85156405ad.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 03:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739274446; x=1739879246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=445BU1poB5o4pzDsWWFrJXcfDzbXWJ+kh91c0XmiWKA=;
        b=ehFZtCmOQwVXxtWB2pk/QUR1JoxQOsClD+wNg41WDyGkKrEjLprnEdCi5ywCmXfz0w
         Df10uECNL5CQ88ZhhXru/vUvjBbCEi34gB3pydk2EC0NjaLmIFTvh5Hc7baORAf+4+wb
         xVs/ViZCMmIpiy7FEASUx/YKHvm5bfMgrm4PsyoU3i1k2aQWGsZR9r6PhUw0U4jbsyao
         hS2cy9rHVokUfkqRspf5/Fl+rUD9WDeJPGeAEAwJYgjAT61RP9Try9clqC94848PmASA
         ukxO5xKBjdrvXDjwJ7haTkVPyLSlc28wbbQkR/nNWgSEgkZZoOnyZCt2WaffYYGlVhgp
         4EmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739274446; x=1739879246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=445BU1poB5o4pzDsWWFrJXcfDzbXWJ+kh91c0XmiWKA=;
        b=WwxSRZzYF1AfneTi0glLgVbdrNM4YzseZgYsB+z+hR80il4y4dM9URLgqnIHI6e9g5
         u4XONSQxA/jap2eEG5p28hhoxn3M1b8E+G+AysKr1suCHgplEvNaGc3naSu8KPwWGoaU
         5vzIvAAEKp1H0r2MpUqyIuVBcdCKjCLPux5PJaMzsLB9sI4SmHU28xjrCLh5QsGdc3B1
         d+JXElQA/+bdQwtNJ7fxSueagCB3/+rH/TjJbj7HO1Ns42DVeIQwXhZ5zZErM8pzrGS9
         KO7tXCRU1f5b1xqPZllWMuwRwfWLOD7n/AWxK3i35U9yAW+ytbhMGmxz1CLu3cQEySte
         yADA==
X-Gm-Message-State: AOJu0YxSlG0yJQBl8IbNxs3b1L1evdpAmJ0hqhaLs+vlEAPU1nGsCPIk
	z/5VqRcqYVEWhPSsuAok5r7/+JAV1sbtQINVsJyy/w72YqHDmFvTAmM3Ag==
X-Gm-Gg: ASbGnctVtbB5kl1HhfwDIcL+GBdOCAPoMtGEaLThO4j2fSdR3akTvmGZe+7ciHnB0b1
	m7pbByYluV++nQ+U7bqzAcBsswoWPjGp80I1ICp77yAlywPnSRf/r4JPr95D2cI2dHYTbpnXm8u
	SaczoHM7QqoxLOvwD4vxN1TpvINXAfxnTqgkcFIOAQ8s0IcrKOwRfT7bY+/0vQtDyk/9Ut76Nxh
	0TXGNoVihKUIsgJugfDzt4iG91aSlRLM7RjyRn/+9D+zVzzNBFhUcXJx3Ubkx2kM9rWVmqWT8pr
	HJWmL1Fjn1N/0SRErN+KvKDWUTDJ
X-Google-Smtp-Source: AGHT+IGQe1vF5YFbXb9zNDPt+CchrR5F7Axkh9zehCHSV/fSXrKFUR2cSuqJn1nFU5N8fkunZoIsJA==
X-Received: by 2002:a17:903:22cd:b0:21a:7e04:7021 with SMTP id d9443c01a7336-21fb6f34436mr48204605ad.24.1739274445859;
        Tue, 11 Feb 2025 03:47:25 -0800 (PST)
Received: from localhost.localdomain ([171.60.229.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653afb6sm95279915ad.53.2025.02.11.03.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 03:47:25 -0800 (PST)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>
Subject: [PATCH 0/1] [GSOC 2025] [Newbie] userdiff: add built-in pattern for shell scripts
Date: Tue, 11 Feb 2025 17:16:09 +0530
Message-ID: <20250211114611.9334-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds a built-in userdiff pattern for shell scripts, allowing Git to recognize function names in shell scripts when displaying diffs.
This change defines a regular expression for detecting shell functions.

Moumita (1):
  Added built in function recognition for shell

 userdiff.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.48.0

