Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFB28688C
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351926; cv=none; b=KSVuGnjzXoBlo6nCXHlsJxIg35HBMVCiTx27qCGjK5giDxvoSPomY1SH1+FBh8AxxVLpCLcE0jfuz0R1INrs8EL6OBwqERzMZly4W2kHQ+SVPTrZsLWtmpZPriWtLq0IJEP1dYEMkuIJZs/EWDLY5R7FouhIIg6fRSp4Cn3qqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351926; c=relaxed/simple;
	bh=an16Hpx5dv4tNViuHxAtlinF1yw0hjruhgPxkeQbMHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0KZVnE1zLVhv6pF1wBoGtw4D+PTJ7MhH7WQ71R0H9Lf8hA1ZceXJQye+m5hyEfWwX4Q5BanJCseki3FTfKN8C3UAwkCVPJZO0kuzDG2QYj8NFaTUgVcwbA6kg88H9fEob4yalQqs2GXFwxE9H9LK2JnD6XJaNQfWvvsurKMAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7x44XNH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7x44XNH"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo13388639b3a.2
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 03:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767351924; x=1767956724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L67yuWYv3+nDrf4Uo4rG2YJ8aCGsBwHl87KzgvgfHk0=;
        b=V7x44XNHT3mX4oh93u8NptNR9ql0ysZIzUErWhmit1depcCqv+v1VSD0xI7XRz/W6b
         DC3YHvtdvI7/hevRFXWnhC8j5cPgiQoz0TW7mUNGwGJWPXercvkieZeHbrcJdFpSMWzz
         H+3lE6Gpe6zgfJeWioSBls21bHdnBC5khbgOH3DpJ7Dx2fCftuolr4vuGyk0ch7WJU4S
         Gis8ZNRW8DJHJZb++ztoAwloWItMNRDirXBRC5xSyS200ONKUVLEImgluArWnG+y6yrk
         3q9+Mla1KhTNqdNceEguCby2JKA2gfjOKvX4Linroy/kfYCjGND6ER8wqmgyccRJhfXU
         +9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767351924; x=1767956724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L67yuWYv3+nDrf4Uo4rG2YJ8aCGsBwHl87KzgvgfHk0=;
        b=qSEqVqq41UXFX76goVzCx7hbTI09a1b/fskWprn58wCrJ42/m+OfTrBSzmPtl9gPqL
         bRztic3xnoaEj8uA4j+xGPtq5pVWT94gqQcJAwmjjOt5Al2EzqGvLwcgwQ12OK5mAlVX
         LzahFtZEskOVZxJa5F2k+zIhEU0Wfz25bcgDBARflmob035O1VHUBw1ijB6KDuuH2hwY
         hAtSmCuBPNxFGlrmpu0xszgeMlFTqVHYXH3/je0d9AaAAn0ICzgA1yPe9P0aJFaEUcWw
         qxBTwk0JtaPwOlhyh3IIR/ac1cfv0tXaKtOBrAsn6g+ARgPNm2BBVqlAmae1CyI+wvsd
         UPaQ==
X-Gm-Message-State: AOJu0Yyw69+K7n2ltc6YF1lq6rW0jalvHE6KetYAhPTRwVuw2NRXbfrs
	UdotaY+QJW8WdaIqoy+KzDhZetquxg0XySID9775YVg8S47Ap5jyd/DxxpPSrYKq
X-Gm-Gg: AY/fxX6jZblFnRhcCHFDctLZGSg4L9DITAcb9BL1s9tX9K0D97qzvsMlDjpYlJTw0Jv
	jw43XutIv6zcPV8kIveP3nEAr1l7wwlHO1YGn82Av4uh803hpJ8e815/vr53ab/wZZuwhhxyLuh
	vNSFC+UykNz0YfezA9XsOAxS5pRolxW+J0PaPzBi3cI2TawasI4z6OZI7OsvvmUanFfhJbsSAGt
	wKRRZUubCn9dVOtnj5ecncalUL1nJfPczXq5JkRDv2uxuiDCh6WBcmz6H8B8cRvwZd54tZPZZCV
	2OUTPQQh/SNqbt7ER0IqEGLpbe4ZLuavo9MHMAxZL1PtFFmjd4PKfoK+s4/gCRnCOwvRDoccH3U
	67LXhe1QY7Dlb0qkXQrjn3uww6IBSedWCS4e7UiRZ64qTFrXjFu3ntX9CHCw1AyuM9SCvNFIRph
	C4pGljjoqj3jdIKeIEaHL2E3U7ENAYCImzyS1YgUcF2CM=
X-Google-Smtp-Source: AGHT+IGMSSwZFriJIP6OyDeMx63qcG6KmXrwLnA9dX4aNWQtTbFSDcdw0aF3MhpKqGNRbiO+QrFhNw==
X-Received: by 2002:a05:6a00:299a:b0:7e8:4471:ae72 with SMTP id d2e1a72fcca58-7ff6804ac37mr37605410b3a.62.1767351923932;
        Fri, 02 Jan 2026 03:05:23 -0800 (PST)
Received: from localhost.localdomain ([1.39.18.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423b9asm40755148b3a.28.2026.01.02.03.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 03:05:23 -0800 (PST)
From: pushkarkumarsingh1970@gmail.com
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] t2021: use test helpers instead of shell primitives
Date: Fri,  2 Jan 2026 11:03:51 +0000
Message-ID: <20260102110452.19221-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>

The tests here used plain `test -f` and `test -h` checks. Replacing them
with `test_path_is_file` and `test_path_is_symlink` makes failures easier
to understand and keeps the test style consistent with the rest of the
suite.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 t/t2021-checkout-overwrite.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index a5c03d5d4a..38c41ae373 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -27,7 +27,7 @@ test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 	git rm --cached a/b &&
 	git commit -m "un-track the file" &&
 	test_must_fail git checkout start &&
-	test -f a/b
+	test_path_is_file a/b
 '
 
 test_expect_success 'create a commit where dir a/b changed to symlink' '
@@ -49,7 +49,7 @@ test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 
 test_expect_success SYMLINKS 'the symlink remained' '
 
-	test -h a/b
+	test_path_is_symlink a/b
 '
 
 test_expect_success 'cleanup after previous symlink tests' '
-- 
2.43.0

