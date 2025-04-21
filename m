Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23013B640
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239155; cv=none; b=aXJEVfmmm26QSUUoVnNXIOzwZKbDioSKZ4Ie0OblB1SbvsrM+7irB8we4xJBrqou727S+IzNYnhzcKAZOsOtTK/yklF/vJmtk7oIM6lynNK6z5NC6evv29lco6TH1L2hRdyi4l4NFVq5YO6gVMdEKz9C69rZ32YnIIHyIySlvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239155; c=relaxed/simple;
	bh=P8tH4T/THV63Fvozs6qq7BzlRl2Ki60+9TtD8s4FzyU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GJzwKcowd2cjwjMT07jSmxyJGRH0T6Y4XYnWhHUFOv/P4MdrJB7xLBgIt5eTg45onI/1sjPryW54TGIWGTC739czSQVk1HwR13cidzBuc7eYlvsAzXxlsPY/WPDMj3liHmTXcGb31Yt1Me1mIrR1KuJ752qWxlbpNlSw9zuHUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y14uuFDe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y14uuFDe"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso2696493f8f.2
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239152; x=1745843952; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RWoLuB2IgG7PfwZF9JbHBYHkl5WfLCgh5JYtuL8Zl+k=;
        b=Y14uuFDe9pgWbZoYtn9mmKyoHE/AOJV+BVTqKMn/eoLNlgDxHDxh9H2WtS7FY2GTDl
         EA6WXo+Bfgs/quGsDLazvekDwfO+ET91KjFvqeSYx8CRvRqG1QWXWT0tXPxaA8ZL7qI5
         xg12QBAGdeGKAWMYgH7YmEOlprSiVsFQTQZYbAZy7TW975itPSniFjykSgraytjsepNR
         u8i9etjVQOCPd8GnMhnOb0DZnRER1JS0EORILGnRRaEODCF7XiQE3uF2VxSIcicIDP6k
         Z19+pXMLsqDKtSTH1QjcHhmsKuX33bZeVAXylx9YLm0sjAql9ki0CePPH36bV42v1Hhp
         yMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239152; x=1745843952;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWoLuB2IgG7PfwZF9JbHBYHkl5WfLCgh5JYtuL8Zl+k=;
        b=RjdPdjjAl02c6EjxG6CF7LVqZ3mNCOOO2fwdDW89n03NQue1Q7hy/OkY4uBFKJvpTc
         sBrTJSy3meMz+AkmUUJZIYPFglKKegb1SDLxAF75tgq1TlJCdNu+4dD1/Mf/RjBnlvoR
         +xyRPKhB76RfESeVRh9e689sTF5URjLZrgGFmdRoLeyl1d7h4bMuq7QpQKDaqxGSA8+8
         Z0j5lgNY3eLphFXyFkidUMhSyqxdsvstAqVoV9V/jF25fHXE3r/NawPQaTBcQawaJxeJ
         et6exbsBGGiZsMkaz4SyY1qolht0NzrK/JWhCF13V6K/5Lme9vot3WgQZaZcdkt9taE3
         UDIg==
X-Gm-Message-State: AOJu0YwHGDEPy9Aj4cmGwIfkAVX2VIhVuYkqeSoVF0sh1qcRoUxYI8Ev
	WL5BeXUmOZewgQ8Mx2S6vV3aVwbdITCSEsxmH3RdshzP8Dy7Ilq5UMGsOA==
X-Gm-Gg: ASbGncstvDhaKmGGo0nY8IQW67deXYoXh1UrxZm4ePnWv4AbCxnLl5KhqzxU/taFzUJ
	wXQhH1N5GE2oq72UIiypG6NZfyOj28+qJiUL1CI9xuMLLbDZxp6J9VB/xNWTiuhnmXO5ISdn0l3
	mCGwyc07msL+hz5mNLls698T301X8k8sbjPhF3mOynrEKB/9IVgxPhMNE8VEnYrTgvouQ8lfb/p
	CnTvAJokun/xWdN8PRVt1vloeiyshW/9f9U+MLTtdlg6Ce3QsPuvpB1Qvl5/izDSeXm74GF8sp2
	9zEKK61bB6GD3ajoVGKgBKbdxJ6bz7o91aV/ih+TQI2DR0vAc2em
X-Google-Smtp-Source: AGHT+IHFM8eHw4YZQJwtrpI+gE0QFtZBznONo1k5SEtron575SOvtRxzF9ZM3Y7oGdyf0DEJbPBvEA==
X-Received: by 2002:a05:6000:144a:b0:391:454:5eb8 with SMTP id ffacd0b85a97d-39efbb0555fmr9304127f8f.48.1745239151691;
        Mon, 21 Apr 2025 05:39:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa433170sm11602121f8f.25.2025.04.21.05.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:39:11 -0700 (PDT)
Message-Id: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Apr 2025 12:39:04 +0000
Subject: [PATCH 0/6] Support Windows/ARM64
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows has started building artifacts for Windows/ARM64 since
v2.47.1 (November 25th 2024). Now that Windows/ARM64 GitHub Action runners
are available in public preview
[https://github.blog/changelog/2025-04-14-windows-arm64-hosted-runners-now-available-in-public-preview/]
at long last, it is high time to upstream the minimal set of patches to
build Git on Windows/ARM64 and pass the test suite.

Dennis Ameling (2):
  bswap.h: add support for built-in bswap functions
  config.mak.uname: add support for clangarm64

Johannes Schindelin (4):
  mingw: do not use nedmalloc on Windows/ARM64
  msvc: do handle builds on Windows/ARM64
  mingw(arm64): do move the `/etc/git*` location
  max_tree_depth: lower it for clangarm64 on Windows

 compat/bswap.h   | 14 +++++++++++++-
 config.mak.uname | 18 ++++++++++++++----
 environment.c    | 12 ++++++++++++
 3 files changed, 39 insertions(+), 5 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1904%2Fdscho%2Fsupport-clangarm64-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1904/dscho/support-clangarm64-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1904
-- 
gitgitgadget
