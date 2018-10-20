Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0FF91F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeJTUt3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38696 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeJTUt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id k11-v6so1112140lja.5
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2zm1QOPFGoZh+KGHhYpMbDfPMoFbSl+O7+U238Qp+4=;
        b=Bpe6D/7w2DA23UaGmSAushaF16aWkGgT2odiG+Aa8eFEqSSK0WuntmC9JJF3pMD6tJ
         VD2rJFP8ILgZXnel56GayGolzBgUq7rIFO2QIptt2pkuqTOVO2Sm9eKFrXawlSvGamR4
         msIPw0rZ/LdFin4gd9Z+5JCnnBMYN1/AdGaLUfHHrqUNO3Sm0IPCGWR6kHeyQ+NNGx9Q
         9bxB1C9pFNSP8EG1pZKeCVe9QldvwB0xNDBQPgf8HctFl6Zv/y+epu2PsVCqh4tu+WqN
         yCcfYTQwken8N9CTg1qNuctsC7E10bLtTHXpSwKkABRk+gEr3Kl8fYLGfv/1Eue45Iwg
         H2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2zm1QOPFGoZh+KGHhYpMbDfPMoFbSl+O7+U238Qp+4=;
        b=cGQDkjs0NxreMmf2B1wWRMVCJjQ++BzmLYJvEyIWzz3PZPGvfB5/cV72WdodSTGkBU
         JHaYHgxADimYpTJ+18uH9qG8iafaXrDZeyhGBZfz3Yj/cWnPWShXDv9Wl6RlMU0CrUOs
         Y0asx427Wl1BqlHOUgRySpoEd4TVhNSt5wURsCrLdEOd38XhPIeu/xMT/XGbGPRmd5HU
         5QtSkBQrVZ3yNF/mdylWDymDnRNiK+NyWAE1grwPv19xwiVdK/mYzqnkFh+d4HZl3hCQ
         1P6fm9t/YZS+yc7g3zQufN/KgHQq2PwB0rhheYoh1QWbJWzRuHicsReDxqrtX1tMBhOj
         KjPA==
X-Gm-Message-State: ABuFfog8a99gGpm67nTMiLrxb2pv2dt1sncMpUk7us+NmsJRWmXO55dX
        +2L6Ol4/tf5CMjAyq34jrWc6vzoC
X-Google-Smtp-Source: ACcGV62lngGLid3eE9JEpm8Sgwz2OICj21pUhS+LAZcJdih1cDvkKQpuifl/Hjoo7TKmW4XtVsu0fw==
X-Received: by 2002:a2e:52ca:: with SMTP id n71-v6mr24361876lje.54.1540039145447;
        Sat, 20 Oct 2018 05:39:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/59] config.txt: move branch.* to a separate file
Date:   Sat, 20 Oct 2018 14:37:57 +0200
Message-Id: <20181020123848.2785-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/branch-config.txt | 102 +++++++++++++++++++++++++++++++
 Documentation/config.txt        | 103 +-------------------------------
 2 files changed, 103 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/branch-config.txt

