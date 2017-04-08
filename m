Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34F120970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbdDHNZm (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:25:42 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34833 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdDHNZk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:25:40 -0400
Received: by mail-wr0-f196.google.com with SMTP id t20so23481908wra.2
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fonaqyz/+mUulpKf6BRhR7J8Q74EEZvSBqL7SMx+Oy0=;
        b=m6vlfYmMwgsjsIMRYB9WeeXWeywEwiclxOQGabA2zGxz0+TNHHaX/JjFaDu4sqvpuC
         Gib+mSl9RIW9rEp/+Ax+qits2fzg5zOeqp5HsKUL+rk6k+WTES8BUGfCR1vwJ+e+ZNOY
         SRUdzpZU8gzJSTC0XWCNd7k/VM1wXIpoXSLvxeoQhWZAdvoLbQhgQdBxcx4bX+YAs1x9
         sEXuJoC/fnqZE4rCpQJPzjfCDyHaLETEG9kkfuwm8XcHT1ggi1WNmQfJ9yauMPsnFer2
         IMdeFE4oc+W5wCfqlMxP8Kz8EkyQKDbMWvMEoX9v/lIsQMGoPU4RU9XZyRdi3AdFgUV6
         2v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fonaqyz/+mUulpKf6BRhR7J8Q74EEZvSBqL7SMx+Oy0=;
        b=g5xxR9DJMj4PEtK86kMWtpnYy3SVsgONsdqhMp8xLNIY0j0SiWOLo+bYPKZOmrxJAc
         qBA1qdP0Uu2u3BV+2WdJPkuz8LFoO9zlbIHXF5Qho4baoE/WGL3F/scgQxV1d0Gn9csy
         Tye0Fyh5eFtYFZ/W4wCwTPQjt99oTa3XJqJZqcmITcMJ8Ef1ivO6M+7qD2ycqZ5ulVOO
         6A7pppY1JFFac22XbCyoud6nl4Uo+F+o6ROkqWxQFqyywNzbdnU38EPeWrifYuk1JjvJ
         bpn5L5Z9y7lw3isQSyvIs1blwK9zA7eBvyu5s2fuXGE0Hu7nuVqLoM5kYE66eNqqgCO5
         LWwA==
X-Gm-Message-State: AFeK/H35rkrLNYQbf6V3Sw45jaW8FNlztF/RiB7i/SVPzL6c9VJ3RKZDqXAFybIza20ifA==
X-Received: by 10.223.135.196 with SMTP id c4mr19333934wrc.109.1491657939091;
        Sat, 08 Apr 2017 06:25:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:25:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/12] PCREv2 & more
Date:   Sat,  8 Apr 2017 13:24:54 +0000
Message-Id: <20170408132506.5415-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds PCRE v2 support, but as I was adding that I kept noticing
other related problems to fix. It's all bundled up into the same
series because much of it conflicts because it modifies the same test
or other code. Notes on each patch below.

Ævar Arnfjörð Bjarmason (12):
  grep: add ability to disable threading with --threads=0 or
    grep.threads=0

This really has nothing to do with the rest except I'm using it to
test non-multithreaded & threaded PCRE more easily.

  grep: remove redundant regflags assignment under PCRE
  Makefile & configure: reword outdated comment about PCRE

Just some trivial cleanups.

  grep: add a test for backreferences in PCRE patterns
  log: add exhaustive tests for pattern style options & config

Yay, more tests!

  log: add -P as a synonym for --perl-regexp

We've had --perl-regexp for years, but not -P like grep, add it.

  grep & rev-list doc: stop promising libpcre for --perl-regexp
  grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
  test-lib: rename the LIBPCRE prerequisite to PCRE
  grep: change the internal PCRE macro names to be PCRE1
  grep: change the internal PCRE code & header names to be PCRE1
  grep: add support for PCRE v2

These combined add the support for PCRE 2. It's split up for ease of
readability. The last one's still a bit big, and I could e.g. split up
all the Makefile/autoconf stuff into a different patch (which wouldn't
do anything without the code), but I thought on balance doing it this
way made the most sense.

 Documentation/config.txt           |   7 ++
 Documentation/git-grep.txt         |   8 +-
 Documentation/rev-list-options.txt |   6 +-
 Makefile                           |  28 +++++-
 builtin/grep.c                     |  26 +++++-
 configure.ac                       |  61 ++++++++++--
 grep.c                             | 184 ++++++++++++++++++++++++++++++-------
 grep.h                             |  26 ++++--
 revision.c                         |   2 +-
 t/README                           |  16 +++-
 t/t4202-log.sh                     |  76 ++++++++++++++-
 t/t7810-grep.sh                    |  79 +++++++++++++---
 t/t7812-grep-icase-non-ascii.sh    |   4 +-
 t/t7813-grep-icase-iso.sh          |  11 ++-
 t/test-lib.sh                      |   4 +-
 15 files changed, 456 insertions(+), 82 deletions(-)

-- 
2.11.0

