Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7091F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754759AbcH0SqB (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:01 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33428 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbcH0Sp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:45:59 -0400
Received: by mail-it0-f65.google.com with SMTP id d65so2941656ith.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gu1eE2E5b8IiY1PVaBj7gtPo/9QJy75SeHSsw60MVoM=;
        b=Z1akcFvGJB9u6XPx64K7V5+GHYNEQk4h6Ar9jVx8313yDjIpZkaout1KhSxJ2KED5G
         +HtG2ZHDXBJvYjAvotv2tqeIbMvNyT6aQHAh5GmhusC0SBziKqfR+FS3dwnJH7Yxr8qz
         G71PfMGPMzT2LCc4PYOxx8JgXyWkZMXuoGbymzQnyG72/JDZ0ZOE1XeUCasJfltiSsyd
         gUbIdNYhZSG1ip3zk/hnAUf9JaIq1f8KwD3qOS8aDZMANmlGynyCTfjPlu13OP14lkWQ
         XG7DesvgnAPXOmv6Rd8NeTgKG39JUlWo9BgLk6pELijyQ4xEyspYJn4rc0Tz7qNJmhXP
         JS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gu1eE2E5b8IiY1PVaBj7gtPo/9QJy75SeHSsw60MVoM=;
        b=eclpXU6KRig0+jDQciMRkSE0pVisp0mT9JTa5l7SUhiu6a+m4RCPAkC7n+WeTmcKLX
         AD3E0nwGcoabOBwXhx5nJaIm+7Zf5AgY+NHYqrAhS2icFNV0DFXoEq8VW+YzCLHogFx1
         28uU4W+o7emwwKnj+km/s00mikshmYxp5l2RZZTrnYoY/GkY/vsOiW33tyEum0Q1HCL8
         MmacfFd2V8mq/5Uqk1bCLBG4ip8H5QslHCiNujL4MiF3JEIWudkNuNhwHB8v5QfcL3UX
         PIEvO9fPu93CE7rujxSYv6depUPBv8cm8E/aGasZuFlLJPAte1t3+mN2mgZrT6asfq2F
         aXZw==
X-Gm-Message-State: AE9vXwNupeNEXzBNmVl/wCfvovsP3HWNtX/cN3DYv6BMKM51OZlNFXkrb0NOGAss71CSyw==
X-Received: by 10.107.57.215 with SMTP id g206mr11642619ioa.194.1472323558366;
        Sat, 27 Aug 2016 11:45:58 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:45:57 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 00/14] libify apply and use lib in am, part 3
Date:   Sat, 27 Aug 2016 20:45:33 +0200
Message-Id: <20160827184547.4365-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal
~~~~

This is a patch series about libifying `git apply` functionality, and
using this libified functionality in `git am`, so that no 'git apply'
process is spawn anymore. This makes `git am` significantly faster, so
`git rebase`, when it uses the am backend, is also significantly
faster.

Previous discussions and patches series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This has initially been discussed in the following thread:

  http://thread.gmane.org/gmane.comp.version-control.git/287236/

Then the following patch series were sent:

RFC: http://thread.gmane.org/gmane.comp.version-control.git/288489/
v1: http://thread.gmane.org/gmane.comp.version-control.git/292324/
v2: http://thread.gmane.org/gmane.comp.version-control.git/294248/
v3: http://thread.gmane.org/gmane.comp.version-control.git/295429/
v4: http://thread.gmane.org/gmane.comp.version-control.git/296350/
v5: http://thread.gmane.org/gmane.comp.version-control.git/296490/
v6: http://thread.gmane.org/gmane.comp.version-control.git/297024/
v7: http://thread.gmane.org/gmane.comp.version-control.git/297193/
v8: https://public-inbox.org/git/20160627182429.31550-1-chriscool%40tuxfamily.org/
v9: https://public-inbox.org/git/20160730172509.22939-1-chriscool%40tuxfamily.org/
v10: https://public-inbox.org/git/20160808210337.5038-1-chriscool%40tuxfamily.org/
v11: https://public-inbox.org/git/20160811085229.19017-1-chriscool%40tuxfamily.org/
v12: https://public-inbox.org/git/20160811184501.384-1-chriscool@tuxfamily.org/

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is "part 3" of the full patch series. I am resending only the
last 14 patches of the full series as "part 3", because I don't want
to resend the first 27 patches of v10 nearly as is.

(So "part 2" is made of patch 01/40 from v11 and patches from 02/40 to
27/40 from v10. And "part 1" has been in "master" for some time now.)

  - Patch 01/14 to 04/14 were v1, v2, v6, v7, v8, v9, v10, v11 and v12.

They haven't changed since v12.

They finish libifying the apply functionality that was in
builtin/apply.c and move it into apply.{c,h}, but the libified
functionality is not yet used in `git am`.

  - Patch 05/14 was in v6, v7, v8, v9, v10 and v12 and hasn't changed.

It replaces some calls to error() with calls to error_errno().

  - Patches 06/14 to 10/14 were in v2, v6, v7, v8, v9 and v10.

They haven't changed since v10.

They implement a way to make the libified apply code silent by
changing the bool `apply_verbosely` into a tristate enum called
`apply_verbosity`, that can be one of `verbosity_verbose`,
`verbosity_normal` or `verbosity_silent`.

