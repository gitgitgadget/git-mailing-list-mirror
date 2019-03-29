Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0BE20248
	for <e@80x24.org>; Fri, 29 Mar 2019 12:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfC2Mfd (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 08:35:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36770 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbfC2Mfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 08:35:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so2432369wrd.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2V62pGQoiR5XsxHw+5Wvi3RTSqvV7iozHjiIlfHRv4=;
        b=j46xdHoGZ7UlINZSfxuZ1Qi4j9CENYqwedV7tbVlmtMh1FFptpcn8xkvRYty+8fSWP
         Wan1xlzKJNSTyB8qiFRlbcXCkIxXryNQudKg6VFSvajBOcvFBG5KdStBU/zuq3wEBxMP
         2jLLyvU/uDY/FUprypkES4REqDD3dZNeJEHSYhmmZBldCdJbYRurUbsXu9JQ82RcOmNd
         Zwb05MbZ45c2JwKGQiiLkIH3Sg0wFc9gBdljc1A2hXQ6NqtiWneHyP/lyiBxuu4ORpjj
         y7l09TbsXLQ+mkprH6g5HJkt+wtVJnVKqO2MtiGhA09Pv/skMSkQEk1ZyjNhs4gIndfk
         WsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2V62pGQoiR5XsxHw+5Wvi3RTSqvV7iozHjiIlfHRv4=;
        b=q75Ewz3j33X4/EuZw0ytPYZePN+DpFnO3GESYPEeuulnfGLBGcj7oEsOszzt3ng84Q
         0dedjcVw/H9dvgG0IkyTYTKeAxYu468Dap/PVcuV9Oy23YlsgD7dvuJDrQ4nsBfkBN/9
         9lI20v3l+p2j1jtLnE4hVXX2KSTaMGjcO52V22jB7yb34ClCZFne+ebgghC5b+erXw/T
         33BWEFcd7peiOi9ZMVXCMeL2JHZpNUxhIFBtV1eMfJaL/DZDYGFtO1+WnQ9R4LwrPx5S
         S7v5d0+FmG1ZsdUCsEZXv4riUtoAYgLqoHRFtwLHUlnlw25ifo0pGuWqwtKUe+1fcIsW
         8Xsw==
X-Gm-Message-State: APjAAAVq/ubYkkv9P0pZdhAyftnAqeE6TdC8lC/OaUteRJa1DTrlIxlX
        lMY43BfmnDGv8hjAjdxmL/8=
X-Google-Smtp-Source: APXvYqwarygu/u9rPB/983VqGwJlitVKd/ph5wAokpSE5zF+mvM66OJ694jUaJomBRRgKodStljdAQ==
X-Received: by 2002:adf:82aa:: with SMTP id 39mr27804635wrc.305.1553862930651;
        Fri, 29 Mar 2019 05:35:30 -0700 (PDT)
Received: from localhost.localdomain (x4dbd3bb2.dyn.telefonica.de. [77.189.59.178])
        by smtp.gmail.com with ESMTPSA id 61sm7341781wre.50.2019.03.29.05.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 05:35:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/6] Asciidoctor-related formatting and CI fixes
Date:   Fri, 29 Mar 2019 13:35:14 +0100
Message-Id: <20190329123520.27549-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190324215534.9495-1-szeder.dev@gmail.com>
References: <20190324215534.9495-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first three patches fix formatting issues with Asciidoctor, while
the last three patches are a small cleanup and fixes to the
documentation CI build jobs; notably patch 5 un-breaks the
documentation build job on Travis CI in the era of Asciidoctor v2.0.0
[1], and patch 6 fixes some forever-broken checks.

Changes since v2:

  - The fixed stderr check in patch 6 is triggered when merged with
    'pu', in particular with commit 9a71722b4d (Doc: auto-detect
    changed build flags, 2019-03-17) in
    'ma/doc-diff-doc-vs-doctor-comparison'.  The changes to patch 6
    deal with that.

  - Mention in patch 4's commit message that Asciidoctor is still only
    installed in the Documentation build job.


