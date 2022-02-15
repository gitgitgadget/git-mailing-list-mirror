Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D3CC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiBOP7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:59:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbiBOP7s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC03EBD2FA
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s10so19370630wrb.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=oiIT/5acSgoj3KUmrUzfrG3+Oa8qTWyTSiN7vWWh81o=;
        b=klZX6JyD1XTviv1kIjZBWQpoja3cDG75HKJDJo4CgEjaF7o1Gv6HWXZ2O4y0FnGvYP
         JNFiRS6z3C71P9RtitHbkpMMk5QTPbuuWmU4F/AH2ov4IU8I8EEbLWM5U4TGJ0Srxw+T
         eEvgjtIuM3x+Aa6hq8jAqa9vXMG8bVjXcSkl+O7OqzYWAoX9jsctOpnZ7P7VehsWfYoR
         Yq/A7UorKrcbmGlopJdqZHnaWb3Cq1RHJOts3o3FmT2HC5JQGp7em75fMFnglX0Wyuo5
         a2zp/AmEqmBXOMnkakRuzmHoSRv7+EYteX7ZDhKAuQ7kyqzObwX2HVX9JjEHE125T1fj
         KlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oiIT/5acSgoj3KUmrUzfrG3+Oa8qTWyTSiN7vWWh81o=;
        b=IFZG78NBC7BigAYM3nP+nl9jQVfz9CPZKR6mMe3mKNgRyW9IIagaxuP2GX6zgxC3O3
         Q9vVdVu2xaxtPR4mV7CvCoA9+ptyX6M/dal6UMXtARhwiIbj498tN7/oHNoOblLBCVSx
         avhDSKDiNYH+iM/lx2+log0Sh6PZY8VycAcjfWF5mNO0CsEk2RlQJOxw7XNrylDqcW1f
         8DmmT5P08O7KOiPSklkpTdABCryyAIIXnAdMQf+F9cJexvKpJZSUjarpEdT1iX4Kay9r
         ANvuA5zhDdoMbXIXU3vzsDtek/hpHvLIA/w9kPPpBsO1A3hULyxmvRS9NIC+wfDGNugG
         Ib3g==
X-Gm-Message-State: AOAM532lC3njytZpUGLa3reiXyYIkIGUVEUSmQEE87eJJe1uvJ+Q2VTB
        QFex9CBiAUceL0w8nH6bZjcKpHZwkok=
X-Google-Smtp-Source: ABdhPJwKyi3QlGna/ua8BsP1jwGVBUPCMIYp4oVAQy6kzAo2Pw39skbxihzc3Z+56uTDTIdRilAcRg==
X-Received: by 2002:a05:6000:2c5:: with SMTP id o5mr3749433wry.130.1644940775646;
        Tue, 15 Feb 2022 07:59:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm14999286wrr.55.2022.02.15.07.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:34 -0800 (PST)
Message-Id: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:10 +0000
Subject: [PATCH 00/23] Builtin FSMonitor Part 3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is part 3 of my builtin FSMonitor series.

Part 3 builds upon part 2 (jh/builtin-fsmonitor-part2) which is currently in
"seen", so this series should be considered a preview until part 2 moves to
"next". (And part 2 should not graduate to "master" without this part.)

Part 2 established the client code (used by commands like git status) and an
MVP implementation of the FSMonitor daemon. This was sufficient to test the
concepts and basic functionality.

Part 3 finishes the daemon and adds additional tests. This includes:

 * On Windows, handle short- and long-name aliasing.
 * On Mac, handle Unicode aliasing.
 * Mark bare, virtual, and remote working directories incompatible with
   FSMonitor.
 * On Mac, ignore xattr change FSEvents.
 * On Windows, cd out of the working directory root.
 * Create a thread to monitor the health and shutdown the daemon if
   necessary.
 * Speed up handling of directory notification events.
 * Test directory move and rename events.
 * Add performance test.

Here is performance data from t/perf/p7527-builtin-fsmonitor.sh on a
synthetic repo containing 1M files on a Macbook Pro. It shows the effects of
the untracked cache (uc) and FSMonitor (fsm) on git status.

$ ./p7527-builtin-fsmonitor.sh 
# passed all 67 test(s)
1..67
Test                                                                 this tree         
---------------------------------------------------------------------------------------
7527.4: [uc false][fsm false] status after checkout                  29.99(3.14+80.12) 
7527.6: [uc false][fsm false] status after big change                73.32(5.11+97.24) 
7527.8: [uc false][fsm false] status after add all                   47.80(5.12+90.47) 
7527.10: [uc false][fsm false] status after add dot                  49.22(5.16+92.05) 
7527.12: [uc false][fsm false] status after commit                   51.53(3.35+100.74)
7527.14: [uc false][fsm false] status after reset hard               33.74(3.03+85.31) 
7527.16: [uc false][fsm false] status after create untracked files   41.71(3.24+89.75) 
7527.18: [uc false][fsm false] status after clean                    34.33(3.07+89.36) 

