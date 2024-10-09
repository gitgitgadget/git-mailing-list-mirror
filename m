Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74475191461
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474591; cv=none; b=TofPejJbj7dZgHb8QI8s5ZFTOVOgfvqowW5k7sr0De06Fsp41uO6eWhB83OieLyqzdxId8kdKysLjL7D3VDSXut67odBSHhD1jeI/RCQgMIx7HrBYm3tnwST1u0GxshiTAiLiODqMcj+f2Lywu0AAwqCbp2QfpAWEPFIB82tVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474591; c=relaxed/simple;
	bh=HqJ32cBTsNLEgnITG2e0g3JOlEIcwlwSHDWNE0u5msk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=coqzHXRZdtrj52j8t3JLZX5aEB+zwDCYoW2DD9IxD4ecC5Zl8L1ooMP4sn8/wY/i5r7dYwcUmjhyVViov2lcsa99pA3k/yJOz6uUCICo8FW4G3eUuwQ6Mi2xw3n9Hf1oFBI3bigEYi6dYmeVhANwL/jKSeRIYF9VN7ni9LgIWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehazo0Sl; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehazo0Sl"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so89390321fa.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474588; x=1729079388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zN8rzQRh8F/KEwbFnGTOfZGS7MqJiKwF5JtjQMPGqvI=;
        b=ehazo0Sl6StEoHjYPSgOipBTgKo19KcdO0Bwy7Hee6rxPmwNtNMP8hbCsC2KaouajQ
         mZ3cRl59olsLABUWNlJIwtf6D047sgYy+H7ZuW6/acl58yWv8U6VhSOrxL3sGTJttdK4
         O3WYyCLQeC4N0TwtTvfAvGtpFoveLtaDbv7NjNMAFFjdoxp0lYYxH675piyGlnJGLVc8
         eBNx5Lkd6tsOGGDpDtslaKahNaAk7oIhb8AJlHN1gsfz6jUyt9CgSMWOwAcPrBX8f6zQ
         39RLD1t8kgKRjG/snTa6zO4wyuhFho6xUj3CO2pI8uOlqqVxChFv366v5LvfkxKFKtb1
         7+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474588; x=1729079388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN8rzQRh8F/KEwbFnGTOfZGS7MqJiKwF5JtjQMPGqvI=;
        b=HQwb2N5Yd008wntw6jHtRfvlJNeNbNY1haFYczkdthDP//1HMwbBl95cRj1zTw1iHn
         nmUQi22QCtMDbf4Al+vfZYW6GeUMAHqxPNYcUN/BCtF22cVNeQwLI/LUtlaICQMZogAC
         hnrrJhOK0/cWzH7/78mdoheb7EkcUAv2crHup4T4TiRgNGPyYu49iTOkqab/Ocz+Bnrs
         YrlnKaeEUWDt6+I5JM5zCLbmefwf/7LYTDjS78oOQPbNIlJRmxzCvmJCOF0YyxB2Dvj3
         AmzXbD2zxCQLaSYCLM46GPIISMBolDsOxIXS5tmtHIfj64wRW5Wl6F9FcPFqDs/iC/SJ
         B1uA==
X-Gm-Message-State: AOJu0Yzuy3B0prkVBzTdzwqRocjY5Pyic9AXdSMyykgDw+u/aEtjK6M/
	YIGCdMTk9CRSWEBwEzqM4x4vYJWlNlh4GXEM13MRXKr/Tg+eDKk9b7Wsuhpr
X-Google-Smtp-Source: AGHT+IEGk/AIKqYe+3I6qaAHIHtxFW4EBvt3L3LOoy0YQ5Ffxf2kcYAjdj8xyZVfgXY/e+7x9CRYTA==
X-Received: by 2002:a05:6512:3b81:b0:539:a4ef:6765 with SMTP id 2adb3069b0e04-539c488d907mr1780246e87.7.1728474588005;
        Wed, 09 Oct 2024 04:49:48 -0700 (PDT)
Received: from void.void ([141.226.169.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a4ff9f7sm595800566b.26.2024.10.09.04.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:49:47 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 0/7] Fix typos
Date: Wed,  9 Oct 2024 14:49:33 +0300
Message-Id: <20241009114940.520486-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation, comments and messages.

Synced with:
  - e1dc6361a9532f9c7e2f8010615f63a659bd92bc (seen) Merge branch 'ds/path-walk' into seen

Tested:
  - Debian 6.1.106-3 (2024-08-26) x86_64 GNU/Linux

Andrew Kreimer (7):
  compat: fix typos
  contrib: fix typos
  git-gui: Fix typos
  t: fix typos
  t/perf: fix typos
  t/unit-tests: fix typos
  t/helper: fix a typo

 compat/fsmonitor/fsm-listen-win32.c    | 4 ++--
 compat/regex/regexec.c                 | 2 +-
 compat/simple-ipc/ipc-unix-socket.c    | 2 +-
 contrib/completion/git-completion.bash | 4 ++--
 contrib/subtree/git-subtree.sh         | 2 +-
 contrib/subtree/t/t7900-subtree.sh     | 2 +-
 git-gui/lib/status_bar.tcl             | 2 +-
 git-gui/lib/themed.tcl                 | 2 +-
 t/helper/test-rot13-filter.c           | 2 +-
 t/lib-bundle.sh                        | 2 +-
 t/lib-rebase.sh                        | 2 +-
 t/lib-sudo.sh                          | 2 +-
 t/lib-unicode-nfc-nfd.sh               | 2 +-
 t/perf/p7527-builtin-fsmonitor.sh      | 2 +-
 t/perf/perf-lib.sh                     | 4 ++--
 t/unit-tests/t-reftable-basics.c       | 2 +-
 t/unit-tests/t-reftable-merged.c       | 2 +-
 17 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.39.5

