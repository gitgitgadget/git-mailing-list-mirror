Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1352055E
	for <e@80x24.org>; Sat, 28 Oct 2017 16:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbdJ1QAo (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 12:00:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:64687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbdJ1QAn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 12:00:43 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgc0l-1dmIFw2dux-00O2Jp; Sat, 28
 Oct 2017 18:00:35 +0200
Date:   Sat, 28 Oct 2017 18:00:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.e.keller@intel.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
In-Reply-To: <20171028000152.2760-1-jacob.e.keller@intel.com>
Message-ID: <alpine.DEB.2.21.1.1710281740070.6482@virtualbox>
References: <20171028000152.2760-1-jacob.e.keller@intel.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:y9BREaICKbu+PSPp9BWvc0sYqp92Y4ltL/22pqQQ405u/4+D2xc
 Cn0VF2AlcnYo2owUJgKxjQRjoaWEg9ydH6n6u/N38HqzdKwPEQ9mJ6zi+lck15nOeCzybEj
 6VK2lIRImu2fmi8/ZuvTtjXMrpklpxiRcC5LqQTFBFvYQSvUnvz7btiTGtkgotbq6Bnc1RZ
 V3+azL7kfD/z7D8u3OYoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QTI1YiwJj+A=:0x4f2NcIUWT0x0RzUopOOx
 FS2fvqnL8Oxd7oWGba8UEJH4LpC9E2bkyS3VKHqQfv6PXHA3rTWNjv9DAEWx/Y/0I4dCJuaKg
 Ixra3gxSCkyjMmDp4RilhnzLc1Ef5qAQJh1EfwsV4/zMcIm/XQRz41G5h7yODdI8lQZ+sEvru
 zS1OjxBf5A08cqMnNfRL8qLrNLUOhesXCREXCrzKzv0IBt6YXjQ5/AzNgSUfI5T3oFxkcsQe4
 xHJSKRJCvC8zSfQfMecYvRPWdXXifFrZE3tzvuqhfIQ3CBvjb7wepzFsjfidHfMYzgatIgM8M
 DXeUnDDKA4rbz8Dycf/l2MEd0r9zxIW2SOM4bPpJaKyO8FN0N5tQzdX1CEXvpzME0qHlLVd6Y
 lucvSq0FViCySfTU6lvwWBgr+kW13GLBIK/Ocd1at/N4V1Hvx/u+pDwWJzmXqrOjgjEwI4jy7
 bWWIJdkYh9M5lowOsqPnVIl8+sEAyk2Plj2a4HiKUpCQm/SwJq+rrzhyRc1nb9l0vYY1NmNSX
 fSO2UWQfaG5HoBTVIcVmMz4QGMTeANrUKUCsOU74ZAV1DdRuIub/9o9g6MhQuCR/Dx5wza5U/
 QYKlcdLYNkCR+YuiToozYbWUAuW7Y3an2KPsLQV+HMNlGZx92E9P1XTxWi8sjMMJnrObhH2ts
 X/sb8/HX4tqj51WSdFBJfJTJfWgwVI+J0CmpQSgVZU4Wzifevb/+mSBSbXm4VifQlCuPeecIV
 kh9ObWCGWOTQKxgIb0O1sJi6zNxFkVhLY9GVLnjn0Ar/Saupt2+c22esENoImc0GX40bwwpYE
 F9jOsAG6xvuBwTbdu5QwmLEbXAV2+2FjdBbgaz8BhoVYXE0R1BbpfId/gTyaudL0yoBJ7vi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Fri, 27 Oct 2017, Jacob Keller wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
> 
> I noticed a failure with git rebase interactive mode which causes "exec"
> commands to be run with GIT_DIR set. When GIT_DIR is in the environment,
> then any command which results in running a git command in
> a subdirectory will fail because GIT_DIR=".git".
> 
> This unfortunately breaks one of my project's Makefiles, which uses
> git-describe to find the version information, but does so from within
> a sub directory.
> 
> I'm in the process of running a bisect to find where this got
> introduced, but I suspect it's part of the rebase--helper changes that
> happened a while ago.

A safe assumption. I do not know how the shell code managed that GIT_DIR
reset, though:

-- snip from v2.12.0's git-rebase--interactive.sh --
        x|"exec")
                read -r command rest < "$todo"
                mark_action_done
                eval_gettextln "Executing: \$rest"
                "${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
-- snap --

Maybe you can spot it?

The fix should be as easy as

-- snip --
diff --git a/sequencer.c b/sequencer.c
index f2c84c2fa62..018ba8d27e2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1859,11 +1859,13 @@ static int error_failed_squash(struct commit *commit,
 static int do_exec(const char *command_line)
 {
 	const char *child_argv[] = { NULL, NULL };
+	const char *child_env[] = { "GIT_DIR", NULL };
 	int dirty, status;
 
 	fprintf(stderr, "Executing: %s\n", command_line);
 	child_argv[0] = command_line;
-	status = run_command_v_opt(child_argv, RUN_USING_SHELL);
+	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
+					  child_env);
 
 	/* force re-reading of the cache */
 	if (discard_cache() < 0 || read_cache() < 0)
-- snap --

*However*, your test still fails with this, as

- your added test tries to remove the directory with -ff instead of -rf

- it tries to run `git rebase --abort` afterwards, which fails with my fix
  because there is no rebase in progress

- instead of `cd subdir && ...`, it calls `>cd subdir && ...`, which
  causes it to abort with a "subdir: not fonud"

So I need this, too, to make it all work:

-- snip --
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 60ab5136f70..967caab222a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -108,13 +108,13 @@ test_expect_success 'rebase -i with the exec command runs from tree root' '
 	rm -fr subdir
 '
 
-test_expect_failure 'rebase -i with the exec git commands in subdirs still work' '
-	test_when_finished "rm -ff subdir" &&
-	test_when_finished "git rebase --abort" &&
+test_expect_success 'rebase -i with the exec git commands in subdirs still work' '
+	test_when_finished "rm -rf subdir" &&
+	test_when_finished "git rebase --abort || :" &&
 	git checkout master &&
 	mkdir subdir && (cd subdir &&
 	set_fake_editor &&
-	FAKE_LINES="1 exec_>cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
+	FAKE_LINES="1 exec_cd_subdir_&&_git_rev-parse_--is-inside-work-tree" \
 		git rebase -i HEAD^
 	)
 '
-- snap --

I only had time to write these two patches, and to verify that t3404
passes now, but not that anything else passes, neither to write a proper
commit message.

Maybe you can take it from there?

Ciao,
Dscho
