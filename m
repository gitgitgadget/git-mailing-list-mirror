Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946A199FB2
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908710; cv=none; b=Zzu14QR8l2FJ6vYVJ/1HbfHVH5kuYPgfKl25aY15LRKykVeoN94o6TacWBPTNBdb9syhXc+fOsLduVznwPRrKPrdBLnn9pcp4fQo8QKPJ5e0qMsQAjmXJXBjdYfHgVJssnSUJURS+bCS6xaIAWkK0BzE3UAnFCzbdyVE7n9ZfyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908710; c=relaxed/simple;
	bh=nj0CnRMAYzPL9eYSbigNMZdkU47iIiy7/rNm6togjmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rq5FQcr11HpbuMJQkl8Xw3NTNKiI2jO8fVTD/RBHiSAXnk1w4o2AupuI9rjL5dGUpC9sT0dOVb4GsNE52YLwmoo68SKGGQpbUuXejIbF8Xi3aXRd+zFY/h3U0vVRah2Q0Ha273ir5+bZDsCuTYKfx/eKLzXjRVz24n42p8D0vvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHtRhV52; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHtRhV52"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so2246735e9.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727908706; x=1728513506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ITSPoz0SVrYo169jqEJ5Rerc1NBZuFGf2J1+joeehU=;
        b=kHtRhV52MGtiX71QYCuYWHinV6SmAQUEI21wtMJvhgq1pA3riXJONMtiA4qTnWyxvu
         7Oj2nYWQKz03Smi6Og5Ix4CEBv75osgj3xhb9dF+ilBTwFpwzFn5YTRCRkYbEPNoXOoA
         FI268k1cUdA5dl8q/iKPmsKU1KcTaoDbBIRfL+1KQs6RDq/N4Aw5mbd3ke5atLa16vw0
         YT6wFFgHE2XGT83Jw8p532PVBPyJwOoaLHUG4YoEYymtTpshdqdkdZEENMSLEha9uknr
         B+G8zhh1l5FCy4sigbDD0I8WP9sQLRPjt5rCsXZEBKutkJLES+t0qezpVysKFL2c3r31
         /TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908706; x=1728513506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ITSPoz0SVrYo169jqEJ5Rerc1NBZuFGf2J1+joeehU=;
        b=Kgc/U/UM8D0run+Y8C6luIyFzoX8eGs68CVjr9rNWlUS8LbRS4Jt7U4aMaQrr1b4aQ
         qjp0ODeyDFy7YJLkz8qFqTi6u/Cs7Z4FmxYE5Q22qpbdeeZVR7d3gxuuev4A4N3/1kV3
         s8xdHcfLN+Xs3Een1avhRubli3zbgLL+u5U/kxF0/5j5aBVy8vKbf0MZE6TVSCrn/J8J
         HxnxOGsboOgriHWae+iENYtBvC2q0098s3emWIoCSUyQKHU7yVJzfp5Aok2FiWS8yiRn
         TETid3HU2JUw/aiy0YiDdQMYd3s2gmZ9GvwSEWAHR5GYyj6ZLTr3yBh7+Ds2czgAEX6A
         FIBQ==
X-Gm-Message-State: AOJu0Yxa55pTkAtFvV2ZQHSFxIpeCTPwxtiU0UbZGZLOD/p1Cp2SnDm1
	ATbcBtTle0Ov4oHVHwCBV0ExixELebGUlfaPMiSMDLkvGwQXAIgKr1Ut/oZ8
X-Google-Smtp-Source: AGHT+IG8pdoR46oeHqeaafmqFOR5YMKZi/AcrLEFvMMskVy7YU1nccfghnDnG+p3NPP/ZkFGh+Br5w==
X-Received: by 2002:a05:600c:19c6:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-42f777ec6b3mr31245645e9.28.1727908706339;
        Wed, 02 Oct 2024 15:38:26 -0700 (PDT)
Received: from void.void ([141.226.9.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eacba2sm29753095e9.14.2024.10.02.15.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:38:25 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 3/5] mergetool: fix a typo
Date: Thu,  3 Oct 2024 01:38:14 +0300
Message-Id: <20241002223816.14858-4-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241002223816.14858-1-algonell@gmail.com>
References: <20241002223816.14858-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 mergetools/vimdiff | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index f8ad6b35d4..ffc9be86c8 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -411,7 +411,7 @@ merge_cmd () {
 			-f "$FINAL_CMD" '"$LOCAL"' '"$BASE"' '"$REMOTE"' '"$MERGED"'
 	else
 		# If there is no BASE (example: a merge conflict in a new file
-		# with the same name created in both braches which didn't exist
+		# with the same name created in both branches which didn't exist
 		# before), close all BASE windows using vim's "quit" command
 
 		FINAL_CMD=$(echo "$FINAL_CMD" | \
-- 
2.39.5

