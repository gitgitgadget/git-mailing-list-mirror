Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4312E71
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkP1msyx"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso30621055e9.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351708; x=1703956508; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKpv5ZFzjn3B1VgPJnotlQlSa+AAZOHqDH7ko024YjQ=;
        b=AkP1msyxsS/+3gWt4ri5Stq1LANw/5SHKg847TrAala3W+zwTSg446Z/HfhiztAoCQ
         L783q7sWdndS82TiEq8n7Vgbg1ASd6E9ndlyOdCiAPVZYNFh7b6tETniiJkMuDpDPYW6
         DsUYuVaTTq0ba6zwG859JgErPUyMBtEM1AWZWBrg6/m4tZ6gJ4lbsR5TrsrDvj60NzQ/
         pqKniQLEjsmpqMgKxN1FizhB6SNShkvo6ngCuBrtD3SQUyU1IIwtWKScaD4RfFKinadQ
         7Rn/ivR8+OxSgm8S4buHRFaTUaEVC0qbBNXVOsVVUtXiPkWeF5vVVeToEwAkCi+lbm+L
         jx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351708; x=1703956508;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKpv5ZFzjn3B1VgPJnotlQlSa+AAZOHqDH7ko024YjQ=;
        b=wsVSY88yQn9r66YGIm9tOyzcoJ58fayfaPHZbeyNuG++jqwR6kczgfXS4VH8Brt66s
         udA17plK0/YXV7dO4GXITgVBPpDf85ss/l2f+Ou9WiaS3j3Wbjs3mNrBMjIqwegGvLsZ
         ZRas5OPSrIwufl0ylw0GaVqZTfdy0QpkNg5Eg7f6O6M+kklKX4qF1f/BQrcaprfYEsie
         iMyaONCZsrY84qMdjH7l9ykXahhF7UwlF25sUwQ30nw00VWuhqENvs8XKKMwYRjA45C/
         veWEMoajzyrdGWwctwbMy9RgUjedKBr5ksoYu29N/s1sYzEehqXq3A/84xE0FVmhUwq+
         XmUg==
X-Gm-Message-State: AOJu0YzjOC5MEfBrfPUVe2xqGvq+aPGfcryDg1IjyoLoiofHfXVCbUN3
	x8s23VUaEEZx/8LjyoFu1bMV28NEOoc=
X-Google-Smtp-Source: AGHT+IHTYLNWztnuNubxwdDg2RPsBCYh6TsXoGBSAq3P8xdHcPbbmWB946XzRB2x8TxAJ7FPPwAeVw==
X-Received: by 2002:a05:600c:33aa:b0:40d:4205:60e5 with SMTP id o42-20020a05600c33aa00b0040d420560e5mr1799302wmp.127.1703351708340;
        Sat, 23 Dec 2023 09:15:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bl13-20020adfe24d000000b003365fcc1846sm6861429wrb.52.2023.12.23.09.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:07 -0800 (PST)
Message-ID: <e5ba799753d8d165788d0eaf5689be466f5f0db1.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:52 +0000
Subject: [PATCH v2 04/12] blame.h: remove unnecessary includes
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
 blame.c | 2 ++
 blame.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/blame.c b/blame.c
index 141756975bf..1a16d4eb6a5 100644
--- a/blame.c
+++ b/blame.c
@@ -3,6 +3,7 @@
 #include "object-store-ll.h"
 #include "cache-tree.h"
 #include "mergesort.h"
+#include "commit.h"
 #include "convert.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -10,6 +11,7 @@
 #include "hex.h"
 #include "path.h"
 #include "read-cache.h"
+#include "revision.h"
 #include "setup.h"
 #include "tag.h"
 #include "trace2.h"
diff --git a/blame.h b/blame.h
index 31ddc85f19e..5b4e47d44c6 100644
--- a/blame.h
+++ b/blame.h
@@ -1,12 +1,9 @@
 #ifndef BLAME_H
 #define BLAME_H
 
-#include "commit.h"
 #include "oidset.h"
 #include "xdiff-interface.h"
-#include "revision.h"
 #include "prio-queue.h"
-#include "diff.h"
 
 #define PICKAXE_BLAME_MOVE		01
 #define PICKAXE_BLAME_COPY		02
-- 
gitgitgadget

