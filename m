Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115FC1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 21:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJXF1M (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 01:27:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39400 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJXF1L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 01:27:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id y144-v6so3202397wmd.4
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 14:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bo2KL+467BbSe54UFadRR89AczTUd90rsbpCpvcfHuU=;
        b=QTSH6mYydhl+Qng2EcUcGjfhV5C2agphbtOuBtZjlT00jzYBso2p4zEbnOhhCijtGj
         ff42ymDAThGx69Lh7g2FoQtgrJsl5Q0PR/iyGGMp9ghBlFohtnrDlCGciyDWSao0PSTX
         4BP+Dd40Qg1Km1GA5ZQ92bPOz/4m3LAvbcApxc4XnXw5eRvIF4rJDSnUNp56GCwJc7hq
         7w0EVsW8B5282QIY8Tr/O3PQt3a7RGHJ0cYngRE1X7zAxLZU2HKXuaRgz5q21YsA17dT
         qoSFjJc1vmbWVleR/Jt7D+yQK3S0qcp+AYxWnEbxcxZWnxhC8vXAPbD+2O4SaE6Rvktk
         XjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo2KL+467BbSe54UFadRR89AczTUd90rsbpCpvcfHuU=;
        b=mnAL+s/I6wOaR+q0QYxeUCRtNHpVH9mphvixHFhWNwzcwvPtmmgef+FYsJ1V38331p
         pftk4o6u9lb2gC+5fRVm4eoudC3xzQuj2nxDj2tSk5qWdIBZujimAWtB5ya8z8bpINF7
         8TUkiuku1zngRs9NQ3zI/gY00mCe5V1fCphPZhB9oAZFYjwzmToRiZ7/+2ZN6EaDKkT0
         Jsq7Pgxo7uJwq8QexPjvg9zLdYxbDKCN57K63AzNscSqY1JocRzKXKxKddKatwFzxz+n
         evYfbQ14vC41dsT6eafbmsizTo6/ze98eUTi4Xx+2wiO2mBTSX/cYadqc8kfWg2Ptbdq
         1PyQ==
X-Gm-Message-State: AGRZ1gLTjdeKareaOwE1CjMYdIxU0vCQsrOkIL+vL+e9kJ21D2twpaxA
        YZXlWCRKoM4s8bQCMNdcbmmKfscX
X-Google-Smtp-Source: ACcGV61T73Un99cDRVOTRFFx5+GBL0vqRFMdV+BpF1mEu/cHD/eJT5VCFZbK5tlECKA1PpQLbCXPyQ==
X-Received: by 2002:a1c:a851:: with SMTP id r78-v6mr17329580wme.97.1540328524302;
        Tue, 23 Oct 2018 14:02:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c14-v6sm4463471wmh.44.2018.10.23.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:02:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] i18n: make GETTEXT_POISON a runtime option
Date:   Tue, 23 Oct 2018 21:01:54 +0000
Message-Id: <20181023210154.32507-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
References: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the GETTEXT_POISON compile-time + runtime GIT_GETTEXT_POISON
test parameter to only be a GIT_TEST_GETTEXT_POISON=<boolean> runtime
parameter, to be consistent with other parameters documented in
"Running tests with special setups" in t/README.

