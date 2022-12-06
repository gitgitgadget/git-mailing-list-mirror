Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEC6C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 15:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiLFPLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 10:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiLFPKv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 10:10:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF62FC38
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 07:07:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so1020529wmh.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 07:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+YSSZoSXAQMKJynanshzk0AzNteiHT/doRwrP/5Qu8=;
        b=R4PAJRuM/dtWxeGA05PlepHFAGS1Z6opLbPDOySrTKjsRI9HOlw5WM09YzoXRcNO+1
         x72+YBr9w98n/u6gejNx20uWNJtDQVmsxOMWFjxfeaZzcGjSENtc5c9Ju4agszoHY40K
         ZuMP15XLOWh9BFy3TC3Kn2AFR7CuK0vDxDdaNcKSP2IUYM/qphQSOXtvl8iBc1SIAWJw
         +tb+GuzhpjY3XugVTfdfen9+f8XVxXsmbKqumoQpAiO+efrI10+/W5Hj+qNubh0tQZVq
         PJJyDZkSfFT1Ghh5xihr2JoK+idLuzHIbfiCn+h7HMjmYbcZmmNafQyen94W0OXXhqSA
         SfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+YSSZoSXAQMKJynanshzk0AzNteiHT/doRwrP/5Qu8=;
        b=XbLzHOlM64fOJ0LFmZn+Np9mXItSU1mRY9ibezbgiEPoB7ZWplTkSVoiKu4lBfQMTY
         nth7nVTRwRyBUsbtwsMM7qKqkiqoVEqxiUJqS0yiAetNVw2tH48Sd3shS1V8oSd/O8La
         XdrT+i0pI/+5fSAp5KSXO9DWbIpln61ovisI6EdgSdLibS4pwwlc8+mrmseeROPAjGaB
         gA7zNUxS8Mk7pm01ZM5G6D/IquGq88X8yVNDn/rple1UskHuNAMHSqHOYYoXDeaChs3f
         uYg6Kdo+nizI7EoNZl/u0NW4HQyzdqXGR9NGscQGCydLekUjAyju7lRI9v0XEGoSsBeU
         t4Yw==
X-Gm-Message-State: ANoB5pk6o8/uEmoXLbLTr4SdysUN5NxlguALqZeJCwsS2DEWtzNgT0UC
        2oQfXJ+kDQC8GYuPSqtLkmZBwuyda/c=
X-Google-Smtp-Source: AA0mqf50fN8dZ/nLgnYz/vfOMJMofv2aV4k47GCctYVngj4Hi5e1mv6FipcGoGVsD/8ewbq0atjQQg==
X-Received: by 2002:a05:600c:4e8b:b0:3d1:f1d3:8613 with SMTP id f11-20020a05600c4e8b00b003d1f1d38613mr555181wmq.101.1670339269294;
        Tue, 06 Dec 2022 07:07:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh7-20020a05600c3d0700b003cf6e1df4a8sm22020446wmb.15.2022.12.06.07.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:07:48 -0800 (PST)