[1] https://public-inbox.org/git/20190324162131.GL4047@pobox.com/



SZEDER Gábor (6):
  Documentation/git-diff-tree.txt: fix formatting
  Documentation/technical/api-config.txt: fix formatting
  Documentation/technical/protocol-v2.txt: fix formatting
  ci: install Asciidoctor in 'ci/install-dependencies.sh'
  ci: stick with Asciidoctor v1.5.8 for now
  ci: fix AsciiDoc/Asciidoctor stderr check in the documentation build
    job

 Documentation/git-diff-tree.txt         |  1 +
 Documentation/technical/api-config.txt  |  2 +-
 Documentation/technical/protocol-v2.txt | 52 ++++++++++++-------------
 ci/install-dependencies.sh              |  3 ++
 ci/test-documentation.sh                | 24 +++++++-----
 5 files changed, 46 insertions(+), 36 deletions(-)

Range-diff:
1:  8026f62876 = 1:  8026f62876 Documentation/git-diff-tree.txt: fix formatting
2:  fd19cf4b24 = 2:  fd19cf4b24 Documentation/technical/api-config.txt: fix formatting
3:  638dcd64e9 = 3:  638dcd64e9 Documentation/technical/protocol-v2.txt: fix formatting
4:  6f8c6ff398 ! 4:  2e94e2b7b6 ci: install Asciidoctor in 'ci/install-dependencies.sh'
    @@ -6,8 +6,9 @@
         installation of the 'asciidoctor' gem somehow ended up in
         'ci/test-documentation.sh'.
     
    -    Install it in 'ci/install-dependencies.sh', where we install
    -    everything else.
    +    Install it in 'ci/install-dependencies.sh', where we install other
    +    dependencies of the Documentation build job as well (asciidoc,
    +    xmlto).
     
         [1] 657343a602 (travis-ci: move Travis CI code into dedicated scripts,
             2017-09-10)
