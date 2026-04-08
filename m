Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292935DA52
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668139; cv=none; b=MydgUPgseYUiZro4DWVCaCQe16X4VhM7J97+hl066ArkJy0/Cw0y1QLc9M0lh6ht6qERMXEckaWJKo4khnAacQLt0XJkT/kdIxeHVpkLlqkIw3mpPNxltIprDQmoKyVH7+EQrmyRM2X1QLXmh0cv4w9A3ojAoAmrlJsapqFOpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668139; c=relaxed/simple;
	bh=BIA5IalMgqLlWaj6r4m1b75sLiDiQ6GgsfaveXIfygk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XX8SKsofy+3FpbOpBOIDHiJMZpqwi3a68gOkQM/WngEasLMuAHGRZv8u2p6hGKCGGbgtjMLq/Vk2He0qWSW0l1/j3gbjzIQgEDDLzobkE60sMKB3Mzihe6witD8LbbdCmsLjMfGPV7RtTwQRpZwzim1aapBb21G5BJD/tYqy8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJykcI5X; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJykcI5X"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c1a131946so722592a91.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775668137; x=1776272937; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YON3BBlxaZm7pF3jMVtqOhIHgm6+XmeNbpBlVDfVHPc=;
        b=EJykcI5XtTcmL/ZX/cBvQQbJSAzeUbDc3++GfGlKPPHBcXb259syWCpRx+tpahfFuP
         ynxxY0fHgtW+UTTMGkemH2g64QX7uC3fOLNsaS08HIoF0NKHSBz5VXWf+7IvIwD+/une
         pSJVohlk7GRMm6GRzC8BDa3jifzicXEreqCEIAWXDmHzxOtX75dYcTRc7OR1MhkQv4+g
         Xg+kOSCAxnNAW2tkD62BxAKFkExKxHHtm0swZIQIFpjtMx8ARx24T81l5uh158IJGQNB
         xu2+JT2nkBBBcN49Xh+3txJMLCSEb1crQQOUNYdqWMy+6QHZ2pRYLDV9OOYQotCG8cCy
         /1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668137; x=1776272937;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YON3BBlxaZm7pF3jMVtqOhIHgm6+XmeNbpBlVDfVHPc=;
        b=Nhpg8x27NzRsfbPnxHDdygjdzaF+HNpL5jgQ2lJM8QaPpTc1MAVElHZM+SaafTIG/F
         JEFwQbultXJpkp3Hbz7Ci3mbEhAKReGaxULA035Ahe52jPFn0sOa26+TrKrYsNfXojPs
         HSf6uyasZnse2gL/WnAJRpNNusJTyTD4D8YkXawx/Xr9IsmFCSFttjHLPNbJ7oql1Zg0
         stnY8b7zu01+p6p6+c0kSyqWyyrxB5IRj92vZZ6z0dEITqWMfigivKAWw/xSdCXKBMpK
         aaQgpTpIfSMIB6mGhTx0OiAHFtfBnyYd7e+unjQlIEhaaxRFwds75VxlozDpt8tBeWQg
         v4HQ==
X-Gm-Message-State: AOJu0YzUs+Fm+BuAdaR1EhcH524g7VaKIwKgRwiuRjQnuM1JjeLXNiKt
	t1Wngdb9L6SdmRIazfUWCcZxvO1fOD5CdaaSJTWIq/WBoPUzlCeMOpd9+tr2uw==
X-Gm-Gg: AeBDieuYJWqJXCbTbwRk/EGgkbadSeBv95eAE5yR71PGIEbULDHAjEOq82ONBKeYWRJ
	PK+gLpTwz3IdyakNAG66egGz3We8wG80YDITxFFtC7RUvcTZVGRbBWxi+qJob10+/tgT2LqVebQ
	b9f5uhNLe2Q6HVoZsDV/wGdPheVaSSfqnNwxLEQwprPR7khl2bAvPLHG5ijzCKK4s75yMz1d2fQ
	OlqTrGA8VSRVQca36LKM1DBve8fC8GOjxIG/0K/raCtDWoJ28TkYXADozDh+ZPUgyRW/OXBA15i
	ITXad5WXYnJi64QJ7X5IFUIYUbdkvkYMj8lABVkLYYCnKBPnqXztfxYagvv7G4Yq2rLyc5m+WxT
	D0aShASJTTtWi2g6oD2Ae/9sE1fLkyg4r0AR7A+GxoHXGn6TOVJbHVCBuy2veHSgUq+CTGKW1g0
	jwQnNQ5ujQf94fMjJxItRLTgTK
