Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B551F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeAWARC (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:17:02 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45654 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeAWARB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:17:01 -0500
Received: by mail-qt0-f193.google.com with SMTP id x27so25596296qtm.12
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 16:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=al+MFtJrcfliO/m/WsnvFBheGpymkkMz1EOKQUhgMVU=;
        b=C7Sk8f4xIYeM/HCh6BxrtUU78HRkm0aGyQTTHT9ZTCjDX2JhjG3XlbyYd6/ZKPl4Tk
         DcDJ5AOKnZmw6CqlHnQm0bwRm91G3jsbqQWZZGXAK4oSwlZuCOL0Juo+fFGz+jB/fuKk
         ylWBkSJwVDFeSMn0jre6ldvxDgB8FlCxs84uBwSukBWf/xhDtV9IdPqsX9FxOHPkt1Mg
         A34f+/3yZGiwoXGn9uvkvaLHxeN9y5Y5aUndoWugLcBegzCWrHcWDqa0iSj4utKs/jAz
         KV0wZlba4r7q+a2eztZDSMP0eQmS+fCrm5sVdNav8QFrFMAFyLdpIpFws4zbHSVdY/xP
         Ql8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=al+MFtJrcfliO/m/WsnvFBheGpymkkMz1EOKQUhgMVU=;
        b=nccUF9HYzWRHq3CqFmsc5LES/Rx4sV4ChosqH2GRcAvN54W/MBrCYVMwIQcN4fIOp8
         bEoH2yjGA+ISCnnmnEoO1WrqOWT1a5Vqzohn2JP7HEHjmOUjVz3a2TIjWmFaO0sJEotB
         hJjVCV6MswEHALfb92Y/ZHJ0I+vHSgsCUqh6CGrAPifHzfhoS9jwyKHHRLKfgjliR+Qo
         0kb6iXjTkefAiCL96kMO1YK3Vfo/LKn5wN7p1igB1Mugl/rCMycDCtCIW+yJ+F7+j4v3
         FzqCgQxPuAilWjIuQ5I+4N6gHZhrQmJvb3+mNnch4FGZCmhL508hrzO1mx5ZolNANluv
         vz4w==
X-Gm-Message-State: AKwxytdIVCepoDJ9Sb0QjjpKyq7emEXnvb/PbmYWHLLkHQh4t3SwTgE/
        2D76ryxZ5m66O5HHi9LTlHo=
X-Google-Smtp-Source: AH8x224VZsUcDwyasWl4/H94IXbeWHLsD4Rrej6fK/QDANFbgfAFkAAjWjorXM65+ABeiL+XZKp3/w==
X-Received: by 10.55.170.212 with SMTP id t203mr1024093qke.167.1516666620786;
        Mon, 22 Jan 2018 16:17:00 -0800 (PST)
Received: from lenovo.fios-router.home (pool-108-54-110-249.nycmny.fios.verizon.net. [108.54.110.249])
        by smtp.gmail.com with ESMTPSA id y72sm3207915qkg.3.2018.01.22.16.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 16:16:59 -0800 (PST)
From:   Isaac Hier <isaachier@gmail.com>
To:     gitster@pobox.com
Cc:     Isaac Hier <isaachier@gmail.com>, git@vger.kernel.org
Subject: [RFC PATCH 0/1] Implement CMake build
Date:   Mon, 22 Jan 2018 19:16:47 -0500
Message-Id: <20180123001648.24260-1-isaachier@gmail.com>
X-Mailer: git-send-email v2.16.0.rc0.1.g067a769b1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds a mostly complete (aside from building tests, documentation,
installation, etc.) CMake build to the git project. I am not sure how much
interest there is in a CMake build, so please send me feedback one way or
another. Personally, I believe CMake will help with Windows builds and is
somewhat easier to read than a Makefile. I considered, adding this to the
contrib directory, but CMakeLists.txt almost always reside in the original
directories, and I'm not sure how wise it would be to do otherwise. If you are
interested in a CMake build, I would be more than happy to finish up the work
here. Decided to wait until I discussed the issue here to finish the final parts
of the build.

Isaac Hier (1):
  Implement CMake build

 CMakeLists.txt              | 1849 +++++++++++++++++++++++++++++++++++++++++++
 cmake/GenerateCmdlist.cmake |   83 ++
 cmake/fopen_dir_test.c      |   11 +
 cmake/fstat_test.c          |   37 +
 cmake/gmtime_test.c         |    7 +
 cmake/iconv_test.c          |   13 +
 cmake/inline_test.c         |    9 +
 cmake/mkdir_test.c          |    7 +
 cmake/mmap_test.c           |   35 +
 cmake/parens_test.c         |    6 +
 cmake/snprintf_test.c       |    7 +
 cmake/sysctl_test.c         |   11 +
 12 files changed, 2075 insertions(+)
 create mode 100644 CMakeLists.txt
 create mode 100644 cmake/GenerateCmdlist.cmake
 create mode 100644 cmake/fopen_dir_test.c
 create mode 100644 cmake/fstat_test.c
 create mode 100644 cmake/gmtime_test.c
 create mode 100644 cmake/iconv_test.c
 create mode 100644 cmake/inline_test.c
 create mode 100644 cmake/mkdir_test.c
 create mode 100644 cmake/mmap_test.c
 create mode 100644 cmake/parens_test.c
 create mode 100644 cmake/snprintf_test.c
 create mode 100644 cmake/sysctl_test.c

-- 
2.14.1

