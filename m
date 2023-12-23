Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5F1401A
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPBbs9iL"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c31f18274so35115245e9.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351709; x=1703956509; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSCkfIpGZxL9WKaqL8EtN8rgM9Yovl63d21O0EWr+bw=;
        b=FPBbs9iL/pNTwPCrbV3yW9nipXuHPsZtxTGd9O956FqtGpVDIdOu0xxPeTPAQ2v5ZG
         SGh2GFF3HV3HcwogXPENqlgAYZ81QBUSmHgPg4+T/yrN4DagfV9r/dFtnFM3IESkO0+h
         V/YZa45w1pSI1eapN5fVeZpptBum/Ut4aDWP2/lKkmFv6Y92Fm5ghE6Jc5yKvdIHh/1J
         AVr0PQur61Xr+kjeJaS7Cqh32udqyIRaz6HB2gSJ7kysjL16huAXX5rWpvRUpQRM4odn
         kRzMIukeP70qSgVZjx7VUxDUkrV5NsFryaxT+XYvGTwKhuqh7SnIxSStiyWWhJ9s7Lwx
         82VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351709; x=1703956509;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSCkfIpGZxL9WKaqL8EtN8rgM9Yovl63d21O0EWr+bw=;
        b=wVW4KEITUUWi4xfjEeDduXtZq0LroayQ9cDVc0e6OUSg3AMAzEBuQtYEuldFE5oYUu
         pwPkOF7pEcVFr0ddb8S/jcTlTAQ8kHANhLh2wTQMZEBwMMr17VI0WSV/atWWjJo5xHCE
         5lPRZZnUiFL6v0qj47GFgrUOkzobaFXUl7OkL0A9//7j4k1def7OsMtZqCIIipOJ9tis
         5/zBSN6w5X6KHGJ9qiyE5JnHDYPD+chToyX7vp3oHoPtrl6RS7N+M0xyEo9mVOXTVX1n
         XDL5y6zLWxqjZhiPrH9BB0pp96u5Nz1vUHVh25buoiYfAWfSwKit28W3fETtK8cczfiy
         olWg==
X-Gm-Message-State: AOJu0YzSLzxwtoxBC/eUQkpjoNZLWe5vCuUYp+gE9q3y11HxTJrC2Heo
	A2+FGlihyBdxpAXbm59lbU/FqjPWtRc=
X-Google-Smtp-Source: AGHT+IFATYGFNN/US+lU+baaC6DWMDytDote6F5vnVXTHxo+uWzfenhrWx/nyYTTlXBwMC2FAm5GiA==
X-Received: by 2002:a05:600c:1391:b0:40d:2902:7af0 with SMTP id u17-20020a05600c139100b0040d29027af0mr1603736wmf.147.1703351709376;
        Sat, 23 Dec 2023 09:15:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b0040b3867a297sm11122313wmb.36.2023.12.23.09.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:08 -0800 (PST)
Message-ID: <8ae3696197b9cb1d27b17ac9f7c06350eefd96d1.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:53 +0000
Subject: [PATCH v2 05/12] fsmonitor--daemon.h: remove unnecessary includes
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
 builtin/fsmonitor--daemon.c          | 2 ++
 compat/fsmonitor/fsm-health-win32.c  | 1 +
 compat/fsmonitor/fsm-listen-darwin.c | 1 +
 compat/fsmonitor/fsm-listen-win32.c  | 1 +
 fsmonitor--daemon.h                  | 4 +---
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 5d01db5c029..7260604534f 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
+#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
@@ -14,6 +15,7 @@
 #include "simple-ipc.h"
 #include "khash.h"
 #include "pkt-line.h"
+#include "run-command.h"
 #include "trace.h"
 #include "trace2.h"
 
diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 2d4e245beb1..2aa8c219ace 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -4,6 +4,7 @@
 #include "fsm-health.h"
 #include "fsmonitor--daemon.h"
 #include "gettext.h"
+#include "simple-ipc.h"
 
 /*
  * Every minute wake up and test our health.
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 11b56d3ef12..2fc67442eb5 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -29,6 +29,7 @@
 #include "fsmonitor--daemon.h"
 #include "fsmonitor-path-utils.h"
 #include "gettext.h"
+#include "simple-ipc.h"
 #include "string-list.h"
 #include "trace.h"
 
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 90a24122844..5a21dade7b8 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -4,6 +4,7 @@
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 #include "gettext.h"
+#include "simple-ipc.h"
 #include "trace2.h"
 
 /*
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 673f80d2aad..5cbbec8d940 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -3,9 +3,7 @@
 
 #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
 
-#include "dir.h"
-#include "run-command.h"
-#include "simple-ipc.h"
+#include "hashmap.h"
 #include "thread-utils.h"
 #include "fsmonitor-path-utils.h"
 
-- 
gitgitgadget

