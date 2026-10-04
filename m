Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29319414A1F
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102689; cv=none; b=hbKJ5eZ5DSZpE9zr9y5cNFAWO059+u3RcHJo2MW96ExMRPrqxlZLujKQbZNY3zCJ+1L5r5/gOJY7MAtC0pwfk5DybQefSs8mR/ahNzkvqZv2exwy8fhQ8E1RLEsCTwVLS5vy+tGsT7TM1rLPpSs8iHh4pw01jT0sg88TdPiyPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102689; c=relaxed/simple;
	bh=2tqB5otkYaSniOswlVHcDpV9LO3rGciVNW37/98E5Uk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IPjJjkwsPUVREiLtB0ZG9V0EeVefTE02YFlc9v63YCKzo2CAS2E60Htq7/yaHH5InJdxq80vxPrFS2urWDeOMjVr4tq+GyOCngFuwGDxcudvTrCcETNB2hl1XumgfmIPZkfNb+w8nuDSUKVM9IISkvkQHZmQ5CIBFk0NYdstpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT5KfcI7; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT5KfcI7"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso1184382eec.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791102686; x=1791707486; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uTUk+se6ubghnS+PWesKlO8wGFfjcCyNr3NMwphgIfQ=;
        b=TT5KfcI7nsJhHfLLk5c8+T9KX3FSwoNWuEXVlKdxmFwsnw9cdFgLj15wEFzXm2RB9r
         jhiBQ3cSSKp3+Bs5NLfYy6iJgBj6aTjnuQXUMuKpmfTnSBfNhU4L1EWruQjengZiI7th
         +Pwl8ls6csNl3VWaKWwZt32h+fnov2Z4egxV1/LIrnOPq6Z7B8uuwhgdEn8EseVfKd3C
         KFE0E/XszArpl6myfeQAu3q5J2CG5Htc1tsO1B8ClV0vMnpOQiTw9MmQ7UTaiYaAO83a
         hxAaJQ3fPexjgzdT7/KPGmEvblHwr1ete/51ZI8t8kyCfACMuA/3uqJ7U19NFpV9sCO+
         F2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791102686; x=1791707486;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTUk+se6ubghnS+PWesKlO8wGFfjcCyNr3NMwphgIfQ=;
        b=MaoP5B8jidaoEtwtlVTsk0PqnZVG+Eg83w3CpRsQdGFWI171bt3eH7eo7V317Qz7nk
         uFXq7wnB0/lBcItG9MFlhInshgY1h6TXJgFfejJlo3bLQsE3JUlYvO9KuYwCoRyNTzBA
         C0eJnUdENMHt94ecQzqsRzzernTxB8OSJbFkAXydaRwqo/uW6lrDbi/2jeaqiVHKSF66
         dJfMIwVJ2dkQ3hYdy3cQDTHnCMp6/bcMAu0xLWLiIkx49m6UDMj9ZIt697dbkRq+p4vj
         EhK3ZK3S2C0tbV02Fg5BELXq8/xL+pONY4Cs6wC2mtgxm3mdxWeyZjhSOiR89Jm+UKbK
         oHtg==
X-Gm-Message-State: AFq9FYL8mWQSXzL9rZz3W0Tra88HuUVdtqjW+7PDdJfTus6it1mzPTgg
	vSqNsfkrvq/fn5uZssWOdcubBbNDxD4GDKM1rtiI+wLnjOfBTnihNFbee0cYZw==
