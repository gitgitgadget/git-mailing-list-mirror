Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57917266B6
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm1nYOzQ"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0530E9F
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:51:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507cd62472dso161850e87.0
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698177087; x=1698781887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3FPUqjia4IL+cndVTBzDaeC3rjHYRKNnJ+Yf1r/viB4=;
        b=Gm1nYOzQHaPmgnQ3VghMYGeewpPr2W9oDsbCtu+35fn72/zstiTCVEpaOFlr92SFKl
         XsAh+FFJHWj3GNti12UdipExjUoTM+72sqETYoo7PJ5G2VuuESFbqP+XNG7Pte8+ql2v
         xYF/LLxHQtj99rb0efMuvHRdwDyLH0aoioUj8KzONgjrXbx0guQpuzHtykTp7ToCtV5h
         dYKva0v9KU8vsVdWsTxCcKCfa6iVDH3L9UNn51Y+k50ckZU7CkOWpBwJckhgX/uD7z35
         rs4AB5aiah9MJ+MfBX/AltdlYvNmIEdN1Fd6kkR/xClmpBwi8jUNIG0Q1nIuuq7W4WQr
         S4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177087; x=1698781887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FPUqjia4IL+cndVTBzDaeC3rjHYRKNnJ+Yf1r/viB4=;
        b=dM9vVGLsiQcD8hjp32qqBOXpxjV97GAcCdGc5wKZpT3onykKUyEDAjdhG14LEcBali
         9t6tLjo+eODOqcvlaxgFctEOD+NSoKmpx/miKmqs08FNAcTay/TR+Qvb2FKtn7mbQwGC
         +1daW2PxYd/1JmGLMmrReIKocT8c1XxiAgpEuvQmaMxsKHlMO4QMC0xGR6Y2BgqoRcuS
         zE3uHa92T2OBmMQD7wbunHsSmq1Q/mlZ9Ds3WdUBTByUqzrgGHm8Z8qnKItsGCzsmlX6
         0EfiXHct5wdM2JDrSLablrlqyDtocdC8okBL3uPaHi/E4gH0ybcX6Kh4VQMXdFolr4I8
         brtg==
X-Gm-Message-State: AOJu0YyPai8NoEwzkpa3Z9ulQC/hhJ0B7M332iC98at7sNDvpq7MD5Rc
	5OsZCAAOPmzNDsGy0NsalukJ2zIjSVn+5YDE
X-Google-Smtp-Source: AGHT+IHCXAkXMS+Z26O7i289A3svzUlJ9HyeYv+AAKCU/G4vGWZ6jEIHI9CBGqNiuaK5baDfb7fbAg==
X-Received: by 2002:a05:6512:2256:b0:503:4:b271 with SMTP id i22-20020a056512225600b005030004b271mr5189588lfu.0.1698177086721;
        Tue, 24 Oct 2023 12:51:26 -0700 (PDT)
Received: from titov.fritz.box ([46.246.8.35])
        by smtp.gmail.com with ESMTPSA id v15-20020a056512348f00b0050085bb9e68sm2248490lfr.101.2023.10.24.12.51.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:51:26 -0700 (PDT)
From: Andrei Rybak <rybak.a.v@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] SubmittingPatches: call gitk's command "Copy commit reference"
Date: Tue, 24 Oct 2023 21:51:06 +0200
Message-ID: <20231024195123.911431-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/SubmittingPatches informs the contributor that gitk's
context menu command "Copy commit summary" can be used to obtain the
conventional format of referencing existing commits.  This command in
gitk was renamed to "Copy commit reference" in commit [1], following
implementation of Git's "reference" pretty format in [2].

Update mention of this gitk command in Documentation/SubmittingPatches
to its new name.

[1] b8b60957ce (gitk: rename "commit summary" to "commit reference",
    2019-12-12)
[2] commit 1f0fc1d (pretty: implement 'reference' format, 2019-11-20)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 0e2d3fbb9c..653bb2ad44 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -266,7 +266,7 @@ date)", like this:
 	noticed that ...
 ....
 
-The "Copy commit summary" command of gitk can be used to obtain this
+The "Copy commit reference" command of gitk can be used to obtain this
 format (with the subject enclosed in a pair of double-quotes), or this
 invocation of `git show`:
 
-- 
2.42.0

