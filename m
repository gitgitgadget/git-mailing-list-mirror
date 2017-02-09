Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3951FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 04:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbdBIE5w (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 23:57:52 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34869 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdBIE5v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 23:57:51 -0500
Received: by mail-pf0-f172.google.com with SMTP id f144so47218145pfa.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 20:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MJePnJY2aeY+vmyAIgG0y7LBUv2RGNYIVM2+rnLyWUg=;
        b=TRJJmucyGOr0TKGB4qNqGKjKjQJoyKjDPoxDJbQG1vpG9PF/ptYSRad6MfdUfIGMTj
         2WSrW7lY+zkbPZ+hZ9NHhc9S47mOISk00kVTuo/085/g/GRxRQTp77ezlzH2NrDwdTpG
         1Vklx9uuRwsAfw4oDqZsVPaaHTNW0O8re/9AnXyrQYoELXWnhylwbZ7Fus7hCmdspMW8
         sZNwqN1Yf67mbV4DgL/c7BoTjLm3oJS0bQ5sOh+9wy0B6us8EN0sjhUGpSBlF/j0A9+4
         6V/ucg21lUc+sz1JxGHNmjkrk7gmhMiZeNLq+mLJ1iq2io8MLmzEh65USaB1rEVRU6uN
         HCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MJePnJY2aeY+vmyAIgG0y7LBUv2RGNYIVM2+rnLyWUg=;
        b=Dld/yxsL8zuXw9XJHTkMtgPrpKY4rX4nkxMp2Um31S8ZzzQlajY+U7K80Rm8wcF7HA
         atZD3qYO5khEgJTdXhB679mYomdOXsoQCqOLqyk1T0Sp5gtaT/AbzxqU5klQXgWQ3CHa
         YqPMUbEq/M/+AFhBFZgs6ollreo35dJ8cpPrYLk6JVMssXoomDtc3OjTNdcVwk4soPGs
         PJBOMzS4GRD1qnVPHJRuttUl4CrHNyge40c8dz1TCKEW/DQsFGcGQ3ncXPE75SesR2gr
         Y+FitpvLfHKIA6ymPSe9pnix2itC6bb0xXoJjruryfSIs6WVD5QAP4+wGrv+tjvEJEyt
         r4Hg==
X-Gm-Message-State: AMke39m3whIKuZ/vpUwKtjC+lcJZxy6fZJ4cJw00v+WU8ilvGIEa5qtpOImb94QjUMYkbMPM
X-Received: by 10.84.151.9 with SMTP id i9mr926928pli.122.1486606138687;
        Wed, 08 Feb 2017 18:08:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:684e:2fd8:5eea:9943])
        by smtp.gmail.com with ESMTPSA id 75sm23381716pfp.80.2017.02.08.18.08.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 18:08:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC-PATCHv2] submodules: add a background story
Date:   Wed,  8 Feb 2017 18:08:55 -0800
Message-Id: <20170209020855.23486-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.1.g018cb5e6f4
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like gitmodules(5), gitattributes(5), gitcredentials(7),
gitnamespaces(7), gittutorial(7), we'd like to provide some background
on submodules, which is not specific to the `submodule` command, but
elaborates on the background and its intended usage.

Add gitsubmodules(7), that explains the states, structure and usage of
submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This would replace the last patch of  sb/submodule-doc, though it's still
RFC. In this revision I took care of the technical details (i.e. proper
formatting, spelling), and only slight rewording of the text.

The main issue persists; see bottom of the patch:

  SAMPLE WORKFLOWS (RFC/TODO)
  ---------------------------
  
  Do we need
  
  * an opinionated way to check for a specific state of a submodule
  * (submodule helper to be plumbing?)
  * expose the design mistake of having the (name->path) mapping inside the
    working tree, i.e. never remove a name from the submodule config even when
    the submodule doesn't exist any more.
    
Any opinion on these would be welcome!
Thanks,
Stefan

 Documentation/Makefile          |   1 +
 Documentation/git-submodule.txt |  36 ++------
 Documentation/gitsubmodules.txt | 194 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/gitsubmodules.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b43d66eae6..325c4735a7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -31,6 +31,7 @@ MAN7_TXT += giteveryday.txt
 MAN7_TXT += gitglossary.txt
 MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitrevisions.txt
