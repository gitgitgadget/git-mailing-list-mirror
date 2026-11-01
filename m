Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530938;
	b=c5xZv5lfN7uEu1DGVd1/GGOR/rQR41OxuZMfgdLqEW0MilIui8C+MjDbfl8fZIEIRFqG
	 HdPVkMy/9TtC5cfP7SvDluxFS2IBMaLd6jI8hVozAigs1wKafLp/fqsWOVViZ6Iw7HZfU
	 qHtwHOkeEb5wzkcMReZCepO7BpiLhMWX9/REa3l02WWQ/pYAKVrVqOghGQLxScoSWj2Qa
	 13JcO6XznqNkKPNboow7lWExquO3NhYgM7s1NRrFusQeVvovKodlmE7oVZL423UjX4t2P
	 kri1ayFLtwq5XN6tSuL1+p/YWS7D4qyhG3S4V/DKy94WXPRxe9xynaZK84FYzF/t0PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=nGFBGr7eDFL4zWoWye4W8OKOLGRhb7YtxxXMrqjY1U4=;
	b=TOsDQSjT/bbVEPKC6pwsUpDM0ijVoTCNtIiVo3ZMs2yTSqbwgW/UP1AKNDrI7O7CpFi3
	 W9Gy+xF/ywNqroCsd2XmrJLq5It3XnwGD81w88Ioyr+RdmV0H9ZSWTrdUMVdNnB/fTvSI
	 nIQPimCtNsHO5jBT6eBQvPx3XKL7KgIg6FQRqWdocJGNvSEv6jYyxypk/MTCiMWM1curf
	 11Pc5V+uq1ukDO4drIWCGeSSG0nub2Tb7XHVsQAXfOZ4x4foSmIt5mL7eIqcRPxQ9Do7J
	 OdtiGpKKV5A/mDPaYFeYIe/RJ6t+83hRApOqTTBdtPehjdX8xNBbF1MxJm1xzUHkN4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D5Fv0tWH;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61547606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 11:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61547606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D5Fv0tWH
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e515769d3so217169285a.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 03:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793530937; x=1794135737; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nGFBGr7eDFL4zWoWye4W8OKOLGRhb7YtxxXMrqjY1U4=;
        b=D5Fv0tWHEtwA17q8DbUdTinoha/kh/5yLcSvFgpVtH6A1mJay//zSs5uFqST5UPsFw
         K2r7yTSTND5SA3Eavt377boXhKDV/EvyKyd6Cpxs1sCH+1jpYfh143IHgIz7Xbny2YHH
         qM8fz0uCBof4Yp0nYfckMg0gV1E/52fIGDL8sbf+xZN7cClxenKWOxtdV0vewi75xQ/I
         JEL2Pnhx/ivVjhVTbpMFD99/J7by3JLeDPhQJfi4OuX32+DdAYD/tBLvrGO5fBlXUTuX
         osstdqp4c85Zg9KyZ/Mw91bo7MhlgnCWVbpzJfwpOVqgRIYmdhV4G5BNh+NsHhPMKZW9
         96WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793530937; x=1794135737;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nGFBGr7eDFL4zWoWye4W8OKOLGRhb7YtxxXMrqjY1U4=;
        b=JJLei7hR+hH0jGkRp5sBap3e3TzDVK15cSJX8XMCjIgpjSuwPHfsjw0oJzpGbZw4dD
         c2nq2ZBfwmRJ21uHLlGycfezRXWIn8+I2SBqTh6mInbe2gOgd+DGpEAnh18pzg8dQ65p
         tIyVZu9S8+bTd8cQc4ENiPHK+ao7Un+y2z9ka3kFhOxO30k+izWjSfuWYFoshAKCYhPp
         3v9JZDD3EaXj5HksRvKsCcC2CczJL92DV3bq3V72JaMEPYEU2LY3QQww2wlss5lYIazK
         ZTqaiCsS1m0cacVYlFxkTvrZ4uXoQycVZFPjTJ3X6AERNRXsvl5uqOSmLpdc8aZsQ/tf
         Tr2Q==
X-Gm-Message-State: AFq9FYI199Veyb1T34mWmg9uDEZ4SbUCjd0KBMFIIP0g+N3qjxVUDGt9
	MtDiLby0gOw55gF5LE/dF9AdnBjWb+akYc0FJAafUuv6R4knUx3DQbIJn+HSN9FS
X-Gm-Gg: AYBFou3swNgaABrAMaHTtp5cUFuSpg8/+sN3jAD2Re1+zQNC9DAFS9Xk1LWEDi1bvxA
	8Hl6XBzKxSDt/ShcjxQmCxzu3/k5AzM/5LUweFlZNWHQKEN1Keae/25ynnyL4DC18tUB18PnCL7
	iLp0flkmryTW4nmNuuHA0G7ka+EH/lvkXVmsuMvMOAyKtrT/8/ujasda4P0yQofwNZzv5xJhx/4
	hQFHHPwSfdd+nypW/sfwL0Ys7KOF/KCkrrdHyUEa5Q7eJFhYhUjGfLB2k7EX3z62Kko/dLTi4cz
	FSqJ9qOoMaF+dizEGoH7msc9E625+75KZlKS/tkF6JvR0Bpr3vG21wCy87iVB637Aih2PjuwiJA
	SR2Oz85ar1n7d9XJdf+AcQwdIcFng2YLO21Qu1Ccoe1mUvNHXH6zvxM5V79Lqwz7pXR1wvQ2Ozd
	VUvCf7sUMyPg+dmBdoOXr4Ok0vQTFtdUpDv6Oz58HqU1Zay7rMhh3ZjrCpOZ2a72aeNrZvduvhA
	kN+QGvhxOVh597Umr8fSYS/4XmtswOWuu9vhTHE6cY8ofuA6GaMa5fOcDwa3Rxs+hNzrU3NsfE0
	D8jgOtdhYcdAnPtLP5iN9OvBnDF2AqY=
X-Received: by 2002:a05:620a:4053:b0:93e:c12c:43f9 with SMTP id af79cd13be357-9442171aacdmr1098287985a.70.1793530937292;
        Sun, 01 Nov 2026 03:02:17 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425a6d761sm580134685a.29.2026.11.01.03.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 03:02:16 -0800 (PST)
Message-Id: <pull.2478.git.git.1793530936.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 11:02:13 +0000
Subject: [PATCH 0/3] ci: fix jobs failing on Ubuntu 26.04
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Four CI jobs fail since ubuntu-latest moved to Ubuntu 26.04.

 * documentation, fuzz smoke test and static-analysis fail with ln: failed
   to create symbolic link '/usr/bin/dirname': Already exists. Run the ln
   with sudo.
 * linux32 cannot resolve deb.debian.org. Pin it to ubuntu-24.04. The Docker
   update in actions/runner-images#15205 fixes this on 26.04, but a new
   runner image will take a long time to roll out, and CI should not stay
   broken while we wait.
 * Use apt-get in linux32 to get rid of the apt does not have a stable CLI
   interface warnings.

The first two are based on Johannes Schindelin's fixes in Git for Windows
(git-for-windows/git#6473).

Harald Nordgren (3):
  ci: use apt-get in the linux32 job
  install-dependencies: work around a permission problem
  ci: pin linux32 to ubuntu-24.04 to restore networking

 .github/workflows/main.yml | 6 ++++--
 ci/install-dependencies.sh | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2478%2FHaraldNordgren%2Fci-linux32-apt-get-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2478/HaraldNordgren/ci-linux32-apt-get-v1
Pull-Request: https://github.com/git/git/pull/2478
-- 
gitgitgadget
