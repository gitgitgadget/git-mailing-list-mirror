Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190C1EEE0
	for <git@vger.kernel.org>; Sun, 18 May 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747583757; cv=none; b=tUc/y7PD3BlaAb0ghU8VK04NCt34u42OljLSq6oALjNRD6XIejfIKuOAp/lsxvScjvqWNTMhB3WUl6Z/2o2nYqlPDLxtgJFsBRpotJ/9W4WmosYs/ufkifZCUHxSsGBFLv/+uQdyvpvZ5UaNfCOLZcg66xsQ2mLHikyfCnzEzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747583757; c=relaxed/simple;
	bh=6sbp4wCeOk/bpR5XcLC1jq2jLNB+gdX6nFdvFGLxKjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU+cemiA0PP0GDRB1BFsOpvTaGbm36afYi23lcLr+VDdGiZzu8u18H+SXUvV6FHHlYbtq9NfjwlGe3depDHJHoQzkJSyXEkUl2tvc2LNayMB9J5yPaAWiP/GC614J4ENSsf/alGvl4jORh55I0NgJ77IyzReCKmZ5329wP++SRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbQJB7vg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbQJB7vg"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3814295b3a.2
        for <git@vger.kernel.org>; Sun, 18 May 2025 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747583755; x=1748188555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ARlJ3xJnGVD28bjax8fq1AsB8NdXcHjYSLazR0G+/Kw=;
        b=jbQJB7vg02fe605s1+yNEwgbViWEVJ2sslL7C8KMyG4YZaRBlTiHkeMptEzp2GXLfg
         wDD2FvRXgs/0mjiBZnpChFrdO5AK4VTy6cEU89NWKQ1kCDs2csrHLkrWFjVXQet3hcfU
         bsY7Rel5HYe2fbtqHg7IhZO5AWaf8nXUfo5HoEz1JsT+0pngrqntgk43c+WgRh9yL1Jw
         PIhPl48crlWC/IRqsuhi4bFEZAiW0h99EmyjIBGSCgOry64NkL7UZJYAfaWCddhMtJzZ
         16kVy9rNKko6G2XwYoGPKP1oYNdh337pkiqWvw08h42/MT7JVeP9U6pGJihQyHnHwRIW
         yvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747583755; x=1748188555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARlJ3xJnGVD28bjax8fq1AsB8NdXcHjYSLazR0G+/Kw=;
        b=ZD1/tKcu/kp+o5TqJ06/O7pBJPoERxhTaeepDys3p+9wEr0PAuzbfRhAA53EAgu8Oh
         4Cf/haJAj31RoWfSbRcwqxlL8j++2qSYP3CrcC5MN/F51n/LUe/vXirbjrByhsdM1meK
         g82GuVN1Toksodl024HKxNWx6MT2aBUIhXVBPdhzWI5GJc1mCv31944Pl0CgCqQLdvaz
         m3eMLlQLA8MmtELmKaRiZKUCy3i7ItWv6F3qjMbmRAPCJXeZn4F40WGbUyLB0MacdxqR
         v+AuKcmjtsgg/+5UXsx0AAzymTmPIf33dOHefwDWqOrxCuRnUWNnPAUoQ9E+bDrKmhE3
         Iidw==
X-Gm-Message-State: AOJu0YyELzKZBR30mqHcZFWfGn4XIRVQNXduDiXK3xKGDahofb6q+fe7
	xXl61z9pLxOiNh2In+ibKsvOmihf0IXbkNcpjpPPnGKmIMvCkbmwBeT+MbLIAJSdGMk=
X-Gm-Gg: ASbGncsjdZoMQc9SvMS8WGyPZtAr9xfiTm2WBxvHPooo25bmqnaStbJ6wXQQ9Q1d37T
	a/4mb9Trez5dW5xJOPeHvYBqGGOMIzR0zYvwfmoB4T1/BqgS6skVTUPipm1KQCKW6yh84mHD7i1
	9wj8h/zbdU9dojUJ3cAbOLcGWk/RZ2L0R2rToqQzvdheJ8IM/EyUe6mSWRzKCHTctE7wa3WZfj0
	r8fA7KOInAYIOjGENHH0m3/X3h4MaGywX5LqQxK+oe4rIO41h+fVFwAvLy/VPl6udTyw4xL46PI
	EmH9kK5WxmRN3lmbDUex2R8llSPYHxCmrOmWV+VejDZkXJc=
X-Google-Smtp-Source: AGHT+IHjJ0cvOKtOLfLpsrmzIZnLwtQwGiFUVW+GW2OZn27DmaDq5FaVAvAbonwj8+PzUQzfVEQBIA==
X-Received: by 2002:a05:6a00:3e14:b0:740:b5f9:287b with SMTP id d2e1a72fcca58-742a97a7195mr14020858b3a.1.1747583754668;
        Sun, 18 May 2025 08:55:54 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a982b88fsm4834464b3a.103.2025.05.18.08.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 08:55:53 -0700 (PDT)
Date: Sun, 18 May 2025 23:55:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] enhance "string_list" code and test
Message-ID: <aCoDB9P5XV1lHMil@ArchLinux>
References: <aAetW0dan8S3Fljq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAetW0dan8S3Fljq@ArchLinux>

Hi All:

I finally finish the version 2. And I don't provide the range-diff due
to that I add more commits compared with version 1.

This patch could be organized into three parts:

1. [PATCH v2 1/8]

   Fix simple sign warnings of the loop iterator.

2. [PATCH v2 2/8] - [PATCH v2 4/8]

   Remove unncessary code, improve the logic and finally enable sign
   compare warnings check.

3. [PATCH v2 5/8] - [PATCH v2 8/8]

   Remove test to the unit test.

However, I want to tell Patrick a thing. I feel hard to remove the
performance test. So, I leave it here. The reason is that we want to
test performance of "string-list" sorting.

Thanks,
Jialuo

shejialuo (8):
  string-list: fix sign compare warnings for loop iterator
  string-list: remove unused "insert_at" parameter from add_entry
  string-list: return index directly when inserting an existing element
  string-list: enable sign compare warnings check
  u-string-list: move "test_split" into "u-string-list.c"
  u-string-list: move "test_split_in_place" to "u-string-list.c"
  u-string-list: move "filter string" test to "u-string-list.c"
  u-string-list: move "remove duplicates" test to "u-string-list.c"

 Makefile                     |   1 +
 string-list.c                |  48 +++-----
 t/helper/test-string-list.c  |  96 ---------------
 t/meson.build                |   2 +-
 t/t0063-string-list.sh       | 142 ---------------------
 t/unit-tests/u-string-list.c | 233 +++++++++++++++++++++++++++++++++++
 6 files changed, 255 insertions(+), 267 deletions(-)
 delete mode 100755 t/t0063-string-list.sh
 create mode 100644 t/unit-tests/u-string-list.c

-- 
2.49.0