This is because "git am", since it was a shell script, has been
silencing the apply functionality by redirecting file descriptors to
/dev/null, but this is not acceptable in C.

  - Patch 11/14 was in v9, v10 and v12, and hasn't changed.

It refactors `git apply` option parsing to make it possible for `git
am` to easily pass some command line options to the libified applied
code.

  - Patch 12/14 is new.

It is a refactoring to prepare for some new changes in patch 13/14.

  - Patch 13/14 was in v12.

It replaces patch 33/40 in v10 (environment: add set_index_file())
that was a hack to make it possible for `git am` to use the libified
apply functionality on a different index file.

For this purpose in this patch we add a "const char *index_file" into
"struct apply_state", and when "index_file" is set, we use
hold_lock_file_for_update(), passing it "state->index_file", instead
of using hold_locked_index(), as it is not possible to pass an index
filename in hold_locked_index().

This patch was changed in this version to also use
"read_cache_from(state->index_file)" instead of "read_cache()" when
state->index_file is set.

  - Patch 14/14 was in v1, v2, v6, v7, v8, v9, v10 and v12, and hasn't
    changed since v12.

This patch makes `git am` use the libified functionality.

General comments
~~~~~~~~~~~~~~~~

Now this patch series is shorter than previously. Hopefully also the
early part of this series until 05/14 or 11/14 will be ready soon to
be moved to next and master, and I may only need to resend the last 3
patches if anything.

I will send a diff between this version and v12 as a reply to this
email.

The benefits are not just related to not creating new processes. When
`git am` launched a `git apply` process, this new process had to read
the index from disk. Then after the `git apply`process had terminated,
`git am` dropped its index and read the index from disk to get the
index that had been modified by the `git apply`process. This was
inefficient and also prevented the split-index mechanism to provide
many performance benefits.

By the way, current work is ongoing to make it possible to use
split-index more easily by adding a config variable, see:

https://public-inbox.org/git/20160711172254.13439-1-chriscool%40tuxfamily.org/

Using an earlier version of this series as rebase material, Duy
explained split-index benefits along with this patch series like this:

 > Without the series, the picture is not so surprising. We run git-apply
 > 80+ times, each consists of this sequence
 >
 > read index
 > write index (cache tree updates only)
 > read index again
 > optionally initialize name hash (when new entries are added, I guess)
 > read packed-refs
 > write index
 >
 > With this series, we run a single git-apply which does
 >
 > read index (and sharedindex too if in split-index mode)
 > initialize name hash
 > write index 80+ times

(See: http://thread.gmane.org/gmane.comp.version-control.git/292324/focus=292460)

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/libify-apply-use-in-am

The previous versions are available there:

v1: https://github.com/chriscool/git/commits/libify-apply-use-in-am25 
v2: https://github.com/chriscool/git/commits/libify-apply-use-in-am54
v6: https://github.com/chriscool/git/commits/libify-apply-use-in-am65
v7: https://github.com/chriscool/git/commits/libify-apply-use-in-am75
v8: https://github.com/chriscool/git/commits/libify-apply-use-in-am97
v9: https://github.com/chriscool/git/commits/libify-apply-use-in-am106
v10: https://github.com/chriscool/git/commits/libify-apply-use-in-am114
v11: https://github.com/chriscool/git/commits/libify-apply-use-in-am116
v12: https://github.com/chriscool/git/commits/libify-apply-use-in-am118

Performance numbers
~~~~~~~~~~~~~~~~~~~

Numbers are only available for tests that have been performed on Linux
using a very early version of this series, though Johannes Sixt
reported great improvements on Windows. It could be interesting to get
detailed numbers on other platforms like Windows and OSX.

  - Around mid April Ævar did a huge many-hundred commit rebase on the
    kernel with untracked cache.

command: git rebase --onto 1993b17 52bef0c 29dde7c

Vanilla "next" without split index:                1m54.953s
Vanilla "next" with split index:                   1m22.476s
This series on top of "next" without split index:  1m12.034s
This series on top of "next" with split index:     0m15.678s

Ævar used his Debian laptop with SSD.

  - Around mid April I tested rebasing 13 commits in Booking.com's
    monorepo on a Red Hat 6.5 server with split-index and
    GIT_TRACE_PERFORMANCE=1.

With Git v2.8.0, the rebase took 6.375888383 s, with the git am
command launched by the rebase command taking 3.705677431 s.

With this series on top of next, the rebase took 3.044529494 s, with
the git am command launched by the rebase command taking 0.583521168
s.

Christian Couder (14):
  builtin/apply: rename option parsing functions
  apply: rename and move opt constants to apply.h
  Move libified code from builtin/apply.c to apply.{c,h}
  apply: make some parsing functions static again
  apply: use error_errno() where possible
  apply: make it possible to silently apply
  apply: don't print on stdout in verbosity_silent mode
  usage: add set_warn_routine()
  usage: add get_error_routine() and get_warn_routine()
  apply: change error_routine when silent
  apply: refactor `git apply` option parsing
  apply: pass apply state to build_fake_ancestor()
  apply: learn to use a different index file
  builtin/am: use apply API in run_apply()

 apply.c           | 4871 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 apply.h           |   34 +-
 builtin/am.c      |   65 +-
 builtin/apply.c   | 4814 +---------------------------------------------------
 git-compat-util.h |    3 +
 usage.c           |   15 +
 6 files changed, 4961 insertions(+), 4841 deletions(-)

-- 
2.9.2.770.g14ff7d2

