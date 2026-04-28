Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB32D5432
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393585; cv=none; b=sStdhfa1S/eMHYWi2l6FQEEk/lU8UqwYKbWhjGuJqkfbtfPwjp/rTmAiPBHLBOAI3s+N976WWXdsxgW0JcaEv3Zk2vqgcoeNjT4lUvRYat+/z1GK+0dFlqpzYH1860NRhFxTlGlJSxSUG7nXMJk+ViXVegSqzEwUWrg15RqcefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393585; c=relaxed/simple;
	bh=UW/W7o1YmTw01h5ZPhkhKPf1x4DA0RYxBWxairbrW7o=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=mSZJLNgoJHbHxZgY/CCRPYDptfBEbPhpj4jiMGYhzpc/THkRDY9KoyqRNla+hnRy2U83zq2u3OYpE9lM5At/KnLRCLkJ9pdLM2h55ecd9gBr+lWtEOqEgZE5vmTrN/N0vvZI3TpRiYU4exUaxsWV8JlGiIjW6K5tF1O6Q3g+j8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oheHV+NW; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oheHV+NW"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7de4be15125so4525878a34.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393583; x=1777998383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RBi0j6o4lUx9WHZKTMFbGHMr6VRq2ZLM2KMwSeBMb0w=;
        b=oheHV+NWprGLkVWT+xgTT4UVod2IREfJ3auDEDul8lvj7SBPod/piVdyAJwPuwWmX5
         Q9xSxMxzN9kplCBTe7mEeetzUuuMOV4Q8L02F+vLSmYdfD4b3KxecdcXvMESfZzpUr/H
         ovvOdtOydn1+ftyo81i4Vt1flgAnJf+Dj4JAGUF3X7NFHRrCckt4faegl9Oj1LqLCvh2
         mKnZFb9fn0H96xrkIi8gysz70Xuw+eqtEHa2XlJw4UDaT+xqiiUa25zRMpq452vlw0CS
         u2jRRpGHKKKH1h/nx0AQ293hTaLFQBWuOrbfAfvcg6vx7DKN/zcKmGYLozMGGz1/fZuc
         GuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393583; x=1777998383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBi0j6o4lUx9WHZKTMFbGHMr6VRq2ZLM2KMwSeBMb0w=;
        b=JmOcfjLZ7k+dP8BB/6aJpr5UTutyYNPAexA1WjqHQ6P3RF/RKT6loN3ePJMpOAvfiH
         O0B3EE6s0AfARiEw7Rii0/5Wd+Aic0zQym9GtaS+HXd4NAGs7W2sApQStwRS19azaJF/
         4lNbDbZIFKUvcC7/iVW0ghtde7iw4umkA/tiUWONcLm3qer0MmvGoB5oYLGZbcAWpxfV
         coaaVPB4na3hRh3jaz72LiGUm7bx7XQ0qVTh3mStv9lewnf5jS6wHx+iurAxbJZkXrZM
         tFPF5cbvG1d616bKsLl6luJx7MgKbOp3Z+hqXWOnG6Ypqk9X/j2oqDHS6dLl/rQMJtcE
         b2PQ==
X-Gm-Message-State: AOJu0Ywvn06Y8KCh0b3nlA6MOBz9UzVZdfNMUDwDZ7qhxC2f/5SnLdH/
	PMh+EFE8W3Oq60L1BFSzlLya3SjXa7YM9EZ8/EcFyUNPg2U0zQIzaJB3+TtfHw==
X-Gm-Gg: AeBDieu0j0tYoh05A9DEa9f/4D8Ju8RP+VPoMamuE/RkxfMZ701IfAAs7pXMDtBA3MQ
	d1aId0wkfwgDPdTBbSsGOEwdB6sbHBZL+4iyJ+KPZk2QCsGHYDAIwwPPmPrkxF7+q2bwQC2plc5
	IQMtks5JHsnTBqqw3nCP/U1dMoBdwK/RJMzt9dqzzXyFk3x5ksIatKg+5GK2GRZlMuX1FFW1BpV
	Q59pwWeWs4sGOz9X/87HlSTOQXz37uXk0gzvy04DarMlOXPhUtG2nD2ELwMR1QiV04JRHnvmzbx
	+wWb+YpkILE3/TnKEO+gi3W9jbDn5C0muQFFiUeAsvayfzUsaDymz0TyH7MLArWvjoOqj5Bdpm/
	T/d3JJx8VmUvjy2lnu2Kx9YYg90YYgeN40T62h4Hk1zr3+2KbcwVLW4KPUBd8cAJ8pI7XvLVxTK
	//GCLfO2yWntbXISVUKAi/uU2XtkK0bok1cHce2ME=
X-Received: by 2002:a05:6830:2b06:b0:7de:4ebe:e44 with SMTP id 46e09a7af769-7de99f7c0f4mr2441226a34.2.1777393582924;
        Tue, 28 Apr 2026 09:26:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.163.230])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de9866c3a7sm2144962a34.14.2026.04.28.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:26:22 -0700 (PDT)
Message-Id: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 16:26:14 +0000
Subject: [PATCH 0/6] Handle cloning of objects larger than 4GB on Windows
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

On Windows, unsigned long is 32-bit even on 64-bit systems. This causes
multiple problems when Git handles objects larger than 4GB. This patch
series is a very targeted fix for a very early part of the problem: it
addresses the most fundamental truncation points that prevent a >4GB object
from surviving a clone at all.

Specifically, this fixes:

 * zlib's uLong wrapping and triggering BUG() assertions in the git_zstream
   wrapper
 * Object sizes being truncated in pack streaming, delta headers, and
   index-pack/unpack-objects
 * pack-objects re-encoding reused pack entries with a truncated size,
   producing corrupt packs on the wire

Many other code paths still use unsigned long for object sizes (e.g.,
cat-file -s, object_info.sizep, the delta machinery) and will need their own
conversions. This series does not attempt to fix those.

Based on work by @LordKiRon in git-for-windows/git#6076.

The last two commits add a test helper that synthesizes a pack with a >4GB
blob and regression tests that clone it via both the unpack-objects and
index-pack code paths using file:// transport.

Johannes Schindelin (6):
  index-pack, unpack-objects: use size_t for object size
  git-zlib: handle data streams larger than 4GB
  odb, packfile: use size_t for streaming object sizes
  delta, packfile: use size_t for delta header sizes
  test-tool: add a helper to synthesize large packfiles
  t5608: add regression test for >4GB object clone

 Makefile                     |   1 +
 builtin/index-pack.c         |   9 +-
 builtin/pack-objects.c       |  23 +++-
 builtin/unpack-objects.c     |   5 +-
 compat/zlib-compat.h         |   2 +
 delta.h                      |  14 +-
 git-zlib.c                   |  25 ++--
 git-zlib.h                   |   4 +-
 object-file.c                |  12 +-
 odb/streaming.c              |  13 +-
 odb/streaming.h              |   2 +-
 oss-fuzz/fuzz-pack-headers.c |   2 +-
 pack-bitmap.c                |   2 +-
 pack-check.c                 |   6 +-
 packfile.c                   |  57 +++++---
 packfile.h                   |   4 +-
 t/helper/meson.build         |   1 +
 t/helper/test-synthesize.c   | 250 +++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t5608-clone-2gb.sh         |  37 ++++++
 21 files changed, 418 insertions(+), 53 deletions(-)
 create mode 100644 t/helper/test-synthesize.c


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2102%2Fdscho%2Ffix-large-clones-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2102/dscho/fix-large-clones-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2102
-- 
gitgitgadget
