Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5402FC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3835261B98
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhKPJwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhKPJwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B0EC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n29so36287390wra.11
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qpSVEWdeBv+QvCLRsnCre08fKjJWYLMlMYksu+powQE=;
        b=P0ecvCG9ky3Oa4WAR6I+IL9848DwVCfebARPn2FWbMqKdk5Fvr/l0Tb2BvZA8R4q6e
         I49fH/4mYNVcmXhyUDFc9sdL+bL2nwGiRLtEoYHWVgm/rD3DKJOgcbzJdzTAjTSN3tkG
         mzoE7zym9N3Be7+RXk25j7NlauX6q5SOBSDkQN8tvGfmW9L7R0cTCv4wj5CFRGo6AoGa
         fAwpSTIaCQQTOcvg1MzthZX4WsBjchKTMjuV6wKEx84bI8WO/6D+DKq4Q7nZMvy8ss1T
         oqa1PbT4goQImrEX8X02aHHWWZawOAicVPprYmjbKtYPeQlwHBhNkuv1Ii9kMs90+rcM
         CiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qpSVEWdeBv+QvCLRsnCre08fKjJWYLMlMYksu+powQE=;
        b=AXN78Q6LGshS1MHU0oB+fToY1bxEafp3DzJw6yFjyOSYruUnU/aVUUkFwmYuXJJO1T
         u1k/2es0daowCtFcz3UvtPK2lgbi5i+lzxRKG8U4vdv3JOAAW6b9rKlQNiog2Z2Lco2P
         x+XgW0kOi3NtLJwx8GqQjjxNt93OScu6beduA+SdJvEp+TuLhjOn4fezjJBtFwxc/V6w
         SbMeguFvZQ3f+CwnNIUKzKartczAJbs1zLHV40kPJ8eyX1aMyLXLcO1fWdLlGW7yQ88S
         uDxQ5wKgLxI/AJXUK7j1zEz4osGuj/Wq1sI9PBiu+02yfoyP25a3QXKU41egikYfg3Eh
         lPGA==
X-Gm-Message-State: AOAM533uGuMpdJePBXfegIUwFwn1rbfp5UqfLcEoNfp5/KZ+fgtMw3Ye
        Cr5oiIKa5+GQFUu4gDYAhNQrvpcChCo=
X-Google-Smtp-Source: ABdhPJzxp0B+CZYZle5UtoGDw3ZTkzqrfwrQQ1Sjmdef1gWb0sUZRv31BqWzZRTP2WKm0hz4u/1lSQ==
X-Received: by 2002:adf:eb81:: with SMTP id t1mr7596179wrn.133.1637056180361;
        Tue, 16 Nov 2021 01:49:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm17100126wrs.56.2021.11.16.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:39 -0800 (PST)
Message-Id: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:23 +0000
Subject: [PATCH v4 00/15] diff --color-moved[-ws] speedups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since V3:

 * Patch 1 now allows the user to choose different endpoints for the diff
   perf tests to facilitate testing with different repositories.
 * Fixed the alignment of the perf results column headers in a couple of
   patches.

Changes since V2:

 * Patches 1-3 are new and fix an existing bug.
 * Patch 8 includes Peff's unused parameter fix.
 * Patch 11 has been updated to fix a bug fix in V2.
 * Patch 13 has an expanded commit message explaining a change in behavior
   for lines starting with a form-feed.
 * Updated benchmark results.

The bug fix in patch 3 degrades the performance, but by the end of the
series the timings are the same as V2 - see the range diff.

V2 Cover Letter: Thanks to Ævar and Elijah for their comments, I've reworded
the commit messages, addressed the enum initialization issue in patch 2 (now
3) and added some perf tests.

There are two new patches in this round. The first patch is new and adds the
perf tests suggested by Ævar, the penultimate patch is also new and coverts
the existing code to use a designated initializer.

I've converted the benchmark results in the commit messages to use the new
tests, the percentage changes are broadly similar to the previous results
though I ended up running them on a different computer this time.

V1 cover letter:

The current implementation of diff --color-moved-ws=allow-indentation-change
is considerably slower that the implementation of diff --color-moved which
is in turn slower than a regular diff. This patch series starts with a
couple of bug fixes and then reworks the implementation of diff
--color-moved and diff --color-moved-ws=allow-indentation-change to speed
them up on large diffs. The time to run git diff --color-moved
--no-color-moved-ws v2.28.0 v2.29.0 is reduced by 33% and the time to run
git diff --color-moved --color-moved-ws=allow-indentation-change v2.28.0
v2.29.0 is reduced by 88%. There is a small slowdown for commit sized diffs
with --color-moved - the time to run git log -p --color-moved
--no-color-moved-ws --no-merges -n1000 v2.29.0 is increased by 2% on recent
processors. On older processors these patches reduce the running time in all
cases that I've tested. In general the larger the diff the larger the speed
up. As an extreme example the time to run diff --color-moved
--color-moved-ws=allow-indentation-change v2.25.0 v2.30.0 goes down from 8
minutes to 6 seconds.

