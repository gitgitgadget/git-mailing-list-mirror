Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E1163
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735603964; cv=none; b=AqqFC+jq/SXe6ho+RHQ9AMdfIFtJEpWeTIwN4CevD4AG2DwQEufJ44AeKAchKgV7/iRHFukPL9QaBdfLxAivZMTSVdiblVWZBvczaVyri3i0Bza4OG+Dx3K+au0LlQ/uceygdhyGZw76ym84vRIf4Jw0vD84lpFptt1AI3qI7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735603964; c=relaxed/simple;
	bh=SAVu4yNEacyGvmkLLgccj2CCpgtxI+jbOy0UkfafAx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=By2JsqXgAWcLag4WQiBlWlBYd32eR9Jqq4/fFwWNKJ/oYQPAOWuE9d+z3DUETu2Jqc2T4bvB8XQriRM0g3rFvQVnlsr8ca1PDc8aaUanSis+xUqSroIgvSJZqk//o6yDojXsn50/F/4b1Lv8Qet6ZQTtjKVoUO9Eqwz767ysqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VERP6pGU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VERP6pGU"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso123826431fa.1
        for <git@vger.kernel.org>; Mon, 30 Dec 2024 16:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735603961; x=1736208761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9a/VL1ZA9qSUqB7SuOmq59l1IU1jFfyEUf4Sd5MnSk=;
        b=VERP6pGU5RO+jFKGmUlsxlS8N/wRWjj91Tefn2uzm9Ej0p+1hiDwlWstmUEl4+kLFB
         VjLXb4iWhPiB+LGI//INTGV/HXANe+eJZL5AsGK2+IiyklFMKf4gD6joG2/0W3fLijAS
         COpGrUS8UVCXELp0yuz8koccUpma1mzrQ/XpLjH6cwVQtihM6/etecT6nvxdTgD9S5ky
         mfDuuu0PDApG1ywvegwsYaq9kqFJrjKKh1pMzzqzOIfyb6IyZRYmGKda5MFzjwH9oTlL
         Dyl0i9zaRO2aJzuqiY5tePjb+i6f2ze/6ZHD7f0hLJjoz4WGLL6kRoC6IsQUEwlNuJgh
         pezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735603961; x=1736208761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9a/VL1ZA9qSUqB7SuOmq59l1IU1jFfyEUf4Sd5MnSk=;
        b=m0ijH6LUYOkt2rIzOIQ7WB1rJfaoTeujGPzoAzFeg19CFXg14HzZ9+BJphBdCZ8bQv
         99RRNo7ScXEG2iUTxL4qXmQY4dBY1YBieCXCNc6NeSzPlZMHM4ghbqG6BAEjPCcVGN2F
         WhsTw4OOtCeKLjNJLwkOC6bmRHFH/qHIkp59aG8xNeV4FEgr2SewQmxgPeDiEdZRv9hQ
         I8CaO4i7avd4mNVqYQbRVd3BJk8KmzUyfdhPGAmSDuYc3KQNZ2ZoeUvOZfioI4y9NI2V
         d9olusgniloVm0MNN61eecBM99FEc+EFo3/bINTjpQwoz5HlOat6pzakr8wnCeRvzV4F
         LD3g==
X-Gm-Message-State: AOJu0YyuStRRNa4o8Ys4X0C41w6zFcdRmcQWrGmfp7vKdzFBqvB49Ns+
	mbbXgIwt53wFiYMjzWxg6HxBm+LTzQVevSWgrcA0sPWa6vf6eBjKGVMRiA==
X-Gm-Gg: ASbGncu6NpJCPxHdXtQFvmI/yaTMr3xhkwCQHeM2fJQNcGgE6RXcDRc9R6OfQMUPJDT
	iWz2E9Suj2VzG4UrTT+A/C4vX2Zi1J4r1FSwLIbqfcYrSe7499ICshfyBD1rJUfaCXHKT9vzo4J
	jJaAd4Kx60MCgZ0woSdU2xlZT/O1vGuUvBBV0AUyTQp3Nwo6aq6loqpjE9W46NzD2RcwEV4xpUN
	WqBk9ykgovEhYy5uTCUSWqKoTRA7ZYx3dQ51JEmrA/zC/uKrbeo3AJr
X-Google-Smtp-Source: AGHT+IEkOkE4YPy/CUmwN8zlke3Zdn9UDFmXH0EnmP7FU7v31MWRpcv1PCoLwqKURxHyWZLd+rlfjA==
X-Received: by 2002:a2e:a9a8:0:b0:304:68e5:eabd with SMTP id 38308e7fff4ca-30468e5f2f1mr97386201fa.3.1735603960607;
        Mon, 30 Dec 2024 16:12:40 -0800 (PST)
