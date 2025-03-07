Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC2DF71
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362526; cv=none; b=b+OxN/FfGl4yHsKRPYknwXRkzguMyUGOgWHbgKLD5epqJ+WsJFaAZB8h2+EY4F5F1AWz/EqAK2e/9gGogr9fJJ0QE4+19V9ohgDPUvxNA5/XkSQNmy90f2LZjFRvOqFg4tLQCR9k9jH7rXN90NAFhAZ2QcQSTRiqu9gEe337gDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362526; c=relaxed/simple;
	bh=3FA7xoAQtkAzVnHGsHWNjUkzsm1xGlZbcpZ2HdUDv1o=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=WkEVOCuYpbrwopK/OY17AJGplmS1VbnrK0yDRXluQgPyHOTN6Ws51WapHTMBUH62hXuowjzsD5H6KoC/PFVgVcCa1NVC9Gm3OZEOt6XeEsLNy++haFoSqZvfMURVZoDojcnM2wecZ05ww9QOw1qz4ytmspK64ReFupEk3as75+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIGC5nnH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIGC5nnH"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf628d653eso352430366b.0
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 07:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741362523; x=1741967323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5nRKsjyhMoOffmeTy04FIfvFXD3ez1MlpaE16ivxrNM=;
        b=dIGC5nnHgxrKWpxlXe79/7+ejHZf7PUvPU1OWSu8+dqArLPYLc0Ss+jxzQ6DxGe0FF
         m3sCt+RbTR1IcR4xwKTqy1DXlx70sOrVnN2mor+TRBdXNVCOIRfeFpbzl18ofUOEKjra
         79GxS6Yy5aP0M1HMAIGjwHuP2BsN9X7j3HmHmI0TCBSFKDgU6woEeakS1ApJnOF81m1s
         17v0Wx6H5QU3wVeiJO4cNyUkAUq/ieAOhRR8os/+tt0QAv/JrMDD5+DSB8+kCJI/ZwcQ
         20nlPyRDl+iUGP/18xj+aFyMBXetWy7cMEmvw3sNZ7Eb9IbRcpLxTdoV7y4kzj4BGI9G
         ia4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362523; x=1741967323;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nRKsjyhMoOffmeTy04FIfvFXD3ez1MlpaE16ivxrNM=;
        b=NhJHtzEgeeBMSRosEV2CenfVRsnETIbsq7RMIl3P8Ah304QWLKvaiSI98pm9aOsLIC
         yCAizAFCZfuYdMxOHCYkW5JaXJbZHcyXM11dd63OU+EYAmqdAVuXpPzZhWjFelI4WIM8
         a+zNmLAUvxgUJVIGd4kxlkgWVTYhe+a9BiJ7V/CydlUgrSUAtyuBI3Uo+k9Bu2gH/DKw
         NFiAt4Wbyuz0lq/dqHvs7LZ4kiZL/VaUR9UlRULbsw9qpFfmM16YCOaYCSwQjRfDJB6j
         Wu3PPoQunsydVFW/LKAy9/NzdV/SkOHB4ljFn86phnIzTn5QFSU5qH55qHGeKbW7FaYZ
         MGUw==
X-Gm-Message-State: AOJu0YyracpmiioBAWIq6fVj9iYTmShzRk5AmDM0OhioPRu0DMBuK+i4
	NxLK+dWnZuuqb9MjltOS9muDXVNPNTvIQ1Bnz9z9BivSn8qJhHdwcaBt1Q==
X-Gm-Gg: ASbGnct7gqck0lzmEP5aL/c1It6PB52M4s9FfyLgAi0un3KMlOxSYc/U2oe2oqZUDN5
	rUAIHStEeRPr3CiZw8YdpKRTC4eNeOAabLIuX1Svl2g/0yqhxB3zSCfp80JsDK6gTR8m8WvmZfb
	AmecSWBEG+9C2ZOCCAUMSl11/2ooYjNaLkKxfKrwTBkFqY6P2dLn3C5KzCx4fN3CjTcyWdsWj9I
	4PXtU9jGZl1EtV+LVYUAUkKAd0bhOCfEHFWBMAXGGBcpDIepIfmCzv2/FinveqbXgIHCXVjChrP
	s3SZiSzN0ZrEXs9ylstTvPXSaghW3yoNJIBJF2amIe7+WQ==
X-Google-Smtp-Source: AGHT+IHqwRPPbDLtEYDFq9AfBkUO674uobK6GO7qiClYsuy0pWSxBSM5Z6mWYZK6kpULnm/GY/VXkA==
X-Received: by 2002:a17:907:1c1f:b0:abf:72c1:6e6c with SMTP id a640c23a62f3a-ac252ba1906mr470918466b.45.1741362523332;
        Fri, 07 Mar 2025 07:48:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2398901besm288989466b.160.2025.03.07.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:48:42 -0800 (PST)
Message-Id: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Mar 2025 15:48:39 +0000
Subject: [PATCH 0/3] Small new merge-ort features, prepping for deletion of merge-recursive.[ch]
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
Cc: Elijah Newren <newren@gmail.com>

I've got 19 patches covering the work needed to prep for and allow us to
delete merge-recursive.[ch], and remap 'recursive' to 'ort', including some
clean-up along the way. I've tried to divide it up into five smaller patch
series.

These 3 patches are the first of those series, and each of these 3 patches
provide a small new feature that together will be used to allow us to
convert some callers over from recursive to ort. If the third patch,
introducing merge_ort_generic(), doesn't make sense to submit without one of
its new callers, I can extend this series to 6 patches and include the
conversion of git-am.sh.

Elijah Newren (3):
  merge-ort: add new merge_ort_generic() function
  merge-ort: allow rename detection to be disabled
  merge-ort: support having merge verbosity be set to 0

 Documentation/merge-strategies.adoc | 12 +++---
 merge-ort-wrappers.c                | 64 +++++++++++++++++++++++++++++
 merge-ort-wrappers.h                | 12 ++++++
 merge-ort.c                         | 24 ++++++++---
 merge-ort.h                         |  5 +++
 5 files changed, 106 insertions(+), 11 deletions(-)


base-commit: a36e024e989f4d35f35987a60e3af8022cac3420
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1875%2Fnewren%2Fendit-new-features-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1875/newren/endit-new-features-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1875
-- 
gitgitgadget
