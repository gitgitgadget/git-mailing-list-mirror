Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254031F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 09:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeJKRJq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 13:09:46 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44896 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJKRJq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 13:09:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so7619915edb.11
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/rd5x9mZLaADzrWYEmwnM3x5RjpOYG2UhetxTm9h7I=;
        b=qxNIf0SgDBrfx+2NkdDnOu/yMs34GyYpWOGgut60e20zEN2K8QX/SA3xywrKugEFcJ
         S+roVBog5tRKykkSmBI5lvb4/uA9lUUct9LWQdXlxAAP3fdeqOnOYcZNr59780JSZSwR
         MuejvSAEbkNvJyNK2If5rU2BZNPO6ih/2sOd3AMgk/H8fhAZX0b8eEMXO48dwMcAaGVC
         PaHWyuUdsm4+EQ0Vsr53g3t77b/g8PsNA5XGXLBShAejRZVFIZwsynsNLgdxyi6e2JPB
         pQ1EoKD3JjXFiB9ol4B6EElu12i2Yp8YNvz5QzgjWpqJcY8WExG7e4CO+MsURwkqGSrl
         5Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/rd5x9mZLaADzrWYEmwnM3x5RjpOYG2UhetxTm9h7I=;
        b=TCMjq3y9QwzBx/UsYF1+6sSSAYjmtqylQr/Wd3mWRLs/aHnF/P4pwKMYXcyVtjvMwF
         GZbWBcJ217ugHxZQwUoqFL/q2RQF/dQjUUBg01/ZIDqCuY6Cm8HUXJMM2ZvFi6uzKHB+
         NxjaVSi8cvexHLLCBmhr9vf1tXIhUL0be2PbqgtmX1PChQP2HzrXKwNECPVucbuLcfv/
         4Zz8RuyJZgIXwbwMkk5EimEnClXwonVfoB4ZVsz/8/ncxD2NgMqr1yc8jY0X7IECHu8P
         fqOxUaPOhk6UYilC9ILBeGnz/JX8wQVie9b6GwGLuBdByRAlTIo9hRO7h1vz6QRQ++SU
         7MpQ==
X-Gm-Message-State: ABuFfoh/gAAp3lTUgjaKlbnk2NRklSldDhsE18A1yDA2yBg6QuljsRtJ
        RzgWMssWtqO5qctyFxj0Gt0=
X-Google-Smtp-Source: ACcGV61e/OIW+ZE2m8jq01ofaLw919SkvFU5CLmoxA46oZaKdL3TFHvfF9WSYKL7vrB5RZWOh43FPQ==
X-Received: by 2002:a50:b68b:: with SMTP id d11-v6mr1657690ede.283.1539250994615;
        Thu, 11 Oct 2018 02:43:14 -0700 (PDT)
Received: from localhost.localdomain (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id q25-v6sm7034721eda.18.2018.10.11.02.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Oct 2018 02:43:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 0/6] Fix the racy split index problem
Date:   Thu, 11 Oct 2018 11:43:03 +0200
Message-Id: <20181011094309.18626-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.465.gaff195083f
In-Reply-To: <20180928162459.17138-1-szeder.dev@gmail.com>
References: <20180928162459.17138-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fourth and hopefully final round of fixing occasional test failures when
run with 'GIT_TEST_SPLIT_INDEX=yes'.  The only code change is the
extraction of a helper function to compare two cache entries' content,
and then a couple of minor log message clarifications.  The range-diff
below is rather clear on that.

I will send a 7/6 follow-up patch shortly as well.

SZEDER Gábor (6):
  t1700-split-index: document why FSMONITOR is disabled in this test
    script
  split-index: add tests to demonstrate the racy split index problem
  t1700-split-index: date back files to avoid racy situations
  split-index: count the number of deleted entries
  split-index: don't compare cached data of entries already marked for
    split index
  split-index: smudge and add racily clean cache entries to split index

 cache.h                     |   2 +
 read-cache.c                |   2 +-
 split-index.c               | 131 +++++++++++++++++++---
 t/t1700-split-index.sh      |  52 +++++----
 t/t1701-racy-split-index.sh | 214 ++++++++++++++++++++++++++++++++++++
 5 files changed, 361 insertions(+), 40 deletions(-)
 create mode 100755 t/t1701-racy-split-index.sh

