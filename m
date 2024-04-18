Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920C199E89
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477134; cv=none; b=imAcd7KUeBYnupp3yqP5RVSY0rMTk5UPSJHnrNqz3+MiSIiHYtK5Z2g27hetAmnUsFa1+fq9+snvPwFgojuUossLq8J1yIYorrw6zCYBJfmQQy9WEiaZmOreCVSI+VrGwi0YWXJMo+imuP0B8L5S1yVqjxxHOVjlJfJqou3rCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477134; c=relaxed/simple;
	bh=XsDY3ATOGu8qFz4TOBERwKCG3vKCC2dht5Us0lhvIuc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OKXoQiG5eTNim08QM29TpXCALK4BykZhZIEcqEO//W+LHFzBnSIci+qKLXYXf2sFIguPYQHum6NNVutT3XCh4WCBTaBCQYZ7DOlmnZbdjIB3xDat+4llDpywIexxokXEqgNeJubxg/uhKRGrM51ktP0Gq7SKYmbgCaaNaqisxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKorNqjS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKorNqjS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-418f1d77adaso7278415e9.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477131; x=1714081931; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6cQZIi/4irN5VCcOFdP3ls2MTP1dKp8KP/x+/tqhDA=;
        b=iKorNqjSioNiN1iwW27IUCMbQlorhrZutZwHrbDRXL7YCasEAHv5REmCwL1EGgnIuC
         IlpSkRVMoTV4XQGYWQKuzev1EKjvhEiFM6mtwivZPwjr+xYkGU4whjWPogSG29EsgyXd
         ZhscjuSNS++BrBxNAyySdFdhr354sh0JcVyghj+i+tR8RsmM1r0Xe/7Sh0VMjQUQAqxH
         +Ep59UOO08uo8X7FAak0vN6OpkV6YB2zw2XT9EVv8xN0DzJ+03BRWh8RNM7N/QuSvpSl
         pyNqG2vK9ZAbuLpYvSqvEWkP6QTkvUSwYr8x+nK+SPCcVS5x9PksCvK8S7ncgN3o2kJ1
         xCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477131; x=1714081931;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6cQZIi/4irN5VCcOFdP3ls2MTP1dKp8KP/x+/tqhDA=;
        b=vAT7jMkyhQ5vDngqTUBF+dnwpOuT4nnql04EuEkB+21stExxIPHsV1gcy4Tw86pXZM
         aijImfiRveA5ON7oYvCt/FlmMOi5OoFguXcMwZBm06wDAAbpwD9wCXllcgkHpUOkJ0vz
         QwzU9j11yaKKQWcUBAMoOgkvRIKncTlsAfROC0AKl9t5EVLvDeWFPPB+8sxk7vC7zJXv
         RLYAL8/TIsb0Zv1fdTCLHjPR0olXyq7kOv6stmMagB9MMJLebtYPY28WnXsfTtIz7xxn
         zWKopuFWi+dyIjz0jAjVuh3f5jHe/P+MHlTzgk/K8ctg9OidInrQmbdcKKqaePjHgS0C
         DBWg==
X-Gm-Message-State: AOJu0YzN6C5I22ZUG76olPRc1gLTMT0WjHNGAuxJ3MT3N4K2C40C6uj0
	ef9ijrNU4cHB7hWZqDSnODev9JnODueerBxxAb00zy+Q1WeTupaZnivrjg==
X-Google-Smtp-Source: AGHT+IHXBT6YN5TozSlagOdoKPLq4lWW+ORaUUF3xXgrxAIr0dWnUPzDARMcn8EJLSFvsbOCZclWEA==
X-Received: by 2002:a05:600c:1c05:b0:418:a3e6:c5e6 with SMTP id j5-20020a05600c1c0500b00418a3e6c5e6mr124379wms.27.1713477130929;
        Thu, 18 Apr 2024 14:52:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c4e4d00b00418e869f896sm3321517wmq.17.2024.04.18.14.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:10 -0700 (PDT)
Message-Id: <0a79615cf2feea974be709e44326547ef31930c7.1713477125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
References: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
	<pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 21:52:01 +0000
Subject: [PATCH v6 4/8] SubmittingPatches: quote commands
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 26055a1fe2b..6b9e954a47d 100644
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

