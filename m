Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7BD2092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750769AbdAVW57 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:57:59 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34495 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAVW55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:57:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so22063135wmi.1
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 14:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gp/C52PjPsz3H6HcxapdIWcwhpLWTTXG0m5HgJ9RjB8=;
        b=AYaStHp/YiRCM8vpUcDYDGsO/zze/8LtIm9dSHRMWwXIUdAxABwMvUXZ/2NZ5Vyh13
         15+UjP1vrM+b/H0JKVVh15Gfro76y0aTrUGrYjxG+mQ0cB1uhSTuVsxosXWgc/GeSy74
         jjRJtT+mfYe1faKJq1DtX24QYPB17qoEh/xc5/9WabRzjzkr3XVDgEpNMgQI6iBQxRqF
         ICJsUFQH1Is8rqShw7a6Pe0qZr8Hidy47YOjFqt3Bj0/81VqDMFZe9QZl74SYXtP+wUM
         9l3mSii6nY2CI1FD13Ja62/jiDJv0/wPphYr5SqCc/iTPT/ffBbRAEPqltMrXOtfmKKB
         2o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gp/C52PjPsz3H6HcxapdIWcwhpLWTTXG0m5HgJ9RjB8=;
        b=IIevpa8DGN5iHMOSJPIJB3F3TsOnlgBK2N/ZgsFzXw7uk2n8niIrXMh6Ye3BqjLQJH
         NaijiWQttytJLr6B7tDzzqgIYKnqug1VNT3f5A/kvUEsR7T8IBcG3rorno1BGkGPg1+k
         gY+MO5oW/+V/MtsyxkGudR+nzLY7251zbu3HYhI0J8UmvBvNIhcPgknP/omtMfzXhs+b
         Umg6NfdDJXnji+W6i945uaRTNoZagaThPQqb3o6DYTlknEsH5zfZWeKIBCzCBc1bRMy6
         cy+5juVc0DIlsKOPFwwQMxq/ezb47/gMzizCLuWrQyZ/57aByrTOhESlVDMVTZ4W1Vt/
         aeiA==
X-Gm-Message-State: AIkVDXJa8qkqOqcrrpPNfn9Veiybx+I0wt3pFRUYQxX+iAw+qTK0ydAgVfxCpghPOX0bEQ==
X-Received: by 10.28.229.73 with SMTP id c70mr10764047wmh.82.1485125876446;
        Sun, 22 Jan 2017 14:57:56 -0800 (PST)
Received: from localhost.localdomain ([2001:a62:fb:5c01:efe0:5d69:845c:6e94])
        by smtp.gmail.com with ESMTPSA id v201sm6468545wmv.4.2017.01.22.14.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jan 2017 14:57:55 -0800 (PST)
From:   bitte.keine.werbung.einwerfen@googlemail.com
X-Google-Original-From: cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     thomas.braun@virtuell-zuhause.de, szeder@ira.uka.de,
        john@keeping.me.uk, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH 7/7] completion: recognize more long-options
Date:   Sun, 22 Jan 2017 23:57:24 +0100
Message-Id: <20170122225724.19360-8-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170122225724.19360-1-cornelius.weig@tngtech.com>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Recognize several new long-options for bash completion in the following
commands:

 - apply: --recount --directory= --unsafe-paths
 - archive: --prefix= --remote= --exec= --output
 - branch: --column --no-column --sort= --points-at
 - clone: --no-single-branch --shallow-submodules
 - commit: --patch --short --date --allow-empty
 - describe: --first-parent
 - fetch, pull: --unshallow --update-shallow
 - fsck: --name-objects
 - grep: --break --heading --show-function --function-context
         --untracked --no-index
 - mergetool: --prompt --no-prompt
 - reset: --merge --mixed --hard --soft --patch --keep
 - revert: --strategy= --strategy-option=
 - rm: --force
 - shortlog: --email
 - tag: --merged --no-merged --create-reflog
