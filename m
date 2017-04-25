Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0D7207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951552AbdDYVGC (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:02 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34384 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948415AbdDYVF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:05:59 -0400
Received: by mail-wm0-f52.google.com with SMTP id r190so16944192wme.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EX4cMYyIH67rxDJsdEvFmTAxnw0vMmWJoVzYY1DUkuE=;
        b=YVqQarbYBve/aWfJaRtWU9Y/tjSByPhJnViAHF30vbKttu+n/HwHjK5z/DLFI0bGxh
         sL7M0sL93dKncl6qGMgXrTGYjeRHJ0WSjiS9Yoq2d+pHFW2BS09z5euJ/opItVGh3O1W
         zMTgfEQiLZBJfc8v7yjeXSVwqRtM2hQFQnJaJk2aTqYMWYAuB4TOMFlsTx9Bi5Z7zxqu
         mLmIMgMJ1vaXu4TZazFYg4s+KhgwxBTWfAS7o6vNycU/ohBIsNM/7Lysgmg0XGMhaK0A
         YW4v6MN0D9ry4UDHx1zO/wYhUftFlwcWcgMsubWhDD5nixRmdqUlC+m+trO3LE9gDDSM
         PBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EX4cMYyIH67rxDJsdEvFmTAxnw0vMmWJoVzYY1DUkuE=;
        b=VpuF6yD7v4wUTLw97gwE4HqhAyMVcDcHiIdtxYOe8aMAuuzlrfdJ1d6SM6CtX1LGH2
         27h26qVSdloEwYCSt2aVZL/zzuVTqFjCgC3qlBfIv0xb6Rwap2a43IzjweRtrzCYd2VQ
         HwK81xvQ81c0Krh/NJnDjV+uUHjlWmtobyEnna3Nkec7djrHKziVQS+1Rhy3jlTqFLPr
         Lx5X/uc278m3ILTLIzkitDnVIdPqx172Qi6pLyfg+LjX0Fmoo3YmQVvHqCUQ6IeZ0OpB
         8FfE9jb9EWY0apBHamH/hdnh+r88BnsDldSHrsCCprYehpeEpz/flu5Gv8Ti+gQRdEPD
         NhOw==
X-Gm-Message-State: AN3rC/6XyMjFBokx2jBvpwi7c/MoAV4tMOko9dglaqg/8lHQnW1OznPH
        9ByG7fbnhoNpew==
X-Received: by 10.28.158.82 with SMTP id h79mr3410025wme.59.1493154358371;
        Tue, 25 Apr 2017 14:05:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:05:57 -0700 (PDT)
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
Subject: [PATCH v4 00/19] PCRE v1 improvements & PCRE v2 support
Date:   Tue, 25 Apr 2017 21:05:29 +0000
Message-Id: <20170425210548.24612-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trivial changes since last time. Just sending this because I'd like
the copy in pu updated. Changes noted below:

Ævar Arnfjörð Bjarmason (19):
  grep: amend submodule recursion test in preparation for rx engine
    testing
  grep: add tests for grep pattern types being passed to submodules

A s/PCRE/LIBPCRE/ on the test_have_prereq, now makes sense with the
series in sequence (error added during rebasing).

  grep: submodule-related case statements should die if new fields are
    added
  grep: remove redundant regflags assignment under PCRE
  grep: remove redundant `regflags &= ~REG_EXTENDED` assignments

NEW: Similarly to how we didn't need to set regflags under PCRE, we
were negating REG_EXTENDED under POSIX basic, without ever setting it
in the first place.

This was just as confusing as the PCRE oddity, so remove it.

  Makefile & configure: reword outdated comment about PCRE
  grep: add a test for backreferences in PCRE patterns
  log: add exhaustive tests for pattern style options & config
  log: add -P as a synonym for --perl-regexp
  grep & rev-list doc: stop promising libpcre for --perl-regexp
  grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
  test-lib: rename the LIBPCRE prerequisite to PCRE

One corresponding s/LIBPCRE/PCRE/ for the earlier change, see above.

  grep: change the internal PCRE macro names to be PCRE1
  grep: change the internal PCRE code & header names to be PCRE1
  perf: add a performance comparison test of grep -E and -P
  grep: add support for the PCRE v1 JIT API
  grep: add support for PCRE v2

We now give proper error messages via pcre2_get_error_message() when
pcre2_match() fails with errors other than "didn't match", the common
case for this is that the engine gave up on a pathological pattern /
input combination.

  grep: remove support for concurrent use of both PCRE v1 & v2
  Makefile & configure: make PCRE v2 the default PCRE implementation

Added more details to the commit message about why switching to PCRE
v2 by default is a good idea. I hadn't noticed before that deep bugs
in PCRE v1 are being WONTFIX'd on the bugtracker saying "nope, never
fixing thath in v1, switch to v2".

 Documentation/git-grep.txt         |   7 +-
 Documentation/rev-list-options.txt |   9 +-
 Makefile                           |  39 +++++--
 builtin/grep.c                     |   4 +
 configure.ac                       |  81 ++++++++++++--
 grep.c                             | 222 +++++++++++++++++++++++++++++++------
 grep.h                             |  32 +++++-
 revision.c                         |   2 +-
 t/README                           |   4 +-
 t/perf/p7820-grep-engines.sh       |  25 +++++
 t/t4202-log.sh                     |  86 +++++++++++++-
 t/t7810-grep.sh                    |  41 ++++---
 t/t7812-grep-icase-non-ascii.sh    |   4 +-
 t/t7813-grep-icase-iso.sh          |  11 +-
 t/t7814-grep-recurse-submodules.sh | 215 +++++++++++++++++++++--------------
 t/test-lib.sh                      |   3 +-
 16 files changed, 613 insertions(+), 172 deletions(-)
 create mode 100755 t/perf/p7820-grep-engines.sh

-- 
2.11.0

