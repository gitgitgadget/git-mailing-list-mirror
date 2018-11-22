Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1B01F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439047AbeKWJsJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43995 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439014AbeKWJsG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so10620348wrs.10
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCWPKzE8TtH9y9sepdaj2YEhS43ZgOckmtKp8mNKDkY=;
        b=JlwCDokBh4nxla0/FSVFCKbQG7rCM450kYOYqhRHHUUpDCOCQN28AWzupvqczQapVo
         oQs5ODNg0GWIQ2eGFB+quxB5AwOXhQJWF95J77eIwQb345MUWkUdFMWPT+mz3QiFGCCU
         cB4+Dgo1RNziavHwCg/eejEjAYmwRefz5I+zblD1nJSwjI0fJo4KkRTf+ck5qBginkPY
         quOcLtn+HV2oM61qvsFE2976eghKJlE9T6D7Az3joerEcgbg3vK72wIz3q3OcjulEGEm
         VHpo4jfYtrwRFkqUvFdtw0UJ6FlLJopJs9+WlMqm97K3SCsN/XAQvGdG+qOVBK9g5S5o
         vNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCWPKzE8TtH9y9sepdaj2YEhS43ZgOckmtKp8mNKDkY=;
        b=GKscAp+tjaa3x7dBsyTMYxnxRtv1KBu0OfAMkkTqpiv4EW/17NzOp8A6qmnBMxhgAs
         b6uUO6XypZ/zOf79/IHUf/HSO6TIiwjjB58DgEFqKJ5XOqbRQ2cCMKl39GKKnEVcKx4u
         uiXbIinCvz+xbMfNavRRNtyKKXjWpeAxWCTsF+HPgoD9XU4xJODR2B3MUMwTr7P8FZmn
         R7f0lnH5RwOH2CRzkp7JVEXhBscU9HxODFf6gAhWrQ82erweaUpIz50avaZoipMecwYb
         oSxCKa9wq68Y8L5hmmaJEM7tX3gzfWVWOb3A1HS0ZqAEYi2Ufs2/kLapJtR9gdhECxDi
         E/LQ==
X-Gm-Message-State: AA+aEWbNI97WdblGbsfqhPhQoReRmDgWnMdcOwAB0SluSKXIYgxW2oTH
        0jpSve0yNqPULhyhxxfheIjvpdcQ
X-Google-Smtp-Source: AFSGD/W9BqV2v83OSy7UF09lzYfBoHSaFIxlCqEHPn/OTGwDou8E4VGuC8QM2H3S68xksWPP+I+wng==
X-Received: by 2002:adf:ee4e:: with SMTP id w14mr12262622wro.112.1542927985034;
        Thu, 22 Nov 2018 15:06:25 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:24 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 13/22] stash: convert list to builtin
Date:   Fri, 23 Nov 2018 01:05:33 +0200
Message-Id: <a77b1240e4d08964dc0c8e634282924a53871ea8.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
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
2.19.1.878.g0482332a22

