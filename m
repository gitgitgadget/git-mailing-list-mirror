Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55C20FA94
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046712; cv=none; b=sotim5UX9VxihBPXwIVPcOYawErKr1ZLj0ulvwel45LRUnAvumE8ztpDxp+GVveJdqdt4WYXtt6usPJ4TLxLZ3TKZQI4KrRDT+Pl+EXKpBLb3GxPV+gMSsZOs5lbIWrASp/QengdlPhsQ9u8n7+KW4FoUuteoSDjxaGBNa6Yg2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046712; c=relaxed/simple;
	bh=qofFs/7O3Rf2Q/4L2MW6nANcoH4mSQXPwgKq+SZoEdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n54S1b/t+grRDAT7qSogeysOOHkihdHzmp70w9Sy48i/c1SA5bQk2uQdhikdL83wIj7RcHgA5L2kx4kWw+J0HuLiv8rDCq86p3ESSmV665KfxOtVaodYOrSypPWERZlXuT4OBk/JcB5qD0UUL8IghUeU34Fp01z23VSPuQxXTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em8x+c1z; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em8x+c1z"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so100143666b.3
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046709; x=1744651509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ireolKcPSX/NzIRbLezAf1Ru+XoO6+Juy7poWStkFZk=;
        b=Em8x+c1zVgMyESdJbH3TZditjzdSyk74WNRCQLEAJbsIi/aLJnoX27CAHxG3186DgX
         Sz++TBXc7ujF/7yzidg62uikEXltafCxN5VA4gEY/exSuG2kh73oyzRJA7UkLGmXZhxD
         GvBxbuAEzlU0Zuk8+dLUCweX3oqpN4v4icUAK4Dq0iIAS1OnTJVJuKfIEJCLBdB/OZGL
         uKG08rAik7HO5XSz2zge8SfXKo8wBZYCG6SnGTx0ypzeu86St4KywIAXmbYj6zPuj+19
         uwd7MY5lB3/O2n1chfBSNMgrlWy6UZF134M9TVx+TCuUReM0zivOfyf7/hExyPSKBx4+
         tZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046709; x=1744651509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ireolKcPSX/NzIRbLezAf1Ru+XoO6+Juy7poWStkFZk=;
        b=nynaoB4lmMS15CJlt9SBtejGzJbr9rSMq2oQSTE+253KLeo3Qq2R9HyMwC2pCpip2V
         Aveht9ttgPnSU5FMLx+yeVpcdZ/hTdYDkiHdgpsTqub20T143c4lkUXtF4TM0YeIkHWJ
         UO9vB182MoPKN4B3xviCYyvMvkJ5yyOqD/3SaRVvhEubTTHmH4tg7IG4hwNqs/xQHc/Z
         aQxt11Y9C8UBa/2VNjlsA1iLHlWuuyIcrAl4aPKjehcSspWIu3xMy6TrEnGWQsFgKfr0
         diMmWGoxD6Tlb9TY4L4+ZlVwU6kSXlVQ+A9Qk8S8NOTfZQBvc7xhXCxWdyCA/+4a/2/3
         XQ3A==
X-Gm-Message-State: AOJu0Yw80pEjOaA5Gq9q1Ut/nXj51ISVWkDae6VOijR3WsOxiKdbUVZu
	sCYK7q2VnGF7vGwYGqwQThEtBhZi+a8L50peELp9MNMsJaaAk4M=
X-Gm-Gg: ASbGncsw8BYjlcNMJ5tc/lhKjKYpxQUwvwGoHNuAl3x3N/I5MNkIpVSXUR+aX9pxn8T
	tW5tZeOSRTC8yRkatIK8qmFznybodcc2tuVzD3GlXtA/K80BZ8ik+d8ZKtW85xDGWngwCnAh4D9
	yq++GEtayB9YMyIu3t6ozipPzeJDCV9gEPr9oJl2asAbT2IfIbYffOaVGszKfNqYJPaAax+quKt
	1TOVRG3bYvpuy28li+j0ozJQcDN69eSWFJKWB0bBF+iNf/b2ajZ7z/QdpC2sV3mi0u6I1rBAHdS
	BXRZp3mwJCM5WUk2UtyTGECVxRz8wQlYLCf59mdpUubpvKtFR2U5k0pncM29m9zcXk2NotGQ0D4
	4ti0aGyjewNsF
X-Google-Smtp-Source: AGHT+IFw0xrFQPztNpmfG30Np+UwDWiCMEjwZk6Md/GNxmmB/ia9aoRUg7+xlev1Ou4z0+d1gExQDA==
X-Received: by 2002:a17:907:3da4:b0:abf:67de:2f1f with SMTP id a640c23a62f3a-ac7d1bde11dmr1166024566b.44.1744046708992;
        Mon, 07 Apr 2025 10:25:08 -0700 (PDT)
Received: from localhost.localdomain (generic-nat.unisi.it. [193.205.5.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01c0fb1sm790193966b.179.2025.04.07.10.25.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 10:25:08 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	sunshine@sunshineco.com,
	Anthony Wang <anthonywang03@icloud.com>
Subject: [GSoC] [PATCH v3 0/3] t9811: Improve test coverage and clarity
Date: Mon,  7 Apr 2025 19:25:01 +0200
Message-Id: <20250407172504.50849-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250405103718.25160-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to expose more testing outputs, we remove the piping of `git tag` 
outputs in order to expose the exit codes. In addition, we remove `-q` 
tags on instances of `grep` to ensure clarity. We also replace `grep` 
with `test_grep` to provide helpful debug output in case of test failure.

--------------

changes in v3:
- patch #1 and #2 were missing my sign-off, which has now been added.
- patch #2 referenced a line number, which was not informative. A new 
  discription has been added referencing the context of the code.

changes in v2:
- patch #2 and #3 have been added to reduce confusion caused by the 
  implications of `grep` followed by `grep -q`, and increase debug 
  output.


 t/t9811-git-p4-label-import.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)