+MAN7_TXT += gitsubmodules.txt
 MAN7_TXT += gittutorial-2.txt
 MAN7_TXT += gittutorial.txt
 MAN7_TXT += gitworkflows.txt
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4a4cede144..d38aa2d53a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -24,37 +24,7 @@ DESCRIPTION
 -----------
 Inspects, updates and manages submodules.
 
-A submodule allows you to keep another Git repository in a subdirectory
-of your repository. The other repository has its own history, which does not
-interfere with the history of the current repository. This can be used to
-have external dependencies such as third party libraries for example.
-
-When cloning or pulling a repository containing submodules however,
-these will not be checked out by default; the 'init' and 'update'
-subcommands will maintain submodules checked out and at
-appropriate revision in your working tree.
-
-Submodules are composed from a so-called `gitlink` tree entry
-in the main repository that refers to a particular commit object
-within the inner repository that is completely separate.
-A record in the `.gitmodules` (see linkgit:gitmodules[5]) file at the
-root of the source tree assigns a logical name to the submodule and
-describes the default URL the submodule shall be cloned from.
-The logical name can be used for overriding this URL within your
-local repository configuration (see 'submodule init').
-
-Submodules are not to be confused with remotes, which are other
-repositories of the same project; submodules are meant for
-different projects you would like to make part of your source tree,
-while the history of the two projects still stays completely
-independent and you cannot modify the contents of the submodule
-from within the main project.
-If you want to merge the project histories and want to treat the
-aggregated whole as a single project from then on, you may want to
-add a remote for the other project and use the 'subtree' merge strategy,
-instead of treating the other project as a submodule. Directories
-that come from both projects can be cloned and checked out as a whole
-if you choose to go that route.
+For more information about submodules, see linkgit:gitsubmodules[5]
 
 COMMANDS
 --------
@@ -420,6 +390,10 @@ This file should be formatted in the same way as `$GIT_DIR/config`. The key
 to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]
 for details.
 
