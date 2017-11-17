Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC03E202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 16:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759094AbdKQQK0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 11:10:26 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:43355 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759087AbdKQQKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 11:10:25 -0500
Received: by mail-wm0-f46.google.com with SMTP id x63so7460420wmf.2
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lzer6T/jFS5vHhTvprJ6puxzSfNoJa7zcdLpe1DFCB0=;
        b=RVCjimiG83pT9KM+aTh+gKZFZiFLH6g4lRakSOe2bEVgHq8Oa3QdreUcATVHThvXFp
         80l0fUlm0N82la2jc+gxQl9acgE2xz5d21JNoPntV3To7XQ2mKIWm1WNWznwq029FuLN
         4AucWkLSBd7kfQVpPnoHTKio2ATJRzMgRFAJDFLk5EWN6zq0OKEgV16dHii0HsUQHXkS
         bA43jg9a2eJTLPDzWXB+YK7xSxB6xcoIOdqROxzmA+x8xu0amWNqefQkREu4W5f8j/Pt
         oycTgF+F4DBfgnKVs0ZhhRRFSSe4wvjEXBdpxIHuJvZ5jXcQo21VH+Kq1zdXXrCXmFiL
         z+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lzer6T/jFS5vHhTvprJ6puxzSfNoJa7zcdLpe1DFCB0=;
        b=nrMuNPQCgZ4mDMKCZYmYqXU1W84wHYJVwS83iG7XrGrRUv0nPExT247QHvvelS/hye
         Cq27/I8j8yYV5ZyzzY0pO8aoX7v79dnJytFkahqfBUeMqqiTKoLDLNR3COMBAascE96Q
         3+MzCGtXEcrhrAzRyF764n+060BUwOwwj6+lVkD/GGgnOnkR6ONw7pkxLXgzR5TBbWh4
         7GP4awptTF7FXb0G46U/yqYPhz31l8LuaQ/x7v5X6+EWftOrIIMbI1H2lpf5t/2hnoJW
         ZyFbrrehX/Rzc9XNgYholnb4OuViDbTztaXb0OZGfTAa2Xj5g9+chuL0+fv190xZoBlv
         +kiA==
X-Gm-Message-State: AJaThX6oDlw4U6B9GjOOCltCKZqN+QI0J3G0LAg9oUOtle/lTy7s8Sz2
        pcl+x3BKpSfPHmukvSwPmiMTHyHa
X-Google-Smtp-Source: AGs4zMbjYYnbksII147ETiArHLDcTM3de0xnt8R8caBPYKcDJgsfOllMeX9/LOcgMFMe7qXj5EYB/A==
X-Received: by 10.28.156.67 with SMTP id f64mr4367911wme.42.1510935023398;
        Fri, 17 Nov 2017 08:10:23 -0800 (PST)
Received: from dnl-413.univ-lyon1.fr (wifi-ext-0165.univ-lyon1.fr. [134.214.214.166])
        by smtp.gmail.com with ESMTPSA id o190sm4777307wmd.32.2017.11.17.08.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Nov 2017 08:10:22 -0800 (PST)
From:   Daniel Bensoussan <danielbensoussanbohm@gmail.com>
X-Google-Original-From: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
To:     git@vger.kernel.org
Cc:     Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Subject: [PATCH 2/2] Triangular workflow
Date:   Fri, 17 Nov 2017 17:07:59 +0100
Message-Id: <20171117160759.6397-2-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
References: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation about triangular workflow was not clear enough.
So it couldn't be clear enough for someone else. That's why we decided to
change it. Some documentation about triangular workflow already exists.
However, it seems unfortunate that there is no documentation about it in Git.

Based-on-patch-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
---
 Documentation/gitworkflows.txt | 59 +++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 3f1ddba82..4aea16bc0 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -490,7 +490,7 @@ GitHub or GitLab which provide a dedicated mechanism for requesting merges.
 ........................................
 ------------------               -----------------
 | UPSTREAM       |  maintainer   | PUBLISH       |
-|  git/git       |- - - - - - - -|  me/remote    |
+|                |- - - - - - - -|               |
 ------------------      <-       -----------------
               \                     /
                \                   /