diff --git a/Documentation/branch-config.txt b/Documentation/branch-config.txt
new file mode 100644
index 0000000000..019d60ede2
--- /dev/null
+++ b/Documentation/branch-config.txt
@@ -0,0 +1,102 @@
+branch.autoSetupMerge::
+	Tells 'git branch' and 'git checkout' to set up new branches
+	so that linkgit:git-pull[1] will appropriately merge from the
+	starting point branch. Note that even if this option is not set,
+	this behavior can be chosen per-branch using the `--track`
+	and `--no-track` options. The valid settings are: `false` -- no
+	automatic setup is done; `true` -- automatic setup is done when the
+	starting point is a remote-tracking branch; `always` --
+	automatic setup is done when the starting point is either a
+	local branch or remote-tracking
+	branch. This option defaults to true.
+
+branch.autoSetupRebase::
+	When a new branch is created with 'git branch' or 'git checkout'
+	that tracks another branch, this variable tells Git to set
+	up pull to rebase instead of merge (see "branch.<name>.rebase").
+	When `never`, rebase is never automatically set to true.
+	When `local`, rebase is set to true for tracked branches of
+	other local branches.
+	When `remote`, rebase is set to true for tracked branches of
+	remote-tracking branches.
+	When `always`, rebase will be set to true for all tracking
+	branches.
+	See "branch.autoSetupMerge" for details on how to set up a
+	branch to track another branch.
+	This option defaults to never.
+
+branch.sort::
+	This variable controls the sort ordering of branches when displayed by
+	linkgit:git-branch[1]. Without the "--sort=<value>" option provided, the
+	value of this variable will be used as the default.
+	See linkgit:git-for-each-ref[1] field names for valid values.
+
+branch.<name>.remote::
+	When on branch <name>, it tells 'git fetch' and 'git push'
+	which remote to fetch from/push to.  The remote to push to
+	may be overridden with `remote.pushDefault` (for all branches).
+	The remote to push to, for the current branch, may be further
+	overridden by `branch.<name>.pushRemote`.  If no remote is
+	configured, or if you are not on any branch, it defaults to
+	`origin` for fetching and `remote.pushDefault` for pushing.
+	Additionally, `.` (a period) is the current local repository
+	(a dot-repository), see `branch.<name>.merge`'s final note below.
+
+branch.<name>.pushRemote::
+	When on branch <name>, it overrides `branch.<name>.remote` for
+	pushing.  It also overrides `remote.pushDefault` for pushing
+	from branch <name>.  When you pull from one place (e.g. your
+	upstream) and push to another place (e.g. your own publishing
+	repository), you would want to set `remote.pushDefault` to
+	specify the remote to push to for all branches, and use this
+	option to override it for a specific branch.
+
+branch.<name>.merge::
+	Defines, together with branch.<name>.remote, the upstream branch
+	for the given branch. It tells 'git fetch'/'git pull'/'git rebase' which
+	branch to merge and can also affect 'git push' (see push.default).
+	When in branch <name>, it tells 'git fetch' the default
+	refspec to be marked for merging in FETCH_HEAD. The value is
+	handled like the remote part of a refspec, and must match a
+	ref which is fetched from the remote given by
+	"branch.<name>.remote".
+	The merge information is used by 'git pull' (which at first calls
+	'git fetch') to lookup the default branch for merging. Without
+	this option, 'git pull' defaults to merge the first refspec fetched.
+	Specify multiple values to get an octopus merge.
+	If you wish to setup 'git pull' so that it merges into <name> from
+	another branch in the local repository, you can point
+	branch.<name>.merge to the desired branch, and use the relative path
+	setting `.` (a period) for branch.<name>.remote.
+
+branch.<name>.mergeOptions::
+	Sets default options for merging into branch <name>. The syntax and
+	supported options are the same as those of linkgit:git-merge[1], but
+	option values containing whitespace characters are currently not
+	supported.
+
+branch.<name>.rebase::
+	When true, rebase the branch <name> on top of the fetched branch,
+	instead of merging the default branch from the default remote when
+	"git pull" is run. See "pull.rebase" for doing this in a non
+	branch-specific manner.
++
+When `merges`, pass the `--rebase-merges` option to 'git rebase'
+so that the local merge commits are included in the rebase (see
+linkgit:git-rebase[1] for details).
++
+When preserve, also pass `--preserve-merges` along to 'git rebase'
+so that locally committed merge commits will not be flattened
+by running 'git pull'.
++
+When the value is `interactive`, the rebase is run in interactive mode.
++
+*NOTE*: this is a possibly dangerous operation; do *not* use
+it unless you understand the implications (see linkgit:git-rebase[1]
+for details).
+
+branch.<name>.description::
+	Branch description, can be edited with
+	`git branch --edit-description`. Branch description is
+	automatically added in the format-patch cover letter or
+	request-pull summary.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 910dcf1c25..249b90b107 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -301,108 +301,7 @@ include::apply-config.txt[]
 
 include::blame-config.txt[]
 
