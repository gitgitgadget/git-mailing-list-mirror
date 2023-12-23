Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8E13FE2
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdeyxy5z"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d53297996so1488945e9.2
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351710; x=1703956510; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttkeYFSt4eNhwg/B0nagXg282CBMg4rUewvl4yzbtls=;
        b=Pdeyxy5zaukDk02RUJDIcSwTrOcoSqV2MhRVlTsi7gFiZ3ga9orUEsPMSIEaphogUU
         YV2QKMThSyePZCdisPhCcx+Gx3EZ96DVhU2nLps0oYESjvF4H4UjDvd18JTfksAwy6hi
         u3PkJCc9IvOR65M+zH4GcKhFccmvuASXg0oBatrSEQu8Wmkkh3+QyfEu3viQK4LcQp4G
         HWczq8MRcKcZtwfrj/zfPpSi+oeQqVBXE/rL8a1U+uQlmGX/Mp84ahryBdy18xe2PZt0
         RmweASzwqjjiQYHgcCoVYa0c9OEYibxqYUr6I69yLDil3o6d2leNsnORjVEVdSZNlDVw
         OnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351710; x=1703956510;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttkeYFSt4eNhwg/B0nagXg282CBMg4rUewvl4yzbtls=;
        b=nA2xENwAUuOM0Hrxh4tAjX8J8O84BrsezDy2sYVHquP0KJac0YmX7x4DisLswOyby9
         yOvKdPpQkT0myq9xaBZAybIzNAMssubjJGYMnkIUYHhBGkZrUMlzuLTzVoLfswdQatod
         k9zk9Y8SuhB3Z2exZ42VUUoYQU9b5jzWfn0I8cqp3TtMjVnnCGsPFYNm94ms9ZGskbqT
         YNaotX6m81oAWzqhptT8GYVMwVlO9k6JX7CFDRtnUOB0ZHXItb5HCn9eygzAT9eBHVe5
         1B1bIbGvFSTkYLIpchKe/oLjSr09ZD+G84UcjJgCfASeK9jax4VowZnvOG/hSE3NMh8s
         bY0w==
X-Gm-Message-State: AOJu0Yyq2mLK0vCjp43Ty+wSsEFOG0O4GM0cgaVp0HvOraTdKifUTRH4
	/bxd+Mbtqr4tfVEB86oJptFb9KaReKs=
X-Google-Smtp-Source: AGHT+IG7k6MtAu/1RaY3bRSquFyCOK+E7p1yx8PvdkbkntvEsa0ACMtyZ0+Mu3BT9f9lbIJy2hF1xA==
X-Received: by 2002:a05:600c:3b8c:b0:40c:2c21:547 with SMTP id n12-20020a05600c3b8c00b0040c2c210547mr1832056wms.184.1703351709848;
        Sat, 23 Dec 2023 09:15:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p35-20020a05600c1da300b0040b360cc65csm11381565wms.0.2023.12.23.09.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:09 -0800 (PST)
Message-ID: <29b7d47718c44b0f22053e51431035bce8825efd.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:54 +0000
Subject: [PATCH v2 06/12] http.h: remove unnecessary include
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
 http-fetch.c  | 1 +
 http-push.c   | 1 +
 http.h        | 1 -
 remote-curl.c | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/http-fetch.c b/http-fetch.c
index 93695a440ad..bec94988bbe 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -6,6 +6,7 @@
 #include "walker.h"
 #include "setup.h"
 #include "strvec.h"
+#include "url.h"
 #include "urlmatch.h"
 #include "trace2.h"
 
diff --git a/http-push.c b/http-push.c
index 329513270c8..b4d0b2a6aa3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -15,6 +15,7 @@
 #include "strvec.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "url.h"
 #include "packfile.h"
 #include "object-store-ll.h"
 #include "commit-reach.h"
diff --git a/http.h b/http.h
index 3a409bccd4e..3af19a8bf53 100644
--- a/http.h
+++ b/http.h
@@ -10,7 +10,6 @@ struct packed_git;
 
 #include "strbuf.h"
 #include "remote.h"
-#include "url.h"
 
 #define DEFAULT_MAX_REQUESTS 5
 
diff --git a/remote-curl.c b/remote-curl.c
index 204feebabe4..55eefa70f97 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -21,6 +21,7 @@
 #include "quote.h"
 #include "trace2.h"
 #include "transport.h"
+#include "url.h"
 #include "write-or-die.h"
 
 static struct remote *remote;
-- 
gitgitgadget

