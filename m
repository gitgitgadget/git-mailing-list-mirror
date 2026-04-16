Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B53803D9
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331263; cv=none; b=sI+gYA5oHGjtvw1UFUzwBlFlOpri48cTlI8P8f0n8czmR41R5P5rCFkCmokFMnvUL69czshxWOyC0aOtauyczXumomc4bfucPQfuEFPwORjkGiyQms4TaAbvjDaAo5iRVL6djtxwGW5xs9HJM3QEcvS5Nk8HHgetOJ2pmjYrUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331263; c=relaxed/simple;
	bh=vugdgNLKcd9UH2zJ+D0lI4ienwUhAuRq11nhR8QkoFA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fYCoP/oY4f8sj8vHBKiHtMBZuQLAs4eH++klhxyYWYBNxrHyHkmawSglSPRay3oJxDBgkounY4xBOUG9oBeaoL5vTIdHs4fVm1rkghvi+bms9Y6te7dYyubn4kxmmmJG4Uvcc7cB82dXTTPU5CIbK+/L37J2L2STt+cAzZNUNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP8UNlW5; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP8UNlW5"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so6954827eec.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 02:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776331261; x=1776936061; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7WhMfnNJ0DwYVCO0LXBirkZcK1Y27Wji9MaKjSHGCPA=;
        b=LP8UNlW5V9nFvzMi0mII21Xe7KtZSYj6lF1tu7s1sOk7QwRY7lezcrhSWPaJMeoOsR
         PVbpdgIYfkfy4GpIJEx3nsHvP0yB+IjZ3Bti91IxihSpTpKstC+2W9/2KyGfJ4clg39F
         sfBLViU6bo+hs66m53cWXZH20w8gvEkBWZppbZW5P4hj7givjvqrSP31+w/hMicxZiyQ
         Xd9+Q+xY33KStQt4mLaJS/zlDcSxZnFFbROPNze4/qQZfWebxyYSLuqoyIqK1yGj4Df+
         X/DsEPDn8rgiFPn7t1R6hquHWx1UfC6RR5/ogvHHPPceJFl+CW1r2oMtFmWu6WSBzKiy
         sv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331261; x=1776936061;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WhMfnNJ0DwYVCO0LXBirkZcK1Y27Wji9MaKjSHGCPA=;
        b=VFqJJnM4BCNt7O1ohuoYKmTnv17GHun80+1hPabR8xzC1pW60qvaYzXPez1ErprN8g
         SVJoh9HHru8lsxQEwn9Cy7MDTE4VgDnKYkk9GPfq7KFS25YABeocAxBTQwp2LWlbON+g
         80usg9x8gXJJUMC7OnWgvm3sxgRq9ks9ueye39d3MZoXbXWYWdyP2fDrYZ7gxckWFT+V
         bXQoZEdlhwDKySrUn8/eYWbr8jYjhQwGxn4Yagry6RfdJ0fAGuR6B4hyhVbahthIecQR
         pKVw0cOmfpIFYYntWzxVxUBBR0ANTV+hZRNUTX+OLIh3eQVXevtZt/tiXZrvjYl4k98Y
         LZQQ==
X-Gm-Message-State: AOJu0Yz/MbbI5ReakYdt+0m6JJa3iJqEV1sVZy6opt73EqV7nMpqDs6U
	iTbIV1cfFGfj/smJ4eq1tdCU94S253wu9+WmPuu2YLiYZWGTYCRINVDtysSyYg==
