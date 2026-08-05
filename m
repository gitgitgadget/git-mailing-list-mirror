Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3788374197
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940018; cv=none; b=AiZVTV3ATEG9PL81GQDHlzHBH3IcBJw7rZp6VqDys+9BA2K4qmh7eC750nDL07RnQ74uhKTdtoACtzsJoIhI6FK79H0N3y59/Y6tLYpvG2LuNx7rXSIQtwm47FIoUyoiFM9WPC7A73PpmWvU2z0gYPeJupYHHFVjYQjwuNmiZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940018; c=relaxed/simple;
	bh=E5TAcKaEOCi7ReHacavmPN3FxQB+iBTnP9fH3OdfmNU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gxWNsNXFYFhi+zLrgbU65LtBz1omfPzxg3gb+gZlGqSxQ9EtNUcbNDzpRZ0C4UL3wsQEtiWAHpU2EXYP0easoM1RnW3/rnHT+zvq+AWESZNibpTXkFLccOVyRcwICI1/3/DiMI7VH0Jhp3Z83PB+wSF7motpmyHVZ1XdEzmX1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GztrlBEK; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GztrlBEK"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93108a3c326so139823685a.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940008; x=1786544808; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bnTtnwxcdY7RASz7pb7KoB8/awq+9cPpOpxZ/RWp49s=;
        b=GztrlBEKaFaKNNXNPuBP25sq8Qow5mvEkqXHkoAJ5Yyg8WStTPfk52KvFaaRtsCI/N
         y0b5rUIMoWkIrLRNMzdLCqyAWU7xXxHynDthPfpHLWNMgAY3aQ8gnqGAILbNndLz9Adu
         GqHzdJdd+fyDHOmH0JhpI3kh75fNLDuuMeCeBB+wEcorZLyKvEmhGA92rmE0WMOIlR60
         JRDRJHAocLJDdiFw0jnGRFMyJlrxvpM/ObMKUjQQwFCpAbMwozl4pOrM0xZjmyrqG5uV
         eud5LE1rJtJKStACFoCj81QKnxlFbZlUGyGax1+XNGPx6Tw3SW7+yIBEJCIMAAkSaq0w
         MvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940008; x=1786544808;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bnTtnwxcdY7RASz7pb7KoB8/awq+9cPpOpxZ/RWp49s=;
        b=VY1PscrnxnzMBPOrYCacHBJC+gkFvsIaSoBMI1vV1sRZBk/+KnHkhdM/dQmCIrD8iu
         kR+aHfOKhosW0cAYXAsS5oNDDYHKTd4XkBW2uruV3Ka5rbLFTib1rgAzUbaRqbwYmxDW
         ZIAKS2w28ik1lVyn8yOOyMJIJtw6IkWzWXfXxaGxbM0iwjprzNf9ROQ/zVdH3UkLqwCa
         97152I3l4Z3d0RMzweSpc97rpIoQRaXPrMKhLSjKDNg4EgcIhSHWC8aNqyQfUeR2Mklo
         TE6nyFdZum0jeObBxb6dss/zCd1LJG0l39titdHf+laVrLe6Kac85kDn98W/OWWXZgps
         GoNw==
X-Gm-Message-State: AOJu0YxZznHKISThwNl1wz8kfVUafXWa159u3do/oBkz9v6IRRdotWPq
	GEvi3IJEg7uVJts5/BAFJCLYa8s3t+szOvfX5dkTsgO/xvIqh4uqh4op720icA==
X-Gm-Gg: AR+sD124z6QR9lJ36xn0dCzi0DgoqQFvFXS5FE7hpDc1db+EpePFmV7SlVct386SchX
	HoXLldOnR9+9nxejc1AG3IlxLwKz4TlLJHlFFzNVslf9sDDhRhhyeO6uGem2nPqEHj2cgsFehp7
	bEeYFqoLLzbW32nuAHtwfwIlC9Bek1Uehpho68LCXlfWKHemUN7zIAZpRxfQ8vF3c7qhtil02sf
	fij5WMOyIgXu41DxTX6Uf8MfHYEnejVh9W53+lQfixUkUaj7p/z/EGP6lIl2cNUkXjglLJwBmQj
	b7vmC7Dsj15UP7hvfYDCQmsgMgwqkYoEmUkoHPswIeMB/Ir6tbrYLYil5aMMCP3d6vOPLoNEcFN
	lL3m8aIUghJNyIAz9Bdor6wAPCl9VL6TAeg35zsy7t1VwTq8pXxBOloE74HQj2ofOvZrMyNGDUV
	UA5Uh8R7SXuEmJFUVXqIHzocrt6pgCyGiYhQP7jy0RPl3e2a1lOyymZ/9w+wbx2WI=
X-Received: by 2002:a05:620a:2982:b0:915:92f3:54e3 with SMTP id af79cd13be357-93631802725mr1138750285a.4.1785940008431;
        Wed, 05 Aug 2026 07:26:48 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a429cf5sm163016485a.15.2026.08.05.07.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:47 -0700 (PDT)
Message-Id: <ad96aedda6a2b22b80200a035b714ca111b97cdc.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:30 +0000
Subject: [PATCH 04/12] mingw: only use -Wl,--large-address-aware for 32-bit
 builds
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

That option only matters there, and is in fact only really understood in
those builds; UCRT64 versions of GCC, for example, do not know what to
do with that option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index cc0ed63af3..b667c693ec 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -757,9 +757,8 @@ ifeq ($(uname_S),MINGW)
         ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
 		HOST_CPU = i686
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
-        endif
-        ifeq (MINGW64,$(MSYSTEM))
+		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup -Wl,--large-address-aware
+        else ifeq (MINGW64,$(MSYSTEM))
 		prefix = /mingw64
 		HOST_CPU = x86_64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
@@ -768,7 +767,6 @@ ifeq ($(uname_S),MINGW)
 		HOST_CPU = aarch64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
         else
-		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
-- 
gitgitgadget

