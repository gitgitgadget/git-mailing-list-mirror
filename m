Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE72B9A6
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 03:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986890; cv=none; b=T0F3PVdrDuIHQHk/zWfFN69L/mphOcrFMv0UfAp3GxW0u5Hb3jfTxF9e+PNi/wMrINZ4AQxCKsC55LZsonEUIh6hF0IR9ncqdq5PH3BCTPd2vkFqf1dFxN8t3hS9z19jRjCtevftibiZevJyZvBuMc3vOlpGmGiRAzicpneB+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986890; c=relaxed/simple;
	bh=M2/PeGJ7e7okM24mJhOq7DONIp9chQ7ldYRhXadlZZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaa3ris2gobPapGqQ6WaGMa8xBQIjS5fYdKZodpqWWsd5eMw8wZbHRl2XIBGm4/69/5razKjKF91YVtWX8jhYFtoTrj2g7aUm9ukgJJPUsfUI19KVKR/fiVAWMKFNlpekAqzWUa1m8ghJLfUi11rhXcbXyKerfUcynDcxVz1lD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f19QYYMq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f19QYYMq"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-211fb27cc6bso22452615ad.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 19:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731986887; x=1732591687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUtIpNisddZNqhYYrh0t0Kdb9uVeHZQ+UM+SycqtQUc=;
        b=f19QYYMql7pPWeCf+y84d6PvifwP10YGeo8qxac8bX7DbCJrpVx7Y37I5tr2WIgEep
         k4WZx8JBSnDB/9dVMql7MzLyzdZbcgresjcqy0+C6PlN35ze2LKvWJSQ9lkmrZoYHSQW
         2XdnbEBVcu91zRNMNAKwsTQjr2hhCyp53K0jA+3PMFz/VkqzWONUMdOF6cXvG0KjoS+N
         jPE9PPqrv/4jn74gx4TG5vJIVY71hTIkA4+5tJjWYznjwwOtus6dKpKJKNnYz6RRSS9l
         Z446X9REYvvd7Yk10388iJZpWF/Qom82vFf5nZngTOYAkGoYjUpwc842aWw91u+0n1Ce
         A8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731986887; x=1732591687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUtIpNisddZNqhYYrh0t0Kdb9uVeHZQ+UM+SycqtQUc=;
        b=fJSyA8E6IhaVREAlDuKJbkmrtiXMLSMEy8z8shHX503eouVjvzIQ9rc2zP2ufJB8pB
         doYs/8zqB7EQdceZITZeYPconxTvLQZd8nYhSuTf+kRaXi9RzRZWxQ7A27IQqIUdD+ts
         c3jGlBYNTyNwXbO+upZiSjQoz+umY2XxpI1cQ/csi0s1eMHG/FMGpVdvS2fBZL1mzlTh
         W7OYbOK3+xm4Oau+mXI1MYVPc2jOTgNTuFR2Muj1YOJP9+fAUkMAUQB4q6T9DSJmAudG
         m/p6UXs3BKmXP3HXgA/+qiL17gDrrVVOCGdmzLYgwloQzRWBuRWCJvw3DCnxEK+JHIX8
         CJdg==
X-Gm-Message-State: AOJu0YxOF2c2NNsbALXpc1JsHMiQKO8NKyts+nGDowui0/a9C9+b/IZn
	tQ7ZzilubiB1iX9yUJcmyfZTDT2oNdRaN+2qntgaqF7u0PqD/2/5ev/9RPlF
X-Google-Smtp-Source: AGHT+IEzAvvumXJI7QWVDqI2xXrYHeUKL0VsVWlR2ndC/vGNfRCYDpjmsQ4mytUbBZHR8KEX6xRAPg==
X-Received: by 2002:a17:902:ec89:b0:212:10ff:4b80 with SMTP id d9443c01a7336-21210ff5018mr101079445ad.54.1731986887216;
        Mon, 18 Nov 2024 19:28:07 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:bc4:dba3:8637:2ce1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212123818easm32790395ad.40.2024.11.18.19.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 19:28:06 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: git@vger.kernel.org
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff: --pickaxe{,-grep} arg names for -S and -G
Date: Mon, 18 Nov 2024 19:27:42 -0800
Message-ID: <20241119032755.3360365-1-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most arguments have both short and long versions.  Long versions are
easier to read, especially in scripts and command history.

