Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843184;
	b=XHViWltvAwSNqESc//csUgMQ527qdnoOP9b5P6Sfqu9G4B/aEXggwR0cWq2p4dC69Q4N
	 Twu0oXWn8D1o8a1+uo4ckh7ZdXlIYcH2P8cs5aVxPyYUuCqorn0xNv8QSjiRyWXRYAjkj
	 JBEaH06zbIq5Zyyi8jR8Ps2QKuvrOJfv4R2nZjpbsSCIiduJS3FcklByKk/f2nGa8U528
	 SGw6gPZMNrjgmx2NqGuMRxtoq9hzq8Z0N66YwJpRQLwB4F5o2Ri4+GBtKg8h0QCCdFIYH
	 P+lae2HfnKFhYHzW52aSFf5hP1PlDWkjjgk9U/vlX3lRUooFUhy0yZ9Lxw5n3OjzYCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=dJhAWQWEpmn4cHTP18xczeckoaQSQ9nDJ4djaXb/+SM=;
	b=vIb3OLEpWBhaExhFNp4NFoK72xMEsR3iZISAlwDAXqNzIwrInd14C0DeQqAA/KXH7tg3
	 w/GdxlFg/Eola1zensJWe0J6VobLFVCsl9WolgGDfWa0Nh9xRInTdSPFqpLmRT+zREYCf
	 XMB8g6PG285H4M7YF5tLx8mXsn35YS6rE33oAaJO1H6Xtsvpl6afO9dLMyHN21IdaGpgQ
	 OapRJ4FYly/zjbIMo54xx7PcKBbfrg8SpR4a417CPfSAMRBFHETIZ14Oa50V5fU9aPaxM
	 UjxWZ1y3xhx3+LmIoEJ4UBbxCMulLPbCCkxE9disACn5PL3EerqEKJga8MVK2q0mqrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r9lpjqo2;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C7C606A33D
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 15:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C7C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r9lpjqo2
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6d68de53053so2367497eaf.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794843183; x=1795447983; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dJhAWQWEpmn4cHTP18xczeckoaQSQ9nDJ4djaXb/+SM=;
        b=r9lpjqo27TbX4s19vhzC2usUsiDFtpac1b4IFXfely4L4U1/8ZNDJdiso4U2Zqm31h
         1OvUQId0eVpiEfNLiT1rIS5MIAvt/z4WdkABlqctFjg18pYBe7ngqAivKHdaISj+JB9a
         rbJzkd+myeS5GY53AT0N3PpNzsT8bUiEp1W5uxHlGNFnWpnhgDqQ9gH0+eZcJh0k0AzU
         /w4wGlpqyYvgkhNp9X6hcntEv4GB4XGS0N2GskaGF9gwhfieQb5LxlgmhV3h4WiW+sgZ
         SanJjKEjRv7d7Ocjv0QKEV1b7q+UR+VRMuRXyC/OyqvCJSuM1tDKlH+oVcmjJ17cQaXI
         7eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794843183; x=1795447983;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dJhAWQWEpmn4cHTP18xczeckoaQSQ9nDJ4djaXb/+SM=;
        b=QK7RVw2z8A+BmcRDUDG2bhiognE4xgw3NOHoW+gCRB2Eszc42HJliRPIR/Pp21WidK
         7+XT6zF3H7YSFt4pu/UI4X8eCSemmu7CWlwltLcn0bMhma7BetuRheNLbG3tVd9mmvAG
         GaX5ndoR3ly678v8IOjwCNmknaAFkk/PY98HyuwUx1+k+BDSyk2oJ1hpwQj00YazjGaR
         pveK+mOSBWgG8xyTE/TT2C0pMbqUb3wrP2p/Xrum5Xvrw1N/+uIutUd+0CXVzhY6Ligx
         X8P+UkADmw7KaVcrJhnsQCbYaX+Yfn616G+g5+XniPp74I5waSh0IMn3CVE3+6vFIGQV
         gOiw==
