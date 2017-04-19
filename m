Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A6971FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 22:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764993AbdDSWlQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 18:41:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34925 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764929AbdDSWlO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 18:41:14 -0400
Received: by mail-wr0-f195.google.com with SMTP id l44so5114017wrc.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 15:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fjfyqtfoEytKXOWsiqiSoqAmZrAGHuTJ5OmxZzxNxY=;
        b=PbVXYCr6MA9EpDXJsURKKyF61ZpBzWpOiISw0/tEjZuw0o5WIpPQvwY//ITxjcldoF
         9FJwY3LyYx4+WEHkgMmIhXLh3VY0hTC+KLDqIrwbyN4aWTVXQ40T2bTW65ZQmuVlj6EJ
         OYhyuW7e08x85hHw93x6ZjsCozoFj1FBMEWDwCaJQdv/wErXpIGaTVhY8mVggxnYi3oa
         TR8CWb/dQL1jUOP9sZ3PM9LDoQP/+zE7B92UWGzbI7qG0gFV+3chLzAm7BveS/6mI1ma
         XnPLAczhZ3en3cZ7dPgxKM3/d2Zbo0NObI4O5Ceh8ti9+rwmMQ6G6iUIqd9Od9y25y3g
         jihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fjfyqtfoEytKXOWsiqiSoqAmZrAGHuTJ5OmxZzxNxY=;
        b=k9j64AJ8/d2fgNx6ziJPbIE8gHiyw204NiowCRWpUNTsehn5Y0jnoktF3th8qczEsi
         xDoOlmFVJORoJk/FxXl/xRDnKIuuDQ3BL93/WuVWGRBZBEunmPivK18nHZ5/AaQU1SXm
         uxYJoLuvcPKJshAaUL+qKJzImHYllcwSSX4zNt8Ka/2NGmUHcRn05R70fQ+PgZPhtce0
         VHYgrz50uhbN4Z0JnrqXRE5B6wZJFEXlJVD4QidH9rH36MLccgu1uzVqSxfB/nCggCpN
         9AJ5075Fzaf9GDVhRTiCjVH1sD8POxcEp1sJHXIsqH50I1dhzPDsrwZjBlEYQZZZEFRb
         l6fQ==
X-Gm-Message-State: AN3rC/65ZlF9sf65M1Duo5L81iiEsIM41VFQx6ga4TAsORpGehxsn7Xe
        XDJYrUdYLOJEevPxOK0=
X-Received: by 10.223.165.77 with SMTP id j13mr5151690wrb.35.1492641672403;
        Wed, 19 Apr 2017 15:41:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q130sm21128996wmd.29.2017.04.19.15.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 15:41:11 -0700 (PDT)
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
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/13] PCRE v1 improvements & PCRE v2 support
Date:   Wed, 19 Apr 2017 22:40:40 +0000
Message-Id: <20170419224053.8920-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been a while since I sent v1 of this. I addressed most of the
comments, except:

 * grep w/submodules doesn't properly pcre2 to submodule greps.

 * The critiqued adding runtime complexity by supporting both pcre1 &
   pcre2 via a switch is still there.

I wanted to get something out the door to review the other bits I've
changed sooner than later, so I'm sending it in the state it's in.
Depending on the consensus for those two issues, fixes for those can
easily be addedd on top.

Comments on specific patches:

Ævar Arnfjörð Bjarmason (13):

Firstly, the "git grep --threads=N" patch is missing, that became the
independent "[PATCH v2 0/8] grep threading cleanup & tests"
series. See <20170416222102.2320-1-avarab@gmail.com>.

  grep: remove redundant regflags assignment under PCRE

No changes.

  Makefile & configure: reword outdated comment about PCRE

Fix comment copy as suggested by JK, and explained the confusing
copy/pasting of Makefile comments to configure.ac in the commit
message.

  grep: add a test for backreferences in PCRE patterns

No changes.

  log: add exhaustive tests for pattern style options & config

Now using [\d] instead of \((?=1) as a pattern to tell -E and -P
patterns apart, as suggested by JK.

  log: add -P as a synonym for --perl-regexp

Uses the [\d] pattern now for a test, no other changes.

  grep & rev-list doc: stop promising libpcre for --perl-regexp

No changes.

  grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"

Minor grammar fix in commit message.

  test-lib: rename the LIBPCRE prerequisite to PCRE

No changes.

  grep: change the internal PCRE macro names to be PCRE1

No changes.

  grep: change the internal PCRE code & header names to be PCRE1

No changes.

  perf: add a performance comparison test of grep -E and -P

NEW: Instead of my huge perl -MBenchmark one-liner I wrote a t/perf/
test for grep engine comparison which I'm citing for subsequent
changes.

  grep: add support for the PCRE v1 JIT API

NEW: Adds JIT support for PCRE v1.

  grep: add support for PCRE v2

Lots of changes:

 - Much smaller and hopefully less confusing commit message &
   discussion of performance differences.

 - Much improved PCRE v2 API use. The Zoltán Herczeg on the pcre-dev
   list helped a lot with that. Now less buggy & more performant.

 - Plugged a trivial memory leak I missed in v1.

Ævar Arnfjörð Bjarmason (13):
  grep: remove redundant regflags assignment under PCRE
  Makefile & configure: reword outdated comment about PCRE
  grep: add a test for backreferences in PCRE patterns
  log: add exhaustive tests for pattern style options & config
  log: add -P as a synonym for --perl-regexp
  grep & rev-list doc: stop promising libpcre for --perl-regexp
  grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
  test-lib: rename the LIBPCRE prerequisite to PCRE
  grep: change the internal PCRE macro names to be PCRE1
  grep: change the internal PCRE code & header names to be PCRE1
  perf: add a performance comparison test of grep -E and -P
  grep: add support for the PCRE v1 JIT API
  grep: add support for PCRE v2

 Documentation/config.txt           |   7 ++
 Documentation/git-grep.txt         |   4 +-
 Documentation/rev-list-options.txt |   6 +-
 Makefile                           |  28 ++++-
 configure.ac                       |  61 +++++++++-
 grep.c                             | 233 ++++++++++++++++++++++++++++++++-----
 grep.h                             |  36 +++++-
 revision.c                         |   2 +-
 t/README                           |  16 ++-
 t/perf/p7820-grep-engines.sh       |  25 ++++
 t/t4202-log.sh                     |  86 +++++++++++++-
 t/t7810-grep.sh                    |  69 ++++++++---
 t/t7812-grep-icase-non-ascii.sh    |   4 +-
 t/t7813-grep-icase-iso.sh          |  11 +-
 t/test-lib.sh                      |   4 +-
 15 files changed, 516 insertions(+), 76 deletions(-)
 create mode 100755 t/perf/p7820-grep-engines.sh

-- 
2.11.0

