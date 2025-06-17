Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8C2E06E9
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186576; cv=none; b=YTAwbg3E0D/4oNrZq2+o2q9VJlNRqFPlXAxrezYXjQVLSwU4hW8ERWzwhNW+jdgoUY7i/PfbR3RPXp+SLQ4pYerTWRTx25bec2RVpG5bYawDEW+KiPyZurS6ghxD99BUKfVISvkuflSnxb1g8JOPyeTQPkLAtIf/S5auV4j9iew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186576; c=relaxed/simple;
	bh=caQ3QcDEiUkNizktaNOoumTPIyOktxemt/f3CTnkjmo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=g4p47cfVRxJ7A60h6M5MANwUqgz2WJxh4awToZX7ruRVam5T1w+idS/WCjnad8uAoix1VtOshNEC4elNlBCCoigA8PShI0eu3pjBR7KorA82vx63XiQpMkXMGyep2CuJOxsbk2QL7A+wtqJ8EdpreoYhXNl667X5ysUJf9zFZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avu0tN/k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avu0tN/k"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4533a53a6efso5359135e9.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 11:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750186572; x=1750791372; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VH4DrWgSve6JMqtcjZOpmPCv8N/UPcvAUzxeSp/jsA8=;
        b=avu0tN/k1SnYFIS94uMqQyjzYLDvmXCTleLbns7/Y/wBZPIEVXET/9dSnbk5TY9BFD
         5LGr54ACaH8SbPJ5JaTFCDKV1VPsu2brtscIwMQYrYNKsLnU+e4Aj9ztdDkqKpsfaHiX
         zLQ0BjO5pYknfqtcO7M7Vnh+lxuCK2s9ydapFrcXGqEW2hGBKiQtL3ZVxX+0KlpNbNEO
         6Sk50Rmxi4hjOV9tbX38erkx1FCduK8o1ay8vk/Pp+kaNqc3DDQIl7oXg19/lcbezESN
         u5cyBKfjWMMHjobyUK3u/g7OknFwenAE5r56POS1vofQ7bQqnJcbju+vYfCmY185aNAF
         dHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750186572; x=1750791372;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VH4DrWgSve6JMqtcjZOpmPCv8N/UPcvAUzxeSp/jsA8=;
        b=uvTULM7eYWyMqa3kG9h8iEJRjALreoC30V97NmP395Pj7c5X4TS3p4GiS/nF8IXZLA
         S/cULtmCNhVT1nsbnChASL2C6aO+7lV/41yNkIRJ2+upe+Kq9qg6N+MN8rNgN4PtluGl
         yK6O7y+I1LcohvcBySkhou2IM0Ur/igztRm8hRygGVAvbHtvnCJMIF+lTXMNji9SjNKR
         lv5VyUE296VexTQwJZyisfm4wKAYTjtT+nD+F88JYnCyVTWsxiTVg2+hYtZN/Zut6YdQ
         bH/5ywTULQJHMJikpK/MRgyqZLEOLmu87nSk1glrVs2rEDTimdjAbAx9NTxOT6IewdTt
         +DPQ==
X-Gm-Message-State: AOJu0YwiY0sYdhPLHSv9t/VObVdSGK6afGytN3D4NDZw5c6q5kDSgcUd
	OUBGRM7Ay5YfaEEt6rr+YgiaddS80rfPCGjQ8o04EW7k6yWvJBu0uR9vg7+PNA==
X-Gm-Gg: ASbGnctzlqQsW+tGqWfxQcIJmjOf9SZLdVzx2LMST9/LjcGQrNq/u0vWqCCl2+EfDzj
	tONhBBFIe6ORu419h+kXOEjC2PXXc5cQ1K/krk773uaBLgLIHlWrQvhES2T6ABm7kpgpFSJHV0Y
	QOdtCnJwnw+BOxx9w4hhYa/sA0tGnzt7Cl4OZfpHgM340CE1VB8py9nIAttrsJVcPhHWbW/QSDe
	TCnqLIPA5wL5EUoQ8W5yczeSFTXDjLwVCDdeAUnWqxTDf+CrH1t1ARcCXp8eOcMt5W8QbWqCusw
	sLKOoi1zbAAchi20X9C5ndz0nRcgZZ3tZYj0bv+5iMcNXHDShXGO8Hy8FITG7QE=
X-Google-Smtp-Source: AGHT+IH0IO0ZDxnFtMUfY+LtN0dHpfgCcJUDCCLqsTWepxFYAviXucxehsppKve/QpbKAZKfAJt/zg==
X-Received: by 2002:a05:600c:314c:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-4533c95bc97mr156211805e9.13.1750186572097;
        Tue, 17 Jun 2025 11:56:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2324c6sm181074335e9.12.2025.06.17.11.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 11:56:11 -0700 (PDT)
Message-Id: <pull.2000.git.git.1750186571037.gitgitgadget@gmail.com>
From: "James Duley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Jun 2025 18:56:10 +0000
Subject: [PATCH] Ensure restore_term works correctly with DUPLEX
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
Cc: James Duley <jagduley@gmail.com>,
    James Duley <jagduley@gmail.com>

From: James Duley <jagduley@gmail.com>

Previously, if save_term/restore_term was called with the DUPLEX flag
and then without the flag, an assertion was hit.
> Assertion failed: hconout != INVALID_HANDLE_VALUE,
> file compat/terminal.c, line 283

This is because save_term doesn't set cmode_out when not DUPLEX,
so an old version of cmode_out was being used.
Therefore, hconout is the correct thing for restore to check
to decide whether to restore stdout console mode.

I saw this on Windows with interactive.singleKey when doing `git add -p`.
Specifically, after hitting `e` to edit in vim, once on to the prompt
for the next hunk, pressing any key results in the assertion.

Signed-off-by: James Duley <jagduley@gmail.com>
---
    Ensure restore_term works correctly with DUPLEX

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2000%2Fparched%2Frestore-term-windows-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2000/parched/restore-term-windows-fix-v1
Pull-Request: https://github.com/git/git/pull/2000

 compat/terminal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 584f27bf7e1..72b184555ff 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -279,8 +279,7 @@ void restore_term(void)
 
 	SetConsoleMode(hconin, cmode_in);
 	CloseHandle(hconin);
-	if (cmode_out) {
-		assert(hconout != INVALID_HANDLE_VALUE);
+	if (hconout != INVALID_HANDLE_VALUE) {
 		SetConsoleMode(hconout, cmode_out);
 		CloseHandle(hconout);
 	}

base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
-- 
gitgitgadget
