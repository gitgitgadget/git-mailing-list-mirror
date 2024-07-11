Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE574416
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686651; cv=none; b=tpx3qoUEK9ywUpPIwaijWbHIxIQO++dAKHCuws7/Lh3Rksba2uz+62aC1ZCxyX5HkKMWgtSBNamNebhuNpI+vDIdhnm5i9UOZTDjYYLDDFZ3geajzSIiwye6hB+cMlIVgbG5V1o1CD2saGjC88ENHokfbzsnlctpOqs6tH2Y8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686651; c=relaxed/simple;
	bh=Gqs0VQwsfgRA2lK8SCn/i68gVXoNG+1qWEpW07/D61k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTmOBCDfeKQm+LeJB9eCcG25lvyDstvfqPPa2r/MwrEtQGWIzD9QHooQPUCfBFrtd9FyEDvv+6+5mtfyHIRPnFnZLu6jeBICbB52L3dlen52kLKxrxfmLn8ok3i1c+ic3uJzL3lJcfAHhNVLQPy3a/OQTyl7xwRMeHBQwvxpCTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9c/QJi6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9c/QJi6"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so4548835e9.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686648; x=1721291448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGcMb6BAXpBImfiOAFXGemoJ0A4QULj+Nih/JoSKkps=;
        b=W9c/QJi6wlccehNrj2f/4xL5sc4jn+6upVph/QL/u/IYrvmMs2sZsiwwlkjmN8mnYX
         k3XlxsjQgIdsG33nz/nShNPWmXvuuApXBI65XYo/jktCp9MmjQFkRirTG06aWIgk8g8y
         9W+Q7v58IbpzaZX/FlJglQVdKtYidCHqy+fBT5Sm9L2ugHEHgnGVSVlkRtqZYs6mPEeg
         fZGUzDgIXO+njn0my45+YlJXt2dYi8ZqyKL6fqugJByZ8IohUowtsuoLxvIHvH1xv/j1
         9YWTC862UbcpExKPFdr/T8W72jYFXglZkg7etPaOZ8Q1obmIq0klbqACdz+N71eQ9x6i
         9VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686648; x=1721291448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGcMb6BAXpBImfiOAFXGemoJ0A4QULj+Nih/JoSKkps=;
        b=T43AeFFWQmJ9rQZWFXoNKkdhddOgTCyDpMq0r/uIIEJpT504Nc8ukuBkh0Ej9uaI6G
         9w2dV/jmh761224asu4SA/84559BDmMhFXBG1idaIjUi6eNZsdcRbZbTOSZ8Q4qWvGLu
         ZUew/u7AaKDu/DW6tfguHGSn0ohhqEtGbDSYmc6RrWvtqeAZsCxegS4Z2mOnFnVSdUiN
         +U85hlVbmrV+2CdnPrIfct0o7ccnxA9aiVuLeoOpEDFD12UyVQgP32oxJX45t4Vnn4h/
         a4p6SqMEE5qqsbhsM9+CU84R/6nX72w0r1KfWFfanJXwdAQPofKuODKRBRFQ+MDc3khn
         UQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlaGuzFXWIN8q+P9sFK41a+yKSyRQ6fYnFNRHG7nZpzQbJiav67cIsrAGyo2Y2fP5LvsYlJd/KLiaMz9Ekgx9XK5Lc
X-Gm-Message-State: AOJu0YyTgkgmQCzQ7LP3aeVDsJ0I9fNx/Vzfva0YruyYpWRvrxKbNcsu
	Vl63qTXjep+h/VDUitfbUvwRrOmUKm3Hwk2vqw8Igsp/qFctEqUEEe4DyRKu
X-Google-Smtp-Source: AGHT+IFcLiJENFQ/t/zps34IehlC72Hd8PGY8YqGnTYI9zxpGdw+mufbDO5WjbLaigfJKrKdLSg3AQ==
X-Received: by 2002:a05:600c:2d84:b0:426:5e8e:aa48 with SMTP id 5b1f17b1804b1-426707db6d5mr68396525e9.22.1720686647827;
        Thu, 11 Jul 2024 01:30:47 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8da7:30a3:c67a:daf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm263674305e9.16.2024.07.11.01.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:30:47 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com
Subject: [PATCH v2 1/8] clang-format: indent preprocessor directives after hash
Date: Thu, 11 Jul 2024 10:30:36 +0200
Message-ID: <20240711083043.1732288-2-karthik.188@gmail.com>
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

We do not have a rule around the indentation of preprocessor directives.
This was also discussed on the list [1], noting how there is often
inconsistency in the styling. While there was discussion, there was no
conclusion around what is the preferred style here. One style being
indenting after the hash:

    #if FOO
    #  if BAR
    #    include <foo>
    #  endif
    #endif

The other being before the hash:

    #if FOO
      #if BAR
        #include <foo>
      #endif
    #endif

Let's pick the former and add 'IndentPPDirectives: AfterHash' value to
our '.clang-format'. There is no clear reason to pick one over the
other, but it would definitely be nicer to be consistent.

[1]: https://lore.kernel.org/r/xmqqwmmm1bw6.fsf@gitster.g

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.clang-format b/.clang-format
index 3ed4fac753..5e128519bf 100644
--- a/.clang-format
+++ b/.clang-format
@@ -96,6 +96,12 @@ BreakStringLiterals: false
 # Switch statement body is always indented one level more than case labels.
 IndentCaseLabels: false
 
+# Indents directives before the hash.
+# #if FOO
+# #  include <foo>
+# #endif
+IndentPPDirectives: AfterHash
+
 # Don't indent a function definition or declaration if it is wrapped after the
 # type
 IndentWrappedFunctionNames: false
-- 
2.45.1

