Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F223093BB
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467379; cv=none; b=ZcRtDIS9BPWWx/Owt/pv974nZC+iPEeBBIq+jTMaGbXMZwRXblI/SSG75i/3c+KYjKjleAJeWmHzqquhGKtMqynJCPpZ7vLncJUIt6F7frW9jHLYZ2HCmkLjX+xuD50KWv40UXojtmo6+rkNZfyWOtWHeHFJX/P6Cu3NA9obUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467379; c=relaxed/simple;
	bh=ahIo9iMeD3Q0NBLT36p+B09xUudlajyn7QqmPHOlL1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMiYdmSBOABKDbNqmMhgkx2L6EEG4LBTNeAWaUouDFbP4ChFU6KXBo5O1Lo3Dfo53aEeba9M0bRotBwOvMN+4LN1vt760HViowUJ1prLCK8ilQWwTOGQfkytPKJC62bnx79vB6k5cDJgX+oUQzx8Y0+Tns41X92i+1RJwSp+o9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhOZ4JY7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhOZ4JY7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748feca4a61so2619858b3a.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751467376; x=1752072176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjrBiEbRcfiSdrZEJRnhgeL9rHOS3XH+ewXY/El6S4E=;
        b=EhOZ4JY7Kz0GruAtP8CiC81Z66m89zoxzvnv2w9+uo/2ty5llHtypEGZJFSOf1vuIj
         qonjpfaDUYpfobQzi3gV3GG4dY03ok7qXcZnvTZDN10xnTrff71+yvAIjLnBfh8P6+PG
         MBReGu9JwDs4XPH9vDv6FQEPF0jqYiobovKjLJQFXk8YoURbLvO9W7PwOSsYSzwZulfY
         SIElp4qPrliUnPBAiWzv6CPYyAoF+OaJnT1bp2a7Vgx3aZkWwZvVg6dOhc+ntALFt0Ab
         mTnfQdIHhBxUq0NbXmoAqrZyxGtr91GZh1P8tVHKvtPon3IJnfrb0Kq4dKswo7SNuiv5
         nHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751467376; x=1752072176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjrBiEbRcfiSdrZEJRnhgeL9rHOS3XH+ewXY/El6S4E=;
        b=LF+4J21gLctpG/r0/YeDD9JN8Ew4bqk20t0usX1kwvKzS9Ni9U5XWAGAQPDzZKuZnC
         dh0f9OEsYLxsS59ng1qhj4gzJCisiQgrRSiB5/+eAdeImfFMCtrvu+8fKBH9vTWZtlXj
         WBXYs18+CxYlQm1DZMkn7m8tkfbaEd3+mGbEj9SdVGTkg9uDFXqei43WdcY9pQvnkqGy
         pCz5E5M0UGX08djooTFFbuw2rqHXFJXqvCg8H6tqqQJY9bFoq3j2a0VXlBuM8lrNqemE
         c30yRQjS78TP+r8JGpbHaNZ8G1hk6rh1O5/SI4AVYTQPoR2Z0UlTyRoMy21BmhVc2tfH
         M5mg==
X-Gm-Message-State: AOJu0YzFea35t0u4y5kJIx6ZKrR+uJZl01tmGPWKZGcq17JJxrwe3IXw
	2wn5gZj2XiFjuUETZQhw5b4QdgHAN0aU8yBtoxo3wusqqjc5w10ps9Y7a5mHiQ==
X-Gm-Gg: ASbGncsEAJIOrW3ii1SsHVhUr9LaFOVSRFvMg95deWtjpVOINUjEOEr47IEoyT9qcpk
	ssy9OK4P/qqA//6XvqJgkcIx60yU68OMpLPhqLKudku8kPMuuPWvuvJHe8aTtL+EiBGCyqsx1FM
	WAm94OOURLzbq5+2695gk5oeCYSua4tvXXL6+CaUVnf6y5bTjrug397n8Iv8WWggxPmI1mg9C68
	Mqxx+JgibnNmKyOMsGqP5Pq0BOWFvFYY+CVXWlGYtyHaGETnW3ECP+Ddqy6/qeBEz5uDjtLLrhO
	tTlbNqdsp0rR/VzrhTL3FG0QOhtfJQ0EliV9F+GK7usPtY9v9OkhGSaVAAgGqp+0XPOk1qrpuO2
	X0Br9hlk9eW4b/syg
X-Google-Smtp-Source: AGHT+IGmn6mg7cd1Ws0ecnshucTgKxp+0i2xuWYySNheZiwxM9nVFLd+z1Ajrwsgby4zfAiQyf4hMg==
X-Received: by 2002:a05:6a00:14cb:b0:748:e9e4:d970 with SMTP id d2e1a72fcca58-74b50ff200fmr4295475b3a.1.1751467376402;
        Wed, 02 Jul 2025 07:42:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:8123:5123:76e8:a897])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af558914dsm15429752b3a.78.2025.07.02.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:42:55 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: pclouds@gmail.com,
	brad@comstyle.com,
	collin.funk1@gmail.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] builtin/gc: improve total_ram calculation for HAVE_BSD_SYSCTL
Date: Wed,  2 Jul 2025 07:42:44 -0700
Message-ID: <20250702144244.43858-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.147.gafe0d4ec5b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In BSD systems other than macOS, since 9806f5a7bf (gc --auto:
exclude base pack if not enough mem to "repack -ad", 2018-04-15),
sysctl() use HW_PHYSMEM with the wrong size for the target.

Use the correct type for physical_memory on each option and make
sure it is initialized, so it is safe to use even if sysctl() fails.

While at it, add a cast to the returned value for consistency.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/gc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 845876ff02..3b2ca99af9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -539,21 +539,25 @@ static uint64_t total_ram(void)
 		return total;
 	}
 #elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM) || defined(HW_PHYSMEM64))
-	int64_t physical_memory;
 	int mib[2];
 	size_t length;
-
-	mib[0] = CTL_HW;
 # if defined(HW_MEMSIZE)
+	int64_t physical_memory = 0;
+
 	mib[1] = HW_MEMSIZE;
 # elif defined(HW_PHYSMEM64)
+	int64_t physical_memory = 0;
+
 	mib[1] = HW_PHYSMEM64;
 # else
+	int physical_memory = 0;
+
 	mib[1] = HW_PHYSMEM;
 # endif
-	length = sizeof(int64_t);
+	mib[0] = CTL_HW;
+	length = sizeof(physical_memory);
 	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
-		return physical_memory;
+		return (uint64_t)physical_memory;
 #elif defined(GIT_WINDOWS_NATIVE)
 	MEMORYSTATUSEX memInfo;
 
-- 
2.50.0.147.gafe0d4ec5b

