Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DFC142636
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279256; cv=none; b=s2C8BsOfqmlNmatziy/YwSNx3VQ2+MlUwReLCqqQZlLW6HUHZbGbxxHDX9dROhIYlOETPaWFQzo29CmNtEb3XIKRR85klAXc0+XFsjQRId07KEsFcRA9UKYSVOJjn5pCdhP+/K4bzUITfQbhnNDpTghSLhsRndS1pCXlDmmNviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279256; c=relaxed/simple;
	bh=GariS4oC7lRisOpkcG5cV1UuBIEx9KffL/cdpr3TnYE=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=pY0KpuNEhIIKzHroAfa0TqNyFbbuJlgT5gE2WSfQlXu8Xb60trd4dYZYtXmw1AwO/4nKbDEr6qH09IPDyUPediFQerfn7v/qrWcbTQoIYiJsfMrynPJc/ZghaX9RT0PPBxBb0erNGVMFqDZdiJ8L/E/ySMR4T8odob8ZezbogSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LseBleUq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LseBleUq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4132cc37e21so15651505e9.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710279253; x=1710884053; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeLT+pU/krgOq2SZ8KwY+tE+q4k1dnscOy8ZHZxQ5u4=;
        b=LseBleUqpEjJiTIFT5+qc69QLAq1BnJhT5kWTmlxg2yvVDelKz1nGzm/BZHgIM6dL8
         uVuUE3/0MrsubthfvvIxHpPp/SKQ6PB25nim0oHws2EDz/Hk2nlu/rZ2Ou10aZrJvSwm
         N1KzefaEpnqbBg8Ajzi5PMFvnwQw6zLFF+7L6CKzdzBasxnAujAGq2P6NlarA1gTP0Pq
         tJNrDYEbvbcVkAGQhF+0xSaChfgwx94ul97vw8uraegkulCWrfskOqX0wNNE9xNucrKU
         WewUnPX98cUaP1T5BYKL/7QG8i+6lNPX962WadB9bS9j5KWn1qIklcP7bK8KqhU/bWsV
         Vkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279253; x=1710884053;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeLT+pU/krgOq2SZ8KwY+tE+q4k1dnscOy8ZHZxQ5u4=;
        b=DPQAxFNwN1u9iLxXGBT25ri6yS2NksP2mJAosex11y5rwC9KBO6wuP/0TAltRWFzvR
         P/X6ByZejbbM0bs/MJi14WLfOyo2NchX6scdU8hKtaf2w7pwTwsLL5h9ACuYDxqrl2RK
         BSMgVB2pIWcZn8cf2IE+npgiql3x/7UiqNLVdreSGaznE/ogKtRwxBvSVblDubyiyRyl
         00ldq2QfSz4aBLOZ5r1i/QoGmUkFnG+xhzQwpGCh850HyxSlhhTOGXhKhA9fOm7jsGA9
         SC4mWYLA3D7ZxTa7xlh25Us2ckJjXB7efwL61NamQDoSgJ6y4i/uu73sUVYa3OnY6yvi
         kx4w==
X-Gm-Message-State: AOJu0YxtE+noQ1fLk9t8TqWYPdKHnsNM1aiDwI+tdu+1Ir78h/EoTK+t
	e/aPMAzQnq5Gz/Hj5TmPmDBkaQpVi+TWMIiDGzyi/maurhswM4A0hfwtNyVL
X-Google-Smtp-Source: AGHT+IEMWeU8t8+vsUTbxbtimbUYIQVB6Tk3nMIi233ASyTjr0sUc2ZLEezjoXj+5psiCfAR2lz3Lg==
X-Received: by 2002:a05:600c:3ac9:b0:413:2ab0:8303 with SMTP id d9-20020a05600c3ac900b004132ab08303mr4893451wms.19.1710279252754;
        Tue, 12 Mar 2024 14:34:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c470f00b004128fa77216sm156740wmo.1.2024.03.12.14.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:34:12 -0700 (PDT)
Message-ID: <pull.1686.git.git.1710279251901.gitgitgadget@gmail.com>
From: "Jonas Wunderlich via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Mar 2024 21:34:11 +0000
Subject: [PATCH] documentation: camel case of config option, and "no" instead
 of "false"
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
Cc: Jonas Wunderlich <git@03j.de>,
    Jonas Wunderlich <git@03j.de>

From: Jonas Wunderlich <git@03j.de>

The `status.showUntrackedFiles` config option only accepts the values "no",
"normal" or "all", but not as this part of the man page suggested "false".

Signed-off-by: Jonas Wunderlich <git@03j.de>
---
    documentation: camel case of config option, and "no" instead of "false"

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1686%2Fjonas-w%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1686/jonas-w/patch-1-v1
Pull-Request: https://github.com/git/git/pull/1686

 Documentation/git-status.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 4dbb88373bc..b0f36fabfb3 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -472,7 +472,7 @@ again, because your configuration may already be caching `git status`
 results, so it could be faster on subsequent runs.
 
 * The `--untracked-files=no` flag or the
-	`status.showUntrackedfiles=false` config (see above for both):
+	`status.showUntrackedFiles=no` config (see above for both):
 	indicate that `git status` should not report untracked
 	files. This is the fastest option. `git status` will not list
 	the untracked files, so you need to be careful to remember if

base-commit: 945115026aa63df4ab849ab14a04da31623abece
-- 
gitgitgadget
