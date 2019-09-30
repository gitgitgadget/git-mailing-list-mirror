Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C3CA1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfI3Jzf (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33125 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfI3Jze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so13728394wme.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ehaFjOxYUjrmCY/HSlmWwlWOPJWMpU7M8+bRvj9nfTA=;
        b=FsRJzSeSU+hluE5ROk6ZQNsGGrOdEAHNktwbljRtvw28x3ckSG6YHUDfibztf+ORgA
         fn0gRbY+brSGLJN9FSvAiGcXzp3uHSr64l2dbICRbuDahXD1ZTsYj0J+RcAZIsK1HXwE
         iZCBeT5c7JEyIo453XLaeHM41utE5yrHVu7J6R9Lie8BE6gZa9mN7Lu9G5AdlBJ5GGbK
         hDw+pqkns8DWH67sEnOMcP9oDhtTCkyITJA3MTDpFMLLvvKrUDfI2KpNxFc+x5VBGOeH
         uFzU5uclf4CRYgtBAgHSAByVblmMnArbTbnoTJBikbEoDllk+H3JeaoL/XJFkexgXyO6
         3rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ehaFjOxYUjrmCY/HSlmWwlWOPJWMpU7M8+bRvj9nfTA=;
        b=n1cdmlNxuZLSPlcpArkyIyhymhuMOmiNb3tZh8oGuSVQXJ3OJT2PFiqRwVPZ68k0Mx
         oPvFxxKAXdOdiPUOxDeWE4qMWDZ7ameYp5DFj3/YNf/yDMoznPUtKqdqo337JHxqe86j
         lSvzdJGhjVSWIdTz4L8mtq7Bwfjh8FhrjBiCXgWJ0xCapNN1VewnwU+TnPKLYlqf+Dt+
         zcwARl4fno0VP6t2rjHH8u6tPkYv/VqyC+8quOkgiNAFKE4WtnUn+FahpUFZd8hBlr4p
         ndkGhHi9/iWM0xKJHrDIHzwx/qaVp/HHSlUZCbeTE8JP8MV9eXDtiMHyFuYrDaQXiALo
         EjvQ==
X-Gm-Message-State: APjAAAXvZlf/0b7+8rrOnz6XAyIU1ryCAAY9AErRia/IskNMFqpO8xOl
        POtG+wNzTWoV9XErpP2gzwe83/fS
X-Google-Smtp-Source: APXvYqwnJqxODW7Ev0BwQVwFTWK+pcyDNvKQqH5gjVl52h3Ji6MwlyUA+UiN2ftH0moFyxNJ+k5uuA==
X-Received: by 2002:a05:600c:2412:: with SMTP id 18mr15812086wmp.128.1569837331007;
        Mon, 30 Sep 2019 02:55:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm15109136wrt.12.2019.09.30.02.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:30 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:30 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:16 GMT
Message-Id: <pull.288.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/13] ci: include a Visual Studio build & test in our Azure Pipeline
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's Continuous Integration (CI) includes an Azure Pipeline that builds Git
on Linux, macOS and Windows, in the former two cases even in multiple
configurations (using GCC vs clang, 32-bit vs 64-bit, etc). On Windows, we
only build using GCC, using (a subset of) Git for Windows' SDK.

Recently, a patch series made it into Git that re-instates the ability to
generate project files for use with Visual Studio. The idea there being:
contributors can check out a special branch that has those generated files
in one generated commit on top of e.g. Git for Windows' master, allowing the
contributors to build Git in Visual Studio, without the need for downloading
Git for Windows' SDK (which weighs quite a bit: ~600MB download, ~2GB disk
footprint). The tests can then be run from a regular Git for Windows Bash.

