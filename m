Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43B199B8
	for <git@vger.kernel.org>; Sat, 18 May 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716028374; cv=none; b=tiUYoZbgH+vlbmK2UqTMsYI48nst6Wu/MfM8XjTeDMjb4N33r2xFehXuI/QrAsCQZmzUACCxUEpuMaagvo49aAZQpaHlEdl7P9Vg5FO8yfEJY1YuqCMQCAQOEQAX4eLHlAUEZAFNsUbGrDa7fJhHkHqSxGou3MxggRvEVtPc0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716028374; c=relaxed/simple;
	bh=eomBttJUDugeAh4/E/RHJ5Kl046QR71tdtyo18mV/ck=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J7j6N4NQUu5cJeP238f25UapsW6EZVPpl2W5Cgg3I6xKdYFId7VOxPwsLyykJZ/AhWbSI8qGM0bb4HVkwnrG89m914UwhjDaae+4QsAWhtzs+EijWGxbk/iFpTEjvtXiv5i3X51yUlGdoM6VlvY3fDMrv9zVc/69kCVBvwAwMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1adBIfN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1adBIfN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-420180b5922so11621865e9.2
        for <git@vger.kernel.org>; Sat, 18 May 2024 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716028370; x=1716633170; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa4ywTRMbTP0sOgRCz5rqk9gwHUD4hcDu9QhBPTQQ6M=;
        b=h1adBIfNKVEy9pa3GIG7syclZJmhCJHPxFvgN1K9DQ50oQcr4qVcN9UarDBiaYEXMs
         KhJnOs8W6ey7euJPWtW3C4Ix2LXynYoL42Nk8LxpDPV0f73SEnjl9ND1xxrNX1ftKIj1
         oDUBz/ZJjPXiWIYsj5HIg3qoiGh7duLkjxExoq8jPmmOf3Dz+l1kWKE3z+TDQimhxIpv
         1ZoKyC8TQHMbAPmT1UerGcHEgf17MUJtpFTUz4bMpXmLswJXqptXy/ks+YHK/+GsWT2u
         BV87M3Vndp6Y+10+Qb5DFsR9uaDExqUqIXpfCkzQp1IenpcWWFh1ahgaNIB9zhu2LIZy
         VSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716028370; x=1716633170;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa4ywTRMbTP0sOgRCz5rqk9gwHUD4hcDu9QhBPTQQ6M=;
        b=LMkx0bKghk5XhhMJJ2f+A+ikUZF6i/YHbg496nTYciPG0/qwfbEB+8zoS/MoUJg20F
         3EWVJs/IqHLvyjQvnmhfYAgdaSmXtHIBgViGiT0/j4ntlyjGFVOrm/8OZl1jyEADi6b7
         0V2aeKHBE1Dwbj2tiBtAd4QKqGCaZeKTm9f58CyHpCfCiaeTukBgA4Xd1QJ114BgTAJM
         8OMSzcZRo4ktXZQyw4Wnz9zsiDTkoGUNzUgryjCmpzeUo/zLImsk4nL9p8ZmrT7fNNYl
         jjWYt/0HRSht4cuPJy3sgjFPFW5aEVTwh6edGQolHaAQbwzUOFzLz/BXbWX2Mh+fFK4f
         KTcA==
X-Gm-Message-State: AOJu0Yy3iD8nnAX/B0BfPCEt4nkaIXDGE9e79ff2mQdF5myWkJhuwC7O
	86QEqq/rlYemE832duXLVvoj1IwWf5HV0QkhTYqJWATm4n5W9gD1xYSjXA==
X-Google-Smtp-Source: AGHT+IEIw5POsorhn6r3h0edgRUPqSl1l2RJaCCZgj62XjlxiCsiWoE9ZvBMVUKY1PBGl6mylTntqg==
X-Received: by 2002:a05:600c:570a:b0:41c:b44:f917 with SMTP id 5b1f17b1804b1-41feaa443f6mr217454965e9.22.1716028370407;
        Sat, 18 May 2024 03:32:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc3e4sm23859920f8f.108.2024.05.18.03.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 03:32:50 -0700 (PDT)
Message-Id: <d4a003bf2ceafcc6d47d01d21b7faff48c9e85aa.1716028366.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 May 2024 10:32:39 +0000
Subject: [PATCH v2 1/8] hook: plug a new memory leak
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 8db1e8743c0 (clone: prevent hooks from running during a clone,
2024-03-28), I introduced an inadvertent memory leak that was
unfortunately not caught before v2.45.1 was released. Here is a fix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 hook.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 632b537b993..fc974cee1d8 100644
--- a/hook.c
+++ b/hook.c
@@ -18,8 +18,10 @@ static int identical_to_template_hook(const char *name, const char *path)
 		found_template_hook = access(template_path.buf, X_OK) >= 0;
 	}
 #endif
-	if (!found_template_hook)
+	if (!found_template_hook) {
+		strbuf_release(&template_path);
 		return 0;
+	}
 
 	ret = do_files_match(template_path.buf, path);
 
-- 
gitgitgadget

