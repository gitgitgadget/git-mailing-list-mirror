Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E53202BB
	for <e@80x24.org>; Fri, 29 Mar 2019 10:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfC2KmC (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:42:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33780 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfC2KmC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so885479pfd.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F69+5ORUv1QF0DlfIbtB7cnZ5djCWKwj7wr6cTbNHbg=;
        b=jfwxu79SRiL1LQgoaRPEZ5SRgVm81ODNRwlS6RLlr6SUr4/tiEsgy1Cdu2sXFSTZcY
         bxn4lclmOkG+jhGRzDBb7xTo46Zrqhp58v7UomEQpoDT+hs3Fp1lwvg3y0X+wTz9qDXS
         4c9yQMqrWTX+GWz8/fsv5MEC801PEFlnoZSFPRhZ5MxFOh+o3XglwlGdINmZ+lx/o0VQ
         FROMph/sU7iRekBmwodnCwqc/qpVmVdkzxB9djczqDPpTvvtTz71pJQp4GKOstbv9Asx
         va1ilThdxHSoecngi76k0wfsMlxaFkR7wLlu7ljQ4y6e5SMCuk917gSgcNP2PADoMfPc
         wIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F69+5ORUv1QF0DlfIbtB7cnZ5djCWKwj7wr6cTbNHbg=;
        b=MFYjnX06MFeXS+hAnkO8mco9S6zQAc+A9POZsJxpaS0xSC6ivQrT+Dwk+KuIoO037e
         q3Z6+mSLX23WrrRG4fuR8IfDlavGOCsY7D7qmP5YolbrSJo2Q2iv5VBofA69VCItppbW
         IwM1PDGblKlQmMerg5vGPYVXSs27LfXFxMQHvx6dCClc14/l5saRiiGjEYSGxG4A5y30
         gFRgO8NI2H6PZeY9sTNxgNxIOr5X5mVeGdxL9N1G6NZnUwdw0UffE9wpsD3C4VWa0LGZ
         epXA2gsUbkEUGt3wFN9p6gDdMSRrhB54vWOmdcRxkndWvD20xXHAWRaqzZgDY8pNErkr
         06kA==
X-Gm-Message-State: APjAAAUjH88BYPx2V28m6MDhSY29/y3Foe0rqJqHhCzFAZjJxuz8+Wvp
        rJ2Te/lXx9DZmC1CsGrHmbU=
X-Google-Smtp-Source: APXvYqxnzHHmnHURXkXtOdrewQD7vGuOTkszHmW7y5fCKVwt9l09R/rHRogJiqVar7leceUSBhaNHw==
X-Received: by 2002:a65:47c6:: with SMTP id f6mr27760693pgs.173.1553856120972;
        Fri, 29 Mar 2019 03:42:00 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id h8sm2382371pfo.149.2019.03.29.03.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:42:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:41:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 21/27] switch: implicit dwim, use --no-guess to disable it
Date:   Fri, 29 Mar 2019 17:39:13 +0700
Message-Id: <20190329103919.15642-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is already the default in git-checkout. The real change in here is
just minor cleanup. The main excuse is to explain why dwim is kept default.

Contrary to detach mode that is easy to get into and confusing to get
back out. Automatically creating a tracking branch often does not kick
in as often (you would need a branch of the same name on a remote). And
since the branch creation is reported clearly, the user should be able
to undo/delete it if it's unwanted.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 38 ++++++++++++++++++++--------------
 builtin/checkout.c             | 16 +++++++-------
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c7192bdefe..58f18a0842 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -31,22 +31,13 @@ branch.
 	`<branch>`.
 +
 If `<branch>` is not found but there does exist a tracking branch in
-exactly one remote (call it `<remote>`) with a matching name, treat as
-equivalent to
+exactly one remote (call it `<remote>`) with a matching name and
+`--no-guess` is not specified, treat as equivalent to
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
 You could omit `<branch>`, in which case the command degenerates to
 "check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
@@ -183,6 +174,27 @@ explicitly give a name with `-b` in such a case.
 	Do not set up "upstream" configuration, even if the
 	`branch.autoSetupMerge` configuration variable is true.
 
+--guess::
+--no-guess::
+	If `<branch>` is not found but there does exist a tracking
+	branch in exactly one remote (call it `<remote>`) with a
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
@@ -287,10 +299,6 @@ Note that this option uses the no overlay mode by default (see also
 	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
 	submodule.
 
---no-guess::
-	Do not attempt to create a branch if a remote tracking branch
-	of the same name exists.
-
 --overlay::
 --no-overlay::
 	In the default overlay mode, `git checkout` never
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 11308ab80c..ff9b96993d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -53,7 +53,7 @@ struct checkout_opts {
 	int show_progress;
 	int count_checkout_paths;
 	int overlay_mode;
-	int no_dwim_new_local_branch;
+	int dwim_new_local_branch;
 	int discard_changes;
 	int accept_pathspec;
 	int switch_branch_doing_nothing_is_ok;
@@ -1430,8 +1430,6 @@ static struct option *add_common_switch_branch_options(
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_BOOL(0, "no-guess", &opts->no_dwim_new_local_branch,
-			 N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
 		OPT_END()
@@ -1468,7 +1466,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 {
 	struct branch_info new_branch_info;
 	int dwim_remotes_matched = 0;
-	int dwim_new_local_branch;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
@@ -1483,7 +1480,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, options, usagestr,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	dwim_new_local_branch = !opts->no_dwim_new_local_branch;
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
 			opts->show_progress = 0;
@@ -1545,7 +1541,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		struct object_id rev;
 		int dwim_ok =
 			!opts->patch_mode &&
-			dwim_new_local_branch &&
+			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
@@ -1626,12 +1622,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
@@ -1656,6 +1654,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 			   N_("create and switch to a new branch")),
 		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and switch to a branch")),
+		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
+			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
 			 N_("throw away local modifications")),
 		OPT_END()
@@ -1663,7 +1663,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.no_dwim_new_local_branch = 0;
+	opts.dwim_new_local_branch = 1;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
 	opts.implicit_detach = 0;
-- 
2.21.0.479.g47ac719cd3

