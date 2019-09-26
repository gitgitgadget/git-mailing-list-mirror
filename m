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
	by dcvr.yhbt.net (Postfix) with ESMTP id 098991F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfIZIaL (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39352 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfIZIaK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id 72so1032136lfh.6
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=z0I+AW2w/9G0HhbJPErUrTHsuwSrhoDLyr4JfrSNPTY=;
        b=Mij3iXvAmP2j0ol+mnQxx19vMKxqOhLXmajN6PToLDrtCJUWRrqJROLrRsSczPKEAm
         c6gWh8G43/ZlWa0hJKoB/uu3FJdJSdZZDRNr3duH1xQN4CKb0U4/EO2Zmk2F529AeC0T
         mXKUgCX83qgqQacL0shDsJr9HMMu3K4hIWg8P7B2ljPHIoMAXeGPxEIXIEq1t8bCPGtd
         BXvSFcAaFBD5OjyWO6v9s9OwaVaUFYUUzRtQMBm2VSQ3F/ucftQ6+S+eaEpZUyCH9Fm+
         P0pULaHXHrk3Rs5Ka4lfxz6oHKCR9s4dqCpVRLoh0LZovDzFYYvA01eyfmgoh6wNsxlO
         oHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z0I+AW2w/9G0HhbJPErUrTHsuwSrhoDLyr4JfrSNPTY=;
        b=Ko1CsBj1J0yJ2oF87krdarKPw8h9tKdVrqXrrhSwldoB151HYFvzv7aGHDTGOWPjJx
         96y5j6Xs21whUwaL/Vk/IGe09A96umH3e1NVDXCdgJi1VR7SnjxCsqJbmjWEUVhulhbe
         FqkpAw0EDJNXpJS3YQHsTR4id2thxI9Xu2jfksNbKWslBaUICNWexFNS/rfmLlIHwF6r
         SM/jlluxT0DJA2RQr4aBBMRWNNmxALrnBAr/6kuOkNWltbT7FdbaiXW2dsZTJeWd9SsA
         sLtt/zLpWBPjvnST5qMt5Hv1MZEXe4gaTY/iMLReMKdIIjTnKJVOihLeId1bJ4vkHTTe
         m7Vg==
X-Gm-Message-State: APjAAAXd+N1wthbAwBJYIbsgZ1XlW09slYmlLJVyqT3p5y5KVLZAWyfz
        RGfexBCkO3/7WPaenGAT+2WAYYU3
X-Google-Smtp-Source: APXvYqy7Vt0TFMqoAqoenL09uiM2JDO0R0g+ce0RbS3fUjMW43UbYnjk/RCtfcEfleenYYx0yGTS/A==
X-Received: by 2002:ac2:5925:: with SMTP id v5mr1428794lfi.8.1569486608922;
        Thu, 26 Sep 2019 01:30:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c69sm346682ljf.32.2019.09.26.01.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:08 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:08 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:29:53 GMT
Message-Id: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/13] ci: include a Visual Studio build & test in our Azure Pipeline
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

Git's Continuous Integration (CI) includes an Azure Pipeline that builds Git
on Linux, macOS and Windows, in the former two cases even in multiple
configurations (using GCC vs clang, 32-bit vs 64-bit, etc). On Windows, we
only build using GCC, using (a subset of) Git for Windows' SDK.

Recently, a patch series made it into Git that re-instates the ability to
generate project files for use with Visual Studio. The idea there being:
contributors can check out a special branch that has those generated files
in one generated commit on top of e.g. Git for Windows' master, allowing the
contributors to build Git in Visual Studio, without the need for downloading
Git for Windows' SDK (which weighs quite a bit: ~600MB download, ~2GB disk
footprint). The tests can then be run from a regular Git for Windows Bash.

This patch series adds that axis to Git's Azure Pipeline: the project files
are generated, MSBuild (which is kind of the command-line equivalent of
Visual Studio's "Build" operation) is used to build Git, and then a
parallelized test job runs the test suite in a Portable Git.

These patches are based on js/visual-studio.

Johannes Schindelin (13):
  push: do not pretend to return `int` from `die_push_simple()`
  msvc: avoid using minus operator on unsigned types
  winansi: use FLEX_ARRAY to avoid compiler warning
  compat/win32/path-utils.h: add #include guards
  msvc: ignore some libraries when linking
  msvc: handle DEVELOPER=1
  msvc: work around a bug in GetEnvironmentVariable()
  vcxproj: only copy `git-remote-http.exe` once it was built
  vcxproj: include more generated files
  test-tool run-command: learn to run (parts of) the testsuite
  tests: let --immediate and --write-junit-xml play well together
  ci: really use shallow clones on Azure Pipelines
  ci: also build and test with MS Visual Studio on Azure Pipelines

 Makefile                                   |   4 +
 azure-pipelines.yml                        | 164 ++++++++++++++++++++-
 builtin/push.c                             |   4 +-
 compat/mingw.c                             |   2 +
 compat/vcbuild/scripts/clink.pl            |  48 +++++-
 compat/win32/path-utils.h                  |   5 +
 compat/winansi.c                           |   2 +-
 config.mak.uname                           |  19 ++-
 contrib/buildsystems/Generators/Vcxproj.pm |   3 +
 read-cache.c                               |   4 +-
 sha1-lookup.c                              |   2 +-
 t/helper/test-run-command.c                | 153 +++++++++++++++++++
 t/test-lib.sh                              |  37 +++--
 13 files changed, 415 insertions(+), 32 deletions(-)


base-commit: aac6ff7b5beeea9bca66ecda6eec60fc1dd447ec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-288%2Fdscho%2Fazure-pipelines-msvc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-288/dscho/azure-pipelines-msvc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/288
-- 
gitgitgadget