@@ -515,7 +515,7 @@ new and the old code, and then send it to a maintainer to commit
 and push it.  This isn't convenient at all, neither for the
 contributor, neither for the maintainer. With the triangular
 workflow, the contributors have the write access on **PUBLISH**
-so they don't have to pass upon maintainer(s).  And only the
+so they don't need maintainer(s) approval to write code.  And only the
 maintainer(s) can push from **PUBLISH** to **UPSTREAM**.
 This is called a distributed workflow (See "DISTRIBUTED WORKFLOWS"
 above).
@@ -526,13 +526,13 @@ The goal of the triangular workflow is also that the rest of the
 community or the company can review the code before it's in production.
 Everyone can read on **PUBLISH** so everyone can review code
 before the maintainer(s) merge it to **UPSTREAM**.  It also means
-that, in a free software, anyone can propose code without danger
+that, in free software, anyone can propose code without danger
 for the stability of the software.
 
 * Encourages clean history by using `rebase -i` and `push --force` to
 the public fork before the code is merged.
 
-This is just a side-effect of the "review before merge" mentionned
+This is just a side-effect of the "review before merge" mentioned
 above but this is still a good point.
 
 
@@ -543,18 +543,20 @@ workflow.
 Preparation as a contributor
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Cloning from **PUBLISH**, which is a fork of **UPSTREAM** or an empty
-repository.
+Cloning from **UPSTREAM**.
 
 ======================
-`git clone <PUBLISH_url>`
+`git clone <UPSTREAM_url>`
 ======================
 
-Setting the behavior of push for the triangular workflow:
+If **PUBLISH** doesn't exist, a contributor can publish his own repository.
+**PUBLISH** contains modifications before integration.
 
-===========================
-`git config push.default current`
-===========================
+============================
+`git clone <UPSTREAM_url>`
+`git remote add **PUBLISH**`
+`git push`
+============================
 
 Adding **UPSTREAM** remote:
 
@@ -576,12 +578,6 @@ Example with master as <branch>:
 * `git config branch.master.pushRemote origin`
 ===================================
 
-Staying up-to-date
-~~~~~~~~~~~~~~~~~~
-
-Retrieve updates from **UPSTREAM** with `git pull` and send them to
-**PUBLISH** with `git push`.
-
 Making your work available
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -590,20 +586,19 @@ the **UPSTREAM** thanks to the configuration you did earlier with the
 `git config remote.pushdefault origin` command.
 
 When a contributor pushes something, the `git config push.default
-current` command can be used to specifies that the name of the
+current` command can be used to specify that the name of the
 **PUBLISH** branch is the same as the name of the **LOCAL** one.
 
-.Display the push remote's name:
+.Display the name of the push remote:
 [caption="Recipe: "]
 
-=================================
-`git rev-parse --abbrev-ref @{push}`
-=================================
-
 The shorthand `<branch>@{push}` denotes the remote-tracking branch
 where the <branch> would be pushed to. If no <branch> is specified
 (`@{push}`), <branch> takes the value of the current branch.
 
+=================================
+`git rev-parse --abbrev-ref @{push}`
+=================================
 
 .Display the fetch remote's name:
 [caption="Recipe: "]
@@ -630,6 +625,12 @@ takes the value of the current branch.
 `git log <branch_name>@{push}..`
 ============================
 
+Staying up-to-date
+~~~~~~~~~~~~~~~~~~
+
+Retrieve updates from **UPSTREAM** with `git pull` and send them to
+**PUBLISH** with `git push`.
+
 Alternatively
 ~~~~~~~~~~~~~
 
@@ -662,16 +663,8 @@ Adding **PUBLISH** remote:
 ===================================
 
 With the `remote add` above, using `git push publish` pushes there,
-instead of saying its URL. In addition, `git push` can push to
-**PUBLISH** without argument.
-
-'Method 1: One option for all branches'
-
-===================================
-`git config remote.pushDefault publish`
-===================================
-
-'Method 2: Each branch its option'
+instead of saying its URL. In addition, `git push` without argument
+pushes to **PUBLISH**.
 
 Example with master as <branch>:
 ===================================
-- 
2.11.0

