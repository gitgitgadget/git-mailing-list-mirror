Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SUBJ_ALL_CAPS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8E31F406
	for <e@80x24.org>; Wed, 16 May 2018 22:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeEPWVj (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:21:39 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:42351 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeEPWVc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:32 -0400
Received: by mail-pg0-f51.google.com with SMTP id p9-v6so884278pgc.9
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ct9y5VaAXrYuBR9bRnm+5q9iYP/wpub+i84qQMY8Pn0=;
        b=Y29h4aVzvhaTwmuW5BAH6Oma5088dpQ/MXOkScPZZ1jrz4s6Kf7FKMO7XFk0ZV928Y
         4jLbRr2HU8Dn2FCBs6qPe61efNcP0x7QmqD13KIIqkZXXvyYC9eBNHp87UdoGKjFkIOr
         61YGnZTWvvoE3vhC78weCycQ8YoXCVCCITj2SO3n2QAbsuxTHf1xP2JFGyLfdQpdaOpv
         42voob0bBu1Leo215LCpGoGuMHWyOiIcKpfa/qeqIbUC/dXmY9lVfLDBPMmUZMAx12PH
         KErhVyFNhf2WAoh01hcFE/ohDRSrQ8s5nOQz1KqenwOL0oqb/Qx8EP1uaKemRclf/0qN
         7X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ct9y5VaAXrYuBR9bRnm+5q9iYP/wpub+i84qQMY8Pn0=;
        b=dYX4RTWyUSg9Qq/nOxJA1rAjdoqZoh/40HJf874JBaQabTJXBUr9sJ2PMloBcc99f0
         mKVHhIWuyZAJj6gak5lf+EPEjHsa6YZpPpBZYjVYh7lh81sPk35YFDPrCTKLNaRDeXG/
         Ifjskhj4BarzKbNjetOofTqFwfcbyAIL3YnbOpG5smr4Kzx5SW5KPkJDORvtBNjtLSJn
         GzRavff3SW4wCWEM71yW9fkLklV5S2ECRo0IX3C7BTWSEkk3x03NEG4x9ZrLFn77Yjnt
         ZvRygiGg1r9phc6ak+TA6ATcmpZ0sfetcIRwhAwFYQHbjb5aT54B17K41FbBAtO6TWil
         IgRg==
X-Gm-Message-State: ALKqPwdWYi/E/cvcYmk9da/+aHOByE1Fa7qRTiHoP45F72jW/nLZiDTT
        GVpwnFZbndWgd0Hu9ekCzuRp8g==
X-Google-Smtp-Source: AB8JxZpKfk9vQh7Umcs+FY92qmugH6FGtgKBQdUFNE9xmizrigOE+hB3VUD9KmPFwNOrogpz2M40Ug==
X-Received: by 2002:a63:7f07:: with SMTP id a7-v6mr2128490pgd.173.1526509291280;
        Wed, 16 May 2018 15:21:31 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k84-v6sm8551827pfh.93.2018.05.16.15.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 00/11] 
Date:   Wed, 16 May 2018 15:21:07 -0700
Message-Id: <20180516222118.233868-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If you have time, yes translate them all. I don't see how any of these
> strings are meant for script. If not, just _() the new string you
> added is fine.

> With a majority of call sites dying like this though, I wonder if we
> should just add repo_read_index_or_die() with die() inside. Then the
> next person won't likely accidentally forget _()

So this comment tricked me into coming up with a patch series. :)

Each patch is themed, I tried to make each commit special w.r.t. reviewers
attention.

We'd start out with a resend of the origin patch, which is boring.

Then we'll move all similar cases into one function (no-op for
introducing the repo_read_index_or_die function as all callers will have the
same error message and the same localisation).

Any following patch will be more controversial then the previous patches,
I would expect, as we introduce more and more change.

The last patch is just an attempt to finish the series gracefully,
and may contain errors (sometimes we do not want to die() in case of
corrupt index).

Is this series roughly what you had in mind?

Thanks,
Stefan


Stefan Beller (11):
  grep: handle corrupt index files early
  repository: introduce repo_read_index_or_die
  builtin/grep: use repo_read_index_or_die
  submodule: use repo_read_index_or_die
  builtin/ls-files: use repo_read_index_or_die
  read_cache: use repo_read_index_or_die with different error messages
  rerere: use repo_read_index_or_die
  check-attr: switch to repo_read_index_or_die
  checkout-index: switch to repo_read_index
  test helpers: switch to repo_read_index_or_die
  read_cache: convert most calls to repo_read_index_or_die

 blame.c                              |  5 +++--
 builtin/add.c                        |  7 +++----
 builtin/am.c                         |  3 ++-
 builtin/check-attr.c                 |  5 ++---
 builtin/check-ignore.c               |  7 ++++---
 builtin/checkout-index.c             |  5 ++---
 builtin/clean.c                      |  4 ++--
 builtin/commit.c                     |  9 +++++----
 builtin/diff.c                       |  3 ++-
 builtin/fsck.c                       |  3 ++-
 builtin/grep.c                       |  2 +-
 builtin/ls-files.c                   |  7 +++----
 builtin/merge-index.c                |  3 ++-
 builtin/mv.c                         |  3 +--
 builtin/reset.c                      |  3 +--
 builtin/rev-parse.c                  |  4 ++--
 builtin/rm.c                         |  3 +--
 builtin/submodule--helper.c          |  3 +--
 check-racy.c                         |  2 +-
 diff.c                               |  5 +++--
 merge-recursive.c                    |  3 ++-
 merge.c                              |  4 ++--
 repository.c                         |  6 ++++++
 repository.h                         |  8 ++++++++
 rerere.c                             | 10 ++++------
 revision.c                           |  5 +++--
 sequencer.c                          |  5 +++--
 sha1-name.c                          |  2 +-
 submodule.c                          |  3 +--
 t/helper/test-dump-cache-tree.c      |  5 ++---
 t/helper/test-dump-untracked-cache.c |  4 ++--
 t/helper/test-lazy-init-name-hash.c  | 11 ++++++-----
 t/helper/test-read-cache.c           |  3 ++-
 t/helper/test-scrap-cache-tree.c     |  4 ++--
 t/helper/test-write-cache.c          |  3 ++-
 35 files changed, 89 insertions(+), 73 deletions(-)

-- 
2.17.0.582.gccdcbd54c44.dirty

