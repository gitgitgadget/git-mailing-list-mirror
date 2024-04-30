Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CC2107
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 00:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437308; cv=none; b=AssUPaZbrDUbwnAAjnTw+PJNh3btHXIKhNsLTeqBRejunMVf+5D/hb10HKSsWp2ccxQLIvkqmporrJCVb2dE+YgldK85a37CFmBrxfic7/I0dQtg0lEO/9PDKSoiYHumYDJbFz4mvN4WWP8Vd84pmEUqhALiIuMExzed4I45rTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437308; c=relaxed/simple;
	bh=ys7WnnxBoxcQj/tiDbX8Y2lJ+cON98xBG6DqxCYSp1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rG9Uzeo+4AdrV0n1i/leCdqxY/BrcANRLj7ouXzbGNs9jXSX1s2qzKBLKyuQspCMRxdn3dVW7O4VVnAP/pIqQmX3KtpuMTEbshYrnKENvn9waeI+ZXCgUg9ZJPvaRAO6Mm3PnzvXKje5cZxjGPVKjHxWgkTIce6A+7a8B9J0s6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiH+c+Et; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiH+c+Et"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6eb86b69e65so3114365a34.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 17:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714437305; x=1715042105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gtm7mmt8gRCogwolmSbMqmLapvDsaZpxoixUgZfCI3c=;
        b=RiH+c+EtXWtf8HQyela8Du4sDcO6HwXVvg/k0uYdro9AtuljEKTAj7E8Pw9WTrc7ec
         bC8n6HwckZpGC30qYN3cQrpGB0sccMCCuy2fg7O/geOtPWgfAk9zNTUJYa5tcFoX+CIN
         0meQjHytkdQ3gGu5hrdmvVK8MaeSkmDj5tPMYG28lqcxllgF9peqP0Kk7sPiIsBb9LDY
         x1wakLr3hobla8jUUf/CI9gksdOx+HvjbRyc5ONoEwMVtzm5voHaNpezKHajGuKA1tsZ
         yfgF7besWgb39Scy/pLirI4XMMBfnC+WP066jcpRZpPBem8f9uaeAzsqg7zWoceYsEdd
         HENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714437305; x=1715042105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gtm7mmt8gRCogwolmSbMqmLapvDsaZpxoixUgZfCI3c=;
        b=kfHdCeBKLODf+dZ6LF3eay/Kf5dBiXsS6iP0+fku5621nhXId51wmbfzjTRStwxYP3
         A254bq0HpUYqkX+EjhwY//hkmIBB5vuyMGhBfSMICVhGIhjpv4hu/TFASVtRE0lqbyzr
         VS5HtxuByBBgzNi48vHqejipbl/0f2b3J+eOyw62dRGOpmB5xzzJa6D9jcBlvVMwtBgF
         xFSVh0wTkG4m11MbEokF5E8eS7OWvlQVOEVWWq23HwJLf/ZOv36AiE8WEoC0YBCopef+
         qymozqOMa03W4N98hkaNXQO6Rs3vrr4ZcL8+1otWv3dZoHI1ZCqs2Ixgv0dGYzpFeEJF
         Cn1w==
X-Gm-Message-State: AOJu0YwcL8n4lV3Ehg48qXMbu+t1CW06yxE4ejyHs1Ck2C6OiCH51VcA
	eMSq4GpdhIo1GndYou5N4qW/Bsr1f5/sDike/s2siwL6iuRKMFaawbjHoBN0
X-Google-Smtp-Source: AGHT+IG6TkpwLGHOr74ehRpIWgyd58WGcgIqmrpoEIeOYPyu1HlyOlbhfGz7xHM0iayMIaFhG+F9vA==
X-Received: by 2002:a05:6830:10ce:b0:6ee:4c37:995 with SMTP id z14-20020a05683010ce00b006ee4c370995mr3350699oto.19.1714437305414;
        Mon, 29 Apr 2024 17:35:05 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id bw3-20020a0568300dc300b006ee5b409f23sm188645otb.22.2024.04.29.17.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 17:35:05 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/2] ci: pre-collapse GitLab CI sections
Date: Mon, 29 Apr 2024 19:33:22 -0500
Message-ID: <20240430003323.6210-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430003323.6210-1-jltobler@gmail.com>
References: <20240430003323.6210-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sections of CI output defined by `begin_group()` and `end_group()` are
expanded in GitLab pipelines by default. This can make CI job output
rather noisy and harder to navigate. Update the behavior for GitLab
pipelines to now collapse sections by default.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 0a73fc7bd1..02e5e058dd 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -18,7 +18,7 @@ elif test true = "$GITLAB_CI"
 then
 	begin_group () {
 		need_to_end_group=t
-		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K$1\n"
+		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1\n"
 		trap "end_group '$1'" EXIT
 		set -x
 	}
-- 
2.44.0

