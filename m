Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952341A9F83
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645040; cv=none; b=GaMAQ9dg4ZLPloV3n8Vm0IP8vlF0VvYshtttIppXZvWjrwJSP+lYxNk7OroQ3wx14u7cZuRnLFlssQX9N3Na/Gqht0h7WvlehbiOLnEIaVcoBMmNoJIP/UXPhNBLpxt95k6tnF4hb6fvdQ0J2WsWIWhl6Ic4OswlD1sBoGfWsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645040; c=relaxed/simple;
	bh=gjHdjHCq3k2UJscGqmicj6nbbRaeCVuIPGpXjsfZqcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nN95huz7PV7N86Fy1lQP+lNk/+3nrZ8nlADo9GQmgnPWZYCIZuAxe3FWw8A0/mywtfSAFjLAvkqlDQi81RfywT/P2c2yuMpkS5o7vM6bEBkPwpXSn2SY7MmZBp7AOuZK1vHVnJgfPFShVDyY/4yVTqKysZRpXq0/0OovOQTsl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhI9HA+N; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhI9HA+N"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso1618670a12.0
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760645036; x=1761249836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJ27zUJ8iWpVm7Y9c4K03FqAqU4swYsP7uz7GX/BFSE=;
        b=BhI9HA+Nk8eWA+wtOyDt5kM8WwbrYtNL3j0JJC8aJNG/3Hxf2A03gp7tlih+xE4DKt
         SBfN1oNlvfH9NrO5efYoriCNZdafU3jtiA/6uIisnTLOUzlTNRm0UHEzvZ1GkVjfRs7P
         usMcLmXhYpckwrLldfzNLFstL/U3ugF4wWs01kMfrUXL4/uyd/zE9bk8UTV1ylIMHvFo
         orz3jA/c5K/wOEM1Pj0s87CGrbJvqDtYEQlKvIAFEcQ3Z6Zc+8vlbXEfXZ2tBS4+voOI
         tHGR1ci24W9dYuN8kEJcYXOWNfOVvuGuABbq2PACglqJvtzDdMgCihROPPuKa54TT328
         1g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645036; x=1761249836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJ27zUJ8iWpVm7Y9c4K03FqAqU4swYsP7uz7GX/BFSE=;
        b=KGI2wuw/mRNuXcQrIrhvb6huF2n9z/m06+fZJduwvSYRP3d16lVw3RrjuS+uTEuTkf
         JjLYAHyd/22dfUMWA+bcP9Ama9raf3QMjRJZ2bRJ3FKyoeq4SyGXyud3ahILGy0MB3lI
         UY+BM+TJkPHn0Qmkxoz+U9kx6THaRSfftNXHpVa+vUBdDqI4zQ73TaPAh7O7e+93KE58
         KQl/HizFqYcrXiNzgD7dP8iYdA44Z5AemmJpr3mi/Ay07oli7ODBQGulTzYrlMd9u0YC
         CT6xxz8twyHkgl3vxKKnpMPIzO78v7owDuMwOWstydVAv81S47DWWkeu3m/TwW08TCQt
         brlg==
X-Gm-Message-State: AOJu0YxEA+r+sUhUsKOfi5dIKZgRkuRIKtQzTUGqNQ+RlJmg7mhL0K+F
	+09rO0PJYzePSauWjzuYkGCkbibBnMNdBQZdwyTfPkFrfhjsvf7g3NOh3ff+yzMJeJeRJA==
X-Gm-Gg: ASbGncsXhKUG1/rk42eSNhz3xtOB5OfM2/s0h8k9XAS/zk6ltTcwPEhnGkMISM83czs
	ZEIZg69cJVfZyr3fUC2YfBdFMJg4+JFkTEpYSd1FF+fLiDgxz/ruK8jJSMU8Vp0Eu/xHwm5uEfN
	0xaViYEaU18szjCd3179SV8u2+CDyq0I9vmheGjYayPOeceZUKQ3pZw7kEIifEaF4SWF5vDHy4R
	nJumOFdzYC6G/FT4sY1J0waSfsVGNRtPc1ubmW3/4INLdgewV/SugIHFekYllZcf6Rb4Ovieq8/
	f2WDTgwiD7Uy88081IFzpQA+ZgoBoCCKPSKQmM3YGTy8eIPWqIF0D0C9Q9R4MsewcW+Pqj/nMXy
	/2JsXCwituskrwfsJ5mAVHJiyEOYZwqDFFIwE3MVNrJt7+rZjCk2KMsiXhbPi+za4Zm5jm7Iy65
	R94ntqUJnpnNzzlyJvGwAa82BCFHPUzRPSN0WcZ9kQtbZvBAswFeYfbsfNeLQP6JhDFBM=
X-Google-Smtp-Source: AGHT+IFUtR1TvYHLt9L72AHeysH9hwwukApJOfkK8sau5kiiywTK3lSDBYv2UOvgh7Z06VUW/l59YQ==
X-Received: by 2002:a17:907:d1e:b0:b3e:8252:cd53 with SMTP id a640c23a62f3a-b64725705e5mr141587766b.27.1760645036296;
        Thu, 16 Oct 2025 13:03:56 -0700 (PDT)
Received: from localhost.localdomain ([105.113.98.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c1d344aa2sm1101737a12.5.2025.10.16.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:03:55 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [PATCH] [PATCH v2] gpg-interface.c: trim CR only before LF
Date: Thu, 16 Oct 2025 21:03:44 +0100
Message-ID: <20251016200344.43239-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem:
The function remove_cr_after() stripped CRs blindly. The comment suggested
NEEDSWORK: trim only CRs before LF. This caused potential confusion.

Solution:
Rename remove_cr_after() to trim_cr_before_lf() and update the comment:
"Trim CR characters only when they appear before LF (\r\n) line endings."
This keeps lone CRs intact and documents intent clearly.

Also improved formatting.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 gpg-interface.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index c961607444..2d114e05e8 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -964,23 +964,37 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	return use_format->sign_buffer(buffer, signature, signing_key);
 }
 
-/*
- * Trim CR characters only when they appear before LF (\r\n) line endings.
- * This avoids removing legitimate lone CRs from teh content.
- */
+/* Convert CRLF to LF, in case we are on Windows */
 static void trim_cr_before_lf(struct strbuf *buffer, size_t offset)
 {
 	size_t i, j;
 
+	for (i = j = offset; i < buffer->len; i++) {
+		/* Skip CR only if it comes right before LF */
+		if (buffer->buf[i] == '\r' && i + 1 < buffer->len &&
+		    buffer->buf[i + 1] == '\n')
+			continue;
+
+		if (i != j)
+			buffer->buf[j] = buffer->buf[i];
+		j++;
+	}
+	strbuf_setlen(buffer, j);
+}
+
+static void trim_cr_before_lf(struct strbuf *buffer, size_t offset)
+{
+        size_t i, j;
+
 	for (i = j = offset; i < buffer->len; i++) {
 	     /* skip CR only if it comes right before LF */
-		if (buffer->buf[i] == '\r' && i + 1 < buffer->len && buffer->buf[i+1] == '\n')
-		    continue;
+	     if (buffer->buf[i] == '\r' && i + 1 < buffer->len &&
+		 buffer->buf[i+1] == '\n')
+		     continue;
  
-			if (i != j)
-				buffer->buf[j] = buffer->buf[i];
-			j++;
-		
+             if (i != j)
+		     buffer->buf[j] = buffer->buf[i];
+	     j++;
 	}
 	strbuf_setlen(buffer, j);
 }
-- 
2.43.0

