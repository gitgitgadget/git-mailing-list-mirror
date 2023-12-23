Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1271412E55
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEEFjXeZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336755f1688so2558318f8f.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351707; x=1703956507; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3TGCI/YCgWfYljSZYwF1mWsCWRqnsoG9BODzgV1+jA=;
        b=eEEFjXeZYCf/2mAIandWsN6+2QwIBuOAo3ixFJZXzio3uduQzx49LiAe7JauXz1FYC
         ftfpXRfw8YrkhzYuf8DMlnW97NDBdtlP1C0Lrot9fYcvMLnGUZkJDaNzQJzvXmDbi0QU
         Xd7Pt3A6jTbrP1Jb+Avv3Knorsowv7EfDw5INE6FoIGvdepuO68/BmzlnxCXLBjuYQtL
         2lZcgs7dCGk666iKo8s3usK5k26epZl6kSJPkTN1GyjHUIbnP5dqLVyAjSc6ENfzj3Hf
         DIYSbSj6cJj0j8TUX5ZjDr+6ocCSgFKZbY8zK8ohB1ZnjgzNR6APRdMGFB2WVwaAr2Lr
         dPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351707; x=1703956507;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3TGCI/YCgWfYljSZYwF1mWsCWRqnsoG9BODzgV1+jA=;
        b=YHAXLr0iP1T7QziZq4sKIArDLcfh2TQaym+xYuio2vCfQbEhgkJPk81m46rbyMQCwy
         lkGcAsQ6VIEapkvIa4KJVsTBjKfAmzINzYp0BkUOvWYvYx9YNKsEJXdTWL4cdvo3mvUC
         qDzW/XqaMBN29YG7ONP9P6SQsZ00cY9i/1M5d/NOQQl7rYYmHFAg8ctWZJHWhEy9ZPeS
         CpQ41JtlWJeBD8thWCE1PweZd96x1BKJu2DGrfUK15ua7andfg5h1CoZ2xlnmQtyov2E
         iVvZbT6T1WYg2KA0duKD0JrYgEDUznu3LUtNVlroFUp/AgY++gsTzYDpkl+h8RdXgszg
         GIgw==
X-Gm-Message-State: AOJu0YzSz1QET+RNuJLtU/FQyC30pQQrZhgAfs7tXwBvy5m7NXlCWogf
	GYaQKxg/PJLaR9rKPD7Z+EQrrOxiKNU=
X-Google-Smtp-Source: AGHT+IFJKqKk4IzzzGgrD9vWoNDuxWp49W9Aw7WH4/NH/I4ZEIAjxesuaLxs/SE8iPgFeAAowY1RDw==
X-Received: by 2002:adf:e40c:0:b0:336:8d5b:8535 with SMTP id g12-20020adfe40c000000b003368d5b8535mr1697893wrm.59.1703351706665;
        Sat, 23 Dec 2023 09:15:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13-20020adfe60d000000b00336607f6630sm6862201wrm.47.2023.12.23.09.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:06 -0800 (PST)
Message-ID: <6211270d6781074745dee1aefbefbf8bca141434.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:51 +0000
Subject: [PATCH v2 03/12] archive.h: remove unnecessary include
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
 archive-tar.c | 1 +
 archive-zip.c | 1 +
 archive.c     | 1 +
 archive.h     | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index 07269968399..f2a0ed77523 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -9,6 +9,7 @@
 #include "tar.h"
 #include "archive.h"
 #include "object-store-ll.h"
+#include "strbuf.h"
 #include "streaming.h"
 #include "run-command.h"
 #include "write-or-die.h"
diff --git a/archive-zip.c b/archive-zip.c
index 7229e3e454f..fd1d3f816d3 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -10,6 +10,7 @@
 #include "streaming.h"
 #include "utf8.h"
 #include "object-store-ll.h"
+#include "strbuf.h"
 #include "userdiff.h"
 #include "write-or-die.h"
 #include "xdiff-interface.h"
diff --git a/archive.c b/archive.c
index 4562a69a0cc..50fd35bd27b 100644
--- a/archive.c
+++ b/archive.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "path.h"
 #include "pretty.h"
 #include "setup.h"
diff --git a/archive.h b/archive.h
index 3a4bdfbd078..bbe65ba0f90 100644
--- a/archive.h
+++ b/archive.h
@@ -1,7 +1,6 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
 
-#include "object-name.h"
 #include "pathspec.h"
 #include "string-list.h"
 
-- 
gitgitgadget