This patch series adds that axis to Git's Azure Pipeline: the project files
are generated, MSBuild (which is kind of the command-line equivalent of
Visual Studio's "Build" operation) is used to build Git, and then a
parallelized test job runs the test suite in a Portable Git.

These patches are based on js/visual-studio.

Changes since v1:

 * "While at it", we now also check for overflows when doing that -1 -
   <unsigned> arithmetic.
 * The JUnit-style XML is finalized also in case that the script aborts e.g.
   due to an incorrect number of arguments in a test_expect_success call.

Johannes Schindelin (13):
  push: do not pretend to return `int` from `die_push_simple()`
  msvc: avoid using minus operator on unsigned types
  winansi: use FLEX_ARRAY to avoid compiler warning
  compat/win32/path-utils.h: add #include guards
  msvc: ignore some libraries when linking
  msvc: handle DEVELOPER=1
  msvc: work around a bug in GetEnvironmentVariable()
  vcxproj: only copy `git-remote-http.exe` once it was built
  vcxproj: include more generated files
  test-tool run-command: learn to run (parts of) the testsuite
  tests: let --immediate and --write-junit-xml play well together
  ci: really use shallow clones on Azure Pipelines
  ci: also build and test with MS Visual Studio on Azure Pipelines

 Makefile                                   |   4 +
 azure-pipelines.yml                        | 164 ++++++++++++++++++++-
 builtin/push.c                             |   4 +-
 compat/mingw.c                             |   2 +
 compat/vcbuild/scripts/clink.pl            |  48 +++++-
 compat/win32/path-utils.h                  |   5 +
 compat/winansi.c                           |   2 +-
 config.mak.uname                           |  19 ++-
 contrib/buildsystems/Generators/Vcxproj.pm |   3 +
 read-cache.c                               |   9 +-
 sha1-lookup.c                              |  12 +-
 t/helper/test-run-command.c                | 153 +++++++++++++++++++
 t/test-lib.sh                              |  38 +++--
 13 files changed, 428 insertions(+), 35 deletions(-)


base-commit: aac6ff7b5beeea9bca66ecda6eec60fc1dd447ec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-288%2Fdscho%2Fazure-pipelines-msvc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-288/dscho/azure-pipelines-msvc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/288

Range-diff vs v1:

  1:  4d0b38125a =  1:  4d0b38125a push: do not pretend to return `int` from `die_push_simple()`
  2:  2abe1e1fb0 !  2:  8800320590 msvc: avoid using minus operator on unsigned types
     @@ -40,17 +40,30 @@
          that is both easier to read and that also does not trigger MSVC's
          warning.
      
     +    While at it, we take care of reporting overflows (which are unlikely,
     +    but hey, defensive programming is good!).
     +
     +    We _also_ take pains of casting the unsigned value to signed: otherwise,
     +    the signed operand (i.e. the `-1`) would be cast to unsigned before
     +    doing the arithmetic.
     +
     +    Helped-by: Denton Liu <liu.denton@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/read-cache.c b/read-cache.c
       --- a/read-cache.c
       +++ b/read-cache.c
      @@
     + 	 * we can avoid searching for it.
       	 */
       	if (istate->cache_nr > 0 &&
     - 		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
     +-		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
      -		pos = -istate->cache_nr - 1;
     -+		pos = -1 - istate->cache_nr;
     ++		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0) {
     ++		if (istate->cache_nr > INT_MAX)
     ++			die("overflow: -1 - %u", istate->cache_nr);
     ++		pos = -1 - (int)istate->cache_nr;
     ++	}
       	else
       		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
       
     @@ -67,12 +80,29 @@
       diff --git a/sha1-lookup.c b/sha1-lookup.c
       --- a/sha1-lookup.c
       +++ b/sha1-lookup.c
     +@@
     + 			miv = take2(sha1 + ofs);
     + 			if (miv < lov)
     + 				return -1;
     +-			if (hiv < miv)
     +-				return -1 - nr;
     ++			if (hiv < miv) {
     ++				if (nr > INT_MAX)
     ++					die("overflow: -1 - %"PRIuMAX,
     ++					    (uintmax_t)nr);
     ++				return -1 - (int)nr;
     ++			}
     + 			if (lov != hiv) {
     + 				/*
     + 				 * At this point miv could be equal
      @@
       			lo = mi + 1;
       		mi = lo + (hi - lo) / 2;
       	} while (lo < hi);
      -	return -lo-1;
     -+	return -1 - lo;
     ++	if (nr > INT_MAX)
     ++		die("overflow: -1 - %"PRIuMAX, (uintmax_t)lo);
     ++	return -1 - (int)lo;
       }
       
       int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
  3:  dbd9022ad5 =  3:  8512a3e96d winansi: use FLEX_ARRAY to avoid compiler warning
  4:  6417d6f689 =  4:  0345b08f54 compat/win32/path-utils.h: add #include guards
  5:  d1dee56fcc =  5:  5add01f8ff msvc: ignore some libraries when linking
  6:  c978c76599 =  6:  5c880f923e msvc: handle DEVELOPER=1
  7:  0590514e43 =  7:  1f2245a228 msvc: work around a bug in GetEnvironmentVariable()
  8:  f7d5d1a1bc =  8:  582b299634 vcxproj: only copy `git-remote-http.exe` once it was built
  9:  6adfc63e98 =  9:  38ccf999e7 vcxproj: include more generated files
 10:  ad9ab10ce0 = 10:  24b1c7bff3 test-tool run-command: learn to run (parts of) the testsuite
 11:  99724f6a1e ! 11:  7be13d19e1 tests: let --immediate and --write-junit-xml play well together
     @@ -11,12 +11,34 @@
          Pipelines, where the JUnit-style XML is consumed to present the test
          results in an informative and helpful way.
      
     +    While at it, also handle the `error()` code path.
     +
     +    The only remaining code path that sets `GIT_EXIT_OK` happens whenever
     +    the trash directory could not be set up, i.e. long before the JUnit XML
     +    was written, therefore we should _not_ try to finalize that XML in that
     +    case.
     +
     +    It is tempting to change the `immediate` code path to just hand off to
     +    `error`, simplifying the code in the process. That would, however,
     +    result in a change of behavior (an additional error message) in the test
     +    suite, which is outside of the purview of the current patch series: its
     +    goal is to allow building Git with Visual Studio and testing it with a
     +    portable version of Git for Windows.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/t/test-lib.sh b/t/test-lib.sh
       --- a/t/test-lib.sh
       +++ b/t/test-lib.sh
      @@
     + 
     + error () {
     + 	say_color error "error: $*"
     ++	finalize_junit_xml
     + 	GIT_EXIT_OK=t
     + 	exit 1
     + }
     +@@
       	say_color error "not ok $test_count - $1"
       	shift
       	printf '%s\n' "$*" | sed -e 's/^/#	/'
 12:  29dceaae5e = 12:  bde1e8ef65 ci: really use shallow clones on Azure Pipelines
 13:  ece296922b = 13:  7af1c01a08 ci: also build and test with MS Visual Studio on Azure Pipelines

-- 
gitgitgadget
