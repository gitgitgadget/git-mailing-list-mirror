Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8281F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeKLXly (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:41:54 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:38443 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbeKLXly (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:41:54 -0500
Received: by mail-pg1-f176.google.com with SMTP id f8-v6so4105102pgq.5
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 05:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=a71LydMvI8MNjqbrACJIYSf2fFbLWz/HTDX/0p8dy1s=;
        b=nX/xMRIEm6IVFbTnsD8obK40lw3L01RcvfHhmuSC+7NpQe2n38e5Z+asuow4PeBwpl
         jwDQgnKXx5vzzIHsxwPzfTBVK4cuGUovQ0REIa9tBcUAcIKmau1fNRAN/XPpdAOW3U5B
         ov55P4KZRH3IB/zTzQGv/z2H52lO6vBgErUVyz4GMVEKTf/SMthrFkCqyxBXi7Lc5wRt
         0TYpboRbxu+hZ0JnzcwAxIWw7LbP1vGMV2uZFOIJPaB5wpwQ151dPgLmsSrANCMXkvUd
         tKKLItTKIMYNp2tk1Dcb/vM++dp8orEPo7AYXBN0BvxLhdKMu2H1uWjjarfTj5g3AP4X
         4VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a71LydMvI8MNjqbrACJIYSf2fFbLWz/HTDX/0p8dy1s=;
        b=ayUbnozTc9mRwuwtF0P1iqYs7+GbRldPRnj5yKWCh/ar+ZEKkydTqsq7aqsQhxKwXQ
         wlvxD9zN+2xz+M53DwbObFuiJJ0/E1JtANvYhWjFqrIdIRLGLaJZvQcb+CGUuYWqXb1a
         tapPQuNwbor0eXH9PG+4mMwVOK1gqwh+XUmsupIO8Xp4WSitpS86Ftjwc0uCl3lsxXK4
         orJUIAG6GPVfPBtS/Lp70Fz1Pihjmpe+swOd0THOhZU52XqP8YAvNpI9kbgTkZhIxuTZ
         4VhWSNLH3IafPDCPpZD5SRZkWZ3Op2P1ZktxzIyzkqT/M5XaEKCGyI5YEcCjcrhMGqHw
         CjVQ==
X-Gm-Message-State: AGRZ1gLY26QJpBEdZ/4clb9cIqj3v045lKIkzdjfG6oLkeoEn6cdA/Uv
        VbYzfovQWzkZFIiNuMB1x9uaGEo/
X-Google-Smtp-Source: AJdET5dSZpTD3DKG/wvLm33pc4Lb2al4xPINWkWmmPz8ldNWnEW8Ye0kUq8iAD+nT5voMt0hHIxXbw==
X-Received: by 2002:a63:d949:: with SMTP id e9mr919417pgj.24.1542030512613;
        Mon, 12 Nov 2018 05:48:32 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id x194-v6sm24473804pfd.32.2018.11.12.05.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:48:32 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:48:32 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 13:48:24 GMT
Message-Id: <pull.73.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/5] tests: various improvements to the GIT_TEST_INSTALLED feature
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

By setting the GIT_TEST_INSTALLED variable to the path of an installed Git
executable, it is possible to run the test suite also on a specific
installed version (as opposed to a version built from scratch).

The only thing this needs that is unlikely to be installed is the test
helper(s).

However, there have been a few rough edges around that, identified in my
(still ongoing) work to support building Git in Visual Studio (where we do
not want to run GNU Make, and where we have no canonical way to create, say,
hard-linked copies of the built-in commands, and other work to let Git for
Windows play better with BusyBox.

Triggered by a comment of AEvar
[https://public-inbox.org/git/20181102223743.4331-1-avarab@gmail.com/], I
hereby contribute these assorted fixes for the GIT_TEST_INSTALLED feature.

Johannes Schindelin (5):
  tests: fix GIT_TEST_INSTALLED's PATH to include t/helper/
  tests: respect GIT_TEST_INSTALLED when initializing repositories
  t/lib-gettext: test installed git-sh-i18n if GIT_TEST_INSTALLED is set
  tests: do not require Git to be built when testing an installed Git
  tests: explicitly use `git.exe` on Windows

 Makefile                |  1 +
 t/lib-gettext.sh        |  7 ++++++-
 t/test-lib-functions.sh |  3 ++-
 t/test-lib.sh           | 15 ++++++++++-----
 4 files changed, 19 insertions(+), 7 deletions(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-73%2Fdscho%2Ftest-git-installed-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-73/dscho/test-git-installed-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/73
-- 
gitgitgadget