5:  b9eb371f81 = 5:  95476591dd ci: stick with Asciidoctor v1.5.8 for now
6:  ba2a005a05 ! 6:  04ee6831fd ci: fix AsciiDoc/Asciidoctor stderr check in the documentation build job
    @@ -2,51 +2,62 @@
     
         ci: fix AsciiDoc/Asciidoctor stderr check in the documentation build job
     
    -    In our 'ci/*' build scripts we rely on 'set -e' aborting the build job
    -    when a command exits with error, while in 'ci/test-documentation.sh'
    -    we tried to check the emptiness of AsciiDoc's and Asciidoctor's
    -    standard error with '! test -s stderr.log'.  Unfortunately, the
    -    combination of the two doesn't work as intended, because, according to
    -    POSIX [1]:
    +    In 'ci/test-documentation.sh' we save the standard error of 'make
    +    doc', and, in an attempt to make sure that neither AsciiDoc nor
    +    Asciidoctor printed any warnings, we check the emptiness of the
    +    resulting file with '! test -s stderr.log'.  This check has never
    +    actually worked, because in our 'ci/*' build scripts we rely on 'set
    +    -e' aborting the build job when a command exits with error, and,
    +    unfortunately, the combination of the two doesn't work as intended.
    +    According to POSIX [1]:
     
           "The -e setting shall be ignored when executing [...] a pipeline
           beginning with the ! reserved word" [2]
     
         Watch and learn:
     
    -      $ cat e.sh
    -      #!/bin/sh
    -      set -ex
    -      echo unexpected >file
    -      ! test -s file
    -      test ! -s file
    -      echo "should not reach this"
    -      $ ./e.sh
    -      + echo unexpected
    -      + test -s file
    -      + test ! -s file
    -      $
    +      $ echo unexpected >file
    +      $ ( set -e; ! test -s file ; echo "should not reach this" ) ; echo $?
    +      should not reach this
    +      0
     
         This is why we haven't noticed the warnings from Asciidoctor that were
         fixed in the first patches of this patch series, though some of them
         were already there in the build of v2.18.0-rc0 [3].
     
         Check the emptiness of that file with 'test ! -s' instead, which works
    -    properly with 'set -e'.  Furthermore, dump the contents of that file
    -    to the log for our convenience, so if it were to unexpectedly end up
    -    being non-empty, then we wouldn't have to scroll through all that long
    -    build log looking for warnings, but could see them right away near the
    -    end of the log.
    -
    -    And one more thing: we build the docs with Asciidoctor right after a
    -    'make clean', meaning that 'make doc' starts with running
    -    'GIT-VERSION-GEN', which in turn prints the version to its standard
    -    error.  This version then goes to 'stderr.log' as well, and a 'sed'
    -    command is supposed to remove it to prevent it from interfering with
    -    that (previously defunct) emptiness check.  Alas, this command doesn't
    -    work as intended, either, because it leaves the file to be checked
    -    intact, but the defunct emptiness check hid this issue, too...  This
    -    patch deals with this as well.
    +    properly with 'set -e':
    +
    +      $ ( set -e; test ! -s file ; echo "should not reach this" ) ; echo $?
    +      1
    +
    +    Furthermore, dump the contents of that file to the log for our
    +    convenience, so if it were to unexpectedly end up being non-empty,
    +    then we wouldn't have to scroll through all that long build log
    +    looking for warnings, but could see them right away near the end of
    +    the log.
    +
    +    Note that we are only really interested in the standard error of
    +    AsciiDoc and Asciidoctor, but by saving the stderr of 'make doc' we
    +    also save any error output from the make rules.  Currently there is
    +    only one such line: we build the docs with Asciidoctor right after a
    +    'make clean', meaning that 'make USE_ASCIIDOCTOR=1 doc' always starts
    +    with running 'GIT-VERSION-GEN', which in turn prints the version to
    +    stderr.  A 'sed' command was supposed to remove this version line to
    +    prevent it from triggering that (previously defunct) emptiness check,
    +    but, unfortunately, this command doesn't work as intended, either,
    +    because it leaves the file to be checked intact, but that defunct
    +    emptiness check hid this issue, too...  Furthermore, in the near
    +    future there will be an other line on stderr, because commit
    +    9a71722b4d (Doc: auto-detect changed build flags, 2019-03-17) in the
    +    currently cooking branch 'ma/doc-diff-doc-vs-doctor-comparison' will
    +    print "* new asciidoc flags" at the beginning of both 'make doc'
    +    invokations.
    +
    +    Extend that 'sed' command to remove this line, too, wrap it in a
    +    helper function so the output of both 'make doc' is filtered the same
    +    way, and change its invokation to actually write the logfile to be
    +    checked.
     
         [1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#set
     
    @@ -66,15 +77,32 @@
      +++ b/ci/test-documentation.sh
     @@
      
    + . ${0%/*}/lib.sh
    + 
    ++filter_log () {
    ++	sed -e '/^GIT_VERSION = /d' \
    ++	    -e '/^    \* new asciidoc flags$/d' \
    ++	    "$1"
    ++}
    ++
    + make check-builtins
    + make check-docs
    + 
      # Build docs with AsciiDoc
    - make doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
    +-make doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
     -! test -s stderr.log
    -+cat stderr.log
    ++make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
    ++cat stderr.raw
    ++filter_log stderr.raw >stderr.log
     +test ! -s stderr.log
      test -s Documentation/git.html
      test -s Documentation/git.xml
      test -s Documentation/git.1
    -@@
    + grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
    + 
    +-rm -f stdout.log stderr.log
    ++rm -f stdout.log stderr.log stderr.raw
    + check_unignored_build_artifacts
      
      # Build docs with AsciiDoctor
      make clean
    @@ -82,8 +110,8 @@
     -sed '/^GIT_VERSION = / d' stderr.log
     -! test -s stderr.log
     +make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
    -+sed '/^GIT_VERSION = / d' stderr.raw >stderr.log
    -+cat stderr.log
    ++cat stderr.raw
    ++filter_log stderr.raw >stderr.log
     +test ! -s stderr.log
      test -s Documentation/git.html
      grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
-- 
2.21.0.539.g07239c3a71.dirty

