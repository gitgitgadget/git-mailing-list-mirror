Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9632127A
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624003; cv=none; b=VZWIQw++NFuDBv360xyxVfNjG/luupmmoHGO4mEEhUB9xJ2qMA3zCtDnMBhAu7mRZtESNTNfb3sfcSzfBbCYP/GS5w7GxdI+E3Npa0FXFk0UXYx+l9NgXw0mEJ7c9/dsYSVmsV7+etOCp01MWqHKHQUbwH75Pknhqv7plQlct8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624003; c=relaxed/simple;
	bh=sbqtkAtkemP83TaCdvnDJ09X1UgS2+Iqln7qtKv5UQ4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jFtwqKvxRLHcW7JqSKBX4aCP36nfcjXm4CC1xZIMAbHdbCNYqiC7ZPzhv52VHempZY2CJYgle3Hv+c5KdEhJ61HbI8Az40II0RqDyCyUQEisI8iY5k4t0d445WSAvTobZdI8yDleoyKfKLpmiPin1hP0SCSGFp9Kigpai+iWDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTtswTs3; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTtswTs3"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8877b60f7a5so196870139f.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 03:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758624001; x=1759228801; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lYsa3QdkVjgJLYY6F9sCaPXA0X3yw9kDOQs6/ZenfBY=;
        b=eTtswTs3oElhZkVnAt3SXAOOJkjyn/4uDHzxq/gKMYA+6m/omrbTPMlJImXO7NDqsu
         /bxFeB+8dLvNam94ESQHXVAAIdF4AJGMPunud54Uk+iCa1a4GosaU0WdyfL2uifhxcEJ
         Aeh1L4Rr+jjc8J5et926Lv5HBKQoVRA8lCuswRaQWJOWEeOLxcYXqHWwFRdh0R3HvqPQ
         +xqcUR5N9au3hlkhwVG3KVP2V+ULhwazPO3dWIrv3Mw/1Gjet6DPAptZfYgvi3dNE+y/
         wF1LpgcYpmOumUhEdcAxOKBsRMb0WaDdThuCtWu/8uHZMttvznM9veCje+ElWIjqyZRz
         jusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624001; x=1759228801;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYsa3QdkVjgJLYY6F9sCaPXA0X3yw9kDOQs6/ZenfBY=;
        b=bfqBg+E6PcizDle/EREVf0JwG6yxE1wvS0TBtcGy/CW/vwV3Mf1k2GQ2q+ndwJSVmC
         tgBnQzk/DeBHLDSOfkSZEKGaUQ/A2WJToFgfpdKoGf8DcPeLu/l617YFdkHitAtEGCSc
         goyPqEeieTZdnkHHNI+3zNovPO0rycMK2lRvTORrR71ftDqBFhyal2WjcSdT10c8XJ2G
         thnVzkJ07wbGmEGm2cX8CECKGGNRH4g8qzh1lu/T4NIXjHdi95DXG2zS5Vb/jEgQEV1Y
         YMYR4to9s0DxS77iYQG2RTY9Ky7NGB7dq+iCkMwR+kekglivzcjcfNGPTExW5iuVgEmU
         4vkg==
X-Gm-Message-State: AOJu0YxPrwFSsX/o9JgxET7+ZFpFmn+0Iuw9XcnGzNLKj4sSqFzYGnQ9
	GvqIOS54Awz69XZqkskGnaQtsVinRRmTX42rBXesMsDXQdjo5VBJISTg0AbA4w==
X-Gm-Gg: ASbGncvbkByTiKsW9kX7SjIisO/CWn6gLEIrkhIuDN8LYFxZ6rJNlScIlElnBwHRfXM
	JP++qqSzHYSLEjAamFje6YEFO+djCo8Zu40OZSXen8wJJqAUoqSqHJIEW3R1cZCdzLOlAu1k63o
	Mp+bqUt6ESwJZMVPWdTJJcpUuglKy3DbOax08e727lF7GcRvoHAUnC3Q3PWP3IYvzZTHiNEKlO+
	ua100AfVDceAAPex4Yq3vJ1jjzPkVso8q/4mzqED49cPVoS4hA/O6VRyxT6ovk7bT3uoUlhrPsz
	XbbfJCEaFN300pXAXg+1ykGfkW5Dbyw0gezKIpOvMtd7lhcwA9C74bkSw+UQqXIMgEve2o4BpSj
	4DiziXTMxVJxppBZkwCWWffp2kBgX/+/M3b8jVw==
X-Google-Smtp-Source: AGHT+IHNKZzOxFvIXcXtGYJftFGuYmsKmEpBkGA/aNjc1HcXCKjA5tYipgqYZAifacvVGboui/TyRg==
X-Received: by 2002:a05:6e02:1885:b0:424:7cee:1135 with SMTP id e9e14a558f8ab-42581ec5942mr34115555ab.25.1758624000854;
        Tue, 23 Sep 2025 03:40:00 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.176.182])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56508512241sm259060173.69.2025.09.23.03.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:40:00 -0700 (PDT)
Message-Id: <pull.1975.git.1758623999720.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 10:39:59 +0000
Subject: [PATCH] l10n: bump actions/setup-go from 5 to 6
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
Cc: Jiang Xin <worldhello.net@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

[Originally opened at https://github.com/git-for-windows/git/pull/5811]

Bumps [actions/setup-go](https://github.com/actions/setup-go)
from 5 to 6.
- [Release notes](https://github.com/actions/setup-go/releases)
- [Commits](https://github.com/actions/setup-go/compare/v5...v6)

---
    l10n: bump actions/setup-go from 5 to 6
    
    (Originally opened at https://github.com/git-for-windows/git/pull/5811,
    then at https://github.com/git-l10n/git-po/pull/870)
    
    Bumps actions/setup-go [https://github.com/actions/setup-go] from 5 to
    6.
    
     * Release notes [https://github.com/actions/setup-go/releases]
     * Commits [https://github.com/actions/setup-go/compare/v5...v6]
    
    
    What's Changed in actions/setup-go@v6
    =====================================
    
    
    Breaking Changes
    ================
    
     * Improve toolchain handling to ensure more reliable and consistent
       toolchain selection and management by @matthewhughes934
       [https://github.com/matthewhughes934] in #460
       [https://github.com/actions/setup-go/pull/460]
     * Upgrade Nodejs runtime from node20 to node 24 by @salmanmkc
       [https://github.com/salmanmkc] in #624
       [https://github.com/actions/setup-go/pull/624]
    
    Make sure your runner is on version v2.327.1 or later to ensure
    compatibility with this release. See Release Notes
    [https://github.com/actions/runner/releases/tag/v2.327.1]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1975%2Fdscho%2Fdependabot%2Fgithub_actions%2Factions%2Fsetup-go-6-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1975/dscho/dependabot/github_actions/actions/setup-go-6-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1975

updated-dependencies:
- dependency-name: actions/setup-go
  dependency-version: '6'
  dependency-type: direct:production
  update-type: version-update:semver-major
...

  Original-author: dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>

Signed-off-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/l10n.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index e2c3dbdcb5..95e55134bd 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -63,7 +63,7 @@ jobs:
             origin \
             ${{ github.ref }} \
             $args
-      - uses: actions/setup-go@v5
+      - uses: actions/setup-go@v6
         with:
           go-version: '>=1.16'
           cache: false

base-commit: 79ee0dce2a61b7552f9b5c73f0cf2d974a20a029
-- 
gitgitgadget
