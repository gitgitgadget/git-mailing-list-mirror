Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901603E481
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728422; cv=none; b=dEYbH0nECLQuq7Pak/QWfyXZ/IA8ATgD8Ogr8OIyyBUECFiGuGY1hPPPw/mA5RkqvFt+u75bpy+Mk7cdaCY1E5Z2pQ5yEZ4Ao03js7d9MdUgKL+FAodF33ibRhDmV+N3UmndSaILD7lsGiky82JWr4m3qXzynPKhXABSvugcLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728422; c=relaxed/simple;
	bh=dm7Knym0Mm9QooYNLPaIiJHD9opknD9oqXOtAo3OvYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NZ2mpr6rtEMsiajFKPGTe6nEwRHjuldnYQrg/83319sfsb3whNgIyPf0oeq1wLdyM4ouruDaQkNdh9j3aO0LVLFWQG3t761fn98LfbuueDEG4KN909jId8OGZSvy5JnD2LJe0kpMuUhBhOT/GcYISgD0X3FK5bKWB++vpwc/bG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+BHUWnd; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+BHUWnd"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e11cd97960so52594a34.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 11:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706728419; x=1707333219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypHIcU7qYTRvfuyAf5SPYRFqspAOgB6/5zx6Ngb2mZE=;
        b=L+BHUWnda6vizTe7UAdRXiXYgZfONJVVeHEs5Hbm/xDapNLfafkNoLlCPr3nsil9s4
         ylzq5KTBY4RLjiHhBNcmFXNFSCuzuV3AVIBT8UmqKraAsPvD8Loo3GJRbyhCO1z1nyeG
         M7CFRyn+7ujkWFky/II6y1Tl2zlBbxcKv0XxOAxwCjahjUeOMelqx4eHR9lwnOYtm77C
         0Hkw0s8qOwzQsLKS7OQ2FRt7D4GWfitVLnVlFe9Kbpzm97u3Yf9mbwg9SK3GoZ2BhcLa
         tss64uzcEedft8Dc0QNkdGYXJJIDqjtGd3SkmP7g2t/L0RVYZ+1OX+FlzCgn1b3JR8SC
         Mjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706728419; x=1707333219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypHIcU7qYTRvfuyAf5SPYRFqspAOgB6/5zx6Ngb2mZE=;
        b=AciTduGyjVb8SCK5++Gs/+ak3lp+rKQjs8OL79C3t9TlXJYSP55PZxDrRvN97e8bXl
         DEAi0NoERxiql/zp5dDzFdnAfPNg7AR4u3BCfJTk9+B9g6T3t9hRrdYaP0bFqmyeRkkk
         VSxXCgFI+oBQ3Co/lPHO5LVVoEBcEDognpKpgyjNOdzD0LuJICYyMzuEVLshgYwtVAWA
         AANN57nr2aD1r971UzotgRPIK7ov0dQszTxgKmqlyZ46Yj3n6sWiiwthaLfWWbhRqhqm
         WqM4DgX5xbDFyuHwOba8uPDVQgiHlci9HjrOPfoua3MRapDlF2jicMKyabtFXQgngWrN
         ZeLw==
X-Gm-Message-State: AOJu0Yw2iGLzINgeLLqmt1QtFn2Z4DYvFpIz1IHS9UAiczDpL/SIqjIY
	ZBV5tXgp3KkHIQq76SOyD7NGLVMDddUlUjse6j3Ew/9bAalA6pzTwb9g0jgo
X-Google-Smtp-Source: AGHT+IGL51IvACO5X2e8pWRT5lv86EDXtExtMXHgCD83hdS3njed3TtB9mE3jxs+LvnKeM/orERKjg==
X-Received: by 2002:a05:6358:d5a9:b0:176:9e92:8e4 with SMTP id ms41-20020a056358d5a900b001769e9208e4mr2891118rwb.10.1706728418672;
        Wed, 31 Jan 2024 11:13:38 -0800 (PST)
Received: from localhost.localdomain ([2601:640:8e80:1270:fc94:809e:19f2:d7a6])
        by smtp.gmail.com with ESMTPSA id p16-20020a63e650000000b005d553239b16sm10771162pgj.20.2024.01.31.11.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 11:13:38 -0800 (PST)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] ci: update FreeBSD cirrus job
Date: Wed, 31 Jan 2024 11:13:25 -0800
Message-Id: <20240131191325.33228-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

FreeBSD 12 is EOL and no longer available, causing errors in this job.

Upgrade to 13.2, which is the next oldest release with support and that
should keep it for at least another 4 months.

This will be upgraded again once 13.3 is released to avoid furtheer
surprises.

"Not enough compute credits to prioritize tasks!" seems to be just a
reminder that the credit allocate for the Free Tier by Cirrus is all
used up and which might result in additional delays getting a result.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 .cirrus.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index b6280692d2..77346a4929 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -1,7 +1,7 @@
 env:
   CIRRUS_CLONE_DEPTH: 1
 
-freebsd_12_task:
+freebsd_task:
   env:
     GIT_PROVE_OPTS: "--timer --jobs 10"
     GIT_TEST_OPTS: "--no-chain-lint --no-bin-wrappers"
@@ -9,7 +9,7 @@ freebsd_12_task:
     DEFAULT_TEST_TARGET: prove
     DEVELOPER: 1
   freebsd_instance:
-    image_family: freebsd-12-3
+    image_family: freebsd-13-2
     memory: 2G
   install_script:
     pkg install -y gettext gmake perl5
-- 
2.39.3 (Apple Git-145)

