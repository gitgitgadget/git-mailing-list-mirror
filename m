Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8277D1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 11:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeKCUgt (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 16:36:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36592 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeKCUgt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 16:36:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24-v6so2200393plq.3
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+ijcLxGnevkA6UFqgyMH2WdYRbWFGKZRzML9jOWNew=;
        b=ZtVKRpqcBCT48g14MPUw7OgoiITNmHfPnYkqs9NHEe0bfr7omIAfvqQ0LQgxaqIIwp
         rKGZ6laMK2GYrTiUJpFoxBxDR8byFav/ytGtA3jjFCDuQrAPHyCNMNttbfWp1IsThnJi
         BY04nDGADdG0N8370icqfFNs9k/3QKxAvPmfP2fC/itzMv10RTUkQbdhx6z2B36poSd7
         ht1e6rAAOX+hfsz48z+PmUifXIhfIoUBfzfaUl0I7CKema57H529982tcZcwDQXlTU2x
         Amggff3KWobbZzRGaMsuJKiBou7gQdWUh9qQGuhEJQJRcBJXhhxPaFHQKhDdkB/UyMQT
         vSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+ijcLxGnevkA6UFqgyMH2WdYRbWFGKZRzML9jOWNew=;
        b=iaZ+ent2F1EAlKIYat18zyER1rIn/wPkhyLvDaQwy9JtPdu4diKanPWqz6qSgQTqNH
         pF7m+Zsj+hh9RHWelhs7SEsK1I4Cw9MDWecKZ9+nemazwQfI82bgk5iB5+3fvHjOosBr
         GM854RQV3tyMaMpLSaRN027sSw0NhfAyhpIiKDtY+I1UFfxWCZwKR8Fv94wU5NErv4jd
         haFyNYgqbJqxDpcC4ovtl2FmLt7e2AdI3t6KpK8vRKaTUshB58AmFHcmcc6Dd9Kb6Ymh
         kj9CPYHEkEcl7cuAs/00+GmiUZEerPUclRBH+mIXPlwY4kZIGXgQQUXGBV4PmlKHruBg
         CoMQ==
X-Gm-Message-State: AGRZ1gLXWKkV8n4SFeFm0xS7l2vk5wheDf9hxLl/9H4HWl5Pl/lwE59A
        T9MSXyLZUT1SCaKF3MqgF/dXv+yq
X-Google-Smtp-Source: AJdET5fLfgB9QXJ3GPVHTnVsX7wAJafkQMwRNbVXUWM9QLJeReDYdhJXQJjD9uHGD9XNhYBv05lPwg==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr15285987pla.131.1541244348543;
        Sat, 03 Nov 2018 04:25:48 -0700 (PDT)
Received: from localhost.localdomain ([183.82.20.190])
        by smtp.gmail.com with ESMTPSA id f18-v6sm66606999pfh.0.2018.11.03.04.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 04:25:47 -0700 (PDT)
From:   tanushree27 <tanushreetumane@gmail.com>
To:     git@vger.kernel.org
Cc:     tanushree27 <tanushreetumane@gmail.com>
Subject: [PATCH] commit: add a commit.allowEmpty config variable
Date:   Sat,  3 Nov 2018 16:55:35 +0530
Message-Id: <20181103112535.5730-1-tanushreetumane@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1.495.g7e9d1c442b.dirty
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
index c0727b7866..ac63b12ab3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1467,6 +1467,11 @@ commit.verbose::
 	A boolean or int to specify the level of verbose with `git commit`.
 	See linkgit:git-commit[1].
 
+commit.allowempty::
+	A boolean to specify whether empty commits are allowed with `git
+	commit`. See linkgit:git-commit[1]. 
+	Defaults to false.
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f970a43422..07a5b60ab9 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -176,7 +176,8 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	Usually recording a commit that has the exact same tree as its
 	sole parent commit is a mistake, and the command prevents you
 	from making such a commit.  This option bypasses the safety, and
-	is primarily for use by foreign SCM interface scripts.
+	is primarily for use by foreign SCM interface scripts. See
+	`commit.allowempty` in linkgit:git-config[1].
 
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
index 170b4810e0..fb9bfbfb03 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -359,4 +359,36 @@ test_expect_success 'new line found before status message in commit template' '
 	test_i18ncmp expected-template editor-input
 '
 
+# Tests for commit.allowempty config
+
+test_expect_success "no commit.allowempty and no --allow-empty" "
+	test_must_fail git commit -m 'test'
+"
+
+test_expect_success "no commit.allowempty and --allow-empty" "
+	git commit --allow-empty -m 'test'
+"
+
+for i in true 1
+do
+	test_expect_success "commit.allowempty=$i and no --allow-empty" "
+		git -c commit.allowempty=$i commit -m 'test'
+	"
+
+	test_expect_success "commit.allowempty=$i and --allow-empty" "
+		git -c commit.allowempty=$i commit --allow-empty -m 'test'
+	"
+done
+
+for i in false 0
+do
+	test_expect_success "commit.allowempty=$i and no --allow-empty" "
+		test_must_fail git -c commit.allowempty=$i commit -m 'test'
+	"
+
+	test_expect_success "commit.allowempty=$i and --allow-empty" "
+		test_must_fail git -c commit.allowempty=$i commit --allow-empty -m 'test'
+	"
+done
+
 test_done
-- 
2.19.1.windows.1.495.gd17cbd8b09