Phillip Wood (15):
  diff --color-moved: add perf tests
  diff --color-moved: clear all flags on blocks that are too short
  diff --color-moved: factor out function
  diff --color-moved: rewind when discarding pmb
  diff --color-moved=zebra: fix alternate coloring
  diff --color-moved: avoid false short line matches and bad zerba
    coloring
  diff: simplify allow-indentation-change delta calculation
  diff --color-moved-ws=allow-indentation-change: simplify and optimize
  diff --color-moved: call comparison function directly
  diff --color-moved: unify moved block growth functions
  diff --color-moved: shrink potential moved blocks as we go
  diff --color-moved: stop clearing potential moved blocks
  diff --color-moved-ws=allow-indentation-change: improve hash lookups
  diff: use designated initializers for emitted_diff_symbol
  diff --color-moved: intern strings

 diff.c                           | 431 +++++++++++++------------------
 t/perf/p4002-diff-color-moved.sh |  57 ++++
 t/t4015-diff-whitespace.sh       | 205 ++++++++++++++-
 3 files changed, 437 insertions(+), 256 deletions(-)
 create mode 100755 t/perf/p4002-diff-color-moved.sh


base-commit: 211eca0895794362184da2be2a2d812d070719d3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-981%2Fphillipwood%2Fwip%2Fdiff-color-moved-tweaks-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-981/phillipwood/wip/diff-color-moved-tweaks-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/981

