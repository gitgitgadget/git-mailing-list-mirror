Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDB140E30
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739088826; cv=none; b=Gd/bvDa+ToH2yOJQaqliTIxtXWoXG3aAAgLL+u7ITRq0UE1Z2KKuPoHZ47sotPgG1FjjRHNpjl0mwaZ876NtTyXZyY/uDWsS8CzD3S1EDLCUfj4gwH/SCtRWuoMa8Y6iVV0FocPY9kz3X+tRxbkiOXZY/drfNo4R73686to3Okk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739088826; c=relaxed/simple;
	bh=JQfQWt3ORky/Unn4e5BeFjC437CPi+ms7hyd3XsiVmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5OFkBo7IXgFT6Jhb7f/cRt1r+cINBGLHFRiHRebH4Q/LscJ/O4N4GAG2bCD3txGWQrihN1dpJ9YcCowkX7mW/zerAOJUkVndg1U4VJQPX6N6XzjV4w1LYJmHBFIKmHiPh1dPlUkw/2+88STnzy/CmCnedNfTgIm7/IPYPVVJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvayzsxt; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvayzsxt"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-21f50895565so29080785ad.2
        for <git@vger.kernel.org>; Sun, 09 Feb 2025 00:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739088824; x=1739693624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPCrQdX4kh1XvhA6zM6EjEvn4vH0XKC/gG3vJcXMSQ4=;
        b=kvayzsxtRXJfuQdSa73JQdcaJaPcxLFjKFvVZ8vLciQjuAVRbUHqhFQjmTAyvqoo6q
         Q8PPD7Ys8pE9HAkvFlwBWf5trWgeebmBvDbHNtvv0WXqTPTFlsl0qLG+QP3GAipajsb1
         rdALjK8R6texPYmPcEVHBQpZqYkuvRvCoA7u8Rg05A5wWBSIAR+3B2JCNrigc7T4uaiK
         IUtw4X9pFjyVAcIYVLtaFESJK/P2PYHgQDSIDjZdshAmlSEimA4T5RvWtj7ym2Q+AjGb
         JmFilro/csYrMjGntv71pMSo12wrePdduSbmfxu6I6J9NHY5ycSmYvRc68EsVOWpFE33
         GAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739088824; x=1739693624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPCrQdX4kh1XvhA6zM6EjEvn4vH0XKC/gG3vJcXMSQ4=;
        b=GI8oKj0Bltw7+/6SVafvcjV1xHlCBK+M2xZlyUdRPvx2LVKzlu7teyXf+PpvTVE1tD
         HOYkoNGMN6Zi3t62mGvVedrfqDNw3/iASh95dyD8dx0DsnmGb5mRIW+OxCbjlQVgttFW
         /mJ/hZN4cXF9WMdsC1ZIjLcG4iU88USPfaCZa4KCjg1HIRmbisdh2U3XqjZwCOC5I0eh
         dXJp02O+EgwrPxtemqCzKse5OHvbQGskIPGVyISRdtzWYvjjS7oAayOJY4c720bZfzwg
         AMEx/cKHuXs2aZLGdTQyCApktmWoXjwOjH4c8AJOke/COXuwHVwL+YvvMbRsT1rHrsTv
         vytA==
X-Gm-Message-State: AOJu0YzCjadBnvf2EDmsJcHMVZXym4o6fa4LO5nBEppNy4pMHFli1ed/
	NEYTiVeMLKAGms+esQmuGwt93kNX26KUr0fVXkyfG/5h9cYLDgeK
X-Gm-Gg: ASbGnctzuIBXwxTIoSSjHAXZnT538sIWMu8zxrtmzcFaSTobtnbxSSO4HTlcYyy7HPj
	SxoVMtYw3mnAcRKc7GM51CXmYGgH9cKAYpoxuoQ93aRH6+B60xmVEuwKmYFFw0riSZ00Ex7Umcx
	CqbM069LqEPGI4MY5SCOjPLOtHSUAlaT8WyAzCWLADNPgO9Zg1LL1MwmmXABaBAy8w3PgRTgvLN
	h6KHuFMQCLdJFgeqtYZICpAcNLAAzPQUdj4Zs+T1KeaYDwV7nlf41UwLY6qom7xMxuXGCJylA5X
	k/wNZqZ8hBdZCtxNevS/qTheBBLzrOVNDU56wLVsuqFxfabyDnHNBQ==
X-Google-Smtp-Source: AGHT+IEp6mhm1OC48iY/t8VZvSJEbTuwk8XWgwEvWbNH+iaeoB97Ho3HZFGdze5aNedTn3muftQ/Yg==
X-Received: by 2002:a05:6a00:3d16:b0:72a:8f07:2bf2 with SMTP id d2e1a72fcca58-7305d44e557mr16145207b3a.9.1739088824220;
        Sun, 09 Feb 2025 00:13:44 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([103.116.72.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730889e0c5fsm466308b3a.119.2025.02.09.00.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 00:13:43 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im
Subject: [GSOC][PATCH v2 4/6] apply: cast some ptrdiff_t's to size_t's
Date: Sun,  9 Feb 2025 08:12:14 +0000
Message-ID: <20250209081216.241350-5-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209081216.241350-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250209081216.241350-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several -Wsign-comparison warnings in "apply.c", complaining
about us comparing ptrdiff_t's with size_t's.

Fix these warnings by typecasting from ptrdiff_t to size_t. As to why
the casts is safe,

  - in function `date_len`, `date` is the starting address of a date at
  the end of the `line` and is guaranteed to be larger than (or equal
  to) `line`

  - in function `git_header_name`, `cp` is guaranteed to be larger than
  (or equal to) `second`, so `line + len` is greater than (or equal to)
  `cp` since we already treat `line + len - second` as a size_t

  - in function `git_header_name`, we are iterating `name` using
  `second`, so `second` is guaranteed to be greater than (or equal to)
  `name`

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index 605a0aa2e3..72464fb6c2 100644
--- a/apply.c
+++ b/apply.c
@@ -540,7 +540,7 @@ static size_t date_len(const char *line, size_t len)
 	    !isdigit(*p++) || !isdigit(*p++))	/* Not a date. */
 		return 0;
 
-	if (date - line >= strlen("19") &&
+	if ((size_t) (date - line) >= strlen("19") &&
 	    isdigit(date[-1]) && isdigit(date[-2]))	/* 4-digit year */
 		date -= strlen("19");
 
@@ -1207,7 +1207,7 @@ static char *git_header_name(int p_value,
 		cp = skip_tree_prefix(p_value, second, line + llen - second);
 		if (!cp)
 			goto free_and_fail1;
-		if (line + llen - cp != first.len ||
+		if ((size_t) (line + llen - cp) != first.len ||
 		    memcmp(first.buf, cp, first.len))
 			goto free_and_fail1;
 		return strbuf_detach(&first, NULL);
@@ -1240,7 +1240,7 @@ static char *git_header_name(int p_value,
 				goto free_and_fail2;
 
 			len = sp.buf + sp.len - np;
-			if (len < second - name &&
+			if (len < (size_t) (second - name) &&
 			    !strncmp(np, name, len) &&
 			    isspace(name[len])) {
 				/* Good */
-- 
2.43.0

