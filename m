Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8D61F453
	for <e@80x24.org>; Thu,  1 Nov 2018 19:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeKBEfu (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 00:35:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43628 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeKBEfu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 00:35:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id t10-v6so21167919wrn.10
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WBzzAPITesIGqE1Dp8eXiLczp0Cqozoo1sHHJg7UBs=;
        b=M+K2OUPs7vhwX+HNeIxrLRzz+gKNP9E5Tt19b25gWtrAtuu33W/KHLgmZifsBcOvNe
         SuarGxebG91yL+SWqu/cOiOvyiSW95llXyup/I324FrJbr0yoOK+zQV7WjNTdmwTXrYg
         yQ+QWOAw2016Q/i2+YcEERTbxz/+JStMoaNno+dO4fc8seHG+bSZPjzARp0ZXJkWpCMU
         PkmpKY5JtWFXTdhdwNS89uuulO9gnNnYqRknotXlvL3nMQqQp3FXp7Gv6H928MJ9m4BS
         nSWVAOKnAU0FOBh4aQFhTYMmB/q6F4BeHUFWFT+3zcOSbhaA5JgCfUfJZwKPffteG/Zz
         wXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WBzzAPITesIGqE1Dp8eXiLczp0Cqozoo1sHHJg7UBs=;
        b=cljuifURvyRkp5H86iKyELjPvFS32EBOcrmh3iV2/OVs0rEfA3Mr2mbh3dkoUTWeGY
         7zoR+XJyuBSn9aT13u++CglZOFhmDRGzMmqfxHvYmp0rzwpcGt2gjjvgmSkPczhwH0g4
         U/z8FXa/OLTzAyKrAwz0gF6+ize+ukVQKscxAWRSpXSIs1sGHXHEgK1h/Aw+ez3ffW1q
         T/bUS8oAKjT0up/ZbRxKN086m6NJZpud4/Jy6z2gnuWVy2pifX5OAZt51OnAY+asHgX/
         bh9htT+fDXPAayHK/UDXjvMh5Y7sTdI1KQQDHb0+6cwHqRNHnNoMmTtsLVbwLz31OVeW
         W46A==
X-Gm-Message-State: AGRZ1gJvr2Zs0WcTjFjOc7l2dbt05zR2FiN6lQmgKfQy1eEDWuz3kJg8
        eNYBBXx3ZQTRLca4VOca8WQK+psEBMQ=
X-Google-Smtp-Source: AJdET5fCznrWvW0bnraCr+EwLABiVrZ2yya3ciHZifaVUUTiTAs2/jhRcpOz6NRCrq0Ms+/HcpEGvQ==
X-Received: by 2002:a5d:65cf:: with SMTP id e15-v6mr7455106wrw.149.1541100687382;
        Thu, 01 Nov 2018 12:31:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y141-v6sm33224118wme.10.2018.11.01.12.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 12:31:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] i18n: make GETTEXT_POISON a runtime option
Date:   Thu,  1 Nov 2018 19:31:15 +0000
Message-Id: <20181101193115.32681-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.899.g0250525e69
In-Reply-To: <20181024114725.3927-1-avarab@gmail.com>
References: <20181024114725.3927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the GETTEXT_POISON compile-time + runtime GIT_GETTEXT_POISON
test parameter to only be a GIT_TEST_GETTEXT_POISON=<non-empty?>
runtime parameter, to be consistent with other parameters documented
in "Running tests with special setups" in t/README.

