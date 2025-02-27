Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1D26BDBD
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671054; cv=none; b=s9zUts+zSLVztoi7YktlXCYre23C6uQEoGiS+KAKRxE2QNfbMa5xns+oukydsL5yrg2Ke0+9z45iCG0NA5tvLOxn5nzVDzoCTuvWtJvwvLqjVmaTTZH9EdngJ7D++dHUserGhacULU4ZL7nSIkCPyUL9mjz3FLC0NJRT4hFa+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671054; c=relaxed/simple;
	bh=F9jiAeZzLuAERZbdCu6/L3f0GLH9Y1+A6zvg7sutcJU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZEapvrC48muXgWyk4WqcOc4fq22/eb9yI6+IajHPu6Pf5vutjL8MTYmW6yPAZaW94BgtovhaOEDmJgCI8JpsT1MyG58oxWSaNiIGluV81RHQrdo0MsNRqlsU6xdZZAIrGUffsCEkdL4qGV+VFHGhpAbKbKr1Lcyuq4vQs2UNg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTd3eKgN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTd3eKgN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so7805045e9.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740671051; x=1741275851; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v0tu0OuPvoFVrBKprqHcEcI8RHe9FTfvuOrdSb/S8xc=;
        b=TTd3eKgNcZvBH8HRrBuafmnWhq78jM0WCAC48POsmh5zLM1IqdE9DTP09fxcjYARmD
         xWD+c/U1dPAcgPAP4yixuGzgVD0/6OCPZST64N18qgO8kDTaZulagQlRvrZfS4/Ga2TF
         NknE4/hvzuJHbITc5x+cgE/MyX+2vXEtwPGKtzjJDureOjT6TZZ0UxyoldDOeIfPTE31
         r4WXYYiyAoUX6shiSNvt+IMWhk3rBovoqO54cXtqnwRwJdaO0ArUWczDI2zWhHyNQ4a2
         fzTzd0wGiUFpYNGzMB2GuMjhkU0OPYwo1qSs57l3nI9NsPx/fbLOw1gcAQPh02fPt2A8
         OuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740671051; x=1741275851;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0tu0OuPvoFVrBKprqHcEcI8RHe9FTfvuOrdSb/S8xc=;
        b=Lk7JVoGw9UcqTK93oUstqVoxYuYgX8B8jlHmI6EUyEjnQDZl2qXXZuCKKLjJg0hP0G
         OhhW4qnzZcKAjMdXxek82/Se0o7L/396Z8P8kW9grdFdZH7foRcwUR7EKmCMfNcUHAb+
         yp39BcwCvyS2t52/Uw4EOkTakPfKWFU0iIvtCWDuhsmT89z/L9hWXwm4qUSkHOzWUoga
         NLcQJIzlAdLgBGWjDBTOjEpTC4vAGaLmF1s8uRfNPii1TpHvbLC6pXpX27tFaoi8K8W3
         H1RFm4jfrUJXVIjblrRoQnR/bTdIpjNmOX3dJczKoEtGf3oJMLffJ/OeqbbWCcNPIx+X
         hcNA==
X-Gm-Message-State: AOJu0Yyl9SsnJBLutRItOvJawZkXEONZbm12V6rI8GKh6EX4gEKWy22V
	nFJ3x/Z556ZpHqwiJ4SulXoel0tK0Y7mH2b2tTn/eTPeAkY0d3aJphz0vg==
X-Gm-Gg: ASbGncvWQeoVRzG1JYYbvxXFi6CXOCJz8Fgl9pElvSu+u7OvHKmxhHdQhgcYLNi/rKo
	Z9bljmOXU6HzTZIckD2hYiKOUxrwMNsGKYTyl+EAHzlq5gmO5JGyug3rsQc1SmtfsbJotSlAm5G
	wW3nr+M9hKLZQaUvW7bfpsz2BS5m6dgYaK63NZO3P3M2WDWy9E5nc6ku/286HOnQjtBd1HU9GAr
	qFoAbRRxsnZ63C7CJ4Iv0eY0BkpB3gj2T72+5wLn39bYNv8BJrbyjFuu5ZnA+K6sXtewp4wfyNC
	SxyXXzQUM5lpe91Yx760gEo7I94=
X-Google-Smtp-Source: AGHT+IEnk6p2NhFQr5LZsxAc7+Ld4lyIC3vuFVRqwOFkIMd1D03t8URFn/fw5OCL4sHDG/LIfnM/YA==
X-Received: by 2002:a05:600c:3151:b0:439:a1ef:c242 with SMTP id 5b1f17b1804b1-439ae18fdc1mr253808535e9.0.1740671050459;
        Thu, 27 Feb 2025 07:44:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27aa69sm26428055e9.29.2025.02.27.07.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:44:10 -0800 (PST)
Message-Id: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Feb 2025 15:44:07 +0000
Subject: [PATCH 0/2] Hot fixes from Git for Windows v2.49.0-rc0
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

I needed many patches to make Git for Windows v2.49.0-rc0 compile and run
the many, many CI jobs successfully. These here patches even apply to
upstream Git. (Technically, the Meson sorting patch is not required to
compile, but it was the fall-out from many required adjustments to make the
Meson jobs happy.)

Johannes Schindelin (2):
  ident: stop assuming that `gw_gecos` is writable
  meson: fix sorting

 ident.c     | 2 +-
 meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: b838bf1938926a7a900166136d995d86f8a00e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1867%2Fdscho%2Fg4w-hot-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1867/dscho/g4w-hot-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1867
-- 
gitgitgadget
