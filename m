Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2413A88A
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308528; cv=none; b=Z9TTYGxQF9A1IVRb2ch8BdDoLcekHWvnUQ7UB9qnMtdN56uVx3pVIBB5XpnbBkrToOXWov0qrmCCGUWEIar0rTB/CfSo4CjXF3ryNu/5kpvE1I8O0icFZpyDTXFUzSpb/MBgv+9dfMZ9+EB7B4v8+T27hP0FR1mKEYHEKCp2pXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308528; c=relaxed/simple;
	bh=x/o/CT4qkjLOrPHpzVsNZcsUyj8o2MV2Gg7+zjPbGTs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S+VucZ0n1l4OfT0B0NZ3VLN5sx7I5D6OKwsW1VhDnc0UvvYDYLkMHfCKHCdw/M1knv8qlj/24I0EEAw3ybFxpA4CwltiIEmdzEIX1RLdQIpK/fkesr5tIE1gmp+gXgEmWLKtoTZBuhZz2R58iL1iTQ58bz6VC6jDhTdhDr3GQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3dYLUWf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3dYLUWf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4187c47405aso12164855e9.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308524; x=1713913324; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcIcGPosIc+mxAdwBaHIMp4LU33r0cPb7e5LXuF9bLQ=;
        b=L3dYLUWfQQeoA8VY6o97U9qkLZ3Pkugjy0hi9lShyu92DLkz5af59KniF4o5N2/fvy
         hGGgeFCLjtuCpq7S+yxJ/CpfnQuGHOnDaoiO4/P/NlOm8yALpCvX+i1wkllTpt2zqnqg
         mb7s/t6LHN+OLHybz4SSET7DCzvVIHQNGDGaL7KwqwtQDDC2U3NQL2p9Wv0fswYtJKwA
         o+F3+39l8cAn7/ICwpJSoTbxpfUOpqcBfAsIQO4LFdH9G7IHeOKgtgbnNk96DbrS8DxC
         3G6SoCG5IBwtBl2iZs/0sZRkt07KENH3a2JpTs0W43OBzDJnqH9vjq9XSwuoY/H8yYKK
         ExwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308524; x=1713913324;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcIcGPosIc+mxAdwBaHIMp4LU33r0cPb7e5LXuF9bLQ=;
        b=lCiI7SDzZ7j+hHw0C1e6klz/uGQ5Zwog7K7y2pUIhzllFXek+BYg99wZFGCQi7wVOH
         42+qWA4akV9Xir8kVzugQE3CN9uuaEz09tyJqvYu21/yW3l7AyIFTVHfoJOOPRMw8NKT
         3/zI2M5M+ThdbntG9FQNVc4SKbLDBqE4eZsGGmzDq/MoLmCNjluvSrgJGVW5Sj7PHzrE
         a/CD88rCbkn6eROlA0rXZf7sjuTl2PYnhV2j1Zv4otEcsA0T6BBFk/xMQN/i8bhfVfiH
         +fj/9f60nOPJ+MT4uuteclP2/fAYKs9RsKyehE67o/uRmcYdGVeNrcTjAzGJjqqtmzcD
         U7RQ==
X-Gm-Message-State: AOJu0Yw6+JGFx1HypPd+d38dKJiaYcjPIJOwidsMkjNN+8KbHDtQiz+A
	hTkTK5Sjl+Au7iQF+Ez09DoDt50XTZ4JfeX8MABTGkD51jEzpuNZ14n/8A==
X-Google-Smtp-Source: AGHT+IEDqdRM2RxgT9zUDwVfUGUgOUlqf3/mybR9i5PUM7QKG6G1+3GYGHUvgD4eZk5xLMDyir/d2A==
X-Received: by 2002:a05:600c:1c19:b0:418:6138:6777 with SMTP id j25-20020a05600c1c1900b0041861386777mr5038559wms.31.1713308524441;
        Tue, 16 Apr 2024 16:02:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26-20020adfa39a000000b00343e825d679sm16151294wrb.87.2024.04.16.16.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:02:03 -0700 (PDT)
Message-Id: <621912a64fbe0ec412cbef42561fd647de446660.1713308518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
References: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Apr 2024 23:01:53 +0000
Subject: [PATCH v5 4/8] SubmittingPatches: quote commands
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a27f7c923b9..b684bdd03a1 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -403,7 +403,7 @@ Before sending any patches, please note that patches that may be
 security relevant should be submitted privately to the Git Security
 mailing list{security-ml}, instead of the public mailing list.
 
-Learn to use format-patch and send-email if possible.  These commands
+Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
 type e-mails) might render your patches unusable.
-- 
gitgitgadget

