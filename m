Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F531990B7
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204837; cv=none; b=b6me3BEDp/7EBNB9JXGDO5Sm0tfFuTt0WA7ysdxr3+YsGL64QFMNZpGorFY5ILUMihbQhXA+g88IxUIPfkrTFnpXZRuxIVDS6zc9/G62u6MM6qp4S5EiSllkAt49N7lrCo/gQTXQYu9buemPMhLZ/LX0AUoMGHHaV7Co2UjnfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204837; c=relaxed/simple;
	bh=W76J3At6puqSrS8fNDMps6s1SFPX/i5s+AxDL4iLN58=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=EFJ6UYHxAMTXBjDCN5xWG/1bl0UUI5eePdMuHFpfunS1vwFgDZ7rFxOE3FbRqqXAtUNlPc2oiJghDGmWBo96KZvCMCK2DB0WOHDWdARGqyhBeb0FQvZVtFxmXlOTcirosT4VoRMjWECi71ogNzgYhJKLo0FXg7FQLOAMpRp8/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jifUFjJW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jifUFjJW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-44a57d08bbfso12255115e9.2
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748204833; x=1748809633; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+R9NDdidNAvjAFkLaZ1UVE+X4ma4wLIqgyoga6mvV4g=;
        b=jifUFjJWRStZPrMqsSlIiXR3QzrX8WZ05TQCbh5Pip7t7G+lQuZGQ+w6hKYECMkEac
         HKyREkqcNQnr7uZf/GiEiTBkIwg+6fchMQWCvU6qMPGg8ri87cDm5AzJrK2J+I/GstXx
         HrgEfjHWuKpGVU07GpFLIz7fsFCH+GxPJhbmoxT1OYgccR/xpLMEAzImv+i/ie5UBcrE
         ysvZRWMd5Rba09RWsgEwzbheUWwK8toZgIPXuxPZdcf8GQMCXnPcEBRtmrwttiJqxuN2
         MPqZkEmBMjnMWUkWquWtfprcLsV+oDIPoG4xMuzg7h97GH4gJnyKYWL8J+7+MFh0KSLG
         dwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748204833; x=1748809633;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+R9NDdidNAvjAFkLaZ1UVE+X4ma4wLIqgyoga6mvV4g=;
        b=UWfwAai2QC0AAVg9zj6Awbvc+ryzkcPIOQZ3MTLOxL4m8r5DPtyIP4bDapClgiEYRM
         Lh/f1uGg1X/i2LFSivTiB6dOv5cQfAqT/I+5rv+s37uqPXefRUtHermtGIt4D36Pwwbg
         /Wxz6IFlyRhXwF5xjG6hXfY230302Q/SdyYmXSKgxU0gXrSNSCqND/e7kWC9XB1xpGEx
         u3flIbn6gnUgy58qN+ggRpoKdt8kdvg1PtO3N0xHvYKSGA++dq5RY1QD8AYaZJ+zVJ9T
         zUwAjjAGTtTxqFJ9lZKwER7pcShDIFjxE38akKVN6aU4uADbTp4qgrb5I5VuQr3AX6LC
         jaUQ==
X-Gm-Message-State: AOJu0Yxlvi6Mzx1JIN0KPHdk8DyJfAWPPcP9TD63IcCMM1kcQfCSPqCz
	9aEZEfYSVJB+W/ECbsXgPhjoIyHpbTDmLD/2z1s4s0SMvmBU6cUKNLDiTZkQpw==
X-Gm-Gg: ASbGnctEbpXltRW3iiJwPggP6nKXTzmDhLPsh8j7kywCKyuUpsSn/zbzfnSaYXeEMw0
	Cfz+U7HJNYuWIawp0L6sU9AhGoyIhZA41CHCEL9CFi4FkZVneM6Oc7gMaCTFdMlBaovSTtVtN9q
	3Th9NiIJOjx3St02T5sJElLGrNljAiYO1/gUYA4r8XEwUdkBz8LzuamwO2OpHNu+o8vuxfyHwhd
	qgE0/Dy40+aXXHVQfjiCfXL1vwjD705jO0Tev4PofkiB7tJ39lm02smM9Qh426hy/tTduDDxrO1
	iJgcpQwPoyoedVxHXQsVJab4Qp/m7oJnUq8a46o9Mfs0qR0xkY0nlH93ijy97RA=
