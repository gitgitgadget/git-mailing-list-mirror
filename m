Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD9B1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 23:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfFSXa5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 19:30:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40237 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFSXa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 19:30:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so995277wre.7
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 16:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ysuOzqLZip6b33tuoNifQ1yZuJ16H666u3bkf7ke428=;
        b=aA4wyIy8o9xabN4dzhCH2feVKWLcFuUeOkJdd++9qXVLuxu/psKK+rFbh8F/8Li6aS
         upaMBrs51C/95C8ettbMMEWsuhUzs1qnYfLsfAOMqmDbmH2yS3qEa6PJ94Zo11dwY5P8
         zfyFra3dD8EM9xZjN//WzGMjoGWpBzMeNp0imVYuGWpdTVEslI7AKp8npSwX/8IFvGvs
         fw3LHLaGz5HIMXIDdgYv7J6Qo03W1EEmDciB4/KKjFiCXVhm++XZ/QwPRPmr6HiwlG66
         OtJ2v+YLvm0ot4iCBjbDnrJU3A+tlPCdnydw2Jmtcz8T55UmJtCzRqH9N4orpek8ERtR
         ktUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ysuOzqLZip6b33tuoNifQ1yZuJ16H666u3bkf7ke428=;
        b=g3bouQ23IOJU1ZCuGPjLqaZKoJXakkoJ2gPKES3LbvVE0yP/YGnaMn0hs1o4PINs0E
         RuB265wWIFWTsotFl7nieJMZLp/slJQXWqSaK9wnUtO86NKrflepSAITzFPhhOteMDvB
         gGg+3iXqKUrtrT4+0saUzqF1NQrGxHITHTrddvhu61iHNV9JuH3TQTtBF7ngcCwLFXsr
         wYHijA/g2VBOKBRx7CUH4laqI6qGwPdpkNdHrIfpg/es+bbhz6vL0i/qbgwaOxQ7j8gI
         TTtDAXxRQiIjLnDDs6+oTwo+B9WfJCqt/6q8pYkyLnz5Ee2OJW5lg8nOltJQc1Puc3w1
         LE0w==
X-Gm-Message-State: APjAAAWHvCDVpv+kFWkmuVZ87+/mrJ8V4dWpOYLjirYsa4KxTN75/anh
        YRuoGdjIGb2qoKpsJSKuAg97ts5UVOg=
X-Google-Smtp-Source: APXvYqyA/RjWfYTVHnQofcShrw5qxskPPdI7wrw1RP0FecAIy4BhaUgJcw4L7ddgP878cFetxntBEg==
X-Received: by 2002:adf:e311:: with SMTP id b17mr89021999wrj.11.1560987055016;
        Wed, 19 Jun 2019 16:30:55 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6sm17964958wrx.85.2019.06.19.16.30.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 16:30:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] Change <non-empty?> GIT_TEST_* variables to <boolean>
Date:   Thu, 20 Jun 2019 01:30:40 +0200
Message-Id: <20190619233046.27503-1-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244
In-Reply-To: <87imt18a2r.fsf@evledraar.gmail.com>
References: <87imt18a2r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This changes the remaining <non-empty?> special snowflake test modes
to <boolean> and gets rid of test_tristate() in favor of the now
standard "boolea" test.

I'm replying to my "gc: run more pre-detach operations under lock"
thread because one of the things my WIP patches to make gc locking
less sucky depends on is new GIT_TEST_GC_* test modes to test its
racyness, which in turn depends on these cleanups.

Ævar Arnfjörð Bjarmason (6):
  env--helper: new undocumented builtin wrapping git_env_*()
  t6040 test: stop using global "script" variable
  tests: make GIT_TEST_GETTEXT_POISON a boolean
  tests README: re-flow a previously changed paragraph
  tests: replace test_tristate with "git env--helper"
  tests: make GIT_TEST_FAIL_PREREQS a boolean

 .gitignore                |  1 +
 Makefile                  |  1 +
 builtin.h                 |  1 +
 builtin/env--helper.c     | 74 +++++++++++++++++++++++++++++++++++++++
 ci/lib.sh                 |  2 +-
 gettext.c                 |  6 ++--
 git-sh-i18n.sh            |  4 ++-
 git.c                     |  1 +
 po/README                 |  2 +-
 t/README                  | 12 +++----
 t/lib-git-daemon.sh       |  7 ++--
 t/lib-git-svn.sh          | 11 +++---
 t/lib-httpd.sh            | 15 ++++----
 t/t0000-basic.sh          | 10 +++---
 t/t0016-env-helper.sh     | 70 ++++++++++++++++++++++++++++++++++++
 t/t0205-gettext-poison.sh |  2 +-
 t/t5512-ls-remote.sh      |  3 +-
 t/t6040-tracking-info.sh  |  6 ++--
 t/t7201-co.sh             |  2 +-
 t/t9902-completion.sh     |  2 +-
 t/test-lib-functions.sh   | 58 +++++-------------------------
 t/test-lib.sh             | 29 ++++++++++++---
 22 files changed, 220 insertions(+), 99 deletions(-)
 create mode 100644 builtin/env--helper.c
 create mode 100755 t/t0016-env-helper.sh

-- 
2.22.0.rc1.257.g3120a18244