X-Gm-Message-State: APuU4Z+7tz5eRL5psdmYnuagzoSKxlLF8v299wPH/7+dkNhFBdR2Wfli
	zgNdUjLZHgduOQlupWe9ZvFzlFn6PuBbzWO14ZlW+Gi/V35iuolEWTOCLOqYeQ==
X-Gm-Gg: AYBFou1FuCcfUVXI4FrmE3BXjy3eFI1DtXNYT3+BRa07kknRbkRxx1Lyb6SUuhX8Dnt
	HUoFgrFzMwvgnobl0TY0X6vK2epe3va4nlm8CFGc0wHUf4L8HX5oIBQTyCPqqIk6c0v0spyfBDc
	uyqXWPy+lHrLmvF9rnSKnre9TRfGDbBIgk01sDJd/BMqvDOKv+JUg0xMfAcjTjc0eLrmkU9850I
	tNuPbCONLpUQayKCaVUTbmQrjO6YbMqft3V31UHWqzlUrwuxroTIRWkRlO3KN0XrX82aQ8MaTCP
	OGQ1nkTBKf8QeIe4W5KRx//I19Wyk7PexroShMvAvvEnLqGJkXhbQxCBJzE27dHj496ulXlbJwi
	01yTJIy2S0GM+BHT9zLD3P9uZ6uvfaU5hfYTop8tp1ZGVYwoEKeVdpkAs8hTTcyoakYeFkAeDKZ
	WalZQoTY+SqnO9VKVr4qrXrHAJYPZGlMnMpTy2oIcbfFCTwzTcpf/y9XdHlmQSzp0BlwWoIEUG/
	hlVssdNMfao90SEFCrNtrdEV//9l1jooGOJds25GpMIEDlazXKW6485vAPpTVlvBNWrpMP7lya/
	M6d/ADBPWHnnfNHaLt/pMsZJITq491sj1xs=
X-Received: by 2002:a05:6820:169e:b0:71a:d6ae:502e with SMTP id 006d021491bc7-71b01484f8dmr12765eaf.19.1794843182453;
        Mon, 16 Nov 2026 07:33:02 -0800 (PST)
Received: from [127.0.0.1] ([52.165.213.187])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab42cc12dsm8811517eaf.7.2026.11.16.07.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:33:01 -0800 (PST)
Message-Id: <pull.2250.v7.git.1794843180501.gitgitgadget@gmail.com>
In-Reply-To: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Nov 2026 15:33:00 +0000
Subject: [PATCH v7] doc: add new detached HEAD state guide
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Add a new guide (`git help detached-head`) to help users who
accidentally end up in detached HEAD state without understanding why.
Make it dual-purpose so that it can also be used as the DETACHED HEAD
section in `git-checkout.adoc`. The result is a shorter guide that
covers more material than the previous section.

This fixes the following issues with the current DETACHED HEAD section:

- Says detached HEAD state is useful but doesn't explain why
- Takes many paragraphs before explaining what detached HEAD state is
- It's common for users to accidentally end up in detached HEAD state,
  but it doesn't explain why that might happen
- One of the UI improvements in `git switch` is to make it harder
  to detach accidentally, but that isn't advertised.
  See 7968bef06b (switch: only allow explicit detached HEAD, 2019-03-29)
- Too many confusing diagrams

To help users who end up in detached HEAD state by accident, explain
the following, making all the explanations dual-purpose so they also
work in the context of `git-checkout.adoc`.

1. What detached HEAD state is
2. What the risks of detached HEAD state are, to help show folks that
   the risks are pretty limited and there's no need to be afraid
3. How you might end up there accidentally (or on purpose)
4. How to avoid entering detached HEAD state accidentally by using
   `git switch`
5. The options for getting out of detached HEAD state

The framing that "Git considers commits that aren't on a branch/other
reference to be garbage" is taken from Steve Klabnik's tutorial
https://steveklabnik.github.io/jujutsu-tutorial/branching-merging-and-conflicts/anonymous-branches.html.
It's funny and it's consistent with the way Git uses the term
"garbage collection".

