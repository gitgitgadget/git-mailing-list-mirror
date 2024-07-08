Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0D558BA
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430614; cv=none; b=eqhnAXad/dBnTLn7JDbEKpHNQjFcHK0sR2qTMFkvydHXLCaWm9VaPAV4UdKTHjxMgiQ6uOyXBBdjiaH5YvxArBcXOPgpWHhQKgDwC4hpORj/j36LbeflLge8LPtunsP/vmAVT/34/4KZs6NnPNoBGuizg7hHW6cvNwbYVs10EaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430614; c=relaxed/simple;
	bh=d0q9Hxhdhih/ajxSMaLCUPyuyuLRA2BTAnO2lFVa1tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npjWOK3549T8adu2Su4wdjM31rLIVWOCjThvUlGIeaRzNaRtINEjbAF835w4HrcFVkVghZlDXSV2o2qJsXwyL9BvZxiJebsByCFJvCInohdJuD+gSEQYbh+yCnHWAMFsmYEqXw2THvQLgYDU/DAOE/80+q7AYKDvV1//R1WkP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDjZ2Q9M; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDjZ2Q9M"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea33671ffso3271049e87.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 02:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430611; x=1721035411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0t/ESDNXetP4dVwGA6sk7uZ9qVhzzo6pAPar0bUuRKE=;
        b=UDjZ2Q9Mt8PG0AnmWOQZh54axSe3cGKuuqnEsy15kSCNmTTygykn141xq0N88TZ+jH
         nQ8t7S0iviFgVVDOtU/lOWokolZV6qz7Ek+3mouGGm5t8VNuowz9CnP0Sj0RRZTmSa95
         ODmirXuZjGTcyR3KKyir/cYOqoLnp+fVjCb/kRSXlafRibRdQIPgM7U4ZxVtSEhOmL5t
         k0CS9zz6ilqXrYZQguE02TgaO6mvrjopxCx9yDW8V6BPknM+8fThakr4pQwx1J+xddgq
         XF9LGgy8E4Oe7MItc721v71fNss1i7QGnd5fX9Vw0CTKKipF8sHLDWLVDBymdsovjDRU
         vUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430611; x=1721035411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0t/ESDNXetP4dVwGA6sk7uZ9qVhzzo6pAPar0bUuRKE=;
        b=Xu52L9k3uMcsGP11q1FIy5UkAV/5Ki3t0SGCsJqpOhLaHo7iJ73OlYtnBxlQ9FEv05
         jgEs5vja+Bl1Ya08hebgTmHsMU1UehdmQ/M5ynr2g45s6ucjQuPTKIJRx2d4OObzU/4L
         GSyXS06nKBUj7ruZGVVC9gAtxFzUDqYlgL5xcDEFPhUH4ATswaEC/TY9bAIBdIyFcqKL
         rtM8hi6oqDhWc/RBFFa4TxNOUCiKD8z5IGacplOQ7XB9OBgRZ96/UgmxjQ8Z7Hu17gjX
         ZbTd8ZWZSaQbTCW40Yy/1RJ+pFtUeCnTV51Srs+64Vij1765/uqo00pIBTcTdKTggfk/
         iqTQ==
X-Gm-Message-State: AOJu0YymV/y8n5H1P0pTTL0rpCfUwarsUwmpj+j00OzKKnnzgt/xwPHV
	7YfLKlxrIdz8bAf3hk108QGAhxLc30qLk3Gp9pnu2h9+abM1bLP3
X-Google-Smtp-Source: AGHT+IHFFTOBBDa0WBEObuLvlmyaS4dTWzGbwOY5aPovv2lzfFVxJROy5T5xJBFzgNgzKTP4xP/oJw==
X-Received: by 2002:a05:6512:3282:b0:52c:e07d:229c with SMTP id 2adb3069b0e04-52ea064c57emr7653694e87.22.1720430611196;
        Mon, 08 Jul 2024 02:23:31 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1d0d:3d35:3ae6:ef05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm158259935e9.10.2024.07.08.02.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:23:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 3/8] clang-format: ensure files end with newlines
Date: Mon,  8 Jul 2024 11:23:11 +0200
Message-ID: <20240708092317.267915-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240708092317.267915-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
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

