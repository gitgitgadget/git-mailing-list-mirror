Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8A61FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754347AbdEKJSs (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:18:48 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36050 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdEKJSr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:18:47 -0400
Received: by mail-wm0-f53.google.com with SMTP id u65so32403781wmu.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9KrnrliyWxfI5vamOJ1+5aSf5BZBvhEUNgTHUETiJ4=;
        b=euuF/cOf11Ghs7VrNRBxppnw7SbPNrI42LEh1kHRpwlP2GMZgvJP6Nozen9vAyR/Ri
         LlZE0oyM1Bk/6n5xUdOqCN2PNNC9//u278URuhuIFsMPdSKZvLfRgbkindbUQlX0YAyj
         cG+cUVQdRaLm4dQWS7AGBRNXVVC+61gDIOehFtR/TSUcxoxJdZmxc33VTK2JguixTN5I
         jQn+dLPjJzgxJq5qnEdFmABlxT2Q8NGWixKEM0YJyyBClUV8Mq7R9BQA9OIYwgA9ugHx
         ize99xDKNWteKn0zqEneyHOUzbxcP0rkqgQK5oQu7VpV5zEuBg97RM55ZCyE1aT3TdaJ
         fImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9KrnrliyWxfI5vamOJ1+5aSf5BZBvhEUNgTHUETiJ4=;
        b=NeScTlrFzJgzbca7mP4e2AECbhFEzX/zRIcTHw4N3tszH4O8/0mym5hhVScA71+iZt
         JHq56ZLQsLfL0aPmXd4My/WK38cn43FID3T70kAiq367gL4fmJqsug9MPvVA1JI5vemS
         UU9ThdtRe3lU51uHQE2smHvOK29weRe+uZeL+69zxFc7ipAc9NtVS3qAyHD+KF+nVOTE
         YCOA515hIJkCvdCMZC9/WRs+InS9lx5Acji86Kmoe2QKsLqmagEPnk2F40iPLt1JoimA
         3Dv/8Pg1KChczxzcoIYpWM0tOb/QaSfPGHZmaQzTOTMFKE6DN8fE9UL9usbhmaIuCitx
         S6FA==
X-Gm-Message-State: AODbwcBiuqO0H8btrNDnnLq6CPA6y1ZfMkYLWx6YJEYYz6jin6ssozFr
        yYqrN+DXDKS/ZQ==
X-Received: by 10.80.173.203 with SMTP id b11mr33368edd.110.1494494325900;
        Thu, 11 May 2017 02:18:45 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:18:44 -0700 (PDT)
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
Subject: [PATCH 00/29] Easy to review grep & pre-PCRE changes
Date:   Thu, 11 May 2017 09:18:00 +0000
Message-Id: <20170511091829.5634-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Easy to review? 29 patches? Are you kidding me?!

I thought about how to split up my sprawling PCRE v2 series which
can't easily be broken up because a lot of it is trivial setup code
needed for later patches, or things that would result in lots of merge
conflicts.

This is an attempt to make that as easy as possible for reviewers
these are only things that should be obviously correct, i.e.:

 * Comments
 * Trivial documentation changes
 * Tests for existing behavior
 * New perf tests used for later patch submissions
 * Moving code around or renaming variables which introduces no
   functional changes, makes later patches smaller.
 * Adding an assert() to existing code to self-document something
   that's true 100% of the time now.

The only exception to that is 27 and 28 which are trivial bugfixes /
consistency fixes to pack-objects & grep in how they warn about
invalid thread configuration under NO_PTHREADS=Y.

Ævar Arnfjörð Bjarmason (29):
  Makefile & configure: reword inaccurate comment about PCRE
  grep & rev-list doc: stop promising libpcre for --perl-regexp
  test-lib: rename the LIBPCRE prerequisite to PCRE
  log: add exhaustive tests for pattern style options & config
  grep: add a test asserting that --perl-regexp dies when !PCRE
  grep: add a test for backreferences in PCRE patterns
  grep: change non-ASCII -i test to stop using --debug
  grep: add tests for --threads=N and grep.threads
  grep: amend submodule recursion test for regex engine testing
  grep: add tests for grep pattern types being passed to submodules
  grep: add a test helper function for less verbose -f \0 tests
  grep: prepare for testing binary regexes containing rx metacharacters
  grep: add tests to fix blind spots with \0 patterns
  perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
  perf: emit progress output when unpacking & building
  perf: add a performance comparison test of grep -G, -E and -P
  perf: add a performance comparison of fixed-string grep
  grep: catch a missing enum in switch statement
  grep: remove redundant regflags assignment under PCRE
  grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
  grep: factor test for \0 in grep patterns into a function
  grep: change the internal PCRE macro names to be PCRE1
  grep: change internal *pcre* variable & function names to be *pcre1*
  grep: move two functions to avoid forward declaration
  test-lib: add a PTHREADS prerequisite
  pack-objects & index-pack: add test for --threads warning
  pack-objects: fix buggy warning about threads
  grep: given --threads with NO_PTHREADS=YesPlease, warn
  grep: assert that threading is enabled when calling grep_{lock,unlock}

 Documentation/git-grep.txt         |   7 +-
 Documentation/rev-list-options.txt |   8 +-
 Makefile                           |  14 ++-
 builtin/grep.c                     |  25 ++++-
 builtin/pack-objects.c             |   4 +-
 configure.ac                       |  12 ++-
 grep.c                             | 107 +++++++++---------
 grep.h                             |  10 +-
 t/README                           |   8 +-
 t/perf/README                      |  19 +++-
 t/perf/p7820-grep-engines.sh       |  35 ++++++
 t/perf/p7821-grep-engines-fixed.sh |  27 +++++
 t/perf/run                         |  13 ++-
 t/t4202-log.sh                     |  80 +++++++++++++-
 t/t5300-pack-object.sh             |  33 ++++++
 t/t7008-grep-binary.sh             | 135 +++++++++++++++++------
 t/t7810-grep.sh                    |  81 +++++++++++---
 t/t7812-grep-icase-non-ascii.sh    |  29 ++---
 t/t7813-grep-icase-iso.sh          |   2 +-
 t/t7814-grep-recurse-submodules.sh | 215 +++++++++++++++++++++++--------------
 t/test-lib.sh                      |   3 +-
 21 files changed, 632 insertions(+), 235 deletions(-)
 create mode 100755 t/perf/p7820-grep-engines.sh
 create mode 100755 t/perf/p7821-grep-engines-fixed.sh

-- 
2.11.0

