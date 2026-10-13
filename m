Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D8435E1D5
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896495; cv=none; b=IpHz9S/sujMjozAEqpPraVMkE9FNsJpkwlnv6GhORzXY8QnTL548a2/iFcN9wDm3U0zvd7yUCseeCpyefSABoGqZTOGMb/iSFtBf25tZ2kN5ds+v+I/DuubifwOCjomzxPEhaKffpDzHM4jbc3jtrHKTDLRd84uxZVT+2eyAEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896495; c=relaxed/simple;
	bh=UZkbK9kis5gwL0ooiXK0R4Fiw2nbWyDBw7L6PV2yJbk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FY+8a5jfLH51VpK/4y5a92I0c2dhtb92zfK8gZtZ/91DJDM1/uyxc9ROaw7sPQuAd8u0hk13xVfUO0uwpewxe1cAt8UcCz9R7gkD1EVTVYeVC5i+Ec+QFJpkVhp6FkjKXL3FcifBGbd8j6vY9zrPbDnTbhx6Yj16GcPmq95poGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW5kWpu6; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW5kWpu6"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5e4d95e3e55so1011197e0c.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791896492; x=1792501292; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3agKGslgNzLLvd6jzWa3u/Rtrip/keB7rHxsIi3K8OM=;
        b=OW5kWpu6NMi/CBZWvgoYGCPlntoAmWEOS6Cc2V0bs8n3pmjfqAS9oK1FqJkYufdAhM
         o3uZG+mq6LWEk0Yepc6p7cPER35utNgm9YXRpd29NvM33sD127eGMCFcbtEu7zWWkojX
         16JCRa1s9YjUaS6Axg6eL41nHj9cguJmWA9vxAlYAXEpMy8CK8fqP4ZFkwJNDb3AjY5l
         XMqN/do+z0qxy1/ixtGSvWbiYsMUrLJBmQ4WqEaSbO7ysd8iZFcSIoc+PfPzDZvIhOP2
         zqyevHv9Ek7En/9oro4xEVfChAyPyeQPBuhJTh0vlojyEOAZXKiSz1WpNzKRREHrNgUK
         PPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896492; x=1792501292;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3agKGslgNzLLvd6jzWa3u/Rtrip/keB7rHxsIi3K8OM=;
        b=1XMh3YpWMTieh7MtV0PiTeM+oOMObwJXaq+L7eavtHJDy+0S9/BNz3unNirJ5hoXDu
         aS1W4gRStX5JSTS55MZ9lfwiIYE3uTnqwKJ/2nMuzJATkG8ou1PL6AdVjbJheOkUcQ+R
         glX9m/wKb1mvHRbYcuiYWkXE58N8YTRVn351CcSIkJru0M7pWATzXlez+WOmxgOPa/pl
         3NXOBqUnBdGuxB8Dk3CgsUxbATQR5qKd+2k1n77KMIDEMdINsilNV+Ib3st3WE+AYnyg
         mqtlEsnhPeWqwxRj3GSKKaa8EqdthuAheEIDWwF9eAGmOglJRnbspyUbsF/USIE20j9o
         VKvg==
X-Gm-Message-State: AFq9FYIMOacF3zOMhzahTbYCfgt7Wb4IUgFtXa3DU29y9kaV8ol9udrh
	0jvN2ARC7Iw1uZDvhuHhYMNPoi8BNRyhQ0qaA6VSHbDtN+SCXmRQstHS+2LhGQ==
X-Gm-Gg: AYBFou0zG3Zx9WIzSelm8ZFSIVVAzoI4c3IdjSdstIJc92oewS7ISkLFg9Y/YNolnOR
	NUjd9HgTFn85+K39x9rypaSvPqH/UVO0/dmB+CqXMo4O+78oPojoYsKVteKZOnMckLza5AAeKR3
	/usMGbejviGmnlTX3E/NDxB01g+FqoJIi95vq74HtgmSeGOQPdjmHIXph5iBNFemToxLTpSFmvo
	411iAB9XPNkl27LDFZRTT32nZyQU7VfHT40nVfMRoIDg77VWEqX18cFRandjEV9WNxu2vJCYXmP
	x8yozOotsZkTaQ2ep709r4qP8sIxGMRnPA/ekrQoRaBPk3xj0YgCZC5HwYRWd+N32yTzPkBstY6
	H9nZX9SsNAQJQxY7dzkAelEpA/zXkc18RWbztbFiZy3A0kZiIWCG6YAV4U1eWY+y5NEg39u/b7s
	x3KCx9IPEUBGYFactN5j1Uw63CobWQdQ7tnV2dzweWa27rlCTzPcQ6O2rBW3h6Bvh8YT4jZTlN0
	IGY
