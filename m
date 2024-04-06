Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AECC18C31
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366548; cv=none; b=HR4tjmE1MDFd9rHeFNMKt5DC75sv+IJ2XN4M0J8qLOuR3nk6K3QF9RUUQfdTLph7ArIZ7sibRq/6le0UjzVoWDJPNLxtZdgMSL8u3FYiJPE/DT3D1Fe8ikKLVyiYZ+6JHvMPU+T8TZDaEHSZHVB5Yh4yguR/4tWhohiT71I8O1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366548; c=relaxed/simple;
	bh=QvyZWQBvNcjyOtZldMnHawONGsX3lLlukOi5dH4BWU8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cLHxxWLgPlu/r//mqdAF+eZDDh2B3eyOXxKt6jbcCvSJiqWHEYTZyYGKK2rKRW+Sd4ye5z4PdJT1Id/qQhwbA5E7E0pjABhm+m2VSs4sihUOdvnikfHj7KGe2TitNAAPhzPRUNmxFqQBN/ZQKoil8FVgEDiTsIlcU8RXn46pDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFf1Afz4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFf1Afz4"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4162ae2a0e4so15062985e9.3
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366544; x=1712971344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhWMCu09nW3c5n5D/UILz3t0YxM+LGCIZpIwSXWRpL8=;
        b=EFf1Afz4Y+tnI9mdNYC8eqvcQ0UFwoAIaMY8AXY/reKZwUQqyxkHyayI2GwdK3K34u
         YchdYGEnAC74JT22uo5wJWTRSqtU4wfnGhe44AYTo+S7XiwyeNCeJMUYbH37GXjUaxAm
         /zYH7v5yJ5neUhRIz34AID0xkd5P76STaGhwvkJ9EUUDB1djksCERmsBVMfdQLKCz9fk
         vjqFbNqBWq5iuqYKWrPwo1sPEkl/PFWAKqiLJ0Bq7kf61enbT6afZQsNBOtGp9ZJOBmB
         jTh1n8/72y2ERnveHOwKQi4oLw8nGYFwu/m+A8MVZZUBpC10HOmPwBdiGGFwUGbZnm5J
         Lmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366544; x=1712971344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhWMCu09nW3c5n5D/UILz3t0YxM+LGCIZpIwSXWRpL8=;
        b=lAAeQIocI+qVvX7OPI/BH24argzrLueQzgon9GIHbbu1Jz+McYajSoNe+NNmERBgQ0
         0iE/tTKp+3HZRlit32qr5Nu8pLGXh7SrMqZV+AmPwlCMP4zpH76KNEeonlqR5ba8Mo6O
         mQvEri+OYbGHT8AEB5XfumzN2G+71ZVC9uejWiF3vNfCqVFxbbP+SmIPm6z5ltf/29Fn
         D4LcA5HTfG/3HSNfPgKKD7ulNozL5Zhu7JwFP3pF202TXWyAb2W9/6Hz5seF96eq5qjh
         4G7eraeY+bxIz29sVo6iRNQcc9L8NbxC+LbF2My7Ql5MrDOGJpWTAgX9az1wAR+5g0ug
         IaHA==
X-Gm-Message-State: AOJu0YyXxohNhDiZ7N9cM27ZoTvuSd/x4IzmUcwaRNEGibJnLs+cNuE1
	2H022Keqaxete0ICX09mDzrqljj86ttwQvvkvVKZFsfUE/IuAufmSBYYAVez
X-Google-Smtp-Source: AGHT+IFaM9M9fb8zjUDFC4mC/yP+AS3x94Yyk+Zl2DTqzZs7PgrNwo+b60B5MTzp4fl9LtfkhOrzzQ==
X-Received: by 2002:a05:600c:154e:b0:416:33e6:25c7 with SMTP id f14-20020a05600c154e00b0041633e625c7mr626404wmg.36.1712366543920;
        Fri, 05 Apr 2024 18:22:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15-20020adfa34f000000b00341c88ab493sm3268792wrb.10.2024.04.05.18.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:22:23 -0700 (PDT)
Message-Id: <a8abcf45881fa759c1a2addcc12b286e0533c6e8.1712366536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Apr 2024 01:22:13 +0000
Subject: [PATCH v2 5/8] SubmittingPatches: discuss reviewers first
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

No matter how well someone configures their email tooling, understanding
who to send the patches to is something that must always be considered.
So discuss it first instead of at the end.

In the following commit we will clean up the (now redundant) discussion
about sending security patches to the Git Security mailing list.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 58 +++++++++++++++++----------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 24c7041a06f..17db961bac4 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -397,6 +397,36 @@ letter.
 [[send-patches]]
 === Sending your patches.
 
+==== Choosing your reviewers
+
+:security-ml-ref: footnoteref:[security-ml]
+
+As mentioned at the beginning of the section, patches that may be
+security relevant should not be submitted to the public mailing list
+mentioned below, but should instead be sent privately to the Git
+Security mailing list{security-ml-ref}.
+
+Send your patch with "To:" set to the mailing list, with "cc:" listing
+people who are involved in the area you are touching (the `git contacts`
+command in `contrib/contacts/` can help to
+identify them), to solicit comments and reviews.  Also, when you made
+trial merges of your topic to `next` and `seen`, you may have noticed
+work by others conflicting with your changes.  There is a good possibility
+that these people may know the area you are touching well.
+
+:current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
+:git-ml: footnote:[The mailing list: git@vger.kernel.org]
+
+After the list reached a consensus that it is a good idea to apply the
+patch, re-send it with "To:" set to the maintainer{current-maintainer}
+and "cc:" the list{git-ml} for inclusion.  This is especially relevant
+when the maintainer did not heavily participate in the discussion and
+instead left the review to trusted others.
+
+Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
+`Tested-by:` lines as necessary to credit people who helped your
+patch, and "cc:" them when sending such a final version for inclusion.
+
 :security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
 
 Before sending any patches, please note that patches that may be
@@ -490,34 +520,6 @@ patch, format it as "multipart/signed", not a text/plain message
 that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
 not a text/plain, it's something else.
 
-:security-ml-ref: footnoteref:[security-ml]
-
-As mentioned at the beginning of the section, patches that may be
-security relevant should not be submitted to the public mailing list
-mentioned below, but should instead be sent privately to the Git
-Security mailing list{security-ml-ref}.
-
-Send your patch with "To:" set to the mailing list, with "cc:" listing
-people who are involved in the area you are touching (the `git contacts`
-command in `contrib/contacts/` can help to
-identify them), to solicit comments and reviews.  Also, when you made
-trial merges of your topic to `next` and `seen`, you may have noticed
-work by others conflicting with your changes.  There is a good possibility
-that these people may know the area you are touching well.
-
-:current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
-:git-ml: footnote:[The mailing list: git@vger.kernel.org]
-
-After the list reached a consensus that it is a good idea to apply the
-patch, re-send it with "To:" set to the maintainer{current-maintainer}
-and "cc:" the list{git-ml} for inclusion.  This is especially relevant
-when the maintainer did not heavily participate in the discussion and
-instead left the review to trusted others.
-
-Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
-`Tested-by:` lines as necessary to credit people who helped your
-patch, and "cc:" them when sending such a final version for inclusion.
-
 == Subsystems with dedicated maintainers
 
 Some parts of the system have dedicated maintainers with their own
-- 
gitgitgadget

