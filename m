Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1362220188
	for <e@80x24.org>; Sat, 13 May 2017 23:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755202AbdEMXpz (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:45:55 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34349 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753044AbdEMXpy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:45:54 -0400
Received: by mail-qt0-f182.google.com with SMTP id c13so9786017qtc.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9gazoCskwL14nmaAsL2rzTMlf93xMb4/970UvZvPOg=;
        b=hhWmDJvMrs8adJdWAYdUMCG9KHPWj9mNogyrQQJv7b29vKMWA94Y7R294qlbPwWOuv
         Wkr2aHAOAv8u0R09eIanYcw1usjIsRDjCKcyINXyBsXsHue4pItqh6iqCNlaLQ7Ojj2E
         gp0hPdJwRMBVxe6F8/2PWtUYhEb/HTVtZct3skO+JrPISFsSbgF+sftPayFJx/Fz+UG/
         JhLB+KV+Y6ABDpEICKiSPW5xS1VZRZciNnZML7JtjCL+1Hm4py4j4kJ2rBx1PClcdwyq
         4YLZlptfv7gy8PG3ds/cpGqqMxaXlooVyF8qhAU/jZfigruoaKBuAyFPywsHYINjZT+z
         20lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9gazoCskwL14nmaAsL2rzTMlf93xMb4/970UvZvPOg=;
        b=swmWbLM5PTf9bwhvBJnVBhMGJiUbF0d0NfVzREScnDqJzyyD0FL1Nu+AxtipyaFDEs
         PODoKyJEzRXz9tjBayMPQTjxhjFBEJmdASt6ZdfiHVNL5r1MC9u/BmIekBXy5wPRZ0iK
         JEt6ji7g7NeClU7P8iZmokvvMSE1MvvcuIccP3X+lLwXFtSFcOlGE50UZ1XUQQzKoHg8
         1NOV3oK1Jb6xbfIplbx67BSqqOe8ZZr62RCisEqq9nQaDrkw/boaEdjCoRb+FuWmAzCr
         9hIWlE1wyp2ZsBZw/BxPWfiOZm0q0K+qM+DRww+LhamcAKwxnoJV/dS9kNf1MnStmrFw
         h+EQ==
X-Gm-Message-State: AODbwcB1IJgVcXfU9VmLliWdnnldcoUDOZAgpZodMkk86133D6+C82nl
        6m4Vzif3SjL/9w==
X-Received: by 10.200.50.49 with SMTP id x46mr10870341qta.105.1494719153278;
        Sat, 13 May 2017 16:45:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h14sm5319234qta.18.2017.05.13.16.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:45:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] PCRE v2, PCRE v1 JIT, log -P & fixes
Date:   Sat, 13 May 2017 23:45:28 +0000
Message-Id: <20170513234535.12749-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trivial changes since v1, but I wanted to send a new one for
completeness since I re-sent the "Easy to review grep & pre-PCRE
changes" series.

For v1 see <20170511170142.15934-1-avarab@gmail.com>
(https://public-inbox.org/git/20170511170142.15934-1-avarab@gmail.com/).

Changes noted below & reply to who noted the issue:

Ævar Arnfjörð Bjarmason (7):
  grep: don't redundantly compile throwaway patterns under threading

Brandon: Added a few paragraphs to the commit message about why this
change is being made, i.e. for ease of understanding the code, not
optimization.

  grep: skip pthreads overhead when using one thread
  log: add -P as a synonym for --perl-regexp
  grep: add support for the PCRE v1 JIT API
  grep: un-break building with PCRE < 8.32
  grep: un-break building with PCRE < 8.20
  grep: add support for PCRE v2

No changes in these, except for re-running the performance tests &
changing the commit messages accordingly, due to the change in the
t/perf code in the previous series, as noted there.

 Documentation/rev-list-options.txt |   1 +
 Makefile                           |  30 +++++--
 builtin/grep.c                     |  16 +++-
 configure.ac                       |  77 +++++++++++++---
 grep.c                             | 180 ++++++++++++++++++++++++++++++++++++-
 grep.h                             |  31 +++++++
 revision.c                         |   2 +-
 t/t4202-log.sh                     |  12 +++
 t/test-lib.sh                      |   2 +-
 9 files changed, 327 insertions(+), 24 deletions(-)

-- 
2.11.0

