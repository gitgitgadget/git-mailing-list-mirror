Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C633D648C
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709532; cv=none; b=VQuG78snjHU3SyZOWJOuY+v8E+Xr8SITqq3Ab/mTM1AbvLjeNa2163ywrGh2XjKv+J/XyuO1DyNiyQQ7nPP/rmxXknAyIP/oUykLtX4rBflgtlzHu01j8NJVuOPR07K/t7wuUxjNvUD/vw3TjhzSfE+PjMlIZlzJcS1xJAD/i+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709532; c=relaxed/simple;
	bh=7YRKLG8QhjLCXZPD9VqhDiznxHvKaEySXp45osV7Q0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q/ZLnSn6AERdzGnMNFoNBLXcnUZbKst0ob9mwZeDxqNXprqsQqVhHILRgv/JzF/rFIoDyk+6vCjSK3HBQzfUsSD7UpAvcowOvs06Fri2Za1T82wuXuM2HNKswPjeJZb+wZJSIFPTQcyS9jZaWCKHGRn9G0Nlk1RqUYAob/Wlu/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLx227Ob; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLx227Ob"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e08baf860so9889055a91.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784709528; x=1785314328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XRhBMHZVWK0L3AwTwDx62sp+a02oOVUyqCfjoTd/OzI=;
        b=JLx227ObJH0j/3H5xLojBJ6+71XfiZQ3HrrtD2kSSVE31QPuaRmj9lt5HZL3CZZB6h
         WLGiB0s/BiuDRqHBHn2Xv7lJCxoN4knWG/Y0OV0lvvBfjvsHM78xsyTLMqNut9QAFaB3
         aDLx7/qvs3yNKpZnbTKxZmOkVMBgqOMd0Tfk/q9KSXUGcNIx2RLhhmTr7SSio1kXPlVT
         7EYUt4U7TkJCt+WzyzsW4x1hwJQ4mkwKoTCCDMaxpEx0Ejboec0dBlupB77gXlgjfqFJ
         322JnuI5CCAjC30BaHV0n5I9+55ShE91zRwITfN8g6pnwTrfo4Fbb0fFaYZZ2VWhGoMO
         9w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784709528; x=1785314328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRhBMHZVWK0L3AwTwDx62sp+a02oOVUyqCfjoTd/OzI=;
        b=pkVbKV9iCUvFUfPSzqbaXpOXkU62TwsMtNeRl4chhU/YKYTAsDJQVRmEJBiwe7/cHk
         sOAAlo0T85U0RkN1PSUlA1AbL0dQW7Ck4iRSHw4MgpEvfzxVpJsiEQUS8caxMNUdAFec
         jysd0nTsF9QHGbCOS2wYjHiVSud+pq2IonylhZku5eeQ5rkRS3s51tI0JbaitruTkvxn
         UqLr1ZHhOEc3m18iHGUGgWDdaCrVSkzhLCFV/F0P6/1P5gLZqRd6gdce2FKX3MCb17Q4
         xSATPmtuohNSRSPfjFbYdaF7QeSmUuEyUJZOehJasm4J5Nv74vo+19c+gfV3n5smxQ5d
         JSNQ==
X-Gm-Message-State: AOJu0YxSDs/+p4bGQifMkjhUVvHc8y8js8rc3b2hlQ6uLXNjcx6jX6G1
	cohAiYXhol5rnK3Vs3wFOqFmXKM/iDof7spKcejqcv/s5j4mAAyXNnCfAsXPSoef
X-Gm-Gg: AR+sD13BnXVTAmu9u4odv9ZSkI/6fO4ot/jKwtRLaYeKhvSCoMmNpgHfv0K2Jn42xad
	W99qtvzNJwJCjyKhHvBZn0Bzz8Rta4cZSqA8EFYG9sIlUMdffT6aeH0An39tgWcKxf50t9OLneM
	wPiTyXBwRtz0Hxp7H/j/q5l9Y+/3wyKW4oyZ4h/86DUIPkco1cBiVOy+WJqTVYDBZwOmZm3k3ZL
	Qknmt1Ai2hqKLXUZTE/cFKfeJzdF4MFzYI2vxPs84sHHMAyHyVkhHCRKI3xiWuP4qpMXhsEk5qa
	CHU+N/rwOlUbNIzTTyja1ZTA5E8SQjKeI0yeE0NILN6ILEaA1cu+o/36ufxsbGmrnsHUpsN0cQj
	2NVZyAI4WMFB5gSMeMQqzgDj+RHOdT7S6jSdlDZOC12d4GYfzA/l0AedJYB6Rav1OwiyF+cEny5
	hK/PJtnbvfYvgbpzaHN9s=
X-Received: by 2002:a17:90b:1844:b0:381:cef1:11b0 with SMTP id 98e67ed59e1d1-38e4b55af0emr22553465a91.33.1784709527753;
        Wed, 22 Jul 2026 01:38:47 -0700 (PDT)
Received: from fedora.tail0f6912.ts.net ([112.133.220.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm7203763c88.15.2026.07.22.01.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:38:47 -0700 (PDT)
From: hardikxk <hardikxk@gmail.com>
To: git@vger.kernel.org
Cc: hardikxk <hardikxk@gmail.com>
Subject: [PATCH 0/1] Extract only the message log body from git commit.
Date: Wed, 22 Jul 2026 14:08:35 +0530
Message-ID: <20260722083836.744338-1-hardikxk@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The patch fixes the `extractLogMessageFromGitCommit` function to skip all the metada of the commit object and only return back the message body.

Previously the function would return the entire data of the objects
including authors tree and SHAs. This patch fixes that to skip over all
that and just return the body of the log message.

hardikxk (1):
  Extract only the message body from git commit.

 git-p4.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)


base-commit: 48bbf81c29ca9a4479ec7850fe206518682cdb2f
-- 
2.55.0