Message-Id: <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
References: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Dec 2022 15:07:45 +0000
Subject: [PATCH v5 0/2] tests(mingw): avoid super-slow mingw_test_cmp
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Half a year ago, directly after sending a patch to fix a performance
regression due to a mis-use of test_cmp
[https://lore.kernel.org/git/b9203ea247776332e4b6f519aa27d541207adc2f.1659097724.git.gitgitgadget@gmail.com/],
I got curious to see whether Git for Windows had the same issue. And it did
not: it passed t5351 in 22 seconds, even while using test_cmp to compare
pack files
[https://github.com/git-for-windows/git/blob/3922f62f0d5991e9fe0a0817ebf89a91339c7705/t/t5351-unpack-large-objects.sh#L90].
This motivated me to upstream Git for Windows' changes.

Changes since v4:

 * The commit message was rewritten almost completely.

Changes since v3:

 * Fixed the subject of the cover letter (which should have been adjusted in
   v3)
 * Elaborated the paragraph about the historical context of this patch

Changes since v2:

 * Dropped the test helper, using diff --no-index instead.

Changes since v1:

 * Fixed double "with" in the commit message.
 * Renamed the test helper to text-cmp.
 * Made the diff --no-index call more robust by using a double-dash
   separator.

Johannes Schindelin (2):
  t0021: use Windows-friendly `pwd`
  tests(mingw): avoid very slow `mingw_test_cmp`

 t/t0021-conversion.sh   |  4 +--
 t/test-lib-functions.sh | 66 -----------------------------------------
 t/test-lib.sh           |  2 +-
 3 files changed, 3 insertions(+), 69 deletions(-)


base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1309%2Fdscho%2Fmingw-test-cmp-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1309/dscho/mingw-test-cmp-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1309

Range-diff vs v4:

 1:  b38b8fb5a85 = 1:  b38b8fb5a85 t0021: use Windows-friendly `pwd`
 2:  128b1f348d8 ! 2:  6a80fab7e39 tests(mingw): avoid very slow `mingw_test_cmp`
     @@ Metadata
       ## Commit message ##
          tests(mingw): avoid very slow `mingw_test_cmp`
      
     -    It is more performant to run `git diff --no-index` than running the
     -    `mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
     -    Windows uses. And a lot more readable.
     +    When Git's test suite uses `test_cmp`, it is not actually trying to
     +    compare binary files as the name `cmp` would suggest to users familiar
     +    with Unix' tools, but the tests instead verify that actual output
     +    matches the expected text.
      
     -    The original reason why Git's test suite needs the `mingw_test_cmp`
     -    function at all (and why `cmp` is not good enough) is that Git's test
     -    suite is not actually trying to compare binary files when it calls
     -    `test_cmp`, but it compares text files. And those text files can contain
     -    CR/LF line endings depending on the circumstances.
     +    On Unix, `cmp` works well enough for Git's purposes because only Line
     +    Feed characters are used as line endings. However, on Windows, while
     +    most tools accept Line Feeds as line endings, many tools produce
     +    Carriage Return + Line Feed line endings, including some of the tools
     +    used by the test suite (which are therefore provided via Git for Windows
     +    SDK). Therefore, `cmp` would frequently fail merely due to different
     +    line endings.
      
     -    Note: The original fix in the Git for Windows project implemented a test
     -    helper that avoids the overhead of the diff machinery, in favor of
     -    implementing a behavior that is more in line with what `mingw_test_cmp`
     -    does now. This was done to minimize the risk in using something as
     -    complex as the diff machinery to perform something as simple as
     -    determining whether text output is identical to the expected output or
     -    not. This approach has served Git for Windows well for years, but the
     -    attempt to upstream this saw a lot of backlash and distractions during
     -    the review, was disliked by the Git maintainer and was therefore
     -    abandoned. For full details, see the thread at
     -    https://lore.kernel.org/git/pull.1309.git.1659106382128.gitgitgadget@gmail.com/t
     +    To accommodate for that, the `mingw_test_cmp` function was introduced
     +    into Git's test suite to perform a line-by-line comparison that ignores
     +    line endings. This function is a Bash function that is only used on
     +    Windows, everywhere else `cmp` is used.
     +
     +    This is a double whammy because `cmp` is fast, and `mingw_test_cmp` is
     +    slow, even more so on Windows because it is a Bash script function, and
     +    Bash scripts are known to run particularly slowly on Windows due to
     +    Bash's need for the POSIX emulation layer provided by the MSYS2 runtime.
     +
     +    The commit message of 32ed3314c104 (t5351: avoid using `test_cmp` for
     +    binary data, 2022-07-29) provides an illuminating account of the
     +    consequences: On Windows, the platform on which Git could really use all
     +    the help it can get to improve its performance, the time spent on one
     +    entire test script was reduced from half an hour to less than half a
     +    minute merely by avoiding a single call to `mingw_test_cmp` in but a
     +    single test case.
     +
     +    Learning the lesson to avoid shell scripting wherever possible, the Git
     +    for Windows project implemented a minimal replacement for
     +    `mingw_test_cmp` in the form of a `test-tool` subcommand that parses the
     +    input files line by line, ignoring line endings, and compares them.
     +    Essentially the same thing as `mingw_test_cmp`, but implemented in
     +    C instead of Bash. This solution served the Git for Windows project
     +    well, over years.
     +
     +    However, when this solution was finally upstreamed, the conclusion was
     +    reached that a change to use `git diff --no-index` instead of
     +    `mingw_test_cmp` was more easily reviewed and hence should be used
     +    instead.
     +
     +    The reason why this approach was not even considered in Git for Windows
     +    is that in 2007, there was already a motion on the table to use Git's
     +    own diff machinery to perform comparisons in Git's test suite, but it
     +    was dismissed in https://lore.kernel.org/git/xmqqbkrpo9or.fsf@gitster.g/
     +    as undesirable because tests might potentially succeed due to bugs in
     +    the diff machinery when they should not succeed, and those bugs could
     +    therefore hide regressions that the tests try to prevent.
     +
     +    By the time Git for Windows' `mingw-test-cmp` in C was finally
     +    contributed to the Git mailing list, reviewers agreed that the diff
     +    machinery had matured enough and should be used instead.
     +
     +    When the concern was raised that the diff machinery, due to its
     +    complexity, would perform substantially worse than the test helper
     +    originally implemented in the Git for Windows project, a test
     +    demonstrated that these performance differences are well lost within the
     +    100+ minutes it takes to run Git's test suite on Windows.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      

-- 
gitgitgadget
