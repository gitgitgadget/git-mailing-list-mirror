Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A64A1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeHaBqC (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:02 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39802 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeHaBqB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:46:01 -0400
Received: by mail-wm0-f46.google.com with SMTP id q8-v6so3436050wmq.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UMd4oUcNnfuAB1Gu72DELEfTN3VmaOoWxdC1snZO+0Q=;
        b=QNFD+jxVYX6/dbRAjUqoZjvaKchkUtXTdoezgRTxXzWGicYcwL+i8dlt9bFoxK5H9e
         7PxyZJRrdz6cju3PMZIuPv8j/sRFubjxyUsEPzAAP04vJ1AnadBKrkZrVBuqZ/B4Rru1
         h+n15/eJjEY1QvIljuBzJnxq/Xvxhjsidg/b/4+xG0uXXyzLeRmH6fIjKgzeh/KQD3m5
         m4gSQN+66Ek0caKQuDcnfVtYsgcvKl+ffLzSgWLRQRs/oT2+EJre7cI39tJ3rYEgFETK
         Ce0ICKR5B1/NHIPragx7XCW56990vB25E1cxZnzpKr/FmFZ5VB03XtO4ste2C+4QOMkq
         dZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMd4oUcNnfuAB1Gu72DELEfTN3VmaOoWxdC1snZO+0Q=;
        b=mUcQUJGoehqF7tdMBRd2SB3kGNM1lYreiZP+0gRV0RL4POHGPfrm28bBj5/1KRKIvn
         CBC/Xlxjt9Ez2vMlKibXsC9LUZCy4ijC9qC7UkMHsgJ3SHmE+985j29xsrwQzvH//uwB
         xHJ2nOKAw/CH9oNzzlrW3WYyjkMhiv1T31eBq5eSC95Sw+N9h63Jv3janEyuVYJ9gdS6
         Vj61OIxciLIYxbvUhwI5oyPLqEYgDee/dnvLcw+jJSv4b5u865Zxu9i7D/Vl+gZhhChI
         vYM6yrrabbGN9eZZu8jkHFEU1UYL6NsYSJEO03ACwuhwsKd1/FHxMRehHbbXy6W84isa
         b4pg==
X-Gm-Message-State: APzg51CDHchOaxhBDi6NFF3KLO/P5n5hZa4NVNuaPAA4jlXBXfXPPRqm
        TGhtalR8ezR/Db6YvlOgyxfA9gc6
X-Google-Smtp-Source: ANB0VdbP4mxmsaZyCZD3d2puZefH9n1yM6SP11wn//jmXZdX9qbainSwzIk34//bwurq5zrchEgMgw==
X-Received: by 2002:a1c:7814:: with SMTP id t20-v6mr2783200wmc.38.1535665307254;
        Thu, 30 Aug 2018 14:41:47 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:46 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 10/20] stash: convert list to builtin
Date:   Fri, 31 Aug 2018 00:40:40 +0300
Message-Id: <dbda179594b478686b8999e445ebe84f10b96ac4.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
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
index 9fb1003dbb..c42a297078 100644
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
@@ -609,6 +615,29 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
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
@@ -639,6 +668,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "list"))
+		return !!list_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 8f2640fe90..6052441aa2 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -382,11 +382,6 @@ have_stash () {
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
@@ -574,7 +569,7 @@ test -n "$seen_non_option" || set "push" "$@"
 case "$1" in
 list)
 	shift
-	list_stash "$@"
+	git stash--helper list "$@"
 	;;
 show)
 	shift
-- 
2.19.0.rc0.22.gc26283d74e

