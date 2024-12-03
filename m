Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC92F143759
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257088; cv=none; b=cQkPxYZfQv/XdTobj6Cp370rn/euUc4GVRhz399LxLmFCqYPJp4JcAC5QV8zSbnO4zIyDYJPQ/cEp6jh7WomKb5t9kZLaKWq5S7AE2RvHVu3GN0Hozb+ydQJwYoUBsVO9vj8L9O+QL3fFveSZxDzcu7DZdYtFMsNQJggc3pOoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257088; c=relaxed/simple;
	bh=0Yq5Sz8XkKdN9evfgwmuzwto7It6Alvu8y1EuM80cTs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=flca8nhhoevcsn4UtzARXY/waaPxFlr1R+pFvcEyn2LXnXn0bLJy+Q98faRAiwWcaWr8pqVXKVFEXLbs55y93/nVXUrr0Gr9Z86K+tDvFNDJRb3c5ApOGhLFVmqzomqNZNIN1OdCS0e8eLPng4xOuBec66Rl0PfLiKAaXVGQSh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGsxKK6L; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGsxKK6L"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so1125355e9.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733257085; x=1733861885; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=epXe3e4ISa7v2BkQ+7LdP3qRUx7jYPPRrASnbNhoJHQ=;
        b=WGsxKK6L5nLtsGDLAO/jBU2nZXhYQdsFPDBBVHdqarzRx0e4jcWTO3HOnLHe16Z06c
         ZlP0NGnNW6sdAVwXYYaWqOWzVpP31IDWsyzxYaiyWfDwyCyUCfdU1zgRbToN0I2LO102
         bW5c/xvcPbTvZEAPQ734vcWg6H97IAuFjiFJFlYnWrqPv6+bGGX0sqyvvZtYrd0n17sq
         nqjUfWuEOhJYHHzknxSNBBAUkqSfxEiRrcuCqU6f+kLmcAQeRxT4NC5bv65Tx6SazHHe
         8r0QWt6NoO6E6TxtAnc0DJ66Hip9AZR62TxEzJMyjhwzglDa7nUQWepm3BKv4eKXLvIK
         gFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733257085; x=1733861885;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epXe3e4ISa7v2BkQ+7LdP3qRUx7jYPPRrASnbNhoJHQ=;
        b=Rh6WE1Uc2OcPE/wm2lXFROWOoUIoLyR52Q+d0AAO3BjG/DlDymjJQ1ybnaARjsujD3
         kXuurj5L5nvUSIjazZAPVnGOlkC2J2Y39C5XFUVqFX8cvou12+ZBr5jTTzgUUY3W/mgz
         JDJhQllmmIcl4P60WmFG/7vXOXokUl73BRRK3Gsbwl5YKXul0m6tlaoGQFFrSQPuGX48
         lkZZKuJB5GaqbPZ69Wh1CNNJR55c9cmEByW97ulgpq4D5KawvM8jm5NIJEdtjeus3rSx
         2ggiIyMfygWY1azx4ezMaawBKK26ifyI0HV65KViN/ho1dOaXB/cRthaRC1I8Kzovp3u
         qZRg==
X-Gm-Message-State: AOJu0YyAbVQTKgb0RR6yRt1Is1fsWUI/3k4KqajgaodgmRgedw0ecCy4
	Mz+9r18iOx4h3Y/wrE4baO8e4NuNGaQByclovNQJrnCkXqReOiuYvmkOVg==
X-Gm-Gg: ASbGnctPQTOi/yyRrh+eb3YsRwCptdU4AoNT0WxB5xP2knBe3FUwSlKrqdOFd2bb+6j
	M8rgA/4gxlikMcC3MRkykMk2x9nfTNnyG1ekmn62OiZojH3lgA90i5+tWEISqzC/AsyKplUzlbQ
	6V56xkUzttfd0C5bQ7f8aA6miyjvbpiPruJ4gh2ADhZTyP9VAOddYGk3ewuDvsGUC3P4UAeyFZF
	2eJf+AM8JpzqVkeKU/2iscsauJ38QVuBcCubkcjfD0EMrvR4y8=
X-Google-Smtp-Source: AGHT+IEOzlc7CLLg6ZpmBJewat3TnZQ6mo8gf7DwrMhm04/0r26TkTU4+f6qDnZIn5i00bd+M1vN4Q==
X-Received: by 2002:a05:600c:3b15:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-434d0d63e7fmr31730555e9.10.1733257084598;
        Tue, 03 Dec 2024 12:18:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d25d1sm233256355e9.31.2024.12.03.12.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:18:04 -0800 (PST)
Message-Id: <pull.1838.git.git.1733257083739.gitgitgadget@gmail.com>
From: "Kai Koponen via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Dec 2024 20:18:03 +0000
Subject: [PATCH] doc: mention rev-list --ancestry-path restrictions
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
Cc: Elijah Newren <newren@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Kai Koponen <kaikoponen@google.com>,
    Kai Koponen <kaikoponen@google.com>

From: Kai Koponen <kaikoponen@google.com>

The rev-list documention doesn't mention that the given
commit must be in the specified commit range, leading
to unexpected results.

Signed-off-by: Kai Koponen <kaikoponen@google.com>
---
    doc: mention rev-list --ancestry-path restrictions

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1838%2Fgkaikoponen%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1838/gkaikoponen/master-v1
Pull-Request: https://github.com/git/git/pull/1838

 Documentation/rev-list-options.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 00ccf687441..459e5a02f52 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -412,7 +412,8 @@ Default mode::
 
 --ancestry-path[=<commit>]::
 	When given a range of commits to display (e.g. 'commit1..commit2'
-	or 'commit2 {caret}commit1'), only display commits in that range
+	or 'commit2 {caret}commit1'), and a commit <commit> in that range,
+	only display commits in that range
 	that are ancestors of <commit>, descendants of <commit>, or
 	<commit> itself.  If no commit is specified, use 'commit1' (the
 	excluded part of the range) as <commit>.  Can be passed multiple

base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
-- 
gitgitgadget