X-Received: by 2002:a05:693c:2d91:b0:2d2:d5a3:e97c with SMTP id 5a478bee46e88-2d40fce99ccmr116733eec.12.1775668136496;
        Wed, 08 Apr 2026 10:08:56 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.55])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d1b152f3adsm7602357eec.20.2026.04.08.10.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:08:55 -0700 (PDT)
Message-Id: <pull.2264.v2.git.git.1775668134796.gitgitgadget@gmail.com>
In-Reply-To: <pull.2264.git.git.1775150062407.gitgitgadget@gmail.com>
References: <pull.2264.git.git.1775150062407.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 17:08:54 +0000
Subject: [PATCH v2] repo: add paths.toplevel to repo info
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

From: Jayesh Daga <jayeshdaga99@gmail.com>

repo info currently does not expose the repository's
working tree root, even though this information is
available via `repo_get_work_tree()` and
`git rev-parse --show-toplevel`.

Add a new field `paths.toplevel` to expose this value.

While doing so, document the correspondence between
`git rev-parse` options and `repo info` fields to make
it easier to identify missing or future additions.

For bare repositories, this value is empty, consistent
with other non-applicable fields.

Signed-off-by: Jayesh Daga [jayeshdaga99@gmail.com](mailto:jayeshdaga99@gmail.com)
---
    repo: add paths.toplevel to repo info
    
    repo info currently does not expose the repository's working tree root,
    even though this information is available via repo_get_work_tree().
    
    This makes it harder for scripts to retrieve the repository root through
    a structured interface, often requiring the use of git rev-parse
    --show-toplevel.
    
    Add a new field paths.toplevel to git repo info that returns the working
    tree root. For bare repositories, this value is empty, consistent with
    other non-applicable fields.
    
    This provides a consistent and script-friendly way to query repository
    paths without invoking additional commands.
    
    Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2264%2Fjayesh0104%2Frepo-toplevel-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2264/jayesh0104/repo-toplevel-v2
Pull-Request: https://github.com/git/git/pull/2264

Range-diff vs v1:

 1:  448dfae6a1 ! 1:  05e34bfe2c repo: add paths.toplevel to repo info
     @@ Metadata
       ## Commit message ##
          repo: add paths.toplevel to repo info
      
     -    Expose the working tree root via `git repo info` as
     -    paths.toplevel, matching the semantics of
     +    repo info currently does not expose the repository's
     +    working tree root, even though this information is
     +    available via `repo_get_work_tree()` and
          `git rev-parse --show-toplevel`.
      
     +    Add a new field `paths.toplevel` to expose this value.
     +
     +    While doing so, document the correspondence between
     +    `git rev-parse` options and `repo info` fields to make
     +    it easier to identify missing or future additions.
     +
          For bare repositories, this value is empty, consistent
          with other non-applicable fields.
      
     -    This allows scripts to retrieve the repository root
     -    through a structured interface without invoking
     -    rev-parse.
     -
     -    Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
     +    Signed-off-by: Jayesh Daga [jayeshdaga99@gmail.com](mailto:jayeshdaga99@gmail.com)
      
       ## builtin/repo.c ##
      @@ builtin/repo.c: static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)


 builtin/repo.c       | 12 ++++++++++++
 t/t1900-repo-info.sh | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index 71a5c1c29c..d0491f6c66 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -62,6 +62,17 @@ static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
 	return 0;
 }
 
+static int get_paths_toplevel(struct repository *repo, struct strbuf *buf)
+{
+    const char *wt = repo_get_work_tree(repo);
+
+    if (!wt)
+	return -1; /* match existing error style */
+
+    strbuf_addstr(buf, wt);
+    return 0;
+}
+
 static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -87,6 +98,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "paths.toplevel", get_paths_toplevel },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 39bb77dda0..470e06e8c2 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -155,4 +155,20 @@ test_expect_success 'git repo info -h shows only repo info usage' '
 	test_grep ! "git repo structure" actual
 '
 
+test_expect_success 'repo info paths.toplevel' '
+    git repo info paths.toplevel >actual &&
+    echo "paths.toplevel=$(git rev-parse --show-toplevel)" >expected &&
+    test_cmp expected actual
+'
+
+test_expect_success 'repo info paths.toplevel (bare repo)' '
+    git init --bare bare.git &&
+    (
+	cd bare.git &&
+	git repo info paths.toplevel >actual &&
+	echo "paths.toplevel=" >expected &&
+	test_cmp expected actual
+    )
+'
+
 test_done

base-commit: 256554692df0685b45e60778b08802b720880c50
-- 
gitgitgadget
