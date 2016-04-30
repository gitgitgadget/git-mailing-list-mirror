From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v15 6/7] commit: add a commit.verbose config variable
Date: Sun,  1 May 2016 01:33:35 +0530
Message-ID: <1462046616-2582-6-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 22:04:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awb86-0001C7-Cv
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 22:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbcD3UEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 16:04:39 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35820 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbcD3UEh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 16:04:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id r187so18013487pfr.2
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rFVlVJOBfFZbS47Mh+CUAesp8vhpKtQK5il9xYo8iUk=;
        b=k69SxoLJUQFZYfKSxxSSrEDmtlV46B/dQ84T0GhHjadadcdIHMELUNGIs9McVYAg0Z
         vpL5TwdJ4wZZlAsZ5lFz37wydnwyjnwbHiQZt2XTrYqHL1j4xs/T/++C9nA5m4FoHYDm
         CRcAXLPsCJC5KEkp2oH9rphsGL3Morpx9u+deEvYWjqkAwOPdV/QS3raJ2hI/ZH9lTcc
         4667ZWoXBQmrj/DUd3T+HTj7lVdOiU4wds/h25IfRbyDHVoJ5wbXg7P2O3xqzlCBTDg3
         ODIAv+1p8Ivivq7ZgFqHySRiJ/+RtgjmUZzcFXB5UPPrKyDGwsWs3wbHiG0o8JEFIzC/
         4f7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rFVlVJOBfFZbS47Mh+CUAesp8vhpKtQK5il9xYo8iUk=;
        b=dbYfxPC0yuzrkEYop3ey3XfWxip75seXtQb+STVlyKxmbdAO5wdN89yLedttK6qziL
         c6AKELwmKy9o19fCHIBcvbCoRQNjukaCP/WlylS3oIQOa0crkfWJVbV1Cp4/E0a+IOiE
         5GG3zSn6eAjLNAQJJw0XdRA+qA15MWQUbn/B5ovvRNK2CaIOAXgARaChhoyOMphDFCuU
         UHkdOl9PI143WyBmkEjGxnaXsuVYVtUn4OLgyY1Y1t/pTGFESnQiCPRhQtI0+wUtDfpD
         CZ+ES4RYtz8Nf80aOZuF7eb5W053f6CmCog6Ey+s5iSjtYTrH63aV730B/akg6CG+Y3k
         J4zQ==
X-Gm-Message-State: AOPr4FXSIDZJSBHOqnkJknqy7sG6CZ4oWMswNIEApUNfZLHRADKpa4BOSAZmKtrwoKSpiw==
X-Received: by 10.98.32.211 with SMTP id m80mr39153112pfj.3.1462046677072;
        Sat, 30 Apr 2016 13:04:37 -0700 (PDT)
Received: from localhost.localdomain ([27.106.101.191])
        by smtp.gmail.com with ESMTPSA id h85sm33329025pfj.52.2016.04.30.13.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Apr 2016 13:04:36 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293132>

Add commit.verbose configuration variable as a convenience for those
who always prefer --verbose.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The previous version of the patch are:
 - [v12] $gmane/288820
 - [v11] $gmane/288820
 - [v10] $gmane/288820
 - [v9] $gmane/288820
 - [v8] $gmane/288820
 - [v7] $gmane/288820
 - [v6] $gmane/288728
 - [v5] $gmane/288728
 - [v4] $gmane/288652
 - [v3] $gmane/288634
 - [v2] $gmane/288569
 - [v1] $gmane/287540

   Note: One might think some tests are extra but I think that it will
   be better to include them as they "complete the continuity" thus
   generalising the series which will make the patch even more clearer.

Changes wrt v14:
 - Add the status related tests in a different patch after this patch.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 Documentation/config.txt     |  4 ++++
 Documentation/git-commit.txt |  3 ++-
 builtin/commit.c             | 14 +++++++++++++-
 t/t7507-commit-verbose.sh    | 46 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..8bf6040 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1110,6 +1110,10 @@ commit.template::
 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.
 
+commit.verbose::
+	A boolean or int to specify the level of verbose with `git commit`.
+	See linkgit:git-commit[1].
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9ec6b3c..d474226 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -290,7 +290,8 @@ configuration variable documented in linkgit:git-config[1].
 	what changes the commit has.
 	Note that this diff output doesn't have its
 	lines prefixed with '#'. This diff will not be a part
-	of the commit message.
+	of the commit message. See the `commit.verbose` configuration
+	variable in linkgit:git-config[1].
 +
 If specified twice, show in addition the unified diff between
 what would be committed and the worktree files, i.e. the unstaged
diff --git a/builtin/commit.c b/builtin/commit.c
index 391126e..114ffc9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,7 +113,9 @@ static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
-static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
+static int config_verbose = -1; /* unspecified */
+static int verbose = -1; /* unspecified */
+static int quiet, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
@@ -1364,6 +1366,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			     builtin_status_usage, 0);
 	finalize_colopts(&s.colopts, -1);
 	finalize_deferred_config(&s);
+	if (verbose == -1)
+		verbose = 0;
 
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
@@ -1515,6 +1519,11 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.verbose")) {
+		int is_bool;
+		config_verbose = git_config_bool_or_int(k, v, &is_bool);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
@@ -1664,6 +1673,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+	if (verbose == -1)
+		verbose = (config_verbose < 0) ? 0 : config_verbose;
+
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 0f28a86..2bb6d8d 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -98,4 +98,50 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
 
+test_expect_success 'setup -v -v' '
+	echo dirty >file
+'
+
+for i in true 1
+do
+	test_expect_success "commit.verbose=$i and --verbose omitted" "
+		git -c commit.verbose=$i commit --amend &&
+		test_line_count = 1 out
+	"
+done
+
+for i in false -2 -1 0
+do
+	test_expect_success "commit.verbose=$i and --verbose omitted" "
+		git -c commit.verbose=$i commit --amend &&
+		test_line_count = 0 out
+	"
+done
+
+for i in 2 3
+do
+	test_expect_success "commit.verbose=$i and --verbose omitted" "
+		git -c commit.verbose=$i commit --amend &&
+		test_line_count = 2 out
+	"
+done
+
+for i in true false -2 -1 0 1 2 3
+do
+	test_expect_success "commit.verbose=$i and --verbose" "
+		git -c commit.verbose=$i commit --amend --verbose &&
+		test_line_count = 1 out
+	"
+
+	test_expect_success "commit.verbose=$i and --no-verbose" "
+		git -c commit.verbose=$i commit --amend --no-verbose &&
+		test_line_count = 0 out
+	"
+
+	test_expect_success "commit.verbose=$i and -v -v" "
+		git -c commit.verbose=$i commit --amend -v -v &&
+		test_line_count = 2 out
+	"
+done
+
 test_done
-- 
2.8.1
