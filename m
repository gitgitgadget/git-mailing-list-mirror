Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F0C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbiEYPBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiEYPA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:00:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B981F6C0FE
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:00:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s28so30367568wrb.7
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K0et8h944WTaWMKXCfg9v14fKgcDq5wcZn29qMVvCfI=;
        b=ky674rmpiYI4rnlLBT22edgkSFuRlglgkZ+cOiecaFiRIOvoxjtzKYwXZ/GDTaTIRr
         atZwG6Ws1HjaqewBXqwxdUyJpz8T/mWRB+i/6f5C9c2r3kd4VCgmmGaPAozTsI4NZCFS
         sBxSnupflq9KxigJSp/PRJ/bn2K0gWTrZh9MHdgIuYLynoblz/SSeca1zoMM8Fe8OjAm
         JcHmGZjDl4TwIipiAAkRrxFFWMy0reWKrmEXum06Q19eQhyaIfqTvmh+qPEAlKEd4HGD
         36GHfZ3e9QNr9UpKSIpFOsUNo6d905L3odZyOx2lvL0aPxFXhqdYvocy98pV8YMxNocu
         NfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K0et8h944WTaWMKXCfg9v14fKgcDq5wcZn29qMVvCfI=;
        b=XgAqrl+0c5A/v7B+5BYmVuCWM+iSsTu8mFbVHzR7zRnPUNVtpkQAAhoLq9Dk6o1G88
         Q0kriqRqCtMxr0CVAsYBk27fq8iEkJfpychm6v1Rg7Ny5Ld17A8o+v+w3sTbqnsCuPuD
         WaqycgqYXou+atYFBtVf+eRf1Lgwdfv4RMuRUOTiukTGIJnXbXpvD4+GtUQLD67FCc4i
         ivw1aCP36HKSuRR19v8bEp2tszjC16Lm/QqcT/d6hGW6eDd2oSk8t1W8EXWW/uxx+s65
         xPsC74cXC1Ghx3Z2hr8W0ZaudJhr/FC87Kjd8NzBNesB3dQkL7pVyTUku/IVXJYlQT8a
         dh6w==
X-Gm-Message-State: AOAM530waAq7ERicY+fyDRwwLPwMEcTHnrDLF64CROuIaO/bmQZBQ4WN
        FxxEONEl0kyifLv6+wcolv7mc2r48Ps=
X-Google-Smtp-Source: ABdhPJycQiCBGDQw2X/ZIdURPczj+Fk2UiuwZVqNu8PNBUlGCxhYKdofqGSOln2+iupu4nCQrPctyw==
X-Received: by 2002:adf:d0d2:0:b0:20f:f976:688e with SMTP id z18-20020adfd0d2000000b0020ff976688emr5428431wrh.530.1653490854740;
        Wed, 25 May 2022 08:00:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcc15000000b003942a244f57sm1882088wmh.48.2022.05.25.08.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:00:53 -0700 (PDT)
Message-Id: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:22 +0000
Subject: [PATCH v8 00/30] Builtin FSMonitor Part 3
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 8 of part 3 of FSMonitor.

This version addresses the new t/helper/test-hexdump utility to emit an LF
at the end. I also updated the test scripts to write hexdump output to a
file and then grep that file to avoid having the tool being in the middle of
a pipeline.

