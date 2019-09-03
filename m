Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF26B1F4B9
	for <e@80x24.org>; Tue,  3 Sep 2019 18:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfICSzb (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:55:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33134 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICSza (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:55:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id t11so2191483plo.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPLCJfiuWRbqEwMoVNANluME56ftVG+84Uxr2cSKl+A=;
        b=ZO6OZCs/iYavu8AoBkgYjJ3dW5yT+zPi/bB8s3y923NIGOLO0eKBUUZKuySvbThfyz
         19HwVeRItjMf4vwOF1zhpN4kixciYKA9nFu62Wi1uvEyV190Btavqp98anUXS1hlGDcM
         YawtnHda7Sa2QqwZla5zhmaQGR15mENLCA9WZev7utxn0cio/HM0hPPbn+7+Z5xgYpQD
         h9EnJwJpraSZ8G2cHy/q9Pfp7y0jrk87H9T8a+AQL1CeN1w/e8oZhO4+CdRPco22iatM
         av8l6UekW0F6HODPb+kFv66jD0qonJ7FDhzs0J/0GT5KXCpSFL7Fc1tqLczbeRa0WNzM
         K5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPLCJfiuWRbqEwMoVNANluME56ftVG+84Uxr2cSKl+A=;
        b=Piipi+Kvlr2AVQvtpJ3EHZbStb3Hc1+bKV4w68/NSip14vK4Hvafn9FIsgcPMG2Sy6
         PxTMV17uubagYKz8dZgacSOnQwyYm/UuU8uZh5PWncEAgFtVw6eN7CtbT6HlNxY8mzVk
         7RdrXr8BQVX40oiCn4qwkjFpr6+itRuy99gauT2K87ZX/hGS+Jzcu3zmVecJdugJF8zm
         DS4GZJlKg/K1PU330jK8tMad76qykV4Zdu7YREW3ksLJym0zr8U8BzHERhbMHbkfTIyN
         UE7ad+DXEVyIVCUn5F4YdYeaOO8wrVu3OUYk2vsTswLs0VOIcyEMo5Q/x1ZGo7AyXpqD
         Nexw==
X-Gm-Message-State: APjAAAWbQKRFzeuFM2I0MJ30uSngaG5FMpvDPZ3m+pGjOyP42oZS2GWI
        dsh8uDolr1F1uh2E4CdmEe0=
X-Google-Smtp-Source: APXvYqw7B0gY73N1htiMRwId3voJDY28ZS+h0lRNzybQqNiwLq+ZJu3Mq9daybrk1LDO8Wp7joC9ow==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr37239851plb.68.1567536929600;
        Tue, 03 Sep 2019 11:55:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id 136sm21283855pfz.123.2019.09.03.11.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Sep 2019 11:55:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 0/4] Warn about git-filter-branch usage and avoid it
Date:   Tue,  3 Sep 2019 11:55:20 -0700
Message-Id: <20190903185524.13467-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.39.gf92d9de5c3
In-Reply-To: <20190828002210.8862-1-newren@gmail.com>
References: <20190828002210.8862-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been about 5 days with no further feedback, other than some timings
from Dscho for Windows showing that my fixes help there too.  So, I did
one last re-read, made a couple small wording tweaks, and am resending as
ready for inclusion.

Changes since v4:
  * Included the windows timings from Dscho in the commit messages for
    the first two perf patches
  * A few slight wording tweaks to the manpage

Elijah Newren (4):
  t6006: simplify and optimize empty message test
  t3427: accelerate this test by using fast-export and fast-import
  Recommend git-filter-repo instead of git-filter-branch
  t9902: use a non-deprecated command for testing

 Documentation/git-fast-export.txt   |   6 +-
 Documentation/git-filter-branch.txt | 273 +++++++++++++++++++++++++---
 Documentation/git-gc.txt            |  17 +-
 Documentation/git-rebase.txt        |   3 +-
 Documentation/git-replace.txt       |  10 +-
 Documentation/git-svn.txt           |  10 +-
 Documentation/githooks.txt          |  10 +-
 contrib/svn-fe/svn-fe.txt           |   4 +-
 git-filter-branch.sh                |  13 ++
 t/t3427-rebase-subtree.sh           |  24 ++-
 t/t6006-rev-list-format.sh          |   5 +-
 t/t9902-completion.sh               |  12 +-
 12 files changed, 310 insertions(+), 77 deletions(-)

Range-diff:
1:  7ddbeea2ca ! 1:  ccea0e5846 t6006: simplify and optimize empty message test
    @@ Commit message
         Despite only being one piece of the 71st test and there being 73 tests
         overall, this small change to just this one test speeds up the overall
         execution time of t6006 (as measured by the best of 3 runs of `time
    -    ./t6006-rev-list-format.sh`) by about 11% on Linux and by 13% on
    -    Mac.
    +    ./t6006-rev-list-format.sh`) by about 11% on Linux, 13% on Mac, and
    +    about 15% on Windows.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
2:  e1e63189c1 ! 2:  6d73135006 t3427: accelerate this test by using fast-export and fast-import
    @@ Commit message
     
         fast-export and fast-import can easily handle the simple rewrite that
         was being done by filter-branch, and should be significantly faster on
    -    systems with a slow fork.  Timings from before and after on two laptops
    -    that I have access to (measured via `time ./t3427-rebase-subtree.sh`,
    -    i.e. including everything in this test -- not just the filter-branch or
    -    fast-export/fast-import pair):
    +    systems with a slow fork.  Timings from before and after on a few
    +    laptops that I or others measured on (measured via `time
    +    ./t3427-rebase-subtree.sh`, i.e. including everything in this test --
    +    not just the filter-branch or fast-export/fast-import pair):
     
    -       Linux:  4.305s -> 3.684s (~17% speedup)
    -       Mac:   10.128s -> 7.038s (~30% speedup)
    +       Linux:    4.305s -> 3.684s (~17% speedup)
    +       Mac:     10.128s -> 7.038s (~30% speedup)
    +       Windows:  1m 37s -> 1m 17s (~26% speedup)
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
3:  ed6505584f ! 3:  2f225c8697 Recommend git-filter-repo instead of git-filter-branch
    @@ Documentation/git-filter-branch.txt: warned.
     +document or provide to a coworker, who then runs them on a different OS
     +where the same commands are not working/tested (some examples in the
     +git-filter-branch manpage are also affected by this).  BSD vs. GNU
    -+userland differences can really bite.  If you're lucky, you get ugly
    -+error messages spewed.  But just as likely, the commands either don't do
    -+the filtering requested, or silently corrupt making some unwanted
    -+change.  The unwanted change may only affect a few commits, so it's not
    -+necessarily obvious either.  (The fact that problems won't necessarily
    -+be obvious means they are likely to go unnoticed until the rewritten
    -+history is in use for quite a while, at which point it's really hard to
    -+justify another flag-day for another rewrite.)
    ++userland differences can really bite.  If lucky, error messages are
    ++spewed.  But just as likely, the commands either don't do the filtering
    ++requested, or silently corrupt by making some unwanted change.  The
    ++unwanted change may only affect a few commits, so it's not necessarily
    ++obvious either.  (The fact that problems won't necessarily be obvious
    ++means they are likely to go unnoticed until the rewritten history is in
    ++use for quite a while, at which point it's really hard to justify
    ++another flag-day for another rewrite.)
     +
     +* Filenames with spaces are often mishandled by shell snippets since
     +they cause problems for shell pipelines.  Not everyone is familiar with
     +find -print0, xargs -0, git-ls-files -z, etc.  Even people who are
    -+familiar with these may assume such needs are not relevant because
    ++familiar with these may assume such flags are not relevant because
     +someone else renamed any such files in their repo back before the person
    -+doing the filtering joined the project.  And, often, even those familiar
    -+with handling arguments with spaces my not do so just because they
    ++doing the filtering joined the project.  And often, even those familiar
    ++with handling arguments with spaces may not do so just because they
     +aren't in the mindset of thinking about everything that could possibly
     +go wrong.
     +
     +* Non-ascii filenames can be silently removed despite being in a desired
    -+directory.  The desire to select paths to keep often use pipelines like
    ++directory.  Keeping only wanted paths is often done using pipelines like
     +`git ls-files | grep -v ^WANTED_DIR/ | xargs git rm`.  ls-files will
    -+only quote filenames if needed so folks may not notice that one of the
    -+files didn't match the regex, again until it's much too late.  Yes,
    -+someone who knows about core.quotePath can avoid this (unless they have
    -+other special characters like \t, \n, or "), and people who use ls-files
    -+-z with something other than grep can avoid this, but that doesn't mean
    -+they will.
    ++only quote filenames if needed, so folks may not notice that one of the
    ++files didn't match the regex (at least not until it's much too late).
    ++Yes, someone who knows about core.quotePath can avoid this (unless they
    ++have other special characters like \t, \n, or "), and people who use
    ++ls-files -z with something other than grep can avoid this, but that
    ++doesn't mean they will.
     +
     +* Similarly, when moving files around, one can find that filenames with
     +non-ascii or special characters end up in a different directory, one
    @@ Documentation/git-filter-branch.txt: warned.
     +the same name, no warning or error is provided; git-filter-branch simply
     +overwrites each tag in some undocumented pre-defined order resulting in
     +only one tag at the end.  (A git-filter-branch regression test requires
    -+this.)
    ++this surprising behavior.)
     +
    -+Also, the poor performance of git-filter-branch often leads to safety issues:
    ++Also, the poor performance of git-filter-branch often leads to safety
    ++issues:
     +
     +* Coming up with the correct shell snippet to do the filtering you want
     +is sometimes difficult unless you're just doing a trivial modification
4:  ca8e124cb3 = 4:  048eba375b t9902: use a non-deprecated command for testing
-- 
2.23.0.39.gf92d9de5c3

