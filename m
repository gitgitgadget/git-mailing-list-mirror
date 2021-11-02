Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203FFC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B92C604AC
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhKBPsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhKBPst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:48:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D5FC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:46:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d3so33969214wrh.8
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8rJ7k439SSwwbQNH8IQf5PXeKedSRNXTQpWjcneP5mQ=;
        b=h+SgO+eKrmD96mdc0KRlzUMLQMU86bKphj590+6J1jhEK85RySdEHI6nO6Nyk1uhgL
         icaZCm2Tef/RrzGuPsx/rpLYSOAwbE7rA5hOPvwfIaXRuCUHx7kndteReT+ZT4T4ibXM
         ntESXAMysiYQuUNS+Fgd5bM8bUDunnTVK8f6LyHdEidb4uZDMmTxmC42qRF7bAtFzQHm
         NR+CP7Z0siemBt3CfEtSHBe5Ydby41ConkVKP9SOQVevnZBeteV3fQlIiWeltlsJG4rP
         b38rPsGGYqAs4RIm9Az55k8i+csSoSoAuhHwHVXuuXz1qYleaRqiORdTL1U8SJP5O2bN
         Tc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=8rJ7k439SSwwbQNH8IQf5PXeKedSRNXTQpWjcneP5mQ=;
        b=D2X9kJdAOhfR7ElNokUc4/r1WGVCDPcwY/Rnhq+5fA9wwbMNJ+8Dj6+yoBjbyH14By
         4JZeC4bV92Ma+DpXTRXTq5ciBAMA2ZkrxCukHx8QU32LDS2IrwABWhvgeybMXNMaXowC
         NAnmjax2QDHckYmB5F+vDT5TeR2pJtJ/z9kvcBr04MjphClOCZQwQIBKD6XEGHf9X36V
         8Fe6DTsbFaDLjnAY+u0yOmJeLm4R0pxX/JhPKJTZ3fJSVarb238S52FW2d0CfWkI+Itz
         9PnaTGswBoD+He6vUTQPddQO+3vVGYJEevd5TA/+c4Pqka547/4TqrT/OCC6TtiZlsfI
         qJpg==
X-Gm-Message-State: AOAM533PZmyTlDJ+iodqJZVQv6O3nym+Sr7NL/Q1XmJvIRwKjHiTI451
        Cxih0a3ni1zWl+APnGFtC5Ch35qTlNE=
X-Google-Smtp-Source: ABdhPJz9QdMwCRPsnVi7OKLUAI0pJ5RduuVtRpsVYG7GFxuKcbmQe8S5qHJRTCm9Mvr8EksX0l5BuQ==
X-Received: by 2002:a05:6000:1a86:: with SMTP id f6mr48453427wry.343.1635867972470;
        Tue, 02 Nov 2021 08:46:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm21070813wrx.17.2021.11.02.08.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:46:11 -0700 (PDT)
