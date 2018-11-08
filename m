Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D225A1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 21:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeKIGxD (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 01:53:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50240 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeKIGxD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 01:53:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id 124-v6so122259wmw.0
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 13:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35xaGFrktmcPNJ1DAP1ZLbBMVt4yglqQyTjgu/X4bRw=;
        b=SP4wdj3OxIthtlOBulD8ple2FL/T75cJU4FjioQE3tHwNqx3aaBAc7Gtfgt1tZmuNV
         Wp0v/Rh3bovUxCPWyOqC4FjQ0kWhGYA7Uqc/A3gfYSpgh88LtSqDOa09yCVQ5TwjGhHH
         fjqZ4SLRw8tlbVE1THddQtoZ9Tm4V8cbpSnj4ULBudPnfmZAIjbZ54iYvA4/+5XveODr
         jXCdR7LjOmFknAsQvWsV6KkXIpCzMRTRBfRyxb4jTZatHsUJIma0Iin8hnSW24FaNOQG
         g3zusdzANc9XbinmEgAbdi1uKVaNahcSunzoqr/AZM7RRukq+iMLwbj0lICdTQ8K0pBj
         l+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35xaGFrktmcPNJ1DAP1ZLbBMVt4yglqQyTjgu/X4bRw=;
        b=Su6UtqJzYn+01YS9yEyvwSlRn09Cacznj8c5pV2/GYEH6m3GoALtJxi6zX7lL5jEgk
         q0cA/rWjP2JZLCRCgOG5RVRnVdO/uQYsPApqPG8fhFbjEueC/R1RtTPJvU1Uh3RkcGU2
         sY0JBF48OpO/sJuSN+ICTVNE0XyxpFooYuPnreQj1/iwC2atVzDN4dnmvGPe3hvUyM+P
         5f8ugRcizsKsAcgZG03EjaMeMBRODjGp65cploiUl1z/QA3S1WoMV7H2am1dPrchgHGi
         9DVPt4gsnqDiXmNVx7BGMXpLvONe/yRsKT4e179HtouUAQgsrxvjV4yitunSaW1XKU3z
         nabA==
X-Gm-Message-State: AGRZ1gKBxqjUR35e6ujH+3+ktNHFXd4UeRCpr7nIJQxYUeMcv+qRdNAB
        XhRi/ZXiunsWIEXW5aiWwEEdraZP
X-Google-Smtp-Source: AJdET5fO5umLGbb8KFixeQZjMVX8KMXAITg/ziSct5bbth+1C6i+1PWj/qAK8hI5MStYUamqgRmU0g==
X-Received: by 2002:a1c:4407:: with SMTP id r7-v6mr2560723wma.16.1541711741130;
        Thu, 08 Nov 2018 13:15:41 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e66-v6sm9036262wmf.40.2018.11.08.13.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 13:15:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/2] i18n: make GETTEXT_POISON a runtime option
Date:   Thu,  8 Nov 2018 21:15:28 +0000
Message-Id: <20181108211530.29017-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <20181101193115.32681-1-avarab@gmail.com>
References: <20181101193115.32681-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses all the feedback against v3. Includes a patch by Junio
sitting in "pu" (and I fixed the grammar error Eric pointed out in its
commit message).

Range-diff:

