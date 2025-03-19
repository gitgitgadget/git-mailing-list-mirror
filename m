Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FE35942
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404825; cv=none; b=e/Eg0CeAVsEEtmcguwub/qLVXVOCwDkykrhjON6hfSfb+Pt5SyZvjazenYPVdTnjKpslw0yGswdZUAhFQNfAWe7uj9mvMTzy4e2fmfF3WQTwGutga6bptnoUgXSTE1wjAAcn+gacVzx1Ez8I+JD/D/PwW6YwK6LYdhpUC1zaK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404825; c=relaxed/simple;
	bh=YSIgcI//p1WnK5Ht7jwug6NFcsqqM73bAQa7/HLaL0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gWmttGQdytLoMfyxV60+A7wL0uvhhHrihYZyZi6mG+kJrEiC64iVcYyJu8cMMd2CvHjtNPPMRZ556kzhBMZ6m9BC//LGsLNqs6NxG2gxum2/Qwb98E06SacqTnaGsm8NaIW5qqAXstFPePstgab4wjq6oEdGBk/zSMR/hmdjpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+aZSe2j; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+aZSe2j"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224019ad9edso31531505ad.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742404823; x=1743009623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLOA7ONJ2yJxgf2J8SkEyzxA6fDWd/Zb6SLFp6eku2E=;
        b=R+aZSe2j5Rh0PgXJJXP+CKTguemoqFEhyUmJpz7ZykELzCzKfECsrO/gpUFaVJvQ2c
         nWHVMD3BCts91MWBc3S2v2bSIB9EWT1eJljQViDGglPm2qSzIei4LtK+uRrDd7m77i+A
         FLcbLErJm2/aKj4cxX7dioHRJTGXqBK0UACHmw0PtRywF1yZhnieZOnkvEcq2GNHsX8U
         5GTzSuHNpsGCr/rNfwnWKzYT4zhALmDrjz5TKLUhQdahd6r9jR2Utemf/mz0nPxfbWUh
         3IvaYghQfvNXsWly9bA0nZ9uM76rPz3T7EeO696riOx6sIRz9nsaTsDfOtV6FFwL2BhX
         MJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404823; x=1743009623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLOA7ONJ2yJxgf2J8SkEyzxA6fDWd/Zb6SLFp6eku2E=;
        b=YCwW2oZsnCCSJ+N/FPSeTxQrZ8YD3UyRekJwWXxSoaHP8/mx5K12HGIi5see//7KsX
         cVM+LFRrUeDipL0AHvueVX0zmB/P6O85YBGvAEG7IoW5NkWhYe1/FrXivkRCLi6zWaoA
         orUK9DpI7vGWshh23//0aSTXoYGW5Zs8a7V+kksfYzrB9bO9uoQ448ueatlukqXR3caX
         kdVG6OIbHqK6QNgXBjmwKwzdMWCCsb6qlRGKoAQzYqAp9+oAlcAO5hvitcUys+ZS9tLI
         YMjjwznhLYPyonT5lY3e53k2RcBomD3PnGsMoABLuczi3FIbika7h2TCIKfoT53zlrG3
         EMAw==
X-Gm-Message-State: AOJu0YxjOm69ElF4nfdtphFDc9azjUrS21DVZrdamPzeCVozgt0lhEQ+
	cVA1pEYoDlbBloJ3G6E/rWHYYB9H4ZCbchLtepkntiPogQ4lZ8CVCibuqw==
X-Gm-Gg: ASbGncu/6jA/Yf2OBdnvAkquQdCdVk1lkYjL7Z7FFyHdZzxl3QM3adzE93UDAauy075
	13t5pvDDKIvGvohrxv4SCfel6MOOMhfmo7hwGkcBHTlBmZpCT8rhKRRqIPJhY/J0P8Wpenoc/0k
	gCRFq37wr78UziPfU2xDAB2ZTDx254W19Ko1+pgCPw/F3BIAvfORSzNKeNBf+Sfdquywm3lh98j
	aXZ9tnIhyHY7Oo+CgMpENL3YNuKg/lM8f/NAgGbGCnN27lSsgYlJ3oI5YQHwKEIJ5wQg9D2Ssh/
	dN7jil0lZpRY5MMFOUkBgJzrVcWJTOJIFjmoRgStgFSD7i5jBhxnzNn4S9i0hz349BAghZW8rSI
	=
X-Google-Smtp-Source: AGHT+IFzWw+qOrRTKxXqCQu5vSDdAmSh65GlJUxrXgFFy5M648wUVnZ9zPG46J2FSqgNk1Xxm3sE0g==
X-Received: by 2002:a17:903:2301:b0:224:76f:9e44 with SMTP id d9443c01a7336-22649828e20mr41505865ad.8.1742404822803;
        Wed, 19 Mar 2025 10:20:22 -0700 (PDT)
Received: from localhost.localdomain ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd3c59sm117240305ad.218.2025.03.19.10.20.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 10:20:22 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH 0/2] add userdiff driver for gitconfig
Date: Wed, 19 Mar 2025 14:20:14 -0300
Message-Id: <20250319172016.2115-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Here's a simple patch, adding a userdiff driver for gitconfig files. This can be
useful for people who use Git for versioning configuration files, like a
dotfiles repository.

This patchset also includes tests for it.

Lucas Seiki Oshiro (2):
  userdiff: add builtin driver for gitconfig syntax
  t4018: add tests for gitconfig in userdiff

 t/t4018/gitconfig-section             | 5 +++++
 t/t4018/gitconfig-section-noindent    | 5 +++++
 t/t4018/gitconfig-subsection          | 7 +++++++
 t/t4018/gitconfig-subsection-noindent | 7 +++++++
 userdiff.c                            | 4 ++++
 5 files changed, 28 insertions(+)
 create mode 100644 t/t4018/gitconfig-section
 create mode 100644 t/t4018/gitconfig-section-noindent
 create mode 100644 t/t4018/gitconfig-subsection
 create mode 100644 t/t4018/gitconfig-subsection-noindent

-- 
2.39.5 (Apple Git-154)

