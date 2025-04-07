Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B623BCEE
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024715; cv=none; b=cRwStI1TncbpFy2ym16rpOBmXoXwRAAbKxMkIafDqSfnc0wJeKJyjKOPN/ITlreZJHRmRutRZwDeWsLl2Mw1GEnSnrUDibaVF7dH6P54pnnCLSW4TOSbhjcnXUpk5LkD324gqDjgpxMrEcMo9J62FwMn9AiUol61Wp1l68u+/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024715; c=relaxed/simple;
	bh=DrguJfPN8GUt+YEOLN7rkf7ipujmM9iqowID8r/N+Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RmWE5vyemGFxq0WWxgrL0R2b/TrXwsI/BcwCt46rGJhFUw3hU/pniSKKQp1GEFFZpXnTTbL0PWptmkyMDC60lIG1Rava5is+MkcXO2cVLcTkdfdWzCDeJxR08kWkC5JIylF2oJGfhtSLKOoGvnpELCUcnP2kMjHT/NErkQ8jeN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbBBQ2nC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbBBQ2nC"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso8313420a12.0
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744024712; x=1744629512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF3xzJyUHV0PXVg0dOiVOTM/IK6avPHTzjkcBoZ0DUA=;
        b=CbBBQ2nCgh9fGcrFeEjpgPTgDvWOAYdbD74dS79GYCo1UZG8BtlfeHup5OX6Ll2ZTD
         bPrlgZndsMsydXnngWRVgmfvXYM0kMNPjs+I9dmNsn+gC8Yx7RssxLMOvopEzMcywg0a
         pzRjJKpzWuEQ0lsCnJIkFNPu0Pc0Qb3Tes4p82h9HTMwChdVMtDrVVU2jQ8s7n+FmOGB
         S+dqKA1bmF09qeTSbXl2sdylPHdIIKtJ0MAwVa+e6B4HB95566zlyNQ5cdxvaiLw3h0a
         kuKmizUnETbG0YFbtqV0reFOWbVxhlhz8prsU3RC8e+xFbs1sdULG0bINNiJHdNKfUNI
         FmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024712; x=1744629512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OF3xzJyUHV0PXVg0dOiVOTM/IK6avPHTzjkcBoZ0DUA=;
        b=kvjKqaWsBp73l42lZlAqT5+QXjdEtXZEVTpzV0jbp/f9xBiTv99JM5iGYomThM613I
         hOrFJTE2Cl4u/H9djRXfZDntKK4O8F2UDkzhOLXj91Kn6ltbQCvHHDyitqLxha1sewq5
         K74SXFu8s1/pIx/oECdOX0NV7vATahg19aWEOTczqQVt+AE4xJnXgsZqkCHsMkepazQl
         HNR/P398nZ+EC1ptsr2O47s5Is1guelKvgQbE8VEmLcr9IquiD6s+OeDFT7DiYpzbRX0
         Q3is1ddVm+hxGTGVkLcmqdgQbKQGeVabKwvXluTegDG5J18/tpueybgkPykVL9H7scY+
         U6qA==
X-Gm-Message-State: AOJu0YwKdtnalvGB5H1eaZuSzGyWzYbfb41NYnShROR5OeXDKbMo+vLP
	QGaawkbG7RekIM84KF8C9zzbVHFituEGmnY4yuzPWLdg1uSvs6u0ClIP/3esLw==
X-Gm-Gg: ASbGncuSTjNpkDMtLCVnSdnU3lJDHfVIB7Xd4scjS5yWhoNBCYlOM78Cinuobb09Veb
	VzZQr3PWqRvuF//v2OPtvzWUf7/F/ulFdSvhS0ave/qfcAvMOOw+D79AlabSx0zVrHvBBzreVE8
	S4nSEMS37Xm9bq8Ljw44fukYxp3NhKRepnw8mucZr1ysX0Kh3izr6LzYnfRju7iDM4Rp3Ko4Agd
	VCgfe+ihfTWBtVgVB2XUW2GnBih//06UHmpCo1cAGga88OTYaHumBQzcpWrTarBzSAhmw/c/fJI
	8yRXiJEblYNJ3NAFBcY408F66UFQpO3qKfQVKq+jXpVSWsESYmKpT6kJLfzdzzDwE9rTH1/uF7t
	GOGk+BXtfJk9h4yaIIl+zZrz7zznv68q7ScvQSIVr0dtAhDJdTpHoGzeDqU8QW1S+qmohPg/gkY
	KjIhazQlvXGJaE9d+vRtQk+9g=
X-Google-Smtp-Source: AGHT+IHWaqGHZyOPfkDtejW0VkmzJ7hFLITwJLvYyHMBBlHCi7EVIgqcAH0BcAQs0Aj191tsAfyTwg==
X-Received: by 2002:a05:6402:34cd:b0:5e7:c773:ae35 with SMTP id 4fb4d7f45d1cf-5f0b3b6089dmr10267225a12.5.1744024711093;
        Mon, 07 Apr 2025 04:18:31 -0700 (PDT)
Received: from Anthonys-MBP.homenet.telecomitalia.it.homenet.telecomitalia.it (host-79-1-195-126.business.telecomitalia.it. [79.1.195.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088084f17sm6613826a12.61.2025.04.07.04.18.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 04:18:30 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Anthony Wang <anthonywang03@icloud.com>
Subject: [GSoC] [PATCH v2 1/3] t9811: avoid using pipes to expose exit codes
Date: Mon,  7 Apr 2025 13:18:22 +0200
Message-Id: <20250407111824.46518-2-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250407111824.46518-1-anthonywang03@icloud.com>
References: <Z_OEAxJENE_mGkVa@pks.im>
 <20250407111824.46518-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit code of the upstream in a pipe is suppressed
thus we lose any exit codes of git commands that are piped. In order to
ensure we pick up the exit code, we can write the output of the git command
to a file, testing the exit codes of both the commands.

---
 t/t9811-git-p4-label-import.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5ac5383fb7..5abac938d0 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
 		cd "$git" &&
 		git p4 sync --import-labels &&
 
-		git tag | grep TAG_F1 &&
-		git tag | grep -q TAG_F1_1 &&
-		git tag | grep -q TAG_F1_2 &&
+		git tag >output &&
+		grep TAG_F1 output &&
+		grep -q TAG_F1_1 output &&
+		grep -q TAG_F1_2 output &&
 
 		cd main &&
 
@@ -208,7 +209,8 @@ test_expect_success 'use git config to enable import/export of tags' '
 		git p4 rebase --verbose &&
 		git p4 submit --verbose &&
 		git tag &&
-		git tag | grep TAG_F1_1
+		git tag >output &&
+		grep TAG_F1_1 output
 	) &&
 	(
 		cd "$cli" &&
-- 
2.39.5 (Apple Git-154)

