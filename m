Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2D620D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdFASVL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:21:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34598 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFASVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:21:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so13309093wmf.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e90uVgUse8tN5C/YvkMQv+lwg1NB6ctqp5TXvVAqceg=;
        b=JETEbhzTetvVp0Dcu6GU24aJx4tzKK1CQM7eE1W1v/zBZhxI2DSsHcyWxxvfWrZZMG
         44lVoCqwyQpaB25ljcjv6sYUni5IaotCdg8i/W3gl9+DHJOG0TD0ADOPKJdGjOWReyIG
         hxoik6SxtaIR4ftB9v5MSfkY/VYTfIdF14Gm1+4vuCvZHE0Lr5blRBa8dLI3YERcaiUp
         2BgCwRUW8gAd796nAuLS9CCU/jX+A4CucPP8ypZCVzfAGc5Ev9RIpfJW0IIJG/7mTPto
         /lfINzzmy4VyMlt56j8iyPXzuzprn72lwU7iO8YfaZOy8tzKPw/rPYC5x08Nay54xA0d
         MDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e90uVgUse8tN5C/YvkMQv+lwg1NB6ctqp5TXvVAqceg=;
        b=sq3MfJ4sQ9HmWMF7Z3IlkoHhyx8mzVOyfDHWY5Bc1loNIHtRzl/AjB01h9hS5xXYXo
         9dlbXLiWwS2FHTPg7BX1ZAjffx3i2Q4yvvReAA4skZSh87yX33Fwny7tqG8Ktt/rtfoA
         xqNzSDXI3n4CRTrqkEfhW5EdNRG364xG74l04CKe3Auy64NmHTqASang68bUL8kGtg2N
         0L8d1BHiliWpVhnHyB6RnuetoBtx5scqzuTyykFwFQtUh15X9eww77lqVwo14dKK9Y5/
         4S4fWMWun6bJEIR3jc3DwT7TCndRzva2+7k2hvkmqdWrMnAIEcuKhTKekH45yZYvgOnu
         g8ZA==
X-Gm-Message-State: AODbwcCj0XxWGhEXyvPYqNn6Mai4nrB4AKdz2EfLhaRYiAAsMQJ5BlMK
        6TS9jCJ7k3yAh/ntjVBVKw==
X-Received: by 10.28.38.68 with SMTP id m65mr376804wmm.25.1496341268684;
        Thu, 01 Jun 2017 11:21:08 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 140sm151065wmu.23.2017.06.01.11.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 11:21:07 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/8] PCRE v2, PCRE v1 JIT, log -P & fixes
Date:   Thu,  1 Jun 2017 18:20:48 +0000
Message-Id: <20170601182056.31142-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See <20170525200528.22037-1-avarab@gmail.com> for v3
(https://public-inbox.org/git/20170525200528.22037-1-avarab@gmail.com/).

This is on top of "[PATCH v4 00/31] Easy to review grep & pre-PCRE
changes".

Changes:

Ævar Arnfjörð Bjarmason (8):
  grep: don't redundantly compile throwaway patterns under threading
  grep: skip pthreads overhead when using one thread
  log: add -P as a synonym for --perl-regexp
  grep: add support for the PCRE v1 JIT API
  grep: un-break building with PCRE < 8.32
  grep: un-break building with PCRE < 8.20

No changes.

  grep: un-break building with PCRE >= 8.32 without --enable-jit

NEW: It turns out that a PCRE version that supports JIT, but is built
without JIT support will fail at link time since there's no
pcre_jit_exec symbol.

It also turns out (contrary to what I claimed on list before, my
mistake) that there's no way to detect this through some macro. All
the pcre include files are the same with/without --enable-jit, only
the object file differs.

So there's now a NO_LIBPCRE1_JIT flag to the Makefile, which is off by
default, but turned on on MinGW. I have not tested that
config.mak.uname change, but everything else I could test on Linux.

The reason for why it's NO_LIBPCRE1_JIT not USE_LIBPCRE1_JIT is that
in practice pretty much everyone who builds pcre builds it with JIT
(I've looked through various Linux/BSD distro build files), it's MinGW
that's the exception here. Given the performance gain it makes sense
to make it the default.

  grep: add support for PCRE v2

Almost no changes, just:

 * A trivial change to stop redundantly assigning to pcre2_jit_on,
   mistakenly left over from an earlier version.

 * Updated commit message / perf numbers for the extra patches in the
   series both here and in v3.

 Documentation/rev-list-options.txt |   1 +
 Makefile                           |  49 ++++++++--
 builtin/grep.c                     |  16 +++-
 config.mak.uname                   |   1 +
 configure.ac                       |  77 ++++++++++++---
 grep.c                             | 185 ++++++++++++++++++++++++++++++++++++-
 grep.h                             |  33 +++++++
 revision.c                         |   2 +-
 t/t4202-log.sh                     |  12 +++
 t/test-lib.sh                      |   2 +-
 10 files changed, 349 insertions(+), 29 deletions(-)

-- 
2.13.0.303.g4ebf302169

