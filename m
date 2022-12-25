Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F22C4332F
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 13:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLYN3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 08:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLYN3v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 08:29:51 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E72C2DF5
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 05:29:49 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j17so2965404wrr.7
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 05:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG0HPbG97bRPqAhWdPWm+s71Bwn/03DdreRF1jB9EVQ=;
        b=ekctp54KDNWSDyVugHNWcGJrSle/sjw56P0KeTL94Zq3Ev3h6k2GH4b9RYcSb5d5wB
         NQ9CY1XrX2l/ISl36wCFul3u4pFSjDLDVVwO2oNRpB3tolSG0noZr65WHIbr6M9hYYek
         eMQ3w7yqH1fGcXyrJRHedSO4HEa4N0PZTtqeQMqvKJzJdAxz4PRxUZpRJMyuXq7uFMm4
         C2/vXn/wGeC5R/ZOcGfs4M67SUukajTnFH/P9WP3TNdMBvezya7zlNIoCUv3vKzgksVR
         A2Glr13bN9+/a9PdBJb0Eu/8u+v41ZMzRFpi7TiAsoMn7DK/wsC0sFO0tuYYUKeC+tKT
         xEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG0HPbG97bRPqAhWdPWm+s71Bwn/03DdreRF1jB9EVQ=;
        b=F85r+TCamM0XeEMocq/pfnVwsUNX2WtRa75CmL7QNAQuPcD5hJ5qWQ9ZzQPk5apWk9
         qvRdcoxeqAAbVRiFACdqcgoQrbqecpq1Ysp8Ek8tsMWTT/Aw1XXPdA+zjIs2gB0g3K2Z
         6tF9Nj41CM0A89gpOhAvdXwJkmZ2aQf4ZMys1lU+vHiw2LWNSSSCHAJGnq2ktlGGRzbE
         rmYxkeXoeUeuTJsPgM5RbmBggTRh3D26B6ZVxzgxGhmxqQW/ZIMtcHIzWuPMSGl2kIpN
         8vnyx5hHltQ+SVrg09pVrPS5dIFDBsIeGr6z7nVNakoIU0c1QudZr+mbxUnFK53V/eK+
         TmHA==
X-Gm-Message-State: AFqh2koumbnMT3erIYlyYi9BFq2C10MiNAGA4FazqcnvzvEUAhBHcqBj
        jPd1WE+veCXH1QdG+a+Bzi+foDoct1Y=
X-Google-Smtp-Source: AMrXdXvmcEPxEPsyZk2fD9HFcIiJxenctMibsl0zqHO2x78vL1MClPGLoL+WoR90EoOpJSg6DC4vAQ==
X-Received: by 2002:a5d:4cd2:0:b0:242:2445:4a42 with SMTP id c18-20020a5d4cd2000000b0024224454a42mr8699654wrt.9.1671974987785;
        Sun, 25 Dec 2022 05:29:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7-20020adfe287000000b00241bd177f89sm7812248wri.14.2022.12.25.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 05:29:47 -0800 (PST)
Message-Id: <pull.1441.v2.git.1671974986363.gitgitgadget@gmail.com>
In-Reply-To: <pull.1441.git.1670436656379.gitgitgadget@gmail.com>
References: <pull.1441.git.1670436656379.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Dec 2022 13:29:46 +0000
Subject: [PATCH v2] scalar: show progress if stderr refer to a terminal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Sometimes when users use scalar to download a monorepo
with a long commit history, they want to check the
progress bar to know how long they still need to wait
during the fetch process, but scalar suppresses this
output by default.

