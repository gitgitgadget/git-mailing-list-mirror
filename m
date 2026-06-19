Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67E3B19A8
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881012; cv=none; b=rRL2LMpoL/BGJkBwcIwglVSD2s/WfJGNN2Dwny9pV+HLsYBkBwTrWaG/y1m8ZIy8uh65YTVhreXl7WMUVNa2o8pTNyKbYcx/0Z3sUPpCVI6RMAd+4q7zzomLLFyKBIfY2Mj692xGyP9BPq7D3zuXDIVcVb6XZgaV1LkItOgTPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881012; c=relaxed/simple;
	bh=U6sjHm59owfe7IdYbea+aQEdmMW400SeZAn7uaeablA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suvPNotf8mAXk1GX5Ze0sLIYuohdxfIUqKRpQSzwytzaDMyueAa5iD8x9WqZex9dioTQePIERNzcGD/8s8BZyokYuaOqAUSl4OEHy0HgkC+/uiy98X/CVP9pN0W/cCECiRCfxlEmf24+qZ3lbgpABNBh3o4Nd7/2Fv+cxPXNRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHZtSuya; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHZtSuya"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so14891945e9.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881009; x=1782485809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0CdN5HWj9lAgP8E/pflDKuxIIs5nSumPKXhtz64tJw=;
        b=dHZtSuya9dLeDlt8lll85wjXEoLCnZ8YEX11SjPfzM/qLg34w289VXutUMdBTIK/sQ
         Pn3GVGkLjs6ScULEATeDd1En8JGglhFxIZKzImHPyLkBHXTb3i/ioK51m9zehX1+Lmjf
         XCH8SLh+kK43zuZ7TCr452izuto2yX1R6FJgWSZ1mRVIes/dpOtLMHjb0Pl+ax0QNSur
         r9WqO95gPbo6Qy6OJ0mYQvicAYtFeiIdYsNVGkuY/VwbV7MvUVWkQjz8Qt79choys2f3
         ZNL42wjmDuqZKTdH/m0irsF1ABBIOuJXS6aV8jklleP5w2xXEggYt48crLM37TY3N4T9
         B2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881009; x=1782485809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q0CdN5HWj9lAgP8E/pflDKuxIIs5nSumPKXhtz64tJw=;
        b=cQPlQ8FIb3/V7jyO0OMXXV9IPsFHJWI8ycPljwGbeeAP4LVtR6Px4w5vkZgTvSDV3g
         Lr01fzR0lKFhbym51QFonGLvAaGnnEzUXzq742mxBS7k8jTN4C8ZOFe+ivp1yvrDz+QC
         n+j96SDyz51UASVXRBP7cnHvbsRvuYGOHRvQBxupkXlZDkBrfwUsTRKVxwEPaDkH3W9G
         +JrBCfDv7NuhSImiOSgwG2q6Sfg65Zr1JbC3b78Kk4xbMhG16O26og5MtXNPqsnKGSH8
         k5B0+FzeQN6Eqxu1Nn5yrXS6D1EOn65OaDfqqqWuYqikuO7eX4yr1m/Tszfudm1vzqrc
         ADEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MmWiHk8GDA/oPRCYucdM6cHqXKfWek+G2RjfQi08yRHHLjGCNc6WGMyud0pSPY7w4d3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/f2p7D9pBHlrI4ykZ1yn5EFZNdO5+PUkXXowSGj+Kytz+9+Z
	iOCCKaLuuJm9J1KpP5XnHNstV301i7wA2Ha9RvzDp2gf0dmyWC/W3AAn
X-Gm-Gg: AfdE7cniLIlu3UBREpLAQvRjQKuIKupLH32qtVHBNR8zrQRlKTm41JXmY9ZUJwUQU7C
	7jp3UrOKoeuADvEV5FR5eAHjzBww7nAmDEYIFhGIKXVsmbSdaF8Q5Rc8lShCbmRwxCN3SO/b1qD
	5TZRbtkqAE6zjvk4tehc6xqBHmIYtbOVQ81GJVpIVnwKvCKX7DOWFJkMjmtUqaMEa/t7Vv2QrSq
	LDoAESF/eoQzKcUsV6HFrVpUk51/vaMihl+YE32bZRx8r21jJki6wv0JO9atzHbACnTRFys50Ia
	Q8Xl267ZKCaQoe9CGkuQoUMb2fuuh2dUuFNLIGgPBwpkmO7AD5pMaY8AW60HvnovNiodNrqfM4I
	gPAo5LvqW0BftE9cCMdQAPI51i5mwmFiBXK3pdudlH0+lk17LMvVMC3K5KbMXpvmrxmb1KdikkT
	wGojeF06T0Pck5yMkNLZNTnUF0W4A4UeLAAZohRxeOEyJXj8WBly5/pQBwo+XjSD3VerFGu7iQL
	kfIWrsgMnEcUe0k3grOBPLs3EG/dn55fdyUV15el7VtGIdjEoT8VEjYeRkQzrjOLBL6zBcc2LaX
	jR9PppYswyOee5U+JTfKdGjZgxeg4oqxst68lpEzleGptUhQjZnFN+kRbV2mNw2yWjijqPgEc5X
	17qGIpGXfp7yt+g==
X-Received: by 2002:a05:600c:8b70:b0:492:43bc:b8ab with SMTP id 5b1f17b1804b1-49243bcb925mr38088485e9.4.1781881009290;
        Fri, 19 Jun 2026 07:56:49 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.56.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:56:48 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v13 02/12] git-compat-util: add strtoul_ul() with error handling
Date: Fri, 19 Jun 2026 16:56:31 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-2-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

We already have strtoul_ui() and similar functions that provide proper
error handling using strtoul from the standard library. However,
there isn't currently a variant that returns an unsigned long.

This variant is needed in a subsequent commit.

This variant is needed in a subsequent commit to enable returning an
unsigned long with proper error handling.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 git-compat-util.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8809776407..4bf569f35c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -975,6 +975,26 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 	return 0;
 }
 
+/*
+ * Convert a string to an unsigned long using the standard library's strtoul,
+ * with additional error handling to ensure robustness.
+ */
+static inline int strtoul_ul(char const *s, int base, unsigned long *result)
+{
+	unsigned long ul;
+	char *p;
+
+	errno = 0;
+	/* negative values would be accepted by strtoul */
+	if (strchr(s, '-'))
+		return -1;
+	ul = strtoul(s, &p, base);
+	if (errno || *p || p == s)
+		return -1;
+	*result = ul;
+	return 0;
+}
+
 static inline int strtol_i(char const *s, int base, int *result)
 {
 	long ul;

-- 
2.54.0
