Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CC18CC0B
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802437; cv=none; b=MlofSdbPbnTpVH0QyyL8FuSf3SbrppZAcNI+JXcn0Uk/qBCcyhl6Io+LhoB+C9aiRlnmLJkpsqnkn2MwWrRFEhUipj1Z2LnTYkhJ+RdC2LOWQnVe81EV9BjB6LxRWFebownBOssMbR0dyr6nGVSzkH2++GStQFtTuPXNVPp2K3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802437; c=relaxed/simple;
	bh=RCGQrVJ+2B8d6qPpZ84M2MHpwzcI3QENkvKAdCdN/LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fszz70MT10x0PMMj981emoxMIVIIKRU+Pt665eHpp2HDaKx+zCL3E9sTC4cXaDVqBFUCFOrV6k0RJBAfucIVsVgjH1zBznA+VMC5v7C9/iBzgx3LaOr7HQoKUnuW7pDTLPzbov4HjhrES7ptLYgvFIoVM3fRovrm0ii19VK13hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaXry1Qw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaXry1Qw"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-719ba0654f9so4902761b3a.3
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 10:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802435; x=1728407235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx8ZIBBTGGeQmLCtSXNPNGQr1EF8HUD86lMPJufPADo=;
        b=RaXry1QwNttnLZBAKUH2MLdmHV6Fg3/wexC4I5DrUJKiAnv/jPRt5hT3whPV5wzyix
         8ETszyg8jA8cb8LoXRtYBQnT1WgyosPxI8GVNQzUaSydqnBWO7Gwr1dan+5hIj0KGGdw
         ETz0WLXrfgaM1oa4b7R49CRBQHqo63oUUDvcLwO/1pzAIyrLgr4HhUUHAyGp/2/o1Eva
         09VNIym4n9uxIEKNhirrQmfGRFQ0YiT7Ayi7eUsplv2bucf1x3MqQURqxEBfKAxKkaZ8
         WxYxwIKUUcwRZ6f+gLvXFPp6+8iOyQJYfEG0FuKMmaUy5IS8Mv3cq4o/TsXTyE/Yc7i1
         eWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802435; x=1728407235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jx8ZIBBTGGeQmLCtSXNPNGQr1EF8HUD86lMPJufPADo=;
        b=TcAEqjMohVLoLnrMBu+lOCM+pySFfqY7jIr9Zr8BewHe4YTwKAFH5stZi3OJxGSd6E
         vyuaC2SCzRK+dDZ22IBrqcu+nSs0YjNHmA9I+Xo9r8QS1/RFvUJC3NhDKhaTGZmbcZzu
         MBAEbvuGkK7JWGt3CMQLIyJzjkTttIKqWSid4OFPjS7Xh/VTImdOTcPerP8wI3dHYkTe
         Pj2WTkWA0MnzqwRWwSEBF4oaSKQnoGk3Z9OtELkdI6IFxee6YCliZb8X074/wY6J4Gbw
         JgA/VtAzZvVvNx30px7NST0gJei6vNcVKiWzWxkAGMSomRnaQU6e2fVNVXAczxU1qqhO
         GdFg==
X-Gm-Message-State: AOJu0Ywq/D3rghLQRVajio5xptupYuN51vwnthD5likVZ1ifSLZAym1Y
	aXA8w5h1q7C3xkwnGIxbWzbsqrQ++fhssrfVezBgwIbUGxje7oZOjT3UvgZ6
X-Google-Smtp-Source: AGHT+IEXxq74NC2JlktUIzXdEIlJ5pXmXZHslZGTvZeqnJgQLRmWl9q8nyNk8sp1AEsXOugcXdikPw==
X-Received: by 2002:a05:6a00:1496:b0:714:1bce:913a with SMTP id d2e1a72fcca58-71dc5d5312fmr520597b3a.21.1727802434893;
        Tue, 01 Oct 2024 10:07:14 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.207])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b26536651sm8265421b3a.190.2024.10.01.10.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 10:07:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH] unit-tests: use xstrfmt() instead of a char buffer in t-reftable-stack
Date: Tue,  1 Oct 2024 22:35:55 +0530
Message-ID: <20241001170629.7768-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A char buffer is used to hold refname values as formatted strings
in the reftable_stack_add() test in t/unit-tests/t-reftable-stack.c.
This can be replaced with a single call to xstrfmt() making the test
conciser.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 31d563d992..2d7cfbf8aa 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -523,14 +523,12 @@ static void t_reftable_stack_add(void)
 	check(!err);
 
 	for (i = 0; i < N; i++) {
-		char buf[256];
-		snprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
-		refs[i].refname = xstrdup(buf);
+		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		refs[i].update_index = i + 1;
 		refs[i].value_type = REFTABLE_REF_VAL1;
 		t_reftable_set_hash(refs[i].value.val1, i, GIT_SHA1_FORMAT_ID);
 
-		logs[i].refname = xstrdup(buf);
+		logs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		logs[i].update_index = N + i + 1;
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
 		logs[i].value.update.email = xstrdup("identity@invalid");
-- 
2.45.GIT

