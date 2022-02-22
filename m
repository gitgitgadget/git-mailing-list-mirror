Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948BC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 15:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiBVP67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiBVP65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 10:58:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848A2B459F
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:58:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d28so6455946wra.4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HbWWteXtiDgh3cvFJtgXymm5nReZdtPoplyy7GLWEmU=;
        b=COVMOlw+90V2pklyUpKYxEOu79vZX2oYtcCIx68p1vGfZCcJGzsRExyJpZSwklv98+
         BCAFwfdFVJizNNL5q5gxjPTkHVqS5wmTxV3pdkxbCtoyPY4vr7d+BvZ0H7BhApRsb26b
         QGmXBQz5EqaKnr/LxmvDPP0SKXzp233aJSjwFkMMfxy2TvAsu67DQckMf1pGRRQVqYXX
         Azhw4bPmoAF9Dj7WAsBaTUwyAQ2BZDEO8cY0iLVbJPz9EIFQEog9a61m/xE0gw51lorz
         TSV4MEWZaYuCcEpbzBlm0rDPJVLpgsoFjrI7JrOHihqmVbExV8U5Fxh8samEy32zIg1Z
         /ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HbWWteXtiDgh3cvFJtgXymm5nReZdtPoplyy7GLWEmU=;
        b=ECwozSqWax4IlZxfZVFzu3T5j3K2QblkyhHsVrWL89znJ0kaDn1yaZ9QIP5okb0lu9
         oDqzITjTSng9g5sfiryJHPJBOQNJ82c1zPyhy0yXnd7lLR/J47K2BvcMv/p4HTgO2HHy
         s9DiAMMTfuBG3YyRR01lr6qOaVZk4XtECi0J/AjL+lelk2qfc93J4wux/0GNuU5Bjy2D
         53q8RVJM7kkSm71XXLCBYnnByzoFRwQ7EP/znxXo1GqsHWMC4//CVcd6Phpe5MKkk4Zo
         YiPJ6v2WN2Y515KAv4iq2rNxB9eNsP17niSNRQq6msHXmZuIueAhEn2Eq/JtYpcgBatS
         DtEQ==
X-Gm-Message-State: AOAM530peUgyrbFDx7pU50wnMwDkf7d6M2Kph5wNoKCiglX6VFFxLTA4
        /LsrQC7dYCU0ZNS//6k/01CV6pYhz1A=
X-Google-Smtp-Source: ABdhPJwiSvehtTbiAecZUVRG6JKiDjORjFWabnYEiLnmhZZUZtX369n2PqYFNw94PKztY9JvluXfvg==
X-Received: by 2002:adf:e547:0:b0:1e3:3efd:48d1 with SMTP id z7-20020adfe547000000b001e33efd48d1mr19953242wrm.13.1645545508713;
        Tue, 22 Feb 2022 07:58:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba14sm31721994wrb.56.2022.02.22.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 07:58:28 -0800 (PST)
Message-Id: <pull.1147.v2.git.1645545507689.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.git.1645030949730.gitgitgadget@gmail.com>
References: <pull.1147.git.1645030949730.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 15:58:27 +0000
Subject: [PATCH v2] add usage-strings check  and amend remaining usage strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Lawall <julia.lawall@inria.fr>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhra303 <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhra303 <chakrabortyabhradeep79@gmail.com>

Usage strings for git (sub)command flags has a style guide that
suggests - first letter should not capitalized (unless requied)
and it should skip full-stop at the end of line. But there are
some files where usage-strings do not follow the above mentioned
guide. Moreover, there are no checks to verify if all usage strings
are following the guide/convention or not.

