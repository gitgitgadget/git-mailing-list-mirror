Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158DC1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 20:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbeKAFBc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 01:01:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37568 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeKAFBc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 01:01:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id u13-v6so2515840pfm.4
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 13:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=rDsT8Tue8O/a3XJ2S8JzYt5C0cwm4VvSxjwm4Fd9QPM=;
        b=LPg6j65ZQ3vglkSO0TJi68mtz+nwom8MZnFjf3pE1u5A/Gvlv2aHBf1rJpEyJaRUgS
         ZR80kyZm5f2sY3fCmWosgJ31uoTgyKLYmMTGOn9dT1AyK1haCstYY5xdjkE4nE6WIQSR
         wdAGtAwAxKUxkXajKk+OTQwaKWjnJHb6tx2yYxDH6SOFjcwOLIhcA+J0cwI7HxVz6wRi
         PDh7seosnuFJKwJZJYQ3u2RiuFpWhPEaCNIHvCFv0b/SrLS2aqqb73tsnbNXBOACpst0
         ZInUP0glwKVGrtMz4Tvm8csHrvsH2G8emFPPoOjvMwV4D4NLOVr9LQj0J1ZQ9P0Yg3zq
         zklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rDsT8Tue8O/a3XJ2S8JzYt5C0cwm4VvSxjwm4Fd9QPM=;
        b=l3Bzn4Dng/548jlL8PcE+TUimQjYeGXHA5MwvzYYGqCk6uKt0WyVKehjhUSd58uv0v
         ySTKyyKsmcDMIwDUyAnCcPp2J39rCUphaYyAcULlsULb+gOKD8DUsS+IZ6CH29OIKpyC
         ar3lr+28+sX7sek8nfAMjuTamrfMlcwc3g4DObQ0rLS268Uj7R++1e73lh0Telpw33q9
         3OheyHhUu6JoY9LMlXeyHJL0AuWTJK+3v1pa/cCtxR8fy/dZp321HZp8nIdZC7v8Qv2r
         GdWiXVjrke5+jESCGYp2I1UvxaWsLMmV7cXU7myssNp8xBjcyxjCWfMREqspViSJEtUE
         nHKQ==
X-Gm-Message-State: AGRZ1gJjqkS28GDcJ6G8wB5QlOFtkwxBgoFtSgbiwmqbnvFRoh6Gy9IG
        +BchDInuaZk6ilv6PUKzSC+4AvMQ
X-Google-Smtp-Source: AJdET5dVPrjoO9STt5zbENG1x6Q0i44PYFEFPRVy1B8wqzPumqU8DuaDoXQDaKKvXK1Zn9stUhPaiQ==
X-Received: by 2002:a63:c746:: with SMTP id v6-v6mr4530324pgg.108.1541016118553;
        Wed, 31 Oct 2018 13:01:58 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id w66-v6sm33895885pfb.51.2018.10.31.13.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:01:57 -0700 (PDT)
Date:   Wed, 31 Oct 2018 13:01:57 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 20:01:51 GMT
Message-Id: <pull.63.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] tests: allow to skip git rebase -p tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --preserve-merges mode of the git rebase command is on its way out,
being superseded by the --rebase-merges mode. My plan is to contribute
patches to deprecate the former in favor of the latter before long.

In the meantime, it seems a bit pointless to keep running the git rebase -p 
tests, in particular in the Windows phase of the automated testing. In
preparation for skipping those tests, this patch series starts out by
decoupling test cases so that no non-rebase -p ones depend on side effects
of rebase -p ones, and it concludes by a patch that allows skipping the 
rebase -p ones by setting the environment variable GIT_TEST_SKIP_REBASE_P.

In a quick 'n dirty test, skipping the rebase -p tests seems to shave off
about 8 minutes from the 1h20 running time of the test suite on Windows
(without git svn tests, we skip them for a long time already, as they are
really, really slow on Windows).

Johannes Schindelin (3):
  t3404: decouple some test cases from outcomes of previous test cases
  t3418: decouple test cases from a previous `rebase -p` test case
  tests: optionally skip `git rebase -p` tests

 t/t3404-rebase-interactive.sh             | 23 ++++++++-------
 t/t3408-rebase-multi-line.sh              |  2 +-
 t/t3409-rebase-preserve-merges.sh         |  5 ++++
 t/t3410-rebase-preserve-dropped-merges.sh |  5 ++++
 t/t3411-rebase-preserve-around-merges.sh  |  5 ++++
 t/t3412-rebase-root.sh                    | 12 ++++----
 t/t3414-rebase-preserve-onto.sh           |  5 ++++
 t/t3418-rebase-continue.sh                |  5 ++--
 t/t3421-rebase-topology-linear.sh         | 36 +++++++++++------------
 t/t3425-rebase-topology-merges.sh         |  5 ++++
 t/t5520-pull.sh                           |  6 ++--
 t/t7505-prepare-commit-msg-hook.sh        |  2 +-
 t/t7517-per-repo-email.sh                 |  6 ++--
 t/test-lib.sh                             |  4 +++
 14 files changed, 78 insertions(+), 43 deletions(-)


base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-63%2Fdscho%2Fsplit-out-rebase-p-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-63/dscho/split-out-rebase-p-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/63
-- 
gitgitgadget