When I added GETTEXT_POISON in bb946bba76 ("i18n: add GETTEXT_POISON
to simulate unfriendly translator", 2011-02-22) I was concerned with
ensuring that the _() function would get constant folded if NO_GETTEXT
was defined, and likewise that GETTEXT_POISON would be compiled out
unless it was defined.

But as the benchmark in my [1] shows doing a one-off runtime
getenv("GIT_TEST_[...]") is trivial, and since GETTEXT_POISON was
originally added the GIT_TEST_* env variables have become the common
idiom for turning on special test setups.

So change GETTEXT_POISON to work the same way. Now the
GETTEXT_POISON=YesPlease compile-time option is gone, and running the
tests with GIT_TEST_GETTEXT_POISON=[YesPlease|] can be toggled on/off
without recompiling.

This allows for conditionally amending tests to test with/without
poison, similar to what 859fdc0c3c ("commit-graph: define
GIT_TEST_COMMIT_GRAPH", 2018-08-29) did for GIT_TEST_COMMIT_GRAPH. Do
some of that, now we e.g. always run the t0205-gettext-poison.sh test.

I did enough there to remove the GETTEXT_POISON prerequisite, but its
inverse C_LOCALE_OUTPUT is still around, and surely some tests using
it can be converted to e.g. always set GIT_TEST_GETTEXT_POISON=.

Notes on the implementation:

 * We still compile a dedicated GETTEXT_POISON build in Travis CI.
   This is probably the wrong thing to do and should be followed-up
   with something similar to ae59a4e44f ("travis: run tests with
   GIT_TEST_SPLIT_INDEX", 2018-01-07) to re-use an existing test setup
   for running in the GIT_TEST_GETTEXT_POISON mode.

 * We now skip a test in t0000-basic.sh under
   GIT_TEST_GETTEXT_POISON=YesPlease that wasn't skipped before. This
   test relies on C locale output, but due to an edge case in how the
   previous implementation of GETTEXT_POISON worked (reading it from
   GIT-BUILD-OPTIONS) wasn't enabling poison correctly. Now it does,
   and needs to be skipped.

 * The getenv() function is not reentrant, so out of paranoia about
   code of the form:

       printf(_("%s"), getenv("some-env"));

   call use_gettext_poison() in our early setup in git_setup_gettext()
   so we populate the "poison_requested" variable in a codepath that's
   won't suffer from that race condition.

See also [3] for more on the motivation behind this patch, and the
history of the GETTEXT_POISON facility.

1. https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/
2. https://public-inbox.org/git/87woq7b58k.fsf@evledraar.gmail.com/
3. https://public-inbox.org/git/878t2pd6yu.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Now:

 * The new i18n helper is gone. We just use "test -n" semantics for
   $GIT_TEST_GETTEXT_POISON

 * We error out in the Makefile if you're still saying
   GETTEXT_POISON=YesPlease.

   This makes more sense than just making it a synonym since now this
   also needs to be defined at runtime.

 * The caveat with avoiding test_lazy_prereq is gone (although there's
   still some unrelated bug there worth looking into).

 * We call use_gettext_poison() really early to avoid any reentrancy
   issue with getenv().


 .travis.yml               |  2 +-
 Makefile                  |  8 +-------
 ci/lib-travisci.sh        |  4 ++--
 gettext.c                 | 11 +++++++----
 gettext.h                 |  9 +++------
 git-sh-i18n.sh            |  2 +-
 po/README                 | 13 ++++---------
 t/README                  |  6 ++++++
 t/lib-gettext.sh          |  2 +-
 t/t0000-basic.sh          |  2 +-
 t/t0205-gettext-poison.sh |  8 +++++---
 t/t3406-rebase-message.sh |  2 +-
 t/t7201-co.sh             |  6 +++---
 t/t9902-completion.sh     |  3 ++-
 t/test-lib-functions.sh   |  8 ++++----
 t/test-lib.sh             |  6 +-----
 16 files changed, 43 insertions(+), 49 deletions(-)

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
index b08d5ea258..3a08626db0 100644
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
@@ -1450,7 +1445,7 @@ ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
 ifdef GETTEXT_POISON
-	BASIC_CFLAGS += -DGETTEXT_POISON
+$(error The GETTEXT_POISON option has been removed in favor of runtime GIT_TEST_GETTEXT_POISON. See t/README!)
 endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
@@ -2602,7 +2597,6 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
 endif
 	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
-	@echo GETTEXT_POISON=\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POISON)))'\' >>$@+
 ifdef GIT_PERF_REPEAT_COUNT
 	@echo GIT_PERF_REPEAT_COUNT=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPEAT_COUNT)))'\' >>$@+
 endif
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 06970f7213..69dff4d1ec 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -123,7 +123,7 @@ osx-clang|osx-gcc)
 	# Travis CI OS X
 	export GIT_SKIP_TESTS="t9810 t9816"
 	;;
