Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338E16FF42
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264778; cv=none; b=Yczmyl52LFf3hTFbfUfO6Gn1lyCclsaTvMfn7qUmKMdLp4aOUk8TqT5LBtV76POy0IFi5QGNJVTs9Onpg+eoilojc2b4/dfEZVYnElQMjGNiozfEjDGEsC4xmrQFF/lhnSB3suz1ijCRw6NWZlO7dsHI+RcyiSyQ3BfsgaDTRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264778; c=relaxed/simple;
	bh=wPHDbWdtBr8SmtXgjYOKy2AKaddHjCOuDTtt46gyM2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjLsyFtUp8V0UvYFT8HmLmrg13lVLpiygbMGWK5Cs7un2gWytq/qpkAIFK339xaZsBS4WZG2xquOXvq3PEz1Y913tl3sMOzNXeg10U/7AQv2ysSqdrzDGXTISaOH+HDqik+tlSes5whGVXrY18i7ygnSVUY82LyfevJLkdJ7v3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBBIv1cD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBBIv1cD"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1395803a12.2
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709264776; x=1709869576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJQu8fxGN/HJ9AmFqhxW/GfTQf5HbC50+/wGcKW2Eu4=;
        b=RBBIv1cDDB/R8o5nhs5hN2FBdVphGI76LcFeHvgAi1Yn+DDQ/GjYR6wGJ9Fg5o9+6x
         Z4ys5LIuoKrzvyf6cjS4RVFrJC607qGeAX1XB5EeiZkY1ZSbeufiTFXz7QD3QAC7XX7/
         md0y8d83n55yD7AtxRZAEWmgdRR+OTcGWLXCXf6ruklFF+BtfqyVz+XMyojZpEULkakA
         fjhyJO3dBdOydsgjT+b/nTExbeLnsnKJ8VrBswg1R5j4vFJXaWG40GDShJjjCBR0/mI3
         if9da38zDM1A8MKl4W581xzkdUAEnkAnkn6SY2if77rdA8c/2e7biaBxaQl6GzSDBX/9
         WwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264776; x=1709869576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJQu8fxGN/HJ9AmFqhxW/GfTQf5HbC50+/wGcKW2Eu4=;
        b=D+JupM93GYGRzsR5fCY4Ih4h0y8v1FvvqjAafszkwDelJWqX1ObF4PvYaz6DSNJ6oL
         5eJ0SDmAI+pf/gyKDeKPn/Ly/b1rinnUG8IRSSrAlC8yh0OhaX6u6YTjA2X/hJRIlwBd
         z2BtiSN+V+xGQswI1rowIqEEsaCSNTirUFhlVnvTIUsktpGxQl6LT0Vdir5fZDqd39O3
         89xWRL1MLOG13y4JUjfrqm0Cxvze7McJg/emahkRYeabkA93MJ89snB4grHa7VOvldWk
         RLDeO5/WAp7EI6ef+TXkY062BgUMWy5/gGBXe2JP3dfunIRudfXA/TdN6vckvQcZIokG
         1RIw==
X-Gm-Message-State: AOJu0Yy0Rpg4ga6jlXv1peHlDtFMCYncUjgZZlOyzOUbY3bPcqQ9D/R6
	Bk8912suE9lquloichOcTDESjlgwmxTqwgaWynMnbns7wjyauf122F95tb/VjLIrfw==
X-Google-Smtp-Source: AGHT+IEO1stipsv1km8CCKo53+g3stwKX8R7XvvQ8oyHekQFmCitgGimsIVgnpr7XijZ7lDTFXqfDw==
X-Received: by 2002:a17:903:11c7:b0:1dc:6fec:15d8 with SMTP id q7-20020a17090311c700b001dc6fec15d8mr609363plh.47.1709264776315;
        Thu, 29 Feb 2024 19:46:16 -0800 (PST)
Received: from ArchLinux.vdiclient.nvidia.com ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902dcc500b001d949393c50sm2295746pll.187.2024.02.29.19.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 19:46:15 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [PATCH V2 0/1] [GSoC][PATCH] t9117: prefer test_path_* helper functions
Date: Fri,  1 Mar 2024 11:46:05 +0800
Message-ID: <20240301034606.69673-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229150442.490649-1-shejialuo@gmail.com>
References: <20240229150442.490649-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed, the original patch is unsutiable, t9117 is a good
candidate script.

shejialuo (1):
  t9117: prefer test_path_* helper functions

 t/t9117-git-svn-init-clone.sh | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)


base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
-- 
2.44.0

