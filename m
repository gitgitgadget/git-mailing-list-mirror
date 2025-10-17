Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7782566D9
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731569; cv=none; b=aoouz5KJJbdvIyDIcqUNnbYy7LR1Dvk7VciT68UkU2jdb5q5hSoazYUvYR0Eu7RqlSj4zw1ZRMzfn+S+bdztiXToJjX5oa24tj6CTWjsteHkZhGx0p2Q0J5/IrQM9vN4WCPQ7wv48b42dErTE+xK/0R9ge4DH91vvKNb+RCYmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731569; c=relaxed/simple;
	bh=/BvgyRJX63GYDC3Ij4Vugqaqn2Nhwr6ceu1t9hbijJk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mEu2iOlQOWiNnaygsnSh/H7omWvpxHk8Rx5a7ODwAdKU36aWdpAWP6lLpJV8oDuJ47w7h+OOyd8PxRE7Hl+yNq4JuKbJOP6aWlJlDU9DllX32yA33F/CnOQdw1VCx7D9lUvcs/pfY6cGK4nU5v2p+zSl2gMEK6uzajDH+3/AMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFO3Sn+h; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFO3Sn+h"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso1634956a12.0
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731564; x=1761336364; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoKt0M9gAHFGW3IJnRFhDO3sqpKnAr8VcNm/yi2Dc1k=;
        b=WFO3Sn+hmVMcS6XL8/p59cPcz/OGxpRvuG0pN/C7lmNuo+ZDfYwR4wZ4JlQ1jYOR+s
         dHpEwhFBSfL+neGGSqE5KUfSYHHjMGT78lSxuuuluM6+FDpACbPDaQalSVfvGP+qHxfg
         HHm6Rw83h/Y9b5k3gQP0347D/2BRp2T1NsJEfXVEJABwUfFdd4tKq/ZhlScT64VDk59L
         qkdFunyYwbVw8G2DG624691ssEBR1Icnu02ubB07iyaf8m5Ykdqlkaj2pOc6yw9WJ4NJ
         VqRbzLrbk9EE8BTZjBXCT0F/3HrkBJqUgCTuzc71EuXhtV7/V3TsYAZXYlqkzwOPRhmW
         bE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731564; x=1761336364;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoKt0M9gAHFGW3IJnRFhDO3sqpKnAr8VcNm/yi2Dc1k=;
        b=n7fEGX12zT/slLP6oBM4SGsrBIb7plTUiwjSy6xQ9Gx78Nno3+IE/YWrs8hAU5ZtDh
         7s+ECtgg9EHDN7DeE7QJ43wbvXjtxTPbHBSB5WPuwm+Gh2YJpc9kfvcgdwNAy/JgNMvO
         2rymtZzEyiN9uCNAUvBY49mJe9hIPZ2GEDkPYD1HPGRlkPX5jyfGMD9k43dRXbX6ungV
         KUgZ8BzitNjB6hr99AbmXoPMa4ERv8+MdnacKRFRuyX+QVHNUP7e8BwAWHOqLG2Tu2kF
         rUn9xE/duU+Ne4ey3+hlX/bKMK+QCgosQmHws58g8EVtehbdI2iV2dS4eJI4aMMwaeHo
         RRlw==
X-Gm-Message-State: AOJu0YwyWcRFJpiwNnWL/jfHXnpCD9t8a8BsgtjleqjvD/z946KF98Yl
	+GSV0JSQKOGzRdHkidWNPGCOkV+iX8Go5jcB6LY92AeRWh5rJsPIoc0kOGEmWn7d
X-Gm-Gg: ASbGncsN8OxDTfl3P2viA0hi8cj66/nL4aXUt0zR4bJD/EBSsFHqG/s0BXQ6+CWxA5e
	xk3WteQELsxpIgb6jBgWP4qt8iDfD1sPgSUxOa1FVaz6rLahDS5iEa+fUOctMBybsRLQFlLnGT7
	qFzD5WPovzui0ixvDRrAWEhKe6FjC78B+F+NoAF7f68g5WjP0m4WnCTV/yRbLaG+xVfOlTkxptd
	RMJ30n+iJ2oOH2LQHmQjqOfDC4tT9VD9QLB82ZlIzM1DWLnmTGPfZgx9HIdRQbF+7jjnSLIBmuK
	2bAivyS6njmf5C2pbm+oSUA1kT1+/1yZYusXJ5534IteCNoO7mIRvIUbdcFJAHhJHC8efFMTOwZ
	TG0ZKeEEJQZZOXCeC5ZA+0/5XpbI57MD18DsK3ziSelg9rN6ObRHVaCHCFVWnt0BG+kOyvqn0D0
	55aDfeBB7Oh95w+krDPt1vUSE=
