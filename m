Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AA48795
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBNittTY"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so782295e9.3
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 11:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703102069; x=1703706869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjKOOUCWMYNRIP9YSvopH/6T+mCMbmLYSJ4SxyinQQk=;
        b=WBNittTYi4jbEdUTqujQF0LBn3CrIyZfd7ZnDaH66oUIq94FzGmoDFHmM3645rddLs
         6AsfnWmHZM3aL9gjY1EMg/8FeTw4v7XT0R0t3pLD62yuxTgXfwtaekkCiU5U7aFIV+LB
         lJCWQz6m6Fv/tc/taJozK5uiDHGWbkFz/sXEM9LCj35JYAJ14md1pjM6oELHysypwsgY
         R4o/4ImuSwohdJvPs8zeUG3m0Vlc8siccbQNZrRmjNzEVaHC2++MsuO8diEPpkfiEwWF
         EESwLUBUYAubZCOSkzHhNFkWDhquJ0DeRREK1erVTIblRsPNJpKPAw9fo6/V4QUUbaXO
         6X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703102069; x=1703706869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjKOOUCWMYNRIP9YSvopH/6T+mCMbmLYSJ4SxyinQQk=;
        b=oBkuOSkUH9m6k0yl7LawN2FOzMUjA8gy+YeoLPbJ6ICNZacfK4B76V30b2ALQ7MoW8
         Sn+iNP5Z+DHGadLF10ToJkWj/wf3P9ipNtxq17RsRiown2ij8lpq4sE7wi3nOVaRPqxt
         Gd8w7GxeYFErkhIz8WsZwP+/hurQJmasZ0d3aOes1HA7Ar8APF/BkL0erJ/joGtmdUWf
         XmeJHy/oeY4ivlqNMXtqpZRJ1duB1WmZANuWCQGbHXSc16y5LBRDTUZugxT3LPzMkJAi
         ysUoskM6KrB7Sc6jJJugENjDjQwig+NJe+a6o2VpnWhfJ6eshexuG27S9+HihpJU6f3U
         TdYw==
X-Gm-Message-State: AOJu0YzShrSV3HVlC9x8PjlIBXOaYL9g8XR/DqUg09JiSujN7IVhlmPU
	h5mW9TPsuqrVfWz2SGrU9xs=
X-Google-Smtp-Source: AGHT+IEdcJ1wuDW0adGkdASsP3OAAXh4L34Ks1hMXkR+wW1hSYnidSgzOQazy7c4cnUMR4KMnoiAGw==
X-Received: by 2002:a05:600c:548e:b0:40b:5e21:c5b2 with SMTP id iv14-20020a05600c548e00b0040b5e21c5b2mr81811wmb.128.1703102068511;
        Wed, 20 Dec 2023 11:54:28 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-e5b0-3039-5d18-ec57.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:e5b0:3039:5d18:ec57])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b0040b2c195523sm8710001wms.31.2023.12.20.11.54.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 11:54:28 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: l.s.r@web.de,
	Elijah Newren <newren@gmail.com>,
	gitster@pobox.com
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH 2/2] Documentation/git-merge.txt: use backticks for command wrapping
Date: Wed, 20 Dec 2023 20:53:42 +0100
Message-Id: <20231220195342.17590-3-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
References: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As René found in the guidance from CodingGuidelines:

   Literal examples (e.g. use of command-line options, command names,
   branch names, URLs, pathnames (files and directories), configuration
   and environment variables) must be typeset in monospace (i.e. wrapped
   with backticks)

So all instances of single and double quotes for wraping said examples
were replaced with simple backticks.

Suggested-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---
 Documentation/git-merge.txt | 50 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 33ec5c6b19..7332f53f2f 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -20,12 +20,12 @@ DESCRIPTION
 -----------
 Incorporates changes from the named commits (since the time their
 histories diverged from the current branch) into the current
-branch.  This command is used by 'git pull' to incorporate changes
+branch.  This command is used by `git pull` to incorporate changes
 from another repository and can be used by hand to merge changes
 from one branch into another.
 
 Assume the following history exists and the current branch is
-"`master`":
+`master`:
 
 ------------
 	  A---B---C topic
@@ -33,7 +33,7 @@ Assume the following history exists and the current branch is
     D---E---F---G master
 ------------
 
-Then "`git merge topic`" will replay the changes made on the
+Then `git merge topic` will replay the changes made on the
 `topic` branch since it diverged from `master` (i.e., `E`) until
 its current commit (`C`) on top of `master`, and record the result
 in a new commit along with the names of the two parent commits and
@@ -57,7 +57,7 @@ merge started (and especially if those changes were further modified
 after the merge was started), `git merge --abort` will in some cases be
 unable to reconstruct the original (pre-merge) changes. Therefore:
 
