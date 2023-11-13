Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16778C8DE
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wjp489Dg"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE29A10CC
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso34463755e9.2
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871058; x=1700475858; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l4XmiTb69qn2BgH9BwECj63T+IbdY5zDETcIIYErL8=;
        b=Wjp489Dgr1zSD66q3snYCGxY9l5ZcgOpwoTdCH1NDPhqcIsVUr7OPDaC0ozNouXVah
         UHtYqjxmVSHPMHINWD2MRBVnHTY4rteqCalCaqJ6tVUf9O6yoj1N4BVgsshpOU06FUBj
         lzg3P1+BGvc/DeoZbzpS1XZNFK0CvrfmR5YzEG1sM8/eVlCDol44v9y8YdLMqstYvLzK
         faaXSnQx5qsRbcbEjBiwnB/VXjNRvYo3+3Ib/xKoRtlKWR1c7y9aSboSepyDrLepq6TZ
         5Con0XAwJh2wp4DGKhWGcEZRP092yDyFEaU45gdScoKj/0n5Y25OJYewHAU2eRnSe8cF
         rgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871058; x=1700475858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l4XmiTb69qn2BgH9BwECj63T+IbdY5zDETcIIYErL8=;
        b=AQS4WBSSHBwbSXOgQ5Qe0Fjlvv0W8cG2eAvC54Thx3lt8QZzWGcZH88pEggi0n/Oba
         vsgIZ8vbbErRbKlsQbY9rRLh6z/8u4fr9Qwp/lDmOhLZhRXomeo5KYnvtxsemx+b2xJH
         V7Vmr6bs8Dd5wnGVrBKhZWefWy4M1QDXAjjSGEc4HYGwProGZrMbcHV9fCPjz2yaZ+u1
         wxpQszRxEJUFoxTpSabHRbdEjAwWeD9+rkih1uhfeqzvUNkLPx8FWevx8n9cCUtEOfL4
         7Th+pkRmm2UcuJQCaMCNSxA8k3UhOg/66Bwp4AorpMEKZKYJ4K0BLCXGJXP8QD3rEKKZ
         oLlA==
X-Gm-Message-State: AOJu0YxUnf2/LApInREltj8dj7aYh11cS90Mt6nDtKx/D1gzf1ATnWFk
	VWi03Z2xOsVXozzBqs7JqKbEHziRHgg=
X-Google-Smtp-Source: AGHT+IF50INO4lq2F05J0AtR3Y4ho3w6g9gBjxVNkDexDhRMyPMXUT2kpM3ndljgRAA1BoihrkHUBw==
X-Received: by 2002:a05:600c:3548:b0:401:daf2:2737 with SMTP id i8-20020a05600c354800b00401daf22737mr4846716wmq.30.1699871058357;
        Mon, 13 Nov 2023 02:24:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c150c00b004083a105f27sm13154609wmg.26.2023.11.13.02.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:18 -0800 (PST)
Message-ID: <712eb3712f1efb6f98b28bfe1e7d4f4f1aaa0152.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:03 +0000
Subject: [PATCH 01/13] Enabling z/OS workflow for git
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

Our team ported Git to z/OS w/ significant modifcation.
This patch is Initial Config

Signed-off-by: Haritha D <harithamma.d@ibm.com>
---
 config.mak.uname | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3bb03f423a0..6ba9b707006 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -625,6 +625,26 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
 endif
+
+ifeq ($(uname_S),OS/390)
+	PERL_PATH = perl
+	PERL_PATH_FOR_SCRIPTS = /bin/env perl
+	SHELL_PATH = bash
+	SHELL_PATH_FOR_SCRIPTS = /bin/env bash
+	PYTHON_PATH = python
+	NO_SYS_POLL_H = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_REGEX = YesPlease
+	NO_MMAP = YesPlease
+	NO_NSEC = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_GECOS_IN_PWENT = YesPlease
+	HAVE_STRINGS_H = YesPlease
+	NEEDS_MODE_TRANSLATION = YesPlease
+endif
+
 ifeq ($(uname_S),MINGW)
 	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
 		$(error "Building with MSys is no longer supported")
-- 
gitgitgadget

