Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB961F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeAZMhX (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:23 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51109 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeAZMhW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:22 -0500
Received: by mail-wm0-f52.google.com with SMTP id f71so992297wmf.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eybaawxfQt3q4i6i08HIstQJhpX2r7wyt24lcUu05/Q=;
        b=itonKobLHCiyhYYoFmtuJV2gI8Sd88xKBax/B7xlqLpTIMbdTWH0LOclekjYj2iTx6
         BNdylvgopQrPjxFQzMlbALOLzE7DkIUQFKuOMXnCu8Kiqk6xoKX4fxFcaU+cHZsOcvTK
         ImOd30lOlwpeDRwdC1IvV5mlmLQOr9gklDL2ItLrchc4nFS8543Ja4Gw/MdxNr4EVnD8
         4UHaEiye9qP2zM7v+CN+hbe38EnNKSAXzflFFAtmAwXA35eaEaAPjIvUKo3Er3CPmHr9
         NeNCP9Xihox1NtaT9Pq3VhYWPM8EEQTDHn/Xo31TzcxZAxwqlaX0PzebBfeHpGfx36sI
         vL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eybaawxfQt3q4i6i08HIstQJhpX2r7wyt24lcUu05/Q=;
        b=DshzDoPanTAu4hB4/qyt0grq7386iDySmVf2+Mub0a/NkCH5bep8/EglmLQKE7KESY
         MXCh7NiKuqyH6cXcwEttVI54Ewzsv2+R4jcVDMWb13RO4VUPEiz5smYuGW8Mb96QEshE
         NdmlgllMJqNIOJBMNK9vBUbVc6mrLSTqt3uPWPl1FEH8uqR0VBeEcoRvbXewfCecE7bl
         ErCQhJrkkPhlx/fmbRiNysvU47IZ5gLRYZ4aIazytif0M/ugJ4+qHMn46DNciuSk15Bu
         EgJ2OmTvU0BY+CemzmiTUzOfU4GQbPbVDiSFVC76GUMjNuAr1lMbbpBMQ04rUAZLXmW0
         P2/A==
X-Gm-Message-State: AKwxytfj3bDmH4cSkeMUfrry9nAa1BKMtLOkoVyuOiw9oKxvUWEJQWNF
        AKmHFb+8R1jjthyBbRUnbahq6w==
X-Google-Smtp-Source: AH8x225KTG+ALGYUR4An7GCszH8M3YIWlZQQwW4bAun7/VoWV0dA4C5QlF301PUWMoUPDPxpslApJQ==
X-Received: by 10.28.6.69 with SMTP id 66mr10111194wmg.67.1516970240946;
        Fri, 26 Jan 2018 04:37:20 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:20 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 00/10] 'test_i18ngrep'-related fixes and improvements
Date:   Fri, 26 Jan 2018 13:36:58 +0100
Message-Id: <20180126123708.21722-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.155.g5159265b1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'test_i18ngrep' can't find the expected pattern, it exits
completely silently; when its negated form does find the pattern that
shouldn't be there, it prints the matching line(s) but otherwise exits
without any error message.  This leaves the developer puzzled about
what could have gone wrong.  Well, at least it left me puzzled...

Initially all I wanted to do was to make 'test_i18ngrep' more
informative on failure, but then skeletons started to fall out of the
closet^Wour test suite, and BAM! before I knew it I had 10 patches:


  t5541: add 'test_i18ngrep's missing filename parameter
  t5812: add 'test_i18ngrep's missing filename parameter
  t6022: don't run 'git merge' upstream of a pipe
  t4001: don't run 'git status' upstream of a pipe

Bugfixes for a few tests.  The first two are fun.

  t5510: consolidate 'grep' and 'test_i18ngrep' patterns
  t5536: let 'test_i18ngrep' read the file without redirection

Cleanups.

  t: move 'test_i18ncmp' and 'test_i18ngrep' to 'test-lib-functions.sh'

Pure code movement.

  t: forbid piping into 'test_i18ngrep'
  t: make sure that 'test_i18ngrep' got enough parameters

These try to prevent similar bugs in our tests in the future.  Both
are imperfect, see the commit messages about their limitations and why
I think they are good enough.

  t: make 'test_i18ngrep' more informative on failure

Again, see the commit message about its limitations and why it's good
enough.


 t/t4001-diff-rename.sh        | 11 ++++++---
 t/t5510-fetch.sh              |  9 +++-----
 t/t5536-fetch-conflicts.sh    |  2 +-
 t/t5541-http-push-smart.sh    |  2 +-
 t/t5812-proto-disable-http.sh |  3 +--
 t/t6022-merge-rename.sh       |  6 +++--
 t/test-lib-functions.sh       | 53 +++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh                 | 26 ---------------------
 8 files changed, 71 insertions(+), 41 deletions(-)

-- 
2.16.1.155.g5159265b1

