Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2343634E
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380779; cv=none; b=kv7ROeFsb0Qpk063t1M0zicoLTGcypqEwOCbBSYjR/anSWfRbFp6cK033ZEeYaquImVQ39K2SpUlWD1Mcj0Gc+sVsfjtWkOoEZgM1VOfVubd7l9KSIGjrPRvR63a7sKUsOA9o0H2GPLVg2os/XSqdnC2Rxq7HjgHzuNwMjM0NBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380779; c=relaxed/simple;
	bh=sx5SnQg4BS6zPrSf8j12JL/vMJ2DMCZ1XyDTs9Dh56A=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Cjx4dxqT8DjlG4jMVIR8sAIZy4VPoSYC2mttWgBcZnq/xYe/rSoWSo9ADm9yOJmvqXvYJjaQrweatXR4dLIrbPJZXnQVph+zPePz5J2mTECEG2cujtRqMQiSq5eQrjCE4BVaLaP9sdrlw3/NhxSUkR6nOQ2y3r8D18EqHY1TBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELOqPVbn; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELOqPVbn"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65005a8840dso9650634d50.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380770; x=1777985570; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qxbzli8597jHvE9YhwQU28K732wiuXB3xCRm7nAOtaU=;
        b=ELOqPVbnHGlm66fWs+AMx+okdHIvVSLBT2BgymzeaGh9ac0dUkYZyGSdlnHX3vMt+2
         LMThHPyLsOrZMGROibMJCWUmLMs6GHxYI4jtERPSt07D5iHGDz2UXq2HfF7mOF+GJ0UO
         Zts+KV+ZdTMnhexSQgnxstLff6NJ3K+qekJ1Pkp+Xh6ouOgeMzbYjy2bofbFn6L2S1Y4
         tM13g/E5K6XPs5Iy9OT0NeBu3G1TrBRR8sIaP7fCoqX9S/iMk/ZyS+mB+51j/dpODPQK
         8VmKRMvFCZ5NJYxE1Y6xu854ANJAwRZW3rnoriH/laO5CIl0HZWSJDK+RkHhqsFPgQBV
         WR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380770; x=1777985570;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxbzli8597jHvE9YhwQU28K732wiuXB3xCRm7nAOtaU=;
        b=ghs4EHnpp9RhVgrgt7DwYOdEs9GGVvEUf9f+shJIn4bGi91AbchU+1DQ1WUO1OL/bi
         FW3Vm7wEQL5Dmr2pjs4YC91NcNHpwIKtwKORUix0L/dkeKMzy/xqFFxgF/FvBh3OpNvL
         USaFE03BMVJM2GdFchPXPxH8j1hDWal4WglMzSBTryqtEgRbqBGCuKwPZwgax8gYW6Q+
         4auMQ6TU4EgvAdN5LHZy0vMNY/9NzDvmrvR+Q29aOqsEhCnmNWeqYGgNSRS9sWPw6lDe
         lF4tK15xT69IxKjX4GMDLxvEjSeGUvFjlYXAhKOdwKBCOkKSJ0PGoX3ek+3hS5JqaWdE
         nEoQ==
X-Gm-Message-State: AOJu0Yz4hMKADjEPxOl/EhUa27tOLTa+8Ygk99Cbc1Ib+YpyaJjvebmL
	XwlQ+fpkAnj9zkCm+ycyTTehXpbo6128Wy/ZZBD6yNhXYb7H1S43XmWlhL6/Og==
X-Gm-Gg: AeBDievBrOHnrjhc8/vWLmdDXJ0GMsqu3Mq7hqOu3lvuKu6ZszNDyL1WGDCc0EcsubI
	lbSZQs0PLiC++6sj/EBcK2nIGSJrGJsJu1QSVAovcdWN4EaSicAi0jtohsVrGn+DNYWJsL6fz4T
	NDdAr9/VKLwBoNsOd42N/ISfwalmF5Ezbnt0l6OSF7I7OUHcBPaiphFYekt3UVF1Pz8zSu9Ks4G
	+kK3Gvkp34Q230Mukdnm22Z0qTmlpcfFBnEv1L7HwD6lLpygRGF3QDZ2F8CdEnVlUEw21+2sRyh
	orZoG/Z3xSMB968328pk8+VkHrppQfUVz4Qf+HVYoSvRnWyIahOQ9RbaPq5pceyapEfLp8pcPAI
	VWCEhTNzhux4kvBCswDp3363KqFwcWbaN+IEJUInYXQxkR+mEigHX6FckB+RldUiEfJlpn2XL+k
	i7GWPgX9h+lSqsPeRlbKERlrYGGJ2Hz11rp1Vp9zUm+9Q1rF3C
X-Received: by 2002:a53:ef0c:0:b0:651:be37:f5a9 with SMTP id 956f58d0204a3-65beeed58b4mr1832399d50.63.1777380770244;
        Tue, 28 Apr 2026 05:52:50 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.185])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bee4a6a1dsm1607856d50.20.2026.04.28.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:52:49 -0700 (PDT)
Message-Id: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 12:52:46 +0000
Subject: [PATCH 0/2] maintenance(geometric): avoid deadlocks on Windows 10
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

On Windows, maintenance_task_geometric_repack() opens pack index files via
pack_geometry_init() (which mmap()s the .idx files), then spawns git repack
as a child process without setting child.odb_to_close. The parent's mmap()s
prevent the child from deleting old .idx files.

On Windows 10 builds before the POSIX delete semantics change (between Build
17134.1304 and 18363.657, see https://stackoverflow.com/a/60512798), this
results in Unlink of file '.git/objects/pack/pack-<hash>.idx' failed. Should
I try again? during fetch-triggered auto-maintenance with the geometric
strategy.

The fix adds the missing child.odb_to_close = the_repository->objects line,
matching all other maintenance tasks.

The first commit introduces a GIT_TEST_LEGACY_DELETE environment variable to
simulate legacy (pre-POSIX) delete semantics on modern Windows, so the
regression test can verify the fix even on Windows 11.

This fixes https://github.com/git-for-windows/git/issues/6210.

Johannes Schindelin (2):
  mingw: optionally use legacy (non-POSIX) delete semantics
  maintenance(geometric): do release the `.idx` files before repacking

 builtin/gc.c           |  1 +
 compat/mingw.c         | 47 ++++++++++++++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh | 22 +++++++++++++++++++-
 3 files changed, 67 insertions(+), 3 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2103%2Fdscho%2Favoid-deadlocks-in-geometric-repacking-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2103/dscho/avoid-deadlocks-in-geometric-repacking-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2103
-- 
gitgitgadget
