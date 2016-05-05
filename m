From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v16 7/7] commit: add a commit.verbose config variable
Date: Thu,  5 May 2016 15:20:02 +0530
Message-ID: <1462441802-4768-8-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, szeder@ira.uka.de, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 05 11:51:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayFwY-0007uH-U4
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 11:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309AbcEEJvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 05:51:36 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33574 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756566AbcEEJve (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 05:51:34 -0400
Received: by mail-pa0-f47.google.com with SMTP id xk12so34663661pac.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 02:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EPHgWa3jW0flyv4P61SMVRcZoDEhtT0p5V7c7JjH2zY=;
        b=kYc1WkUyGiJCBAMA1Jgs6UmnPA7EDaEE6ms16U+M0OFbjoj4lvIjIKwjS9YOLE3ezA
         lXRj/qKExIXqoEcFKQ4mD17PG03qHis6LLjjSS72SFn6lm02zYZnyHNLY96DbW9SI60C
         I69a9VbJElp1UdUxXsNW36249Sv8P3s+7azekk5RPVHKDOgtywljzCaN7xMa7mGTMwe/
         pxsmseieesgfIXtOdDcWg1x2i3gS6LL0dITGjoAdNZtCSPKCVU4gezDyJNJznhA1fUbQ
         MJTvM6UgLQWX1lGMFP5KazfkSaA7PXfN+ZJk3zzbNGBlK4bMYQtAhIxHlQGw/0KG0X3+
         1jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EPHgWa3jW0flyv4P61SMVRcZoDEhtT0p5V7c7JjH2zY=;
        b=UWmdQ2WTX3z2B1HBbyz9iKcSDrTaYxADaSVeHwiYRpHVoWOgJ6TgZqMkzVU//4hpq4
         AAFidOjnt+7sox9/Y+tGuonKtaNQzXcfNNUxWpKwN3Vj0WTqeG3Ab1aqPSDqyfiurVt/
         x+iUhWF7/nGe6u/81MnAwQgqcRGDr+nDll7aNB/J6Hi9V09pP+bljCAPN+wbslFgeXyJ
         f3DMNdXa1V+GZnJNmUVrCGlEHiLyT56rQVZg8ogx4ORY9NT5hNDuq0J8WpEmd5cNmr7A
         MvDRzxhCRYhFUv8YfYjuBJ+qyMt/9vNQtmy9a8JtIR7XBhq9NySaqL8kLcEHeU1sZqZB
         /MLA==
X-Gm-Message-State: AOPr4FUCAjdksUh146OF3s9YEhngV94YDBdKhB5xDC7/lHupx9Ww3obuxNfWzKoUmf+/Ig==
X-Received: by 10.66.167.40 with SMTP id zl8mr19286567pab.8.1462441892810;
        Thu, 05 May 2016 02:51:32 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id zn12sm12255111pab.14.2016.05.05.02.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 May 2016 02:51:32 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293641>

Add commit.verbose configuration variable as a convenience for those
who always prefer --verbose.

Add tests to check the behavior introduced by this commit and also to
verify that behavior of status doesn't break because of this commit.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
 Documentation/config.txt     |  4 ++++
 Documentation/git-commit.txt |  3 ++-
 builtin/commit.c             | 14 +++++++++++-
 t/t7507-commit-verbose.sh    | 51 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 2 deletions(-)

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
index 5a81181..ed2653d 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -103,4 +103,55 @@ test_expect_success 'status does not verbose without --verbose' '
 	! grep "^diff --git" actual
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
+test_expect_success "status ignores commit.verbose=true" '
+	git -c commit.verbose=true status >actual &&
+	! grep "^diff --git actual"
+'
+
 test_done
-- 
2.8.1
