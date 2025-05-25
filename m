Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E5376
	for <git@vger.kernel.org>; Sun, 25 May 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748140988; cv=none; b=UZE5GCIdM7jAGG+ikQZeLsMMl8/q+0ou4wwvd2dVRwP917akRAIoewTd4sfMk+dIld33tnlepXINsVmVurDMNptgkoweDLwPmSL3aOxmEEvQ/5b5dOemJ8jeF/FrO4hDw+RE5wpjDCZUBnst7zcWBUlGa2KBqt4qADTtbvbUzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748140988; c=relaxed/simple;
	bh=U/kSGCSTmhWF/0wqN8caA+cnQGyZXQ/b/L1wHkj9Phk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=azCgvvSrCzKoqK99KUWMrLC4PbJNZ3fiXJyynWEOmVlAiX/Yyf6aHydgTm1GehiAqO2pUBsiydrMp09mzn53kOSnwfQEF4DUU5JK/PDBUuUC5IULd8R7YKSu9piPZ5IXC8tw1iY/zWDkZ485szSv1O2AOEFpo4+pKLJy9b7Wtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op63fT5V; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op63fT5V"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so9329965e9.0
        for <git@vger.kernel.org>; Sat, 24 May 2025 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748140985; x=1748745785; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX7GrCzAcw8St4LqWJ31GQp6IGNheU7v5yxBJWfBvbs=;
        b=Op63fT5VzgWzUhZ8bitT+It2wA93IHiUSmaDjHG2b0oUx/sWvO5FWfC99Fbpag1Tig
         vAAp3BNLH9voc8fEGEEus3JmxutxHs2B1fPWjf5ALcb3ZUzfoF/Lcgk+OUO5Wp28I72+
         ViJy1ItwBsGUFEIymeK4frU23EP2+PcI1n4nZarU8HrLpVJzaINQXL0aUvKruSQC/6iA
         ZEkhybCywp/ANwbi7hUH/h96cj41zkv5nuMtmwg815KyzIMjVEhtGKyIVkveaStIBNWb
         iMIgXbNyiIm9FLdQCbAAlKPHEqBGeNJC21hpv/u44ti91wkFY6AUBEQmzLPBHzOTZjuu
         5XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748140985; x=1748745785;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX7GrCzAcw8St4LqWJ31GQp6IGNheU7v5yxBJWfBvbs=;
        b=TXCkUMJFkPnHOVJDrspVBikOi4ZbgkHpj20hW6gUgC7KZjlL1RNH6HruBNJNGt2IGT
         AjbR+3tOdf2LQ8RGhNOL+Zfa6GYgLJkXfoQSkFgeiXDgUDYp+FbzyjGKJCtJg3zYP/tz
         az1BwzOcLAjly1BkYjtR6k+wUs+aUD1Aa520Nz11xZBqdiBz+2gZYC6bfaC8bLtMvFjR
         ti4hI5pwjGiQhpy4kPjJvIkHz31rgQOaa2bFKLIxPvrAk/f0Y9nlikKwngkJ4b7FmYZh
         sjVGZ7j6EDynUj1OmrOsRUwY9Fy8iBf789nJHOYBeZnn16eWciG8gMhZRrIqQZeQQuHz
         FWRg==
X-Gm-Message-State: AOJu0Yyh/3RD3T4Zxpp3VNuzfp8Jyx+BRSQfy1xzPct6p6owK/FUH7PB
	+tzyxMmLnCM9mn1HhE16tlRkf6r2C0a0NY5R5CIE2noJyuXa5Sx3+nyBe2NTzA==
X-Gm-Gg: ASbGncslts1JYrHEyoGM4qa1Z4oHAvw2CvHSGey0OoZG9hWFy5fQKP0PDv4E0ZwJAtd
	8fVoVJcuCMa9usuwXyDdumvOCJkREa47vppkyPJb7+GMOOeNDCW8oDCvRpAx1B/t/lIrRVT1Ryd
	JJozpVWJclQt2QkIYLOqF/Q5zWOAaKpFe3nssy+Y6X8Q68v+JKcUjqwS1Dgrhmg5bGJO1bDFLzY
	2HTwn9idM2Ju0Njy3/5vFHG5sTUfznfbVUrRj2kveB4oo4uhyyVrOgF5f+jED8CZ/D4LHDldF7u
	tgquS/PwGwFr6r9PWJy3w2Pb/oeYo2LySAQD5wpnxDu3tDlRookr
X-Google-Smtp-Source: AGHT+IFR/yyCDu/PVn/E9/K28W1/Cu33uROt1JIjd02/bhYOsPUZUzgPVU5j4C3VxIssuoD+PuAWmw==
X-Received: by 2002:adf:a1c4:0:b0:3a3:6c58:ef3a with SMTP id ffacd0b85a97d-3a4cb484513mr2355566f8f.43.1748140984522;
        Sat, 24 May 2025 19:43:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cc932836sm3738242f8f.39.2025.05.24.19.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 19:43:04 -0700 (PDT)
Message-Id: <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 02:43:01 +0000
Subject: [PATCH v4 0/2] pack-bitmap: fix memory leak if load_bitmap failed
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
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

This patch prevents pack-bitmap.c:load_bitmap() from nulling
bitmap_git->bitmap when loading failed thus eliminates memory leak. This
patch also add a test case in t5310 which use clang leak sanitizer to detect
whether leak happens when loading failed.

Lidong Yan (1):
  pack-bitmap: add load corrupt bitmap test

Taylor Blau (1):
  pack-bitmap: fix memory leak if load_bitmap() failed

 pack-bitmap.c           | 94 +++++++++++++++++++++++++++++++----------
 pack-bitmap.h           |  1 +
 t/helper/test-bitmap.c  |  8 ++++
 t/t5310-pack-bitmaps.sh | 27 ++++++++++++
 4 files changed, 107 insertions(+), 23 deletions(-)


base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1962%2Fbrandb97%2Ffix-pack-bitmap-leak-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1962/brandb97/fix-pack-bitmap-leak-v4
Pull-Request: https://github.com/git/git/pull/1962

Range-diff vs v3:

 1:  cf87aad7c99 ! 1:  b6b3a83a224 pack-bitmap: fix memory leak if `load_bitmap_entries_v1` failed
     @@ Metadata
      Author: Taylor Blau <me@ttaylorr.com>
      
       ## Commit message ##
     -    pack-bitmap: fix memory leak if `load_bitmap_entries_v1` failed
     +    pack-bitmap: fix memory leak if load_bitmap() failed
      
          After going through the "failed" label, load_bitmap() will return -1,
          and its caller (either prepare_bitmap_walk() or prepare_bitmap_git())
 2:  f5371d7daa9 = 2:  7876d9a9014 pack-bitmap: add load corrupt bitmap test

-- 
gitgitgadget
