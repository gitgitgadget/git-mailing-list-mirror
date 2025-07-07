Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31523CB
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906744; cv=none; b=X4IyOcZHTMFftdQSuo9cbtHN2NYvgx95NOLP1JoIs38MR3hhsejgZOjE0rXCk91HoXLUorSTNSjeKd0nCIENvoykAKus5UzZ6b7RnGp5q7zPGP51kPZuxicDyoz/obcY9M55UhpSgGXUOx/dL73VIH4FA/EWqsw7VRTYNy6i5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906744; c=relaxed/simple;
	bh=D6H6iAIwlPYRbH6d/46vUVyREpMMsw2lnmLbqSxB5vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeJNrO/6jXJ5ws6eT4XKWwOJ7r2AYNkeXUD8x6Rz5VutU6fEUVbVu+Z6IQUza9m5TKNfdl5iSit+d8e4kk4/n/kcdQZdI4HCbrZHkpUlYzV4XMnm6LrRzt6jMBsfTq42CFXsk7/pJSJmOpJgBDWjl9Te7CH+JYzQM2vBCPqSqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLwjvheU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLwjvheU"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso4079374b3a.2
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906742; x=1752511542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5fRevnfn3Dk9c2UzqFM3YfgxoDdBWEQtHWlyvir3q0=;
        b=KLwjvheUyIM175sqHDHjgHuOr/rcQv7stGSGnOdepih4CMilDeK+M176WzIFZCJseg
         wdAFSAE5Tg5541aSDB0kUy7IqHHssJJw+Ff4k65+ul9bi6JXDfsgmgN5h+v/3PYEWB7R
         KSqnSoSciTn/XWIQ/8tJzAGVLjGA2JjuLCuh9XXOViX2wsm7WW0whKKAPN4f6tYyUy3I
         lEo6GkvGEMq+ZHPEY0OTPejTgA1YTRh7BDvit47oTbAdHKl5cSg5yRDJNVRPyI0pyMt2
         U8999n7keqZA+JQaigxG6Wqp5dXzOQ77KDCXSxq6DFKFkpRSUJdEPa+z5eHqdNOyR3iU
         pnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906742; x=1752511542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5fRevnfn3Dk9c2UzqFM3YfgxoDdBWEQtHWlyvir3q0=;
        b=rc277cvGXvHUw1SUAwz4QLavEBYH4p99jlAetNg4FrAPkdR05DTjBGXUmhZUH2YzfF
         Mrlkb9LQo2aLvLkWWpvivMHXg2ZfmNpnT1LWwYFXT/jNimyyuRep0ksLF7dVQB0M2R8w
         BFzUoTSNmUMlS2QRkhH22/QF8Rki4XGbrXWGo6bPRj7p22iYsl1O9NXh0R82mwpTjMsK
         K55GGQiU2pYDsatBEREAwaJlPLU6gkWkP+Yrkmu5HqeSVYeNW2zkMMLDIrUy8+00lCEc
         BUx2gkCAH9Gj2DBjIVn01O9RNTmG/OhJc9lkR66SEGBhcrLN/19nM7kiV+TS5gyqk7T6
         Fw9A==
X-Gm-Message-State: AOJu0Yyo7xnxag16Agu0UfJtxgEwPnFhQSsNLLeJ0ApU8WROW3MSXL/1
	suToAyI2BlAriOuPOCrw5Ja9wXhu50j7DkNRJN9nVLgSA+irYOAvRzh4XC24Tw==
X-Gm-Gg: ASbGncv+NdFBCwPr1k48lmIaRvf+geENSeQLDLJfLPV3QZGJuq/d3yveX9nyNAbrvuN
	buT0phqRAOdJF10x9IlpWrQ028vK08fVQJRdXZcrB2w+yCo/tcJwewXm4fyhCiMqelL30Uwy/Y4
	McgHEV4eH0qvkkGeMrDzvZoXrsmZlDH5nBGLLLgfUqkYg4+aoZJZktVk2Sxg9js30pdREL+fM+c
	LDR0ngAxqJaSsv+NmknCCDdKsLDaW7AY1SGbEGWTSI18xLtpcQqxLslo1gbZjyPstCWHczHdYml
	K9vxIzYz3Dyj3nTmrccs6oB42/Ih35fauP9rIbVDOyPgXHPKdhqK9sBBp9UzNzx6+sKztZAdO1g
	LfpeSatWDF2Va
X-Google-Smtp-Source: AGHT+IHF8x+7ghTTkRiZctf/HpwdZQtaA3dTMcZUd+FaI5jl/CJtQ7J0WEmpMhB/WvpTBaQAwiTZDw==
X-Received: by 2002:a05:6a00:178a:b0:748:de24:1ade with SMTP id d2e1a72fcca58-74ce65aef02mr18779051b3a.7.1751906741601;
        Mon, 07 Jul 2025 09:45:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:151b:4ec:76e5:19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417de3esm9465444b3a.86.2025.07.07.09.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:45:41 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: brad@comstyle.com,
	collin.funk1@gmail.com,
	gitster@pobox.com,
	pclouds@gmail.com,
	ps@pks.im,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v5] builtin/gc: correct total_ram calculation with HAVE_BSD_SYSCTL
Date: Mon,  7 Jul 2025 09:45:18 -0700
Message-ID: <20250707164518.6600-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.90591.ge5deae765f.dirty
In-Reply-To: <20250703080111.64276-1-carenas@gmail.com>
References: <20250703080111.64276-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The calls to sysctl() assume a 64-bit memory size for the variable
holding the value, but the actual size depends on the key name and
platform, at least for HW_PHYSMEM.

Detect any mismatched reads, and retry with a shorter variable
when needed.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/gc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 7dc94f243d..6880f5b13d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -517,7 +517,7 @@ static uint64_t total_ram(void)
 		return total;
 	}
 #elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM) || defined(HW_PHYSMEM64))
-	int64_t physical_memory;
+	uint64_t physical_memory;
 	int mib[2];
 	size_t length;
 
@@ -529,9 +529,16 @@ static uint64_t total_ram(void)
 # else
 	mib[1] = HW_PHYSMEM;
 # endif
-	length = sizeof(int64_t);
-	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
+	length = sizeof(physical_memory);
+	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0)) {
+		if (length == 4) {
+			uint32_t mem;
+
+			if (!sysctl(mib, 2, &mem, &length, NULL, 0))
+				physical_memory = mem;
+		}
 		return physical_memory;
+	}
 #elif defined(GIT_WINDOWS_NATIVE)
 	MEMORYSTATUSEX memInfo;
 
-- 
2.50.0.90591.ge5deae765f.dirty

