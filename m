Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DB524CA
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777262; cv=none; b=hLWnfTeEn9wjduCc5FnsHOjVaKIs+fEbO4g6QIPEFmZxqbkVoCDX3josfuCurcd9M1LlEZrr42qPry4rPyQBthZaGNKh0pVUB45VZ1iytV27ttQrriSjtGMS1Tyvxd237mUNPmhJRMWI1xC8Sc07iIlHH+B5oLK5fnxkV2+9Gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777262; c=relaxed/simple;
	bh=1StjE7zjd17x/xpyPcdK24QDz8zI0hElvyrqAB5dM+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPPphuIHLlvAOkyEGclTSdSEtaxKiaZFkTvHc5RUcoe69TvoDdx+aTkhH5mmVT/P+TJJqPdMklFcLywFwbRGX12XboktIeX1cDm+j6UUr8JnuENVJTIn+ydnMN4jYOsIVS0l3r5TEwDWxhyK3xIrVvenM8hp8VLOtF39FwAjSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpiX0Lbz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpiX0Lbz"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce2aada130so3632246a12.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710777260; x=1711382060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VHFaU6fInccGEPLio2mNG7bIn7HT7iVlUI/xrzDK4E4=;
        b=OpiX0LbzzM4tGwM3k2nINjkNdAF3TRgE7VZRTnfCyvx0w8gbPdQPXEH4S2QWazUWrQ
         JfrSnr85L65Q5leHqaoEqn9+ivMGTTRowTRFN0PMAzkI295Ka9Fa3uyhWB7GWZY2qMD1
         gGpwbN7JResk+UT98NZVXsvvLnFFScigL+mDHoH4wASzUBSeGUUAcSQRHujdlhSHCWG+
         biYqYd5ku71shze1Bz5bY/EV7hsDPYScMNEnClr9+KaBr3k8EG8cR+DDDMsobbuT4rvt
         egYfhiJFVVGldur95f3HAc/PtFYtKQhLpy5qbpklCgkUqG+fH1dD9fWC+LzjxDi4dmao
         XZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710777260; x=1711382060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHFaU6fInccGEPLio2mNG7bIn7HT7iVlUI/xrzDK4E4=;
        b=liZLWQOT7Nwu8Vfht3qd6uRo6IscJYEZHqPWGGilXrbpILMVeJwM30IBFUHSjg9Kk0
         2Xzf3exlrVTHQDdHXAPCELGqcO05tA/tI0LjqouQs3kcYKmmWptmKKZy51Blod6hkTa+
         qEz4LXs8o23Z+lPgeF+Uv59JVMwMx0CyX1WGwtFka7dD6Xt2cCbaHMOQSt7Om/IFEMAo
         tO9eAe3n8NgcPundc87aNjej9fCRhQQTWzRBlgQaw7Blc5nF04OAbPh24A6wu8qYUqa+
         hujxluOrfxLWiSXBoVZ7ts8q40mrQI3WG8r+pCOUz2pu9uZ1sKduPUhKC7S0eN7oSEfB
         WtZw==
X-Gm-Message-State: AOJu0YzTSsh8Lopr9rLS2ArbaAfY1p4M1wg8olSOpQkPQRw7L66WBWst
	obK1eAFPcGDcJABmqOD0clJu7bfy57A377x/LEaX8FrA/3CFdLHlw0Oga8J0
X-Google-Smtp-Source: AGHT+IEgbQ+G8+dcOiqGG/NgR4+DMElo72llPKeHNpk9FDChFjVomCQoijve2di8l074EEFRwiXNLw==
X-Received: by 2002:a17:90b:101:b0:29b:260f:676 with SMTP id p1-20020a17090b010100b0029b260f0676mr9007896pjz.46.1710777259657;
        Mon, 18 Mar 2024 08:54:19 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id gd1-20020a17090b0fc100b0029beec8e86csm7844922pjb.36.2024.03.18.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:54:19 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH 0/2] fix certain cases of add and commit with untracked path not erroring out
Date: Mon, 18 Mar 2024 21:21:57 +0530
Message-ID: <20240318155219.494206-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While adding tests for 'commit --include', I accidentally reproduced a
potential bug where in we do not error out when passing a pathspec which
does not match any tracked path. This was noticed by Junio while
reviewing[1]. This patch series fixes that and a similar case in 'add
--update'.

[1]: https://lore.kernel.org/git/xmqqil41avcc.fsf@gitster.g/

Ghanshyam Thakkar (2):
  builtin/commit: error out when passing untracked path with -i
  builtin/add: error out when passing untracked path with -u

 builtin/add.c                            | 16 ++++++++++++++++
 builtin/commit.c                         | 15 +++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh |  4 ----
 t/t2200-add-update.sh                    |  5 +++++
 t/t7501-commit-basic-functionality.sh    | 16 +---------------
 5 files changed, 37 insertions(+), 19 deletions(-)

-- 
2.44.0

