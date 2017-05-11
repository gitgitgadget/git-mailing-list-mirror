Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF1E2018D
	for <e@80x24.org>; Thu, 11 May 2017 17:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757127AbdEKRCE (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:02:04 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36283 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756019AbdEKRCD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:02:03 -0400
Received: by mail-qk0-f180.google.com with SMTP id u75so27684085qka.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctxe5CkvXpE7pwBOeA5brhoP15g/DnfHrsz5Us/qmTk=;
        b=A7d9k0MHDEVdVWLwCvRIQaSr4NZ8sb2rcNFxEdfokJk8dHiWmDrDieA3rgglneJxGe
         byfZZBQ1t2v7Eh72xo6dKClHRDPTLrCBOrL7qS7nGjqKe3lBdohix7/LUfWa0wA6Cnnc
         WghSLFdOhLfevo17ZpSBQ38Swl/B1FZNl1gWSRvS1CiBKALJCXnvpXGGWtENn6aKTj5D
         5QjfkgsuY5JsDr5DKLYdvWAwQFwV+xI76fAZxP82bqjnWdgOifcYn26svg9P8qMBP9NW
         lvaoiRrXp9SqOvWSu6k5qOdtG8w67mx0guafReBCb/aTCo1vcTmnzvjrbT0Tyd4o6guw
         LHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ctxe5CkvXpE7pwBOeA5brhoP15g/DnfHrsz5Us/qmTk=;
        b=GsjEfZqhu07yCtoKcrZ/Iz5EuFlCQlRsZ6azuOwzrcprHDj+bupWn8n881kwBiJtWb
         qxBGnMMC3uQkNXM2XkO1N4ArVwSmWzkIsZLVn0Y1jaJArq33Sjrvx/3iyk8M6Oqfpcpe
         Avrej4vF3BfHstlO9XPDp7/4Xu3sr3w4zKS/tA3xU8BOU8a5MoXGNxV/USl8ndJWNNjx
         E0cKVyEz1gy+g8PZ6+V4xBWCOziaWPDN1suFOshHxVblmz04VCR2fH7GPWnW/v6XJsgi
         crCIaPiZky937Ee66kLHUAo9U2hqOSb3EOCRhUf5lMUAsuCyGnxWV6wocuJcONHmQ2m9
         1Ldg==
X-Gm-Message-State: AODbwcAl1GP3+OGn37PYa1MsFH5oS9L6gVnqhEp748OLNQmeJMwTwbAt
        jtpl0TPGGG6LJQ==
X-Received: by 10.55.97.202 with SMTP id v193mr131073qkb.186.1494522122271;
        Thu, 11 May 2017 10:02:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10sm480407qte.15.2017.05.11.10.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:02:01 -0700 (PDT)
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
Subject: [PATCH 0/7] PCRE v2, PCRE v1 JIT, log -P & fixes
Date:   Thu, 11 May 2017 17:01:35 +0000
Message-Id: <20170511170142.15934-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of the 29 patch series of "Easy to review grep &
pre-PCRE changes" (<20170511091829.5634-1-avarab@gmail.com>;
https://public-inbox.org/git/20170511091829.5634-1-avarab@gmail.com/).

This could be split into 3 unrelated things, but I have think it's
probably easier for everyone to bundle these up, since they all go on
top of the other series. Comments below:

Ævar Arnfjörð Bjarmason (7):
  grep: don't redundantly compile throwaway patterns under threading
  grep: skip pthreads overhead when using one thread

Internal changes to grep to not redundantly spawn threads. No
functional changes, just internal cleanup.

  log: add -P as a synonym for --perl-regexp

Trivial change to add -P.

  grep: add support for the PCRE v1 JIT API
  grep: un-break building with PCRE < 8.32
  grep: un-break building with PCRE < 8.20

I tested ancient versions of PCRE, which turned up build issues that
are fixed this time around.

  grep: add support for PCRE v2

The main point of this whole thing.

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

