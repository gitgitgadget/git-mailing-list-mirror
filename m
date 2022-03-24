Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45369C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351919AbiCXQx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352156AbiCXQxF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C0B0A6D
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u3so7511783wrg.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9maRmUAwONbo4jVZ60N+smLJ7VLQE/8Uz5b0uOivQVY=;
        b=qVhVrpi6y7R0czX8owSQ2eBfWsJbYeK7IYl5ul9B9z0DGmpQZy73PFxqbTpeRh1Wn2
         lYIkn574j1gTmsZR4+C2pB0qzn0wEQgWQsgYOB4Ju2e3zl+6MrHMpnPMpjq7+FCA7JEB
         KMoio9FtoB0kGqybikyc9BJKRdW3lTH1i2AlmwElYPUaaBEwmY+V9kWrIHQnxxfqxr1C
         +P09aHOR/iOQ/12NtWTKvH4sNM0RZD6ITe+ejmk98U9k9e6KVu5mamuSlho1r1noabAS
         tiVr9E1/bpRcOyF590pro3Kvv5fON4zdJBhaiR17xARizfv9CXqd15r9jMDvFRPUYYU8
         NS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9maRmUAwONbo4jVZ60N+smLJ7VLQE/8Uz5b0uOivQVY=;
        b=Hlh4Bxb0QpTQa1TMfnnIgB3aZEz6xo4rj2WICnDMaTEuga3LzSViE1hoRtri8x0txv
         wTE+gX45+mVe/XcBbn4+UhNgqMSqsNsE/G9EZ+T7WERIS9irz0K9HP0+SlE/xchJYUqT
         TkZ3K+/GwOcy1AJi5Bwd+bjF+6nfJtx2e8mvx++/B9DBnmN0Kgb+WX8/RY8BG6MFryTg
         G1E/ZGmPzEd5LAqOI+R0bkAXurM6CXE7yMpiHE0KB+YrPl7vop1z5pszA7hgqzRIoLc4
         Be9pJBzagGmmW5Cy/DxefhEgz8tZ4eD2nZviQZv9m4qlxpwfAUZv4PjUwiqcsLQiXglP
         6uoQ==
X-Gm-Message-State: AOAM532Xg8RmAlPFFBmmwFmP8/8e025v9P5fz/6HJe61x7GgVldzIzx+
        vvZMK3dvA8dK5C+i2+I9g8qQP8HAvVE=
X-Google-Smtp-Source: ABdhPJxjKBvpMIqxQmb4mLqv38dMAlwDus7HMWj9JjpjMnZ4alW3BUE+XIo4a3SeMQCNtUXixwDxVQ==
X-Received: by 2002:a05:6000:1d83:b0:203:ed96:fa4c with SMTP id bk3-20020a0560001d8300b00203ed96fa4cmr5463387wrb.400.1648140682434;
        Thu, 24 Mar 2022 09:51:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14-20020a056000186e00b0020405198faasm3610745wri.52.2022.03.24.09.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:21 -0700 (PDT)
Message-Id: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:50:53 +0000
Subject: [PATCH v4 00/27] Builtin FSMonitor Part 3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V4 of Part 3 of my builtin FSMonitor series. This version has been
updated to depend upon V8 of Part 2.

 * [] Feedback on V7 of Part 2 caused a minor change in a unit test in Part
   3, so I'm resending Part 3 so that we can test the complete feature.

 * [] I also changed in Part 2 how some of the untracked cache tests were
   handled when FSMonitor is disabled, so I've made the corresponding
   changes here.

Here is the range-diff from V3 to V4:

 1:  779a15b38e =  1:  23bfb8c516 fsm-listen-win32: handle shortnames
 2:  11d4a17b69 =  2:  d14f171460 t7527: test FSMonitor on repos with Unicode root paths
 3:  901fa32f6e =  3:  4db2370d04 t/helper/fsmonitor-client: create stress test
 4:  a8f0b2a525 =  4:  f2c0569c90 fsmonitor-settings: bare repos are incompatible with FSMonitor
 5:  e32a8a7ea7 =  5:  b2599bb9d2 fsmonitor-settings: stub in Win32-specific incompatibility checking
 6:  5546339d96 =  6:  9ad6d87ccc fsmonitor-settings: VFS for Git virtual repos are incompatible
 7:  1d2877efda =  7:  7652c79ab3 fsmonitor-settings: stub in macOS-specific incompatibility checking
 8:  06d7f18676 =  8:  2f2a523552 fsmonitor-settings: remote repos on macOS are incompatible
 9:  5ca97f482d =  9:  0297d80388 fsmonitor-settings: remote repos on Windows are incompatible