+SEE ALSO
+--------
+linkgit:gitsubmodules[1], linkgit:gitmodules[1].
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
new file mode 100644
index 0000000000..3369d55ae9
--- /dev/null
+++ b/Documentation/gitsubmodules.txt
@@ -0,0 +1,194 @@
+gitsubmodules(7)
+================
+
+NAME
+----
+gitsubmodules - information about submodules
+
+SYNOPSIS
+--------
+$GIT_DIR/config, .gitmodules
+
+------------------
+git submodule
+------------------
+
+DESCRIPTION
+-----------
+
+A submodule allows you to keep another Git repository in a subdirectory
+of your repository. The other repository has its own history, which does not
+interfere with the history of the current repository. This can be used to
+have external dependencies such as third party libraries for example.
+
+Submodules are composed from a so-called `gitlink` tree entry
+in the main repository that refers to a particular commit object
+within the inner repository that is completely separate.
+A record in the `.gitmodules` (see linkgit:gitmodules[5]) file at the
+root of the source tree assigns a logical name to the submodule and
+describes the default URL the submodule shall be cloned from.
+The logical name can be used for overriding this URL within your
+local repository configuration (see 'submodule init').
+
+Submodules are not to be confused with remotes, which are other
+repositories of the same project; submodules are meant for
+different projects you would like to make part of your source tree,
+while the history of the two projects still stays completely
+independent and you cannot modify the contents of the submodule
+from within the main project.
+If you want to merge the project histories and want to treat the
+aggregated whole as a single project from then on, you may want to
+add a remote for the other project and use the 'subtree' merge strategy,
+instead of treating the other project as a submodule. Directories
+that come from both projects can be cloned and checked out as a whole
+if you choose to go that route.
+
+When cloning or pulling a repository containing submodules however,
+the submodules will not be checked out by default; You need to instruct
+'clone' to recurse into submodules. The 'init' and 'update' subcommands
+of 'git submodule' will maintain submodules checked out and at an
+appropriate revision in your working tree.
+
+WHEN TO USE
+-----------
+
+Submodules, repositories inside other repositories,
+can be used for different use cases:
+
+* To have finer grained access control.
+  The design principles of Git do not allow for partial repositories to be
+  checked out or transferred. A repository is the smallest unit that a user
+  can be given access to. Submodules are separate repositories, such that
+  you can restrict access to parts of your project via the use of submodules.
+
+* To decouple Git histories.
+  Decoupling histories has different benefits.
+
+** When you want to use a (third party) library tied to a specific version.
+   Using submodules for a library allows you to have a clean history for
+   your own project and only updating the library in the submodule when needed.
+
+** In its current form Git scales up poorly for very large repositories that
+   change a lot, as the history grows very large. For that you may want to look
+   at shallow clone, sparse checkout or git-lfs.
+   However you can also use submodules to e.g. hold large binary assets
+   and these repositories are then shallowly cloned such that you do not
+   have a large history locally.
+
+STATES
+------
+
+When working with submodules, you can think of them as in a state machine.
+So each submodule can be in a different state, the following indicators are used:
+
+* the existence of the setting of 'submodule.<name>.url' in the
+  superprojects configuration
+* the existence of the submodules working tree within the
+  working tree of the superproject
+* the existence of the submodules git directory within the superprojects
+  git directory at $GIT_DIR/modules/<name> or within the submodules working
+  tree
+
+      State      URL config        working tree     git dir
+      -----------------------------------------------------
+      uninitialized    no               no           no
+      initialized     yes               no           no
+      populated       yes              yes          yes
+      depopulated     yes               no          yes
+      deinitialized    no               no          yes
+      uninteresting    no              yes          yes
+
+      invalid          no              yes           no
+      invalid         yes              yes           no
+      -----------------------------------------------------
+
+The first six states can be reached by normal git usage, the latter two are
+only shown for completeness to show all possible eight states with 3 binary
+indicators. The states in detail:
+
+uninitialized::
+The uninitialized state is the default state if no
+'--recurse-submodules' / '--recursive'. An empty directory will be put in
+the working tree as a place holder, such that you are reminded of the
+existence of the submodule.
+---
+To transition into the initialized state
+you can use 'git submodule init', which copies the presets from the
+.gitmodules file into the config.
+
+initialized::
+Users transitioned from the uninitialized state to this state via
+'git submodule init', which preset the URL configuration. As these URLs
+may not be desired in certain scenarios, this state allows to change the
+URLs.  For example in a corporate environment you may want to run
+
+    sed -i s/example.org/$internal-mirror/ .git/config
++
+before proceeding to populate the submodules.
+
+populated::
+In the populated state you have the submodule fully available, i.e. the git
+directory exists as well the working tree exists. In this state you can work
+with the submodule, just like with any other repository.
+
+depopulated::
+In this state you still have the git directory around, but the working tree
+is gone.  For example when the superproject checks out a revision that doesn't
+have the submodule, the state may change to depopulated.
+
+deinitialized::
+The git directory is still there, but the user is no longer interested in the
+submodule as indicated by the missing URL configuration.
+
+invalid::
+When there is no git directory for a submodule, then there is something
+seriously wrong with the submodule.
+
+INNER WORKINGS
+--------------
+
+Generally a submodule can be considered its own autonomous repository,
+that has a worktree and a git directory at split places.
+
+The superproject only records the commit sha1 in its tree, such that
+any other information, e.g. where to obtain a copy from, is not recorded
+in the core data structures of Git. The porcelain layer of Git however
+makes use of the .gitmodules file that gives strong hints where and how
+to obtain a copy of the submodules git repository from.
+
+On the location of the git directory
+------------------------------------
+
+Since v1.7.7 of Git, the git directory of submodules is stored inside the
+superprojects git directory at $GIT_DIR/modules/<submodule-name>
+This location allows for the working tree to be non existent while keeping
+the history around. So we can use git-rm on a submodule without loosing
+information that may only be local.
+
+In the future we may see git-checkout that can checkout submodules and
+revisions that do not contain the submodule can still be checked out without
+having to drop the submodules git directory.
+
+It is also possible to imagine a future in which a bare repository still
+contains its submodules inside the modules sub directory, such that you can
+get a full clone including submodules from that bare repository, the URLs
+as configured or given in the .gitmodules would only be used as a backup.
+
+SAMPLE WORKFLOWS (RFC/TODO)
+---------------------------
+
+Do we need
+
+* an opinionated way to check for a specific state of a submodule
+* (submodule helper to be plumbing?)
+* expose the design mistake of having the (name->path) mapping inside the
+  working tree, i.e. never remove a name from the submodule config even when
+  the submodule doesn't exist any more.
+
+SEE ALSO
+--------
+linkgit:git-submodule[1], linkgit:gitmodules[1].
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.12.0.rc0.1.g018cb5e6f4

