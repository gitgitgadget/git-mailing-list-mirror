Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CC17755
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4e51h4z"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3369339f646so1542342f8f.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351712; x=1703956512; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCWixEfH4TB7v+wqSA2k0k7641XZv4vbXlQI8FYdHFA=;
        b=L4e51h4zWGzIKUJVuQDFnuD6WujYlOfnQoMWFHdbt+h9ktKL6rAJyrnICfjICu373z
         VQW8sgEiQk/jusXUDstPMzTb2qX+u0O+El7O2oo8XJ0X+xmnTIfQonD25Doz4qniUsEB
         izDQCmn3P1pdXwo+lDFMwaQJlDGkENtTw24jrIlHZ1fK5pbGos0pCJkqwolWR2xY8Mar
         S3qyIzQX/mjNgdQzvn61yZwKCVT+HRmmMbK/602f5nMe994EKPDxMOsofvdlLRfLt2UT
         YcHCaLNBnZHf3ujAiFgQUPQFoADnETCvszkyYqSDrc0EZ1faKohnFYmGQUfu3rq7vlex
         TKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351712; x=1703956512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCWixEfH4TB7v+wqSA2k0k7641XZv4vbXlQI8FYdHFA=;
        b=l8OG+H+ZQyF9FbLSW7Vq+zMbqHG+gtrqbdGs6nc1P9jl6p4a2VrP82rmYA3nKPcUQz
         PpKDWleQWA7yJmOaIT6P9dg4Yaq8kHfBvj+e2pKXnel/rDuzu37hT36N9jXn5q/TRGWw
         oL0DweA4YSBquAi4Q0aiJeafZIo7BgF97nGmfv9oRFnUlZNGmQpiRb5C1oFz9DjvwlUH
         UEJ5Gjzg3dNWa3lOZ6KX/LOXXfSN+thjwWxI83zYaodRAgORQKci9BjIIk3QMVn4jmpI
         t8Y8Dv9lwsAxzSkrj69Q4McF+Hej9gcrv4O/DyiXtPxc5zjPBacZ5FSi3nv2IpOTtanS
         REFQ==
X-Gm-Message-State: AOJu0YxoAhC45j8RUTj0AT9pAhyKJILGoMWuDCKFw40g9zFWEfG0OOvq
	yhP9Sm3w0bGzgAJBu0FXbybI5LCqX28=
X-Google-Smtp-Source: AGHT+IG/U+4i7cV7rzY2sLSj9lUJS0euwng3ipLQnJMWm7GJ8XmgAPGEeSq5LqLFMtdqaS+l0ZpQDQ==
X-Received: by 2002:adf:ec8a:0:b0:336:5fd5:6bd1 with SMTP id z10-20020adfec8a000000b003365fd56bd1mr2293226wrn.62.1703351712473;
        Sat, 23 Dec 2023 09:15:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d4612000000b003367bb8898dsm6866007wrq.66.2023.12.23.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:12 -0800 (PST)
Message-ID: <d9062fb11bea61febdd7721b03269a912488c80b.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:58 +0000
Subject: [PATCH v2 10/12] trace2/tr2_tls.h: remove unnecessary include
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
 trace2/tr2_tgt_normal.c | 1 +
 trace2/tr2_tls.c        | 1 +
 trace2/tr2_tls.h        | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 38d5ebddf65..baef48aa698 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "repository.h"
 #include "run-command.h"
+#include "strbuf.h"
 #include "quote.h"
 #include "version.h"
 #include "trace2/tr2_dst.h"
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 601c9e5036f..4f75392952b 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "strbuf.h"
 #include "thread-utils.h"
 #include "trace.h"
 #include "trace2/tr2_tls.h"
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index f9049805d4d..3dfe6557fc4 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -1,7 +1,6 @@
 #ifndef TR2_TLS_H
 #define TR2_TLS_H
 
-#include "strbuf.h"
 #include "trace2/tr2_ctr.h"
 #include "trace2/tr2_tmr.h"
 
-- 
gitgitgadget

