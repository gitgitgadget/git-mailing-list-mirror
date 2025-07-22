Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756F80034
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206621; cv=none; b=oFnXgJOA2cVGmFR893ZzG5D/iZ1hMKdoHM4hrnmH4qkW/oKHc895GMIhIPBrPCPCwFvYrU+Q1tdqkYFmeUCAI+d8cpILqH9RBZ4U8L30CYz2SHhDHVtB9qTSoHw7PE+Qer7ymHo1tx68TFknJCAVRh/yYP2Y3HPsU1YZXoD5jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206621; c=relaxed/simple;
	bh=MrJiiAEzpflU2U97t0hybLdlEy3Hq6q+yTTsOtDHlmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ac5y1LN7uk0lx3sYRkqyzLsVbbC+Y2DhU8O+QaE2IX+RvMzhe0MJVI7cJPVjv+5P8d5XuQNG4cg9SZwlp5tBOA4/mQzyrd0c4u0Mzvtg972tDI51zCQVpHnW+9vI1/VQzaPcP372T9g1fDMsx4BDaanH2V/c4SV6mV9qIv3wEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdgHMhPq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdgHMhPq"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3220c39cffso5705825a12.0
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753206618; x=1753811418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+nihSqlUQ1Xq2FafczO0iWubG8FnrB8v2HGx9t8Zxs=;
        b=SdgHMhPqdTLmmsVZIuzSrDiDpO1dGjjenkKuM2q5MghR6xo79Wmzn1ZkA8FIkWmaQX
         3VdaZ1tGDqUgNBAiU7ErNSr5SbX0COeJATHNfoRgXtPPU2F+WxMwF9yjs4C/CR02wNQp
         SkPuLtOLfQLJPQWNHtI+RM6reex6otVGEvhqhLoQKWeWZ7cF+eEBOY1ZpfEZIPt/6aYq
         j3rllSWK5fB9Sumta3EIPa1BMijY6QZn9j/OCbU49W15eSrqC/laV3HPQHBnQPe69D9I
         Tf64n8wgTtIzVsC6Diz7G0nful1KAogXR1Js5NJ0mTOP1b7Tmqgm+frtR7E6lB1eYv80
         FVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206618; x=1753811418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+nihSqlUQ1Xq2FafczO0iWubG8FnrB8v2HGx9t8Zxs=;
        b=eebx+yDyjN2KXvByN3BzrUcBFerpZ8+Wt9SBXaIoivdSfKFvgUbNI5WsT+r846NIGp
         FhAJsmdLnZ/Q986MDYxvZ208ctB15A4E1eVxkYC27qUfY0QSdfA8OzlouZ6vUDYFotdt
         uFS17Gy7CzXXM+CGT4bsE59GiMhw7lqFg8zZ9CMyE7cLvqaR/eGtfrJO+nTsm9eem6PK
         CbNAnKiL+Iv4SgbkItEk+qM68eLJ45nEuVd8cIpa0w3vq/QnAef8Buehsljr4NwXrv6P
         rtVUdkRjCEJQfm3etdoZvJk+5pi4syDaAQR73kBgxcX3lx3RYGCOeoDrutyBQpKlCAJO
         g+Kw==
X-Gm-Message-State: AOJu0Yz+wwfrKIdhd0lux8MrmBAVcnNKaCrGRlDRJpVHo3+DsFbym6oI
	HlaEgkTZpfi0H3ebeG1jP13pTG/08GwLHpqo1yE9ybhuzYC30Yu9iV1All7lPA==
X-Gm-Gg: ASbGncuO25TCVUB8v8lphShbzSXoTjbeIz+t/6wqtecK+V2xRJlDvVL+vx7cAvZJ67j
	uuygh5abYvMuDnREVgGRHvmjYvdO89nE5icE1n3r+kx4QMVZdh+qmq7k9TTrzuRzr23i9Wrjngr
	hJEOyc0C3zcvBzvU1Um3DetyRsTHg7jyTRVEEROJBPKR0mOlRnwpBl2yFoeC9I4Uo7P/UQmIweH
	A/qBPELwbSm44yGUo7c5PoDfGAcTIJf86Xt/WAIHTqB9YoufEpTj59dwkiDVC+kyfvC/Uw+1e0p
	BGrWegs9Kv0LrpYOQqvQSmtopZusdj4fTu6gbXfOiHjIZyhvALeq7NEswREkwBmXkvbtbEhG2XY
	j9QfDflJsHzCsi4T44xFA8lIKnu4IZTv3Ww==
X-Google-Smtp-Source: AGHT+IEhrUpoRL5/k6SzJtoVytv1mHWhyP9t/o8gWXDu/ImRueSNe3dL41z++8q1PHgN7GhruPkabA==
X-Received: by 2002:a17:90b:5303:b0:313:bf67:b354 with SMTP id 98e67ed59e1d1-31e5061d76bmr386356a91.0.1753206617831;
        Tue, 22 Jul 2025 10:50:17 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e6a8bsm12283493a91.18.2025.07.22.10.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:50:17 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v3 0/2] fix resource leaks in test helpers
Date: Tue, 22 Jul 2025 17:50:09 +0000
Message-Id: <20250722175009.2125844-1-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
- Dropped the second patch (`builtin/archive.c`) as discussed.
- Combined both resource leak fixes in `t/helper/test-delta.c` into a
  single patch using a unified cleanup path via `goto`.
- Ensured file descriptor is safely initialized and closed only when needed.

Thanks for the detailed and thoughtful reviews. Your comments helped me better understand how resource cleanup should be handled, especially when dealing with early program termination.

I especially appreciate your in-depth explanation regarding the difference between true resource leaks and stack-unwinding cases. The example you gave was very insightful, and it clarified how automated tools and reviewers should assess whether a resource is truly leaked. Thank you for taking the time to provide such a clear and instructive explanation.

Hoyoung Lee (2):
  t/helper/test-truncate: close file descriptor after truncation
  t/helper/test-delta: fix possible resource leak and ensure safe
    cleanup

 t/helper/test-delta.c    | 9 +++++----
 t/helper/test-truncate.c | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.34.1

