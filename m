Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509666;
	b=conjytMyJYzSGZYk6fcPmy19lE/8vV7HjKYle47db6O8QAzaWnMDCNnWsR3ToZDL7OEW
	 iMwKxMVD5pqc+9r1Od2Ac85R2wrrBIkZq3Xrb7/90bscZNveo2uVodsuSJwOi6zDQcSp2
	 A1Yc7i/ZgSlnt/oS4UaQf0tkHMt/H1mltK2wYLmjJaAjSsravkIn7SvrUEeVAvfCfKhLg
	 EQoro3itZ0fpfG3lpVOx76R/SyjiETMGIEFvLtWQUZN2nu+6j5yTTe6PCwk40hu+cfSZ7
	 x+dW2WZdide2aCmk1IHT6DVDByrlWbrzP+y8+5h24gEoQMKcHuhrRDcbiDwOvb3Adsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wZCULKk9XEVS3QtQM3CfZBztZe09d6wEHX06ppj2zCM=;
	b=zpHk9dVYnxb/1yUMlAgu1y0zv3ImFG9B9KVzPpT/az3oVSaqJIsnX8cpUvkVL1qhMWqo
	 RJq21LxEdjq214jlV1EFGn274cVBMj82dprGDdZNrAyIR3zDjaXoE1BbYqnWkSkDrdC6W
	 4llKUEMtbFeV+QE6jKLpnDq8+uVHlBOGTkyvUwS+QTa3U8nUkt2FZu1WygEUbP7MNBnAT
	 4FWmxfZ8Xw9VRYaiuSLMdUD6naLj+qqhG/SBGDdF77M5biH2rz/YcBla+raFsq99+4keM
	 otne18AKoBdk2ip0u0xYDDUUW6VmpKRsHkQdTl8p3cBFzNdzvpdPjhiLF5Z2PpkHIAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lJYFEGi6;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38F60A2637
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA38F60A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lJYFEGi6
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-487049569b6so1900733f8f.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509664; x=1793114464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wZCULKk9XEVS3QtQM3CfZBztZe09d6wEHX06ppj2zCM=;
        b=lJYFEGi6s6koFC4cRclSg+DvIaB7Ye5oLPb9DEfcDsNUwqIRiCqmhA+Wt3fUpPomPs
         dXB/6LS5Jl1BX5+moqaW2zC4DIveilBKojttuzz3tt/+aGHZnVAQAuTMq0R3bQoYpo3g
         D4H0UvvbN4KxWj4ECov3qg0rid0T0EwTQyUgDIWaKw2CYVwFRUKW74hwuEuxQY7PJhtm
         lyZT4sZwefMLzh+f9S55dtW/TOcVp+gONWGQk2KWAb+9SOvx4PkdZBeyriz5ULSiDZpt
         FzlDZQBnHKLZlwgHLGTbFrqdgl23TdMEAYDWUf7dcSx65sPKFFuqAH9tJ/eWMfKzMh6B
         /IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509664; x=1793114464;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZCULKk9XEVS3QtQM3CfZBztZe09d6wEHX06ppj2zCM=;
        b=zY4xToEmNS3EqtokM0BLUtawbKmh7F9tVrBwzw6cApXiEUn6enUCRgt35onjj3TK0g
         tnzOBg64WLLcIVruheKrWicE+1+nVD8k7+aa91u/XTjtMyIp+SQNyPfWBC9EDesbdmPt
         Tj2q3T+TwFf1+Z8xtqjlAnbwkUA5USUbe/FXRvgE/EirmKx0cGJQXSTl+RbZ2OLuUg4p
         +fBKe+hhFbLsyHBMijCM//bnvgELYqxWM8cqr2TsGnFGsiaEmW/LuOIASdgartTVtvwv
         cGlW5G5y/yFTj85b4GhbasEYXCzBarckDky9q6MYrEg3dfy0oO3CXEzF16orKrfJaopc
         PXvw==
X-Gm-Message-State: AFq9FYI4uxiSyR91C2br6Kd/EmcevlWm/T7Fu0QXdOkLXpm1ak4s6XvM
	l9eEkUtVJdg7Ofg4Fx7FrmvxRxQVygJ3hv343ZMmtFK40NebLlzRQL+8f0Z8GA==
X-Gm-Gg: AYBFou1dYUe/1esOJ8vaZJ4rMSzMfqbP3nW37wMDpSIn3dXy4iV9mj/xEmt6gHIHLda
	bNKqR8qbsbG4jCYf6asrJ4Dk2b3zltZYecG7B40nCTmtMUh4ei1P9tLkUW9U2Ryv7mC5WhKv3wy
	iddDf65PGYNRWfjQzgThqPtFKcqRRZiuaaLjl8tcQbGwbU668BnmJNcsxxGP+gh5do2cs2sTbSA
	fOEbXHtNODo8IbmfIrW7w0YOCU2gCXw4gHsXwLvpiOh1xGfu8GWeEES6Sh4mc8Ga9pm1qAG3TlV
	o18cGBSgsHNMbYBtVNylp+y6YkXeQMFf4wg5n2oi5zmVhU+28UWjZ35NFbVkPMx1XZRxRrR/Xg4
	0delL5XbPWTD94JEhmivJPXNf7TJy9QKYXvTDZuADWep9PIDDFeBGQO9IVwS/4eAFg4NSU75OSg
	Ko/Jy6SsIJv0bTmHOAgJiTfUcmFrefDaZD+xJXY9WjdxWfbfkStOpqin1ybeWxGZVtx5WKPRns3
	6A=
X-Received: by 2002:a05:6000:29d2:b0:48c:7386:af18 with SMTP id ffacd0b85a97d-48e079803d2mr15381397f8f.8.1792509662468;
        Tue, 20 Oct 2026 08:21:02 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823ca7sm6307355f8f.38.2026.10.20.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:21:02 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 6/7] stash create: remove unnecessary index load and refresh
Date: Tue, 20 Oct 2026 16:20:41 +0100
Message-ID: <61e4ce22a0fe228047c666c30d814b2541c8e932.1792509606.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792509606.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792509606.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

create_index_from_tree() is called either directly or indirectly
from do_create_stash() after it has loaded and refreshed the index,
so we do not need to refresh it again here. This saves three lstat()
calls per changed path.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index ddeb5a5d2a..55916259c3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -384,9 +384,6 @@ static int create_index_from_tree(const struct object_id *tree_id,
 	struct index_state dst_istate = INDEX_STATE_INIT(the_repository);
 	struct lock_file lock_file = LOCK_INIT;
 
-	repo_read_index_preload(the_repository, NULL, 0);
-	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
-
 	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof(opts));
-- 
2.56.0.134.g299a3c16181

