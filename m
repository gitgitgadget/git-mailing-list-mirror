Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B2279901
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395319; cv=none; b=hik5TefNg71+1dUmNXzinOvIOT1SvPGqH6h+6dCLNAkGhf7EfwRlR1kDKsIELtdia383F12u78b6vSQMiC1+yUu8FMo9ItrsKo/M4HlzGt15KyU468xZr9b8lmZ4Grot1Osx6iL4CKsNZ6xtVUwzhOXrYJhJQiw6uI8zPlKD3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395319; c=relaxed/simple;
	bh=mmd/5guqVmqLmPi52cPl/LTZApdWgoPIZ6OxRh0DsHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZwdabQIMCdIIcjiwLOU8rDAhsbfaRnjKpXRaX6qE0vEimGeecWlaUkh7dAcv4bUZx/+fhltrqM3ulJ4BI13uM8LN/HLa0pvetU1y0Rap8fLcHY/0IHCyeq72qij1WV+kD6bwAQA6hEJEIuv51HNubjRxDPNf9KJU81SIaceZrtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWDDlzWN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWDDlzWN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfe574976so44965565e9.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745395316; x=1746000116; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXm/aQ48Y9U8ZECX5eFmYfLEomCq7vg88HgPm27tm5U=;
        b=lWDDlzWNIZ0WT4NzGPC2zmHvfz/CKVHASqdqmTunFuxDs+m5ZnrAW2UVzvtBoHMwRd
         8fqFzHv5Dzfou3p/WJSo1g5m3fhi/8F4KDeAPGuyziCjCqUZzO/50coHJs9IYdyUUe5M
         9pXmBEekxoc8xO9kJ4NY5u8vsH5mAbUH3yz2DjLWluO/WyuIGcIEbBka/r1Ug3gnzPj/
         TgrqRb+lkQZeU2ceRKyKMhKDz7CzDooLbPnUzGT8BqvAjNL0fzIZdAhRUEO8RS1zVIz1
         Fzawt6p6OCuqjr0pzAOraPT0KeCQkZXnJtVleXkU4m5MwTqevw0Ted1pPIwUglV+aHju
         nmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745395316; x=1746000116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXm/aQ48Y9U8ZECX5eFmYfLEomCq7vg88HgPm27tm5U=;
        b=KiInDmO0Vv9YELavXKdetpHOsUsPEl+kp28UJfEVSagouiTMJQlbhj5O7unb67iO0b
         EvigiHCulrZPyV8z7G2aEy++tALi+31RZ0/1oVy/lMh3mw60kSiaMOJJ7ws8coXmLcqs
         SM9Ds4NIyTvJypRT2FzielIspU7e4F41YnYYjkgnntBdNhrmvpLBo+wRvGF/mCjXchgv
         TecrZDVa/kRPi7xBjeJrKkUN/lAvljIDpNFLQ5FpII1eYU1TTsPvBxj/NdnVq5JF3Luj
         OCMhNxP61XMgPir9sEdGjx6GWATT80xUsG/W6NdxL5vT8Zk2Vs9u1EOjnRLQC9u6/KgE
         h8OA==
X-Gm-Message-State: AOJu0Yx6Imbhan+r08yeDJXdkOBXC3KSDq4BKmCWKF7eDqPcdZktbHwD
	3e+0H7VoeWiMOukUxr1u2Ud1BvbcXU4xYAPQNiFmzRiwRVMvwhtb0sdEnQ==
X-Gm-Gg: ASbGnctZX4DcGpQIuaEuJMHZoYmysdfjTqT+p2NCOgaXanmzqTnlg+ACjzk87Emx/P/
	AX+djH2Qfw1iFa4RMDGAgDSTtQB/jufcHhabVhwjDYznj0tdAV64ogNqjTEkRJoELBQiIHbTfu4
	XCyVatbMLJ0SmG1UsmGT+x/D5Zsc39Ke49H4JWesdE/bnpjS5QDjB2Onz/zqn7Rzaujb9/axzBQ
	ujZdTX4qgdKLTAaetAWEMrDUFBQ257jtrpfzKZObYu6dwEjTobnzby5/Ugx4vtMEGhkJ2oQgE4X
	6AlCZ68mClY8lhuYa5/codXnYnoiKoaHeEGeQ4DtQw==
X-Google-Smtp-Source: AGHT+IGDB8iMvwI45b8aDZcv4u2apO5Dy0p1lfSITQhTY9b9s0XcjEbuOtqb3qOh9paK2lC3uvf7Cg==
X-Received: by 2002:a05:600c:3acf:b0:43d:fa58:81d4 with SMTP id 5b1f17b1804b1-4406ac25befmr145239955e9.33.1745395315599;
        Wed, 23 Apr 2025 01:01:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092db2beesm16293245e9.30.2025.04.23.01.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:01:54 -0700 (PDT)
Message-Id: <939bcb0dc63f7f9dff71588182c7f384341f8432.1745395308.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
	<pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 08:01:47 +0000
Subject: [PATCH v2 5/6] mingw(arm64): do move the `/etc/git*` location
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In fb5e3378f8 (mingw: move Git for Windows' system config where users
expect it, 2021-06-22), I moved the location of Git for Windows' system
config and system Git attributes file to the top-level `/etc/` directory
(because it is a much more obvious location than, say, `/mingw64/etc/`).

The patch relied on a very specific scenario that the newly-supported
Windows/ARM64 builds of `git.exe` fails to fall into. So let's broaden
the condition a bit, so that Windows/ARM64 builds also use that location
(instead of the even more obscure `/clangarm64/etc/` directory).

This fixes https://github.com/git-for-windows/git/issues/5431.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index bd94f458088..9a95ba8c9ab 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -489,7 +489,7 @@ ifeq ($(uname_S),Windows)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
-ifeq (/mingw64,$(subst 32,64,$(prefix)))
+ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 	# Move system config into top-level /etc/
 	ETC_GITCONFIG = ../etc/gitconfig
 	ETC_GITATTRIBUTES = ../etc/gitattributes
@@ -749,7 +749,7 @@ ifeq ($(uname_S),MINGW)
 	ifneq (CLANGARM64,$(MSYSTEM))
 		USE_NED_ALLOCATOR = YesPlease
 	endif
-        ifeq (/mingw64,$(subst 32,64,$(prefix)))
+        ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 		# Move system config into top-level /etc/
 		ETC_GITCONFIG = ../etc/gitconfig
 		ETC_GITATTRIBUTES = ../etc/gitattributes
-- 
gitgitgadget

