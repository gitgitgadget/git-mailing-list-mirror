Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8AB2201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756198AbdETVms (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:42:48 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34710 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755988AbdETVmq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:42:46 -0400
Received: by mail-wr0-f172.google.com with SMTP id l9so32344624wre.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eD0LDbIVhz8JM+ppvzogC0P51QzqqNNrEkm9UDwsXg=;
        b=ZiiHc7WqMbpMe/suj9lISJ2LofYSv2EVebM7/wmpu8q/Oyav9R59hhGqXbtT6y1yeO
         TfMdXdLuKo6n4YBD/+mGH3DtqFN+WydeYAgQhQWF8f5Z9u4JYKD8KuBkAc3wmB6Lm3Vx
         zhE6JMvA5tMldpGNU3sPjmC3i2IEDvndf0YwqMq1jfd2XxczybLZPA1+2FT34eOzLtGb
         ZsDttszxhnkNGGUuBqOVWtKTm7s6v/A/45zGEhDZFT4gx/dieMWLlGvQnIKuq2x3cibf
         weOcBasEMxzsqV/30HNdu3+IejTMKGzJTXGQw093tsFDqw6uphIeQM/pv4UkVGUtVjgW
         XNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eD0LDbIVhz8JM+ppvzogC0P51QzqqNNrEkm9UDwsXg=;
        b=d4AU/CRWLwaCVwnKH6n4duPUVm7xXNl9ulij5Ctvm6GXewUuOPIMnueRku58W3SOtT
         VE/J0KnJ+SaVxo9SQHxES7Vv2iuI+TUf2Wckbp+fOgZrGKp8VmnQxpKJaPaqGnFIdykM
         ehZv7m8zRWHiULBhPGjngSj+Z5TYGj1gh0H7mVoK+fO+8mivomwnuHtucUUzFnJ6yhhZ
         Bf1Oa0Nf1aflGppPzHd9tUnhYE0oufBS2Tk1TqHJhbdFLbP/uvpi09ZQNlMzFQRp7du7
         ulQjBBo9dt4aSxUiGxeR3MHpcQ6UOE/rizcM+H0s10SjdkLOD8+iNQe7joIi2nfYAhsL
         1few==
X-Gm-Message-State: AODbwcCz4i5UmG4y/kQjslKUZ9QfAFM2cHDIMy2UK/RrN7vPFEynBhQS
        FKMNVd7eb1HTOg==
X-Received: by 10.223.166.129 with SMTP id t1mr8084914wrc.116.1495316565308;
        Sat, 20 May 2017 14:42:45 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:42:44 -0700 (PDT)
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
Subject: [PATCH v3 00/30] Easy to review grep & pre-PCRE changes
Date:   Sat, 20 May 2017 21:42:03 +0000
Message-Id: <20170520214233.7183-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Easy to review? 29 (I mean 30) patches? Are you kidding me?!

As noted in v1 (<20170511091829.5634-1-avarab@gmail.com>;
https://public-inbox.org/git/20170511091829.5634-1-avarab@gmail.com/)
these are all doc, test, refactoring etc. changes needed by the
subsequent "PCRE v2, PCRE v1 JIT, log -P & fixes" series.

Since Junio hasn't been picking it I'm no longer sending updates to
that patch series & waiting for this one to cook first.

See <20170513231509.7834-1-avarab@gmail.com>
(https://public-inbox.org/git/20170513231509.7834-1-avarab@gmail.com/)
for v2 & notes about that version. What changed this time around? See
below:

Ævar Arnfjörð Bjarmason (30):
  Makefile & configure: reword inaccurate comment about PCRE
  grep & rev-list doc: stop promising libpcre for --perl-regexp
  test-lib: rename the LIBPCRE prerequisite to PCRE

No changes.

  log: add exhaustive tests for pattern style options & config

Test comment clarifications in t4202-log.sh as pointed out by Junio.

  log: make --regexp-ignore-case work with --perl-regexp

NEW: I noticed that the `-i` in `git log --perl-regexp -i --grep=<rx>`
never worked as intended. I.e. the flag for ignoring the case of the
pattern wasn't picked up.

Fixing this was trivial (one-line change), so I've included it in this
series since it's needed by a new t/perf patch (see below).

  grep: add a test asserting that --perl-regexp dies when !PCRE
  grep: add a test for backreferences in PCRE patterns
  grep: change non-ASCII -i test to stop using --debug
  grep: add tests for --threads=N and grep.threads
  grep: amend submodule recursion test for regex engine testing
  grep: add tests for grep pattern types being passed to submodules

No changes.

  grep: add a test helper function for less verbose -f \0 tests

Trivial style changes in nul_match() suggested by Junio. No functional
changes.

  grep: prepare for testing binary regexes containing rx metacharacters

No changes.

  grep: add tests to fix blind spots with \0 patterns

Continued trivial style changes in nul_match() (the other half of the
code in that function is added in this commit)>

  perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
  perf: emit progress output when unpacking & building

No changes.

  perf: add a comparison test of grep regex engines
  perf: add a comparison test of grep regex engines with -F
  perf: add a comparison test of log --grep regex engines

The log --grep test is new, and all these tests learned to take an env
variable to pass arbitrary extra grep/log flags, so I can e.g. test
with -i, -v, -w etc.

Subsequent commit messages that e.g. mentioned perf tests with the
previous hardcoded -i test have been amended to mention the new test
results.

  grep: catch a missing enum in switch statement

Grammar fix in commit message.

  grep: remove redundant regflags assignments

The two commits that made changes to regflags assignments have been
squashed.

  grep: factor test for \0 in grep patterns into a function

Rewrote commit message to not go off on a tangent about what grep -f
[file-with-\0-pattern] should mean, which is not what this change is
about.

  grep: change the internal PCRE macro names to be PCRE1
  grep: change internal *pcre* variable & function names to be *pcre1*
  grep: move is_fixed() earlier to avoid forward declaration
  test-lib: add a PTHREADS prerequisite

No changes.

  pack-objects & index-pack: add test for --threads warning
  pack-objects: fix buggy warning about threads

Rewrote the tests in these two so that the first one sets up a failing
test which is subsequently fixed in the commit that fixes the bug, as
suggested by Junio.

Removed a stray `cat err` left over from debugging.

  grep: given --threads with NO_PTHREADS=YesPlease, warn
  grep: assert that threading is enabled when calling grep_{lock,unlock}

No changes.

 Documentation/git-grep.txt         |   7 +-
 Documentation/rev-list-options.txt |   8 +-
 Makefile                           |  14 ++-
 builtin/grep.c                     |  23 +++-
 builtin/pack-objects.c             |   4 +-
 configure.ac                       |  12 ++-
 grep.c                             | 108 ++++++++++---------
 grep.h                             |  10 +-
 revision.c                         |   1 +
 t/README                           |   8 +-
 t/perf/README                      |  19 +++-
 t/perf/p4220-log-grep-engines.sh   |  44 ++++++++
 t/perf/p7820-grep-engines.sh       |  47 ++++++++
 t/perf/p7821-grep-engines-fixed.sh |  32 ++++++
 t/perf/run                         |  13 ++-
 t/t4202-log.sh                     | 160 +++++++++++++++++++++++++--
 t/t5300-pack-object.sh             |  36 +++++++
 t/t7008-grep-binary.sh             | 135 +++++++++++++++++------
 t/t7810-grep.sh                    |  81 +++++++++++---
 t/t7812-grep-icase-non-ascii.sh    |  29 ++---
 t/t7813-grep-icase-iso.sh          |   2 +-
 t/t7814-grep-recurse-submodules.sh | 215 +++++++++++++++++++++++--------------
 t/test-lib.sh                      |   3 +-
 23 files changed, 771 insertions(+), 240 deletions(-)
 create mode 100755 t/perf/p4220-log-grep-engines.sh
 create mode 100755 t/perf/p7820-grep-engines.sh
 create mode 100755 t/perf/p7821-grep-engines-fixed.sh

-- 
2.13.0.303.g4ebf302169

