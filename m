Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9A263F3A
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239305; cv=none; b=OJNn3mGGWzE1SLR4X1sWf7MFtorWwWxMZUnFBYvmWD1q2S8jNZLcMfYc3R1/RL9+W4eeVS4OssZmEt71qbfEitWs1b+DmxzS5j/ni5rvlBRT5Me4dwi4eitXny/qpZrTFaSQzIJa/mPBfwnJOZUX/nD+SdymuMILpafdo5Vi3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239305; c=relaxed/simple;
	bh=EfkkKWGbKsrMChDYtVIMnIyRwSsGqspU3wNts3ZPehY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jUO90Z4I46GSxVqDNp7HcN3PlzRQyntVDCxeF6HKo/E7wg/W1jkETJ8fUDww635X7pEmWOVl+NKMGT7xhMueSitovNENGLdORie/unahQacNRocfBiAeNVjVO+17lGlZzFHkh97CKPZircBJk5mYjPUOVSSXMfnJnGxmIU7xZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUIxTcPc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUIxTcPc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so27159305e9.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239302; x=1745844102; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gc7xtrIyj7M0mkJ6eE7OY0115hOVp91VXkcyCHCNK2c=;
        b=LUIxTcPc+GSC0MDYKzj9XPQl0qtIaB5eIL0GY3NRviU2o4tb++mRd6s+cZCzaWD7TK
         KelvPRTkHBPQG9ccT/qI6B/DyZuv843D1Y9PVDZ54gtu3ZeEaiVIOvRYCkKI4fWp8dYl
         r3Tpsf59xiGqMpUcdc6MksW9QdXfckSc4+PKHHEtTzgBZqvnriwcYsh+HTp2IndNFCL5
         gNbGiPws3805bw2ANjkRmMoYh+1SaPof9b3fKFVDfilvXAFK7IoQWpTgki87dY2+04aY
         AfP/pnC15bm5qtLieQQiguGM2pfTYnsVjQC3eI7FB4g2oW7UUon5OPEWL46UOLFcqsdP
         GwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239302; x=1745844102;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc7xtrIyj7M0mkJ6eE7OY0115hOVp91VXkcyCHCNK2c=;
        b=MKSeZbH51IUhqvLUiVslssyGZiHdcMxThgbLD8GNYl+WEwWAqcIykkqD0bXlf/eYoD
         7a8xIuQEO2Z+3hPmIzFrxmPtLE2mglMHXJjFr5nsD9FRPYBRbzPOKT98BZOWaiqvVCKL
         iPB8nFgw5HGxBZZMYkcb1aV+IHqVpxd0za2aHecwmNYTfB6EfMsB0W2G5z5cfBk7hABs
         EPYTrxewkZi3YhmJ5YhwDplhtgQFviNinjq1+94Ir286ciHOE1UXxWjMTNJZXOpOEjX/
         uGZd4kRiIsdaV0dtuKS6d/d16t0tq6rzdsRosrweUcxbuKQ/DxSjbG389yAvSye2Ol+V
         wmeA==
X-Gm-Message-State: AOJu0YzK/6WHCI+AFV8LV4v9dI+wtr2acHr7BUkmdlTavsTbNuc+olHj
	w69d17iXGVQDVyjWqIoIRKnFsi5gzAfPGqYSutwa4QaHECaS1dORFyUiJg==
X-Gm-Gg: ASbGnct6A9GjHTj4E3b9lxtd848FKx2ZPXugibIbB5Ggti/j0HEQFwxwU4+tTlkXiO/
	cjYrmbyuNmj8Mmbl33Hg2ogfru1sncOYvO8JO1eYu8lwRq/qvm80T/MX5dN0secyBMZXoT5m6LR
	Ux6DfMxeYEU4g6oFOMe5y6F/oBtVVxFxoYxwwAkoDZ0CbqIY7yge5FTh38edVllJRmsmesQ7S/I
	krc4M8+wuvJHIxsO+zMSye0d8CKTiBshZw8MIVxb+63AtGVkVFbwrrQVbYRMpTBfjwQaW3kCAdC
	+uKfSxCB5Nj2LMSIB3CBSLYHy1B/zKnSe5NLQ4R5AA==
X-Google-Smtp-Source: AGHT+IFmd8mBAGO2F16cpO0htNlvwFU2K6Eultea/NlJwxUKZx8tgiEapItJGqgq9iTmhhjVvMKMtw==
X-Received: by 2002:a05:600c:4e52:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-4406b1f1cbamr103074105e9.3.1745239301615;
        Mon, 21 Apr 2025 05:41:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbcb6sm131685705e9.18.2025.04.21.05.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:41:41 -0700 (PDT)
Message-Id: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
From: "oneee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Apr 2025 12:41:40 +0000
Subject: [PATCH] doc: sparse-checkout: Fix list markers
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
Cc: oneee <kimww0306@gmail.com>,
    onee-only <kimww0306@gmail.com>

From: onee-only <kimww0306@gmail.com>

Changed the list markers from a mix of "(1)" and "(b)" to a
consistent numeric format "(1)", "(2)" for clarity and consistency.

Signed-off-by: onee-only <kimww0306@gmail.com>
---
    doc: sparse-checkout: Fix list markers

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1948%2Fonee-only%2Ffix-sparse-checkout-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1948/onee-only/fix-sparse-checkout-doc-v1
Pull-Request: https://github.com/git/git/pull/1948

 Documentation/technical/sparse-checkout.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/sparse-checkout.adoc b/Documentation/technical/sparse-checkout.adoc
index dc2e763bbec..8202172b70b 100644
--- a/Documentation/technical/sparse-checkout.adoc
+++ b/Documentation/technical/sparse-checkout.adoc
@@ -66,7 +66,7 @@ sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to
 	reasons: (1) users in cone mode specify directories rather than
 	patterns (their directories are transformed into patterns, but
 	users may think you are talking about non-cone mode if you use the
-	word "patterns"), and (b) the sparse specification might
+	word "patterns"), and (2) the sparse specification might
 	transiently differ in the working tree or index from the sparsity
 	patterns (see "Sparse specification vs. sparsity patterns").
 

base-commit: 4bbb303af69990ccd05fe3a2eb58a1ce036f8220
-- 
gitgitgadget