When I added GETTEXT_POISON in bb946bba76 ("i18n: add GETTEXT_POISON
to simulate unfriendly translator", 2011-02-22) I was concerned with
ensuring that the _() function would get constant folded if NO_GETTEXT
was defined or if it wasn't and GETTEXT_POISON wasn't defined.

But as the benchmark in my [1] shows doing a one-off runtime
getenv("GIT_TEST_[...]") is trivial, and since GETTEXT_POISON was
originally added this has become the common idiom in the codebase for
turning on special test setups.

So change GETTEXT_POISON to work the same way. Now the
GETTEXT_POISON=YesPlease compile-time option is gone, and running the
tests with GIT_TEST_GETTEXT_POISON=[true|false] can be toggled on/off
without recompiling.

This allows for conditionally amending tests to test with/without
poison, similar to what 859fdc0c3c ("commit-graph: define
GIT_TEST_COMMIT_GRAPH", 2018-08-29) did for GIT_TEST_COMMIT_GRAPH, but
this patch doesn't change any of the existing tests to work like that.

Notes on the implementation:

 * The only reason we need a new "git-sh-i18n--helper" and the
   corresponding "test-tool gettext-poison" is to expose
   git_env_bool() to shellscripts, since git-sh-i18n and friends need
   to inspect the $GIT_TEST_GETTEXT_POISON variable.

   We only call these if $GIT_TEST_GETTEXT_POISON is set, or in the
   test suite, and this code can go away for non-test code once the
   last i18n-using shellscript is rewritten in C.

 * We still compile a dedicated GETTEXT_POISON build in Travis CI,
   this is probably the wrong thing to do and should be followed-up
   with something similar to ae59a4e44f ("travis: run tests with
   GIT_TEST_SPLIT_INDEX", 2018-01-07) to re-use an existing test setup
   for running in the GIT_TEST_GETTEXT_POISON mode.

 * The reason for not doing:

       test_lazy_prereq GETTEXT_POISON 'test-tool gettext-poison'
       test_lazy_prereq C_LOCALE_OUTPUT '! test-tool gettext-poison'

   In test-lib.sh is because there's some interpolation problem with
   that syntax which makes t6040-tracking-info.sh fail. Hence using
   the simpler test_set_prereq.

See also
https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/ for
more discussion.

1. https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Mon, Oct 22 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> So I think the only reason to keep it compile-time is performance, but I
>> don't think that matters. It's not like we're printing gigabytes of _()
>> formatted output. Everything where formatting matters is plumbing which
>> doesn't use this API. These messages are always for human consumption.
>>
>> So shouldn't we just drop this notion of GETTEXT_POISON at compile-time
>> entirely, and make GIT_GETTEXT_POISON=<boolean> a test flag that all
>> builds of git are aware of? I think so.
>
> Haven't thought things through, but that sounds like a good thing to
> aim for.  Keep the ideas coming...

Here's a polished version of that. I think it makes sense to queue
this up before any other refactoring of GETTEXT_POISON, and some patch
to unconditionally preserve format specifiers as I suggested upthread
could go on top of this.

 .gitignore                     |  1 +
 .travis.yml                    |  2 +-
 Makefile                       | 11 ++---------
 builtin.h                      |  1 +
 builtin/sh-i18n--helper.c      | 27 +++++++++++++++++++++++++++
 ci/lib-travisci.sh             |  4 ++--
 gettext.c                      |  5 ++---
 gettext.h                      |  4 ----
 git-sh-i18n.sh                 |  3 ++-
 git.c                          |  1 +
 po/README                      | 13 ++++---------
 t/README                       |  6 ++++++
 t/helper/test-gettext-poison.c |  9 +++++++++
 t/helper/test-tool.c           |  1 +
 t/helper/test-tool.h           |  1 +
 t/t0000-basic.sh               |  2 +-
 t/t3406-rebase-message.sh      |  2 +-
 t/t7201-co.sh                  |  5 ++++-
 t/test-lib-functions.sh        |  8 ++++----
 t/test-lib.sh                  | 11 ++---------
 20 files changed, 72 insertions(+), 45 deletions(-)
 create mode 100644 builtin/sh-i18n--helper.c
 create mode 100644 t/helper/test-gettext-poison.c

diff --git a/.gitignore b/.gitignore
index 9d1363a1eb..f7b7977910 100644
--- a/.gitignore
+++ b/.gitignore
@@ -148,6 +148,7 @@
 /git-serve
 /git-sh-i18n
 /git-sh-i18n--envsubst
+/git-sh-i18n--helper
 /git-sh-setup
 /git-sh-i18n
 /git-shell
diff --git a/.travis.yml b/.travis.yml
index 4d4e26c9df..4523a2e5ec 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -26,7 +26,7 @@ addons:
 
 matrix:
   include:
-    - env: jobname=GETTEXT_POISON
+    - env: jobname=GIT_TEST_GETTEXT_POISON
       os: linux
       compiler:
       addons:
diff --git a/Makefile b/Makefile
index d18ab0fe78..684dec4d39 100644
--- a/Makefile
+++ b/Makefile
@@ -362,11 +362,6 @@ all::
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
 # user.
 #
-# Define GETTEXT_POISON if you are debugging the choice of strings marked
-# for translation.  In a GETTEXT_POISON build, you can turn all strings marked
-# for translation into gibberish by setting the GIT_GETTEXT_POISON variable
-# (to any value) in your environment.
-#
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
@@ -714,6 +709,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
+TEST_BUILTINS_OBJS += test-gettext-poison.o
 TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-json-writer.o
@@ -1099,6 +1095,7 @@ BUILTIN_OBJS += builtin/revert.o
 BUILTIN_OBJS += builtin/rm.o
 BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/serve.o
+BUILTIN_OBJS += builtin/sh-i18n--helper.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
@@ -1439,9 +1436,6 @@ endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
-ifdef GETTEXT_POISON
-	BASIC_CFLAGS += -DGETTEXT_POISON
-endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
 	USE_GETTEXT_SCHEME ?= fallthrough
@@ -2591,7 +2585,6 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
 endif
 	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
-	@echo GETTEXT_POISON=\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POISON)))'\' >>$@+
 ifdef GIT_PERF_REPEAT_COUNT
 	@echo GIT_PERF_REPEAT_COUNT=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPEAT_COUNT)))'\' >>$@+
 endif
