Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A843D20248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDKNOB (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:14:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37299 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKNOB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:14:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so3408755ply.4
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+p1eyfn2RXMcH18+2NYvY57WgE83WRC41/FDimkUr8=;
        b=ovsmDYY0JgSUzrgC+0ScbNfw0O+az0C1bGMFBDXcaAUvfYdxK7BvLW5glFQHLfeuZv
         kmUXhgX4+pKA0SmVfuyk5TT5LQZVMgycRmUWYj0IsE99BXN2Tyr5+qMK8ZXkmRYQP9J2
         Nac5YVDYMZZIJ5KmqIfiepatiCpqKGIHoQMHHIuEKT3iCsYQwzokLBli8CAz4y1RkE6T
         ez3ZmIW1ASooDjj1kcGjyzy5pQpQTHKAjJSB5tJi+bykZV80C7sKT8VkMWNolejKSRVE
         f0Ogu83y9ovw3RVHMsIosR/zZFrQnAalLpQvZo71j2fTJFepgtODMcAbNUyLbzL0AmfX
         mmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+p1eyfn2RXMcH18+2NYvY57WgE83WRC41/FDimkUr8=;
        b=UuY8uCW4QAhlcZanMiLxuOTxbK68jr0dS+JIb8wJ1lw81ctcxiKZ0xQPvsHjXl7K9w
         MD6a31R9tf84MRhRW65eC3BikfjTXc5f4/LECYaq438rMVLSi3YYajMCdTmNKScCgZcU
         4JRu2P8T2UruV1wEZWXXn+re6o/F91NcRAknlMVzczS1If7HEJDIKqe3PxWd5Q+iBpSt
         jXN48v2fMZ5SWTkfkuVOE2TeRGDjV53zggwyA80nXedGLRwFGl1fNlcqurR29Gd/J8p6
         o+RIByWl5xQWOks6lNAVZIK/NjXDOM8TFmFAXXPkCC4YNPPM+2YS17dPG7IXvirWJStD
         wp9Q==
X-Gm-Message-State: APjAAAVG0lrmBHNSyyh+Ra0cwh+wQ7g255tuGVVx9jkrF84Wl3MOU7Dg
        a0dbHcxbDma4QHPGk+Yp9ww=
X-Google-Smtp-Source: APXvYqzp+V2QWIbVVdxQvCqsfjyPcQiEmohoTp3zzUthECJvw+i8eo/nxp4jyGUtiq2uzs6mjjLxBg==
X-Received: by 2002:a17:902:59c5:: with SMTP id d5mr50198912plj.104.1554988439952;
        Thu, 11 Apr 2019 06:13:59 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id i2sm58844197pfo.9.2019.04.11.06.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:13:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:13:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 14/16] doc: promote "git restore"
Date:   Thu, 11 Apr 2019 20:12:16 +0700
Message-Id: <20190411131218.19195-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new command "git restore" (together with "git switch") are added
to avoid the confusion of one-command-do-all "git checkout" for new
users. They are also helpful to avoid ambiguous context.

For these reasons, promote it everywhere possible. This includes
documentation, suggestions/advice from other commands.

One nice thing about git-restore is the ability to restore
"everything", so it can be used in "git status" advice instead of both
"git checkout" and "git reset".  The three commands suggested by "git
status" are add, rm and restore.

"git checkout" is also removed from "git help" (i.e. it's no longer
considered a commonly used command)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-clean.txt        |  2 +-
 Documentation/git-commit.txt       |  2 +-
 Documentation/git-format-patch.txt |  2 +-
 Documentation/git-reset.txt        |  6 +--
 Documentation/git-revert.txt       |  4 +-
 Documentation/gitcli.txt           |  4 +-
 Documentation/giteveryday.txt      |  5 +-
 Documentation/gittutorial-2.txt    |  4 +-
 Documentation/gittutorial.txt      |  2 +-
 Documentation/user-manual.txt      | 12 ++---
 builtin/clone.c                    |  2 +-
 builtin/commit.c                   |  2 +-
 command-list.txt                   |  2 +-
 t/t7508-status.sh                  | 82 +++++++++++++++---------------
 t/t7512-status-help.sh             | 20 ++++----
 wt-status.c                        | 26 +++++++---
 16 files changed, 93 insertions(+), 84 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 03056dad0d..8a31ccffea 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -64,7 +64,7 @@ OPTIONS
 	directory) and $GIT_DIR/info/exclude, but do still use the ignore
 	rules given with `-e` options.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