So let's check whether scalar stderr refer to a terminal,
if so, show progress, otherwise disable it.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    scalar: show progress if stderr refer to a terminal
    
    When users use scalar to download a monorepo with a long commit history
    (or the client and server network communication is very poor), we often
    need to spend a long time in the fetch phase of scalar, some users may
    want to check this progress bar To understand the progress of fetch and
    how long they have to wait, so we should enable scalar to display fetch
    progress.
    
    v1. add [--verbose| -v] to scalar clone.
    
    v2.
    
     1. remove --verbose option.
     2. check if scalar stderr refer to terminal, if so, show progress.
    
    Note: output look like this:
    
    $ scalar clone git@github.com:git/git.git
    Initialized empty Git repository in /home/adl/test/git/src/.git/
    remote: Enumerating objects: 208997, done.
    remote: Counting objects: 100% (870/870), done.
    remote: Compressing objects: 100% (870/870), done.
    remote: Total 208991 (delta 0), reused 870 (delta 0), pack-reused 208121
    remote: Enumerating objects: 470, done.
    remote: Counting objects: 100% (418/418), done.
    remote: Compressing objects: 100% (418/418), done.
    remote: Total 470 (delta 1), reused 0 (delta 0), pack-reused 52
    Receiving objects: 100% (470/470), 1.96 MiB | 1.64 MiB/s, done.
    Resolving deltas: 100% (1/1), done.
    Updating files: 100% (471/471), done.
    branch 'master' set up to track 'origin/master'.
    Switched to a new branch 'master'
    Your branch is up to date with 'origin/master'.
    
    
    "new branch", "new tag" output is a bit annoying, it would be better to
    suppress them, but keep the progress.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1441%2Fadlternative%2Fzh%2Fscalar-verbosity-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1441/adlternative/zh/scalar-verbosity-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1441

