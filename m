Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D16421D3F3
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772944445; cv=none; b=HCpocmyZl6l0zU7gL/Xr4FYy6DPKokiC/3QkfySqmg64gTyUi5ng5MJBJVNu6v9jzFteyGEsxv6GumIsQM63OiDvoxeecMbi08ToMuMW9nApGPZsQTE+JM5Iq8WNxfNlUzOK1u/EgAgc354SQy2He7r0m9SZs8DlGI8CMH/EV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772944445; c=relaxed/simple;
	bh=srRPCujEvswkiUOILSK+K8jkAjGK1MM7hulVfl70KJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ih+4XnRglSTXm8Ua3f4gFU+Ez3f4hCKHvEQRSM1Fuz21CrJ5mGhxRSqDFkD/RnvC24xOonakUCX+9B3g+mbfJvrwvNklZID74GSNLzmpbbC0FLZgcq6eZNig+IzcE8MNs9eqceog3XiDEFsAfPOpbA/drBVjHHBkVbWgdRdRrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhy2DYMo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhy2DYMo"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70c38515d3so1781465a12.0
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 20:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772944443; x=1773549243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCiyeLaAGvszm0d2cfx+shUan1WifUZlHlFqR/nwqu4=;
        b=Jhy2DYMovH9rmBxq+ayrcm0SQj9pGvBKiVjC1GORa/p+/XIT26O7tZBr08nKjo1njC
         mo4Wb3BXtu3VtuXQdWAP1aT14Gby7yj5/KwxxZvldRcmjfzSs357A6/QK6wx8tZ8CuKd
         66D129j9YkGHG8t/1uwuH5dRKB6prHSY3mfY/rYfKIRvauA9YYvX1G/S8mnPdpoxYEXb
         FXGxnbEdKDYXHUT1q0rRSuUUIhwLPTwjCfozWMDEkvrv+ozWvBgIeFGAJGi7+fyNci0a
         JwZcgnGODrW53CoPpr5zWo5Y+hpB0VBF19f8oFRHIhU/2CyqVfjTKFlSFIrvWlc/L4gS
         c2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772944443; x=1773549243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCiyeLaAGvszm0d2cfx+shUan1WifUZlHlFqR/nwqu4=;
        b=dKMROgFwx+g+KyR8n0AiNfa5PC6srpcgj45W9v3md4javUiTjZS7EggbzSqAyUHWT7
         LGC2NaL0Zh+b7eCYxxpFZzpHn1imehFdeCJa5R1EW0pxA1pbXYehwm3J1t1CFzUTT+io
         5QTLWH66f1Gc3AUUF3YLSOENk3BrKZIE2UVaS6n9ZWMKDu++iv5i8In99ipc1jzd9nxj
         Hsiuouqdl09kFa+XyvORYJJCK0IRQJ6lmQUPNL6sAexjAWjmaBsfflbAay8inV5nNLY+
         JrSS1K5LPiIOItAqShp2mGDJp8yS3PYCaBytz8cbmDiUwiOosMIPB09fbfjnlMF9Sy0L
         qjTw==
X-Gm-Message-State: AOJu0YyUjXWiw2dth0yLbbWMyUdLg0FBjv9zZYQQDdBELuP7mVRI0VSi
	JPTpQBydVheGgufHd5k8GiL2vzvO/xakx+O3MNu5RYh/CWXYCXMaP13bPnvo/Iqz
X-Gm-Gg: ATEYQzwRfhZ4oPDG/my1+MF79j4V8f9TP5Cr9jqHGpoWIHXEvrfDrtICloQiDEcDYrT
	yBR6rEOrRYVC5YB4uM5czjKOz6gcmtQ+vLbm3TPVlLSx/4H+w1fO1GOV0wcJTlF/gkvYP6ofswm
	Rb2tp6Sp5HVDlx58MfhkQwMhRmToZmDAJZN2PccSeGRuplKW65GpyxEhtmDCyHU88c0dTGR+7uG
	ximMcRXlzfKrl+mnyGkqDKbrKgfFxJ32kXxitNiZSmGXYT5zSXgNlZ/QYvMUQwhRGai/cBtrExG
	M5QSssVoQVeXFHki9UjkLSmLXAuTG36mppQlHguxMSgtHRCtvm0EhGSRfSbfsUU5OtfXUcsGFxZ
	ouY1tZ25rLoXMKhjqyLpeeeNVSmdNOloG/pFQrd+q76iyv2WGu6Q6KUSk9gk0To52rCw4GZpr0+
	UO/on0VXOtk8dpPZLac93xFdjctOFpHeIs4klqX+XFPvHOrpJjogV98igDbUoGGh04n1wp4K4Bl
	8t+iM+FXwSgCDi3jDfCXR38
X-Received: by 2002:a17:902:e742:b0:2ae:63fd:6d6a with SMTP id d9443c01a7336-2ae8249d4f1mr45803985ad.7.1772944443103;
        Sat, 07 Mar 2026 20:34:03 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83eada11sm67259555ad.38.2026.03.07.20.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 20:34:02 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Tian Yuchen <a3205153416@gmail.com>
Subject: [PATCH] .mailmap: update email address for Tian Yuchen
Date: Sun,  8 Mar 2026 12:33:44 +0800
Message-ID: <20260308043344.77986-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map my old Gmail address to my new custom address in .mailmap.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 8a39e93bf8..c2e3939beb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -283,6 +283,7 @@ Thomas Ackermann <th.acker@arcor.de> <th.acker66@arcor.de>
 Thomas Rast <tr@thomasrast.ch> <trast@student.ethz.ch>
 Thomas Rast <tr@thomasrast.ch> <trast@inf.ethz.ch>
 Thomas Rast <tr@thomasrast.ch> <trast@google.com>
+Tian Yuchen <cat@malon.dev> <a3205153416@gmail.com>
 Timo Hirvonen <tihirvon@gmail.com> <tihirvon@ee.oulu.fi>
 Toby Allsopp <Toby.Allsopp@navman.co.nz> <toby.allsopp@navman.co.nz>
 Tom Grennan <tmgrennan@gmail.com> <tgrennan@redback.com>
-- 
2.43.0

