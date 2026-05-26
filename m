Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CBC400E15
	for <git@vger.kernel.org>; Tue, 26 May 2026 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814058; cv=none; b=UyyXpafzaQnzEFcKNsCL8uQ4ecHprF7vY3nj7OpW/rGhHabAkJ262tDHY9d3yD3TiUYeD6w7HGYbvi9NNRHTFnvHa89YjCpjD2MAR3AaxTZuixdlx2fzmgDwhKrRo/8Za0sixHysWrrQfreleoIWSFZoO2EQavgR2w9n8KNrvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814058; c=relaxed/simple;
	bh=/zjBgBHdAARG7uqMpAY0So4yfznH9j0s4n3AcEGkNoY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=adT7vn7NO8QMUUSi71Mbe8SGpMOSGjY8g8n9Fso5kFwDYVwkBoOONk46sqCVgx+Xznf67UHUh/yv9q3M+UkCGQtozU/8mBscPb13YLwszzqRp6FSwmAOXZiAiuNj8EonshTL4Ua5vGCvAVWpKzP3Qz8f1bcXZsRtz3GngOP6+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsgYZvfH; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsgYZvfH"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b6dd874471so160528216d6.0
        for <git@vger.kernel.org>; Tue, 26 May 2026 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779814056; x=1780418856; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCqirxs1wxfcwwNqmlu7KuKF+9ohCCmzW3dhfSfA5Z8=;
        b=OsgYZvfHxUQHVx8Y6VvwyEfbTv4frM7gMrPYdi3+l+aio3KgmZBcarYeomY1fJ8HHr
         UyuGWfwW8G+CmNINGeE1VfqiepMg7RVlo4af5vblWkc1rwQxqRAeQbPkyJfJt1ouDzn0
         6rCP0k1RMLQHCMrta2i5dDIX1pTu6/finDk9bAQH3Zf7GwtXkVH7ymdqOgl88FiDRJ68
         lBVD8ZhBKzx9pwnSxP/kpdboyncfFWH7vqNmeFjHhhVgxIN/oucI372MW/0CSsVFoex7
         Qt+skqUnU5KLNGV5zM4p8XAAzi/+uAdo1I3cDSP3X0Iv7zF7ispnBIRPOyh7S3AL0UaV
         GCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814056; x=1780418856;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cCqirxs1wxfcwwNqmlu7KuKF+9ohCCmzW3dhfSfA5Z8=;
        b=TtnX6b7jswRhQTUsuC3bIOpxGqFdrbppoV1bO2pXIu+detMrWhRUv9hCJ9VHqBvUda
         rsmQSEoNEoXqCBV/zGhknhTuD40cgsGv5rdh3Iiz5/IXHcsI7xJHp7Fe8rhN7Crda3Rh
         6TNksOJmj0Z0RQ7G041dazSchjEnKwcPebJDM8yR80pG2TyEYYANe7fd+it2JlaBlHDX
         XEBBV3a0cMifaxW6k0wH9+LpRqyFkceWhmvPtWEAEUkxMWMPaFd9HZUqETHBkoXfduxa
         rSzcOQGZf5Nen+9SRIFbAyzanfPWb9U+dP+Gu2dqZqYppHmMXpVRChIA4Qn1tRrhufbX
         oa4w==
X-Gm-Message-State: AOJu0Yza9wM6L4CEj63PsOG++ig2v+qkjsdeoSX+7hAla8W5SDFgAkWp
	s0+dtsaj632f+Hn4WhEY6LomtN9jA1EsUEhayxOobwz6w2GPt0pGwLDpk1Hiag==
X-Gm-Gg: Acq92OECaFwbuEPko6ivkvKb1HmRIari9B8lynacLJYUhGcyEWMV//Xg0ej5i6xhil7
	pz/61Nun7jpBs9e81np3zEPOGBtVpTj5U6z4RO8cAclGhV7hI2mTCC6KH2bRwGUzxc2gTylQ7fO
	pauuXcHRvi5KjsBHR0x9gU5rUpQT+RkwqowvQxISKlXJpUcp/TtoKyz1+vkOT5m2zcrLhyHXVbe
	KsnwWr9r8PDxeMltvRYvJ/6KsFYcupul9qZOcaRuHG74BaeusbEiS7crBKLu0kgCqsCsWhIMN/3
	6Lb5c3qHgl1gJpwvst8pS6YiIJSjL9qhYHGhY332p6SUcNm+69itGQld/awC2jxQQx8AuCU3o8c
	ECVaLn2dj5i1+/uT2qmF9jWDVhNrpEXWiR3gMXUCdOn8/cfDLHAdw/jP51lP/M5TGxGfUjAjDuB
	z5iA5naRdOjRK8tM+yEqEtCTE=
X-Received: by 2002:a05:6214:5086:b0:8ca:7f:89b1 with SMTP id 6a1803df08f44-8cc7b5a2b1bmr306790816d6.12.1779814056128;
        Tue, 26 May 2026 09:47:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80deb2a2sm152161976d6.15.2026.05.26.09.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:47:35 -0700 (PDT)
Message-Id: <6cb8924a2740a676f26ee262f35908d03d180b73.1779814052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
References: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
From: "Evan Haque via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 16:47:29 +0000
Subject: [PATCH 3/5] git-son: add to command list as mainporcelain
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
Cc: Evan Haque <evanhaque1@gmail.com>,
    Evan Haque <evanhaque1@gmail.com>

From: Evan Haque <evanhaque1@gmail.com>

Register git-son in command-list.txt as a mainporcelain command so
that it appears in "git help" output and is discoverable through the
standard help machinery.

Assisted-by: Claude Opus 4.6
Signed-off-by: Evan Haque <evanhaque1@gmail.com>
---
 command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/command-list.txt b/command-list.txt
index 21b802c420..880177e0fd 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -186,6 +186,7 @@ git-show                                mainporcelain           info
 git-show-branch                         ancillaryinterrogators          complete
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
+git-son                                 mainporcelain
 git-sparse-checkout                     mainporcelain
 git-stage                                                               complete
 git-stash                               mainporcelain
-- 
gitgitgadget

