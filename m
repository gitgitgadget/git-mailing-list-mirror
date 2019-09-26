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
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E1D1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 17:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfIZRqV (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 13:46:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34870 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZRqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 13:46:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so2370179lfl.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=DaJxAQBB+IYSIicVRrR+d87a8fv7mIF2sL6+UhJGX5Y=;
        b=FYhSu2Jy9e4/KtFA9AdramY/4W6VVMjbunBmATnkBGREWSsGBgZMMNLhHQfVrtdRLL
         rJ1qcBPyKBpuOYkxcLdFqXvYoJ43ngdmWOiIb/SvccQ4Vt4fZWdL95KA/+/UhliH0NHS
         6LNhRJMLa1BjcuXEQuOQy/chQngWqFbvBgrV8lTERGWBFKTGuGLEo9YZNsRu7qSf4qki
         XkmuowhRwULU2yxCYRUk2J368hU8EiUPMPONpGecsplZ/+SBgpm27TJWzqPThVYFMOk6
         zlHdVTZF+jyGXdQdxqJlrk6QzsF6m8JlvkuuvZkCRyY60ihXJDW+aB9JKR2FT3qeBeqd
         192w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DaJxAQBB+IYSIicVRrR+d87a8fv7mIF2sL6+UhJGX5Y=;
        b=FJGSkjmppZjuCTqZdOEFWtt4X2BGNLak9YNg3zVQNjZjHvIigxLvvAjXhpapd21LQY
         EfZi2+pbB64BdUs6yWUCoJNs7+kqrAJ3zCcJzXQwDsnYVx5hBcl3w34gjWTa3MN7V1MH
         nw3r6TRlReyBj0AoptlxTJOR4M6wB1vNNWR24fVNnQkQ0EWXVMp73niAoCpiZZf7wOsJ
         dNaqrLMOkR+UlJUtvxTXrmTYIn4Gi9w2zv6hl/djOhY2eMlFRtl7NgxRDUcc0Yf4IM6l
         nTx6TjLHh8h9MWsVTLAgFF4JmUT4i8OZS0qSrpZdagr+GbhLwXwIMpm3Asm5JlgNk28d
         Dw3A==
X-Gm-Message-State: APjAAAWeMgLN+hZSY7hmnA4gj3o1fGGU84/nGpTi11z9rO3es/V4PvwB
        kgZNJmH/z4zlP5ZrEt61FbjXdrYr
X-Google-Smtp-Source: APXvYqzRAxJwedtMD6FxHgJG1I1h+2TCMz8K/Slsvy/pnBAwbVVfr2dB8fm9d9XQ300lD6XLvP8z4Q==
X-Received: by 2002:a19:8c14:: with SMTP id o20mr2986973lfd.158.1569519978998;
        Thu, 26 Sep 2019 10:46:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21sm704760ljq.15.2019.09.26.10.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:46:18 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:46:18 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 17:46:16 GMT
Message-Id: <pull.360.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] git-gui (Windows): use git-bash.exe if it is available
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... and yet another patch that is carried in Git for Windows for quite a
long time.

This commit was contributed as https://github.com/patthoyts/git/gui/pull/6 
which was ignored for almost three years, and then as 
https://github.com/prati0100/git-gui/pull/2 which was rejected in favor of a
mailing list-centric workflow.

The patch is based on Git GUI's master branch at 
https://github.com/prati0100/git-gui/.

Thomas Klaeger (1):
  git-gui (Windows): use git-bash.exe if it is available

 git-gui.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)


base-commit: 12d29c326551a6570594db525bea42ad9cea8028
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-360%2Fdscho%2Fgit-gui-git-bash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-360/dscho/git-gui-git-bash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/360
-- 
gitgitgadget
