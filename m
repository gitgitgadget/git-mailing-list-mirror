Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A836207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S946431AbdDTVYJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:24:09 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34096 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943485AbdDTVYH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:24:07 -0400
Received: by mail-wr0-f177.google.com with SMTP id z109so43647493wrb.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wrxgx5lvemtzELLiTCuT2pRxKdDW7vIvqa/4w9+xbQA=;
        b=Ygj9dKAZD5CHkf7N85r+Yf79NmjoCXhZozjkD/Ao3eI+xDaVoPxgU/Eigw5nia434W
         alf4M0Zmi97whdJoC8/bpwYCW4PHhLEgsN6l6otUF4UJQ5D5kP2wd44nS5isupTsSUz/
         XbkKv6W9gzdaPR6JaGiPVR/bvCV1Gt4E6iB20xldm+RRs5Xez30XBVRCHkFgXtme1EyK
         Oitp+l05lv2SZm75/IGYkp94DjT1J2VHs1lARExaLGbFpR2VgMwcpxOpQ7T//QIH4Kh/
         Gaux6lHwM8xo+tz28dTiVlJKfG9qtqzBjPouFSoH7OiVeeB+kAPYQenSL4h6oShd4dp8
         HzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wrxgx5lvemtzELLiTCuT2pRxKdDW7vIvqa/4w9+xbQA=;
        b=AygV+LDzENZEO6/YxfU1aQ+lA9cirl2O6TPo16cQfwQnDk3kwntpv16h1Wcs5ZnxIR
         0nZ2TBJx009j0o7t/48xdrKzH3xv1YicYU2tSBEY5XV1D5epmO9GlzIsfkE8obhvtk22
         qvoR8MAhfZPvmlEdbaboT03Js1+lE/S3pA/i8HSaUR7Mcizvj0Ky1qDu2fnzk2h5JMY9
         +KfOL7SKJaFnGjmB+xvoBYb6WCKXWF7+ulAMmlhQCSpuBioz+/HVYyH0L70KoDYH/8oq
         IHukl+En6wbrSdCmFVFPtegLm0yptLjYfFiDeJZhGyFNLaayJy7bH0H5qJR5VXeGWo7Z
         Qdaw==
X-Gm-Message-State: AN3rC/4VY6OI1puJ4glaYK0g9qQPPPjrcWyR1LZCq0WG9SXEHuZtKU4g
        E5XtC8ISxcW0iQ==
X-Received: by 10.223.130.66 with SMTP id 60mr10285090wrb.59.1492723445494;
        Thu, 20 Apr 2017 14:24:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:24:04 -0700 (PDT)
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
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/18] PCRE v1 improvements & PCRE v2 support
Date:   Thu, 20 Apr 2017 21:23:27 +0000
Message-Id: <20170420212345.7408-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry about the high volume sending. I thought I wouldn't have time to
work on v3 for a while, but here it is a day later. I promise to hold
off on further sending for a bit.

This, unlike v2, addresses all the outstanding comments the series
had. Most importantly I added a patch at the end to remove the
concurrent support for v1 & v2 of the library as Jeff & Junio
suggested.

See the v2 coverletter in <20170419224053.8920-1-avarab@gmail.com> for
changes since v1, changes since v2 noted below:

Ævar Arnfjörð Bjarmason (18):
  grep: amend submodule recursion test in preparation for rx engine
    testing
  grep: add tests for grep pattern types being passed to submodules
  grep: submodule-related case statements should die if new fields are
    added

I thought there was a bug in v2 still where submodule grepping
wouldn't properly pass along e.g. `-c grep.patternType=pcre2`, this
turned out to not be the case since we pass -c options to subprocesses
via the GIT_CONFIG_PARAMETERS env var, which I didn't know about.

But in preparing to fix that I wrote these tests which improve on some
blind spots in the tests Brandon initially added for the submodule
grep. It's part of this series because it would conflict with
subsequent patches if sent stand-alone, but is otherwise unrelated.

  grep: remove redundant regflags assignment under PCRE
  Makefile & configure: reword outdated comment about PCRE

No changes.

  grep: add a test for backreferences in PCRE patterns

s/PCRE/LIBPCRE/ for the prereq check. That's changed later, but this
patch didn't work properly stand-alone, error introduced in earlier
v1-era rebasing.

  log: add exhaustive tests for pattern style options & config
  log: add -P as a synonym for --perl-regexp

No changes.

  grep & rev-list doc: stop promising libpcre for --perl-regexp

I've reworded these docs to make even weaker promises about what's a
"Perl-compatible regular expression". As noted in the commit message
the motivation is that maybe in the future we'd like to provide -P via
some entirely different library, e.g. Intel's hyperscan. This leaves
that door open without breaking existing promises in the
documentation.

  grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"

Now with tests for recursive submodule grepping.

  test-lib: rename the LIBPCRE prerequisite to PCRE

Now with s/LIBPCRE/PCRE/ back for the s/PCRE/LIBPCRE/ change noted earlier.

  grep: change the internal PCRE macro names to be PCRE1
  grep: change the internal PCRE code & header names to be PCRE1
  perf: add a performance comparison test of grep -E and -P
  grep: add support for the PCRE v1 JIT API

No changes.

  grep: add support for PCRE v2

Fix one s/LIBPCREDIR/LIBPCRE2DIR/ in a ./configure notice which I
missed & tests & minor changes for recursive submodule grepping.

  grep: remove support concurrent use of both PCRE v1 & v2

NEW: Removes grep.patternType=[pcre|pcre1|pcre2] & makes trying to
compile git with both v1 & v2 an error, but either one will work, with
v1 being the default still.

After writing this up & seeing what the change is I also agree that
it's a good idea to apply this. It makes the user-facing docs simpler,
but also the various tests which previously had to worry about
[pcre|pcre1|pcre2] which now just test "perl".

  Makefile & configure: make PCRE v2 the default PCRE implementation

NEW: This changes the default PCRE implementation to v2, and makes
USE_LIBPCRE mean USE_LIBPCRE2, but USE_LIBPCRE1 is still available.

I originally wrote this as something to keep for some future
submission, but come to think of it I can't see why it shouldn't be
applied.

The v2 PCRE is stable & end-user compatible, all this change does is
change the default, someone building a new git is likely to also have
packaged PCRE v2 sometime in the last 2 years since it was released,
and if not they can choose to use the legacy v2 library by making the
trivial s/USE_LIBPCRE/USE_LIBPCRE1/ change, or package up PCRE v2.

 Documentation/git-grep.txt         |   7 +-
 Documentation/rev-list-options.txt |   9 +-
 Makefile                           |  39 +++++--
 builtin/grep.c                     |   4 +
 configure.ac                       |  81 +++++++++++---
 grep.c                             | 214 ++++++++++++++++++++++++++++++------
 grep.h                             |  32 +++++-
 revision.c                         |   2 +-
 t/README                           |   4 +-
 t/perf/p7820-grep-engines.sh       |  25 +++++
 t/t4202-log.sh                     |  86 ++++++++++++++-
 t/t7810-grep.sh                    |  41 ++++---
 t/t7812-grep-icase-non-ascii.sh    |   4 +-
 t/t7813-grep-icase-iso.sh          |  11 +-
 t/t7814-grep-recurse-submodules.sh | 215 +++++++++++++++++++++++--------------
 t/test-lib.sh                      |   3 +-
 16 files changed, 608 insertions(+), 169 deletions(-)
 create mode 100755 t/perf/p7820-grep-engines.sh

-- 
2.11.0

