Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9511736
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi8+px8k"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99178184
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:51:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32f7abbb8b4so843362f8f.0
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698958278; x=1699563078; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JILAqu1fh3Eb/3IyzuhSp54njt452p8V8rROwluhj1Q=;
        b=Pi8+px8k8WlGIlYkXCwsS20n4FyOlh9zRU7qmv5BtYoaOb/hZW6LLgbWfquaxcn91j
         0Ws1+NH4C3LvsH31a5A8Aa67bOLK91ZgjaHN+R5G+GiXahrl1F62w+6jKYcz88rSbHjU
         NeKCT5fVboTE+dwi14VE2nVZeaL1QYxWeHoYpCZjMzcn2lGLEJ/HbzSdJeFgFxWv6iMs
         USMjr27ODb+kpNqVvml3LYy9/xNJNcK0JA9hOrIrBOap7x0RMcLWcqCy3TEUcU/Ipdk5
         B2qFvccLYVviJ1/xejvbJV6e8IYASdZWjkHwFWco1tL+Em44+7B/U8B4po1HLejulmCK
         t69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698958278; x=1699563078;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JILAqu1fh3Eb/3IyzuhSp54njt452p8V8rROwluhj1Q=;
        b=ppgbA3zy1yb8Iggadd0v3BCSZB51fRhiVgfEK1izdXHxpmVO2HgJVUacMMp+pzm1nT
         EAi36sQyTF3qbDsn8fUx6fJzUzqNfkxXa4dx+Dd58W5ZchPNGI6DV2vcSQ+Zha1/VKW3
         VljJJzBIIPkV/b59b+6Wc8cA4H75o9a0wh0nEavywZMBpgzkMpNholXXn9QSn2yHdEps
         JV1EubPB6fcM+Fzeq4Lue3YbJagi5eItwxzOvVbc3RSGqNrjcHESi3CGx1hxJlh+pEFY
         LgrsbQqDCGDHyXvF9caIk9a+0QiKbe9vOGRuIhrSU/P4RxKgMSmxBn7/GCqWBIV4YwIa
         yHIQ==
X-Gm-Message-State: AOJu0Yz59V5nTntXDdEPjEThLz6ZA7PpOAGAuxknm4m5AFRvg7SfnvtQ
	I0eee2PKixS3LO6khYsSk524zNAQ/lo=
X-Google-Smtp-Source: AGHT+IHnVTgpEaU+nz8wcgRViG9Wsj6K5gSG6ixovfAsc1ys8fsNFi7mUrMKu/YUQN+0/qpIyVfcOA==
X-Received: by 2002:a5d:5443:0:b0:32d:857c:d546 with SMTP id w3-20020a5d5443000000b0032d857cd546mr13709886wrv.64.1698958278244;
        Thu, 02 Nov 2023 13:51:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11-20020adfe7cb000000b00317a04131c5sm253691wrn.57.2023.11.02.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:51:17 -0700 (PDT)
Message-ID: <pull.1608.git.1698958277454.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Nov 2023 20:51:17 +0000
Subject: [PATCH] strvec: drop unnecessary include of hex.h
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
Cc: Jonathan Tan <jonathantanmy@google.com>,
    Calvin Wan <calvinwan@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

In 41771fa435 (cache.h: remove dependence on hex.h; make other files
include it explicitly, 2023-02-24) we added this as part of a larger
mechanical refactor. But strvec doesn't actually depend on hex.h, so
remove it.

Signed-off-by: Linus Arver <linusa@google.com>
---
    strvec: drop unnecessary include of hex.h
    
    In 41771fa435 (cache.h: remove dependence on hex.h; make other files
    include it explicitly, 2023-02-24) we added this as part of a larger
    mechanical refactor. But strvec doesn't actually depend on hex.h, so
    remove it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1608%2Flistx%2Fstrvec-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1608/listx/strvec-cleanup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1608

 strvec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/strvec.c b/strvec.c
index 89dc9e7e753..178f4f37480 100644
--- a/strvec.c
+++ b/strvec.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "strvec.h"
-#include "hex.h"
 #include "strbuf.h"
 
 const char *empty_strvec[] = { NULL };

base-commit: bc5204569f7db44d22477485afd52ea410d83743
-- 
gitgitgadget
