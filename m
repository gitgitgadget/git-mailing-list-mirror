Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C65265607
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239162; cv=none; b=Gtnsh1/gDP/Kg3fXn1CgBcFc8xnuzl436VewEPsrK1F8Ab9iiasRW8mqVKUFM3qFfxq3+dGEA/5MsanzmiZ8Edp/6xJKTZHbHixA3DtVosoI/i0QXdtDke4Lj1zGRyOJe0qk58Rey6AKfeWq2rHbV6c8tGrjWJi6KixQ5I0AXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239162; c=relaxed/simple;
	bh=mmd/5guqVmqLmPi52cPl/LTZApdWgoPIZ6OxRh0DsHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uapOv4DoXwqUqoRl9AvNrQNMub11MwwEAs42mimSAlXU+uojeom52Fj81Qfkj0zs6s8Ts7YvoGW//wNo+NLhNYbSdEcqHhqaQda7om6CtmGFY3XAeRCLkl8jbDosvgfV2p6ui6PJyWfFGhvoAL1e3ETs5MVIn8lIBHQWXw7veuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYZ/MR7l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYZ/MR7l"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso28635835e9.0
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239157; x=1745843957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXm/aQ48Y9U8ZECX5eFmYfLEomCq7vg88HgPm27tm5U=;
        b=FYZ/MR7lQ5Ywsxj4LJh4Th61O4oJjXDMD82W4lk1/iB4wzwhO2efC/4OZUn/QFtb+M
         /p6HM82JUz3N4b+Zqq3La6yXNbpwJMiKcB3wdNrRq3IFeb0J0+FDUhhQUtmPGQEouEhu
         ozJqAIrtIyxRi5ikhKinNmOuQ2/GIaqL5NedyiTb0OMHMzeT3BnShWtngN06zhi7dnZO
         6yOmfB2UgOqxvMVZBgjc1ycOTE0FMuoSST4E/VqqImE/WAZI8UeUZx4xKEwbF5HFcRFZ
         xYmWjhdnWvPyNouAmg/VrcmCoiSroJdx2L8I8RABDkWWP73UaHHY9hc91IpGooB9ieMK
         bbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239157; x=1745843957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXm/aQ48Y9U8ZECX5eFmYfLEomCq7vg88HgPm27tm5U=;
        b=UPodKQ6ZxVfh6nFVvOZ4KUTTXqnErMHvFLRFD0IEDLs7tpHaXhAEclIsXdzhPxkFfI
         O5OjXRnQt24MFH2x0FqJ8m8R/ZR0sa8AANgBHu5S1/y3JRfMFAWjlbbkx6bznJCMO/IQ
         Bi5xqQ3/EGaB1PC7ba3adkuv9HFYBItP9u3APLc9lcwMIVmGgrviXdr+IoXbfkNb7szD
         U3CqBCPNZ/MkNsPSME/Ck2C10rmS+BmqFmYolnAiCjPtI6uthoQgxGlQbGg36UbM9Lvd
         TKAlkiNohU/g6vtsdcFxoo6i1K0gCBZkYrnUu1kLuwZJW+bUcCS02No5gWSbjnh1a0LZ
         L44A==
X-Gm-Message-State: AOJu0YxnmCCy2kbj6YS12rGzAGy31BSJvelCjhNjFCf+sDtA9U8W2KL0
	iuYIqvnn31vFE0FCUENtjYNMmUiu6NOvWQUDlCeWKDO3pDKPQgdHLBhgEg==
X-Gm-Gg: ASbGncsgDNcInr0KhWYHBZmQWwyOTwuLuHozR+pbx0TLrATEb77MT4hTrx6IK+0bL9W
	Od9fpbceEHEuL7hHyNpvIhCNRVQkvcKgoJIjrd4tGRUuLNNbT85jV3kyRfwuz52RIdFAzjF3szv
	qdOPZGIb3ZqNrFVPio339T3k4Q0Z7eOOMHsLyQi9YHPMZSUDS81t2lsOdKUU9ELepLH8WJR2IMJ
	57DYVdlyDF79yBOwSzuhRv5wxw1MyIDc0uT+CxqO/261SGms/31qB9wTHNGab8U8e0nOwTlIsNV
	MUKldgnXefR8gF/TITLAGmmZR+kurq65rWIqze28sg==
X-Google-Smtp-Source: AGHT+IELkt1rADp8mbGazRDkdQX8G5xJ+rGLkIYbyGivDrNybxs9Wgx96DP4XKkoSqL6o/FGMsl6Wg==
X-Received: by 2002:a05:600c:5251:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-4406abb0f9cmr82416565e9.17.1745239156333;
        Mon, 21 Apr 2025 05:39:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6dfe4esm131895475e9.33.2025.04.21.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:39:15 -0700 (PDT)
Message-Id: <939bcb0dc63f7f9dff71588182c7f384341f8432.1745239150.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Apr 2025 12:39:09 +0000
Subject: [PATCH 5/6] mingw(arm64): do move the `/etc/git*` location
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
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

