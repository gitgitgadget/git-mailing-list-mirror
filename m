Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A511F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 01:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeJKIqQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 04:46:16 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:46977 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeJKIqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 04:46:16 -0400
Received: by mail-io1-f74.google.com with SMTP id l4-v6so6495012iog.13
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 18:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9rMFW+ZaHothkjOIf2+mWzmb9Y8XjNdvQAZrs6feroY=;
        b=jOForyk4dw4w1HaCeM5ERk41r8QsPbvg7ov95N9wl5XPYop6MBjYxCie14fEGbRqMR
         4Ocirc2t6mB1r8lgO9orKAf+nymlgtlW1+yvjtxFjRA+g5FDLAP9ckH+JAIh8XTvrdgO
         gCzIBHiyYd5KJMPWo8QIaI52aCTh61fAQaKV72HQ2pbXbJovjx4rN8apMQlbr334Qwd6
         BINDM10tC/3sSujXanQqvZkxiBp2X6Ik+6sjyxwRmXEcpwpDOBPuo39H2AgQLBfghADK
         jCv0Qbgm0SMJdNdR6+UsFbtLPfq+hoqbhEqRQl1am8QpKRqCv8XhIrnrfeiYnHysaUVw
         7+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9rMFW+ZaHothkjOIf2+mWzmb9Y8XjNdvQAZrs6feroY=;
        b=Vq/1T88zKsGygBHhWgQ9t4dByxdoRwP5oQJTrbQCrS5mveSyI4QkDMD9WX1ko3szvQ
         rWWXt0WLqILrdxGdkEzQJRvkSaT+5d+spllR0wyaTQj+sGRvlxvLm3BcF6wNh151d5cI
         2egT1gmEjHv4WJfy1viU2Tzu6lWXObbL7bDc6YZIVz5ZZQa/yEqe/AZlDFzxIo4DEdcG
         QdqpWzL9BmGHpp43y5wyuVhqYme6ZxXYQf9Cr/LwLorYdRG6/PUvskpzdA9U3bc/jLF2
         EXYZY1n2VikoPp9ksNHwUsnKpvXlzWQHb7GloRpx4ZCDjoGYmhVjDTxXfpOq0Iyr1+WS
         QNPg==
X-Gm-Message-State: ABuFfogcA0GNy/cMt8eM4OhyI18hYerC1TkpjFHbOaUVacVUtv7gizY3
        txUzIAmkJWqWOib9/DAl8LyNsK3NUQGPx7jyLqwFdOMW6B3xR0Fsl2SPje0G3fH4IPWzKCAQXdc
        ydm2XE7BUFpo1T/0Naknkw5x3JrvARWB9mk8BWpnxmLl2EYoUJxn0nPm7NCfr1qcOav6J9H8mCk
        Qi
X-Google-Smtp-Source: ACcGV60ydPhfFtOaMEB+Jvd1wyexSkA7pVr//vU3RiulsYyco8HMn/E/hYkzX0Iw379UqedkoNbIjNRogO/0hTTi1rpl
X-Received: by 2002:a24:e48b:: with SMTP id o133-v6mr2770461ith.0.1539220886135;
 Wed, 10 Oct 2018 18:21:26 -0700 (PDT)
Date:   Wed, 10 Oct 2018 18:21:19 -0700
In-Reply-To: <20181009193445.21908-1-szeder.dev@gmail.com>
Message-Id: <cover.1539219248.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181009193445.21908-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 0/2] Per-commit filter proof of concept
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        stolee@gmail.com, avarab@gmail.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did my own experiments on top of what Szeder provided - the first
patch is to have one fixed-size bloom filter per commit, and the second
patch makes that bloom filter apply to only the first parent of each
commit. The results are:

  Original (szeder's)
  $ GIT_USE_POC_BLOOM_FILTER=$((8*1024*1024*8)) time ./git commit-graph write
  0:10.28
  $ ls -l .git/objects/info/bloom
  8388616
  $ GIT_TRACE_BLOOM_FILTER=2 GIT_USE_POC_BLOOM_FILTER=y time ./git -c \
    core.commitgraph=true rev-list --count --full-history HEAD -- \
    t/valgrind/valgrind.sh
  886
  bloom filter total queries: 66459 definitely not: 65276 maybe: 1183 false positives: 297 fp ratio: 0.004469
  0:00.24

  With patch 1
  $ GIT_USE_POC_BLOOM_FILTER=256 time ./git commit-graph write
  0:16.22
  $ ls -l .git/objects/info/bloom
  1832620
  $ GIT_TRACE_BLOOM_FILTER=2 GIT_USE_POC_BLOOM_FILTER=y time ./git -c \
    core.commitgraph=true rev-list --count --full-history HEAD -- \
    t/valgrind/valgrind.sh
  886
  bloom filter total queries: 66459 definitely not: 46637 maybe: 19822 false positives: 18936 fp ratio: 0.284928
  0:01.53

  With patch 2
  $ GIT_USE_POC_BLOOM_FILTER=256 time ./git commit-graph write
  0:06.70
  $ ls -l .git/objects/info/bloom
  1832620
  $ GIT_TRACE_BLOOM_FILTER=2 GIT_USE_POC_BLOOM_FILTER=y time ./git -c \
    core.commitgraph=true rev-list --count --full-history HEAD -- \
    t/valgrind/valgrind.sh
  886
  bloom filter total queries: 53096 definitely not: 52989 maybe: 107 false positives: 89 fp ratio: 0.001676
  0:01.29

For comparison, a non-GIT_USE_POC_BLOOM_FILTER rev-list takes 3.517
seconds.

I haven't investigated why patch 1 takes longer than the original to
create the bloom filter.

Using per-commit filters and restricting the bloom filter to a single
parent increases the relative power of the filter in omitting tree
inspections compared to the original (107/53096 vs 1183/66459), but the
lack of coverage w.r.t. the non-first parents had a more significant
effect than I thought (1.29s vs .24s). It might be best to have one
filter for each (commit, parent) pair (or, at least, the first two
parents of each commit - we probably don't need to care that much about
octopus merges) - this would take up more disk space than if we only
store filters for the first parent, but is still less than the original
example of storing information for all commits in one filter.

There are more possibilities like dynamic filter sizing, different
hashing, and hashing to support wildcard matches, which I haven't looked
into.

Jonathan Tan (2):
  One filter per commit
  Only make bloom filter for first parent

 bloom-filter.c | 31 ++++++++++++++++++-------------
 bloom-filter.h | 12 ++++--------
 commit-graph.c | 30 ++++++++++++++----------------
 revision.c     | 29 +++++++++++++++--------------
 4 files changed, 51 insertions(+), 51 deletions(-)

-- 
2.19.0.271.gfe8321ec05.dirty

