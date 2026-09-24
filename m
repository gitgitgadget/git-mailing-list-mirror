Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97483C9ED5
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251515; cv=none; b=Qu5x0gpNhfBNRdTCcMB08p5E2bCRmxUaU+JHHqE1dyxCGXrwmPiZmn05Ca508NJEVTc6ogwZgV3etZmdkKkAJ+xMemNanTTeZTGz0thwubN5kfXihFzN8dcixuYkO4LVHff+pHBaGa4TD/qHdJneK0jShi34rwG09uRzTgsr/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251515; c=relaxed/simple;
	bh=R6tTU3xcdrWXBofIX2mV2SqCNG/vvuvvCajuDpr+BpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IG3m8ehApc/1P+WDgC7N7OTwMd90T1vlwnD53JjD0vVnSsGSfY8FpN3loTncw+lOo7kvJ+e8wEpFTJFCh2+ppo7+x9M4fTzgvbmBs5cuKUEVwKqstElvAyNPCjXQ697/sI7U/ws0dx3Bp1WkfBKbyJGT6NnWJDzaovfHoJYOygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcHAcbPW; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcHAcbPW"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e62211987so2231269eec.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790251513; x=1790856313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oiS5FaVmT0CC9SEuW5XiI46BV4urIPeZzJBwO3EMhgg=;
        b=HcHAcbPWebYH2RGhzk+pfznijJVg/06PRKHmBLKky6yjQVVCmhhFGfpBss/AG1Z8RJ
         vYVADAg90JkMTpVFyglMaX9J7J18S5enNOmpyPTVdGjR4uHRjpBdsuFM5eLljYC0H3lD
         Br1VKKedkuE8XdjCIv61zxQywtUo70BgkjCUt9rG2ps5D/MijwIbb7fI3HclmwHZWgeX
         OSiWPuhzjg3kahCeRgGMQItcC5Q1wMS7mJZn7E9+RkWoX1m1nEcKOi5a0wRUT7Sz43CK
         n8NRBUB9UfDPptdZDIXto6RFRszb7mWmoHl+YfY+EmhQJP7MAUvTiSSB3GmumNCURMVt
         3oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790251513; x=1790856313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiS5FaVmT0CC9SEuW5XiI46BV4urIPeZzJBwO3EMhgg=;
        b=RwIxliylkPJDuAwyue+VI7xYJRdzTWtvZ0j7+f3naeynsIOI892tt6A48bzhQqUMRL
         MmqIbk1tNZqrY2hknWx5Zu3HKLvZtAtCfYd/VKDUWm1KVugDXuURTXG/u6c14IcycjcB
         jHUQn2z7q5mGkU9mwxYnqqDNLl1TAGtn3/UDrtaU77S54zqN29nv2l3gs64tAr4qWgfU
         zL+B2eL3cvUW6fH/J//7ZR/+1dCrU+N1nVpNupgnaR6tn/rtOchYt+EmhzJmpsozxsUf
         wxyGS1ioxzaaXh4QVkg3VZDlcbIfWKDLL3XdzlRQQ1N34/wA9XG7mq3BpBfvAnG+OT8k
         8eKw==
X-Gm-Message-State: AFuF++lAmzm6xykiQ9OXS9D5rOAom56OMzp1w7UxOKj/dUOEBGE/Hhws
	Obhoh3dgkHjg22+jsXXjNdIXptizzhRIRjzSyEImcjqAvtepLxh7gHi3hhMu695omWE=
