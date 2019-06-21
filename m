Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60571F461
	for <e@80x24.org>; Fri, 21 Jun 2019 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFUKS2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 06:18:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53008 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfFUKS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 06:18:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so5826814wms.2
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rEBQPMGwnSMaXxJrnqbFpQCaYbTWV5fFCu1cKwnsZ04=;
        b=pgo6FTN7ykCmoIH9ZyWGp+hUjcchmryQGw+r2E51ALXhzJN2X7q45VPbBQ80lBhcUe
         2qw6Li/kkaVqw6/5K5nQt2uSeJleoXkstA0T3QljMMkrljkPd1tWse2rU0HpwWckk/eN
         HLZ85iAWMk6a29oNyiVSaN1ldqcNMr4qGaVCmAFw5rU4bZy7DQ+QjlaLB0qk1OjryZ79
         ElVPZzrCye6xSlSD+9Du+lAagYYJ3miQhtWCXoDK7z+npOuSpzk+VAxPGqRY3Z0SMuFQ
         i8A8JtiZlmwKN3OZJu95a9Fry6iVy3aba7mC2rUEtjw7CNi7/Qw8Xkg5QRUO76Y1h/Qu
         cczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rEBQPMGwnSMaXxJrnqbFpQCaYbTWV5fFCu1cKwnsZ04=;
        b=G+IsGa1OOVu+fZBWyJD7bLysnWE7Q9DOda1oawDfVpkM0cUFt05hDxvLDgbNAYDR6A
         OkKJDOIfNbn5Uk/mswpCQwvrkryC3j1PV1oOHf5hmMz5xMbU9qSOx8zvZDyIQ7MwegBW
         AEI7UpMRNB7BfMoIWbezU4H6arzqyzesdPV81sKRaDhhp5hIKK7dlNG29C1SOp9KhAe3
         vSU1hMwBvSkprPXmJ+M4D8/no0oAyJzDKoM8uIt01TBVHnQMbn64uQ0Jd9iEG7b+NT2v
         e3Ax2sH5I3J3RmXVWf94w/XBbuNPy6gG8MzBmj8eR62wcArrq2nKRtMVPgue3GAaxCwy
         dTFQ==
X-Gm-Message-State: APjAAAWR/ZjjpdWTtPEITiT3z3xaMiLNBbGoksT82eg9hNh/OibQVrQv
        2qGvh80E0kY33ZWRiQTEv9PWj2sqa/Y=
X-Google-Smtp-Source: APXvYqyo4weUy0eNh1E0j7C8UNMX6qpn32O1401NC0vrY6OK8RlUcyNED8rM9VzMnoH2pyuCzVCimw==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr3663786wmf.51.1561112303628;
        Fri, 21 Jun 2019 03:18:23 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y184sm1878193wmg.14.2019.06.21.03.18.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 03:18:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/8] Change <non-empty?> GIT_TEST_* variables to <boolean>
Date:   Fri, 21 Jun 2019 12:18:04 +0200
Message-Id: <20190621101812.27300-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190620210915.11297-1-avarab@gmail.com>
References: <20190620210915.11297-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now with:

 * The --type=bool etc. Ui change to env--bool.

 * I considered supporting YesPlease for gettext poison, but didn't go
   for it. Details in updated commit message.

 * "default" "case" arm fork warning on some compilers.

Ævar Arnfjörð Bjarmason (8):
  config tests: simplify include cycle test
  env--helper: new undocumented builtin wrapping git_env_*()
  config.c: refactor die_bad_number() to not call gettext() early
  t6040 test: stop using global "script" variable
  tests: make GIT_TEST_GETTEXT_POISON a boolean
  tests README: re-flow a previously changed paragraph
  tests: replace test_tristate with "git env--helper"
  tests: make GIT_TEST_FAIL_PREREQS a boolean

 .gitignore                |  1 +
 Makefile                  |  1 +
 builtin.h                 |  1 +
 builtin/env--helper.c     | 95 +++++++++++++++++++++++++++++++++++++
 ci/lib.sh                 |  2 +-
 config.c                  | 28 +++++++----
 gettext.c                 |  6 +--
 git-sh-i18n.sh            |  4 +-
 git.c                     |  1 +
 po/README                 |  2 +-
 t/README                  | 12 ++---
 t/lib-git-daemon.sh       |  7 ++-
 t/lib-git-svn.sh          | 11 ++---
 t/lib-httpd.sh            | 15 +++---
 t/t0000-basic.sh          | 10 ++--
 t/t0017-env-helper.sh     | 99 +++++++++++++++++++++++++++++++++++++++
 t/t0205-gettext-poison.sh |  7 ++-
 t/t1305-config-include.sh | 21 +++------
 t/t5512-ls-remote.sh      |  3 +-
 t/t6040-tracking-info.sh  |  6 +--
 t/t7201-co.sh             |  2 +-
 t/t9902-completion.sh     |  2 +-
 t/test-lib-functions.sh   | 58 ++++-------------------
 t/test-lib.sh             | 31 ++++++++----
 24 files changed, 298 insertions(+), 127 deletions(-)
 create mode 100644 builtin/env--helper.c
 create mode 100755 t/t0017-env-helper.sh

