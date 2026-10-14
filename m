Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C255D86B
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992451; cv=none; b=tuxBMJZNzJC5uyod6q/9hIqT2tPrwwSHT+3V4yS79flazAZDgDqwVHP+MEaBp78NwlgDlBL1oA1wmjG41Y7VGKOH4ElxwbxsLkkPQ/fc33eklvSFce8B5v0hzhLaEe9FeNouDQIf+WPEsq8DvN0ji4/191eLBOL6MlNHDSyBTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992451; c=relaxed/simple;
	bh=YiyR1gvO2+bfAA+qC0LK+ycd53HEhESsW30disfCLbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZZgxdxiKN4F+7S/Ub6LJNhN6BGicWMguwEepoq5+5t5jmJKkj0Qetf6b5UjO/8luGukv/LYjBH02V7JcH7BM6PLscT6dj85zm5uCcGH2n0j3bqm9gLWbCR0xHef3VGCpkxcvalp76/znRdcMFufrfWBz3bsXzlsmNJk/nHqX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl4QeGEm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl4QeGEm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso56370145e9.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992443; x=1792597243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wZCULKk9XEVS3QtQM3CfZBztZe09d6wEHX06ppj2zCM=;
        b=Zl4QeGEmojVZ1fMWD4R8/Ek37WWPyoxl75JyGVeSdGoG6ArywoR4NBmCK5vNj0/kEN
         I0TTyYfRoZVv18s4TvCqZPnDVOEhnxG+rQ8ZnqPIUkcO8cmmyQd6WkK5FrIUTxIRRvWt
         QVDoarm+ey2lM2V0IUh8U+WXs5I+jgOMYi8Q9oxNbzKS+A/OfSApfVJ0opsVeebw6y9U
         baS2NnP/ZzgJDLkohpVIR9C5CrS4PO5B+YDKjrYHW5BUKPy094KyjIioiaVj//M7EL/o
         kmD/O1nrylDm6r4mnkKQjFyPXA9sbgQpEMY/dZJXFzR+WGuTLmL68IUqR+4mg3ROcYQY
         Rpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992443; x=1792597243;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZCULKk9XEVS3QtQM3CfZBztZe09d6wEHX06ppj2zCM=;
        b=THiXeqgq4e5eDFbhz7CeQuEpmazh+w1sFFOiIL/k7Gyc6I7RFXex/yugyFGtvkOtsp
         kru05uf8gJVbaFrz3rVeNTpXTnu651Wy6ajeqxuwa74E2Ot7is05GGHIB9mkk0PrmoAR
         acql/U1BgtKrh0oUsEEUyMxCi3z/NiPjTfNVHar0FnLCCeeotB5229Lr69WlMgVKqtBY
         jLl86L52DrkyfKpEJwm6kWp1ufSHf6BXAhW1MyvITAOzBwxzNKXSsEut5qgYOVEB3ezD
         DIpF8BMV98X3RP2pr0ukRI/RsY19EbMe2ueWHZLzAAZ/EciPvUldCpBoIdzOIyL3P7jb
         7s2w==
X-Gm-Message-State: AFq9FYIR0X54Y8+ZEUEM/sUk5ycHHyAGr9A5TdvkoC5x8QRQfVwnhG7j
	n+C/NE0FdMAalW6V7nzioxvzALw9BDy6uO3TLKAgUy03o1WTID8jmnfz6KeVCQ==
X-Gm-Gg: AYBFou2WBIfoqG03UB0iu4DSrouDHLB5wRwTcZT+HZtZy/MxYgZCkGqupY0myJzNTY3
	fya0Pmoj7JrIPMlEX2ldGsRKGC5T6d8sv4P7YTzYBcXTwCZZP4glNMN/+gAzEfjh4J6Cp14Hi/6
	sXHyOLfAYLZuFMWI5sBu6WIr+xChzAgxzQlq+ErcWwvc2ofXgaJL5s/gz0LAnUfpJpTEdO68U4W
	veTM7qsu9LFrU8gS3f4shPEifmDEIkzZGDh9UcxqV7OcDskB43wZR5LVeW490++frIvJe49kctP
	MDhUGF02ADAdSz7sdBEivIosQQDejBwEPsJs9162jWbpHnzGWBYt5ymfz4AsD2HackKNfx7Eh1M
	PkBUO6qkBj0KTuWBNa4crhpZzPBTUMnbabAykY2WHwe6URsDMmwfReX4NxZ9nP7GC/bG2OYji2i
	0m7FZyYPkK8MrsfEJRT5LUaxJVN8GrlZfqBwgtW7wAL+cYLJ1dLM/neiUL2UyFx0WwYhEqJeKin
	A==
X-Received: by 2002:a05:600c:8598:b0:4a1:b8e6:dee2 with SMTP id 5b1f17b1804b1-4a1b8e6dfffmr33193775e9.2.1791992442694;
        Wed, 14 Oct 2026 08:40:42 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967acasm10324829f8f.2.2026.10.14.08.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:40:42 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 6/7] stash create: remove unnecessary index load and refresh
Date: Wed, 14 Oct 2026 16:40:18 +0100
Message-ID: <768d6bc7e5a8c47e1d727917cbd8818f1906cb17.1791992404.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791992404.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1791992404.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

create_index_from_tree() is called either directly or indirectly
from do_create_stash() after it has loaded and refreshed the index,
so we do not need to refresh it again here. This saves three lstat()
calls per changed path.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index ddeb5a5d2a..55916259c3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -384,9 +384,6 @@ static int create_index_from_tree(const struct object_id *tree_id,
 	struct index_state dst_istate = INDEX_STATE_INIT(the_repository);
 	struct lock_file lock_file = LOCK_INIT;
 
-	repo_read_index_preload(the_repository, NULL, 0);
-	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
-
 	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof(opts));
-- 
2.56.0.134.g299a3c16181

