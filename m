Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8728212577
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402800; cv=none; b=KIMbhqO0Xx5g2K3xTMB565PgyMIVF+uIxqSPT8ugFPhWlKcPCeYEdjvZkM5USQpwCX6zw1buAL/ud+2Gqq+jTEBvwgsndq0o2fOdvpap7H4V9bjYxQTbTtVPep8KgLsmt7XfL1KoajH/+ePRRuo4ksSvSfnZhPPvDm73hPOoxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402800; c=relaxed/simple;
	bh=3fTMwuCEmz/gT+mkDaFxX8DyH7uqDRTTfI7UskqQ0Ec=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=EhTqd0/P55HKEKWM44BFdTGX9y8dBNnkii4Em14KeotDqbHUHafkwbveFugdjEjADKxVjPNZocodHU6C70+JVMJUTm5xM7nuWjVuPCYqvLUSrYBn0FRRn7P9iT473QnkvPiuVcxGUI2nF7iGdBSDCGwZXmVYwKsYNXiN+Ymtl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANSLZmFj; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANSLZmFj"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7f8ea864d54so119594585a.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756402797; x=1757007597; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AwW/yHLM4+MVUOFktVXcNftMF7mXervDLTY5nyNv0Vw=;
        b=ANSLZmFjI7qXskyiJzBY+if5gbZ21+b9zARNT7YVadqKZ6splstb7jT+dQdpx4IF17
         MDtsK6t4VGSBvdDaUdtWiw7KbBaUvN0Q5O6uq2RGgXgWZyQ2lpftTu1WfAzZAlT0953h
         4SIDc0l/B01zj/jDAzybfnxU8cjYbiWz5p13f16XkCNriJTjT7+/KKak5VUVfGGoJbrg
         bpghiI5fyaI+mgS/6vhEAGUY72rLbLpHgoCDtCD2MCallI6sci4mG8vjisCVIJRHEakj
         ywrSVGwB5Ua8+ywLSpnDR+NaxKScmdE2B1/IbtOjY43LwJai5y+GazeC4IpCKgKdzhVn
         EnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756402797; x=1757007597;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwW/yHLM4+MVUOFktVXcNftMF7mXervDLTY5nyNv0Vw=;
        b=vXDbDaybDHu7I85KySO1jG4VgSf8M+WKzbj+Q+q1HrtAx5iGJZlAIhN1gsNe+hwAC7
         cTDiIQjkO6Aa8g1ZEUsFO9PXnrxAV/zvtVQqVCKrunueEw/K5MyyVAHK563kATZzd1f3
         QSQN3wFnOX4AUSH1LaSJhcwdIhXIXknpACR91HxfYYP/FNjZzZP5L5qlgEvePQdVY0jZ
         cR1AeBbuE7iT4O+KUDF93+6zpM1RuCMxznwfGjhsTS7ysIU+NRQBwo4gJNn9v4EdK4vQ
         IVszSAx3C+moDFxlR37GDPwIh+Uf1gkHnHOYM0Dsh+//NBSetl7N6zCcjm+tSWiddbm6
         w3ZA==
X-Gm-Message-State: AOJu0Ywtah3Wte4y0eNglEqqRizGW6KdzCgkIZAkNSGcsSb+oiaqLFea
	dBWmh7hPxZKwjK9ZYeuhTITD4x5fAdDCiraY3zARebGXLkw3Zhz4NupvFpK3TrRr
X-Gm-Gg: ASbGncsliYqLlZBFvv7azNkI2pGAdylVQ7MQivNeN/ijnu7cCUABobmgWZ1/AA+JSZW
	U3SdX28+a3agDMcDKeGq+DJUu670W5pfBjJtXV8S6eZPqMrTgH/Pz4NEcrdk2WL7XMUl/Pe27Mk
	XLtegwuDmysv5V8aQbVWglFMlrp4vHv1z/uBQq2xaxtiYm8/D3rPFS8SCgto7SqDXrLk22WUzNg
	19Y8mzcPsEGQ/JUuUaUzn3tZNjeTxgDux3Z6bqx8ouJ0HgenZGDq2oLG82vREzbMyjIbHO98jwu
	2s0ifExm0ZDEaTdobC3w7VGPivJJV23EL7FeoC2VVn5K/f9IbGbTLDbFV6ohIn/gL3YVuA4UB+f
	QFtkc3siIHYnGgY44LeCqjJtT
X-Google-Smtp-Source: AGHT+IHF0KmU87j0dbNwOOCDajSfiOc+Urs8VFrwBIBIAAiw6w6GofJlPH/w+Ni7qMsB2QrOwwHeZw==
X-Received: by 2002:a05:620a:25d3:b0:7e9:f820:2b39 with SMTP id af79cd13be357-7ea1106e9e7mr2903945285a.69.1756402796818;
        Thu, 28 Aug 2025 10:39:56 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.244.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc14660baasm19200585a.38.2025.08.28.10.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:39:56 -0700 (PDT)
Message-Id: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 17:39:50 +0000
Subject: [PATCH 0/5] midx-write: fix segfault and do several cleanups
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
    me@ttaylorr.com,
    Derrick Stolee <stolee@gmail.com>

I was motivated to start looking closely at midx-write.c due to multiple
users reporting Git crashes in their background maintenance, specifically
during git multi-pack-index repack calls. I was eventually able to reproduce
it in git multi-pack-index expire as well.

Patch 1 is the only change we need to fix this bug. It includes a test case
that will fail under --stress with SANITIZE=address. It requires creating
many packfiles (50 was not enough, but 100 is enough). As far as I can tell,
this bug has existed since Git 2.47.0 in October 2024, but I started hearing
reports of this from users in July 2025 (and took a while to get a
dump/repro).

The remaining patches are cleanups based on my careful rereading of
midx-write.c. There are some issues about error handling that needed some
cleanup as well as a removal of the DISABLE_SIGN_COMPARE_WARNINGS macro.

Thanks, -Stolee

Derrick Stolee (5):
  midx-write: only load initialized packs
  midx-write: put failing response value back
  midx-write: use cleanup when incremental midx fails
  midx-write: use uint32_t for preferred_pack_idx
  midx-write: reenable signed comparison errors

 midx-write.c                | 118 ++++++++++++++++++------------------
 t/t5319-multi-pack-index.sh |  17 ++++++
 2 files changed, 75 insertions(+), 60 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1965%2Fderrickstolee%2Fmidx-write-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1965/derrickstolee/midx-write-cleanup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1965
-- 
gitgitgadget
