Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9611B1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 09:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeKNTRo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 14:17:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36032 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeKNTRo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 14:17:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id s11so4657445wmh.1
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 01:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdzIIBIaLiG+GRwm8fidDkoPGfXbIfvUxQQYJdkwpu4=;
        b=snMYCF304wjTPe5HnR+hduMFPvKaaZHYI+3pWpwcroYnt8wWZJ0SfwvNEUyLr375f6
         NnkaETqAeiAgbcOa+j/o4ox0w+petCENjJ/F4lPm+Yxmkg8CalwFKaaX7NcZnAGpKnsr
         Pmdr4T23WW5VC65ABAR9xCcmpjUWk6ShSJGsA1dpo78a+X/vInAyaZ4YuAw/a+xMCJy5
         xzgrFuqt4XPsQz8euYLHtKI8HXTKXX/kd/7HcX15UGhEBl7xHog7WuR7FNqntxYZOlY8
         ZdNEnoQaUEjl95RPPOGCg/oW6vBbLAf5gQvcxO8rh12FgqcUc3X5meTuXAde2TiGciat
         LV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HdzIIBIaLiG+GRwm8fidDkoPGfXbIfvUxQQYJdkwpu4=;
        b=NHIQ3LPWeZvg49QTY8QGL1HS2PtZyRxi+ovlf4um7+YVs8lNoeEtKnmPEn4o/F8N0z
         BRrB4snU4S7qwcWhvYGbGXONltT38NQfvAYCqbjs5nUr6jjhc1KsrvKO89Yni8k38Z6c
         N52Zva6KgxNPYJTj8psvu4zj4jDbwp+Mw+CGXKm6Z/Qsqax1up/5E1aD4vamuACzsm/u
         82jccgg2biJTGpRKpEqz9eM7CwZJ06TubtaeF+a+Fx+DGek3nkJjUFbUOQ8C94aFk9V8
         XXHYt7gNK9bym5Y+abAECn3DpdkvjkwYemrqw7VUcr1FrRfZMB/0tGKBExfBfaRsOwko
         inwA==
X-Gm-Message-State: AGRZ1gLVtg/Wqo96bhjuQfABYFXIbmbvsf0HsY6gukfCRQA0AeQWzZNI
        rgpweFzFG6WDWvTUe8lGa9rwPazB6pQ=
X-Google-Smtp-Source: AJdET5eR4dwJQit1QhI+aVkuIuXG4HSnmJqNFZNj3ipaIX0pN8Fn1SHd0PtkZFMHGFv+w3GmA/UuVg==
X-Received: by 2002:a1c:9089:: with SMTP id s131-v6mr1204484wmd.66.1542186918472;
        Wed, 14 Nov 2018 01:15:18 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm16385228wrt.49.2018.11.14.01.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 01:15:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] rebase.useBuiltin doc & test mode
Date:   Wed, 14 Nov 2018 09:15:04 +0000
Message-Id: <20181114091506.1452-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <0181114090144.31412-1-avarab@gmail.com>
References: <0181114090144.31412-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was missing a "=" in the t/README docs in 2/2 in v1. Also move the
docs around slightly so this & my gettext series don't have conflicts.

*** BLURB HERE ***

Ævar Arnfjörð Bjarmason (2):
  rebase doc: document rebase.useBuiltin
  tests: add a special setup where rebase.useBuiltin is off

 Documentation/config/rebase.txt | 14 ++++++++++++++
 builtin/rebase.c                |  5 ++++-
 t/README                        |  4 ++++
 3 files changed, 22 insertions(+), 1 deletion(-)

Range-diff:
1:  a5508195c6 ! 1:  ca87aacbfa tests: add a special setup where rebase.useBuiltin is off
    @@ -29,12 +29,13 @@
      --- a/t/README
      +++ b/t/README
     @@
    - index to be written after every 'git repack' command, and overrides the
    - 'core.multiPackIndex' setting to true.
    + GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
    + by overriding the minimum number of cache entries required per thread.
      
    -+GIT_TEST_REBASE_USE_BUILTIN<boolean>, when false, disables the builtin
    -+version of git-rebase. See 'rebase.useBuiltin' in git-config(1).
    ++GIT_TEST_REBASE_USE_BUILTIN=<boolean>, when false, disables the
    ++builtin version of git-rebase. See 'rebase.useBuiltin' in
    ++git-config(1).
     +
    - Naming Tests
    - ------------
    - 
    + GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
    + of the index for the whole test suite by bypassing the default number of
    + cache entries and thread minimums. Setting this to 1 will make the
-- 
2.19.1.1182.g4ecb1133ce

