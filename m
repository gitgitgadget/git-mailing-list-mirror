Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8817C1F406
	for <e@80x24.org>; Thu, 14 Dec 2017 10:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbdLNKsT (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 05:48:19 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:43477 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdLNKsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 05:48:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 9790AA0151;
        Thu, 14 Dec 2017 11:48:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kzwTcVeAFYMt; Thu, 14 Dec 2017 11:48:13 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id D9FCBA00DC;
        Thu, 14 Dec 2017 11:48:13 +0100 (CET)
Received: from dnl-413.univ-lyon1.fr (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Thu, 14 Dec 2017 11:48:13 +0100
From:   Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
To:     <git@vger.kernel.org>
CC:     Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Subject: [PATCH v2] doc: add triangular workflow
Date:   Thu, 14 Dec 2017 11:48:00 +0100
Message-ID: <20171214104800.4998-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: BPMBX2013-01.univ-lyon1.fr (134.214.201.243) To
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Added a new file about triangular workflow for a clearer organization.

With a more precise documentation, any new Git contributors
will spend less time on understanding this doc and the way Git works.

Based-on-patch-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
---
 Documentation/Makefile                    |   1 +
 Documentation/git-triangular-workflow.txt | 221 ++++++++++++++++++++++++++++++
 Documentation/git.txt                     |   2 +-
 Documentation/gittutorial.txt             |   1 +
 Documentation/gitworkflows.txt            |   1 +
 5 files changed, 225 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-triangular-workflow.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2ab6556..c3e98c7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -10,6 +10,7 @@ OBSOLETE_HTML =
 MAN1_TXT += $(filter-out \
 		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt))
+MAN1_TXT += git-triangular-workflow.txt
 MAN1_TXT += git.txt
 MAN1_TXT += gitk.txt
 MAN1_TXT += gitremote-helpers.txt
diff --git a/Documentation/git-triangular-workflow.txt b/Documentation/git-triangular-workflow.txt
new file mode 100644
index 0000000..ee599b7
--- /dev/null
+++ b/Documentation/git-triangular-workflow.txt
@@ -0,0 +1,221 @@
+git-triangular-workflow(1)
+==========================
+
+NAME
+----
+git-triangular-workflow - An overview of the triangular workflow with Git
+
+
+SYNOPSIS
+--------
+[verse]
+git *
+
+
+DESCRIPTION
+-----------
+
+In some projects, contributors cannot push directly to the project but
+have to suggest their commits to the maintainer (e.g. pull requests).
+For these projects, it's common to use what's called a *triangular
+workflow*:
+
+- The project maintainer publishes a repository, called **UPSTREAM** in
+this document, which is a read-only for contributors. They can clone and
+fetch from this repository.
+- Contributors publish their modifications by pushing to a repository,
+called **PUBLISH** in this document, and request a merge.
+- Opening a pull request
+- If the maintainers accepts the changes, they merge them into the
+  **UPSTREAM** repository.
+
+This workflow is commonly used on different platforms like BitBucket,
+GitHub or GitLab which provide a dedicated mechanism for requesting merges.
+
+........................................
+------------------               -----------------
+| UPSTREAM       |  maintainer   | PUBLISH       |
+|                |- - - - - - - -|               |
+------------------      <-       -----------------
+              \                     /
+               \                   /
+        fetch | \                 / ^ push
+              v  \               /  |
+                  \             /
+                   -------------
+                   |   LOCAL   |
+                   -------------
+........................................
+
+Motivations
+~~~~~~~~~~~
+
+* Allows contributors to work with Git even if they don't have
+write access to **UPSTREAM**.
+
+With the triangular workflow, the contributors have the write 
+access on **PUBLISH** and push their code there.  Only the
+maintainers merge from **PUBLISH** to **UPSTREAM**.
+
+* Code review is made before integration.
+
+In a triangular workflow the rest of the community or the company
+can review the code before it's in production. Everyone can read on
+**PUBLISH** so everyone can review code before the maintainer merge
+it to **UPSTREAM**.  In a free software, anyone can
+propose code.  Reviewers accept the code when everyone agree
+with it.
+
+* Encourages clean history by using `rebase -i` and `push --force` to
+the public fork before the code is merged.
+
+This is just a side-effect of the "review before merge" mentioned
+above but this is still a good point.
+
+
+Here are the configuration variables you will need to arrange your
+workflow.
+
+Preparation as a contributor
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Cloning from **UPSTREAM**.
+
+======================
+`git clone <UPSTREAM_url>`
+======================
+
+If **PUBLISH** doesn't exist, a contributor can publish his own repository.
+**PUBLISH** contains modifications before integration.
+
+============================
+* `git clone <UPSTREAM_url>`
+* `git remote add **PUBLISH**`
+* `git push`
+============================
+
+Adding **UPSTREAM** remote:
+
+===================================
+`git remote add upstream <UPSTREAM_url>`
+===================================
+
+With the `remote add` above, using `git pull upstream` pulls there,
+instead of saying its URL. In addition, the `git pull` command
+(without argument) can be used to pull from **UPSTREAM**.
+
+For each branch requiring a triangular workflow, set
+`branch.<branch>.remote` and `branch.<branch>.pushRemote` to set up
+the **UPSTREAM** and **PUBLISH** repositories.
+
+Example with master as <branch>:
+===================================
+* `git config branch.master.remote upstream`
+* `git config branch.master.pushRemote origin`
+===================================
+
+Making your work available
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The `git push` command sends commits to the **PUBLISH** repository and not to
+the **UPSTREAM** thanks to the configuration you did earlier with the
+`git config remote.pushdefault origin` command.
+
+When a contributor pushes something, the `git config push.default
+current` command can be used to specify that the name of the
+**PUBLISH** branch is the same as the name of the **LOCAL** one.
+
+.Display the name of the push remote:
+[caption="Recipe: "]
+
+The shorthand `<branch>@{push}` denotes the remote-tracking branch
+where the <branch> would be pushed to. If no <branch> is specified
+(`@{push}`), <branch> takes the value of the current branch.
+
+=================================
+`git rev-parse --abbrev-ref @{push}`
+=================================
+
+.Display the fetch remote's name:
+[caption="Recipe: "]
+
+===================================
+`git rev-parse --abbrev-ref @{upstream}`
+===================================
+
+The shorthand `<branch>@{upstream}` substitutes the upstream name of
+the branch. If no <branch> is specified (`@{upstream}`), <branch>
+takes the value of the current branch.
+
+.Display commits added to the current branch since last push:
+[caption="Recipe: "]
+
+===============
+`git log @{push}..`
+===============
+
+.Display commits added to a specific branch since last push:
+[caption="Recipe: "]
+
+============================
+`git log <branch_name>@{push}..`
+============================
+
+Staying up-to-date
+~~~~~~~~~~~~~~~~~~
+
+Retrieve updates from **UPSTREAM** with `git pull` and send them to
+**PUBLISH** with `git push`.
+
+Alternatively
+~~~~~~~~~~~~~
+
+Cloning from **UPSTREAM**
+[caption="Recipe: "]
+
+In the preparation above, a clone from **PUBLISH** was used. Starting
+with a clone of **UPSTREAM** is possible too.
+
+Cloning from **UPSTREAM**
+
+======================
+`git clone <UPSTREAM_url>`
+======================
+
+Setting the behavior of push for the triangular workflow:
+
+===========================
+`git config push.default current`
+===========================
+
+Because modifications will be often pushed into the **PUBLISH** repository,
+instead of having to type its URL every time, a short name can be used
+to call it.
+
+Adding **PUBLISH** remote:
+
+===================================
+`git remote add publish <PUBLISH_url>`
+===================================
+
+With the `remote add` above, using `git push publish` pushes there,
+instead of saying its URL. In addition, `git push` without argument
+pushes to **PUBLISH**.
+
+Example with master as <branch>:
+===================================
+`git config branch.master.pushRemote publish`
+===================================
+
+
+SEE ALSO
+--------
+linkgit:gitworkflows[7],
+linkgit:git-push[1],
+linkgit:git-pull[1],
+linkgit:git-merge[1],
+linkgit:git-rebase[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 483a1f3..3641824 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -831,7 +831,7 @@ linkgit:gittutorial[7], linkgit:gittutorial-2[7],
 linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
 linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
-linkgit:gitworkflows[7]
+linkgit:gitworkflows[7], linkgit:git-triangular-workflow.txt[1]
 
 GIT
 ---
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 242de31..cc08b21 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -669,6 +669,7 @@ linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
 linkgit:git-help[1],
 linkgit:gitworkflows[7],
+linkgit:git-triangular-workflow.txt[1],
 linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 02569d0..c52ee4a 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -467,6 +467,7 @@ other options.
 SEE ALSO
 --------
 linkgit:gittutorial[7],
+linkgit:git-triangular-workflow.txt[1],
 linkgit:git-push[1],
 linkgit:git-pull[1],
 linkgit:git-merge[1],
-- 
2.11.0

