Received: from mail-pz2-f16.google.com (mail-pz2-f16.google.com [74.125.228.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D30340401
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610695; cv=none; b=XExrfV5QMdytoBhNqM34x51lh+lrWdNjHDpac8bSHq/13oZAZvX8yzDy4GV+6zwxNeLPKTe+bSBDu5YESt3G9t9wpx5pSJY+pzw6CispG1sgY525L0br+D6je01NZDRbeLuMln/R2umv4/e/82qB7yS6hi0vOfxiFrYQJulPW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610695; c=relaxed/simple;
	bh=GEv4+MdQ+PdOKeOYcu5krtL5DZaQJOt65m+Z68dCXYA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jXan8Y/s+SMvHZtgeeX6EOo6OPDR7PiGUrKVKNCH7XEiIMmwf//NKKKYOxdVkSE/9ZiUu9IQ6Q63Gj690D5UsF5MdIp9HBRdp4fn4FdTqp7VH0sDpUo4agIVZeEZw/yx1OdA8lawSFBWT85garVB5ynqUuP7l1xAFM5LGzVfWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2aqkREe; arc=none smtp.client-ip=74.125.228.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2aqkREe"
Received: by mail-pz2-f16.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so1159649a12.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610693; x=1791215493; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kjhY7y6F91PF0OB2F66DF9+J2mbs4nos6nXdtJY4gFA=;
        b=T2aqkREegs8ugsF+gL7sxqwnreCbT7dlPG0v+iWpp+PVsUc5+pRpjk+FOhr2X8tTXH
         83BxqQkVYbahvgE0nBomC8fixz5eOz9xigQWotg22xuIpkEFIFJrvuKwSpXyX0i1VbaG
         2GHGeO1D6mg6FCV729CBaJqNAkbhPOYjrMBMfYnMesMrSWgJbF1xJ+XwjUjPby7K1nox
         tfGQ+XpX0dIDfjdxh+71QeyDyVWuTWjBTrowbh+UjMgtNso8L7OI9pkxvXe/lUFZ5wv0
         WK2MvNaQQIQylttcrtha6V6O9FOslaXE2czE6USPDU0/q2GEJ+K8uAtMEbydVnYF/7ip
         BnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610693; x=1791215493;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kjhY7y6F91PF0OB2F66DF9+J2mbs4nos6nXdtJY4gFA=;
        b=1yJh2f9yFb7zdkguiNHgxyMKD2w1K8zYXjxrFziHlhyCAqCrx5f8uhCnv+RPLGG76A
         kdzS9htol9zFGM/vJP9rLNFuD4h6t2AzlaVFTDHLE7RK6nwACbyU5a9EKxK56xGc2sln
         AyszXuXSOjkY5Q00xXgC/YHPtWV6XYqBkNuYbkfXb9CYQzjUVRaAgoDdaQqpaLOBUXJr
         ZoeNK4jPJkefZBg2dpzi5fyHS1T1QHKvJMotu8QFwen7Gzgo7FgqeNccNB0HNu9Dc8ut
         HkALuL5afUpwRvMtLzDegmwChMzudhpIVPu7QxKoBJqpy8+7V5Jy2qLMGRcfMhlcgRQ2
         pKFg==
X-Gm-Message-State: AFuF++mNO/f0knZEPKYkhTv1P5M2cwCd/ReAxnLbpWcbv5CjuUSoDsym
	W87TpUy2gDDn1O45RcCIa+JoRmGDp7eJ7LjXMtUHwo1aSr7zKCiZSUWRc2rS4Q==
X-Gm-Gg: AYBFou1oFqkPfWIfZ8NTD6AsOfX6E+0yxpCl8VwQPRQP45MfirZ0AQ70rDBqwz1u5Ds
	jO9zUhlguj1f1JAWhmWG4phy0fmnx10RRqD4sCUyc9MMIHklC6AB41+xDtITUAwIX8BqKnfTYGG
	gt718JAyss7Ua7NA0ROSUfGdOteK9yGGl0HaomDUwQgJb2M81MbCyUqbI1hhWoAIFvO19WE+lgy
	nYPKJSD11Hvus9Ct87ebKYl5cqSvD4aq8KIcePtchmfcZFOB6B0cSp9UbqRTMLoG9eF0+PdgO90
	uBXRrVTSZWVEkjbSpNMrsGRPBpVHgFWZa5jaUuJe+llh289pjj7Vcs6zqURqSi1OVwEjFxK/9HM
	AAzFMez+m6rbmJxdkDhpPN97MJQpVAPdWMmxRnHTeqgRw5Frn/+y3IBqhZ6f79Bp4iSHOuQtifS
	8hqR/avn/ABFenDfxQb0f1HPQGkoreZKd19+Nyexu/Huw/NUNNX44v1Ot852MOcLqDyHmwnrTW8
	Q==
X-Received: by 2002:a05:6a21:828c:b0:3dd:f9ff:f5a with SMTP id adf61e73a8af0-3de0e713cd1mr10598099637.9.1790610693190;
        Mon, 28 Sep 2026 08:51:33 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.102.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-882ad656fdcsm2098982b3a.18.2026.09.28.08.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:51:32 -0700 (PDT)
Message-Id: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 15:51:27 +0000
Subject: [PATCH 0/4] Add a compile-time option to use the new, very fast sha1dc Rust crate
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

I stumbled across this new Rust crate last week. Its performance numbers are
quite impressive. Naturally, I want to make use of this and get for Windows,
which is used on many monorepos where this makes a real difference: In a
pretty fast and loose test, I verified that a git index-pack runs roughly
three times faster solely due to using those SIMD-based optimizations!

As a safety precaution, because this sha1dc crate is quite new, I wanted to
introduce an escape hatch: core.sha1dcBackend=c, but turn it on by default,
which is the reason for the three additional patches. Should these patches
be undesirable for the Git project? I would not be mad at all if they were
simply dropped.

Johannes Schindelin (4):
  libgitcore: add `sha1dc` as an optional feature
  sha1dc: allow selecting the C backend without rebuilding
  pthread: provide `pthread_once()` shims for Windows and for
    NO_PTHREADS
  sha1dc: make `sha1dc_init()` thread-safe

 Cargo.toml                     |   4 ++
 Documentation/config/core.adoc |   5 ++
 Makefile                       |  29 +++++++++
 compat/win32/pthread.c         |  16 +++++
 compat/win32/pthread.h         |   5 ++
 hash.h                         |   5 ++
 sha1dc_git.c                   | 109 +++++++++++++++++++++++++++++++--
 sha1dc_git.h                   |   5 +-
 sha1dc_rs.h                    |  37 +++++++++++
 src/lib.rs                     |   2 +
 src/sha1dc_rs.rs               |  78 +++++++++++++++++++++++
 t/helper/test-sha1.c           |  19 +++++-
 t/t0013-sha1dc.sh              |  21 ++++++-
 thread-utils.h                 |  16 +++++
 14 files changed, 343 insertions(+), 8 deletions(-)
 create mode 100644 sha1dc_rs.h
 create mode 100644 src/sha1dc_rs.rs


base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2240%2Fdscho%2Foptionally-use-sha1dc-rs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2240/dscho/optionally-use-sha1dc-rs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2240
-- 
gitgitgadget