-GETTEXT_POISON)
-	export GETTEXT_POISON=YesPlease
+GIT_TEST_GETTEXT_POISON)
+	export GIT_TEST_GETTEXT_POISON=YesPlease
 	;;
 esac
diff --git a/gettext.c b/gettext.c
index 7272771c8e..d4021d690c 100644
--- a/gettext.c
+++ b/gettext.c
@@ -7,6 +7,7 @@
 #include "gettext.h"
 #include "strbuf.h"
 #include "utf8.h"
+#include "config.h"
 
 #ifndef NO_GETTEXT
 #	include <locale.h>
@@ -46,15 +47,15 @@ const char *get_preferred_languages(void)
 	return NULL;
 }
 
-#ifdef GETTEXT_POISON
 int use_gettext_poison(void)
 {
 	static int poison_requested = -1;
-	if (poison_requested == -1)
-		poison_requested = getenv("GIT_GETTEXT_POISON") ? 1 : 0;
+	if (poison_requested == -1) {
+		const char *v = getenv("GIT_TEST_GETTEXT_POISON");
+		poison_requested = v && strlen(v) ? 1 : 0;
+	}
 	return poison_requested;
 }
-#endif
 
 #ifndef NO_GETTEXT
 static int test_vsnprintf(const char *fmt, ...)
@@ -164,6 +165,8 @@ void git_setup_gettext(void)
 	if (!podir)
 		podir = p = system_path(GIT_LOCALE_PATH);
 