7527.20: [uc false][fsm true] status after checkout                  29.23(1.94+10.84) 
7527.22: [uc false][fsm true] status after big change                64.23(4.66+24.86) 
7527.24: [uc false][fsm true] status after add all                   45.45(4.37+18.70) 
7527.26: [uc false][fsm true] status after add dot                   44.42(4.02+17.10) 
7527.28: [uc false][fsm true] status after commit                    30.52(1.95+10.91) 
7527.30: [uc false][fsm true] status after reset hard                28.70(2.70+13.89) 
7527.32: [uc false][fsm true] status after create untracked files    28.63(2.59+10.71) 
7527.34: [uc false][fsm true] status after clean                     28.97(2.59+10.78) 

7527.36: [uc true][fsm false] status after checkout                  35.06(3.17+86.11) 
7527.38: [uc true][fsm false] status after big change                74.65(5.14+101.50)
7527.40: [uc true][fsm false] status after add all                   49.96(5.22+90.96) 
7527.42: [uc true][fsm false] status after add dot                   49.77(5.24+91.72) 
7527.44: [uc true][fsm false] status after commit                    36.95(3.27+92.25) 
7527.46: [uc true][fsm false] status after reset hard                33.89(3.18+85.68) 
7527.48: [uc true][fsm false] status after create untracked files    41.44(3.40+92.99) 
7527.50: [uc true][fsm false] status after clean                     34.60(3.26+90.19) 

7527.52: [uc true][fsm true] status after checkout                    0.58(0.45+0.10)   
7527.54: [uc true][fsm true] status after big change                 65.16(4.91+25.64) 
7527.56: [uc true][fsm true] status after add all                    45.43(4.45+18.92) 
7527.58: [uc true][fsm true] status after add dot                    15.56(2.57+6.32)  
7527.60: [uc true][fsm true] status after commit                      0.98(0.46+0.11)   
7527.62: [uc true][fsm true] status after reset hard                 30.30(2.96+14.49) 
7527.64: [uc true][fsm true] status after create untracked files      2.15(1.73+0.40)   
7527.66: [uc true][fsm true] status after clean                       1.68(1.56+0.32)   


Here is performance data from t/perf/p7519-fsmonitor.sh on the same
synthetic repo containing 1M files on a Macbook Pro. This test performs the
same series of commands on all three FSMonitor options: (1) using the hook
interface to talk to Watchman, (2) no FSMonitor, and (3) the builtin
FSMonitor daemon.

$ ./p7519-fsmonitor.sh 
# passed all 42 test(s)
1..42
Test                                                          this tree        
-------------------------------------------------------------------------------
7519.4: status (fsmonitor=fsmonitor-watchman)                  0.89(0.63+0.17)  
7519.5: status -uno (fsmonitor=fsmonitor-watchman)             0.56(0.43+0.13)  
7519.6: status -uall (fsmonitor=fsmonitor-watchman)           24.52(1.82+9.90) 
7519.7: status (dirty) (fsmonitor=fsmonitor-watchman)         32.40(6.54+9.94) 
7519.8: diff (fsmonitor=fsmonitor-watchman)                    0.66(0.38+0.42)  
7519.9: diff HEAD (fsmonitor=fsmonitor-watchman)               1.60(0.69+0.80)  
7519.10: diff -- 0_files (fsmonitor=fsmonitor-watchman)        0.37(0.29+0.08)  
7519.11: diff -- 10_files (fsmonitor=fsmonitor-watchman)       0.42(0.32+0.09)  
7519.12: diff -- 100_files (fsmonitor=fsmonitor-watchman)      0.42(0.32+0.10)  
7519.13: diff -- 1000_files (fsmonitor=fsmonitor-watchman)     0.41(0.31+0.09)  
7519.14: diff -- 10000_files (fsmonitor=fsmonitor-watchman)    0.44(0.32+0.12)  
7519.15: add (fsmonitor=fsmonitor-watchman)                   24.81(2.44+10.06)

7519.18: status (fsmonitor=disabled)                          11.18(1.80+74.68)
7519.19: status -uno (fsmonitor=disabled)                      7.11(1.50+73.95) 
7519.20: status -uall (fsmonitor=disabled)                    30.09(3.01+91.11)
7519.21: status (dirty) (fsmonitor=disabled)                  31.46(5.03+77.75)
7519.22: diff (fsmonitor=disabled)                             5.79(1.27+62.97) 
7519.23: diff HEAD (fsmonitor=disabled)                        7.29(1.57+76.03) 
7519.24: diff -- 0_files (fsmonitor=disabled)                  0.68(0.30+0.09)  
7519.25: diff -- 10_files (fsmonitor=disabled)                 0.32(0.29+0.07)  
7519.26: diff -- 100_files (fsmonitor=disabled)                0.32(0.29+0.07)  
7519.27: diff -- 1000_files (fsmonitor=disabled)               0.35(0.29+0.09)  
7519.28: diff -- 10000_files (fsmonitor=disabled)              0.56(0.29+0.21)  
7519.29: add (fsmonitor=disabled)                             29.49(3.52+85.88)

