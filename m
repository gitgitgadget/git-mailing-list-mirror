Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D845414A86
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705810077; cv=none; b=DagIevmNelcRSNtgdZ0q00lMKRz+3fkiSPVmm9i7dzgBSImAv/L9SuCAiHFjGBzxEwGggtN8ZyRMKcYSkvFgE2cndy7e4Kyxd3L4GPnP+t9Vocc8tVC1Yaohjx5wJ1UUambuN8CWoy1nzqnck67BYQr+E5HUD3RyNk2DilLHTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705810077; c=relaxed/simple;
	bh=HedS2MPLlbIaZ0JqaKmRiqkfMkNRKeDxsml/Mvis+Ys=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bR2vul7tS9LbUrox2+ZmN5pNZmFIQdshpmfo92361W+paWGD2+sxGwbsKOVKHlGB75aK5K/7YUr5n1pWHqkdbeK6gAu6IOEdoFwWs8QKdjVuh7z89RnKAxzarRrHVsfAtKs1MM57X1UY+NioFO0D3girLCuTeXiiuAXx7zwFPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWIuCnCW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWIuCnCW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso27261075e9.2
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705810074; x=1706414874; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FML9+77WhKtZvMS3zA/wwIpR2Ng90oHbCVZNTrJ7Sv0=;
        b=XWIuCnCWk5v5InHwZF9gALdvtyhxeQpLYpKh52SAz8kdp66CAkHr57TOQWss7ZmlTy
         jcgYeQjnVNt7eR4OrM04geToyKsOg1qzEXZsHXqcExOOeEERfejU6z9WVd37Lpdm640a
         R3u0O5JnXxHJZobICJefUDeVdtjadRGo0gFWPsKf4mbu/Sjr0Hw6uT7Sfp4XQXu2ftwf
         v/fNavHiuBCUqek0EXuiBJaW/ZSzVLp2FnpkpQ2p1GGmCyC3XaFMkJtx9MgWmTJ47YsW
         B2/L2kAq41eNKXmxm0NkYa5NAIeBmOKFVukeisPC/hOsKVmUbzS6vJ9hdVYViNXDbW5e
         R1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705810074; x=1706414874;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FML9+77WhKtZvMS3zA/wwIpR2Ng90oHbCVZNTrJ7Sv0=;
        b=Q+MkDCUWiE+BSbXOg8EWDYCOivtPwRPKfI3y+dj0HjG1eaiyLcMmWkLBg3pSO2aZBb
         rbklE/Fvt4xwY0/EAtbHlikLV9eKcTtpI3BEp3yyEyVD3YFeI9caXjDJqcq+nmjfp7YM
         C8gfwkKqCxCvsesN8ZJOaFx+hrFZumnVwvO/uXzr3cvJFJk9lju5ZHWKE83DffA1U8P0
         jSXTJhW2Enmzz+aWU6ySMZ7gl8x4P7IEk/0s41DDD/omDI6bwUqXCGer+BAAIRVPYcln
         cw87eO0OZf83hGf08KOOHrQTZNvuSXCjm+S6xp5bJ/iQpFBBDLm1HE1E19lmQzRzmA+z
         Ifpg==
X-Gm-Message-State: AOJu0YwXImRysmXEttyFgj/leeGPyO+SIZwVm6vAKBBgCNTSq31Fn15u
	x141Gf/Lt56BYixOyqt5uDN/9pv5JKmTzAv0oufKK12cJRB+FLsL/9dQOZXj
X-Google-Smtp-Source: AGHT+IFRLWpWz9ABJnL4ZhVOaxzMRS1i2Ql+eF6w8B3I+v/Yvc7VPqqzDhBXt0Ag0/V33V37/wWNOQ==
X-Received: by 2002:a05:600c:3585:b0:40e:a3b3:db6e with SMTP id p5-20020a05600c358500b0040ea3b3db6emr1008323wmq.47.1705810073593;
        Sat, 20 Jan 2024 20:07:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b0040e89ade92fsm13756218wmq.14.2024.01.20.20.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 20:07:53 -0800 (PST)
Message-ID: <2f72ef0d5f83678de86f4773a547d10e57053300.1705810072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>
References: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jan 2024 04:07:48 +0000
Subject: [PATCH 1/4] completion: complete missing rev-list options
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Some options listed in rev-list-options.txt, and thus accepted by 'git
log' and friends, are missing from the Bash completion script.

Add them to __git_log_common_options.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8c40ade4941..6108d523a11 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2071,6 +2071,16 @@ __git_log_common_options="
 	--min-age= --until= --before=
 	--min-parents= --max-parents=
 	--no-min-parents --no-max-parents
+	--alternate-refs --ancestry-path
+	--author-date-order --basic-regexp
+	--bisect --boundary --exclude-first-parent-only
+	--exclude-hidden --extended-regexp
+	--fixed-strings --grep-reflog
+	--ignore-missing --left-only --perl-regexp
+	--reflog --regexp-ignore-case --remove-empty
+	--right-only --show-linear-break
+	--show-notes-by-default --show-pulls
+	--since-as-filter --single-worktree
 "
 # Options that go well for log and gitk (not shortlog)
 __git_log_gitk_options="
-- 
gitgitgadget

