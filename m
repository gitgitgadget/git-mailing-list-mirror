Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111F28CF40
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030104; cv=none; b=bYhbxM/sYWbeBNeHRFR+IpmwjiAyJGU4bYLAa8UxV6u0KffaFy0QZZSghojJyMm2sKVOCuhzAhSj41X2VOHBjcs4CVS58VdwR4Baazx4fBxohjBQNMx4R5Vs/WtGFll3zALFoO7HWKwyKR0pPsUZakG7IpnPvK3NQnV46T/pA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030104; c=relaxed/simple;
	bh=kBnj7VslKC09qGF8AHER/pKLvlkGgv1B5ZqDAvHtm7w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PVPd6dywuob2sNvrAb/zobZOuvh3ThxWC1Ve0UHV1e0anHauFeE6Dn6N/7Yzc46Or+bnbipL6UuZpXWI7GAX5ADbClBBXjQzgDbNCyM2TqSXonwgAgrjFNDLYMi2qQ8tZo9DCglrPsy0mA8IUyFV7dDkWAOj6kUseeb8aEj7UmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2aCxiiJ; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2aCxiiJ"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e4564178bcso569650137.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 02:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749030102; x=1749634902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7m2YBQEig+fSCIXIgY72TRaXdWUMP1lxmTLmCPZEGTA=;
        b=e2aCxiiJWjcT8f6ZuxAZ82fzAcrDyYP6SZBYfSXMmNIanmmZ6UxtqtAj9NDUsVKK3o
         jDZEGsJt+418Hf9XQvCAijz12CrRzL2NZQvbKu+/hzWhKoHT/RIN4RiqOV2EAfw5uiRm
         8FxFccYJPSx6s/vJHunXXWzk+z5GxMgXewZ+pA3K1Do3IKGaq9fnv57gh3WxGmZL9FbL
         I+p5ifuOupZv6JLcCzj4D12iAv4Qp12zmYSdI0tLvsort3lc3gk/85T2kRwLCF+P5e2R
         hP48B6N1dfZpKHKvI+U0jdNvz94ezEDuKHMtSSCY6erB7Tbup0f9etevG3S6PremheOB
         Zbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749030102; x=1749634902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7m2YBQEig+fSCIXIgY72TRaXdWUMP1lxmTLmCPZEGTA=;
        b=gCD7GZLdquzHSMr3Osl7q08GvKUrZ46A8knWnkKLg4hNea4xfKzdA95RchVe8zN2s3
         rrqLFHJ+NCJb5qbxlaXCAh23KwMBAr8b+2ApzTm22/MA6QcVcTMhudktrSWlxuLADTM7
         3RkJyoJaLvR2fJZX/0iNzUl7Y3Inz6eMgzrOav7Sa+uMnI+taPA2E2XaTrsZp/C0zUPy
         i13nvAZqj4HUF4yFnkP+PnR6EiOtjI+1BxchvHzaEJNFXYbNNPXMYBi2/cIGUyyi/lV0
         B4KkdBRjcXQ4BMwbBZ5jF8Dvu/fBoMcCYOIxdAG7/6cjYcPdIRuVE7IXmTh1rRGCkBPf
         w4UQ==
X-Gm-Message-State: AOJu0YxtYF4J9iMWfBX/6Tj714uIvMwhJy/XI5mTtbxv8CGX40ycH4rZ
	aHg2GBZqd44XD16h5VDiqMgdUskbIplru/zxagOk4fJyKQDdA9+UBB7sbfMNtQ==
X-Gm-Gg: ASbGnctUIN0uGcfzEMem9Ggj7ZrenBLhY74XnnGyzLX8YHZc9e7w2r3w0FoiREVVYHj
	R5/MobYt6Saqe5chn2C1CZqXGyPONKQsKoad/BeoRwqloubBO7Akiz9yY0NKqSyJbTTI+6Jh3WS
	wqCB+vXZd+6Ij+BCJvL+niSBi2QlVTeiqE9SDnVpbMgUos6n3gXHc3Mdzz9h9sRLAJ4Mv2mGnO3
	8+PD/DdRd11zYp52Cs2XqjJGO+A/OFan+f4Hr5f7B/PmMVRy3Sv4GGQJGTwPYXNZ5So4zbj1cvl
	XzTz97mEmc2ICF1aSF4qObHyBlqkoxsLJXsNGYD8IiTZYOVarBRBhFWzsz0TJAo=
