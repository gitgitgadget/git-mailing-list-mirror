Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1717E20441
	for <e@80x24.org>; Tue, 27 Dec 2016 23:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbcL0XnX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 18:43:23 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35010 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932952AbcL0XnT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 18:43:19 -0500
Received: by mail-pg0-f42.google.com with SMTP id i5so84377658pgh.2
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 15:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uERQuHMrCiVGVYZTsCI4txxIlaYaI57nr1rjGf+3GEU=;
        b=Nsy0yc2NlmSkICL6DdSnzhBTvRd8mULZHRMf2VhlbjBL6fsT67Dlpqfg+zwuXwJFfH
         pYtGu7mhV4DlPJ4zuqOs8EtijBd1QwIBR9jJZK0uqfTPh9HGm4mq0fy1jr6FDE7ke0Nq
         TwvdW+1dse1HMdAbG/b4sLkkHLQhOC2PLrGdiPZIXqDiJpKo0J5mxOJSSlYooKzWkjzk
         4ZLufACCJHvEjuG3tieup5CP4oOIM1tJfhMs2r8N9HoYV1JjG77ebMLphgvtNTvnlNLU
         R8WSbwFQGXTD9XE/8ySwmO0QqeBMM7zZeAnK1K4xWyi9YlP7bM+N1YcQxfKWnyeoCyNZ
         JwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uERQuHMrCiVGVYZTsCI4txxIlaYaI57nr1rjGf+3GEU=;
        b=B7XIA41sn6hHc07Y7DoZdyoWVbjhBMh/7NQwkKC/ViTNF/aG1/TanGOR2Auo7KFZwi
         ywVUw6lNmGB/UU/uR7hrhgBcnlhuFk+RrXQlzkdP0w4ah+DJecoD7Pj+wn1vNuspNKEF
         joBOZV+ehWZpCH63dGNuSYc4YkTzArpVWePAUqdgLoMz87qvLrxV7o5Mz87mhPy/2sAo
         Ir/LeOAopuUs+se2TnOQxKgdzfFvECO3j1WJzZ/sTh4v+za6wJz+S4m7AjmjtxWJ7h7U
         ceMLn3KpL/Ea19uq6mRcV7y5exdOkHPs3f8fm8GRopASa3z8ztMomp1tllvGSHNeExA4
         MUHw==
X-Gm-Message-State: AIkVDXJzdJMhPfHSL4o2tOoCMAjcjHEFsAhxwym6gVNFKxBhLSp/+Elgs1GCHDddYxmS7gfA
X-Received: by 10.99.227.81 with SMTP id o17mr62722865pgj.69.1482882197875;
        Tue, 27 Dec 2016 15:43:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1aa:810:98b9:be05])
        by smtp.gmail.com with ESMTPSA id s3sm59811051pfg.14.2016.12.27.15.43.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Dec 2016 15:43:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] submodules: add a background story
Date:   Tue, 27 Dec 2016 15:43:10 -0800
Message-Id: <20161227234310.13264-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.196.gee862f456e.dirty
In-Reply-To: <20161227234310.13264-1-sbeller@google.com>
References: <20161227234310.13264-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like gitattributes, gitcredentials, gitnamespaces, gittutorial,
gitmodules, we'd like to provide some background on submodules,
which is not specific to the `submodule` command, but elaborates
on the background and its intended usage.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt |  36 ++------
 Documentation/gitsubmodules.txt | 176 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/gitsubmodules.txt

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 7e03ccc444..c99920aceb 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -23,37 +23,7 @@ DESCRIPTION
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
@@ -405,6 +375,10 @@ This file should be formatted in the same way as `$GIT_DIR/config`. The key
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
index 0000000000..aa5fa25608
--- /dev/null
+++ b/Documentation/gitsubmodules.txt
@@ -0,0 +1,176 @@
+gitsubmodules(5)
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
+Submodules, repositories in other repositories, can be used for different
+use cases:
+
+* To have finer grained access control.
+  The design principles of Git  do not allow for partial repositories to be
+  checked out or transferred. A repository is the smallest unit that a user
+  can be given access to. Submodules are separate repositories, such that
+  you can restrict access to parts of your project via the use of submodules.
+
+* To decouple Git histories.
+  Decoupling histories has different benefits.
+
+  When you want to use a (third party) library tied to a specific version.
+  Using submodules for a library allows you to have a clean history for
+  your own project and only updating the library in the submodule when needed.
+
+  In its current form Git scales up poorly for very large repositories that
+  change a lot, as the history grows very large. For that you may want to look
+  at shallow clone, sparse checkout or git-lfs.
+  However you can also use submodules to e.g. hold large binary assets
+  and these repositories are then shallowly cloned such that you do not
+  have a large history locally.
+
+STATES
+------
+
+Submodules can be in different states, the following indicators are used:
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
+only shown for completeness. The states in detail:
+
+* uninitialized
+  The uninitialized state is the default state if no
+  '--recurse-submodules' / '--recursive'. An empty directory will be put in
+  the working tree as a place holder, such that you are reminded of the
+  existence of the submodule.
+
+  To transition into the initialized state
+  you can use 'git submodule init', which copies the presets from the
+  .gitmodules file into the config.
+
+* initialized
+  Users transitioned from the uninitialized state to this state via
+  'git submodule init', which preset the URL configuration. As these URLs
+  may not be desired in certain scenarios, this state allows to change the
+  URLs.  For example in a corporate environment you may want to run
+
+    sed -i s/github.com/$internal-mirror/ .git/config
+
+  before proceeding to populate the submodules.
+
+* populated
+  In the populated state you have the submodule fully available.
+
+* depopulated
+  In this state you still have the git directory around, but the working tree
+  is gone.  For example when the superproject checks out a revision that doesn't
+  have the submodule, the state changes to depopulated.
+
+* deinitialized
+  The git directory is still there, but the user is no longer interested in the
+  submodule as inidicated by the missing URL configuration.
+
+
+INNER WORKINGS
+--------------
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
+It is also possbile to imagine a future in which a bare repository still
+contains its submodules inside the modules sub directory, such that you can
+get a full clone including submodules from that bare repository, the URLs
+as configured or given in the .gitmodules would only be used as a backup.
+
+SAMPLE WORKFLOWS (RFC/TODO)
+----------------
+Do we need
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
2.11.0.196.gee862f456e.dirty

