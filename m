Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2720B326
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234735; cv=none; b=ZsBkSGsGcgg9GO7kQ+tiTjmdTV3HuVxMwJSGYTFYVFKhxqEZBicp4Fm31vr2xADflsgEgJwjFfXXU1NJ8PveQR5UffQA2y0KRxGDEvIJUT3b9qmU51kU160+yo0/1+1SIc+YR0+wqUhhutABkGhx1eIwgrflfpGBAv/ZrJU0rVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234735; c=relaxed/simple;
	bh=6/2JMYRRJNO60Rpu/KWQTBzCvR6sbnHK7cfRy5IotbA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TdAhnzlI8NCRtxTgP6bSQgdXRur/ei3I/ZkHOKppPl5VSG3zHsH3sHMBfve17VwZjM2GeMCoc8UWnEFbLj+P4SUaRA9mpmac04ARhSFeQF2EtxsGPII3H6w/ioqb0M66Hn+fKENrdrd7LFz/MXYN2IoxCQhedSVrZfSOdhADf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyQhisJx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyQhisJx"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a83597ce5beso100473366b.1
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724234732; x=1724839532; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsDOVUDd1iubFyn5t8FFIOwFGfGqLWQFxC9903I5l7Q=;
        b=DyQhisJxCQunM/d3VGkIxVWS/JvWHwm2MJNJT7AU61KwtYDtgUgb4MgvvO5Vz5Pgfr
         oKVouuxrcbfrx8nw6PE/LmmQs+H6gVQg0iSpNnit6U0tWfwN/Rf0BABGbEJX3sPS0Wq+
         m09ENI1+KIWCdydVv5inZOuVKcIdcMFKSlJQrT/FuiQPeHBTzw1568ArrPT/VRXNibm5
         cxYrgX547MC8TOgtNTidvmZLWzkMwtvc9cz1oxTLdfKrjFsBrY3TTLrIoM9tAwDy8F+s
         28VvtZ6MmUE7awvNvxQ/04lSOyaAldewFdc7FX4okPWJhRtZ7eSrodRIsY8zatGtKsJN
         xpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234732; x=1724839532;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsDOVUDd1iubFyn5t8FFIOwFGfGqLWQFxC9903I5l7Q=;
        b=kqupiGjGj43wfLlK9kHf7IdixGG7bmSFmVGHOMlBSCcuKiZBuxHetfVebEXn9REapF
         matjT0S0zZhdIedg0UE9WoKfjdgOmYDx1BN6kcvoaqCPiHSC3LElX+pwDAphINprVr8A
         yaNH7dKXfo3QzSXG872eqLKDisBijlwHGpimWnz5GsMuHxjUqtaGNimkJsiyHDgTakUd
         zQixldGTbZwq3bTxZaWZ8oAOahuobDi6qal9WNT6HYUopAFzL6uT5jAKwTwsaQWC1Jc8
         P9CKidNRkHjk18ymwvSC5dIvZE2DZvoZBFxKGpKuOAEiFU+gGJiF0Y/TWXY+DqVGC5Ts
         7FgA==
X-Gm-Message-State: AOJu0YympVvqHBOIYlfYBaKy2OI/QxUZ4MQrKBeC01WGHsONzCrerXw5
	Y+J0kinvuLvGc5gURyOUv6QCQoIfHkHlu2N7kFS9h6wVKL3Vlm/6XEp7Mw==
X-Google-Smtp-Source: AGHT+IHmrgEoVlEI0d/Oda1AwMQKj8s6Okgf21S9wQbznWa2HYz6+YfbZ4LUpYPm10yLXZVGjuyUEA==
X-Received: by 2002:a17:907:7252:b0:a7a:acae:3419 with SMTP id a640c23a62f3a-a867016735bmr181693666b.28.1724234731076;
        Wed, 21 Aug 2024 03:05:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c69easm884293966b.40.2024.08.21.03.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 03:05:30 -0700 (PDT)
Message-Id: <pull.1768.v2.git.git.1724234729288.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.git.git.1724232485264.gitgitgadget@gmail.com>
References: <pull.1768.git.git.1724232485264.gitgitgadget@gmail.com>
From: "ahmed akef via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 10:05:29 +0000
Subject: [PATCH v2] docs: explain the order of output in the batched mode of
 git-cat-file(1)
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
Cc: ahmed akef <aemed.akef.1@gmail.com>,
    ahmed akef <aemed.akef.1@gmail.com>

From: ahmed akef <aemed.akef.1@gmail.com>

The batched mode of git-cat-file(1) reads multiple objects from stdin
and prints their respective contents to stdout.
The order in which those objects are printed is not documented
and may not be immediately obvious to the user.
Document it.

Signed-off-by: ahmed akef <aemed.akef.1@gmail.com>
---
    docs: explain the order of output in The batched mode of git-cat-file(1)
    
    this is the same change as https://github.com/git/git/pull/1761 but dues
    to missteps, the PR got closed and I couldn't fix it, also applied the
    review comments from @pks-t
    cc: Patrick Steinhardt ps@pks.im

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1768%2Fahmedakef%2Fexplain-the-order-of-output-in-cat-file-batch-operations-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1768/ahmedakef/explain-the-order-of-output-in-cat-file-batch-operations-v2
Pull-Request: https://github.com/git/git/pull/1768

Range-diff vs v1:

 1:  86a982884ec ! 1:  3f742957aa1 docs: explain the order of output in the batched mode of git-cat-file(1)
     @@ Documentation/git-cat-file.txt: BATCH OUTPUT
       If `--batch` or `--batch-check` is given, `cat-file` will read objects
      -from stdin, one per line, and print information about them. By default,
      -the whole line is considered as an object, as if it were fed to
     -+from stdin, one per line, and print information about them sequentially in the same order.
     -+By default, the whole line is considered as an object, as if it were fed to
     - linkgit:git-rev-parse[1].
     +-linkgit:git-rev-parse[1].
     ++from stdin, one per line, and print information about them in the same
     ++order as they have been read from stdin. By default, the whole line is
     ++considered as an object, as if it were fed to linkgit:git-rev-parse[1].
       
       When `--batch-command` is given, `cat-file` will read commands from stdin,
     + one per line, and print information based on the command given. With


 Documentation/git-cat-file.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index bd95a6c10a7..c39074b9ee6 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -270,9 +270,9 @@ BATCH OUTPUT
 ------------
 
 If `--batch` or `--batch-check` is given, `cat-file` will read objects
-from stdin, one per line, and print information about them. By default,
-the whole line is considered as an object, as if it were fed to
-linkgit:git-rev-parse[1].
+from stdin, one per line, and print information about them in the same
+order as they have been read from stdin. By default, the whole line is
+considered as an object, as if it were fed to linkgit:git-rev-parse[1].
 
 When `--batch-command` is given, `cat-file` will read commands from stdin,
 one per line, and print information based on the command given. With

base-commit: 80ccd8a2602820fdf896a8e8894305225f86f61d
-- 
gitgitgadget
