Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF461F461
	for <e@80x24.org>; Sat, 24 Aug 2019 22:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfHXWKr (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:10:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33038 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfHXWKq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:10:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so11673451wme.0
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Q/h5UF9kQtD087ArEfF8Q6wrsRcMb2SomwZhpBDfnNs=;
        b=b3fEEBS9bicsjS7TiTBVKZ+Ga/HYjXtqgTXDJygpgfm7OXOYfVU0nT8F/K1fAAqLTM
         WdXURyju55AQp6JDoGqAOwEQd283lx2206xLmXqAThFD5clBvGChu4fTilqxJO4LGH4K
         e4oHl6FCDLiKKaMgz+/2xJ126ul+5EekRYyo75nUZ2G+TXaWina/ylAko3IAK0dB765t
         uyPKsPH4CsElOK9ksQ8KauFMamMWmJgCVJrnZgUsRmOB6WjiULpkdZxUj6tiBudOFKZH
         qHz7TvO04sDrjestJbyWeVrVDsQLTUh0hZhrZaU209AcBO5HjxDj3brv469rr30F2DCE
         mnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q/h5UF9kQtD087ArEfF8Q6wrsRcMb2SomwZhpBDfnNs=;
        b=gRqAYUdxKJ2TU2tMEJ8bpkPs0cWagkMtlSEj6cRyDFV+EmnLA6D+8Iw0v8Y/hXGaQI
         qD/fNd2fMZlE93MA7anu30kbfWwgkrAezl6GVyaOmvWOYxnV52tNgWKRnE0GkBTWAgAd
         lYl/L6UV37bmobqeqvjmj8Mc88R4ahPP7VSRRtk4b4t2NVGU7KstF9vrGhbJUWfQN2Hf
         N3y12xvE7pkvIIjOZbz/B0/chTPOgRjqwFQjJqmBRyWdgUPuaxTYCv2JkldLbsjdA0Wg
         bluP87TjwpgmeJGj8affBbkR+FoZTsksju9nJQW6YVsbU3eUZWu9tEkaIPsJdScdbcfv
         BBcw==
X-Gm-Message-State: APjAAAUwM5oXB4/5rmkx4W6Bc5KR5HIul/6A8Ue+VwtdWnAyZ8kTMCYn
        5P1uq0em5b4C89RjJkkLWsc7g8ul
X-Google-Smtp-Source: APXvYqxFskZI+9V94seTZpkAWJN0iCzNy9p0rBBWxECEGPsJ/z6kxwerSZnGP6J6BtEwTBCW5UxQ3A==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr13416844wmb.42.1566684644627;
        Sat, 24 Aug 2019 15:10:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19sm6192629wml.28.2019.08.24.15.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 15:10:44 -0700 (PDT)
Date:   Sat, 24 Aug 2019 15:10:44 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Aug 2019 22:10:40 GMT
Message-Id: <pull.141.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Handle worktrees at the top of a network drive
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

Windows' network drive concept is a quite useful and versatile one. Once
authenticated, one can even change the working directory to a network drive
(cd \\server\share, works in PowerShell and Git Bash).

Some users want to have their Git repositories there, and with these
patches, that works, even.

This is yet another patch series in the seemingly endless stream of Git for
Windows patches.

Johannes Schindelin (3):
  setup_git_directory(): handle UNC paths correctly
  Fix .git/ discovery at the root of UNC shares
  setup_git_directory(): handle UNC root paths correctly

 setup.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-141%2Fdscho%2Fgitdir-at-unc-root-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-141/dscho/gitdir-at-unc-root-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/141
-- 
gitgitgadget