Jeff Hostetler (30):
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
  t/helper/hexdump: add helper to print hexdump of stdin
  t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
  t7527: test Unicode NFC/NFD handling on MacOS
  fsmonitor--daemon: allow --super-prefix argument
  t7527: improve implicit shutdown testing in fsmonitor--daemon

 Makefile                               |  20 +-
 builtin/fsmonitor--daemon.c            | 116 ++++++-
 builtin/update-index.c                 |  16 +
 compat/fsmonitor/fsm-health-darwin.c   |  24 ++
 compat/fsmonitor/fsm-health-win32.c    | 278 ++++++++++++++++
 compat/fsmonitor/fsm-health.h          |  47 +++
 compat/fsmonitor/fsm-listen-darwin.c   | 122 ++++++-
 compat/fsmonitor/fsm-listen-win32.c    | 436 ++++++++++++++++++++-----
 compat/fsmonitor/fsm-listen.h          |   2 +-
 compat/fsmonitor/fsm-settings-darwin.c |  89 +++++
 compat/fsmonitor/fsm-settings-win32.c  | 137 ++++++++
 config.mak.uname                       |   5 +
 contrib/buildsystems/CMakeLists.txt    |   8 +
 fsmonitor--daemon.h                    |  11 +-
 fsmonitor-settings.c                   | 167 ++++++++--
 fsmonitor-settings.h                   |  33 ++
 fsmonitor.c                            |  73 ++++-
 fsmonitor.h                            |  11 +
 git.c                                  |   2 +-
 t/helper/test-fsmonitor-client.c       | 106 ++++++
 t/helper/test-hexdump.c                |  30 ++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/lib-unicode-nfc-nfd.sh               | 162 +++++++++
 t/perf/p7527-builtin-fsmonitor.sh      | 257 +++++++++++++++
 t/t7519-status-fsmonitor.sh            |  32 ++
 t/t7527-builtin-fsmonitor.sh           | 401 ++++++++++++++++++++++-
 unpack-trees.c                         |   1 +
 28 files changed, 2439 insertions(+), 149 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-darwin.c
 create mode 100644 compat/fsmonitor/fsm-health-win32.c
 create mode 100644 compat/fsmonitor/fsm-health.h
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c
 create mode 100644 t/helper/test-hexdump.c
 create mode 100755 t/lib-unicode-nfc-nfd.sh
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh


base-commit: 5eb696daba2fe108d4d9ba2ccf4b357447ef9946
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1143%2Fjeffhostetler%2Fbuiltin-fsmonitor-part3-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1143/jeffhostetler/builtin-fsmonitor-part3-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1143

