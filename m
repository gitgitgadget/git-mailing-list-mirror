Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B028EA
	for <git@vger.kernel.org>; Mon,  5 May 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430796; cv=none; b=eRPN+h35HXJ+FalkMQcH3/MYO858+Li1b86qQzNlORjI6COXxOgX6l81+JzjnaXIMDS1SoWshnqhfD3y/6vav7PozO9C/MDQOWdr4wkSuOCuRCjqAgdL3TnbKY/IK3tsm8J/Zw1nLqigoq8k5cRZdpghBUOEtVj7rU5f3Efv0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430796; c=relaxed/simple;
	bh=zNH0amKK8xIzm0c2fA3wrkQzkYbUYGTed1wJiabvIi8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=faaaajmrCtqJRZLuh5kSirciT20Pr/DODlCjx4mRcs9jA3/ToslGOkk3kmLdpgv2/1UYeBMRA8QuNerNdPraI/lk3xdWNhxFuGLwv73qxJyDouMmf4Rr8yBZfzR61T030FfJcrKeCIdrwVs+4q0vEW4oX3N8nBZojXejzqUiHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvM+h5fz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvM+h5fz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0618746bso26412985e9.2
        for <git@vger.kernel.org>; Mon, 05 May 2025 00:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746430792; x=1747035592; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yNeMleZL5+l8ML7b37Tx+4F0L7emGTOK3CjnO7l8Zko=;
        b=cvM+h5fzqEpINa9gsjoo73E4gZ70DYeTbtgEnsBaaYr/kilZEiLZ5+rvjideFpeB+g
         2t65bT+uvaXF5gxQsbtkfo1fKC8D7pc1tPQMc8V38pj2YIJlqJ+OeQpjjnw4rYJpDmYq
         XcNUwZkVg+AOfn5bIAJdh85HuBR32ONJ1vFNo4NJNp34RJHjqPIJhRw7h7RHiuXbS57I
         hKirB8oF1aE7BAwhM/LN1Tju1rOiy/XIjootzBRPG+tsCnp0jqH9qg6EbbWzWBPH8uup
         fZkKV8vDvl9Tg3eYQ4052+Kr8C4kvkjzlvGcGWDQ4O0rgwXgsOI8m1sWL3Ja/IF81wWz
         F+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746430792; x=1747035592;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNeMleZL5+l8ML7b37Tx+4F0L7emGTOK3CjnO7l8Zko=;
        b=SdW1UIqSbSP3ZMePaPlHkkqYTwQ8BeuButUqt4TcDSe8N9AqiZ68yVMZhpgdw/lajm
         1hAhSohkgj23txeYInU2rSJnq7mx5GtAz+3E5EvaM8oA7UozEH9DBg14uCZkE2w9ZNz0
         web8ZYLtGSCQrRha6P4Qg0rCjOyVwk2xdt5EqYcosDkfh7PQQ50mX+n+gpTC9yHMVI+8
         CVSbx6xycpSplIbEvuT+6VTPBeEakvwF/ki5iNV1jWjKEKlgHMqG269inXm3L84k3SWN
         33QjvvWIkeX7oM+5I1zWjFr3Gax5RJtkblX9TPPEJ+Vl3iDRxt/HwPxh75H7dNCY0Uol
         wwHw==
X-Gm-Message-State: AOJu0YzQj/eRn5Qvc/R41W/2b4A8nk7kbVGq9zAEUgEmh1pSvho6W0p+
	MNWmI6nu7mNGm+RHvpcnyB8U+ihwCOvDt9wT6LLVJGZfZDepavDv3lkr9Q==
X-Gm-Gg: ASbGncuB7h8mpDrJJS/8GPLaJyBtPN9rJlCAlpJUVsPIb/SDspAZ/5wHQznXnXPaOy+
	PrE7ie2rjSghsT/gPlGRPpiJ83rurTKQsvbomyRdXWIaexOFYQe8dCCIAGnMjwruoR9SBsS86/j
	8mgeSAmTv9rZJDvKL0UTQBaC3W4V1SQIQ3vHsPyBFr6aSCo7XTcCGfZm90K3O25ihrlCNkoZE8t
	ECm6K9BFqefpF0pMY8byjUqq5vfI3CKHmSO2cYinDMYOlouOzTLww3edVzcrd9VnWLv+W5wFBHY
	b+Mq7SpkuEHqGUTLw34laOZ2NuLW9/FksNeGhd41Dw==
X-Google-Smtp-Source: AGHT+IGm6Sz6NqCKev29PsKuU1XoTfgXgxYjbDdyZdq6BJwrI5iIGy4fJAbKrcZuLjMOyHoQ+f7e4w==
X-Received: by 2002:a05:600c:500d:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-441c4938d9emr41288225e9.27.1746430791943;
        Mon, 05 May 2025 00:39:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0ce2sm9678542f8f.16.2025.05.05.00.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 00:39:51 -0700 (PDT)
Message-Id: <pull.1916.git.1746430790.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 07:39:47 +0000
Subject: [PATCH 0/3] Some CI/buildsystems cleanup
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series drops a couple of no-longer-used parts of Git's code base.

Johannes Schindelin (3):
  ci: stop linking the `prove` cache
  contrib/buildsystems: drop support for building .vcproj/.vcxproj files
  config.mak.uname: drop the `vcxproj` target

 ci/run-build-and-tests.sh                  |   5 -
 ci/run-test-slice.sh                       |   5 -
 config.mak.uname                           |  76 ---
 contrib/buildsystems/Generators.pm         |  42 --
 contrib/buildsystems/Generators/QMake.pm   | 189 -------
 contrib/buildsystems/Generators/Vcproj.pm  | 579 ---------------------
 contrib/buildsystems/Generators/Vcxproj.pm | 402 --------------
 contrib/buildsystems/engine.pl             | 395 --------------
 contrib/buildsystems/generate              |  29 --
 contrib/buildsystems/parse.pl              | 228 --------
 10 files changed, 1950 deletions(-)
 delete mode 100644 contrib/buildsystems/Generators.pm
 delete mode 100644 contrib/buildsystems/Generators/QMake.pm
 delete mode 100644 contrib/buildsystems/Generators/Vcproj.pm
 delete mode 100644 contrib/buildsystems/Generators/Vcxproj.pm
 delete mode 100755 contrib/buildsystems/engine.pl
 delete mode 100755 contrib/buildsystems/generate
 delete mode 100755 contrib/buildsystems/parse.pl


base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1916%2Fdscho%2Fci-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1916/dscho/ci-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1916
-- 
gitgitgadget