Amend the usage strings that don't follow the convention/guide and
add a check in the `parse_options_check()` function in `parse-options.c`
to check the usage strings against the style guide.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
    add usage-strings ci check and amend remaining usage strings
    
    This patch series completely fixes #636.
    
    The issue is about amending the usage-strings (for command flags such as
    -h, -v etc.) which do not follow the style convention/guide. There was a
    PR [https://github.com/gitgitgadget/git/pull/920] addressing this issue
    but as Johannes [https://github.com/dscho] said in his comment
    [https://github.com/gitgitgadget/git/issues/636#issuecomment-1018660439],
    there are some files that still have those kind of usage strings.
    Johannes also suggested to add a CI check under ci/test-documentation.sh
    to check the usage strings.
    
    So, in this patch, all remaining usage strings are corrected. I also
    added checks to parse_options_check() in parse-options.c (as suggested
    by Ævar).
    
    Changes since v1:
    
     1. remove check-usage-strings.sh
     2. remove CI check
     3. add checks to parse-options.c
     4. modify t/t1502-rev-parse-parseopt.sh to pass the test

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1147%2FAbhra303%2Fusage_command_amend-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1147/Abhra303/usage_command_amend-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1147

Range-diff vs v1:

 1:  ea0ba45d77a ! 1:  902937e768d add usage-strings ci check and amend remaining usage strings
     @@ Metadata
      Author: Abhra303 <chakrabortyabhradeep79@gmail.com>
      
       ## Commit message ##
     -    add usage-strings ci check and amend remaining usage strings
     +    add usage-strings check  and amend remaining usage strings
      
          Usage strings for git (sub)command flags has a style guide that
          suggests - first letter should not capitalized (unless requied)
     @@ Commit message
          are following the guide/convention or not.
      
          Amend the usage strings that don't follow the convention/guide and
     -    add a `CI` check for checking the usage strings (whether the first
     -    letter is capital or it ends with full-stop). If the `check` find
     -    such strings then print those strings and return a non-zero status.
     -
     -    Also provide a script that takes an optional argument (a valid <tree>
     -    string), to check the usage strings in the given <tree> (`HEAD` is
     -    the default argument).
     +    add a check in the `parse_options_check()` function in `parse-options.c`
     +    to check the usage strings against the style guide.
      
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
     - ## Makefile ##
     -@@ Makefile: check-docs::
     - check-builtins::
     - 	./check-builtins.sh
     - 
     -+### Make sure all the usage strings follow usage string style guide
     -+#
     -+check-usage-strings::
     -+	./check-usage-strings.sh
     -+
     - ### Test suite coverage testing
     - #
     - .PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
     -
       ## builtin/bisect--helper.c ##
      @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
       		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
     @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv
       			   N_("force cloning progress")),
       		OPT_BOOL(0, "require-init", &require_init,
      
     - ## check-usage-strings.sh (new) ##
     -@@
     -+{
     -+  if test -d ".git"
     -+  then
     -+    rev=${1:-"HEAD"}
     -+    for entry in $(git grep -l 'struct option .* = {$' "$rev" -- \*.c);
     -+    do
     -+      git show "$entry" |
     -+      sed -n '/struct option .* = {/,/OPT_END/{=;p;}' |
     -+      sed "N;s/^\\([0-9]*\\)\\n/$(echo "$entry" | sed 's/\//\\&/g'):\\1/";
     -+    done
     -+  else
     -+    for entry in $(grep -rl --include="*.c" 'struct option .* = {$' . );
     -+    do
     -+      cat "$entry" |
     -+      sed -n '/struct option .* = {/,/OPT_END/{=;p;}' |
     -+      sed "N;s/^\\([0-9]*\\)\\n/$(echo "$entry" | sed -e 's/\//\\&/g' -e 's/^\.\\\///'):\\1/";
     -+    done
     -+  fi
     -+} |
     -+grep -Pe '((?<!OPT_GROUP\(N_\(|OPT_GROUP\()"(?!GPG|DEPRECATED|SHA1|HEAD)[A-Z]|(?<!"|\.\.)\.")' |
     -+{
     -+  status=0
     -+  while read content;
     -+  do
     -+    if test -n "$content"
     -+    then
     -+      echo "$content";
     -+      status=1;
     -+    fi
     -+  done
     -+
     -+  exit $status
     -+}
     -
     - ## ci/test-documentation.sh ##
     -@@ ci/test-documentation.sh: filter_log () {
     - }
     - 
     - make check-builtins
     -+make check-usage-strings
     - make check-docs
     - 
     - # Build docs with AsciiDoc
     -
       ## diff.c ##
      @@ diff.c: static void prep_parse_options(struct diff_options *options)
       			       N_("select files by diff type"),
     @@ diff.c: static void prep_parse_options(struct diff_options *options)
       
       		OPT_END()
      
     + ## parse-options.c ##
     +@@ parse-options.c: static void parse_options_check(const struct option *opts)
     + 		default:
     + 			; /* ok. (usually accepts an argument) */
     + 		}
     ++		if (opts->type != OPTION_GROUP && opts->help &&
     ++			!(starts_with(opts->help, "HEAD") ||
     ++			  starts_with(opts->help, "GPG") ||
     ++			  starts_with(opts->help, "DEPRECATED") ||
     ++			  starts_with(opts->help, "SHA1")) &&
     ++			  (opts->help[0] >= 65 && opts->help[0] <= 90))
     ++			err |= optbug(opts, xstrfmt("help should not start with capital letter unless needed: %s", opts->help));
     ++		if (opts->help && !ends_with(opts->help, "...") && ends_with(opts->help, "."))
     ++			err |= optbug(opts, xstrfmt("help should not end with a dot: %s", opts->help));
     + 		if (opts->argh &&
     + 		    strcspn(opts->argh, " _") != strlen(opts->argh))
     + 			err |= optbug(opts, "multi-word argh should use dash to separate words");
     +
       ## t/helper/test-run-command.c ##
      @@ t/helper/test-run-command.c: static int quote_stress_test(int argc, const char **argv)
       	struct strbuf out = STRBUF_INIT;
     @@ t/helper/test-run-command.c: static int quote_stress_test(int argc, const char *
       		OPT_END()
       	};
       	const char * const usage[] = {
     +
     + ## t/t1502-rev-parse-parseopt.sh ##
     +@@ t/t1502-rev-parse-parseopt.sh: test_expect_success 'setup optionspec-only-hidden-switches' '
     + |
     + |some-command does foo and bar!
     + |--
     +-|hidden1* A hidden switch
     ++|hidden1* a hidden switch
     + EOF
     + '
     + 
     +@@ t/t1502-rev-parse-parseopt.sh: test_expect_success 'test --parseopt help-all output hidden switches' '
     + |
     + |    some-command does foo and bar!
     + |
     +-|    --hidden1             A hidden switch
     ++|    --hidden1             a hidden switch
     + |
     + |EOF
     + END_EXPECT


 builtin/bisect--helper.c      | 2 +-
 builtin/reflog.c              | 6 +++---
 builtin/submodule--helper.c   | 2 +-
 diff.c                        | 2 +-
 parse-options.c               | 9 +++++++++
 t/helper/test-run-command.c   | 6 +++---
 t/t1502-rev-parse-parseopt.sh | 4 ++--
 7 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..614d95b022c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1209,7 +1209,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
+			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 85b838720c3..28372c5e2b5 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -600,7 +600,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "updateref", &flags,
 			N_("update the reference to the value of the top reflog entry"),
 			EXPIRE_REFLOGS_UPDATE_REF),
-		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
+		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen")),
 		OPT_CALLBACK_F(0, "expire", &cmd, N_("timestamp"),
 			       N_("prune entries older than the specified time"),
 			       PARSE_OPT_NONEG,
@@ -613,7 +613,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			 N_("prune any reflog entries that point to broken commits")),
 		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
 		OPT_BOOL(1, "single-worktree", &all_worktrees,
-			 N_("limits processing to reflogs from the current worktree only.")),
+			 N_("limits processing to reflogs from the current worktree only")),
 		OPT_END()
 	};
 
