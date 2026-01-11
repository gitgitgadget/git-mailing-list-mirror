Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625234C820
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768158933; cv=none; b=N61x6b38XUwRoHdoFfeBb2kj3NcCz7MsRhWjUeQg+wJ5EZRnD1Sy1os57AHQORpUCwAWfP2f4wAxJiir+AXAqg8bEjmw8VZlPgOpCK6uskhKPQG9tCHpW70RqjDJsj8+DNeSlLjZw8HBBJN2zhPP55P4VDLTSVq5mE04UR7TS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768158933; c=relaxed/simple;
	bh=NOAyyuYWp/U6WJqHyxIoKL3Nmi4FsCWu9uocQmOdfkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJML0a41z7syT/wa2THqQdtJc2kDUgSFTDO30TnmiaKnhS6Fy7YXGBjOKg0rE+DX7ED3TO28nkbiYOHKalkxp21YQh97i68EeSWT+ugivMuqestCgjwNNi4LECtrsKFfZErnhECr816ENyAgn7XhW4LKn6jhBxkG8dE2WYoBCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2Tq7grj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Tq7grj"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0a33d0585so36215815ad.1
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768158932; x=1768763732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrj9DW+pJervh9LD7nOxUhnedbzmDlXlRuE7/rQ8eas=;
        b=k2Tq7grj86dikoACaDoA1SER9p8hhPLMM1kiSC1Qc58ggyIkK255NtULUEDxaC/D4b
         FtVK0lzXDIqpJZj3rn3V/DeXM/p4fOG59aipUN15RfJAPMzicEQ/oYezT4Caj9Cv8rTk
         T1U78dw06yxDGIJFubgp+MKcoLB+x7wfrIAfKZoJfbzs+rwqZ45I08B1JUuWCsyAbZR6
         NnCwyIId6UGxZQx5HeEcsLKIC96seGGhPF4XBPaNza5A0BJ0LLeibQfB6G2P07JPfHY1
         SEvZxCdhipUv7XDGKLPf6g4CvwhXtoWAeEMA1XAE3g8+nHwZZnOj6TzMe7oCAKGu50YV
         Alqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768158932; x=1768763732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qrj9DW+pJervh9LD7nOxUhnedbzmDlXlRuE7/rQ8eas=;
        b=opzcyS1a93AZt7shShz8NCf9CQ2uEIiAI+J/Urr3QQN40zHBcRsU577+spUcPTxEC1
         7q/i0of/rYn5IenkQ8t0r54Ixexe1/veIRT+XpBy3bLohwlf3xklfBdtXlIB+MIsEB13
         4YwHHZ2pK6La8ZMZU4XfYx8pAHP5vHPvLcW550o5ryqaApbdpmxGQyAaX23PD5y11f1H
         4w5Yd6aVgBi2qWYTE1sh0tmywSmpcvzfS629Xt5rL9Meyy31H4gGu1SFwd3sHXeSNskn
         SV/e90iL0YXVmN29k3vC2mu5UI0Fn3PYLcYoJu6+TbfkQzEn1tPxGu53n2bio+SKJhm8
         M+ow==
X-Gm-Message-State: AOJu0Yyufk1ufI7uZUxC1blSmSNRHq7Qonv/J9zDIGxhv7ht2xszVF8O
	892VBdrnhHigFHDyc9yjo44IE8U3Of5edurpaaaITOV0IZV3wAvh4Brlbv6H3A==
X-Gm-Gg: AY/fxX7oeFEf+cqZpula75M8mVki+oT4RKhgBNZjCcVeA/CYB9tC+nkYbuZ1iL8OnLP
	o1owZB9ANuLquHHPux/qa5oNzOodib0l8MQwD5wmidGeC6tq0G8iE4o8ZCaI3bEMgfi5INlbeUy
	KVh59D9q3IQQFpMWuZdufMW3GhFd7ctsl4s/fLE9VjnvIytl0udzpF0q5UBMQK3jPMvi5bNW6j6
	O0G+QiQSlhZ5oNIqqSmgxHuq5KHTiVDhlNZmSNAi/OZV7Q9CZUiyNbANqAm7JXyUCrluIguPH9L
	R/vAsMSUPJ4OWx/M+OTLvv7220xpn037KtkLwhC6nUZ+PxYGD+koDB7f9W5onVjx4d8iRlg/3w2
	BzO1PaYjwI4jygQOgIlkCUS/luYcbxiJbyiICRTciDdHCCHi+H/nkjGcvWtAeH9frUxNgTA+eYv
	aiGHyhIqOOd9JUzKTjn/Vm3B6d1UvLPN2R
X-Google-Smtp-Source: AGHT+IGsPui5s2TuYk1bQFyf+ucvsuL//gfxawSD5/riLFgkNY6155uzKeOl3qZ2DQFz6XTFOin4zA==
X-Received: by 2002:a17:903:41c9:b0:2a0:a33f:304c with SMTP id d9443c01a7336-2a3ee4c0025mr167195365ad.57.1768158931607;
        Sun, 11 Jan 2026 11:15:31 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2f8asm155940285ad.57.2026.01.11.11.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 11:15:31 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v2] t1410: use test helpers in reflog rewind test
Date: Sun, 11 Jan 2026 19:07:52 +0000
Message-ID: <20260111191525.17087-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqh5ssouub.fsf@gitster.g>
References: <xmqqh5ssouub.fsf@gitster.g>
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