X-Gm-Gg: AeBDievao6nFxnRAXNSTYDiBNR4J5ciiv7KbuWIYCVYQIL1uB9l/FCNRUjUmauXeOg1
	MFE/9LMMJum2uz8jLxipu0YlCXT12nrMN1z/FcEhoIF3MO1cQI4WnMTKfpHrnMzUnt7XBG/XsRA
	yPvy/hl3AyNW+mO1PdJVXIhcs3bVhOYUthLE94Iw6NIz7lsnBhpXTW8+43IpDJ4GT7kdC/7z22o
	JwQczuUBLgffaXqktbN80MUX15Ccy5dIJ7hlVOY3uEiIgHTUg5yN+7qSMKZ1JAACxoeESql090b
	fOIxx8r9EzKV4B9arXE4nVG89ICQ2COWq+xeGLkRnhNahX1YSzF/6rLu1VJ6na40sD1UVELUwkD
	DeXF3uUOCJPglTwKSJPjLj/McO0ejaX0QHxEs5iV3sD2fXH7opUU3GPRN0t09c/eRzqTuTFrUm6
	7NRcPWsFOqLdnM6kHTfEOK6l4=
X-Received: by 2002:a05:7300:dc06:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-2d5870ad65fmr14717887eec.5.1776331260756;
        Thu, 16 Apr 2026 02:21:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.72.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c90cd7esm8100678eec.13.2026.04.16.02.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:21:00 -0700 (PDT)
Message-Id: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 09:20:56 +0000
Subject: [PATCH 0/3] http: fix emptyAuth=auto for Negotiate/SPNEGO
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
    johannes.schindelin@gmx.de,
    Matthew John Cheetham <mjcheetham@outlook.com>

When a server advertises Negotiate (SPNEGO) authentication alongside Basic,
the "auto" mode of http.emptyAuth should allow libcurl to attempt Kerberos
authentication using the system ticket cache before falling back to
credential_fill(). Currently this never happens due to an interaction
between two older features.

The Negotiate-stripping logic from 4dbe66464b (remote-curl: fall back to
Basic auth if Negotiate fails, 2015-01-08) removes CURLAUTH_GSSNEGOTIATE on
the first 401, before the auto-detection from 40a18fc77c (http: add an
"auto" mode for http.emptyauth, 2017-02-25) gets a chance to see it as an
"exotic" method. The result is that auto mode silently degrades to the same
behavior as emptyAuth=false for any server whose only non-Basic/Digest
method is Negotiate, forcing Kerberos users to manually set
http.emptyAuth=true to get seamless ticket-based authentication.

This series fixes the interaction by delaying the Negotiate stripping in
auto mode by one round-trip, giving empty auth a chance to use the system
Kerberos ticket. If there is no valid ticket, Negotiate is stripped on the
second 401 and we fall through to credential_fill() as before. The true and
false modes are unchanged.

Patch 1: Extract a http_reauth_prepare() helper from the three retry paths
that call credential_fill() on HTTP_REAUTH. Pure refactor, no behavior
change.

Patch 2: Delay the GSSNEGOTIATE stripping in auto mode and teach
http_reauth_prepare() to skip credential_fill() when empty auth should be
attempted first.

Patch 3: Add tests verifying that auto mode produces an extra round-trip
(empty auth attempt) compared to false mode, using the existing
nph-custom-auth.sh CGI infrastructure.

There is a trade-off in auto mode: when a server advertises Negotiate but
the client has no valid Kerberos ticket, there is one extra round-trip
compared to the current behavior. This matches the trade-off already
documented in 40a18fc77c. Users who want to avoid it can set
http.emptyAuth=false.

Note: this patch series was taken early into Git for Windows for the
2.54.0-rc2 release.
https://github.com/git-for-windows/git/commit/8e94b65c003783d7d7b09d9fccdf06a1363e347c

Matthew John Cheetham (3):
  http: extract http_reauth_prepare() from retry paths
  http: attempt Negotiate auth in http.emptyAuth=auto mode
  t5563: add tests for http.emptyAuth with Negotiate

 http.c                      | 32 +++++++++++++++-
 http.h                      |  6 +++
 remote-curl.c               |  4 +-
 t/t5563-simple-http-auth.sh | 74 +++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 4 deletions(-)


base-commit: 2b39a27d40682c09ac1c031f099ee602061597cd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2087%2Fmjcheetham%2Fspnego-fix-upstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2087/mjcheetham/spnego-fix-upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2087
-- 
gitgitgadget
