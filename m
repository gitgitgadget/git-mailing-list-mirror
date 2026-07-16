Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462242CAF8
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212078; cv=none; b=RJEVUh8jiAF/UVuWlxRSPtlilunHnHzJMNe/ca+Fkk/Azq7r9XU0i2cdGw0E4ButJU5MGSJbEhs2807HNUJZ0emvUc4uJUFrmpAY61CGFoQLKxJ/0thqclz00oRKE1RPILpobx7zu85VyIQpPTdFzPot7NY7evxUrPLVwelB2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212078; c=relaxed/simple;
	bh=r9vuL0z1BQ6TvkYm2g4WdSOjP3pcyzWjAzwci0kEPSs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aueDAMPhceWxSEDSMi2mAoY2PGQvwpujAb09o/2l3wt8e2riACHU637rb8QLxG2xnHFAZXtUSSU7PD9RHQTAITdHRNN7c8kxk6qKy0exSDVsdU6kc3fWqSNOhfaVnamSf0IvzVD4rGrLvDFW7fXVq2ve/v5zkPRpNJx2zE+MlEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANXGEIy7; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANXGEIy7"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so40215416d6.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212076; x=1784816876; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/oB4PJN33/IpyKMirvaJk4vuXWZ56tV7LxKo67ObkuI=;
        b=ANXGEIy7KR+sYsjrJNU8q9v5aPb0w5lU7AP0ZrH2134haPkWFwEgAgOuP+pq3sbtur
         8ILLP6MC5FSAEWdSKkjIFOUuvRH7skRJ/ZI+/8LXMCwRSng86AhGm+fJkMqMLWUfY2sZ
         ywdsKasLo8d+PBiol+NZlK+6mY3x6UUOmGRGURh4leBmCrWB8Et6xOQSVCtKCSedLMdK
         k0KIFqT9MzQOGpV8VHr3ZRXnuVTfEl4yqPdsJchFD5IvtzFMzCzJ+40Y3JlE7dSddTPt
         4UsFYVx/ek/j8BFvFxVCsX1vavLrhgGZf1e7g2V649pmfExKsUTleucP+YPpVHwZmbUy
         AAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212076; x=1784816876;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oB4PJN33/IpyKMirvaJk4vuXWZ56tV7LxKo67ObkuI=;
        b=Eca1T1xoBLz5UDb38CHH/hQg3vZbjREtR9Cr4/mwoT5Yv4jOnFpQgWmPPPlrGfvxMI
         Kc4w15qzZA3AUSFMBBK7OHRTO4hqOC6XOYNRlrl9RuoGXBnfOzpE+TqCoyuEQtlYyOER
         IqS323/zSpCYra3g+Zvl01W5/iCd68NtniTWGQ6IifEj6WDtRypCvN3g/lSqminyYOVF
         JFKMbIgaZsePJ5SyBsN/LfJSIa73lAFTO73Yesn9qZyzg8oEU1RT5X+Ju4W52xz7Ei78
         VH/E6q9DPtd6UTHptqHFv/HskpgprwjxbFl+Ahhrb0cix+v1VdPMyFJwvOc9EAPCTn5j
         8scw==
X-Gm-Message-State: AOJu0YxEg1vhM01twFJqD2avvB8p1AOt07NseLeAMS5z8uHR5w1S50TB
	d3EqA1cbT9TgIyEb9Z8I8GzMd5TIsV01eZvU0oLDxV9mP6humyCyFN1pg1lXrg==
X-Gm-Gg: AfdE7cmFiKxM1SIp1Bdj9JIOL6YfsijiwumzP36ptPn5q7J7GGdEpIc2l5s+d/dpfHY
	HjFOYaxh2CPTJf914lk2y/ObhpVJgrBZPssaA6sVWgDvxx/DkBA63L1thSShrfCnu1Woff3d5o5
	S3HIPGObRgR3Fv31cDhVViwfARvWAvLdsrl1eXIdbiHVpJhQYd+rIWapxINAwjmjiPjEU1cZj6D
	qfd5c4fHThMxnxPqy92JdfNW/gi8e25ksLMsbyvHSw/34TBjJUm1RvosO/J9CVdfX8oCMax9RxW
	l8jgE8J2LJLOqWT1M8WsQFegIUXo3i20m6Mk4nt7WQ95iLey/Gu/IJrdpi1IOmE12YUYtcjZEqA
	BsH1BryU8r7iftve4Cx9Aldz7Je4lLv9g7Uc561X1ZziKQsPLVu2CBbzO419miuNOER9b4rufv4
	+iEY12oKIUgIlHGPY=
X-Received: by 2002:a05:6214:8110:b0:907:4850:d191 with SMTP id 6a1803df08f44-9074850d6e8mr136063236d6.49.1784212075721;
        Thu, 16 Jul 2026 07:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82e9d5csm219072466d6.41.2026.07.16.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:27:55 -0700 (PDT)
Message-Id: <2ec24be3b5a121736b5f4f7f6e5450d577208d21.1784212072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2182.git.1784212072.gitgitgadget@gmail.com>
References: <pull.2182.git.1784212072.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 14:27:51 +0000
Subject: [PATCH 2/2] wincred: prevent silent credential loss when storing
 OAuth tokens
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `git credential approve` hands the wincred helper a password
together with an `oauth_refresh_token`, the OAuth branch of
`store_credential()` writes one WCHAR past the allocation while
formatting both fields into a single `CredentialBlob`. On Windows
this trips heap verification and tears the helper down with status
`0xC0000374`; `approve` masks the failure, so the credential the
user meant to save never reaches `CredWriteW()` and the next
session prompts for it again.

The bug has the same shape as the one fixed in the previous commit:
the allocation leaves no room for the terminating NUL, and the
`sizeOfBuffer` argument to `_snwprintf_s()` is a byte count where
the API expects a WCHAR count, which lets the safe-CRT runtime
write the terminator out of bounds.

Apply the same remedy d22a488482 (wincred: avoid memory corruption,
2025-11-17) applied in `get_credential()`: allocate `(wlen + 1) *
sizeof(WCHAR)` bytes and pass `wlen + 1` as the destination
capacity in WCHARs.

This closes the second of the two heap writes tracked under
GHSA-rxqw-wxqg-g7hw.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/credential/wincred/git-credential-wincred.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 190bbccdf9..22eb27ca31 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -208,8 +208,8 @@ static void store_credential(void)
 
 	if (oauth_refresh_token) {
 		wlen = _scwprintf(L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
-		secret = xmalloc(sizeof(WCHAR) * wlen);
-		_snwprintf_s(secret, sizeof(WCHAR) * wlen, wlen, L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
+		secret = xmalloc((wlen + 1) * sizeof(WCHAR));
+		_snwprintf_s(secret, wlen + 1, wlen, L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
 	} else {
 		secret = _wcsdup(password);
 	}
-- 
gitgitgadget
