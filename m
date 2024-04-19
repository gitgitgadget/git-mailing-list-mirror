Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3E8F62
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504160; cv=none; b=AZzJB4andIZ1A5FY/RZTZAsZ9G3AfMb0O+4xMclfDXB0X0BeFAWQGhcOcQ2fK3zTgNpnm63GKBy26nexnymo1vE//W56PI7uHxuVXP321yWaSLFcKk9+c1c/oPY+JDce80BkyrYnFStmFtOS0uVK+9po/R7aPF4JtRmtBFmGXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504160; c=relaxed/simple;
	bh=MLOxizPMH13V/nmWD73mPqJzfltd5DqNenMqtilm0m4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hB1vHaxwB0Jy/MvLxx1OVCZoxKw0JJPsLC2T2rrWSj/k3CpPD2IPk83Z0+In8LHVmJFP56xIF0prNO/kQ98xg7nAzIcYhophp6VBjAO1HcJ1m11/MPfBw0hB+f/PKuWpuTndBJu5xIiFMNmW+kHwYLSaMXb3E5AQ4+oQw03wEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5eQLQ3a; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5eQLQ3a"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d895138d0eso13641721fa.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713504156; x=1714108956; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LodBV6FiAEjtGgTccQmp9l61Rlj/gUAFYBcrwkt2Ubk=;
        b=O5eQLQ3a/PJV+7g0kdALZsp0kICLfCVC5z2NeMsDf2Giwn29BLoaASEFpvcRHinzab
         JugM0zWg6YQ+bVV97jQxR/KJsBS0B9NWB5XA4+H+8B0cxkLbZXjaziYp450UViIdiQj8
         dbEbYTIc093SoxmTUIjYHsTE6ipOaBjslooXW5sFqatLe50uK176+xsfjo31ncEreJrt
         CCpo/yRcvAkdE4wvJleL2svGCFRQFr/oIaFfJPfpP4r60YXNnHMlgOSNklNUPeQZM7ak
         Gb58eNuxaJ/bIYzCOQ0ZziQAf2wCZprdoTIRe+zJ0NQesAVr2WPOQIqLM2S0OditUfUL
         A9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713504156; x=1714108956;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LodBV6FiAEjtGgTccQmp9l61Rlj/gUAFYBcrwkt2Ubk=;
        b=FsJQkxEtLyILzZp7jCSKf3DxlQz850I0cdEkeWrdga/nWOPMKAeHnx8OEjcpqKvZSX
         NiRYFhTNp2+nR1bcVU2NeGNcomS7YMhFBgxM9UyYm3DjihLf0sdfO6EJ1v3xnQQt14M6
         7olYKGxQk2J1J3csYmaYG116+6igmrinrHjABdSFnGSLmSP5ptFHjInsgjO+AeZjGby4
         SEfwbQ0ZCCuzlGMCml5v1cVSHdF0lFhdgs6pglz56HTUgTQquLNa8cdNUSKsPlr9EEZk
         S/FPtJi2rHQL70p7bXov3JUOTvW9Bp3NqVlYKxamWxhsuOXispj1j6YFMv2U+tYxh5tD
         t4Gg==
X-Gm-Message-State: AOJu0YwEJZTvDyDZq3cwAd1YtUJfFVAsoi9AIkN4f2U7LzjhiSWJIPbw
	8hGqnCo0bs8ZejWMKNgYuyTHQ4z0ZqIx0ahbex9yqKiIhiIiMcmM/L4m/Q==
X-Google-Smtp-Source: AGHT+IFXVOf7RPy8Mou3E0WJBMAnIFMkLAgWl3zj7PLGiMv03D2arw97wKsfFo/8hbsT2kGPuiY+ow==
X-Received: by 2002:a2e:330b:0:b0:2dc:9b50:eabb with SMTP id d11-20020a2e330b000000b002dc9b50eabbmr488117ljc.4.1713504156070;
        Thu, 18 Apr 2024 22:22:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7d65a000000b005701d5535b4sm1662658edr.51.2024.04.18.22.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 22:22:35 -0700 (PDT)
Message-Id: <b6a1304f8aefdfebe2eefc0e07460d6d8dbb004d.1713504153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Apr 2024 05:22:26 +0000
Subject: [PATCH v2 1/8] Makefile: sort UNIT_TEST_PROGRAMS
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

