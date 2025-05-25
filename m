Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98741A275
	for <git@vger.kernel.org>; Sun, 25 May 2025 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748206992; cv=none; b=QyT5jeUgDPc4qZXUv7Ps1EO7MisFDsCrVHVHKrqya+oIGIJ4BDCA4Zdhvx/bz4if0TvA51sZYcHOQVm60VGsXnMi3P+jayhdJOtisCCbsE1/wYvpmgCtmgiD8VZTT4gWcBA3ikt+I0KucKwNNdnjS8X7zjsTl+vxuzXxRFUSxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748206992; c=relaxed/simple;
	bh=vOUT3B+HDJ82rfUGrUp1uK4Clj/oPtS3OECd02i2MH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgEZjjXVIoDqu7uv+0iQzHiBjN+OPRAmkHAzoUd0LE9oAqB5dJdhuD0phOCCtuE98Pj4dkxbI/dcIU4zm7XHGi0x4qEkyXOJE9WuSZuS0OjGz8msBLl3TOyzv+CY/NOum+Aa22ORizSj7dW6CtteefQjJYsUkDqHdXX/5JD7P6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/LcZvHF; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/LcZvHF"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-87dfe906a87so112466241.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748206989; x=1748811789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDr78Vw2mMGX9q8ZbO7vvTVLmHsaw71JMSgw+UETQlc=;
        b=l/LcZvHFjXfA9v3zeAEbI93F9Bx7plP/07TRZYDbpewPfdfljlEKkO1alEzNscVFID
         vZTNibk2ZY6x/ePqFCW8Zr10Q5SgldGyP69/u9Kq2B084RyoL2+zpzJhqe9PCvrCsHif
         Qx8FnMif0NBjJ8fxRZYoikmF5KLBwTrmvuamcioYbPy0GtZg3lGddbfbe60FVjgvHKQ2
         KDprAPRFQIzQ8SUP+Ftm6T8Rnkf3dYLbziM5APisn9sZMn+I8V8mkfJ2x+r934jfRvxk
         tfY3ITNv+ZKheVaua43fIVLdsz3815lyINi45jccPAZ+mlRNeVKOqIjVibcIiwKRu13a
         /zTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748206989; x=1748811789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDr78Vw2mMGX9q8ZbO7vvTVLmHsaw71JMSgw+UETQlc=;
        b=Pq0rrkr+RETY62LJo4Y6BUVuOhJjjD23N3j4CdqecSZHqstkQT+Tmt0gW8xkBeeq77
         tnj2nu1IplhO4TFvdUtgfIBYdBYrq8Yf+cQQkXck38tg6TWoDOQVnZRHLbYGjVd/wwt5
         B+IT2Uws2yLl0TFldSsgX0RqLEFAI4wzmquyzZvyVPl7EjpGbVvX7XR/uw5Ix+tWspcz
         BpWKt3iCq71K45ri7rppdv9frK9gdcvc6toFgoLiFWfN0Qd5ia6Q2bM/nAGThBA4l5sF
         hp8C2frrqBst6li5I1gk9ilWHeX172bkoBBe35VsgT0EVofqGjabh87iVZMSiu4+CePj
         /NPQ==
X-Gm-Message-State: AOJu0YzXtkC8CZUBo86YPyoDA+mHrLbzQywQjHwS10UGoged43Lt8GQw
	XiZb9XspDfCJYMCTtGaCjYsoD1KD3f63DsCmN+0ogazRkHFkQh8kG0pEeacJ+g==
X-Gm-Gg: ASbGncvvtZvh4s4WhzjQxOerF8+c1AMb3KrEcPwzK4jS69avYTiKiVQ3YGFI+gmBn7z
	/H2Mvv1h6JOhMPPWlZq5VL+S4PgOj/NUXixk7K4pcdzi0Rdv4qx5vSCcajXZMc4nOQlUaBlVFPD
	VncZuwDhzNUfYZ9PC2sNPzjm9RAvEX/RgIhMX7AgvfNj03VPm3yL0HtQ3RvyJyMJ4i4I3+U2KoN
	f+yIYRlFAC3WkKlwDONV6jatsOpQRRMksATMWaovsFd23nlqk+jw4SHKMRXfO5dCKBF7q43FYnv
	1pPwwRYre78BJ1JYe9zJBlMNzLV5NMl48jZfawMdT2vko/Og04w=
X-Google-Smtp-Source: AGHT+IHWR/AlFLkn94vMPqFzWUY3wp68YFSnJKAGC+bdKlzWa9G1Uo6V5XZtGF4znvcZa33KXnuP6Q==
X-Received: by 2002:a05:6122:82a6:b0:50b:e9a5:cd7b with SMTP id 71dfb90a1353d-52f2c58ca11mr5314052e0c.9.1748206988850;
        Sun, 25 May 2025 14:03:08 -0700 (PDT)
Received: from rodrigo-pc.. ([179.99.7.58])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52f45695f31sm188808e0c.43.2025.05.25.14.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 14:03:08 -0700 (PDT)
From: Rodrigo Carvalho <rodrigorsdc@gmail.com>
To: git@vger.kernel.org
Cc: Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH 1/2] userdiff: add support for R programming language
Date: Sun, 25 May 2025 18:02:35 -0300
Message-ID: <20250525210236.116342-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch appends userdiff.c file in order to support R programming
language function header. This will be useful for those who use Git
for versioning .R files.

Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
---
 userdiff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index da75625020..d1d31ea67e 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -317,6 +317,10 @@ PATTERNS("python",
 	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
 	 /* -- */
+PATTERNS("r",
+	"^[ \t]*([a-zA-z][a-zA-Z0-9_.]*[ \t]*<-[ \t]*function.*)$",
+	/* -- */
+	"[a-zA-Z_][a-zA-Z0-9_.]*"),
 PATTERNS("ruby",
 	 "^[ \t]*((class|module|def)[ \t].*)$",
 	 /* -- */
-- 
2.43.0

