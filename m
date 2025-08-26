Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973231A54D
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224283; cv=none; b=fxQbSArUka5Vg/lsLI7vtRRb0rDuIt62hMmLstdUmOPRuYcnTLb+VmQrQGAj+BiUjBMlJz2XtKTKyf7eCMvIirAkJTblaCsPZSNYYv3ZsSNgpBLtah7k2KnrZa6Z9rbpvC6cX+/kn/qcBXumgQ5KGZAkPoKwuAGLCOukTXMK1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224283; c=relaxed/simple;
	bh=a7BfXJeJW59qESzuU7ivifc6pL6z4c4QRkylbL7x04Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGd2aEyB9RxlQGIJhhJmrh4yIZj7fc9dmpIhFFOG8h+u8p2wLnkd/mWtzZ0h+rr4MUJVk2xA5J1k82Tf+A2bL+qv5TRmEEEHn4j/H1v9ztU46ITq0W2jaxyBRhdcfBKVBQbJcMp456yOr1ZsyW79iUMGfcFokHz9FrVWbunBrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V48HjEKn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V48HjEKn"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso2459113b3a.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 09:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756224281; x=1756829081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7hTZXI4nagfG3cyxyNCtAtCt3rN3Zm/GQalUTBGK+0=;
        b=V48HjEKn29yYQK2HlA7hfMHvTdfy4uK+Swo8OZIzEq5wp2eQFv2HwlyDfqVHl5du02
         sKJ6SFErm5yPklw2Dnx5tlrk+WwPvu3qLxGCvALucING8WlZfL10PfgUTwev6EeApyPr
         r7bFEm9/IwxoTeE/8+WH+jXLZCj8ur2Ol34gE4dxjktD5L/abn9ns7S6QqzMl1ARFfBy
         W6Zllznv/pauVqo+Sz8BVxgy4MTE/gtl8Pz3uF6Ff4mMwgpMeNMYReAoaIN9isn3aIzO
         hHGLmtOEPcNFTcCZ27Aw6zpB3hF0v+k1rM43CMyg+mdrAoqrxLJXHnrgh8p4Qj2U0XzQ
         i30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224281; x=1756829081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7hTZXI4nagfG3cyxyNCtAtCt3rN3Zm/GQalUTBGK+0=;
        b=xIjT40iyQKtZwfGOEuTT7BvahrmiTZ1ckC1wWSRKxb9+oYhXp16drMYhmZzBUqiibC
         +clLzd0JzwIn3u3vyVFutRahYOVUkausfjubBd3DM3zGrld5fzkXmbuVT6TAO6DURPUc
         4fRGSBd+6XqZHoHjym83bmxtVeAMByAkZ+nIko8EQO72NmclH/O0+3Jocj8q6PsHFuae
         eyvxhN9o9FopRCN1Lyq8Lg5PC55EJbrEc+9nLzS2c4m+x8W5d/Wdbu4T1nP230FtUOhY
         VEQ1F8dzozH02Z6JTA3heGcbAmVOk6Ip1M9FF/7I6cu2kLMIm8y0soOLEuxLaQActJ6b
         QISg==
X-Gm-Message-State: AOJu0YxcbdJkSWk4drDy2fcrGb71E4SArlXoTjteoVoqb37sa44363Aq
	rLR6Bm9WHuYsPYYuj2Einlsdfy1yxBaNb8tWI+jbzi05TNrKPALrq6SI
X-Gm-Gg: ASbGncubaw0OqilmCYdnBQVK4TcqQlO6Sd9nvvyn3JB4/rbfnZ/3LEMLPKGC48ol3CF
	UPkCOxFF/tLE8fkMhUgjjsy0NpdNi8XtFZ2f1DuIGxH++5riyAjMmMeyzAzpv/S96mcQ+T1Ay3I
	G3scMUh2JnVsKAYotN/efy/FhKX8U6v+2Hk6FS0bp5C5rPI/q+b7TU4PzrQwe6jERmklBvwxZIx
	8N7Jh2lIxzfCJLxxIRWKjzRZUptV6pgv5hOMadWY+MKHoFx6lXccds2747P3tFb96oZn38PjoUq
	uayyvAlwHv/MBcD+n9/wYCUZ0+T9BZvQZLfLIq7AbyEaZwZ1QdskLbiyMQ2XYv8tVbVzG+OMUla
	opVD4xe1ks1MY7ckO
X-Google-Smtp-Source: AGHT+IE/UArbq2DjbpFJb4H+3SY3gmRAdW5HhV7woKgsfiIpeidSWWTKh5QkcSQ5OIpmNRGAgKhovQ==
X-Received: by 2002:a05:6a00:10d1:b0:76e:7aee:35f2 with SMTP id d2e1a72fcca58-7702fc15031mr17895665b3a.30.1756224281018;
        Tue, 26 Aug 2025 09:04:41 -0700 (PDT)
Received: from tinycat ([172.56.186.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771eaa6792dsm5075303b3a.48.2025.08.26.09.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:04:40 -0700 (PDT)
From: David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Calvin Wan <calvinwan@google.com>,
	Kyle Lippincott <spectral@google.com>
Subject: [PATCH] Makefile: build libgit-rs and libgit-sys serially
Date: Tue, 26 Aug 2025 09:04:37 -0700
Message-ID: <20250826160437.2539113-1-davvid@gmail.com>
X-Mailer: git-send-email 2.50.0.7.gec2f25360c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "cargo build" invocations in contrib/ cannot be run in parallel.

"make -JN" with INCLUDE_LIBGIT_RS enabled causes cargo lock warnings
and can trigger ld errors during the build.

The build errors are caused by two inner "make" invocations getting
triggered concurrently: once inside of libgit-sys and another inside of
libgit-rs.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 29a53520fd..286d3ba3b2 100644
--- a/Makefile
+++ b/Makefile
@@ -3989,7 +3989,7 @@ libgit-sys libgit-rs:
 		cargo build \
 	)
 ifdef INCLUDE_LIBGIT_RS
-all:: libgit-sys libgit-rs
+all:: libgit-sys .WAIT libgit-rs
 endif
 
 LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
-- 
2.50.0.7.gec2f25360c

