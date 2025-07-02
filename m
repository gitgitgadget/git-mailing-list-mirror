Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBE2DE6EC
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487708; cv=none; b=db4ZyGJrIrLFaOcxrI5XXo5PwjPJ3UkLrjOxN9opA6OfZtOoiTtrBugGoJNeP3kJkurMPj84/GedB0gtL1SElA5db1zcbWL95dcIcPKu4Bf/WjmpHsiKeS3fXP0UB3ouoYKfonZB9wVDkeyHTNZ9rMWbDmA8KugGnVPNiTHSnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487708; c=relaxed/simple;
	bh=rfHg4JakWng3DMFXouLfwoLdi4F+FP/dT5Wk6Y7vTKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=envNtJHa4UgOCtj1w33jE9lTKQkxVTF12gmF4RXhlI9aWzUgOAhGWRye4kHAEW0hcFdAAGG3kgRFzjPXS9ham2YvCKwcnf66AM8MqORlLcxUOMANUN6luc4WkheBF76ILj1+SwfG86ucE8JlYFoJhCuyRLww2ijoh7ToC65XCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/syfawz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/syfawz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e1d710d8so87157945ad.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487705; x=1752092505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvBf/+oqc5Z5h01c/BqwN4BMyFW/95kYyC0vKfjlfFg=;
        b=j/syfawzYJT7PnFPTBSqW3pxLHS7NOMF85eL/384p+MB9OMHwYekqj480ciRPGkOfu
         Dids5N5EvOaVZA9nQqHbasmdVNpfNoOd312jaWjE8jQHscGXTsQy6PovZPIx3ymPHgoN
         dCkc9rauJzvDVeJCQHokpH7EXI2u3nRA5u5ERVLOk3FvSvDGciSVTdic52jLaEQdnArO
         y59DMaUzyTFaU7TfJ9buuB2xHxSmLs82LMs/hxqkiXgf+mV2C0mKGyZeocJst8ysgHlU
         t3VAYhbR9DR8JTKf1mkuEM9R/sGlR/T59LMRvoLuj+jdY7+3L2ChPA3d3q+mIV4P+pGY
         wCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487705; x=1752092505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvBf/+oqc5Z5h01c/BqwN4BMyFW/95kYyC0vKfjlfFg=;
        b=vA6WYJYb88Tv3bc15NWgkUE1vyKOuEKoKl0PQXwSWFetWpXfW5xUvQi7ISv3QXH0hV
         dMPumojt4CjRMBpSNBa+1SSeJl72XtYqhM9Mt3LDOAUu6alCde20I/tnmuA39vGVxIdS
         QB/79WYVtQum94vVlcLuw04gZZjEXXWYzS0hIfhOI4CP2+b47H2xddVdMQFIROqm9daJ
         zbiEU5NJEF6Rw+6EwwF4No/RGGu4764gQ7w2BCl0Qyn5xlU5jS/3aVBAQPiEhLQHVczN
         3DICuDxaOp8bGIdeew0fXUe5Ox456hrB1t+j5L99Z8xkgSQ0TKH5oV6fcuH6B7XQ40YY
         4M1g==
X-Gm-Message-State: AOJu0Yxw3+04kJaf80s1EwvQk19Wivd0Fw4wfn1V0iwTVHpxBj4MH8LB
	GfesTvTqY34w7fIAiQLN9IOVl49TNiok23kD1XIFO6bOExpH9kuOX6/G29rbDw==
X-Gm-Gg: ASbGncutno1sg52Yal7q2ygVMHt8QouTzsUEbNWX7NDlHV6+58h/1jcGYBBjIOStTJz
	AcwG03AHa2luKt4RuLPT0sfWrejd1XYorbsuiutyU76KXlaT8Ax9zH2DDRlEQEawYh2ZoPFIqFw
	e1VlhjFo3U+fKGUihisPZ+pdhAOt8xRqXG551kPoVYNlbzIMuHsOKBRC15sZb5QQKsS2CCx1X0w
	Yyks1LyTYcEzGcLQa7y3eglgyouSDbarnqhyjnGDw4n38aoWK1/FkJeMTpybBk7VD2Mg6eBH528
	QKDiM4t+bbvXtHM0iQMkE+qAiahxaHLIkkgeQzN0Ken3OYvpm3+TQ1itytkRVePFv+BN38Fu+Yj
	9gxtqHTeDPsy0genn
X-Google-Smtp-Source: AGHT+IGz40+rpiP9DeB+F5F+8jOee8E0Zt6xcz7mBnWTyxqOOm3tkVRndB0XwmctzgmuTpESYMuhhA==
X-Received: by 2002:a17:903:4b43:b0:236:7079:fafd with SMTP id d9443c01a7336-23c6e5b7737mr73374365ad.36.1751487705439;
        Wed, 02 Jul 2025 13:21:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:8123:5123:76e8:a897])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3d11b4sm138281945ad.254.2025.07.02.13.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:21:45 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: brad@comstyle.com,
	collin.funk1@gmail.com,
	pclouds@gmail.com,
	ps@pks.im,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v3] builtin/gc: correct total_ram calculation with HAVE_BSD_SYSCTL
Date: Wed,  2 Jul 2025 13:21:18 -0700
Message-ID: <20250702202118.48742-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.145.g83014dc05f.dirty
In-Reply-To: <20250702154649.44210-1-carenas@gmail.com>
References: <20250702154649.44210-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The calls to sysctl() assume an 64-bit memory size, but the actual
size depends on the key name and platform, at least for HW_PHYSMEM.

Detect any mismatched reads, and make sure that any non used bytes
are correctly discarded before returning.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/gc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 845876ff02..c2f248052c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -539,7 +539,7 @@ static uint64_t total_ram(void)
 		return total;
 	}
 #elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM) || defined(HW_PHYSMEM64))
-	int64_t physical_memory;
+	uint64_t physical_memory;
 	int mib[2];
 	size_t length;
 
@@ -551,9 +551,16 @@ static uint64_t total_ram(void)
 # else
 	mib[1] = HW_PHYSMEM;
 # endif
-	length = sizeof(int64_t);
-	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
+	length = sizeof(physical_memory);
+	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0)) {
+		if (length < sizeof(physical_memory)) {
+			unsigned bits = (sizeof(physical_memory) - length) * 8;
+
+			physical_memory <<= bits;
+			physical_memory >>= bits;
+		}
 		return physical_memory;
+	}
 #elif defined(GIT_WINDOWS_NATIVE)
 	MEMORYSTATUSEX memInfo;
 
-- 
2.50.0.145.g83014dc05f.dirty

