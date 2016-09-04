Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EEEE1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbcIDUSr (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:18:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35325 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754167AbcIDUSq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:18:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id c133so10464935wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzbV9MpnOjMO7QvHw1GG53d52ktCTYExwCwuq2fr2kk=;
        b=auw/k//zBpFSm3fi8Uq6MStYYwR3xY2fdQljCmr2AoclgZnskhawTx/SzTk/pHRg4S
         59vg1SpCwmWp41i8Au+y88QQfeBrjFfub04SqUz0Jj/m0TZBDmqciaKJwLUSOUPOtVlR
         lCDIfcBffWBz/yozb6zPn7kBeJx5uT5NDHW7UYxHogOn/lE96EvaUU/S08pzHuTDEw47
         2lWUv/Z+UHLelCexSU7DIhllM89AKv2QAbdC8onylm243hNgrSJrHlZfRpNu3g78beHb
         zbeN/deVIG1P4XnFJQThB68Lnj/u/Sy2rq9hJuOAs+V3xFLJngD6YZIkp219lczL4NNq
         QtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzbV9MpnOjMO7QvHw1GG53d52ktCTYExwCwuq2fr2kk=;
        b=RuBM83MYGrPQF1xAp3I8d/ihNOD2xaXdVc2uXUSCOUep8Hjl0eRsfla8Ydm2V+5m9u
         NhcKNRP9tYANvNmWEHvpL7v9LOwhBUM0OX/OnZgKBotPZVdFysBfjghFIRq9pDF6ZtQ/
         5nk9JJoZjw213Kgv/1Fxpo+lowP49+VsXO6gu8bqbDyD5Lb2pWREojbyGQR3mxt8oykM
         iDzJamI4kyf8qdO7adcuxw2beZqbKekWA5J50S8PNP2b9nxYIBktyL7Gl2YjayICeqhw
         2DiHcyDOaEEiUOdaNB9AzU2zNbuUjMjtyfbkaWzmA6yoaSaMOxyOFwg8/XV1qQo43oij
         mukw==
X-Gm-Message-State: AE9vXwNEL5ffhyci1wilh7r42AKiCHKH3YdPwU+o1B6IYTKSKwQEUZmFhjgse/m3zSO0FA==
X-Received: by 10.194.85.18 with SMTP id d18mr27475926wjz.43.1473020324524;
        Sun, 04 Sep 2016 13:18:44 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:43 -0700 (PDT)
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
Subject: [PATCH v14 00/41] libify apply and use lib in am, part 2
Date:   Sun,  4 Sep 2016 22:17:52 +0200
Message-Id: <20160904201833.21676-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
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
v13: https://public-inbox.org/git/20160827184547.4365-1-chriscool@tuxfamily.org/

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is "part 2" of the full patch series. I am resending everything
that is not already in master to give people another chance to review
everything.

  - Patch 01/41 to 27/41 were in v10, but not in v11, v12, and v13.

They libify the apply functions by making them return error codes
instead of die()ing or exit()ing and by making sure they release all
the resources they use.

There is only one change in patch 26/41 where I now use error_errno()
right away instead of first using error() and then converting the
error() into error_errno() in patch 32/41.

  - Patches 28/41 to 31/41 were in v12 and v13.

They finish libifying the apply functionality that was in
builtin/apply.c and move it into apply.{c,h}, but the libified
functionality is not yet used in `git am`.

In patch 29/41 I added some comments in apply.h above the definition
of APPLY_OPT_INACCURATE_EOF and APPLY_OPT_RECOUNT, as suggested by
Stefan. This is the only change compared to v13.

  - Patch 32/41 was in v10, v12 and v13.

It replaces some calls to error() with calls to error_errno().

One hunk has been removed because of the changes in 26/41.

  - Patches 33/41 to 37/41 were in v10, v12 and v13.

They implement a way to make the libified apply code silent by
changing the bool `apply_verbosely` into a tristate enum called
`apply_verbosity`, that can be one of `verbosity_verbose`,
`verbosity_normal` or `verbosity_silent`.

The only changes since v13 are in 37/41. The name of the first
argument to mute_routine() is changed from "bla" to "msg" as suggested
by Ramsey, and the commit message is improved as suggested by Stefan.

  - Patch 38/41 was in v10, v12 and v13, and hasn't changed.

It refactors `git apply` option parsing to make it possible for `git
am` to easily pass some command line options to the libified applied
code.

  - Patch 39/41 was new in v13, and hasn't changed.

It is a refactoring to prepare for patch 40/41.

  - Patch 40/41 was in v12 and v13, and hasn't changed.

It adds a "const char *index_file" into "struct apply_state", to make
it possible to use a special index file instead of the default one.

  - Patch 41/41 was in v10, v12 and v13.

This patch makes `git am` use the libified functionality.

The only change compared to v13 is that "through" instead of "thru" is
used in an error message.

General comments
~~~~~~~~~~~~~~~~

Now this patch series is 41 patches long to give yet another
possibility for all the patches to be reviewed.

I took another look at all these patches myself and didn't find
anything other than the changes I made in 26/41 to improve.

I will send a diff between this version and v13 as a reply to this
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
v13: https://github.com/chriscool/git/commits/libify-apply-use-in-am120

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


Christian Couder (41):
  apply: make some names more specific
  apply: move 'struct apply_state' to apply.h
  builtin/apply: make apply_patch() return -1 or -128 instead of
    die()ing
  builtin/apply: read_patch_file() return -1 instead of die()ing
  builtin/apply: make find_header() return -128 instead of die()ing
  builtin/apply: make parse_chunk() return a negative integer on error
  builtin/apply: make parse_single_patch() return -1 on error
  builtin/apply: make parse_whitespace_option() return -1 instead of
    die()ing
  builtin/apply: make parse_ignorewhitespace_option() return -1 instead
    of die()ing
  builtin/apply: move init_apply_state() to apply.c
  apply: make init_apply_state() return -1 instead of exit()ing
  builtin/apply: make check_apply_state() return -1 instead of die()ing
  builtin/apply: move check_apply_state() to apply.c
  builtin/apply: make apply_all_patches() return 128 or 1 on error
  builtin/apply: make parse_traditional_patch() return -1 on error
  builtin/apply: make gitdiff_*() return 1 at end of header
  builtin/apply: make gitdiff_*() return -1 on error
  builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
  builtin/apply: make build_fake_ancestor() return -1 on error
  builtin/apply: make remove_file() return -1 on error
  builtin/apply: make add_conflicted_stages_file() return -1 on error
  builtin/apply: make add_index_file() return -1 on error
  builtin/apply: make create_file() return -1 on error
  builtin/apply: make write_out_one_result() return -1 on error
  builtin/apply: make write_out_results() return -1 on error
  builtin/apply: make try_create_file() return -1 on error
  builtin/apply: make create_one_file() return -1 on error
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

 Makefile               |    1 +
 apply.c                | 4988 ++++++++++++++++++++++++++++++++++++++++++++++++
 apply.h                |  137 ++
 builtin/am.c           |   65 +-
 builtin/apply.c        | 4873 +---------------------------------------------
 git-compat-util.h      |    3 +
 t/t4012-diff-binary.sh |    4 +-
 t/t4254-am-corrupt.sh  |    2 +-
 usage.c                |   15 +
 9 files changed, 5205 insertions(+), 4883 deletions(-)
 create mode 100644 apply.c
 create mode 100644 apply.h

-- 
2.10.0.41.g9df52c3

