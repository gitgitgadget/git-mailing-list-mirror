Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151E158DBD
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699828; cv=none; b=Ov1cGWgWq3LGGlTrN0mS/ZNnyh1uPrElgT1Ptmoib1BQfiPpz0W07sPPY9bZ+IVCX0DTSzE8C5gspZwc/03TabYxgPkw7IMtt2ivqTYWT1tC930ZrOiWaiDyzDnq8IrT/G6idNwQ7zj0TINn0FWXt5EUv7qdroVQEDLxx4+EazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699828; c=relaxed/simple;
	bh=xoKPgz6S7m4akW3oF0B6oWglXsx7fiv8kxMqTndFlsk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FbHVdRo7ktBF9T8LUIX2/U9aPD1j+CUhwNzGulaNKKq2byGU61pXZK/xd8FQhfDJX07FNRK3I6ZNxNd3q3v8efCw9trn0q67Ae1ZFX8iSoh73XaCRBJym/63HXjv/V2HPY7VtMJ38Hujz+MFoXzOjEUCBScsKFoOWfS2Uxy42S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqF9jWRf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqF9jWRf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4166d6dab3dso19695915e9.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699824; x=1713304624; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sYkM0tUAr4BggkmFvibmlBmY0KXYSu3PaveFclcdBQ=;
        b=gqF9jWRfRUXQKwmSdudphBarmdDcQykcNMfMF434jf+t5lbF30+/NMcegZrueKd488
         hqRMS1MYjiWgfZbao9jgaY2eob0Kg0LPBtgHA3pHnYM0TUZadPfLz6CQU7bXf6egrqAw
         LN9zQZxYw874FiSG3OKLiwbP5h9RrSFWMo7phy45Iirg+riNaznMN6HOKMynfC2+fazl
         uN0JA/8JHSWeGmli0A9T4xVMAeq3XvduGLe+Vn4lLC1kREJ7hibYVk9gWTHmaUhx3/L2
         3D5DO8sPtS+ybDZTQaFfV5UjD5Es+JNuRa2u2P4pRrSiC/+AryerzfKiyA90Bz15VNIn
         yRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699824; x=1713304624;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sYkM0tUAr4BggkmFvibmlBmY0KXYSu3PaveFclcdBQ=;
        b=Rapbs5P3FM850wDZ282LbyvdfNTTjLA8b9fixmzVU8+YmP4RfxE/tCocqnYSRHzDgJ
         pk2Xb7yaq+ovyJPLC6fERa48ny9RQQPeqT8PsMGLN/z+eqm7Vwp18Fj/Svt5o2LQxLmd
         0MQa30SEjIyKyzzOrIgIsCqEk+u/O1BZ3HPoTpFbF3ZPDt7Hk0WWPdWPbfEg94wXOqrN
         sDsc/Qs2uHWZgy4y46OPh5h3hzRWdBkJcJzzbwW7OTqlY1kexwepnSimS4t5JwS3I0BG
         hxo9w4m5bW96LexsQs18JCwSKoFR3vavvLxwLcRcBBtX4NkD1/9C11WjhTLa8hsCrt+x
         FlxA==
X-Gm-Message-State: AOJu0YwL+P77nKUW5hLIrRV31CuaeRcjTQuZgLflQR7LgXLUtheACq1X
	O6ltR7TWWPoLTysMCVVi8p0A0S1NW13uTgaM94hdu01MiCzVOkV36yqHMtpM
X-Google-Smtp-Source: AGHT+IGU4Nxi2zIkXdX6bdvpQQuV0m5lrrfFTUzc2Zi3hNw0oxpbqwyxaQm1VGyli2c3G5RA6p6wAg==
X-Received: by 2002:a05:600c:5253:b0:414:71b2:c915 with SMTP id fc19-20020a05600c525300b0041471b2c915mr631482wmb.34.1712699824675;
        Tue, 09 Apr 2024 14:57:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b004163321790esm226013wmq.19.2024.04.09.14.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:57:04 -0700 (PDT)
Message-Id: <4fcab0d3319fa47c2f4126139ca636d6848e9e3d.1712699815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 21:56:55 +0000
Subject: [PATCH v3 8/8] SubmittingPatches: demonstrate using git-contacts with
 git-send-email
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

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index bafb1ee0157..57953898cee 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -413,6 +413,13 @@ trial merges of your topic to `next` and `seen`, you may have noticed
 work by others conflicting with your changes.  There is a good possibility
 that these people may know the area you are touching well.
 
+If you are using `send-email`, you can feed it the output of `git contacts` like
+this:
+
+....
+	git send-email --cc-cmd='git contacts' feature/*.patch
+....
+
 :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
 :git-ml: footnote:[The mailing list: git@vger.kernel.org]
 
-- 
gitgitgadget
