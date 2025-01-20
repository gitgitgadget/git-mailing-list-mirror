Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5E1DFD85
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378969; cv=none; b=jpYeU3iwvQcZu2f8SEPznObgDvC4emF/d6f7xhdqOa63K+LEiGabK7M2+5027iB9okzzu/mTYKFv/jVOE8xcnBOt5YV4vpBI9QvPDB/RLPcoSIXcF2ydaFXTvp2bv4E3KwFGK4DYqwirKLpo92UGL5dBuzkbhCwSmdk9KnYHwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378969; c=relaxed/simple;
	bh=HvUq6XNoAEpn/xPYbd3uqwMz7NWVbHO0FELGTtLOH3w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Y43tdSbe4wzqsET2WSZkIbThbTT7nML4lrcn8Gj1of4gaTPQzKyh1iWFRZaEIHlfs21Pleuf9TwktifJrx6RDCdYYgI5k9fH4aJjhEdGzb7Xffpq5cwpJXx1jke6ie78dUYwbzCbu0CmV4mtDPerbbOiCMbWXUoxVjht3+U9uO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synergi.so; spf=pass smtp.mailfrom=synergi.so; dkim=pass (2048-bit key) header.d=synergi.so header.i=@synergi.so header.b=gUkkCkRv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synergi.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synergi.so
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synergi.so header.i=@synergi.so header.b="gUkkCkRv"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa6954ec439so55989766b.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 05:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synergi.so; s=google; t=1737378965; x=1737983765; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pAVpDgAiroLIY/Kixjk/IW6cqIiX0LCe0Ai+ZFHEyGY=;
        b=gUkkCkRvvJzL5fsJsk58oAoPHpDlYuP4xskf18fE6nmcVOyr2m1EtsoiCOh0L7ehoY
         yf3eKWh5nZwevMerWN++dyBSIpN5XKt/ZKNPQzfIigH/uJvAuKguYvzDFhxI1uN0tO5Q
         pLOjUNkFWRNfB3VAwezz58Mkkg4jAyVthTCFQsBgQqgyQ5U6UojLW0iKkQWP1HV2BO9r
         HIWyh/T3nOEXMJzzDDiZUJccOigfMb33loyWdPSssx/Iw/T7Ay+JRok4B+CxytWwO90E
         LBbOoIOzWdx9DCXxdQ2WxMr+krzNKmwkUHmaElLEwwdAPZxP/EjNPkIDgr2sWqnJPq2y
         N6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737378965; x=1737983765;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAVpDgAiroLIY/Kixjk/IW6cqIiX0LCe0Ai+ZFHEyGY=;
        b=tjdH7VWlxVE+jS3QT37L8WorhOepgAFLtUEGGNs79viAgJ+MswCJjOABgVHcT2OXVh
         kyxJnFdKrO9Fcbkjdj1x7niweAAgPDDmr8iwgwSqYiyzsly0t0nunWywY+zVF+3tEdX4
         yzB1eG8s4UkjYs6OVCCEQe+l9EKSAvrhFa8iWWQdysPCBr2+ByoKuvWX26ZUPQHuVBZ2
         gGlc/TgaMphPQ0j2brwOAa3cBLIeQ0nJcKN8hqkwQL2Mfwj6YjMWjAhKY3GXX6rhDTct
         IaHsoEkOCnoSoMMzjIqQK7KmJ406ue5O8jduXxrLWGWWh+aRa1a/PFn444/7XalqSEfh
         c7SQ==
X-Gm-Message-State: AOJu0Yw7/xXjQ1cje4a7ietKfFPKuH5GLARHtEYhfxMp4omBfj0/Memn
	gLkYYxmqLYh4cPUQWNblfw7qqNjbmdICFcEbFfn8xR3QjoiB1xPProcS+16j1oWzzQ3MvNnp1QO
	xgucJo1LH/7GENRV3jSzPxVEpIan0AjStg/9E8d9Kc9pucyNZTg0tzA==
X-Gm-Gg: ASbGncsU4tUfjbURnFJsWxVMx7Hu5GU0d5iCSRDpC9eFuqGDSy9myl5USfxUhrH5SSR
	mQWYC6PmCgC9gttpZcX31OCUPlST989guc/ct6b5jTIPXAtZezIU=
X-Google-Smtp-Source: AGHT+IGTs3acjKN1w9IN8Rp/w/sDjq2Zje+OM/8Pb/zU+uHj6HeIqIagObPsflLZVtcJb0U6gw59P9v2q2UsGcTM7Ho=
X-Received: by 2002:a17:907:948a:b0:aa6:6792:8bce with SMTP id
 a640c23a62f3a-ab38b1b6f43mr385281966b.3.1737378965384; Mon, 20 Jan 2025
 05:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bob Ruiken <bob@synergi.so>
Date: Mon, 20 Jan 2025 15:15:54 +0200
X-Gm-Features: AbW1kvZ4f6Xn7YAY9Nbl0U--eGVim68X2t0LuUMHnNfuTFtaOewtp_5MEFgPAPU
Message-ID: <CAK_bMgeW6ACsWKDbLk0fvm7DuOo5BYhN2OpA-EyOTCSWrkEXSw@mail.gmail.com>
Subject: [bug] Using --ignore-space-at-eol with --name-only does not apply the filtering
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

While doing some diffing work today I found a small issue combining a
filtering and formatting flag. Let me know if anything is missing in
this email, this is my first time reporting a bug here.

What did you do before the bug happened? (Steps to reproduce your issue)
I'm using "git diff --name-only" to analyse the difference between the
current branch and a target branch.
Then I wanted to expand the preciseness, I don't actually care about
spacing differences at the end of lines, for which I use the
"--ignore-space-at-eol" flag.
The problem comes in when combining the two flags: when I do "git diff
--name-only --ignore-space-at-eol" the names of the files where only
space changes at EOL are happening still appear.

What did you expect to happen? (Expected behavior)
I expect the two flags "--name-only" and "--ignore-space-at-eol" to
work together such that files not matching the latter filter are not
shown in the output.

What happened instead? (Actual behavior)
The files that the "--ignore-space-at-eol" flag is supposed to filter
are still shown when "--name-only" is used.

What's different between what you expected and what actually happened?
Filenames being resulted that do not match the filters added by flags.

Best regards,

Bob

[System Info]
git version:
git version 2.39.5 (Apple Git-154)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.5.0 Darwin Kernel Version 23.5.0: Wed May  1 20:14:38
PDT 2024; root:xnu-10063.121.3~5/RELEASE_ARM64_T6020 arm64
compiler info: clang: 16.0.0 (clang-1600.0.26.6)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh
