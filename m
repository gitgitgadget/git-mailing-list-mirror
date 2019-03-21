Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C7320248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfCUNTa (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:19:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36244 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfCUNTa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:19:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id p10so4289535pff.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T3FuHFvANgiRp+vQnd8WT0MBmLeTtTgAjorjAoWT8bY=;
        b=jZoAkWkD+T9dVpD9eNmafQXSILKt4YwKsOS4bBQRD4KhFxWC7VD4NUHWYn1McwJr/L
         mCgQW0ouSh+Nm6F2IQlcnGlgsy8EQ4G6V4tXdme1W1MKs/gGeFwagX5ah3r0JFHr3qSH
         t/Xmkw4fYvKjWWC6er3T2vt3GlX8Hq4H6kaeLLUQ0fU4208U2C2RfBfqCMdqSNAw6uaP
         jJOSYeKqL3R0CWzIUO4SSDSVrft4QPiu7TAEnonWZltmXHog8874P5MO32SkTN+zwBrD
         FtjJtQqWIaF3TPXZ5/6fnr+x6y1pOflZyHAp7LGOGuCHEkTA2oi2X+PiO18n9rp9GBNL
         G1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T3FuHFvANgiRp+vQnd8WT0MBmLeTtTgAjorjAoWT8bY=;
        b=PNWLReNX1I6kiIzryueYowPXpoPfJqXwM/yX0PM2UMNy6T8sHA9XVEAjR7ke67ywdy
         wsFyma0fWSsdHzZ+1DE6uS4HRBQHeKaoxwHTvIHEjEoukwyVPOgr5JO2fUrdIuM6HECA
         QQDPQo8jM13q3O6RqbxAU/3wxom7GSj7misLIEMc6kXAmmyZ+QZASI2FwIEqD3CwnT1A
         3F7f5Aderak24e8AoNR72Fmf+0p21yM7k6KzBc5S7b4akkd4XO71GSAMcto0bFdPtgnm
         F5FVg4yfV9JYWb7gTz4t1xWqQlsUPGdy0MFAJYZGTC2uKmDB6SzeXBTopyxzt+FhvYUu
         avBQ==
X-Gm-Message-State: APjAAAXuuSRo1SiZjwQxBoIBVdr+hCJl40moxsK1vEpzdBgHQrJ6PU+9
        Y8PHuVShu+1wtgsvA5H5hL8=
X-Google-Smtp-Source: APXvYqyY5KGVrO1S748FJr5t0Rx2cCcyhkYExMFUuT1CGfsXmcXN64OS8Yd0K4ctq7SvX74VJn7gBg==
X-Received: by 2002:a62:1f58:: with SMTP id f85mr3261183pff.39.1553174369066;
        Thu, 21 Mar 2019 06:19:29 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id z20sm5550522pgu.28.2019.03.21.06.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:19:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:19:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 20/26] switch: implicit dwim, use --no-guess to disable it
Date:   Thu, 21 Mar 2019 20:16:49 +0700
Message-Id: <20190321131655.15249-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
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
index a14133b474..ee74379038 100644
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
2.21.0.548.gd3c7d92dc2

