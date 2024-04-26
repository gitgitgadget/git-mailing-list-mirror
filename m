Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F645365
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091176; cv=none; b=LsReIVCh7rtnaZOVdUjTEDM9xoBPmaBFOGdd5KYHHHa051d00vOSn2Q1JESNYThSfo/G7Fk0pbJqaji9TNMwcjopT9Jg6etmzjyb0VoPhp7qlQXFRQ0zc6cRIaJ/ZVb+OaNREJMjwTGCgSA9uvZ1MtMhl9jJA0UTocV8wdSx4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091176; c=relaxed/simple;
	bh=MLOxizPMH13V/nmWD73mPqJzfltd5DqNenMqtilm0m4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AS8R+/P7YV3iSP0jbqutNsm/J3G2ljxpFhimxERznlKqP/lKiQjJv5GQScmGe0I8eAIITQK26qD888srVtZ7CRA34TpTFeR0YWoEDlXRipZAA2Z2RS7jy1snD/6bDmOTCOeigUTGNYu0fV0PorFmNwsQSvrgSQMIDzovaTD+Ufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODUsYcan; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODUsYcan"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b794510cdso3706165e9.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091173; x=1714695973; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LodBV6FiAEjtGgTccQmp9l61Rlj/gUAFYBcrwkt2Ubk=;
        b=ODUsYcanwc5MxC83+uWHucpOYQ0PaIhZxeBymS8MCrwAV6i/gzODDYhLs+mBntt32p
         kUYuJPtwk5+Tpf9z4cb4pwOBgSb2+KTLgnE49MtrPyL6RbXL+He0uQ23Dqt0PsCS6dcI
         SgaOXBhbGK73qNBqdnYHXtSfu3Nn0fyv9R7kmpApDmbjF0IREmg+77fvB25Dlq418zRH
         jHJHtrau1H3N7bKCwLIE6re0mWCOGChlKCPxshUyDqlB9ur6ydsTgQTEqf3q9Ir1tZm2
         Us7qI++9cpCg0dv3JsRwvZ3hj8gCrPiErGxaPZ209WoFT4uW53ye8SSaieI9PTCJg1Mu
         hGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091173; x=1714695973;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LodBV6FiAEjtGgTccQmp9l61Rlj/gUAFYBcrwkt2Ubk=;
        b=b4BAhEfg/pBHHTcuEEwC7RUCqOgsmYfFfP88WKo4c4ong/aE2p2oqDxuKXkr3WiFbl
         Xb/cWMsV0/cEnij/XDk6xYgTGuvcNVGMy0dwqiMOr5f5UoYxTS75bjArFsYBC5JF42rb
         lbbulp1ZTXz1+KeHoiwU3gOaNwPSUDOa2O2bvQ+v/AbFBDyFXtXvExjSq2M1s+nNDOuc
         zDf4XDbmSaz3/BK01guN9X9yPcKXuNn9DVBezFeFOM7fS66xN7B1rGqJv2LRDGxwkY5f
         3bRbmAN0Ve6FJ4m6/CNNFCoTKPMITznXXyjSDCQlxFgQwPIkiosSVOz47YYiynTasfqM
         nutQ==
X-Gm-Message-State: AOJu0YwQBkl6gXvbhY/AR7NU2GkeiuQnjOokmVXSFagoXr4sFXbYfs5f
	OVWIUqePGS1DP1feIpzwjTHZw76UVhGxbuPdDCDxOHJjeL+5EXuSfCvvMw==
X-Google-Smtp-Source: AGHT+IFIddlU/SSX6js9aWkPYZW/QmXUMwHWHgz4zP65YG6bG8lqno5s2E0J1LmnWzyOLoXxwRM0AA==
X-Received: by 2002:a05:600c:a4f:b0:41b:39a3:cbfa with SMTP id c15-20020a05600c0a4f00b0041b39a3cbfamr855284wmq.12.1714091173014;
        Thu, 25 Apr 2024 17:26:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b0041aa79f27a0sm11967859wmo.38.2024.04.25.17.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:12 -0700 (PDT)
Message-Id: <b6a1304f8aefdfebe2eefc0e07460d6d8dbb004d.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:01 +0000
Subject: [PATCH v3 01/10] Makefile: sort UNIT_TEST_PROGRAMS
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4e255c81f22..d3a3f16f076 100644
--- a/Makefile
+++ b/Makefile
@@ -1343,10 +1343,10 @@ THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-basic
-UNIT_TEST_PROGRAMS += t-mem-pool
-UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-ctype
+UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
+UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
-- 
gitgitgadget

