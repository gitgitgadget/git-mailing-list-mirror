Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C83C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 10:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJRK7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJRK7K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 06:59:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957C518B08
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b4so22877426wrs.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Qy1F3ROYiTz5l5+vIK8dID3spOVzQy2rta6YGmhn3k=;
        b=RXbNMDjSiGcF6hIM/rrgDUypJhfezKF/avPPKzwx2JXuHaMCiUZh71jvXXBxF2d0r8
         fx1bPwcC65UyJWaOIbao20Lw+RBoNrsE1Ppb++t8saH85maDMcdcL2YltGVUJN5DPaPG
         KznYkPbXsqayF0ae1SYFK7dKmRA3i7Yfsa+syrKvEzi5Q2S51Dd6ZjJrzKpdE86LL+1q
         I843qtEZxsQBnEEYlFGF6A16nOYOlaYBlI4+1j3QgaYo/pFTrtjyH4ykhKy93/yDeAGw
         akgkt5yVKut+NpTkVbvAXe+iyBxN8L19a57tLmiiXID2vVYYsZobtuptl2vR3qUmRUIc
         blaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Qy1F3ROYiTz5l5+vIK8dID3spOVzQy2rta6YGmhn3k=;
        b=V14iECsRMC2C/grd0sM1XmjOBdVx7XO9wsWh+gPT/cVAKEhg2t1ecu6+s2jgG2ahQC
         8B8HZ+N/Mz3i+DKbZ6VjUNC0UaJ/x5RWp+3yXzJ6vqFVsGz7dlgcwYEC8rCk7Cy/GsJJ
         v8gpZW2/ZIUcfmpMKhk+8IICq5ntqnHfQU+zGYk3fj4OD1e1s+ydKSzJn70Ar0C09cr1
         lcffmDJCuB6QStWwCQ4IXe/lR9U95PZ8O/SuE7B6qXOTBc+EmEz14M+1U8IPiINkco3m
         LIctHfkygU5kH2fF0SPcZw+R+eswYYZadWoJcEeuOrNJDlgjhe9OLNNa3gL0EN18sPdl
         7Eqw==
X-Gm-Message-State: ACrzQf0Q35QbjmAKNha8StslC++TTuBRnJ+hoB8gfKkzfT8WNWmKjuyp
        Dyus3nAqWocL6OZSeVm/hmMemxOIsDI=
X-Google-Smtp-Source: AMsMyM5W1YUK9Z41NUBVVYRT4Eum4lWyODqeF3Cna5OG9zlQokOvhJASNcgfk5wuMgwC3nwMQ37lGA==
X-Received: by 2002:adf:fbc7:0:b0:220:6004:18ca with SMTP id d7-20020adffbc7000000b00220600418camr1457639wrs.632.1666090747654;
        Tue, 18 Oct 2022 03:59:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b0022860e8ae7csm10571618wrv.77.2022.10.18.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:59:06 -0700 (PDT)
Message-Id: <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Oct 2022 10:59:00 +0000
Subject: [PATCH v3 0/5] Some fixes and an improvement for using CTest on Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
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

Changes since v2:

 * Enhanced a commit message to clarify how the "cumbersome approach" looks
   like when a developer wishes to pass options to the test scripts in
   Visual Studio.
 * Changed the base branch to ac/fuzzers, to avoid merge conflicts in
   .gitignore.
 * Moved the PANIC check in test-lib.sh so that it is not skipped when the
   file GIT-BUILD-DIR exists.

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
 t/test-lib.sh                       | 10 ++++++++++
 5 files changed, 21 insertions(+), 9 deletions(-)


base-commit: 6713bfc70c4dc6da1fa4084f000b72f5d74fecfb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1320%2Fdscho%2Fctest-on-windows-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1320/dscho/ctest-on-windows-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1320

Range-diff vs v2:

 1:  e00cb37b98a ! 1:  356b2e9a100 cmake: make it easier to diagnose regressions in CTest runs
     @@ Commit message
      
          Like in Git's CI runs, when running the tests in Visual Studio via the
          CTest route, it is cumbersome or at least requires a very unintuitive
     -    approach to pass options to the test scripts.
     +    approach to pass options to the test scripts: the CMakeLists.txt file
     +    would have to be modified, passing the desired options to _all_ test
     +    scripts, and then the CMake Cache would have to be reconfigured before
     +    running the test in question individually. Unintuitive at best, and
     +    opposite to the niceties IDE users expect.
      
          So let's just pass those options by default: This will not clutter any
          output window but the log that is written to a log file will have
     @@ Commit message
      
          While at it, also imitate what the Windows jobs in Git's CI runs do to
          accelerate running the test scripts: pass the `--no-bin-wrappers` and
     -    `--no-chain-lint` options. This makes the test runs noticeably faster
     -    because the `bin-wrappers/` scripts as well as the `chain-lint` code
     -    make heavy use of POSIX shell scripting, which is really, really slow on
     -    Windows due to the need to emulate POSIX behavior via the MSYS2 runtime.
     +    `--no-chain-lint` options.
     +
     +    This makes the test runs noticeably faster because the `bin-wrappers/`
     +    scripts as well as the `chain-lint` code make heavy use of POSIX shell
     +    scripting, which is really, really slow on Windows due to the need to
     +    emulate POSIX behavior via the MSYS2 runtime. In a test by Eric
     +    Sunshine, it added two minutes (!) just to perform the chain-lint task.
     +
     +    The idea of adding a CMake config option (á la `GIT_TEST_OPTS`) was
     +    considered during the development of this patch, but then dropped: such
     +    a setting is global, across _all_ tests, where e.g. `--run=...` would
     +    not make sense. Users wishing to override these new defaults are better
     +    advised running the test script manually, in a Git Bash, with full
     +    control over the command line.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 2:  de7b47a9aa7 = 2:  9faca9d5cbe cmake: copy the merge tools for testing
 3:  f96d5ab484c = 3:  41a8021a4bd add -p: avoid ambiguous signed/unsigned comparison
 4:  22473d6b8f3 ! 4:  5b0c2a150e9 cmake: avoid editing t/test-lib.sh
     @@ Commit message
       ## .gitignore ##
      @@
       /fuzz_corpora
     - /fuzz-pack-headers
     - /fuzz-pack-idx
      +/GIT-BUILD-DIR
       /GIT-BUILD-OPTIONS
       /GIT-CFLAGS
     @@ contrib/buildsystems/CMakeLists.txt: endif()
      
       ## t/test-lib.sh ##
      @@ t/test-lib.sh: then
     - 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
     + 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
     + 	exit 1
       fi
     - GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
     --if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
      +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
      +then
      +	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
     @@ t/test-lib.sh: then
      +		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
      +		;;
      +	esac
     -+elif test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
     - then
     - 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
     - 	exit 1
     ++fi
     + 
     + # Prepend a string to a VAR using an arbitrary ":" delimiter, not
     + # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
 5:  6aaa675301c = 5:  40cf872f483 cmake: increase time-out for a long-running test

-- 
gitgitgadget
