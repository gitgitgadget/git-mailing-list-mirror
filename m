Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0603F1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 11:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfBFLAB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 06:00:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37290 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfBFLAA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 06:00:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so2910226pfb.4
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 03:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2vZigOQSAutpt8Vt9YztXEdTmgbs1OwefroYN1/aRT4=;
        b=YtQaIDb1cDVgi8emOY7fReePB8gSUUOJevMuGHvUMIQt36KS1+vtRhvJ4asPC7aiUS
         u3rsWPROP+RmhKk2zDlfzo40JiG7RF8ufZnoq6pborSYeH+jTh2pQOb2hLZviCWD8UFO
         XXkjv8tKvAsdlGkZkTlB6OSv111jl/RrhdTrvkw57NKl7UPwuCKdEeXBmvBGsM965fnS
         hStZ/w44vxUbNn8tWowyUz/p/is96F7yqt+4d935FwOjCyNGkR5SVYz/bjqspWKSBkgQ
         YWAIVfIg1mrvUGYjQXm3NAd+oGgPdkuisbRcZVBZaNQLjqRwjLOKq62VWmGYZo7Utool
         fUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2vZigOQSAutpt8Vt9YztXEdTmgbs1OwefroYN1/aRT4=;
        b=FwWoC8lLC/hNGO3I9O33rOb2Nuw8wcbJYEJgzy1hAY3xksVsLaiYjZeq9zwx7TqDUm
         QeD817ju/kyBtT499gSzuhEbINxkv/rctx1v1O3KLmR1M51oGA4lwHsxkSk0EW9eQLkB
         kN4nS5RYGcJJUcATk+ir8zk/F8wPq7MOzNQd//guKA2Hv/Kjs4MK35dLYbL+iggJLhKY
         ZiYANs1ONSbWUXpFBz3RFajfUhM5mwIWCiWTvzM2OyWyRCSiU6Rz+IEM3ENCUrbHl5Ca
         AFZZ85KHOe9BR4SxrF25qSGrQO79EszyhlFomkRcFapRe0xYmFkNSEEGTkn0G+qpoZFt
         hbbA==
X-Gm-Message-State: AHQUAubnE+aztEBEDo0WWAxfKsY153tT5i9AVjt8J/nsl0Eex/QyNTr7
        COlg2crlm9zLOtkdzDHYCyvr1I3u
X-Google-Smtp-Source: AHgI3IYzZMZhgpRVCVdpjNvFVOf69w5nvV3L8AskqzTPL4cHwDNjmZBsjVdK22ns4fiz7Htz4aZhMA==
X-Received: by 2002:a63:6a05:: with SMTP id f5mr8907746pgc.72.1549450799586;
        Wed, 06 Feb 2019 02:59:59 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id b7sm7698450pfa.52.2019.02.06.02.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 02:59:58 -0800 (PST)
Date:   Wed, 6 Feb 2019 02:59:57 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 3/3] submodule: teach set-branch subcommand
Message-ID: <b0a314725c0943f60e381f2cd6054769288a269b.1549450636.git.liu.denton@gmail.com>
References: <cover.1549450636.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549450636.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches git-submodule the set-branch subcommand which allows the
branch of a submodule to be set through a porcelain command without
having to manually manipulate the .gitmodules file.
---
 Documentation/git-submodule.txt        |  7 ++
 contrib/completion/git-completion.bash |  5 +-
 git-submodule.sh                       | 75 +++++++++++++++++++--
 t/t7419-submodule-set-branch.sh        | 93 ++++++++++++++++++++++++++
 4 files changed, 175 insertions(+), 5 deletions(-)
 create mode 100755 t/t7419-submodule-set-branch.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 9951c68744..cb838ee556 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
 'git submodule' [--quiet] update [<options>] [--] [<path>...]
+'git submodule' [--quiet] set-branch [<options>] [--] <path>
 'git submodule' [--quiet] summary [<options>] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
@@ -168,6 +169,12 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
+set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
+	Sets the default remote tracking branch for the submodule. The
+	`--branch` option allows the remote branch to be specified. The
+	`--default` option removes the submodule.<name>.branch configuration
+	key, which causes the tracking branch to default to 'master'.
+--
 summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
 	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 499e56f83d..8b3b5a9d34 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2573,7 +2573,7 @@ _git_submodule ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="add status init deinit update summary foreach sync"
+	local subcommands="add status init deinit update set-branch summary foreach sync"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
@@ -2604,6 +2604,9 @@ _git_submodule ()
 			--force --rebase --merge --reference --depth --recursive --jobs
 		"
 		;;
