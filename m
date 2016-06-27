Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139C02018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbcF0SYw (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:24:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34418 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcF0SYv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:24:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so26958817wmz.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:24:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCw17urVAdrT4wKQmRx87BxSxDWXLCN1LpxB0mZVRao=;
        b=dfVEmmcCGeB5bj78Wq8lOmyp2gA3WZvVLD+X0TRJ08+kTEd9yFt+CoOUrucBguQJoX
         tpA5QYJ8Y4kxiKFiM1v+k8OPFZVALPTyb+82AdXWn+C+YcsbV8PcN8Pk6g9uhCByFTuQ
         tBkaLLuZbdcgXUAaZy2LhCoiA/HvPzCzB2gUJQZcP4cXsKp13vNR86LaBn6jhvi1/I4a
         lhIiwkKaEGPR+Jm4ZGxUqYvs9PEv5D/inZdmendEbKtPc/65pOhou9sBQuuj7pwGJWmi
         kUVCGgsCewyDcrBL61lxsj5T/89aqDLVLzwfEHzzaWegvT4aqmZ6YIy8RXTkXLL22Jnz
         f+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCw17urVAdrT4wKQmRx87BxSxDWXLCN1LpxB0mZVRao=;
        b=HXWMy0cstwVsfaegW09MLsLZjGtTSCbCxEuLqb0ajYE9sk2u4uDoIkHmli5A6thPpe
         NHpOrpPLpf2jRbvawWR9MgHax8DjKpxx+sPi+ZC+LaHi0gDGUI3kEHeYrLCdj8qvzzIF
         zCU/VJMeZEVAVen1v8Z7t7FF4RjwvcGfSsT1xGlDyACBHfUkYZ7+VmOId2sRCyzc/ofG
         hpcKbrZn11T1V86YdFRDw7jyec+DAPuOjryCSBo3aNj1RT5nJwCJPP0K2En8vjjghbPe
         WEeqH+sSugJuyMq38U/zlWtDZ5b9bezqJS2CDKo5n3fvuTjgHV+2N0TR/4qi0KKRNf3m
         eCpA==
X-Gm-Message-State: ALyK8tIrgQ0SlBPsU7oxxG4pXVvZliiIidWywSndKI6GFm4+AqocWr5Fgr5kLJb2zWZGLQ==
X-Received: by 10.194.178.199 with SMTP id da7mr2134409wjc.123.1467051889819;
        Mon, 27 Jun 2016 11:24:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:24:48 -0700 (PDT)
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
Subject: [PATCH v8 00/41] libify apply and use lib in am, part 2
Date:	Mon, 27 Jun 2016 20:23:48 +0200
Message-Id: <20160627182429.31550-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
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

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This new patch series is built on top of the above previous work.

More precisely, this is "part 2" of the full patch series which is
built on top of the "part 1" of the full patch series. And as the
"part 1" is now in "next", this "part 2" is built on top of "next".

  - Patches 01/41 is new in v8.

It renames some structs and constants that will be moved into apply.h
to give them a more specific name as suggested by Junio.

  - Patches 02/41 to 32/41 were in v1, v2, v6 and v7.

They finish libifying the apply functionality that was in
builtin/apply.c and move it into apply.{c,h}, but the libified
functionality is not yet used in `git am`.

There are a number of changes in these patches compared to v7, so that
apply_all_patches() will return 1 in case some patches don't apply and
128 in case a previously fatal error happened. This makes it possible
for `git apply` to return the same exit code as it used to return
before libification.

To do that a number of functions like find_header(), parse_chunk(),
apply_patch(), etc have been made to return -128 instead of -1 when it
was necessary.

  - Patches 33/41 to 39/41 were in v2, v6 and v7.

They implement a way to make the libified apply silent by adding a new
'be_silent' flag into 'struct apply_state'. It is a new feature in the
libified apply functionality.

This could be in a separate series, but unfortunately using the
libified apply in "git am" unmasks the fact that "git am", since it
was a shell script, has been silencing the apply functionality by
redirecting file descriptors to /dev/null and it looks like this is
not acceptable in C.

There are no changes in these patches compared to v7.

  - Patch 40/41 was in v1, v2, v6 and v7.

This patch makes `git am` use the libified functionality. It is the
same as in v7.

  - Patch 41/41 was in v6 and v7.

It replaces some calls to error() with calls to error_errno(). It is
the nearly the same as in v7. The only change is that one call to
error() is now replaced by error_errno() earlier in the series.

General comments
~~~~~~~~~~~~~~~~

Sorry if this patch series is still long. I can split it into two or
more series if it is prefered.

I will send a diff between this version and the previous one, as a
reply to this email.

The benefits are not just related to not creating new processes. When
`git am` launched a `git apply` process, this new process had to read
the index from disk. Then after the `git apply`process had terminated,
`git am` dropped its index and read the index from disk to get the
index that had been modified by the `git apply`process. This was
inefficient and also prevented the split-index mechanism to provide
many performance benefits.

Using this series as rebase material, Duy explains it like this:

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

Performance numbers
~~~~~~~~~~~~~~~~~~~

Only tests on Linux have been performed using a very early version of
this series. It could be interesting to test on other platforms
especially Windows and perhaps OSX too.

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
  environment: add set_index_file()
  write_or_die: use warning() instead of fprintf(stderr, ...)
  apply: add 'be_silent' variable to 'struct apply_state'
  apply: make 'be_silent' incompatible with 'apply_verbosely'
  apply: don't print on stdout when be_silent is set
  usage: add set_warn_routine()
  usage: add get_error_routine() and get_warn_routine()
  apply: change error_routine when be_silent is set
  builtin/am: use apply api in run_apply()
  apply: use error_errno() where possible

 Makefile               |    1 +
 apply.c                | 4891 ++++++++++++++++++++++++++++++++++++++++++++++++
 apply.h                |  133 ++
 builtin/am.c           |   91 +-
 builtin/apply.c        | 4803 +----------------------------------------------
 cache.h                |    1 +
 environment.c          |   10 +
 git-compat-util.h      |    3 +
 t/t4012-diff-binary.sh |    4 +-
 t/t4254-am-corrupt.sh  |    2 +-
 usage.c                |   15 +
 write_or_die.c         |    6 +-
 12 files changed, 5147 insertions(+), 4813 deletions(-)
 create mode 100644 apply.c
 create mode 100644 apply.h

-- 
2.9.0.172.gfb57a78

