Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F13A1E63
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766027647; cv=none; b=F+jppuIFTAZSNZLyEesS6eVzhJ1gluQh4HhGfnzjsC489Lg21mpnqUAFYEoqyv39BtfdxiOlBRz1s/V5Hz9xStAuPb8278gXiBgv0DHGDf5z9fSNVMXitn8gxrTJjdcv7LV6lEav2aL3G68GqmJzKr2gvviQG+hQG0qD9/KHjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766027647; c=relaxed/simple;
	bh=jx6qEdflQo2yFP3ubtrzyq/BatQzhlNuWyGn16M1/30=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=mZi39gcSfgrJ/E4OOq+/PujLD1tq4nZ/2ZdQGJiLge/NN7HPtJ6v76ndXcgcHCpvjEy0yJTjNlgZT8Du59zqMyib3UGLyXuVx3xcg+qQSU6bu5K6QpiZfhlAAiBJdUycCJeO2vO41YlouZeShZ70jgDl4Zhnhd8UsDiTI78tazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8tQc0cI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8tQc0cI"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8bb6a27d3edso19168985a.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 19:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766027645; x=1766632445; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Gf5ydPHNztZEI3QcypadQOsfOm7/9Cg44wcs0R7jSU=;
        b=j8tQc0cIolCNU0z3RCb0a9P4MhMxg6za8wry/8Rqnk4QQmb8kwagNhEHcIY2ThIn8A
         cNROQZzYbEl9TWwuL5H1RXhbrjlYVgJA2f566icstM3xMITGg7dBuQENzvboFqoJTk4z
         PhYsvkpho7kvNeKBUtubR54oHXLzlQBKNrGu01KyTXDqrq6sbd1VpHOG6T6Cse2E3k61
         365IRGGPZA+WtHq51/otkzPnvCSbnUci4MAiGaFvs3whRbvLraknYd/8aeJivCngHf60
         WJXiZptZ9N0s7aPXLsPchhr916cP5Q9ff8Jc1RbxtAM4XAydv48PfikFYl+GFdB771/w
         WcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766027645; x=1766632445;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Gf5ydPHNztZEI3QcypadQOsfOm7/9Cg44wcs0R7jSU=;
        b=rJjGPFtr5gyHE3KPf79tBMYux5ElAwOuFoBbXtgmGtLhemm8UCixp6eWvnTOIGzps1
         h+GxGVEZlLaQy1EqwKRTcQtVIko+zUmy/K3El5dkNLzLel1anupyRGmFihvXImo+fUTw
         H3B+dCu+rvxxxgH4wYkLG7+frCOOWnpXxDCdMAPjP2mDhuSpjbArHOBNX/lXElIFni7k
         3CJpEWYaF26iJgzVk+FC+pqYaRC2jhVJxn3s0FNRPQNPJQj3Pdik2AvXSVA3vcGoosUs
         vB5AIBUwWAR/3yj44jhK2whiF82MUa0jpfnn1OqAp+fIGSdBy68qFQeGbaSgs7AqZ34S
         sfJg==
X-Gm-Message-State: AOJu0YyuSJZXXeHgWWYh3jdkRNY0w+vs3HhgzKvWY1gMNMSRwH3LTT3L
	oZirzO1VM/Rrxy0fEXwagF5fA6ygtAYb91BhbHog8Vnnej1089Pk0dNZz1KQ9R/lC08=
X-Gm-Gg: AY/fxX5ySMso4IPkCn/aepA8ZzVsJx1FCIwFw1UHE/0IK0ygiloW8f5ZBfkwjIa8XaE
	i3vwZVEpN5pOmSiAB5VXjz29QFHYyTb7VRVASttM7BG/ynrGU3Oztd76L/Z8gsdR7tHZV0of77K
	7zCxqSVoEuhqX3mJvKOa9dvj7gqqziLQPXZ2Auc74n8svNvJXSH/IcpOvDFvVrOKgIPmrLk09zb
	FvZOR/jUkU9bWpV2l97IjwUfVjxNs6KNdefF5FmUBM8V281syJGhqZ9R1YA/yGAoSPe8nYUmhzF
	Wflmj8rD8rrO7L5Ikmn4t4xA1MZ4eM6NxT6EkT61GLqFzXaE3WMzavYEWyhSe37ELMR03vbIKAH
	Hcyp8oFbSoTyzMhZLZFeCxfSwxGbbFrPtje5MXrTKgkoiBK20kZ8OYfR4w+wL7VVU5peyL/4rpY
	tq9+JwK3H+R+EyCnk=
X-Google-Smtp-Source: AGHT+IFr/ZQgttf+TZsaSzbio8Odz0MYYA76SLzfdViLwadf2/GbiepzIUa1pJJC47v7kztRmz2wXg==
X-Received: by 2002:a05:620a:2a09:b0:8b2:ed71:deda with SMTP id af79cd13be357-8bb3a39dfe7mr2652222985a.84.1766027644599;
        Wed, 17 Dec 2025 19:14:04 -0800 (PST)
Received: from [127.0.0.1] ([172.174.166.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeb5c3d2fsm83572685a.10.2025.12.17.19.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 19:14:04 -0800 (PST)
Message-Id: <pull.2131.git.git.1766027643744.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 03:14:03 +0000
Subject: [PATCH] open: check fd_flags value before calling fcntl
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
Cc: AZero13 <gfunni234@gmail.com>,
    AZero13 <gfunni234@gmail.com>

From: AZero13 <gfunni234@gmail.com>

Otherwise, fcntl can be called with invalid fd_flags.

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    open: check fd_flags value before calling fcntl
    
    Otherwise, fcntl can be called with invalid fd_flags.
    
    Signed-off-by:Greg Funni gfunni234@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2131%2FAZero13%2Ffixopen-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2131/AZero13/fixopen-v1
Pull-Request: https://github.com/git/git/pull/2131

 compat/open.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/open.c b/compat/open.c
index 37ae2b1aeb..b313bcd364 100644
--- a/compat/open.c
+++ b/compat/open.c
@@ -44,8 +44,8 @@ int git_open_cloexec(const char *name, int flags)
 
 		if (!o_cloexec && 0 <= fd && fd_cloexec) {
 			/* Opened w/o O_CLOEXEC?  try with fcntl(2) to add it */
-			int flags = fcntl(fd, F_GETFD);
-			if (fcntl(fd, F_SETFD, flags | fd_cloexec))
+			int fd_flags = fcntl(fd, F_GETFD);
+			if (fd_flags < 0 || fcntl(fd, F_SETFD, fd_flags | fd_cloexec))
 				fd_cloexec = 0;
 		}
 	}

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
