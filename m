Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA8263F47
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536671; cv=none; b=Iy6SxyMhkU8vbTgX6F0JFjMyB+VkQUOVZbGdxIw/MaTNuqaYPpLRH1Urb30GG9T9HYtyIDztSj2/5Qas0EBnBiY1rfKATtjlMWLFgdnGo3vNUQG9IYDwJ0V8xJCPy62JUoouAslkTgYI876H2QFBOLPdhyKLoDz3PIsoVzAGxDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536671; c=relaxed/simple;
	bh=fB80ASbecHtp4fGMlEVSHuxVoWUEiTfhiT/c1rpUQfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNa98aL9JbL6OdN1DkJD+XcXQ5OpgKfSTebxVM+hQ+nfuTbjrFpH8UPeOByPoIqhtzPzdGY3t0S09EW/BLqh8aKFgOo8Jsgktl+wlrRBdUFvVk3XbZlc/jRp1i7/sTMzIpeMuN6+MoeUIUgiz9uqf7JdEcUEKQWffliLEeSRd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxH+aetW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxH+aetW"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e83d65e5so22284125ad.1
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739536665; x=1740141465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUev6MBsFEBj9LcEfo26+7FRqWVh8ngUTgpXCvWBZ7M=;
        b=BxH+aetWTjBGzBQcZxB+Nv0CDZWHUCqt+N+LQDisnqrl/2lLNoEgoitDlE4B/E+vKS
         BId3UVX1Z86EJN7lQY/9E0MJy/xr59YzMI9hTcTynNanuLZpH0BaW6X9h2AwTaClLIEl
         kP6G0DULS+e2ms+lEkXfBVgGFV0oMXaYuWCD5gf07vYsxK81WHd2i8bp03JV3SKOXj9d
         OSyZRVV2un02pFi0sFz9y5+d+nGOu7whZdHnJlMNcTrdlq7d/SZ9KPk9xenhwLRnMQO5
         duhnCv+eO2ztZsTymmeMXUzj2Qx5FEsXz/clgOXR/3v4TnKvpFkxD3xMZoBz8FF+je6Y
         wV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536665; x=1740141465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUev6MBsFEBj9LcEfo26+7FRqWVh8ngUTgpXCvWBZ7M=;
        b=jw/pz+pNSdcAHcEhSbntf9ozVNMNeTEC6md5y/IkGcIJXNgpS1bGCH7LmiQCo4rdGd
         Cp9+5ITCwdda7nCBW+yPJNvq+D0eT5nIfvnZoG3hLCpjWrazbuWfDSCoB2BJutr44OJ4
         91K5lK57xvsffR1mRAlXqh0h1W9vcJi3uIJFl9ZgYPmYfF8P7hpo7XTHXT01a9mLYrwb
         6nH90y3+l3DHm/sAO3Jui8x724y4pK4XXdFq8BvePT62lrCJ2ONryxRdjmnSmj2C8eV4
         WrLkSrUOPuFZZTDSeBzL9Vk148xZhTHkCRpXu2HMsaSCLXXhMJn/nZzdTLK0tRKp7H7q
         el4A==
X-Forwarded-Encrypted: i=1; AJvYcCXWdr4xh6rWjG+Bh1O0H+Zfh4wiLutgOVLKmK9YBni8tQStRvAUevu4XhLrOglSSn9n5q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vkh4aruexJXzI10tRu0txGCOjmIP8PhvgC/CZiCz2O7FQb2G
	/LGEMIZw4OwMLPhmB/ybwK40fcsYfhsxAE+dHEV6uH9xS5VDWeOQ
X-Gm-Gg: ASbGncvbxNbyherNazuyuillAntDgdt8xcgOZvALQOgOeSU9hK3NiA2lRJ1/6UTE41d
	FNLbshCjy3elmgJV5oLy7KDFrYjYpCt0Q5dhzdgujYD1Cas0tbPneyu/uS/wAGCDgdZsm9toOy+
	upzfOzlyGieU5E6EIfglhuGe3fsr9qdmqiuh+mv5edR1QvbzcvJ/froDOkjVQOBfYq2IJCr9uk4
	eQA9mUgpfZOxgE25zrJUKXZQn+Z/L7vCts7WL88Qu7pC0214pPlRkuFTkgFio0xu3TSzUkQ/tmP
	N2pOqMGeEJGPr052laDxYBXmil2FEdQVkdM0xJag
X-Google-Smtp-Source: AGHT+IEnuf/peGu51npdfaMPnCt8ocivzHyW1TOS64QRiUgdRD7Q4Wdwlqcr+vyNSO7b91Lpuc7avA==
X-Received: by 2002:a17:902:d4d2:b0:21f:1ae1:dd26 with SMTP id d9443c01a7336-220bbcd0acbmr167342575ad.52.1739536664865;
        Fri, 14 Feb 2025 04:37:44 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d09esm27814775ad.112.2025.02.14.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:37:44 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de,
	gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 1/6] version: replace manual ASCII checks with isprint() for clarity
Date: Fri, 14 Feb 2025 18:06:11 +0530
Message-ID: <20250214123734.1403120-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
References: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
 <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the isprint() function checks for printable characters, let's
replace the existing hardcoded ASCII checks with it. However, since
the original checks also handled spaces, we need to account for spaces
explicitly in the new check.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 version.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/version.c b/version.c
index 4d763ab48d..6cfbb8ca56 100644
--- a/version.c
+++ b/version.c
@@ -2,6 +2,7 @@
 #include "version.h"
 #include "version-def.h"
 #include "strbuf.h"
+#include "sane-ctype.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -29,7 +30,7 @@ const char *git_user_agent_sanitized(void)
 		strbuf_addstr(&buf, git_user_agent());
 		strbuf_trim(&buf);
 		for (size_t i = 0; i < buf.len; i++) {
-			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
+			if (!isprint(buf.buf[i]) || buf.buf[i] == ' ')
 				buf.buf[i] = '.';
 		}
 		agent = buf.buf;
-- 
2.48.1