1:  cc24ba8de8 ! 1:  2210ee8bd9 i18n: make GETTEXT_POISON a runtime option
    @@ -34,11 +34,11 @@
     
         Notes on the implementation:
     
    -     * We still compile a dedicated GETTEXT_POISON build in Travis CI.
    -       This is probably the wrong thing to do and should be followed-up
    -       with something similar to ae59a4e44f ("travis: run tests with
    -       GIT_TEST_SPLIT_INDEX", 2018-01-07) to re-use an existing test setup
    -       for running in the GIT_TEST_GETTEXT_POISON mode.
    +     * We still compile a dedicated GETTEXT_POISON build in Travis
    +       CI. Perhaps this should be revisited and integrated into the
    +       "linux-gcc" build, see ae59a4e44f ("travis: run tests with
    +       GIT_TEST_SPLIT_INDEX", 2018-01-07) for prior art in that area. Then
    +       again maybe not, see [2].
     
          * We now skip a test in t0000-basic.sh under
            GIT_TEST_GETTEXT_POISON=YesPlease that wasn't skipped before. This
    @@ -56,12 +56,22 @@
            so we populate the "poison_requested" variable in a codepath that's
            won't suffer from that race condition.
     
    -    See also [3] for more on the motivation behind this patch, and the
    +     * We error out in the Makefile if you're still saying
    +       GETTEXT_POISON=YesPlease to prompt users to change their
    +       invocation.
    +
    +     * We should not print out poisoned messages during the test
    +       initialization itself to keep it more readable, so the test library
    +       hides the variable if set in $GIT_TEST_GETTEXT_POISON_ORIG during
    +       setup. See [3].
    +
    +    See also [4] for more on the motivation behind this patch, and the
         history of the GETTEXT_POISON facility.
     
         1. https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/
    -    2. https://public-inbox.org/git/87woq7b58k.fsf@evledraar.gmail.com/
    -    3. https://public-inbox.org/git/878t2pd6yu.fsf@evledraar.gmail.com/
    +    2. https://public-inbox.org/git/20181102163725.GY30222@szeder.dev/
    +    3. https://public-inbox.org/git/20181022202241.18629-2-szeder.dev@gmail.com/
    +    4. https://public-inbox.org/git/878t2pd6yu.fsf@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -181,7 +191,7 @@
      #else
      static inline void git_setup_gettext(void)
      {
    -+	use_gettext_poison();; /* getenv() reentrancy paranoia */
    ++	use_gettext_poison(); /* getenv() reentrancy paranoia */
      }
      static inline int gettext_width(const char *s)
      {
    @@ -392,8 +402,32 @@
      --- a/t/test-lib.sh
      +++ b/t/test-lib.sh
     @@
    + TZ=UTC
    + export LANG LC_ALL PAGER TZ
    + EDITOR=:
    ++
    ++# GIT_TEST_GETTEXT_POISON should not influence git commands executed
    ++# during initialization of test-lib and the test repo. Back it up,
    ++# unset and then restore after initialization is finished.
    ++if test -n "$GIT_TEST_GETTEXT_POISON"
    ++then
    ++	GIT_TEST_GETTEXT_POISON_ORIG=$GIT_TEST_GETTEXT_POISON
    ++	unset GIT_TEST_GETTEXT_POISON
    ++fi
    ++
    + # A call to "unset" with no arguments causes at least Solaris 10
    + # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
    + # deriving from the command substitution clustered with the other
    +@@
    + test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
      test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
      
    ++if test -n "$GIT_TEST_GETTEXT_POISON_ORIG"
    ++then
    ++	GIT_TEST_GETTEXT_POISON=$GIT_TEST_GETTEXT_POISON_ORIG
    ++	unset GIT_TEST_GETTEXT_POISON_ORIG
    ++fi
    ++
      # Can we rely on git's output in the C locale?
     -if test -n "$GETTEXT_POISON"
     +if test -z "$GIT_TEST_GETTEXT_POISON"
-:  ---------- > 2:  a6948d936a Makefile: ease dynamic-gettext-poison transition


Junio C Hamano (1):
  Makefile: ease dynamic-gettext-poison transition

Ævar Arnfjörð Bjarmason (1):
  i18n: make GETTEXT_POISON a runtime option

 .travis.yml               |  2 +-
 Makefile                  |  8 +-------
 ci/lib-travisci.sh        |  4 ++--
 gettext.c                 | 11 +++++++----
 gettext.h                 |  9 +++------
 git-sh-i18n.sh            |  2 +-
 po/README                 | 13 ++++---------
 t/README                  |  6 ++++++
 t/lib-gettext.sh          |  2 +-
 t/t0000-basic.sh          |  2 +-
 t/t0205-gettext-poison.sh |  8 +++++---
 t/t3406-rebase-message.sh |  2 +-
 t/t7201-co.sh             |  6 +++---
 t/t9902-completion.sh     |  3 ++-
 t/test-lib-functions.sh   |  8 ++++----
 t/test-lib.sh             | 22 +++++++++++++++++-----
 16 files changed, 59 insertions(+), 49 deletions(-)

-- 
2.19.1.930.g4563a0d9d0

