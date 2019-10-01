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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CAD01F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 11:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfJALlI (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 07:41:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54668 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbfJALlH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so2976065wmp.4
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 04:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ypbGhFR3/lLCpzE8cLyGA83w/2vFD1KGz6Ba5B8jpC8=;
        b=ZHwVcaoKO6PJPBaXmd/4OhORLCXoeLyIj4mdrSQjmZp+w/A+fFuZZDDknBQrVKW8JK
         X+jk1k2TfXWDAtAN1RPcuxqzraPY1Ra4q0fnYNc6m4Vm18e2VQ18ZIiv1OKj9LSZVIgU
         P2XKOagBpc4nAuCPl/NWdCE+C+5Ef08P159fuZnzXj/HtlPvVVpCiGA5vinEAwzUIwzm
         UP87oXK89HUhHk9frBDLaPeS1qBuYiw92510DmWxrKTcXZo9DAjlq6b/HW1++9NGDPp7
         w5pfyWjZX7Wi0sHZDDTNjJEALZwY3/3AgawtPf9rBCON1kl7YwfFJpPihniU3SVFwTUM
         m7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ypbGhFR3/lLCpzE8cLyGA83w/2vFD1KGz6Ba5B8jpC8=;
        b=EDnlfPIejuJdQ1+IXxoMj5+9mCPRkLGTo0rpEpWubm7xaL/YyIZ/q69tDs0toYYSF6
         lnaKRSFdGVhwcwWC4/Qrr3UErRcLVyBL1RrcAG7Mr0oVh163yv3lV4vFx5gAG72nnSuW
         koXzmd50VsSC5oLIkmFofxUy6POEQMOr4cWkirbdEToccykOHsEKYLmq9TnC0AZQrbkj
         tVJBxUm+h9V/R487Q1SeMFB0JlK2xpnEn87fysYKdz8duLTLnzZOEriTFjRXM+rEr+P4
         NyxU7gJUSTi8JgNAjZeosGDgaVwr4HeFK7wJ6WkqRVSypQn5Xvd85XKscvTEH0KKe4gq
         EePQ==
X-Gm-Message-State: APjAAAXDCCOwPfh+zMMsQdufkGOl6Cm63nX9swyErbE4gew8i+iwEl3Y
        IP1CSnER3ufZdBdwbQql5jxmfrel
X-Google-Smtp-Source: APXvYqy50q9nHFONqf+sBJp7jLk4f29HPV+L0hgptpP+lfvpSSN+t9T5GXvVWbox1YcojEUi5KYv0w==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr3203011wmg.33.1569930064965;
        Tue, 01 Oct 2019 04:41:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z142sm4580820wmc.24.2019.10.01.04.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:41:04 -0700 (PDT)
Date:   Tue, 01 Oct 2019 04:41:04 -0700 (PDT)
X-Google-Original-Date: Tue, 01 Oct 2019 11:41:02 GMT
Message-Id: <pull.356.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] t0061: fix test for argv[0] with spaces (MINGW only)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test was originally designed for the case where user reported that
setting GIT_SSH to a .bat file with spaces in path fails on Windows: 
https://github.com/git-for-windows/git/issues/692

The test has two different problems:

 1. It succeeds with AND without fix eb7c7863 that addressed user's problem.
    This happens because the core problem was misunderstood, leading to
    conclusion that git is unable to start any programs with spaces in path
    on Win7. But in fact a) Bug only affected cmd.exe scripts, such as .bat
    scripts b) Bug only happened when cmd.exe received at least two quoted
    args c) Bug happened on any Windows (verified on Win10). Therefore,
    correct test must involve .bat script and two quoted args.
 2. In Visual Studio build, it fails to run, because 'test-fake-ssh.exe' is
    copied away from its dependencies 'libiconv.dll' and 'zlib1.dll'.

Fix both problems by using .bat script instead of 'test-fake-ssh.exe'. NOTE:
With this change, the test now correctly fails without eb7c7863.

Signed-off-by: Alexandr Miloslavskiy alexandr.miloslavskiy@syntevo.com
[alexandr.miloslavskiy@syntevo.com]

Alexandr Miloslavskiy (1):
  t0061: fix test for argv[0] with spaces (MINGW only)

 t/t0061-run-command.sh | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-356%2FSyntevoAlex%2F%230191_t0061_fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-356/SyntevoAlex/#0191_t0061_fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/356
-- 
gitgitgadget
