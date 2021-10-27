Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A5BC433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3544A60E8B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhJ0MGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhJ0MGv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:06:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799AC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v17so3718211wrv.9
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0zCjAB7U79qcnwKdnAsjL0gZ+S64NKaQBT2LtcKg82Y=;
        b=mtsPt5++NzBKnMzFJ0yvU9OzJ2H96ZMV6GRGGadJ8wQca/fLe2kjz/Xwy+mMnlcOyr
         LugooCZMsgGFCuFJomnzylWCNV+YMsM75VaOPALT9fKfBHQ9tu6QKrIGecudoXoKIOFi
         amr0ZgLuYEAo9QAD9ANKhgigwQHl5IRtOaTJuZ6P0UMeqFEjrWQoGIMTktZwK1BpZI5x
         QF/h99zCdCguLIqnudGAWWGTBqaf1Zo7Jc7/XHMOTgWH50j1ZFKradsg6pPve9WrPC6o
         pWu4tqJkSm1M9mhiS1ora/bPc1SMwRgSRTk2DnWS1/hDwjmZLdjXEAf8GUNlV5mrkJ7V
         98tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0zCjAB7U79qcnwKdnAsjL0gZ+S64NKaQBT2LtcKg82Y=;
        b=HcBEvEVVoPD4s3D2tiywCUzJ9i88iJLLrImYrCCL4JxisrgGWIxgYrEAStsEL9jECr
         tItpArIIXMDfbmLWwjdPrr02lDH3es35WJLqL9F7ddrTeQChDV7KC6qfggUO8g+ONi9Q
         lFfY15Kw3YGET7UScem9Y5Uju0f0mNJlRR+NftuFp87LLrsqbc1Is1zF2F8WUkEnxBSG
         s2tZ+gF/zf7c1PkNvDqkYXefCbioMY8R4vD9z9HvRB6LII6zFIJSm0iy8OQsZM/u093Y
         3ijm87PInAKLq1FSSgqG0NC/Zxo9de2ajk/aq5wQiorE364m9/r4ZCmlCfncjZqolQpN
         /4LA==
X-Gm-Message-State: AOAM533YMg9bCVBsXA0RQI5/naNnM2XmonBYFLum93BE8eCQg5NVKPNO
        AwfIAhy0Ihp/FRuXkerhA6mPkxH3vZw=
X-Google-Smtp-Source: ABdhPJxrB/7lqpezdfBVve0vYBEn17TehsbEMluhJ5guw0+FkIwHsJjdA79wPPfmCvMipIKNbDCUKQ==
X-Received: by 2002:a05:6000:18ce:: with SMTP id w14mr39546522wrq.230.1635336264694;
        Wed, 27 Oct 2021 05:04:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o194sm3676384wme.40.2021.10.27.05.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:24 -0700 (PDT)
Message-Id: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:07 +0000
Subject: [PATCH v3 00/15] diff --color-moved[-ws] speedups
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

Sorry it has taken so long to post this re-roll. Changes since V2:

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
 t/perf/p4002-diff-color-moved.sh |  45 ++++
 t/t4015-diff-whitespace.sh       | 205 ++++++++++++++-
 3 files changed, 425 insertions(+), 256 deletions(-)
 create mode 100755 t/perf/p4002-diff-color-moved.sh


base-commit: 211eca0895794362184da2be2a2d812d070719d3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-981%2Fphillipwood%2Fwip%2Fdiff-color-moved-tweaks-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-981/phillipwood/wip/diff-color-moved-tweaks-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/981

