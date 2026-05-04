Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9AB3D3487
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914513; cv=none; b=jj5Dw6TpBT4w6VzfJe5qAux+RJqtNaw8hs0h1JRWZ/+yHYjoVDPOCV0ZQQJhMF9kLQlHqXBFc5OxEs5zaIct+qsyBz/TUUDy+iRvJKgHrqmvD1g7FhHdeABzPLfohLq1stCA3X8Yt+2eST+vagff8RvEsPwj9jsT3OqhD+mDrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914513; c=relaxed/simple;
	bh=vnoPfDJssXnfjA2xtQZHpEJqGCH/aUQM8DWVOUhmU48=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j43+lUoLP4qRUQ/t0PR8HlCv5CIwn6nn/sFGSUqDpaKc5Ea+yG7nkdiaBypRIvMpivvqNhecsVxkdTBaPBt0ZP6t4MkeYmxlwkvepMn46MCBASTH5m+y3Z4N7Zn6tD5xtpRLcM38YGZQovBC8OYSrHlBSmuB73UwPJJ+ggaO6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhrIM253; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhrIM253"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-95d0476490fso407990241.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914510; x=1778519310; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8tktdYEfOkbkEW5U65sPjma0hIrDS8bYHNPHP3qWcI=;
        b=WhrIM253A0Thxo2QohtjeRKrk1h79ayL/PsCponJlcOhIecKoUjxQtg+tbPlXA+ADw
         +NHLlPd9OT1V7Y1/NO/V1C+AVT2oaCrMO7y0pEG/opDmq2QFQLfte/8xT82/GrzHdG+g
         s/eAopegLXnPA/IJZXFsxU/k2cAqxkcHstSb8enF63Di8l7Cxp1I7m4xFB52YXRGCIW6
         qagnLZS1smH+nqPd/68uuaGG2yVPg8n0aWtmfskS2dhEStzdLdeKo9c7fFWWpAMSaAsk
         nACJsENo5CUBPd6E6KLmQThwpWH0KAuuD7doRSipMmZYvpMemnAvasMSNq81/RbEb++5
         nCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914510; x=1778519310;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g8tktdYEfOkbkEW5U65sPjma0hIrDS8bYHNPHP3qWcI=;
        b=DBhSYdrD/THOqWP8NqObiDWlmBH9RQYUEjpL2T0bgjj/LE0hl43GihXPb1wue6EeuY
         2dTBVMmDJl12rUwqZ5oX/FoYLPFADuYYaF2TocftEp8CbsZk/44l3HzKhkWiClXB6aR+
         Bga9IE8qHc2dCr5cqFiGlp1fLWDVIzdGc5USB6lJJSJ0XRWWmb3HWuLDz0jy3+eyociv
         T5I7InDpAMs7mpUXHUj34Z+Wd9V5vJxQ9qmWRNLldXavBBe0TmgMb8fx5y7znoXuvWB7
         yi2LhaWXNWLvuCeV4nKcpccNcZsTYlHX4Q7UOzQTkoAJ/EvfONOL3Cbb/ASUUnsrbd6j
         S9Ew==
X-Gm-Message-State: AOJu0Yz0qxM7d6g/TbRDGRAiQHfRFMCTS4u+sk2jRQ1zIarPTi6tWaXn
	vIdJLnRS2PDaJvIzVLEmp6LNPOHAFKq2HjcRy7DOEd3czYBoOEYO30S3KuPQrCN3
X-Gm-Gg: AeBDievCxNppIvSIuqpuOB4qnKK2vGlFhkHLk7DqTNP9kiT2NApcnkvZ7XoP3a5wDCL
	Ia1y/tFugG9qW3REkdFxZKD9C6z/7Z1vEgwHw9lWpJFsxIEFkhikQm4thP9w5JQkx0BzZFvkRyQ
	8C6WukVO3XbFYc8klcArKfOxfQOvmdhgO5KBR0ZerZ9pUtFZrbSCnFfX8cOlYapMBe6/trr3AjF
	jobcMyVlMWZMYO4A9j75r6iYmXbJHTbGiMSYb7a6Br/ufUoxc7G6U7Ob5GQ0ur5iDoS/8t2QbbJ
	xPKlf2E+lvtGAV0wsp8imrmoVBQR3cyb+lF3jSLUimnTULzRyuE2COYCWJq3fthWuVHy9ZMjqev
	OnmSEKbXZg7d7nSGjmNtvsYsNW9WGldStIOm3LGDGHQP4hfUWYqyAgZX4UUhIY4MWpzDgyTXiy7
	uiPOhfESoSrl1lCoarq5i4WUAgzUQjljmWFw6k
