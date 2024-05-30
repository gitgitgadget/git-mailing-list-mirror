Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43094183086
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072088; cv=none; b=bXZCiHOyyxr7LxLI+aGzll3sWftRm2iuI3JUqp7quuHwH45tcpZ4zkQvnZ0o4Qq6mWEHGJ08cMpJnKny735vK1vzoHGMLMudZBYWX9xtYmk68D/LohweNUsk4u3juBg4XhgzOLi1yF3OFEK1yJp6YCWk1E6391cQ9leEyBIcfyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072088; c=relaxed/simple;
	bh=InPeg5jDTpTAgwapUoYtZ3Q4ZPl+sDy0QXT3acuZbA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFa0J9oI6OXXuWtnmWdFST0hNvank8yLRwnbdeJJEMARjv1DnI+ZmGdT2SjyfmKZkNtYVqV2yoXkyx0yUDlgpNDgm0OuN/P5xURJOiBqwsave8l+cEssB6f8kbHrSPxgHcJqYQiVxdOxbkYIRwXquisjJxoKywmi2LfltF0wDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO1rHGSz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO1rHGSz"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7021ab0d0f5so708608b3a.2
        for <git@vger.kernel.org>; Thu, 30 May 2024 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717072086; x=1717676886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dyH7pqaWDgPFQllQx1h8FapBaFN3fRTn97eh2WEIf80=;
        b=DO1rHGSzPaAIIqyOOoUNP2jyxboZrPkBX5DB0zsAnKOhqEgW4pBNV9mV/G1W13NHqD
         7trCGV2JP4zfuQC4bpDRpdNqakH3vxKaPwCEOCTnLRhWVsXZMVMwKCrKogGPvtrsI39y
         wQOdNyL2h/qy0WcD6rhfzGxydlqG3h9D+ec5Z7jr57pQADWnOLtPDHhUkKXDYzFv2jjl
         XsU0+J7+AhImqGgcWgfMKguqwmqV8jl89W8MxX/fywkdt5mTuMth2mKlxV0qkahFtbhf
         52FoXl6995HsymOO/8O5C36K8XdyJzoee8Y7fzDgoCwzJfhQQal4BOLSz6wSEZMPm0hC
         zGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717072086; x=1717676886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyH7pqaWDgPFQllQx1h8FapBaFN3fRTn97eh2WEIf80=;
        b=PEgLEblLzabnmj532GlPNZjSjuC2oVK35fRNay/YwdLz/qPm5DuZYuGHHDiMAM4rvg
         6b+1lj9AxEbVd4nfP9zWnkxaD/erVB9zy7i9qMucWPTC2kcVbl2R4V+HFvi64HUqbZrW
         IB3ogGRrX4RSdRjcqnd/ymDbKLbgTglttmOGBZK6h5Tx43PwOUUVj9Kn9UvJpPqVrPFo
         qLj3y6/EN0+BEoTFCa8aT6mylbWW3h9auqe7GH/37gcyjwbmkg9xyTEXrwyxXkw9Rat7
         C8W39Tp1esuNYDZ9LSvEfCOI5IBForsEzV6gdJ2ArwMeSZ5rXUPo1EY3TRL7gnBOxLp5
         XhKQ==
X-Gm-Message-State: AOJu0YxiWnj5aYO7MDHnsv9TEjt1+JCJpuDXSw467S8Gst+Q7ADfC3Qb
	tdKgyadu3LYHTO0hVW7GE6ZMkehfVwkCBqzV6BhMoGNtkdt1sMId8wM+o4+O
X-Google-Smtp-Source: AGHT+IGO3ikyZB3dlYvSSYDbMyunCq4HgHpH8N5hmhc8fig6M6ciSMmxnY9VVjFgSF3qJn+3S+8Mfw==
X-Received: by 2002:aa7:9302:0:b0:6eb:3d37:ce7a with SMTP id d2e1a72fcca58-702311e1504mr1653695b3a.21.1717072085891;
        Thu, 30 May 2024 05:28:05 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c1f2548c7dsm321176a12.20.2024.05.30.05.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:28:05 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH 0/2] ref consistency check infra setup
Date: Thu, 30 May 2024 20:27:51 +0800
Message-ID: <20240530122753.1114818-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch mainly focuses on two things:

1. Setup the infrastructure of the ref consistency check.
2. Implement ref name and content checks for files backend to verify the
correctness about the infrastructure with corresponding unit test.

See https://github.com/shejialuo/git/pull/1 for CI.

Thanks,
Jialuo

shejialuo (2):
  refs: setup ref consistency check infrastructure
  refs: add name and content check for file backend

 builtin/fsck.c           |   5 ++
 refs.c                   |   5 ++
 refs.h                   |   5 ++
 refs/files-backend.c     | 119 ++++++++++++++++++++++++++++++++++-
 refs/packed-backend.c    |   7 +++
 refs/refs-internal.h     |   4 ++
 refs/reftable-backend.c  |   7 +++
 t/t0602-reffiles-fsck.sh | 132 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 283 insertions(+), 1 deletion(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

-- 
2.45.1