X-Gm-Gg: AYBFou089Z+kUotWWNl8ItxbXXHJpjznleKeEKwB/kK8Jnn0jouvG597fOEmjLFu9dQ
	5z/j5f3uXl2Cgbm37IOanBZasa+wtKaR2uG1i3MJ+TTJgMaTfuugij9pm/i1Mj5BmkE2WHlIZU5
	QNG8/92d9dXbhZsre/PqY12vP2ovDGiX8qa60a9NLmRzbdEmGMqos1++OKb3xMeAZt0WL4UknLQ
	bqUgf3dBVJv6J1HqNWUa8MTmH0J71PT0HpkoA1Q3adEgUWvfbyQCvr1HytHCCl2YFN+QFl3HQN6
	DcV+/qk3cpkpsH63J53bqNcNtpT/TeADy4p0sE1akQW96n/dt1RgETH/hISl++xzbA5byIMRIwU
	24EcxOJ8duuZFkmX/WE25NxD96IcDzMTgd4ogdyl4rGRfoqogsPFa635SC3lCAqX7aOiACe4Zf7
	SeY3BK7R6Ns2J5SkarSh1/cUsSjY/+ceekqK8/MQY/0eceSM/4lfOrvugDLaQl6/Wq3T1/YzmKD
	w==
X-Received: by 2002:a05:693c:20d4:10b0:351:1394:d918 with SMTP id 5a478bee46e88-3511394ed5dmr5377806eec.14.1791102685968;
        Sun, 04 Oct 2026 01:31:25 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127138638sm3520282eec.8.2026.10.04.01.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 01:31:25 -0700 (PDT)
Message-Id: <pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Oct 2026 08:31:20 +0000
Subject: [PATCH v6 0/4] fetch: avoid fetching every branch of a new remote in a shallow repo
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Avoid fetching every branch of a new remote in a shallow repo.

Changes in v6:

 * Remove leftover reference to deleted default-branch logic in commit
   message.

Changes in v5:

 * Renumber test file from t5585 to t5586.

Changes in v4:

 * Removed the automatic default-branch fetch. A fresh remote fetches
   nothing until you track a branch explicitly.
 * Fixed fetch report showing "new ref HEAD" instead of "new branch "
 * Reworded remote..refmap docs and commit message.

Changes in v3:

 * Replace the special ":"/"+:" fetch refspec with remote.<name>.refmap,
   reusing git's existing --refmap mechanism instead of inventing new
   refspec syntax.
 * Split the change into 4 commits.

Changes in v2:

 * Replaced the opt-in fetch.shallow config entirely with a new special
   fetch refspec (+:) that git remote add now defaults new remotes to in a
   shallow repository. The new refspec fetches whichever branches any local
   branch tracks at that remote, plus the remote's default branch.

Harald Nordgren (4):
  fetch: add remote.<name>.refmap
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   8 +++
 Documentation/fetch-options.adoc |   5 ++
 Documentation/git-remote.adoc    |  14 +++-
 builtin/fetch.c                  |  60 +++++++++++++---
 builtin/remote.c                 |  31 ++++++--
 remote.c                         |  41 ++++++++++-
 remote.h                         |   9 +++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  76 ++++++++++++++++++++
 t/t5510-fetch.sh                 |  17 +++++
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 11 files changed, 363 insertions(+), 18 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v6
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v5:

 1:  d48a7004e4 = 1:  5c31a51bb7 fetch: add remote.<name>.refmap
 2:  fecdbc43b8 = 2:  74c177e3e2 fetch: infer branches to fetch from a refmap-only remote
 3:  b45f3cf0ab ! 3:  3abcc8915b remote: add "git remote add --limited-fetch"
     @@ Commit message
      
          Give "git remote add" a --limited-fetch option that sets up
          remote.<name>.refmap instead of remote.<name>.fetch, so that
     -    "git fetch <name>" only fetches the branches already tracked, plus
     -    the remote's default branch, as described in the previous commit.
     -    It is rejected together with -t/--track or --mirror, since those
     -    already say explicitly what to fetch.
     +    "git fetch <name>" only fetches the branches already tracked, as
     +    described in the previous commit. It is rejected together with
     +    -t/--track or --mirror, since those already say explicitly what to
     +    fetch.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
 4:  8c2a144eb7 = 4:  84d192445c remote: default to --limited-fetch in a shallow repository

-- 
gitgitgadget
