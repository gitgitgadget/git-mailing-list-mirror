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
	by dcvr.yhbt.net (Postfix) with ESMTP id 464521F461
	for <e@80x24.org>; Fri, 21 Jun 2019 10:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfFUKSf (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 06:18:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44140 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfFUKSe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 06:18:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16so5983195wrl.11
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEx9zZSP0K4r7Yu9Gkx+jdK13o3tdQx951Ls51YsjJ4=;
        b=q/7qNPhaq4eKlgrF6moSys6Loxo/jY4OfBvB+RsL33LC0s8p+QQohVxjYp41+DiZy3
         mxbB1baWEoxIqRbF7b1cqyS+hYFieJSLYMY3sz2T/a3sH0j7TFWU09+jF8NJEOrJLgyh
         qWejdJX3d718ZyEd/NyCvr5Oh/egvt+EZ238l0SuVs7kCopfUADw0SzlJ7c3PwhuSH8P
         9SLtnUOjk02dgYwKVuaFtvbmQDobEVzUsv66YhvUSSXap2G/wqAaHh8YJ45GDw4zUxU/
         lrpOv2ifDpVkIJtcYsw8Cwyywfbir2s+rVkhyj2l9UyQodKT4xiQEvE+NPcEPUSxBT9C
         zzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEx9zZSP0K4r7Yu9Gkx+jdK13o3tdQx951Ls51YsjJ4=;
        b=WTE0EUsKPECi2U5ankc/ci6cR8COJkmHdrCkt9lAXngVk5n+DuKvGy1t7DSTDLrcWt
         9FE1xvifdWYPqmVLwIsU4vB5R9d/Ixx/LyyHyZSq2UpdFaJNPGclNnuCiBE3gS7Gxn4P
         PbmvBc2Mb0sakEXzU4SVHM9PNs06LgSNHFQIat9HlrP3NNDqZw9BQHiWYZush7p4SWAs
         j/BlNscwUACqreItwI73OH7xnEVMKgn7LO5EwYbhiBK0gEBOAfS/XmVp5swvryEYOR7E
         cg7lKmhbcHuhf4Zh5INV2lS7DEQoSVMZWfVcQjE0l4afMEmJipwU2jQKOqE+Im/0yjuf
         fqfw==
X-Gm-Message-State: APjAAAX8S6YWaCoU+NfIsVOL89vpaTGqF4A15MzHVBI+eTmejCOGi1lG
        kBOOtawpJOLFSynfsTM2PQ05cqEiiRo=
X-Google-Smtp-Source: APXvYqxg+cDhGYIDr5GdeTWgn7elwjR6s2NcIFjTbl5ZSqpD4J6GM59UnJYGaxBqJ24Ir728aQ1WRw==
X-Received: by 2002:adf:e88e:: with SMTP id d14mr16855698wrm.189.1561112311455;
        Fri, 21 Jun 2019 03:18:31 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y184sm1878193wmg.14.2019.06.21.03.18.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 03:18:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/8] tests: make GIT_TEST_GETTEXT_POISON a boolean
Date:   Fri, 21 Jun 2019 12:18:09 +0200
Message-Id: <20190621101812.27300-6-avarab@gmail.com>
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

Change the GIT_TEST_GETTEXT_POISON variable from being "non-empty?" to
being a more standard boolean variable.

Since it needed to be checked in both C code and shellscript (via test
-n) it was one of the remaining shellscript-like variables. Now that
we have "env--helper" we can change that.

There's a couple of tricky edge cases that arise because we're using
git_env_bool() early, and the config-reading "env--helper".

If GIT_TEST_GETTEXT_POISON is set to an invalid value die_bad_number()
will die, but to do so it would usually call gettext(). Let's detect
the special case of GIT_TEST_GETTEXT_POISON and always emit that
message in the C locale, lest we infinitely loop.

As seen in the updated tests in t0017-env-helper.sh there's also a
caveat related to "env--helper" needing to read the config for trace2
purposes.

