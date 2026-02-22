Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34BE1E511
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720877; cv=none; b=rNy2CXxXg2yMDPBktaoiikQnC+RKIvro4eQyZsBifnK4UDxf2VBQxr6A2J/yt6dSx36bU5X8TL/NECLChEFGfPAnpJGVcnUq7w+oha5d298E4FlZxz3vPd5LEYQQjZtLw4dHpKepNimEfrY14dSzImyZJNuQXH53N3hdXLNJczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720877; c=relaxed/simple;
	bh=dHNWnJB3I+wOYtv4hT2EbmcotUbC540zTD22/2MEXXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gutbc+MGZDREEpdThCHe76TMMsESsJgH7p01v9CSK2IDkhm0N+y5dSHMxFAVmNDoaU/E8oWElevZl+ErJwTwAn42fr7C1TZpD9ks/1Nsk3I/BjfjFD9NbzoCHtzSqoZwCrKsNa7aIn/w3vTF54gOpzNo9PjvgypfGV7+PoeyUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEr0RaeG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEr0RaeG"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8249cb73792so2901539b3a.3
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 16:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771720876; x=1772325676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BK1tZWI/he8wIwVqoQLcH2SYIZOlXqN9ZiRpEWvu8Tw=;
        b=XEr0RaeG5XYjF1whcf9oCI4t3pKCBL9JCnT8WzFEs/e9symvGsWIsvm9iMpWna/kXj
         tbMKfpLC3VfScIu0iG2OBCQe4AkhgFG50p8evNr2WUxSaVPdGGHivZwGiBKXEvSjadIb
         G1FowhiwqZ1gFI6hV3tjJ6uv69oSXXnGbkkiUt0AKNJJhdy+kMSvJXNUOMV90sRyOLSw
         ypo9VPkRd6inCF2fQlovUDjtZ/OiAvhsdLUuUMr5sj2EGkefApIp+pKUb3JduKUqltyy
         jelhKmXQGzcIaIr4GhQp4EuQWkxIvvBzZzil0JBfc3d7GoLFKCZGI0zaYqn5X63FR259
         QJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771720876; x=1772325676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK1tZWI/he8wIwVqoQLcH2SYIZOlXqN9ZiRpEWvu8Tw=;
        b=PO8cfDfrOjzh/+GCMYmHEpjF5901vUGMtiA0HTtEUJ2z3jeqk9pzpqpNqgqDXyKfYP
         uNrNVDiTFzJKrGIBzQeoEEVzX5uC2JrPUYb0CIXUUd81oasZyGw9nOpg+uV8fSDKlClV
         cc5wbVOwexJlne71zzwi+HsApGeRK4qqrlbWdmqTnQd8lyDXPykE7AUJX62kvVIwHG0a
         QQd4Y5DLBh8NuS6WK+fCKp71DAuHNa2+s8MD30RCr2uRPA7eqRcz6+qLkl0R2RLx6fA5
         Lpy3QFTFOZt4t+/9VpqXNEhIcVWW2M1UYogIDv9pWDLzb+1s8AUSekDf5+rny9BFZspZ
         y7Bg==
X-Gm-Message-State: AOJu0YyXANLwuE6SvvlXxUquJMp98nh2H8YWs/qIVf/dh3tai0J/UM+D
	i9c4xk92zFF+1U+ORgxL/OrzwBqSjpByN4czJS65zOZlDEhE8bsW30KxgVI/fA==
X-Gm-Gg: AZuq6aLeF8ofSKlmL6il5IG/H+CvL70OkRzTE+cF3yRaYYYdqVEaKLPX0spTxFeXVlG
	6cZmvIjtoa/KS2jl5q6ihz+w+G4x8dChh/ewBLPeKr5S81pWj4/Fxi8ghNyaUXRxWRR3Rjp+BPq
	kXiXEANTxML6L2wit8BTExxU6MTw1I8AlFa+5A5cNVHis6iqboFya9uPbW6l+EDybVGT9O5hBdR
	fPf5J/0dQswV+Jx4YJqU5pHoWo7LSf+EJyynCYnye2MOaZO2ZG5cKLB5FCqXsnThrnjXL/CL+o6
	ZO/Veel7s0GK+gm8FVcfrb+kc49ln90w+8lVKiUByM6cys9+RioSn2s+hE/FSHoTJhd6Xsybppj
	+2XhhkkfHn+fRrMoDYy+wolGp4wTblQ0nNanAXbBOdDqVSb2VlNeIeoFrea8daNcMrHcjIgLGHF
	4CDwOFKTo1BxVaH/L7pxwr5J0AZZuKc1wD+s6KU+qqfcg=
X-Received: by 2002:a05:6a00:3693:b0:823:1d04:e280 with SMTP id d2e1a72fcca58-826da907392mr3649843b3a.22.1771720876025;
        Sat, 21 Feb 2026 16:41:16 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd86c6f7sm3184105b3a.31.2026.02.21.16.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:41:14 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC] repo: remove unused header
Date: Sun, 22 Feb 2026 06:10:36 +0530
Message-ID: <20260222004036.47744-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "hex.h" header is included in "builtin/repo.c", but none of the
functions or macros it provides are used in this file.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---

As instructed in the Getting Started section of SoC 2026 Ideas page in repo project
This comes as a micro patch.

 builtin/repo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..63d21df4c2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -2,7 +2,6 @@
 
 #include "builtin.h"
 #include "environment.h"
-#include "hex.h"
 #include "odb.h"
 #include "parse-options.h"
 #include "path-walk.h"
-- 
2.52.0
