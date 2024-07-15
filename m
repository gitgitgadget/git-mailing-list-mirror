Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D555282FD
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074889; cv=none; b=S4vv5/o1K+0y2UaiHUAYkfJvJ2L4+urP85GtPs8iVgf60ehIFAHIfvTEo64oMxrBL037UR0CSPGrAmzTZIdKmALuI1vFkMavasPoFNK/hSp6ilwebQm1W+V+rWK2woxZQsrNltmsdD6kywN+P3pH0HwkqhmphHr6rWHzCZXbvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074889; c=relaxed/simple;
	bh=u32LQG4dN9nfkFEuddyIXoN/3mhVI6NWOOXZDTojG8U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MN2JO90I+TCjguqY/XPYXuQlxI4yh2m/AYy9k/L8AWjmh2NNgDIC1x11fB3Q24iZjT/FwJCoZS4vfAkvVQbpzyVJKm8JVDu2YKWWOYYp6PHWy/7DUe1HFD8IcypgwsqVGZOZ2daFAWYIGQWTUpHxMkT1aepLHizDst3q/ik0BYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqAPQusb; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqAPQusb"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25e1610e359so2200232fac.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721074886; x=1721679686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W8/Ekc3sWlNmwWSqhq/+qCoXGlhRecvSYcC1v2Zj1Xc=;
        b=HqAPQusbOjHTnYpfISreU5IhzTmgbAyEC0a8LMTzskKPO7riXVFeXtz+XQJPxGJKlL
         4r/xCfJpTIloS8mdOnXUx40uM+tJo8FtYtgeUJPvjLyvjvzc/RZ4tWKyen+zbvsnqx/R
         DFAXoIw1hhVo+p3hOiWgx2bxjWoEI+Ta54Apy1FgcXshQo6vbuyuXGpQTGu2XA5/EAUs
         LAp4IsPaMN/1RO0pQnp3aAHud+SmSDcjGOrLvA0fzAMXPF9PA1wByZGXnSwIxK0QKIeo
         Xke+1gWuTjYxx4vWzBzMxuG4e1uxocZBuiliC9XYkDp3Nr5hKDa+VLQl1dbEgXqzNRS3
         P9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074886; x=1721679686;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8/Ekc3sWlNmwWSqhq/+qCoXGlhRecvSYcC1v2Zj1Xc=;
        b=a+tHbb8Wvq/bxWG0oq/E2yhkXFNhty7MztvAnNwGFlg0h9RJDJR4BrRwQOJTF/jsdv
         zENe5wn6cFF8CTUVFZRhyaf6sKGzF/bTwzKLFN9x1Lo0Y/vvMYmOUpk2zrx6+Dh43jlG
         Rz9q3O4itViQ50OXyyzJfjL7xJSh427Xp+wrrCOwVMoMMGuuyWF2ABZU59EUxqzC29n+
         uVN6M2lM/EV3UAtB2tUppYHF+z0xZ0JCaYvu5wERmtA6JFy2qx5mQvZg1ldx2vhbbFcv
         VMskoVGvJHnmKt/iJ22k9D01IP6sCCu9M2jUJ3oC0SheDhrprJXGFxJ2FGUlNPPpReK1
         xSdA==
X-Gm-Message-State: AOJu0YwY7IJCJXzEUChtF0jheGdJCGre4DM7LE3UBQRpe3TMTMqiDRz1
	xgrd9oO7u/U5WXPupgOpuPaahOzY0zT+bQKO+THR5uIdMQWVa6ht0qvZdQ==
X-Google-Smtp-Source: AGHT+IHVZxYmnToxNV9We3cDJbjOCo2Im+lWWysDN4Sdty8pAniyTO4sTIbJjezrbs06ljI7siOSIQ==
X-Received: by 2002:a05:6871:58f:b0:258:3455:4b02 with SMTP id 586e51a60fabf-260ba82a853mr314129fac.51.1721074886540;
        Mon, 15 Jul 2024 13:21:26 -0700 (PDT)
Received: from gmail.com (p4453252-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.169.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7eebasm4797789b3a.136.2024.07.15.13.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:21:26 -0700 (PDT)
Message-ID: <5478131d-ed0c-4a0a-832f-39189db07941@gmail.com>
Date: Tue, 16 Jul 2024 05:21:23 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/4] pager: do not close fd 2 unnecessarily
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>
Content-Language: en-US
In-Reply-To: <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We send errors to the pager since 61b80509e3 (sending errors to stdout
under $PAGER, 2008-02-16).

In a8335024c2 (pager: do not dup2 stderr if it is already redirected,
2008-12-15) an exception was introduced to avoid redirecting stderr if
it is not connected to a terminal.

In such exceptional cases, the close(STDERR_FILENO) we're doing in
close_pager_fds, is unnecessary.

Furthermore, in a subsequent commit we're going to introduce changes
that will involve using close_pager_fds multiple times.

With this in mind, controlling when we want to close stderr, become
sensible.

Let's close(STDERR_FILENO) only when necessary, and pave the way for the
upcoming changes.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index be6f4ee59f..251adfc2ad 100644
--- a/pager.c
+++ b/pager.c
@@ -14,6 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static char *pager_program;
+static int close_fd2;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -23,7 +24,8 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	close(2);
+	if (close_fd2)
+		close(2);
 }
 
 static void wait_for_pager_atexit(void)
@@ -141,8 +143,10 @@ void setup_pager(void)
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
-	if (isatty(2))
+	if (isatty(2)) {
+		close_fd2 = 1;
 		dup2(pager_process.in, 2);
+	}
 	close(pager_process.in);
 
 	/* this makes sure that the parent terminates after the pager */
-- 
2.46.0.rc0.4.g229d67bbd7