+	use_gettext_poison(); /* getenv() reentrancy paranoia */
+
 	if (!is_directory(podir)) {
 		free(p);
 		return;
diff --git a/gettext.h b/gettext.h
index 7eee64a34f..43d991a2df 100644
--- a/gettext.h
+++ b/gettext.h
@@ -28,12 +28,15 @@
 
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
 
+extern int use_gettext_poison(void);
+
 #ifndef NO_GETTEXT
 extern void git_setup_gettext(void);
 extern int gettext_width(const char *s);
 #else
 static inline void git_setup_gettext(void)
 {
+	use_gettext_poison();; /* getenv() reentrancy paranoia */
 }
 static inline int gettext_width(const char *s)
 {
@@ -41,12 +44,6 @@ static inline int gettext_width(const char *s)
 }
 #endif
 
-#ifdef GETTEXT_POISON
-extern int use_gettext_poison(void);
-#else
-#define use_gettext_poison() 0
-#endif
-
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
 	if (!*msgid)
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 9d065fb4bf..e1d917fd27 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -17,7 +17,7 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "$GIT_GETTEXT_POISON"
+if test -n "$GIT_TEST_GETTEXT_POISON"
 then
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
 elif test -n "@@USE_GETTEXT_SCHEME@@"
diff --git a/po/README b/po/README
index fef4c0f0b5..aa704ffcb7 100644
--- a/po/README
+++ b/po/README
@@ -289,16 +289,11 @@ something in the test suite might still depend on the US English
 version of the strings, e.g. to grep some error message or other
 output.
 
-To smoke out issues like these Git can be compiled with gettext poison
-support, at the top-level:
+To smoke out issues like these, Git tested with a translation mode that
+emits gibberish on every call to gettext. To use it run the test suite
+with it, e.g.:
 
-    make GETTEXT_POISON=YesPlease
-
-That'll give you a git which emits gibberish on every call to
-gettext. It's obviously not meant to be installed, but you should run
-the test suite with it:
-
-    cd t && prove -j 9 ./t[0-9]*.sh
+    cd t && GIT_TEST_GETTEXT_POISON=YesPlease prove -j 9 ./t[0-9]*.sh
 
 If tests break with it you should inspect them manually and see if
 what you're translating is sane, i.e. that you're not translating
diff --git a/t/README b/t/README
index 8847489640..25c4ba3419 100644
--- a/t/README
+++ b/t/README
@@ -301,6 +301,12 @@ that cannot be easily covered by a few specific test cases. These
 could be enabled by running the test suite with correct GIT_TEST_
 environment set.
 
+GIT_TEST_GETTEXT_POISON=<non-empty?> turns all strings marked for
+translation into gibberish if non-empty (think "test -n"). Used for
+spotting those tests that need to be marked with a C_LOCALE_OUTPUT
+prerequisite when adding more strings for translation. See "Testing
+marked strings" in po/README for details.
+
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index eec757f104..755f421431 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -12,7 +12,7 @@ export GIT_TEXTDOMAINDIR GIT_PO_PATH
 
 . "$GIT_BUILD_DIR"/git-sh-i18n
 
-if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
+if test_have_prereq GETTEXT && test_have_prereq C_LOCALE_OUTPUT
 then
 	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
 	is_IS_locale=$(locale -a 2>/dev/null |
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
diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
index 438e778d6a..a06269f38a 100755
--- a/t/t0205-gettext-poison.sh
+++ b/t/t0205-gettext-poison.sh
@@ -5,13 +5,15 @@
 
 test_description='Gettext Shell poison'
 
+GIT_TEST_GETTEXT_POISON=YesPlease
+export GIT_TEST_GETTEXT_POISON
 . ./lib-gettext.sh
 
-test_expect_success GETTEXT_POISON 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is poison' '
+test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is poison' '
     test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" = "poison"
 '
 
-test_expect_success GETTEXT_POISON 'gettext: our gettext() fallback has poison semantics' '
+test_expect_success 'gettext: our gettext() fallback has poison semantics' '
     printf "# GETTEXT POISON #" >expect &&
     gettext "test" >actual &&
     test_cmp expect actual &&
@@ -20,7 +22,7 @@ test_expect_success GETTEXT_POISON 'gettext: our gettext() fallback has poison s
     test_cmp expect actual
 '
 
-test_expect_success GETTEXT_POISON 'eval_gettext: our eval_gettext() fallback has poison semantics' '
+test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semantics' '
     printf "# GETTEXT POISON #" >expect &&
     eval_gettext "test" >actual &&
     test_cmp expect actual &&
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
index 826987ca80..72b9b375ba 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -254,9 +254,9 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	git checkout -f renamer && git clean -f &&
-	git checkout renamer^ 2>messages &&
-	test_i18ngrep "HEAD is now at 7329388" messages &&
-	(test_line_count -gt 1 messages || test -n "$GETTEXT_POISON") &&
+	GIT_TEST_GETTEXT_POISON= git checkout renamer^ 2>messages &&
+	grep "HEAD is now at 7329388" messages &&
+	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 175f83d704..3c6b185b60 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1697,7 +1697,8 @@ test_expect_success 'sourcing the completion script clears cached commands' '
 	verbose test -z "$__git_all_commands"
 '
 
-test_expect_success !GETTEXT_POISON 'sourcing the completion script clears cached merge strategies' '
+test_expect_success 'sourcing the completion script clears cached merge strategies' '
+	GIT_TEST_GETTEXT_POISON= &&
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&
 	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78d8c3783b..2f42b3653c 100644
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
+	if test_have_prereq !C_LOCALE_OUTPUT
 	then
 		# pretend success
 		return 0
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 897e6fcc94..370a4821e1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1105,12 +1105,8 @@ test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-if test -n "$GETTEXT_POISON"
+if test -z "$GIT_TEST_GETTEXT_POISON"
 then
-	GIT_GETTEXT_POISON=YesPlease
-	export GIT_GETTEXT_POISON
-	test_set_prereq GETTEXT_POISON
-else
 	test_set_prereq C_LOCALE_OUTPUT
 fi
 
-- 
2.19.1.899.g0250525e69

