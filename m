Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB038BF81
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020340; cv=none; b=EK81PZRtCt8S1OwkMoJS/3508GRdIhsuFztiUReB9kjZJtFAcgPUhNfY49ze1Vin3S7PSk7NUWAYpG4nBpbVf3Q/NuGrwJRetDHrcHH6CdO3FznyD9i/i6eThz/Y8l9824GeP6KtaP3jxE9quA8n/qnfTYZdyoKXvQ0a6OSfHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020340; c=relaxed/simple;
	bh=89nLw7EZj66FvBEaRRyOMPebQcxVATBNoKooCJORMAY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J0IUDOH9HT0Cku0DlCr/o5wtVAe3rwH/LnCPPkGq9a3N3c456Ql/R2B+b/lsT8f42Ns+nc1XxnNujESrfvsPfBVCRizsdcF8/1Xa5SR+HcMq5+MZj1RW9Hm8hBgvmux/zXDbyg63Lzuo2kxNeg8pk8r3G4KOmvsUwYHKIWr2Ls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6uYHzsF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6uYHzsF"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-39675172593so5674925a91.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020339; x=1789625139; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ll5QfYvjGnS09/QE0E9ZwMigAu6WnbwpvUc3eBVGEX4=;
        b=L6uYHzsFhBNsHkR7TBNhHk6a7mXPaJePHpU2tUhpdP/TCLHFyBxg6gdwYk5PgyducD
         N1OnrvEZEhi55GQ6yrcXEqTYBslI6Y6IcWaX27o0CWrE8WYZbWhvQOjbCU7Jdl5l0+kE
         BUZghntYr0cg+INqYLLLZzOPoa+hVXWGRUUOKb6kS4BUKMNiZvwjb2sgWbxpPMUpqq42
         ZHDTroAnbzo2+8YYDBeTofPKQyAHQgyOQsqczGXJSfCVdrouMcxrNdwUprDM0JZmMU6W
         SybebuutwuVkLT1Q/c7nLQwPRIW+545ltqkVSxJktR75uoaToDR6Tg+NkGPliVz5Oh0r
         vPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020339; x=1789625139;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ll5QfYvjGnS09/QE0E9ZwMigAu6WnbwpvUc3eBVGEX4=;
        b=OVKKxW+mO3noXB+i855MwIzJ7TS2O6/uq46qZ5HEePz40+Mx8xdNknxQcIDB+cTG8c
         yLh0gBhSWMOw0s/wKRb/RF5VdfByf/8fwGVnWAboFybYynZ8dXH4VZKY7gppjIT85W2M
         RafOFpxeNb6WphBtNJ/8jB+HJu96vpPc9siqjicEF0QB5wyifc4UmiKrI9B1upqYTxf2
         UQ4zlggo5TPeqzSOCDzZX4Fn8E6CBbmW1HxaFf7obERXc7/Fm/KhqAC7KwKxLI49u27d
         OtkhMSROyfp9dD5KHH48+Berul/SmxUVpYGpwPgqJTDZgQDKcfXtrLWRtf3eQnd2B0NE
         qFqA==
X-Gm-Message-State: AFuF++lNpybMuMb7IbHfjsA4IEkrYgzYaReyD57Xe5QtuFlcIuR6Vv+3
	U7FlY5QG6Zwf0g8xsODBJViwI3vHATXnUnIoHkN6OIjomPvN4NRfr5CIHZuryw==
X-Gm-Gg: AYBFou0qIOPJWfbe8vOwQuG1nuGQ/THdzOKorYv+Jyozxq/EeTKEK6P1iQlqqmFvXK8
	054vNGL6cB9D+cEI38uSzt20Gz3ygbysLeb9np4TYhDwno5MuM6oOlQnbs88i5JuVJC8lo4oQtG
	LtGDV00emnoiAJ4KTL/wBme95dhOhnOVUm7hk6WbbyoT9oRac1GrG+CVfeEIJvFqX2db4OUymYk
	sruxqeQmCAlUsNZqhvIdVzBs8sH9zjX0vklou+cqGDs3DstozAgjEzQxibcgqa3RpBxroduSbOV
	TTq0EbrtjMq6jPzhzmCXjmZeH/dXZfFqQ3PpjPB7SbR38enSOz7ePFZ+Kdi4ueXl2rSVBxaZIw/
	O9YEiUWOkgxfU1+8pKhPnwyzrQbefHEt7IwwPqlrDEMqyXa7USJnJ1IA24WBVefETSCh3b5xcYD
	bzvdMrwNakbU+Ve0fjIyW9JUMXd8TFmcNeoZKc+FyU4neVFzCaUDE2arKd8Fi+ZMrN3HJlK97SZ
	T0Ne/zsDug=
X-Received: by 2002:a17:90b:3ec5:b0:398:9c00:29ed with SMTP id 98e67ed59e1d1-39b26277673mr56837899a91.21.1789020338661;
        Wed, 09 Sep 2026 23:05:38 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333959d5f69sm46648324eec.0.2026.09.09.23.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:38 -0700 (PDT)
Message-Id: <29caf78bddc914ce610750f6fcd72e4bf10d4a79.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:21 +0000
Subject: [PATCH v4 07/13] mingw: only enable the MSYS2-specific stuff when
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

Helped-by: Johannes Sixt <j6t@kdbg.org>
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

