Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB236196E
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521190; cv=none; b=Fb4GzINpDMneTsrv+d06LLdn9K3POUlviK7tiWIRR0wcHV+pkE0bIuluU5e4W3QBrHrlLWqQNruZfjKhNsupWYyOoM37mz7pj/yOBuCjOwx1vif+WlkeJQguDUQjV6skomNud2bWJHgVl8gfGzb3RgtB6SIKaXp862AzIPySoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521190; c=relaxed/simple;
	bh=9nw5qJuhTup9/RftlFnhcLt9X0dyTpRGtOaBMqnh9/M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WlBNGRFEBIAslmqoT7VQERNJEFJPKQcEPa9XDnmAAqnqBybOrv/0WtEGe3TqX2ojRxJxCXxBJuODMObMq9AxhJs7uzLdVJllfhZxSHWdkhbH/h/OBkd/swO8MqPOne4VzAGF5nzux26G+L2/0mMoklp1KmMg0JNeSgaDi5BrPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcLwI4gK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcLwI4gK"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso801365b3a.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521186; x=1787125986; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PiXXz2ixKbQNTYbOqGgau58vHVVinCL7ipI4PQruFik=;
        b=mcLwI4gKOdMk5s/nE4frlsfNFSydF31YM9B204Lo1DIhhlnj9uIoW0fX0Zygv8q8gL
         KDodLkI2edfWfs5rvVT/AK9PnDxhOpNSkmRcxh6RB7dTvb2M5jToTLhpLBqZ9nQgnCLw
         9zo0dIFIrnMcv3GLVLAnPIOhTBSYc4dujxZ7QnJYOllyds4+bCPBMKJeDGEAdNPSTEnK
         JRL3zGdWMMzHoHLINDm2C8CGd4y5WPuVbktXAthBXW+wPxAM1RllbkbP/9PDBI2dNuXW
         ruHoh0hi/tCHS2lOsYT5yuKPkrRL6H/scG76Gcd7ISmAloe+Zpo5g/HgRH20ecZjqd3T
         9TsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521186; x=1787125986;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiXXz2ixKbQNTYbOqGgau58vHVVinCL7ipI4PQruFik=;
        b=Tai6z2Y9YPTdZB/rhu2XUvA57HoBr1amAo4TUqPGDnewvfieH/rGWFsv6mT3Cwg7xS
         dKea0jgl5qTAHYY3FLtBISTlR9r7VLL8ryz+U5OBr2ui6BwL42HaFMZ461Zf4SYyh2mD
         bJyrWoLOT34kDe44VIeJcpcyghYkmVMAUdtQnbhg/NQE3ee8YPpz1CRwukbOncTDcWpx
         dtZx2vhzE7zb7/CbxK6Pn+71HZpRLf5vZOVAj2x3vK3MrDNEUR5C7inKOzewXuVRNDUn
         vT9x8LtzVzua64y3E94a+8qcAmgVSx+JoZ4m3iVQzVqIqHhSAUA9RApdfFH0y90yv4jd
         Ig1g==
X-Gm-Message-State: AOJu0YyDDcpKK+tljYSQgIjrOfmq1pKaa/N0g3Jj9OLLvWRfOkSbGxps
	45joKvvk1un7QlKy0/94G/hljeqtk85lvyOk59vqwlLA9NLmOnMZUA9O6OzzdQ==
X-Gm-Gg: AR+sD13i4FHRBgQBaVSfBXY48nqq3mkSsxdAbnpuqi2RRySMCvBDVyxAZWYmTJ+XpwJ
	y/9yz+VizYnEDcxinemXORFwD/rHNdkqtIiDtru7vtvlMymlq3OzxXkxLoELjDoXtb5tfQwqDjQ
	1PKuO4nBKEDvi/u+vQ8Ag9077K4LR79x+J5KbFFqkUkhxCbEC3TWwkMn6ZH4iShHiWIt4Fmsop9
	kvXObn6Q90lze9slCX49mD0N8URW6JLH9bzAQs66KTe+akOmrqExY7Apr9m1kabklcyr2IwKFFm
	HUpznj2vFTyiQ0dQ2SO5i1P49QfJcK/GYLD9W0AAm0IScuwuoq6X5amG/bZ2Wso9u1CIvF0zzgK
	wSW6ZIMaGGooog3vZDCGZqQnHf82OUpx/r7AbKfVauVmJHl+SPIgy9kDXPQaVOUnU05ExoymqOY
	E1+e2PwlBolFl7GNZKSpexx05KO4cTIWZwZ6IEis8j6J3ftxU4ITpsbWlfv8S+s4WPvrv3tQ==
X-Received: by 2002:a05:6a00:98a:b0:845:c8f9:6ce0 with SMTP id d2e1a72fcca58-84fb54e4ce3mr3255515b3a.21.1786521185957;
        Wed, 12 Aug 2026 00:53:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1b73aa6sm682033b3a.0.2026.08.12.00.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:53:05 -0700 (PDT)
Message-Id: <b00d242621ad2da67cd07edf34d3c8d3bb19f638.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:47 +0000
Subject: [PATCH v2 07/12] mingw: only enable the MSYS2-specific stuff when
 compiling in MSYS2
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

The tell-tale is the presence of the `MSYSTEM` value while compiling, of
course. In that case, we want to ensure that `MSYSTEM` is set when
running `git.exe`, and also enable the magic MSYS2 tty detection.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8363239513..21f53e3f7e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -758,12 +758,12 @@ ifeq ($(uname_S),MINGW)
 		prefix = $(MINGW_PREFIX)
 		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
 		BASIC_LDFLAGS += -Wl,--pic-executable
+		COMPAT_CFLAGS += -DDETECT_MSYS_TTY
                 ifeq (MINGW32,$(MSYSTEM))
 			BASIC_LDFLAGS += -Wl,--large-address-aware
                 endif
         endif
-	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
-		-fstack-protector-strong
+	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -fstack-protector-strong
 	EXTLIBS += -lntdll
 	EXTRA_PROGRAMS += headless-git$X
 	INSTALL = /bin/install
-- 
gitgitgadget

