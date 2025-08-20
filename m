Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903C277CB4
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755715202; cv=none; b=A35iJe4kEYajjWiHV56mCVaq4m+Tp8OkxwzKtbpSTtHMAPcjJp954kPqrFpJ3NB/1o4ypXSwzfxGOKsSp2o+gG3gH0E8MFibmuO+FfZupdlfNfLXSWmLOOW7uPl6JgNu2iT45OiGnKoeg+0H05Z3vg9oORIRcm76aTWLGXIlWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755715202; c=relaxed/simple;
	bh=JxT5Y9fcelh/EQzSFAMQPfb604GJC/DqqM3jYMmv3lc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=tREJQfpcJtS+3Henf3wM3gcBB6FauDWG3Ey37+Y1IjJ5bQvzDX1+CegJVpcq5FSPEy50jAKQM877EWHmdmgXZ1TxrbDStHXTWqaHl0HoZEz9pLvlo+8XFv91f/oQinZiZ3rjj1SBwb8kd5YaNRDFox1jtUO+5gNjneo2cPBfakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENgxuI20; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENgxuI20"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so150159f8f.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755715198; x=1756319998; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFLh6xwa33UajaI8/cFLDvSFsIIpHtBCGTEq99ixn2s=;
        b=ENgxuI20OFpYXCCtP9y0uVIzoPyQn9jvK8kSw1MCtpEbpkbMFtMZCZ9HswoTev4C42
         GQaV8ix7GcNYOdIwrd1pF/WWd6i1cH9r7Rqqg5l98fU2ZiGiS8EcpEqYYaqqE5N/Q+XW
         jssiN8W21XfPlqH9XY33kNShRifx7kI2OkevrDP/qFy8mX+ZHztw6MQW/qigh7o9YF6M
         6QaVUS94ZrBoaQsSR8LrJdZLaMApsDfBMM5Od2Tw3ekwrx2SL5U3iVI2mCfYZ1kD7Ece
         cnF03bIeHp4PPycgeXEcjdcJFioBVijsQNsn4kBHSZ3opEUwPJTx8SSpUCqxG/Jrq+UC
         welQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755715198; x=1756319998;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFLh6xwa33UajaI8/cFLDvSFsIIpHtBCGTEq99ixn2s=;
        b=KyV+xjlqQutXVqFIdona20wzOJeru6Wa7+v+Ngdgg4Vn9Sa4Tm6PoKPHr3/8WuokHr
         0eT9BUW3LmU6zIpVKoDpcYQLn4RhMuGI1EdADHFEfV8T7nF1YOtkq510t9dHMWL5qjdg
         empGVweiWaRbR2SWYeFu5CsLdx2hFub8ZMUgKAYZgZQZdyiHfKswVwf3YV2AqR5O2GTq
         jDR+cI95RjdiA+sKflHDcLHALUYmGK+010LAAGmTZaq9zgZLBezQQISn/TLM3P40gV29
         B4DE7+Hm9FL5h5+6ESG0SjqPA2s07537tgzKh8lG2xkn9MOckSjswn3zwVWXe4pUljTz
         aszg==
X-Gm-Message-State: AOJu0Yx3Yu65yN9VY3pIsnAUSyCKTyie7tMaM4bVAEbGu/o4lBV6RbAN
	fk0ixoQXbn6lXW0SlUpCPs9abvrNX3fVUQbUyDlSyG7AOR6D0a5nh9Fkg4EduA==
X-Gm-Gg: ASbGncspCzUqtScwWtWw0U+EhKj6aA00PTR7LKG9j/RXDuRh5/mm0b99atJm1aoIRp0
	tEJh52X3sLFaMAIdg9FeQjdcNOg2eynPsaIxY/fLhV+EjfQ4FXbY1HX7IxS34rQUdnFUetUpv3J
	NvGK9wwW/jQzPL2JRgsSt+9zLhJkAVGtimZ2bavX9z/9WvtZqShdqx4VxYRFoslSyfmdQRsFrZJ
	p/59BR1IJCPz2cmEj90jF24Ezi+tQHjxkCAyyJaKm0nznTHxu59OXWy+g6UsMqkmX0+KCDPKo2x
	2eHEOXo2gHKSdhPxS06gNn+rIAVl2DsGf6OHk2dFaozOJ1EBC4KfsfiHwjRxSuMJJDIHx5toNt2
	PJakgK5NjnRja4VJX6o4poA7LcrpDoRfv9TyAS12CdOrPzt8w
X-Google-Smtp-Source: AGHT+IFnP/JcD0oOjeSMFvqevDnpuvAIy1M9HwBwLWuQbPuLJNVW9nQ8CIcOy7a6fIm9B+MmWFVivg==
X-Received: by 2002:a05:6000:2502:b0:3b8:f318:dc61 with SMTP id ffacd0b85a97d-3c32dd5c6a2mr2600649f8f.40.1755715197966;
        Wed, 20 Aug 2025 11:39:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c31327sm42506305e9.8.2025.08.20.11.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:39:57 -0700 (PDT)
Message-Id: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 20 Aug 2025 18:39:53 +0000
Subject: [PATCH 0/3] [2.51.0 Bug] Missing singleton objects in 'git repack -adf --path-walk'
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>

Now that the --path-walk feature for git repack is out in the wild and
getting more visibility than it did in the Git for Windows fork, the
following issue was brought to my attention:

Some folks would report missing objects after git repack -adf --path-walk!

It turns out that this snuck through the cracks because it was pretty
difficult to create a reproducing test case (patch 1) but it boils down to:

 1. A path has exactly one version across all of the history being repacked.
 2. That path is in the index.
 3. The object at that path is not a loose object.
 4. pack.useSparse=true in the config (this is the default)

It is also something where users don't necessarily notice the missing
objects until they fetch and a missing object is used as a delta base. Doing
normal checkouts doesn't cause changes to these files, so they are never
opened by Git. Users hitting this issue can usually recover using git fetch
--refetch to repopulate the missing objects from a remote (unless they never
had a remote at all).

Patch 2 introduces the fix for this issue, which is related to forgetting to
initialize a struct indicator when walking the pending objects.

When reflecting on the ways that I missed this when building the feature, I
think the core issue was an overreliance on using bare repos in testing. I
also think that the way that the UNINTERESTING object exploration was
implemented was particularly fragile to missing updates to the
initialization of the struct, so patch 3 adds a new initializer to reduce
duplicate code and to help avoid this mistake in the future.

Thanks, -Stolee

P.S. CC'ing all original reviewers of the series.

Derrick Stolee (3):
  t7700: add failing --path-walk test
  path-walk: fix setup of pending objects
  path-walk: create initializer for path lists

 path-walk.c       | 55 +++++++++++++++++++++--------------------------
 t/t7700-repack.sh | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 30 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1956%2Fderrickstolee%2Fpath-walk-missing-objects-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1956/derrickstolee/path-walk-missing-objects-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1956
-- 
gitgitgadget
