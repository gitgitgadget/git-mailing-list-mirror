Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VozquvV2"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D863EB
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so33605335e9.1
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585691; x=1702190491; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNi9JTg7O8mXiHhbMn/8YgHPkgzDveZ7qNVf8534OA0=;
        b=VozquvV22GDEGRtLz3xZijQz/FLWPbxsPh299Y6YYdN7jqaRlBeftkrKsWp9M+7VH5
         NXRf+LfkF1MFzqe4WKaKz2iEGbu8QsbOkr0R3BfOXmv5kizo4nOQRjSjzvNl61uF5EBs
         KUDMSGbgxyY/1zIyAYGvDr5gB8pOaNy3fnCdy0uROFBCoIt+/PnuvPE80ZRPujOSKwvo
         D7v2whGlicPykln8b2HCatM54ekcwwFRn6sUH0sVz93vx3pKKp8KKvHDem/soTE8JkZ/
         6PiqwRx7weLMHCJh7+VHlbp6u7t1hDiwHNIJiunUr5H92y+qm9cPTY7+beBwMyK9JbXT
         IqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585691; x=1702190491;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNi9JTg7O8mXiHhbMn/8YgHPkgzDveZ7qNVf8534OA0=;
        b=WvBJHXXnc0+UKBjRgKcDX6X44bwVzQyWrH9RBUODrr1VfxJyKFWTmqaaQfn1RnaaEd
         ZVLI+wPaU040LO4UNUqDcqh04Jmk2op4cueNg0/MJ5jLCCY2v27xVYc23wkmQrAwmnT3
         P8JKGMazlxJ36SAG4qvDAZSc/YZ9eKRBGFh/h5pRhMCb+jrhr1Xef92qEkVtf+wYYUGy
         UDiuwVD4+J/oOs15NZtAxTB3aZ23lGLjyb0tphcsdqZvuM6tBBepMuL/sLkQs6or3yEw
         m4zDPT1DmrDlkFOY0pfnBq6r2wSuz/TAOPdU3D/fGk0nTIgm1oRkUzMX4A8T/uxzpsXC
         Cs2g==
X-Gm-Message-State: AOJu0Yz5XHJSsRoL2Ww3xpEq8j+Pud11pHAYHu6u3nt35MvKqAy8vvhd
	SNLLM0HUoIDO18fj2gAtnGzaePLka8U=
X-Google-Smtp-Source: AGHT+IG7w4Pd9+zx6NUEtmoUceDPb5ptpbg1KBwkRkZEL2v4wpkb7ZVgjHM8DMJs5v8skXhIfUmyzw==
X-Received: by 2002:a05:600c:2195:b0:40c:909:58f4 with SMTP id e21-20020a05600c219500b0040c090958f4mr189518wme.235.1701585691060;
        Sat, 02 Dec 2023 22:41:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b004094d4292aesm10802345wmg.18.2023.12.02.22.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:30 -0800 (PST)
Message-ID: <5f8014882e07682787adb6ccd59829f1ab01bd84.1701585683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:16 +0000
Subject: [PATCH 07/12] line-log.h: remove unnecessary include
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
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The unnecessary include in the header transitively pulled in some
other headers actually needed by source files, though.  Have those
source files explicitly include the headers they need.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 line-log.c | 1 +
 line-log.h | 2 --
 log-tree.c | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/line-log.c b/line-log.c
index a878cb7810a..c276ccec549 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "diffcore.h"
 #include "line-range.h"
 #include "hex.h"
 #include "tag.h"
diff --git a/line-log.h b/line-log.h
index 4291da8d792..e9dadbc1a58 100644
--- a/line-log.h
+++ b/line-log.h
@@ -1,8 +1,6 @@
 #ifndef LINE_LOG_H
 #define LINE_LOG_H
 
-#include "diffcore.h"
-
 struct rev_info;
 struct commit;
 struct string_list;
diff --git a/log-tree.c b/log-tree.c
index 504da6b519e..337b9334cdb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -2,6 +2,7 @@
 #include "commit-reach.h"
 #include "config.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "environment.h"
 #include "hex.h"
 #include "object-name.h"
-- 
gitgitgadget