Since the C_LOCALE_OUTPUT prerequisite is lazy and relies on
"env--helper" we could get invalid results if we failed to read the
config (e.g. because we'd loop on includes) when combined with
e.g. "test_i18ngrep" wanting to check with "env--helper" if
GIT_TEST_GETTEXT_POISON was true or not.

I'm crossing my fingers and hoping that a test similar to the one I
removed in the earlier "config tests: simplify include cycle test"
change in this series won't happen again, and testing for this
explicitly in "env--helper"'s own tests.

This change breaks existing uses of
e.g. GIT_TEST_GETTEXT_POISON=YesPlease, which we've documented in
po/README and other places. As noted in [1] we might want to consider
also accepting "YesPlease" in "env--helper" as a special-case.

But as the lack of uproar over 6cdccfce1e ("i18n: make GETTEXT_POISON
a runtime option", 2018-11-08) demonstrates the audience for this
option is a really narrow set of git developers, who shouldn't have
much trouble modifying their test scripts, so I think it's better to
deal with that minor headache now and make all the relevant GIT_TEST_*
variables boolean in the same way than carry the "YesPlease"
special-case forward.

1. https://public-inbox.org/git/xmqqtvckm3h8.fsf@gitster-ct.c.googlers.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                 |  2 +-
 config.c                  |  9 +++++++++
 gettext.c                 |  6 ++----
 git-sh-i18n.sh            |  4 +++-
 po/README                 |  2 +-
 t/README                  |  4 ++--
 t/t0017-env-helper.sh     | 16 ++++++++++++++++
 t/t0205-gettext-poison.sh |  7 ++++++-
 t/t1305-config-include.sh |  2 +-
 t/t7201-co.sh             |  2 +-
 t/t9902-completion.sh     |  2 +-
 t/test-lib.sh             |  8 +++-----
 12 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 288a5b3884..fd799ae663 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -184,7 +184,7 @@ osx-clang|osx-gcc)
 	export GIT_SKIP_TESTS="t9810 t9816"
 	;;
 GIT_TEST_GETTEXT_POISON)
-	export GIT_TEST_GETTEXT_POISON=YesPlease
+	export GIT_TEST_GETTEXT_POISON=true
 	;;
 esac
 
diff --git a/config.c b/config.c
index 374cb33005..b985d60fa4 100644
--- a/config.c
+++ b/config.c
@@ -956,6 +956,15 @@ static void die_bad_number(const char *name, const char *value)
 	if (!value)
 		value = "";
 
+	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
+		/*
+		 * We explicitly *don't* use _() here since it would
+		 * cause an infinite loop with _() needing to call
+		 * use_gettext_poison(). This is why marked up
+		 * translations with N_() above.
+		 */
+		die(bad_numeric, value, name, error_type);
+
 	if (!(cf && cf->name))
 		die(_(bad_numeric), value, name, _(error_type));
 
diff --git a/gettext.c b/gettext.c
index d4021d690c..5c71f4c8b9 100644
--- a/gettext.c
+++ b/gettext.c
@@ -50,10 +50,8 @@ const char *get_preferred_languages(void)
 int use_gettext_poison(void)
 {
 	static int poison_requested = -1;
-	if (poison_requested == -1) {
-		const char *v = getenv("GIT_TEST_GETTEXT_POISON");
-		poison_requested = v && strlen(v) ? 1 : 0;
-	}
+	if (poison_requested == -1)
+		poison_requested = git_env_bool("GIT_TEST_GETTEXT_POISON", 0);
 	return poison_requested;
 }
 
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index e1d917fd27..8eef60b43f 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -17,7 +17,9 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "$GIT_TEST_GETTEXT_POISON"
+if test -n "$GIT_TEST_GETTEXT_POISON" &&
+	    git env--helper --type=bool --default=0 --exit-code \
+		GIT_TEST_GETTEXT_POISON
 then
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
 elif test -n "@@USE_GETTEXT_SCHEME@@"
diff --git a/po/README b/po/README
index aa704ffcb7..07595d369b 100644
--- a/po/README
+++ b/po/README
@@ -293,7 +293,7 @@ To smoke out issues like these, Git tested with a translation mode that
 emits gibberish on every call to gettext. To use it run the test suite
 with it, e.g.:
 
-    cd t && GIT_TEST_GETTEXT_POISON=YesPlease prove -j 9 ./t[0-9]*.sh
+    cd t && GIT_TEST_GETTEXT_POISON=true prove -j 9 ./t[0-9]*.sh
 
 If tests break with it you should inspect them manually and see if
 what you're translating is sane, i.e. that you're not translating