diff --git a/builtin.h b/builtin.h
index 962f0489ab..a40c56e7a2 100644
--- a/builtin.h
+++ b/builtin.h
@@ -219,6 +219,7 @@ extern int cmd_revert(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_serve(int argc, const char **argv, const char *prefix);
+extern int cmd_sh_i18n__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
diff --git a/builtin/sh-i18n--helper.c b/builtin/sh-i18n--helper.c
new file mode 100644
index 0000000000..1fba8b902b
--- /dev/null
+++ b/builtin/sh-i18n--helper.c
@@ -0,0 +1,27 @@
+#include "builtin.h"
+#include "cache.h"
+#include "config.h"
+#include "parse-options.h"
+
+static const char * const builtin_sh_i18n_helper_usage[] = {
+	N_("git sh-i18n--helper [<options>]"),
+	NULL
+};
+
+int cmd_sh_i18n__helper(int argc, const char **argv, const char *prefix)
+{
+	int poison = -1;
+	struct option options[] = {
+		OPT_BOOL(0, "git-test-gettext-poison", &poison,
+			 N_("is GIT_TEST_GETTEXT_POISON in effect?")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     builtin_sh_i18n_helper_usage, PARSE_OPT_KEEP_ARGV0);
+
+	if (poison != -1)
+		return !git_env_bool("GIT_TEST_GETTEXT_POISON", 0);
+
+	usage_with_options(builtin_sh_i18n_helper_usage, options);
+}
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 06970f7213..6a89d0d7d8 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -123,7 +123,7 @@ osx-clang|osx-gcc)
 	# Travis CI OS X
 	export GIT_SKIP_TESTS="t9810 t9816"
 	;;
-GETTEXT_POISON)
-	export GETTEXT_POISON=YesPlease
+GIT_TEST_GETTEXT_POISON)
+	export GIT_TEST_GETTEXT_POISON=true
 	;;
 esac
diff --git a/gettext.c b/gettext.c
index 7272771c8e..722a2f726c 100644
--- a/gettext.c
+++ b/gettext.c
@@ -7,6 +7,7 @@
 #include "gettext.h"
 #include "strbuf.h"
 #include "utf8.h"
+#include "config.h"
 
 #ifndef NO_GETTEXT
 #	include <locale.h>
@@ -46,15 +47,13 @@ const char *get_preferred_languages(void)
 	return NULL;
 }
 
-#ifdef GETTEXT_POISON
 int use_gettext_poison(void)
 {
 	static int poison_requested = -1;
 	if (poison_requested == -1)
-		poison_requested = getenv("GIT_GETTEXT_POISON") ? 1 : 0;
+		poison_requested = git_env_bool("GIT_TEST_GETTEXT_POISON", 0);
 	return poison_requested;
 }
-#endif
 
 #ifndef NO_GETTEXT
 static int test_vsnprintf(const char *fmt, ...)
diff --git a/gettext.h b/gettext.h
index 7eee64a34f..4c492d9f57 100644
--- a/gettext.h
+++ b/gettext.h
@@ -41,11 +41,7 @@ static inline int gettext_width(const char *s)
 }
 #endif
 
-#ifdef GETTEXT_POISON
 extern int use_gettext_poison(void);
-#else
-#define use_gettext_poison() 0
-#endif
 
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 9d065fb4bf..c0713b1ee9 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -17,7 +17,8 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "$GIT_GETTEXT_POISON"
+if test -n "$GIT_TEST_GETTEXT_POISON" &&
+	    git sh-i18n--helper --git-test-gettext-poison
 then
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
 elif test -n "@@USE_GETTEXT_SCHEME@@"
