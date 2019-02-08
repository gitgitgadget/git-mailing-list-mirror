Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445221F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfBHJFr (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:05:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33294 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfBHJFq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:05:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so1398193pfb.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HEFUm2a4sT5mm8LJnU83g00VJT5v1AEfuPI2vOmnXbY=;
        b=h6QxI2wqrDVaMpJlcm1a2NnFwsLUGJtKQU6SNUT+p0HaW/B7PkC9Ixo3EHUm/J4lUT
         wnWQKyeU99IDiHeZCkeD3cpX960GOBGes6sXyKOMu2kmDxRWMASmAROzzW/3zK+/vipo
         uV6ZAaBfFiD4ujLruH27Ga7H5qEAoM0G5RxKMYcsEbJ/R2Gct1y4+21zmTydQpYJw67V
         7n+Thgp+5Za/yUdJr0XJ5Q+/3Rb+bU4pdj5+aH8FhgyqMzWSTpPZux4FaE46NpVhBYbC
         Y9LqmfVHgxqwL0F7yGRLPFlriaukZtbZ6loA/D28PP7gMudYVXgMonUCUyxUi0wUszyM
         fU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HEFUm2a4sT5mm8LJnU83g00VJT5v1AEfuPI2vOmnXbY=;
        b=U4F096XoDH0fpudBz6oKUgIy/udIzRGfwQLhTe1E3mrCOMa0NmEIbvYED1kqOnWpxt
         jnx0jYiFES+/IjESgiW6jq13uJaGSTo1DPPjhmz1Q1QUHEEJfHI8ENExtE7v0bfRafW0
         7xDf+e3dXHzW8rWOoIkcXJYtTbJ+zGDEhY8QlDY2xjYZeK/LXHKsYW6GaTxuGbE3zCrV
         0aac8Pw7a/YFtno9Pjs9+2pC+eWt8Ed/0JBjX+OOag1RNBf99+MYT4GWt3uN9RnT2U5b
         yzUCr8JZYla9FF+n+yng786ivZQj2t9DnouylTCTW++9WZEuyg1lREw8o3+MiJjnvp+v
         ET3Q==
X-Gm-Message-State: AHQUAubltKNFIZ6ec2TgMzkxFh6KvAT5e8KcgjTEDPwXfQf4YFVY8pGl
        PtMFvOWslMuu/Xv9/22aZzQ=
X-Google-Smtp-Source: AHgI3IYs3tZm9AgZUKf62TUr6hG2RzVISXYSDEzC07L0qCE5H2fNqrhvc3sZO3hgheEWCKm0oqnoSA==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr18834715pgk.21.1549616745768;
        Fri, 08 Feb 2019 01:05:45 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id o13sm2372168pfk.57.2019.02.08.01.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:05:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:05:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/19] switch: no implicit dwim, use --guess to dwim
Date:   Fri,  8 Feb 2019 16:03:57 +0700
Message-Id: <20190208090401.14793-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to automatic detach, this behavior could be confusing because
it can sometimes create a new branch without a user asking it to,
especially when the user is still not aware about this feature.

In the future, perhaps we could have a config key to disable these
safety nets and let 'switch' do automatic detach or dwim
again. But that will be opt-in after the user knows what is what. For
now give a short option if you want to use it often.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 37 ++++++++++++++++++++--------------
 builtin/checkout.c             | 16 +++++++--------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 31c6cbef19..bcb7822c27 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -31,22 +31,13 @@ branch.
 	<branch>.
 +
 If <branch> is not found but there does exist a tracking branch in
-exactly one remote (call it <remote>) with a matching name, treat as
-equivalent to
+exactly one remote (call it <remote>) with a matching name and
+--no-guess is not specified, treat as equivalent to
 +
 ------------
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
-If the branch exists in multiple remotes and one of them is named by
-the `checkout.defaultRemote` configuration variable, we'll use that
-one for the purposes of disambiguation, even if the `<branch>` isn't
-unique across all remotes. Set it to
-e.g. `checkout.defaultRemote=origin` to always checkout remote
-branches from there if `<branch>` is ambiguous but exists on the
-'origin' remote. See also `checkout.defaultRemote` in
-linkgit:git-config[1].
-+
 You could omit <branch>, in which case the command degenerates to
 "check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
@@ -182,6 +173,26 @@ explicitly give a name with `-b` in such a case.
 	Do not set up "upstream" configuration, even if the
 	branch.autoSetupMerge configuration variable is true.
 
+--[no-]guess::
+	If <branch> is not found but there does exist a tracking
+	branch in exactly one remote (call it <remote>) with a
+	matching name, treat as equivalent to
++
+------------
+$ git checkout -b <branch> --track <remote>/<branch>
+------------
++
+If the branch exists in multiple remotes and one of them is named by
+the `checkout.defaultRemote` configuration variable, we'll use that
+one for the purposes of disambiguation, even if the `<branch>` isn't
+unique across all remotes. Set it to
+e.g. `checkout.defaultRemote=origin` to always checkout remote
+branches from there if `<branch>` is ambiguous but exists on the
+'origin' remote. See also `checkout.defaultRemote` in
+linkgit:git-config[1].
++
+Use `--no-guess` to disable this.
+
 -l::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
@@ -284,10 +295,6 @@ Note that this option uses the no overlay mode by default (see also
 	Just like linkgit:git-submodule[1], this will detach the
 	submodules HEAD.
 
---no-guess::
-	Do not attempt to create a branch if a remote tracking branch
-	of the same name exists.
-
 --[no-]overlay::
 	In the default overlay mode, `git checkout` never
 	removes files from the index or the working tree.  When
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a5284391a9..a49ab35b7d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -52,7 +52,7 @@ struct checkout_opts {
 	int show_progress;
 	int count_checkout_paths;
 	int overlay_mode;
-	int no_dwim_new_local_branch;
+	int dwim_new_local_branch;
 	int accept_pathspec;
 	int switch_branch_doing_nothing_is_ok;
 
@@ -1388,8 +1388,6 @@ static struct option *add_common_switch_branch_options(
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_BOOL(0, "no-guess", &opts->no_dwim_new_local_branch,
-			 N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
 		OPT_END()
@@ -1426,7 +1424,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 {
 	struct branch_info new_branch_info;
 	int dwim_remotes_matched = 0;
-	int dwim_new_local_branch;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
@@ -1441,7 +1438,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, options, usagestr,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	dwim_new_local_branch = !opts->no_dwim_new_local_branch;
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
 			opts->show_progress = 0;
@@ -1501,7 +1497,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		struct object_id rev;
 		int dwim_ok =
 			!opts->patch_mode &&
-			dwim_new_local_branch &&
+			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
@@ -1582,12 +1578,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
 		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
+		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
+			 N_("second guess 'git checkout <no-such-branch>' (default)")),
 		OPT_END()
 	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.no_dwim_new_local_branch = 0;
+	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
@@ -1612,12 +1610,14 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 			   N_("create and switch to a new branch")),
 		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and switch to a branch")),
+		OPT_BOOL('g', "guess", &opts.dwim_new_local_branch,
+			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_END()
 	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.no_dwim_new_local_branch = 0;
+	opts.dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
 	opts.implicit_detach = 0;
-- 
2.20.1.682.gd5861c6d90