-*Warning*: Running 'git merge' with non-trivial uncommitted changes is
+*Warning*: Running `git merge` with non-trivial uncommitted changes is
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
@@ -74,8 +74,8 @@ include::merge-options.txt[]
 If `--log` is specified, a shortlog of the commits being merged
 will be appended to the specified message.
 +
-The 'git fmt-merge-msg' command can be
-used to give a good default for automated 'git merge'
+The `git fmt-merge-msg` command can be
+used to give a good default for automated `git merge`
 invocations. The automated message can include the branch description.
 
 --into-name <branch>::
@@ -104,14 +104,14 @@ include::rerere-options.txt[]
 	present, apply it to the worktree.
 +
 If there were uncommitted worktree changes present when the merge
-started, 'git merge --abort' will in some cases be unable to
+started, `git merge --abort` will in some cases be unable to
 reconstruct these changes. It is therefore recommended to always
-commit or stash your changes before running 'git merge'.
+commit or stash your changes before running `git merge`.
 +
-'git merge --abort' is equivalent to 'git reset --merge' when
+`git merge --abort` is equivalent to `git reset --merge` when
 `MERGE_HEAD` is present unless `MERGE_AUTOSTASH` is also present in
-which case 'git merge --abort' applies the stash entry to the worktree
-whereas 'git reset --merge' will save the stashed changes in the stash
+which case `git merge --abort` applies the stash entry to the worktree
+whereas `git reset --merge` will save the stashed changes in the stash
 list.
 
 --quit::
@@ -120,8 +120,8 @@ list.
 	stash entry will be saved to the stash list.
 
 --continue::
-	After a 'git merge' stops due to conflicts you can conclude the
-	merge by running 'git merge --continue' (see "HOW TO RESOLVE
+	After a `git merge` stops due to conflicts you can conclude the
+	merge by running `git merge --continue` (see "HOW TO RESOLVE
 	CONFLICTS" section below).
 
 <commit>...::
@@ -144,25 +144,25 @@ PRE-MERGE CHECKS
 Before applying outside changes, you should get your own work in
 good shape and committed locally, so it will not be clobbered if
 there are conflicts.  See also linkgit:git-stash[1].
-'git pull' and 'git merge' will stop without doing anything when
-local uncommitted changes overlap with files that 'git pull'/'git
-merge' may need to update.
+`git pull` and `git merge` will stop without doing anything when
+local uncommitted changes overlap with files that `git pull`/`git
+merge` may need to update.
 
 To avoid recording unrelated changes in the merge commit,
-'git pull' and 'git merge' will also abort if there are any changes
+`git pull` and `git merge` will also abort if there are any changes
 registered in the index relative to the `HEAD` commit.  (Special
 narrow exceptions to this rule may exist depending on which merge
 strategy is in use, but generally, the index must match HEAD.)
 
-If all named commits are already ancestors of `HEAD`, 'git merge'
+If all named commits are already ancestors of `HEAD`, `git merge`
 will exit early with the message "Already up to date."
 
 FAST-FORWARD MERGE
 ------------------
 
 Often the current branch head is an ancestor of the named commit.
-This is the most common case especially when invoked from 'git
-pull': you are tracking an upstream repository, you have committed
+This is the most common case especially when invoked from `git
+pull`: you are tracking an upstream repository, you have committed
 no local changes, and now you want to update to a newer upstream
 revision.  In this case, a new commit is not needed to store the
 combined history; instead, the `HEAD` (along with the index) is
@@ -269,7 +269,7 @@ Barbie's remark on your side.  The only thing you can tell is that your
 side wants to say it is hard and you'd prefer to go shopping, while the
 other side wants to claim it is easy.
 
-An alternative style can be used by setting the "merge.conflictStyle"
+An alternative style can be used by setting the `merge.conflictStyle`
 configuration variable to either "diff3" or "zdiff3".  In "diff3"
 style, the above conflict may look like this:
 
@@ -328,10 +328,10 @@ After seeing a conflict, you can do two things:
 
  * Resolve the conflicts.  Git will mark the conflicts in
    the working tree.  Edit the files into shape and
-   'git add' them to the index.  Use 'git commit' or
-   'git merge --continue' to seal the deal. The latter command
+   `git add` them to the index.  Use `git commit` or
+   `git merge --continue` to seal the deal. The latter command
    checks whether there is a (interrupted) merge in progress
-   before calling 'git commit'.
+   before calling `git commit`.
 
 You can work through the conflict with a number of tools:
 
@@ -392,7 +392,7 @@ CONFIGURATION
 
 branch.<name>.mergeOptions::
 	Sets default options for merging into branch <name>. The syntax and
-	supported options are the same as those of 'git merge', but option
+	supported options are the same as those of `git merge`, but option
 	values containing whitespace characters are currently not supported.
 
 include::includes/cmd-config-section-rest.txt[]
-- 
2.39.3 (Apple Git-145)

