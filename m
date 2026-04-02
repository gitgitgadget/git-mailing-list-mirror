Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EEC2FE591
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141883; cv=none; b=kGOrR/XWFwYYp40xU1jKJNQwj+ojHJF351OP27O2w2c3lkoDphRtCKoTQbrS3pE3k6GKQrJZ7u6cyNUzITnaCONeOsx15QkmTyAPSYSVVX0rX5CyW8Pa7rO+SRYIK30ILNqMlNSmDEJ/mdHZQjMkP8Rh2MrGuhDTKAErEhzF5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141883; c=relaxed/simple;
	bh=yH5pSPSLSd/tXsE08xm00Po2cbVjGytpg5l0f9ebNsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxRO8ojccvqks/cXnPT+R+eW3SIQKtCV8JGlAORgNzhMNCTvseTfuzHT1Ro38y/fM9HzApmYh/Iqkxxm477aWNUgIVQyq5lGH+PMezku/+DYRpSHgH6n7BR77TeEDRwBmO++nmROGg7zNxwU7VnnyWyPfpG+7SVRZQcydFM3Ebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTiIOY9j; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTiIOY9j"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so8956755e9.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775141880; x=1775746680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SX5R9I70ANt0T5SNHk2H9F8Huc0rBsHFiUOXgCMnsYs=;
        b=HTiIOY9jf+3+l8iVFbryUHfMotUmXu6+a50ZRHgl8UuuQ4NmpN0Ab4Zrg92F4YF/ey
         Lww9zJ5KIbBBBqxebbtFkJn4DHsF4i7Rk8K5qjTrcnrEgSYif+LNhsGvZYddHHExYavf
         D+UvJM8F6H8WJaxBA/wNuanTO+itD5u3GnWU991N3al5dGHeIk/gAZtbrQeRn4Irkwvs
         wsA0Uz8ci8WKNju6jZfivi3njbLP4OYRhRYHEKqowvc6XBg6iNcobM8WX0tfJch4DpF8
         KOIEh6l5d22EGH8hNNxlBQEIhhkK2fwJ9IWj9NXUCe7AEiVOzIZCiu0P1HF99GWNakoA
         e94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141880; x=1775746680;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SX5R9I70ANt0T5SNHk2H9F8Huc0rBsHFiUOXgCMnsYs=;
        b=E9/w2WJQLsSsO1L55X5Vvg6MnXUz3KIRZGUU8w032ZRJE2hn9j/WhbZvUauO9nl4oI
         uF9RNJcTc5K6eRXyBra7+5QxDTWkmK1Afpl7Gh10kvCz3lGqe2WX1kTdj9IquswVraIh
         LKEc/2qfJOusMGe7qG0AJfbESRGuBYWXEaPxwzD6e5wxLEzpUZwEx0leS7yZoAhd4SDC
         Dvoyfn8cHYi3GXmGfjckB9f+/+O3E4kyRK1YMzXaEpZ7YkQWh3Sj/kGPKThVrsKD1KsI
         D2hbQErs15PCprw4vTF+zbhPoEb4EmQPHW8KdyT9V7Uw/s9hQDTpqzEB78f0Ca4U9zn0
         8pVQ==
X-Gm-Message-State: AOJu0Yzcmrg+D551pU1Zvw0QBUqrmBrWWernfZfHuqye6T3Q15diVngC
	z93UVB3buxDaj8PYU2HSL/NP8nimTKzi9fh1ebTuKus/3QT1Jdx/RlSqvjGP+Q==
X-Gm-Gg: ATEYQzze1e49HGa5gYhf/jFla+7xgtHJPTkBkPy5t4TISfFyeYOhAjBrCH3eqnQ+ckJ
	8zDHWhDrF45HP36JihgD4zxCi7+zGThsjeMtQHj90jZSEXsOEUKbCKEebCCNUzytK5tNv4kXG2H
	C1o/SuqcIpMvDD47LBudJxexFfQx3a5e/Aby2mMe1S50QzdZ35f0OT/BF4SDdenhm4ytvFmEn32
	0PnPBBJdYw1LOXWDJyBjw3VUFhFzmnaO0lL3zFaXZDBTGah5mfxk7eCVDR7FeCuotXrNejjaJGy
	U1a0ac1LooxRvjmMKZZc3XLdg+8RVqFEitZKiKuikFTm7X+1Mvb07xgNJQfBXF9CM5O8bSDtvgK
	0TJiFXiNczXX8wSkfRYQL4SMiMK979q2UANR87Pdv8nmVI9ov9hFB86pPWUE4FC2SMM31J+1ynB
	jFshTMmvWnyySJ5gIyC1VsLWZ45iotnHPk1oHi
X-Received: by 2002:a05:600c:46ce:b0:488:92a3:dd4d with SMTP id 5b1f17b1804b1-48892a3ddfcmr32507115e9.29.1775141879746;
        Thu, 02 Apr 2026 07:57:59 -0700 (PDT)
Received: from berwick ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8b6230sm70913705e9.24.2026.04.02.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:57:59 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 0/4] xdiff: reduce the size of a couple of arrays
Date: Thu,  2 Apr 2026 15:57:40 +0100
Message-ID: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9.dirty
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the myers algorithm is selected the input files are pre-processed
to remove any common prefix and suffix. There are a couple of places
where we allocate arrays large enough to hold the whole file when
they only need to be big enough to hold the remaining lines after the
common prefix and suffix have been removed. This series adjusts those
allocations to avoid allocating space for the common lines.

These patches are based on 'en/xdiff-cleanup-3'

Base-Commit: 7ff1460b62ffc8f18a5478be5aba9d4599afb635
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fxdiff-reduce-array-sizes%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/7ff1460b6...a3438dc09
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/xdiff-reduce-array-sizes/v1


Phillip Wood (4):
  xdiff: reduce size of action arrays
  xdiff: cleanup xdl_clean_mmatch()
  xprepare: simplify error handling
  xdiff: reduce the size of array

 xdiff/xprepare.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

-- 
2.52.0.362.g884e03848a9.dirty

