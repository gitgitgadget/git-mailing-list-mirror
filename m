Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE339E9AD
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521184; cv=none; b=QYHmgE2z70wSSSnRoWMVqR9X0RFUhaGX+wXJpO3z+bEHaDUtfp0l5E05rf/ws007cmUdM/4VE4NVy9AEbajRCWpY99+B+ZC44eI73a+I0JpI0aj7meKl+TZkb0P4RJSy52XJMNl5CgMhcc4H9mrELOCL8OzLHfjUi/2g6Demh6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521184; c=relaxed/simple;
	bh=otKoDAwZCTLMe/mhK/XkAqcZlc7oxBQe8IkHMg+2zxc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HQReB+CrkeRuGmke3OK1bCefxlOHWNE35KctVyzKD0y9Dyb+8LPpM/3s3D6y3ByZoos7/OQYdIk6a+RTuvfNyGNevWRUMg1U2aLJOeym8jlzi/kLiXzqtKnKasOXQ4AKZqRvxRoS2Ems73rb8WFFo5vstGYczDlXvR3BbrTRCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxLNK85f; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxLNK85f"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso801288b3a.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521180; x=1787125980; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hyw55P1alNCMt5VS/ljJlX/iuvMulsFfubfBfjeaYmU=;
        b=VxLNK85fdthFp0Wqw0LvoEDOdmrQ9XyIWCI87k+fYo56IzWAcN/WVmqaflFa/qtSeD
         4ar0Nfyu+uq9s7lqFLQOIYF8yeyQFaDyUgv/C9f4dUzSju2vTfMoCNe6eyiHNoX+e7/h
         SlTmDWLi0SGxzDhhWDAxEekBDDdso+DfU8tfpIIwnhxTtAjHzZWwZ9HqUuk9/HCpmA3h
         W2SMCmT+TRCgp/pKYjib0b6eZarTNnDHd9deCzrd3VzOTCxxYtf3u/DnQramfruLOwFI
         h9Wth8qg+GVkwaUT3diFc1rUmMTrTzrk0qF0TTUJrXFElQYy9hUpkl4bQxGjs6ue14D6
         esTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521180; x=1787125980;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyw55P1alNCMt5VS/ljJlX/iuvMulsFfubfBfjeaYmU=;
        b=C8D60M+PI90LDKxclXfluMR6U8ksFCb6RUhJST4Y0OUb5jQq/2gZYYdxNL6pP+sgnN
         vvlDllaaT+4dQzobWBRzlKI0KI0nth7vAHLCu3EOpTPh6QmanWWOpnN3x2dshnVu4Xlo
         ZHtxsS08vRYUy1D4Dp9WsIYOVw+2BKFy3whS3POn9VG2gNdSEeBbPSnFls19c3d5Upe4
         e8xYJbDRQRrDMg8XVIRZJR+IhZk/DxsBjV0jhdLs+fwKRG/0a/Tfyr+mlHQkSl44ZTr8
         GRLVv20gP39NyevzHjt3cgil8th0J0yNX5gHNJ42rmCdy7yq3DOqpGgBaEQ2QXuIkEY5
         Qfrw==
X-Gm-Message-State: AOJu0Yw06yjMrB/Dapvdfj+WRj6U4gFpGxUBDLlWuM/fNgxCgz7WrP+1
	Q4CmpBys1spHILBR4ot8v6ob8uA9BLZ9Yu3FB503Ymi99cGXLrTsoOTzasLCYw==
X-Gm-Gg: AR+sD133hAZAROUbB6GNswl0cxa06yPgBoHn0MXOtGEpdKrdsUfSzshk2bxE9yD9Cx6
	WKRG8X+tqzenxalm3uh4IuO+lycqk1Nq+tvRDsOxQJjFvW0U+mU8xNPzSk752FjiIE0krLRchc7
	hhPVVaTGkJrZ09Wf/IMl/n6pwCmKS0A8WLuzMxzs1/KiPwOTgGSZnlksLFGQe8Ot+srRx1ZLD5j
	c0as2EKegX3evpiSOmowWgca5ExIxSkdnALmnYwVqD9MVXvUYKVS7YrewjjJ7htaRTtXnMMuCsK
	8pShEo9o3Ht9hrzDuTt/5tavPCr5/K9j6wyfOcB+9nEVhdJlehRXXquxvdtnPQZdzm5A70XA8aS
	NNRRBrZsKnbniz53BlbBWu2i/EeykEH3TSsDPfcdB4dKQ2nfr8+cCP7TH0/fUNuKGZ+KY1YM0Fl
	kx4h/UkbIDxE92SDh9w5Ej2gGQAEZaMzvSd+qbwJ5VUPA7u8UiFoCYyEp5aQ6ajrDmUswmY8+qU
	jg=
X-Received: by 2002:a05:6a00:420a:b0:847:77e9:acbb with SMTP id d2e1a72fcca58-84fb540a6ddmr3656269b3a.13.1786521180256;
        Wed, 12 Aug 2026 00:53:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1cf445bsm653695b3a.12.2026.08.12.00.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:52:59 -0700 (PDT)
Message-Id: <53f1fd576379a7331e827a2384605a1445f85d86.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:43 +0000
Subject: [PATCH v2 03/12] mingw: drop the -D_USE_32BIT_TIME_T option
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

This option was added in fa93bb20d72 (MinGW: Fix stat definitions to
work with MinGW runtime version 4.0, 2013-09-11), i.e. a _long_ time
ago. So long, in fact, that it still targeted MinGW. But we switched to
mingw-w64 in 2015, which seems not to share the problem, and therefore
does not require a fix.

Even worse: This flag is incompatible with UCRT64, which we are about to
support by way of upstreaming `mingw-w64-git` to the MSYS2 project, see
https://github.com/msys2/MINGW-packages/pull/26470 for details.

So let's send that option into its well-deserved retirement.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index a464b2009c..cc0ed63af3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -768,7 +768,6 @@ ifeq ($(uname_S),MINGW)
 		HOST_CPU = aarch64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
         else
-		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
-- 
gitgitgadget

