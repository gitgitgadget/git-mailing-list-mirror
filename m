Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B11B4138
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604885; cv=none; b=XMaaLPXi/1QOfU20nu0zCMOr3NIXUGx/Q0VRc73LAIn1glmTzvnSOSSKYngQxld4Zpik1QOdDL4NP5Xzv/W9XosTD+Lh0FUuq05e/1s7XhISCz7yNmMnKLn5Ph2NZwjCQqUBXw52WTF2h7toit/h78SiZZPeX0AJ9zw5m4aDcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604885; c=relaxed/simple;
	bh=SybgaxRxSa3G8PFqdy+gE0rSA+G9QttAzNwOvdulrnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IEFYa3kCd7RuPF/pxT0Aqqu6VEWXv3nbW/L98mUlho7f1D4eBM/td0BfyCPChI0/XukR2ZRsz7XxEvwSIRlgmZzRhumh4o7o178j9ztIYlSUd4hIqmymU2kzzu/8fiYZ6QaQfyXVQa2TjdBVWM01Me/KaqCyIPoID9hC4vWEjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwrvpyVI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwrvpyVI"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5495078cd59so4753302e87.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 04:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741604882; x=1742209682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nKH5OC1tHnSX6uHtj/ZPfBxj+3v7OUqrUC2lC7dIiOo=;
        b=ZwrvpyVItCn9i+gUP19nR4tK7wjyX0+uz71Sl3ASd+cEUMMoexg2JB1BEGjM+xzbwi
         k2PdJFHQFCTizFVUl+HsMbu4XiHl3d9U2QSypNisSch3kB35tMkW40K49Jk1no/Ca6dl
         PGf3e0ieq+h3t9uM4xHdGmaxyaBqHDDc9GJ0n0nUgjF40XTGte/3y+STPQJIDyL5a4ux
         j/NMu+aEnGB0aiRVkL3tQ22w6osEy48vkKX3Z51+Cwaqzu1kllOKAVo5yW6MmLmfJek4
         8hQ8CxtYoKeW7N/KdScCk/uAVMFicNuTMiSIpt9bbljq1nO94/CRnXyPpaeOGoXxABom
         EPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741604882; x=1742209682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKH5OC1tHnSX6uHtj/ZPfBxj+3v7OUqrUC2lC7dIiOo=;
        b=UJMn1xk4o701rANfKVBdYQL5pSw7nYAesLg9PdOFSOuhA/OMpvg6dHQQyp9wYh0oiN
         XPoR9LArv80rTqeg8AAf6rOS/hbzMkr/lPut1zc011k2R37/+/AccaFOU09LlhjzSzkE
         sbovcbOJ5Cp5bKGCCcgOEhb8wXPS4nZFv4TkQyiOLDhqkh6eUp2Z9D5M5QhY4BKZaJUi
         Sw4OX3YdtLIrtu4AJcIrAHtf1QEntUabkhGZjOiW1N2il+wJ2r92ceL6pPoEx3z0PMOE
         Xk9nVwtD2GVM2LqAG37csM4TEBZkCMS7XeWtrw07AcH+D+zPJIk0ZQhvSeoUluFtjYia
         XZIQ==
X-Gm-Message-State: AOJu0Yw3ZYtUFGikaFQoYY3/q7okglyDGq5xZvOx3fGwSBfc/jrsaCGK
	fX8U/InMHnRf+dPrxk1Ly7rhb9kgvtrKXfa0i1DvljZ4WGbo1EzeyXv9N4Ny
X-Gm-Gg: ASbGncuTeO5wMEkzwdBKvXWlUMppSllO61n68t/1812z58TKfeNEN0pqhjdjJFnRclk
	ztChGSyrln6dALs7aNz5eSmJ5AtBhENicGCl1wL0iDF5wH5LJdhPA9eo4FkTNO83uiExWXUZrre
	nyyAEEFAo/BhE5pe+4k3RJ93Lk/6xjMAbo0JNaXIgC05wkF8qz+/11EIdQN8MvFlx6dVofQlptK
	aub9KG2yrk/2bRlm0E3/PZIQ0Y4QBnnfWatfcU+Qodlde1d8SnQVWojisnvcUhoIAEY6uNT/xRv
	3hqQ80uspc+/Tz5ii11z2+7XW6tPUiKU2jZvT9k6F34kYaBZzMBJtOpo3ZIuu29DAmh3goSDdzr
	aCx3AkIj0yBadznEsBnyI7EdQ
X-Google-Smtp-Source: AGHT+IGnw7kGgOpE1XRhY1hiGce9g9CP0if9+8wIir0VeJdQHNCjI1OSPk69v1xofvDMzvFxg5eSfQ==
X-Received: by 2002:a05:6512:1242:b0:545:2300:9256 with SMTP id 2adb3069b0e04-54990e3ed96mr4139853e87.12.1741604881376;
        Mon, 10 Mar 2025 04:08:01 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-167-109.NA.cust.bahnhof.se. [98.128.167.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae58a7bsm1423030e87.72.2025.03.10.04.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 04:07:59 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH] git-clone doc: fix indentation
Date: Mon, 10 Mar 2025 12:07:56 +0100
Message-ID: <20250310110758.601206-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.472.g01f2b84529
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit bc26f7690a (clone: make it possible to specify --tags,
2025-02-06) added a new paragraph in the middle of this list item. By
adding an empty line rather than using a list continuation, we broke the
list continuation, with the new paragraph ending up funnily indented.

Restore the chain of list continuations.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Based immediately on top of bc26f7690a. Could equally well be queued
 onto some later point, modifying git-clone.adoc instead of .txt. 

 Documentation/git-clone.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 8d0476f6dc..ebfb608885 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -279,9 +279,9 @@ corresponding `--mirror` and `--no-tags` options instead.
 	`remote.<remote>.tagOpt=--no-tags` configuration. This ensures that
 	future `git pull` and `git fetch` won't follow any tags. Subsequent
 	explicit tag fetches will still work (see linkgit:git-fetch[1]).
-
-	By default, tags are cloned and passing `--tags` is thus typically a
-	no-op, unless it cancels out a previous `--no-tags`.
++
+By default, tags are cloned and passing `--tags` is thus typically a
+no-op, unless it cancels out a previous `--no-tags`.
 +
 Can be used in conjunction with `--single-branch` to clone and
 maintain a branch with no references other than a single cloned
-- 
2.49.0.rc1.472.g01f2b84529

