Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041E131B837
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410426; cv=none; b=R7nQM7+AxOHAmqw/dK1Cl2N8sEK3+7LhtOvdZicQbVuALHEKvi8S6v9ifCrCXoJZL/DMtRxAcj/5oSvL/H0DcaoQeR2oh7qy5vQzqxT0QvB32CeY73hfRWxz908pxVUY+N9Kth0ZOSka73fprUT1Dr16yxJViZ8U636zfxz0i0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410426; c=relaxed/simple;
	bh=1ye0M7jy2GqNtgx9jg08vk2zsOEBLJ6Dwt9XzS8+SJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZY7e150MaFGCsM4hKf19oSiuuvZB1PhGCd1tg1/Qaw3bqeyv5wXDzF8CGmPSz8QmuW6WtOJJ8vMyimxJr16IFf+m6bOI9gsiWTNizp+mxwz/zRJlk/00swlDLBGIQBdVJOLDgBf/T2aMsziNVJtJQ4JEkDOZ7HRFJ4hx3Obtdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3Tii1KZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3Tii1KZ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35a1dd9c842so877861a91.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773410424; x=1774015224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=A3Tii1KZM9xnSZE9cS5FB3fxjMIlSAjCAYSwlC8NifikUW3avf9Ccn+GadnZFntSGh
         nrjHbjLvBgWR2pE0nYz4T6tSr26X6aLqYeR1QIH8XU9fGx76bS2WgNW78VI3qVwVb+5h
         mf6eIM1lJ9lgJImen5HvSZ5eXndCUPICpHLiWgx6TaaUw+hxzXBl7fQYutFa4t1scc+w
         kcVClw6plPcoPAj6iiV8cjvaAJ09KymGRgfVDCkCCa1MKekei+dOqWcfhujMgvB0m833
         1AW1nGbK2vnOLSMIs4kF0P1Ai0unzK7cpDUBn2cI6BHh/NXOfW8FxHgb5xp0vSpJ76Zg
         cNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410424; x=1774015224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=i3XEMtb2iS4SCyS2BZ71VE+wQjy1Gxk3xfKDfbsu7+D6/4QcEG3L/HH7SA/KX38goS
         UX/BxUbhm0lcQafowmVHpfQ/18tQ1wk83cYKipJoGkw5Qy+mj5URjSIkEaMm10eU/yR1
         KZlchaBs9UgFa9Vpn64EhQHTAqknd7VLNIfbfs5LBAfGnDkZPdsf9961IC8GEo9IpGLB
         SHN707McaZEE3nHsw7mqliXljvw4B5ceoEQTP67BsvYyuPl0TzkHUKtweEVdY0yypo7D
         q4GyhlIrtfb2I5E+uJ/zLRS7PoXextWUHAtGO5xCrbUXN6KTAlRr6WrYtFf7P8YJZKBF
         ywiQ==
X-Gm-Message-State: AOJu0Yy3kgHDMBaPxg0krVwW8+oo3X+L0Lt9LnCztzheXggowRko9VHv
	jq0M+xoXd0NQ4EhHTrLQPAsncsDY3G6Lbvgf0QCAWodeLmhKYtOAkO3MR6q1KZ6J
X-Gm-Gg: ATEYQzyxd/MT147YKBZbcVOt5VnvWVgvOUFerKf9YzemXXReHfBUxK89lkn36brfe5N
	wn50o9oomUALUPFMEZVI/OGHtiAKnVe44rDcmMrHVTXBMbkJH3BNh68z1Cn16ZQmAZkSBbj94qt
	TY2nBKwuJHmU5tRQTXm3iwqPmXKZKQktgTdGxkGJ1LSGPhDBnDdIRfK/o36pMjv53yi/PlLE/Zh
	xKXbo+6FH87lNNVatXgYSE/j3KNNZunD1Ou1p7KNv585+TGASgKdMP52NQGg6El/RR57n4QspSs
	guVvzGXyV+AmIa0YuYCUYVfJkANu3g/PX1H3LcH4uPTT2ljosDAK98G3qQrQdoQzfdtRy4D6pJq
	9dkxxyg2T+Ky70nQqi+02RQxGfqMtsQYjj8C++B9IR3ITgpbzdpcWAclJPjaiL3j3cu15dsTyAc
	c8rEyuQn96vJHh5P/tV8g7cpkUvbu3VegGtFIMf53P
X-Received: by 2002:a17:90b:2c8f:b0:359:8bb5:fb3d with SMTP id 98e67ed59e1d1-35a21e395a4mr3018446a91.6.1773410420131;
        Fri, 13 Mar 2026 07:00:20 -0700 (PDT)
Received: from divineocn ([45.127.227.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fc97356dsm9909959a91.8.2026.03.13.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:00:19 -0700 (PDT)
From: aum2357 <ahambrahmasmi2357@gmail.com>
To: git@vger.kernel.org
Cc: aum2357 <ahambrahmasmi2357@gmail.com>
Subject: [PATCH GSOC] Signed-off-by: aum2357 <ahambrahmasmi2357@gmail.com>
Date: Fri, 13 Mar 2026 19:30:57 +0530
Message-ID: <20260313140057.563755-1-ahambrahmasmi2357@gmail.com>
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