X-Google-Smtp-Source: AGHT+IHcNYmqjq8azMyuN04lt5oOep/Pcn1Zo6Q1qv7IZnriDQUhJm6DdXndj7Ueo3luVdVoUvgoUg==
X-Received: by 2002:a05:600c:3d8e:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-44c95aada01mr59964905e9.30.1748204832798;
        Sun, 25 May 2025 13:27:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d4aa2sm220989445e9.21.2025.05.25.13.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:27:11 -0700 (PDT)
Message-Id: <577da2bbaa6af0dcbc0c7bf67768a7af66d421ee.1748204829.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
References: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 20:27:02 +0000
Subject: [PATCH 2/9] doc: convert git-merge manpage to new style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

In order to avoid breaking the format on '<<<<<<' and '>>>>>' lines
by applying the synopsis rules to these spans, they are formatted using '+'
signs instead of '`' signs.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-merge.adoc | 51 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
index 64281d6d44dd..12aa859d16de 100644
--- a/Documentation/git-merge.adoc
+++ b/Documentation/git-merge.adoc
@@ -8,13 +8,13 @@ git-merge - Join two or more development histories together
 
 SYNOPSIS
 --------
-[verse]
-'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
+[synopsis]
+git merge [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>]
 	[--into-name <branch>] [<commit>...]
-'git merge' (--continue | --abort | --quit)
+git merge (--continue | --abort | --quit)
 
 DESCRIPTION
 -----------
@@ -57,7 +57,7 @@ merge started (and especially if those changes were further modified
 after the merge was started), `git merge --abort` will in some cases be
 unable to reconstruct the original (pre-merge) changes. Therefore:
 
-*Warning*: Running `git merge` with non-trivial uncommitted changes is
+WARNING: Running `git merge` with non-trivial uncommitted changes is
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
@@ -67,7 +67,7 @@ OPTIONS
 
 include::merge-options.adoc[]
 
--m <msg>::
+`-m <msg>`::
 	Set the commit message to be used for the merge commit (in
 	case one is created).
 +
@@ -78,13 +78,13 @@ The `git fmt-merge-msg` command can be
 used to give a good default for automated `git merge`
 invocations. The automated message can include the branch description.
 
---into-name <branch>::
+`--into-name <branch>`::
 	Prepare the default merge message as if merging to the branch
-	`<branch>`, instead of the name of the real branch to which
+	_<branch>_, instead of the name of the real branch to which
 	the merge is made.
 
--F <file>::
---file=<file>::
+`-F <file>`::
+`--file=<file>`::
 	Read the commit message to be used for the merge commit (in
 	case one is created).
 +
@@ -93,12 +93,12 @@ will be appended to the specified message.
 
 include::rerere-options.adoc[]
 
---overwrite-ignore::
---no-overwrite-ignore::
+`--overwrite-ignore`::
+`--no-overwrite-ignore`::
 	Silently overwrite ignored files from the merge result. This
 	is the default behavior. Use `--no-overwrite-ignore` to abort.
 
---abort::
+`--abort`::
 	Abort the current conflict resolution process, and
 	try to reconstruct the pre-merge state. If an autostash entry is
 	present, apply it to the worktree.
@@ -114,17 +114,17 @@ which case `git merge --abort` applies the stash entry to the worktree
 whereas `git reset --merge` will save the stashed changes in the stash
 list.
 
---quit::
+`--quit`::
 	Forget about the current merge in progress. Leave the index
 	and the working tree as-is. If `MERGE_AUTOSTASH` is present, the
 	stash entry will be saved to the stash list.
 
