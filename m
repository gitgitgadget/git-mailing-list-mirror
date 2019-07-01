Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1738A1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 13:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfGANLy (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 09:11:54 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:37610 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfGANLx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 09:11:53 -0400
Received: by mail-ed1-f46.google.com with SMTP id w13so23495089eds.4
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ruur+/O6JkPy0nIB4FrEAxZRuQLCy60uPo/USYw7ofQ=;
        b=WDRXuLgKYLUKarqCpda58drfG8jsFyWB71voaKMNxfwHSk6i2Ars/DQyJMqofxYGBW
         ws3tHKvWswb4igap2AFzwx9UwmewKAR7tVwKk0pZX16vutVeciz9uI/0movaCrDEO3QK
         f1WopiGygDuvdJcAUx1QXOTV5TbaZIx5jFPIIApiEKw0nv8ISbVUBrHCk6Vf9Y0tMyS/
         PfHT6iGRBPV3MTLd0RqKd1z3R4jHqrZKrbKQOopu+tvFMGIQsvccIzkn/Jzj7Dwk6xEP
         4L9i+phlcAYkqE8KtIxNhp/vtYMz1HgEJlUBsxm4Z1qfduoW5Hr60YlrG9Oy4IAm9Kja
         PMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ruur+/O6JkPy0nIB4FrEAxZRuQLCy60uPo/USYw7ofQ=;
        b=IYv7RqSjramdA3aOEtY80Fn0dzFtMcuekpMjMbUVLFt7+YitNH5v9kg0obCzs294zw
         1jZlUEhXS+rBQjm/78/Y7eUEOpbpNYzk+sm333go3C0VAsToA+l1KUBPPc2Re00CJnnc
         7oQnXWx3lkQUN0dAIpC4Bcm1M9P4s8vEYHZ71SHy2K7wL/xi6jU9DUPJwWuDYWNmNzX1
         EuZQ9J84ku8CN8V/aRxPwa7dH5oK9YeNLH2jUFQz0zBikJBRiQEeuxJqHd5MCHmaIqLD
         h9OQhM66YNXukoc956e0F/bD7s3L3dlrWAvuK4E7HmjbFuS2B6GU1IPHBOSJBPngrYKF
         864w==
X-Gm-Message-State: APjAAAVNY7zovpnYi825MTd9iThlhBadr9o3/XNe8t/Fted3dUSAAKgf
        n5EqbA+hkYVnjRKpWxHY0zQ4n33O
X-Google-Smtp-Source: APXvYqzFh8KRQy4po6ZPTFSLHk1OAroDdYyhwtnJv/UGBewAyPPmiInGtFCRJVvZQtUe3QKzBAwZPQ==
X-Received: by 2002:a17:906:b243:: with SMTP id ce3mr22595419ejb.176.1561986711919;
        Mon, 01 Jul 2019 06:11:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm2176054ejr.61.2019.07.01.06.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:11:51 -0700 (PDT)
Date:   Mon, 01 Jul 2019 06:11:51 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 13:11:49 GMT
Message-Id: <pull.276.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] t3420 remove progress from output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove ugliness in the tests that check the output of git rebase

Based-On: sg/rebase-progress Cc: SZEDER Gábor szeder.dev@gmail.com
[szeder.dev@gmail.com]

Phillip Wood (1):
  t3420: remove progress lines before comparing output

 t/t3420-rebase-autostash.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)


base-commit: 5b12e3123b7b70e3875404a4ffe571ca079364fe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-276%2Fphillipwood%2Fwip%2Ft3420-remove-progress-from-output-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-276/phillipwood/wip/t3420-remove-progress-from-output-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/276
-- 
gitgitgadget
