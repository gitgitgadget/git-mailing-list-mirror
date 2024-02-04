Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AB24A19
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707069813; cv=none; b=Rg5UiYvNmjj8WTa4Dxf0QEVbWeCo1VVMVeWVmrEjvl/sdzSYxXCCEE6OnI8RNeCD4AqPXxsmNLVmpRoVu+0sZNGQ0QLIXtpCezpnGpcQrB2lU5NuO7GCho6vb6n4QaA4B0Wqntq7wMH4rpkZpQNnjoO/LfjAjGjlNEdEROzwdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707069813; c=relaxed/simple;
	bh=778Bv9UEz781P/NpjPnd4FfccJMe3sRZ02mg2CGoTTc=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=IOC+K71P22UEpPiDbysTaAnzPVIx05iUKAvszfZyoZgCCw/9i4wn3eU9Vi1PBdxzJHpMp8qRhmo3OyptMxwaJGvbVPJxq+nZ4/HpAYqun1I162HH/WykM3AHR7N/F4bqqTFO9zr6nR1NyWW/u/zXC/du40Pon2/R8jtNvPmREoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ/oA9jf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ/oA9jf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fd55c7f93so6657035e9.1
        for <git@vger.kernel.org>; Sun, 04 Feb 2024 10:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707069809; x=1707674609; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F8AXqVDSFBV6ZcACx/wp8rpOEMHm7xf414egag4Qizo=;
        b=eQ/oA9jfVG+yVEogtSblK13mnUMps4cgsAhL+112UwSSAnEmeYSv6la2D8fa/hegCG
         Wl55NNet2aSEmiAANYZOb8BPRM4/PP3qARsdmfqR9HaAwR5vz6pZ8306MZJ4U326YMG/
         ys+VAO/lNSIHhoqhn0mm7hsnx0o6i4CbL+rJBc3aS+4/kx04Ghi2aHd71zsBwvZwQW1w
         EW68mf3UgsQ1f6Spr3j/MBsZj6btQWT7NjeIbSR2wuSmHhzAiDJO3ottv8xICKrVeFam
         +DO5juz+U3+e9uKoUoCJahBaC8lHOKdB99bbvOQLpHkKJJZWUYErkCvr+Vxv/MTj4I9B
         cuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707069809; x=1707674609;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8AXqVDSFBV6ZcACx/wp8rpOEMHm7xf414egag4Qizo=;
        b=PkCGzuv5a2LqW4a8SziMLdT0Tz9aPkg/oZvk3VonlRV0frrDTtpi+UzAktHEMJRlle
         /y7XKbeLchwF03ZToeHbqqS+i2u7f4sGPzV6uUxgFh8g/xsvmqubQWVFMnVzocmpDKDk
         AhH2xlblOKoXz/nmIsDlSOKmUDdp1RL7kf5i5/fOdvRu8gpOSKH0ZJ8A7fKNMXrkH2MK
         yIreCromgyzmW9s5SJfVD34sY49Mu/R+uUiuNwC1byHVFfidnWUjr8u75ksbTL6l7S9c
         GUeshHH4VkXvzm0LP6282qRbraZvDS874bVB95pbAGjhlH/bgvfRdaCyuhogFB9mijJ4
         RLng==
X-Gm-Message-State: AOJu0Yx9SAfWtDl0IosRdkffjmn1eYnX3gZLqepX+f2TMd8am+afHOvH
	+macvS80zdcYqBPTlyn7QXEN1Jc/bRIsHovZErnXvaIwqKGVnq6KfRYoWzFy
X-Google-Smtp-Source: AGHT+IFLK2695TLaBAJdE9TAdOuONU9Ift4AMZ+dcXAynn7YpANcUWf1BsPhB2lyzVRp+z004k4k9g==
X-Received: by 2002:a05:600c:3594:b0:40e:a569:3555 with SMTP id p20-20020a05600c359400b0040ea5693555mr3262307wmq.35.1707069809113;
        Sun, 04 Feb 2024 10:03:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/yprM7F4EUH57JALiCE1basmY7seXVlZ1fIdhxbcGVw4JLTgX9SOb9ye93S6/rlMo2gh0kyVYQPAP25RVkQ6Y8RmE3WjmHziI6Xu+3A==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c4f5600b0040fd8937fc6sm2056604wmq.0.2024.02.04.10.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 10:03:28 -0800 (PST)
Message-ID: <pull.1665.git.git.1707069808205.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Feb 2024 18:03:28 +0000
Subject: [PATCH] .github/PULL_REQUEST_TEMPLATE.md: add a note about
 single-commit PRs
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Contributors using Gitgitgadget continue to send single-commit PRs with
their commit message text duplicated below the three-dash line,
increasing the signal-to-noise ratio for reviewers.

This is because Gitgitgadget copies the pull request description as an
in-patch commentary, for single-commit PRs, and _GitHub_ defaults to
prefilling the pull request description with the commit message, for
single-commit PRs (followed by the content of the pull request
template).

Add a note in the pull request template mentioning that for
single-commit PRs, the PR description should thus be kept empty, in the
hope that contributors read it and act on it.

This partly addresses:
https://github.com/gitgitgadget/gitgitgadget/issues/340

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    .github/PULL_REQUEST_TEMPLATE.md: add a note about single-commit PRs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1665%2Fphil-blain%2Fempty-description-single-commit-prs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1665/phil-blain/empty-description-single-commit-prs-v1
Pull-Request: https://github.com/git/git/pull/1665

 .github/PULL_REQUEST_TEMPLATE.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
index 952c7c3a2aa..65fa3a37173 100644
--- a/.github/PULL_REQUEST_TEMPLATE.md
+++ b/.github/PULL_REQUEST_TEMPLATE.md
@@ -4,4 +4,8 @@ a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
 bug reports. Nevertheless, you can use GitGitGadget (https://gitgitgadget.github.io/)
 to conveniently send your Pull Requests commits to our mailing list.
 
+If you use Gitgitgadget for a single-commit pull request, please *leave the pull
+request description empty*: your commit message itself should describe your
+changes.
+
 Please read the "guidelines for contributing" linked above!

base-commit: bc7ee2e5e16f0d1e710ef8fab3db59ab11f2bbe7
-- 
gitgitgadget