10:  6715143724 = 10:  b6dfd609ad fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
11:  ed1f723130 = 11:  db5197b44b unpack-trees: initialize fsmonitor_has_run_once in o->result
12:  35c77b854b = 12:  3f154d0251 fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
13:  a5affb359c = 13:  4aade7b560 fsmonitor--daemon: cd out of worktree root
14:  087af5dfb6 = 14:  d8ebac2a9b fsmonitor--daemon: prepare for adding health thread
15:  e78eb20c1b = 15:  7fb0795e25 fsmonitor--daemon: rename listener thread related variables
16:  301fff5296 = 16:  e90adcd06d fsmonitor--daemon: stub in health thread
17:  c6b5bdd25e = 17:  d9b91a998c fsm-health-win32: add polling framework to monitor daemon health
18:  13d11713a8 = 18:  0e95ee0d01 fsm-health-win32: force shutdown daemon if worktree root moves
19:  01c1a38c46 = 19:  48a590d202 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
20:  0f0a5b5ca1 = 20:  36ab239fd9 fsmonitor: optimize processing of directory events
21:  d8218d197a ! 21:  3010b22e69 t7527: FSMonitor tests for directory moves
    @@ Commit message
         Create unit tests to move a directory.  Verify that `git status`
         gives the same result with and without FSMonitor enabled.
     
    -    NEEDSWORK: This test exposes a bug in the untracked-cache on
    -    Windows when FSMonitor is disabled.  These are commented out
    -    for the moment.
    -
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     
      ## t/t7527-builtin-fsmonitor.sh ##
    @@ t/t7527-builtin-fsmonitor.sh: do
              matrix_try $uc_val $fsm_val file_to_directory
              matrix_try $uc_val $fsm_val directory_to_file
      
    -+        # NEEDSWORK: On Windows the untracked-cache is buggy when FSMonitor
    -+        # is DISABLED.  Turn off a few test that cause it problems until
    -+        # we can debug it.
    -+        #
    -+        try_moves="true"
    -+        test_have_prereq UNTRACKED_CACHE,WINDOWS && \
    -+            test $uc_val = true && \
    -+            test $fsm_val = false && \
    -+            try_moves="false"
    -+        if test $try_moves = true
    -+        then
    -+            matrix_try $uc_val $fsm_val move_directory_contents_deeper
    -+            matrix_try $uc_val $fsm_val move_directory_up
    -+            matrix_try $uc_val $fsm_val move_directory
    -+        fi
    ++        matrix_try $uc_val $fsm_val move_directory_contents_deeper
    ++        matrix_try $uc_val $fsm_val move_directory_up
    ++        matrix_try $uc_val $fsm_val move_directory
     +
              if test $fsm_val = true
              then
22:  79da369dcc = 22:  85cdb4d84f t/perf/p7527: add perf test for builtin FSMonitor
23:  4ab4306ada = 23:  29063455c8 fsmonitor: never set CE_FSMONITOR_VALID on submodules
24:  5d0fa19929 ! 24:  6e99f5e4f2 t7527: test FSMonitor on case insensitive+preserving file system
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule" '
     +
     +    git init test_insensitive &&
     +
    -+    start_daemon -C test_insensitive -tf "$PWD/insensitive.trace" &&
    ++    start_daemon -C test_insensitive --tf "$PWD/insensitive.trace" &&
     +
     +    mkdir -p test_insensitive/abc/def &&
     +    echo xyz >test_insensitive/ABC/DEF/xyz &&
25:  264397e8bd = 25:  cef7dbbaf0 fsmonitor: on macOS also emit NFC spelling for NFD pathname
26:  e6b621fb76 = 26:  bc2d5a7a93 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
27:  aa96a849ce ! 27:  176c530c3f t7527: test Unicode NFC/NFD handling on MacOS
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'case inse
     +
     +    git init test_unicode &&
     +
    -+    start_daemon -C test_unicode -tf "$PWD/unicode.trace" &&
    ++    start_daemon -C test_unicode --tf "$PWD/unicode.trace" &&
     +
     +    # Create a directory using an NFC spelling.
     +    #


