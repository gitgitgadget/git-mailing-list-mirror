Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DDE41F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeIZEoV (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:21 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:38009 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeIZEoV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:21 -0400
Received: by mail-ed1-f50.google.com with SMTP id x8-v6so190352eds.5
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=emstmxA0N28GUlKQv9rQzOqV8OvFlYCuvFOq5X0kWlU=;
        b=hm0Pz/JUFB6A9Gn4OjxpZF8Wzd2vfJncyXjR1oLrtvn1VySbFwPOR8eJh6gCED+7M2
         DKg6IjmekllfB8MmT5TeOdD2z300InQ1/DX7re2qT+MXhd2hgn1MUy0jmCD4462B/dca
         pTZptf/GszMP5NUcgLIgX5oMQDOpwcraS4NkS9seZVNAkIIcJdvFJ5xE12PBCexcDa4G
         EJ/3/kIH5vv+Q+0RFFYJb/lrHyU2/LVTDEpORi5YbbVC2sVd3AgzAI6RlGgZHdNa6AxU
         +cBYo+YxV5GqF6Hwd5b/qXlF/woJCU1urp1PUnSa3j6GdtCMHgiriShT8Do8kdKf0DgD
         9RwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emstmxA0N28GUlKQv9rQzOqV8OvFlYCuvFOq5X0kWlU=;
        b=a4XAV4QSc07Qi14gi/0j7woCjz5YkJyvOaD3efqt41jos4CJRd6lR1eekOfokvCivK
         xDXqSpqj26PCjvUT/a/SjKH67HSYCkJqyCn4937YlUdD6OnW2RKg2iQAZ2Gfys0rHzoo
         Tfi+17PFnUB8ZreRx8DW9YGo20/YDR62GypP8Tt2Fi2M5fEcAj3P48Use7xTuCrQc41b
         bs9bbM6oTvQS70vXBA1A6NtNXAxaI2/jj+uUPVA8taevP3SKbfpMCqABTxOwApk5tGdW
         QF9iyTOef1PZWWkFL+96vFpcHsROg5IOJyDkcWFEa6l94FPc+rSa8wgtNFrbQ4xIVqE/
         /Tlg==
X-Gm-Message-State: ABuFfoiQ1w6MFAIQjBJ+Ox20H7rLfeRxQDXmfc23p3Js+l8BBAj3p7lV
        H3S9ZU4jVlzSf0GyPcTwRTAo9kXI
X-Google-Smtp-Source: ACcGV61KDCFFibgw0rH3Wd1u0XFeeOj1fh0OzVETuWqwvfZExl7GrbyLn9XBlQgnfwuMsaGmb553vw==
X-Received: by 2002:aa7:d3d4:: with SMTP id o20-v6mr4844071edr.193.1537914874487;
        Tue, 25 Sep 2018 15:34:34 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.33
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:33 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 11/21] stash: convert list to builtin
Date:   Wed, 26 Sep 2018 01:33:27 +0300
Message-Id: <d0ea2c4b94b451d498aff5e8829534cb535a691f.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
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
index c1f78d3275..9e256690ec 100644
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
@@ -614,6 +620,29 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
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
@@ -644,6 +673,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.23.g1fb9f40d88