Co-authored-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
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
    
    Changes in v3:
    
    I went through the style comments from v1.
    
    content changes:
    
     * Change "90 days" to "30 days" (thanks to Junio)
     * Say that HEAD is where Git stores your "current branch or commit" to
       make the first sentence read better (thanks to Junio)
     * Mention git switch --detach a little earlier (thanks to Kristoffer)
     * Replace "the only problem" with "it's important to know that" (thanks
       to Junio)
    
    formatting changes etc:
    
     * Replace help detachedhead with help detached-head (thanks to Junio)
     * Fix spacing in command-list.txt (thanks to Junio)
     * Get Marie's signoff (thanks to Junio)
    
    non-changes: Left these phrases alone because I don't think the proposed
    changes would make it more clear.
    
     * "3 main ways you can end up in detached HEAD state"
     * "to look at an old version of your code"
     * "avoid accidentally ending up"
    
    Changes in v4:
    
     * Fix commit message in example: "fix bug", not "3" (thanks to Junio)
     * "commit for that tag" -> "tagged commit" (thanks to Junio)
     * Move "git checkout COMMIT_ID or git switch --detach COMMIT_ID" down
       to the "3 main ways" list to reduce duplication (thanks to Junio)
     * Add some examples and be clearer about how detached HEAD state lets
       you check out an old version of the project. (thanks to Junio)
    
    Changes in v5:
    
     * Explain HEAD's relationship to the current commit to make it feel
       more uniform (thanks to Junio)
     * Add a note about the benefits of detaching HEAD (thanks to Junio &
       Ben)
     * Change "HEAD can either be a commit ID or a branch name"
    
    Changes in v6:
    
     * Adjust some wording around "stores" (thanks to Junio)
     * Change the quote style in advice.c (thanks to Junio)
     * Update expected output in t2020-checkout-detach.sh (thanks to Junio)
    
    Changes in v7:
    
     * Add "You can also use this to make experimental commits without being
       on a branch."
     * Update the commit message to explain that the goal is to help users
       who get into detached HEAD state accidentally, and how the guide is
       written to serve two purposes at the same time.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2250%2Fjvns%2Fdetached-head-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2250/jvns/detached-head-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/2250

