Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D022256F
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871558; cv=none; b=mjwRB4t3ZzmZwXKbNdE3DRqqhZ2EFnFVlsMBRu5uZwlQNA6yeFzzEbMJh0/stRk84mpW3mqCoNd6+j6Af21St3C+bC+qw+a88hoBpC33Qr671SQ/FY4PEb+ETctd1nYqWT/2s5Sa55/vG+flB5xE8CiR3ISzz85+fO+j5vypqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871558; c=relaxed/simple;
	bh=Az1EmpzrTGdgPcCaxCDlwyTjp9E3IbkaWag1J0HmTQc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cATGDckSOMvnWBlOVpUVXtoylJx8ML4Qmdp2IVOr/DSOUjzkgs+g5UbDGBBCsscjMdH+724Bvi30/aLzOVvXx9i21fQMyT5b4vgEgbTGHCaQ5JgCHIhthdHjP2lpfqDAsNMMvKjHd70MKlLOsCFH9Xg9zGh8U2BP01YX4Sfzb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmElGBee; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmElGBee"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7331529eec.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871550; x=1777476350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0xpe4rdiGBjb6BuGD+QuyBBDw82WfvfL45Lch7FTAA=;
        b=kmElGBeeDwqJS9bIkHhJ4WstRrGJobJp3kDb1RiesczAISTcG6Ps3l+vakdVvwOrfc
         s17KeVjk2YgeBbl9aeFcvZNNiEs0KW3bT3bco9184/cpGYiH2dTwZbzM0Kg1aXZD/nhx
         Dwe2hYoK0rpZRhwGJ0ELnzIHdJ8TwRVRna3ytfkou9aUZKcNFIYw5vdazQwepGoL3fQv
         eQsB3XYg/6uNAoNR6SiUxLoN+trm75Ypj1cJKCBjnamsC4AC2UP8JO2T1WyzycvFm1DC
         cN/bsFVo6bpf6TR2U8VT8MWUiu8FBjDmDnV0jAgPKUaTJj4w/4X7X4SEGxb9GFm3Tu0v
         0oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871550; x=1777476350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0xpe4rdiGBjb6BuGD+QuyBBDw82WfvfL45Lch7FTAA=;
        b=fkw5JRVq2NH/i+SmJnK7V6OweWm0H91534nPqFzNLAqV+8Cz+TUoorUUDK74xZ/P3w
         WvO98T+tkAJ2vFCwAw7W5fz3oUI7Is83Op2S+GCuRIxgxNUQHeKPWDjCnVL3Siq5t3TP
         BzY1Hof31dEoaMPYu+C6XDTyn8VPA0YZIN/yptSONF76OSYxUO4gy9nw2DXQIZiafrcK
         nAip2FgQ/ayLBjVqep7VUgeJBxxwlVv19Lb5yCalxoVQ5NvYSZUX2kQguTQRJsA+RgFA
         A4kkK/xmWYbG0Tslq45QrSatXeBmXBuFckzpSa8chH2vHKoF5YkvZsozfDVtHwgmOACI
         BehQ==
X-Gm-Message-State: AOJu0Yxx4/i03XHOAO5txm9EzsQcUkyk26iG1RX2swQrHYVaYkTf1My9
	dgXp0Gnk4K/WngbwLiRQaIe9+ItYXbbupIXwipu6yraXZbY34G3nqREHIFUuTQ==
X-Gm-Gg: AeBDievGAdqFPxosAAidHJu9GMyt6dvdw7oxDgmIw8CzRCXyO3EjlQlY+3rNDk+rAXC
	0ChReQgaXu2SLW9IfDaQd5b4Ktkbr1y4rOw5wQ57ghNtM2wyM25UiV1MDvZhWN0SP0azbfv1+6N
	Ew70ck5eS/tJGxzMaC3+cBEdnY2F0yKY/irWHY/oRHCIhQqE9tK/6pgGPrdzVz+BTzYk46WY84g
	sAjKL4niXmuJVA1x+5MGnEq9Dti6yICLuZqd3KbVUb07jBmSZHBvKsW52tLOeXKSGJ+yuV138B6
	+S/jJcY5qY1koJdfT9OH2YVPuxAMnOpZOZzxcCYLiTJAWZyMU6aiXa+8rhabMsMT47Gik/4Vu+E
	nFqTI339uAmZ4BzN3E+F2CygfTUR6BbVqHtKELltKDrV0XWxcouD/W0GnszP+gdb17wEqScZLUv
	GnDbWJu322NqEcmfPJY7IZGQF3SaeZsc/Kz3g9aA==
X-Received: by 2002:a05:7300:214e:b0:2da:2ec2:64fe with SMTP id 5a478bee46e88-2e478c20853mr13310515eec.24.1776871550164;
        Wed, 22 Apr 2026 08:25:50 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm29748444eec.8.2026.04.22.08.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:25:49 -0700 (PDT)
Message-Id: <466c56abe002ed2ac8cf0da2d6d1d8c288cd232b.1776871546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
	<pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Apr 2026 15:25:40 +0000
Subject: [PATCH v3 1/7] t5516: fix test order flakiness
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'fetch follows tags by default' test sorts using 'sort -k 4', but
for-each-ref output only has 3 columns. This relies on sort treating
records with fewer fields as having an empty fourth field, which may
produce unstable results depending on locale. Use 'sort -k 3' to match
the actual number of columns in the output.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 29e2f17608..ac8447f21e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1349,7 +1349,7 @@ test_expect_success 'fetch follows tags by default' '
 		git for-each-ref >tmp1 &&
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/HEAD|p"  |
-		sort -k 4 >../expect
+		sort -k 3 >../expect
 	) &&
 	test_when_finished "rm -rf dst" &&
 	git init dst &&
-- 
gitgitgadget

