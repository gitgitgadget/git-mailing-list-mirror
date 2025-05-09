Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA17BA38
	for <git@vger.kernel.org>; Fri,  9 May 2025 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779441; cv=none; b=SX6p0L/6IAmo5bGDxxSzkVnQ+Qri3hyPWT6EoCqxeKiPxlcpCQl7URyyW4iz3He5U007t3Cd/clmfrUn++u39ETLRd/FLz+Kz2nqiXq7sBdPq49SgofTsjB3HJ6kcv0ziufl4234YGp6c5FMfzwpwdQiJJLx1F9Zq/vxNNaVQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779441; c=relaxed/simple;
	bh=JiDxrDon/2DrJx00a0Y1Mq2RlIBoADCMedDzKqBMso4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=asjCNs8tPPqoeot68/DWVRKME8mc+CeMfnIFN0raZpb4G2J71AMCXxevv3BoSNkkO4AzAKsublbsqyjazyEJVrxkeoduWorjUSvOjFaRslfBZ3aj23m9iRYQ3BvO5uVqUoFzVAvfrOsb2gAA+XrTO23SU5cOA43VxSW0ozHyKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlU451PD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlU451PD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so20544125e9.3
        for <git@vger.kernel.org>; Fri, 09 May 2025 01:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746779438; x=1747384238; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqOLUAjY1HtFLqN8o6/wmISmBUGZBTa+CiZf2nuL0uM=;
        b=PlU451PDP/rW4M1CRPEMH+PqRC9CMezE87B+JQnSSYkTOEE/W8sZb16svaN6eH3YsH
         V+H0nQLHWUUPHzvRi/wfg0fv22xY2FjoZNvhMZvRk8OEroj/Z4IHNXGHqgJFxHLaGTB+
         mDS5SyfvL461MDg6fwrVXt1pTfYDvIfOc5hKy3gHWPsZPmye8Cj0lARODBJACuLdmf6W
         qJcn0UpMNr7/rMpYiFHWh7T8O62YNPuR9vN3lqnremaAHztowy6DZ1JTDyv0R9Ug/Wii
         1N9uzmEOqMVxslWHkniPlFqMj1authszNHnp4Iy6fA8QNllAg2YqZa+UUqrnMGOkFnpN
         Anwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746779438; x=1747384238;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqOLUAjY1HtFLqN8o6/wmISmBUGZBTa+CiZf2nuL0uM=;
        b=LEUWJZPcVepNoNFh9NfhTNXzdBqHuzPrdxDkU4PV4runVQYuz8auqzU+fMsJ4ZGgFb
         vrBhI2AwvptIK/ZBJun6f8midA/IvJeIyP4uOZgXhkQoXKwueEguEJb899l/qbdVoX/A
         412cFg/yJZ1G2hgEsgN91I3KlsVRMtsInQOcRRG6Skpui3Y2F9a1oT920vCjCpXUGcSb
         tc1jI2eFrxjQzZG9FpngBmajrd76dFmYqyDNRKfHcy3Ly8X+zFOBCN4yWpE611zXicBN
         UGqSJeRrrB04AyywfOcgrDM/XmYy3MKwyf3kJ8zcHUrz5HJB+btEJhMQUw5H1QcCLHdo
         jBNw==
X-Gm-Message-State: AOJu0Yzba9GE0IEPNApj2AIb5PFmpHDhqWYBvK9J4isjxcij2oh8cNBr
	vIF2jg8xZJkL/7e8f2Dok3VNcyCqy8hLzWTf1ayf6bi+SU0wXgVXCRkIzQ==
X-Gm-Gg: ASbGncsQ9/M/4yqZOMrtnxguwp7tP52DoAQpVTZGU3zlnkH/kHZE7aLA5riwf49/rUb
	EzGXSDZAwPcQK3VdhKvoCuAUxH62TYBMHIxklqZef7EHxdycVdRPwLfS/fi7RLr78sZA6xvKeeX
	qhHyaO9PxFzez5m4GNW7vfV/LSFrV3yhqZMS03V3jz8HDnh/rv6+icg6KYa8v3OsKAM9U7QKzGm
	d+jg4qZcGZuFbB1NFVRhmw6WeC159WNRVD1Fx/pe0hBLDpZd/mIUQe0ZHgPj/UDluFhPRc8J64N
	C5xWWa8Z6FwZZ2XBjWRatfY6x2W/nYtyI8wgoRDYpA==
X-Google-Smtp-Source: AGHT+IHkfU0wWMgaN1H5rhwiHl+wsTMnPBY2XO6wXV+urR0AuiYvnsb5U/BpdpnUaBfRla6iRdZw2A==
X-Received: by 2002:a05:600c:c0d1:10b0:43d:762:e0c4 with SMTP id 5b1f17b1804b1-442d77fa213mr8820195e9.27.1746779437186;
        Fri, 09 May 2025 01:30:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d7778a79sm10595695e9.0.2025.05.09.01.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 01:30:36 -0700 (PDT)
Message-Id: <pull.1957.v3.git.git.1746779435536.gitgitgadget@gmail.com>
In-Reply-To: <pull.1957.v2.git.git.1746774869081.gitgitgadget@gmail.com>
References: <pull.1957.v2.git.git.1746774869081.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 May 2025 08:30:35 +0000
Subject: [PATCH v3] commit-grap: fix memory leak when `fill_oids_from_packs()`
 fails
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
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In commit-graph.c:fill_oids_from_packs, if open_pack_index failed,
memory allocated and returned by add_packed_git will leak. Simply
add close_pack and free(p) will solve this problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    fill_oids_from_packs: fix memory leak when fill_oids_from_packs failed
    
    In commit-graph.c line 1930, if open_pack_index failed, memory allocated
    in line 1925 by add_packed_git will leak. Simply add close_pack and
    free(p) will solve this problem.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1957%2Fbrandb97%2Ffix-commit-graph-leak-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1957/brandb97/fix-commit-graph-leak-v3
Pull-Request: https://github.com/git/git/pull/1957

Range-diff vs v2:

 1:  190961fe942 ! 1:  e0dfe69f504 fill_oids_from_packs: fix memory leak when fill_oids_from_packs failed
     @@ Metadata
      Author: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## Commit message ##
     -    fill_oids_from_packs: fix memory leak when fill_oids_from_packs failed
     +    commit-grap: fix memory leak when `fill_oids_from_packs()` fails
      
          In commit-graph.c:fill_oids_from_packs, if open_pack_index failed,
          memory allocated and returned by add_packed_git will leak. Simply


 commit-graph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 6394752b0b0..93d867770b0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1929,6 +1929,8 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		}
 		if (open_pack_index(p)) {
 			ret = error(_("error opening index for %s"), packname.buf);
+			close_pack(p);
+			free(p);
 			goto cleanup;
 		}
 		for_each_object_in_pack(p, add_packed_commits, ctx,

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