diff --git a/git.c b/git.c
index 5920f8019b..125c523720 100644
--- a/git.c
+++ b/git.c
@@ -539,6 +539,7 @@ static struct cmd_struct commands[] = {
 	{ "rm", cmd_rm, RUN_SETUP },
 	{ "send-pack", cmd_send_pack, RUN_SETUP },
 	{ "serve", cmd_serve, RUN_SETUP },
+	{ "sh-i18n--helper", cmd_sh_i18n__helper, 0 },
 	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 	{ "show", cmd_show, RUN_SETUP },
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
diff --git a/po/README b/po/README
index fef4c0f0b5..dba46c4a40 100644
--- a/po/README
+++ b/po/README
@@ -289,16 +289,11 @@ something in the test suite might still depend on the US English
 version of the strings, e.g. to grep some error message or other
 output.
 
-To smoke out issues like these Git can be compiled with gettext poison
-support, at the top-level:
+To smoke out issues like these Git tested with a translation mode that
+emits gibberish on every call to gettext. To use it run the test suite
+with it, e.g.:
 
-    make GETTEXT_POISON=YesPlease
-
-That'll give you a git which emits gibberish on every call to
-gettext. It's obviously not meant to be installed, but you should run
-the test suite with it:
-
-    cd t && prove -j 9 ./t[0-9]*.sh
+    cd t && GIT_TEST_GETTEXT_POISON=true prove -j 9 ./t[0-9]*.sh
 
 If tests break with it you should inspect them manually and see if
 what you're translating is sane, i.e. that you're not translating
diff --git a/t/README b/t/README
index 8847489640..53c3dee7a9 100644
--- a/t/README
+++ b/t/README
@@ -301,6 +301,12 @@ that cannot be easily covered by a few specific test cases. These
 could be enabled by running the test suite with correct GIT_TEST_
 environment set.
 
+GIT_TEST_GETTEXT_POISON=<boolean> turns all strings marked for
+translation into gibberish. Used for spotting those tests that need to
+be marked with a C_LOCALE_OUTPUT prerequisite when adding more strings
+for translation. See "Testing marked strings" in po/README for
+details.
+
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
diff --git a/t/helper/test-gettext-poison.c b/t/helper/test-gettext-poison.c
new file mode 100644
index 0000000000..476be95da5
--- /dev/null
+++ b/t/helper/test-gettext-poison.c
@@ -0,0 +1,9 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "thread-utils.h"
+#include "gettext.h"
+
+int cmd__gettext_poison(int argc, const char **argv)
+{
+	return use_gettext_poison() ? 0 : 1;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 6b5836dc1b..3e75672a37 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -19,6 +19,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "example-decorate", cmd__example_decorate },
 	{ "genrandom", cmd__genrandom },
+	{ "gettext-poison", cmd__gettext_poison },
 	{ "hashmap", cmd__hashmap },
 	{ "index-version", cmd__index_version },
 	{ "json-writer", cmd__json_writer },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e4890566da..04f033b7fc 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -15,6 +15,7 @@ int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
+int cmd__gettext_poison(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4d23373526..b6566003dd 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -274,7 +274,7 @@ test_expect_success 'pretend we have a mix of all possible results' "
 	EOF
 "
 
-test_expect_success 'test --verbose' '
+test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 	test_must_fail run_sub_test_lib_test \
 		test-verbose "test verbose" --verbose <<-\EOF &&
 	test_expect_success "passing test" true
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 0392e36d23..2bdcf83808 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -77,7 +77,7 @@ test_expect_success 'rebase -n overrides config rebase.stat config' '
 #     "Does not point to a valid commit: invalid-ref"
 #
 # NEEDSWORK: This "grep" is fine in real non-C locales, but
-# GETTEXT_POISON poisons the refname along with the enclosing
+# GIT_TEST_GETTEXT_POISON poisons the refname along with the enclosing
 # error message.
 test_expect_success 'rebase --onto outputs the invalid ref' '
 	test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 826987ca80..cb2c8cf3f3 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -256,7 +256,10 @@ test_expect_success 'checkout to detach HEAD' '
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
 	test_i18ngrep "HEAD is now at 7329388" messages &&
-	(test_line_count -gt 1 messages || test -n "$GETTEXT_POISON") &&
+	(
+		test_line_count -gt 1 messages ||
+		test_have_prereq GETTEXT_POISON
+	) &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78d8c3783b..f46e21cfa0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -755,16 +755,16 @@ test_cmp_bin() {
 
 # Use this instead of test_cmp to compare files that contain expected and
 # actual output from git commands that can be translated.  When running
-# under GETTEXT_POISON this pretends that the command produced expected
+# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ncmp () {
-	test -n "$GETTEXT_POISON" || test_cmp "$@"
+	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
 }
 
 # Use this instead of "grep expected-string actual" to see if the
 # output from a git command that can be translated either contains an
 # expected string, or does not contain an unwanted one.  When running
-# under GETTEXT_POISON this pretends that the command produced expected
+# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ngrep () {
 	eval "last_arg=\${$#}"
@@ -779,7 +779,7 @@ test_i18ngrep () {
 		error "bug in the test script: too few parameters to test_i18ngrep"
 	fi
 
-	if test -n "$GETTEXT_POISON"
+	if ! test_have_prereq C_LOCALE_OUTPUT
 	then
 		# pretend success
 		return 0
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 897e6fcc94..ec77aa57d4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1104,15 +1104,8 @@ test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
-# Can we rely on git's output in the C locale?
-if test -n "$GETTEXT_POISON"
-then
-	GIT_GETTEXT_POISON=YesPlease
-	export GIT_GETTEXT_POISON
-	test_set_prereq GETTEXT_POISON
-else
-	test_set_prereq C_LOCALE_OUTPUT
-fi
+test-tool gettext-poison && test_set_prereq GETTEXT_POISON
+test-tool gettext-poison || test_set_prereq C_LOCALE_OUTPUT
 
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
-- 
2.19.1.568.g152ad8e336