X-Received: by 2002:a05:6102:4489:b0:610:2912:adcc with SMTP id ada2fe7eead31-62d87d98a93mr4280949137.30.1777914509825;
        Mon, 04 May 2026 10:08:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.101.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253264sm1102841385a.22.2026.05.04.10.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:08:29 -0700 (PDT)
Message-Id: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 17:08:17 +0000
Subject: [PATCH v2 00/11] Handle cloning of objects larger than 4GB on Windows
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

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

Changes since v1:

 * dramatically accelerated the test helper that generates 4GB pack files,
   via two separate strategies:
   1. using the "unsafe" SHA-1 for the blob OID computation.
   2. using pre-computed "Lego blocks" to construct the 4GB packs needed in
      the test cases, where the size (and therefore the involved OIDs) are
      well-known in advance.
 * even with these improvements, the actual git clone is still slow (of
   course, because it cannot use any of those shortcuts), therefore the
   tests are marked as EXPENSIVE.
 * to exercise those tests nevertheless, the last patch lets all EXPENSIVE
   test cases be run for the integration branches other than seen.

Johannes Schindelin (11):
  index-pack, unpack-objects: use size_t for object size
  git-zlib: handle data streams larger than 4GB
  odb, packfile: use size_t for streaming object sizes
  delta, packfile: use size_t for delta header sizes
  test-tool: add a helper to synthesize large packfiles
  t5608: add regression test for >4GB object clone
  test-tool synthesize: use the unsafe hash for speed
  test-tool synthesize: precompute pack for 4 GiB + 1
  test-tool synthesize: add precomputed SHA-256 pack for 4 GiB + 1
  t5608: mark >4GB tests as EXPENSIVE
  ci: run expensive tests on push builds to integration branches

 Makefile                     |   1 +
 builtin/index-pack.c         |   9 +-
 builtin/pack-objects.c       |  23 +-
 builtin/unpack-objects.c     |   5 +-
 ci/lib.sh                    |   9 +
 compat/zlib-compat.h         |   2 +
 delta.h                      |  14 +-
 git-zlib.c                   |  25 +-
 git-zlib.h                   |   4 +-
 object-file.c                |  12 +-
 odb/streaming.c              |  13 +-
 odb/streaming.h              |   2 +-
 oss-fuzz/fuzz-pack-headers.c |   2 +-
 pack-bitmap.c                |   2 +-
 pack-check.c                 |   6 +-
 packfile.c                   |  57 ++--
 packfile.h                   |   4 +-
 t/helper/meson.build         |   1 +
 t/helper/test-synthesize.c   | 541 +++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t5608-clone-2gb.sh         |  37 +++
 22 files changed, 718 insertions(+), 53 deletions(-)
 create mode 100644 t/helper/test-synthesize.c


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2102%2Fdscho%2Ffix-large-clones-on-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2102/dscho/fix-large-clones-on-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2102

Range-diff vs v1:

  1:  dc660106ea =  1:  dc660106ea index-pack, unpack-objects: use size_t for object size
  2:  92f4327b1f =  2:  92f4327b1f git-zlib: handle data streams larger than 4GB
  3:  3a539061c5 =  3:  3a539061c5 odb, packfile: use size_t for streaming object sizes
  4:  3274cba862 =  4:  3274cba862 delta, packfile: use size_t for delta header sizes
  5:  afa74a3a2b =  5:  afa74a3a2b test-tool: add a helper to synthesize large packfiles
  6:  a3019888d8 =  6:  a3019888d8 t5608: add regression test for >4GB object clone
  -:  ---------- >  7:  859e93e7a9 test-tool synthesize: use the unsafe hash for speed
  -:  ---------- >  8:  29b9a74e91 test-tool synthesize: precompute pack for 4 GiB + 1
  -:  ---------- >  9:  8e6e720804 test-tool synthesize: add precomputed SHA-256 pack for 4 GiB + 1
  -:  ---------- > 10:  5b44410b2f t5608: mark >4GB tests as EXPENSIVE
  -:  ---------- > 11:  1eaaa7fad7 ci: run expensive tests on push builds to integration branches

-- 
gitgitgadget
