Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FB262807
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732996; cv=none; b=J2Ra6OAA5mwktPDJXMg0cK55tIqdUEr+OeCcqUB0nkQDc5DV9VEtse8Q1LsXWacoiRAT91a9ABJdA6ibKf3veHEqVsXFYYloQjrBUVuSBAEFu3yCHGu5gZFqk0UTDXAOrRCDqwcn1M8aGdCSFg/YI/n5PyWVMMvTkl6MUYU5J68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732996; c=relaxed/simple;
	bh=ZcbuYFgxpAYBKnD12RpDKzu8rlFCC3ZKRu1LCjjkqcM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SGmJf70AU/fR5q7eDNMSmekOnFk2/J+YnXX1ThgIsFOMkTJS5sCqQ+BuYlobbjAkU7K8pLpS0sbiq8gQlhTKxLDVB3ycX2dzzYY5QVUtvOSu7s79d634qY5bVHw4sJh3iM1DMjhH2qol+FAfOdhkDb6ii0NZIIdUq1+LFdu6uiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POPYd41N; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POPYd41N"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a375d758a0so1152827f8f.0
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747732993; x=1748337793; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+tt/5j68i8D52Nxn51Ia91D32+EPDn1zKmAKYiqA9U=;
        b=POPYd41Nf4bzoJOdR+wuqDPLdPMpnOjVhS/UUUQPF2dM/C38nOCsAT6eyHF5DYxyMw
         iMZAF7tC6dlZO2btkly0T6Q5MnZuAiB673bp9mQQSS2CQNuicBUZ/P3uw6NCW0hARpbn
         vGDBPzRAc+0s5+CJwIYWubOhj0y8jpyZcryuFTuWVBeCer3nhWUJmaNjGyKdMo0yf1WG
         Tk8EwOgh28FUu8Ly/rDDwlLR5v1EMOTaOsvQfpVJBflxkluYdlJlygNqWRi9pTHXvbB5
         VmBL4L6cqjfr47YAYCRgftfA6UkNtsWN1hqU2Z0nH0Ek+8OM4v5acwdFk3mrA8jaNiJc
         uZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732993; x=1748337793;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+tt/5j68i8D52Nxn51Ia91D32+EPDn1zKmAKYiqA9U=;
        b=PXzepMXPRIIkjQGSnvubiYhZZNZstw8B4SquwWLqRCiT40Kv5KMkXg2DmE1FNx+xkZ
         2ldkvpoRvrCTgr7D9xoob/N1EB54ml+kNJevfhzYf5SW9juu+ah632IAHSaDIPWpH5kL
         awJJHRgtPli503zWNlIM6sPvtXM6CsSOMS8fyVlunSdLU6URoZzTi84tOFSFXaVBlqgs
         7pJ+UK9yJ8gzWZG0m3gG6jbmfzjN5NqxSEgLg06FHYz1q+dfHYqwEyrTxjzTogdCXvFw
         SJEHnTm9gnAtW4N5dR/f4ZBvae/xh5uIJuDJeZOhro7zQHAWK4JEoIpA5GiDKokiOqpH
         8QAg==
X-Gm-Message-State: AOJu0YxhKzs3nOlyJJ24Y8ibYd4ad9ajmIWUA80JFxl3BX3R6LAchp3p
	wbqG7MOTfvp2flWq7086DGbaDLZcpBFyMo7LxV5RJEkttTUdX1JvFSGRIb+14g==
X-Gm-Gg: ASbGnctOowyPfEiU3efH/QoG+Vs/feekesiOLOtBAEqVgzA4VK0GpK12xHVF9270RPB
	0DmDnKICKbxyUtkx5Yf9BAY7CubrCxMUI0LuQVCmA5UQ5hbFzqPsMQVjVxw+20dWi+o8UOjMMop
	5e4mEvKn2N7vT0zfQTwwmBdwOsdGnwK55mAxQ5kZX2FO9nusLYT7lQMCCdrn8jhG3LuTVE4yjbN
	sfQs7AW0OOtEIx7Tf1X9u674V0Ach8vDS4KTOCoHqVqzm9WMUzle0HLheLx7TUkjuZVVtvSlSs4
	sB2wrTUf96O/uhdO0thcSvkVvogpHgwC0Q3u6/bhFVcjJj7ajmBOMS+J1AeJowA=
X-Google-Smtp-Source: AGHT+IG5IeDqp8jyrXtOKT3Vs+RbebQoMXO/4EfLE+yBYKvWHeIATN+BoVejoCiB5pP0EhWSxefZww==
X-Received: by 2002:a5d:64c7:0:b0:3a3:64c2:2a8b with SMTP id ffacd0b85a97d-3a364c22c3emr12321608f8f.49.1747732992847;
        Tue, 20 May 2025 02:23:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88957sm15528423f8f.75.2025.05.20.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:23:12 -0700 (PDT)
Message-Id: <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 May 2025 09:23:07 +0000
Subject: [PATCH v2 0/3] pack-bitmap: fix memory leak if load_bitmap_entries_v1 failed
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
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:load_bitmap_entries_v1, the function read_bitmap_1
allocates a bitmap and reads index data into it. However, if any of the
validation checks following the allocation fail, the allocated bitmap is not
freed, resulting in a memory leak. To avoid this, the validation checks
should be performed before the bitmap is allocated.

Lidong Yan (2):
  pack-bitmap: fix memory leak if `load_bitmap_entries_v1` failed
  pack-bitmap: add loading corrupt bitmap_index test

Taylor Blau (1):
  pack-bitmap: fix memory leak if `load_bitmap_entries_v1` failed

 pack-bitmap.c           | 29 +++++++-----------------
 t/t5310-pack-bitmaps.sh | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 21 deletions(-)


base-commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1962%2Fbrandb97%2Ffix-pack-bitmap-leak-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1962/brandb97/fix-pack-bitmap-leak-v2
Pull-Request: https://github.com/git/git/pull/1962

Range-diff vs v1:

 1:  00168766edf = 1:  130c3dc5dcd pack-bitmap: fix memory leak if `load_bitmap_entries_v1` failed
 -:  ----------- > 2:  b515c278a8f pack-bitmap: fix memory leak if `load_bitmap_entries_v1` failed
 -:  ----------- > 3:  5be22d563af pack-bitmap: add loading corrupt bitmap_index test

-- 
gitgitgadget
