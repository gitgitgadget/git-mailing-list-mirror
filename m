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
	by dcvr.yhbt.net (Postfix) with ESMTP id 221941F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfFTVJ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:09:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33716 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfFTVJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:09:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so4478483wru.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2KHJuVUArx6r9DHSs5jShUpjPeoPYX8TV48GwTpnb8=;
        b=Y8XnIBDAcClZplb79dFnTCbyDqIr4HZ/mKmlfqqw3ZyDEdCIioJt0ZevaJ4wie2y9s
         NdhLM2b+YF9+wmfe9mQN62E+sR45U9yxjS3B+FLlUw8FlMMEya3kxWDM1SSzMzSa8DI0
         ehRrt2db3x8iPghkbAOlvOuAJHtJD1u3OhuJb5//Bahe476C+wmhlk9kcj/Cl9Pi0zc0
         6AWyjJdQWAT4JwKzRlrOOG8BBxCQz+lLZ9qkXbVcyf5fx0ArI+8HS17K065HJ/eii94T
         /C+oLkd0BucpjdhZvUxawMC0vThV68mayST6FNrUyssLtJu4i8O1bSWf9oxYz8B5rQ4v
         YN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2KHJuVUArx6r9DHSs5jShUpjPeoPYX8TV48GwTpnb8=;
        b=WLlj9oWHzoqHCXmfiBIzqKCCLQZFXTrA638P36hPM/TC1PI+WLaBwhv0Juivxp0Rae
         P7e5vkHolxrZF6Lc+bPVcJsSXIDdunT9RzCxLy0FpS8oETfsYfzrx+HLZslijpIJ6DU5
         YWnS8GCpxTtBddnxez81dCipdPavOeB2sm4bszCvWx9+Ng41qsLSEiG1rxd2Bu5KNZGQ
         GjnuC4joOtjaOHFVsdNZCipN2md2WuCkFDHsJBchtjky6B4pSbzDMBUeFIIqUEA0XGFN
         DihE8no9vbV7s4dSW2D4dmLvyvRU4vAb9xNJQOjI1qPm+cx0wWVpB8AJyGX0pHQ9roRm
         Unzg==
X-Gm-Message-State: APjAAAUEy4VIe3NeJMFn8C6y7d7agbzFLd6Qt5/dF9MyOeBNWkw7mFBC
        oMWgV2yZUWRWciORhgOq+qn9K1mlWa0=
X-Google-Smtp-Source: APXvYqzTnmQjXKCeRNBndzYb7WWf2OM1c1NOBZmD+nx2HlI1VHhQFMp5n6PJToKog+BLlkOmAtKuOw==
X-Received: by 2002:a5d:664f:: with SMTP id f15mr33642695wrw.214.1561064964493;
        Thu, 20 Jun 2019 14:09:24 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm1295781wre.73.2019.06.20.14.09.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:09:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] Change <non-empty?> GIT_TEST_* variables to <boolean>
Date:   Thu, 20 Jun 2019 23:09:07 +0200
Message-Id: <20190620210915.11297-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190619233046.27503-1-avarab@gmail.com>
References: <20190619233046.27503-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v2 fixes tricky bugs I noticed after sending v1 in calling
gettext so early in the setup, and the t0016 name clash with pu Junio
pointed out.

I didn't change the "env--helper" interface as suggested because I
already had this ready and figured I'd send a v2 for review of the
stuff I have now.

