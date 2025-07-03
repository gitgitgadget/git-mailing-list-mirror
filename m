Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2B136658
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551515; cv=none; b=DmiYqhJ2/7BaNS6ZikQbP0nhz4IawO9Bs1qoPqNRQ8WzJViWNKMFPf+2UHdQEEMnc3DDzLYayBzIeQggKoK/j6vNLrhShOpOBhcZvPKeR/ka0FzoZu3Mtq7i9o2JSS/7JISGCg6hmfLok1fRRayismcWzEVXSrNEktM4SyI2HLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551515; c=relaxed/simple;
	bh=5O1S0/aL9+uhpkPTH33to1sZTgh65D9X58Xjig0mBKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJgefsyJc52KHzZerPazaa8x5JHaqdOK+whmtMSFinr1rO8IP5Y7DQb6JiWPwK2lwdu9Z9svYY98VQbtBldB6b+JpW31lf46qSrFl80Ju2hbfJZ9Iem3oGjuNwHVisz+HktrS6nnmPA4thMDlRMHJo4A5rwkrifaufDt471Opho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7X7Y5UK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7X7Y5UK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23649faf69fso51487065ad.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751551514; x=1752156314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srxKTJtsfbFNJK9DDWB4O1ZiBh4Xfs2fBdBS4KyHALs=;
        b=Q7X7Y5UKPtPAB899wgTavHnScWOukmaIICfde6VoXbsVKMRpNqvBqywG95F9qiTI6q
         cUc99hT+TsIqkEOzdDtXcWUwchiuCAjpolN/ss8B+hrbtirpSzqoMM6FJkgi3X6TLQNj
         X0OPPzppWoCsBwOoqQ3mZ6oZmeU8bs7vN4N+yG6gd0zLiWtnfOilpxrqpiJZLRjHV8YA
         r3WS3AvCzwxVwoN3ETY7kQin4oEXrB5lf0myKni454Z4l1QDwdIP71NsWMpojHQxOJFa
         T+hbjBRWdnRQ93hUfynxPTwA0MeDVevmlcfmNjiGFBfVlEb2Jlpbly1ysuUxC96qpboF
         wSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751551514; x=1752156314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srxKTJtsfbFNJK9DDWB4O1ZiBh4Xfs2fBdBS4KyHALs=;
        b=J/e96GI8W/lDce3BowBylMj+ddMHeTtOhn0lGtHzZn/xgqGR4dk25h/J91NXyDoCld
         YMbhHQJEdDzOkd7InaWMUnLSGBLIGvlNLxBx1Xi14nd0TkmhedXDx10A3SjW9XBgX3Lz
         7Sn85HwXOeEWzuzVR0B2UdDRIh73S/mUXmBufBM9/qXpEr6shWvTMSwuZJfGFgs0Yu8A
         U+FsQI2nztp2dvsvSToW1Ub456VXGt9i3tZ+xJtaoCa60VtbsN0YwIcnf7NfBhvGgwbV
         Fts+0pwdZbA+Jrfk7tvwQCDsH9MQX2d4EVSjCod7duXRmZp5vT5cjl2cesZEnpoaJukl
         4Z2w==
X-Gm-Message-State: AOJu0YxAUhMbwvVpVnReEhY3/9XHhsopL8ujzmUFEa9VzSpeRWfa2Z+j
	mOtwp0x6uF5NelZ9ygnBrGtcboQpvOqzhE5LtqdADMkxDHMIh48ZFqm0
X-Gm-Gg: ASbGncuSd9rjJX876v1ml902j6OWAyUaHTHhwcN11tLPwZ092UtP6FjxIFrUVKly0Js
	5sLj47KwuPDc3LS99sCttlarHUS7Ib7IjBMFtGUYxU+R3K3PaOzdHGleCTvdKUsDYaX77ei5JdL
	rskZqZty3h3rbb+PukYAtwv2oTI8vqg9r2U6ddAU3vMN1wo3+Lc23q7eG6Tk9VP2OMEXFajsWlG
	yU1M3ZNSrTTyvMMALwa0YKeqywDqEl72/QjBuhSSBQWKxkr7gOjMrntlQ4fVcCcUlHiiml/bppr
	9zziGSnAh//kUxwRLerNoZiDFDhR3zWFdFN+Vlw29PvnxRGHUpEPuxyM9Z5ojrpHtdIIUZl3M1Q
	=
X-Google-Smtp-Source: AGHT+IEaff6fzQo9QjEjJUXlmpDUWTOB7uo9Q6/G3Sl14/dlKlzfEdPo++1v2HvaKBMnjv2RGRw/Tg==
X-Received: by 2002:a17:903:2b04:b0:234:8c52:1f9b with SMTP id d9443c01a7336-23c6e5706b7mr111871775ad.43.1751551513701;
        Thu, 03 Jul 2025 07:05:13 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34f7a42d37sm12661341a12.8.2025.07.03.07.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:05:13 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: Re What's cooking in git.git (Jul 2025, #01; Tue, 1)
Date: Thu,  3 Jul 2025 19:35:01 +0530
Message-ID: <20250703140501.34410-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <xmqqwm8rh00m.fsf@gitster.g>
References: <xmqqwm8rh00m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> * kj/renamed-submodule (2025-06-07) 2 commits
>  - submodule: skip redundant active entries when pattern covers path
>  - submodule: prevent overwriting .gitmodules entry on path reuse
> 
>  The case where a new submodule takes a path where used to be a
>  completely different subproject is now dealt a bit better than
>  before.
> 
>  Comments?
>  source: <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>


Ummmm, I think this has been a backlog for some while.
I have sent new patches [0]
There was also a clear description [1] of the
helper logic I added.

If there is any other approach I should take 
I could do that too

0 - https://lore.kernel.org/git/20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com/
1 - https://lore.kernel.org/git/CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com/


Thank you,

- Jayatheerth 

