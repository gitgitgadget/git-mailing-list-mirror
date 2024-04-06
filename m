Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC8BE58
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366544; cv=none; b=IHOPs5AJGUzCbGxTyUx4Iqf/nSBwtebWMIa5gHJmiMg5Acvk4X1BU/w0zZVElXAZtBUEEFuGE1DI2+whv1lFxnX/I46Q24MloBA2/ox5drA7mv+ylVSUl8hNxizdzaB89o5XMdNW5LPw0J8BqHcIDL6gTdD0Af8z1TX7k3tNfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366544; c=relaxed/simple;
	bh=xk57zUsLcULI4piYDwAtccyPpYcWKKlCtENISMpU5Eo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xy0p0lT7BFSC4bWfQDEsTxt3SuRZ3zPTH7CHl3+nKCn3A57bPRJgUrRcrDmtIRKuU0a6Ju1/RkMPQkXC3zFJG4PMmWGMA9qQjko8d+phTDjT0MqGhc62mS0ps0qeWsvkYIqZTu6YVogrR9HBzqo9vE2Po7VdULH3nMoHx1qKttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1Zkbo5m; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1Zkbo5m"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41632010478so6793745e9.1
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366540; x=1712971340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waqH/iRrWNhiEfcSl3rSo7z9FkzRwk5MNMpC/HcssOg=;
        b=B1Zkbo5mRsNKSz4VZHXy6QTrzBmpvA7RRBHYS/60l8Wbi9FKd1Gua3+E0aXV5W4RC7
         IMTq0RZkw+GdhLEtAK4pUvxamcXQuptONVR0MdsAK5LXFmqa2STNu2D6FHFd6xVpawba
         FUUIltEyQRRTbCyIqAp6DGBoLmPmth1V+H+/9Y1j02nsepj+u4BiPWuzz8WBAkJKzAjv
         RePoy2LDN7erbAlvh/lwz7x7rPRLqqmybwW61CAANxO8fXnEfnbnB65pfV8Zw5nkzfL5
         6cxQfVwm3f/8uwKL3rwwVph0EceGTdZ0Wpybd+mCY+kRWJVNV89CVs7Sd3xEQZ+22o9z
         GnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366540; x=1712971340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waqH/iRrWNhiEfcSl3rSo7z9FkzRwk5MNMpC/HcssOg=;
        b=AF9nXSWtVuShpEURsplBIiKf+0tDdyuyzwldd3YqRQfVo5JjlKyynvtXpWEq7j+0Rb
         iWX4lg2kFLZkKAz9Lp9qyaL84QL/oIZ6fwLogAu0p2lCAmxGhTspqXDx3EA0haBHRKdj
         H7n36UYJYv4bGkv3hSU6ByJNFu0ZP+CeBVgLzK9bgTjppIhvobedEKnRAv7/e7KPR6Uh
         gQJpWoDN+FwUb3NpqWvb05cp3uAW1K2m6HrKpzzHjJE56FtfYwr4ZLmbYNAH9pwtyyEE
         VgAjGsWtqYFNBF7Wu/Xvf0X5+amjfsgYxZZ7srVYwTOuUGxxEF/7acAbAT8fkS3Ax82r
         lrOw==
X-Gm-Message-State: AOJu0YxHHzJKquIyZDV7uG84+WxRPBQSI/oaZdaJI1ogu2eQXyzXB6EC
	ykRgC5b15Osb2mFHwiKEYpPlfHfTzqBGgUr3M7yWooEXj0ytNdjEC3nHUro8
X-Google-Smtp-Source: AGHT+IGrzhqa+aB68fG7YYj5s/NMDu4tBdYFOkSGl+H2ACcoZRPh57QOpxepLNpMksT9qS/zaLwjuA==
X-Received: by 2002:a05:600c:3585:b0:413:21f5:de48 with SMTP id p5-20020a05600c358500b0041321f5de48mr2708199wmq.18.1712366540405;
        Fri, 05 Apr 2024 18:22:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n34-20020a05600c3ba200b0041625fc652asm8205223wms.26.2024.04.05.18.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:22:18 -0700 (PDT)
Message-Id: <82e5e05288ded6394e562408507e3269c26e688a.1712366536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Apr 2024 01:22:10 +0000
Subject: [PATCH v2 2/8] SubmittingPatches: make 'git contacts' grep-friendly
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Avoid splitting up the command over two lines. This way, a command like

    $ git grep git.contacts Documentation

will return a positive hit for this location.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e734a3f0f17..a33fe7e11f6 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -494,8 +494,8 @@ mentioned below, but should instead be sent privately to the Git
 Security mailing list{security-ml-ref}.
 
 Send your patch with "To:" set to the mailing list, with "cc:" listing
-people who are involved in the area you are touching (the `git
-contacts` command in `contrib/contacts/` can help to
+people who are involved in the area you are touching (the `git contacts`
+command in `contrib/contacts/` can help to
 identify them), to solicit comments and reviews.  Also, when you made
 trial merges of your topic to `next` and `seen`, you may have noticed
 work by others conflicting with your changes.  There is a good possibility
-- 
gitgitgadget