X-Received: by 2002:a05:6122:469f:b0:5da:9b81:1aa4 with SMTP id 71dfb90a1353d-5e91f436139mr3152913e0c.5.1791896487548;
        Tue, 13 Oct 2026 06:01:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.191.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97c39482sm24532796d6.45.2026.10.13.06.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:01:26 -0700 (PDT)
Message-Id: <pull.2250.v2.git.1791896486100.gitgitgadget@gmail.com>
In-Reply-To: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Oct 2026 13:01:26 +0000
Subject: [PATCH v2] doc: checkout: rewrite detached HEAD state explanation
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

The current explanation has the following issues:

- Says detached HEAD state is useful but doesn't explain why
- Takes many paragraphs before explaining what detached HEAD state is
- It's common for users to accidentally end up in detached HEAD state,
  but it doesn't explain why that might happen
- One of the UI improvements in `git switch` is to make it harder
  to detach accidentally, but that isn't advertised.
  See 7968bef06b (switch: only allow explicit detached HEAD, 2019-03-29)
- Too many confusing diagrams

Write a new explanation addressing these issues, and put it in a
standalone guide so that we can easily reference it from advice
("see `git help detachedhead`").
The result is a shorter guide that covers more material.

The framing that "Git considers commits that aren't on a branch/other
reference to be garbage" is taken from Steve Klabnik's tutorial
https://steveklabnik.github.io/jujutsu-tutorial/branching-merging-and-conflicts/anonymous-branches.html.
It's funny and it's consistent with the way Git uses the term
"garbage collection".

Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: checkout: rewrite detached HEAD state explanation
    
    This is a pretty quick rewrite where we didn't get any user feedback. If
    we really want to make sure it's clear to users as possible, we should
    IMO do a second stage later where we ask users which parts are unclear.
    
    Changes in v2:
    
     * Make the meson.build and Makefile changes (thanks to Kristoffer)
     * Rename to gitdata-model (thanks to Kristoffer)
     * Mention commits will be deleted after 90 days to make it seem less
       scary (thanks to Kristoffer)
     * Add an "easily" qualifier to "it lets you look at an old version of
       your code", to avoid implying that this is the only way (thanks to
       Junio)
     * Mention that Git will warn you when switching branches if you're
       leaving commits behind (thanks to Junio)
     * Remove "unintentionally" (thanks to Junio)
     * Mention git help datamodel (thanks to Junio)
    
    Left the style comments alone (ideas for how to make it more clear) to
    be potentially addressed in v3, after we finalize the information
    content.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2250%2Fjvns%2Fdetached-head-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2250/jvns/detached-head-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2250

