Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400A4779F
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726441297; cv=none; b=uJGlK+xdylckKg79rz4yw9D6a+po1VId+vIKTxrYCiYn7053PM54iYh+bolxdIMj2WvJ69ZASfgmojqdRG0OwTu+eQolK1aMZDPJXl82pCd2CqKKS1RgHwers2NNfddkfQl7qqmcRNHhzsAIDZ3Jd+bIyvq+UHld6J1aeIvYD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726441297; c=relaxed/simple;
	bh=vluW+hyLtsD8KiP0CPz+yy6Uu3MKs7vWh0sPWbbRNGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cYcllGAhO09nDTZpA1xwzqBiBkxvCbDRxcKusgR2SHcxQFDlPaa6D0pHV6PmjYo+EufuHLcM5P7SKEEXKNNaky5lVxAYo82XM/sCJPsiKLKgWEFFWXCfwtL1W4RKgNZjX45faNUKAFeLJWvXcYUV2jVCyY+JILkssKMryyAzW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5gT+jgX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5gT+jgX"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c180d123so1453065f8f.3
        for <git@vger.kernel.org>; Sun, 15 Sep 2024 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726441293; x=1727046093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PiZY0+Z127EA6bCPcZd9PJA5Ho7/5LfL5s9CgeMvEiQ=;
        b=C5gT+jgX7JGDNjIMU0MSdn9Fg02evy7HJcFOGkkV6f+KEGQCpo+l+tGrDr5T0HSIrf
         lr+rhadJOUmphFOWk5wnbKEXPwM4N7Qt2qH+HtCI+d2kwg0B9Oj3/si/j28/YCU7GSpy
         cKXHMs4WtBxyItH8MHfeeUUYL8bogWcnkkVIG0CK7q5UkYD079/6EIF95Iyd3tMO1eyq
         AcqSZf1ffVDST1Giuba3wKP7Y0FmXNLWbEfcv2yKmcFG89qXMESzOrR0P4Qn/tJWRrGX
         MLPXnxv6cawsKjdDil2NFUkFED7NHH0U+fhFbifq1OF5tTVSY9RVIgkMoIB4reEfzIGZ
         YWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726441293; x=1727046093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiZY0+Z127EA6bCPcZd9PJA5Ho7/5LfL5s9CgeMvEiQ=;
        b=bxnsIC1GYXHgsC7qaDLXj+noKyAoImyTh9S+U/7Se6UAZjkSRTiM891ig1CLh2AEoX
         aCRDCT3b1CyVfxmMRav8Ar+2F2uU3XkdzrXkr+zjeTSqf/4x75SvWFQaRy53UDYf+3XY
         dLUN+CQCLcIcK3ZwgeSSPUmdOSTSvLLQYmW7FTDfDTDN1E6ZUY/GjZPhLTznKfhLv5E8
         buDTg5HsvHRq6n4//NXZo0gM5RfsJ93MuqxK6yVGoNY4q7ccEluTqHyJ0c83I32CWbFA
         +iateZqn777bIhp89hfNZybT6Q1+QilpG2Yz1qzyAiIkyIsZW8pSxRN01Kg5ONV3UMRm
         9cSg==
X-Gm-Message-State: AOJu0YwH0uoZLn5DXIZdWY3ReQXPItuMBM01bP26JAJkwG5s+0Ms4cEf
	3n0RTlyWUxHoBJxQsdSQWS+cFei16vcZ7kan1keCl+0Nz/3jlPwES+mNqnfR
X-Google-Smtp-Source: AGHT+IErZptLw7EaXORW86s3S6hx9UxMdvuMhizm3MgdIT2O+rubXBrlckHZ/+p027Gla+A4RRgwHA==
X-Received: by 2002:a5d:5c88:0:b0:378:e8b4:1900 with SMTP id ffacd0b85a97d-378e8b41a8dmr2277333f8f.41.1726441292651;
        Sun, 15 Sep 2024 16:01:32 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da2427227sm58872265e9.44.2024.09.15.16.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 16:01:32 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] attr: fix a typo
Date: Mon, 16 Sep 2024 02:01:25 +0300
Message-Id: <20240915230125.128941-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 06b5b5e55e..c605d2c170 100644
--- a/attr.c
+++ b/attr.c
@@ -187,7 +187,7 @@ static void all_attrs_init(struct attr_hashmap *map, struct attr_check *check)
 }
 
 /*
- * Atribute name cannot begin with "builtin_" which
+ * Attribute name cannot begin with "builtin_" which
  * is a reserved namespace for built in attributes values.
  */
 static int attr_name_reserved(const char *name)
-- 
2.39.5