Jeff Hostetler (27):
  fsm-listen-win32: handle shortnames
  t7527: test FSMonitor on repos with Unicode root paths
  t/helper/fsmonitor-client: create stress test
  fsmonitor-settings: bare repos are incompatible with FSMonitor
  fsmonitor-settings: stub in Win32-specific incompatibility checking
  fsmonitor-settings: VFS for Git virtual repos are incompatible
  fsmonitor-settings: stub in macOS-specific incompatibility checking
  fsmonitor-settings: remote repos on macOS are incompatible
  fsmonitor-settings: remote repos on Windows are incompatible
  fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
  unpack-trees: initialize fsmonitor_has_run_once in o->result
  fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
  fsmonitor--daemon: cd out of worktree root
  fsmonitor--daemon: prepare for adding health thread
  fsmonitor--daemon: rename listener thread related variables
  fsmonitor--daemon: stub in health thread
  fsm-health-win32: add polling framework to monitor daemon health
  fsm-health-win32: force shutdown daemon if worktree root moves
  fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
  fsmonitor: optimize processing of directory events
  t7527: FSMonitor tests for directory moves
  t/perf/p7527: add perf test for builtin FSMonitor
  fsmonitor: never set CE_FSMONITOR_VALID on submodules
  t7527: test FSMonitor on case insensitive+preserving file system
  fsmonitor: on macOS also emit NFC spelling for NFD pathname
  t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
  t7527: test Unicode NFC/NFD handling on MacOS

 Makefile                               |  19 +-
 builtin/fsmonitor--daemon.c            | 104 ++++++-
 builtin/update-index.c                 |   4 +
 compat/fsmonitor/fsm-health-darwin.c   |  24 ++
 compat/fsmonitor/fsm-health-win32.c    | 278 +++++++++++++++++
 compat/fsmonitor/fsm-health.h          |  47 +++
 compat/fsmonitor/fsm-listen-darwin.c   | 122 ++++++--
 compat/fsmonitor/fsm-listen-win32.c    | 413 ++++++++++++++++++++-----
 compat/fsmonitor/fsm-listen.h          |   2 +-
 compat/fsmonitor/fsm-settings-darwin.c |  89 ++++++
 compat/fsmonitor/fsm-settings-win32.c  | 137 ++++++++
 config.mak.uname                       |   5 +
 contrib/buildsystems/CMakeLists.txt    |   8 +
 fsmonitor--daemon.h                    |  11 +-
 fsmonitor-settings.c                   |  92 ++++++
 fsmonitor-settings.h                   |  29 ++
 fsmonitor.c                            |  73 ++++-
 fsmonitor.h                            |  11 +
 t/helper/test-fsmonitor-client.c       | 106 +++++++
 t/lib-unicode-nfc-nfd.sh               | 167 ++++++++++
 t/perf/p7527-builtin-fsmonitor.sh      | 257 +++++++++++++++
 t/t7519-status-fsmonitor.sh            |  32 ++
 t/t7527-builtin-fsmonitor.sh           | 299 ++++++++++++++++++
 unpack-trees.c                         |   1 +
 24 files changed, 2206 insertions(+), 124 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-darwin.c
 create mode 100644 compat/fsmonitor/fsm-health-win32.c
 create mode 100644 compat/fsmonitor/fsm-health.h
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c
 create mode 100755 t/lib-unicode-nfc-nfd.sh
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh


base-commit: f87a1eba693b297d049281fa2d0c21b573027347
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1143%2Fjeffhostetler%2Fbuiltin-fsmonitor-part3-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1143/jeffhostetler/builtin-fsmonitor-part3-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1143

