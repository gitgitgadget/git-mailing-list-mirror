Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0AC2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbcHHVD4 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:03:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32823 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbcHHVDx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:03:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so17869825wme.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:03:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lu93oWRfOnWHAubm2qit4YcxDrtQVTSNBFdpdrGiPkQ=;
        b=IynUSDgsbrAF41flHZFCrK4raDlYsxefdZVb5RTTRLp837fQigyDKNA1QIRDlqKX4C
         E6ekx50r+bnw/PguWbOQELx7aDf/qFHs0zhOie2e0RMlueY1Sk/MLIYW4ktrL3ruivg8
         6R1UddBonuHYk8s3Gc7BCraFjWK+6I4AamtbfscgQ1Y3ADcROqQ72wY2M5u2niSXH7y+
         C6rrkPbwSB6LLrKKi7bIKES581dRZMPgg6rBzadOvQwdJSqXMbVXhyEha1GgjgQ9m6DZ
         cr6eHjcfsA6jgXKcgUtj1ZD/Ki5VZUuDPjI48FXc+rQeF1S/UWAZdR3kA2DaxcElAf9F
         xzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lu93oWRfOnWHAubm2qit4YcxDrtQVTSNBFdpdrGiPkQ=;
        b=X0Cl+WUHiNLyoAUtdJBcjaIlMAv7IwPjvDGLbNIiDYqyaIJOL/XN0RCjJT1Rb6zOiE
         sQRTPjZrwFWbN+c2BBInvy87CC3Bjh+CTEveb6INMFFLkuR65BWeqCqospE+Nk+aC6tf
         0IYw/nMDi7UZgSfvBDN7uy0/09WRcSdiQX7kS78slJLNLCrtlueM5zjadluOcpg4Fxyh
         XJStscjPxvtszhDeCyt4XBpNiIcKrLkYziTZaQocJR1/4iCk3XhGp63MjKbEJViOTk0P
         64otZo7jeiUQv5q5oqkWJsNB69MYT5hsPy2+5vuD7xSPH29ezk3yXBo9UfvJ3mRMuqLn
         ORTQ==
X-Gm-Message-State: AEkoousMNJc61neeEasqDipTUQ/e+3QQO6XeN+RNmxC94D8C3/AcAdWARFtF83kVcPPs9w==
X-Received: by 10.28.48.71 with SMTP id w68mr17111640wmw.4.1470690231777;
        Mon, 08 Aug 2016 14:03:51 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:03:50 -0700 (PDT)
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
Subject: [PATCH v10 00/40] libify apply and use lib in am, part 2
Date:	Mon,  8 Aug 2016 23:02:57 +0200
Message-Id: <20160808210337.5038-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
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
v9: https://public-inbox.org/git/20160730172509.22939-1-chriscool%40tuxfamily.org/

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is "part 2" of the full patch series. This is built on top of the
"part 1" and as the "part 1" is now in "master", this "part 2" is
built on top of "master".

  - Patch 01/40 was in v8 and v9, and hasn't changed.

It renames some structs and constants that will be moved into apply.h
to give them a more specific name.

  - Patches 02/40 to 31/40 were in v1, v2, v6, v7, v8 and v9.

They finish libifying the apply functionality that was in
builtin/apply.c and move it into apply.{c,h}, but the libified
functionality is not yet used in `git am`.

There are a few minor changes in these patches. In 04/40 we now
consider that we have an error if read_patch_file() returns a negative
integer instead of just a non 0 integer, as Stefan suggested. In 26/40
we now use write_in_full() instead of write_or_whine_pipe(), as
suggested by Peff.

  - Patch 32/40 was in v6, v7, v8 and v9, and hasn't changed.

It replaces some calls to error() with calls to error_errno().

  - Patch 33/40 was in v2, v6, v7, v8 and v9.

It makes it possible to temporarily change the current index.

This is a hack to make it possible for `git am` to use the libified
apply functionality on a different index file.

`git am` used to do that by setting the GIT_INDEX_FILE env variable
before calling `git apply`.

The commit message has been improved again to explain more why we are
using this short cut and more comments have been added, especially in
apply.h, as suggested by Junio and Stefan.

  - Patches 34/40 to 38/40 were in v2, v6, v7, v8 and v9.

They implement a way to make the libified apply code silent by
changing the bool `apply_verbosely` into a tristate enum called
`apply_verbosity`, that can be one of `verbosity_verbose`,
`verbosity_normal` or `verbosity_silent`.

This is because "git am", since it was a shell script, has been
silencing the apply functionality by redirecting file descriptors to
/dev/null, but this is not acceptable in C.

The most significant change in these patches is that one patch (34/41
in v9: write_or_die: use warning() instead of fprintf(stderr, ...))
has been removed, as it was not needed anymore, since we don't use
write_or_whine_pipe(), as suggested by Peff.

Another change is that in 34/40, a spurious coma has been removed just
after the last element in an enum, as suggested by Junio.

The last change is that a comment has been improved in 38/40 as
suggested by Stefan.

  - Patch 39/40 was new in v9.

It refactors `git apply` option parsing to make it possible for `git
am` to easily pass some command line options to the libified applied
code as suggested by Junio.

Compared to v9, we now remove some useless function declarations from
"apply.h", and make the related functions static again in "apply.c",
as suggested by Ramsay.

  - Patch 40/40 was in v1, v2, v6, v7, v8 and v9, and hasn't changed.

This patch makes `git am` use the libified functionality. It now uses
the refactored code from the new patch 40/40 to parse `git apply`
options.


General comments
~~~~~~~~~~~~~~~~

Sorry if this patch series is still long. Hopefully the early part of
this series until 32/40 will be ready soon to be moved to next and
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
v9: https://github.com/chriscool/git/commits/libify-apply-use-in-am106

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


Christian Couder (40):
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
  apply: make it possible to silently apply
  apply: don't print on stdout in verbosity_silent mode
  usage: add set_warn_routine()
  usage: add get_error_routine() and get_warn_routine()
  apply: change error_routine when silent
  apply: refactor `git apply` option parsing
  builtin/am: use apply api in run_apply()

 Makefile               |    1 +
 apply.c                | 4972 ++++++++++++++++++++++++++++++++++++++++++++++++
 apply.h                |  132 ++
 builtin/am.c           |   65 +-
 builtin/apply.c        | 4873 +----------------------------------------------
 cache.h                |   13 +
 environment.c          |   16 +
 git-compat-util.h      |    3 +
 t/t4012-diff-binary.sh |    4 +-
 t/t4254-am-corrupt.sh  |    2 +-
 usage.c                |   15 +
 11 files changed, 5217 insertions(+), 4879 deletions(-)
 create mode 100644 apply.c
 create mode 100644 apply.h

-- 
2.9.2.614.g4980f51

