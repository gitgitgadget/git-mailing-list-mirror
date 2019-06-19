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
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C7F1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 23:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfFSXbD (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 19:31:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51522 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSXbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 19:31:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so1154724wma.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 16:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2r0LoHBcuAqe3Ep064Vuw4tbEOXpx407y731AQr6j1w=;
        b=FGDi21IyVRSCVJmAPRu1el6+VmVTGU6mZzOmrpvqJZKFu57O+ih/QUXLvuVWiRmnMC
         PBIFyaLElSPz8/1e2IXFdv4nqYK/18l00U/9QgJV466zMdJCvOOjsyxJbsQFvRYF/oTb
         kaMBrgVpBo48W7tmTQ50ZAOYv7QqIxxqi+Gk6FpwubXMKqWre/4NZy46wOD6Y/V0ZzrS
         EcVrbGC7ePuqH7ViR9HL5nOfW3QESM44Y6L1hgBk2UyvmDWE5dkPoBJEZstsyzBxADve
         no0fCN71eUVYESiyzwU5RGWo9ZUg282+GFFzgO8ITB9wSoCGZbLRDA0Ro5MvM4jh9+5D
         qUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2r0LoHBcuAqe3Ep064Vuw4tbEOXpx407y731AQr6j1w=;
        b=X0EyLkGk2f5U57K5XMxmsopFTJgu3zmSHvnlBV9aFHaOXdaLUF+jmMS/WrEnO4Mc/B
         LEHwJT2OPZG+zLVcjGaJy0IfbnlXupbaIQacfyDprnt0PcbUjTLNpNDdiTrQqV0oBMrp
         Mp3SPJc3LGWJGb6PHov3TPQlJKHWEordLV0a5by3hpPy+yzIj61pmmNKCD5l60qYoViy
         xnsk+ukJ89t8EDgHpou5dKQqJ1UpCV9mL5CYKi/BA4ECJ7vMV5g9aRpmr1Lr2o+oDwj+
         sw5DkaXHWeamw2wYJQcrfUnjANlqWjlHbsWNYqOxZkKK+Fnm93Hhtg5nCWUlTi1uCtc5
         8Jdw==
X-Gm-Message-State: APjAAAUPnfbWfjs3vKTXdwJjsyyPUhIwQ4MC5f9oHdzQZc544JwFlgmn
        Aj15MFglDwHNX5lOG6DNynRazDH2O9Y=
X-Google-Smtp-Source: APXvYqzVwfoNw3ie+gfkFRmDE7zN6D9meruZGzqRL75dpfg34p63xTSe9fIhPAhDL4BNzxV9iYAy8Q==
X-Received: by 2002:a1c:3942:: with SMTP id g63mr9040901wma.61.1560987059555;
        Wed, 19 Jun 2019 16:30:59 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6sm17964958wrx.85.2019.06.19.16.30.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 16:30:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] tests: make GIT_TEST_GETTEXT_POISON a boolean
Date:   Thu, 20 Jun 2019 01:30:43 +0200
Message-Id: <20190619233046.27503-4-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244
In-Reply-To: <87imt18a2r.fsf@evledraar.gmail.com>
References: <87imt18a2r.fsf@evledraar.gmail.com>
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
we have "git env--helper" we can change that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                 | 2 +-
 gettext.c                 | 6 ++----
 git-sh-i18n.sh            | 4 +++-
 po/README                 | 2 +-
 t/README                  | 4 ++--
 t/t0205-gettext-poison.sh | 2 +-
 t/t7201-co.sh             | 2 +-
 t/t9902-completion.sh     | 2 +-
 t/test-lib.sh             | 4 ++++
 9 files changed, 16 insertions(+), 12 deletions(-)

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
index e1d917fd27..de8ae67d7b 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -17,7 +17,9 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "$GIT_TEST_GETTEXT_POISON"
+if test -n "$GIT_TEST_GETTEXT_POISON" &&
+	    git env--helper --mode-bool --variable=GIT_TEST_GETTEXT_POISON \
+		--default=0 --exit-code --quiet
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
diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
index a06269f38a..1675d3e171 100755
--- a/t/t0205-gettext-poison.sh
+++ b/t/t0205-gettext-poison.sh
@@ -5,7 +5,7 @@
 
 test_description='Gettext Shell poison'
 
-GIT_TEST_GETTEXT_POISON=YesPlease
+GIT_TEST_GETTEXT_POISON=true
 export GIT_TEST_GETTEXT_POISON
 . ./lib-gettext.sh
 
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
index 4b346467df..bdd5017d24 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1443,6 +1443,10 @@ then
 	unset GIT_TEST_GETTEXT_POISON_ORIG
 fi
 
+test_lazy_prereq C_LOCALE_OUTPUT '
+	! git env--helper --mode-bool --variable=GIT_TEST_GETTEXT_POISON --default=0 --exit-code --quiet
+'
+
 # Can we rely on git's output in the C locale?
 if test -z "$GIT_TEST_GETTEXT_POISON"
 then
-- 
2.22.0.rc1.257.g3120a18244