+	set-branch,--*)
+		__gitcomp "--default --branch"
+		;;
 	summary,--*)
 		__gitcomp "--cached --files --summary-limit"
 		;;
diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad..43ec756602 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,6 +10,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
@@ -684,6 +685,72 @@ cmd_update()
 	}
 }
 
+#
+# Configures a submodule's default branch
+#
+# $@ = requested path
+#
+cmd_set_branch() {
+	unset_branch=false
+	branch=
+
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			# we don't do anything with this but we need to accept it
+			;;
+		-d|--default)
+			unset_branch=true
+			;;
+		-b|--branch)
+			case "$2" in '') usage ;; esac
+			branch=$2
+			shift
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	if test $# -ne 1
+	then
+		usage
+	fi
+
+	# we can't use `git submodule--helper name` here because internally, it
+	# hashes the path so a trailing slash could lead to an unintentional no match
+	name="$(git submodule--helper list "$1" | cut -f2)"
+	if test -z "$name"
+	then
+		exit 1
+	fi
+
+	test -n "$branch"; has_branch=$?
+	test "$unset_branch" = true; has_unset_branch=$?
+
+	if test $((!$has_branch != !$has_unset_branch)) -eq 0
+	then
+		usage
+	fi
+
+	if test $has_branch -eq 0
+	then
+		git submodule--helper config submodule."$name".branch "$branch"
+	else
+		git submodule--helper config --unset submodule."$name".branch
+	fi
+}
+
 #
 # Show commit summary for submodules in index or working tree
 #
@@ -980,7 +1047,7 @@ cmd_absorbgitdirs()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | deinit | update | status | summary | sync | absorbgitdirs)
+	add | foreach | init | deinit | update | set-branch | status | summary | sync | absorbgitdirs)
 		command=$1
 		;;
 	-q|--quiet)
@@ -1021,8 +1088,8 @@ then
     fi
 fi
 
-# "-b branch" is accepted only by "add"
-if test -n "$branch" && test "$command" != add
+# "-b branch" is accepted only by "add" and "set-branch"
+if test -n "$branch" && (test "$command" != add || test "$command" != set-branch)
 then
 	usage
 fi
@@ -1033,4 +1100,4 @@ then
 	usage
 fi
 
-"cmd_$command" "$@"
+"cmd_$(echo $command | sed -e s/-/_/g)" "$@"
diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
new file mode 100755
index 0000000000..c4b370ea85
--- /dev/null
+++ b/t/t7419-submodule-set-branch.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Denton Liu
+#
+
+test_description='Test submodules set-branch subcommand
+
+This test verifies that the set-branch subcommand of git-submodule is working
+as expected.
+'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+test_expect_success 'submodule config cache setup' '
+	mkdir submodule &&
+	(cd submodule &&
+		git init &&
+		echo a >a &&
+		git add . &&
+		git commit -ma &&
+		git checkout -b topic &&
+		echo b >a &&
+		git add . &&
+		git commit -mb
+	) &&
+	mkdir super &&
+	(cd super &&
+		git init &&
+		git submodule add ../submodule &&
+		git commit -m "add submodule"
+	)
+'
+
+test_expect_success 'ensure submodule branch is unset' '
+	(cd super &&
+		test_must_fail grep branch .gitmodules
+	)
+'
+
+test_expect_success 'test submodule set-branch --branch' '
+	(cd super &&
+		git submodule set-branch --branch topic submodule &&
+		grep "branch = topic" .gitmodules &&
+		git submodule update --remote &&
+		cat <<-\EOF >expect &&
+		b
+		EOF
+		git -C submodule show -s --pretty=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'test submodule set-branch --default' '
+	(cd super &&
+		git submodule set-branch --default submodule &&
+		test_must_fail grep branch .gitmodules &&
+		git submodule update --remote &&
+		cat <<-\EOF >expect &&
+		a
+		EOF
+		git -C submodule show -s --pretty=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'test submodule set-branch -b' '
+	(cd super &&
+		git submodule set-branch -b topic submodule &&
+		grep "branch = topic" .gitmodules &&
+		git submodule update --remote &&
+		cat <<-\EOF >expect &&
+		b
+		EOF
+		git -C submodule show -s --pretty=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'test submodule set-branch -d' '
+	(cd super &&
+		git submodule set-branch -d submodule &&
+		test_must_fail grep branch .gitmodules &&
+		git submodule update --remote &&
+		cat <<-\EOF >expect &&
+		a
+		EOF
+		git -C submodule show -s --pretty=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
2.20.1.522.g5f42c252e9

