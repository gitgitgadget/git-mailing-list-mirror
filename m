Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EC2F8BC3
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457329; cv=none; b=Xu9IK5s5JG5ZjMZsJIrOSEqgBsdiYM7sifs2K3Wclsf0N0pdX8XRidYxkRPaE6M79tS1Usi/TizIzLcQdFSqvGDOE+tnl8GVCUZdxc/0h/gAnr1kL21niCbaWkAAQCtvgI9Z1X0s0OibP1UbqEHTIEKRPJsqCdA4GzkSFWRse9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457329; c=relaxed/simple;
	bh=LrzSIkDKh4Cp609GynwtCU6yNbrkHsN03UjUbX2CQI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7lo3kqmtJI2IJxq0gsutjTtv2fIvdi708+ADck4/MlKSY8v2vbAXakRshM2zHpON35n6queCZH+hZ2A8D0IV0vWqEB5CvyGmrB3VKyh4lMlD5TaEtrUO/iRBT6gzKML+M/V1MAMFB3sU+wQ4DlMcXx77JhxapMoXWp3Zj/A7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeN15CxN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeN15CxN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b0b0064027so176115ad.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774457328; x=1775062128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URFn/ZxuuRPYH1hqLVi1KgeuMi5tnIVU36pXpuXE8DA=;
        b=IeN15CxNzqgK33Ubp+kmlRiHf1Hrs3EmqCySaDX9de8Y1WLCGEr97mXHgUpsXisI1M
         Opw70tXC+cJLxuA4E630tZvSqayOxqtjeC9R/Wt/t4K6j/C8L8H/0CRMBvTq1e4HX8dW
         gl+9Jr5ExeuHXW3murKwaMfs5QWHUJUtyAPVNVx/N3PjJ0Be6H0nkyhw+MsLkDHhehuh
         NVuBt0/ZEpJi9r8bgqvml/QNKRvW29Ax+iUCwitbKGF6fNXyZznCK+M1QabfnKcO7XUB
         zPLA10FBTSxqRMrBhbevByxsoOJsfK/k6PI+GP3kj2Iz+UjlXzJtuhQ4K3e/igLv1/7W
         XmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774457328; x=1775062128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URFn/ZxuuRPYH1hqLVi1KgeuMi5tnIVU36pXpuXE8DA=;
        b=jNuLhljdDo3GPqmgIvbD+h3MDj9hEcvX75A2HXYM4UVnUfZDFIqiNf+yXrqz89TeHT
         2+Osg1Ynhbsw5AhAcCFdnr+XNI57ytkFXKET+KL9EEJVA6DlMOtFAKm8s/4wJYa2z1zs
         3dKUKOitl9LYo69hXEpFXye+jhslC/q58/dOGz9qD2ryMIEvPOyIhfDLJGLh3lwc8bFt
         Z7QRUvGIvXf/of23I6jRhaH3EVlqMcO6tWW8zwrlSE2L/xzu1zZsVh82VYmGcQ3Ijc90
         aC26t6Ekd0C8a1Axcw+qPIyV81xMpf6pX9TPcMvHhaETtYgLVQtKAvEesWomBqkLO3sc
         y5xQ==
X-Gm-Message-State: AOJu0YyjYxrk3BEqdLsHQwXErRtEoxgsYiWwKIX7o9OaqegLXAPcRCwC
	mIibcSGIAgubAM7Go/uYTxN3Y71Tpc44hBznyAXFhl2yoBjUKEhIXBWgxikUTQ==
X-Gm-Gg: ATEYQzzuenxSUQJqMgoSRrjfn/CH6igvnzbwKvBNm4CZmdUqxldmhDSsfUpD3ZdciNc
	brVbToWYN/3di5fgBj1/Mel5V3psUyg5XRFMDAJvpiifcGeDe1vT6iAraPy/2EDYD7Rr8tZfnID
	kO3c0y73h1k3vEz4rqIjHNqDo8qq9LpUDvYsMkl08ZTKVnVik4JDcsHyCmZEsncJetizxALyU4Z
	67rvaMGHNWgkJGObu6wcSKSmqzDcgYboiYvv7xuzp4/T1qRQUyRDwqtAvp3vVNI9z6iL2RZs2MH
	rmfHv2daEWzPKsktct/YUGI8uznjoMbFmJlgfOaKq45R9N9Xy6gLTPaFhB7FjzExK2aEgEB6JWf
	OF/BLFyN7+zHbEK2t93fKjkpsthgY5dBHwGZlTLo4LYUfIWE1FrkAj9W61PjPjBbrdjq9YDK0wL
	Cmd9Wo4RlkUeMhU+46A2DZcYZU4a4z7zXWXb9Crb9mf9S77lAaBJSvGg==
X-Received: by 2002:a17:903:2c04:b0:2ae:aa16:acf7 with SMTP id d9443c01a7336-2b0b0ad656fmr47423055ad.40.1774457327714;
        Wed, 25 Mar 2026 09:48:47 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6f26:76cd:bafb:15d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm3901275ad.2.2026.03.25.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:48:47 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 0/5] refs: reduce reliance on the_repository global state
Date: Wed, 25 Mar 2026 22:14:17 +0530
Message-ID: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the effort to reduce reliance on the_repository
global state by making repository context explicit across the refs
subsystem. The patches focus on passing struct repository through various
ref helpers and backends, and replacing uses of global state such as
the_repository and the_hash_algo with the appropriate repository instance.

Patch 1/5: Making branch name helper functions (copy_branchname(),
check_branch_ref(), validate_branchname(), and validate_new_branchname())
repository-aware. (built on top of jw/object-name-bitset-to-enum)

Patch 2/5: Updating get_files_ref_lock_timeout_ms() to take a repository
and propagating it through files-backend, including callback paths.

Patch 3/5: Replacing uses of the_hash_algo in refs.c with the hash
algorithm from the appropriate repository.

Patch 4/5: Removing remaining uses of the_repository in reftable-backend.c
where a repository instance is already available.

Patch 5/5: Replacing the single instance of the_repository in
packed-backend.c, thus dropping the USE_THE_REPOSITORY_VARIABLE macro.

Shreyansh Paliwal (5):
  refs: make branchname helpers repository aware
  refs: make get_files_ref_lock_timeout_ms() repostory aware
  refs: remove the_hash_algo global state
  refs/reftable-backend: drop uses of the_repository
  refs/packed-backend: use ref_store->repo instead of the_repository

 branch.c                   | 15 ++++++++-------
 branch.h                   |  5 +++--
 builtin/branch.c           | 14 +++++++-------
 builtin/check-ref-format.c |  3 ++-
 builtin/checkout.c         |  6 +++---
 builtin/merge.c            |  2 +-
 builtin/worktree.c         | 10 +++++-----
 refs.c                     | 28 +++++++++++++---------------
 refs.h                     |  5 +++--
 refs/files-backend.c       | 19 +++++++++++++------
 refs/packed-backend.c      |  3 +--
 refs/refs-internal.h       |  2 +-
 refs/reftable-backend.c    |  6 +++---
 13 files changed, 63 insertions(+), 55 deletions(-)

--
2.53.0

