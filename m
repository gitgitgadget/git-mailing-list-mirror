Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F617C
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727623032; cv=none; b=SdFn8lm4rdV7GDSQtDF2D9Rn5ZqTbrGNE9TysiYtwSHOr0K8G8yve/07NwB2BJ7GFU2J5jSOjXd1ccI/CBcqJ7M6xzZIlQUYzW7S2dwzqr3/LtcqLc9hqwGLYVnKtuj4yi9r3wsNKIQ730q+z+mx0hjOZyGbvkM5s4sgVr5bpcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727623032; c=relaxed/simple;
	bh=pBEqUdna26FNG/QvtS/6uIIKXCDyM+gbY75F9/vDlEs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Tj8kekjSGONsE7kno8oSc9EIKoXE77O2UQQvhFeAntwbCaf7ipbzyIEhvB9F7LrQxz82y7j2cvTt2EvWAByB2OLmr5dhmqTajcYgBc7RVZ8mrJsy7uzGf5Wnr8c8UFC3O2FlO+QEvi7XA7G7e27f8OBVOqQ2GcnbIo8zcWTrVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miGdnkEl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miGdnkEl"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso421503766b.0
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727623028; x=1728227828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UF/lE/JWSgYp7vWJThQrcW+dhMAoVRgUb+6fYcQFkKk=;
        b=miGdnkEl+3V1N3fRqAQsSQEupd0EPx0ScUlDMOqQYFjAMzLw2zRmhezgy+Ijt0et3G
         do7k8XNCtcvLufXdpww+dTfcVURIAebv6h1oj2L32NFg4JGe3dHwcJXaE6SL8Vb+6Zf5
         7uquGFZ8DTitAT4CQz1+YfSfxPB6NjFnH3hNfTe1J4V24U76CIUMek9wtXnkuHMbVlP1
         0W89mjIaQyOICxFCT2WxmToK7gaDZckORFkdYgc3p9lz6+u/RVZLh9Imbm0Fe1BRjy8d
         ft0TW1YCTz0MBqV47Va9ScMc8/XRjSWjuosIL8YwiMZSb0tj8gt9JXbqSJM2qpvWd6D5
         mn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727623028; x=1728227828;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UF/lE/JWSgYp7vWJThQrcW+dhMAoVRgUb+6fYcQFkKk=;
        b=mhB8nBImyNHNp0FTpx/QgyTD378eMHZCvtYVpJnIcbCXfNxKNVmMC/MRrlPm+Aa4X7
         vC4vyB2NnE67RFHHCUp0evEdMPDsZUOugy21CyCHF2hR14hrsXzjrfbNs+ArBb2y+jfL
         DbqirwI4nOLXFJGap5uDAIx34837Ul7czYRKCUXQaOk10C5fQ7W/XDxNgVAbgNOKCShS
         AIjkfcq0oe75LV6/5XYBxKuVsxoZvMAeloFSnvN5g7D3apUIAIyTbVzQ/b7DyezNSlYJ
         sLzPNilaNLLkNM9ut7Vw0cBijmcuey+XHsLoRoiOLcs6Mzwq5wqX5OVz5ISo9DNndQRh
         nCgw==
X-Gm-Message-State: AOJu0Yyh/8ddZevdmgjRQwL+nb4bOBVmBn7KUWGSVIy81Oj7UNWvhu2U
	vs43UuVvphEJ3u7jGXLEs8iNcAeEIYI3yRj6aP2spia5gfB760ylhcMekA==
X-Google-Smtp-Source: AGHT+IH0mFQyruc80nWLXbDqtLUrbHBqBR8l/UekHEiB/ej0bO1LgPYP6XBDRkfwVqMK2SZGZ0O1ig==
X-Received: by 2002:a17:907:7d8c:b0:a91:15ba:7c4d with SMTP id a640c23a62f3a-a93c3211997mr1075907566b.33.1727623028142;
        Sun, 29 Sep 2024 08:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93e9f9aed3sm126071266b.31.2024.09.29.08.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 08:17:07 -0700 (PDT)
Message-Id: <pull.1803.git.1727623027242.gitgitgadget@gmail.com>
From: "Monika =?UTF-8?Q?Kairaityt=C4=97?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Sep 2024 15:17:07 +0000
Subject: [PATCH] documentation: add missing word "ref"
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
Cc: Monika =?UTF-8?Q?Kairaityt=C4=97?= <monika@kibit.lt>,
    Monika Kairaityte <monika@kibit.lt>

From: Monika Kairaityte <monika@kibit.lt>

In the git-fetch documentation, description of <refspec> syntax is not
entirely clear. When explaining about "the destination ref <dst>", word
"ref" is included. Logically, it should be the same in the explanation
of "the source <src>".

Signed-off-by: Monika Kairaityte <monika@kibit.lt>
---
    documentation: add missing word "ref"

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1803%2Fmokibit%2Fdocs-add-missing-ref-word-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1803/mokibit/docs-add-missing-ref-word-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1803

 Documentation/pull-fetch-param.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index c718f7946f0..066a35af9cd 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -24,7 +24,7 @@ ifdef::git-pull[]
 endif::git-pull[]
 +
 The format of a <refspec> parameter is an optional plus
-`+`, followed by the source <src>, followed
+`+`, followed by the source ref <src>, followed
 by a colon `:`, followed by the destination ref <dst>.
 The colon can be omitted when <dst> is empty.  <src> is
 typically a ref, but it can also be a fully spelled hex object

base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
-- 
gitgitgadget
