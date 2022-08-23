Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE73C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 09:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243570AbiHWJMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbiHWJLr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 05:11:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795B26CF43
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h5so15267343wru.7
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=IF/dmoq0X+XnGg2S2jBSuz1NiJ+alYGXCdZTBMBMLD8=;
        b=GLd/fNBGFGacFFvqqZCNfXRlPPF2DCZm2DIduXQPEz/G5/0KwGWaNJ2W8/4g4E8XK9
         tCXWv+jdpGll+RREf0uCX3qPA2WDTuwdm4ABP+kpWhy+iuRAvf4kLELvdJaNLR6uwy6n
         mQls5CHggfETYr30hmb6V3IO1oeCYP//OJqNPiy9X6pKPY9ixcXME/ZMmstxWCOnSMQL
         eYWi/yPPim5Hv+g9el3Fc5wCmbhR2dAtmm8p/1Q8bGHAta+mlIdpVvnesxWsqYCwiAbl
         tU+9sz739LQ2lLWZrGfiXF5qtkaHhEt3LIIKeuzl32dDhtg/orszz5q9METCXEkoR60g
         kr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=IF/dmoq0X+XnGg2S2jBSuz1NiJ+alYGXCdZTBMBMLD8=;
        b=cRs7amiOW+ZBDwcZcZ76m1jqAh9kwjTwmZkxy5cVRPVOo2FGcKOAXipG7Cex/sbMVD
         XtXmK8961EMGde/Cn0DWBoxWovAerYtFrgpD1dor2zRPt2VPMUiKc/r5o0C8716Je+Qu
         DIfGZJHw8xk7mUJh4pITc8hAFw4qU2cg0Xg7//r/qBmmilIphKzDjUA9YDfe1IR8gu6t
         eDo39YmH/xquTkAdc+1FAeoCvQaS59N0tWiNOC/kV+XV5rHpoV287SVa2FslWywn2wZe
         BO8soWQ0ayTJAPQAxtefB4kOhEq7hpqKCskuasHQ42KgG/SzEtePxFE55qD80oY0l/hI
         LEFw==
X-Gm-Message-State: ACgBeo0ED3SfLnY4o8rlg+mT0PzWkFr21xvNEoc0dzsSrNPFei4xTy1L
        FnKvE64bCrKt9SJBYHtIuUMn+eqwupY=
X-Google-Smtp-Source: AA6agR4qRdp7JlGhmJnlEVJNzVccUOBVlxolfSh5VsoL8iiiF7pEVp4xXyClxjIV8Y9DWaou/5gu4A==
X-Received: by 2002:adf:ed87:0:b0:225:6361:bb13 with SMTP id c7-20020adfed87000000b002256361bb13mr2309048wro.408.1661243465724;
        Tue, 23 Aug 2022 01:31:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d6247000000b0021db7b0162esm13351261wrv.105.2022.08.23.01.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:31:05 -0700 (PDT)
Message-Id: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 08:30:58 +0000
Subject: [PATCH v2 0/5] Some fixes and an improvement for using CTest on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Visual Studio users enjoy support for running the test suite via CTest,
thanks to Git's CMake definition.

In https://github.com/git-for-windows/git/issues/3966, it has been reported
that this does not work out of the box, though, but causes a couple of test
failures instead. These problems are not caught by Git's CI runs because the
vs-tests jobs actually use prove to run the test suite, not CTest.

In addition to fixing these problems, this patch series also addresses a
long-standing gripe I have with the way Git's CMake definition supports
CTest: It edits t/test-lib.sh, which leaves this file eternally modified
(but these modification should never be committed, they refer to a
local-only, configuration-dependent directory).

Note: The signed/unsigned comparison bug in git add -p that is fixed in this
here patch series is a relatively big one, and it merits further
investigation whether there are similar bugs lurking in Git's code base.
However, this is a much bigger project than can be addressed as part of this
patch series, in particular because the analysis would require tools other
than GCC's -Wsign-compare option (which totally misses the instance that is
fixed in this here patch series).