---
 contrib/completion/git-completion.bash | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0e09519..87d3d2c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -936,6 +936,7 @@ _git_apply ()
 			--apply --no-add --exclude=
 			--ignore-whitespace --ignore-space-change
 			--whitespace= --inaccurate-eof --verbose
+			--recount --directory= --unsafe-paths
 			"
 		return
 	esac
@@ -974,7 +975,7 @@ _git_archive ()
 	--*)
 		__gitcomp "
 			--format= --list --verbose
-			--prefix= --remote= --exec=
+			--prefix= --remote= --exec= --output
 			"
 		return
 		;;
@@ -1029,6 +1030,7 @@ _git_branch ()
 			--track --no-track --contains --merged --no-merged
 			--set-upstream-to= --edit-description --list
 			--unset-upstream --delete --move --remotes
+			--column --no-column --sort= --points-at
 			"
 		;;
 	*)
@@ -1142,6 +1144,8 @@ _git_clone ()
 			--single-branch
 			--branch
 			--recurse-submodules
+			--no-single-branch
+			--shallow-submodules
 			"
 		return
 		;;
@@ -1183,6 +1187,7 @@ _git_commit ()
 			--reset-author --file= --message= --template=
 			--cleanup= --untracked-files --untracked-files=
 			--verbose --quiet --fixup= --squash=
+			--patch --short --date --allow-empty
 			"
 		return
 	esac
@@ -1201,7 +1206,7 @@ _git_describe ()
 	--*)
 		__gitcomp "
 			--all --tags --contains --abbrev= --candidates=
-			--exact-match --debug --long --match --always
+			--exact-match --debug --long --match --always --first-parent
 			"
 		return
 	esac
@@ -1284,6 +1289,7 @@ __git_fetch_recurse_submodules="yes on-demand no"
 __git_fetch_options="
 	--quiet --verbose --append --upload-pack --force --keep --depth=
 	--tags --no-tags --all --prune --dry-run --recurse-submodules=
+	--unshallow --update-shallow
 "
 
 _git_fetch ()
@@ -1333,7 +1339,7 @@ _git_fsck ()
 	--*)
 		__gitcomp "
 			--tags --root --unreachable --cache --no-reflogs --full
-			--strict --verbose --lost-found
+			--strict --verbose --lost-found --name-objects
 			"
 		return
 		;;
@@ -1377,6 +1383,8 @@ _git_grep ()
 			--max-depth
 			--count
 			--and --or --not --all-match
+			--break --heading --show-function --function-context
+			--untracked --no-index
 			"
 		return
 		;;
@@ -1576,7 +1584,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool="
+		__gitcomp "--tool= --prompt --no-prompt"
 		return
 		;;
 	esac
@@ -2456,7 +2464,7 @@ _git_reset ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch"
+		__gitcomp "--merge --mixed --hard --soft --patch --keep"
 		return
 		;;
 	esac
@@ -2472,7 +2480,10 @@ _git_revert ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
+		__gitcomp "
+			--edit --mainline --no-edit --no-commit --signoff
+			--strategy= --strategy-option=
+			"
 		return
 		;;
 	esac
@@ -2483,7 +2494,7 @@ _git_rm ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		__gitcomp "--cached --dry-run --ignore-unmatch --quiet --force"
 		return
 		;;
 	esac
@@ -2500,7 +2511,7 @@ _git_shortlog ()
 		__gitcomp "
 			$__git_log_common_options
 			$__git_log_shortlog_options
-			--numbered --summary
+			--numbered --summary --email
 			"
 		return
 		;;
@@ -2778,8 +2789,8 @@ _git_tag ()
 	--*)
 		__gitcomp "
 			--list --delete --verify --annotate --message --file
-			--sign --cleanup --local-user --force --column --sort
-			--contains --points-at
+			--sign --cleanup --local-user --force --column --sort=
+			--contains --points-at --merged --no-merged --create-reflog
 			"
 		;;
 	esac
-- 
2.10.2

