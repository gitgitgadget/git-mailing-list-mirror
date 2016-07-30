Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8854B1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbcG3RZY (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:25:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34048 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcG3RZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:25:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so20050831wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2mtB5E9YlP9Z3UaQ1e2JKTDexGb5Jh5iLHqkV78AQY=;
        b=YjjDkgNpQ/0RrlByXoY3pV/4lHQtgEOIhPd7WyEx8hmaBMoW082m8w7l7BKNKCg12S
         7ocOI/r6ggOP0Falfl4Y9q4JqJKEQ4i03kn2OiJ+hgfFjLg4084YedN82HIzdvyoMmr2
         55rb3uG+Tdc/cgKU//2XGSzK9mKTTzlJdF5tZfhc6/SarqB7gvXhWaKwwaNmUsuinOoz
         f26EYU6DPmAxVCqC1aPieW1mciS0lArMXNdvcqVSkoOZbL2SAnozBx1fcTGQdHgAzI7T
         gqmQtKjCD5ma5wmfdU1UWIz66TqRbujcsc1Md+3dPrSdlL4Pn4A4qOkgKolhkjIFf2ZQ
         AYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2mtB5E9YlP9Z3UaQ1e2JKTDexGb5Jh5iLHqkV78AQY=;
        b=QuglZyOXFEdxukcN5RXlITJSEj+ndC1ZH0A9/yVxiazSgEK6YoDxbZ5d/uiX+94vhM
         hqctOVGj840ZnDDew53gjssH4L4x9jUyiYRzWOzitxtLNg2EiI4K2O6xdWXcZWes8ah7
         aUh/aJu4lPT3fHMynBWpK558QlEAUEnEwau6SNFmZFAnh+8uf43dkYh+W/K6hwmHnQAk
         sQMi+ZRaIoGtD1GXBfQ+ULumhVUP/NaCyWi2Xkd/oU/nIq4KQ/r2wLlAQY7kbTroPTzX
         Jbx2aXLkKLf37b5cwVbZhmmLZKKFZ58QLCSP+dBcNlhCnk39yVZE4yVlqTVXZDQZW7Jh
         ZP2g==
X-Gm-Message-State: AEkoouuwNL4W0tLl8NNjmXk8qfpJQG0JKaMZT7uYTScsXk4Jr1FjTJAPe4MxWd6Q2xEADw==
X-Received: by 10.28.71.197 with SMTP id m66mr50874784wmi.26.1469899520542;
        Sat, 30 Jul 2016 10:25:20 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:19 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 00/41] libify apply and use lib in am, part 2
Date:	Sat, 30 Jul 2016 19:24:28 +0200
Message-Id: <20160730172509.22939-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is "part 2" of the full patch series. This is built on top of the
"part 1" and as the "part 1" is now in "master", this "part 2" is
built on top of "master".

  - Patches 01/41 was new in v8 and hasn't changed.

It renames some structs and constants that will be moved into apply.h
to give them a more specific name.

  - Patches 02/41 to 31/41 were in v1, v2, v6, v7 anv v8.

They finish libifying the apply functionality that was in
builtin/apply.c and move it into apply.{c,h}, but the libified
functionality is not yet used in `git am`.

The only change in those patches is in 30/41 where an
`#include "builtin.h"` has been added back into "builtin/apply.c"
thanks to Ramsey.

  - Patch 32/41 was in v6, v7 and v8.

It replaces some calls to error() with calls to error_errno(). It is
the same as in v8, but it was at the end of the series (41/41) in v8
and has been moved from there as suggested by Junio.

  - Patch 33/41 was in v2, v6, v7 and v8.

It makes it possible to temporarily change the current index.

This is a hack to make it possible for `git am` to use the libified
apply functionality on a different index file.

`git am` used to do that by setting the GIT_INDEX_FILE env variable
before calling `git apply`.

The commit message has been improved and some comments have been added
as suggested by Junio to make it clear that this is a short cut that
adds some technical debt.

  - Patches 34/41 to 39/41 were in v2, v6, v7 and v8.

They implement a way to make the libified apply code silent by
changing the bool `apply_verbosely` into a tristate enum called
`apply_verbosity`, that can be one of `verbosity_verbose`,
`verbosity_normal` or `verbosity_silent`.

This is because "git am", since it was a shell script, has been
silencing the apply functionality by redirecting file descriptors to
/dev/null, but this is not acceptable in C.

There are many changes, thanks to Junio, in these patches compared to
v8, as the previous iterations added a `be_silent` bool instead of
changing `apply_verbosely` into `apply_verbosity`.

The previous patch 35/41 (apply: make 'be_silent' incompatible with
'apply_verbosely') has been removed as it is not necessary anymore.

  - Patch 40/41 is new.

It refactors `git apply` option parsing to make it possible for `git
am` to easily pass some command line options to the libified applied
code as suggested by Junio.

  - Patch 41/41 was in v1, v2, v6, v7 and v8.

This patch makes `git am` use the libified functionality. It now uses
the refactored code from the new patch 40/41 to parse `git apply`
options.


General comments
~~~~~~~~~~~~~~~~

Sorry if this patch series is still long. Hopefully the early part of
this series until 32/41 will be ready soon to be moved to next and
master, and I may only need to resend the rest.

I will send a diff between this version and the previous one, as a
reply to this email.

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
  environment: add set_index_file()
  write_or_die: use warning() instead of fprintf(stderr, ...)
  apply: make it possible to silently apply
  apply: don't print on stdout in verbosity_silent mode
  usage: add set_warn_routine()
  usage: add get_error_routine() and get_warn_routine()
  apply: change error_routine when silent
  apply: refactor `git apply` option parsing
  builtin/am: use apply api in run_apply()

 Makefile               |    1 +
 apply.c                | 4969 ++++++++++++++++++++++++++++++++++++++++++++++++
 apply.h                |  142 ++
 builtin/am.c           |   65 +-
 builtin/apply.c        | 4873 +----------------------------------------------
 cache.h                |    1 +
 environment.c          |   12 +
 git-compat-util.h      |    3 +
 t/t4012-diff-binary.sh |    4 +-
 t/t4254-am-corrupt.sh  |    2 +-
 usage.c                |   15 +
 write_or_die.c         |    3 +-
 12 files changed, 5209 insertions(+), 4881 deletions(-)
 create mode 100644 apply.c
 create mode 100644 apply.h

-- 
2.9.2.558.gf53e569

