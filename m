Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADB3158DB1
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699827; cv=none; b=m21yhRh6+vAb4b5noGlq/axTtHLrsykv5zchd4njl+1VKRd1r1kGJ7xEjpTVSnfTbpaOx488deRZlHC+PZiJ1biuyo44GUfpU6erY4Uyuh87QhipKXS+Plt0IlVvpgIkqyj40cy+6n2rBOkzJ4/z/z8OhkSu2Wrbf1rtLarZBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699827; c=relaxed/simple;
	bh=yVwWzomOuqumczx8qiJjN0ddsUHGMc1ItM0fpeK8IPA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ihx7KDLRAKhHTg8BdWNV+ggEA3ecL2QwoSuLW2r435yHFYAec+oLOx+nqcb4lthLRevPIEAmdl0P8HbzL9uGQqhaXCwiy/NYrq4SIfK2z8vB3GPTsI36ZKZwv9I5adoEl1uVzlFp3v7qaCn+9P/2eISMLw307eM7nlI8FqZ8xWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABjY08LK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABjY08LK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4168a5d7564so13875625e9.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699824; x=1713304624; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdWdrZDi/XyXCZA+chwRbfdhAoQjsUXIcslctsO8abk=;
        b=ABjY08LKFw839Rbt4xAFhmaoEjvu+Ls9YcLOM3a56ylXTcf64LAGaxuHHEHUy6K4ET
         1ERwYlilznEN5HO4EDefC9KZ/aj3J7HE1RNqKXDBo6kTM/ZZ6pVB8HWt+8Qk9LtZgooR
         4fV2JRBPbke7WSI+e4zg6EKxlPqPheZag3iHJ+DC84tehjUpGRb+T3R+uwesEHSPNl5l
         /EF/TIx/+GFngaN+t6GXqhdx995my55QXFFX7eTw+G4CzUKLitFbXsW2Ao+lUQQuKalN
         /dZUxAjAZeCwAAQBymAEC9AmfCi6owwNtuQyGwsXqSenjzemfTciuZ4ZLgZNSndYXr/b
         VN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699824; x=1713304624;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdWdrZDi/XyXCZA+chwRbfdhAoQjsUXIcslctsO8abk=;
        b=gBOhMZJ9n80rdP3ITRtJOc3T1649fSZITR311k3fD8UY+/iscHmfxAnZ29Thb8ScYJ
         yYpYDtcla61lFKetQVIHI4Ps2jWJ5WTjlaTnJy1OvlNakqkWx/x+2RVCeAc63+gi1i7T
         b0sOiNPaDbls2enuvGHwFjQAuW69ybqK8wbCfDLPV2tU3eeJudxcesksDQITsfSTa0Ky
         I1c306xGZLXi/DIjfNVVjMX4Wdkp2VB6Y62vZhWgqgt7M+BHuIevRU4/JVOtdRxRDVbI
         nvYgfdaGbwG6dFXd3YQiyID+wu17vz+KGcWTn06uqdx7klFklYKODGEUAfUSX77x1Ene
         MasQ==
X-Gm-Message-State: AOJu0YwEWnq/vBhKht5/TEhhDZ90Z+0r3Pv5Z07vLvPyDRBtkmYEb31x
	RpfCqRrGcir/g8OSbNORZ6vqGt+RvaujLuHlkzmcte08OBx/f2pnzVUEujWL
X-Google-Smtp-Source: AGHT+IE8RuEmd9+wM0tbEzzjK3rKQNrrvQsgo7PfTj5fVb442+QlTqr8T9apd2fM0T6e0AOFpmJ68g==
X-Received: by 2002:a05:600c:46c6:b0:416:9ba1:622d with SMTP id q6-20020a05600c46c600b004169ba1622dmr635680wmo.38.1712699823637;
        Tue, 09 Apr 2024 14:57:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c4f4300b004167df5ed4bsm208221wmq.29.2024.04.09.14.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:57:03 -0700 (PDT)
Message-Id: <e64fc5c888aea1bed1279882da7d44cc1a463fd3.1712699815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 21:56:54 +0000
Subject: [PATCH v3 7/8] SubmittingPatches: add heading for format-patch and
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 98ec8170aeb..bafb1ee0157 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -426,6 +426,8 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
+==== `format-patch` and `send-email`
+
 Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
-- 
gitgitgadget

