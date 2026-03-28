Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A676194AE6
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774734009; cv=none; b=ebUADaN4t55HrKsJ5zf1U8+TVc70UxNF5mbCh+LL3DB573L18Z6P5SxKZLAAoOfRMZLVcuEQ+KccUYndgSERv3z+8ZAB22a/VkRHHbrnPimx+D75g3ppIgoLFBzg6Gz2UiO7RJKiHaDHmTB1PeC1EfyxPxTqhz7jvyqrpircQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774734009; c=relaxed/simple;
	bh=zBxRmA5s5yEYp+GHGKa9JeDizmbQJTk5c4sEWK4WbaU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SQc5CJcmDdILZSmZtXWqran8YtissowgyvkThOw7Nm8XMLYpjgIuC/Pc/k8DonnmiRSjC5c7b/XlT9ebbWkt9y/S6XubISiIeMUdL9bR6cic93LAP939Q979vBp3P2RqXXFDusKRQ03esNIcX3G3/MITHpOol9f5RZvEFKOMiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqDudfKC; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqDudfKC"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c15849aa2cso3496919eec.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774734006; x=1775338806; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FQe/K+OTACvZz4tw+fNaPFj3TnyAZks5TH1kQ9p9DPY=;
        b=HqDudfKCe4nFVSmjARwAXXh0Txst4Zb7NCBck4cItacdVJwfhr1FlhqmlbWyx5Rakd
         HiecDV2FisQSFEQwgHNXx8nKYT62hCN67K7H4Jx2+ozoY7L8I+Ws6KxhBU7SPOrdBozp
         EKRRyJ77UjpMpEJ+gtxL0s/Ul9fX7bkSlMG07Crf4Se/94CaiLJXmsgJZ2gyIpkf+gQr
         wT1NZk5cjGXFdkotXsvgv6zfkcu0Xyk8e9RR5iKA8TSCMJceP3XlNMJimD0LEU6KbEe7
         ulMgdpTKhnEM342NbI4x7/hvqF3YgVoXKNSO6lpcYzjCHk8277JFA2ZrK8P0V+zLBLm8
         +xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774734006; x=1775338806;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQe/K+OTACvZz4tw+fNaPFj3TnyAZks5TH1kQ9p9DPY=;
        b=mCI7gEtUHde+ftezaO2pyK6ptbekZ094v2DwGAITZ72LMLAvK05Uqq5bPsJ/hyG6TV
         mVskCqlCLvO0H9W6gH8jiwcUx9x+bwIwdM4X8VXR/xoucvcxtHGHPC3h243+jSQWQ88R
         vPSmRm/O2vKfdsBc5PKR1SANPJh9auSua0jXsoPHttATCGaeJ0NPYRH7cuqVhd7+/LSD
         pPT8BqwDXtMWoSDHoeb1h+nXp+I9V14tJV3+ofnrJf3qIxgCueexRtn6LtTBqTlOewcw
         cf0sgfeWCxaZZCuxPGGvSFjPlSvUgeP0OSr2OWUCj3UkZY8jpqt3c+XhZDsEIoLmfNvQ
         YFxQ==
X-Gm-Message-State: AOJu0YyRuTrOPuJjRcjjVy8dgpf5yn/78RCObaCxRWPDqAyjBaKltIRR
	vpsGtLCAx/RBVCrJX8GAeezy7EkagdkyQocgTEURXFnebzUEuzm1QvpFvq6/7g==
X-Gm-Gg: ATEYQzw/BHPNTPuzcrijJOlgVeh3TqkGgwmXz278GdPWMruUUX1uJsKtq3231BuGlCd
	yu8NQOGZVb+qCwz4kBHibtUaWCfQpCtWGc4YlZZdCj9hW5dl7TU1vSwLqBChAefDqLBascFbGBl
	IkApYZMNrdbQMn56gkUV3rKLQ0pWVRmgo4Br4dmzwfBwR9ZIQ2zdZKjWikb5FuD9Vmgoqr0p0d5
	AxHDc3Obt96wph+8feBrnnbYfcWTRr9jhqQLL00VbEnZOcfcn9HLpnTZlj4+xK+eEc/LjZhRgl3
	2WVDqXape0Gl8+KiYnb5dPFLQsLc5HuqswRzE8D3vBk6cSbVLAdEROd/zTMhhw8+rOJ8MTxz55E
	tOwyq1XIN1C7x7/ZgC1jO5MFK9jlk2TulBSgJpHHn5MLEuP1fIGZwK/fy42aQjiLVQESiOxrmA5
	hNg2d6hRrCxsG2j8BvYLh1ZUr2r/bQ
X-Received: by 2002:a05:7300:230c:b0:2c1:71a8:3857 with SMTP id 5a478bee46e88-2c185cd45e1mr3893178eec.14.1774734006318;
        Sat, 28 Mar 2026 14:40:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9bd48sm2832899eec.20.2026.03.28.14.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 14:40:05 -0700 (PDT)
Message-Id: <pull.2251.git.git.1774734004.gitgitgadget@gmail.com>
From: "Dhruv Arora via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Mar 2026 21:40:02 +0000
Subject: [PATCH 0/2] [GSoC] userdiff: adding typescript pattern
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
Cc: Dhruv Arora <a_dhruv@outlook.com>


Description
===========

 * Add builtin userdiff pattern for TypeScript files. Recognizes function
   declarations, class definitions, arrow functions, and method definitions.
   
   * Handles common modifiers like export, async, static, etc

 * Added tests for the typescript pattern in userdiff.

Dhruv Arora (2):
  userdiff: adding typescript pattern
  fix(userdiff): sorted pattern and tests

 t/t4018/typescript-class-method         |  7 +++++++
 t/t4018/typescript-export-default-class |  7 +++++++
 t/t4018/typescript-export-function      |  7 +++++++
 userdiff.c                              | 15 +++++++++++++++
 4 files changed, 36 insertions(+)
 create mode 100644 t/t4018/typescript-class-method
 create mode 100644 t/t4018/typescript-export-default-class
 create mode 100644 t/t4018/typescript-export-function


base-commit: ce74208c2fa13943fffa58f168ac27a76d0eb789
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2251%2FDhruv-0-Arora%2Fuserdiff%2Ftypescript-pattern-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2251/Dhruv-0-Arora/userdiff/typescript-pattern-v1
Pull-Request: https://github.com/git/git/pull/2251
-- 
gitgitgadget
