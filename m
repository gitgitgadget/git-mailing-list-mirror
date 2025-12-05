Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18B302166
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946958; cv=none; b=BglOdUrE/IFe9B4+5Ht+fjHFmjZI3M3T4y/HOsopALIbe9g+sobV538j9DWUIt0qNfKegRx/x8N1yObHLgO1rGRsm4n4c5d0GtwDn219tWOesXnjhG9AjYg0mzSByM4OdkDJQx3K1UHaRe6z2/YhTdeuOS/R9h+ZDlNGqMl7l3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946958; c=relaxed/simple;
	bh=ZbvltTBk2RxO6u673XwmN6IKn95QiVwaX+EYx22ScSM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bu5fbISRCLxclvZd934VKWoRe7FZdg28ZD94lAMffpMw66ERKJYNcHnYRMp+i4Zl6xi3D2VUtyqFNhdc7JTXBG6X4AMb+MZ1++XMW85hTIgxiVS1gJxFUO+TScuh8w7grFVy0WL1uSVE4DGvBceHWY89Jcu2p1fgec+juw+9qPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ17LcSg; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ17LcSg"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b22b1d3e7fso205222285a.3
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946949; x=1765551749; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpPCJ8F0XSC6L7Xc9j8KJxmdrZQSXhsGQKMK39ulf3M=;
        b=BQ17LcSgNk/C/YF0ZlNyX1pvLS/B/Cq1OZ/4D+G6yKSxrjOxuz/SyQdG7Z8/ocYaOO
         Z/FthlQ05Fz7iXyM+09/Ai9RVdlWdmB2aPNEMAfx17LepfEsacYb+VQ7tvKJ57bG4KzK
         7mL2p/vkqq21lkFHmohRUwtAKJ2Q45uaSVcnepoWccbOB3PxtOAcfC3rcR5hV2DkmZ4O
         /fFZHuZUOk/Tai7Zf69VqzGdKRv3u/UkqHB3Nu04D0BbWYdVLdwBfix00rGlAptA1W4T
         FMx1+JkIIQkRs4jLcZD/7U6jt9KisJbUhcvzeael+Mj0SP6b6Ahfb4+jPZJ+pbx9GF3D
         ylNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946949; x=1765551749;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpPCJ8F0XSC6L7Xc9j8KJxmdrZQSXhsGQKMK39ulf3M=;
        b=RewcwPEwVjzx+DrDdzZvgVONPR3/rsdh+Nk5Z1vqogV6l3zx6ytsewePsRqOt7Lk8E
         PLnMjLmL/TNbYjM0ybjgdAzVpi8o5tYUYJS01F37GMnXqAax1UDNOa5fQ6pW4gDwvTm/
         zXwuA7mPRSGnP9zBZjAw3Ir06GM5unZzAMkRruobVpDGCxMoNEawDGEt0i0sUj+++Cy4
         fHdKaQ1mqUbIvnIo23AAqIotfBEoH0oeaPze7GBl+og+pYCZlKaHQSlm4BbYIrYUyMCs
         FLUlQdo8Ydfv5AGHoIG8dIPV9mPaGdvJ/gY0vmU25lPa/oWIvqOsCj+mkoz1NKHFeVYr
         +Arw==
X-Gm-Message-State: AOJu0Yxn18CVI1Y6r1eugR48YT5Aj7bkn+1exQJF8/fdb1TwW+Bw3Cd2
	DOnfsAE6lo6MiuQHvRhloJUyAL9Waf7HKkz6sP5eNJ3g/OqR1mjjv2swwxghvA==
X-Gm-Gg: ASbGncvQLuUoeH9g6IpL9+y39IWjP2vquWMlundUCSiTc9nOAMlvoFLWAD+m+LrwR4i
	QvaX+3ptVPB5yjtz1VEfDqxuo7ZufJrRisfv9CkEU6BenNcfDkrcOPF04uUNzw46b7tCwzPW9MO
	US1FUMHVQuNv4yJcrnZ3/e6lMugsCtkgZ1iNhE4ZJVaBO3gMusQJiqxOOC/zbuUBPFEE0Ipj7H7
	FBu/QABYA+eSmSHztf6YIG6mt4iJqWCTRZlmxyHgtPhRDel/LIp6HXjhRZpiccyNptqyrt4C7zu
	mQEg83zlAH9SDY6jd8YxHMP9+JUBqGqIEyVu8fSSg5ZbTyH7W6mKW1gfldP838ecN5PTNrW39uP
	9saCASitvGYVeB4k+bbvoW7JkmIUKlLu3Tk6S9U0teuowi0nLOlBCqCpmGo/46LmrwPZSgw4DbP
	+J96sRHFWOGmHx
X-Google-Smtp-Source: AGHT+IF+kIpdasGt/+lFrOF7mk+reA7IxLHaA9eyu32/4YWVSIDChVn5RonVSW+CTzco0tDGzEFrcQ==
X-Received: by 2002:a05:620a:4088:b0:892:eeb9:4def with SMTP id af79cd13be357-8b5e6c851bdmr1426879985a.49.1764946949202;
        Fri, 05 Dec 2025 07:02:29 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b627ab3d15sm392592585a.55.2025.12.05.07.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:28 -0800 (PST)
Message-Id: <b97afa9a5c28aa89fd94f210a0dec5de891eb221.1764946945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:17 +0000
Subject: [PATCH v2 02/10] apply: symbolic links lack a "trustable executable
 bit"
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When 0482c32c334b (apply: ignore working tree filemode when
!core.filemode, 2023-12-26) fixed `git apply` to stop warning about
executable files, it inadvertently changed the code flow also for
symbolic links and directories.

Let's narrow the scope of the special `!trust_executable_git` code path
to apply only to regular files.

This is needed to let t4115.5(symlink escape when creating new files)
pass on Windows when symbolic link support is enabled in the MSYS2
runtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index a2ceb3fb40..de5750354a 100644
--- a/apply.c
+++ b/apply.c
@@ -3779,7 +3779,7 @@ static int check_preimage(struct apply_state *state,
 		if (*ce && !(*ce)->ce_mode)
 			BUG("ce_mode == 0 for path '%s'", old_name);
 
-		if (trust_executable_bit)
+		if (trust_executable_bit || !S_ISREG(st->st_mode))
 			st_mode = ce_mode_from_stat(*ce, st->st_mode);
 		else if (*ce)
 			st_mode = (*ce)->ce_mode;
-- 
gitgitgadget