Range-diff vs v1:

 1:  6169841190a ! 1:  2e4c296bd19 scalar: use verbose mode in clone
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    scalar: use verbose mode in clone
     +    scalar: show progress if stderr refer to a terminal
      
          Sometimes when users use scalar to download a monorepo
          with a long commit history, they want to check the
     @@ Commit message
          during the fetch process, but scalar suppresses this
          output by default.
      
     -    So add `[--verbose| -v]` to scalar clone, to enable
     -    fetch's output.
     +    So let's check whether scalar stderr refer to a terminal,
     +    if so, show progress, otherwise disable it.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     - ## Documentation/scalar.txt ##
     -@@ Documentation/scalar.txt: scalar - A tool for managing large Git repositories
     - SYNOPSIS
     - --------
     - [verse]
     --scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
     -+scalar clone [--single-branch] [--branch <main-branch>] [--verbose | -v] [--full-clone] <url> [<enlistment>]
     - scalar list
     - scalar register [<enlistment>]
     - scalar unregister [<enlistment>]
     -@@ Documentation/scalar.txt: cloning. If the HEAD at the remote did not point at any branch when
     - 	A sparse-checkout is initialized by default. This behavior can be
     - 	turned off via `--full-clone`.
     - 
     -+-v::
     -+--verbose::
     -+	When scalar executes `git fetch`, `--quiet` is used by default to
     -+	suppress the output of fetch, use verbose mode for cancel this.
     -+
     - List
     - ~~~~
     - 
     -
       ## scalar.c ##
      @@ scalar.c: void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
       static int cmd_clone(int argc, const char **argv)
       {
       	const char *branch = NULL;
      -	int full_clone = 0, single_branch = 0;
     -+	int full_clone = 0, single_branch = 0, verbosity = 0;
     ++	int full_clone = 0, single_branch = 0, show_progress = isatty(2);
       	struct option clone_options[] = {
       		OPT_STRING('b', "branch", &branch, N_("<branch>"),
       			   N_("branch to checkout after clone")),
     -@@ scalar.c: static int cmd_clone(int argc, const char **argv)
     - 		OPT_BOOL(0, "single-branch", &single_branch,
     - 			 N_("only download metadata for the branch that will "
     - 			    "be checked out")),
     -+		OPT__VERBOSITY(&verbosity),
     - 		OPT_END(),
     - 	};
     - 	const char * const clone_usage[] = {
      @@ scalar.c: static int cmd_clone(int argc, const char **argv)
       	if (set_recommended_config(0))
       		return error(_("could not configure '%s'"), dir);
       
      -	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
     -+	if ((res = run_git("fetch", "origin",
     -+			   verbosity ? NULL : "--quiet",
     -+			   NULL))) {
     ++	if ((res = run_git("fetch", "--quiet",
     ++				show_progress ? "--progress" : "--no-progress",
     ++				"origin", NULL))) {
       		warning(_("partial clone failed; attempting full clone"));
       
       		if (set_config("remote.origin.promisor") ||
     @@ scalar.c: static int cmd_clone(int argc, const char **argv)
       		}
       
      -		if ((res = run_git("fetch", "--quiet", "origin", NULL)))
     -+		if ((res = run_git("fetch", "origin",
     -+				   verbosity ? NULL : "--quiet",
     -+				   NULL)))
     ++		if ((res = run_git("fetch", "--quiet",
     ++					show_progress ? "--progress" : "--no-progress",
     ++					"origin", NULL)))
       			goto cleanup;
       	}
       
     +
     + ## t/t9211-scalar-clone.sh ##
     +@@
     + test_description='test the `scalar clone` subcommand'
     + 
     + . ./test-lib.sh
     ++. "${TEST_DIRECTORY}/lib-terminal.sh"
     + 
     + GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
     + export GIT_TEST_MAINT_SCHEDULER
     +@@ t/t9211-scalar-clone.sh: test_expect_success '--no-single-branch clones all branches' '
     + 	cleanup_clone $enlistment
     + '
     + 
     ++test_expect_success TTY 'progress with tty' '
     ++	enlistment=progress1 &&
     ++
     ++	test_config -C to-clone uploadpack.allowfilter true &&
     ++	test_config -C to-clone uploadpack.allowanysha1inwant true &&
     ++
     ++	test_terminal env GIT_PROGRESS_DELAY=0 \
     ++		scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
     ++	grep --count "Enumerating objects" stderr >actual &&
     ++	echo 2 >expected &&
     ++	test_cmp expected actual &&
     ++	cleanup_clone $enlistment
     ++'
     ++
     ++test_expect_success 'progress without tty' '
     ++	enlistment=progress2 &&
     ++
     ++	test_config -C to-clone uploadpack.allowfilter true &&
     ++	test_config -C to-clone uploadpack.allowanysha1inwant true &&
     ++
     ++	scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
     ++	! grep "Enumerating objects" stderr &&
     ++	! grep "Updating files" stderr &&
     ++	cleanup_clone $enlistment
     ++'
     + test_done


 scalar.c                | 10 +++++++---
 t/t9211-scalar-clone.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/scalar.c b/scalar.c
index 6c52243cdf1..e5cc554c537 100644
--- a/scalar.c
+++ b/scalar.c
@@ -404,7 +404,7 @@ void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
-	int full_clone = 0, single_branch = 0;
+	int full_clone = 0, single_branch = 0, show_progress = isatty(2);
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
@@ -499,7 +499,9 @@ static int cmd_clone(int argc, const char **argv)
 	if (set_recommended_config(0))
 		return error(_("could not configure '%s'"), dir);
 
-	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
+	if ((res = run_git("fetch", "--quiet",
+				show_progress ? "--progress" : "--no-progress",
+				"origin", NULL))) {
 		warning(_("partial clone failed; attempting full clone"));
 
 		if (set_config("remote.origin.promisor") ||
@@ -508,7 +510,9 @@ static int cmd_clone(int argc, const char **argv)
 			goto cleanup;
 		}
 
-		if ((res = run_git("fetch", "--quiet", "origin", NULL)))
+		if ((res = run_git("fetch", "--quiet",
+					show_progress ? "--progress" : "--no-progress",
+					"origin", NULL)))
 			goto cleanup;
 	}
 
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index dd33d87e9be..49f054d5917 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -3,6 +3,7 @@
 test_description='test the `scalar clone` subcommand'
 
 . ./test-lib.sh
+. "${TEST_DIRECTORY}/lib-terminal.sh"
 
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
 export GIT_TEST_MAINT_SCHEDULER
@@ -148,4 +149,29 @@ test_expect_success '--no-single-branch clones all branches' '
 	cleanup_clone $enlistment
 '
 
+test_expect_success TTY 'progress with tty' '
+	enlistment=progress1 &&
+
+	test_config -C to-clone uploadpack.allowfilter true &&
+	test_config -C to-clone uploadpack.allowanysha1inwant true &&
+
+	test_terminal env GIT_PROGRESS_DELAY=0 \
+		scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
+	grep --count "Enumerating objects" stderr >actual &&
+	echo 2 >expected &&
+	test_cmp expected actual &&
+	cleanup_clone $enlistment
+'
+
+test_expect_success 'progress without tty' '
+	enlistment=progress2 &&
+
+	test_config -C to-clone uploadpack.allowfilter true &&
+	test_config -C to-clone uploadpack.allowanysha1inwant true &&
+
+	scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
+	! grep "Enumerating objects" stderr &&
+	! grep "Updating files" stderr &&
+	cleanup_clone $enlistment
+'
 test_done

base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882
-- 
gitgitgadget
