Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26C61F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389473AbeLTTpJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50270 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbeLTTpD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so3259355wmd.0
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfDX7o6pDfIKWbvvg/L6ZObKOWCviZjfJLmXTNSu8DM=;
        b=NHKOCG+5kMS1lsO5UEe6Bx15bcsaO/919TTTF+iH2erfMVDZsVjatTV/bBLXwrO2In
         bzyAZ/7OG8B2s5YU7wzHpKfM/b+g5y9Hx2iwUzN7BW7IJNWZGpHxcS1ChlO9ay6xW3do
         jzq7TA+P35sRt/wOYw7D5qzMBrjTYNO+7Hi0Zsys/G57nnVDpaOFjyS7qyS0vwaBryMS
         n9vP7EZawF2Jt4t+effw60btGmNyYvq+SOvlKIX6sDfN2tstdO1gwQcNW8JlbCnZfddj
         8+EG6eibRXenJqG0+QO7bvn72ZNKkZkAWOiWeFqx/fIQ0gh7r+7NCeDPiRrrF3kvI1uY
         hp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfDX7o6pDfIKWbvvg/L6ZObKOWCviZjfJLmXTNSu8DM=;
        b=BSPwJS43Y6wvikX/U4WtlJpyKAlzVre6JVoqiKUF2lfwTWoOPXYIfk3Oz7nEwBlAYD
         D5lQrqWbq3Lm34QgOgCtIV6Az8b2Y0JUC1UtQ6QM9tC7bSJVoWr2gOdaDfl57kgUEHxc
         psMCh1+ozqJ3Gz/6mcZ7d9J5CTz65Dofj1BokpP/f++hWjS1ftDUzoEoxoLb2gpcQsgw
         LFySRoB1Lu4py4K+a1giL6Mh78ukenhJaN3go5vAwgvt0YwXmtzE5QQUf5XUo+DklnVe
         9Vd2AeOb1k6EmB3bFXlILIndbTuC2P4P+lAjOpuQbq6+Elh0fvYGf+fBiFZulYyvNAxr
         yMBA==
X-Gm-Message-State: AA+aEWY1PbpGwCzgytHtgNvTT3i/q8QHFSFLyzLKT6j8kyxOri/GwCzU
        +Z0Y0PHhQuv0DYllh0gyfZHAqRUPtjg=
X-Google-Smtp-Source: ALg8bN7z36KYvqrMOar47IFczQkrk/3MBrHVSyW2uQYMy8xaCXz+7ZD9XVbxBj4Szjv78iKld8h01g==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190mr1605wmg.13.1545335101823;
        Thu, 20 Dec 2018 11:45:01 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:01 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 14/26] stash: convert list to builtin
Date:   Thu, 20 Dec 2018 21:44:30 +0200
Message-Id: <09b927684780e34eb65742d03ae9b20be90e929d.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash list to the helper and delete the list_stash function
from the shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 31 +++++++++++++++++++++++++++++++
 git-stash.sh            |  7 +------
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index d7ff78784b..d66a4589a5 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 #include "rerere.h"
 
 static const char * const git_stash_helper_usage[] = {
+	N_("git stash--helper list [<options>]"),
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
@@ -19,6 +20,11 @@ static const char * const git_stash_helper_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_list_usage[] = {
+	N_("git stash--helper list [<options>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_drop_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	NULL
@@ -616,6 +622,29 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int list_stash(int argc, const char **argv, const char *prefix)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_list_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (!ref_exists(ref_stash))
+		return 0;
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "log", "--format=%gd: %gs", "-g",
+			 "--first-parent", "-m", NULL);
+	argv_array_pushv(&cp.args, argv);
+	argv_array_push(&cp.args, ref_stash);
+	argv_array_push(&cp.args, "--");
+	return run_command(&cp);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -646,6 +675,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "list"))
+		return !!list_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 8a9f907aa9..ab3992b59d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -399,11 +399,6 @@ have_stash () {
 	git rev-parse --verify --quiet $ref_stash >/dev/null
 }
 
-list_stash () {
-	have_stash || return 0
-	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
-}
-
 show_stash () {
 	ALLOW_UNKNOWN_FLAGS=t
 	assert_stash_like "$@"
@@ -591,7 +586,7 @@ test -n "$seen_non_option" || set "push" "$@"
 case "$1" in
 list)
 	shift
-	list_stash "$@"
+	git stash--helper list "$@"
 	;;
 show)
 	shift
-- 
2.20.1.441.g764a526393

