Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CE611F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeJWGGa (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:06:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45196 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeJWGGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:06:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id t10-v6so6661789eds.12
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jdsm1/u6AdxXQPdhBQ+lakiJLj2fFT8pGRGC/boSkvA=;
        b=Wuk+/qIg4e9968TECduh5P7vnENirU5NbLQJYnmXFnSwrx1ogKzxfX9OCTxmcFDBvU
         +gxC5QUN19ztQqnRBxKn7lOyedS57IPFlaF8EZE606jnZ2/PGbCo/Z0SDeK0hShW8v/Y
         AuZXPtChVSaZSOQjcmmQRzOCht+HP9L2WJsFRuIENgpDqTjmBJfYmcFV+gdyY1U1aHLY
         O+nqrrXs4mcLwRmCgYEDRbOaQN47TZAPDGzRDchTCo2Fd50fX72E2LQbVpGii5ig3E5Y
         SVcpbzQ9xoxdw8A1U3ANGG6pgOO083k1KtFytHFX5fd554L+QI2smT69otFHg5MN7UBY
         /Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jdsm1/u6AdxXQPdhBQ+lakiJLj2fFT8pGRGC/boSkvA=;
        b=cgLYKBlq5ZhbKTffMjR77q362uR1hWcoR9UBkn8ooXm3yTO6VaGpFV1h6X1KzG0Vdt
         aS9bQ9J1jJ7dTXYNHdG7zlz9Um9zhstbGCPomRfVRHvco9k2Heenlb5YbdUYTSdtBdTQ
         0GKLiTjem9Eq3sPy1EEsbhCgEFbxnSjEjfAZVjvwUZrIto47nXE8O22VTTMvvOz3v9m/
         gJhT936rhpsu8wJ/O3B69O/8378ABhYyDtkOicqPGHnNg/Dxkf7gy4mmpgrLxBcsPG/o
         ra0vol2F4ZI4uPdqh5ztjs4/kfL2oeF/SVHXkPIqz7CF+lZWMzVmMlt28zkS+sJgsAM1
         zdwg==
X-Gm-Message-State: ABuFfohwXi9U1zi6QTkdOyY3jWpKA++xugE5/GQd8wm5566jmjhq+biz
        WVKShedmLh7QDmWFAu1DnN8jx7Jd
X-Google-Smtp-Source: ACcGV62/kGaAQnh2AxMKR7XP430/HPgwIeThHBX3e+xZAQWsDLvcs0yGRANz8ZSdABDg7t9W+Tsmtw==
X-Received: by 2002:a50:86fd:: with SMTP id 58-v6mr15250587edu.15.1540244767883;
        Mon, 22 Oct 2018 14:46:07 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id w37-v6sm1374826edc.2.2018.10.22.14.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 14:46:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
References: <20181022153633.31757-1-pclouds@gmail.com> <878t2pd6yu.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <878t2pd6yu.fsf@evledraar.gmail.com>
Date:   Mon, 22 Oct 2018 23:46:05 +0200
Message-ID: <875zxtd59e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 22 2018, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Oct 22 2018, Nguyễn Thái Ngọc Duy wrote:
>
>> The current gettext() function just replaces all strings with
>> '# GETTEXT POISON #' including format strings and hides the things
>> that we should be allowed to grep (like branch names, or some other
>> codes) even when gettext is poisoned.
>>
>> This patch implements the poisoned _() with a universal and totally
>> legit language called Ook [1]. We could actually grep stuff even in
>> with this because format strings are preserved.
>>
>> Long term, we could implement an "ook translator" for test_i18ngrep
>> and friends so that they translate English to Ook, allowing us to
>> match full text while making sure the text in the code is still marked
>> for translation.
>
> Replying to both this patch, and SZEDER's series for brevity. Thanks
> both for working on this. It's obvious that this stuff needs some
> polishing, and it's great that's being done, and sorry for my part of
> having left this in the current state.
>
> a)
>
> Both this patch and SZEDER's 7/8 are addressing the issue that the
> poison mode doesn't preserve format specifiers.
>
> I haven't tried to dig this up in the list archive, and maybe it only
> exists in my mind, but I seem to remember that this was explicitly
> discussed as a goal at the time.
>
> I.e. we were expecting the lack of this to break tests, and that was
> considered a feature as it would spot plumbing messages we shouldn't be
> translating.
>
> However, it's my opinion that this was just a bad idea to begin with,
> I've CC'd a couple of prolific markers of i18n from my log grepping (and
> feel free to add more) to see if they disagre.
>
> I think it probably helped me a bit in the beginning when i18n was
> bootstrapping and there was a *lot* to mark for translation, but we've
> long since stabilized and aren't doing that anymore, so it's much easier
> to just review the patches to see if they translate plumbing.
>
> All of which is to say that I think something like your patch here is
> fine to just accept, and the only improvement I'd suggest is some note
> in the commit message saying that this was always intentional, but
> nobody can name a case where it helped, so let's just drop it.
>
> In SZEDER's case that we shouldn't have GIT_GETTEXT_POISON=scrambled,
> let's just make it boolean and make "scrambled" (i.e. preserving format
> specifiecs) the default.

