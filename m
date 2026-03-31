Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B4539BFF0
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951379; cv=none; b=uec6EvMS6T7+4I3BvAAF2XYG4X8oazsAS0Gi+8sUP5eUWt9ulEmxPcGPW4N6hK7J1gI8HBXepsn/tBVb8wj91LoRml4HTjjn+GO+2qd/Qs6nYV3cSJWoMkTGHY+xNxVXzddwEYbOPzB0V4ghCWGbAmNbtTK62Lyk8fMzaweFjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951379; c=relaxed/simple;
	bh=1lLOdan5NhkHI36Hrp/dl1DyoopbdMY27nMxN6GFhrY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=atvALZjbMX2ZBHQAMhfTzLS6A00JzoJWGJLBV9nY3Y85AOqpP3u1j9P6kgRetqGowQbDnMnBSkaIl8WbW0Qdj4moBiVUZoZbDo6Xtio+mh+99XrlJGRz6nEcWMRWSKQvQqR/mBt/weeopSazaHcXOtBp868UOLyNOY432IWfHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq69RlPl; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq69RlPl"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d9c98e437cso4605768a34.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774951376; x=1775556176; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RjV8xaCNYDZn6QBT29OpZPybn0t37EtzScgVaz6MN0k=;
        b=nq69RlPlYnlBCYS5kWoPHC4USbkzGf4zLdYz4tbakWThmBH8YMju0c7sXA2cKB5ZjN
         V5koZ+STd9U4iuFrViD7h1yKObL2x7Gs1Ll0TT+j1YRJjBeERJKTCmsfrrQ7dr3tRguD
         /jk4U1tWCMFessHMma7QlIActyeF7bSkoXVGG8Qu7SIApNg5eZW92/VSj7w/oHxXd69z
         BPehECR0B1SCxwfV1iIjmwJKm2XO/I6bzmjwNgp40CHp0NcYdXEY19AsdRbtB1bHqevM
         bVzRPuEBIqMMyXkIfUQQuUWi1vMhOE3mL4nnDuvfQaOc10oj3VYaNDICXqi4/4gxRFow
         2fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774951376; x=1775556176;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjV8xaCNYDZn6QBT29OpZPybn0t37EtzScgVaz6MN0k=;
        b=p/7ufd0aF9P+6qMuaa+iQd/WJQw/EHHHNFq0QX9YzYgBz/OiWjHT4GxZtR7gTGbuIR
         dIraW9+fnHFJv8EH9d7XFN18YxxphvnmV+YqBuLXnzi0BzMImpREFMgET+hkEosW0S8i
         baTar1rgVQEt2FtVk3kYKtRgm4jPlQzUNRHkFkVg+2A4A5GS4XwOUfeW8nLVkJ+QziAs
         Wk7Ndsp3hqvWveKgnvps9an8TGZz90X6PGZg8w/4ynOWtDX6cRvbsgjGuKvHX7ndbZuJ
         fcReBLe5Ub0N5iP4Mznb/vbWeo2yt/Sh0i5GSzQ8zOsvshRLCv+M0tWI0PJZaz5PrzR0
         ugAw==
X-Gm-Message-State: AOJu0YxbAyRfQFT2emeYYwUAhdZuwsZ+knqknjzvrPUFGSgErkId4mJK
	RCYnw+wA85C5lSanm+lJZQSCpEAEBlSiGGAW+q0uY3nWZIbBSxcG33jr0EkLmA==
X-Gm-Gg: ATEYQzwocGuhTA92WxrNyH0JeiRznHxtC7/yj8Uv1NkYlvnzkCRjbHmgp1k74XC/MHQ
	iQRMicvQ1/qAhvBdGdWfPv78NwodzxFueL6MgK1sE1Kec+6yjoVqbXW5+eSNEWIPUockqPKyAhA
	j/km8q7Sn0laNokFGfzOqAVlOX/UKGAJ9UOVTmVB0UOUT1O1GrQ91ecP1U5QNDW092yV5OwYQbT
	s7m1q79njVvw/HNOJZKHwhYS7pTUPcxbApnPBDavM3U0OrC4NdgwTz5TcCyOHsP1KiGjnPBLDdh
	H8VxFxKgiwPdc4xrRZMo/eypPsK1klgyApqaLHvlxYiqij33Kq3K5edd//Ao1iGs0Vd1jbFN68G
	q1FwhAh33Ckbe0bVFX19L6BJd/jF0ih6wvUu+28RnZYpQh07h+hBC0RNFTbhryjz7ckDEWAV1LJ
	/13fC2qAqUZD8sWx9ic02s/3MKxpg=
X-Received: by 2002:a05:6820:1903:b0:67d:e90f:99d1 with SMTP id 006d021491bc7-67e18764916mr8368942eaf.66.1774951376395;
        Tue, 31 Mar 2026 03:02:56 -0700 (PDT)
Received: from [127.0.0.1] ([52.242.243.103])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e2d510bd0sm4795320eaf.8.2026.03.31.03.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:02:55 -0700 (PDT)
Message-Id: <pull.2259.git.git.1774951373588.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 10:02:53 +0000
Subject: [PATCH] cache-tree: use index state repository in trace2 calls
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

From: Jayesh Daga <jayeshdaga99@gmail.com>

trace2 calls in cache-tree.c use the global 'the_repository',
even though cache_tree_update() has access to an explicit
repository pointer via 'istate->repo'.

Using the global repository can result in incorrect trace2
output when multiple repository instances are in use, as
events may be attributed to the wrong repository.

Use 'istate->repo' in cache_tree_update() to ensure correct
repository attribution.

Other call sites are left unchanged as they do not have
access to a repository instance.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
    cache-tree: use index state repository in trace2 calls
    
    trace2 calls in cache-tree.c use the global 'the_repository', even
    though cache_tree_update() has access to an explicit repository pointer
    via 'istate->repo'.
    
    Using the global repository can result in incorrect trace2 output when
    multiple repository instances are in use, as events may be attributed to
    the wrong repository.
    
    Use 'istate->repo' instead in these call sites to ensure correct
    repository attribution.
    
    Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com
    
    cc :Karthik Nayak karthik.188@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2259%2Fjayesh0104%2Fcache-tree-trace2-repo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2259/jayesh0104/cache-tree-trace2-repo-v1
Pull-Request: https://github.com/git/git/pull/2259

 cache-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 60bcc07c3b..e4f9174c4a 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -488,12 +488,12 @@ int cache_tree_update(struct index_state *istate, int flags)
 		prefetch_cache_entries(istate, must_check_existence);
 
 	trace_performance_enter();
-	trace2_region_enter("cache_tree", "update", the_repository);
+	trace2_region_enter("cache_tree", "update", istate->repo);
 	transaction = odb_transaction_begin(the_repository->objects);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
 	odb_transaction_commit(transaction);
-	trace2_region_leave("cache_tree", "update", the_repository);
+	trace2_region_leave("cache_tree", "update", istate->repo);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
 		return i;

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
gitgitgadget