Range-diff vs v3:

  1:  8fc8914a37b !  1:  48ee03cf52a diff --color-moved: add perf tests
     @@ Commit message
          diff --color-moved: add perf tests
      
          Add some tests so we can monitor changes to the performance of the
     -    move detection code. The tests record the performance of a single
     -    large diff and a sequence of smaller diffs.
     +    move detection code. The tests record the performance --color-moved
     +    and --color-moved-ws=allow-indentation-change for a large diff and a
     +    sequence of smaller diffs. The range of commits used for the large
     +    diff can be customized by exporting TEST_REV_A and TEST_REV_B when
     +    running the test.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ t/perf/p4002-diff-color-moved.sh (new)
      +
      +test_perf_default_repo
      +
     -+if ! git rev-parse --verify v2.29.0^{commit} >/dev/null
     ++# The endpoints of the diff can be customized by setting TEST_REV_A
     ++# and TEST_REV_B in the environment when running this test.
     ++
     ++rev="${TEST_REV_A:-v2.28.0}"
     ++if ! rev_a="$(git rev-parse --quiet --verify "$rev")"
     ++then
     ++	skip_all="skipping because '$rev' was not found. \
     ++		  Use TEST_REV_A and TEST_REV_B to set the revs to use"
     ++	test_done
     ++fi
     ++rev="${TEST_REV_B:-v2.29.0}"
     ++if ! rev_b="$(git rev-parse --quiet --verify "$rev")"
      +then
     -+	skip_all='skipping because tag v2.29.0 was not found'
     ++	skip_all="skipping because '$rev' was not found. \
     ++		  Use TEST_REV_A and TEST_REV_B to set the revs to use"
      +	test_done
      +fi
      +
      +GIT_PAGER_IN_USE=1
     -+test_export GIT_PAGER_IN_USE
     ++test_export GIT_PAGER_IN_USE rev_a rev_b
      +
      +test_perf 'diff --no-color-moved --no-color-moved-ws large change' '
     -+	git diff --no-color-moved --no-color-moved-ws v2.28.0 v2.29.0
     ++	git diff --no-color-moved --no-color-moved-ws $rev_a $rev_b
      +'
      +
      +test_perf 'diff --color-moved --no-color-moved-ws large change' '
     -+	git diff --color-moved=zebra --no-color-moved-ws v2.28.0 v2.29.0
     ++	git diff --color-moved=zebra --no-color-moved-ws $rev_a $rev_b
      +'
      +
      +test_perf 'diff --color-moved-ws=allow-indentation-change large change' '
      +	git diff --color-moved=zebra --color-moved-ws=allow-indentation-change \
     -+		v2.28.0 v2.29.0
     ++		$rev_a $rev_b
      +'
      +
      +test_perf 'log --no-color-moved --no-color-moved-ws' '
      +	git log --no-color-moved --no-color-moved-ws --no-merges --patch \
     -+		-n1000 v2.29.0
     ++		-n1000 $rev_b
      +'
      +
      +test_perf 'log --color-moved --no-color-moved-ws' '
      +	git log --color-moved=zebra --no-color-moved-ws --no-merges --patch \
     -+		-n1000 v2.29.0
     ++		-n1000 $rev_b
      +'
      +
      +test_perf 'log --color-moved-ws=allow-indentation-change' '
      +	git log --color-moved=zebra --color-moved-ws=allow-indentation-change \
     -+		--no-merges --patch -n1000 v2.29.0
     ++		--no-merges --patch -n1000 $rev_b
      +'
      +
      +test_done
  2:  e9daed2360c =  2:  47c652716e8 diff --color-moved: clear all flags on blocks that are too short
  3:  658aec2670c =  3:  99e38ba9de9 diff --color-moved: factor out function
  4:  a30f52d7f15 !  4:  9ca71db61ae diff --color-moved: rewind when discarding pmb
     @@ Commit message
          mitigates the performance impact of this commit. After the
          optimization this commit has a negligible impact on performance.
      
     -    Test                                                                 HEAD^               HEAD
     -    ------------------------------------------------------------------------------------------------------------------
     +    Test                                                                  HEAD^               HEAD
     +    -----------------------------------------------------------------------------------------------------------------
          4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.33+0.05)    0.39 (0.34+0.04)  +2.6%
          4002.2: diff --color-moved --no-color-moved-ws large change           0.80 (0.76+0.03)    0.86 (0.82+0.04)  +7.5%
          4002.3: diff --color-moved-ws=allow-indentation-change large change  14.22(14.17+0.04)   19.01(18.93+0.05) +33.7%
  5:  1dde206b7b1 =  5:  56bb69af36e diff --color-moved=zebra: fix alternate coloring
  6:  2717ff500d2 =  6:  10b11526206 diff --color-moved: avoid false short line matches and bad zerba coloring
  7:  f96fa71d53c =  7:  c2e7b347257 diff: simplify allow-indentation-change delta calculation
  8:  324b689c915 !  8:  d7bbc0041e0 diff --color-moved-ws=allow-indentation-change: simplify and optimize
     @@ Commit message
            git diff --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
          by 93% compared to master and simplifies the code.
      
     -    Test                                                                 HEAD^               HEAD
     +    Test                                                                  HEAD^              HEAD
          ---------------------------------------------------------------------------------------------------------------
          4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.35+0.03)   0.38(0.35+0.03)  +0.0%
          4002.2: diff --color-moved --no-color-moved-ws large change           0.86 (0.80+0.06)   0.87(0.83+0.04)  +1.2%
     @@ Commit message
          4002.5: log --color-moved --no-color-moved-ws                         1.32 (1.25+0.07)   1.32(1.24+0.08)  +0.0%
          4002.6: log --color-moved-ws=allow-indentation-change                 1.71 (1.64+0.06)   1.36(1.25+0.10) -20.5%
      
     -    Test                                                                 master              HEAD
     +    Test                                                                  master             HEAD
          ---------------------------------------------------------------------------------------------------------------
          4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.33+0.05)   0.38(0.35+0.03)  +0.0%
          4002.2: diff --color-moved --no-color-moved-ws large change           0.80 (0.75+0.04)   0.87(0.83+0.04)  +8.7%
  9:  f142f33276a =  9:  c3e5dce1910 diff --color-moved: call comparison function directly
 10:  8f3ea865dd3 = 10:  9eb8cecd52a diff --color-moved: unify moved block growth functions
 11:  078c04d4a66 = 11:  35e204e1578 diff --color-moved: shrink potential moved blocks as we go
 12:  618371471a0 = 12:  ec329e7946d diff --color-moved: stop clearing potential moved blocks
 13:  6a8e9a2724d = 13:  6ec94134aaf diff --color-moved-ws=allow-indentation-change: improve hash lookups
 14:  ef98a6e7015 = 14:  d44c5d734c3 diff: use designated initializers for emitted_diff_symbol
 15:  ae78c05f08d ! 15:  5177f669423 diff --color-moved: intern strings
     @@ Commit message
          little change in the performance of 'git log --patch' as the diffs are
          smaller.
      
     -    Test                                                                 HEAD^               HEAD
     +    Test                                                                  HEAD^              HEAD
          ---------------------------------------------------------------------------------------------------------------
          4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38(0.33+0.05)    0.38(0.33+0.05)  +0.0%
          4002.2: diff --color-moved --no-color-moved-ws large change           0.88(0.81+0.06)    0.55(0.50+0.04) -37.5%
     @@ Commit message
          4002.5: log --color-moved --no-color-moved-ws                         1.31(1.22+0.08)    1.29(1.19+0.09)  -1.5%
          4002.6: log --color-moved-ws=allow-indentation-change                 1.32(1.24+0.08)    1.31(1.18+0.13)  -0.8%
      
     -    Test                                                                 master              HEAD
     +    Test                                                                  master             HEAD
          ---------------------------------------------------------------------------------------------------------------
          4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.33+0.05)   0.38(0.33+0.05)  +0.0%
          4002.2: diff --color-moved --no-color-moved-ws large change           0.80 (0.75+0.04)   0.55(0.50+0.04) -31.2%

-- 
gitgitgadget