X-Gm-Gg: AYBFou3FPXzWmzRqfFnpQ9D4QZNCixlu33HR+sHqdTQwtQ2shG+B/b1DWeMltaCRmzF
	dzrBd2bTJt41TWLPa3zeFIvrI8dBe7Wf8JR6dmsB5kKHb6szwqCcoxr940BlDwI2f3vHqA+LdgJ
	zdCm4U40HazrDNLVBFvIykvMFHGDloUAcBJ0xekSiIX5bzkQXO6czNBlHdsvXAFYnXFr1DqEa2k
	1DMyhbxCnh3pKAgTMlekTvyzzPXOqmKP6Hgt6EQE3bZICOkZWcaBKyglO8xyvn+RUtHXzB0W5rC
	p3K3SsVq/RfNS5Mo0kJnX1nhSgcQ/r+pVZyTlxPlq/qH/dw1PCl4/mhuUc6SqF7fCzsQbinwPTo
	oa2adI7kqoLmiLkkSNrz3+QOFWZebiDphC0hsPOUa9aeeiKOAywWxqPEhNShMqxQjMFvdGgRP3C
	K2xoMO3PveFIaElZi8xDj0VCg3CP+uRkpHSbNQZS4nZNsLWuDpyUGDA7o97y+oGfb0smTlGl6Kd
	tadIA0/UCnaKYQz65/G1Yx2pw==
X-Received: by 2002:a05:7300:169b:b0:340:dca6:f34e with SMTP id 5a478bee46e88-340dca6f75fmr407402eec.40.1790251512511;
        Thu, 24 Sep 2026 05:05:12 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm14302671eec.5.2026.09.24.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:05:11 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC PATCH 0/3] Improve error reporting to mention "why" a directory is not a repository
Date: Thu, 24 Sep 2026 17:32:18 +0530
Message-ID: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.12.g2c9c8d64bb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment, there are a few scenarios where the error message for an
invalid Git repository is a bit blunt. For instance, when we point
GIT_OBJECT_DIRECTORY at a directory that does not exist, we get this:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
  fatal: not a git repository: 'repo.git'

Even though repo.git itself is a valid repository, we get this rather
puzzling error saying that it is not. The actual problem is the invalid
value given to GIT_OBJECT_DIRECTORY, and the user is left on their
to figure that out. This series aims to make such issues easier to
diagnose by saying why the specified repository was not considered
valid.

With this series, the same command outputs:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
  fatal: not a git repository: 'repo.git'
  reason: cannot access object directory '/does/not/exist' set via $GIT_OBJECT_DIRECTORY

The following scenarios are covered when --git-dir is given explicitly:

  - HEAD is missing, or its path is not traversable
  - HEAD is a symlink that cannot be read
  - HEAD is a symlink whose target lives outside refs/
  - HEAD cannot be opened, or cannot be read
  - HEAD contains neither a ref under refs/ nor an object ID
  - $GIT_OBJECT_DIRECTORY is set to something we cannot access
  - the object directory in the common directory is inaccessible
  - the refs directory in the common directory is inaccessible

This series does not yet report a reason in the following cases.

The discovery walk, where we iterate up to the ceiling or the mount
point looking for a repository:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git rev-parse --is-bare-repository
  fatal: not a git repository (or any parent up to mount point /)
  Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)

The gitfile case, for instance when run from inside a submodule /
worktree:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git rev-parse --is-bare-repository
  fatal: gitfile does not point to a valid repository: /path/to/super/sub/.git

GIT_ALTERNATE_OBJECT_DIRECTORIES is also left alone. Its diagnostic
are misleading in their own way, but they are emitted much later, from
the object database rather than from setup, so they need a separate
treatment.

I would be very interested in hearing what others think about this
direction. If it looks reasonable, I'm happy to cover the remaining
cases too, either in this series or separately.

Kaartic Sivaraam (3):
  t0009: add tests to cover more error reporting scenarios
  setup: introduce new helper 'is_git_directory_verbose'
  setup: communicate why a directory is not a valid git directory

 setup.c                       | 165 +++++++++++++++++++++++++---------
 t/t0009-git-dir-validation.sh |  38 ++++++++
 2 files changed, 161 insertions(+), 42 deletions(-)

-- 
2.56.0.rc1.12.g2c9c8d64bb