---continue::
+`--continue`::
 	After a `git merge` stops due to conflicts you can conclude the
 	merge by running `git merge --continue` (see "HOW TO RESOLVE
 	CONFLICTS" section below).
 
-<commit>...::
+`<commit>...`::
 	Commits, usually other branch heads, to merge into our branch.
 	Specifying more than one commit will create a merge with
 	more than two parents (affectionately called an Octopus merge).
@@ -152,7 +152,7 @@ To avoid recording unrelated changes in the merge commit,
 `git pull` and `git merge` will also abort if there are any changes
 registered in the index relative to the `HEAD` commit.  (Special
 narrow exceptions to this rule may exist depending on which merge
-strategy is in use, but generally, the index must match HEAD.)
+strategy is in use, but generally, the index must match `HEAD`.)
 
 If all named commits are already ancestors of `HEAD`, `git merge`
 will exit early with the message "Already up to date."
@@ -195,11 +195,11 @@ happens:
    stage 2 from `HEAD`, and stage 3 from `MERGE_HEAD` (you
    can inspect the stages with `git ls-files -u`).  The working
    tree files contain the result of the merge operation; i.e. 3-way
-   merge results with familiar conflict markers `<<<` `===` `>>>`.
+   merge results with familiar conflict markers +<<<+ `===` +>>>+.
 5. A ref named `AUTO_MERGE` is written, pointing to a tree
    corresponding to the current content of the working tree (including
    conflict markers for textual conflicts).  Note that this ref is only
-   written when the 'ort' merge strategy is used (the default).
+   written when the `ort` merge strategy is used (the default).
 6. No other changes are made.  In particular, the local
    modifications you had before you started merge will stay the
    same and the index entries for them stay as they were,
@@ -231,7 +231,6 @@ git merge v1.2.3^0
 git merge --ff-only v1.2.3
 ----
 
-
 HOW CONFLICTS ARE PRESENTED
 ---------------------------
 
@@ -260,7 +259,7 @@ And here is another line that is cleanly resolved or unmodified.
 ------------
 
 The area where a pair of conflicting changes happened is marked with markers
-`<<<<<<<`, `=======`, and `>>>>>>>`.  The part before the `=======`
++<<<<<<<+, `=======`, and +>>>>>>>+.  The part before the `=======`
 is typically your side, and the part afterwards is typically their side.
 
 The default format does not show what the original said in the conflicting
@@ -270,7 +269,7 @@ side wants to say it is hard and you'd prefer to go shopping, while the
 other side wants to claim it is easy.
 
 An alternative style can be used by setting the `merge.conflictStyle`
-configuration variable to either "diff3" or "zdiff3".  In "diff3"
+configuration variable to either `diff3` or `zdiff3`.  In `diff3`
 style, the above conflict may look like this:
 
 ------------
@@ -290,7 +289,7 @@ Git makes conflict resolution easy.
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
-while in "zdiff3" style, it may look like this:
+while in `zdiff3` style, it may look like this:
 
 ------------
 Here are lines that are either unchanged from the common
@@ -308,8 +307,8 @@ Git makes conflict resolution easy.
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
-In addition to the `<<<<<<<`, `=======`, and `>>>>>>>` markers, it uses
-another `|||||||` marker that is followed by the original text.  You can
+In addition to the +<<<<<<<+, `=======`, and +>>>>>>>+ markers, it uses
+another +|||||||+ marker that is followed by the original text.  You can
 tell that the original just stated a fact, and your side simply gave in to
 that statement and gave up, while the other side tried to have a more
 positive attitude.  You can sometimes come up with a better resolution by
@@ -390,8 +389,8 @@ include::merge-strategies.adoc[]
 CONFIGURATION
 -------------
 
-branch.<name>.mergeOptions::
-	Sets default options for merging into branch <name>. The syntax and
+`branch.<name>.mergeOptions`::
+	Sets default options for merging into branch _<name>_. The syntax and
 	supported options are the same as those of `git merge`, but option
 	values containing whitespace characters are currently not supported.
 
-- 
gitgitgadget

