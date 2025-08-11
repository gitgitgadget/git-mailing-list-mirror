Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9164DDD2
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922889; cv=none; b=h1YlyFecERxXUr1O2JSd8/H87DPIdzeyNH79B4eMr657xkwj/pIDbVgxKXTgMgpGRxFsp/CZMjFP5fzUhUqE3FwSNh5U3PthIDClgQL+gy/pQM2I8Z8umiDI3RAnXNS5xhLMKsaWuyfcz3Urnwd84563jw/fkvRbWPR20Lph72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922889; c=relaxed/simple;
	bh=gzDtVsT2256ZsHW5p1Gen8Uc5IDUJUPwsHWfk+GPGIU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=exuePPRkYHORpDm+5d1TNrD2cbhPh+QWWReydP8eyM1E9M/5J1L9VhghkHV+bWtj9Hla8tD6Bw5tpssv+ULORNPIjaTp1l49hd0I99sgbwHRRky7c/4id1mISfkLxlKUY44G+NVsP8J4WfXDFVygdjNFqIrCPI05/QIKxGK6WhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASlCIzZL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASlCIzZL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so37615435e9.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754922886; x=1755527686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=haVV1l4ruwZyTLJI9uWQBw48EybJB7S3suEyziq3+IU=;
        b=ASlCIzZLDO+sO0NElguMeTd/B0/bA5xwR8JoiKoGOAr/5jfev5JC+Ncxz6Q+LMx+PG
         bc1pdoT/5mBisvOhLdaO7TzHLaOTsbV3fUVk9jTvtJnncHDlz7CSIXIzxbZdkU6tdknE
         FokK5IzwR059lMVFNZ4RhHAgcVeIVg8LLO0O2ACOKKTOQ6GO3OvWxlCwCX2J7lQ6K5jm
         1Of2oxDObKjDdCHl3z57nJNPi0z6RiERdGNB9dcBBVl6GafsODq1ZivNz9a8BEI+nbVF
         CJPk1/mnsoVXir49TcOFYaRy4oUmDR70B4cspJH1+lg5y2gwXJdgU2pCrKhVCrhkEhEv
         yQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922886; x=1755527686;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haVV1l4ruwZyTLJI9uWQBw48EybJB7S3suEyziq3+IU=;
        b=AA64VaM4Vrw0fGW/X7pLbxqF+nquRb2j6LlDhDiz3OxvQOzmCQmi3kvJUIsAsWhcu4
         D1VzPzoOWue7xmu2eK8fXJ/PupTZaFolg/ym3izMTNLXw+O2Qw39EPi4qr3lqj5Xi+Tg
         dEHMygPR/7GVHmBXWGOFA7d7Qrk3a/7h6lbVmGyqFrBwSxGM8C4d1Gjq6V5gwwWYoP3g
         Ac+rO+mnqC4CsHb01FEb9i2knXFiYU+RWZUSLUNaLzs/cV4rkZ/YAHj0krMN7Y32e+Jv
         RptYtasXuIdNoSAwbsIFGFM9QWT9Lj009JDPRx8ypQBQ5vbaJzi+W0968SQR/vIF5Zqq
         8CaA==
X-Gm-Message-State: AOJu0Yx80ANQJNWvQpl9MBDw7pI5xKPU+RCgfsDb2GC5m3X5CT9IJxpl
	ggi4bhk84UnFqqGVAHpBioPJE2BsB2RE32QlYqR2a4MpVYTa6Q5oYtM5bXAixw==
X-Gm-Gg: ASbGncshPmI6nFC50Wi5rvAXF9/XBA5tD5p4LIDgI9n/Qi0cMLAwORhrui/pHO7zge1
	cQzT3pkzr9crT29GTFJy/GJzwLhEdNm0pOgEN7DY/+fXl38790EpmxHL4CjZdSGNx+md+GBCOWE
	ByQl5QTiTLPsKS1Uj0sraqkPn03ynbGss1ySsMa33lsV1FM+Xi9q29zAhMy0vKz9gf31dDOiAxD
	wq1YJPa+6XE2aygiFZ5A7GgjplNkUE9pcGBfmqNvdi52YPswI7dp4BrUi9S5o2azJVSyLqNdAZn
	DHBTV9h3W16oKKF02osSxmTEhwTaYTpDuckjaqw35/qwcyMRkHHpMJUJIIFvQk0MQgYObDlghIw
	RwgABvamX10V0v25ha626idA=
X-Google-Smtp-Source: AGHT+IEMNP+a6MEMDvrXJaEbmkUn63Hv6Xz7oNkbka9/GOmlI0NNbrCyEhaN5Aen7C29WbpKbRfPPg==
X-Received: by 2002:a05:600c:1d1e:b0:459:d3ce:2cea with SMTP id 5b1f17b1804b1-459f4ea1e75mr104207065e9.6.1754922885611;
        Mon, 11 Aug 2025 07:34:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0846777sm31080117f8f.48.2025.08.11.07.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:34:45 -0700 (PDT)
Message-Id: <pull.2028.git.git.1754922884439.gitgitgadget@gmail.com>
From: "Gustavo =?UTF-8?Q?Velasco-Hern=C3=A1ndez?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 14:34:44 +0000
Subject: [PATCH] docs: update description for '--mirror' option for 'git push'
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Gustavo =?UTF-8?Q?Velasco-Hern=C3=A1ndez?= <gustavo.velascoh@gmail.com>,
    "Velasco-Hernandez, Gustavo" <Gustavo.Velasco-Hernandez@netapp.com>

From: "Velasco-Hernandez, Gustavo" <Gustavo.Velasco-Hernandez@netapp.com>

The current description considers only created, updated or deleted refs
locally. However it does not address the case where new refs were created
on the remote end, in which case, are also deleted.

Signed-off-by: Gustavo Velasco-Hernandez <gustavo.velascoh@gmail.com>
---
    Docs: Update description for '--mirror' option for 'git push'

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2028%2Fgustavovelascoh%2Fgit-push-update-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2028/gustavovelascoh/git-push-update-docs-v1
Pull-Request: https://github.com/git/git/pull/2028

 Documentation/git-push.adoc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index d1978650d60..9d543f823de 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -166,9 +166,10 @@ already exists on the remote side.
 	be mirrored to the remote repository.  Newly created local
 	refs will be pushed to the remote end, locally updated refs
 	will be force updated on the remote end, and deleted refs
-	will be removed from the remote end.  This is the default
-	if the configuration option `remote.<remote>.mirror` is
-	set.
+	will be removed from the remote end. Any ref existing
+	in the remote end, but not locally, will be removed too.
+	This is the default if the configuration option
+	`remote.<remote>.mirror` is set.
 
 -n::
 --dry-run::

base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
-- 
gitgitgadget
