Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC78F48
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877926; cv=none; b=NU5o0eKHBCMVXQbugW8AIDe5fJjXa8NyGJSw7rFKNWR4EgggI9Bl4yesbHokZii7f9CpImxm8jtshwckJRA2EEQG90qfWMmN6s+MkKnRa21WbFewwKXdlUjMndfpoPzbngCEowsQja+OLO9zqTTC/XCgRhw3cToonotF5IdQx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877926; c=relaxed/simple;
	bh=Ev7jKoSONZYIpIIfnngSgt6Ifl2VCjatVrFXK0VQaic=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=etFeE+S5k1KYp8CdNuJ61qH0xBDvLLsnWcBl1Ul9zv7tiMtUw4L2rcwSQvbT9Oggm2BbqctgTKdZ7ncd+LXoD8NAi1NUhLmbSaUw9y98fW2I+Lg++x0dgi3EgBb7QgeAEGPKkTdFFYxhsRqpwlI3h/z4QxGCMswWNOjiQgT1nu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeXpr/F9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeXpr/F9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420180b5922so4838645e9.2
        for <git@vger.kernel.org>; Mon, 27 May 2024 23:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716877923; x=1717482723; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ijOLul70WLggrypi/S/xO/3456r9qGbKvKzYx2aAH1w=;
        b=DeXpr/F9cYdRjUKObbFoTl36n6C4Mw2RhwVhUoSCEGBT1TVEB3rsEensGGCg0Syo8S
         G9BPhpJXzyN1Gyo771YIFsmxzddAIFLFbrKFoTvekXLEyQv3NTKLiNizOMOuUjR1XQZA
         G2RlHleFr/Vu6zcvgw73IxhjnSiLV6rN2e6UazLnWVVi9GGNsAvfiq8V6hkcqEZFGpC1
         eWKUgO36DTx8JLJDrl8IiBcIC0VqTv43whjK4GUxhSGwtEindvFfkLRZqEUsXjqz0Dzl
         8GHpA7wGHorBykZAItki7/ZHDUoseBcmjHCYDQUxSPuIzbnbKSudTtLrrrnlTbEpR4d0
         OJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716877923; x=1717482723;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijOLul70WLggrypi/S/xO/3456r9qGbKvKzYx2aAH1w=;
        b=iXnbYnsz1oyf0ZhNKQqhYSbrHGqRUn0fwiIkRX6kHnWHfeh1vLIvrAphzXHBe6OU/h
         GHbqNBoMpk/V3TkWbFOL7Rd8dIwNqFZk067UW6kgmX3BLVNnuq5rLF8GG8Xb/E4qth3v
         baG3V6s8MpuP5Lw6nLo92eB2PeULliX6lgNx/xzcjz+mzD28Fk3GM3J69GJ+l2FFrS8z
         jbwDb132XRssrdXsZmWv2mJjIkKgrEitC/02GduX9NuRA9fhFq26OsmKE9dg6gbDjiVn
         hmyKahRbTQ0+ZdFH/Oqh4tb94gPh1OdkeIKQB1O1IrtAYHhv7qxbaQ1iDa/f0h/aPfnw
         17Yw==
X-Gm-Message-State: AOJu0YzOR5Jvzde+QCieB8ztDY4kTaT6kASQxSmyzVvBTyzi/Z35S1Uc
	RtXWXBYQHFhGefO93P/B9DxZilLb5xSQH7jjvowaB+ek9WS6tVirCvVfpQ==
X-Google-Smtp-Source: AGHT+IHjaypaxgFV+8utw+qoTOxcxRjf6nbsCrpq7j/vdfuCnI1IvKppN0YMzl3gMdGK7w/g1/rkWg==
X-Received: by 2002:adf:f005:0:b0:355:15a:f0b5 with SMTP id ffacd0b85a97d-3552fdaa768mr9717747f8f.32.1716877922910;
        Mon, 27 May 2024 23:32:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35b2500e0dbsm926622f8f.86.2024.05.27.23.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 23:32:02 -0700 (PDT)
Message-Id: <pull.1728.git.git.1716877921.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 May 2024 06:31:59 +0000
Subject: [PATCH 0/2] Remove some usages of the_repository
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
Cc: Philip Peterson <philip.c.peterson@gmail.com>

Because usage of the global the_repository is deprecated, remove the usage
of it in favor of a passed arg representing the repository.

Philip Peterson (2):
  add-patch: do not use the_repository
  apply: do not use the_repository

 add-patch.c |  6 +++---
 apply.c     | 30 +++++++++++++++---------------
 2 files changed, 18 insertions(+), 18 deletions(-)


base-commit: b9cfe4845cb2562584837bc0101c0ab76490a239
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1728%2Fphilip-peterson%2Fpeterson%2Fremove-the-repository-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1728/philip-peterson/peterson/remove-the-repository-v1
Pull-Request: https://github.com/git/git/pull/1728
-- 
gitgitgadget
