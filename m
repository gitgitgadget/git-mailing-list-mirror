Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2015F20248
	for <e@80x24.org>; Wed, 13 Mar 2019 19:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfCMTUQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 15:20:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42204 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbfCMTUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 15:20:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id j89so2537426edb.9
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MaIklqBJBYv0HUUzzz0BeOfHQlibCw5QGAnSYCWE3ek=;
        b=ht00P1pfQtL884mYpIoJUoedBi4Jg+nXHXbaymAo7qnkXEOi6wFVeUze5aCH+Yf9mN
         n5zKPm4/hNL3n2iQ9eLi4NlGUBmFw6Tj5DT/LqduKG3i1Ihgw3a1j+T8hL4UW7FOTFR7
         VMTOxCfssrQMds+LXtWposkNErbJAeTRxH8+6y6jKRjM+fTJEBzg1Pn+T7MFsqHd0sZf
         SumuAsH62PFiRX3DqZlzS9/ucUpb/+/8WKQ/Mu1TVMU03anZehSxTZ6uUyrJy1gsEosH
         ez91Xur3WhS2CVpcXhhUTK6eh1n0eziKhFLI7xQRTRv8yPrVv5iydY5PnQpilP7SJ0IA
         AOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MaIklqBJBYv0HUUzzz0BeOfHQlibCw5QGAnSYCWE3ek=;
        b=qJqoADGCThsB0LLxxDsgV5rScpZ7RcaA+k8TvAa9DgGJAYk+jf86xfqEY1EduKf8VY
         VphkuDF8KeixiOSwHECkAuDP/Aj9b4eCtu3aE08gQH99RbH6LK5tR0evANaQq4rHLXVL
         aZdzZUhRrOomdT+mOup4gWYAiVCyypKjeUf7j5E4sSt5qzZoiXO9AhRrDlgmq+FiG/q7
         QCYvwakdjzCr3Z2aWZ+ZGkc1Bg0Yd0J9xu4EfquyaW5QqErnZ0S2eeVnQCMXQ5qxEqOB
         moPIybAErGuOeRBubnLSvxTBX4qAsRuXuXsOWdqAhIpBM15X2QRT5soau/4auEEvUWYk
         kscQ==
X-Gm-Message-State: APjAAAV1knP9siGVpdjDd8a9GdQWMp7ek5t/GQJfFkL9T/+9t+o1J3TY
        vStGgdgWYsODzgoW3DBQZefjTfKR
X-Google-Smtp-Source: APXvYqzX/GySDRpcTJwCVOhXDTfei4Z8JhyAxbvKSqzv9CsrOI999+0eCtGQpZe/TwqrBNn6IV82xw==
X-Received: by 2002:a17:906:7206:: with SMTP id m6mr30616930ejk.145.1552504813692;
        Wed, 13 Mar 2019 12:20:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i20sm625150ejv.26.2019.03.13.12.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:20:13 -0700 (PDT)
Date:   Wed, 13 Mar 2019 12:20:13 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Mar 2019 19:20:10 GMT
Message-Id: <pull.163.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Allow difftool to be run outside of Git worktrees
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

It was reported in https://github.com/git-for-windows/git/issues/2123 that 
git difftool --no-index fails to work outside worktrees, even if it should
work.

I fear this is a regression I introduced over two years ago (!) when I
converted the Perl script to C.

At least now that I know about the bug, I can fix it.

Johannes Schindelin (2):
  difftool: remove obsolete (and misleading) comment
  difftool: allow running outside Git worktrees with --no-index

 builtin/difftool.c  | 21 +++++++++++++++++----
 git.c               |  2 +-
 t/t7800-difftool.sh | 10 ++++++++++
 3 files changed, 28 insertions(+), 5 deletions(-)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-163%2Fdscho%2Fdifftool-no-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-163/dscho/difftool-no-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/163
-- 
gitgitgadget