Range-diff vs v3:

  1:  779a15b38e8 =  1:  23bfb8c5165 fsm-listen-win32: handle shortnames
  2:  11d4a17b692 =  2:  d14f1714604 t7527: test FSMonitor on repos with Unicode root paths
  3:  901fa32f6ea =  3:  4db2370d046 t/helper/fsmonitor-client: create stress test
  4:  a8f0b2a5256 =  4:  f2c0569c901 fsmonitor-settings: bare repos are incompatible with FSMonitor
  5:  e32a8a7ea7a =  5:  b2599bb9d2e fsmonitor-settings: stub in Win32-specific incompatibility checking
  6:  5546339d963 =  6:  9ad6d87ccce fsmonitor-settings: VFS for Git virtual repos are incompatible
  7:  1d2877efda0 =  7:  7652c79ab35 fsmonitor-settings: stub in macOS-specific incompatibility checking
  8:  06d7f18676d =  8:  2f2a5235522 fsmonitor-settings: remote repos on macOS are incompatible
  9:  5ca97f482d0 =  9:  0297d80388a fsmonitor-settings: remote repos on Windows are incompatible
 10:  67151437245 = 10:  b6dfd609adb fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
 11:  ed1f7231309 = 11:  db5197b44bb unpack-trees: initialize fsmonitor_has_run_once in o->result
 12:  35c77b854bd = 12:  3f154d02517 fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
 13:  a5affb359c4 = 13:  4aade7b560a fsmonitor--daemon: cd out of worktree root
 14:  087af5dfb63 = 14:  d8ebac2a9b2 fsmonitor--daemon: prepare for adding health thread
 15:  e78eb20c1bf = 15:  7fb0795e25e fsmonitor--daemon: rename listener thread related variables
 16:  301fff5296a = 16:  e90adcd06db fsmonitor--daemon: stub in health thread
 17:  c6b5bdd25e4 = 17:  d9b91a998ce fsm-health-win32: add polling framework to monitor daemon health
 18:  13d11713a86 = 18:  0e95ee0d01b fsm-health-win32: force shutdown daemon if worktree root moves
 19:  01c1a38c462 = 19:  48a590d2026 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
 20:  0f0a5b5ca16 = 20:  36ab239fd9a fsmonitor: optimize processing of directory events
 21:  d8218d197ad ! 21:  3010b22e690 t7527: FSMonitor tests for directory moves
     @@ Commit message
          Create unit tests to move a directory.  Verify that `git status`
          gives the same result with and without FSMonitor enabled.
      
     -    NEEDSWORK: This test exposes a bug in the untracked-cache on
     -    Windows when FSMonitor is disabled.  These are commented out
     -    for the moment.
     -
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## t/t7527-builtin-fsmonitor.sh ##
     @@ t/t7527-builtin-fsmonitor.sh: do
       		matrix_try $uc_val $fsm_val file_to_directory
       		matrix_try $uc_val $fsm_val directory_to_file
       
     -+		# NEEDSWORK: On Windows the untracked-cache is buggy when FSMonitor
     -+		# is DISABLED.  Turn off a few test that cause it problems until
     -+		# we can debug it.
     -+		#
     -+		try_moves="true"
     -+		test_have_prereq UNTRACKED_CACHE,WINDOWS && \
     -+			test $uc_val = true && \
     -+			test $fsm_val = false && \
     -+			try_moves="false"
     -+		if test $try_moves = true
     -+		then
     -+			matrix_try $uc_val $fsm_val move_directory_contents_deeper
     -+			matrix_try $uc_val $fsm_val move_directory_up
     -+			matrix_try $uc_val $fsm_val move_directory
     -+		fi
     ++		matrix_try $uc_val $fsm_val move_directory_contents_deeper
     ++		matrix_try $uc_val $fsm_val move_directory_up
     ++		matrix_try $uc_val $fsm_val move_directory
      +
       		if test $fsm_val = true
       		then
 22:  79da369dcce = 22:  85cdb4d84f2 t/perf/p7527: add perf test for builtin FSMonitor
 23:  4ab4306adab = 23:  29063455c83 fsmonitor: never set CE_FSMONITOR_VALID on submodules
 24:  5d0fa19929d ! 24:  6e99f5e4f2a t7527: test FSMonitor on case insensitive+preserving file system
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule" '
      +
      +	git init test_insensitive &&
      +
     -+	start_daemon -C test_insensitive -tf "$PWD/insensitive.trace" &&
     ++	start_daemon -C test_insensitive --tf "$PWD/insensitive.trace" &&
      +
      +	mkdir -p test_insensitive/abc/def &&
      +	echo xyz >test_insensitive/ABC/DEF/xyz &&
 25:  264397e8bd4 = 25:  cef7dbbaf04 fsmonitor: on macOS also emit NFC spelling for NFD pathname
 26:  e6b621fb766 = 26:  bc2d5a7a930 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
 27:  aa96a849ce4 ! 27:  176c530c3fa t7527: test Unicode NFC/NFD handling on MacOS
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'case inse
      +
      +	git init test_unicode &&
      +
     -+	start_daemon -C test_unicode -tf "$PWD/unicode.trace" &&
     ++	start_daemon -C test_unicode --tf "$PWD/unicode.trace" &&
      +
      +	# Create a directory using an NFC spelling.
      +	#

-- 
gitgitgadget
