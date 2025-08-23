Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EAE35972
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909790; cv=none; b=ps3gs3H2JN23kCOBehaNfEgaG/P6Y24azCbvjS3uU3BPaltD04KiqJbOFuvTExZwTrCUdj+SE407cxlUeSz5tD/UIAaxPtPV51in0YjR23Ap/c/isVbAGVK+MN0t0r4G/CIRL+ldhMUWI+4xbQrLeX+By4YE8uucG3/ksjI5SIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909790; c=relaxed/simple;
	bh=za/ukFKQGqA36EPz1/OuDEbzJFgoW9BziIJMv34+xwI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rp+me/ucrN3R9uIPEI4uK7c3UQ0hl7syonTiRpwzkJhxHxNewKO9P0RzPHnA62+gbUZDEZP1xRrbqKCJ+aXzo+gZ0EAfCv+P1wyqR5FwBgNemeGa/ABgW4lI4Tlf57vMo/ubjrCeidimgMWlKz4G9RhQwFBjjnboBjsCSkgNS5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR6kbA3i; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR6kbA3i"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9dc55d84bso2303391f8f.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755909786; x=1756514586; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxMO6H2NhV3OshelcB7U0Qq9bv/miJ2JN23nmRaw7LI=;
        b=GR6kbA3ixvgBHU74Ya6lMJZJ4lG67gQxpgruLHHWciH7cGNcGXN/lhhFjQnnLu4PGs
         LW0LklRE4d7ZiH4RhOM+HKv6pWXBfh+oeZhW/31OCHeoD0AUgvwLJNJ6BqvFhWebk0g9
         CEIaYKJ3cBDzK+kBWvTR3HZP4Pplk0H88G0IL1crnWF/nOuR2NBYKNjkzddPRpZcX8yB
         /h/OHq41FMcqxjSpBIzgFPuB9Etgdh4zq5gh1LYRjsJ5iGHZj+jFmZZvS8CS5eCTrp+h
         0t4pklp4nkyp7Z/KAe5Pb29vTbwUbgiTvOMvTKWmzV44IQCSDIQqO2E5A8c1MTkEAwae
         Xs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909786; x=1756514586;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxMO6H2NhV3OshelcB7U0Qq9bv/miJ2JN23nmRaw7LI=;
        b=Xv1fXxsw/sexTjCeC/Mc8QMTwnMtpfQfOF2Zuuu6jIVLEITyCDHEDNL8Z+hfV0Xits
         pEb2UNhXQqeN5tUx1MCAdj/TJGOdrP/080BaEwGeNr/+2Jhjl487bdbTL7EuHqn3zgf/
         FE2qIm0K9yVt0qwHINR29jZuGfNvMKV2JTvSiKq17BoUVvhODvujzebQJjEfB71HAzAs
         uoR/CgvdH7UgOFdsjHumahJlST8e9Teiw9BPLP1V2hbVpeauFIV0AwaXqpXW3u98gk7r
         A3tefIFf26zQOIqppwRVpOWlHNyc1oxmTBXKfqz9hkR5idTS9dKk7MisMU32marYw8kH
         5y4Q==
X-Gm-Message-State: AOJu0YwUo4/JIoTvCNdOHCdYM+jDlA8AtWV1u1EKyHBiXUh29nFNQHNC
	kpbGeQsRnlaL5SaBl75/KmwbwU7f89iKp3N+eGB4RKpMwdtXoIWyVY/8wKubJA==
X-Gm-Gg: ASbGnctOePiLtlLEN4ndcfSyemitb/1sZcSbDbXMYBkA9+jDkTEYoCOCZj8SBjD3VgH
	RXfn3mT+ssoa8T8Mpr7wnFroXbYvHMCFXec3VkjHjn+HZDxGNvYbi1rV9WxeUx+O9FAgiwdh+he
	LvPoj+Vxt0+qbD8wAHPwgf3xtGjnkkC5RqEHa9M0Ihe77QCFvln677utTBx+YKZGfk+ktdpN5ph
	VKx+o7gv2/S2AqkgCS4JDHVahn3zmsH57jSJ22t+oOzZB/noDtUNKf7dNQaVSdv6OJCE3tsekPi
	iqhtOFEm+0Do//Km4fnk9pr1NnING/3kv9AQUzN6yCKBu8wXYPl86w2CN02OHgVqILLNn9vEaVe
	6Du1SorNAaZkF2PglzzuHkn+nTRI=
X-Google-Smtp-Source: AGHT+IH/ZdkL21oltxTzy5LyutQUbbD+mgBxpGUfCJtYYXVu0oXDHKIFY7PfpeNBIqrEw44F6Di1gA==
X-Received: by 2002:a05:6000:25c7:b0:3b7:8832:fdcc with SMTP id ffacd0b85a97d-3c5dcdfd72emr3632026f8f.38.1755909786229;
        Fri, 22 Aug 2025 17:43:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711abd15asm1414559f8f.56.2025.08.22.17.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 17:43:05 -0700 (PDT)
Message-Id: <339b7a1bc5be0fe3fd56c03c49e4c578d04c33d0.1755909782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
References: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
	<pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 00:42:59 +0000
Subject: [PATCH v9 2/5] doc: git rebase: dedup merge conflict discussion
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Previously there were two explanations, this combines them both into a
single explanation.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 49 ++++++++++++++---------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index bb5a3ff7f828..e82ceb9cbfce 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -42,6 +42,26 @@ shortcut for `git checkout topic && git rebase master`.
 ------------
 
 
+If there is a merge conflict during this process, `git rebase` will stop at the
+first problematic commit and leave conflict markers. If this happens, you can do
+one of these things:
+
+1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
+   and make edits to resolve the conflict. For each file you edit, you need to
+   tell Git that the conflict has been resolved. You can mark the conflict as
+   resolved with  `git add <filename>`. After resolving all of the conflicts,
+   you can continue the rebasing process with
+
+   git rebase --continue
+
+2. Stop the `git rebase` and return your branch to its original state with
+
+   git rebase --abort
+
+3. Skip the commit that caused the merge conflict with
+
+   git rebase --skip
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -77,13 +97,6 @@ any commits in `HEAD` which introduce the same textual changes as a commit
 in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
 with a different commit message or timestamp will be skipped).
 
-It is possible that a merge failure will prevent this process from being
-completely automatic.  You will have to resolve any such merge failure
-and run `git rebase --continue`.  Another option is to bypass the commit
-that caused the merge failure with `git rebase --skip`.  To check out the
-original `<branch>` and remove the `.git/rebase-apply` working files, use
-the command `git rebase --abort` instead.
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
@@ -186,28 +199,6 @@ This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to `--onto` and the `<upstream>`
 parameter can be any valid commit-ish.
 
-In case of conflict, `git rebase` will stop at the first problematic commit
-and leave conflict markers in the tree.  You can use `git diff` to locate
-the markers (<<<<<<) and make edits to resolve the conflict.  For each
-file you edit, you need to tell Git that the conflict has been resolved,
-typically this would be done with
-
-
-    git add <filename>
-
-
-After resolving the conflict manually and updating the index with the
-desired resolution, you can continue the rebasing process with
-
-
-    git rebase --continue
-
-
-Alternatively, you can undo the 'git rebase' with
-
-
-    git rebase --abort
-
 MODE OPTIONS
 ------------
 
-- 
gitgitgadget