Range-diff vs v1:

 1:  efe0f9db36 ! 1:  83139be46f doc: checkout: rewrite detached HEAD state explanation
     @@ Commit message
          Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     + ## Documentation/Makefile ##
     +@@ Documentation/Makefile: MAN7_TXT += gitcore-tutorial.adoc
     + MAN7_TXT += gitcredentials.adoc
     + MAN7_TXT += gitcvs-migration.adoc
     + MAN7_TXT += gitdatamodel.adoc
     ++MAN7_TXT += gitdetached-head.adoc
     + MAN7_TXT += gitdiffcore.adoc
     + MAN7_TXT += giteveryday.adoc
     + MAN7_TXT += gitfaq.adoc
     +
       ## Documentation/detached-head.adoc (new) ##
      @@
      +`HEAD` is where Git stores your current branch. `HEAD` can either be:
     @@ Documentation/detached-head.adoc (new)
      +   This is called "detached HEAD state".
      +
      +It can sometimes be useful for `HEAD` to be a commit ID.
     -+For example, it lets you look at an old version of your code
     -+(with `git checkout COMMIT_ID`).
     ++For example, it lets you easily look at an old version of your code
     ++(with `git checkout COMMIT_ID` or `git switch --detach COMMIT_ID`).
      +
      +The only problem is that if you create new commits while in detached
      +HEAD state, those commits won't be on a branch. This makes those new
      +commits much harder to find later. Also, Git considers commits that
      +aren't on any branch (or a tag or other reference) to be garbage.
      +Git will eventually permanently delete those "garbage" commits during
     -+garbage collection.
     ++garbage collection. Those commits will be deleted after 90 days by
     ++default, see linkgit:git-gc[1] for more.
      +
     -+There are 3 main ways you can end up in detached HEAD state
     -+unintentionally:
     ++There are 3 main ways you can end up in detached HEAD state:
      +
      +1. `git checkout COMMIT_ID`, where `COMMIT_ID` is a commit ID
      +2. `git checkout v1.3`, where v1.3 is a tag name
     @@ Documentation/detached-head.adoc (new)
      +   You might want to do this if you've created new commits, so that you can
      +   find the commit later and so that it won't be garbage collected.
      +
     -+If you create commits in detached HEAD state that aren't on a branch,
     -+you can find them later using linkgit:git-reflog[1].
     ++If you switch branches after making commits in detached HEAD state, Git
     ++will warn you that you might be about to "lose" those commits and print
     ++out the commit ID. You can also always find those commits later using
     ++linkgit:git-reflog[1].
     ++
     ++Here's what that warning looks like:
     ++
     ++-------------------------
     ++Warning: you are leaving 1 commit behind, not connected to
     ++any of your branches:
     ++
     ++  48c09f6 3
     ++-------------------------
     ++
     ++For a more in-depth explanation of how `HEAD` works in Git,
     ++see linkgit:gitdatamodel[7] (`git help datamodel`).
      
       ## Documentation/git-checkout.adoc ##
      @@ Documentation/git-checkout.adoc: For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
     @@ Documentation/git-checkout.adoc: For more details, see the 'pathspec' entry in l
       [[ARGUMENT_DISAMBIGUATION]]
       ARGUMENT DISAMBIGUATION
      
     - ## Documentation/gitdetachedhead.adoc (new) ##
     + ## Documentation/gitdetached-head.adoc (new) ##
      @@
     -+gitdetachedhead(7)
     -+===============
     ++gitdetached-head(7)
     ++===================
      +
      +NAME
      +----
     -+gitdetachedhead - How detached HEAD state works
     ++gitdetached-head - How detached HEAD state works
      +
      +DESCRIPTION
      +-----------
     @@ Documentation/gitdetachedhead.adoc (new)
      +---
      +Part of the linkgit:git[1] suite
      
     + ## Documentation/meson.build ##
     +@@ Documentation/meson.build: manpages = {
     +   'gitcredentials.adoc' : 7,
     +   'gitcvs-migration.adoc' : 7,
     +   'gitdatamodel.adoc' : 7,
     ++  'gitdetached-head.adoc' : 7,
     +   'gitdiffcore.adoc' : 7,
     +   'giteveryday.adoc' : 7,
     +   'gitfaq.adoc' : 7,
     +
       ## advice.c ##
      @@ advice.c: void detach_advice(const char *new_name)
       	"\n"
     @@ command-list.txt: gitcore-tutorial                        guide
       gitcredentials                          guide
       gitcvs-migration                        guide
       gitdatamodel                            guide
     -+gitdetachedhead                         guide
     ++gitdetached-head                         guide
       gitdiffcore                             guide
       giteveryday                             guide
       gitfaq                                  guide


 Documentation/Makefile              |   1 +
 Documentation/detached-head.adoc    |  57 ++++++++++++
 Documentation/git-checkout.adoc     | 129 +---------------------------
 Documentation/gitdetached-head.adoc |  14 +++
 Documentation/meson.build           |   1 +
 advice.c                            |   1 +
 command-list.txt                    |   1 +
 7 files changed, 76 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/detached-head.adoc
 create mode 100644 Documentation/gitdetached-head.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b395..5892f48b06 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -54,6 +54,7 @@ MAN7_TXT += gitcore-tutorial.adoc
 MAN7_TXT += gitcredentials.adoc
 MAN7_TXT += gitcvs-migration.adoc
 MAN7_TXT += gitdatamodel.adoc
+MAN7_TXT += gitdetached-head.adoc
 MAN7_TXT += gitdiffcore.adoc
 MAN7_TXT += giteveryday.adoc
 MAN7_TXT += gitfaq.adoc
diff --git a/Documentation/detached-head.adoc b/Documentation/detached-head.adoc
new file mode 100644
index 0000000000..712074c0ef
--- /dev/null
+++ b/Documentation/detached-head.adoc
@@ -0,0 +1,57 @@
+`HEAD` is where Git stores your current branch. `HEAD` can either be:
+
+1. A branch, which is your current branch.
+2. A commit ID, when you don't have a current branch.
+   This is called "detached HEAD state".
+
+It can sometimes be useful for `HEAD` to be a commit ID.
+For example, it lets you easily look at an old version of your code
+(with `git checkout COMMIT_ID` or `git switch --detach COMMIT_ID`).
+
+The only problem is that if you create new commits while in detached
+HEAD state, those commits won't be on a branch. This makes those new
+commits much harder to find later. Also, Git considers commits that
+aren't on any branch (or a tag or other reference) to be garbage.
+Git will eventually permanently delete those "garbage" commits during
+garbage collection. Those commits will be deleted after 90 days by
+default, see linkgit:git-gc[1] for more.
+
+There are 3 main ways you can end up in detached HEAD state:
+
+1. `git checkout COMMIT_ID`, where `COMMIT_ID` is a commit ID
+2. `git checkout v1.3`, where v1.3 is a tag name
+3. `git checkout origin/main`, where `origin/main` is
+   a remote-tracking branch
+
+Checking out a tag puts you in detached HEAD state because `HEAD` can
+only be a branch or a commit, not a tag or any other reference.
+So `git checkout TAG` will set HEAD to the commit for that tag.
+
+The easiest way to avoid accidentally ending up in detached HEAD state
+is to use linkgit:git-switch[1] instead of linkgit:git-checkout[1] to
+switch branches. `git switch` won't let you detach unless you explicitly
+pass the `--detach` argument.
+
+To get back onto a branch, you can:
+
+1. Switch to the branch you want to be on, with `git switch BRANCHNAME`.
+2. Create a new branch at the current commit, with `git switch -c BRANCHNAME`.
+   You might want to do this if you've created new commits, so that you can
+   find the commit later and so that it won't be garbage collected.
+
+If you switch branches after making commits in detached HEAD state, Git
+will warn you that you might be about to "lose" those commits and print
+out the commit ID. You can also always find those commits later using
+linkgit:git-reflog[1].
+
+Here's what that warning looks like:
+
+-------------------------
+Warning: you are leaving 1 commit behind, not connected to
+any of your branches:
+
+  48c09f6 3
+-------------------------
+
+For a more in-depth explanation of how `HEAD` works in Git,
+see linkgit:gitdatamodel[7] (`git help datamodel`).
diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 2aefea0228..4e9e94e24d 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -376,135 +376,8 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 [[DETACHED_HEAD]]
 DETACHED HEAD
 -------------
-`HEAD` normally refers to a named branch (e.g. `master`). Meanwhile, each
-branch refers to a specific commit. Let's look at a repo with three
-commits, one of them tagged, and with branch `master` checked out:
 
-------------
-           HEAD (refers to branch 'master')
-            |
-            v
-a---b---c  branch 'master' (refers to commit 'c')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-When a commit is created in this state, the branch is updated to refer to
-the new commit. Specifically, `git commit` creates a new commit `d`, whose
-parent is commit `c`, and then updates branch `master` to refer to new
-commit `d`. `HEAD` still refers to branch `master` and so indirectly now refers
-to commit `d`:
-
-------------
-$ edit; git add; git commit
-
-               HEAD (refers to branch 'master')
-                |
-                v
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-It is sometimes useful to be able to checkout a commit that is not at
-the tip of any named branch, or even to create a new commit that is not
-referenced by a named branch. Let's look at what happens when we
-checkout commit `b` (here we show two ways this may be done):
-
-------------
-$ git checkout v2.0  # or
-$ git checkout master^^
-
-   HEAD (refers to commit 'b')
-    |
-    v
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-Notice that regardless of which checkout command we use, `HEAD` now refers
-directly to commit `b`. This is known as being in detached `HEAD` state.
-It means simply that `HEAD` refers to a specific commit, as opposed to
-referring to a named branch. Let's see what happens when we create a commit:
-
-------------
-$ edit; git add; git commit
-
-     HEAD (refers to commit 'e')
-      |
-      v
-      e
-     /
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-There is now a new commit `e`, but it is referenced only by `HEAD`. We can
-of course add yet another commit in this state:
-
-------------
-$ edit; git add; git commit
-
-	 HEAD (refers to commit 'f')
-	  |
-	  v
-      e---f
-     /
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-In fact, we can perform all the normal Git operations. But, let's look
-at what happens when we then checkout `master`:
-
-------------
-$ git checkout master
-
-               HEAD (refers to branch 'master')
-      e---f     |
-     /          v
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-It is important to realize that at this point nothing refers to commit
-`f`. Eventually commit `f` (and by extension commit `e`) will be deleted
-by the routine Git garbage collection process, unless we create a reference
-before that happens. If we have not yet moved away from commit `f`,
-any of these will create a reference to it:
-
-------------
-$ git checkout -b foo  # or "git switch -c foo"  <1>
-$ git branch foo                                 <2>
-$ git tag foo                                    <3>
-------------
-<1> creates a new branch `foo`, which refers to commit `f`, and then
-    updates `HEAD` to refer to branch `foo`. In other words, we'll no longer
-    be in detached `HEAD` state after this command.
-<2> similarly creates a new branch `foo`, which refers to commit `f`,
-    but leaves `HEAD` detached.
-<3> creates a new tag `foo`, which refers to commit `f`,
-    leaving `HEAD` detached.
-
-If we have moved away from commit `f`, then we must first recover its object
-name (typically by using git reflog), and then we can create a reference to
-it. For example, to see the last two commits to which `HEAD` referred, we
-can use either of these commands:
-
-------------
-$ git reflog -2 HEAD # or
-$ git log -g -2 HEAD
-------------
+include::detached-head.adoc[]
 
 [[ARGUMENT_DISAMBIGUATION]]
 ARGUMENT DISAMBIGUATION
diff --git a/Documentation/gitdetached-head.adoc b/Documentation/gitdetached-head.adoc
new file mode 100644
index 0000000000..a477060db2
--- /dev/null
+++ b/Documentation/gitdetached-head.adoc
@@ -0,0 +1,14 @@
+gitdetached-head(7)
+===================
+
+NAME
+----
+gitdetached-head - How detached HEAD state works
+
+DESCRIPTION
+-----------
+include::detached-head.adoc[]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index cfa9c67609..6b3141647f 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -197,6 +197,7 @@ manpages = {
   'gitcredentials.adoc' : 7,
   'gitcvs-migration.adoc' : 7,
   'gitdatamodel.adoc' : 7,
+  'gitdetached-head.adoc' : 7,
   'gitdiffcore.adoc' : 7,
   'giteveryday.adoc' : 7,
   'gitfaq.adoc' : 7,
diff --git a/advice.c b/advice.c
index 401d047391..43f86c2eaf 100644
--- a/advice.c
+++ b/advice.c
@@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
 	"\n"
 	"  git switch -\n"
 	"\n"
+	"Run `git help detachedhead` to learn more.\n"
 	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
 
 	fprintf(stderr, fmt, new_name);
diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c9..922a1dbd84 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -218,6 +218,7 @@ gitcore-tutorial                        guide
 gitcredentials                          guide
 gitcvs-migration                        guide
 gitdatamodel                            guide
+gitdetached-head                         guide
 gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide

base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90
-- 
gitgitgadget