The interface suggested in
<xmqqa7ecnjot.fsf@gitster-ct.c.googlers.com> is indeed prettier. FWIW
I did things like --mode-bool instead of --type=bool because it's
easier to do just with the getopt framework, likewise --variable=X
instead of "X" being last on the argv since you can do it all with the
flag parsing doing the work for you, and since it's an internal-only
command I figured it didn't matter much.

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
 builtin/env--helper.c     | 74 +++++++++++++++++++++++++++++++++
 ci/lib.sh                 |  2 +-
 config.c                  | 28 +++++++++----
 gettext.c                 |  6 +--
 git-sh-i18n.sh            |  4 +-
 git.c                     |  1 +
 po/README                 |  2 +-
 t/README                  | 12 +++---
 t/lib-git-daemon.sh       |  7 ++--
 t/lib-git-svn.sh          | 11 ++---
 t/lib-httpd.sh            | 15 ++++---
 t/t0000-basic.sh          | 10 ++---
 t/t0017-env-helper.sh     | 86 +++++++++++++++++++++++++++++++++++++++
 t/t0205-gettext-poison.sh |  7 +++-
 t/t1305-config-include.sh | 21 ++++------
 t/t5512-ls-remote.sh      |  3 +-
 t/t6040-tracking-info.sh  |  6 +--
 t/t7201-co.sh             |  2 +-
 t/t9902-completion.sh     |  2 +-
 t/test-lib-functions.sh   | 58 ++++----------------------
 t/test-lib.sh             | 33 +++++++++++----
 24 files changed, 266 insertions(+), 127 deletions(-)
 create mode 100644 builtin/env--helper.c
 create mode 100755 t/t0017-env-helper.sh

Range-diff:
-:  ---------- > 1:  c3483c37a1 config tests: simplify include cycle test
1:  8da3cd4240 ! 2:  e689759f7c env--helper: new undocumented builtin wrapping git_env_*()
    @@ -154,10 +154,10 @@
      	{ "fetch", cmd_fetch, RUN_SETUP },
      	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
     
    - diff --git a/t/t0016-env-helper.sh b/t/t0016-env-helper.sh
    + diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
      new file mode 100755
      --- /dev/null
    - +++ b/t/t0016-env-helper.sh
    + +++ b/t/t0017-env-helper.sh
     @@
     +#!/bin/sh
     +
