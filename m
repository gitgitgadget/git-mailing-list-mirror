Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD58209FD
	for <e@80x24.org>; Thu, 25 May 2017 20:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161731AbdEYUFl (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 16:05:41 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33454 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161618AbdEYUFk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 16:05:40 -0400
Received: by mail-wm0-f48.google.com with SMTP id m7so1012222wmg.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLxPy8lWffFHBauNr8UBSAKQZysBdGWyVuz1LE58LFQ=;
        b=s7hA3VxV3vpuMVGhzkiZ7cwrARaTinLBqrjbdB9eYzD2xtJhW4CrWe6UWXlBENckPS
         KqgQNQPhTMLqM5QXr8H9+pgyUhzPiteLxsMj/7uPmdQDJ0q9qAUzb++X2tnuQaXzaVYd
         XfQ7TO1mGfXqFEbJTeCXSQWyc8Qhn79DFR6B4Wvs3878TVLdGC111vQGC5ttfz7pAjMY
         VpwdtlwJObFO0V31NzCQa+4QA1QwwD1MXF5ijRtdJvmRgZva9bKDX/y96rYQ5HympdNN
         uKwNW0kOQ3Qw7HexhrFw5k+wao5tNnhg88npCEf/huvwqt4/zYslT6rgkADJwymNDmqC
         aEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLxPy8lWffFHBauNr8UBSAKQZysBdGWyVuz1LE58LFQ=;
        b=UUebtolleNnDTTxA60eeyfpykIViiyvw1Kx2zrELJE0bMbQCVaEg1cSdML7piPdp9V
         5ikfgRzBM+5DSvWnGdCz53uvT6Loj7Asa3kny63erpPFwjROCO1Kceyk7mFRD/XvgId2
         +fX4Bzxf1n+oxCeUkgfHYVbXF2up2vxmJsP5E/g2rgmBulYGqm/5T+PrDyFlm6IduNkN
         bwOSGeTv9/dPM5ZDJzKk182dbwSvJgrhiLY8QLJ/3xVyGJzRY2QKw3QYGy11eSUHhPyx
         HUajodbG50jzqB4kBZxLvCSHSV1nCF25K0hUNp0rO8NKVqDT/YcDEwOAN/98MqbLWEPV
         wSTw==
X-Gm-Message-State: AODbwcAgzEB8wHSEIPB3O5q74WMLOBkIdX1CG3j0bQJWXemIue8/W2pw
        OXsoE6Nd7lETew==
X-Received: by 10.28.149.68 with SMTP id x65mr10431640wmd.66.1495742739421;
        Thu, 25 May 2017 13:05:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id r60sm10574313wrb.37.2017.05.25.13.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 13:05:38 -0700 (PDT)
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
Subject: [PATCH v3 0/7] PCRE v2, PCRE v1 JIT, log -P & fixes
Date:   Thu, 25 May 2017 20:05:21 +0000
Message-Id: <20170525200528.22037-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See <20170523192453.14172-1-avarab@gmail.com> for v2
(https://public-inbox.org/git/20170523192453.14172-1-avarab@gmail.com/).

This on top of "[PATCH v4 00/31] Easy to review grep & pre-PCRE
changes".

This hopefully addresses all the comments I had on v2. Comments below:

Ævar Arnfjörð Bjarmason (7):
  grep: don't redundantly compile throwaway patterns under threading
  grep: skip pthreads overhead when using one thread
  log: add -P as a synonym for --perl-regexp

No changes.

  grep: add support for the PCRE v1 JIT API

 * Simplify logic around canjit variable.

 * s/BUG: // for things that aren't internal bugs (but keep it for one
   that's an actual bug if it happens...)

 * Simplify syntax around `#ifdef PCRE_CONFIG_JIT` blocks.

  grep: un-break building with PCRE < 8.32

 * Reword commit message for less confusion.

 * Macro name: s/GIT_PCRE1_CAN_DO_MODERN_JIT/GIT_PCRE1_USE_JIT/g

  grep: un-break building with PCRE < 8.20

No changes.

  grep: add support for PCRE v2

 * Makefile: Clarify comment about what LIBPCREDIR=* does now.

 * Makefile: One use of USE_LIBPCRE is now USE_LIBPCRE1. It's
   logically the same, but less confusing now.

 * grep.c: Fix up comment syntax

 * grep.c: Same canjit & s/BUG: // bug fixes as noted for PCRE v1.

 Documentation/rev-list-options.txt |   1 +
 Makefile                           |  36 +++++--
 builtin/grep.c                     |  16 +++-
 configure.ac                       |  77 ++++++++++++---
 grep.c                             | 187 ++++++++++++++++++++++++++++++++++++-
 grep.h                             |  31 ++++++
 revision.c                         |   2 +-
 t/t4202-log.sh                     |  12 +++
 t/test-lib.sh                      |   2 +-
 9 files changed, 335 insertions(+), 29 deletions(-)

-- 
2.13.0.303.g4ebf302169

