Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D526D5A6
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671056; cv=none; b=h+WPlPfm7mUZPWA2GhA4iJoJVSg178KT+cMh/F2yHFKKQlK6uOGik+3brcP1UnLQxmV7m2maHS4RCDyGUFuT7McfqJJ08scQa2khZkgaKAjSx3KwTol0UZ/tYk8XL+YdNHY5IdwjHajGApX7JithG1Cp6sngQ7YZto4R4Qofk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671056; c=relaxed/simple;
	bh=vgvbFqmEyBwKn/02J5I8DT0+eg0biDd/GAk4vpIiN2I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bXcttlRh3d0IHblytGAhl4d8crGkKRo8RjWXBoJETPaKv0o05+tFcPyLwr6VXv3j/AWqBemD0n9b9bMx5DZHVZa4+ZXIQfvSbuwKqYu0IJGtLoOWb/OH2ibilcOsiuoGzaz1sv025fHagKjpNIDO8cfUH8cyLG5/locXQQAGz/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ekj3Z584; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekj3Z584"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so10565285e9.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 07:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740671052; x=1741275852; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMdxut9zpX/3B0KMhIX3QI7ZZ50b65oO2Wud3RDYJRc=;
        b=Ekj3Z584IBpPi3Atu+cLkV8YpO4HgkzUz5aOyoj7LGKQM5Cr5meta7Yle5ee73HuKe
         IEv1+Wwr5VMlIMmzo0ssBVdAO+yCzrKmRcoU0cZYp6ijpD1xzgmuXj1E6ns2D2Ig6kFP
         XMDMNJFiJTIGvaojfdvZ3E1Lq1ssKkN+PydpQazJFU8UK46WSmz8MXVugYL2fMtMFbt6
         c8oAclEOIrtIe3HRo8oNJblH3cI8L94izUPbCYzsM6YkQT+TpcQ+IYhE8laegBvdJJux
         nC2SNgajt8NuWnOnFoHN/cVPGKjcYkG/k3Og+HA13IsHbj3r1Du7KrEdvA1gbKt+HlIi
         /Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740671052; x=1741275852;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMdxut9zpX/3B0KMhIX3QI7ZZ50b65oO2Wud3RDYJRc=;
        b=D/mMIXu62YRVw3WhX456nfkbR7qOU2aNB+P0Gz3QgkOLivT3ztmtTlwnHNmclo20sz
         SZZleGr0r34BfkgY4vDDWP3Ur/Vf1XIdfBSH96pQehM5hdzkBtNvr0fvrcj8Q/RuZkGE
         bKhrD8Va3GYIaK1MhdBMv8+uwMArLWV+s3ism90JDnVJF3QBjmCVPe4K6zDTLm9Dl0Ch
         ob5PAJYZsSpZL71J4w8902nLZjIJayn5U91d0Z3Z50WqXwLTdHv0Gcwr8o9GznLS5B33
         R8cI33CIJAVt/78sOmwiR1OX4QnUpUwXFh2KzJhYlZLkvot7i7YA2/uqoc6K22xx1x3W
         UZhg==
X-Gm-Message-State: AOJu0Yxz94Q0Q72IfEOgrJlTUoIQRIlpi7lhVaEdr3K9LwzuwQcRl6K0
	OSG9s0fzk3oOoCZv8GIdI+H+LdUhPzJjn0p8Q3XZkxkXgBQ86xjNLrI+Sw==
X-Gm-Gg: ASbGncv0KKWTa9cjtCnlLlI3Q3Cd4aQ2dmt1x2n9TFd1+yixHQcjR2NYIW/0lfbZIOH
	ruQuOOZ4hqKt8g4T34f3oX5qlfkLgZkKwQFFJF+6ZvbUFEg13DNKGm0GCBQqYTnJIK1hzLGT6EH
	rXw1J6BStk5HIQ6yV9qUqUzlB4rWBne+lFnA4FooiU26VOmzgHsz1lUn2iSDp4ABrOhEbTaPMe/
	sCgXDMtYBvwf2P01B4xWS7cksbNQQ8Xhm8+vxgiU0hnTvp8gctfRGK5v+gBrrqBovtKF5r/zJYR
	J4M6ZKDaiV0H0w2iZBxRo9OhuKk=
X-Google-Smtp-Source: AGHT+IHyof7+d9Bv44aOkkCawgvFPhoTFSVfveZWNOPfG/IEts8n4ySQc/tlhOlC/kOLf1p3VX6Tug==
X-Received: by 2002:a05:6000:1563:b0:390:e9e2:9f49 with SMTP id ffacd0b85a97d-390e9e2a1b0mr1351858f8f.54.1740671051762;
        Thu, 27 Feb 2025 07:44:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f990esm28498725e9.5.2025.02.27.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:44:10 -0800 (PST)
Message-Id: <045c11dc1d51690eed4dc07da26dcace612f786c.1740671049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Feb 2025 15:44:08 +0000
Subject: [PATCH 1/2] ident: stop assuming that `gw_gecos` is writable
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

In 590e081dea7c (ident: add NO_GECOS_IN_PWENT for systems without
pw_gecos in struct passwd, 2011-05-19), code was introduced to iterate
over the `gw_gecos` field; The loop variable is of type `char *`, which
assumes that `gw_gecos` is writable.

However, it is not necessarily writable (and it is a bad idea to have it
writable in the first place), so let's switch the loop variable type to
`const char *`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ident.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index caf41fb2a98..967895d8850 100644
--- a/ident.c
+++ b/ident.c
@@ -59,7 +59,7 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 
 static void copy_gecos(const struct passwd *w, struct strbuf *name)
 {
-	char *src;
+	const char *src;
 
 	/* Traditionally GECOS field had office phone numbers etc, separated
 	 * with commas.  Also & stands for capitalized form of the login name.
-- 
gitgitgadget