diff --git a/t/README b/t/README
index 9747971d58..9a131f472e 100644
--- a/t/README
+++ b/t/README
@@ -343,8 +343,8 @@ whether this mode is active, and e.g. skip some tests that are hard to
 refactor to deal with it. The "SYMLINKS" prerequisite is currently
 excluded as so much relies on it, but this might change in the future.
 
-GIT_TEST_GETTEXT_POISON=<non-empty?> turns all strings marked for
-translation into gibberish if non-empty (think "test -n"). Used for
+GIT_TEST_GETTEXT_POISON=<boolean> turns all strings marked for
+translation into gibberish if true. Used for
 spotting those tests that need to be marked with a C_LOCALE_OUTPUT
 prerequisite when adding more strings for translation. See "Testing
 marked strings" in po/README for details.
diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index 709bbbd275..c1ecf6aeac 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -80,4 +80,20 @@ test_expect_success 'env--helper --type=ulong' '
 	test_must_be_empty actual.err
 '
 
+test_expect_success 'env--helper reads config thanks to trace2' '
+	mkdir home &&
+	git config -f home/.gitconfig include.path cycle &&
+	git config -f home/cycle include.path .gitconfig &&
+
+	test_must_fail \
+		env HOME="$(pwd)/home" GIT_TEST_GETTEXT_POISON=false \
+		git config -l 2>err &&
+	grep "exceeded maximum include depth" err &&
+
+	test_must_fail \
+		env HOME="$(pwd)/home" GIT_TEST_GETTEXT_POISON=true \
+		git -C cycle env--helper --type=bool --default=0 --exit-code GIT_TEST_GETTEXT_POISON 2>err &&
+	grep "# GETTEXT POISON #" err
+'
+
 test_done
diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
index a06269f38a..f9fa16ad83 100755
--- a/t/t0205-gettext-poison.sh
+++ b/t/t0205-gettext-poison.sh
@@ -5,7 +5,7 @@
 
 test_description='Gettext Shell poison'
 
-GIT_TEST_GETTEXT_POISON=YesPlease
+GIT_TEST_GETTEXT_POISON=true
 export GIT_TEST_GETTEXT_POISON
 . ./lib-gettext.sh
 
@@ -31,4 +31,9 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semant
     test_cmp expect actual
 '
 
+test_expect_success "gettext: invalid GIT_TEST_GETTEXT_POISON value doesn't infinitely loop" "
+	test_must_fail env GIT_TEST_GETTEXT_POISON=xyz git version 2>error &&
+	grep \"fatal: bad numeric config value 'xyz' for 'GIT_TEST_GETTEXT_POISON': invalid unit\" error
+"
+
 test_done
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 6b388ba2d0..de294c990e 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -314,7 +314,7 @@ test_expect_success 'include cycles are detected' '
 	git -C cycle config include.path cycle &&
 	git config -f cycle/cycle include.path config &&
 	test_must_fail \
-		env GIT_TEST_GETTEXT_POISON= \
+		env GIT_TEST_GETTEXT_POISON=false \
 		git -C cycle config --get-all test.value 2>stderr &&
 	grep "exceeded maximum include depth" stderr
 '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 5990299fc9..b696bae5f5 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -249,7 +249,7 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	git checkout -f renamer && git clean -f &&
-	GIT_TEST_GETTEXT_POISON= git checkout renamer^ 2>messages &&
+	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
 	grep "HEAD is now at 7329388" messages &&
 	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 43cf313a1c..75512c3403 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1706,7 +1706,7 @@ test_expect_success 'sourcing the completion script clears cached commands' '
 '
 
 test_expect_success 'sourcing the completion script clears cached merge strategies' '
-	GIT_TEST_GETTEXT_POISON= &&
+	GIT_TEST_GETTEXT_POISON=false &&
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&
 	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4b346467df..ed5d69dfe5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1443,11 +1443,9 @@ then
 	unset GIT_TEST_GETTEXT_POISON_ORIG
 fi
 
-# Can we rely on git's output in the C locale?
-if test -z "$GIT_TEST_GETTEXT_POISON"
-then
-	test_set_prereq C_LOCALE_OUTPUT
-fi
+test_lazy_prereq C_LOCALE_OUTPUT '
+	! git env--helper --type=bool --default=0 --exit-code GIT_TEST_GETTEXT_POISON
+'
 
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then
-- 
2.22.0.455.g172b71a6c5