Range-diff:
1:  c3483c37a1 = 1:  c3483c37a1 config tests: simplify include cycle test
2:  e689759f7c ! 2:  39cb96739a env--helper: new undocumented builtin wrapping git_env_*()
    @@ -20,9 +20,11 @@
         default value makes all the difference, and we'll be able to replace
         test_tristate() itself with that.
     
    -    The --mode-bool option will be used by subsequent patches, but not
    -    --mode-ulong. I figured it was easy enough to add it & test for it so
    -    I left it in so we'd have wrappers for both git_env_*() functions.
    +    The --type=bool option will be used by subsequent patches, but not
    +    --type=ulong. I figured it was easy enough to add it & test for it so
    +    I left it in so we'd have wrappers for both git_env_*() functions, and
    +    to have a template to make it obvious how we'd add --type=int etc. if
    +    it's needed in the future.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -72,74 +74,95 @@
     +#include "parse-options.h"
     +
     +static char const * const env__helper_usage[] = {
    -+	N_("git env--helper [--mode-bool | --mode-ulong] --env-variable=<VAR> --env-default=<DEF> [<options>]"),
    ++	N_("git env--helper --type=[bool|ulong] <options> <env-var>"),
     +	NULL
     +};
     +
    ++enum {
    ++	ENV_HELPER_TYPE_BOOL = 1,
    ++	ENV_HELPER_TYPE_ULONG
    ++} cmdmode = 0;
    ++
    ++static int option_parse_type(const struct option *opt, const char *arg,
    ++			     int unset)
    ++{
    ++	if (!strcmp(arg, "bool"))
    ++		cmdmode = ENV_HELPER_TYPE_BOOL;
    ++	else if (!strcmp(arg, "ulong"))
    ++		cmdmode = ENV_HELPER_TYPE_ULONG;
    ++	else
    ++		die(_("unrecognized --type argument, %s"), arg);
    ++
    ++	return 0;
    ++}
    ++
     +int cmd_env__helper(int argc, const char **argv, const char *prefix)
     +{
    -+	enum {
    -+		ENV_HELPER_BOOL = 1,
    -+		ENV_HELPER_ULONG,
    -+	} cmdmode = 0;
     +	int exit_code = 0;
    -+	int quiet = 0;
     +	const char *env_variable = NULL;
     +	const char *env_default = NULL;
     +	int ret;
    -+	int ret_int, tmp_int;
    -+	unsigned long ret_ulong, tmp_ulong;
    ++	int ret_int, default_int;
    ++	unsigned long ret_ulong, default_ulong;
     +	struct option opts[] = {
    -+		OPT_CMDMODE(0, "mode-bool", &cmdmode,
    -+			    N_("invoke git_env_bool(...)"), ENV_HELPER_BOOL),
    -+		OPT_CMDMODE(0, "mode-ulong", &cmdmode,
    -+			    N_("invoke git_env_ulong(...)"), ENV_HELPER_ULONG),
    -+		OPT_STRING(0, "variable", &env_variable, N_("name"),
    -+			   N_("which environment variable to ask git_env_*(...) about")),
    ++		OPT_CALLBACK_F(0, "type", &cmdmode, N_("type"),
    ++			       N_("value is given this type"), PARSE_OPT_NONEG,
    ++			       option_parse_type),
     +		OPT_STRING(0, "default", &env_default, N_("value"),
    -+			   N_("what default value does git_env_*(...) fall back on?")),
    ++			   N_("default for git_env_*(...) to fall back on")),
     +		OPT_BOOL(0, "exit-code", &exit_code,
    -+			 N_("exit code determined by truth of the git_env_*() function")),
    -+		OPT_BOOL(0, "quiet", &quiet,
    -+			 N_("don't print the git_env_*() return value")),
    ++			 N_("be quiet only use git_env_*() value as exit code")),
     +		OPT_END(),
     +	};
     +
    -+	if (parse_options(argc, argv, prefix, opts, env__helper_usage, 0))
    ++	argc = parse_options(argc, argv, prefix, opts, env__helper_usage,
    ++			     PARSE_OPT_KEEP_UNKNOWN);
    ++	if (env_default && !*env_default)
     +		usage_with_options(env__helper_usage, opts);
    -+	if (!env_variable || !env_default ||
    -+	    !*env_variable || !*env_default)
    ++	if (!cmdmode)
     +		usage_with_options(env__helper_usage, opts);
    ++	if (argc != 1)
    ++		usage_with_options(env__helper_usage, opts);
    ++	env_variable = argv[0];
     +
     +	switch (cmdmode) {
    -+	case ENV_HELPER_BOOL:
    -+		tmp_int = strtol(env_default, (char **)&env_default, 10);
    -+		if (*env_default) {
    -+			error(_("option `--default' expects a numerical value with `--mode-bool`"));
    -+			usage_with_options(env__helper_usage, opts);
    ++	case ENV_HELPER_TYPE_BOOL:
    ++		if (env_default) {
    ++			default_int = git_parse_maybe_bool(env_default);
    ++			if (default_int == -1) {
    ++				error(_("option `--default' expects a boolean value with `--type=bool`, not `%s`"),
    ++				      env_default);
    ++				usage_with_options(env__helper_usage, opts);
    ++			}
    ++		} else {
    ++			default_int = 0;
     +		}
    -+		ret_int = git_env_bool(env_variable, tmp_int);
    -+		if (!quiet)
    -+			printf("%d\n", ret_int);
    ++		ret_int = git_env_bool(env_variable, default_int);
    ++		if (!exit_code)
    ++			puts(ret_int ? "true" : "false");
     +		ret = ret_int;
     +		break;
    -+	case ENV_HELPER_ULONG:
    -+		tmp_ulong = strtoll(env_default, (char **)&env_default, 10);
    -+		if (*env_default) {
    -+			error(_("option `--default' expects a numerical value with `--mode-ulong`"));
    -+			usage_with_options(env__helper_usage, opts);
    ++	case ENV_HELPER_TYPE_ULONG:
    ++		if (env_default) {
    ++			if (!git_parse_ulong(env_default, &default_ulong)) {
    ++				error(_("option `--default' expects an unsigned long value with `--type=ulong`, not `%s`"),
    ++				      env_default);
    ++				usage_with_options(env__helper_usage, opts);
    ++			}
    ++		} else {
    ++			default_ulong = 0;
     +		}
    -+		ret_ulong = git_env_ulong(env_variable, tmp_ulong);
    -+		if (!quiet)
    ++		ret_ulong = git_env_ulong(env_variable, default_ulong);
    ++		if (!exit_code)
     +			printf("%lu\n", ret_ulong);
     +		ret = ret_ulong;
     +		break;
    ++	default:
    ++		BUG("unknown <type> value");
    ++		break;
     +	}
     +
    -+	if (exit_code)
    -+		return !ret;
    -+
    -+	return 0;
    ++	return !ret;
     +}
     
      diff --git a/git.c b/git.c
    @@ -168,64 +191,77 @@
     +
     +test_expect_success 'env--helper usage' '
     +	test_must_fail git env--helper &&
    -+	test_must_fail git env--helper --mode-bool &&
    -+	test_must_fail git env--helper --mode-ulong &&
    -+	test_must_fail git env--helper --mode-bool --variable &&
    -+	test_must_fail git env--helper --mode-bool --variable --default &&
    -+	test_must_fail git env--helper --mode-bool --variable= --default=
    ++	test_must_fail git env--helper --type=bool &&
    ++	test_must_fail git env--helper --type=ulong &&
    ++	test_must_fail git env--helper --type=bool &&
    ++	test_must_fail git env--helper --type=bool --default &&
    ++	test_must_fail git env--helper --type=bool --default= &&
    ++	test_must_fail git env--helper --defaultxyz
     +'
     +
     +test_expect_success 'env--helper bad default values' '
    -+	test_must_fail git env--helper --mode-bool --variable=MISSING --default=1xyz &&
    -+	test_must_fail git env--helper --mode-ulong --variable=MISSING --default=1xyz
    ++	test_must_fail git env--helper --type=bool --default=1xyz MISSING &&
    ++	test_must_fail git env--helper --type=ulong --default=1xyz MISSING
     +'
     +
    -+test_expect_success 'env--helper --mode-bool' '
    -+	echo 1 >expected &&
    -+	git env--helper --mode-bool --variable=MISSING --default=1 --exit-code >actual &&
    ++test_expect_success 'env--helper --type=bool' '
    ++	# Test various --default bool values
    ++	echo true >expected &&
    ++	git env--helper --type=bool --default=1 MISSING >actual &&
     +	test_cmp expected actual &&
    -+
    -+	echo 0 >expected &&
    -+	test_must_fail git env--helper --mode-bool --variable=MISSING --default=0 --exit-code >actual &&
    ++	git env--helper --type=bool --default=yes MISSING >actual &&
     +	test_cmp expected actual &&
    -+
    -+	git env--helper --mode-bool --variable=MISSING --default=0 >actual &&
    ++	git env--helper --type=bool --default=true MISSING >actual &&
     +	test_cmp expected actual &&
    -+
    -+	>expected &&
    -+	git env--helper --mode-bool --variable=MISSING --default=1 --exit-code --quiet >actual &&
    ++	echo false >expected &&
    ++	test_must_fail git env--helper --type=bool --default=0 MISSING >actual &&
     +	test_cmp expected actual &&
    -+
    -+	EXISTS=true git env--helper --mode-bool --variable=EXISTS --default=0 --exit-code --quiet >actual &&
    ++	test_must_fail git env--helper --type=bool --default=no MISSING >actual &&
    ++	test_cmp expected actual &&
    ++	test_must_fail git env--helper --type=bool --default=false MISSING >actual &&
     +	test_cmp expected actual &&
     +
    -+	echo 1 >expected &&
    -+	EXISTS=true git env--helper --mode-bool --variable=EXISTS --default=0 --exit-code >actual &&
    -+	test_cmp expected actual
    ++	# No output with --exit-code
    ++	git env--helper --type=bool --default=true --exit-code MISSING >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_must_be_empty actual.err &&
    ++	test_must_fail git env--helper --type=bool --default=false --exit-code MISSING >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_must_be_empty actual.err &&
    ++
    ++	# Existing variable
    ++	EXISTS=true git env--helper --type=bool --default=false --exit-code EXISTS >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_must_be_empty actual.err &&
    ++	test_must_fail \
    ++		env EXISTS=false \
    ++		git env--helper --type=bool --default=true --exit-code EXISTS >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_must_be_empty actual.err
     +'
     +
    -+test_expect_success 'env--helper --mode-ulong' '
    ++test_expect_success 'env--helper --type=ulong' '
     +	echo 1234567890 >expected &&
    -+	git env--helper --mode-ulong --variable=MISSING --default=1234567890 --exit-code >actual &&
    -+	test_cmp expected actual &&
    ++	git env--helper --type=ulong --default=1234567890 MISSING >actual.out 2>actual.err &&
    ++	test_cmp expected actual.out &&
    ++	test_must_be_empty actual.err &&
     +
     +	echo 0 >expected &&
    -+	test_must_fail git env--helper --mode-ulong --variable=MISSING --default=0 --exit-code >actual &&
    ++	test_must_fail git env--helper --type=ulong --default=0 MISSING >actual &&
     +	test_cmp expected actual &&
     +
    -+	git env--helper --mode-ulong --variable=MISSING --default=0 >actual &&
    -+	test_cmp expected actual &&
    ++	git env--helper --type=ulong --default=1234567890 --exit-code MISSING >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_must_be_empty actual.err &&
     +
    -+	>expected &&
    -+	git env--helper --mode-ulong --variable=MISSING --default=1234567890 --exit-code --quiet >actual &&
    -+	test_cmp expected actual &&
    -+
    -+	EXISTS=1234567890 git env--helper --mode-ulong --variable=EXISTS --default=0 --exit-code --quiet >actual &&
    -+	test_cmp expected actual &&
    ++	EXISTS=1234567890 git env--helper --type=ulong --default=0 EXISTS --exit-code >actual.out 2>actual.err &&
    ++	test_must_be_empty actual.out &&
    ++	test_must_be_empty actual.err &&
     +
     +	echo 1234567890 >expected &&
    -+	EXISTS=1234567890 git env--helper --mode-ulong --variable=EXISTS --default=0 --exit-code >actual &&
    -+	test_cmp expected actual
    ++	EXISTS=1234567890 git env--helper --type=ulong --default=0 EXISTS >actual.out 2>actual.err &&
    ++	test_cmp expected actual.out &&
    ++	test_must_be_empty actual.err
     +'
     +
     +test_done
3:  f759d5e91e = 3:  8a88f263bf config.c: refactor die_bad_number() to not call gettext() early
4:  1ac798e8ce = 4:  6594a95d6e t6040 test: stop using global "script" variable
5:  d7d6e6c874 ! 5:  248c0f9d46 tests: make GIT_TEST_GETTEXT_POISON a boolean
    @@ -17,7 +17,7 @@
         the special case of GIT_TEST_GETTEXT_POISON and always emit that
         message in the C locale, lest we infinitely loop.
     
    -    As seen in the updated tests in t0016-env-helper.sh there's also a
    +    As seen in the updated tests in t0017-env-helper.sh there's also a
         caveat related to "env--helper" needing to read the config for trace2
         purposes.
     
    @@ -32,6 +32,21 @@
         change in this series won't happen again, and testing for this
         explicitly in "env--helper"'s own tests.
     
    +    This change breaks existing uses of
    +    e.g. GIT_TEST_GETTEXT_POISON=YesPlease, which we've documented in
    +    po/README and other places. As noted in [1] we might want to consider
    +    also accepting "YesPlease" in "env--helper" as a special-case.
    +
    +    But as the lack of uproar over 6cdccfce1e ("i18n: make GETTEXT_POISON
    +    a runtime option", 2018-11-08) demonstrates the audience for this
    +    option is a really narrow set of git developers, who shouldn't have
    +    much trouble modifying their test scripts, so I think it's better to
    +    deal with that minor headache now and make all the relevant GIT_TEST_*
    +    variables boolean in the same way than carry the "YesPlease"
    +    special-case forward.
    +
    +    1. https://public-inbox.org/git/xmqqtvckm3h8.fsf@gitster-ct.c.googlers.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      diff --git a/ci/lib.sh b/ci/lib.sh
    @@ -93,8 +108,8 @@
      GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
     -if test -n "$GIT_TEST_GETTEXT_POISON"
     +if test -n "$GIT_TEST_GETTEXT_POISON" &&
    -+	    git env--helper --mode-bool --variable=GIT_TEST_GETTEXT_POISON \
    -+		--default=0 --exit-code --quiet
    ++	    git env--helper --type=bool --default=0 --exit-code \
    ++		GIT_TEST_GETTEXT_POISON
      then
      	GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
      elif test -n "@@USE_GETTEXT_SCHEME@@"
    @@ -131,7 +146,7 @@
      --- a/t/t0017-env-helper.sh
      +++ b/t/t0017-env-helper.sh
     @@
    - 	test_cmp expected actual
    + 	test_must_be_empty actual.err
      '
      
     +test_expect_success 'env--helper reads config thanks to trace2' '
    @@ -146,7 +161,7 @@
     +
     +	test_must_fail \
     +		env HOME="$(pwd)/home" GIT_TEST_GETTEXT_POISON=true \
    -+		git -C cycle env--helper --mode-bool --variable=GIT_TEST_GETTEXT_POISON --default=0 --exit-code --quiet 2>err &&
    ++		git -C cycle env--helper --type=bool --default=0 --exit-code GIT_TEST_GETTEXT_POISON 2>err &&
     +	grep "# GETTEXT POISON #" err
     +'
     +
    @@ -227,7 +242,7 @@
     -	test_set_prereq C_LOCALE_OUTPUT
     -fi
     +test_lazy_prereq C_LOCALE_OUTPUT '
    -+	! git env--helper --mode-bool --variable=GIT_TEST_GETTEXT_POISON --default=0 --exit-code --quiet
    ++	! git env--helper --type=bool --default=0 --exit-code GIT_TEST_GETTEXT_POISON
     +'
      
      if test -z "$GIT_TEST_CHECK_CACHE_TREE"
6:  954428b3cd = 6:  c9d44aa306 tests README: re-flow a previously changed paragraph
7:  79b41cf01b ! 7:  b0bab6adc8 tests: replace test_tristate with "git env--helper"
    @@ -35,7 +35,7 @@
      
     -test_tristate GIT_TEST_GIT_DAEMON
     -if test "$GIT_TEST_GIT_DAEMON" = false
    -+if ! git env--helper --mode-bool --variable=GIT_TEST_GIT_DAEMON --default=1 --exit-code --quiet
    ++if ! git env--helper --type=bool --default=true --exit-code GIT_TEST_GIT_DAEMON
      then
      	skip_all="git-daemon testing disabled (unset GIT_TEST_GIT_DAEMON to enable)"
      	test_done
    @@ -68,7 +68,7 @@
     -	test_tristate GIT_SVN_TEST_HTTPD
     -	case $GIT_SVN_TEST_HTTPD in
     -	true)
    -+	if git env--helper --mode-bool --variable=GIT_TEST_HTTPD --default=0 --exit-code --quiet	
    ++	if git env--helper --type=bool --default=false --exit-code GIT_TEST_HTTPD
     +	then
      		. "$TEST_DIRECTORY"/lib-httpd.sh
      		LIB_HTTPD_SVN="$loc"
    @@ -85,7 +85,7 @@
      require_svnserve () {
     -	test_tristate GIT_TEST_SVNSERVE
     -	if ! test "$GIT_TEST_SVNSERVE" = true
    -+	if ! git env--helper --mode-bool --variable=GIT_TEST_SVNSERVE --default=0 --exit-code --quiet
    ++	if ! git env--helper --type=bool --default=false --exit-code GIT_TEST_SVNSERVE
      	then
      		skip_all='skipping svnserve test. (set $GIT_TEST_SVNSERVE to enable)'
      		test_done
    @@ -99,7 +99,7 @@
      
     -test_tristate GIT_TEST_HTTPD
     -if test "$GIT_TEST_HTTPD" = false
    -+if ! git env--helper --mode-bool --variable=GIT_TEST_HTTPD --default=1 --exit-code --quiet
    ++if ! git env--helper --type=bool --default=true --exit-code GIT_TEST_HTTPD
      then
      	skip_all="Network testing disabled (unset GIT_TEST_HTTPD to enable)"
      	test_done
    @@ -162,7 +162,7 @@
      test_lazy_prereq GIT_DAEMON '
     -	test_tristate GIT_TEST_GIT_DAEMON &&
     -	test "$GIT_TEST_GIT_DAEMON" != false
    -+	git env--helper --mode-bool --variable=GIT_TEST_GIT_DAEMON --default=1 --exit-code --quiet
    ++	git env--helper --type=bool --default=true --exit-code GIT_TEST_GIT_DAEMON
      '
      
      # This test spawns a daemon, so run it only if the user would be OK with
8:  a9aa166b66 ! 8:  d1a32debba tests: make GIT_TEST_FAIL_PREREQS a boolean
    @@ -90,6 +90,15 @@
      	then
      		case "$1" in
      		# The "!" case is handled below with
    +@@
    + # The error/skip message should be given by $2.
    + #
    + test_skip_or_die () {
    +-	if ! git env--helper --mode-bool --variable=$1 --default=0 --exit-code --quiet
    ++	if ! git env--helper --type=bool --default=false --exit-code $1
    + 	then
    + 		skip_all=$2
    + 		test_done
     
      diff --git a/t/test-lib.sh b/t/test-lib.sh
      --- a/t/test-lib.sh
    @@ -106,16 +115,14 @@
     +GIT_TEST_FAIL_PREREQS_INTERNAL=
     +if test -n "$GIT_TEST_FAIL_PREREQS"
     +then
    -+	if git env--helper --mode-bool --variable=GIT_TEST_FAIL_PREREQS \
    -+		--default=0 --exit-code --quiet
    ++	if git env--helper --type=bool --default=0 --exit-code GIT_TEST_FAIL_PREREQS
     +	then
     +		GIT_TEST_FAIL_PREREQS_INTERNAL=true
     +		test_set_prereq FAIL_PREREQS
     +	fi
     +else
     +	test_lazy_prereq FAIL_PREREQS '
    -+		git env--helper --mode-bool --variable=GIT_TEST_FAIL_PREREQS \
    -+			--default=0 --exit-code --quiet
    ++		git env--helper --type=bool --default=0 --exit-code GIT_TEST_FAIL_PREREQS
     +	'
     +fi
     +
-- 
2.22.0.455.g172b71a6c5