Range-diff:
1:  ba2b1bdf16 = 1:  ba2b1bdf16 t1700-split-index: document why FSMONITOR is disabled in this test script
2:  bf1b038f10 ! 2:  c7cb9d9115 split-index: add tests to demonstrate the racy split index problem
    @@ -136,13 +136,20 @@
              git commands will then erroneously consider the file clean.
     
         Note that in the last two 'test_expect_failure' cases I omitted the
    -    '#' (as in nr. of trial) from the tests' name on purpose for now, as
    -    it confuses 'prove' into thinking that those tests failed
    -    unexpectedly.
    +    '#' (as in nr. of trial) from the tests' description on purpose for
    +    now, as it breakes the TAP output [2]; it will be added at the end of
    +    the series, when those two tests will be flipped to
    +    'test_expect_success'.
     
         [1] In the branch leading to the merge commit v2.1.0-rc0~45 (Merge
             branch 'nd/split-index', 2014-07-16).
     
    +    [2] In the TAP output a '#' should separate the test's description
    +        from the TODO directive emitted by 'test_expect_failure'.  The
    +        additional '#' in "#$trial" interferes with this, the test harness
    +        won't recognize the TODO directive, and will report that those
    +        tests failed unexpectedly.
    +
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
3:  e7f7fb6e2d = 3:  ce803d8064 t1700-split-index: date back files to avoid racy situations
4:  6dc0b01ad3 = 4:  1d12d718d1 split-index: count the number of deleted entries
5:  9c420f9c66 ! 5:  0dd448c707 split-index: don't compare stat data of entries already marked for split index
    @@ -1,6 +1,6 @@
     Author: SZEDER Gábor <szeder.dev@gmail.com>
     
    -    split-index: don't compare stat data of entries already marked for split index
    +    split-index: don't compare cached data of entries already marked for split index
     
         When unpack_trees() constructs a new index, it copies cache entries
         from the original index [1].  prepare_to_write_split_index() has to
    @@ -20,7 +20,9 @@
     
         So modify prepare_to_write_split_index() to check the copied cache
         entries' CE_UPDATE_IN_BASE flag first, and skip the thorough
    -    comparison of cached data if the flag is already set.
    +    comparison of cached data if the flag is already set.  Those couple of
    +    lines comparing the cached data would then have too many levels of
    +    indentation, so extract them into a helper function.
     
         Note that comparing the cached data in copied and original entries in
         the shared index might actually be entirely unnecessary.  In theory
    @@ -62,6 +64,37 @@
      diff --git a/split-index.c b/split-index.c
      --- a/split-index.c
      +++ b/split-index.c
    +@@
    + 	si->saved_cache_nr = 0;
    + }
    + 
    ++/*
    ++ * Compare most of the fields in two cache entries, i.e. all except the
    ++ * hashmap_entry and the name.
    ++ */
    ++static int compare_ce_content(struct cache_entry *a, struct cache_entry *b)
    ++{
    ++	const unsigned int ondisk_flags = CE_STAGEMASK | CE_VALID |
    ++					  CE_EXTENDED_FLAGS;
    ++	unsigned int ce_flags = a->ce_flags;
    ++	unsigned int base_flags = b->ce_flags;
    ++	int ret;
    ++
    ++	/* only on-disk flags matter */
    ++	a->ce_flags &= ondisk_flags;
    ++	b->ce_flags &= ondisk_flags;
    ++	ret = memcmp(&a->ce_stat_data, &b->ce_stat_data,
    ++		     offsetof(struct cache_entry, name) -
    ++		     offsetof(struct cache_entry, ce_stat_data));
    ++	a->ce_flags = ce_flags;
    ++	b->ce_flags = base_flags;
    ++
    ++	return ret;
    ++}
    ++
    + void prepare_to_write_split_index(struct index_state *istate)
    + {
    + 	struct split_index *si = init_split_index(istate);
     @@
      		 */
      		for (i = 0; i < istate->cache_nr; i++) {
    @@ -137,21 +170,7 @@
     +				 * code paths modifying the cached data do
     +				 * set CE_UPDATE_IN_BASE as well.
     +				 */
    -+				const unsigned int ondisk_flags =
    -+					CE_STAGEMASK | CE_VALID |
    -+					CE_EXTENDED_FLAGS;
    -+				unsigned int ce_flags, base_flags, ret;
    -+				ce_flags = ce->ce_flags;
    -+				base_flags = base->ce_flags;
    -+				/* only on-disk flags matter */
    -+				ce->ce_flags   &= ondisk_flags;
    -+				base->ce_flags &= ondisk_flags;
    -+				ret = memcmp(&ce->ce_stat_data, &base->ce_stat_data,
    -+					     offsetof(struct cache_entry, name) -
    -+					     offsetof(struct cache_entry, ce_stat_data));
    -+				ce->ce_flags = ce_flags;
    -+				base->ce_flags = base_flags;
    -+				if (ret)
    ++				if (compare_ce_content(ce, base))
     +					ce->ce_flags |= CE_UPDATE_IN_BASE;
     +			}
      			discard_cache_entry(base);
6:  52c755f210 ! 6:  384b440345 split-index: smudge and add racily clean cache entries to split index
    @@ -46,6 +46,11 @@
         racily clean cache entries as well, and will then write them with
         smudged stat data to the new split index.
     
    +    This change makes all tests in 't1701-racy-split-index.sh' pass, so
    +    flip the two 'test_expect_failure' tests to success.  Also add the '#'
    +    (as in nr. of trial) to those tests' description that were omitted
    +    when the tests expected failure.
    +
         Note that after this change if the index is split when it contains a
         racily clean cache entry, then a smudged cache entry will be written
         both to the new shared and to the new split indexes.  This doesn't
-- 
2.19.1.465.gaff195083f

