Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB43C1F
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680969; cv=none; b=BpEn3V+z3r2ojcOqHGbd+G0Vo2NcLBE2U0xoamFeGcqrd0b1aQgCnOzr9h4nV8aHUMzIsv/hIn8LT5B+gMl9hlKv2AlTMnh8+D/RQu8TwJ01YrinKQ2ffbdP1hpN43ducFM7JnDScz7EnVHSJfM2oixbK5gJg2cEb2TKuVuSdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680969; c=relaxed/simple;
	bh=HQ+4N7IcgV3vAZjVha0xTnOI7M2Asoug2frsaT+vUSs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dYZDaMn8Pn00dEd3icnJwlr8T5cRxi+lK3AkbFCO/gGJQKw1HF1yenm/8WpL0TAre9lALieQWYTfySoN6S0LpxlbtBMUsV34IcNCcJM+H2JQzMGbAXTJiWNqyaHyuHCGjrQ1WlyutglrcNUY9sLby4PlvfpENP16l7MFTkjsOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qHMXmT7K; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qHMXmT7K"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fd2fca1cebso8498847b3.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740680966; x=1741285766; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lz2qHD4ZafE/rKyCZ1mhSBXXAm4hSWn0V+G3xsNfa0M=;
        b=qHMXmT7K63gNw5m5lTIUDEgQt79nYNo4F7aYAel0zLjp6PoKy4IALAuX9+rvWY9GBt
         vHq8j21Fj8wS759bobwUuJezZk0bry7efcT9e/SyguWOtBelNnss6bh3PEUjZKZqKKH8
         /FdfOoqYqs/OpjfgK7jAPgbFCjNF/I8CKgsoVVns/G+b+SnG0zMwXtHZaryBGtnM07uN
         Ax0ljnhIqV8mhJfkkVfIGNgv5s2aEcaIG2/Cs6TSwD0TDP0CLBevbTzJsKhpuvMlwtwD
         I5saIdV62fKzH3fy7zdV45IeXM9WuKc1rSEqwSMlYcEr8E92PP3cD2cruy3PVnCw+qDE
         ktZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680966; x=1741285766;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lz2qHD4ZafE/rKyCZ1mhSBXXAm4hSWn0V+G3xsNfa0M=;
        b=Q0V07SSgEQZwQLrKQzOW3P12U5j1wpINVFHJriZS9Ly3/R0Ac6ST1e4wfTB+b4fENC
         4h2zv8zitN9cGBuZtHfWucX2yidxLr96NWJ+lKRcXrNlHogSMaTSnoipXoOIudQVbSbv
         3pP3NF/nyGE08x5pckar9anWDD0ZjUDJFfcgV6z81CEjEHV90h1Lg7sEMtQ/uf3QMzvL
         vzxLc0oiiYkJXQrgWutMr+XJ0LgctQuVr9VwoHoWw4J/6IPuiuQGcSb+sp+iJ/Wq0xUK
         Vn+iIQCAvFZhQq5c2pH7Y/2ScsaytiwqQ2XoH/UWPqXswHgi/uK+deeS4P+XctC1RYlY
         DAwA==
X-Gm-Message-State: AOJu0YxOBXlurdzZvle8bbwuGiBucxMZYXHL+OMpgdFbynZO801b2jto
	rsLel7KxtQAEd7HTwwUo8IEFmXVmD6yY/p1ZNSz7R9Whzp/LEfYV5HMPzajpOoD77pTuKkYez/2
	x
X-Gm-Gg: ASbGncsWX2cNdz3bz+dw03YZ4zokhl16cuun8AVj9cXT7+URREfAWpbqrSGkBscp6JO
	cAEpPnC3upMLS+Xg2ML0RK/Qu8h0ioHIn/KTmK/oKuEnbDbaqeF1msxEC2HoyTI7JOBliPc41GF
	oa681d4UMBjnlk0ZnNA53AcdXhuJpJiGIwRAzWxJkV/swr3xruV4mumC7us1UoMZVy1MzaZYV9l
	fzXsqhPC2yiPMc3xPKJpSAcHGs5acTtcr3YgdF1a4fYf7KjaFFox6AWvgd5Z0owmKWTRsctcbbw
	5hHAu+LQjYot82azU/oa3yayo7R/F+bX42QjLJ4boVnrA/gG3IVrsl8FAMB3mbcugeBEBd8gqw=
	=
X-Google-Smtp-Source: AGHT+IEyhdfT5ONbULLyfla6HYpX7Lw2OyVj9p24M7ZUr6ztTxrwCi8C9PKMzl8Ya3hFE53MuuG4ag==
X-Received: by 2002:a05:690c:4b83:b0:6fb:b78a:c0e5 with SMTP id 00721157ae682-6fd4a0c2ca3mr5940447b3.28.1740680966471;
        Thu, 27 Feb 2025 10:29:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cb7e674sm3872037b3.83.2025.02.27.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:29:26 -0800 (PST)
Date: Thu, 27 Feb 2025 13:29:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] pack-objects: freshen objects with multi-cruft packs
Message-ID: <cover.1740680964.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This short series contains a fix for a bug I noticed while rolling out
multi-cruft packs (via 'git repack --max-cruft-size') within GitHub's
infrastructure.

The series is structured as follows:

 - The first patch simplifies how 'repack' aggregates cruft packs
   together when their size is below the '--max-cruft-size' or
   '--max-pack-size' threshold. This simplification changes behavior
   slightly, but not in a meaningful way. It occurred to me while
   writing the second patch.

 - The second patch describes and fixes the main bug. The gist here is
   that objects which are (a) unreachable, (b) exist in a cruft pack
   being retained, and (c) were freshened to have a more recent mtime
   than any existing cruft copy are unable to be freshened.

The fix pursued in the second patch changes the rules around when we
want to retain an object via builtin/pack-objects.c::want_found_object()
when at least one cruft pack will survive the repack.

Previously the rule was to discard any object which appears in any
surviving pack, regardless of mtime. The rule now is to only discard an
object if it appears in either (a) a non-cruft pack which will survive
the repack, or (b) a cruft pack whose mtime for that object is older
than the one we are trying to pack.

I think that this is the right behavior, but admittedly putting this
series together hurt my brain trying to think through all of the cases.
I'm fairly confident in the testing here as I remember it being fairly
exhaustive of all interesting cases. But I'd appreciate a sanity check
from others that they too are convinced this is the right approach.

Thanks in advance for your review!

Taylor Blau (2):
  builtin/repack.c: simplify cruft pack aggregation
  builtin/pack-objects.c: freshen objects from existing cruft packs

 builtin/pack-objects.c  | 118 ++++++++++++++++++++++++++++++++++------
 builtin/repack.c        |  38 +------------
 packfile.c              |   3 +-
 packfile.h              |   2 +
 t/t7704-repack-cruft.sh | 106 ++++++++++++++++++++++--------------
 5 files changed, 171 insertions(+), 96 deletions(-)


base-commit: 08bdfd453584e489d5a551aecbdcb77584e1b958
-- 
2.49.0.rc0.2.gc0c926adde2
