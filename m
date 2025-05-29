Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476121171D
	for <git@vger.kernel.org>; Thu, 29 May 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748513529; cv=none; b=EBiy7GyWunbj6n9uTnN+M6r4bBUMGTDuj0hmCVD7p3/jJc/j47aRqeOFUAcANjRrc7kNETddCIWUIMNc4LOGerlJNo4oampalisamUU6stITpcfsq8LCRMl/2cM+8KPDrPDg02x7VELzMAm8GqXgouht1tGtxj7PGIHw7kE86pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748513529; c=relaxed/simple;
	bh=OH0JbiJAy8lG+5i2/Skf1Cc4qHPi1bq2UKrx3q1VIRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuAPn5X0IkjljzWK2sFsPVPNwi8KCP5ko9l9aLlJVvmrXsU405gPyfabEpfV+tiMXbxtCRHUsfHFIpAtuYr0x8FY0kyI29FSYleaHM4ehpYA+LyItel2kNCxessW+Jno7XLx9buTzRj2T0Wn1ezYs7xEsvQkggAgB32MdEWkkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8F5/qGn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8F5/qGn"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-232059c0b50so7048535ad.2
        for <git@vger.kernel.org>; Thu, 29 May 2025 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748513527; x=1749118327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWzR7KUSwJbDNCT3Kl9HCkQgr0ivUKWnwUbVVJf0wok=;
        b=L8F5/qGnMhFoJg4QD3nfiYMMNPOHc/LReVyGnuzD6ZdPO8ZKpN2uQ6yqXRyfpJmuAk
         p/ZnG9/ZYxuml2ULP155qN1LX67ubVAH5vXHOp0L4Vv1FnG8PAa7Y/6D44cYqTLbLJ2V
         xMRJEAq8a3pvOopJ3+XR17avX/UhQOrfi559253w3oOHSsllq9tcOrlWgmKUOyQ9SQK3
         q6CQJgXhsn3IFmQpu6i5VJEU42tH2gKpnKFwlJrK+3o7/lFTPXNbB/RZTrgrSpOh95Fc
         v3pVuuBnDOIT49OVEoynjjM9pMcTIxhPtICQju/IIbO2SdXNXW2dgwMbb8+yZ9PoTsRY
         di9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748513527; x=1749118327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWzR7KUSwJbDNCT3Kl9HCkQgr0ivUKWnwUbVVJf0wok=;
        b=d8hcFHbiK8V0CUyMa0hg6dMnHPi0FiZdA0qNvt2zz1ar16WzXHPfbT8cJzC2zAY8V4
         jTk+vARuDt6Blvsjb3vMBciGoCrUNoJUq+k43C6zQIXcHd3TnpR9mfaejZSWofN+pn6H
         kmIjjA4LvN6/O/dd8WJ5x0ukBWSskf2IMPwAEH/VRY1zke/apioDgkfHWIiNmVZhpuVk
         bI9UACmx0DiUhIPgTqisiSg3kZ97IKcblEMj5R7XzIdt9WdWQpA650pIrzrcDG6bdDAp
         c3A3mrmrFtFPL40UJCqYaJWTWDAyX251EPvNXPeQ3mrd0ZufGeJVjTNNFgGmsnsWoIuJ
         i/6g==
X-Gm-Message-State: AOJu0Yz6C8uZhegP2Cry1Fo6jl0Bt2Ar2xrdfoPskdEKppR0HG1aUhmU
	lmfcL4TMW7SGSUWJ6Imqcd9F4MY3apKe0k6kQhJTySE4f6lRNUF7JIXSdquizg==
X-Gm-Gg: ASbGncvxhaJi4dM9ZmQo7XCQqPoO5xe7bG1E+Q8HA01KFhdsaY2ZaNeRoCAOIah0e5x
	d5RW/Yf9NNvAh1hzqZePTi8iKKg2+cuOoP+I8sS7XBUZiOHR79wKI3GYwPzybcWCBo1d4WomZ0X
	fxeGOgAeHbJPmY2SyEwp8T8dNh1ypSz7TBcMVb+M5gsRDLfhltz77N7T0YxAg1Lr9EtPgLcwm7C
	sYmt1Zz0VxjbcDyeQIAKczU/RUHTrWey+KN2pRJQw+SI8ktvZ92mrwmlqdJTb8/epibyif5pqt9
	KCEaIJGB9XuAdQMy0BjtUDuL2KdQtXUAxY3+/84M9KIYETAVVHgPvOxkK77L2ehRnNcE+mBp9wo
	2FqoNCYR/PfgSqG74
X-Google-Smtp-Source: AGHT+IGU4Xvnv79MnCWuxZGbVCWrFpM1TKgz2jpE9DcFQZJuUgmH1tOo5Zz3Rskbl6tAFUTdcbaC6g==
X-Received: by 2002:a17:902:e888:b0:235:1962:1c13 with SMTP id d9443c01a7336-23519621cefmr5801175ad.14.1748513526935;
        Thu, 29 May 2025 03:12:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:69ab:ad83:5133:4bd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bca106sm9273645ad.32.2025.05.29.03.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 03:12:06 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH] reftable: make REFTABLE_UNUSED C99 compatible
Date: Thu, 29 May 2025 03:11:36 -0700
Message-Id: <20250529101136.16219-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since f93b2a0424 (reftable/basics: introduce `REFTABLE_UNUSED`
annotation, 2025-02-18), the reftable library was migrated to
use an internal version of `UNUSED`, which unconditionally sets
a GNU __attribute__ to avoid warnings function parameters that
are not being used.

Make the definition conditional to prevent breaking the build
with non GNU compilers.

Reported-by: "Randall S. Becker" <rsbecker@nexbridge.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/basics.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/reftable/basics.h b/reftable/basics.h
index d8888c1262..7d22f96261 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -16,7 +16,11 @@
 #include "system.h"
 #include "reftable-basics.h"
 
+#ifdef __GNUC__
 #define REFTABLE_UNUSED __attribute__((__unused__))
+#else
+#define REFTABLE_UNUSED
+#endif
 
 /*
  * Initialize the buffer such that it is ready for use. This is equivalent to
-- 
2.50.0.rc0.1.gb4243b6ac8

