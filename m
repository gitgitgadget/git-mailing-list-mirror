Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1B3D393
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923846; cv=none; b=GZlLaJJxTGjx/TxwS3F/ER15J20tXshbE9SQoDhzzUwkIs84InRCoPeS4ZyvNUR3dLVeDZnNCCZe3uQsncXWrKM4apUAk/0BnwynJC8HCZSsNRg6WelDK2uY+pdv2s5YVDtK0PFI2gR2KNb8GhA/0vRiMTutypYLNshwrYwicoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923846; c=relaxed/simple;
	bh=eJre5Hygid85NlKbxHbeId4BaergKiPt0Wu/xJH0RR0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=o+F32d3o4RZ+yrpEyyrU/LFfoz5HskGfbeADd9qdNFZWejJboTwlc9oPcol2CA1/i51+2EMCWd4z6JfuspsjXAAVO+Xdhyy8VDsvjkt9y+YPtPtZ5WejTQUfVY+LnUHY2P2HVO7LpaRI9w/VaalxL/LYGqs/9CXa5oWfZt1s+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhlcIpcl; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhlcIpcl"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8b194341eso7179581fa.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712923843; x=1713528643; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iE/5aCsVQ867L9biHbRJmyQ01xmIAQhyp9xWShihnME=;
        b=jhlcIpclEkQptEM79QvX5ki9RD/2TQCQfpEeIVfm5AlDqFmcwYBpdhZ2WI4dDW77oQ
         lPNO9UkSwQr67oFeHMQntkY/tCAkDG0/qnU4Co2rXLXj1kw/RBn7PGH7PWBAWUvtZH2u
         38uYS2cRfh5L0FBH5VDNuAgAHIHgN+gGZt/Ou/JtIQG40jBXwuP0aPgfneBdfyRDjppD
         p2lhrfWdRCJn4TiTvjRt8/mcumFCXGfqn82d3ALSRsosNsVVuyyhT8G2ZTkrvSeb/SJ6
         SJZ5kL928r0ISIDhm/mou0NdO/TZLaInr0mwC0RQeLTD5TuRXljJ2Ttzfw1offGHfKDT
         INDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712923843; x=1713528643;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iE/5aCsVQ867L9biHbRJmyQ01xmIAQhyp9xWShihnME=;
        b=cCMUDFekc1ST8k3gZGdSBu5L8UFf2REBHAwqOaRjLmDeJHUnfG23fSNIPPW89Okn0i
         7UWc17COuHhHFSFXisq9XJWnogGcnp1vuAz5q6r/EFwWgnrLmNO4jkTtu7Kp8LdiUsFY
         aVQzLVc7FQbQBbqP62znpDccd6jLkX1qQk79CMVjvnSFKru59f6kI/GLlH8hpZQeQWeX
         7yOzOxCJ1MArDckt2UT8jP0XEJwcQLnxWXy7LWhkpd792QAXrUlVsYxje4brAjgDSWi9
         V81R3yNrnJRy43wuY/7DMMoUPcrrFVBj2kGWR9RuMAfgy5AMyLcv3d+WJYyDji7sahQI
         fLZg==
X-Gm-Message-State: AOJu0YyiZS6Jk08n6IhMnIu+D7n+ewEe2ReS4a1VrC6hcr40UDBlPe93
	UHkEBPCETjnqHJaExoQpl4PxubrZNN0mlDL3v+2PG8uvdkJhbFewFTHHyg==
X-Google-Smtp-Source: AGHT+IHenSGl794+2EvKBpePViNzL6nwLjGzjWE9FTQE8K8V31u0/Dr3D1xe5M5thcnR1VYiO/Hh8Q==
X-Received: by 2002:a05:651c:508:b0:2d8:1946:3025 with SMTP id o8-20020a05651c050800b002d819463025mr1524425ljp.22.1712923842474;
        Fri, 12 Apr 2024 05:10:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b00417319c802asm8222448wmg.10.2024.04.12.05.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 05:10:41 -0700 (PDT)
Message-Id: <pull.1717.git.1712923841235.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Apr 2024 12:10:40 +0000
Subject: [PATCH] merge-tree: fix argument type of the `--merge-base` option
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 5f43cf5b2e4 (merge-tree: accept 3 trees as arguments, 2024-01-28), I
taught `git merge-tree` to perform three-way merges on trees. This
commit even changed the manual page to state that the `--merge-base`
option takes a tree-ish rather than requiring a commit.

But I forgot to adjust the in-program help text. This patch fixes that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    merge-tree: adjust argument type of the --merge-base option

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1717%2Fdscho%2Fmerge-tree-document-merge-base-treeish-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1717/dscho/merge-tree-document-merge-base-treeish-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1717

 builtin/merge-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 3492a575a6c..60eaf0ca9f1 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -563,7 +563,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NONEG),
 		OPT_STRING(0, "merge-base",
 			   &merge_base,
-			   N_("commit"),
+			   N_("tree-ish"),
 			   N_("specify a merge-base for the merge")),
 		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
 			N_("option for selected merge strategy")),

base-commit: 342990c7aaef5ac645e89101cb84569caf64baf4
-- 
gitgitgadget
