Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007581F454
	for <e@80x24.org>; Thu,  7 Nov 2019 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbfKGRrD (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 12:47:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42166 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730857AbfKGRrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 12:47:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so4014876wrf.9
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 09:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bq9Oo6khlk4ah5qmiaJ2mszJzEqRc3cwZbujG25sYTc=;
        b=hLza8aYs8DZqCwyPQhmQUtywTMxLlOUrikUL5Os5u8BOEeE0M1MszfsulZlIlNU5Ax
         2g6EVwrNRXIqmnuYaUAm8d8AFpXU2L5fgdB3JLcMg/9xO4bTazbkXDwD82mG5qxa0uoP
         hHW09KKDKhmPK/ubC1frkOwELmCHmmV66eANy1W2uH/oIZhpCj8njMcDkCfMuTGm25VR
         Tm7pNoInyRuRrRv0SWkcUaJEsnBAwci67Hua+ubeZ6u6zApGFIg6hgjySpYr2AhUzGQK
         9oIfNCAJixP4PzlCT5SAGk4+euK3U4V0QoskQ8P1ORwrA1JW6LX1c+IGiXqQzgDUPo5E
         ZMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bq9Oo6khlk4ah5qmiaJ2mszJzEqRc3cwZbujG25sYTc=;
        b=Y9uHyTfVKwez+thtwfll52KY5Bki4EGC2EWKl/ycJG/xdcVwXBbMXQN8h9uDp/cNaE
         QV81I73UXHDeXazGorFbAf++I+83j5iNS+tBoRY0JxmaKVvBK/Z7VAMYS2TllM+Oi7Zb
         ySNkQyNCGuhnqDxLrV0PzAlKPGB52NnG2R7ZPUBCFslQb/TfJ1nGUULDm4/Lls2KOzDc
         1b/t1JiITEBctoXTww3ChK4UrtYsxx0AWlr9vntmhU04dX2wpyH1TB26yZoPsAvAoxbC
         N9/s6Je+sDfXphECBNiKAUM2xTJlvO6hdy2uiCDRWCHmxjYDy7JO84MdbOzhBR8kXHeb
         aTlQ==
X-Gm-Message-State: APjAAAV5a2wrD/vXVfH6D5uqVFV+Nn1nn54Ziq4d2N/IeQv+6rD5amL5
        q9VGmvUjZRiliMtEHpMWOl4o4pjM
X-Google-Smtp-Source: APXvYqzZ2P6Tx3YmaCJpWCx+uSx7SlgGP9p60Z6j8JlunUtVhqvp+U535XXFH81+3mrHHH+lPQnvYQ==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr3885211wrw.395.1573148819820;
        Thu, 07 Nov 2019 09:46:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm2963852wrq.22.2019.11.07.09.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 09:46:59 -0800 (PST)
Message-Id: <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
References: <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 17:46:56 +0000
Subject: [PATCH v3 0/2] commit-graph: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ryenus@gmail.com, stolee@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Ryenus, for reporting this problem.

Update in V3:

Based on our discussion, I've added the suggested GIT_PROGRESS_DELAY
environment variable. This allowed the existing tests to stick around with
one exception in the GC tests. The test remains, but we can no longer look
at the commit-graph output.

Derrick Stolee (2):
  progress: create GIT_PROGRESS_DELAY
  commit-graph: use start_delayed_progress()

 Documentation/git.txt   | 4 ++++
 commit-graph.c          | 2 +-
 progress.c              | 8 +++++++-
 t/t5318-commit-graph.sh | 4 ++--
 t/t6500-gc.sh           | 6 ++----
 5 files changed, 16 insertions(+), 8 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-450%2Fderrickstolee%2Fcommit-graph-progress-fix-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-450/derrickstolee/commit-graph-progress-fix-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/450

Range-diff vs v2:

 -:  ---------- > 1:  656dba5afb progress: create GIT_PROGRESS_DELAY
 1:  78bd6bc2c0 ! 2:  3c0c9675e1 commit-graph: use start_delayed_progress()
     @@ -11,9 +11,13 @@
          previous step. But, this is showing up for all users no matter how few
          commits are being added.
      
     -    Now that we changed this method, very fast commands show no progess at
     -    all. This means we need to stop testing for seeing these progress lines
     -    in the test suite.
     +    The tests that check for the progress output have already been updated
     +    to use GIT_PROGRESS_DELAY=0 to force the expected output. However, there
     +    is one test in t6500-gc.sh that uses the test_terminal method. This
     +    mechanism does not preserve the GIT_PROGRESS_DELAY environment variable,
     +    so we need to modify check on the output. We still watch for the
     +    "Enumerating objects" progress but no longer look for "Computing
     +    commit graph generation numbers".
      
          Reported-by: ryenus <ryenus@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ -31,44 +35,16 @@
       					ctx->commits.nr);
       	for (i = 0; i < ctx->commits.nr; i++) {
      
     - diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
     - --- a/t/t5318-commit-graph.sh
     - +++ b/t/t5318-commit-graph.sh
     -@@
     - 	test_line_count = 0 err
     - '
     - 
     --test_expect_success 'commit-graph write force progress on for stderr' '
     --	cd "$TRASH_DIRECTORY/full" &&
     --	git commit-graph write --progress 2>err &&
     --	test_file_not_empty err
     --'
     --
     - test_expect_success 'commit-graph write with the --no-progress option' '
     - 	cd "$TRASH_DIRECTORY/full" &&
     - 	git commit-graph write --no-progress 2>err &&
     -
       diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
       --- a/t/t6500-gc.sh
       +++ b/t/t6500-gc.sh
      @@
     - 	test_line_count = 2 new # There is one new pack and its .idx
     - '
     - 
     --test_expect_success 'gc --no-quiet' '
     --	git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
     --	test_must_be_empty stdout &&
     --	test_line_count = 1 stderr &&
     --	test_i18ngrep "Computing commit graph generation numbers" stderr
     --'
     --
     --test_expect_success TTY 'with TTY: gc --no-quiet' '
     --	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
     --	test_must_be_empty stdout &&
     + test_expect_success TTY 'with TTY: gc --no-quiet' '
     + 	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
     + 	test_must_be_empty stdout &&
      -	test_i18ngrep "Enumerating objects" stderr &&
      -	test_i18ngrep "Computing commit graph generation numbers" stderr
     --'
     --
     ++	test_i18ngrep "Enumerating objects" stderr
     + '
     + 
       test_expect_success 'gc --quiet' '
     - 	git -c gc.writeCommitGraph=true gc --quiet >stdout 2>stderr &&
     - 	test_must_be_empty stdout &&

-- 
gitgitgadget
