Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39681F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEHANI (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHANI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so781482wmb.5
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yrOgDzyurX4GUDMVf/Wttc+5D8Qt16ESJiAkNo+A+Y=;
        b=JvuVd93a2Ptgc9oY2hF/QE9Tvn35nU7BrWkqN08U348RBsKT3wfwAXdaQIz7mMupAk
         Y5vGu9GgRieGcvVraZulWUg4w0B96EcK2aS9c2XrCoFn5+ZlY7lTal6paMYJzWex/OTN
         3cqTh+eXHM16ExHyaQqeKZs1g2gvbQCth4X1Z4vYr4lAOqJ0X6fb7FAURc3fKeHoWFis
         KojvDgudW5JVUQkJ17hYJB/Gw/MxiqfA+x6fo1a5NgVx4+IGP+lhqqwZlO/Z6D+2+VGr
         5rJjqyjfA2H0ezWIH9SCWOhGhWeQRZcdknRL9g4EpqBZT5M9u3uNcvN2la97J5g0oLZ6
         nWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yrOgDzyurX4GUDMVf/Wttc+5D8Qt16ESJiAkNo+A+Y=;
        b=l6a7T6+qfWYXzB7LPnLv6YCTeNlU6dZwrq6/zLcNf/V3J6f8SsPEqA5IM+5ZyMb8ky
         AE+cvhzLNDrIzt5Euk8CAAqDl2rR4UO25iGFWqyR2E+vT5z6lrMF/NzYTcRPeFGRshFp
         MU2IEJLyqWIPEI8WIIqZmB6Pseu86w90xEFAhaGIFB3ZLs2Dg/6qZuK4mzE9NPWjqBAi
         /rbINSsJZ+JA8eBDA+mIp4qo1B5l6ppvDtACZYH+RNS5bSyn7CzTm/dqvCX9dKu0ApJW
         MLP46dUAnjBDUonnalYweZGY0TPP2OdlTA6NfNJPmrnOvnQG0t/Axs1VHu4kX8jQPv4z
         g4Gg==
X-Gm-Message-State: APjAAAXB0d+5wV1D+/ywOq28SdtM915VwxS29ZtLxP5w1T5hAjOIICPP
        Fa9UZI5jXe3zZOCgFBuc5yL3oVR4lhU=
X-Google-Smtp-Source: APXvYqw+d2fdo23Hb6Ihs+9X5DRn01vL69qsiqxZF+wffJQc9Ez87+Dh0SFRwGm49k2oWaDjDcC2Iw==
X-Received: by 2002:a7b:c04b:: with SMTP id u11mr674964wmc.95.1557274385560;
        Tue, 07 May 2019 17:13:05 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC WIP PATCH v8 00/13] learn --keep-base & more
Date:   Wed,  8 May 2019 02:12:39 +0200
Message-Id: <20190508001252.15752-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a WIP series I have that I figured I'd send out as-is for
comment since Junio said he'd be merging dl/rebase-i-keep-base down.

So I wanted to test it, and as seen early in this series in 3/13 and
4/13 we had significant blindspots in our tests, i.e. there were no
tests for whether --no-ff bypassed the amended logic as it should.

As seen from those tests we may have some bugs here, either existing
or new, needs more poking at it. We are also inconsistent with whether
a --no-ff yields a different SHA-1 after the forced rebase, surely it
always should, no?

Then in 9/13 and 10/13 I re-added the incomplete patches I had in
https://public-inbox.org/git/20190221214059.9195-1-avarab@gmail.com/
to see if my tests passed with Denton's --fork-point code, they
do. Yay!

Left them there because I was wondering if I needed to port some/all
of the tests over, and maybe amend a commit message to reword some of
my findings in
https://public-inbox.org/git/871s3z6a4q.fsf@evledraar.gmail.com/

