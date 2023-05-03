Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46302C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 23:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjECXve (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 19:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjECXva (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 19:51:30 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C88A57
        for <git@vger.kernel.org>; Wed,  3 May 2023 16:51:28 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6a5ec0d8d8aso3981588a34.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 16:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683157887; x=1685749887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu6A2/4otWXV1bAjkzQZ8+qNRU3C6+zHFrwJf+iPHac=;
        b=qiaG2r0dit8r0jyr9lLmd1rLTyHEgyYXimCPzZ9K1cvBq+uaX9SrJ8C2XHyieX+4qH
         buoRc24msO+nJqpEg8vrNCUVmn0PS7yMr02qNnR7/NyJyM5hwRLMKgqEYQICJVVk7wb+
         lg4L6hvg7Ujc72GyHxQm+Gb5dBelzlyOR1SQvwHJGibeM/snZ4gtvRuikH3TUestfhCt
         NSIoFXvuz6Ua7dR4mSseMApmkkBiuDPZ6qpfOyCqBbgwhWxF9J1RDTsWGf2N7nIc/GGH
         Gqu8zl316k5Ka8r5B5Sk/FYLqhbHKgRZgEVPzrQFYWRxrpn4WzK3Ee4lvdrt43z46IwC
         z8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683157887; x=1685749887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gu6A2/4otWXV1bAjkzQZ8+qNRU3C6+zHFrwJf+iPHac=;
        b=PY2+qlnJGu/E3bnv3ZwGsLTCCsbLGnNp0wsa2x4QjND3vh9T4fR+JWmKg1k8ruEQwT
         1XEw1aMKbhnkL/fXru+4rft8OV6++hFAfepErFBIyO/1LYbDL08qHiYx/+iV4z7FAbrV
         Oy4iNTl8GYGyTyeDHU4W+D1mQrmQh6XMExag1RR5L2tOsJiczTKprvyXHnOR2nLStgZR
         fvHD2xB+gPDhhvENubAbK/nJgPKNcQILvQGdw/P6L3Xtxo5GluK1gmd2u1wWxTla0bDx
         CcdKd9NlHBJ+zrjJ2th1o3Bq3NV62Rvta0N9j6CiSYR1JW3LHcumElzY15qL0Aj2V0U/
         vypw==
X-Gm-Message-State: AC+VfDxKJN2iPAihCe61xl9R0TDqfbHvHCagQTSzjyty8JoIfgjvTihj
        bWxxM2gA+foUaM4laf5RRD5UID5jhkU=
X-Google-Smtp-Source: ACHHUZ7/GQqS/Gr1789m8yI//PFuEl3epSU8Ri9z8Pb31prGQ6NvI5hrrh02pAXURXOr4W9ifeO/jQ==
X-Received: by 2002:aca:a897:0:b0:392:593f:bb1c with SMTP id r145-20020acaa897000000b00392593fbb1cmr834473oie.20.1683157887368;
        Wed, 03 May 2023 16:51:27 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r22-20020acaa816000000b0038ee0c3b38esm1120805oie.44.2023.05.03.16.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 16:51:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] doc: remove unnecessary newline from callouts
Date:   Wed,  3 May 2023 17:51:26 -0600
Message-Id: <20230503235126.71028-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was initially needed when the callouts were inside the listing, but
after 48aeecdcc1 (Fix up remaining man pages that use asciidoc
"callouts"., 2006-04-28) moved them outside they are not needed.

Some are already following this format, for example git-checkout.txt,
git-cherry-pick.txt, and howto/using-merge-subtree.txt.

Let's be consistent and do the same everywhere.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-branch.txt       |  3 ---
 Documentation/git-diff.txt         |  5 -----
 Documentation/git-init.txt         |  1 -
 Documentation/git-reset.txt        | 10 ----------
 Documentation/git-restore.txt      |  1 -
 Documentation/git-update-index.txt |  1 -
 Documentation/giteveryday.txt      |  8 --------
 7 files changed, 29 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d207da9101..9fcf766fbf 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -359,7 +359,6 @@ $ cd my2.6
 $ git branch my2.6.14 v2.6.14   <1>
 $ git switch my2.6.14
 ------------
-+
 <1> This step and the next one could be combined into a single step with
     "checkout -b my2.6.14 v2.6.14".
 
@@ -371,7 +370,6 @@ $ cd my.git
 $ git branch -d -r origin/todo origin/html origin/man   <1>
 $ git branch -D test                                    <2>
 ------------
-+
 <1> Delete the remote-tracking branches "todo", "html" and "man". The next
     'fetch' or 'pull' will create them again unless you configure them not to.
     See linkgit:git-fetch[1].
@@ -384,7 +382,6 @@ Listing branches from a specific remote::
 $ git branch -r -l '<remote>/<pattern>'                 <1>
 $ git for-each-ref 'refs/remotes/<remote>/<pattern>'    <2>
 ------------
-+
 <1> Using `-a` would conflate <remote> with any local branches you happen to
     have been prefixed with the same <remote> pattern.
 <2> `for-each-ref` can take a wide range of options. See linkgit:git-for-each-ref[1]
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 52b679256c..fa8f28d5d3 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -153,7 +153,6 @@ $ git diff            <1>
 $ git diff --cached   <2>
 $ git diff HEAD       <3>
 ------------
-+
 <1> Changes in the working tree not yet staged for the next commit.
 <2> Changes between the index and your last commit; what you
     would be committing if you run `git commit` without `-a` option.
@@ -167,7 +166,6 @@ $ git diff test            <1>
 $ git diff HEAD -- ./test  <2>
 $ git diff HEAD^ HEAD      <3>
 ------------
-+
 <1> Instead of using the tip of the current branch, compare with the
     tip of "test" branch.
 <2> Instead of comparing with the tip of "test" branch, compare with
@@ -182,7 +180,6 @@ $ git diff topic master    <1>
 $ git diff topic..master   <2>
 $ git diff topic...master  <3>
 ------------
-+
 <1> Changes between the tips of the topic and the master branches.
 <2> Same as above.
 <3> Changes that occurred on the master branch since when the topic
@@ -195,7 +192,6 @@ $ git diff --diff-filter=MRC            <1>
 $ git diff --name-status                <2>
 $ git diff arch/i386 include/asm-i386   <3>
 ------------
-+
 <1> Show only modification, rename, and copy, but not addition
     or deletion.
 <2> Show only names and the nature of change, but not actual
@@ -208,7 +204,6 @@ Munging the diff output::
 $ git diff --find-copies-harder -B -C  <1>
 $ git diff -R                          <2>
 ------------
-+
 <1> Spend extra cycles to find renames, copies and complete
     rewrites (very expensive).
 <2> Output diff in reverse.
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 160dea1372..401ae1bb99 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -164,7 +164,6 @@ $ git init      <1>
 $ git add .     <2>
 $ git commit    <3>
 ----------------
-+
 <1> Create a /path/to/my/codebase/.git directory.
 <2> Add all existing files to the index.
 <3> Record the pristine state as the first commit in the history.
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 79ad5643ee..de8b84e930 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -145,7 +145,6 @@ $ mailx                                    <2>
 $ git reset                                <3>
 $ git pull git://info.example.com/ nitfol  <4>
 ------------
-+
 <1> You are happily working on something, and find the changes
     in these files are in good order.  You do not want to see them
     when you run `git diff`, because you plan to work on other files
@@ -167,7 +166,6 @@ $ git reset --soft HEAD^      <1>
 $ edit                        <2>
 $ git commit -a -c ORIG_HEAD  <3>
 ------------
-+
 <1> This is most often done when you remembered what you
     just committed is incomplete, or you misspelled your commit
     message, or both.  Leaves working tree as it was before "reset".
@@ -185,7 +183,6 @@ $ git branch topic/wip          <1>
 $ git reset --hard HEAD~3       <2>
 $ git switch topic/wip          <3>
 ------------
-+
 <1> You have made some commits, but realize they were premature
     to be in the `master` branch.  You want to continue polishing
     them in a topic branch, so create `topic/wip` branch off of the
@@ -199,7 +196,6 @@ Undo commits permanently::
 $ git commit ...
 $ git reset --hard HEAD~3   <1>
 ------------
-+
 <1> The last three commits (`HEAD`, `HEAD^`, and `HEAD~2`) were bad
     and you do not want to ever see them again.  Do *not* do this if
     you have already given these commits to somebody else.  (See the
@@ -219,7 +215,6 @@ Updating from 41223... to 13134...
 Fast-forward
 $ git reset --hard ORIG_HEAD       <4>
 ------------
-+
 <1> Try to update from the upstream resulted in a lot of
     conflicts; you were not ready to spend a lot of time merging
     right now, so you decide to do that later.
@@ -244,7 +239,6 @@ Merge made by recursive.
  ...
 $ git reset --merge ORIG_HEAD      <2>
 ------------
-+
 <1> Even if you may have local modifications in your
     working tree, you can safely say `git pull` when you know
     that the change in the other branch does not overlap with
@@ -274,7 +268,6 @@ $ git switch feature
 $ git reset --soft HEAD^ ;# go back to WIP state  <2>
 $ git reset                                       <3>
 ------------
-+
 <1> This commit will get blown away so a throw-away log message is OK.
 <2> This removes the 'WIP' commit from the commit history, and sets
     your working tree to the state just before you made that snapshot.
@@ -295,7 +288,6 @@ $ git reset -- frotz.c                      <1>
 $ git commit -m "Commit files in index"     <2>
 $ git add frotz.c                           <3>
 ------------
-+
 <1> This removes the file from the index while keeping it in the working
     directory.
 <2> This commits all other changes in the index.
@@ -318,7 +310,6 @@ $ edit
 $ git switch -c branch2                     <2>
 $ git reset --keep start                    <3>
 ------------
-+
 <1> This commits your first edits in `branch1`.
 <2> In the ideal world, you could have realized that the earlier
     commit did not belong to the new topic when you created and switched
@@ -346,7 +337,6 @@ $ git add ...                               <6>
 $ git diff --cached                         <7>
 $ git commit ...                            <8>
 ------------
-+
 <1> First, reset the history back one commit so that we remove the original
     commit, but leave the working tree with all the changes. The -N ensures
     that any new files added with `HEAD` are still marked so that `git add -p`
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 5964810caa..9d34dbe8a4 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -159,7 +159,6 @@ $ git restore --source master~2 Makefile  <1>
 $ rm -f hello.c
 $ git restore hello.c                     <2>
 ------------
-
 <1> take a file out of another commit
 <2> restore hello.c from the index
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index f4bb9c5daf..40396e23f3 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -381,7 +381,6 @@ $ git update-index --no-assume-unchanged foo.c   <8>
 $ git diff --name-only                           <9>
 M foo.c
 ------------
-+
 <1> forces lstat(2) to set "assume unchanged" bits for paths that match index.
 <2> mark the path to be edited.
 <3> this does lstat(2) and finds index matches the path.
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index faba2ef088..a897ad71d9 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -72,7 +72,6 @@ $ git add . <1>
 $ git commit -m "import of frotz source tree."
 $ git tag v2.43 <2>
 ------------
-+
 <1> add everything under the current directory.
 <2> make a lightweight, unannotated tag.
 
@@ -94,7 +93,6 @@ $ git merge alsa-audio <9>
 $ git log --since='3 days ago' <10>
 $ git log v2.43.. curses/ <11>
 ------------
-+
 <1> create a new topic branch.
 <2> revert your botched changes in `curses/ux_audio_oss.c`.
 <3> you need to tell Git if you added a new file; removal and
@@ -159,7 +157,6 @@ $ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <9>
 $ git reset --hard ORIG_HEAD <10>
 $ git gc <11>
 ------------
-+
 <1> checkout a new branch `mine` from master.
 <2> repeat as needed.
 <3> extract patches from your branch, relative to master,
@@ -196,7 +193,6 @@ mothership$ cd frotz
 mothership$ git switch master
 mothership$ git merge satellite/master <5>
 ------------
-+
 <1> mothership machine has a frotz repository under your home
 directory; clone from it to start a repository on the satellite
 machine.
@@ -220,7 +216,6 @@ $ edit/compile/test; git commit -a
 $ git checkout master
 $ git cherry-pick v2.6.14..private2.6.14 <2>
 ------------
-+
 <1> create a private branch based on a well known (but somewhat behind)
 tag.
 <2> forward port all changes in `private2.6.14` branch to `master` branch
@@ -290,7 +285,6 @@ $ git fetch ko && for branch in master maint next seen <11>
     done
 $ git push --follow-tags ko <13>
 ------------
-+
 <1> see what you were in the middle of doing, if anything.
 <2> see which branches haven't been merged into `master` yet.
 Likewise for any other integration branches e.g. `maint`, `next`
@@ -410,7 +404,6 @@ david:x:1003:1003::/home/david:/usr/bin/git-shell
 $ grep git /etc/shells <2>
 /usr/bin/git-shell
 ------------
-+
 <1> log-in shell is set to /usr/bin/git-shell, which does not
 allow anything but `git push` and `git pull`.  The users require
 ssh access to the machine.
@@ -441,7 +434,6 @@ refs/heads/master	alice\|cindy
 refs/heads/doc-update	bob
 refs/tags/v[0-9]*	david
 ------------
-+
 <1> place the developers into the same git group.
 <2> and make the shared repository writable by the group.
 <3> use update-hook example by Carl from Documentation/howto/
-- 
2.40.0+fc1

