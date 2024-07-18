Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6043172
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332552; cv=none; b=L3kNLjqbgDWvbXtJMZfiozMrdyZL5f9O4yWuya8QmZuzYFqpkQXnlGJwIH8teN86WWBloCqLztVoT832spOwxj1HUEI74r4/7Z/xxAUweKFZ8EAhb5eERJyNvxysF7kZdf3axbeb7/KeS9UI46sZ3cxX/lcWP7H+VyC/Tjwey0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332552; c=relaxed/simple;
	bh=3pGMGT0Ll7EwkS9Rdl4SNWOqFHptBVsgg5Yqs7bST3A=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Q3i17MlK/1ozmP90PJnFzUMTf59I5lFf0XQX6MYhhPUJ6odyh9ib8zHvgeSKg5o9+XctTmM35mOg67A/JvWythiYwMwWvVLaPduI2LFEhO3wvFIZAVfPWOGUegKlz3tTrYifUIio8rxHhne4WKfIlf+0RRQCZZU4TVSOXUQa6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbFch3xZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbFch3xZ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367ab50a07aso160312f8f.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721332548; x=1721937348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o+cUuL9bmTI7Ev3FXVFvcpXU8/2aQNH0rznrcirZ3Fo=;
        b=lbFch3xZQzChn6v1E7Cw3PCN4jJ8lyR+vF0JSt0BNPbsHxlvS/PzEV+PBRc2o51Wue
         +cPC6DPQD6Ep/eWrTMiIEXSs8mpZVba4MgLIqjwkLVuHd3iVYSeMRZp2QNy0BqDBPGtf
         LrsyBkLJozRFTrsrAiRBo3fsH9FpBL7oirnCPfvGiTE1B4PMjp4Jd7E0DDLb17eLPHqh
         9NVzsKVCE/QsJ1kgVi77OAcMZyU+DudbgJOUiHdoE1obTqgYRqhxwOeplucIi1hBgBXl
         X3i+axYg61Sh9IS5wFKEu80aAXKWzFx5GGzR/U3Rm7EBZF25FPsVfHoP0cMXtUnhXRb5
         fOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721332548; x=1721937348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+cUuL9bmTI7Ev3FXVFvcpXU8/2aQNH0rznrcirZ3Fo=;
        b=V2dmTlF5UFxkY6MlIcqVRulVKegSYy40xSHeYQswTsCCG0PN+jS8hQLmgLBKKtxE9l
         N5/mhfoC0d07+FIel8kju3WXGUDpMo10uZqS2df+LJAK9BFJKSKtoG31yX1//9eqiJzO
         Q47ogtwbcAwOPD+AEfZ9r8c7denT3+J6mxSEgVAw0gP9yf7mackgH4oFSbmExqiTfkeu
         FzfmCqNk+sqbCjntQ/6V1pw2ZAugWDU3D6cbOocLLEX2nrSwSDXqfNY3AEoDBE4zodaL
         4sJZHz0HhBCpP07LiJFLbgnAPA9ArlM7Z/XdDq5zgMelBsRN3savy5Q17AmPp3HtJYvj
         xJYA==
X-Gm-Message-State: AOJu0YwU07DDWAeP26fhnFeOSsBpDeEjX3huPsygT2PfAvhQPOqdofL1
	Tsw+KJrIN9i7KFc8o8P+5z+HWZOCfzAexE3/Xc5FdHLIC8agjfS5V3ANCg==
X-Google-Smtp-Source: AGHT+IHUzTSNUcxn2HuxRe3wy0JXSSVK9bgFaRSPWkcFueFWTtD1oRDVHd1NPAAXDUfHWd8p3S1v8Q==
X-Received: by 2002:a05:600c:19cc:b0:426:689b:65b7 with SMTP id 5b1f17b1804b1-427c2d2d8fbmr45163135e9.25.1721332548187;
        Thu, 18 Jul 2024 12:55:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368727f231esm434768f8f.56.2024.07.18.12.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:55:47 -0700 (PDT)
Message-Id: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jul 2024 19:55:44 +0000
Subject: [PATCH 0/2] Fix background maintenance regression in Git 2.45.0
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
    me@ttayllorr.com,
    Derrick Stolee <stolee@gmail.com>

Here is an issue I noticed while exploring issues with my local copy of a
large monorepo. I was intending to show some engineers how nice the objects
were maintained by background maintenance, but saw hundreds of small
pack-files that were up to two months old. This time matched when I upgraded
to the microsoft/git fork that included the 2.45.0 release of Git.

The issue is that 'git multi-pack-index repack' was taught to call 'git
pack-objects' with the new '--stdin-packs' option. However, this changes the
object selection algorithm. Instead of using the objects referenced by the
multi-pack-index, it compares pack-files using a list of "included" and
"excluded" pack-files. This loses some granularity of how the
multi-pack-index chooses among duplicate objects.

The end result is that some objects that would normally have been included
in the new pack-file are no longer included. The copy that the
multi-pack-index references is in the pack-file that was intended to be
repacked, so that pack-file cannot be expired in the next 'git
multi-pack-index expire' step and is included again in the batch of objects
to repack.

In the context of the change that is reverted by this series, it seems the
motivation of the change was two-fold:

 1. some I/O benefits to using pack names over object names, and
 2. the ability to use an object walk to improve delta compression.

In my local prototyping, I've found that we could improve 'git pack-objects'
to use an object walk when given a set of objects over stdin without needing
to use pack-file names. I do not believe the '--stdin-packs' option should
be used for the 'git multi-pack-index repack' mechanism, or at least should
be done with great care and only in specific cases where some assumptions
can be made around duplicate objects and closure under reachability.

However, the prototype I've built to get these benefits is non-trivial due
to working to guarantee that partial clones do not accidentally download
missing blobs. That will follow in a separate series that can be reviewed at
a slower pace.

Thanks, -Stolee

Derrick Stolee (2):
  t5319: add failing test case for repack/expire
  midx-write: revert use of --stdin-packs

 midx-write.c                | 18 ++++++------
 t/t5319-multi-pack-index.sh | 55 +++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 9 deletions(-)


base-commit: bea9ecd24b0c3bf06cab4a851694fe09e7e51408
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1764%2Fderrickstolee%2Fincremental-repack-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1764/derrickstolee/incremental-repack-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1764
-- 
gitgitgadget