Then I have 11/13 and 12/13 which seem pretty sensible to me as-is,
and finally I wanted --preserve-merges and --rebase-merges to also
benefit from this logic, so 13/13 is a WIP patch for that. The code
should be done (although maybe there's a better way to do it...), but
it needs a better commit message & tests.

Denton Liu (6):
  t3431: add rebase --fork-point tests
  t3432: test rebase fast-forward behavior
  rebase: refactor can_fast_forward into goto tower
  rebase: fast-forward --onto in more cases
  rebase: fast-forward --fork-point in more cases
  rebase: teach rebase --keep-base

Ævar Arnfjörð Bjarmason (7):
  t3432: distinguish "noop-same" v.s. "work-same" in "same head" tests
  t3432: test for --no-ff's interaction with fast-forward
  rebase tests: test linear branch topology
  rebase: don't rebase linear topology with --fork-point
  rebase: eliminate side-effects from can_fast_forward()
  rebase: add a should_fast_forward() utility function
  WIP: can_fast_forward() support for --preserve-merges and
    --rebase-merges

 Documentation/git-rebase.txt           |  30 +++++-
 builtin/rebase.c                       | 117 +++++++++++++++++-----
 contrib/completion/git-completion.bash |   2 +-
 t/t3400-rebase.sh                      |   2 +-
 t/t3404-rebase-interactive.sh          |   2 +-
 t/t3416-rebase-onto-threedots.sh       |  57 +++++++++++
 t/t3421-rebase-topology-linear.sh      |  44 +++++++++
 t/t3431-rebase-fork-point.sh           |  57 +++++++++++
 t/t3432-rebase-fast-forward.sh         | 128 +++++++++++++++++++++++++
 9 files changed, 407 insertions(+), 32 deletions(-)
 create mode 100755 t/t3431-rebase-fork-point.sh
 create mode 100755 t/t3432-rebase-fast-forward.sh

Range-diff:
 1:  aececab3b4 =  1:  0c931f6275 t3431: add rebase --fork-point tests
 2:  238bf1db83 =  2:  b5bdca58db t3432: test rebase fast-forward behavior
 -:  ---------- >  3:  5d057a1240 t3432: distinguish "noop-same" v.s. "work-same" in "same head" tests
 -:  ---------- >  4:  06084d9891 t3432: test for --no-ff's interaction with fast-forward
 3:  526c03b5a9 =  5:  f5a2172398 rebase: refactor can_fast_forward into goto tower
 4:  10572de16f !  6:  ea90934368 rebase: fast-forward --onto in more cases
    @@ -146,13 +146,13 @@
      +++ b/t/t3432-rebase-fast-forward.sh
     @@
      changes='our and their changes'
    - test_rebase_same_head success --onto B B
    - test_rebase_same_head success --onto B... B
    --test_rebase_same_head failure --onto master... master
    -+test_rebase_same_head success --onto master... master
    - test_rebase_same_head failure --fork-point --onto B B
    - test_rebase_same_head failure --fork-point --onto B... B
    --test_rebase_same_head failure --fork-point --onto master... master
    -+test_rebase_same_head success --fork-point --onto master... master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    +-test_rebase_same_head failure work same success work diff --onto master... master
    ++test_rebase_same_head success noop same success work diff --onto master... master
    + test_rebase_same_head failure work same success work diff --fork-point --onto B B
    + test_rebase_same_head failure work same success work diff --fork-point --onto B... B
    +-test_rebase_same_head failure work same success work diff --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work diff --fork-point --onto master... master
      
      test_done
 5:  446985193c !  7:  46660cefe0 rebase: fast-forward --fork-point in more cases
    @@ -55,35 +55,45 @@
      --- a/t/t3432-rebase-fast-forward.sh
      +++ b/t/t3432-rebase-fast-forward.sh
     @@
    - test_rebase_same_head success --onto master... master
    - test_rebase_same_head success --no-fork-point
    - test_rebase_same_head success --fork-point master
    --test_rebase_same_head failure --fork-point --onto B B
    --test_rebase_same_head failure --fork-point --onto B... B
    -+test_rebase_same_head success --fork-point --onto B B
    -+test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    + }
      
    - test_expect_success 'add work to side' '
    -@@
    - test_rebase_same_head success --onto master... master
    - test_rebase_same_head success --no-fork-point
    - test_rebase_same_head success --fork-point master
    --test_rebase_same_head failure --fork-point --onto B B
    --test_rebase_same_head failure --fork-point --onto B... B
    -+test_rebase_same_head success --fork-point --onto B B
    -+test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    + changes='no changes'
    +-test_rebase_same_head success work same success work same
    ++test_rebase_same_head success noop same success work same
    + test_rebase_same_head success noop same success noop-force same master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    + test_rebase_same_head success noop same success noop-force same --onto master... master
    + test_rebase_same_head success noop same success noop-force same --no-fork-point
    +-test_rebase_same_head success work same success work same --fork-point master
    +-test_rebase_same_head failure noop same success work diff --fork-point --onto B B
    +-test_rebase_same_head failure work same success work diff --fork-point --onto B... B
    +-test_rebase_same_head success work same success work same --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work same --fork-point master
    ++test_rebase_same_head success noop same success work diff --fork-point --onto B B
    ++test_rebase_same_head success noop same success work diff --fork-point --onto B... B
    ++test_rebase_same_head success noop same success work same --fork-point --onto master... master
      
    - test_expect_success 'add work to upstream' '
    -@@
    - test_rebase_same_head success --onto B B
    - test_rebase_same_head success --onto B... B
    - test_rebase_same_head success --onto master... master
    --test_rebase_same_head failure --fork-point --onto B B
    --test_rebase_same_head failure --fork-point --onto B... B
    -+test_rebase_same_head success --fork-point --onto B B
    -+test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    + test_expect_success 'add work same  to side' '
    + 	test_commit E
    + '
    + 
    + changes='our changes'
    +-test_rebase_same_head success work same success work same
    ++test_rebase_same_head success noop same success work same
    + test_rebase_same_head success noop same success noop-force same master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    + test_rebase_same_head success noop same success noop-force same --onto master... master
    + test_rebase_same_head success noop same success noop-force same --no-fork-point
    +-test_rebase_same_head success work same success work same --fork-point master
    +-test_rebase_same_head failure work same success work diff --fork-point --onto B B
    +-test_rebase_same_head failure work same success work diff --fork-point --onto B... B
    +-test_rebase_same_head success work same success work same --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work same --fork-point master
    ++test_rebase_same_head success noop same success work diff --fork-point --onto B B
    ++test_rebase_same_head success noop same success work diff --fork-point --onto B... B
    ++test_rebase_same_head success noop same success work same --fork-point --onto master... master
      
    - test_done
    + test_expect_success 'add work same  to upstream' '
    + 	git checkout master &&
 6:  88096495c2 !  8:  a59ff76704 rebase: teach rebase --keep-base
    @@ -149,8 +149,8 @@
      			 N_("allow pre-rebase hook to run")),
      		OPT_NEGBIT('q', "quiet", &options.flags,
     @@
    - 		usage_with_options(builtin_rebase_usage,
    - 				   builtin_rebase_options);
    + 		warning(_("git rebase --preserve-merges is deprecated. "
    + 			  "Use --rebase-merges instead."));
      
     +	if (keep_base) {
     +		if (options.onto_name)
    @@ -296,46 +296,46 @@
      --- a/t/t3432-rebase-fast-forward.sh
      +++ b/t/t3432-rebase-fast-forward.sh
     @@
    - test_rebase_same_head success --onto B B
    - test_rebase_same_head success --onto B... B
    - test_rebase_same_head success --onto master... master
    -+test_rebase_same_head success --keep-base master
    -+test_rebase_same_head success --keep-base
    - test_rebase_same_head success --no-fork-point
    -+test_rebase_same_head success --keep-base --no-fork-point
    - test_rebase_same_head success --fork-point master
    - test_rebase_same_head success --fork-point --onto B B
    - test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    -+test_rebase_same_head success --fork-point --keep-base master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    + test_rebase_same_head success noop same success noop-force same --onto master... master
    ++test_rebase_same_head success noop same success noop-force same --keep-base master
    ++test_rebase_same_head success noop same success noop-force same --keep-base
    + test_rebase_same_head success noop same success noop-force same --no-fork-point
    ++test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
    + test_rebase_same_head success noop same success work same --fork-point master
    + test_rebase_same_head success noop same success work diff --fork-point --onto B B
    + test_rebase_same_head success noop same success work diff --fork-point --onto B... B
    + test_rebase_same_head success noop same success work same --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work same --keep-base --keep-base master
      
    - test_expect_success 'add work to side' '
    + test_expect_success 'add work same  to side' '
      	test_commit E
     @@
    - test_rebase_same_head success --onto B B
    - test_rebase_same_head success --onto B... B
    - test_rebase_same_head success --onto master... master
    -+test_rebase_same_head success --keep-base master
    -+test_rebase_same_head success --keep-base
    - test_rebase_same_head success --no-fork-point
    -+test_rebase_same_head success --keep-base --no-fork-point
    - test_rebase_same_head success --fork-point master
    - test_rebase_same_head success --fork-point --onto B B
    - test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    -+test_rebase_same_head success --fork-point --keep-base master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    + test_rebase_same_head success noop same success noop-force same --onto master... master
    ++test_rebase_same_head success noop same success noop-force same --keep-base master
    ++test_rebase_same_head success noop same success noop-force same --keep-base
    + test_rebase_same_head success noop same success noop-force same --no-fork-point
    ++test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
    + test_rebase_same_head success noop same success work same --fork-point master
    + test_rebase_same_head success noop same success work diff --fork-point --onto B B
    + test_rebase_same_head success noop same success work diff --fork-point --onto B... B
    + test_rebase_same_head success noop same success work same --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work same --fork-point --keep-base master
      
    - test_expect_success 'add work to upstream' '
    + test_expect_success 'add work same  to upstream' '
      	git checkout master &&
     @@
    - test_rebase_same_head success --onto B B
    - test_rebase_same_head success --onto B... B
    - test_rebase_same_head success --onto master... master
    -+test_rebase_same_head success --keep-base master
    -+test_rebase_same_head success --keep-base
    - test_rebase_same_head success --fork-point --onto B B
    - test_rebase_same_head success --fork-point --onto B... B
    - test_rebase_same_head success --fork-point --onto master... master
    -+test_rebase_same_head success --fork-point --keep-base master
    + test_rebase_same_head success noop same success noop-force diff --onto B B
    + test_rebase_same_head success noop same success noop-force diff --onto B... B
    + test_rebase_same_head success noop same success work diff --onto master... master
    ++test_rebase_same_head success noop same success work diff --keep-base master
    ++test_rebase_same_head success noop same success work diff --keep-base
    + test_rebase_same_head failure work same success work diff --fork-point --onto B B
    + test_rebase_same_head failure work same success work diff --fork-point --onto B... B
    + test_rebase_same_head success noop same success work diff --fork-point --onto master... master
    ++test_rebase_same_head success noop same success work diff --fork-point --keep-base master
      
      test_done
 -:  ---------- >  9:  46ccfca308 rebase tests: test linear branch topology
 -:  ---------- > 10:  b06e84c6d6 rebase: don't rebase linear topology with --fork-point
 -:  ---------- > 11:  bf13aa8a80 rebase: eliminate side-effects from can_fast_forward()
 -:  ---------- > 12:  2ffbb6c342 rebase: add a should_fast_forward() utility function
 -:  ---------- > 13:  20c38b78c7 WIP: can_fast_forward() support for --preserve-merges and --rebase-merges
-- 
2.21.0.1020.gf2820cf01a

