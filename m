Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC42E5D31
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276757; cv=none; b=c94d1sI4qGPl97qigsArThO0Wb5WakVTidE/qR5C7Xp4Cus8XwqfMGhpN6NzTD/38vzq48KKux9g+fazkTIBJ/scmNSK4PEjWWJihgd+XXEGrQOUUWO7KkN9t912xWGrbCBprvayqjHHTB/HvwcnL1WwaMrQfVFEErp+jC5KUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276757; c=relaxed/simple;
	bh=za/ukFKQGqA36EPz1/OuDEbzJFgoW9BziIJMv34+xwI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XZbnPUiPVfrs6yauz2nxQgOjlWd4HEJEK2uxLo0EP6id5SSU5k0hkGfENveB8flCKDkEQMUh6uGBRsyEgcaoq3H8CGY+aiwHhSWamcguZEsj/2s9Y6wGJS3eWpAMZlvtFLz4BA9PMLR/8bhb2KP33e+Hjf3NnsQ3ST4diq1gSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUafU3yK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUafU3yK"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so10907655e9.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755276754; x=1755881554; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxMO6H2NhV3OshelcB7U0Qq9bv/miJ2JN23nmRaw7LI=;
        b=BUafU3yKwb0WjeQEa8vJg1tkb6o9UW7iLbqoWS3wYtzWtsqACIybeE0s9JuhYMrxII
         FvNu5Ltmbx4m2JoHFnH/NfMz7BJ46fUdaoYDWlHRrkcTcURshfv/adJMkOXEQeIxaiac
         6JLVCyElP1Jej6ON7sZKEXW59lSDoP5FQE3ahrR1mi8Nuciy8OpHzgVM8mBj9j5VVgFy
         iIaDhsFqsCxPK39PMLQKLwttdf70/TRGrVK4p7/WI7WXxPUGQ7w1HVxdNkTw5eQanj2f
         1lNvPXSg6UYaVDWwnP1m+cm7GrNQiX+Tb7IVrRvUSyKz9vg8nzoZmDqwXebWfw9miRon
         3t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276754; x=1755881554;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxMO6H2NhV3OshelcB7U0Qq9bv/miJ2JN23nmRaw7LI=;
        b=elYxUTh5rzkZ9OZWJltkZIsiRkLyAhYk8vMguR7avDp3Y+CqJHJUGt5ZJLR6ABHWUW
         SyIzdc8b2s8W8Lh7cHKsKY6UCVuVvmocz11UgXPzyDxg/qixym6NJcXiTFnMF+Ms1EOo
         SQifgJ0hpyVACz9zQCO+7lDN9WkAhA7+0LvmzI8cv/HmrwPPTxMgV6t/qLWh6w7+lhJg
         80iHdeCvd3pZQ0IQJfUbGbJkvXneozIotSXmJXbcmyyqFTh7g+PLVGoSYMaLuENO4VeH
         w8ofH0ykg1/eF7a5NyaW6LKyuxwYbJzFN96oF21/flfYjg+8NCCUNvynYSRo1oedzJON
         VaCg==
X-Gm-Message-State: AOJu0YyrMT0aAQ34YkOSINK+AeU0MLnTDGafseuzDFTy3QujNiaSR3+p
	hkRVbeAKtVRiuOiXC1d5crBJ7uTbNr+Sa1pZGDZpahd91IABfFuQyHvwrVeyGw==
X-Gm-Gg: ASbGncvBcMwhQjgm3590n0kNcWxxjzGVn3PD3qdYZT2Xv87X83e12GscCMiyAyFiFrp
	HpoMyXC1NP834U/zEZPRF2lh0KyRsC5ZJFl2SUm/4WDWwX3PzW2NNi7ElZPFBceYp+9eYOO9HQX
	vewc/agsia75VRhZbeGs3N8A+raLe41BpteL+aO/hGIx0zZjwe7ZDlArkzhWxBseXO/p79uUUo1
	YTf13SzUmwPNBVUa8I7PP0wJGotQ9T5OYqPwUjlYmSEQut1Y5KoMGRp2nlBD8b9OD/Lcxv2A9o3
	He4m1tik17Sji14mFUYX66KI/Rkmnst+RdUIbGh7O65W2f6WCopJ2+VpfxviHmMxIHaEVtrnKlN
	IXLOGhBgvGbMPxdEcSqRhHiw=
X-Google-Smtp-Source: AGHT+IG16kJ7RjehzV2BgWCBnD6oO/rN3VLDDqeZwBLasgLX5Ib401YiAtop9saW0QLHRpT0UxypkQ==
X-Received: by 2002:a05:600c:4f4d:b0:459:d709:e5cf with SMTP id 5b1f17b1804b1-45a217dfff0mr30057295e9.3.1755276754079;
        Fri, 15 Aug 2025 09:52:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a23323c56sm11723055e9.9.2025.08.15.09.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:52:33 -0700 (PDT)
Message-Id: <ad63f69918df0130b6b0236d04e27f8529115cd4.1755276751.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
	<pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 16:52:27 +0000
Subject: [PATCH v8 2/5] doc: git rebase: dedup merge conflict discussion
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