7519.31: status (builtin fsmonitor--daemon)                    0.67(0.54+0.09)  
7519.32: status -uno (builtin fsmonitor--daemon)               0.42(0.35+0.08)  
7519.33: status -uall (builtin fsmonitor--daemon)             22.77(1.71+10.35)
7519.34: status (dirty) (builtin fsmonitor--daemon)           21.79(4.18+9.97) 
7519.35: diff (builtin fsmonitor--daemon)                      0.52(0.34+0.36)  
7519.36: diff HEAD (builtin fsmonitor--daemon)                 1.55(0.66+0.80)  
7519.37: diff -- 0_files (builtin fsmonitor--daemon)           0.37(0.31+0.08)  
7519.38: diff -- 10_files (builtin fsmonitor--daemon)          0.35(0.29+0.07)  
7519.39: diff -- 100_files (builtin fsmonitor--daemon)         0.35(0.29+0.07)  
7519.40: diff -- 1000_files (builtin fsmonitor--daemon)        0.35(0.29+0.07)  
7519.41: diff -- 10000_files (builtin fsmonitor--daemon)       0.37(0.29+0.09)  
7519.42: add (builtin fsmonitor--daemon)                      24.64(2.40+10.04)


Jeff Hostetler (23):
  fsm-listen-win32: handle shortnames
  t7527: test FS event reporing on macOS WRT case and Unicode
  t7527: test builtin FSMonitor watching repos with unicode paths
  t/helper/fsmonitor-client: create stress test
  fsmonitor-settings: bare repos are incompatible with FSMonitor
  fsmonitor-settings: stub in platform-specific incompatibility checking
  fsmonitor-settings: virtual repos are incompatible with FSMonitor
  fsmonitor-settings: stub in macOS-specific incompatibility checking
  fsmonitor-settings: remote repos on macOS are incompatible with
    FSMonitor
  fsmonitor-settings: remote repos on Windows are incompatible with
    FSMonitor
  unpack-trees: initialize fsmonitor_has_run_once in o->result
  fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
  fsmonitor--daemon: print start message only if
    fsmonitor.announceStartup
  fsmonitor--daemon: cd out of worktree root
  fsmonitor--daemon: prepare for adding health thread
  fsmonitor--daemon: rename listener thread related variables
  fsmonitor--daemon: stub in health thread
  fsm-health-win32: add framework to monitor daemon health
  fsm-health-win32: force shutdown daemon if worktree root moves
  fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
  fsmonitor: optimize processing of directory events
  t7527: FSMonitor tests for directory moves
  t/perf/p7527: add perf test for builtin FSMonitor

 Makefile                               |  19 +-
 builtin/fsmonitor--daemon.c            | 138 ++++++++-
 builtin/update-index.c                 |   9 +
 compat/fsmonitor/fsm-health-darwin.c   |  24 ++
 compat/fsmonitor/fsm-health-win32.c    | 257 ++++++++++++++++
 compat/fsmonitor/fsm-health.h          |  47 +++
 compat/fsmonitor/fsm-listen-darwin.c   |  89 +++++-
 compat/fsmonitor/fsm-listen-win32.c    | 409 ++++++++++++++++++++-----
 compat/fsmonitor/fsm-listen.h          |   2 +-
 compat/fsmonitor/fsm-settings-darwin.c |  75 +++++
 compat/fsmonitor/fsm-settings-win32.c  | 137 +++++++++
 config.mak.uname                       |   5 +
 contrib/buildsystems/CMakeLists.txt    |   8 +
 fsmonitor--daemon.h                    |  11 +-
 fsmonitor-settings.c                   |  84 +++++
 fsmonitor-settings.h                   |  26 ++
 fsmonitor.c                            |  71 ++++-
 t/helper/test-fsmonitor-client.c       | 105 +++++++
 t/perf/p7527-builtin-fsmonitor.sh      | 257 ++++++++++++++++
 t/t7519-status-fsmonitor.sh            |  35 +++
 t/t7527-builtin-fsmonitor.sh           | 157 ++++++++++
 unpack-trees.c                         |   1 +
 22 files changed, 1838 insertions(+), 128 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-darwin.c
 create mode 100644 compat/fsmonitor/fsm-health-win32.c
 create mode 100644 compat/fsmonitor/fsm-health.h
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh


base-commit: ce8aa175364c7a02115c4b4f91d5674f4d6d8ae8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1143%2Fjeffhostetler%2Fbuiltin-fsmonitor-part3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1143/jeffhostetler/builtin-fsmonitor-part3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1143
-- 
gitgitgadget
