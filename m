Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070381F42D
	for <e@80x24.org>; Wed, 30 May 2018 21:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932430AbeE3VHA (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 17:07:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37005 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932445AbeE3VG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 17:06:57 -0400
Received: by mail-wr0-f193.google.com with SMTP id i12-v6so30911075wrc.4
        for <git@vger.kernel.org>; Wed, 30 May 2018 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eH7wlyT5CtQlwFdCjK1XPtmwA4YsWLRGIgmB5V0zC3o=;
        b=nNKje9S3eXqne+JFoK1f/G/yECShEgzJZdEBrKCrVAttohtbH4UM5OR9dt+N8M1vGl
         0FfRb+qws4r60ubarwFTvzgBxv5rQOJt5jt3GynZ9GDcn3CxtIXD+0fHxvxzZNxFx9vm
         Nfm6gabWZDi8k4Xr3TFJuyGYgGXR7iVWGgd1u/j+eUIixV+vdgaNaOAfdCJ5f3K1oGl7
         8rLHOqfXrL0ePlzUjRPrWbmFg8dxEdKvikJQwgGUNyldtLvgP/y89KDffZnjs3+otQUE
         X9/7qGNhqIaVbwccj/C9pkYqTQ99rpszYPwiNuwMmM7wWvTOJDgpIdA/mbH9bka/xObS
         81ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eH7wlyT5CtQlwFdCjK1XPtmwA4YsWLRGIgmB5V0zC3o=;
        b=GV9coYTYrIOg28pKrEtZdZ8+sE329yWvnY7wX6aXWj1nTrQnFLzbo3iMjlRySfj0ye
         vPjai6W3P7ZwqiUOlf/rIIpMXfW2w+t3loMv2HROkpXrzqMeNz63HULeaXDa16d+1Joy
         2tWbZBWHUkyUcKFQ9L5YpoRNNOET4/sHc0pKHp4cSwuyBIRWrLWpykJYapWNO8fCYpMg
         fMG4171XQF2hj/eAH/T9A7302Hd/2m08saQ0OpiQm6SjxrMDMjy/GBjh4XqfMIxEpZyW
         Mt+yUFE/GTAgcF/lt/Naj84+AS8cvlZewFirCxsRpTEZ8p8e5jqbnGRI5DiJwhlyjH1h
         ShCg==
X-Gm-Message-State: ALKqPwfFXZryqMIP5JSI+ET+RfHMrlCYVlmTYAmb7njGBnBDzgZ5r8OI
        F9+6A8p6AS4upnl8xkxILKc3u/Oz
X-Google-Smtp-Source: ADUXVKJ1qkJ9e9MnDvvzk9eD5WYswDRTx886/Ua9dtKU/+lNz9HaIN9WNUP95ufXnYJa5nybfKkUag==
X-Received: by 2002:adf:e94e:: with SMTP id m14-v6mr3321856wrn.126.1527714415869;
        Wed, 30 May 2018 14:06:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o16-v6sm18237097wri.67.2018.05.30.14.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 14:06:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] color.ui docs & add color.ui=isatty
Date:   Wed, 30 May 2018 21:06:37 +0000
Message-Id: <20180530210641.19771-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I started writing this for the reasons explained in 4/4, but the
justification there is a bit of a stretch. Where we'd realistically
like to diverge color.ui=auto and color.pager=false, but since I wrote
it already maybe some people will come out of the woodworks telling me
that this is what they've always wanted for whatever reason.

Maybe if we don't like 4/4 we should take 3/4 because we might want
another such option in the future, but that's probably overly hedging
our bets, still. I really don't like this pattern that we have a
multi-value config option that dies instead of warns on unknown future
values, so I'm leaning towards saying that should be accepted to git.

But while I was working towards 4/4 I did some nice fixes in [12]/4. I
think those should go in regardless, so they're non-RFC.

Ævar Arnfjörð Bjarmason (4):
  config doc: move color.ui documentation to one place
  config doc: clarify "to a terminal" in color.ui
  color.ui config: don't die on unknown values
  color.ui config: add "isatty" setting

 Documentation/config.txt | 100 +++++++++++++++++++++------------------
 color.c                  |  25 ++++++++--
 color.h                  |   1 +
 t/t7006-pager.sh         |  31 ++++++++++++
 4 files changed, 107 insertions(+), 50 deletions(-)

-- 
2.17.0.290.gded63e768a