-:  ---------- > 3:  f759d5e91e config.c: refactor die_bad_number() to not call gettext() early
2:  8315c4ecdc = 4:  1ac798e8ce t6040 test: stop using global "script" variable
3:  f1ee208d70 ! 5:  d7d6e6c874 tests: make GIT_TEST_GETTEXT_POISON a boolean
    @@ -7,7 +7,30 @@
     
         Since it needed to be checked in both C code and shellscript (via test
         -n) it was one of the remaining shellscript-like variables. Now that
    -    we have "git env--helper" we can change that.
    +    we have "env--helper" we can change that.
    +
    +    There's a couple of tricky edge cases that arise because we're using
    +    git_env_bool() early, and the config-reading "env--helper".
    +
    +    If GIT_TEST_GETTEXT_POISON is set to an invalid value die_bad_number()
    +    will die, but to do so it would usually call gettext(). Let's detect
    +    the special case of GIT_TEST_GETTEXT_POISON and always emit that
    +    message in the C locale, lest we infinitely loop.
    +
    +    As seen in the updated tests in t0016-env-helper.sh there's also a
    +    caveat related to "env--helper" needing to read the config for trace2
    +    purposes.
    +
    +    Since the C_LOCALE_OUTPUT prerequisite is lazy and relies on
    +    "env--helper" we could get invalid results if we failed to read the
    +    config (e.g. because we'd loop on includes) when combined with
    +    e.g. "test_i18ngrep" wanting to check with "env--helper" if
    +    GIT_TEST_GETTEXT_POISON was true or not.
    +
    +    I'm crossing my fingers and hoping that a test similar to the one I
    +    removed in the earlier "config tests: simplify include cycle test"
    +    change in this series won't happen again, and testing for this
    +    explicitly in "env--helper"'s own tests.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -24,6 +47,26 @@
      esac
      
     
    + diff --git a/config.c b/config.c
    + --- a/config.c
    + +++ b/config.c
    +@@
    + 	if (!value)
    + 		value = "";
    + 
    ++	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
    ++		/*
    ++		 * We explicitly *don't* use _() here since it would
    ++		 * cause an infinite loop with _() needing to call
    ++		 * use_gettext_poison(). This is why marked up
    ++		 * translations with N_() above.
    ++		 */
    ++		die(bad_numeric, value, name, error_type);
    ++
    + 	if (!(cf && cf->name))
    + 		die(_(bad_numeric), value, name, _(error_type));
    + 
    +
      diff --git a/gettext.c b/gettext.c
      --- a/gettext.c
      +++ b/gettext.c
    @@ -84,6 +127,31 @@
      prerequisite when adding more strings for translation. See "Testing
      marked strings" in po/README for details.
     
    + diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
    + --- a/t/t0017-env-helper.sh
    + +++ b/t/t0017-env-helper.sh
    +@@
    + 	test_cmp expected actual
    + '
    + 
    ++test_expect_success 'env--helper reads config thanks to trace2' '
    ++	mkdir home &&
    ++	git config -f home/.gitconfig include.path cycle &&
    ++	git config -f home/cycle include.path .gitconfig &&
    ++
    ++	test_must_fail \
    ++		env HOME="$(pwd)/home" GIT_TEST_GETTEXT_POISON=false \
    ++		git config -l 2>err &&
    ++	grep "exceeded maximum include depth" err &&
    ++
    ++	test_must_fail \
    ++		env HOME="$(pwd)/home" GIT_TEST_GETTEXT_POISON=true \
    ++		git -C cycle env--helper --mode-bool --variable=GIT_TEST_GETTEXT_POISON --default=0 --exit-code --quiet 2>err &&
    ++	grep "# GETTEXT POISON #" err
    ++'
    ++
    + test_done
    +
      diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
      --- a/t/t0205-gettext-poison.sh
      +++ b/t/t0205-gettext-poison.sh
    @@ -96,6 +164,29 @@
      export GIT_TEST_GETTEXT_POISON
      . ./lib-gettext.sh
      
    +@@
    +     test_cmp expect actual
    + '
    + 
    ++test_expect_success "gettext: invalid GIT_TEST_GETTEXT_POISON value doesn't infinitely loop" "
    ++	test_must_fail env GIT_TEST_GETTEXT_POISON=xyz git version 2>error &&
    ++	grep \"fatal: bad numeric config value 'xyz' for 'GIT_TEST_GETTEXT_POISON': invalid unit\" error
    ++"
    ++
    + test_done
    +
    + diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
    + --- a/t/t1305-config-include.sh
    + +++ b/t/t1305-config-include.sh
    +@@
    + 	git -C cycle config include.path cycle &&
    + 	git config -f cycle/cycle include.path config &&
    + 	test_must_fail \
    +-		env GIT_TEST_GETTEXT_POISON= \
    ++		env GIT_TEST_GETTEXT_POISON=false \
    + 		git -C cycle config --get-all test.value 2>stderr &&
    + 	grep "exceeded maximum include depth" stderr
    + '
     
      diff --git a/t/t7201-co.sh b/t/t7201-co.sh
      --- a/t/t7201-co.sh
    @@ -130,10 +221,14 @@
      	unset GIT_TEST_GETTEXT_POISON_ORIG
      fi
      
    +-# Can we rely on git's output in the C locale?
    +-if test -z "$GIT_TEST_GETTEXT_POISON"
    +-then
    +-	test_set_prereq C_LOCALE_OUTPUT
    +-fi
     +test_lazy_prereq C_LOCALE_OUTPUT '
     +	! git env--helper --mode-bool --variable=GIT_TEST_GETTEXT_POISON --default=0 --exit-code --quiet
     +'
    -+
    - # Can we rely on git's output in the C locale?
    - if test -z "$GIT_TEST_GETTEXT_POISON"
    + 
    + if test -z "$GIT_TEST_CHECK_CACHE_TREE"
      then
4:  f1e28dff36 = 6:  954428b3cd tests README: re-flow a previously changed paragraph
5:  f046cf21fb = 7:  79b41cf01b tests: replace test_tristate with "git env--helper"
6:  e2c68e0239 = 8:  a9aa166b66 tests: make GIT_TEST_FAIL_PREREQS a boolean
-- 
2.22.0.455.g172b71a6c5

