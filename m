Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A291F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbeKNBzw (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:55:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36915 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731811AbeKNBzw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:55:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id p6-v6so6223231pll.4
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMLa3cWwc83CeD+AOgpuy8D40MCBSV7p8wIMamKQfWQ=;
        b=mvBBoBVj5iLrao/DujEyCECd6kEqJPqeePhrNsynQtcQ5xLJjDXT6vNIABZOV5HaOU
         btjCI+7fNQ/hyx6Dryy2Ba/1CQkLrx5wuk9oBXDr6LwcSm25+O6kEDWhH1H16+W398u5
         GTyyGz7FXovVlLAJAHx5jozBaGelNy9SjJI8hHbaOqG4w3DpQOjZMhtj1+qT2swA45TX
         9PtY19mTDuHGCzUADTJ11MMeglh/qYpia2q6haflZ1KhfGdl9rn0vCS2KUd8TXjIUEhy
         auIZZ9sRv542FZcPHRDPY9F0ikQxHP3Duq38PubSC3zpNdNcU6zWhLLaiT1CXDN48VCl
         Rb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMLa3cWwc83CeD+AOgpuy8D40MCBSV7p8wIMamKQfWQ=;
        b=h/arlDCm26E6eyO4p6e7MXlM9GJ9JdXf7Gk/OdsP6Y64qGP/DdhpIRJHSRe/SmDLy2
         Ml6o2yu7vnUR/lLQFgaslab+M5LvOfs6PePBY9wYunjGlfZgQvPn7MpBx8VLc/FIlB9X
         wx6FOeM77JuF4Ht2QA8CFT1Dj7CziYNkXG3YKgBgIgnXXOWqCLnMRCI7Dw9yBfmCysIM
         TrrmFPg/U+9Am96ZsiprgGauyOJ/jAwor3t9JHWuIeq6eF6L+1CK0WIbYMpznP+EacvD
         CR1bmGccfgvHKjqwPEfdV+n0aHhVl/tqqQ82mow7PrpkTs33dNoIi3QLvGhfUrKvDuql
         BxmQ==
X-Gm-Message-State: AGRZ1gImU5MoUY6G+TSL2cJQLdWO+YuW6o9v7IAR84wQ6WTOVs+E0w35
        X9Z20KYxUE9PRWQw0Dt3ngU=
X-Google-Smtp-Source: AJdET5eMpbp8f29PUroXYxc0v52acQ+M8Qc5LvEsBtBaufz5xYxeHwZEoYipgcANMaPeqLffCKj/Ew==
X-Received: by 2002:a17:902:76cc:: with SMTP id j12-v6mr5700825plt.339.1542124630338;
        Tue, 13 Nov 2018 07:57:10 -0800 (PST)
Received: from localhost.localdomain ([2405:204:53a9:d282:201a:4104:6de2:bf3f])
        by smtp.gmail.com with ESMTPSA id p38sm10582402pgm.40.2018.11.13.07.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:57:09 -0800 (PST)
From:   Tanushree Tumane <tanushreetumane@gmail.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, johannes.Schindelin@gmx.de,
        tanushree27 <tanushreetumane@gmail.com>
Subject: [PATCH v4] commit: add a commit.allowEmpty config variable
Date:   Tue, 13 Nov 2018 21:26:56 +0530
Message-Id: <20181113155656.22975-1-tanushreetumane@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1.495.g7e9d1c442b.dirty
In-Reply-To: <87d0rm7zeo.fsf@evledraar.gmail.com>
References: <87d0rm7zeo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: tanushree27 <tanushreetumane@gmail.com>

when we cherrypick an existing commit it doesn't change anything and
therefore it fails prompting to reset (skip commit) or commit using
--allow-empty attribute and then continue.

Add commit.allowEmpty configuration variable as a convenience to skip
this process.

Add tests to check the behavior introduced by this commit.

This closes https://github.com/git-for-windows/git/issues/1854

Signed-off-by: tanushree27 <tanushreetumane@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 Documentation/config.txt     |  5 +++++
 Documentation/git-commit.txt |  3 ++-
 builtin/commit.c             |  8 ++++++++
 t/t3500-cherry.sh            | 10 ++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

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
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index f038f34b7c..11504e2d9f 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -55,4 +55,14 @@ test_expect_success \
      expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* - .*"
 '
 
+
+# Tests for commit.allowEmpty config
+
+test_expect_success 'cherry-pick existing commit with commit.allowEmpty' '
+    test_tick &&
+	test_commit "first" &&
+	test_commit "second" &&
+	git -c commit.allowEmpty=true cherry-pick HEAD~1
+'
+
 test_done
-- 
2.19.1.windows.1.495.g7e9d1c442b.dirty