-branch.autoSetupMerge::
-	Tells 'git branch' and 'git checkout' to set up new branches
-	so that linkgit:git-pull[1] will appropriately merge from the
-	starting point branch. Note that even if this option is not set,
-	this behavior can be chosen per-branch using the `--track`
-	and `--no-track` options. The valid settings are: `false` -- no
-	automatic setup is done; `true` -- automatic setup is done when the
-	starting point is a remote-tracking branch; `always` --
-	automatic setup is done when the starting point is either a
-	local branch or remote-tracking
-	branch. This option defaults to true.
-
-branch.autoSetupRebase::
-	When a new branch is created with 'git branch' or 'git checkout'
-	that tracks another branch, this variable tells Git to set
-	up pull to rebase instead of merge (see "branch.<name>.rebase").
-	When `never`, rebase is never automatically set to true.
-	When `local`, rebase is set to true for tracked branches of
-	other local branches.
-	When `remote`, rebase is set to true for tracked branches of
-	remote-tracking branches.
-	When `always`, rebase will be set to true for all tracking
-	branches.
-	See "branch.autoSetupMerge" for details on how to set up a
-	branch to track another branch.
-	This option defaults to never.
-
-branch.sort::
-	This variable controls the sort ordering of branches when displayed by
-	linkgit:git-branch[1]. Without the "--sort=<value>" option provided, the
-	value of this variable will be used as the default.
-	See linkgit:git-for-each-ref[1] field names for valid values.
-
-branch.<name>.remote::
-	When on branch <name>, it tells 'git fetch' and 'git push'
-	which remote to fetch from/push to.  The remote to push to
-	may be overridden with `remote.pushDefault` (for all branches).
-	The remote to push to, for the current branch, may be further
-	overridden by `branch.<name>.pushRemote`.  If no remote is
-	configured, or if you are not on any branch, it defaults to
-	`origin` for fetching and `remote.pushDefault` for pushing.
-	Additionally, `.` (a period) is the current local repository
-	(a dot-repository), see `branch.<name>.merge`'s final note below.
-
-branch.<name>.pushRemote::
-	When on branch <name>, it overrides `branch.<name>.remote` for
-	pushing.  It also overrides `remote.pushDefault` for pushing
-	from branch <name>.  When you pull from one place (e.g. your
-	upstream) and push to another place (e.g. your own publishing
-	repository), you would want to set `remote.pushDefault` to
-	specify the remote to push to for all branches, and use this
-	option to override it for a specific branch.
-
-branch.<name>.merge::
-	Defines, together with branch.<name>.remote, the upstream branch
-	for the given branch. It tells 'git fetch'/'git pull'/'git rebase' which
-	branch to merge and can also affect 'git push' (see push.default).
-	When in branch <name>, it tells 'git fetch' the default
-	refspec to be marked for merging in FETCH_HEAD. The value is
-	handled like the remote part of a refspec, and must match a
-	ref which is fetched from the remote given by
-	"branch.<name>.remote".
-	The merge information is used by 'git pull' (which at first calls
-	'git fetch') to lookup the default branch for merging. Without
-	this option, 'git pull' defaults to merge the first refspec fetched.
-	Specify multiple values to get an octopus merge.
-	If you wish to setup 'git pull' so that it merges into <name> from
-	another branch in the local repository, you can point
-	branch.<name>.merge to the desired branch, and use the relative path
-	setting `.` (a period) for branch.<name>.remote.
-
-branch.<name>.mergeOptions::
-	Sets default options for merging into branch <name>. The syntax and
-	supported options are the same as those of linkgit:git-merge[1], but
-	option values containing whitespace characters are currently not
-	supported.
-
-branch.<name>.rebase::
-	When true, rebase the branch <name> on top of the fetched branch,
-	instead of merging the default branch from the default remote when
-	"git pull" is run. See "pull.rebase" for doing this in a non
-	branch-specific manner.
-+
-When `merges`, pass the `--rebase-merges` option to 'git rebase'
-so that the local merge commits are included in the rebase (see
-linkgit:git-rebase[1] for details).
-+
-When preserve, also pass `--preserve-merges` along to 'git rebase'
-so that locally committed merge commits will not be flattened
-by running 'git pull'.
-+
-When the value is `interactive`, the rebase is run in interactive mode.
-+
-*NOTE*: this is a possibly dangerous operation; do *not* use
-it unless you understand the implications (see linkgit:git-rebase[1]
-for details).
-
-branch.<name>.description::
-	Branch description, can be edited with
-	`git branch --edit-description`. Branch description is
-	automatically added in the format-patch cover letter or
-	request-pull summary.
+include::branch-config.txt[]
 
 browser.<tool>.cmd::
 	Specify the command to invoke the specified browser. The
-- 
2.19.1.647.g708186aaf9