-	conjunction with 'git reset') to create a pristine
+	conjunction with 'git restore' or 'git reset') to create a pristine
 	working directory to test a clean build.
 
 -X::
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a85c2c2a4c..7628193284 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -359,7 +359,7 @@ When recording your own work, the contents of modified files in
 your working tree are temporarily stored to a staging area
 called the "index" with 'git add'.  A file can be
 reverted back, only in the index but not in the working tree,
-to that of the last commit with `git reset HEAD -- <file>`,
+to that of the last commit with `git restore --staged <file>`,
 which effectively reverts 'git add' and prevents the changes to
 this file from participating in the next commit.  After building
 the state to be committed incrementally with these commands,
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0a24a5679e..01bfcecf69 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -422,7 +422,7 @@ One way to test if your MUA is set up correctly is:
 
     $ git fetch <project> master:test-apply
     $ git switch test-apply
-    $ git reset --hard
+    $ git restore --source=HEAD --staged --worktree :/
     $ git am a.patch
 
 If it does not apply correctly, there can be various reasons.
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index c25f8a95b9..633d71d36a 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -29,9 +29,9 @@ This means that `git reset <paths>` is the opposite of `git add
 `git restore [--source=<tree-ish>] --staged <paths>...`.
 +
 After running `git reset <paths>` to update the index entry, you can
-use linkgit:git-checkout[1] to check the contents out of the index to
-the working tree.
-Alternatively, using linkgit:git-checkout[1] and specifying a commit, you
+use linkgit:git-restore[1] to check the contents out of the index to
+the working tree. Alternatively, using linkgit:git-restore[1]
+and specifying a commit with `--source`, you
 can copy the contents of a path out of a commit to the index and to the
 working tree in one go.
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 018ecf49d3..9aadc36881 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -26,8 +26,8 @@ effect of some earlier commits (often only a faulty one).  If you want to
 throw away all uncommitted changes in your working directory, you
 should see linkgit:git-reset[1], particularly the `--hard` option.  If
 you want to extract specific files as they were in another commit, you
-should see linkgit:git-checkout[1], specifically the `git checkout
-<commit> -- <filename>` syntax.  Take care with these alternatives as
+should see linkgit:git-restore[1], specifically the `--source`
+option. Take care with these alternatives as
 both will discard uncommitted changes in your working directory.
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 592e06d839..e2a9674297 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -47,8 +47,8 @@ disambiguating `--` at appropriate places.
    things:
 +
 --------------------------------
-$ git checkout -- *.c
-$ git checkout -- \*.c
+$ git restore *.c
+$ git restore \*.c
 --------------------------------
 +
 The former lets your shell expand the fileglob, and you are asking
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index ad455f3e39..1bd919f92b 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -51,8 +51,7 @@ following commands.
 
   * linkgit:git-commit[1] to advance the current branch.
 
-  * linkgit:git-reset[1] and linkgit:git-checkout[1] (with
-    pathname parameters) to undo changes.
+  * linkgit:git-restore[1] to undo changes.
 
   * linkgit:git-merge[1] to merge between local branches.
 
@@ -82,7 +81,7 @@ Create a topic branch and develop.::
 ------------
 $ git switch -c alsa-audio <1>
 $ edit/compile/test
-$ git checkout -- curses/ux_audio_oss.c <2>
+$ git restore curses/ux_audio_oss.c <2>
 $ git add curses/ux_audio_alsa.c <3>
 $ edit/compile/test
 $ git diff HEAD <4>
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index e0976f6017..8bdb7d0bd3 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -370,13 +370,13 @@ situation:
 $ git status
 On branch master
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   closing.txt
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   file.txt
 
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index e6ad6b5f8d..59ef5cef1f 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -110,7 +110,7 @@ $ git status
 On branch master
 Changes to be committed:
 Your branch is up to date with 'origin/master'.
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   file1
 	modified:   file2
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 4e210970e1..8bce75b2cf 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1446,7 +1446,7 @@ mistake, you can return the entire working tree to the last committed
 state with
 
 -------------------------------------------------
-$ git reset --hard HEAD
+$ git restore --staged --worktree :/
 -------------------------------------------------
 
 If you make a commit that you later wish you hadn't, there are two
@@ -1523,12 +1523,10 @@ Checking out an old version of a file
 
 In the process of undoing a previous bad change, you may find it
 useful to check out an older version of a particular file using
-linkgit:git-checkout[1].  We've used `git checkout` before to switch
-branches, but it has quite different behavior if it is given a path
-name: the command
+linkgit:git-restore[1]. The command
 
 -------------------------------------------------
-$ git checkout HEAD^ path/to/file
+$ git restore --source=HEAD^ path/to/file
 -------------------------------------------------
 
 replaces path/to/file by the contents it had in the commit HEAD^, and
@@ -3800,8 +3798,8 @@ use linkgit:git-tag[1] for both.
 The Workflow
 ------------
 
-High-level operations such as linkgit:git-commit[1],
-linkgit:git-checkout[1] and linkgit:git-reset[1] work by moving data
+High-level operations such as linkgit:git-commit[1] and
+linkgit:git-restore[1] work by moving data
 between the working tree, the index, and the object database.  Git
 provides low-level operations which perform each of these steps
 individually.
diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..024eb57996 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -492,7 +492,7 @@ static enum {
 static const char junk_leave_repo_msg[] =
 N_("Clone succeeded, but checkout failed.\n"
    "You can inspect what was checked out with 'git status'\n"
-   "and retry the checkout with 'git checkout -f HEAD'\n");
+   "and retry with 'git restore --source=HEAD :/'\n");
 
 static void remove_junk(void)
 {
diff --git a/builtin/commit.c b/builtin/commit.c
index f17537474a..fa5982cc86 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1676,7 +1676,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (commit_index_files())
 		die(_("repository has been updated, but unable to write\n"
 		      "new_index file. Check that disk is not full and quota is\n"
-		      "not exceeded, and then \"git reset HEAD\" to recover."));
+		      "not exceeded, and then \"git restore --staged :/\" to recover."));
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
 		write_commit_graph_reachable(get_object_directory(), 0, 0);
diff --git a/command-list.txt b/command-list.txt
index b9eae1c258..cf8dccb439 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -59,7 +59,7 @@ git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
 git-check-ignore                        purehelpers
 git-check-mailmap                       purehelpers
-git-checkout                            mainporcelain           history
+git-checkout                            mainporcelain
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
 git-cherry                              plumbinginterrogators          complete
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e1f11293e2..681bc314b4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -94,13 +94,13 @@ test_expect_success 'status --column' '
 #   (use "git pull" to merge the remote branch into yours)
 #
 # Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
+#   (use "git restore --staged <file>..." to unstage)
 #
 #	new file:   dir2/added
 #
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (use "git restore <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
@@ -128,13 +128,13 @@ cat >expect <<\EOF
 #   (use "git pull" to merge the remote branch into yours)
 #
 # Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
+#   (use "git restore --staged <file>..." to unstage)
 #
 #	new file:   dir2/added
 #
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
+#   (use "git restore <file>..." to discard changes in working directory)
 #
 #	modified:   dir1/modified
 #
@@ -278,13 +278,13 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -347,13 +347,13 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -420,13 +420,13 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -484,13 +484,13 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -542,13 +542,13 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -605,13 +605,13 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   ../dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   modified
 
@@ -676,13 +676,13 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	<GREEN>new file:   dir2/added<RESET>
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	<RED>modified:   dir1/modified<RESET>
 
@@ -802,13 +802,13 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -852,7 +852,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   dir1/modified
 
@@ -896,14 +896,14 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 	new file:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -956,14 +956,14 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 	new file:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -1019,7 +1019,7 @@ and have 2 and 2 different commits each, respectively.
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -1068,14 +1068,14 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD^1 <file>..." to unstage)
+  (use "git restore --source=HEAD^1 --staged <file>..." to unstage)
 
 	new file:   dir2/added
 	new file:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -1123,13 +1123,13 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -1235,13 +1235,13 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
   (commit or discard the untracked or modified content in submodules)
 
 	modified:   dir1/modified
@@ -1295,13 +1295,13 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 	modified:   sm (new commits)
@@ -1379,13 +1379,13 @@ cat > expect << EOF
 ;   (use "git pull" to merge the remote branch into yours)
 ;
 ; Changes to be committed:
-;   (use "git reset HEAD <file>..." to unstage)
+;   (use "git restore --staged <file>..." to unstage)
 ;
 ;	modified:   sm
 ;
 ; Changes not staged for commit:
 ;   (use "git add <file>..." to update what will be committed)
-;   (use "git checkout -- <file>..." to discard changes in working directory)
+;   (use "git restore <file>..." to discard changes in working directory)
 ;
 ;	modified:   dir1/modified
 ;	modified:   sm (new commits)
@@ -1431,7 +1431,7 @@ and have 2 and 2 different commits each, respectively.
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -1458,13 +1458,13 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
@@ -1581,13 +1581,13 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   dir1/modified
 
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 458608cc1e..1b9712c675 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -85,7 +85,7 @@ You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
   (use "git rebase --abort" to check out the original branch)
 
 Unmerged paths:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
 
 	both modified:   main.txt
@@ -110,7 +110,7 @@ You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
   (all conflicts fixed: run "git rebase --continue")
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   main.txt
 
@@ -148,7 +148,7 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
   (use "git rebase --abort" to check out the original branch)
 
 Unmerged paths:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
 
 	both modified:   main.txt
@@ -176,7 +176,7 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
   (all conflicts fixed: run "git rebase --continue")
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   main.txt
 
@@ -246,7 +246,7 @@ You are currently splitting a commit while rebasing branch '\''split_commit'\''
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   main.txt
 
@@ -354,7 +354,7 @@ You are currently splitting a commit while rebasing branch '\''several_edits'\''
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   main.txt
 
@@ -453,7 +453,7 @@ You are currently splitting a commit while rebasing branch '\''several_edits'\''
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   main.txt
 
@@ -557,7 +557,7 @@ You are currently splitting a commit while rebasing branch '\''several_edits'\''
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore <file>..." to discard changes in working directory)
 
 	modified:   main.txt
 
@@ -816,7 +816,7 @@ You are currently reverting commit $TO_REVERT.
   (use "git revert --abort" to cancel the revert operation)
 
 Unmerged paths:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
 
 	both modified:   to-revert.txt
@@ -837,7 +837,7 @@ You are currently reverting commit $TO_REVERT.
   (use "git revert --abort" to cancel the revert operation)
 
 Changes to be committed:
-  (use "git reset HEAD <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   to-revert.txt
 
diff --git a/wt-status.c b/wt-status.c
index 445a36204a..19fd1add75 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -178,9 +178,15 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 		return;
 	if (s->whence != FROM_COMMIT)
 		;
-	else if (!s->is_initial)
-		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
-	else
+	else if (!s->is_initial) {
+		if (!strcmp(s->reference, "HEAD"))
+			status_printf_ln(s, c,
+					 _("  (use \"git restore --staged <file>...\" to unstage)"));
+		else
+			status_printf_ln(s, c,
+					 _("  (use \"git restore --source=%s --staged <file>...\" to unstage)"),
+					 s->reference);
+	} else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
 
 	if (!both_deleted) {
@@ -205,9 +211,15 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
 		return;
 	if (s->whence != FROM_COMMIT)
 		; /* NEEDSWORK: use "git reset --unresolve"??? */
-	else if (!s->is_initial)
-		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
-	else
+	else if (!s->is_initial) {
+		if (!strcmp(s->reference, "HEAD"))
+			status_printf_ln(s, c
+					 , _("  (use \"git restore --staged <file>...\" to unstage)"));
+		else
+			status_printf_ln(s, c,
+					 _("  (use \"git restore --source=%s --staged <file>...\" to unstage)"),
+					 s->reference);
+	} else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
 	status_printf_ln(s, c, "%s", "");
 }
@@ -225,7 +237,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 		status_printf_ln(s, c, _("  (use \"git add <file>...\" to update what will be committed)"));
 	else
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" to update what will be committed)"));
-	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
+	status_printf_ln(s, c, _("  (use \"git restore <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
 	status_printf_ln(s, c, "%s", "");
-- 
2.21.0.682.g30d2204636

