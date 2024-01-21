Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04536125
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705810079; cv=none; b=J9h8W8XY2GlDXJ8TnMumVpvDUf5Q9in2EAhNS3xLCbB7MuMgwes5RzFuFqQGpYCwJH04Ig8ZOLnas5D7I7jnjGR0SPpeURBtRlISzC7VI1ZX963KpOUD0M3BZ05deGv6aQwdwu8CivhNlMh5IDb+TKSJmWU1CUuj4OZKtjxeXWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705810079; c=relaxed/simple;
	bh=DrIUtxU9tcETeHtghzztEv6tMoPjN/90+9YSlozm9sw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Fy4+FnVw7De0XovD+lqlm05CcmcUmen5HdgMCT4EA/RgR8hjFCf5s3ogo9tgy7QZoIQ+eiBGsonTN8c3qrdBMdGqe/YT2Z48pFzAd3jFmcl+ggfwv5tuX3CVxhJPqDK8CzB0w+gpjk+wG7YnAcBOUJam7T7Z/VZGIpp3E+v2kJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3Cd8dAv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3Cd8dAv"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso25198785e9.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705810075; x=1706414875; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5zQp+7QfdMkDFTuX6mjaT0RtNsGNWcE3O531N6blVE=;
        b=V3Cd8dAvQ8ARpBMURTnJC4KdAEVbUUyP3CK5Bmf8jcun0Y9j0JdQRcd+fLsICEeGnu
         Yzbe0FVBWmSz9e9AS8zjN6FhdbyDZVjDYVhmV/5TBbjNnqkI6U2L0m6TQg3N0tGfX4Tg
         SH2npazhDybhInpmV+pLy5KEH+XrtY3/c9Dik2faXksDjut9f238eNLD97vnpya4ul8S
         RESXEvh6akFy07ZGI/vBL4ztMKaIjPUTPGxHLFTLJrd/DDhaBtdcV5Xgtxf1RJ105m9T
         tkiJIuGTyq+AM42USaA3jagEheK5yO4C+o7rQP/ktXtSkVWhgK2xQq1z8vBECGeSAwKk
         nfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705810075; x=1706414875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5zQp+7QfdMkDFTuX6mjaT0RtNsGNWcE3O531N6blVE=;
        b=uAyo8WRmGeZXYU6qPvyDk9jm8+5xvgStGh2ORXLBKsGrbhEmqhYwwBx7TVv5R7UD92
         4adO5eA3/D2aghoM7d37xnz9w1VE6kBOwzpgtIAMwS3zW0IjlOcKHlqhTMGemwIDkLrn
         ekp8JWrGxEQKi3sMB/STY0gnQdjHLHNqG/sEqdp//XKsf2P8rm36v7eAH+g3OzCHbgOH
         W/N8QI5ktTn/vVRRctJLYJ8yu0v5SIR3mdIopzWzXkOFPrYMPj8Cu2yezTxIX4GsmnAf
         ITZuvZ8BFD22kZY2OtVAhkwIx4pa/aVi55FtcNii+XCZW9UUkSocbnb2Orz7QjTAK/co
         0+0g==
X-Gm-Message-State: AOJu0YyU+i505KrLUpH+zuRW8heIgeA+R0VY2xC7Im9YnHSeWi+DsHk/
	0P9nVjIt/KahVWXlTdLRSSE7AGGRZC9dVqaOnDdTsA0pUPZS8tpihPcrCu3t
X-Google-Smtp-Source: AGHT+IHa0xMeY7Miv6bfRdXhpoHS++mXx9Hnzwm2nQq+Aq5q6ySSOGMXHuRpEGM3ROS13YAiAhbqFg==
X-Received: by 2002:a05:600c:6541:b0:40e:623e:4648 with SMTP id dn1-20020a05600c654100b0040e623e4648mr576823wmb.326.1705810074996;
        Sat, 20 Jan 2024 20:07:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b0040e50d82af5sm34477891wms.32.2024.01.20.20.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 20:07:54 -0800 (PST)
Message-ID: <faa601ecb92b301d5730474efd11fba27d6a5cc7.1705810072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>
References: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jan 2024 04:07:50 +0000
Subject: [PATCH 3/4] completion: complete --encoding
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

The option --encoding is supported by 'git log' and 'git show', so add
it to __git_log_show_options.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ccb17f4ad7b..a7ae2cbe55b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2096,6 +2096,7 @@ __git_log_shortlog_options="
 # Options accepted by log and show
 __git_log_show_options="
 	--diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
+	--encoding=
 "
 
 __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
-- 
gitgitgadget