Range-diff vs v2:

  1:  8fc8914a37b =  1:  8fc8914a37b diff --color-moved: add perf tests
  -:  ----------- >  2:  e9daed2360c diff --color-moved: clear all flags on blocks that are too short
  -:  ----------- >  3:  658aec2670c diff --color-moved: factor out function
  -:  ----------- >  4:  a30f52d7f15 diff --color-moved: rewind when discarding pmb
  2:  9b4e4d2674a !  5:  1dde206b7b1 diff --color-moved=zebra: fix alternate coloring
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       		switch (l->s) {
       		case DIFF_SYMBOL_PLUS:
      @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
     - 			}
     + 							    &pmb, &pmb_alloc,
     + 							    &pmb_nr);
       
     - 			if (adjust_last_block(o, n, block_length) &&
     --			    pmb_nr && last_symbol != l->s)
     -+			    pmb_nr && last_symbol == l->s)
     +-			if (contiguous && pmb_nr && last_symbol != l->s)
     ++			if (contiguous && pmb_nr && last_symbol == l->s)
       				flipped_block = (flipped_block + 1) % 2;
       			else
       				flipped_block = 0;
  3:  5512145c70f !  6:  2717ff500d2 diff --color-moved: avoid false short line matches and bad zerba coloring
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
      +		if (pmb_nr && (!match || l->s != moved_symbol)) {
       			int i;
       
     - 			adjust_last_block(o, n, block_length);
     + 			if (!adjust_last_block(o, n, block_length) &&
      @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       			pmb_nr = 0;
       			block_length = 0;
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       			continue;
       		}
      @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
     - 			}
     + 							    &pmb, &pmb_alloc,
     + 							    &pmb_nr);
       
     - 			if (adjust_last_block(o, n, block_length) &&
     --			    pmb_nr && last_symbol == l->s)
     -+			    pmb_nr && moved_symbol == l->s)
     +-			if (contiguous && pmb_nr && last_symbol == l->s)
     ++			if (contiguous && pmb_nr && moved_symbol == l->s)
       				flipped_block = (flipped_block + 1) % 2;
       			else
       				flipped_block = 0;
  4:  93fdef30d64 =  7:  f96fa71d53c diff: simplify allow-indentation-change delta calculation
  5:  6b7a8aed4ec !  8:  324b689c915 diff --color-moved-ws=allow-indentation-change: simplify and optimize
     @@ Commit message
            git diff --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
          by 93% compared to master and simplifies the code.
      
     -    Test                                                                  HEAD^              HEAD
     +    Test                                                                 HEAD^               HEAD
          ---------------------------------------------------------------------------------------------------------------
     -    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41( 0.38+0.03)   0.41(0.37+0.04)  +0.0%
     -    4002.2: diff --color-moved --no-color-moved-ws large change           0.83( 0.79+0.04)   0.82(0.79+0.02)  -1.2%
     -    4002.3: diff --color-moved-ws=allow-indentation-change large change  13.68(13.59+0.07)   0.92(0.89+0.03) -93.3%
     -    4002.4: log --no-color-moved --no-color-moved-ws                      1.31( 1.22+0.08)   1.31(1.21+0.10)  +0.0%
     -    4002.5: log --color-moved --no-color-moved-ws                         1.47( 1.40+0.07)   1.47(1.36+0.10)  +0.0%
     -    4002.6: log --color-moved-ws=allow-indentation-change                 1.87( 1.77+0.09)   1.50(1.41+0.09) -19.8%
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.35+0.03)   0.38(0.35+0.03)  +0.0%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.86 (0.80+0.06)   0.87(0.83+0.04)  +1.2%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change  19.01(18.93+0.06)   0.97(0.92+0.04) -94.9%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.16 (1.06+0.09)   1.17(1.06+0.10)  +0.9%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.32 (1.25+0.07)   1.32(1.24+0.08)  +0.0%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.71 (1.64+0.06)   1.36(1.25+0.10) -20.5%
      
     +    Test                                                                 master              HEAD
     +    ---------------------------------------------------------------------------------------------------------------
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.33+0.05)   0.38(0.35+0.03)  +0.0%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.80 (0.75+0.04)   0.87(0.83+0.04)  +8.7%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change  14.20(14.15+0.05)   0.97(0.92+0.04) -93.2%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.15 (1.05+0.09)   1.17(1.06+0.10)  +1.7%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.30 (1.19+0.11)   1.32(1.24+0.08)  +1.5%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.70 (1.63+0.06)   1.36(1.25+0.10) -20.0%
     +
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## diff.c ##
      @@ diff.c: static int compute_ws_delta(const struct emitted_diff_symbol *a,
     + 	return 1;
     + }
       
     - static int cmp_in_block_with_wsd(const struct diff_options *o,
     - 				 const struct moved_entry *cur,
     +-static int cmp_in_block_with_wsd(const struct diff_options *o,
     +-				 const struct moved_entry *cur,
      -				 const struct moved_entry *match,
      -				 struct moved_block *pmb,
      -				 int n)
     -+				 const struct emitted_diff_symbol *l,
     -+				 struct moved_block *pmb)
     - {
     +-{
      -	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
      -	int al = cur->es->len, bl = match->es->len, cl = l->len;
     ++static int cmp_in_block_with_wsd(const struct moved_entry *cur,
     ++				 const struct emitted_diff_symbol *l,
     ++				 struct moved_block *pmb)
     ++{
      +	int al = cur->es->len, bl = l->len;
       	const char *a = cur->es->line,
      -		   *b = match->es->line,
     @@ diff.c: static void pmb_advance_or_null(struct diff_options *o,
      +		struct moved_entry *prev = pmb[i].match;
      +		struct moved_entry *cur = (prev && prev->next_line) ?
      +			prev->next_line : NULL;
     -+		if (cur && !cmp_in_block_with_wsd(o, cur, l, &pmb[i])) {
     ++		if (cur && !cmp_in_block_with_wsd(cur, l, &pmb[i])) {
       			/* Advance to the next line */
      -			pmb[i].match = pmb[i].match->next_line;
      +			pmb[i].match = cur;
  6:  cfbdd447eee !  9:  f142f33276a diff --color-moved: call comparison function directly
     @@ Commit message
      
          Test                                                                  HEAD^             HEAD
          -------------------------------------------------------------------------------------------------------------
     -    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41(0.37+0.04)   0.41(0.39+0.02) +0.0%
     -    4002.2: diff --color-moved --no-color-moved-ws large change           0.82(0.79+0.02)   0.83(0.79+0.03) +1.2%
     -    4002.3: diff --color-moved-ws=allow-indentation-change large change   0.92(0.89+0.03)   0.91(0.85+0.05) -1.1%
     -    4002.4: log --no-color-moved --no-color-moved-ws                      1.31(1.21+0.10)   1.33(1.22+0.10) +1.5%
     -    4002.5: log --color-moved --no-color-moved-ws                         1.47(1.36+0.10)   1.47(1.39+0.08) +0.0%
     -    4002.6: log --color-moved-ws=allow-indentation-change                 1.50(1.41+0.09)   1.51(1.42+0.09) +0.7%
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38(0.35+0.03)   0.38(0.32+0.06) +0.0%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.87(0.83+0.04)   0.87(0.80+0.06) +0.0%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change   0.97(0.92+0.04)   0.97(0.93+0.04) +0.0%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.17(1.06+0.10)   1.16(1.10+0.05) -0.9%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.32(1.24+0.08)   1.31(1.22+0.09) -0.8%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.36(1.25+0.10)   1.35(1.25+0.10) -0.7%
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
  7:  73ce9b54e86 ! 10:  8f3ea865dd3 diff --color-moved: unify moved block growth functions
     @@ diff.c: static void pmb_advance_or_null(struct diff_options *o,
      -		struct moved_entry *prev = pmb[i].match;
      -		struct moved_entry *cur = (prev && prev->next_line) ?
      -			prev->next_line : NULL;
     --		if (cur && !cmp_in_block_with_wsd(o, cur, l, &pmb[i])) {
     +-		if (cur && !cmp_in_block_with_wsd(cur, l, &pmb[i])) {
      -			/* Advance to the next line */
      +		if (o->color_moved_ws_handling &
      +		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
      +			match = cur &&
     -+				!cmp_in_block_with_wsd(o, cur, l, &pmb[i]);
     ++				!cmp_in_block_with_wsd(cur, l, &pmb[i]);
      +		else
      +			match = cur &&
      +				xdiff_compare_lines(cur->es->line, cur->es->len,
  8:  ef8ce0e6ebc ! 11:  078c04d4a66 diff --color-moved: shrink potential moved blocks as we go
     @@ diff.c: static void add_lines_to_move_detection(struct diff_options *o,
       		struct moved_entry *prev = pmb[i].match;
       		struct moved_entry *cur = (prev && prev->next_line) ?
      @@ diff.c: static void pmb_advance_or_null(struct diff_options *o,
     + 			match = cur &&
       				xdiff_compare_lines(cur->es->line, cur->es->len,
       						    l->line, l->len, flags);
     - 		if (match)
     +-		if (match)
      -			pmb[i].match = cur;
      -		else
      -			moved_block_clear(&pmb[i]);
     -+			pmb[j++].match = cur;
     - 	}
     +-	}
      -}
      -
      -static int shrink_potential_moved_blocks(struct moved_block *pmb,
     @@ diff.c: static void pmb_advance_or_null(struct diff_options *o,
      -			memset(&pmb[rp], 0, sizeof(pmb[rp]));
      -			rp--;
      -			lp++;
     --		}
     --	}
     ++		if (match) {
     ++			pmb[j] = pmb[i];
     ++			pmb[j++].match = cur;
     + 		}
     + 	}
      -
      -	/* Remember the number of running sets */
      -	return rp + 1;
      +	*pmb_nr = j;
       }
       
     - /*
     + static void fill_potential_moved_blocks(struct diff_options *o,
      @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       			continue;
       		}
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
      +		pmb_advance_or_null(o, l, pmb, &pmb_nr);
       
       		if (pmb_nr == 0) {
     - 			/*
     + 			int contiguous = adjust_last_block(o, n, block_length);
  9:  9d0a042eae1 ! 12:  618371471a0 diff --color-moved: stop clearing potential moved blocks
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       		if (pmb_nr && (!match || l->s != moved_symbol)) {
      -			int i;
      -
     - 			adjust_last_block(o, n, block_length);
     + 			if (!adjust_last_block(o, n, block_length) &&
     + 			    block_length > 1) {
     + 				/*
     +@@ diff.c: static void mark_color_as_moved(struct diff_options *o,
     + 				match = NULL;
     + 				n -= block_length;
     + 			}
      -			for(i = 0; i < pmb_nr; i++)
      -				moved_block_clear(&pmb[i]);
       			pmb_nr = 0;
 10:  dd365ad115f ! 13:  6a8e9a2724d diff --color-moved-ws=allow-indentation-change: improve hash lookups
     @@ Commit message
          for the different modes but after the next two commits there is no
          measurable benefit in doing so.
      
     +    There is a change in behavior for lines that begin with a form-feed or
     +    vertical-tab character. Since b46054b374 ("xdiff: use
     +    git-compat-util", 2019-04-11) xdiff does not treat '\f' or '\v' as
     +    whitespace characters. This means that lines starting with those
     +    characters are never considered to be blank and never match a line
     +    that does not start with the same character. After this patch a line
     +    matching "^[\f\v\r]*[ \t]*$" is considered to be blank by
     +    --color-moved-ws=allow-indentation-change and lines beginning
     +    "^[\f\v\r]*[ \t]*" can match another line if the suffixes match. This
     +    changes the output of git show for d18f76dccf ("compat/regex: use the
     +    regex engine from gawk for compat", 2010-08-17) as some lines in the
     +    pre-image before a moved block that contain '\f' are now considered
     +    moved as well as they match a blank line before the moved lines in the
     +    post-image. This commit updates one of the tests to reflect this
     +    change.
     +
          Test                                                                  HEAD^             HEAD
          --------------------------------------------------------------------------------------------------------------
     -    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41(0.38+0.03)   0.41(0.36+0.04) +0.0%
     -    4002.2: diff --color-moved --no-color-moved-ws large change           0.82(0.76+0.05)   0.84(0.79+0.04) +2.4%
     -    4002.3: diff --color-moved-ws=allow-indentation-change large change   0.91(0.88+0.03)   0.81(0.74+0.06) -11.0%
     -    4002.4: log --no-color-moved --no-color-moved-ws                      1.32(1.21+0.10)   1.31(1.19+0.11) -0.8%
     -    4002.5: log --color-moved --no-color-moved-ws                         1.47(1.37+0.10)   1.47(1.36+0.11) +0.0%
     -    4002.6: log --color-moved-ws=allow-indentation-change                 1.51(1.42+0.09)   1.48(1.37+0.10) -2.0%
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38(0.33+0.05)   0.38(0.33+0.05)  +0.0%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.86(0.82+0.04)   0.88(0.84+0.04)  +2.3%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change   0.97(0.94+0.03)   0.86(0.81+0.05) -11.3%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.16(1.07+0.09)   1.16(1.06+0.09)  +0.0%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.32(1.26+0.06)   1.33(1.27+0.05)  +0.8%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.35(1.29+0.06)   1.33(1.24+0.08)  -1.5%
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ diff.c: static void fill_es_indent_data(struct emitted_diff_symbol *es)
      +	return a_width - b_width;
       }
       
     - static int cmp_in_block_with_wsd(const struct diff_options *o,
     + static int cmp_in_block_with_wsd(const struct moved_entry *cur,
      @@ diff.c: static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
       			   const void *keydata)
       {
     @@ diff.c: static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
       
      -	a = container_of(eptr, const struct moved_entry, ent);
      -	b = container_of(entry_or_key, const struct moved_entry, ent);
     --
     ++	a = container_of(eptr, const struct moved_entry, ent)->es;
     ++	b = container_of(entry_or_key, const struct moved_entry, ent)->es;
     + 
      -	if (diffopt->color_moved_ws_handling &
      -	    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
      -		/*
     @@ diff.c: static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
      -		 * configuration for the next block is done else where
      -		 */
      -		flags |= XDF_IGNORE_WHITESPACE;
     -+	a = container_of(eptr, const struct moved_entry, ent)->es;
     -+	b = container_of(entry_or_key, const struct moved_entry, ent)->es;
     - 
     +-
      -	return !xdiff_compare_lines(a->es->line, a->es->len,
      -				    b->es->line, b->es->len,
      -				    flags);
     @@ diff.c: static struct moved_entry *prepare_entry(struct diff_options *o,
       
       	hashmap_entry_init(&ret->ent, hash);
       	ret->es = l;
     -@@ diff.c: static void mark_color_as_moved(struct diff_options *o,
     - 			hashmap_for_each_entry_from(hm, match, ent) {
     - 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
     - 				if (o->color_moved_ws_handling &
     --				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
     --					if (compute_ws_delta(l, match->es,
     --							     &pmb[pmb_nr].wsd))
     --						pmb[pmb_nr++].match = match;
     --				} else {
     -+				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
     -+					pmb[pmb_nr].wsd = compute_ws_delta(l, match->es);
     -+				else
     - 					pmb[pmb_nr].wsd = 0;
     --					pmb[pmb_nr++].match = match;
     --				}
     -+				pmb[pmb_nr++].match = match;
     - 			}
     +@@ diff.c: static void fill_potential_moved_blocks(struct diff_options *o,
     + 	hashmap_for_each_entry_from(hm, match, ent) {
     + 		ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
     + 		if (o->color_moved_ws_handling &
     +-		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
     +-			if (compute_ws_delta(l, match->es, &(pmb[pmb_nr]).wsd))
     +-				pmb[pmb_nr++].match = match;
     +-		} else {
     ++		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
     ++			pmb[pmb_nr].wsd = compute_ws_delta(l, match->es);
     ++		else
     + 			pmb[pmb_nr].wsd = 0;
     +-			pmb[pmb_nr++].match = match;
     +-		}
     ++		pmb[pmb_nr++].match = match;
     + 	}
       
     - 			if (adjust_last_block(o, n, block_length) &&
     + 	*pmb_p = pmb;
      @@ diff.c: static void diff_flush_patch_all_file_pairs(struct diff_options *o)
       		if (o->color_moved) {
       			struct hashmap add_lines, del_lines;
     @@ diff.c: static void diff_flush_patch_all_file_pairs(struct diff_options *o)
       			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
       			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
       
     +
     + ## t/t4015-diff-whitespace.sh ##
     +@@ t/t4015-diff-whitespace.sh: EMPTY=''
     + test_expect_success 'compare mixed whitespace delta across moved blocks' '
     + 
     + 	git reset --hard &&
     +-	tr Q_ "\t " <<-EOF >text.txt &&
     +-	${EMPTY}
     +-	____too short without
     +-	${EMPTY}
     ++	tr "^|Q_" "\f\v\t " <<-EOF >text.txt &&
     ++	^__
     ++	|____too short without
     ++	^
     + 	___being grouped across blank line
     + 	${EMPTY}
     + 	context
     +@@ t/t4015-diff-whitespace.sh: test_expect_success 'compare mixed whitespace delta across moved blocks' '
     + 	git add text.txt &&
     + 	git commit -m "add text.txt" &&
     + 
     +-	tr Q_ "\t " <<-EOF >text.txt &&
     ++	tr "^|Q_" "\f\v\t " <<-EOF >text.txt &&
     + 	context
     + 	lines
     + 	to
     +@@ t/t4015-diff-whitespace.sh: test_expect_success 'compare mixed whitespace delta across moved blocks' '
     + 	${EMPTY}
     + 	QQtoo short without
     + 	${EMPTY}
     +-	Q_______being grouped across blank line
     ++	^Q_______being grouped across blank line
     + 	${EMPTY}
     + 	Q_QThese two lines have had their
     + 	indentation reduced by four spaces
     +@@ t/t4015-diff-whitespace.sh: test_expect_success 'compare mixed whitespace delta across moved blocks' '
     + 		-c core.whitespace=space-before-tab \
     + 		diff --color --color-moved --ws-error-highlight=all \
     + 		--color-moved-ws=allow-indentation-change >actual.raw &&
     +-	grep -v "index" actual.raw | test_decode_color >actual &&
     ++	grep -v "index" actual.raw | tr "\f\v" "^|" | test_decode_color >actual &&
     + 
     + 	cat <<-\EOF >expected &&
     + 	<BOLD>diff --git a/text.txt b/text.txt<RESET>
     + 	<BOLD>--- a/text.txt<RESET>
     + 	<BOLD>+++ b/text.txt<RESET>
     + 	<CYAN>@@ -1,16 +1,16 @@<RESET>
     +-	<BOLD;MAGENTA>-<RESET>
     +-	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>    too short without<RESET>
     +-	<BOLD;MAGENTA>-<RESET>
     ++	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>^<RESET><BRED>  <RESET>
     ++	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>|    too short without<RESET>
     ++	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>^<RESET>
     + 	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>   being grouped across blank line<RESET>
     + 	<BOLD;MAGENTA>-<RESET>
     + 	 <RESET>context<RESET>
     +@@ t/t4015-diff-whitespace.sh: test_expect_success 'compare mixed whitespace delta across moved blocks' '
     + 	<BOLD;YELLOW>+<RESET>
     + 	<BOLD;YELLOW>+<RESET>		<BOLD;YELLOW>too short without<RESET>
     + 	<BOLD;YELLOW>+<RESET>
     +-	<BOLD;YELLOW>+<RESET>	<BOLD;YELLOW>       being grouped across blank line<RESET>
     ++	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>^	       being grouped across blank line<RESET>
     + 	<BOLD;YELLOW>+<RESET>
     + 	<BOLD;CYAN>+<RESET>	<BRED> <RESET>	<BOLD;CYAN>These two lines have had their<RESET>
     + 	<BOLD;CYAN>+<RESET><BOLD;CYAN>indentation reduced by four spaces<RESET>
 11:  c160222ab3c = 14:  ef98a6e7015 diff: use designated initializers for emitted_diff_symbol
 12:  753554587f9 ! 15:  ae78c05f08d diff --color-moved: intern strings
     @@ Commit message
          number of hash lookups a little (calculating the ids still involves
          one hash lookup per line) but the main benefit is that when growing
          blocks of potentially moved lines we can replace string comparisons
     -    which involve chasing a pointer with a simple integer comparison.
     +    which involve chasing a pointer with a simple integer comparison. On a
     +    large diff this commit reduces the time to run 'diff --color-moved' by
     +    37% compared to the previous commit and 31% compared to master, for
     +    'diff --color-moved-ws=allow-indentation-change' the reduction is 28%
     +    compared to the previous commit and 96% compared to master. There is
     +    little change in the performance of 'git log --patch' as the diffs are
     +    smaller.
      
     -    On a large diff this commit reduces the time to run
     -       diff --color-moved
     -    by 33% and
     -        diff --color-moved-ws=allow-indentation-change
     -    by 26%. Compared to master the time to run
     -        diff --color-moved-ws=allow-indentation-change
     -    is now reduced by 95% and the overhead compared to --no-color-moved is
     -    reduced to 50%.
     +    Test                                                                 HEAD^               HEAD
     +    ---------------------------------------------------------------------------------------------------------------
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38(0.33+0.05)    0.38(0.33+0.05)  +0.0%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.88(0.81+0.06)    0.55(0.50+0.04) -37.5%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change   0.85(0.79+0.06)    0.61(0.54+0.06) -28.2%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.16(1.07+0.08)    1.15(1.09+0.05)  -0.9%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.31(1.22+0.08)    1.29(1.19+0.09)  -1.5%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.32(1.24+0.08)    1.31(1.18+0.13)  -0.8%
      
     -    Compared to the previous commit the time to run
     -        git log --patch --color-moved
     -    is increased slightly, but compared to master there is no change in
     -    run time.
     -
     -    Test                                                                  HEAD^             HEAD
     -    --------------------------------------------------------------------------------------------------------------
     -    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.41(0.36+0.04)   0.41(0.37+0.03)  +0.0%
     -    4002.2: diff --color-moved --no-color-moved-ws large change           0.83(0.79+0.03)   0.55(0.52+0.03) -33.7%
     -    4002.3: diff --color-moved-ws=allow-indentation-change large change   0.81(0.77+0.04)   0.60(0.55+0.05) -25.9%
     -    4002.4: log --no-color-moved --no-color-moved-ws                      1.30(1.20+0.09)   1.31(1.22+0.08)  +0.8%
     -    4002.5: log --color-moved --no-color-moved-ws                         1.46(1.35+0.11)   1.47(1.30+0.16)  +0.7%
     -    4002.6: log --color-moved-ws=allow-indentation-change                 1.46(1.38+0.07)   1.47(1.34+0.13)  +0.7%
     -
     -    Test                                                                  master            HEAD
     -    --------------------------------------------------------------------------------------------------------------
     -    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.40( 0.36+0.03)  0.41(0.37+0.03)  +2.5%
     -    4002.2: diff --color-moved --no-color-moved-ws large change           0.82( 0.77+0.04)  0.55(0.52+0.03) -32.9%
     -    4002.3: diff --color-moved-ws=allow-indentation-change large change  14.10(14.04+0.04)  0.60(0.55+0.05) -95.7%
     -    4002.4: log --no-color-moved --no-color-moved-ws                      1.31( 1.21+0.09)  1.31(1.22+0.08)  +0.0%
     -    4002.5: log --color-moved --no-color-moved-ws                         1.47( 1.37+0.09)  1.47(1.30+0.16)  +0.0%
     -    4002.6: log --color-moved-ws=allow-indentation-change                 1.86( 1.76+0.10)  1.47(1.34+0.13) -21.0%
     +    Test                                                                 master              HEAD
     +    ---------------------------------------------------------------------------------------------------------------
     +    4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.33+0.05)   0.38(0.33+0.05)  +0.0%
     +    4002.2: diff --color-moved --no-color-moved-ws large change           0.80 (0.75+0.04)   0.55(0.50+0.04) -31.2%
     +    4002.3: diff --color-moved-ws=allow-indentation-change large change  14.20(14.15+0.05)   0.61(0.54+0.06) -95.7%
     +    4002.4: log --no-color-moved --no-color-moved-ws                      1.15 (1.05+0.09)   1.15(1.09+0.05)  +0.0%
     +    4002.5: log --color-moved --no-color-moved-ws                         1.30 (1.19+0.11)   1.29(1.19+0.09)  -0.8%
     +    4002.6: log --color-moved-ws=allow-indentation-change                 1.70 (1.63+0.06)   1.31(1.18+0.13) -22.9%
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ diff.c: static void append_emitted_diff_symbol(struct diff_options *o,
       };
       
       struct moved_block {
     -@@ diff.c: static int cmp_in_block_with_wsd(const struct diff_options *o,
     +@@ diff.c: static int cmp_in_block_with_wsd(const struct moved_entry *cur,
       				 const struct emitted_diff_symbol *l,
       				 struct moved_block *pmb)
       {
     @@ diff.c: static int cmp_in_block_with_wsd(const struct diff_options *o,
       	 */
       	delta = b_width - a_width;
       
     -@@ diff.c: static int cmp_in_block_with_wsd(const struct diff_options *o,
     +@@ diff.c: static int cmp_in_block_with_wsd(const struct moved_entry *cur,
       	if (pmb->wsd == INDENT_BLANKLINE)
       		pmb->wsd = delta;
       
     @@ diff.c: static void pmb_advance_or_null(struct diff_options *o,
       		int match;
      @@ diff.c: static void pmb_advance_or_null(struct diff_options *o,
       			match = cur &&
     - 				!cmp_in_block_with_wsd(o, cur, l, &pmb[i]);
     + 				!cmp_in_block_with_wsd(cur, l, &pmb[i]);
       		else
      -			match = cur &&
      -				xdiff_compare_lines(cur->es->line, cur->es->len,
      -						    l->line, l->len, flags);
      +			match = cur && cur->es->id == l->id;
      +
     - 		if (match)
     + 		if (match) {
     + 			pmb[j] = pmb[i];
       			pmb[j++].match = cur;
     - 	}
     +@@ diff.c: static void pmb_advance_or_null(struct diff_options *o,
     + }
     + 
     + static void fill_potential_moved_blocks(struct diff_options *o,
     +-					struct hashmap *hm,
     + 					struct moved_entry *match,
     + 					struct emitted_diff_symbol *l,
     + 					struct moved_block **pmb_p,
     +@@ diff.c: static void fill_potential_moved_blocks(struct diff_options *o,
     + 	 * The current line is the start of a new block.
     + 	 * Setup the set of potential blocks.
     + 	 */
     +-	hashmap_for_each_entry_from(hm, match, ent) {
     ++	for (; match; match = match->next_match) {
     + 		ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
     + 		if (o->color_moved_ws_handling &
     + 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
      @@ diff.c: static int adjust_last_block(struct diff_options *o, int n, int block_length)
       
       /* Find blocks of moved code, delegate actual coloring decision to helper */
     @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
       		default:
       			flipped_block = 0;
      @@ diff.c: static void mark_color_as_moved(struct diff_options *o,
     - 			 * The current line is the start of a new block.
     - 			 * Setup the set of potential blocks.
     - 			 */
     --			hashmap_for_each_entry_from(hm, match, ent) {
     -+			for (; match; match = match->next_match) {
     - 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
     - 				if (o->color_moved_ws_handling &
     - 				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
     + 				 */
     + 				n -= block_length;
     + 			else
     +-				fill_potential_moved_blocks(o, hm, match, l,
     ++				fill_potential_moved_blocks(o, match, l,
     + 							    &pmb, &pmb_alloc,
     + 							    &pmb_nr);
     + 
      @@ diff.c: static void diff_flush_patch_all_file_pairs(struct diff_options *o)
       
       	if (o->emitted_symbols) {

-- 
gitgitgadget
