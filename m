Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E45520248
	for <e@80x24.org>; Mon, 25 Mar 2019 20:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfCYUXn (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 16:23:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37863 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYUXm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 16:23:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so10556926wmf.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GfCDbT7FUIEK4ZzwmpDtwa8wFKmGyRYtWPa6meDHXew=;
        b=F/God8coB9ljOPBj7LEgpaE4DWXUj4wBWlfTzqgPV/J1+rtB8dgRHFbJUYO4+lu9Yn
         U8Ap0/xh7AeYUJDqKoxFiClQG/Dwz0H7/+zN+WbqtTPTWEZmK3N4nsyymM5JtMkMOmj8
         g35LqdykffDAumT+cR2GUXMC1rRj3FVWMOr2Eylc0CsrFhgtJjur1XyZF2RPGUU4Bob7
         sZ4oJXG018enxvAVhiOcUKVxs2LRdGj77FwKjDxpGPLGQv5OaAd9VfOKUoFW2R//EGGo
         2NJKUmkiv5hqSAWMnINnJWuczoHcOkMNUeSPPBxCYCdRhWN6j6bVJ8ohOStaxjen9C7X
         3mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GfCDbT7FUIEK4ZzwmpDtwa8wFKmGyRYtWPa6meDHXew=;
        b=IkXjKuBgkGanV/hZre8eSijMBZ8gB8wLZQVxTJFLW4DgG+HqilK0mt6FXJh7edp4Lj
         tYGl//PFKiwPw2X5r964Co3E5SPX9dVsq7gPdAMgWP7s9+kS0lVI/jd1Wv2VtAy34tTB
         WN10dXXTEO9+gOYZsRHyr5ukZ4tMRLMjiDL1iW7Ex3XIzLwUZLRhI1GdbUwWAQjGsARe
         ewd8hPqnVs8a+sqHOhTcYDewtkG1GA5PcqBnozNv2lqo46QdJA3OvD8W0HFjdtlA96Kb
         VAJxPlVR7RGxlU62fLSyak4A4nYp7nUpbkGhW9nYCsX5q/ytY6AJopxjFxyYo05B8HN6
         +h+A==
X-Gm-Message-State: APjAAAXzyKFqfFnRP1uPMEZoThIZBLdqKCxWiBHrFd+eZMJrx865+RYR
        LAdbKSzXZvgdr/d2bVvjymQXPGwAvj8=
X-Google-Smtp-Source: APXvYqzTz2ZPWHvXn6WlC2mS4Zz9gIKHsWYgb0cl887c4q5oWUWM5WxwcPaRcEYsQWnUoLgxtAf0gQ==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr5135057wmk.108.1553545420774;
        Mon, 25 Mar 2019 13:23:40 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q26sm16506904wmc.6.2019.03.25.13.23.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 13:23:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] parse-options: allow for configuring option abbreviation
Date:   Mon, 25 Mar 2019 21:23:28 +0100
Message-Id: <20190325202329.26033-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new core.abbreviatedOptions which corresponds to the newly added
GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS test mode. This allows
e.g. script authors to enact the same sort of paranoia about option
abbreviation as our own test suite now uses by default.

I'm renaming GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS to
GIT_TEST_ABBREVIATED_OPTIONS for consistency with the new
configuration variable, and I've picked the shorter
core.abbreviatedOptions instead of core.disallowAbbreviatedOptions
because it's easier to reason about a variable that's true by default
than about one that has a negation in its name.

While I'm at it, factor out the check for the environment variable
into a parse_options_config() which similar to the code added in
62c23938fa ("tests: add a special setup where rebase.useBuiltin is
off", 2018-11-14) will first check the environment variable, and then
the configuration.

Using git_env_bool() means it's a bit of a pain to distinguish between
the case where GIT_TEST_ABBREVIATED_OPTIONS is set to "true" or
"false" v.s. being empty, hence the
test_when_finished/export/sane_unset dance in the test that's being
added, but I think that's more sane than introducing a "bool but not
in the same way as the rest" GIT_TEST_* variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/core.txt | 12 ++++++++++++
 parse-options.c               | 19 +++++++++++++++----
 t/README                      |  4 ++--
 t/t0040-parse-options.sh      | 22 +++++++++++++++++-----
 t/test-lib.sh                 |  6 +++---
 5 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 7e9b6c8f4c..5a42ec3940 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -1,3 +1,15 @@
+core.abbreviatedOptions::
+	Defaults to `true` which allows options to be abbreviated as
+	long as they aren't ambiguous, e.g. for linkgit:git-init[1]
+	the `--bare` option can be abbreviated as `--bar`, `--ba` or
+	even `--b` since no other option starts with those
+	prefixes. However, if such an option were added in the future
+	any use of these abbreviations would break.
++
+By setting this to false (e.g. in scripts) you can defend against such
+future breakages by enforcing that options must always be fully
+provided.
+
 core.fileMode::
 	Tells Git if the executable bit of files in the working tree
 	is to be honored.
diff --git a/parse-options.c b/parse-options.c
index acc3a93660..d6a291f705 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -6,7 +6,7 @@
 #include "color.h"
 #include "utf8.h"
 
-static int disallow_abbreviated_options;
+static int abbreviated_options = 1;
 
 #define OPT_SHORT 1
 #define OPT_UNSET 2
@@ -346,7 +346,7 @@ static enum parse_opt_result parse_long_opt(
 		return get_value(p, options, all_opts, flags ^ opt_flags);
 	}
 
-	if (disallow_abbreviated_options && (ambiguous_option || abbrev_option))
+	if (!abbreviated_options && (ambiguous_option || abbrev_option))
 		die("disallowed abbreviated or ambiguous option '%.*s'",
 		    (int)(arg_end - arg), arg);
 
@@ -456,6 +456,17 @@ static void parse_options_check(const struct option *opts)
 		exit(128);
 }
 
