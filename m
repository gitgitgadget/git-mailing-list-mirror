Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09529324B27
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410661; cv=none; b=cf0Vm4TAp9BU2/QrzXGpmNMQGavYF/BfdNFBjq7YvPNbQxOfMAszFXl9ID/iqLNkHRrPN1FCp6Ma+7QQzP+6XSFeh2+znvQmfGtUQoMaWIjscp/ey6RMIKZlvjC/ULmcgLP5fVD5n2ji1JW2KgUorHFQKYDmeaBd/du/FPi8kaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410661; c=relaxed/simple;
	bh=1ye0M7jy2GqNtgx9jg08vk2zsOEBLJ6Dwt9XzS8+SJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QarbQdR99AeExURry4hw0x0mfMwWQmWHtiLIR7PcvQa6TQa1JYVO+m82IHUa0hYmOXuTr988fAayenuhQul8WLj+o4kCOS+J4E+iXmpxYlI9biW4ohGy2KdxXbhi8b+v/O6HlSggUrhrNgSIJfMGSfO5+d9TxTC9IWby6wz96Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXjf2XBl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXjf2XBl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aea68839a5so17468975ad.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773410659; x=1774015459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=YXjf2XBlS5c1LTELqjpg0Qy7tr581JXzkdPKZLNa2nh1FyzrPNKZRYXwMQzPEfiC38
         r5cS2HeR9BPBe0XqANGQnAR4w4RSHi1TGAM9yzfQlVpPFujqPl8Gu6ebrpNJPuxiWWQr
         Hwk4O/2BPGV3MCFfBNJrvD20Yc6rFAON34wk9MjiNK4GsPfCXMjs7H1QW12rUmKeWD2Y
         jlqgM9hsrSCB4Gy04UdfrpFDZwtk3aLXMJZYRtGbXiLJGgnVIetqMnoHrFmyyl4RHm/u
         Uxwq5BZl5pH0EGI5ZN+DSnLswYEypL5P+n6Qm509/zvhHOlscADyVN18K/DoB8Wkh7yH
         85aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410659; x=1774015459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=pMKEsNvtsJYavfo7Q4vPQjD63TWPhQyLt/6Ej72LDwYtjd31QlmJP5G9T9nm92R8ad
         Lw+L32WuvJKgcVSxU38u7WbXUFUj6W7srv00aX39m70Xr77+Vnx1w26HxlqBg5MFK/IC
         nO9IqHJfNq9RGND1gjCBfearuHouVX7dxQPLrI3Kdk80/QfWEg9yqo5dJR7sVaBTHBt4
         iDayhqXilyHmvyS3ST0+vWOcRgiJVNYsUGU42LxVndiKjYPZ2bFmFaa0pj3Y5Kw2SZbk
         MBP7simNPgGkTlYsCarBQwGy9p9Uua8jxFEHvP9dnM+B8S7DA/h8rkmgWLdSfks9ZB+c
         G7IQ==
X-Gm-Message-State: AOJu0YwgwcOgYbR4wmVUDDrcItT3YTbbzzPHmiY5INmgIg9B/ZJ8RtGX
	LENpRIHJt5I96/oJArLbyv44ZK6HK6yqPo22V5qPMYHdqowO5HiHgfu6zXx5mNmc
X-Gm-Gg: ATEYQzx0ZxZyXxib4boEab1WCa3qeOMyySYW9oKhubTByj7P6bGU8IR0ysJj1EXc73n
	OBKNQI18fyA7leloYQqjiu9h4+0zHho95Oo7/991reCvyGvUOexgwVjPRNzHWuSYlT73RefR//b
	5+JNRkc7swa63iUfmMkzuoVvGLqWRR526KwfUpqE4j9k9s9MPYJDYwJ54XSmDQ7/rT/21w2pcun
	yFo049Y+mdquwy2pTbk6YOe67J0Tlr++D/VW1UbpNr0DdP7hU+huqpo55pJ1Az1KUV06NJEkYZ1
	0gTdF3CixYt8wnAxRGmYJ8qsD/8ZHYQZvS6q5mrDfmwWkdGHLIpkqftT35VRhGbF+Pmv6hlrsFj
	YMkedpDB812ut66hJMwPnQ+7I1ocK9l1WH/qhYCSrCHPXI6bHhiBHKWHDnutWNpGj6bSlGqcxmf
	MFlLvIoV0iZtVFU7Tvv8YdtVIQD3aMvA==
X-Received: by 2002:a17:903:19c7:b0:2ae:46f9:a115 with SMTP id d9443c01a7336-2aeba5158eemr67089465ad.22.1773410658795;
        Fri, 13 Mar 2026 07:04:18 -0700 (PDT)
Received: from divineocn ([45.127.227.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece8629bbsm22769885ad.88.2026.03.13.07.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:04:18 -0700 (PDT)
From: aum2357 <ahambrahmasmi2357@gmail.com>
To: git@vger.kernel.org
Cc: aum2357 <ahambrahmasmi2357@gmail.com>
Subject: [PATCH GSOC] diff: use conventional comparison order
Date: Fri, 13 Mar 2026 19:34:40 +0530
Message-ID: <20260313140440.564201-1-ahambrahmasmi2357@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff: use conventional comparison order

Replace `0 <= addremove_explicit` with `addremove_explicit >= 0`
to follow the common coding style where variables appear on the
left side of comparisons.
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0ee21692c2..ad0d6047af 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -432,7 +432,7 @@ int cmd_add(int argc,
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if ( addremove_explicit >= 0 )
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
2.53.0