@@ -736,7 +736,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "updateref", &flags,
 			N_("update the reference to the value of the top reflog entry"),
 			EXPIRE_REFLOGS_UPDATE_REF),
-		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen.")),
+		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen")),
 		OPT_END()
 	};
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 33c82c3ab91..6332d305983 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1875,7 +1875,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &clone_data.depth,
 			   N_("string"),
 			   N_("depth for shallow clones")),
-		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
+		OPT__QUIET(&quiet, "suppress output for cloning a submodule"),
 		OPT_BOOL(0, "progress", &progress,
 			   N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &require_init,
diff --git a/diff.c b/diff.c
index 7d5cfd325ea..387435a4a45 100644
--- a/diff.c
+++ b/diff.c
@@ -5630,7 +5630,7 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("select files by diff type"),
 			       PARSE_OPT_NONEG, diff_opt_diff_filter),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
-		  N_("Output to a specific file"),
+		  N_("output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
 
 		OPT_END()
diff --git a/parse-options.c b/parse-options.c
index 2437ad3bcdd..91cbfb0d7f7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -492,6 +492,15 @@ static void parse_options_check(const struct option *opts)
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
+		if (opts->type != OPTION_GROUP && opts->help &&
+			!(starts_with(opts->help, "HEAD") ||
+			  starts_with(opts->help, "GPG") ||
+			  starts_with(opts->help, "DEPRECATED") ||
+			  starts_with(opts->help, "SHA1")) &&
+			  (opts->help[0] >= 65 && opts->help[0] <= 90))
+			err |= optbug(opts, xstrfmt("help should not start with capital letter unless needed: %s", opts->help));
+		if (opts->help && !ends_with(opts->help, "...") && ends_with(opts->help, "."))
+			err |= optbug(opts, xstrfmt("help should not end with a dot: %s", opts->help));
 		if (opts->argh &&
 		    strcspn(opts->argh, " _") != strlen(opts->argh))
 			err |= optbug(opts, "multi-word argh should use dash to separate words");
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 913775a14b7..8f370cd89f1 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -221,9 +221,9 @@ static int quote_stress_test(int argc, const char **argv)
 	struct strbuf out = STRBUF_INIT;
 	struct strvec args = STRVEC_INIT;
 	struct option options[] = {
-		OPT_INTEGER('n', "trials", &trials, "Number of trials"),
-		OPT_INTEGER('s', "skip", &skip, "Skip <n> trials"),
-		OPT_BOOL('m', "msys2", &msys2, "Test quoting for MSYS2's sh"),
+		OPT_INTEGER('n', "trials", &trials, "number of trials"),
+		OPT_INTEGER('s', "skip", &skip, "skip <n> trials"),
+		OPT_BOOL('m', "msys2", &msys2, "test quoting for MSYS2's sh"),
 		OPT_END()
 	};
 	const char * const usage[] = {
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 284fe18e726..2a07e130b96 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -53,7 +53,7 @@ test_expect_success 'setup optionspec-only-hidden-switches' '
 |
 |some-command does foo and bar!
 |--
-|hidden1* A hidden switch
+|hidden1* a hidden switch
 EOF
 '
 
@@ -131,7 +131,7 @@ test_expect_success 'test --parseopt help-all output hidden switches' '
 |
 |    some-command does foo and bar!
 |
-|    --hidden1             A hidden switch
+|    --hidden1             a hidden switch
 |
 |EOF
 END_EXPECT

base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
-- 
gitgitgadget
