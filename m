Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A025F78F
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757263253; cv=none; b=qdt2+K2gKqW/EJ8E0rzZ5dYLuhhoD7IHCHFbqKgEvlI7YNe8KZV7ZG/UXthgxxQfSj4qhi10MB1q7+56Qt/vrJxIl4Eiwri7j12K+4gxFYPbX1SkYFhoT2aqTecsnWUpai/0Hdb0qoPwp+Zxw3rSzUSObp2rdumHe0r+WmYGIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757263253; c=relaxed/simple;
	bh=YxflvnelRWTDGnYw8qT748OsDUSlpuNkuHr9XAQizAc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rH5hTBTJ/sYPbvXb7NSAGlAF71TA+sKHZQlNlxHyG/TFahOiZaJRLrDYf+yW6TpH7zenjUTi7ewCeIyZrqwmIo4eA2G3FZE09wTPC/rwQb29r4pqFfprJWXRr6ze9pVfvjGlAdtkMJbvtRKF2XgR6SFqQ4aST3hNOrLECV0rPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDPXpNKf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDPXpNKf"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772488c78bcso3600363b3a.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757263251; x=1757868051; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUo+y6+wp6hMvfjarzReyWoDDTFmxvuNTxR8NdSRxQM=;
        b=nDPXpNKfisk6Tu5tQ6GcV0cOCM6F5SwFkF4XJpv4Dn+YHi8UaK9sHE4PVqy0gHRw0W
         GReqv7ErCiL1YrJ1koVtJkr6UAv4/K9jlUr6hNN/ypsfuLPKtlY+NM0evw20r5ietltf
         /K5wUCvhoisGsdH2BWIMGZS1cd/ktUOybY/O1ZD5GJaUZi1YmreiYddElNTb47SpvGV3
         O5ITzmnKWpn6GmwxRXfrlQ9+D6L8CjGEq5FQC52NmmORaaqNV1MloWeTQR0sdZ7S1ilR
         gsrRwNf9BJRlS8lnjVLdJyg6Blm7mEQ5pnkIamDpNGq/ZiitO1VShLKsp+rDxFZpUnCz
         QHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757263251; x=1757868051;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUo+y6+wp6hMvfjarzReyWoDDTFmxvuNTxR8NdSRxQM=;
        b=rZYhzdkAVGzuEizX9DnLTdUKpxGrE7DfqAOot0z1oUZqI/0lGh4H1hNhR+IjyCjihj
         ThWW1g/Cvfsf4zrCVRlnve1cG7C643qd+2GEIKPE29GQwY58FjIiwh2qflUGqR6+usay
         FWe1gk6Caq3p9gTSynYMhCFXLUpewe8xjFIbeDlFg26QX4nWlexZGiuQYHOikLp9mqq5
         aYfwdzb/U/CNZiQSUGuHEcWdgElMypg1yVdd/49obmh40hc05DpUZi1EYBgiN+Xbi1AQ
         A6BjsFN3XMJyOwbV6/cyWCbll3tgDYNQvg09IE2Jjx0KhIJbXL1CwdJX40l5NHRcWQlP
         Cy0g==
X-Gm-Message-State: AOJu0YwBG+S03JCGjYTwZgrfUakV9KxSLQM34Av1pYUQJsaZm+bR/83K
	dTuvLEm4821XywKjWyH/MUluoiOd1KqJZeiGeHc8k/gzoEtLvClS0UoTCgaK4ML8
X-Gm-Gg: ASbGncv1VhoYJZjGxdgr/2isD0P2GGNqGnLI1dJ5y3G6T3iYRXy0MTBuBLwf2twPwCe
	hxF0jYoks8Fgz1hPcvCEJPOC7moKEFld5fdMCQ1wVb0EvOVbtKNBCSeAVRyoIbd+drvwt8mb+wL
	4TzfADkyQwFDFOJRjnJMgs1ZO3sBjHYpVkxYdggpuUJFJbr7f0OKQUjyX47a20ubod2tlsYZJEW
	hXNygwQ3eSGHmWavJOd3d2zNDsJca/hdNH9yejn07pFbugs94z3n1uVYZjnCXE99aff4HPFISM3
	oyUBGDIfs/I7Oaj4Xz9hB0SUtsHqmgp39uCkFrZLRMShq/vbyfDZyNKuUA7ZQuDWgmgS3g/Yp8Z
	+2pGgK8/07n67d09a/5h+Dx/ePVTaw1bXyGS+yBI=
X-Google-Smtp-Source: AGHT+IEPC5BeFviwxfIyU1DnF0hlCS9tHaCuLcWQEdR+utn9gl6fdx4gB6FA2Oy/ni/bOjQA64NCRg==
X-Received: by 2002:a05:6a00:1789:b0:772:48c5:c758 with SMTP id d2e1a72fcca58-7742dde288bmr7457011b3a.8.1757263251173;
        Sun, 07 Sep 2025 09:40:51 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a26a3e3sm27484444b3a.13.2025.09.07.09.40.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:40:50 -0700 (PDT)
Date: Mon, 8 Sep 2025 00:40:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 4/4] refs: enable sign compare warnings check
Message-ID: <aL21kDwK-zGZyJ9q@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After fixing the tricky compare warning introduced by calling
"string_list_find_insert_index", there are only two loop iterator type
mismatches. Fix them to enable compare warnings check.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index a8f06b9a0a..79069c37b8 100644
--- a/refs.c
+++ b/refs.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
@@ -2381,7 +2380,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	const char *hook;
-	int ret = 0, i;
+	int ret = 0;
 
 	hook = find_hook(transaction->ref_store->repo, "reference-transaction");
 	if (!hook)
@@ -2398,7 +2397,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		if (update->flags & REF_LOG_ONLY)
@@ -2791,9 +2790,7 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 					    ref_transaction_for_each_queued_update_fn cb,
 					    void *cb_data)
 {
-	int i;
-
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		cb(update->refname,
-- 
2.51.0

