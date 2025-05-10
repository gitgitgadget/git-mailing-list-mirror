Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09414901B
	for <git@vger.kernel.org>; Sat, 10 May 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902082; cv=none; b=FLRecRHn14A4vdXY2+sGVnLmsWF777x+1iMlNxtF+5fugZllZRm5jfxewED2FrARGt/9W83Nw/0kOHlRdEI2ksll7F8sdzB/dQbfPXWrSyyJLRSRKK9boh0G54YCgfEFbEzwZa7i9zmPGBeazGlaNHN+9ighyxP8ImVRhFa4kJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902082; c=relaxed/simple;
	bh=qUdEmOcsSK78+0LmoEnkV88srk/f6lGZyOZsTrsp0Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=er+Mua37/6BL740osL1wi51H6+p8+ZrSg0I9HRJr7CSjztBDkEWL3Bvbj53Glkkin0HhidXYhTrTVM3w76YaJyuiOzGKmUa7FTBv4thcj4q1QTYy+puQghPwyevI3QmjJ+PCHUQcSBp9mz056jEEHtDKK5gm91W6ewM6wDiaaSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKh+QDtd; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKh+QDtd"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7297c3ce7aso2572360276.0
        for <git@vger.kernel.org>; Sat, 10 May 2025 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902079; x=1747506879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Um0zzCa1FFq/KATYKKCbB4J5PX39TL/bcfJfXbrrtE=;
        b=LKh+QDtdU22HWTafUmEEXb85vNwa3mb8SclyBt7JymkAe6eUVhOBv7Ru6zzn1hPmzO
         OaSrkmrvHf26SJ7U/N8SOv00mQjuPxTf9LdNNiFAVVTLqjcCHzMMjTObXLHFqpwZKqO8
         mqJlineVRMcwPz44jvLA9j69DTMhCvIlzv3rRJcB+0XhSWFe5FZgIJRkHeY8whIczs9s
         cwYtKx7BLpAHbwulwoBBSRT8ymA3ugMlwM95Wth6Rq8aTQdgCNMohCEVK4+sbaKZKBRK
         T0/4wfx45J9mb1H3FpuHPCWjpWX8of1QsPHrRfAkzNopr6PCrWvybC1ulO+4CM3DXOaB
         6+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902079; x=1747506879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Um0zzCa1FFq/KATYKKCbB4J5PX39TL/bcfJfXbrrtE=;
        b=rScemNlQMAf/9J2nnozLO7bIytTnYoZfU/cXLYnOYjZ30CxA5nEKwLZ0zG6LgnNUVG
         MDhL+JLtAj1xkf1OpYDA0F+YRS3vheoV5GDFvV84mAhSGE4WbWM72vkXlcr0InzgSons
         X0jvcUp5JPTVqnJcOdqIaqvIfUOzERZkm1cfhFEnnlKmDkq5VkBTd8PnvBME47A+ISuy
         xaGQZ8w96bNc2v9hbjyx/NtcTwkSIYnuv3y7Rau/0eCA37Uh2gxTGAgKiQLpVLHjG8ED
         4UgaP0gjOQVUD/Py2McXG41Nhwsg1047ct22grJrFIsBDAQqNSpluz0Z+iy6qTcFoKY8
         L79Q==
X-Gm-Message-State: AOJu0YxbwTsg4uokzHPwhw5AbwXO77mR3wj05MutFi/opysbZ4J7lW/y
	g0oB5i5oHysiXT5yShmHzK0LhTez0iWcVc5AsJAdsVhYWDmvsNokliihNl+b
X-Gm-Gg: ASbGncvCMYaJT/BiSHjp+i0x4KgJU7lHML9fApZ9b72/PFxd4jkFWYYKTQI7orbFR6i
	PW7ATaA7Ho6auntsusMkoeuHsuwk98mpI0wSAKNmPTIcb4WFeKBA/4u7FKcopStNF1JriLOAbeD
	UjmW3QA70rpIIBmLeVxoZFAvF5KXyLN3Su9/vAOMINa9su1j2GX3nNkm0Q951WyZpH5gS3G293Z
	4nDgzO0SQokBPhSAfIo1h+064WkjfDjPholVyh/yUyRcpQRfTZhysFA4tRWlrGPVxgrfY3FGWHO
	t/T6+HuBEHL5FNzMC0LOb92ApmQTxMjI7guC4yo/9ZAPnGRjEfp5t3D094MYw6PytvQJWme2Zbr
	jn6W8j8bOGDV9ysiXn/nFmK+O
X-Google-Smtp-Source: AGHT+IGB4FEs2vucpUfJxOt9x7oJTWb2JBs4ebaC6HfUP4c4Nc8+iyr8QfocSZxLA37Jq478s2fORQ==
X-Received: by 2002:a05:6902:2508:b0:e78:f2a8:a69b with SMTP id 3f1490d57ef6-e78fdc95c06mr9746087276.17.1746902078759;
        Sat, 10 May 2025 11:34:38 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:541:bcf5:33bd:f1fc])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd4a72f0sm1191649276.20.2025.05.10.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:34:38 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 5/9] t0450: mark stash documentation as a known discrepancy
Date: Sat, 10 May 2025 14:33:40 -0400
Message-ID: <20250510183358.36806-6-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stash documentation now differs when built with breaking changes,
and t0450 is not smart enough to understand the results. Expect failure
by adding to the known list of mismatches.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t0450/adoc-help-mismatches | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index c4a15fd0cb..379da30191 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -50,6 +50,7 @@ restore
 rev-parse
 show
 stage
+stash
 switch
 update-index
 update-ref
-- 
2.48.1

