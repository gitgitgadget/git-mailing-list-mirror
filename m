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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB9B1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 23:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfF0Xj3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 19:39:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51444 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0Xj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 19:39:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so7285030wma.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+uzeFRGh5u8sZN6dcCo0v1FILBCp/7yc4F35XVPyTDs=;
        b=aolhlNgARKf3s6l5c0KGp6W1UznhYFoKIR5+vPWg3dSCSCk8AY0mZuyBDu1qPH3KdM
         88zDQ9rx/231/d4IEzUXJlC6sLk85HdjV5MLuv9yikw9N6neQWJvC9nPl2W3Z+pMVJcR
         fdtnkvHpLPBHxLPigvItXmqz40j6E0p2NnKYbq8ZiJCIdsYlD41fTBinlKQLyL9HSRiR
         OPoew1mZ6LaoSpf3DAl5BXOn7EiqEbfrY3I4MGaMJPY74LG23wPCe/FMMERL30CjAA5m
         maqiueUwNiQXzS8v3vHhDyjKKmEsdSd3LWlVbSkD31Oofv4t9B7K7NAUEzQSPgAmZXlW
         YpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uzeFRGh5u8sZN6dcCo0v1FILBCp/7yc4F35XVPyTDs=;
        b=N6DsF5eNo99fUTmjI/1mM8WNjjLq/fRHwBABDkhLX1GlYpmuivkDBSgy4RND5Fi+jy
         HPZmxSsSJ5PkLMZBcHKL4a4zOBLnr6ii/CoR/F/qir+tr7iqt8VT4J8581V+oWAFE608
         z+ko59Lv6ByIVS4ir9fTrT9rMYuGStFedRo2nOdRnakJUlfbW5dV0h/2ubKkG0Pfn4hZ
         f37ym6FdFovohD40N5W+R2hLJMzX1odOasgF/tVx9epYHOM45KzYn+856GjlO/Isd7vO
         gO0BH7wZVgKS854zZtotf0EoNhFqeU1SZ2HzbCvxUdZpfNqxACpzbkSPBIzxk4eP7jlM
         MwFA==
X-Gm-Message-State: APjAAAVIOvuYdBCv6zAgr3cIvr63QbAMm7msn6IcIX/V2WxePlwnB2EF
        gDDBFyzDtk4aY12pinNIWZbds/XK
X-Google-Smtp-Source: APXvYqyi5yI5Ht/E+SKRMdLD6MsyX5YoM4hg6spcROXOBgxf+YrVa5LZspQqcAbxn7FBhlDKfw0A1g==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr4812650wmj.65.1561678764175;
        Thu, 27 Jun 2019 16:39:24 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x16sm720530wmj.4.2019.06.27.16.39.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:39:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/9] grep: move from kwset to optional PCRE v2
Date:   Fri, 28 Jun 2019 01:39:03 +0200
Message-Id: <20190627233912.7117-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190626000329.32475-1-avarab@gmail.com>
References: <20190626000329.32475-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A non-RFC since it seem people like this approach.

This should fix the test failure noted by Johannes, there's two new
patches at the start of this series. They address a bug that was there
for a long time, but I happened to trip over since PCRE is more strict
about UTF-8 validation than kwset (which doesn't care at all).

I also added performance numbers to the relevant commit messages, took
brian's suggestion of saying "NUL-byte" instead of "\0", and did some
other copyediting of my own.

The rest of the code changes are all just comments & rewording of
previously added comments.

Ævar Arnfjörð Bjarmason (9):
  log tests: test regex backends in "--encode=<enc>" tests
  grep: don't use PCRE2?_UTF8 with "log --encoding=<non-utf8>"
  grep: inline the return value of a function call used only once
  grep tests: move "grep binary" alongside the rest
  grep tests: move binary pattern tests into their own file
  grep: make the behavior for NUL-byte in patterns sane
  grep: drop support for \0 in --fixed-strings <pattern>
  grep: remove the kwset optimization
  grep: use PCRE v2 for optimized fixed-string search

 Documentation/git-grep.txt                    |  17 +++
 grep.c                                        | 115 +++++++---------
 grep.h                                        |   3 +-
 revision.c                                    |   3 +
 t/t4210-log-i18n.sh                           |  39 +++++-
 ...a1.sh => t7008-filter-branch-null-sha1.sh} |   0
 ...08-grep-binary.sh => t7815-grep-binary.sh} | 101 --------------
 t/t7816-grep-binary-pattern.sh                | 127 ++++++++++++++++++
 8 files changed, 233 insertions(+), 172 deletions(-)
 rename t/{t7009-filter-branch-null-sha1.sh => t7008-filter-branch-null-sha1.sh} (100%)
 rename t/{t7008-grep-binary.sh => t7815-grep-binary.sh} (55%)
 create mode 100755 t/t7816-grep-binary-pattern.sh