Changes since v1:

 * Clarified why it is a good idea to pass --no-bin-wrappers and
   --no-chain-lint when running on Windows.
 * Clarified why the add -p bug has not been caught earlier.
 * Clarified the scope of this patch series to fix running Git's tests
   within Visual Studio.
 * Increased the time-out for the very slow t7112 test script.
 * The test_chmod was determined to be not only faulty, but unneeded, and
   was dropped.

Johannes Schindelin (5):
  cmake: make it easier to diagnose regressions in CTest runs
  cmake: copy the merge tools for testing
  add -p: avoid ambiguous signed/unsigned comparison
  cmake: avoid editing t/test-lib.sh
  cmake: increase time-out for a long-running test

 .gitignore                          |  1 +
 Makefile                            |  1 +
 add-patch.c                         |  2 +-
 contrib/buildsystems/CMakeLists.txt | 16 ++++++++--------
 t/test-lib.sh                       | 11 ++++++++++-
 5 files changed, 21 insertions(+), 10 deletions(-)


base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1320%2Fdscho%2Fctest-on-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1320/dscho/ctest-on-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1320

Range-diff vs v1:

 1:  9cf14984c0a ! 1:  e00cb37b98a cmake: align CTest definition with Git's CI runs
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    cmake: align CTest definition with Git's CI runs
     +    cmake: make it easier to diagnose regressions in CTest runs
      
     -    In Git's CI runs, the Windows tests are run with `--no-bin-wrappers` and
     -    `--no-chain-lint`, mainly to win back some time caused by the serious
     -    performance penalty paid for the tests relying so heavily on POSIX shell
     -    scripting, which only works by using a POSIX emulation layer.
     +    When a test script fails in Git's test suite, the usual course of action
     +    is to re-run it using options to increase the verbosity of the output,
     +    e.g. `-v` and `-x`.
      
     -    Let's do the same when running the tests, say, in Visual Studio.
     +    Like in Git's CI runs, when running the tests in Visual Studio via the
     +    CTest route, it is cumbersome or at least requires a very unintuitive
     +    approach to pass options to the test scripts.
      
     -    While at it, enable the command trace via `-x` and verbose output via
     -    `-v`, otherwise it would be near impossible to diagnose any problems.
     +    So let's just pass those options by default: This will not clutter any
     +    output window but the log that is written to a log file will have
     +    information necessary to figure out test failures.
     +
     +    While at it, also imitate what the Windows jobs in Git's CI runs do to
     +    accelerate running the test scripts: pass the `--no-bin-wrappers` and
     +    `--no-chain-lint` options. This makes the test runs noticeably faster
     +    because the `bin-wrappers/` scripts as well as the `chain-lint` code
     +    make heavy use of POSIX shell scripting, which is really, really slow on
     +    Windows due to the need to emulate POSIX behavior via the MSYS2 runtime.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 2:  86ab58b6508 = 2:  de7b47a9aa7 cmake: copy the merge tools for testing
 3:  79abfa82c32 < -:  ----------- tests: explicitly skip `chmod` calls on Windows
 4:  4d24a4345ba ! 3:  f96d5ab484c add -p: avoid ambiguous signed/unsigned comparison
     @@ Commit message
          Let's avoid that by converting the unsigned bit explicitly to a signed
          integer.
      
     +    Note: This is a long-standing bug in the Visual C build of Git, but it
     +    has never been caught because t3701 is skipped when `NO_PERL` is set,
     +    which is the case in the `vs-test` jobs of Git's CI runs.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## add-patch.c ##
 5:  c7fc5a4ee4c = 4:  22473d6b8f3 cmake: avoid editing t/test-lib.sh
 -:  ----------- > 5:  6aaa675301c cmake: increase time-out for a long-running test

-- 
gitgitgadget
