Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F44C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B13A61167
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhJ2OBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhJ2OBv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:01:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230B6C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k7so16230733wrd.13
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=t3403TpJA8Xyn9TDURg7k+7VTQp2inZQ3qMX5L1HnRc=;
        b=ZBUvwN0UM0H/7qnNEW1zH397iG4kmJvobIqVGCv2BBOATV7zvD/tOYtw6BR6QG5w+h
         +/E4CAvIMIMWqdLTUZZhcyHM9Kqh0B1Vh9dkDzCcelHbJB+zHr7CItY4fC77Cnm+ZI0L
         j1BfMin5YDxBxNA8aS2rQ8MdG02d0YTF7lV+cPfQBjDdYvQX3Z8CiYgsM/R8el3uNcOq
         hB4rsLg+KaqoUaAczws5P+rc/kIGf6mXeg/DxEy6mi6HkLfEVzOXxF8SEOV9gOppeRXo
         6lnHHamGP72Z/ocbpsYIkDEjpSAYRn97t3FLRzqpYo/SXPDBwwQwCK7nQE71L8thUQrE
         uLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=t3403TpJA8Xyn9TDURg7k+7VTQp2inZQ3qMX5L1HnRc=;
        b=Q+XG3Skqtg6wjluHusXMj327rAKrghvx72BdzreWd1y9TH1yBfx1sgHYCQM6lSj+n5
         fdPKlvY347FOOKP3CC5Kgbo/JAJvjVdXW2s4M4VlPacxJIsGirb9X6qW/xFeST8eDE3k
         KBVwaSvrYjrGAObHzC119080yjIlOXEEcOqADCJegFk4Vsr+MeIazNuh3soyIZ/hJVFt
         M49Ya9BBrn7kQP7c+Odeot57WlJ3zU4/y5Vu3IScHGWSDry0MLnJFHYO7ajnXm20deU8
         iPQBWmjBf/j7VFVGZcOURLW99Uhd7OQh7fiFzmiyTVU3Ho8q0JkglROC27KmcLHMhk42
         t8wg==
X-Gm-Message-State: AOAM532hdet4eBE4xP8W6iibhRLSeIzzINWYDAE7hCWAuzGPAv3cXgwX
        wJk2XhiJN0EF7kojY9nsHW5TDmrtWH4=
X-Google-Smtp-Source: ABdhPJxWKHLsg87BL+XE/+pqYoEdnvfjsd9eLI8LfHmm3gja/QjmhSlEg3PMFakN7YJOmj4sGw+ufw==
X-Received: by 2002:a5d:64a5:: with SMTP id m5mr5166624wrp.281.1635515960689;
        Fri, 29 Oct 2021 06:59:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l124sm9416840wml.8.2021.10.29.06.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:59:20 -0700 (PDT)
Message-Id: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:59:11 +0000
Subject: [PATCH v3 0/8] Allow clean/smudge filters to handle huge files in the LLP64 data model
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
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
 t/t1051-large-conversion.sh | 25 +++++++++++++++++++++++++
 t/test-lib.sh               |  4 ++++
 11 files changed, 88 insertions(+), 19 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1068%2Fdscho%2Fhuge-file-smudge-clean-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1068/dscho/huge-file-smudge-clean-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1068

Range-diff vs v2:

 1:  068f897b973 = 1:  068f897b973 test-genzeros: allow more than 2G zeros in Windows
 2:  6edcbae372e ! 2:  05219720014 test-tool genzeros: generate large amounts of data more efficiently
     @@ t/helper/test-genzeros.c
       int cmd__genzeros(int argc, const char **argv)
       {
      +	/* static, so that it is NUL-initialized */
     -+	static char zeros[256 * 1024];
     ++	static const char zeros[256 * 1024];
       	intmax_t count;
      +	ssize_t n;
       
     @@ t/helper/test-genzeros.c: int cmd__genzeros(int argc, const char **argv)
      -		if (putchar(0) == EOF)
      +	/* Writing out individual NUL bytes is slow... */
      +	while (count < 0)
     -+		if (write(1, zeros, ARRAY_SIZE(zeros) < 0))
     ++		if (write(1, zeros, ARRAY_SIZE(zeros)) < 0)
       			return -1;
      +
      +	while (count > 0) {
 -:  ----------- > 3:  489500bb1dc test-lib: add prerequisite for 64-bit platforms
 3:  1bdded86f5d ! 4:  ce9dfaac9f8 t1051: introduce a smudge filter test for extremely large files
     @@ t/t1051-large-conversion.sh: test_expect_success 'ident converts on output' '
       
      +# This smudge filter prepends 5GB of zeros to the file it checks out. This
      +# ensures that smudging doesn't mangle large files on 64-bit Windows.
     -+test_expect_failure EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
     ++test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     ++		'files over 4GB convert on output' '
      +	test_commit test small "a small file" &&
      +	test_config filter.makelarge.smudge \
      +		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
 4:  3ffd3a001f7 ! 5:  dbef8168bc7 odb: teach read_blob_entry to use size_t
     @@ t/t1051-large-conversion.sh: test_expect_success 'ident converts on output' '
       
       # This smudge filter prepends 5GB of zeros to the file it checks out. This
       # ensures that smudging doesn't mangle large files on 64-bit Windows.
     --test_expect_failure EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
     -+test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
     +-test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     ++test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     + 		'files over 4GB convert on output' '
       	test_commit test small "a small file" &&
       	test_config filter.makelarge.smudge \
     - 		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
 5:  32472ae3f98 ! 6:  18419070c29 git-compat-util: introduce more size_t helpers
     @@ git-compat-util.h
       
      +/*
      + * Returns true if the left shift of "a" by "shift" bits will
     -+ * overflow. The types of "a" and "b" must be unsigned.
     -+ * Note that this macro evaluates "a" twice!
     ++ * overflow. The type of "a" must be unsigned.
      + */
      +#define unsigned_left_shift_overflows(a, shift) \
     -+    ((a) > maximum_unsigned_value_of_type(a) >> shift)
     ++    ((shift) < bitsizeof(a) && \
     ++     (a) > maximum_unsigned_value_of_type(a) >> (shift))
      +
       #ifdef __GNUC__
       #define TYPEOF(x) (__typeof__(x))
 6:  c6910584108 = 7:  f59c523bcc4 odb: guard against data loss checking out a huge file
 7:  d87d4229bb4 ! 8:  acc5591517f clean/smudge: allow clean filters to process extremely large files
     @@ convert.c: static int crlf_to_worktree(const char *src, size_t len, struct strbu
       	const char *path;
      
       ## t/t1051-large-conversion.sh ##
     -@@ t/t1051-large-conversion.sh: test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output'
     +@@ t/t1051-large-conversion.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
       	test "$size" -ge $((5 * 1024 * 1024 * 1024))
       '
       
      +# This clean filter writes down the size of input it receives. By checking against
      +# the actual size, we ensure that cleaning doesn't mangle large files on 64-bit Windows.
     -+test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on input' '
     ++test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
     ++		'files over 4GB convert on input' '
      +	test-tool genzeros $((5*1024*1024*1024)) >big &&
      +	test_config filter.checklarge.clean "wc -c >big.size" &&
      +	echo "big filter=checklarge" >.gitattributes &&

-- 
gitgitgadget