X-Google-Smtp-Source: AGHT+IGsQaNA65gRNPccHL7L2gbT0VW6NVsmQKWmjajbTzLTBnMkubYqvwhX8ygTw+56LE/nJKybhA==
X-Received: by 2002:a05:6102:b08:b0:4df:9aed:3114 with SMTP id ada2fe7eead31-4e73612362amr4803856137.8.1749030101781;
        Wed, 04 Jun 2025 02:41:41 -0700 (PDT)
Received: from dwmfdoom ([177.33.100.243])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e64e9f8d5asm9905473137.28.2025.06.04.02.41.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:41:41 -0700 (PDT)
From: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
To: git@vger.kernel.org
Subject: [GSoC PATCH 0/1] userdiff: add javascript diff driver 
Date: Wed,  4 Jun 2025 06:35:45 -0300
Message-ID: <20250604094100.80598-1-derick.william.moraes@gmail.com>
X-Mailer: git-send-email 2.50.0.rc0.62.g658f0ae201.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, I'm Derick and this is one of my first contributions. I'm a CS
undergrad student and I'm really excited to start learning more about
Git's internals.

As it is in 2025, javascript is amongst the most prevalent programming
languages and yet it it not beeing supported by a diff driver in Git.
I do believe that the addition of this functionality is a good
contribution that will benefit tons of developers that work with
javascript.

For me, it was a surprise to discover that javascript isn't supported
yet, so the first thing that came to mind was if someone had already
tried to work on the problem. Searching at Git's lore, I found some
previous atempts at tacking it and I tried to learn from them and to 
guide my work along what I believe were good paths taken.

The pattern I added to userdiff.c to recognize functions groups them in
some categories, that are: conventional functions (Those that are
declared in outer scope, and not assigned to any variable), assigned
functions (those that ARE assigned to a variable), arrow functions and
functions declared inside classes or objects.

For js literals, the regex matches valid alphanumerical literals that
are valid in javascript. It also matches numerical literals in binary,
octal, decimal and hexadecimal bases, and punctuations.

I also added test cases for instances of function declarations.

I tried to keep things simple, my idea is to make it work well while
thinking 'vanilla' javascript-first. I'm quite sure the contribution
still can be improved so I'm looking foward for feedback on what is
important/interesting to be made.

Derick W. de M. Frias (1):
  userdiff: add javascript diff driver

 .../javascript-anonymous-function-assigned    |  4 +++
 t/t4018/javascript-arrow-function-assigned    |  4 +++
 t/t4018/javascript-arrow-function-assigned-2  |  1 +
 t/t4018/javascript-async-function             |  4 +++
 t/t4018/javascript-async-function-assigned    |  4 +++
 t/t4018/javascript-class-function             |  6 ++++
 t/t4018/javascript-function                   |  4 +++
 t/t4018/javascript-function-assigned          |  4 +++
 t/t4018/javascript-generator-function         |  5 ++++
 t/t4018/javascript-generator-function-2       |  5 ++++
 .../javascript-generator-function-assigned    |  5 ++++
 .../javascript-generator-function-assigned-2  |  5 ++++
 t/t4018/javascript-method-function            |  6 ++++
 userdiff.c                                    | 28 +++++++++++++++++++
 14 files changed, 85 insertions(+)
 create mode 100644 t/t4018/javascript-anonymous-function-assigned
 create mode 100644 t/t4018/javascript-arrow-function-assigned
 create mode 100644 t/t4018/javascript-arrow-function-assigned-2
 create mode 100644 t/t4018/javascript-async-function
 create mode 100644 t/t4018/javascript-async-function-assigned
 create mode 100644 t/t4018/javascript-class-function
 create mode 100644 t/t4018/javascript-function
 create mode 100644 t/t4018/javascript-function-assigned
 create mode 100644 t/t4018/javascript-generator-function
 create mode 100644 t/t4018/javascript-generator-function-2
 create mode 100644 t/t4018/javascript-generator-function-assigned
 create mode 100644 t/t4018/javascript-generator-function-assigned-2
 create mode 100644 t/t4018/javascript-method-function

-- 
2.50.0.rc0.62.g658f0ae201.dirty