Range-diff vs v6:

 1:  64f50b8248 ! 1:  020aac7cc4 doc: checkout: rewrite detached HEAD state explanation
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    doc: checkout: rewrite detached HEAD state explanation
     +    doc: add new detached HEAD state guide
      
     -    The current explanation has the following issues:
     +    Add a new guide (`git help detached-head`) to help users who
     +    accidentally end up in detached HEAD state without understanding why.
     +    Make it dual-purpose so that it can also be used as the DETACHED HEAD
     +    section in `git-checkout.adoc`. The result is a shorter guide that
     +    covers more material than the previous section.
     +
     +    This fixes the following issues with the current DETACHED HEAD section:
      
          - Says detached HEAD state is useful but doesn't explain why
          - Takes many paragraphs before explaining what detached HEAD state is
     @@ Commit message
            See 7968bef06b (switch: only allow explicit detached HEAD, 2019-03-29)
          - Too many confusing diagrams
      
     -    Write a new explanation addressing these issues, and put it in a
     -    standalone guide so that we can easily reference it from advice
     -    ("see `git help detached-head`").
     -    The result is a shorter guide that covers more material.
     +    To help users who end up in detached HEAD state by accident, explain
     +    the following, making all the explanations dual-purpose so they also
     +    work in the context of `git-checkout.adoc`.
     +
     +    1. What detached HEAD state is
     +    2. What the risks of detached HEAD state are, to help show folks that
     +       the risks are pretty limited and there's no need to be afraid
     +    3. How you might end up there accidentally (or on purpose)
     +    4. How to avoid entering detached HEAD state accidentally by using
     +       `git switch`
     +    5. The options for getting out of detached HEAD state
      
          The framing that "Git considers commits that aren't on a branch/other
          reference to be garbage" is taken from Steve Klabnik's tutorial
     @@ Documentation/detached-head.adoc (new)
      +it lets you easily check out an old version of your project. For
      +example, a data scientist could use this to run an old version of a
      +data pipeline or a programmer could use this to figure out when a bug
     -+was introduced. By detaching `HEAD`, you don't need to create a
     -+temporary branch.
     ++was introduced. You can also use this to make experimental commits
     ++without being on a branch. By detaching `HEAD`, you don't need to create
     ++a temporary branch.
      +
      +But it's important to know that if you create new commits while in
      +detached HEAD state, those commits won't be on a branch. This makes


 Documentation/Makefile              |   1 +
 Documentation/detached-head.adoc    |  65 ++++++++++++++
 Documentation/git-checkout.adoc     | 129 +---------------------------
 Documentation/gitdetached-head.adoc |  14 +++
 Documentation/meson.build           |   1 +
 advice.c                            |   1 +
 command-list.txt                    |   1 +
 t/t2020-checkout-detach.sh          |   2 +
 8 files changed, 86 insertions(+), 128 deletions(-)
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
index 0000000000..36fa422753
--- /dev/null
+++ b/Documentation/detached-head.adoc
@@ -0,0 +1,65 @@
+In Git, you can always use `HEAD` to refer to the commit you have
+checked out. But `HEAD` is also where Git stores the name of your
+current branch. Internally in Git, `HEAD` can store either:
+
+1. A branch name, which is your current branch.
+   The commit you have checked out is the latest commit on that branch.
+2. A commit ID, when you don't have a current branch.
+   This is called "detached HEAD state".
+
+It can sometimes be useful for `HEAD` to be a commit ID, because
+it lets you easily check out an old version of your project. For
+example, a data scientist could use this to run an old version of a
+data pipeline or a programmer could use this to figure out when a bug
+was introduced. You can also use this to make experimental commits
+without being on a branch. By detaching `HEAD`, you don't need to create
+a temporary branch.
+
+But it's important to know that if you create new commits while in
+detached HEAD state, those commits won't be on a branch. This makes
+those new commits much harder to find later. Also, Git considers commits
+that aren't on any branch (or a tag or other reference) to be garbage.
+Git will eventually permanently delete those "garbage" commits during
+garbage collection. Those commits will be deleted after 30 days by
+default, see linkgit:git-gc[1] for more.
+
+There are 3 main ways you can end up in detached HEAD state:
+
+1. `git checkout COMMIT_ID` or `git switch --detach COMMIT_ID`,
+   where `COMMIT_ID` is a commit ID.
+2. `git checkout v1.3`, where v1.3 is a tag name
+3. `git checkout origin/main`, where `origin/main` is
+   a remote-tracking branch
+
+Checking out a tag puts you in detached HEAD state because `HEAD` can
+only be a branch or a commit, not a tag or any other reference.
+So `git checkout TAG` will set HEAD to the tagged commit.
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
+  48c09f6 fix bug
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
index 401d047391..3238e9b866 100644
--- a/advice.c
+++ b/advice.c
@@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
 	"\n"
 	"  git switch -\n"
 	"\n"
+	"Run 'git help detached-head' to learn more.\n"
 	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
 
 	fprintf(stderr, fmt, new_name);
diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c9..7fb57765fb 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -218,6 +218,7 @@ gitcore-tutorial                        guide
 gitcredentials                          guide
 gitcvs-migration                        guide
 gitdatamodel                            guide
+gitdetached-head                        guide
 gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 28bbbe6c05..b0bfd3191c 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -228,6 +228,7 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 
 	  git switch -
 
+	Run 'git help detached-head' to learn more.
 	Turn off this advice by setting config variable advice.detachedHead to false
 
 	HEAD is now at \$commit three
@@ -310,6 +311,7 @@ test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked
 
 	  git switch -
 
+	Run 'git help detached-head' to learn more.
 	Turn off this advice by setting config variable advice.detachedHead to false
 
 	HEAD is now at \$commit... three

base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90
-- 
gitgitgadget
