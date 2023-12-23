Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912E15E93
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYsvvsUh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d4d70eca6so11621685e9.3
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351712; x=1703956512; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI1ud4HLkaVcpZYdQynYi6SrOVU+12fz4PaoZLJWSmg=;
        b=mYsvvsUhrEyHy13J3jvyZWcwj/YUZVFPJcE93cF1Jcb/iGh9ws5v+DQxJyK6ctZZn8
         79BVAnXvtxXNtvQx/+QjAXpO3bunKy9OQdDhQbRdjOlE6g+EdW6aM9IKedc6hBmKjQKY
         jyICRUrV+a/a+0TD51su9/uhZBvTgipuYMjmp2WS2qsY7edD2RgIwaxGsFnKc2mW0W22
         A0MYB8qKJbn8XKAxr8x5VxSnT6npAiVsxilDHfEgKf/CzqxbQhdYy9JLxUnXhLA4IvUN
         s6azNnRYo1Xlq8eghnepiiB5RDAeV6WHEPHR+g/SCM8MBibi/cY76GviUkI8UK3hzqEL
         AbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351712; x=1703956512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wI1ud4HLkaVcpZYdQynYi6SrOVU+12fz4PaoZLJWSmg=;
        b=jy+1PprCl9EacRP57kG/IFcQKb3DQiJwZ+V3h53yM3f9Hftj206WdDgCdG42lR84hk
         P6RDUCxZ61VSYwIz9Ml7wJLQMaq4N0+PmSTO9iILYzx6h6UeYMgTUwLLR2cGb6JoMGzm
         XTg8IqNvt1+qLeGrkCCYrgsXbbz9Uj+ztWFjGtYqdCfzjbu+8ocyq+HLipLiPwnzuECD
         nbEkT7uIK0GHssEfYLEHnja+OUYXDjEyesjxb8i20aM9voLUOM9OcvPwQ1Sg5LlFfoM6
         vvpjYSH342ztDvf/bN1BW+ZKCaGKm2dPnoVe/FnzmRzMkhpOGj4YsL0EDNUF0xi5aFuR
         qBig==
X-Gm-Message-State: AOJu0Yx/kYL2GIfG+RozU/QV0c/xAwotb9kUtQ9XRPJxCOKZ8BdP8q+S
	dVZLmAf9N1I6mNtXNO2JDE68l+p+a+c=
X-Google-Smtp-Source: AGHT+IGXs6yszJKgUGHs5wwJJ9UvdloguQXsD22qCO+6d0YUubAFwNX5ILnc0qpc71WKeprAvPB9Ww==
X-Received: by 2002:a05:600c:35ca:b0:40d:50b3:6a3d with SMTP id r10-20020a05600c35ca00b0040d50b36a3dmr370506wmq.154.1703351711771;
        Sat, 23 Dec 2023 09:15:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q28-20020adfab1c000000b0033690139ea5sm4481958wrc.44.2023.12.23.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:11 -0800 (PST)
Message-ID: <95688443246a131c20395aac1468bc2b1593089d.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:57 +0000
Subject: [PATCH v2 09/12] submodule-config.h: remove unnecessary include
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
 submodule-config.h        | 1 -
 t/helper/test-submodule.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule-config.h b/submodule-config.h
index e8164cca3e4..958f320ac6c 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -3,7 +3,6 @@
 
 #include "config.h"
 #include "submodule.h"
-#include "strbuf.h"
 #include "tree-walk.h"
 
 /**
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 356e0a26c5a..50c154d0370 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -4,6 +4,7 @@
 #include "remote.h"
 #include "repository.h"
 #include "setup.h"
+#include "strbuf.h"
 #include "submodule-config.h"
 #include "submodule.h"
 
-- 
gitgitgadget

