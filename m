Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439D0C433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 14:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiKNOHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 09:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbiKNOHM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 09:07:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230852B1BC
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 06:07:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w14so18439701wru.8
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 06:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLjI6oinCxRnSfkLM2spZOaFHLnCuHHq5dVHdK+m0m8=;
        b=iOsxwDgCLy64UHfa4rsWxQhrFTOf7WCGUEQQdVLrD1szTp4S73Wum2BqbpkwfV0HKT
         GTAfgzi4+jAe6xqyLQCqe7aJx+3ettUkkwRc+GvFtgPd+z5+TK6wBL+Pc6Abto8N0k2E
         Cq31fLnH3NWeKI9WOvhrYB8A1qf0DFDhgEBlOt/L4u/+9BVWMvdZWhv/n9ChMagPObc2
         B2USQ9hCSQNKZ8WpbdVLKtZPwIApPcQGKif+lwUMEaT+ii+Fd2H/KRsZVjQk3vdgvMKO
         EMTDOHG9+diZb79gOYYl1B4sZ5gEvL1Ob6j0skO+1Kd5lqb4c21iwTcAHbItYx2Hq8KR
         MLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLjI6oinCxRnSfkLM2spZOaFHLnCuHHq5dVHdK+m0m8=;
        b=effyg8skONkLdXbMTtMWv9Yo2V2/oadXL7diyaDhSZPMgrSP2p/CSQzBKqga25nAo4
         k2w1pCxdFaBnKc0doMkC22h1Dy37uAdfhGEietXiC/sQb20xHw7ZdEMTIm1FXRpUuBW8
         A49JFiahL/CNruz5OFhBhMOtHc1OpGVhJDFUnQXwUYhmokY/vl6Fpkx03duZbKF0tGgr
         GT2dYzzisDEIgtdjVHLoIPOgf6ZtursN2bk5LZJurRiGvGg6J/19DDT7pLiGpzVnNRAC
         mgfGSRWcQ4sbnmmm2VFokHyEg4jg0Hy4ayW1SXhZDc6Sz77aPYbo8h2zioJm+LXYtm6F
         Sn9A==
X-Gm-Message-State: ANoB5plAW3CX0cdc6yGxL/ccSdCAaI64EplpVNDQ+DnNwYF+Tj8UDZ96
        wiHYJg5cVKMM2DwRjZArNx2oP3wbijY=
X-Google-Smtp-Source: AA0mqf52kcQJT1habvBC39zFvGWFPRdYI6ta0JfJGfQMLJTCjIuKTD4Yd6aMp0lS4JMIwrbNXoHqhQ==
X-Received: by 2002:a5d:4ecf:0:b0:236:5655:1393 with SMTP id s15-20020a5d4ecf000000b0023656551393mr7655104wrv.626.1668434815171;
        Mon, 14 Nov 2022 06:06:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iz7-20020a05600c554700b003cf894dbc4fsm12768866wmb.25.2022.11.14.06.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:06:53 -0800 (PST)
Message-Id: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
References: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Nov 2022 14:06:50 +0000
Subject: [PATCH v4 0/2] tests(mingw): avoid super-slow mingw_test_cmp
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

A few months ago, directly after sending a patch to fix a performance
regression due to a mis-use of test_cmp
[https://lore.kernel.org/git/b9203ea247776332e4b6f519aa27d541207adc2f.1659097724.git.gitgitgadget@gmail.com/],
I got curious to see whether Git for Windows had the same issue. And it did
not: it passes t5351 in 22 seconds, even while using test_cmp to compare
pack files
[https://github.com/git-for-windows/git/blob/3922f62f0d5991e9fe0a0817ebf89a91339c7705/t/t5351-unpack-large-objects.sh#L90].

The explanation is of course that Git for Windows uses a test helper for
test_cmp that is written in C, instead of the Bash function. And C is much
faster than a Bash function, especially on Windows. This is especially sad
when said Bash code is only used on Windows. So I originally had pulled out
this helper from the years-long effort to let Git for Windows use BusyBox'
ash to run the test suite. The result was a single-patch contribution of a
change that had been in Git for Windows since June 2018. Unfortunately, this
tried-and-tested code was rejected by the Git maintainer.

Let's fall back to the next-best solution: git diff --no-index, which the
Git maintainer seems to like. The downside is that the diff machinery does a
lot more than a simple cmp clone, and therefore a lot more things can go
wrong that might make it look like a test case is failing when the fault is
somewhere else entirely. There is one way to find out whether this is a
valid concern.

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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1309%2Fdscho%2Fmingw-test-cmp-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1309/dscho/mingw-test-cmp-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1309

Range-diff vs v3:

 1:  b38b8fb5a85 = 1:  b38b8fb5a85 t0021: use Windows-friendly `pwd`
 2:  a7f4265ceb2 ! 2:  128b1f348d8 tests(mingw): avoid very slow `mingw_test_cmp`
     @@ Commit message
          `mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
          Windows uses. And a lot more readable.
      
     -    Note: Earlier attempts at fixing this involved a test helper that avoids
     -    the overhead of the diff machinery, in favor of implementing a behavior
     -    that is more in line with what `mingw_test_cmp` does now, but that
     -    attempt saw a lot of backlash and distractions during review and was
     -    therefore abandoned.
     +    The original reason why Git's test suite needs the `mingw_test_cmp`
     +    function at all (and why `cmp` is not good enough) is that Git's test
     +    suite is not actually trying to compare binary files when it calls
     +    `test_cmp`, but it compares text files. And those text files can contain
     +    CR/LF line endings depending on the circumstances.
     +
     +    Note: The original fix in the Git for Windows project implemented a test
     +    helper that avoids the overhead of the diff machinery, in favor of
     +    implementing a behavior that is more in line with what `mingw_test_cmp`
     +    does now. This was done to minimize the risk in using something as
     +    complex as the diff machinery to perform something as simple as
     +    determining whether text output is identical to the expected output or
     +    not. This approach has served Git for Windows well for years, but the
     +    attempt to upstream this saw a lot of backlash and distractions during
     +    the review, was disliked by the Git maintainer and was therefore
     +    abandoned. For full details, see the thread at
     +    https://lore.kernel.org/git/pull.1309.git.1659106382128.gitgitgadget@gmail.com/t
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      

-- 
gitgitgadget
