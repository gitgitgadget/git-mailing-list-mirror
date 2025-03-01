Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BFC1D9A50
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740826757; cv=none; b=Yi7F69S6tJ2huX+nsddpiK96KWyMGWzMbKyb08hpVZaZEljBz1N+TYlotqmcuTL076Dq/h812Yg0YYIPS+J+ddrVBSm69PaPd5GYUAsX9mf5UtUNTvxnAdMmLyMGNYHarCE+/40vReeayVWDJ/VHutvhZ3ov6T2F5vcnUwrMBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740826757; c=relaxed/simple;
	bh=zSWO/SaI+RJcY7tNU7VshAvDS6CZ9ZGaJEnw9uTiyBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VEVpPtrD6kXOnn825ZRX8QrAqWRAbmHkibav50EVWnbkTsUgKJJd6tNX3+3Wzvk0vNv/gAckg+1RnAtxO6p+CO/kr77J/LdDIFG4ZiHNR6wr90qdD54rW+B6R7N+17MXBzPCBPw8RlEGvLEUlaiVJcfuR06di2+ij5xffikSb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG6wYpJM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG6wYpJM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2211cd4463cso57486475ad.2
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 02:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740826755; x=1741431555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLhiVp3LQliQoH1k76FmWy21ZhtvCpRbtnOftP471Y8=;
        b=VG6wYpJMGR3vlm5OEzRL8Lj+WxWKuq7mu5GX381rfYE1FQrEdIrNCCgKXg+hjryTw2
         YdZk4bYkCgp125BxwUou3FdoNtVmkeuWUTTGhXXPHiH7W3+/c+y7QBiVO4TDVddJ54vI
         gB0S+If2OdHtjk+23ggy9h9w8eC1FzOhGo4NjFOO5diTNaAUAO+xLHunIPazo+jqX2fC
         Q6nx1Vp6aGft3LlihEI7LQQdvdPU274P8EdcF4jlCzGZn5i+NQC5exAnRqq+cCQh0U4r
         SQeL2Y4c+7DIQg1OKjtz7JsorSOW/qZChZG1UxDNdTRsenjhehM6fgmoYsqNsTjAbzG6
         48BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740826755; x=1741431555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLhiVp3LQliQoH1k76FmWy21ZhtvCpRbtnOftP471Y8=;
        b=L9aCqSnX2xfD0pcv6k2k2tlyx4OT38J+8GfEq4NEWIIwXBO8N+fhDPDm8TuvbI/nBO
         9HbnhWF01uZElUsLYnU4B+pmF0TVhKl18E/nB8zg7eKf2873xFbVV59Tus051NLYYz08
         gpTHQCRuw3Z9tshmHUCWFX6IpZzcS51eW3wxZAgiNLcmsFEaLZ5mfYwxLkksMxCLPTYr
         n+n9EbO1tLy26aKW55lHjkLO3sBS/MeHXHnL7dykFphX+k7nvTDbl1WRKikU13uP8HiJ
         kKE+Mtl5tYan99eyr/aSx9Z9LBADK5LeYgT4D8j1VEAKbKXpwdL1LYzVsgfH8JROzPTq
         S66A==
X-Gm-Message-State: AOJu0YwwKAznor4ds9qQRpF8+bxUA2chKvwlxGBGg+kEkwiS/2N6kNFn
	LYC28m9dpbwP9FJhsIH8dqtKt/suR/9ei0mLtkoD/P9Gj9gin0PNP3Kp5bDQutQ=
X-Gm-Gg: ASbGncvRGkvDKjry/qYY4Z+sXXLfzOQfzCA5LKKJom+nKeq+dSXJjgkaCIPmJEQQwYi
	pw6oZ17NVFKxfk7xLlJ5hAlTsxeVsDA3LNMyNEfDiAA5nRSlvElHXW/3wG2vEphMj2n2cdlpIUy
	1SL6kNtMMAL2GrHmqzD2E6qh2TQrSXndFm6dOOnKFwlDdCEUTOZjWXwh+RxuzNiB2SCzIQbNUAq
	ll9mHCGB7faoU4u0yXq3Jo4QD/CIyWIdQBmu/EsQN9qg/KZHB1VFvD+tJNVnKH9547dvkYCJ9sU
	MJr8T8iag1a1xS+3abHmjAFYus+YDL0UUf0+lIKzlUd1GvTb7eZl849Sv4dMtJLXyMeR9hpLVna
	NW1g=
X-Google-Smtp-Source: AGHT+IFihrP5HxazeMsLg67qLF06vRsm4+mng1KZgItiXNZRK82vSLB+1iPDdtMDKex1n1Jd+ykxng==
X-Received: by 2002:a17:903:98f:b0:215:9894:5679 with SMTP id d9443c01a7336-22368ac4102mr107912415ad.0.1740826755358;
        Sat, 01 Mar 2025 02:59:15 -0800 (PST)
Received: from localhost.localdomain ([139.167.143.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5cf4sm46156505ad.130.2025.03.01.02.59.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Mar 2025 02:59:15 -0800 (PST)
From: Mahendra Dani <danimahendra0904@gmail.com>
To: git@vger.kernel.org
Cc: Mahendra Dani <danimahendra0904@gmail.com>
Subject: [GSOC][PATCH 0/1] t1403: prefer test_path_exists helper function
Date: Sat,  1 Mar 2025 16:28:37 +0530
Message-Id: <20250301105838.1481-1-danimahendra0904@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test -e does not provide a nice error message when we hit test 
failures, so use test_path_exists instead.

Mahendra Dani (1):
  t1403: prefer test_path_exists helper function

 t/t1403-show-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: cb0ae672aeabefca9704477ea8018ac94f523970
-- 
2.39.2 (Apple Git-143)

