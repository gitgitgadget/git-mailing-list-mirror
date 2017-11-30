Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2751320954
	for <e@80x24.org>; Thu, 30 Nov 2017 09:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbdK3JnP (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 04:43:15 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40637 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdK3JnN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 04:43:13 -0500
Received: by mail-wm0-f52.google.com with SMTP id v19so11167713wmh.5
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H+4ilQaVaGUjCTg3+gNx2tJhkoNAq33mKZWbD4tijDE=;
        b=posc8CMzffAjJcJtNtdeqbRCbBXSVqP8ibjXHwXHGGrmxO8aiD8IZdf4ewk80r/MyO
         Aw3/gwoAZrzxoOcY0GgOatHeAZA2qcHQG3HLM1O+ZDGbHHp01cUAyg0+UeEEoaXaLeOs
         VSL/hzXxDr57eSx9mZGrphcfwjAHdRzkfulSoE60EazAJN5jiFIfkgaeDJ0JnFyLUp6b
         KfgleS0KBKXgGCiYXFrJZG5AiDvLp+KzWE5F4bLri/edNjNrER9g4+h/1hBuEcvoeV4z
         mQiOlLqajkQidmOG+qbJlmEivaVQ7uBOjJSGwkPlLSDk7qh33NDGm6fLdq/NcrRZg5GT
         64pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H+4ilQaVaGUjCTg3+gNx2tJhkoNAq33mKZWbD4tijDE=;
        b=n+YXFPuJ0IJDSkcQJDQKqhUMgNsS0AET8F1jjOZQRiHSYgQac9Xs1HS/XYzc/JOPYI
         tZaZyJgcBGe1AQrfjzh92QJWiEJxvQQVwX+PAwksePLYrE3Gh0iIBWYFTMd/uZzPPJK6
         LSepghhDd8mlmW7hhtJz1mujO3eYdQ85767MiMVQpzO7qES3igoJfUTmH6FrTOhyL1ST
         k30WDLJNyOhPcDn/WyfLEoiwg3mVh3WOtk6UU/97UhdvzHiviehCiGvwZ5E09RDoMU8t
         Veqf1zewXO9j+1VEkEfRDuyzveNIN5myKPvDTpdWVSvymCbPM4yEnxbavFnOpNaa9tbl
         a64Q==
X-Gm-Message-State: AJaThX4S6i/ANk+/dMSZQGG756majP86UeGRx47geEz3LTh/khD6sYNe
        hqooPKVKzZRa/qxPGUA++X3XYQ==
X-Google-Smtp-Source: AGs4zMY87QOB7O7JtQjEKjemPpCH0TB1ei2SKyoqmMSCfiQEJ9C16gWH7QIrZ48aS5dySFyxLgpnVw==
X-Received: by 10.28.52.81 with SMTP id b78mr27542wma.70.1512034991070;
        Thu, 30 Nov 2017 01:43:11 -0800 (PST)
Received: from Boby.univ-lyon1.fr (wifi-ext-0227.univ-lyon1.fr. [134.214.214.228])
        by smtp.gmail.com with ESMTPSA id j125sm8479748wmf.24.2017.11.30.01.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Nov 2017 01:43:10 -0800 (PST)
From:   Timothee Albertin <timothee.albertin@gmail.com>
X-Google-Original-From: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
To:     git@vger.kernel.org
Cc:     Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Subject: [PATCH] doc: clarify triangular workflow
Date:   Thu, 30 Nov 2017 10:42:12 +0100
Message-Id: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changed the documentation about the triangular workflow because it was
not clear enough for a new contributor.

With a clearer and more precise documentation, any new Git contributors
will spend less time on understanding this doc and the way Git works.

Based-on-patch-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
---
 Documentation/gitworkflows.txt | 203 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 02569d0..21f6dc8 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -407,8 +407,8 @@ follows.
 `git pull <url> <branch>`
 =====================================
 
-Occasionally, the maintainer may get merge conflicts when he tries to
-pull changes from downstream.  In this case, he can ask downstream to
+Occasionally, the maintainers may get merge conflicts when they try to
+pull changes from downstream.  In this case, they can ask downstream to
 do the merge and resolve the conflicts themselves (perhaps they will
 know better how to resolve them).  It is one of the rare cases where
 downstream 'should' merge from upstream.
@@ -464,6 +464,205 @@ in patches to figure out the merge base.  See linkgit:git-am[1] for
 other options.
 
 
+TRIANGULAR WORKFLOW
+-------------------
+
+Introduction
+~~~~~~~~~~~~
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
+- If the maintainers accept the changes, they merge them into the
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
+* Code review is done before integration.
+
+In a triangular workflow the rest of the community or the company
+can review the code before it's in production. Everyone can read on
+**PUBLISH** so everyone can review code before the maintainer merge
+it to **UPSTREAM**.  In free software, anyone can
+propose code.  Reviewers accept the code when everyone agrees
+with it.
+
+* Encourages clean history by using `rebase -i` and `push --force` to
+the public fork before the code is merged.
+
+This is just a side-effect of the "review before merge" mentioned
+above, but this is still a good point.
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
+* `git remote add <PUBLISH>`
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
+where the <branch> would be pushed to. If no <branch> is specified,
+<branch> takes the value of the current branch.
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
+the branch. If no <branch> is specified, <branch> takes the value of
+the current branch.
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
 SEE ALSO
 --------
 linkgit:gittutorial[7],
-- 
2.7.4