Received: from fedora.play.pl ([2a02:a319:4086:2580::b7c7])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045b06a1easm36279651fa.73.2024.12.30.16.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 16:12:39 -0800 (PST)
From: Bartosz Pracz <bartosz.pracz.92@gmail.com>
To: git@vger.kernel.org
Cc: Bartosz Pracz <bartosz.pracz.92@gmail.com>
Subject: [PATCH] all: standardize headers to reflect Git's purpose as a DVCS
Date: Tue, 31 Dec 2024 01:12:34 +0100
Message-ID: <20241231001234.1182828-1-bartosz.pracz.92@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updated headers across multiple files to reflect Git's role as a distributed version control system (DVCS).
This change replaces outdated or informal descriptions, enhancing professionalism and consistency
throughout the codebase.

No functional changes were made, and this commit is purely cosmetic.

Signed-off-by: Bartosz Pracz <bartosz.pracz.92@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 2 +-
 builtin/cat-file.c                  | 2 +-
 builtin/check-ref-format.c          | 2 +-
 builtin/commit-tree.c               | 2 +-
 builtin/diff-files.c                | 2 +-
 builtin/hash-object.c               | 2 +-
 builtin/init-db.c                   | 2 +-
 builtin/ls-tree.c                   | 2 +-
 builtin/read-tree.c                 | 2 +-
 builtin/update-index.c              | 2 +-
 builtin/var.c                       | 2 +-
 builtin/write-tree.c                | 2 +-
 config.c                            | 2 +-
 date.c                              | 2 +-
 object-file.c                       | 2 +-
 read-cache.c                        | 2 +-
 t/t4100/t-apply-3.patch             | 4 ++--
 trace.c                             | 2 +-
 usage.c                             | 2 +-
 19 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index dec8afe5b1..ac84a03e17 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -376,7 +376,7 @@ $ ./bin-wrappers/git walken
 
 You should see all of the subject lines of all the commits in
 your tree's history, in order, ending with the initial commit, "Initial revision
-of "git", the information manager from hell". Congratulations! You've written
+of "git", Distributed version control system". Congratulations! You've written
 your first revision walk. You can play with printing some additional fields
 from each commit if you're curious; have a look at the functions available in
 `commit.h`.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b13561cf73..34f4553da4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index cef1ffe3ce..c3e3a6371f 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  */
 #include "builtin.h"
 #include "refs.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 2ca1a57ebb..7bb4dbb6fa 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 604b04bb2c..837b9b496a 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index a25f0403f4..69dcd59333 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  * Copyright (C) Junio C Hamano, 2005
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 096f96b9c4..f74b75acb5 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8542b5d53e..3fb4645c73 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index d2a807a828..4571612dd7 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 74bbad9f87..9b57946177 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
diff --git a/builtin/var.c b/builtin/var.c
index 1449656cc9..276aa923c9 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Eric Biederman, 2005
  */
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 43f233e69b..2d890c55ec 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
diff --git a/config.c b/config.c
index 50f2d17b39..e3ff33be04 100644
--- a/config.c
+++ b/config.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  * Copyright (C) Johannes Schindelin, 2005
diff --git a/date.c b/date.c
index a1b26a8dce..a5ad6682f4 100644
--- a/date.c
+++ b/date.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
diff --git a/object-file.c b/object-file.c
index 5b792b3dd4..5e457688f5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  *
diff --git a/read-cache.c b/read-cache.c
index 15d79839c2..777a261fa1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
diff --git a/t/t4100/t-apply-3.patch b/t/t4100/t-apply-3.patch
index cac172e779..08b51e01b3 100644
--- a/t/t4100/t-apply-3.patch
+++ b/t/t4100/t-apply-3.patch
@@ -63,7 +63,7 @@ dissimilarity index 82%
 +++ ls-tree.c
 @@ -1,212 +1,247 @@
 -/*
-- * GIT - The information manager from hell
+- * GIT - Distributed version control system
 - *
 - * Copyright (C) Linus Torvalds, 2005
 - */
@@ -275,7 +275,7 @@ dissimilarity index 82%
 -	return 0;
 -}
 +/*
-+ * GIT - The information manager from hell
++ * GIT - Distributed version control system
 + *
 + * Copyright (C) Linus Torvalds, 2005
 + */
diff --git a/trace.c b/trace.c
index 2cfd25942e..ae43433196 100644
--- a/trace.c
+++ b/trace.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) 2000-2002 Michael R. Elkins <me@mutt.org>
  * Copyright (C) 2002-2004 Oswald Buddenhagen <ossi@users.sf.net>
diff --git a/usage.c b/usage.c
index 47709006c1..af0a32af98 100644
--- a/usage.c
+++ b/usage.c
@@ -1,5 +1,5 @@
 /*
- * GIT - The information manager from hell
+ * GIT - Distributed version control system
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-- 
2.47.0

