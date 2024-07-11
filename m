Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459B15748C
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686653; cv=none; b=oCQIravfP6J64hV/Txut3AqRWdnoqO8BmZZeqZc5Kin1CSrr01YejQa8xfI8O6pszYT47fOZ0lV2OYElnq4a7iwedEJa1GpqhTVqEWnoDWxPHSPEqCXBFgLaGd+Wgi+X/ytG3pinjwReO2wQHQpzxHnajBUvTOCaq63ebP50GBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686653; c=relaxed/simple;
	bh=d0q9Hxhdhih/ajxSMaLCUPyuyuLRA2BTAnO2lFVa1tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2eWuE4ni6iE+3fCg1ZlD3hFJ8413o2ADgLXXM+n3zy5xExe3+SWt+pmzZm0yVfUWnFzzoQQ+8LNV/BHMkBIApWnzi2TueA9BNhOonLKEipTXy800A157kkbKBjeQxKYb0On8R+gf6Ipnw9jnfGkL+XdANSy40HLrT+488YrsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFuvEjRC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFuvEjRC"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so7754211fa.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686650; x=1721291450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0t/ESDNXetP4dVwGA6sk7uZ9qVhzzo6pAPar0bUuRKE=;
        b=CFuvEjRCYK3KYQBtcMnmHXi5qilOD6OA+ypxNvBk8A75r4QgVD070xFo0KFHLHzVrz
         c8F4Bo25fjEtlXW+fOIYU9mJqO2i+WAwN3Mhn9W7DFKVT64frJB/qp6dj3MxDMmTQt9F
         KuSZE7tevAQ2B/ThKKHS/zL2Xh7SOO9r7cL6bvbl9AxTdZ5nASxKIGcwNzcJJYyG+i1O
         Z8IVakSQlc77hkDS69u6Pm2CHlw5rrwz2O+j3+p0d0oEhuPWZeQuVXhS9veH8TVglEo0
         y/rh+vO2MIU+k2dq+2zbmI9qELgGBcduNdAjuB+Py2uuabkLyIhxaQsx56avXoPE+zuR
         b7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686650; x=1721291450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0t/ESDNXetP4dVwGA6sk7uZ9qVhzzo6pAPar0bUuRKE=;
        b=Kl50ju3R1tU8KN/2gJCpCLQRnZfxgCGXKAnV0KnBXrol8pKvcnAHRg1emL4eXlVk/y
         ewggUGH7qC4GVdW+cKM64A8q29xxDkpV88lHXyxBvYx2xQu5iBLMtwe74prx+2Lsq8UF
         ul0qhDDQfo3dMXxnQN8kbiuSZggeR+6CVn3xJFH/NBDuap0gmCbFcGvWTLhOXRqa6+kH
         r1oOLhDY+ITHSTEgtlxYe0XCR3jHjmxrmaREQ+IdvF44EDC9MCOg6FUdZpZ846qUyvWY
         Uqe+vWPfeyWy1zmba8L5qepcKhUhUsjwb7Vd8Tv/Ccq0XNBv8BJd4D6kOcKCjQ/IGImi
         qmaA==
X-Forwarded-Encrypted: i=1; AJvYcCUJpa97IV6Gh8RceAmswL9C/6vXuAJO8pIrDYlhtLH+u0zQrkbQS3P0Jod8FXt9x93J9U3M7bHVYQMbzrVBDy6e7+hH
X-Gm-Message-State: AOJu0Yzj8XXMU38p1isU7yO5dgvG+tr4kfBlznVeIjoP2DcxwCfsLZeP
	xS4so26XBu5RLiX6eFB+MAcW8hvvo2FmaRRMZhJCW7iPz5NZdYRc
X-Google-Smtp-Source: AGHT+IHGfp70fidAIQ0mAWrbmp94Ru1S7Z2ksNUk4sANKoKVf9WB39/qfipEeIY5vlQlLpfLps2x6g==
X-Received: by 2002:a05:6512:3e0a:b0:52c:e1cd:39be with SMTP id 2adb3069b0e04-52eb9990eb3mr6270432e87.8.1720686649727;
        Thu, 11 Jul 2024 01:30:49 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8da7:30a3:c67a:daf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm263674305e9.16.2024.07.11.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:30:49 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com
Subject: [PATCH v2 3/8] clang-format: ensure files end with newlines
Date: Thu, 11 Jul 2024 10:30:38 +0200
Message-ID: <20240711083043.1732288-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711083043.1732288-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240711083043.1732288-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All our source files end with a newline, let's formalize in
'.clang-format'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.clang-format b/.clang-format
index 803b274dd5..4c9751a9db 100644
--- a/.clang-format
+++ b/.clang-format
@@ -106,6 +106,9 @@ IndentCaseLabels: false
 # #endif
 IndentPPDirectives: AfterHash
 
+# Insert a newline at end of file if missing
+InsertNewlineAtEOF: true
+
 # Don't indent a function definition or declaration if it is wrapped after the
 # type
 IndentWrappedFunctionNames: false
-- 
2.45.1

