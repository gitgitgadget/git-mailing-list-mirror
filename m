Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE8220188
	for <e@80x24.org>; Sat, 13 May 2017 23:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755828AbdEMXPb (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:15:31 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34789 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdEMXPa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:15:30 -0400
Received: by mail-qk0-f196.google.com with SMTP id u75so12493792qka.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwAc5FgsWDOHgbwNywrLotg2kS4n13maZ6958BoWMKQ=;
        b=fLVPLcHI9Mhbg6T7c9kW2GsVrMLhgU1xUlp9wYNY0eRNwdI73GtMPKpxpb5RtxHARz
         ZP2+7hKqdtL7leBu/diX65IRy82aR/alB+PYAepcXDUJhZOhLfFCRcBzfI44GtA8kaGd
         rPYJc+H6qvBTNc5RN/pUDo3xp1KB8wudGxeEntkv+ycdsg7ADlHe6Yl1jz6EnbXC2aeE
         2aHNwOeJPFd+z2i70YUtpvhADcjuOdpgqbd/ZF0sdlW6hJ2k4txeQ9pLnUQuUq4rcYsJ
         InEHtFWlF1nl/2LWry5j1GWcEuyAdTQOeGPYlMSVE5P3WYPkspnRUqqz9+mMSqr2jbEI
         Fz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwAc5FgsWDOHgbwNywrLotg2kS4n13maZ6958BoWMKQ=;
        b=WBZ817gmqSSXsU6RkEGRBDbw7rObjgveiDWCOxqyVuB1BpDNvqF4eLHqBQqwgHeh7T
         bpa3Db7roX5rYjUvZKJvdTTfdFclLB+E3Ycrzk44w/vjPvJSLqMfdJ/mDaVnqV4+DWTw
         qUEtEeG2T0zG/ITkBaNVs8Kou+omEX8WACONOykwDnOMfakHMFCBokStUOBX72GQNCt9
         +3tvmIHQkvMytLulOgM4ApC38SHRlbFEOWUJPn/O3rvzKwY+kOO4SJwPUAO+TQQ9L0yJ
         VrSzf8rtVHg+Cn/d20URWmj0MDOeGkJ7oDiIdeegATmflgMSvdJ2ggHuQXGmvJpZQ8jd
         9xdg==
X-Gm-Message-State: AODbwcCtMw7dc7KBFZ/IUJSvNG2oZZn+tCqGKkjRQ3TgqiKaYoHwAvv9
        lUCerVmosFFDsxXXnSM=
X-Received: by 10.55.101.17 with SMTP id z17mr9502984qkb.168.1494717328760;
        Sat, 13 May 2017 16:15:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:15:25 -0700 (PDT)
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
Subject: [PATCH v2 00/29] Easy to review grep & pre-PCRE changes
Date:   Sat, 13 May 2017 23:14:40 +0000
Message-Id: <20170513231509.7834-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Easy to review? 29 patches? Are you kidding me?!

As noted in v1 (<20170511091829.5634-1-avarab@gmail.com>;
https://public-inbox.org/git/20170511091829.5634-1-avarab@gmail.com/)
these are all doc, test, refactoring etc. changes needed by the
subsequent "PCRE v2, PCRE v1 JIT, log -P & fixes" series.

Thanks a lot for the review everyone. This fixes all the issues
raised. Changes noted below, with names prefixed by the person who
raised the issue.

Ævar Arnfjörð Bjarmason (29):
  Makefile & configure: reword inaccurate comment about PCRE
  grep & rev-list doc: stop promising libpcre for --perl-regexp
  test-lib: rename the LIBPCRE prerequisite to PCRE

No changes.

  log: add exhaustive tests for pattern style options & config

Johannes: Now doesn't create a "(1|2)" tag, so should work on Windows
& beyond (wasn't needed, just created as a side-effect of test_commit)

Junio: Added comments for tricky basic/extended/perl

Junio: Moved all the 'test_have_prereq PCRE' test / test_cmp code
together, not apart as before.

  grep: add a test asserting that --perl-regexp dies when !PCRE
  grep: add a test for backreferences in PCRE patterns

No changes.

  grep: change non-ASCII -i test to stop using --debug

Brandon: Removed stray leftover unused --debug

  grep: add tests for --threads=N and grep.threads

Brandon: Amended commit message to clarify that this test doesn't need
a NO_PTHREADS prerequisite, and we actually get coverage out of
testing with --threads=N when not with threads, or at least it doesn't
harm anything.

  grep: amend submodule recursion test for regex engine testing

Junio: Now "foo" -> "(1|2)" as the commit message claims, not ->
"(1|2)d".

  grep: add tests for grep pattern types being passed to submodules

No changes.

  grep: add a test helper function for less verbose -f \0 tests

Junio: "nul_match() {" -> "nul_match () {" & quote "$status" & don't
quote non-variable strings.

  grep: prepare for testing binary regexes containing rx metacharacters

No changes.

  grep: add tests to fix blind spots with \0 patterns

Junio: Also fixed quoted variable strings here as above.

  perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
  perf: emit progress output when unpacking & building

No changes.

  perf: add a performance comparison test of grep -G, -E and -P

All my multibyte performance tests were done with the string
'm(ú|u)ult.b(æ|y)te' which didn't match anything in the kernel, now
done with 'm(ú|u)lt.b(æ|y)te' instead.

I re-ran all the performance tests mentioned in the commit messages
where applicable.

  perf: add a performance comparison of fixed-string grep

One test_cmp was run twice due to rebasing from the pcre1/pcre2 days
of this series. Fixed.

  grep: catch a missing enum in switch statement

Stefan: Removed the comment about die(..BUG) & put the relevant detail
in the commit message instead.

  grep: remove redundant regflags assignment under PCRE
  grep: remove redundant `regflags &= ~REG_EXTENDED` assignments

No changes.

  grep: factor test for \0 in grep patterns into a function

Brandon: Fix comment syntax creating the function, and move it to the
correct place now instead of later in the "move is_fixed()" commit.

  grep: change the internal PCRE macro names to be PCRE1
  grep: change internal *pcre* variable & function names to be *pcre1*

No changes.

  grep: move is_fixed() earlier to avoid forward declaration

Brandon: Now just moves is_fixed() instead of is_fixed() & has_null()

  test-lib: add a PTHREADS prerequisite
  pack-objects & index-pack: add test for --threads warning
  pack-objects: fix buggy warning about threads

No changes.

  grep: given --threads with NO_PTHREADS=YesPlease, warn

Use Git standard comment syntax for TRANSLATORS comment.

  grep: assert that threading is enabled when calling grep_{lock,unlock}

 Documentation/git-grep.txt         |   7 +-
 Documentation/rev-list-options.txt |   8 +-
 Makefile                           |  14 ++-
 builtin/grep.c                     |  23 +++-
 builtin/pack-objects.c             |   4 +-
 configure.ac                       |  12 ++-
 grep.c                             | 108 ++++++++++---------
 grep.h                             |  10 +-
 t/README                           |   8 +-
 t/perf/README                      |  19 +++-
 t/perf/p7820-grep-engines.sh       |  35 ++++++
 t/perf/p7821-grep-engines-fixed.sh |  26 +++++
 t/perf/run                         |  13 ++-
 t/t4202-log.sh                     |  96 ++++++++++++++++-
 t/t5300-pack-object.sh             |  33 ++++++
 t/t7008-grep-binary.sh             | 135 +++++++++++++++++------
 t/t7810-grep.sh                    |  81 +++++++++++---
 t/t7812-grep-icase-non-ascii.sh    |  29 ++---
 t/t7813-grep-icase-iso.sh          |   2 +-
 t/t7814-grep-recurse-submodules.sh | 215 +++++++++++++++++++++++--------------
 t/test-lib.sh                      |   3 +-
 21 files changed, 646 insertions(+), 235 deletions(-)
 create mode 100755 t/perf/p7820-grep-engines.sh
 create mode 100755 t/perf/p7821-grep-engines-fixed.sh

-- 
2.11.0