Range-diff vs v7:

  1:  26144c58659 =  1:  26144c58659 fsm-listen-win32: handle shortnames
  2:  1bf2e36b6ad =  2:  1bf2e36b6ad t7527: test FSMonitor on repos with Unicode root paths
  3:  4bca494bb22 =  3:  4bca494bb22 t/helper/fsmonitor-client: create stress test
  4:  663deabc3f6 =  4:  663deabc3f6 fsmonitor-settings: bare repos are incompatible with FSMonitor
  5:  7cb0180a1ed =  5:  7cb0180a1ed fsmonitor-settings: stub in Win32-specific incompatibility checking
  6:  9774faddc45 =  6:  9774faddc45 fsmonitor-settings: VFS for Git virtual repos are incompatible
  7:  f7ef7dcffc8 =  7:  f7ef7dcffc8 fsmonitor-settings: stub in macOS-specific incompatibility checking
  8:  dc2dfd67931 =  8:  dc2dfd67931 fsmonitor-settings: remote repos on macOS are incompatible
  9:  5627038aaa3 =  9:  5627038aaa3 fsmonitor-settings: remote repos on Windows are incompatible
 10:  9a12cc78b5d = 10:  9a12cc78b5d fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
 11:  aaff000cecb = 11:  aaff000cecb unpack-trees: initialize fsmonitor_has_run_once in o->result
 12:  4f2b15d3d1f = 12:  4f2b15d3d1f fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
 13:  427dec412a5 = 13:  427dec412a5 fsmonitor--daemon: cd out of worktree root
 14:  51b266b06e1 = 14:  51b266b06e1 fsmonitor--daemon: prepare for adding health thread
 15:  594e0ae243d = 15:  594e0ae243d fsmonitor--daemon: rename listener thread related variables
 16:  c2b5c02ed38 = 16:  c2b5c02ed38 fsmonitor--daemon: stub in health thread
 17:  46a5ae2a635 = 17:  46a5ae2a635 fsm-health-win32: add polling framework to monitor daemon health
 18:  7cf1be5f8e2 = 18:  7cf1be5f8e2 fsm-health-win32: force shutdown daemon if worktree root moves
 19:  95cf1299d44 = 19:  95cf1299d44 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
 20:  b020bfb4568 = 20:  b020bfb4568 fsmonitor: optimize processing of directory events
 21:  d058d7e0c08 = 21:  d058d7e0c08 t7527: FSMonitor tests for directory moves
 22:  f5dac286812 = 22:  f5dac286812 t/perf/p7527: add perf test for builtin FSMonitor
 23:  92f5c0d2c8b = 23:  92f5c0d2c8b fsmonitor: never set CE_FSMONITOR_VALID on submodules
 24:  40b80adbb31 = 24:  40b80adbb31 t7527: test FSMonitor on case insensitive+preserving file system
 25:  b93f0642699 = 25:  ea19a06e8cb fsmonitor: on macOS also emit NFC spelling for NFD pathname
 26:  6f2e935f148 ! 26:  66a01db4739 t/helper/hexdump: add helper to print hexdump of stdin
     @@
       ## Metadata ##
     -Author: Jeff Hostetler <jeffhostetler@github.com>
     +Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
          t/helper/hexdump: add helper to print hexdump of stdin
      
          Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     -    Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
     +    Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Makefile ##
      @@ Makefile: TEST_BUILTINS_OBJS += test-getcwd.o
     @@ t/helper/test-hexdump.c (new)
      +{
      +	char buf[1024];
      +	ssize_t i, len;
     ++	int have_data = 0;
      +
      +	for (;;) {
      +		len = xread(0, buf, sizeof(buf));
     @@ t/helper/test-hexdump.c (new)
      +		if (!len)
      +			break;
      +
     ++		have_data = 1;
     ++
      +		for (i = 0; i < len; i++)
      +			printf("%02x ", (unsigned char)buf[i]);
      +	}
      +
     ++	if (have_data)
     ++		putchar('\n');
     ++
      +	return 0;
      +}
      
 27:  6a830869954 ! 27:  25c6066eddc t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
     @@ t/lib-unicode-nfc-nfd.sh (new)
      +#
      +test_lazy_prereq UNICODE_NFC_PRESERVED '
      +	mkdir c_${utf8_nfc} &&
     -+	ls | test-tool hexdump | grep "63 5f c3 a9"
     ++	ls | test-tool hexdump >dump &&
     ++	grep "63 5f c3 a9" dump
      +'
      +
      +# Is the spelling of an NFD pathname preserved on disk?
      +#
      +test_lazy_prereq UNICODE_NFD_PRESERVED '
      +	mkdir d_${utf8_nfd} &&
     -+	ls | test-tool hexdump | grep "64 5f 65 cc 81"
     ++	ls | test-tool hexdump >dump &&
     ++	grep "64 5f 65 cc 81" dump
      +'
      +
      +# The following _DOUBLE_ forms are more for my curiosity,
     @@ t/lib-unicode-nfc-nfd.sh (new)
      +#
      +test_lazy_prereq UNICODE_DOUBLE_NFC_PRESERVED '
      +	mkdir c_${greek_nfc} &&
     -+	ls | test-tool hexdump | grep "63 5f e1 bd a7"
     ++	ls | test-tool hexdump >dump &&
     ++	grep "63 5f e1 bd a7" dump
      +'
      +
      +# See if the NFD spelling appears on the disk.
      +#
      +test_lazy_prereq UNICODE_DOUBLE_NFD_PRESERVED '
      +	mkdir d_${greek_nfd2} &&
     -+	ls | test-tool hexdump | grep "64 5f cf 89 cc 94 cd 82"
     ++	ls | test-tool hexdump >dump &&
     ++	grep "64 5f cf 89 cc 94 cd 82" dump
      +'
      +
      +# The following is for debugging. I found it useful when
 28:  f9a7869d202 = 28:  fc3a0e7847f t7527: test Unicode NFC/NFD handling on MacOS
 29:  9fc7c970929 = 29:  25676ca4ec2 fsmonitor--daemon: allow --super-prefix argument
 30:  ca833ecc7a1 ! 30:  d70d2545a5a t7527: improve implicit shutdown testing in fsmonitor--daemon
     @@
       ## Metadata ##
     -Author: Jeff Hostetler <jeffhostetler@github.com>
     +Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
          t7527: improve implicit shutdown testing in fsmonitor--daemon
     @@ Commit message
      
          Replace the simple sleep with a sleep-and-retry loop.
      
     -    Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
     +    Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## t/t7527-builtin-fsmonitor.sh ##
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'implicit daemon start' '

-- 
gitgitgadget
