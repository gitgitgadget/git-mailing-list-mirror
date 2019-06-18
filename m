Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8DCA1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfFRMX6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:23:58 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:41471 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfFRMX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:23:58 -0400
Received: by mail-ed1-f42.google.com with SMTP id p15so21412794eds.8
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2ed0QaV/tNc/0J3MSydsvGgSd5q4WursT+HSafCV2hI=;
        b=X76RLGI9k285AI1SGF8lRyqL5d92n/DB8x2w4HwkLi0SzeAshiJETzikhZUPbYNptP
         2i2Unbuo8AMnCZueoW8ZySHZMeMnt7+ShlnoHnEZiG3K2ar4X2qjUiM8MIUHbyF+ZSEp
         85DfBd9Hy+bN0WViqEuZsKAOd19jdfUgVjllEIFTBF0lApObInuG+A2quc0xqNq+HsbC
         laLkbDUwqYgxXq6hvmQEtOFixFqh2Qz9nMzkZu9cL+hFaRbtnWssD3fYCrW3FhsCC9yo
         /jAA2aQ00EKyuVOnzSqsg24UJF1dBP57Sys3O6g+7P/4G5IHsosQJfIWoUNk51PiK29o
         4KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2ed0QaV/tNc/0J3MSydsvGgSd5q4WursT+HSafCV2hI=;
        b=SjTIDze4r5Y5YlkkJHsWFM7JKdXkpgRFXK+Sh5fUxgqbKL2ltfkyzS8bMYkM2t7Dxc
         dlFNH7qd9RC/SzKa5nz9SmzYlou/OHcWHohnhdxudNMhcOt0XzyRJxsx87tns+3+H8Ff
         IfZ0Zd2E7b3Bie81y19mHAAEitENfUgM9O6Ovcq0kP1UEVMTkxjhAfH7I+M0JJGvF709
         TcpyRWBHuA63uisT5WCfdnulqOxHUcM2qJzTTBr+sRJtSD3f5l0hOZ2TKnjNIKDYRcme
         RtCCe1s2pdvv/W19mttUWsXJiChthKW1LVV+MFGvwNiczfTCmVmA1fum2WYl/MtpQrjV
         BLVA==
X-Gm-Message-State: APjAAAWqIEJeE4bMy6Xxq+Z1KCePq7Pp1HUyq6y+VuUtAoLhJ8FoEY1h
        T3khMwRftC1dj/zDHnFPv+0P70Ew
X-Google-Smtp-Source: APXvYqzO65yhduD/gXznj/9qcEVDPjea2lLZvGL09Mmbq5Nmg2cJEL+Q2N1t9qrADARwGwef/6H7+g==
X-Received: by 2002:a50:9273:: with SMTP id j48mr98113504eda.285.1560860636054;
        Tue, 18 Jun 2019 05:23:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y22sm4710273edl.29.2019.06.18.05.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:23:55 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:23:55 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:37 GMT
Message-Id: <pull.149.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/17] Fix MSVC support, at long last
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley and Jeff Hostetler worked quite a bit on getting Git to
compile with MS Visual C again, and this patch series is the culmination of
those efforts. With these patches, it is as easy as

make MSVC=1

Note: the patches went through quite the number of iterations. For example,
for a long time we targeted Visual Studio 2015, and used NuGet packages for
the dependencies (such as OpenSSL, cURL, etc), while the current iteration
targets Visual Studio 2017 and uses vcpkg
[https://docs.microsoft.com/en-us/cpp/vcpkg?view=vs-2017] for dependencies.
Hopefully I did not forget to remove any remnants of those previous
versions.

Please also note that this patch series is part 1 of 3 in a bigger story:
the next patch series will add support to build Git in Microsoft Visual
Studio, and the third patch series will add Continuous Testing by adding an
MSVC build and a corresponding parallelized test job to our Azure Pipeline.

Jeff Hostetler (8):
  cache-tree.c: avoid reusing the DEBUG constant
  msvc: mark a variable as non-const
  msvc: do not re-declare the timespec struct
  msvc: define ftello()
  msvc: fix detect_msys_tty()
  msvc: support building Git using MS Visual C++
  msvc: do not pretend to support all signals
  msvc: ignore .dll and incremental compile output

Johannes Schindelin (6):
  Mark .bat files as requiring CR/LF endings
  t0001 (mingw): do not expect a specific order of stdout/stderr
  obstack: fix compiler warning
  mingw: replace mingw_startup() hack
  msvc: fix dependencies of compat/msvc.c
  msvc: avoid debug assertion windows in Debug Mode

Philip Oakley (3):
  msvc: include sigset_t definition
  msvc: define O_ACCMODE
  msvc: add pragmas for common warnings

 .gitattributes                     |   1 +
 .gitignore                         |   5 +
 Makefile                           |  42 ++++++-
 cache-tree.c                       |  14 +--
 compat/mingw.c                     | 100 +++++++++++++----
 compat/mingw.h                     |  24 ++--
 compat/msvc.h                      |  10 ++
 compat/obstack.h                   |   2 +-
 compat/vcbuild/.gitignore          |   3 +
 compat/vcbuild/README              |  51 +++++++++
 compat/vcbuild/find_vs_env.bat     | 169 +++++++++++++++++++++++++++++
 compat/vcbuild/scripts/clink.pl    |  41 ++++++-
 compat/vcbuild/vcpkg_copy_dlls.bat |  39 +++++++
 compat/vcbuild/vcpkg_install.bat   |  80 ++++++++++++++
 compat/winansi.c                   |  13 +++
 config.mak.uname                   |  79 ++++++++++++--
 git-compat-util.h                  |   9 ++
 t/t0001-init.sh                    |   3 +-
 18 files changed, 628 insertions(+), 57 deletions(-)
 create mode 100644 compat/vcbuild/.gitignore
 create mode 100644 compat/vcbuild/find_vs_env.bat
 create mode 100644 compat/vcbuild/vcpkg_copy_dlls.bat
 create mode 100644 compat/vcbuild/vcpkg_install.bat


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-149%2Fdscho%2Fmsvc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-149/dscho/msvc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/149
-- 
gitgitgadget
