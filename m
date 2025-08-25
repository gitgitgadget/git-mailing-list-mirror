Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA0280337
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148940; cv=none; b=Uatj/acfMKAj8k/MguAb3+GOI1y6CWMS2q6r5DNnJ4g/1FA9IbGi07UoSaz+SjuygeY37MXdWJPAqbqMniruE+cV2rAYCL0GV2ThMHwPjXli99rgiY8N0MmSF4JcrxC4snJOw4cNig2YKNhCaEMMpx9J2tuLrVyEb/q45DRUp0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148940; c=relaxed/simple;
	bh=71WdxjY+eIg1OIhKm5uALfuYab40p3IlyHkVVGvXCOM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HhmdKKRky/by6svkQvHpgTM2GL/q+RBcm+iPvzJLyhhKnQMxy2fhfipFShq0eHRsVLS9fiGt9Nq5XL0mmn1dOfNU5djDqjqs37owzGlSWQerp8BjuxKOX9ue8BBOZMi+ISPBP6fdlEadLb186Ro9elfAWHAjKU380nZV2od1T0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUNqtusd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUNqtusd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so29597575e9.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756148937; x=1756753737; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGSjQEgQ9TMEc2U2cHDK5803cWi8OIxdYgOTfNYG/0A=;
        b=PUNqtusdYBAEUfQsRzY0QEK2Qd98xFjdHnTQWgvd/qksNUPW/616Xo70ffHzzwYbI8
         w/WAF3n3BC2LmFPi7Q4JvoMc/NOeBSxZ6g4PN0RVdXWFjq/nT3DN6BtKCXjMsd46IuLG
         sUjlHcrQG5iyoXqfbwiIb7R3No7mdDDxwmyAQnR24498CK+R7bPhplatLsKtQMm91pmx
         o9PGvhMgXCArPufOzskze3e/Ml6HBpGVzxi5nu2L2e0rOM8ET1N6fR9sSHT2a9D43NnT
         LLOAD/PabTuSGgC/QOrJkF2bUWz1PxLbvcYJPcKDgaLSRWcn+sOmqWkJNHz/mJkqK9VA
         icIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148937; x=1756753737;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGSjQEgQ9TMEc2U2cHDK5803cWi8OIxdYgOTfNYG/0A=;
        b=ScY7zPyf/QsiJ/ew6Idj5ts+EE43pFXVlKGu4oUlD/9PSthUiE90FYqOgSMpbjDMHx
         MxY37Fddjp81sy08bO+ovwGMtyG6LlomCmgZAd+z7Uje1TfFKHIvsXKz8l+o4jlEdL6G
         Hg6vd5gHC+tDWfm82xJA2wBtXrFE9p4iI0RE0eQzCyvooUV4mkBgDZ6u4DARhV3Bk8mM
         P+GxANiV6ZZwy6izE8XvIA11fRiEWEblvesngi8bd871ptusrM7n7hzYxwXoFeFaErnw
         pthEG9KCAjMWCilqVpxdPIakeQEG1ivtYxpmN8/ekSoW3c1+B+5q1Uez3+Od5iEVnxym
         gR6Q==
X-Gm-Message-State: AOJu0YxaRoTItqQV+V5YvBHFZQ6jeUur8L2efrwuj2GAOe2SZM0w6W5Z
	KSYF1f3qBBgMZQN5Aqw74rvI91qoiMFgRrdnLnU3I52h+Q9B+64eGh2nldlxMg==
X-Gm-Gg: ASbGncvbhxQziy23XFdEZCWuEun6+z2MngvOYFtyyIaA6wN5zEfaraCROw0qDxQOywf
	FhwI2h/NKrxTXNOAJ/Eacab6DF34L9ZIx4WXD9JV2y0/XH4HC81ClIgx61S6ji0b1vRn79H6Xs1
	sqTO8CEEDrz0teztslk/YljIS04VTT67mO8dXVpdi36WsjIYmdHwdayYXBQwyJrtCfm3b//+rzw
	AIrmWkJOj9Ad3gG9N1Q8bvoQycc2NTd+mlFHl/Z/2dk+UaRU/HLDfi2Gg/EkUyozGOBuxHLTeUT
	vbq3zl5oyuUnH7BV+iY2uFQsqd8NsZR9Tgoc9TWTraY/GBbe+DtqXJwntOxgV5qcobMJ4KHbZYK
	DW9XBcnXpYB5PHH91ppi3PkfSCy0=
X-Google-Smtp-Source: AGHT+IFpgKbcWbpcwydtK0byWjyAIH0IuYmtenpmeojwqPYuwBh8sDD4rfuh8RJt+uRiJcxnVgyz/A==
X-Received: by 2002:a05:6000:2c0d:b0:3c8:ed45:497 with SMTP id ffacd0b85a97d-3c8ed450713mr4096859f8f.47.1756148937023;
        Mon, 25 Aug 2025 12:08:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5747sm12543104f8f.48.2025.08.25.12.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:08:56 -0700 (PDT)
Message-Id: <0a3915264bdc613097580be0e041896116df5452.1756148933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Aug 2025 19:08:51 +0000
Subject: [PATCH 3/5] doc: git-checkout: don't use "reset"
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Many Git users don't know what the term "reset" means. Resolve this by:

- Expanding it into its definition, in one case
- Giving a simpler but still accurate explanation ("the branch will not
  be created or modified"), in the other case

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index a3edb95973a2..dc9607d9ea39 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -58,18 +58,17 @@ slower than getting the same information from `git status`.
 	`--track` without `-b` implies branch creation; see the
 	description of `--track` below.
 +
-If `-B` is given, _<new-branch>_ is created if it doesn't exist; otherwise, it
-is reset. This is the transactional equivalent of
+If `-B` is given, _<new-branch>_ is created if it doesn't exist;
+otherwise `<new-branch>` is forced to point at the commit. This is the
+transactional equivalent of
 +
 ------------
 $ git branch -f <branch> [<start-point>]
 $ git checkout <branch>
 ------------
 +
-that is to say, the branch is not reset/created unless "git checkout" is
-successful (e.g., when the branch is in use in another worktree, not
-just the current branch stays the same, but the branch is not reset to
-the start-point, either).
+that is, the branch will not be created or modified unless
+`git checkout` is successful.
 
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
-- 
gitgitgadget