Range-diff:
 -:  ---------- >  1:  cfc01f49d3 log tests: test regex backends in "--encode=<enc>" tests
 -:  ---------- >  2:  4b59eb32f0 grep: don't use PCRE2?_UTF8 with "log --encoding=<non-utf8>"
 1:  ad55d3be7e =  3:  cc4d3b50d5 grep: inline the return value of a function call used only once
 2:  650bcc8582 =  4:  d9b29bdd89 grep tests: move "grep binary" alongside the rest
 3:  ef10a8820d !  5:  f85614f435 grep tests: move binary pattern tests into their own file
    @@ -2,9 +2,10 @@
     
         grep tests: move binary pattern tests into their own file
     
    -    Move the tests for "-f <file>" where "<file>" contains a "\0" pattern
    -    into their own file. I added most of these tests in 966be95549 ("grep:
    -    add tests to fix blind spots with \0 patterns", 2017-05-20).
    +    Move the tests for "-f <file>" where "<file>" contains a NUL byte
    +    pattern into their own file. I added most of these tests in
    +    966be95549 ("grep: add tests to fix blind spots with \0 patterns",
    +    2017-05-20).
     
         Whether a regex engine supports matching binary content is very
         different from whether it matches binary patterns. Since
    @@ -14,8 +15,8 @@
         engine can sensibly match binary patterns.
     
         Since 9eceddeec6 ("Use kwset in grep", 2011-08-21) we've been punting
    -    patterns containing "\0" and considering them fixed, except in cases
    -    where "--ignore-case" is provided and they're non-ASCII, see
    +    patterns containing NUL-byte and considering them fixed, except in
    +    cases where "--ignore-case" is provided and they're non-ASCII, see
         5c1ebcca4d ("grep/icase: avoid kwsset on literal non-ascii strings",
         2016-06-25). Subsequent commits will change this behavior.
     
 4:  03e5637efc !  6:  90afca8707 grep: make the behavior for \0 in patterns sane
    @@ -1,12 +1,13 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    grep: make the behavior for \0 in patterns sane
    +    grep: make the behavior for NUL-byte in patterns sane
     
    -    The behavior of "grep" when patterns contained "\0" has always been
    -    haphazard, and has served the vagaries of the implementation more than
    -    anything else. A "\0" in a pattern can only be provided via "-f
    -    <file>", and since pickaxe (log search) has no such flag "\0" in
    -    patterns has only ever been supported by "grep".
    +    The behavior of "grep" when patterns contained a NUL-byte has always
    +    been haphazard, and has served the vagaries of the implementation more
    +    than anything else. A pattern containing a NUL-byte can only be
    +    provided via "-f <file>". Since pickaxe (log search) has no such flag
    +    the NUL-byte in patterns has only ever been supported by "grep" (and
    +    not "log --grep").
     
         Since 9eceddeec6 ("Use kwset in grep", 2011-08-21) patterns containing
         "\0" were considered fixed. In 966be95549 ("grep: add tests to fix
    @@ -14,9 +15,9 @@
         behavior.
     
         Change the behavior to do the obvious thing, i.e. don't silently
    -    discard a regex pattern and make it implicitly fixed just because it
    -    contains a \0. Instead die if e.g. --basic-regexp is combined with
    -    such a pattern.
    +    discard a regex pattern and make it implicitly fixed just because they
    +    contain a NUL-byte. Instead die if the backend in question can't
    +    handle them, e.g. --basic-regexp is combined with such a pattern.
     
         This is desired because from a user's point of view it's the obvious
         thing to do. Whether we support BRE/ERE/Perl syntax is different from
 5:  b9aad3ec1c !  7:  526b925fdc grep: drop support for \0 in --fixed-strings <pattern>
    @@ -2,15 +2,14 @@
     
         grep: drop support for \0 in --fixed-strings <pattern>
     
    -    Change "-f <file>" to not support patterns with "\0" in them under
    -    --fixed-strings, we'll now only support these under --perl-regexp with
    -    PCRE v2.
    +    Change "-f <file>" to not support patterns with a NUL-byte in them
    +    under --fixed-strings. We'll now only support these under
    +    "--perl-regexp" with PCRE v2.
     
    -    A previous change to Documentation/git-grep.txt changed the
    -    description of "-f <file>" to be vague enough as to not promise that
    -    this would work, and by dropping support for this we make it a whole
    -    lot easier to move away from the kwset backend, which a subsequent
    -    change will try to do.
    +    A previous change to grep's documentation changed the description of
    +    "-f <file>" to be vague enough as to not promise that this would work.
    +    By dropping support for this we make it a whole lot easier to move
    +    away from the kwset backend, which we'll do in a subsequent change.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 6:  3587be009a !  8:  14269bb295 grep: remove the kwset optimization
    @@ -2,9 +2,99 @@
     
         grep: remove the kwset optimization
     
    -    A later change will replace this optimization with a different one,
    -    but as removing it and running the tests demonstrates no grep
    -    semantics depend on this backend anymore.
    +    A later change will replace this optimization with optimistic use of
    +    PCRE v2. I'm completely removing it as an intermediate step, as
    +    opposed to replacing it with PCRE v2, to demonstrate that no grep
    +    semantics depend on this (or any other) optimization for the fixed
    +    backend anymore.
    +
    +    For now this is mostly (but not entirely) a performance regression, as
    +    shown by this hacky one-liner:
    +
    +        for opt in '' ' -i'
    +            do
    +            GIT_PERF_7821_GREP_OPTS=$opt GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS='-j8 CFLAGS=-O3 USE_LIBPCRE=YesPlease' ./run origin/master HEAD -- p7821-grep-engines-fixed.sh
    +        done &&
    +        for opt in '' ' -i'
    +            do GIT_PERF_4221_LOG_OPTS=$opt GIT_PERF_REPEAT_COUNT=10 GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_MAKE_OPTS='-j8 CFLAGS=-O3 USE_LIBPCRE=YesPlease' ./run origin/master HEAD -- p4221-log-grep-engines-fixed.sh
    +        done
    +
    +    Which produces:
    +
    +    plain grep:
    +
    +        Test                             origin/master     HEAD
    +        -------------------------------------------------------------------------
    +        7821.1: fixed grep int           0.55(1.60+0.63)   0.82(3.11+0.51) +49.1%
    +        7821.2: basic grep int           0.62(1.68+0.49)   0.85(3.02+0.52) +37.1%
    +        7821.3: extended grep int        0.61(1.63+0.53)   0.91(3.09+0.44) +49.2%
    +        7821.4: perl grep int            0.55(1.60+0.57)   0.41(0.93+0.57) -25.5%
    +        7821.6: fixed grep uncommon      0.20(0.50+0.44)   0.35(1.27+0.42) +75.0%
    +        7821.7: basic grep uncommon      0.20(0.49+0.45)   0.35(1.29+0.41) +75.0%
    +        7821.8: extended grep uncommon   0.20(0.45+0.48)   0.35(1.25+0.44) +75.0%
    +        7821.9: perl grep uncommon       0.20(0.53+0.41)   0.16(0.24+0.49) -20.0%
    +        7821.11: fixed grep æ            0.35(1.27+0.40)   0.25(0.82+0.39) -28.6%
    +        7821.12: basic grep æ            0.35(1.28+0.38)   0.25(0.75+0.44) -28.6%
    +        7821.13: extended grep æ         0.36(1.21+0.46)   0.25(0.86+0.35) -30.6%
    +        7821.14: perl grep æ             0.35(1.33+0.34)   0.16(0.26+0.47) -54.3%
    +
    +    grep with -i:
    +
    +        Test                                origin/master     HEAD
    +        -----------------------------------------------------------------------------
    +        7821.1: fixed grep -i int           0.61(1.84+0.64)   1.11(4.12+0.64) +82.0%
    +        7821.2: basic grep -i int           0.72(1.86+0.57)   1.15(4.48+0.49) +59.7%
    +        7821.3: extended grep -i int        0.94(1.83+0.60)   1.53(4.12+0.58) +62.8%
    +        7821.4: perl grep -i int            0.66(1.82+0.59)   0.55(1.08+0.58) -16.7%
    +        7821.6: fixed grep -i uncommon      0.21(0.51+0.44)   0.44(1.74+0.34) +109.5%
    +        7821.7: basic grep -i uncommon      0.21(0.55+0.41)   0.44(1.72+0.40) +109.5%
    +        7821.8: extended grep -i uncommon   0.21(0.57+0.39)   0.42(1.64+0.45) +100.0%
    +        7821.9: perl grep -i uncommon       0.21(0.48+0.48)   0.17(0.30+0.45) -19.0%
    +        7821.11: fixed grep -i æ            0.25(0.73+0.45)   0.25(0.75+0.45) +0.0%
    +        7821.12: basic grep -i æ            0.25(0.71+0.49)   0.26(0.77+0.44) +4.0%
    +        7821.13: extended grep -i æ         0.25(0.75+0.44)   0.25(0.74+0.46) +0.0%
    +        7821.14: perl grep -i æ             0.17(0.26+0.48)   0.16(0.20+0.52) -5.9%
    +
    +    plain log:
    +
    +        Test                                     origin/master     HEAD
    +        ---------------------------------------------------------------------------------
    +        4221.1: fixed log --grep='int'           7.31(7.06+0.21)   8.11(7.85+0.20) +10.9%
    +        4221.2: basic log --grep='int'           7.30(6.94+0.27)   8.16(7.89+0.19) +11.8%
    +        4221.3: extended log --grep='int'        7.34(7.05+0.21)   8.08(7.76+0.25) +10.1%
    +        4221.4: perl log --grep='int'            7.27(6.94+0.24)   7.05(6.76+0.25) -3.0%
    +        4221.6: fixed log --grep='uncommon'      6.97(6.62+0.32)   7.86(7.51+0.30) +12.8%
    +        4221.7: basic log --grep='uncommon'      7.05(6.69+0.29)   7.89(7.60+0.28) +11.9%
    +        4221.8: extended log --grep='uncommon'   6.89(6.56+0.32)   7.99(7.66+0.24) +16.0%
    +        4221.9: perl log --grep='uncommon'       7.02(6.66+0.33)   6.97(6.54+0.36) -0.7%
    +        4221.11: fixed log --grep='æ'            7.37(7.03+0.33)   7.67(7.30+0.31) +4.1%
    +        4221.12: basic log --grep='æ'            7.41(7.00+0.31)   7.60(7.28+0.26) +2.6%
    +        4221.13: extended log --grep='æ'         7.35(6.96+0.38)   7.73(7.31+0.34) +5.2%
    +        4221.14: perl log --grep='æ'             7.43(7.10+0.32)   6.95(6.61+0.27) -6.5%
    +
    +    log with -i:
    +
    +        Test                                        origin/master     HEAD
    +        ------------------------------------------------------------------------------------
    +        4221.1: fixed log -i --grep='int'           7.40(7.05+0.23)   8.66(8.38+0.20) +17.0%
    +        4221.2: basic log -i --grep='int'           7.39(7.09+0.23)   8.67(8.39+0.20) +17.3%
    +        4221.3: extended log -i --grep='int'        7.29(6.99+0.26)   8.69(8.31+0.26) +19.2%
    +        4221.4: perl log -i --grep='int'            7.42(7.16+0.21)   7.14(6.80+0.24) -3.8%
    +        4221.6: fixed log -i --grep='uncommon'      6.94(6.58+0.35)   8.43(8.04+0.30) +21.5%
    +        4221.7: basic log -i --grep='uncommon'      6.95(6.62+0.31)   8.34(7.93+0.32) +20.0%
    +        4221.8: extended log -i --grep='uncommon'   7.06(6.75+0.25)   8.32(7.98+0.31) +17.8%
    +        4221.9: perl log -i --grep='uncommon'       6.96(6.69+0.26)   7.04(6.64+0.32) +1.1%
    +        4221.11: fixed log -i --grep='æ'            7.92(7.55+0.33)   7.86(7.44+0.34) -0.8%
    +        4221.12: basic log -i --grep='æ'            7.88(7.49+0.32)   7.84(7.46+0.34) -0.5%
    +        4221.13: extended log -i --grep='æ'         7.91(7.51+0.32)   7.87(7.48+0.32) -0.5%
    +        4221.14: perl log -i --grep='æ'             7.01(6.59+0.35)   6.99(6.64+0.28) -0.3%
    +
    +    Some of those, as noted in [1] are because PCRE is faster at finding
    +    fixed strings. This looks bad for some engines, but in the next change
    +    we'll optimistically use PCRE v2 for all of these, so it'll look
    +    better.
    +
    +    1. https://public-inbox.org/git/87v9x793qi.fsf@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 7:  5bc25c03b8 !  9:  c0fd75d102 grep: use PCRE v2 for optimized fixed-string search
    @@ -7,19 +7,95 @@
         slower than PCRE v1 and v2 JIT with the kwset backend, so that
         optimization was counterproductive.
     
    -    This brings back the optimization for "-F", without changing the
    -    semantics of "\0" in patterns. As seen in previous commits in this
    -    series we could support it now, but I'd rather just leave that
    -    edge-case aside so the tests don't need to do one thing or the other
    -    depending on what --fixed-strings backend we're using.
    -
    -    I could also support the v1 backend here, but that would make the code
    -    more complex, and I'd rather aim for simplicity here and in future
    +    This brings back the optimization for "--fixed-strings", without
    +    changing the semantics of having a NUL-byte in patterns. As seen in
    +    previous commits in this series we could support it now, but I'd
    +    rather just leave that edge-case aside so we don't have one behavior
    +    or the other depending what "--fixed-strings" backend we're using. It
    +    makes the behavior harder to understand and document, and makes tests
    +    for the different backends more painful.
    +
    +    I could also support the PCRE v1 backend here, but that would make the
    +    code more complex. I'd rather aim for simplicity here and in future
         changes to the diffcore. We're not going to have someone who
         absolutely must have faster search, but for whom building PCRE v2
         isn't acceptable.
     
    -    1. https://public-inbox.org/git/87v9x793qi.fsf@evledraar.gmail.com/
    +    The difference between this series of commits and the current "master"
    +    is, using the same t/perf commands shown in the last commit:
    +
    +    plain grep:
    +
    +        Test                             origin/master     HEAD
    +        -------------------------------------------------------------------------
    +        7821.1: fixed grep int           0.55(1.67+0.56)   0.41(0.98+0.60) -25.5%
    +        7821.2: basic grep int           0.58(1.65+0.52)   0.41(0.96+0.57) -29.3%
    +        7821.3: extended grep int        0.57(1.66+0.49)   0.42(0.93+0.60) -26.3%
    +        7821.4: perl grep int            0.54(1.67+0.50)   0.43(0.88+0.65) -20.4%
    +        7821.6: fixed grep uncommon      0.21(0.52+0.42)   0.16(0.24+0.51) -23.8%
    +        7821.7: basic grep uncommon      0.20(0.49+0.45)   0.17(0.28+0.47) -15.0%
    +        7821.8: extended grep uncommon   0.20(0.54+0.39)   0.16(0.25+0.50) -20.0%
    +        7821.9: perl grep uncommon       0.20(0.58+0.36)   0.16(0.23+0.50) -20.0%
    +        7821.11: fixed grep æ            0.35(1.24+0.43)   0.16(0.23+0.50) -54.3%
    +        7821.12: basic grep æ            0.36(1.29+0.38)   0.16(0.20+0.54) -55.6%
    +        7821.13: extended grep æ         0.35(1.23+0.44)   0.16(0.24+0.50) -54.3%
    +        7821.14: perl grep æ             0.35(1.33+0.34)   0.16(0.28+0.46) -54.3%
    +
    +    grep with -i:
    +
    +        Test                                origin/master     HEAD
    +        ----------------------------------------------------------------------------
    +        7821.1: fixed grep -i int           0.62(1.81+0.70)   0.47(1.11+0.64) -24.2%
    +        7821.2: basic grep -i int           0.67(1.90+0.53)   0.46(1.07+0.62) -31.3%
    +        7821.3: extended grep -i int        0.62(1.92+0.53)   0.53(1.12+0.58) -14.5%
    +        7821.4: perl grep -i int            0.66(1.85+0.58)   0.45(1.10+0.59) -31.8%
    +        7821.6: fixed grep -i uncommon      0.21(0.54+0.43)   0.17(0.20+0.55) -19.0%
    +        7821.7: basic grep -i uncommon      0.20(0.52+0.45)   0.17(0.29+0.48) -15.0%
    +        7821.8: extended grep -i uncommon   0.21(0.52+0.44)   0.17(0.26+0.50) -19.0%
    +        7821.9: perl grep -i uncommon       0.21(0.53+0.44)   0.17(0.20+0.56) -19.0%
    +        7821.11: fixed grep -i æ            0.26(0.79+0.44)   0.16(0.29+0.46) -38.5%
    +        7821.12: basic grep -i æ            0.26(0.79+0.42)   0.16(0.20+0.54) -38.5%
    +        7821.13: extended grep -i æ         0.26(0.84+0.39)   0.16(0.24+0.50) -38.5%
    +        7821.14: perl grep -i æ             0.16(0.24+0.49)   0.17(0.25+0.51) +6.3%
    +
    +    plain log:
    +
    +        Test                                     origin/master     HEAD
    +        --------------------------------------------------------------------------------
    +        4221.1: fixed log --grep='int'           7.24(6.95+0.28)   7.20(6.95+0.18) -0.6%
    +        4221.2: basic log --grep='int'           7.31(6.97+0.22)   7.20(6.93+0.21) -1.5%
    +        4221.3: extended log --grep='int'        7.37(7.04+0.24)   7.22(6.91+0.25) -2.0%
    +        4221.4: perl log --grep='int'            7.31(7.04+0.21)   7.19(6.89+0.21) -1.6%
    +        4221.6: fixed log --grep='uncommon'      6.93(6.59+0.32)   7.04(6.66+0.37) +1.6%
    +        4221.7: basic log --grep='uncommon'      6.92(6.58+0.29)   7.08(6.75+0.29) +2.3%
    +        4221.8: extended log --grep='uncommon'   6.92(6.55+0.31)   7.00(6.68+0.31) +1.2%
    +        4221.9: perl log --grep='uncommon'       7.03(6.59+0.33)   7.12(6.73+0.34) +1.3%
    +        4221.11: fixed log --grep='æ'            7.41(7.08+0.28)   7.05(6.76+0.29) -4.9%
    +        4221.12: basic log --grep='æ'            7.39(6.99+0.33)   7.00(6.68+0.25) -5.3%
    +        4221.13: extended log --grep='æ'         7.34(7.00+0.25)   7.15(6.81+0.31) -2.6%
    +        4221.14: perl log --grep='æ'             7.43(7.13+0.26)   7.01(6.60+0.36) -5.7%
    +
    +    log with -i:
    +
    +        Test                                        origin/master     HEAD
    +        ------------------------------------------------------------------------------------
    +        4221.1: fixed log -i --grep='int'           7.31(7.07+0.24)   7.23(7.00+0.22) -1.1%
    +        4221.2: basic log -i --grep='int'           7.40(7.08+0.28)   7.19(6.92+0.20) -2.8%
    +        4221.3: extended log -i --grep='int'        7.43(7.13+0.25)   7.27(6.99+0.21) -2.2%
    +        4221.4: perl log -i --grep='int'            7.34(7.10+0.24)   7.10(6.90+0.19) -3.3%
    +        4221.6: fixed log -i --grep='uncommon'      7.07(6.71+0.32)   7.11(6.77+0.28) +0.6%
    +        4221.7: basic log -i --grep='uncommon'      6.99(6.64+0.28)   7.12(6.69+0.38) +1.9%
    +        4221.8: extended log -i --grep='uncommon'   7.11(6.74+0.32)   7.10(6.77+0.27) -0.1%
    +        4221.9: perl log -i --grep='uncommon'       6.98(6.60+0.29)   7.05(6.64+0.34) +1.0%
    +        4221.11: fixed log -i --grep='æ'            7.85(7.45+0.34)   7.03(6.68+0.32) -10.4%
    +        4221.12: basic log -i --grep='æ'            7.87(7.49+0.29)   7.06(6.69+0.31) -10.3%
    +        4221.13: extended log -i --grep='æ'         7.87(7.54+0.31)   7.09(6.69+0.31) -9.9%
    +        4221.14: perl log -i --grep='æ'             7.06(6.77+0.28)   6.91(6.57+0.31) -2.1%
    +
    +    So as with e05b027627 ("grep: use PCRE v2 for optimized fixed-string
    +    search", 2019-06-26) there's a huge improvement in performance for
    +    "grep", but in "log" most of our time is spent elsewhere, so we don't
    +    notice it that much.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -81,15 +157,19 @@
     +		} else {
     +			/*
     +			 * E.g. t7811-grep-open.sh relies on the
    -+			 * pattern being restored, and unfortunately
    -+			 * there's no PCRE compile flag for "this is
    -+			 * fixed", so we need to munge it to
    -+			 * "\Q<pat>\E".
    ++			 * pattern being restored.
     +			 */
     +			char *old_pattern = p->pattern;
     +			size_t old_patternlen = p->patternlen;
     +			struct strbuf sb = STRBUF_INIT;
     +
    ++			/*
    ++			 * There is the PCRE2_LITERAL flag, but it's
    ++			 * only in PCRE v2 10.30 and later. Needing to
    ++			 * ifdef our way around that and dealing with
    ++			 * it + PCRE2_MULTILINE being an error is more
    ++			 * complex than just quoting this ourselves.
    ++			*/
     +			strbuf_add(&sb, "\\Q", 2);
     +			strbuf_add(&sb, p->pattern, p->patternlen);
     +			strbuf_add(&sb, "\\E", 2);
    @@ -101,9 +181,9 @@
     +			p->patternlen = old_patternlen;
     +			strbuf_release(&sb);
     +		}
    -+#else
    ++#else /* !USE_LIBPCRE2 */
      		compile_fixed_regexp(p, opt);
    -+#endif
    ++#endif /* !USE_LIBPCRE2 */
      		return;
      	}
      
-- 
2.22.0.455.g172b71a6c5

