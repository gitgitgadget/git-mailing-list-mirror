Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00601311AC
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855369; cv=none; b=gvo2Qj5nZbTsK8u118drdc+MQI32SILAiFOp24nFe7QvfSXNV2NTG4VHAcb6er4/7PLfFlhxSHGUrn6On50aJxlYYOK1PM7IVQVS+BbKbUc+JT2rNty0vTSEIGfcM/M2FDuwNgtiaAUeVDAUPL6/yXOZup9TwhydaN8qOTO5vLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855369; c=relaxed/simple;
	bh=1bAd+/lwvauhLT/Sm5m/r5E/zXc74zi2BNURHQAEGoQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PnKTOExJj6DCnFcDN1dKHEGjQ1kJdENfZGUdQGtQTc6G/GP4jFuKoenFSItg3AeTx9HGyyzaL+2fZbdolFAfD0v2Crb016VfYV+9uAx2aLRhtUPEsHFeQ6TVDYotUlYiIDkAWfGS4V96s5WXzvNLXeq6AcXuKszQQaETz//HxMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awhV1Lem; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awhV1Lem"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42803bbf842so94062885e9.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 03:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722855366; x=1723460166; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wYAxYPNm79Rqug7CR12+0E6VI9pfRT1lW2slSQ+6Mik=;
        b=awhV1LemydyR5mX0WcrHKl3ZkA5xo4iClmCppxCCEBMEYCEF87FKYsq6TJui/uRweK
         EX721NaCwyZZxAZ3S77ahjicSy3j03ky9Cl81Kx/G96i+aPs8zIlpFuURA5kqzRmQaX6
         Ujnm0go6cGddMQfL1/UK79xizdVbIrk/1lpbTvvaodBfsl+wctV/TrukkXGYVay5RQN2
         WKPYdq92qJALSM2K9u5KcLkHsFJlbMJ+wrfIAAs7SeL1D6jXKibqL3cu6rKDp9JnLRhT
         Yj7xvVpTRz4GcH2aCJnG0XXTHzoUpqk+6Do86krG+/06/heb2xQi8S7aqKRiKHcsEXAC
         CkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855366; x=1723460166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYAxYPNm79Rqug7CR12+0E6VI9pfRT1lW2slSQ+6Mik=;
        b=PitGQBBXUqF+Prnur14y3ZYC5Vbsr0rNKPz8QYK1m3kvQdXcTPU3xFq79cYPxD3UiK
         BOQw6uZ1LhCc/LGJk/M5GvFHzlE2NwvCE9WJWgcQzczcX9zQ/gACk7hpowUYwby1EZu+
         Td2gbRZ9xMwEowKdjF2wrQu/rKi/v7DeTfwehGDNjixY2l+OJra6GiONaHDYeOkvc4ND
         KCsS/22RdhiL7o9AIOHIirogSCisfWgxGiNtovHCqNbkEhtlpePKbsml/SXxpShCdKGu
         t2AcBtQJVZjECjcEw1Bi7ZcWUZ2eXMBqTy24uIWg0OfuNgnO48yZRWzD/Kpg5X+Tq80I
         /G7Q==
X-Gm-Message-State: AOJu0YzuX1A5UxbkoKH+b1gSXKwXvAEDgs0yX625Vw91UgE7GfUJVr4q
	jeCKV/XCqWReu9LzwdCEWAsEmJ8Hzju9+4YSgNKikAY3U00kQRaAmlescA==
X-Google-Smtp-Source: AGHT+IEmp1CvVKLtznyRz9TCkhfwQKNZd1YQRhX7eBB/yLLCT4xms4JOYTe9uByJMKqwQkch23UG4w==
X-Received: by 2002:a05:600c:46d5:b0:428:e820:37b6 with SMTP id 5b1f17b1804b1-428e8203ceamr86743655e9.31.1722855365510;
        Mon, 05 Aug 2024 03:56:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428ebbe18c0sm113608225e9.17.2024.08.05.03.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:56:05 -0700 (PDT)
Message-Id: <pull.1758.git.git.1722855364436.gitgitgadget@gmail.com>
From: "Sven Strickroth via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Aug 2024 10:56:04 +0000
Subject: [PATCH] repository: prevent memory leak when releasing ref stores
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Sven Strickroth <email@cs-ware.de>,
    Sven Strickroth <email@cs-ware.de>

From: Sven Strickroth <email@cs-ware.de>

`ref_store_release` does not free the ref_store allocated in
`ref_store_init`.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
    repository: prevent memory leak when releasing ref stores

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1758%2Fcsware%2Frepository-memory-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1758/csware/repository-memory-leak-v1
Pull-Request: https://github.com/git/git/pull/1758

 repository.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/repository.c b/repository.c
index 9825a308993..46f1eadfe95 100644
--- a/repository.c
+++ b/repository.c
@@ -366,12 +366,16 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->remote_state);
 	}
 
-	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
+	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e) {
 		ref_store_release(e->value);
+		free(e->value);
+	}
 	strmap_clear(&repo->submodule_ref_stores, 1);
 
-	strmap_for_each_entry(&repo->worktree_ref_stores, &iter, e)
+	strmap_for_each_entry(&repo->worktree_ref_stores, &iter, e) {
 		ref_store_release(e->value);
+		free(e->value);
+	}
 	strmap_clear(&repo->worktree_ref_stores, 1);
 
 	repo_clear_path_cache(&repo->cached_paths);

base-commit: e559c4bf1a306cf5814418d318cc0fea070da3c7
-- 
gitgitgadget
