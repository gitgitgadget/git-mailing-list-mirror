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
	by dcvr.yhbt.net (Postfix) with ESMTP id D04CA1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfHSJS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 05:18:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45822 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHSJSX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 05:18:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so7884898wrj.12
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=cnprQBFPVdld5o0jWafe8SbdbeovxrEKtrYLRXSG1AI=;
        b=FjcLoYcq51S2snr2Ilcslssnto6GEdJaBf0z+HwUTHdingeeha23O0QYgXTobhlaFf
         JU2iSvSXzE//zJxb1F8iXPZM5oql9wP2K3vMLpP9/HGk1zOQy6pPIa7GT5szdhPjvAMi
         bVdvLRQSSYvz2ZaJBFW3Q7GPZnEoWAiKXfDJmAxFkB7dHexULmZtEH0oCkz/F9fREjt/
         MvAM+nVMA1IkOnvph0TWQHZJ1CZthiGn5yCeAzAqXFpe9sOjYSJ8xovI5DCl9fqLwYQY
         GQcyC2zOI+Uj4jT6d9VnPeVPnSoJ92PX3ApFPDI5bokgcJAiPQS4wyF6RK9T2leYe3Q3
         QsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=cnprQBFPVdld5o0jWafe8SbdbeovxrEKtrYLRXSG1AI=;
        b=XMbhrEvLOFX8RZKAFMNcK19zPH/hjJMXYpWKUr2ldVIRI3BmRnRfZZXdHvjggO35fv
         we5JuKCJmEW7bX80xw0uwDjZdiH+qAPkYWT3vsUw7OLf/501S8j3uDVihQYiZx1JCeAe
         QLvUeFEz2MVWUUb8Pb8Cyc0syj/eYimUen4cbro+FscnoQbjLNMUnk12kM3WIkchIxNq
         PX1PdOclXz5lez/dczhypH5D3pBpv+mPXsbwuYR8o4gwGsqyr0R9qrQnOPhOJyaQFbeD
         z88pijBH+N4fF92TtksefnydWOnkUUqd9ScEdpzbeILhD08cQyDYfCsbhZLg0LCdVH3V
         1y4Q==
X-Gm-Message-State: APjAAAX8xKQbC0kPLcE20e538Yr3Sm1l+1aTbsTcg0qUBlPLmir2Xeix
        nI5KwqCLxi61d4HGglwqRNhZAZ7L
X-Google-Smtp-Source: APXvYqzmTpZznX0vJpHTyGuXzxqvhOK8AiUaTykF0VLinKzsycpeK2HbrQGlYykAwDBWO+rfr023bw==
X-Received: by 2002:a5d:414f:: with SMTP id c15mr86841wrq.248.1566206301473;
        Mon, 19 Aug 2019 02:18:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm14956409wrx.85.2019.08.19.02.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:18:20 -0700 (PDT)
Date:   Mon, 19 Aug 2019 02:18:20 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Aug 2019 09:18:17 GMT
Message-Id: <pull.312.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] rebase -i: always update HEAD before rewording
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series contains a couple of patches to make the C version of rebase
--interactive behave more like the scripted version. The third patch is not
strictly related to the first two but is included here to avoid merge
conflicts.

Phillip Wood (3):
  rebase -i: always update HEAD before rewording
  rebase -i: check for updated todo after squash and reword
  sequencer: simplify root commit creation

 sequencer.c                        | 130 +++++++++--------------------
 t/t3404-rebase-interactive.sh      |  16 +++-
 t/t3429-rebase-edit-todo.sh        |  21 ++++-
 t/t7505-prepare-commit-msg-hook.sh |   8 +-
 t/t7505/expected-rebase-i          |   3 +-
 5 files changed, 75 insertions(+), 103 deletions(-)


base-commit: ff66981f4593aec0f3b3eeace0eacb7dbe44fd8c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-312%2Fphillipwood%2Fwip%2Frebase-reword-update-head-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-312/phillipwood/wip/rebase-reword-update-head-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/312
-- 
gitgitgadget