X-Google-Smtp-Source: AGHT+IFRZ4lGpOcS5iWtTzEUswm6M2aa5o9wbN4HjwxfW4MGY9pRnDbF9sqjaNrl0/2h1p55gT89yg==
X-Received: by 2002:a17:902:e544:b0:26b:5346:5857 with SMTP id d9443c01a7336-290c9cd4b82mr55092105ad.24.1760731563883;
        Fri, 17 Oct 2025 13:06:03 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.129.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247219457sm3484595ad.113.2025.10.17.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:06:03 -0700 (PDT)
Message-Id: <597ea0f5ce24967974358e18603265b14322ba54.1760731558.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 20:05:57 +0000
Subject: [PATCH 3/4] doc: git-reset: clarify `git reset [mode]`
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

From user feedback, there was some confusion about the differences
between the modes, including:

1. Sometimes it says "index" and sometimes "index file".
   Fix by replacing "index file" with "index".
2. Many comments about not being able to understand what `--merge` does.
   Fix by mentioning `git merge --abort` since my best guess is that
   most folks want to use that instead of `git reset --merge`.
3. Issues telling the difference between --soft and --mixed, as well as
   --keep. Leave --keep alone because I couldn't understand its use case,
   but change `--soft` / `--mixed` / `--hard` as follows:

--mixed is the default, so put it first.

Describe --soft/--mixed/--hard with the following structure:

* Start by saying what happens to the files in the working directory,
  because the thing users want to avoid most is irretrievably losing
  changes to their working directory files.
* Then describe what happens to the staging area. Right now it seems to
  frame leaving the index alone as being a sort of neutral action.
  I think this is part of what's confusing users, because in Git when
  you update HEAD, Git almost always updates the index to match HEAD.
  So leaving the index unchanged while updating HEAD is actually quite
  unusual, and it deserves to be flagged.
* Finally, give an example for --soft to explain a common use case.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-reset.adoc | 42 +++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 876187dc83..fa4bb2b551 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -24,42 +24,44 @@ However, when you specify files or directories or pass `--patch`,
 files without updating HEAD.
 
 `git reset [<mode>] [<commit>]`::
-	This form resets the current branch head to _<commit>_ and
-	possibly updates the index (resetting it to the tree of _<commit>_) and
-	the working tree depending on _<mode>_. Before the operation, `ORIG_HEAD`
-	is set to the tip of the current branch. If _<mode>_ is omitted,
-	defaults to `--mixed`. The _<mode>_ must be one of the following:
+	Set the current branch head (`HEAD`) to point at _<commit>_.
+	Depending on _<mode>_, also update the working directory and/or index
+	to match the contents of _<commit>_.
+	_<commit>_ defaults to `HEAD`.
+	Before the operation, `ORIG_HEAD` is set to the tip of the current branch.
++
+The _<mode>_ must be one of the following (default `--mixed`):
 +
---
-`--soft`::
-	Does not touch the index file or the working tree at all (but
-	resets the head to _<commit>_, just like all modes do). This leaves
-	all your changed files "Changes to be committed", as `git status`
-	would put it.
 
+--
 `--mixed`::
-	Resets the index but not the working tree (i.e., the changed files
-	are preserved but not marked for commit) and reports what has not
-	been updated. This is the default action.
+	Leaves your working directory unchanged.
+	Updates the index to match the new HEAD, so nothing will be staged.
 +
 If `-N` is specified, removed paths are marked as intent-to-add (see
 linkgit:git-add[1]).
 
+`--soft`::
+	Leaves your working directory unchanged. The index is left unchanged,
+	so everything in your current commit will be staged.
+	For example, if you have no staged changes, you can use
+	`git reset --soft HEAD~5; git commit`
+	to combine the last 5 commits into 1 commit.
+
 `--hard`::
-	Resets the index and working tree. Any changes to tracked files in the
-	working tree since _<commit>_ are discarded.  Any untracked files or
-	directories in the way of writing any tracked files are simply deleted.
+	Overwrites all files and directories with the version from _<commit>_,
+	and may overwrite untracked files.
+	Updates the index to match the new HEAD, so nothing will be staged.
 
 `--merge`::
+	Mainly exists for backwards compatibility: `git merge --abort` is the
+	usual way to abort a merge. See linkgit:git-merge[1] for the differences.
 	Resets the index and updates the files in the working tree that are
 	different between _<commit>_ and `HEAD`, but keeps those which are
 	different between the index and working tree (i.e. which have changes
 	which have not been added).
 	If a file that is different between _<commit>_ and the index has
 	unstaged changes, reset is aborted.
-+
-In other words, `--merge` does something like a `git read-tree -u -m <commit>`,
-but carries forward unmerged index entries.
 
 `--keep`::
 	Resets index entries and updates files in the working tree that are
-- 
gitgitgadget