Tests that check just the option parsing are duplicated to check both
short and long argument options.  But more complex tests are updated to
use the long argument in order to improve the test readability.
Assuming that the usage tests have already verified that both arguments
invoke the same underlying functionality.

Signed-off-by: Illia Bobyr <illia.bobyr@gmail.com>
---
 Documentation/diff-options.txt | 34 ++++++------
 Documentation/git-blame.txt    |  2 +-
 Documentation/gitdiffcore.txt  | 52 +++++++++---------
 diff.c                         | 12 +++--
 diff.h                         |  7 ++-
 gitk-git/gitk                  | 10 +++-
 t/t4062-diff-pickaxe.sh        |  8 +--
 t/t4209-log-pickaxe.sh         | 99 ++++++++++++++++++++++------------
 8 files changed, 137 insertions(+), 87 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index cd0b8..d9d6a6 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -650,6 +650,7 @@ Note that not all diffs can feature all types. For instance, copied and
 renamed entries cannot appear if detection for those types is disabled.
 
 -S<string>::
+--pickaxe=<string>::
 	Look for differences that change the number of occurrences of
 	the specified string (i.e. addition/deletion) in a file.
 	Intended for the scripter's use.
@@ -657,18 +658,19 @@ renamed entries cannot appear if detection for those types is disabled.
 It is useful when you're looking for an exact block of code (like a
 struct), and want to know the history of that block since it first
 came into being: use the feature iteratively to feed the interesting
-block in the preimage back into `-S`, and keep going until you get the
-very first version of the block.
+block in the preimage back into `--pickaxe`, and keep going until you get
+the very first version of the block.
 +
 Binary files are searched as well.
 
 -G<regex>::
+--pickaxe-grep=<regex>::
 	Look for differences whose patch text contains added/removed
 	lines that match <regex>.
 +
-To illustrate the difference between `-S<regex> --pickaxe-regex` and
-`-G<regex>`, consider a commit with the following diff in the same
-file:
+To illustrate the difference between `--pickaxe=<regex> --pickaxe-regex`
+and `--pickaxe-grep=<regex>`, consider a commit with the following diff in
+the same file:
 +
 ----
 +    return frotz(nitfol, two->ptr, 1, 0);
@@ -676,9 +678,9 @@ file:
 -    hit = frotz(nitfol, mf2.ptr, 1, 0);
 ----
 +
-While `git log -G"frotz\(nitfol"` will show this commit, `git log
--S"frotz\(nitfol" --pickaxe-regex` will not (because the number of
-occurrences of that string did not change).
+While `git log --pickaxe-grep="frotz\(nitfol"` will show this commit, `git
+log --pickaxe="frotz\(nitfol" --pickaxe-regex` will not (because the
+number of occurrences of that string did not change).
 +
 Unless `--text` is supplied patches of binary files without a textconv
 filter will be ignored.
@@ -688,21 +690,21 @@ information.
 
 --find-object=<object-id>::
 	Look for differences that change the number of occurrences of
-	the specified object. Similar to `-S`, just the argument is different
-	in that it doesn't search for a specific string but for a specific
-	object id.
+	the specified object. Similar to `--pickaxe`, just the argument is
+	different in that it doesn't search for a specific string but for a
+	specific object id.
 +
 The object can be a blob or a submodule commit. It implies the `-t` option in
 `git-log` to also find trees.
 
 --pickaxe-all::
-	When `-S` or `-G` finds a change, show all the changes in that
-	changeset, not just the files that contain the change
-	in <string>.
+	When `--pickaxe` or `--pickaxe-grep` finds a change, show all the
+	changes in that changeset, not just the files that contain the
+	change in <string>.
 
 --pickaxe-regex::
-	Treat the <string> given to `-S` as an extended POSIX regular
-	expression to match.
+	Treat the <string> given to `--pickaxe` as an extended POSIX
+	regular expression to match.
 
 endif::git-format-patch[]
 
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index b1d7fb..e455e9 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -41,7 +41,7 @@ a text string in the diff. A small example of the pickaxe interface
 that searches for `blame_usage`:
 
 -----------------------------------------------------------------------------
-$ git log --pretty=oneline -S'blame_usage'
+$ git log --pretty=oneline --pickaxe='blame_usage'
 5040f17eba15504bad66b14a645bddd9b015ebb7 blame -S <ancestry-file>
 ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
 -----------------------------------------------------------------------------
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 642c5..f3f48 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -245,32 +245,32 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation limits the set of filepairs to those that change
 specified strings between the preimage and the postimage in a certain