[...]

> b)
>
> SZEDER's series, and your patch (although it's smaller) still preserve
> the notion that there's such a thing as a GETTEXT_POISON *build* and you
> actually need to compile git with that flag to make use of it.
>
> This, as I recall, was just paranoia on my part back in 2010/2011. I
> wanted to be able to present a version of this i18n stuff where people
> who didn't like it could be assured that if they didn't opt-in to it
> they wouldn't get any of the code (sans a few trivial and obviously
> correct wrapper functions).
>
> So I think the only reason to keep it compile-time is performance, but I
> don't think that matters. It's not like we're printing gigabytes of _()
> formatted output. Everything where formatting matters is plumbing which
> doesn't use this API. These messages are always for human consumption.
>
> So shouldn't we just drop this notion of GETTEXT_POISON at compile-time
> entirely, and make GIT_GETTEXT_POISON=<boolean> a test flag that all
> builds of git are aware of? I think so.

Something like this, untested except I compiled it and ran one test
with/without GIT_GETTEXT_POISON, so it may have bugs:

 Makefile                | 10 +---------
 gettext.c               |  4 +---
 gettext.h               |  4 ----
 po/README               | 13 ++++---------
 t/README                |  5 +++++
 t/helper/test-tool.c    |  1 +
 t/helper/test-tool.h    |  1 +
 t/test-lib-functions.sh |  8 ++++----
 t/test-lib.sh           | 12 +++---------
 9 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/Makefile b/Makefile
index d18ab0fe78..78190ee9d9 100644
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
@@ -1439,9 +1435,6 @@ endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
-ifdef GETTEXT_POISON
-	BASIC_CFLAGS += -DGETTEXT_POISON
-endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
 	USE_GETTEXT_SCHEME ?= fallthrough
@@ -2591,7 +2584,6 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
 endif
 	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
-	@echo GETTEXT_POISON=\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POISON)))'\' >>$@+
 ifdef GIT_PERF_REPEAT_COUNT
 	@echo GIT_PERF_REPEAT_COUNT=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPEAT_COUNT)))'\' >>$@+
 endif
diff --git a/gettext.c b/gettext.c
index 7272771c8e..d71e394284 100644
--- a/gettext.c
+++ b/gettext.c
@@ -46,15 +46,13 @@ const char *get_preferred_languages(void)
 	return NULL;
 }

-#ifdef GETTEXT_POISON
 int use_gettext_poison(void)
 {
 	static int poison_requested = -1;
 	if (poison_requested == -1)
-		poison_requested = getenv("GIT_GETTEXT_POISON") ? 1 : 0;
+		poison_requested = git_env_bool("GIT_GETTEXT_POISON", 0);
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
diff --git a/po/README b/po/README
index fef4c0f0b5..9dad277e33 100644
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
+    cd t && GIT_GETTEXT_POISON=true prove -j 9 ./t[0-9]*.sh

 If tests break with it you should inspect them manually and see if
 what you're translating is sane, i.e. that you're not translating
diff --git a/t/README b/t/README
index 8847489640..b3b2fa0b11 100644
--- a/t/README
+++ b/t/README
@@ -301,6 +301,11 @@ that cannot be easily covered by a few specific test cases. These
 could be enabled by running the test suite with correct GIT_TEST_
 environment set.

+GIT_GETTEXT_POISON=<boolean> turns all strings marked for translation
+into gibberish. Used for spotting those tests that need to be marked
+with a C_LOCALE_OUTPUT prerequisite when adding more strings for
+translation. See "Testing marked strings" in po/README for details.
+
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.

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
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78d8c3783b..4e8683addd 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -755,16 +755,16 @@ test_cmp_bin() {

 # Use this instead of test_cmp to compare files that contain expected and
 # actual output from git commands that can be translated.  When running
-# under GETTEXT_POISON this pretends that the command produced expected
+# under GIT_GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ncmp () {
-	test -n "$GETTEXT_POISON" || test_cmp "$@"
+	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
 }

 # Use this instead of "grep expected-string actual" to see if the
 # output from a git command that can be translated either contains an
 # expected string, or does not contain an unwanted one.  When running
-# under GETTEXT_POISON this pretends that the command produced expected
+# under GIT_GETTEXT_POISON this pretends that the command produced expected
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
index 897e6fcc94..f82d2149a2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -105,6 +105,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 		TRACE
 		DEBUG
 		TEST
+		GETTEXT_POISON
 		.*_TEST
 		PROVE
 		VALGRIND
@@ -1104,15 +1105,8 @@ test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
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
+test_lazy_prereq GETTEXT_POISON 'test-tool gettext-poison'
+test_lazy_prereq C_LOCALE_OUTPUT '! test-tool gettext-poison'

 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
