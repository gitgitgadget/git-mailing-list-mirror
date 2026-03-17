Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962D182B7
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707365; cv=none; b=QJjn0vmoADX4UjJGKEwWqFnerqNgqh6UtjegglE4JU4noG9Dj+j5Gmb6ZlNHt2VY5DhSh5IFHl5+0DyPYGEbVcqiB7ry1qAYEUJ9nYWyoWJ1DwiiGhmC1juJlzCf4kzmKDh9IYB1OHno9lmSzNN5O+UrzwQ96iOvx2P08Ns+xKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707365; c=relaxed/simple;
	bh=6yBT0pWDHnKOddZK+bX+yCdUXn8Uff1tvpYac+qALzo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fkIcQxIIW3Kt5qxaffWzUskdITuPPWfC0pJRBDlYln6TLGgBqJTRhjr0BFkAVft6fMemaFvXmg87tXNLNkSZl7GgGYnqWHg2M+zKMLoi5iGFVQEfvhqY/XBgyiamA0rxO6bdTNdBWV8oyTypLU3Se/p+Tat14pRj1Z3f8PlVsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWJddW55; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWJddW55"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c0d36f3888so872701eec.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707363; x=1774312163; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Usm/Zo7w/v7nLR87BttoBXgb3MtBH/2RRELx4EhfYyc=;
        b=bWJddW55VZckcwwbZTeAipQU63ZfhCgkSPa6BDe9l4jGvSkdsvguL3jxVO5B9IsjMQ
         5sEmRmTqgG+Dmk5DhCWUEJnGmAvD+vT64Q0IMvaEaYtHosK56a/dMcJZXF+uUR/DbmCu
         5vN1ZvWVRw8jdH99Ktxo2mLUmA7dqOZ3oHK9K3IzrWmO2IAzvEX43CHI27ngxIlpUn07
         EThvmpkyNMk3pUSGi1lQnXagAM1gCCt1ud87XdTj5IsO3ZPCs9tfDjPPsKgN1w1dhJwU
         D5qOdet1dGjDgcSt9WFn3ZvSs9bGDQax0b+AtGq3u/1JU7r5LPWGpqd7KJILRObm5b3G
         FPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707363; x=1774312163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Usm/Zo7w/v7nLR87BttoBXgb3MtBH/2RRELx4EhfYyc=;
        b=TIlOA5yrCOruiZeb8jJwrUHvXEo205zfxbR4+iKfwbn2JJIiqSG5/tt8w5Pja+lqEj
         XqX424L4AIICEBqcacDVfb8LtxFz6DjUB0CJ3sTmGc1OQYAcboDQ8GMRT9F250jAOZz/
         evGWDgPAUqh9sDNZSGtEf93td+ucVgYcl+DIAF3bfS71Cj134bd8GwIjicEuLzHZlAem
         euoVFH9T1dUHv2SDnYx6DLalo0IuCF3EBds6KdycN/rdGeQ62Uf9Ol9ob/oaf95wEBa9
         KCHWVhT3ZHeNTmqmtcHFHECYmpODOd2oagPLlbVRfKEWK/+iE7pyiblnQJr5sDdxujtl
         dHbw==
X-Gm-Message-State: AOJu0YzZP9qFaV/1+AxTKfRl5TrbtaoxdZqnrUTAVyJ6meG7vpIZLDCE
	y21b27mEO4WWeJOkGJhA1Dz3M6cDyra0zlSq3LZ7nnSae5uQH0TbQnuQgUSRWA==
X-Gm-Gg: ATEYQzxHo1iscko5xj5zUh1ZVYeMw2u3dtMuo9OTnUB1d1/hYzT6sffIQrkx7sTneGz
	Ylkc5WWimhSjSPqpFEd4fksIcJ+IGLN9F+UxbE2R3YcdQX1/C7DS/ClllYaT3E/OIPnkmimmOTD
	0zeH0fhgwbRkIl+VFRSCXblS8gNqxWswQZ1FMzGauOB76r2YcrapYcImm/ibQiJfthwmRw63d39
	zwa2Br84eRCW366U5vmPWe/agONiEpad4Mi3FBZWpkFA7xgQi+BkRwNjQvS/2mOiA5xUEhGzJ/E
	nNO2FAl73ez3LeYhY0rer+gxX0ZxfFiFwRQGuwWfmEApS3+z83T4xNH/TBOzHFg7vAa/jfhzeSy
	HOevrCNw1scp6dmN+3WzAdUZTHfUcHJbNaf9e4DAWNjG7HecrdP3S+3fSC8QAX4yv19L5NY+dqw
	eMcjFmoQY/NMMdZk5zgdWB1H/1wxBQrIeWBrll
X-Received: by 2002:a05:7300:e887:b0:2b7:35c8:32cf with SMTP id 5a478bee46e88-2bea55380c4mr7288272eec.28.1773707362731;
        Mon, 16 Mar 2026 17:29:22 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.136.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3e4a54sm18933880eec.10.2026.03.16.17.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:29:22 -0700 (PDT)
Message-Id: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 00:29:16 +0000
Subject: [PATCH 0/5] backfill: accept revision arguments
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>

The git backfill command assists in downloading missing blobs for blobless
partial clones. However, its current version lacks some valuable
functionality. It currently:

 1. Only walks commits reachable from HEAD.
 2. It walks all reachable commits to the full history.
 3. It can focus on the current sparse-checkout definition, but otherwise it
    doesn't focus on a given pathspec.

All of these are being updated by this patch series, which allows rev-list
options to impact the path-walk. These include:

 1. Specifying a given refspec, including --all.
 2. Modifying the commit walk, including --first-parent, commit ranges, or
    recency using --since.
 3. Modifying the set of paths to download using pathspecs.

One particularly valuable situation here is that now a user can run git
backfill -- <path> to download all versions of a specific file or a specific
directory, accelerating history queries within that path without downloading
more than necessary. This can accelerate git blame or git log -L for these
paths, where normally those commands download missing blobs one-by-one
during its diff algorithms.

This patch series is organized in the following way:

 1. A missing #include is added to prevent future compilation issues.
 2. The test repo in t5620 is expanded to make later tests more interesting.
 3. The backfill builtin parses the rev-list arguments. We test the top
    arguments that work as expected, though the pathspec arguments need
    extra work.
 4. Update the path-walk logic to work efficiently with some pathspecs, such
    as fixed prefix pathspecs, accelerating the computation.
 5. For more complicated pathspecs, do a post-filter in builtin/backfill.c
    instead of restricting the walk in the path-walk API.

The main goal of this series is to make such customizations possible, and to
improve performance where common use cases are expected. I'm open to
feedback as to whether we should consider more detailed performance analysis
or whether we should wait for how users interact with these new options
before overoptimizing unlikely use cases.

Thanks, -Stolee

Derrick Stolee (5):
  revision: include object-name.h
  t5620: prepare branched repo for revision tests
  backfill: accept revision arguments
  backfill: work with prefix pathspecs
  path-walk: support wildcard pathspecs for blob filtering

 Documentation/git-backfill.adoc |   3 +
 builtin/backfill.c              |  19 ++-
 path-walk.c                     |  61 ++++++++++
 revision.h                      |   1 +
 t/t5620-backfill.sh             | 203 +++++++++++++++++++++++++++++++-
 5 files changed, 279 insertions(+), 8 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2070%2Fderrickstolee%2Fbackfill-revs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2070/derrickstolee/backfill-revs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2070
-- 
gitgitgadget
