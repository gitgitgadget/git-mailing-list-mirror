Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2510224B04
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680532; cv=none; b=nXuRL57CpxV+Sk76VHydc5STxaMRHFni/9t+A8u8g1u4iYcMlA0YFPvSkkg/ZWX1sThS7a0vlg8vWR9bhiiNqfXaqAF4+l0285Gl6b2wV/hASib8wgxpS4R39W0Mcm5PmEQcrKQbFr90OPycnyvlazAPGPO4fCFtVZdqftbOwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680532; c=relaxed/simple;
	bh=xl+dV4iFV8i4mxBtmm9C26PjL7rbvJkzoJHhCBigYys=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=micwaNyECK0gKoR9PE/8febRCnsmUAeNtF2sOZAd1iUjSt4O+saKNtfKxKJbOrJt9IWEFFU0mpmJSnr1ftGVO4n1Te9AHQSn7Olsa04e70kGn820XkbCqAuHr4fdBUv2eTBq6RsiRu5UFNo23OzkjZbvkgrgq2jmtCdWCwQppEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVTehrBO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVTehrBO"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7886bee77so1911369f8f.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754680529; x=1755285329; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXHDoiIK5bO+424aEKX0ocmutw7x0EOE1OCtaoqUbDk=;
        b=NVTehrBOhEilerXqIBdteNp1byOvBwONyaxWoMXaW3CX6EhtzIQOIffk4m/MSbsm8B
         tMeOMGdVJ5BLhoYxce/wGcLRpiSQ7yghL0c+3JzCjeV1q7qweCVD4z9JhLca/9RWfZD8
         L7ULbOZ29x+GGQaABykoor2BAflQF+yZEibDHfaqUXAjHA0WCzb+CdGYlOUdmuA1JJKT
         LCX3iRiCucgCxfql6srMK6/hmqWixangO996JzeQjfeXoz/jCRZMfdAogwJfU3RYanbC
         G5SV/yKz6SzRu1uniQeNthPPMaM9v8x8Furib1L5af+sz0iZmj2oi7fcJcepjj1v4DGQ
         rttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754680529; x=1755285329;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXHDoiIK5bO+424aEKX0ocmutw7x0EOE1OCtaoqUbDk=;
        b=bgzcNzOG+a4Ocvco7hl4uExnp/tjizKAl4xMtEuwENCFG4fTZfV+s3JHQ3flA/dqiZ
         F6m3LGpDJi41rYiKaqAKyocDby9c9XzmZEghsKS2yjgqRmQeulPczSxmnexkmFgVWQuK
         OQ5/DH2SpGi1eR0FNCXac3YCByS4VISVkcENcIiFxEiMd/0NZtWmB43zsHsAlpWCg7/R
         0qfl0FellmISPgXDTBRoPn4IaD+uHRmkgM1tdI3MgZNC7xcJZ9YD/WtaBtRbps6QxEoT
         WJVMLJCBH/UUwAkMGgsEjxhFIR/TX+6KsxTZAeFhf1+TlGEL25NQnhsIN0EZMzZVy6DS
         tkGQ==
X-Gm-Message-State: AOJu0YzQlz3l3TPcDe4FkAKQC8stKwWAbDOS1svzvqOCTCWEwtTLh1nD
	v2PZXj6ByZdrYExhETuxGT2cQgUfddsfeP36Ax7meEDR0DzHUwtfpwJxLWOBaA==
X-Gm-Gg: ASbGncvt+Dv8Yr/ivkQ9OjTjEYvLZ3zSCVvE/PW8+GkusdiP6aCOyAaOSwBtd8KQwCo
	i2QjASP3lwukYcNQIxAImhM32VA6Wa+JqaOZjbxQ3qI2Gx33Eyr3hkNJ+e7TgqwEAVOlR6UkFJy
	QoJi4DTyI1yj1AGav6B1eQx0p85kkAAbrZ4ZkSaqPKD4w6VNPErrXr1UOj49LcT1NojvMvaLeel
	765qM5YExxr6v7f2jsfe6s1Sc3O6wYWBdKMAn44N8wrvsRgG75Lw78M6FGOXuRCEYtuHoDr+tHJ
	d9EpknU4gh0SZibR9BcTARszi7ejGalrBBaN17d3SzebiAGnOTTZT+7AQ+J/fzaxIdcduWZc3/X
	RSnEKB2hHopijGO1kiuDfUHA=
X-Google-Smtp-Source: AGHT+IHj8lc3ofh3ItyBgBc2qKte3qmE8nKKiYSCABgTY7ot6loxRTGuI3SZf0PJvBIcd///H1YxYw==
X-Received: by 2002:a05:6000:18a9:b0:3b7:e3c3:fbb6 with SMTP id ffacd0b85a97d-3b900b7b012mr3497228f8f.31.1754680528655;
        Fri, 08 Aug 2025 12:15:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459ebede65asm100650085e9.8.2025.08.08.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:15:28 -0700 (PDT)
Message-Id: <249a5127904f2d73119f3b60d70a57fe84d1b4ad.1754680525.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 19:15:22 +0000
Subject: [PATCH v2 2/5] doc: git rebase: dedup merge conflict discussion
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Previously there were two explanations, this combines them both into a
single explanation.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 50 +++++++++++++++--------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6dacf693bd71..a93c616f38b1 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -39,6 +39,27 @@ short-cut for `git switch topic && git rebase master`.
     D---E---F---G master
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
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -74,13 +95,6 @@ any commits in `HEAD` which introduce the same textual changes as a commit
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
@@ -183,28 +197,6 @@ This is useful if F and G were flawed in some way, or should not be
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

