Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88544D135
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878352; cv=none; b=HdnoFqVj6Cw0HM54khOb8ba0vFC1vOdC8ItzlOE9D1GdpI62TsgKfDiP6JBUFik/yZBDj1i2EQLgf934Xd52wkLvsKKtvjI2gVbD6CeBroYpc7qBdJtOuqrgWzlfXvB5Rzny7xvFSR+Ctfl/vq5yZastm7fDkFREU9IEY/Ke1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878352; c=relaxed/simple;
	bh=m65Lyj4qOKzezlQEAP9zCSgUvtX1U62ojZ3VjLrkWzY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZVrjMYdjsk1Q8gnsuRJZHqQ9j5gDFAtxPY6u4KHoiT7T1lqCMhch8Z2KXzPI+z0yjnF5Yc2Kqj5UGRwdQklpAa60pNoFbXDVm8eBvebHN+IpqdUke6Fq+ep8LVAAfuFn/jIOCxsByxcj0wMPFXZFvCX1oTdz8ywDPihN6ngp98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoQkr9YM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoQkr9YM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-417e327773cso5467585e9.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878349; x=1713483149; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j0Cobwn8pOLHdBx5HncqmKTqtmSNrQN1DDonsyvETw=;
        b=BoQkr9YMhEzQy7O7i0yAZvkvPCbGN75N+1grnFLOurZvO+rO3ZfSGqP5Z6J07UJxRU
         wustxYrbaWgLMIW7B+TkbLWQyLc7tTbqc7SsIBUsi23b2ZPEKBHfzU9eit/DN5JsGInZ
         SpAjgUAjwixScIE5ApGHul0AwY81P/2YTi6DtG3VvETx4g8g1VbDLw+04wEy4N0FwWW/
         Hg9B4rh8jRmZhCZsSNIFYUn6908A52ldot8izbE7L9FN+XJ+zntoGEHpXbwE2x0sygzZ
         xrZorC8YD7u2o7BWrhj5K52FP47I4wW+IZ/fc5I71JNAgkE+QSzLlsQ6o1Q0GU1B6doW
         29Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878349; x=1713483149;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4j0Cobwn8pOLHdBx5HncqmKTqtmSNrQN1DDonsyvETw=;
        b=VK1aP7f5cdjT9uVFDq4N3+eokd/wgbQIMM2xaWOX9BMVrKzZtRcyd9hzDOseQ3HKMQ
         iIFwThxI+kzRnBfEGClTPNLzKipdDGDQ64EMwf0fopTpwz25w9ksZchmAQNqrVW5k3ef
         kkWibo5OkT5Yv8sSimwi7i7Ns0uCexi61cCnNVMl01GGFUV2V9llasuayrhBuasDd4R4
         v0uUEMmy/nQmre0dmBg9Jut4SFZVru4Gi2GE7xv1sSp9djmKItjSK+V1DEb6R6lkGTzv
         dLhvYpyA0aL+RCK06jK3s9cwyTbVlPG/gqC9cAUOd5To7H8D/zfoABMIiJXBLEamYYur
         rJJg==
X-Gm-Message-State: AOJu0YwnqLgg3HT+RNdVmh8Ti5/ZNh8wndaqaqa3xZ5SkhBehMm4tu+T
	lqr7GXAf5La+BXH7TyU5cWt2cm2bf2pmkLDtSDuVrumT3A99AjgfGoktww==
X-Google-Smtp-Source: AGHT+IEuhLQmamEjjJIAk/zpK5lAOaNcMqrAvcDor216nxm836XbA6BWouCvOiFboed9716dC/4IZQ==
X-Received: by 2002:a05:600c:5110:b0:416:3deb:e3ef with SMTP id o16-20020a05600c511000b004163debe3efmr793407wms.1.1712878348773;
        Thu, 11 Apr 2024 16:32:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b0041680911b0fsm6981554wmq.30.2024.04.11.16.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:32:28 -0700 (PDT)
Message-Id: <81556298599ffa77ba6bb1304d19afb2b4df079f.1712878339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 23:32:18 +0000
Subject: [PATCH v4 7/8] SubmittingPatches: add heading for format-patch and
 send-email
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
 Documentation/SubmittingPatches | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ecc1622c8bf..fd40a444f95 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -433,6 +433,8 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
+==== `format-patch` and `send-email`
+
 Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
-- 
gitgitgadget