+static void parse_options_config(void)
+{
+	int env = git_env_bool("GIT_TEST_ABBREVIATED_OPTIONS", -1);
+	if (env != -1) {
+		abbreviated_options = env;
+		return;
+	}
+	git_config_get_bool("core.abbreviatedoptions", &abbreviated_options);
+	return;
+}
+
 void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 int argc, const char **argv, const char *prefix,
 			 const struct option *options, int flags)
@@ -480,6 +491,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	    (flags & PARSE_OPT_KEEP_ARGV0))
 		BUG("Can't keep argv0 if you don't have it");
 	parse_options_check(options);
+	parse_options_config();
 }
 
 static void show_negated_gitcomp(const struct option *opts, int nr_noopts)
@@ -714,9 +726,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
 {
 	struct parse_opt_ctx_t ctx;
 
-	disallow_abbreviated_options =
-		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);
 
+	parse_options_config();
 	parse_options_start(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
diff --git a/t/README b/t/README
index 9ed3051a1c..1d628baf31 100644
--- a/t/README
+++ b/t/README
@@ -399,9 +399,9 @@ GIT_TEST_SIDEBAND_ALL=<boolean>, when true, overrides the
 fetch-pack to not request sideband-all (even if the server advertises
 sideband-all).
 
-GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
+GIT_TEST_ABBREVIATED_OPTIONS=<boolean>, when false (which is
 the default when running tests), errors out when an abbreviated option
-is used.
+is used. Overrides the core.abbreviatedOptions setting.
 
 Naming Tests
 ------------
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 5f6a16336d..19685d1582 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -203,27 +203,39 @@ file: (not set)
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
-	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	GIT_TEST_ABBREVIATED_OPTIONS=true \
 	test-tool parse-options --int 2 --boolean --no-bo >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
-	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	GIT_TEST_ABBREVIATED_OPTIONS=true \
 	test-tool parse-options --expect="integer: 2" --int=2
 '
 
 test_expect_success 'ambiguously abbreviated option' '
-	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	test_expect_code 129 env GIT_TEST_ABBREVIATED_OPTIONS=true \
 	test-tool parse-options --strin 123
 '
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
-	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	GIT_TEST_ABBREVIATED_OPTIONS=true \
 	test-tool parse-options --expect="string: 123" --st 123
 '
 
+test_expect_success 'abbreviated options configured with core.abbreviatedOptions' '
+	test_when_finished "
+		rm -rf A B C &&
+		GIT_TEST_ABBREVIATED_OPTIONS=$GIT_TEST_ABBREVIATED_OPTIONS &&
+		export GIT_TEST_ABBREVIATED_OPTIONS
+	" &&
+	git init --bare A &&
+	test_must_fail git init --ba B &&
+	sane_unset GIT_TEST_ABBREVIATED_OPTIONS &&
+	git -c core.abbreviatedOptions=true init --ba C
+'
+
 cat >typo.err <<\EOF
 error: did you mean `--boolean` (with two dashes ?)
 EOF
@@ -329,7 +341,7 @@ file: (not set)
 EOF
 
 test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
-	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	GIT_TEST_ABBREVIATED_OPTIONS=true \
 	test-tool parse-options --no-ambig >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e550009411..4b0dd8a1a9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -58,9 +58,9 @@ fi
 export PERL_PATH SHELL_PATH
 
 # Disallow the use of abbreviated options in the test suite by default
-test -n "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" || {
-	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true
-	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
+test -n "$GIT_TEST_ABBREVIATED_OPTIONS" || {
+	GIT_TEST_ABBREVIATED_OPTIONS=false
+	export GIT_TEST_ABBREVIATED_OPTIONS
 }
 
 ################################################################
-- 
2.21.0.360.g471c308f928

