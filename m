Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3591F453
	for <e@80x24.org>; Sat,  3 Nov 2018 15:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeKDAYp (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 20:24:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41933 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeKDAYp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 20:24:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id p16-v6so2352239plr.8
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W40fApXmcjjKz3ZQ/nCGh308iu+B1epDBZiMze0nVJw=;
        b=flMattTKDu4DnBgUbrfN6pfvbPoYOJMdYxD2c1HbckE1wpFe+NUjXQ/wmEyH5iFbgt
         CYpzt5JCo/UTmn9ufal/QXKGLIg8jrTEeW9J86yJ0e2xP8bp5ft9AhKhuOdSmDnhzmvL
         NhDWsVgXUzycpLin2IffTqZfADhZ4zBssvIMn4xB5wVf9T6+gLgEswgQu75a8SXVVumn
         7vVBo6456Arm5K/iVWdWLcTZwmzAbQisGhkZwidT4LvkcEVcxyhgapIP7mXcy8gJKrOn
         4iHd6WDkE7omUHHG9YizhBKTejiTJjGH66hbM+6jBdRyC6YmtriV4VhH2zVRjoA5Lhig
         kOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W40fApXmcjjKz3ZQ/nCGh308iu+B1epDBZiMze0nVJw=;
        b=DmrwPptUg9I+0G3ymEbqy+denHA8l7UTb2EuQrXJmPVsSu4iGRl1OSfV+o5FQJ35wp
         ndeHMZwf6JsTpbrX+ZT9Nc7sbkI245NoxCCUf7wi5xKvxLKWp2uoQpjLP0PT6ZV8SSbA
         Anv88Hl7HN/ITL255lcs2ixMw4EWXfGWDTJXxPi9JT4dCe8JGhr9KCAjbkdfXggAq3VY
         POMFGm4rDPsUNuuFLU9dzE/Art4pfPJAC18qoSM0ZSw4oU4oUc+1kFahj27qwbR//72A
         WtMwszKAE3O7JOQCWS7YZcEXkXYXQe1AiWq+F0+0FL1fetaulv2xaIZXm6W5btfg1WoW
         snMg==
X-Gm-Message-State: AGRZ1gJ/oB5eNQR0DQpe8CrYiFAZ/H6WxEKXDLg9wSU8s2W0U3T9Zryg
        ISC22O6endnPkANexjszA04=
X-Google-Smtp-Source: AJdET5cJrk+znLuEnQN7nKl/a3KuZqJBz2Dy9gRghCi2EwvUEQu2a+P9BVmbnMSUQtp7ChuIiicGpw==
X-Received: by 2002:a17:902:bf49:: with SMTP id u9-v6mr15992554pls.10.1541257989139;
        Sat, 03 Nov 2018 08:13:09 -0700 (PDT)
Received: from localhost.localdomain ([183.82.20.190])
        by smtp.gmail.com with ESMTPSA id n82-v6sm48358656pfg.21.2018.11.03.08.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 08:13:08 -0700 (PDT)
From:   tanushree27 <tanushreetumane@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, tanushreetumane@gmail.com
Subject: [PATCH v3] commit: add a commit.allowEmpty config variable
Date:   Sat,  3 Nov 2018 20:42:06 +0530
Message-Id: <20181103151205.29122-1-tanushreetumane@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1.495.g7e9d1c442b.dirty
In-Reply-To: <CACsJy8DttJ2EBcN8Kq-yECY0Pvp3vd0Vx45=szWD0cBW0Mcixw@mail.gmail.com>
References: <CACsJy8DttJ2EBcN8Kq-yECY0Pvp3vd0Vx45=szWD0cBW0Mcixw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add commit.allowEmpty configuration variable as a convenience for those
who always prefer --allow-empty.

Add tests to check the behavior introduced by this commit.

This closes https://github.com/git-for-windows/git/issues/1854

Signed-off-by: tanushree27 <tanushreetumane@gmail.com>
---
 Documentation/config.txt     |  5 +++++
 Documentation/git-commit.txt |  3 ++-
 builtin/commit.c             |  8 ++++++++
 t/t7500-commit.sh            | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c0727b7866..f3828518a5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1467,6 +1467,11 @@ commit.verbose::
 	A boolean or int to specify the level of verbose with `git commit`.
 	See linkgit:git-commit[1].
 
+commit.allowEmpty::
+	A boolean to specify whether empty commits are allowed with `git
+	commit`. See linkgit:git-commit[1]. 
+	Defaults to false.
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f970a43422..5d3bbf017a 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -176,7 +176,8 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	Usually recording a commit that has the exact same tree as its
 	sole parent commit is a mistake, and the command prevents you
 	from making such a commit.  This option bypasses the safety, and
-	is primarily for use by foreign SCM interface scripts.
+	is primarily for use by foreign SCM interface scripts. See
+	`commit.allowEmpty` in linkgit:git-config[1].
 
 --allow-empty-message::
        Like --allow-empty this command is primarily for use by foreign
diff --git a/builtin/commit.c b/builtin/commit.c
index 67fa949204..4516309ac2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -101,6 +101,7 @@ static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
+static int config_commit_allow_empty = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit;
@@ -1435,6 +1436,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
 		return 0;
 	}
+	if (!strcmp(k, "commit.allowempty")) {
+		config_commit_allow_empty = git_config_bool(k, v);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
@@ -1556,6 +1561,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (verbose == -1)
 		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
 
+	if (config_commit_allow_empty >= 0)  /* if allowEmpty is allowed in config*/
+		allow_empty = config_commit_allow_empty;
+	
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 170b4810e0..25a7facd53 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -359,4 +359,36 @@ test_expect_success 'new line found before status message in commit template' '
 	test_i18ncmp expected-template editor-input
 '
 
+# Tests for commit.allowEmpty config
+
+test_expect_success "no commit.allowEmpty and no --allow-empty" "
+	test_must_fail git commit -m 'test'
+"
+
+test_expect_success "no commit.allowEmpty and --allow-empty" "
+	git commit --allow-empty -m 'test'
+"
+
+for i in true 1
+do
+	test_expect_success "commit.allowEmpty=$i and no --allow-empty" "
+		git -c commit.allowEmpty=$i commit -m 'test'
+	"
+
+	test_expect_success "commit.allowEmpty=$i and --allow-empty" "
+		git -c commit.allowEmpty=$i commit --allow-empty -m 'test'
+	"
+done
+
+for i in false 0
+do
+	test_expect_success "commit.allowEmpty=$i and no --allow-empty" "
+		test_must_fail git -C commit.allowEmpty=$i commit -m 'test'
+	"
+
+	test_expect_success "commit.allowEmpty=$i and --allow-empty" "
+		test_must_fail git -c commit.allowEmpty=$i commit --allow-empty -m 'test'
+	"
+done
+
 test_done
-- 
2.19.1.windows.1.495.g9597888df3.dirty

