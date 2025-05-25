Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDB28DD0
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748198512; cv=none; b=FbxjAd8LcxZRnTK/D9GE40C6mkaIPPKIcfmsF6tBZXp+DODs5HeOgTGUc19ZsiBAjpIGfcAa0aetDkou6NRHYtFAW39l1tMvyjv0Ke6ahdJ7e0ri7AM5+MJHkgdAscvYUf/+ZxD61IlCyC7AW30lT82xyCBu3CQQ5ikeMfptjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748198512; c=relaxed/simple;
	bh=69jWABLnX3VjGNJM3dJw2kHouyj03EOdjgT//+A87gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8UkOicdwkB6Sou1PYCkCH6i2ToYGJ1Yv5wXhwhAgc/lsqvnH05AzQ51mh+euWySoZXKlZ5MTShqRJZja/KHgWWGpdiwfQqatARBsuQVFN6TNLUzqVp0sVp9FiJpDRIrNDiB/1czn3sKZcMQb6BuaKz/ZCbLNjBhDyiYAcrq/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IoA+Xp8C; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IoA+Xp8C"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7caeeef95d4so143858585a.2
        for <git@vger.kernel.org>; Sun, 25 May 2025 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748198510; x=1748803310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBUYZSHWdA+a/uicy/zMf+4Wb3veM2kkMdajiq3jlwI=;
        b=IoA+Xp8CpULVBwoDVtIdN5yyXNEMS1scYfcMI4ZJktLC5o42GE/EIFzU5fgRzOGW2j
         99mLSqFj9BHeX2qkkayrecmZwQ3APUjsOj2CBki+kFQXYvh2OTThOmi8yYxoGtJUa7c3
         Ke8wVAj5BRRq75R12gOTRsFFyFuinIdbXc73fdEhLXAyOB9Lg0Mqk3lheKUsa5pDHeVC
         n1bZN0WaYm1zal6Wuf23DwWMCXWHGnC6y/o9W1QTuSebFoyfMIBcGa42BEJ0kOIhtZ0x
         GMPv4t+xUE7GpaaPLQsm7QS4dvkHOjIF2CgqvPvgNQDyyJC8AGlCt0fX2sqMvT6Wk5kQ
         vAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748198510; x=1748803310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBUYZSHWdA+a/uicy/zMf+4Wb3veM2kkMdajiq3jlwI=;
        b=s5436fpNP4WZm1rRrRIfp3sJHksoQimABfeh/WEFMHofhLB62t41Qjxsi0ecK5k02L
         F1kMGqxgDD8ImKvea3Mw26V4S3j1eaMFRwcWOfalBZFoRY3xCTC000md/qtebELS/rgu
         QSyKrRXsaLoIgXse9TONDaaHyp674bDXq+A44TmiZjLfBaNo0bIwcdAEBY4UnwkSzwXB
         PmjHvHKt/0HpSIJpdsbBkzwD5+01sK/4I1QWufJUbBQ6xQ3hvT5fAxjk9PauAs5UiJq3
         L4Z9Lua2oW1WXGFOH95atz4QZVZ81F6uRdWgq7Rhu/itql5Fl2prSfrSfV+j7IRb9VvV
         10HA==
X-Gm-Message-State: AOJu0YyPZW7ZZF8hPnbRpVA9shukowU/SYMoNVn0qiQX5cQRsMiuujxO
	/bs7hQzcPor8A22rLpirPrMUJE/BC21QHeDmZDNzxlraqLC3j94fsPXvRoEXVINoiJ7j2lqGRox
	B7qhH
X-Gm-Gg: ASbGncu7fqC8hNPUI0F12lYXf40Hlh5vU/1rZ1/WhUGxHhGoTPGEDsl+UF5F7od0lMU
	MLUuAfMvttirWnq50uFzEJZUphKYYQqqDTmh1BmIfIYqX1K1JGr5PYscUva17Xx9m71D5kwBPRq
	SWm982E/fffTNTsJOWIiMCnxJKuToZUAtjF2TLwNCZWtNeErbAN/9OWRJ+75ZOBpOGeqfT6QbD1
	MkFHTLqbpuvDv8ZrS2kGR4qs0fC3ROayZw097xJQZx+08uiJU2C0m6+GEv55z9iqmq2InemEiXf
	w3pgI04c55OQmFnbF3lN7mFaFCZqFYRY5oWVnWlgWy8NjQppAyvQuYygbmCVFP7hHkdjGXYYU5p
	LfJ4uNJQ3VqDvheYCnkH0kx8=
X-Google-Smtp-Source: AGHT+IEl0jv0hpnVAgRIxsq85oY5ucyCdU6Jbbfdzzrqag7NB9sFJMPQBxeAO0cfJmYTjLuOb/aFzg==
X-Received: by 2002:a05:6214:21c9:b0:6fa:8c15:75c1 with SMTP id 6a1803df08f44-6fa9cfe74cfmr134025816d6.2.1748198509671;
        Sun, 25 May 2025 11:41:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6faa48185bdsm13540046d6.6.2025.05.25.11.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 11:41:49 -0700 (PDT)
Date: Sun, 25 May 2025 14:41:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] midx: improve prepare_midx_pack() ergonomics
Message-ID: <cover.1748198489.git.me@ttaylorr.com>
References: <aDC0bK+NOuuVvQtb@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDC0bK+NOuuVvQtb@nand.local>

[This brief series is based on ps/midx-negative-packfile-cache].

This series implements a suggestion from this thread to have
prepare_midx_pack() return a pointer to packed_git structure identified
by the given pack_int_id.

This convention makes converting a pack_int_id into a bona-fide pack
significantly less error-prone, particularly when dealing with
incremental MIDXs.

Along the way, I noticed a couple of opportunities for clean-up and
light refactorings, which make up the first four patches.

In the future, I think we could take this further by:

  - applying the same pattern to the 'pack_names' array, and

  - renaming both arrays something like 'packs_' or similar to indicate
    that they are "private" and should not be accessed outside of
    midx.c.

We might be able to go even further than that by making the entire
structure opaque to external callers by defining it within midx.c
itself. We don't get there in this series, but it sets us on the right
direction.

Thanks in advance for your review!

Taylor Blau (5):
  pack-bitmap.c: fix broken warning() when missing MIDX'd pack
  midx-write.c: guard against incremental MIDXs in want_included_pack()
  midx-write.c: simplify fill_packs_from_midx()
  midx-write.c: extract inner loop from fill_packs_from_midx()
  midx: return a `packed_git` pointer from `prepare_midx_pack()`

 midx-write.c  | 114 +++++++++++++++++++++++++++++++-------------------
 midx.c        |  81 ++++++++++++++++++-----------------
 midx.h        |   4 +-
 pack-bitmap.c |   4 +-
 4 files changed, 115 insertions(+), 88 deletions(-)


base-commit: 73fe0882eec06f7b9ea021fe062a32cd1731e574
-- 
2.49.0.641.gb9c9c4c3bd
