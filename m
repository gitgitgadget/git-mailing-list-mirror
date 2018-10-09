Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783D91F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 19:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeJJCxm (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 22:53:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45825 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJCxl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 22:53:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so3078545wrw.12
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 12:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3O25GXctm7QLEpcINjbdJcMBfwUQzdZJNrpvy0FGII=;
        b=fYEXX9KpQxOIvww+l5NR8JNoyyryKu3LqKuvrvZX4vnPT0etKswUYVsvf+Rlyzw7EF
         L9IkcqbD5rjWddUq6wA72qpkTaCwlrnnacReWvrUz3hiJynM4Q8eKlB0/onJmxQVM/W+
         scnx3FjiDUxLRTOqJAWq3C/N85hlqGYyrhkITBqDfr913N70opZj4e2+YCoX1ZuuNyCh
         GZZ9r/r/GTxOJFOeN+vC1JCORMabORZGw0dzyK6QBdi+csBFWfzycDx6uvyEE04cWzMs
         2bPe0TIpzssg5CzP3NmwUZUKIuf6q5Bt3wOvS7PkBYWBElxCZnuXC8ByKNgUvUyZ893I
         QXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3O25GXctm7QLEpcINjbdJcMBfwUQzdZJNrpvy0FGII=;
        b=OUnNT/nM/pYW0k0KcAPXA8a0aklmvqklpu+JF9roPfWIklGFHl1xZrM5BRCiWj3vue
         lCEgwSfml5B75w4+Dwno8jVCtaYX1pTx653WIDqP75ApQtNZMlCPyYMOBKlK8pLVU+Nk
         RUdAF51GhJMVi+VEbHtApieTEL96+H13lXxV7hsRS7A5RokPkBDA6XR/U/62LToYUtlq
         AJQ4Xx71BWazTWBdej7IeI5M/VERDbWA3Q+1/wDTZryZuLKqqpxNGEf1cunpxgdH9PqE
         N0HNQAhSL9Fx2RfelmLAKXGprA/D/1gdvw8Jkt/fWaUaQ/hEuEGtXk4MRxvPgiXihcMG
         E2Gw==
X-Gm-Message-State: ABuFfoiuIvA9gAu6CC0YXiVq4b/hRuNcjIgSVtYMQ9VgAeCBetoQgtWZ
        aSPG/L7snRKGnxFX3lL/Nr/O7X9P
X-Google-Smtp-Source: ACcGV61VLZZTb6O4bKwrYYW8gwCx6Os3RX46Ff1au2XxAuUonyriAMybuYUnToy8Vi35xOrAtURqwA==
X-Received: by 2002:a5d:6692:: with SMTP id l18-v6mr22949313wru.154.1539113710263;
        Tue, 09 Oct 2018 12:35:10 -0700 (PDT)
Received: from localhost.localdomain (x4dbd5132.dyn.telefonica.de. [77.189.81.50])
        by smtp.gmail.com with ESMTPSA id e6-v6sm18823117wrc.70.2018.10.09.12.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 12:35:09 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/4] Bloom filter experiment
Date:   Tue,  9 Oct 2018 21:34:41 +0200
Message-Id: <20181009193445.21908-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.409.g0a0ee5eb6b
In-Reply-To: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To keep the ball rolling, here is my proof of concept in a somewhat
cleaned-up form, with still plenty of rough edges.

You can play around with it like this:

  $ GIT_USE_POC_BLOOM_FILTER=$((8*1024*1024*8)) git commit-graph write
  Computing commit graph generation numbers: 100% (52801/52801), done.
  Computing bloom filter: 100% (52801/52801), done.
  # Yeah, I even added progress indicator! :)
  $ GIT_TRACE_BLOOM_FILTER=2 GIT_USE_POC_BLOOM_FILTER=y git rev-list --count --full-history HEAD -- t/valgrind/valgrind.sh
  886
  20:40:24.783699 revision.c:486          bloom filter total queries: 66095 definitely not: 64953 maybe: 1142 false positives: 256 fp ratio: 0.003873

The value of $GIT_USE_POC_BLOOM_FILTER only really matters when writing
the Bloom filter, and it specifies the number of bits in the filter's
bitmap, IOW the above command creates a 8MB Bloom filter.  To make use
of the filter the variable can be anything non-empty.

Writing the Bloom filter is very slow as it is (yeah, that's why
bothered with the progress indicator ;).  I wrote about it in patch 2's
commit message: the cause for about half of the slowness is rather
obvious, but I don't (yet) know what's responsible for the other half.


Not a single test...  but I've run loops over all files in git.git
comparing 'git rev-list HEAD -- $file's output with and without the
Bloom filter, and, surprisingly, they match.  My quick'n'dirty
experiments usually don't fare this well...


It's also available at:

  https://github.com/szeder/git bloom-filter-experiment


SZEDER Gábor (4):
  Add a (very) barebones Bloom filter implementation
  commit-graph: write a Bloom filter containing changed paths for each
    commit
  revision.c: use the Bloom filter to speed up path-limited revision
    walks
  revision.c: add GIT_TRACE_BLOOM_FILTER for a bit of statistics

 Makefile       |   1 +
 bloom-filter.c | 103 +++++++++++++++++++++++++++++++++++++++
 bloom-filter.h |  39 +++++++++++++++
 commit-graph.c | 116 ++++++++++++++++++++++++++++++++++++++++++++
 pathspec.h     |   1 +
 revision.c     | 129 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 389 insertions(+)
 create mode 100644 bloom-filter.c
 create mode 100644 bloom-filter.h

-- 
2.19.1.409.g0a0ee5eb6b

