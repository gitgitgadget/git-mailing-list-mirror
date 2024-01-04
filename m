Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DA200C0
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXPTQIzM"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dbdbf680d6so143857a34.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 00:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704355811; x=1704960611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHWUYviedtKd/IU95qogPu7Vl3ptEuEtNB/M1RwKSFg=;
        b=RXPTQIzMXQkVxAuM0uInrao3Gs0TKILUH1ciMSJjjYFjX3wwkjeVXB0hpGZEX1FrvO
         bJw11LIz2tvi+CGyV+DLT0rVm8yi7ODWVfdFp32OfmdZnbIZaQWN05SUcFeaSdvYVv5Y
         HG+28kLgmJfVVG+VRvl2RGCQg1Ertg0VzSmkfoZ4DrVfOZ6ZmrdrtaiCP01z0gqiJX/e
         Fj/I9sE1SRZgwFFdYJLnQ2kKfb8NrBeP8r8eaLSRPtf+EdP0jdCqgBvTWbwXForpFfnS
         LcLs3gdkCi4pcMN1wzpRwqezSNV+Tgd1VFFfiWIMRYcReEzbckf79djNps0dKGSicGN+
         MURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704355811; x=1704960611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHWUYviedtKd/IU95qogPu7Vl3ptEuEtNB/M1RwKSFg=;
        b=QnFGH84Ho+KMCuYWZeE3eD5u+OHe4QHDRQj7ptcABXWLk30j7IvrXqI5CRiXzyR5df
         fuB3QmWyRBIGk23R3Stu9sDquHP3iGEUIHeD/S9sgQE3SxSz7oRFZijJJEwB5dxB8tRi
         sKANM3lPV+FFhr57fAW81Xq5OdZUzhrKE5EeKCVsYXWdSyt3h2ihB3NeGBGy1FkGjGLx
         I4kH2ey6GCm7FBPblSE29AHBMMTOGunOeXFS58PsZUaMXQtsj1AS0TmdTDmClHyu+ZGy
         6THtqKJuY95xMlTu+p+ZHzjZEuzlAIJYuBQ1A/bDDeG93YK8Sx3F1VU8pTi91+jexqD5
         HUKQ==
X-Gm-Message-State: AOJu0Yyl9wt1BN865ZbH49WbftOtIwOYrHGpSaR4MqDu/4jpkS+lSxje
	KAhtn9R+fIBQsjuFpTrt+Sl2S5fqPB4=
X-Google-Smtp-Source: AGHT+IHe1ib2bq2GfSIDkVL/tiZEdv822gCRYu1HGtCIbg3nDt3iFl7F8061UW+gE3IXAg9ewOkwMg==
X-Received: by 2002:a05:6358:2925:b0:173:8f7:73e4 with SMTP id y37-20020a056358292500b0017308f773e4mr188941rwb.3.1704355810684;
        Thu, 04 Jan 2024 00:10:10 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:29c1:be46:cbba:96b0])
        by smtp.gmail.com with ESMTPSA id fb27-20020a056a002d9b00b006d9bdc0f765sm17133610pfb.53.2024.01.04.00.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 00:10:10 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Illia Bobyr <illia.bobyr@gmail.com>
Subject: [PATCH] rebase: clarify --reschedule-failed-exec default
Date: Thu,  4 Jan 2024 00:06:31 -0800
Message-Id: <20240104080631.3666413-1-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation should mention the default behavior.

It is better to explain the persistent nature of the
--reschedule-failed-exec flag from the user standpoint, rather than from
the implementation standpoint.

Signed-off-by: Illia Bobyr <illia.bobyr@gmail.com>
---
 Documentation/git-rebase.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git Documentation/git-rebase.txt Documentation/git-rebase.txt
index 1dd65..45d3c 100644
--- Documentation/git-rebase.txt
+++ Documentation/git-rebase.txt
@@ -626,13 +626,16 @@ See also INCOMPATIBLE OPTIONS below.
 	Automatically reschedule `exec` commands that failed. This only makes
 	sense in interactive mode (or when an `--exec` option was provided).
 +
-Even though this option applies once a rebase is started, it's set for
-the whole rebase at the start based on either the
-`rebase.rescheduleFailedExec` configuration (see linkgit:git-config[1]
-or "CONFIGURATION" below) or whether this option is
-provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
-start would be overridden by the presence of
-`rebase.rescheduleFailedExec=true` configuration.
+This option applies once a rebase is started. It is preserved for the whole
+rebase based on, in order, the command line option provided to the initial `git
+rebase`, the `rebase.rescheduleFailedExec` configuration (see
+linkgit:git-config[1] or "CONFIGURATION" below), or it defaults to false.
++
+Recording this option for the whole rebase is a convenience feature. Otherwise
+an explicit `--no-reschedule-failed-exec` at the start would be overridden by
+the presence of a `rebase.rescheduleFailedExec=true` configuration when `git
+rebase --continue` is invoked. Currently, you can not, pass
+`--[no-]reschedule-failed-exec` to `git rebase --continue`.
 
 --update-refs::
 --no-update-refs::
-- 
2.40.1

