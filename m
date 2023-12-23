Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7BD15E81
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDLLolhU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d53297996so1489115e9.2
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351711; x=1703956511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSzRHp5BbQ8RHnANLkfpKqCzWCpWXu9TeHXFY5OAtwo=;
        b=JDLLolhU7tIeC33qQ+/p6S6zGR5GhTCWWijPM5PvRCPBEAB65wQ7zrCQDQCGJkwHHQ
         E51CoEJiTZ23DMFrtkaYaTZ4NRzL+lVTuFiLxJ/z3Vkp6svURy2tnPgInx3aD07NFi2q
         k0gvkyWh1rfv3cV1JRdFU6ltxozkfKm95SrDiB0fSEvtw2ZYCIfhD74Ytt19oQbP5rSY
         A3aUFAhrMfhQfuAWkiida/G0Yc2rZvcFghMb70eOaDxjCu0Ohj9zFktSIG+TpeF8dds5
         5/LXX0qkqTzhCmYQhq4XmpIvH8I5uDy3KZAGjJj7lG65em1S01mJ2uVvXoSgNH02e23O
         mIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351711; x=1703956511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSzRHp5BbQ8RHnANLkfpKqCzWCpWXu9TeHXFY5OAtwo=;
        b=qy9w+wDsaoZTns31OartTatRvhXqXtjGAyGKhNVvBj6bI8k2KTQmx8hE3ym86y3LVb
         ORWRUqTND26i8+kaLGjHPPjeszNzM1u4mwQPEquBot3Rnjbl35d+pEqdjsTyeG7aiZyd
         dPnD0rcA/dNJ2ng0tcA0azU0ew/+KhH8sjRL8m4hZxUS2qg1dt6wEYMai1DbXhIysaYv
         tZCovTGbgZOAK2LsemPCOYqggfG634FRSh4H9BG9HmvjKlrlYoYHz4Wd+HAgvbVoNBwI
         ryit7NNbf/5Pt3M3JMIiE+rsrIfyIeI50ndIEaq2Yr0BYLnA7E0mLk4hO/rKK/HAISZM
         +9gw==
X-Gm-Message-State: AOJu0Yy5kDGBvwMH/ePXXbjWRFfnfd53p/FBoVaUFZ+xO13WxHZR13lL
	9LL87gRlyRs68wgu9k2SA3RLIroGpLc=
X-Google-Smtp-Source: AGHT+IEKJ1s6a7kGn1e0sI755nO8kUa2ny8ZUDKVaErZoq2lisOrO0vNXWCJ/+D1SWzOJCaQuGiYaA==
X-Received: by 2002:a05:600c:430c:b0:40d:4199:5a90 with SMTP id p12-20020a05600c430c00b0040d41995a90mr1650420wme.133.1703351711258;
        Sat, 23 Dec 2023 09:15:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c191400b0040b349c91acsm3305210wmq.16.2023.12.23.09.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:11 -0800 (PST)
Message-ID: <ab91f88a560a700351e4bb2b7b14f023e62ec3db.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:56 +0000
Subject: [PATCH v2 08/12] pkt-line.h: remove unnecessary include
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The unnecessary include in the header transitively pulled in some
other headers actually needed by source files, though.  Have those
source files explicitly include the headers they need.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 pkt-line.c               | 1 +
 pkt-line.h               | 1 -
 t/helper/test-pkt-line.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index af83a19f4df..236dd3a3ee1 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -4,6 +4,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "run-command.h"
+#include "sideband.h"
 #include "trace.h"
 #include "write-or-die.h"
 
diff --git a/pkt-line.h b/pkt-line.h
index 954eec87197..aedef56286f 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -2,7 +2,6 @@
 #define PKTLINE_H
 
 #include "strbuf.h"
-#include "sideband.h"
 
 /*
  * Write a packetized stream, where each line is preceded by
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index f4d134a1452..77e99c37df0 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "test-tool.h"
 #include "pkt-line.h"
+#include "sideband.h"
 #include "write-or-die.h"
 
 static void pack_line(const char *line)
-- 
gitgitgadget

