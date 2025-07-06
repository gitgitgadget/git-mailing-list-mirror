Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEC61BF58
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751836057; cv=none; b=RxsAo9A6vtQgUydZ+v22LiCdKJ3Yn9mWkgYmYv2VfeYYBZwA39upjL9P7FHGcxBYV2UQcuPbffnHZ0W/uffBAwprT1gPuSsUdIwmfb3Cdpsu0MM10Fm6gSF0mvdjunS2gyOp0tPH2ThtFEb3J258Cvtm9EntRbDrSRL4HVoUFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751836057; c=relaxed/simple;
	bh=r2YjZ5YDWkD7gSZWZ/8P19SieVPvJnp+Gp5FaooeOE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=igEooteb7HW6cR4qMoZLHBfY/5yFy/j3Y/eDbx+z58uttXBWlsDCONAsldAdH3oWYyhWh72zzIgq3xG+R42NogqZU9+RNu61Y7pSSCOMZuGymWx/UU3QJu1xENW1PoT5QULHxD0GRxjyggfnRo0V7qitIvXnPkOnH1alBGQUeUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8i+KGqs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8i+KGqs"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3110538b3a.2
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751836053; x=1752440853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ox5hTM3tBINRsg38El0P8fHf2SrJm2w2Kb4RSAttpQc=;
        b=O8i+KGqsrJ6STfBstkMH1zxI8rZGX0AjnvH0e1VyDIQ7be91Oh4QoIJgeo+ONf/LS4
         4esK7Dcd718qkdFAQZc+NQhr6Mqd9U46a4Ue00VjNmfM4pahE1gy6cRh8aagu3pQe6wH
         LJC2P4yCCJF5b6JPzH/07ezHuZ0bzYksL8nrIooaWNszYIffjQIQApO6hz3iZr2txm+F
         li5FppK3Z3Syb76I6AerCKgHRf/45D25ztv5qKHRIgQvwh/rxbG35bTi5n0GoFWTTLvU
         ixtw2kh/siLdxLIxIoBzus+VJxo834rJswjT4CfYvd67lsoADKEstQFcru96V7njCIW9
         tZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751836053; x=1752440853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ox5hTM3tBINRsg38El0P8fHf2SrJm2w2Kb4RSAttpQc=;
        b=eKG+ZRZVYnAGQJrtFNFDHVXM73+mZRXykh80/g5v9czKvhFh4qy3RMqfZjYg4RYa3m
         LUoLEHPT7NbHxEvp5E9BAiJJEYsg1mQDNjKiWRm5kCXLEAuQsAEHv3p2H8Z2AUTolhNg
         bDdvs1+FP851Fd9tjuWKCNCyRLWdND5LBldgPteGYcWqcE9iw1wGhSfhoxcJY565scHg
         g4KSezmqtpQECMVcZc/cUlcrB+Xw3fk+eduXfZvIrNc5pI0vW4/ABfY9lH9GBsB8eL/d
         7LPT4uAXRfvVHQNuSxrUMlraLDKqOf6yuuIp24Pg46TqzAhqF0T8XafTTpXsNT3lseEl
         35WQ==
X-Gm-Message-State: AOJu0Yx+E+65mqFa/TlNUn+50hKZBvrpr9N3s8qALJ3wNHdCPMnixYTR
	rZGTtdFt8WVy0Jl/p6OAmDQcDhr3mRGfKSvz8i1kAzSo3bE7dS1N0zhW/JFK9azUW/0=
X-Gm-Gg: ASbGncugxR6CY7pN9J4g4NrWS0Hqjiv5KexeV23yZbMn8Psw9nAPUNdvBRCfJk0yVnb
	fomx8AL8E5mhH2qAfQ1+JSErXWt1LN0YYtUTSuzFF6pE7a1l74uc+gy1jvFqCRrGRuKvCVWVNhk
	jtn435ZsGBgNC+45rtVs7R59XZ9LrtP3LUk/FWrejLAYU3Y6NYRIAtaZIwBkrDVZV2dtZQQa3PK
	nNpabVc+/UTalvul42peZd806KC9ZffRDaOnnyemPCA0yEGbZ7be8+Ot/1+hc8SOl6cuKQtA4b+
	BLoeSHQtPiwLS1AgcWOAnRqJCo6CaqAE17LtKaxCgxPTghlfn1KCEBQJJUrsuQeIGqEeBd4ahOv
	49pYL31TN7WQ=
X-Google-Smtp-Source: AGHT+IFiCuLQppa3jq8OfF5PU0Z18f3iMiJUJhMTDXOQjLd+K9QlfzKEum+GMhfx6G9V2z80eFN13g==
X-Received: by 2002:a05:6a20:2451:b0:216:1ea0:a51a with SMTP id adf61e73a8af0-2260cfebb51mr14174142637.38.1751836053275;
        Sun, 06 Jul 2025 14:07:33 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm7220117b3a.136.2025.07.06.14.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:07:32 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH 0/7] move builtin help test to t1517
Date: Mon,  7 Jul 2025 02:37:18 +0530
Message-ID: <20250706210725.79903-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In patch series which contain this
"[*]: 43a8391977 (builtin/verify-tag: stop using `the_repository`, 2025-03-07)"
and some other builtin commands, the help test was added into their
respective test files. Since it better fits thats tests that check
command behavior outside a repository should be in t/t1517-outside-repo.sh.
Patrick suggest moving the test to t/t1517-outside-repo.sh.

This patch series moved the all the test.

Usman Akinyemi (7):
  t/t1517: move checkout-index -h test to t1517
  t/t1517: move for-each-ref -h test to t1517
  t/t1517: move ls-files -h test to t1517
  t/t1517: move pack-refs -h test to t1517
  t/t1517: move send-pack -h test to t1517
  t/t1517: move verify-commit -h test to t1517
  t/t1517: move verify-tag -h test to t1517

 t/t0610-reftable-basics.sh      |  7 -----
 t/t1517-outside-repo.sh         | 49 +++++++++++++++++++++++++++++++++
 t/t2006-checkout-index-basic.sh |  7 -----
 t/t3004-ls-files-basic.sh       |  7 -----
 t/t5400-send-pack.sh            |  7 -----
 t/t6300-for-each-ref.sh         |  7 -----
 t/t7030-verify-tag.sh           |  7 -----
 t/t7510-signed-commit.sh        |  7 -----
 8 files changed, 49 insertions(+), 49 deletions(-)

-- 
2.50.0

