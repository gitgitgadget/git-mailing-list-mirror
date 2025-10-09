Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835072110
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053844; cv=none; b=moSU9mgB5GO5gFqo9m0+lkRS9z9kikYviUIspfZEtDG/Ywb8mPrc4YuZFhSsUfsT/uwErJianmuO1wSSMqrKLaTkmKsZRTQMJ0aRNGCYyOOXLFPRCLishcbGRB5GBuspyuj1Jji3ZA2w7H5CQN/slL6WIgKMQvBG55u3+795WPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053844; c=relaxed/simple;
	bh=Uc8nIsCrP7Zvq8T5P117L+TcEdakIsp4zCPHPJ8nYEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eACrqfpLZIxgNtGa+QPc9kWfrph+RWXIRNiGc0W+XLueqe3G5gHTN05ga7ER/F1cX65lr9UaXIwFenlS4F2Z4lIk3YRYK3n6X4p6HiiZy+GmsvA022e+XB1g2ZRhAPhwVYmMYYzXb81tKAVCBjinmF9hlr35PKTnrxarPRiqU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6p/EFn3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6p/EFn3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so13701645e9.0
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760053840; x=1760658640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6y1GaBB5AKcpsYpGzTfVFdY88+ajBFvJF6b3+5NA+hs=;
        b=R6p/EFn385VMi5KyQPeACM2RG/pwrUlIHMt1gDFO59fVCV/ofheRecWyuOR0ob5Tid
         G9qW9XX4oDGpq3hOPy1P0LUPWxqJ79hhoW8tohBd9r7gV4RvSzfSCuS7ZQQHd5rOFnEJ
         LEri5uZ0NTYWNTVJhqL5a14/rpbXmletep4izi20TXKACrM/COH0VS3g8cE3tP6Z3Zur
         Wt2FO9PsHkJfxpjTY7DU1paztG3oSFwVcM5fp0R/sMDHKAIXdDzLINkuAMSYgi+DqJvQ
         10iDykRO/08zEKEnV1CjPI59mX7TtuXEBLdHZgz4lju5Qj1xnUHAJLQJZiBWsILLNDAg
         TOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760053840; x=1760658640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6y1GaBB5AKcpsYpGzTfVFdY88+ajBFvJF6b3+5NA+hs=;
        b=YBg6xeB89siz3PNionufHxsQdEoxLKSAdBoki/eCfdTEN5JIZTvR29JI471u4YP6oB
         KeRA40LbQNWfqGvqKgUBKNf5XdV632C/4wjw/HF3d9lIP2e2XgNvHHKDf1TN1lSxmQRn
         JcMd+EccZCtKLBF4moMwLoRIcMJXGNilIEqBOOu+5B4/L9spVjrxbMwrQkqoyUwJvDBn
         BY3Iwfqw0arzXRCjP7WbTxPWNRIVj6rjugElOAQg1DyTbpcVDUvpDbWTTZO0RsDEAn4W
         nehPtAD15uJCBFo/S5kHXGk9GUPeG9DdOMe+6rwUJ6NvNbFhqqkmnchEMiFiNEaNwLtt
         OR5Q==
X-Gm-Message-State: AOJu0YygQs4l88iYGuhSCo57qqJr/GtiODdsPox9hpuzUYVB/ooczd7E
	HEqmpYwQfVAa4yw/NnQRLmnVtEy1tHg1uGXTq8gQio+zBhjSquzjRx9FgynMrSJcEm4jqg==
X-Gm-Gg: ASbGnctbSMb7298zkGQv+o4tz0Vud0T5C4b/rpC2Wf+D69Jki6m+WiSxGOubiswUwRZ
	qZmA+lGhXqQpfpjRpD5J4BTHIgDOB9f84DgpHp7WYMZ0m1HCUJYDRUUtfZkrm3MXk7etdpN0IOo
	TTqgK11OM65jEpkd/7xv0O76XYy+fTRBJiAOJVgg/T/PLeMI30blrom6jzPwB6lIXKrUTnJWUCB
	sGlXTcZs4RGEZgPz4zq8DzNMu29UTOmMlvUMYeYzcbxLFTYChfBX2DTSgyzX6o8BE8yGwdijiiv
	Ces/bN0Ge0V+zs4XYozCZCqdks0degp6HRZie45xeRBkUfjZVPo7ZVozNLTfNBlOgF91hG48zBd
	6Zf5Ch/Q+HtO4cPGftmp1zG73LYzfVVXPGBCLKPUNQ4HjYqiyFVgLt/bVULfBf5XkbPw4c3h7x1
	hO9ZBQVvjDW1ega2tqYNTpmitMPak=
X-Google-Smtp-Source: AGHT+IGwK7TJVfUYtsHDK1Jj2kQ9+661j7NjyYt27sGa94Fsc9t/htmnI17iUbJAdaDb5KwAoUUdzg==
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46fa9b171f2mr63733215e9.36.1760053840362;
        Thu, 09 Oct 2025 16:50:40 -0700 (PDT)
Received: from localhost.localdomain ([105.113.99.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb497aea6sm18038245e9.4.2025.10.09.16.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 16:50:40 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [PATCH] [Outreachy] patch-ids: fix NEEDSWORK timezone parsing in fast-import.c
Date: Fri, 10 Oct 2025 00:49:57 +0100
Message-ID: <20251009234957.1789543-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 builtin/fast-import.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 606c6aea82..695e1a0ae1 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1959,14 +1959,15 @@ static int validate_raw_date(const char *src, struct strbuf *result, int strict)
 		return -1;
 
 	num = strtoul(src + 1, &endp, 10);
-	/*
-	 * NEEDSWORK: check for brokenness other than num > 1400, such as
-	 *            (num % 100) >= 60, or ((num % 100) % 15) != 0 ?
-	 */
-	if (errno || endp == src + 1 || *endp || /* did not parse */
-	    (strict && (1400 < num))             /* parsed a broken timezone */
-	   )
+	
+
+        unsigned int hours = num / 100;
+        unsigned int minutes = num % 100;
+
+	if (errno || endp == src + 1 || *endp || 
+	    (strict && (num > 1400 || minutes >=60 || minutes % 15 != 0))){
 		return -1;
+	}
 
 	strbuf_addstr(result, orig_src);
 	return 0;
-- 
2.43.0

