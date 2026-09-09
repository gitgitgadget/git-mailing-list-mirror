Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71763BB126
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981451; cv=none; b=A2t70ysI86bQNzX7jaE9TuYjVvVdLSodoRQnq+1y36RV9tzj2vy4t2gx/YXPao8FXUN5RoAA0ltt4hy0WQrNbWmS/MfzeGQBf1XeychMazvKhX/d6Vr5FtMIl6FfjmyLHZAg5g2odAEf83Nkzd0WB0K4Xnzfsk+XdH0c5npg9rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981451; c=relaxed/simple;
	bh=9nw5qJuhTup9/RftlFnhcLt9X0dyTpRGtOaBMqnh9/M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fw7KhQ0Pkhew3ZYLeUVOs1PDG23PNjXHHjonwUC73AbNIGve9eWTYrYf6nWEDJQCGdQJ821v5CLkDAEGsT8tTvTMrIRpc3hR9Doj4cx0NPNZH//sqBVT7m73oNKXnHnqlbG+YtXlZBSoHoWN4qnR8yn/PMFf7OrD7bVUlu6Qaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nObZ59/L; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nObZ59/L"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2dd020a2e44so9409005ad.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981450; x=1789586250; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PiXXz2ixKbQNTYbOqGgau58vHVVinCL7ipI4PQruFik=;
        b=nObZ59/LtsihZleYo3kA965yyuq2cnkV2rA7qpREoakNkHqz9N3Uy/9CXtIADcXYaV
         d+6hf+VANsCUnCq6eNUaSfjD2vL30SKct6n/TTYSeAYFwHDD4jW1YC+Poz1yM374wdTJ
         aeRc9Lu4Hl+ij69IbDeq79Vquz6tIzsvh+Od+fQNdwupsakTJ8SbqpMz69huJSd0WXKP
         2xpKxfnEQbh197UsaX8rjyIVA0qeSiJLSiVkt8lfn4rc49G3B+pFF/vKkWW+FX+bFnnB
         +Q0TA3pgO/UPCOw6oU2CoaI1Mu4Bh4aQYgMewcUFV6wCfj8wOelHLayqePvrcLVk1oGo
         YQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981450; x=1789586250;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiXXz2ixKbQNTYbOqGgau58vHVVinCL7ipI4PQruFik=;
        b=jnogUh2AbVp6A0/cw/FUSwwgXY4eAoS2kaUkutMX++DuTuMxq3h6bWF+XJJNC+mq3i
         9/zkTdFDD2dZ6B/R/dqdHCujkOjQzu1YhynjOSvtjYYwpsb1NHkMPCqrq68EDrqfwppU
         s487l+MmKPRDM8hemBYedeyJVjFnmLfAY8bZE84VaaGaKhfboi7jpcWBNL9bMNSKAuu1
         uOwYHaxXeuu0gyY3Zg3LcM6hP8Tr8vAp2sP8nUBdiL5aw1M0Co4G6tUUIcpc0bP28/Rx
         vlAC7HWuK7rv6k7w0Aku4cDjxIJw0XUoh6sRjHnSm1EIGnmd2et1Whd7vaAyFw+fK9gL
         /kiA==
X-Gm-Message-State: AFuF++kbnTnqKZ8azvTwOX0VYWMDOGN+Aj8ZuD1xfoavjw4AzE25O4o8
	v5fwvyyv4lq2n0Zf7svhycE5St+LbZIsIEyoaQcuSqoE9usG1PFPz0jCtoAOig==
X-Gm-Gg: AYBFou1CDitQvPKQHTTv8V6ZJso2CfFVG+yJWExKb1g7VQZ+fmaAN5bzCX9zxdePuB9
	5vEHJ/uqO+r4mSfCrTuaM33gQ7SGnDA26Zx88GQ62WzJCWgKZ2QylvQbPb7bI0Q5QSrZ9getYX9
	5gOro00Mz5uKyPi29FjtE8awgODIBGQKbf2uBSWmFbbY8vBwmymlkeRPBim2j1rwhCQN41mcwlX
	iCyZdNS3HIHoYzO5TkZEXYnETCwf6Q11246td4QsOF6MT7W/Gi5PCWt+ICNHi8xFw1HfUYOqZNu
	BaYxRfEqERUyRI7g9XW6IqO9uNdYuvD2kTkG5OSiHL0DXIOIJT31XHdG+b+zdOypuPT/irKcVzr
	hXWQyQrAECSyFiCPEdtc0Tbe47+IP+hkjYw5wBR0Z5JK91tIR1DGCtM+lrucvNtXmLpEVjAjJiP
	DNT159MFz8znzAZHrNuUPCdmqe4GzE8HmmorMrlG9SSwOg59r2x4nBPcAZvUEudahsQE1cFior
X-Received: by 2002:a17:903:22c8:b0:2d7:5ebe:a588 with SMTP id d9443c01a7336-2db126d6e31mr515773165ad.13.1788981449776;
        Wed, 09 Sep 2026 12:17:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm45634075eec.12.2026.09.09.12.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:29 -0700 (PDT)
Message-Id: <b00d242621ad2da67cd07edf34d3c8d3bb19f638.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:11 +0000
Subject: [PATCH v3 07/12] mingw: only enable the MSYS2-specific stuff when
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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