Message-Id: <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 15:46:03 +0000
Subject: [PATCH v4 0/8] Allow clean/smudge filters to handle huge files in the LLP64 data model
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series came in via the Git for Windows fork
[https://github.com/git-for-windows/git/pull/3487], and I intend to merge it
before v2.34.0-rc0, therefore I appreciate every careful review you gentle
people can spare.

The x86_64 variant of Windows uses the LLP64 data model, where the long data
type is 32-bit. This is very different from the LP64 data model used e.g. by
x86_64 Linux, where unsigned long is 64-bit.

Most notably, this means that sizeof(unsigned long) != sizeof(size_t) in
general.

However, since Git was born in the Linux ecosystem, where that inequality
does not hold true, it is understandable that unsigned long is used in many
code locations where size_t should have been used. As a consequence, quite a
few things are broken e.g. on Windows, when it comes to 4GB file contents or
larger.

Using Git LFS [https://git-lfs.github.io/] trying to work around such issues
is one such a broken scenario. You cannot git checkout, say, 5GB files. Huge
files will be truncated to whatever the file size is modulo 4GB (in the case
of a 5GB file, it would be truncated to 1GB).

This patch series primarily fixes the Git LFS scenario, by allowing clean
filters to accept 5GB files, and by allowing smudge filters to produce 5GB
files.

The much larger project to teach Git to use size_t instead of unsigned long
in all the appropriate places is hardly scratched by this patch series.

Side note: The fix for the clean filter included in this series does not
actually affect Git LFS! The reason is that Git LFS marks its filter as
required, and therefore Git streams the file contents to Git LFS via a file
descriptor (which is unaffected by LLP64). A "clean" filter that is not
marked as required, however, lets Git take the code path that is fixed by
this patch series.

Changes since v3:

 * The commit message of the fourth patch no longer talks about a "workdir"
   but about the "working tree".
 * The smudge filter test case is now more precise when verifying the
   result's file size.

Changes since v2:

 * The test cases now use a prereq to avoid running in 32-bit setups (where
   they would be guaranteed to fail).
 * The SIZE_T_IS64BIT prereq specifically does not follow LONG_IS_64BIT, by
   testing for exactly 64 bits.
 * The code comment above unsigned_left_shift_overflows() was fixed.
 * unsigned_left_shift_overflows() now verifies that shift is smaller than
   the bit size of the operand.
 * genzeros now marks its buffer of NULs as const.
 * The error check in the infinite loop genzeros was fixed.

Changes since v1:

 * Removed extraneous "Signed-off-by:" lines from "git-compat-util:
   introduce more size_t helpers".
 * Integrated Carlo's patch to allow genzeros to generate large amounts of
   NULs, even in LLP64 data models.
 * Using test-tool genzeros instead of dd if=/dev/zero, to help HP NonStop
   (which appears to use the LP64 data model and therefore should pass the
   new test cases even without the fixes provided in this patch series).
 * Accelerating genzeros to have performance characteristics similar to dd
   if=/dev/zero instead of being ~50x slower.

Carlo Marcelo Arenas Belón (2):
  test-genzeros: allow more than 2G zeros in Windows
  test-lib: add prerequisite for 64-bit platforms

Johannes Schindelin (2):
  test-tool genzeros: generate large amounts of data more efficiently
  git-compat-util: introduce more size_t helpers

Matt Cooper (4):
  t1051: introduce a smudge filter test for extremely large files
  odb: teach read_blob_entry to use size_t
  odb: guard against data loss checking out a huge file
  clean/smudge: allow clean filters to process extremely large files

 convert.c                   |  2 +-
 delta.h                     |  6 +++---
 entry.c                     |  8 +++++---
 entry.h                     |  2 +-
 git-compat-util.h           | 25 +++++++++++++++++++++++++
 object-file.c               |  6 +++---
 packfile.c                  |  6 +++---
 parallel-checkout.c         |  2 +-
 t/helper/test-genzeros.c    | 21 +++++++++++++++++----
 t/t1051-large-conversion.sh | 26 ++++++++++++++++++++++++++
 t/test-lib.sh               |  4 ++++
 11 files changed, 89 insertions(+), 19 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1068%2Fdscho%2Fhuge-file-smudge-clean-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1068/dscho/huge-file-smudge-clean-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1068

Range-diff vs v3:

 1:  068f897b973 = 1:  068f897b973 test-genzeros: allow more than 2G zeros in Windows
 2:  05219720014 = 2:  05219720014 test-tool genzeros: generate large amounts of data more efficiently
 3:  489500bb1dc = 3:  489500bb1dc test-lib: add prerequisite for 64-bit platforms
 4:  ce9dfaac9f8 ! 4:  f099b4eaead t1051: introduce a smudge filter test for extremely large files
     @@ Commit message
          t1051: introduce a smudge filter test for extremely large files
      
          The filter system allows for alterations to file contents when they're
     -    added to the database or workdir. ("Smudge" when moving to the workdir;
     -    "clean" when moving to the database.) This is used natively to handle CRLF
     -    to LF conversions. It's also employed by Git-LFS to replace large files
     -    from the workdir with small tracking files in the repo and vice versa.
     +    added to the database or working tree. ("Smudge" when moving to the
     +    working tree; "clean" when moving to the database.) This is used
     +    natively to handle CRLF to LF conversions. It's also employed by Git-LFS
     +    to replace large files from the working tree with small tracking files
     +    in the repo and vice versa.
      
     -    Git pulls the entire smudged file into memory. While this is inefficient,
     -    there's a more insidious problem on some platforms due to inconsistency
     -    between using unsigned long and size_t for the same type of data (size of
     -    a file in bytes). On most 64-bit platforms, unsigned long is 64 bits, and
     -    size_t is typedef'd to unsigned long. On Windows, however, unsigned long is
     -    only 32 bits (and therefore on 64-bit Windows, size_t is typedef'd to
     +    Git reads the entire smudged file into memory to convert it into a
     +    "clean" form to be used in-core. While this is inefficient, there's a
     +    more insidious problem on some platforms due to inconsistency between
     +    using unsigned long and size_t for the same type of data (size of a file
     +    in bytes). On most 64-bit platforms, unsigned long is 64 bits, and
     +    size_t is typedef'd to unsigned long. On Windows, however, unsigned long
     +    is only 32 bits (and therefore on 64-bit Windows, size_t is typedef'd to
          unsigned long long in order to be 64 bits).
      
          Practically speaking, this means 64-bit Windows users of Git-LFS can't
     @@ t/t1051-large-conversion.sh: test_expect_success 'ident converts on output' '
      +test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
      +		'files over 4GB convert on output' '
      +	test_commit test small "a small file" &&
     ++	small_size=$(test_file_size small) &&
      +	test_config filter.makelarge.smudge \
      +		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
      +	echo "small filter=makelarge" >.gitattributes &&
      +	rm small &&
      +	git checkout -- small &&
      +	size=$(test_file_size small) &&
     -+	test "$size" -ge $((5 * 1024 * 1024 * 1024))
     ++	test "$size" -eq $((5 * 1024 * 1024 * 1024 + $small_size))
      +'
      +
       test_done
 5:  dbef8168bc7 ! 5:  308a8f2a3ad odb: teach read_blob_entry to use size_t
     @@ t/t1051-large-conversion.sh: test_expect_success 'ident converts on output' '
      +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
       		'files over 4GB convert on output' '
       	test_commit test small "a small file" &&
     - 	test_config filter.makelarge.smudge \
     + 	small_size=$(test_file_size small) &&
 6:  18419070c29 = 6:  65bc291b680 git-compat-util: introduce more size_t helpers
 7:  f59c523bcc4 = 7:  7b6655f03f5 odb: guard against data loss checking out a huge file
 8:  acc5591517f ! 8:  41fda423982 clean/smudge: allow clean filters to process extremely large files
     @@ convert.c: static int crlf_to_worktree(const char *src, size_t len, struct strbu
      
       ## t/t1051-large-conversion.sh ##
      @@ t/t1051-large-conversion.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     - 	test "$size" -ge $((5 * 1024 * 1024 * 1024))
     + 	test "$size" -eq $((5 * 1024 * 1024 * 1024 + $small_size))
       '
       
      +# This clean filter writes down the size of input it receives. By checking against

-- 
gitgitgadget
