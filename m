Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA552F83A2
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960593; cv=none; b=UCIycU1Z2AOknQ53XIoGRtLX+i3cU/G6cbkyZQIwVn6ENTlmsSfCoiQ1F/JnxVzfvEnw0H00k1RJ1FaZd0Ec5t5C1tVoNyFW7oGNJI11P0YCegCL7WfLzKfNjOlENZ4VvcdoLNhtYgtpieTMuy0z5pPP5sLzphTh5FqtscqTy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960593; c=relaxed/simple;
	bh=hSx2CZwpO7RKO+qqNffZQuiz1moqQVVpL6qiQ+0M3R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8K1LsuN58Ze1uDCv/daWbXFE9eIwtssBhvZyWGqQze/lCy5Q4C0CojaSbN9BRhBkPojZKU55NG/T7K2YwFMSlbiyHnhY5jMUGKrA0EW+/6vpM2acyEb1g5RbrjhFZyzo9rwFfUTOwk/pY4bo23/SRrYzZ/gnA5/FTuz9oFiWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lkpp8iuW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkpp8iuW"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ee5037d44so93417537b3.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776960591; x=1777565391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POiIgpjfab4vYD5iBW6bkM9av1l5uB1iMbDmv4ef6HU=;
        b=Lkpp8iuWZFviE0TywEKfbwDSklmmr2GDMk9cydeuiEIfG6q/4Mlj8eoDuHk4wyFs5s
         jhHSSYToxgvPVUemKmGaCpKk/ldBHZ05ThOMyVWjxfKKC2biUB73EGhFMpBdbxmDn7si
         ZJXZzRh9U809AVp+/7TMGGHgiOJwlTRqFOBrSyXd5Ijtf+RkWTrbMAa6hHR+WtuxHEj8
         8Qrw+0eClTylMDaJ9Oq2S70I2ppFL79I2g5tEcrr/vwPXzctZRVbXeNLBFMewcYxLX87
         hHfXwXtZLbAeZy47wPGMF7kbJJceOP6LUYwZ8X8vy625oxt7j5zuCsBKbduQmH9nSOSK
         7vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960591; x=1777565391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=POiIgpjfab4vYD5iBW6bkM9av1l5uB1iMbDmv4ef6HU=;
        b=RH9qIn/Dz+WbUlkbRk4Ib6XCxOUVTJEj3vR+GUOxKkRs/xAy7VXdep09cv59/4WNHg
         1JcpvoX0Puj4nJ4drQ5vSsjHNbi9dBxuUehOm1jqsGpctNFflHiZYAHZPEGXO/y6GDSY
         ZOHrUX57U76zdGBqrVSdNInFW2wWMd4ujbApPtbkcYinqEwbKSkUIvogANgIoZJ/AuPw
         fdFvBKWkE8MZyqbjStrcO7bzG5LFlcadZqrS/di7D4vrcwewCIxlQswN7ZtN7le9gNSN
         QrMXeymh4Swy7vacw7NLBA+aM263KDTSqNDOi3h6tBhhX6dsoAT9q5PVTOhE3nyUR2Ly
         6xGw==
X-Gm-Message-State: AOJu0YxmcwpML4Iq1YUnYZeFqx0s9EqdnHX/mGZTYGg1Brc7IsRTwoR1
	nz9Wbsae6OTTF54Ng7fJ7a9F8+MWA8AHWOabNMWlKJ3dgFRvbTL/MP2WlSAjrstA
X-Gm-Gg: AeBDiesRb+3GTqrk5fdXfDNSwgUrshflJgmnCkXVG9F5PfGcRAi/bGQH9+FE097PVqu
	Zt/3yDN3oi81We9GPuW3CPwMDVwX1IhKcOQArnh9vyu2Mod5UrnAOw2R4KPz+14N7zBsxbTXO2I
	vdG5bukj/WsnQlDi6kkwNFUXC+bz+r5goYNpZ8BtJesMpSa8BaJhJm8IahUXpRM/MSq9rIhiIdN
	/UgmlpbT/r/jaYe+JYmz0322kSXaGhXOMPLK9grql7vht7/cC9B+FI7caLhJ7XmGnrhrFVr1a2v
	xPJSbyGvEsFDkuT7pDLx58k0NnB+U8s/2+M+udZnMnBQ1Iw/xlzLTv/+CYYnq1ACOOqEwC/p96J
	FgYKWCmysHa1KTcE2zkLaNIsY+0zQR5jqr6+6/bMpBEpm7DWGu8u97xDQt5Lak1Hj7c4cbj/dU9
	Gst36mO27sBXTiGS8h/CF/8t25II19IZYIxyDqj3j/RanfoZWXJBuZhVuLd4qOhnuHazMfQA==
X-Received: by 2002:a05:690c:348a:b0:7b6:783f:2122 with SMTP id 00721157ae682-7b9ed2eeec8mr205176657b3.9.1776960590844;
        Thu, 23 Apr 2026 09:09:50 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7baeeaa2cb5sm51083997b3.21.2026.04.23.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:09:50 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v3 8/8] Git 2.54-rc2
Date: Thu, 23 Apr 2026 17:08:32 +0100
Message-ID: <20260423160832.114816-9-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423160832.114816-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423160832.114816-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9c55beb496..fb11bace12 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-DEF_VER=v2.54.0-rc1
+DEF_VER=v2.54.0-rc2
 
 LF='
 '
-- 
2.53.0.155.g9f36b15afa

