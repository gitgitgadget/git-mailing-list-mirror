Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F218383
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722226485; cv=none; b=ZMrCElHTsXifry656lVZ/t5VcHBlAr+9fyinalcQdn4+RWX4h7jOnFWb5uWK6+6n4tI27Zfnpq3xpTKkntWk0KlvyXWt11taW+vpln2kYoTumBilqquA7RTfBfA2akYQAYrIlyVsDad5iSPBKMcuTnc5ESBslA5fqjcT4htRPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722226485; c=relaxed/simple;
	bh=WbJVB7R7irnXBNcGh6GZzF6k53wkYbK10BSePG0Nmv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+a95U+59rbwh97TotM0IfiMwftUlPd7zruWi2fb9j4XFZMSpJY3Rw/Nnto1ReScr52iFUjcL5K7tr84gcYFG0OELwx3C1c7JbwZxDW+QJwNlJsEVrHXgZCQ3d7D/Q2976MsLxSoAicai1RriSKGt4yYlu9qi+1FqdGtQArFRqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQRgk36I; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQRgk36I"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc587361b6so14835905ad.2
        for <git@vger.kernel.org>; Sun, 28 Jul 2024 21:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722226483; x=1722831283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u3I2FF9GN5AB5DLYV1RU+w6hhhoyfAWuJX6ER1uNp6w=;
        b=YQRgk36I31LKmuRZ6kibUATHdgCM+UsDwSYbgxPe7geCPMdq3yKV9Ftkcfbfc32JjM
         TFSGPnngvPifKdBbP9at3tOqEM8JVepljF3xMkammX/vQZAcixMRRZNo4zEPBhmbv9bW
         wX1CL2/wck1qRyZZ1awEozcVqGjovbWJ7xepcVuC7kAzqAQYcSON5kOXttQCfQYb61CX
         gmGaIfoT8X9tRF0FrErpqO5Y9zlB7fqOjJN5xBguoJ6TW8iQ+3i+JHOLGVpPRpEKxKT7
         ONr5Ugg5DcuBB2MMiROnSDoCZd9+tt03cuSMXol9y2rZQr2ChyyPluV3Do4ylISQxdCh
         1iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722226483; x=1722831283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3I2FF9GN5AB5DLYV1RU+w6hhhoyfAWuJX6ER1uNp6w=;
        b=BwM35Hq+/gq7+6FzgsIrb7t07ygJWUcYauuqfJnGgTlJ/5r/ZluKj3umcy8+r0SNeI
         9ah9ib8rtyi4tnlpQRiXgT08P6FXHfDczOyqsromWmkFRTs4CPLSWDT7bdocklpBVVQA
         UX8DnVTgp6Q4jYQ+9Yh4FaAwG71Q/Maz5cRbLxK+mO2/T8v8YBheXQPr4PS6Plfhff33
         E5HjjJpflmIhLpG5HorIThqRS7SS62ScP/tFcu0hIaDP80fP8Cuy2HdpzYOZqCj4YDqv
         HdbnTaAkyp61fxcnBkEaofmAuQuTkMvD0rTUdScavPoDR6Aqt4/1vqUJKkeoN3SLciif
         9KJw==
X-Gm-Message-State: AOJu0Yyz5D5bksywuACcpGgn9ev++gRkflhCv4GAgHazswVEv8fUH99P
	PGlM7FAPGvDUFwKHCzxePQ3dwRrP9kvbif5jp1VbPaIX7RRC8AaDnRx0yw==
X-Google-Smtp-Source: AGHT+IElpT4EnYBjayfQmth/tWiYdVe3lMAaSSXwGQiCrYmupQFItpvAO9fGWZjPQ2GOrX0Q2FJknA==
X-Received: by 2002:a17:902:ec8c:b0:1f9:c508:acd5 with SMTP id d9443c01a7336-1ff047e4864mr39768685ad.5.1722226482980;
        Sun, 28 Jul 2024 21:14:42 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:380f:e9c0:c977:eae1:b73e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c80044sm72074895ad.14.2024.07.28.21.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 21:14:42 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] unit-tests/test-lib: fix typo in check_pointer_eq() description
Date: Mon, 29 Jul 2024 09:43:19 +0530
Message-ID: <20240729041435.7618-1-five231003@gmail.com>
X-Mailer: git-send-email 2.46.0.rc2.1.g1fdd4dfe68
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment surrounding chech_pointer_eq() should explain about what
this function does instead of explaining check_int().  Correct this.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 t/unit-tests/test-lib.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
index 2de6d715d5..c59f646fd9 100644
--- a/t/unit-tests/test-lib.h
+++ b/t/unit-tests/test-lib.h
@@ -76,8 +76,9 @@ int test_assert(const char *location, const char *check, int ok);
 int check_bool_loc(const char *loc, const char *check, int ok);
 
 /*
- * Compare two integers. Prints a message with the two values if the
- * comparison fails. NB this is not thread safe.
+ * Compare the equality of two pointers of same type. Prints a message
+ * with the two values if the equality fails. NB this is not thread
+ * safe.
  */
 #define check_pointer_eq(a, b)						\
 	(test__tmp[0].p = (a), test__tmp[1].p = (b),			\
-- 
2.46.0.rc2.1.g1fdd4dfe68

