Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709CB1E86F
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708281448; cv=none; b=YNe0WkbQydvywUtR4QudBvLRi7uLFEav7e65NzqGBVyat0427Y9hcRUQA3zs+Dz3xRMc/+emJHrRQMPErKMSVZiLEaIvDCXsr/qCegPWiH1ozeGypLtUQ0M46c4GzTza55ALXRqVHmdhhvhD9IzFXmGxe+v+ov6njIMUpnDIISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708281448; c=relaxed/simple;
	bh=JEmWuCKTHf3koLdLT2rHYacdLh5XRdCy4loO2lIH48k=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=o+nUU2nSmuC35YBpAKYOYWxo26Ey2C3QK/4nsNJ5n73BgaKuTyXThJhBhmTthxSwS5t2ZlABnpg/zgXw5vICntxooes6PSZZyuiNAGjA6Bup63Byfa2LFqu2Wq9gpfNrFcA8Ft888boVs2GnfLClfnys1iP/AhWQXRcl9yCJUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh/BE4ft; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh/BE4ft"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4126104e28eso5339425e9.0
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 10:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708281444; x=1708886244; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jL9kI+5T4aoblRjuN/MFrbjPIRwh5YgxsDgXbwO8aV8=;
        b=hh/BE4ftJnpuTRAS07v6ZOy6f+u3o+h5CW4TX+ZtOW/Jko56bodHvs6qzvHYdFrwB7
         BBpWBkbm5vRofEwpPJQE0sPFrqizbUnJO42j62zW9khR3mH64vtQJCNNqJ4Kj/y8/Hf8
         5a9ev7+YJqFwXR1YEJLZSZiYWduJl6x5e+Er79QYfTWgsWw8E2CWDFrwRlAoXBN9pBp2
         3WlixgNeRaW+6ZLvsqHp9gz2+n7eE2OnRAdKmHOc2rNBxQTbwVxn1gnM5cUCW8Rth5NA
         ZfK0zhm6eXxFBwj2MFIzOrStzMpCoKf0EUpEXsZKidupJHaqX3fFstAxRm+SBgNlPGgT
         JNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708281444; x=1708886244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jL9kI+5T4aoblRjuN/MFrbjPIRwh5YgxsDgXbwO8aV8=;
        b=DhBf+xqq2s5LI4Abe2arKgDX1xiDhI/FIT8z0gzx/KOGQz2Bc23X05D8n5IR4hgOpP
         5eCL980DrKybCSRVx7wSGHQ+dAfWZIzRlwiO4oBQJezi9j8gJcPFSMct8hGCsfEvKOZg
         qS0TULDhmOBXGX7ZghJFHXsFHFusot2JBo+t04erbV/wVaiVLnCNAF2k7/HV2SRK3V/0
         42MJeME7mdhoC2TZtKtzfhoZLk1km+mWJ+x09kOl9C4nhurMlpn9kkief2XHwCijgXpy
         eO/wab0qXpAtuL5m4Vki0NbonVIKTq8SFLes08QPbWorPNOmJLDzax6TIb75tTsYKNMC
         3ucw==
X-Gm-Message-State: AOJu0YzIKulWVyYaM6a1W/24y6Wu8mshgub/bW+dgM2cNXWso4uoNmQN
	UNWypcXtMTRE9Kgwrf1Xj9AKnWqGv3SKP841DooKPmdrcJQL5T3a0iRV4dro
X-Google-Smtp-Source: AGHT+IHNEkou8k3FqfHoY680BZ2/jElaVvXM5izb+pmiDK9uSIijVptC7sx8MMe0evCDZOETetHpHw==
X-Received: by 2002:a05:600c:1f87:b0:411:fc3f:c620 with SMTP id je7-20020a05600c1f8700b00411fc3fc620mr8937597wmb.20.1708281444006;
        Sun, 18 Feb 2024 10:37:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b004120b4c57c9sm8997272wmo.4.2024.02.18.10.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 10:37:23 -0800 (PST)
Message-ID: <pull.1668.git.1708281443289.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Feb 2024 18:37:23 +0000
Subject: [PATCH] diff.c: use utf8_strwidth() instead of strlen() for display
 width
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
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    diff.c: use utf8_strwidth() instead of strlen() for display width

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1668%2FChand-ra%2Fdiff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1668/Chand-ra/diff-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1668

 diff.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index ccfa1fca0d0..02d60af6749 100644
--- a/diff.c
+++ b/diff.c
@@ -2712,13 +2712,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * making the line longer than the maximum width.
 	 */
 
-	/*
-	 * NEEDSWORK: line_prefix is often used for "log --graph" output
-	 * and contains ANSI-colored string.  utf8_strnwidth() should be
-	 * used to correctly count the display width instead of strlen().
-	 */
 	if (options->stat_width == -1)
-		width = term_columns() - strlen(line_prefix);
+		width = term_columns() - utf8_strwidth(line_prefix);
 	else
 		width = options->stat_width ? options->stat_width : 80;
 	number_width = decimal_width(max_change) > number_width ?

base-commit: 2996f11c1d11ab68823f0939b6469dedc2b9ab90
-- 
gitgitgadget
