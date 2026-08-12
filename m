Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48A393DC0
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521188; cv=none; b=VeloeBV9yoUv2gFZ3C8C39GCOxnadjYBq8bfmZbp0JmqD8KmUr2BdzFUTMrgU5pHDek56fYZ+onNV1EcNCzzQsPJHX6sE9Ull7moUuYtiIOJ/holI/HTLVnCpiOVQo06F9KH0ajiBEd1K89iQdV+gHoM/wY/c010D4NPLthg098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521188; c=relaxed/simple;
	bh=T2gc4X7ZZRpun11O9hyf1XCi3A6a+rsn+E8Qx1Vrtd8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hDeqKObEo+IMd3hnmsIdAUuVRfML/QTOttK6nbnID9CjW/HYSjfFHhd2bcO6YwMy7Ne8L3oQGtj3oOYa+3A9S/h+H6qhFp5DsYqdbA/VeA9TXkYFfNL1DWh9zO9lSkVrwc5TNzDW8rITgEErWfpNJNmWhjgHFz8ayjPvcVz2+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMD0KF3I; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMD0KF3I"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84830c774a0so939455b3a.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521183; x=1787125983; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ILyrVVd08nn+N9cu/FXvgcHG6hzZpAgakTjwOtMYuNY=;
        b=bMD0KF3ILOeZZrOvydrs1R/Nhg0qLQp+x8YhgTPLKJgoCWo9Yr2/nsRy1YGwTcEhuH
         huhOBAwCOVpOh/Z9VfxosHGo40t+coZ4LxTxEQyP12xV6ysjAF7iaO8m1M+hoshegyKE
         PdYidesF0VklTq1r2yxKePCzyv4Y6NzmixzGhdGqST6jlIl679wyNW1yWY6DDjVL1Wgq
         +GtONn8oIzyh2EQvrtQ8btpii3A5zrociNrJgGsp+XW2/wvWt5eRccK9z+0NmwvshlF8
         mo/MdbLEwz/UFR/jNgFQx1J+mRTTZMi7AcXrXHs05mi0DVoBOQT/IQzjMo5W3YtSkuRV
         +x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521183; x=1787125983;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ILyrVVd08nn+N9cu/FXvgcHG6hzZpAgakTjwOtMYuNY=;
        b=KmTX6FRxC1L4emAN6GUb8aAIwpJbTE4e246si5tRSK6fa9KNKU9q/YYiwWGJtME22Q
         sNdNlO6gLnmh2bd5Nt4akStoEiVlrgj7GXU3winAjRj0hx7rxsi8diaOgxAWv1gnpsiT
         SvNmzp/Qurl07ZCGqHiTFK0iZmBzqxtPp6IzgiMfvptuMyW00U67CjqgatOGMVWsJstI
         cy1JjYUe+vzT7vBJ4MPPRnwMIzWlAK5c1K8YvahNzwBYhJdD4w8sAd4ZARgtwF9+iOip
         qsg34fMT6GDnDtj/vBpb4rVjDKCAoEL0yzpdbFYhCvKKIglg/wDs/c39O05HHbgDsapi
         6esw==
X-Gm-Message-State: AOJu0YwsT2DUEfOFBK3Y4/kLaaHsXAmyFczPvBPhqhb277DLX3qzfHu1
	jbCiWK8xpZyxN2R5V/ygbnSve+MoebAI3MdTK7oE2xGXEmShRpO/8pxi/zNcgQ==
X-Gm-Gg: AR+sD109rJ0TleRXg2EZQAZuPlm+k3j5HfEk4UgtCmdU8TJHVUWN3huMdnbTctPcLYW
	WucGwQD40hpu1ASWlbUYs8oAY1gwjkevYo7rP4reyQ00ul1luJY/Grx5LsWhOVah4VQudo3TE4N
	/KpCCr/DxKrVHSbwsD/4TMXOpk+wKLFTP3yAXELVZxpjn0rwTEjhaHf+7h/Td6SK9MOTyjIpR/9
	tglLIyO0EagtTxNuhuWDsdoI+PRPk4ZBc8mzwfFFYPTTsTxmkNv+Q3jt5zAtN6nntYuQpzzPqoB
	fcPaMpf27IExnjIVXAuwGsQGACvGtFHmCMN20eCZ40jzqGpS7gK/hxininZmiqcI1Dq/+KUrNYO
	gnPeBbAem/vBNbvXFDY4UVIpvJTYQbfxU+w2HRs/vil3y2bGKvGn2vUEFz7gBZBSOqztuWhCGX/
	X34Bx63dKVi288MUC0nHIbWWW5hRGYGuupmiHtyrod3MKrA7ngUMyItJwaPVPaRG9C
X-Received: by 2002:a05:6a00:a0d:b0:845:d6a5:716b with SMTP id d2e1a72fcca58-84fb54fee49mr3261499b3a.23.1786521183044;
        Wed, 12 Aug 2026 00:53:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1ee8bdcsm653374b3a.39.2026.08.12.00.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:53:02 -0700 (PDT)
Message-Id: <d67201f9b3ad288373fcbb73fed15356b7a795d8.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:45 +0000
Subject: [PATCH v2 05/12] mingw: avoid over-specifying `--pic-executable`
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

In bf2d5d8239e (Don't let ld strip relocations, 2016-01-16) (picked from
https://github.com/git-for-windows/git/pull/612/commits/6a237925bf10),
Git for Windows introduced the `-Wl,-pic-executable` flag, specifying
the exact entry point via `-e`. This required discerning between i686
and x86_64 code because the former required the symbol to be prefixed
with an underscore, the latter did not.

As per https://sourceware.org/bugzilla/show_bug.cgi?id=10865, the
specified symbols are already the default, though.

So let's drop the overly-specific definition.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index b667c693ec..f6387f4c7b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -757,15 +757,15 @@ ifeq ($(uname_S),MINGW)
         ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
 		HOST_CPU = i686
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup -Wl,--large-address-aware
+		BASIC_LDFLAGS += -Wl,--pic-executable -Wl,--large-address-aware
         else ifeq (MINGW64,$(MSYSTEM))
 		prefix = /mingw64
 		HOST_CPU = x86_64
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+		BASIC_LDFLAGS += -Wl,--pic-executable
         else ifeq (CLANGARM64,$(MSYSTEM))
 		prefix = /clangarm64
 		HOST_CPU = aarch64
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+		BASIC_LDFLAGS += -Wl,--pic-executable
         else
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
-- 
gitgitgadget

