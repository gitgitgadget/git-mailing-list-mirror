Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29E13A410
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308526; cv=none; b=PLjlc9EMqhvG+WJL/Nsngfx8qZksHOZ5p6vNA230J4mgne/PU/HFJvr13klGtreuAdyfPYaDnEt48aRy6jKa/KsE8toBuCgXPo43h+Hwf4XMZGgByiR6a205IH6kyMfT+Jf8CWh6anvMBqruSc3ItYbi6FzSQN94W9cS2pVL76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308526; c=relaxed/simple;
	bh=GKvQn0S/xGBDGm5jgiU0AKvesBhwyIahDxAyonj+jj0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rc7jEloaznWPihqyItzPW+zSvMdzJ0YkxCHRGhvCM1aGdudhUuMX/iYn1jyes6AD7l0+jZaARydChV+Une5JyG9OJjbKtfj9Vs4/4/g6j2Qt2CWnai9/QvyfD18Rkf/sIiZRSamb72mevAFnBW1cDGRgK4+U26oytBa6lBHPUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzGGk3nB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzGGk3nB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4187c47405aso12164745e9.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308523; x=1713913323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuQ4UGHaaupgIuS5pZX0/sf8mod6lYYHBQMg4k8s9V8=;
        b=UzGGk3nBWvq16DSfmUJAZ3W04KZMehjH+M8LUBjsEMuV+ypvUYNd3ye8ac3XVEKxCt
         wIFea9GrQ/LJpNwumLo9bAkJeboFIJhJAFwT01TUGPB0x8sqwgx408RCnOQKbMi73/+B
         wsqhS3GH/PN07EayjCJIgSe3DG2E70puK8fG1YA53lmKOoOhkbVL1o3i04YH9xkHoQOx
         qaBf6X/3dkePXBr7js//elytvQjmcS/kcaK6KytGKmlM2tef2DbGkzn6d8W0eWUip2gX
         cENeRu9ZV8DrgmoM9qE6pEU23EYfW7k9Z1ystrnKj3hGZipkoTrf/VP4sBpyizkhi2/u
         BnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308523; x=1713913323;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuQ4UGHaaupgIuS5pZX0/sf8mod6lYYHBQMg4k8s9V8=;
        b=C/X1wEKwcmLReMFU7+Vta+9RP2klVzqbUwHJ0CkjigGFDJJJfecHXMzZnRGI5II8+D
         gLbbT8uT9sj0ejnGuyHk4FBQbyHv+I6Eg4GsnASmugz0/OT2vOehzOyvs7btOAiMQhfy
         +7qZBwxBfpAgtDElzrb8BpQJzAgLvtGO5WOww/B3KNDG0iKvL0XCZbHpD/EsXol3JQlt
         7d0G5jzdMNkjIcw8obhxPvFlSIb9m8cCys0M++pl8HkHlyMNnsi6KpDGd4Ix8mMFDgJx
         dhUSjpFS4tM/4x6FLyoUkfEFI7W0xgqm8KLXrfjeGlMgHR4tj4qtMCBp/fLQCbYq1BXS
         msyA==
X-Gm-Message-State: AOJu0YxCMrjQMVk1KgFIaC3z/0ivUQTBPqMUP7WVNX5xxD/QUpWS26pz
	0FNLD7KGOD3EC8hadNWE9gYn2/U/l++A+Uwcugq1i3GOIW9bKNXMXt9NLA==
X-Google-Smtp-Source: AGHT+IGzb0rbcJPFSL4rz3kWPqOYB8P+QVYOyDso0HyW4jllKMAe16odL16+VxB0ZQyhijKTypWY/g==
X-Received: by 2002:a05:600c:470f:b0:418:41a7:d032 with SMTP id v15-20020a05600c470f00b0041841a7d032mr5605917wmo.13.1713308523242;
        Tue, 16 Apr 2024 16:02:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0041897c6171dsm400203wmq.16.2024.04.16.16.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:02:02 -0700 (PDT)
Message-Id: <7c4cc5a91f0ab09ff46179aaa24562fb0a0e9706.1713308518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
References: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Apr 2024 23:01:52 +0000
Subject: [PATCH v5 3/8] SubmittingPatches: mention GitGitGadget
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
 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 0d4276c6c7e..a27f7c923b9 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -408,6 +408,10 @@ are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
 type e-mails) might render your patches unusable.
 
+NOTE: Here we outline the procedure using `format-patch` and
+`send-email`, but you can instead use GitGitGadget to send in your
+patches (see link:MyFirstContribution.html[MyFirstContribution]).
+
 People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
-- 
gitgitgadget

