Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078EA20284
	for <e@80x24.org>; Thu, 25 May 2017 19:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935333AbdEYTpy (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:45:54 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37788 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757593AbdEYTpw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:45:52 -0400
Received: by mail-wm0-f54.google.com with SMTP id d127so110924851wmf.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIHh5nf6F3dV0mO3hn2b0x5imJYXYYfxYq9uLfx7oxA=;
        b=e2QhKrnQTeksovk42OVfdPeg0E/b0Blk5PXHXcuRF9T4THhXDeIFPhOaEgc/s/F9tz
         qPgupMYB9SK0nfRg5Vk/M9wetYNUowe5vd4uawiVjTTc7wt5hcwHRNoKjuJFf+e+MIoP
         iv99mSRjsSWWzEs08GrjUu1e8hIqRLt2HDOsE/UnBjWCg2rHzXBB2r3bl8Hr4s+4/CdN
         Ou6CPOKa6Xyla8xqjGGEQ2Sb7zyZjf8G4bj7GYKFk72PAlWFIwa3BZl45YlroHbMXLpJ
         M9S1s/JkR9uXULnW7tsJ3vRo0PzeIol+W7I8pCfQCk7m68kPOBMCsz8ZNoyGVlpr4ThS
         rxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIHh5nf6F3dV0mO3hn2b0x5imJYXYYfxYq9uLfx7oxA=;
        b=Np0Oma5K5RiFuJF+N5gbr4VbsQoDHHBDZEJ6fNG7VG2bPPuXuBtnC8sCtbl23YxFWB
         PbOPWg9NvDv9zGjNnQMi2VJB8kJSWizrGbud4PT84pMBEYyO9Q6vfcs11tE3mYU7IbxU
         GdgKN3PmED4u7E4T39dYWBNZsC5uf2kOjKSGWtFXHYu3YmDB6Np35MIdDBNwwnQhhuWt
         Ewz/eNl3LaHJVVIinWSbQTIsEdl7IycT3jIeZviZxS/1RIVZpyiSeXaUVMhZWGOdaJwc
         GQMts9w0RLQ0zgIB23Su5peR++6GahrVUaLGF6nO+4qQ+Wc7feTuO9gC0AUeTFlpZlgK
         DLKQ==
X-Gm-Message-State: AODbwcCfWcU1jAXiIaPJwk5KPQ1CXRU9Ms/u/jb79DiZlDkk8My8l/Kd
        1Dhp5G3jgtbAAQ==
X-Received: by 10.223.135.213 with SMTP id c21mr29729709wrc.10.1495741550489;
        Thu, 25 May 2017 12:45:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:45:49 -0700 (PDT)
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
Subject: [PATCH v4 00/31] Easy to review grep & pre-PCRE changes
Date:   Thu, 25 May 2017 19:45:04 +0000
Message-Id: <20170525194535.9324-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Easy to review? 29 (I mean 30, I mean 31) patches? Are you kidding
me?!

As noted in v1 (<20170511091829.5634-1-avarab@gmail.com>;
https://public-inbox.org/git/20170511091829.5634-1-avarab@gmail.com/)
these are all doc, test, refactoring etc. changes needed by the
subsequent "PCRE v2, PCRE v1 JIT, log -P & fixes" series.

See <20170520214233.7183-1-avarab@gmail.com>
(https://public-inbox.org/git/20170520214233.7183-1-avarab@gmail.com/)
v3 & notes about that version. What changed this time around? See
below:


Ævar Arnfjörð Bjarmason (31):
  Makefile & configure: reword inaccurate comment about PCRE
  grep & rev-list doc: stop promising libpcre for --perl-regexp
  test-lib: rename the LIBPCRE prerequisite to PCRE
  log: add exhaustive tests for pattern style options & config
  log: make --regexp-ignore-case work with --perl-regexp
  grep: add a test asserting that --perl-regexp dies when !PCRE
  grep: add a test for backreferences in PCRE patterns
  grep: change non-ASCII -i test to stop using --debug
  grep: add tests for --threads=N and grep.threads
  grep: amend submodule recursion test for regex engine testing
  grep: add tests for grep pattern types being passed to submodules
  grep: add a test helper function for less verbose -f \0 tests
  grep: prepare for testing binary regexes containing rx metacharacters
  grep: add tests to fix blind spots with \0 patterns

No changes.

  perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do

Fix trailing whitespace.

  perf: emit progress output when unpacking & building

No changes.

  perf: add a comparison test of grep regex engines
  perf: add a comparison test of grep regex engines with -F
  perf: add a comparison test of log --grep regex engines
  perf: add a comparison test of log --grep regex engines with -F

These are all improved:

 * Skip the PCRE test when we don't have the PCRE prerequisite,
   instead of erroring out.

 * Update outdated commit messages left over from previous
   submissions.

 * General minor nits in the code, e.g. use the same for-loop variable
   name in all four files which have similar code, simplify the
   test_cmp invocation etc.

  grep: catch a missing enum in switch statement
  grep: remove redundant regflags assignments

No changes.

  grep: factor test for \0 in grep patterns into a function

Brandon pointed out that one of the lines in this patch was longer
than 79 characters. Fixed.

  grep: change the internal PCRE macro names to be PCRE1
  grep: change internal *pcre* variable & function names to be *pcre1*
  grep: move is_fixed() earlier to avoid forward declaration
  test-lib: add a PTHREADS prerequisite
  pack-objects & index-pack: add test for --threads warning
  pack-objects: fix buggy warning about threads
  grep: given --threads with NO_PTHREADS=YesPlease, warn
  grep: assert that threading is enabled when calling grep_{lock,unlock}

No changes.

 Documentation/git-grep.txt             |   7 +-
 Documentation/rev-list-options.txt     |   8 +-
 Makefile                               |  14 ++-
 builtin/grep.c                         |  23 +++-
 builtin/pack-objects.c                 |   4 +-
 configure.ac                           |  12 +-
 grep.c                                 | 110 +++++++++--------
 grep.h                                 |  10 +-
 revision.c                             |   1 +
 t/README                               |   8 +-
 t/perf/README                          |  17 ++-
 t/perf/p4220-log-grep-engines.sh       |  53 ++++++++
 t/perf/p4221-log-grep-engines-fixed.sh |  44 +++++++
 t/perf/p7820-grep-engines.sh           |  56 +++++++++
 t/perf/p7821-grep-engines-fixed.sh     |  41 +++++++
 t/perf/run                             |  13 +-
 t/t4202-log.sh                         | 160 +++++++++++++++++++++++-
 t/t5300-pack-object.sh                 |  36 ++++++
 t/t7008-grep-binary.sh                 | 135 ++++++++++++++++-----
 t/t7810-grep.sh                        |  81 ++++++++++---
 t/t7812-grep-icase-non-ascii.sh        |  29 ++---
 t/t7813-grep-icase-iso.sh              |   2 +-
 t/t7814-grep-recurse-submodules.sh     | 215 ++++++++++++++++++++-------------
 t/test-lib.sh                          |   3 +-
 24 files changed, 843 insertions(+), 239 deletions(-)
 create mode 100755 t/perf/p4220-log-grep-engines.sh
 create mode 100755 t/perf/p4221-log-grep-engines-fixed.sh
 create mode 100755 t/perf/p7820-grep-engines.sh
 create mode 100755 t/perf/p7821-grep-engines-fixed.sh

-- 
2.13.0.303.g4ebf302169

