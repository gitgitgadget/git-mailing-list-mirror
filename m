Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EF31814C
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140264; cv=none; b=AntOtrmwDERJJzllg5YrptpxoKfao4/51nQkSl1apNXFSTJP9K+h19ZBvwZkAFcUIkqoZcz1M1UdkkTnSzHjajMCmhEIAWvWIr+X1ojMup7mSijkRSxoq7qmZ2FHakvrbiWCDtrik++kxuMNUdoDije6tFf6W5gIbrMloP5lwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140264; c=relaxed/simple;
	bh=NOAyyuYWp/U6WJqHyxIoKL3Nmi4FsCWu9uocQmOdfkI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QcpmXtY4dBo9qZu2fHZuMFSsWP5LVlrI5zJlOI/MrZAV1qEILJyeO9CWhDPv2TSbncmTJUBy6QEQtZlaR4z0yUfJ+kmgWcMpTAmNvKokIDgtjut0uZuhAMEJlI+OyB1Wjx6UQAUAxKT6NVMrPV6/X8s5nSizDzUtA2sohLMobRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYPjD7df; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYPjD7df"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f39438187so485995b3a.2
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 06:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768140263; x=1768745063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrj9DW+pJervh9LD7nOxUhnedbzmDlXlRuE7/rQ8eas=;
        b=LYPjD7dfGPliJQz1i/dO7Ij3tDWdE0h6SywN9NJEsFzcwoUuDBJP+wp2IzQ1epklXN
         Gk5hQqDn9ifMlnxA1B0p3fgJ+HLQ9JVy4wVQOP9nO1FlYqe/a+t7h7CBJVD0BgxRhyW1
         K9j5i1h879Wbl1W2qg2myGuW+vV4gBuYhrSCm32VuBVJYkfqXzRHc/nv9+0fvPXZy6j/
         okP1c7RBi9KmPOPAOvQl5fKlAT8KoGMY/7l5AOWIo3pfhTkJgujkAUNnFHglzIfOShEF
         JtsdLriclvkQkkKDr62BaQ5zjinHq9vaDAQT3GtR3xl/89IXHBc7sPC22LdcGpRbLhDk
         /2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140263; x=1768745063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrj9DW+pJervh9LD7nOxUhnedbzmDlXlRuE7/rQ8eas=;
        b=WbnS6KImMWP2aH/rM5k0m27mqr0irEeyiU6ki3CK1jVnbY3eUOgRY3kmCnkaqX6M1m
         MUTBnNJOvzKLBMkanhu170unOdaC9N/wxs6/sV8CGfFiibm6okAcSfGILt985Cl7Q3Tm
         cJP5KvannoUMScZ3WdEM4FVtO6xjbbnCwXCGsKyMvoB9KCJARoGyf1cyHtABvWUDDrUf
         puQl+5qWYSWxaSunFRJZFb1/AyJXS35VH+4vGbkYRhodeYx9yqLkGlNqi1ai/LOMGYP8
         30mrsM6I2CJJlWxAdda143NswxL17suYwYGYKRKJ6AFhL9AzlEFu3aSGZqJaV45yzK6w
         5zdQ==
X-Gm-Message-State: AOJu0YzmSSt0a72KNtVAUKZcxsr0INLjsHl6VSq0Llm9XEfqqFCQjbm2
	2S8xd1GGHAwoWHZZ1Hxa9APvhRboSc0YU5VUa3LFvAPrQr6Ko8J3/27uhp+5fQ==
X-Gm-Gg: AY/fxX7DM+5+owPpBEUVgs5rDj5uiiP8gJx9qhEYa1X4IhgErAWHP3mEm+DOJg3AE7f
	VVYTbOpwwTen/IFLbkw3ckONUzlE3k/DeBT4SeGM7FpQAE0M3sEjAMvM1oiZHqX3Z8TxeOY1Jfe
	ifcs9swdSWHjmhPR/UNTwLKdAQ5TgpNyZHEK2Cj8GbNRcHOkRVb2dXG2tLa+vCQ/1sWUKuwOZOI
	m9UMtO5yqU/eiFX42hjwpyzJetr+eNJbI0kwDS+uTNhSpXhJsjrn0ZkAmIkU2uK1lA60IAXvGsz
	p92kUqKPd6DwdNH/Z7S4BKHfX+Blj7iVOw7zg4kXtiwLWUm4n5qxCGNcdQru12Sw1r1u2N7PUs2
	YB1ozuV0ETHZmxJ/DoRf1IhGwEJe/8GCdxqKzpw/NiBoUapOC5AiC0s1N5jXmdMiPJ/OJfpvdOe
	fSld1Xl+/NnuZacXq81PvRFp59edYTh1X87bU0G+x/uNc=
X-Google-Smtp-Source: AGHT+IH4qeOtEO+aR3h+qLMcXRKU38h9Zr7g1ONs6MCrsahjlbEiq7g2/CMRb9BIqoUhGKH4AuIuqA==
X-Received: by 2002:a05:6a00:2998:b0:81e:4ec2:da9a with SMTP id d2e1a72fcca58-81e4ec2dcf9mr6266120b3a.49.1768140262590;
        Sun, 11 Jan 2026 06:04:22 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f4433488esm3388260b3a.2.2026.01.11.06.04.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 06:04:21 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] t1410: check files and missing paths after reflog rewind
Date: Sun, 11 Jan 2026 14:03:27 +0000
Message-ID: <20260111140417.36274-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace raw `test -f` and `! test -f` checks in the rewind test with
`test_path_is_file` and `test_path_is_missing`. This provides clearer
failure diagnostics and keeps the test consistent with the rest of
the test suite.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 t/t1410-reflog.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index e30f87a358..ce71f9a30a 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -130,10 +130,10 @@ test_expect_success 'pass through -- to sub-command' '
 
 test_expect_success rewind '
 	test_tick && git reset --hard HEAD~2 &&
-	test -f C &&
-	test -f A/B/E &&
-	! test -f F &&
-	! test -f A/G &&
+	test_path_is_file C &&
+	test_path_is_file A/B/E &&
+	test_path_is_missing F &&
+	test_path_is_missing A/G &&
 
 	check_have A B C D E F G H I J K L &&
 
-- 
2.43.0