-way.  -S<block-of-text> and -G<regular-expression> options are used to
-specify different ways these strings are sought.
-
-"-S<block-of-text>" detects filepairs whose preimage and postimage
-have different number of occurrences of the specified block of text.
-By definition, it will not detect in-file moves.  Also, when a
-changeset moves a file wholesale without affecting the interesting
-string, diffcore-rename kicks in as usual, and `-S` omits the filepair
-(since the number of occurrences of that string didn't change in that
-rename-detected filepair).  When used with `--pickaxe-regex`, treat
-the <block-of-text> as an extended POSIX regular expression to match,
-instead of a literal string.
-
-"-G<regular-expression>" (mnemonic: grep) detects filepairs whose
-textual diff has an added or a deleted line that matches the given
-regular expression.  This means that it will detect in-file (or what
-rename-detection considers the same file) moves, which is noise.  The
-implementation runs diff twice and greps, and this can be quite
-expensive.  To speed things up, binary files without textconv filters
-will be ignored.
-
-When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
-that match their respective criterion are kept in the output.  When
-`--pickaxe-all` is used, if even one filepair matches their respective
-criterion in a changeset, the entire changeset is kept.  This behavior
-is designed to make reviewing changes in the context of the whole
+way.  --pickaxe=<block-of-text> and --pickaxe-grep=<regular-expression>
+options are used to specify different ways these strings are sought.
+
+"-S<block-of-text>", or "--pickaxe=<block-of-text>" detects filepairs
+whose preimage and postimage have different number of occurrences of the
+specified block of text.  By definition, it will not detect in-file moves.
+Also, when a changeset moves a file wholesale without affecting the
+interesting string, diffcore-rename kicks in as usual, and `--pickaxe`
+omits the filepair (since the number of occurrences of that string didn't
+change in that rename-detected filepair).  When used with
+`--pickaxe-regex`, treat the <block-of-text> as an extended POSIX regular
+expression to match, instead of a literal string.
+
+"-G<regular-expression>", or "--pickaxe-grep=<regular-expression>"
+(mnemonic: grep) detects filepairs whose textual diff has an added or a
+deleted line that matches the given regular expression.  This means that
+it will detect in-file (or what rename-detection considers the same file)
+moves, which is noise.  The implementation runs diff twice and greps, and
+this can be quite expensive.  To speed things up, binary files without
+textconv filters will be ignored.
+
+When `--pickaxe` or `--pickaxe-grep` are used without `--pickaxe-all`,
+only filepairs that match their respective criterion are kept in the
+output.  When `--pickaxe-all` is used, if even one filepair matches their
+respective criterion in a changeset, the entire changeset is kept.  This
+behavior is designed to make reviewing changes in the context of the whole
 changeset easier.
 
 diffcore-order: For Sorting the Output Based on Filenames
diff --git a/diff.c b/diff.c
index 173cbe..73efe 100644
--- a/diff.c
+++ b/diff.c
@@ -4878,15 +4878,17 @@ void diff_setup_done(struct diff_options *options)
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		die(_("options '%s', '%s', and '%s' cannot be used together"),
-			"-G", "-S", "--find-object");
+			"-G/--pickaxe-grep", "-S/--pickaxe", "--find-object");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
 		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s'"),
-			"-G", "--pickaxe-regex", "--pickaxe-regex", "-S");
+			"-G/--pickaxe-grep", "--pickaxe-regex",
+                        "--pickaxe-regex", "-S/--pickaxe");
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
 		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s' and '%s'"),
