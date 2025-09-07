Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14C29ACC6
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274338; cv=none; b=MmfYMaR3XtmyPq2WEzgin6XOoUsrwqY/wu7aDGWQKnFqQjbY3YTyuGhLWnkfaIpp5xP3Ii0a4kXCoq6++KxeEgHkvBriXNNAIWddZmwk5QlFSWSNNClNoqEYPZD4Leljjj5D2WuWhDgi/S9UFfgiL6JbyW2//BRIyeFoQFpypeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274338; c=relaxed/simple;
	bh=KyaXLJUnuALiSO8HG9cn696kQ2xGRqkqTTXz5M7peHk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qnKrJQ6PFH0KBfZdFB2H8KWhuX4hvoigSR9NiuyXt9enrf1cMENQ1pGDi0ZFVAJU3c/6ODRwyA28VRJKQaNebYYfTQPBUqcgtP2mrr665sgXtfLTo6pAhW5r67MYCRtfv/lFZly4ulxe1CuDaSxAzlYFFNJP1uF8f3UVstfDGtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuB7wco0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuB7wco0"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-817f3d08465so19290885a.2
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274335; x=1757879135; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9aqDdw2OhYhJqKx1mlW4ZT5Uk5oE9Gnbhficeew/l4=;
        b=ZuB7wco0F0bzC8mpJKG5/ySSolQanimmb4oQ57B9mdV6ZjV/UJ9yjwktMnqWKiKHLR
         aVmdl9usqiFk5FvNoeg/GSd63MD9kk5kyPk40j5h0iX1gbNqrcGZxelGCg1IV7pXdZH3
         +DLz0YJjoUzQZAOT+B1Cm/rKebfVvLhG66IPkHsS3BRcUGFUNLYYpRTeppA2vSRhpXEO
         sTO8pcQLxJ39xVxevFlvlim3/RQS+gBI+U4Fh0Z2b5WVWI/254ToDyYAmgbGyEWhMfkN
         emz2nQ4sES3+c6rqZQTktNRdrGRl+riUJosW9cdrzAut8AF3BzFzXVa4ASB5M/+3zrRG
         Mu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274335; x=1757879135;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9aqDdw2OhYhJqKx1mlW4ZT5Uk5oE9Gnbhficeew/l4=;
        b=a4gF/jtu91Eh9VkFxQmg+YlE+/RHhKY6ILfMiuPtkNHl/aB7DyM7RqpO6v8zE3sa41
         QtMC7FCTZsNOq+izNJFBK7jpy6i87a7YniOjGc3/cANbNCzzfAQB4RbdQzdtyPu9RteA
         DTcPwqtgFyfH9+XCLUPRCREKEvwCVh+K/3WmQ9I7GPQ6vJzNGYqlbZMUn8PLtOF2I958
         BInoh8iA59ZivlnnvBbMd0qIyU+1pIwflm5RTIWBHNjC+H+lAjYfs7QLJMtv0N0pzmor
         oHuJLQhE1HcVN3Fk0HrAo+25Twdo2qHRFZGBhxLiMcFoSIOl42icQEtRFFiQ74PpBmbu
         tpPw==
X-Gm-Message-State: AOJu0YxSpyXWW+lvkAnOWXc8vrpN/PyFBDiqO2agHoJHPib8aRPbz2g1
	T3n7xlxig230ejv1gn5SKXznGRS9RA7eSx05ntEdnMTvq1NtbelNttp3MB76ZflN
X-Gm-Gg: ASbGnct0umBcKxulCK9/SXlZVwJlANMe72Y9+BCEdox90vOPTSuziuPDZL/OMgRfikV
	JFfylAGnFxVy64iKmqDk6weLPhrOicQ+Ubpgi6oidZ7I0LOVPL68A4atCSxDozUszN2SJ36IlT6
	6C7rzdkRwNsOsqpkXKvUz6CMjUwWkguGOjfoh6qXjf05sfuFwiu5D8AMRHPoVGzCkR3nxB6gZzg
	gEiuzyYEDuJZSO3Nyvp3ZsQMyzp+2uTtldw4D+ZIr+Ff95syxn2tnPUykkmxOLqAg8E2rghM7QA
	mi3do9Ga8aqG4o0tf/beXULAten+SQljHJr9rGAX8ezfEsxs+tXoayPU4rxLgwFZ6Fe5wGAeSrO
	XtMGa+kitpdIwRPgXNRxOKP8TaDUe1bpK8w==
X-Google-Smtp-Source: AGHT+IFJYN+kCzHk4DrEqNioagMSgsabgWrbd6bgYTpR8mq9D4TJdrPX+V73Xvs9jbXUiDi8S2N9fA==
X-Received: by 2002:a05:620a:d8a:b0:810:c12d:bef7 with SMTP id af79cd13be357-813bf8b5d14mr539050485a.9.1757274335244;
        Sun, 07 Sep 2025 12:45:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f673e8esm82396471cf.18.2025.09.07.12.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:34 -0700 (PDT)
Message-Id: <ec54380ed385438a1322ef25afa6e0f4dfa7c711.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:14 +0000
Subject: [PATCH 11/17] xdiff: include compat/rust_types.h
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xinclude.h | 1 +
 xdiff/xmacros.h  | 2 +-
 xdiff/xtypes.h   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
index a4285ac0eb..6733d752a4 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -24,6 +24,7 @@
 #define XINCLUDE_H
 
 #include "git-compat-util.h"
+#include <compat/rust_types.h>
 #include "xmacros.h"
 #include "xdiff.h"
 #include "xtypes.h"
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 8487bb396f..ef663af3b8 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -23,7 +23,7 @@
 #if !defined(XMACROS_H)
 #define XMACROS_H
 
-
+#include <compat/rust_types.h>
 
 
 #define XDL_MIN(a, b) ((a) < (b) ? (a): (b))
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 3d26cbf1ec..80afb98bf4 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -23,7 +23,7 @@
 #if !defined(XTYPES_H)
 #define XTYPES_H
 
-
+#include <compat/rust_types.h>
 
 typedef struct s_chanode {
 	struct s_chanode *next;
-- 
gitgitgadget

