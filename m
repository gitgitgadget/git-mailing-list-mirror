Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F191A2C25
	for <git@vger.kernel.org>; Sun, 25 May 2025 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748206994; cv=none; b=GuiWDrKmN8jfbLRt59xBhACTV3Ecz7CdcyEa5PW1KycJs9FHdsbnb5jnJyqI6VT9+5ecXmEoi4C40kz9N25eChTkx96Hvj5vNCXgNSzWXdEXizUFbzJp4BfdHfR24vlpR3P9IOtRiyu8vonPOvTDNlDUoYBmfpIJi6u8N1iFJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748206994; c=relaxed/simple;
	bh=oWKvy9w7gFLFxI+WkkLL6h7t6kpxKGqxofTWvsL+OVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDnuPuChksvGwYLnMIOkTUV1DqVB8dCRVt2iTXVCB6upaZKsYXsnIHxMLfty4QLWc1hC2O/jD22GzebwKNI8sgTmvscjniXP9lhrQhAckvPC1JtdUviWv2I0Shfh6hCBGR2KZMaW/1MtmcsXFdqzhwiYEbeiOVud9ilrNXQ+5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWTdMqPb; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWTdMqPb"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6faa543d8bcso7478146d6.3
        for <git@vger.kernel.org>; Sun, 25 May 2025 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748206991; x=1748811791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVcE6KZoDyRlS/kRW/SFLDz5CoqLaekPebD4P8xkcsg=;
        b=iWTdMqPbsL3VruWOfw0yKr5w4MpixBBazBw8gPIHIQBm6K89tr29H2mnjo0QHpk0gV
         +ppjLy9k2JqAVwbqrVA7IyTgYinTDiCgdIFFZlvcbh8h7Jnl6bmmohobaV7rFOez/rrA
         x4gtrKa6S8pZm3F/LDjxQwDC4MAeoISdYhnVJg8F1xPDHOjjx8WVVkicyQNX6jbWspVH
         6/tv8cV1Aw9kx/RvQfyG2b/xdFIakMXlphEG88VwuZJeMOhDfqyM60s5PkLPzl2WniYq
         nKz6gj8f5exjiuZx9RIXL43vyP1M4f6VQAuj1BDbndq6CNqqP3V8jywgEwbDUC5hXSyH
         s2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748206991; x=1748811791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVcE6KZoDyRlS/kRW/SFLDz5CoqLaekPebD4P8xkcsg=;
        b=mwJ7JKScdlIfyqd/pbBL6Yr43QDW4f6JuqwuFGSYIkw0JAULeDWP1OH0V8tI5HaXzX
         cA2pczarWjBNw2VZL65ir1hZqrTzpquGHoQO/aXMjTbAy0MlQ3rMBB31mlyhOaFmrv4F
         ehefruQOGJN/JeT6xKJhnZUhGSiJwdZy7kxyfHE1I99sjjfrOQ4jRjlv9tzO17VAim8U
         uKRfn24g/1gMXSoBj/vpw1EDuMGaBfTY/xXfOrtzAxPmOwIhbY8vFb8PgdaDsppe2K3B
         jxSy9j7Su+fUt97l/u2s/8cpiohtKnkWgWyHOf7sDq0ovKJyDc/0aahemzmgdHIrn5H9
         9bew==
X-Gm-Message-State: AOJu0YyJ9KJ136/jB6DgFeOfKbJfmK+LW+9Q3aJELFBpsMNy++uX3uQI
	xC0gWNFSdp1VU7zAFTruIN4wMX+ZeSGbAOLyiiCSAivDMzBEjZVKzzaR2ZGr3g==
X-Gm-Gg: ASbGncsl/xhQhBwfGcLq5ZCDzU8LtZM/tWnzHrEDfK11wiATLypeDlTt+u3DznxCQI8
	MBDDSNupZWEbHTvUUjDLmoYhherSyVR5S0wFSoE8aKlOrqioTbox9qHz3oKCngYV6cDpuhB5xAQ
	x9q0RtYkfK6bGsX/N+yN4lWJPG/jfnJ6rKFf1JoehGRkSaZPDbTCo9iLJ31RkKoR73znc/sIILN
	/TMJVmszCza/Mi6H1j1IOicQbcy02BE/b9dJ6dgplfk6JbrZIAbrywwtnnouv4zsTMZZa6jPDdC
	bGxoYDABADr4DO9eVKU0FJmzIIjwGnHAFL5zcx5H94UOZapWw2n4YOLOFKd8LQ==
X-Google-Smtp-Source: AGHT+IE2nqksskcHCHbzWnOoa0TYIpMv+ihiVCuB45yKl7/Wesggo1H5Zx2V7QVUfghg2CILfJR5Sg==
X-Received: by 2002:ad4:410b:0:b0:6fa:9d79:eb70 with SMTP id 6a1803df08f44-6fa9d79ebb9mr88983346d6.34.1748206990917;
        Sun, 25 May 2025 14:03:10 -0700 (PDT)
Received: from rodrigo-pc.. ([179.99.7.58])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52f45695f31sm188808e0c.43.2025.05.25.14.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 14:03:10 -0700 (PDT)
From: Rodrigo Carvalho <rodrigorsdc@gmail.com>
To: git@vger.kernel.org
Cc: Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH 2/2] t4018: add two userdiff tests for R language
Date: Sun, 25 May 2025 18:02:36 -0300
Message-ID: <20250525210236.116342-2-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525210236.116342-1-rodrigorsdc@gmail.com>
References: <20250525210236.116342-1-rodrigorsdc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds two userdiff tests for R programming language
files. These files define a simple function, with and without
indentation.

Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
---
 t/t4018/r-indent   | 6 ++++++
 t/t4018/r-noindent | 6 ++++++
 2 files changed, 12 insertions(+)
 create mode 100644 t/t4018/r-indent
 create mode 100644 t/t4018/r-noindent

diff --git a/t/t4018/r-indent b/t/t4018/r-indent
new file mode 100644
index 0000000000..9df440f2a4
--- /dev/null
+++ b/t/t4018/r-indent
@@ -0,0 +1,6 @@
+RIGHT <- function(a, b) {
+    c = mean(a, b)
+    d = c + 2
+    ChangeMe()
+    return (d)
+}
diff --git a/t/t4018/r-noindent b/t/t4018/r-noindent
new file mode 100644
index 0000000000..6d9b01ffe3
--- /dev/null
+++ b/t/t4018/r-noindent
@@ -0,0 +1,6 @@
+RIGHT <- function(a, b) {
+c = mean(a, b)
+d = c + 2
+ChangeMe()
+return (c)
+}
-- 
2.43.0