-			"--pickaxe-all", "--find-object", "--pickaxe-all", "-G", "-S");
+			"--pickaxe-all", "--find-object",
+                        "--pickaxe-all", "-G/--pickaxe-grep", "-S/--pickaxe");
 
 	/*
 	 * Most of the time we can say "there are changes"
@@ -5864,10 +5866,10 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_SET_INT_F(0, "ita-visible-in-index", &options->ita_invisible_in_index,
 			      N_("treat 'git add -N' entries as real in the index"),
 			      0, PARSE_OPT_NONEG),
-		OPT_CALLBACK_F('S', NULL, options, N_("<string>"),
+		OPT_CALLBACK_F('S', "pickaxe", options, N_("<string>"),
 			       N_("look for differences that change the number of occurrences of the specified string"),
 			       0, diff_opt_pickaxe_string),
-		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
+		OPT_CALLBACK_F('G', "pickaxe-grep", options, N_("<regex>"),
 			       N_("look for differences that change the number of occurrences of the specified regex"),
 			       0, diff_opt_pickaxe_regex),
 		OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
diff --git a/diff.h b/diff.h
index 0cde3..1fc17 100644
--- a/diff.h
+++ b/diff.h
@@ -600,7 +600,12 @@ void diffcore_fix_diff_index(void);
 "                try unchanged files as candidate for copy detection.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
-"  -S<string>    find filepair whose only one side contains the string.\n" \
+"  -G<string>\n" \
+"  --pickaxe-grep=<string>\n" \
+"                find differences whose patch contains the string.\n" \
+"  -S<string>\n" \
+"  --pickaxe=<string>\n" \
+"                find filepair whose only one side contains the string.\n" \
 "  --pickaxe-all\n" \
 "                show all files diff when -S is used and hit is found.\n" \
 "  -a  --text    treat all files as text.\n"
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 7a087f..c83f6 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -228,7 +228,15 @@ proc parseviewargs {n arglist} {
             "--until=*" - "--before=*" - "--max-age=*" - "--min-age=*" -
             "--author=*" - "--committer=*" - "--grep=*" - "-[iE]" -
             "--remove-empty" - "--first-parent" - "--cherry-pick" -
-            "-S*" - "-G*" - "--pickaxe-all" - "--pickaxe-regex" -
+            "-S*" - "--pickaxe=*" -
+            "--pickaxe" {
+              set nextisval 1
+            }
+            "-G*" - "--pickaxe-grep=*" -
+            "--pickaxe-grep" {
+              set nextisval 1
+            }
+            "--pickaxe-all" - "--pickaxe-regex" -
             "--simplify-by-decoration" {
                 # These mean that we get a subset of the commits
                 set filtered 1
diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index a90b4..ee87d3 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -17,13 +17,13 @@ test_expect_success setup '
 '
 
 # OpenBSD only supports up to 255 repetitions, so repeat twice for 64*64=4096.
-test_expect_success '-G matches' '
-	git diff --name-only -G "^(0{64}){64}$" HEAD^ >out &&
+test_expect_success '--pickaxe-grep matches' '
+	git diff --name-only --pickaxe-grep "^(0{64}){64}$" HEAD^ >out &&
 	test 4096-zeroes.txt = "$(cat out)"
 '
 
-test_expect_success '-S --pickaxe-regex' '
-	git diff --name-only -S0 --pickaxe-regex HEAD^ >out &&
+test_expect_success '--pickaxe --pickaxe-regex' '
+	git diff --name-only --pickaxe 0 --pickaxe-regex HEAD^ >out &&
 	test 4096-zeroes.txt = "$(cat out)"
 '
 
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index b42fdc5..1efda 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='log --grep/--author/--regexp-ignore-case/-S/-G'
+test_description='log --grep/--author/--regexp-ignore-case/--pickaxe{,-grep}'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
@@ -61,18 +61,39 @@ test_expect_success 'usage' '
 	test_expect_code 129 git log -S 2>err &&
 	test_grep "switch.*requires a value" err &&
 
+	test_expect_code 129 git log --pickaxe 2>err &&
+	test_grep "option.*requires a value" err &&
+
 	test_expect_code 129 git log -G 2>err &&
 	test_grep "switch.*requires a value" err &&
 
+	test_expect_code 129 git log --pickaxe-grep 2>err &&
+	test_grep "option.*requires a value" err &&
+
 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
 	grep "cannot be used together" err &&
 
+	test_expect_code 128 git log -Gregex --pickaxe string 2>err &&
+	grep "cannot be used together" err &&
+
+	test_expect_code 128 git log --pickaxe-grep regex -Sstring 2>err &&
+	grep "cannot be used together" err &&
+
+	test_expect_code 128 git log --pickaxe-grep regex --pickaxe string 2>err &&
+	grep "cannot be used together" err &&
+
 	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
 	grep "cannot be used together" err &&
 
+	test_expect_code 128 git log --pickaxe-grep regex --find-object=HEAD 2>err &&
+	grep "cannot be used together" err &&
+
 	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
 	grep "cannot be used together" err &&
 
+	test_expect_code 128 git log --pickaxe string --find-object=HEAD 2>err &&
+	grep "cannot be used together" err &&
+
 	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
 	grep "cannot be used together" err
 '
@@ -87,10 +108,10 @@ test_expect_success 'usage: --no-pickaxe-regex' '
 	fatal: unrecognized argument: --no-pickaxe-regex
 	EOF
 
-	test_expect_code 128 git log -Sstring --no-pickaxe-regex 2>actual &&
+	test_expect_code 128 git log --pickaxe string --no-pickaxe-regex 2>actual &&
 	test_cmp expect actual &&
 
-	test_expect_code 128 git log -Gstring --no-pickaxe-regex 2>err &&
+	test_expect_code 128 git log --pickaxe-grep string --no-pickaxe-regex 2>err &&
 	test_cmp expect actual
 '
 
@@ -105,47 +126,59 @@ test_log_icase	expect_second	--author person
 test_log_icase	expect_nomatch	--author spreon
 
 test_log	expect_nomatch	-G picked
+test_log	expect_nomatch	--pickaxe-grep picked
 test_log	expect_second	-G Picked
+test_log	expect_second	--pickaxe-grep Picked
 test_log_icase	expect_nomatch	-G pickle
+test_log_icase	expect_nomatch	--pickaxe-grep pickle
 test_log_icase	expect_second	-G picked
+test_log_icase	expect_second	--pickaxe-grep picked
 
-test_expect_success 'log -G --textconv (missing textconv tool)' '
+test_expect_success 'log --pickaxe-grep --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	test_must_fail git -c diff.test.textconv=missing log -Gfoo &&
+	test_must_fail git -c diff.test.textconv=missing log --pickaxe-grep foo &&
 	rm .gitattributes
 '
 
-test_expect_success 'log -G --no-textconv (missing textconv tool)' '
+test_expect_success 'log --pickaxe-grep --no-textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	git -c diff.test.textconv=missing log -Gfoo --no-textconv >actual &&
+	git -c diff.test.textconv=missing log --pickaxe-grep foo --no-textconv >actual &&
 	test_cmp expect_nomatch actual &&
 	rm .gitattributes
 '
 
 test_log	expect_nomatch	-S picked
+test_log	expect_nomatch	--pickaxe  picked
 test_log	expect_second	-S Picked
+test_log	expect_second	--pickaxe  Picked
 test_log_icase	expect_second	-S picked
+test_log_icase	expect_second	--pickaxe  picked
 test_log_icase	expect_nomatch	-S pickle
+test_log_icase	expect_nomatch	--pickaxe  pickle
 
 test_log	expect_nomatch	-S p.cked --pickaxe-regex
+test_log	expect_nomatch	--pickaxe  p.cked --pickaxe-regex
 test_log	expect_second	-S P.cked --pickaxe-regex
+test_log	expect_second	--pickaxe  P.cked --pickaxe-regex
 test_log_icase	expect_second	-S p.cked --pickaxe-regex
+test_log_icase	expect_second	--pickaxe  p.cked --pickaxe-regex
 test_log_icase	expect_nomatch	-S p.ckle --pickaxe-regex
+test_log_icase	expect_nomatch	--pickaxe  p.ckle --pickaxe-regex
 
-test_expect_success 'log -S --textconv (missing textconv tool)' '
+test_expect_success 'log --pickaxe --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	test_must_fail git -c diff.test.textconv=missing log -Sfoo &&
+	test_must_fail git -c diff.test.textconv=missing log --pickaxe foo &&
 	rm .gitattributes
 '
 
-test_expect_success 'log -S --no-textconv (missing textconv tool)' '
+test_expect_success 'log --pickaxe --no-textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-	git -c diff.test.textconv=missing log -Sfoo --no-textconv >actual &&
+	git -c diff.test.textconv=missing log --pickaxe foo --no-textconv >actual &&
 	test_cmp expect_nomatch actual &&
 	rm .gitattributes
 '
 
-test_expect_success 'setup log -[GS] plain & regex' '
+test_expect_success 'setup log --pickaxe{,-grep} plain & regex' '
 	test_create_repo GS-plain &&
 	test_commit -C GS-plain --append A data.txt "a" &&
 	test_commit -C GS-plain --append B data.txt "a a" &&
@@ -160,31 +193,31 @@ test_expect_success 'setup log -[GS] plain & regex' '
 	git -C GS-plain log >full-log
 '
 
-test_expect_success 'log -G trims diff new/old [-+]' '
-	git -C GS-plain log -G"[+-]a" >log &&
+test_expect_success 'log --pickaxe-grep trims diff new/old [-+]' '
+	git -C GS-plain log --pickaxe-grep "[+-]a" >log &&
 	test_must_be_empty log &&
-	git -C GS-plain log -G"^a" >log &&
+	git -C GS-plain log --pickaxe-grep "^a" >log &&
 	test_cmp log A-to-B-then-E-log
 '
 
-test_expect_success 'log -S<pat> is not a regex, but -S<pat> --pickaxe-regex is' '
-	git -C GS-plain log -S"a" >log &&
+test_expect_success 'log --pickaxe <pat> is not a regex, but --pickaxe <pat> --pickaxe-regex is' '
+	git -C GS-plain log --pickaxe "a" >log &&
 	test_cmp log A-to-B-then-E-log &&
 
-	git -C GS-plain log -S"[a]" >log &&
+	git -C GS-plain log --pickaxe "[a]" >log &&
 	test_must_be_empty log &&
 
-	git -C GS-plain log -S"[a]" --pickaxe-regex >log &&
+	git -C GS-plain log --pickaxe "[a]" --pickaxe-regex >log &&
 	test_cmp log A-to-B-then-E-log &&
 
-	git -C GS-plain log -S"[b]" >log &&
+	git -C GS-plain log --pickaxe "[b]" >log &&
 	test_cmp log D-then-E-log &&
 
-	git -C GS-plain log -S"[b]" --pickaxe-regex >log &&
+	git -C GS-plain log --pickaxe "[b]" --pickaxe-regex >log &&
 	test_cmp log C-to-D-then-E-log
 '
 
-test_expect_success 'setup log -[GS] binary & --text' '
+test_expect_success 'setup log --pickaxe{,-grep} binary & --text' '
 	test_create_repo GS-bin-txt &&
 	test_commit -C GS-bin-txt --printf A data.bin "a\na\0a\n" &&
 	test_commit -C GS-bin-txt --append --printf B data.bin "a\na\0a\n" &&
@@ -192,36 +225,36 @@ test_expect_success 'setup log -[GS] binary & --text' '
 	git -C GS-bin-txt log >full-log
 '
 
-test_expect_success 'log -G ignores binary files' '
-	git -C GS-bin-txt log -Ga >log &&
+test_expect_success 'log --pickaxe-grep ignores binary files' '
+	git -C GS-bin-txt log --pickaxe-grep a >log &&
 	test_must_be_empty log
 '
 
-test_expect_success 'log -G looks into binary files with -a' '
-	git -C GS-bin-txt log -a -Ga >log &&
+test_expect_success 'log --pickaxe-grep looks into binary files with -a' '
+	git -C GS-bin-txt log -a --pickaxe-grep a >log &&
 	test_cmp log full-log
 '
 
-test_expect_success 'log -G looks into binary files with textconv filter' '
+test_expect_success 'log --pickaxe-grep looks into binary files with textconv filter' '
 	test_when_finished "rm GS-bin-txt/.gitattributes" &&
 	(
 		cd GS-bin-txt &&
 		echo "* diff=bin" >.gitattributes &&
-		git -c diff.bin.textconv=cat log -Ga >../log
+		git -c diff.bin.textconv=cat log --pickaxe-grep a >../log
 	) &&
 	test_cmp log full-log
 '
 
-test_expect_success 'log -S looks into binary files' '
-	git -C GS-bin-txt log -Sa >log &&
+test_expect_success 'log --pickaxe looks into binary files' '
+	git -C GS-bin-txt log --pickaxe a >log &&
 	test_cmp log full-log
 '
 
-test_expect_success 'log -S --pickaxe-regex looks into binary files' '
-	git -C GS-bin-txt log --pickaxe-regex -Sa >log &&
+test_expect_success 'log --pickaxe --pickaxe-regex looks into binary files' '
+	git -C GS-bin-txt log --pickaxe-regex --pickaxe a >log &&
 	test_cmp log full-log &&
 
-	git -C GS-bin-txt log --pickaxe-regex -S"[a]" >log &&
+	git -C GS-bin-txt log --pickaxe-regex --pickaxe "[a]" >log &&
 	test_cmp log full-log
 '
 
-- 
2.45.2

