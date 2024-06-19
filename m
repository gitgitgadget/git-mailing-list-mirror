Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7DC4A1D
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718777403; cv=none; b=YSSJZ14vXYTZhn23sszpUpdC06At+EdQOxwmB4pC2YjeV6EK1RPzNwbzvQtfqDk8IwLaxqtTWc+IyGfA/9qpZqJXwv8NiuZmnPPpiIDFJMXytTFmmdP15TtwvXAzTnbrXncotlc13CHWRJBqecw5AFy365knY9TRaJ25DFn1sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718777403; c=relaxed/simple;
	bh=+RDHK9jVP+yKzheJI0ezfjSdFl/nOth/MaVa950Sfeg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GECFSKjL16LHGPQesfznKdQS0c67zJDsv7ACg5IblO04bEOqU5QV1icYQBkGnPUcnmI45sXcBasZmAM7yV/8/BfJurJxjMJL+hH8tBQRpoHSoGuEk65goGviNCh6qTmkssJrFZcMRhKksHYsdQJYU943d0GFdbVMwCmw84Txffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQFQzkpf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQFQzkpf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217990f997so45035175e9.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 23:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718777400; x=1719382200; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XEF1gw30YL9jJDlOkuh/aWCkMbD+nRSvjTBftD3FCYY=;
        b=dQFQzkpfWntMRAEsFMIoHaYc9nUPj6L1DxRSpvxNYUmq1u4RFuiLPffev/LZ/kbr37
         8Kj5uNVYquO8NSLRJtHMJvvhIY54XB+yrEU1F8Aqiqf6OSeQ2i0cMn5gbMbGKwJzHt5I
         J696KUAa/3QSTy0ZPD2YpvkXdcIyopbN2kF3zhsbAq0VsQVFATtMhzo9ExySnyRSGDLV
         WXb5XeNntfby8OOTb8319vKuQdUfW6lHeo/3PDfn4iwjZVaA3YjokCmhuuCInIrGt0tx
         hoHnou5UE0Scs7l21dl3ApSPPLeMSxSct+2MgiMDLBnFcOlRt8wYIjgFY1xZjWS5i9Yg
         y0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718777400; x=1719382200;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEF1gw30YL9jJDlOkuh/aWCkMbD+nRSvjTBftD3FCYY=;
        b=LIHwQxv26bsNAnXt8o9ErFfoQ5Qq5UflqfRWud3BwiCxRzI8pfLaSu0GfWt2BSv8E8
         5MEsI4WtNYELEVcYNyogdj0SRBNdLMztlrJ9YCCzrpPiiU0jZF3N//qmtjwnVsPhPtVn
         MEnXLdE06BWvnpjvEg+QtgAfThmekToXOa+e9L19tx4ss1qXOSA72nsda7FqhXQcUeAR
         8k2t/cuK3DItWfSY6LSdDtCqq0WsxThYaopnyFhWuYBBWjAzHmVerjOL3gdoWTCmynq4
         IehknGkYIlBr1TDFwCCcyU8Q5GmDik68I39AYbMWE5mIo/Y/R8DsDmAgy0aRGmO1nFKD
         1lVQ==
X-Gm-Message-State: AOJu0YyiAZR8eIDa+YYy0aZWtCJ5Hknpo6PtD60bYd6kzKTeiqFl6GPN
	4KBosbHb/6S5VHIFrdivgxxH/CujwSuX72EKpiYxLJzI/8ZZ2umRbawIdg==
X-Google-Smtp-Source: AGHT+IFVXZdJZ/t26zWMMiwU2zC7lebAMf3uM3bKqObPgpnkKDcRR3YnaBhN0fVLiGlIoIp1JtN7TA==
X-Received: by 2002:a7b:cc13:0:b0:424:784c:b13b with SMTP id 5b1f17b1804b1-424784cb209mr2631265e9.13.1718777399919;
        Tue, 18 Jun 2024 23:09:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320b11sm216322855e9.29.2024.06.18.23.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:09:59 -0700 (PDT)
Message-Id: <pull.1752.git.1718777398765.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 06:09:58 +0000
Subject: [PATCH] mingw: drop bogus (and unneeded) declaration of `_pgmptr`
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

In 08809c09aa13 (mingw: add a helper function to attach GDB to the
current process, 2020-02-13), I added a declaration that was not needed.
Back then, that did not matter, but now that the declaration of that
symbol was changed in mingw-w64's headers, it causes the following
compile error:

      CC compat/mingw.o
  compat/mingw.c: In function 'open_in_gdb':
  compat/mingw.c:35:9: error: function declaration isn't a prototype [-Werror=strict-prototypes]
     35 |         extern char *_pgmptr;
        |         ^~~~~~
  In file included from C:/git-sdk-64/usr/src/git/build-installers/mingw64/lib/gcc/x86_64-w64-mingw32/14.1.0/include/mm_malloc.h:27,
                   from C:/git-sdk-64/usr/src/git/build-installers/mingw64/lib/gcc/x86_64-w64-mingw32/14.1.0/include/xmmintrin.h:34,
                   from C:/git-sdk-64/usr/src/git/build-installers/mingw64/lib/gcc/x86_64-w64-mingw32/14.1.0/include/immintrin.h:31,
                   from C:/git-sdk-64/usr/src/git/build-installers/mingw64/lib/gcc/x86_64-w64-mingw32/14.1.0/include/x86intrin.h:32,
                   from C:/git-sdk-64/usr/src/git/build-installers/mingw64/include/winnt.h:1658,
                   from C:/git-sdk-64/usr/src/git/build-installers/mingw64/include/minwindef.h:163,
                   from C:/git-sdk-64/usr/src/git/build-installers/mingw64/include/windef.h:9,
                   from C:/git-sdk-64/usr/src/git/build-installers/mingw64/include/windows.h:69,
                   from C:/git-sdk-64/usr/src/git/build-installers/mingw64/include/winsock2.h:23,
                   from compat/../git-compat-util.h:215,
                   from compat/mingw.c:1:
  compat/mingw.c:35:22: error: '__p__pgmptr' redeclared without dllimport attribute: previous dllimport ignored [-Werror=attributes]
     35 |         extern char *_pgmptr;
        |                      ^~~~~~~

Let's just drop the declaration and get rid of this compile error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: drop bogus (and unneeded) declaration of _pgmptr
    
    Ran into this in
    https://github.com/git-for-windows/git-sdk-64/actions/runs/9558244721/job/26346637793.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1752%2Fdscho%2Fdrop-bogus-_pgmptr-declaration-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1752/dscho/drop-bogus-_pgmptr-declaration-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1752

 compat/mingw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6b36d0387aa..41d8ca335d2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -16,7 +16,6 @@ static const int delay[] = { 0, 1, 10, 20, 40 };
 void open_in_gdb(void)
 {
 	static struct child_process cp = CHILD_PROCESS_INIT;
-	extern char *_pgmptr;
 
 	argv_array_pushl(&cp.args, "mintty", "gdb", NULL);
 	argv_array_pushf(&cp.args, "--pid=%d", getpid());

base-commit: 08809c09aa1351b603e9c55734105cd2e3c24c41
-- 
gitgitgadget
