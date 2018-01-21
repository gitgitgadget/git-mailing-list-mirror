Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795CE1F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756745AbeAUADT (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:03:19 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:42779 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeAUADR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:17 -0500
Received: by mail-wr0-f174.google.com with SMTP id e41so4819638wre.9
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98By2maKTuzCmfZzinZ7sCCKM9VJ1p+/5Od3n08YGww=;
        b=KchU46iXOXKOZMIj4YqSSVTv2xROXVXnReBd4/37tGB7YtS2uzMS87J3FsfdJzxwRd
         zWO2lEURBigjWbPoqLO9SUf//EHpPULBGszqxvw5g+MNtDCzfMcRy2bq5hi0nB67CW02
         9MflM+KSw74j7I4B9kCs8L7F3hB83rkmBgVuHr09q5Lg2azml2pFzIYyel4NLbc6vqeR
         DK09Gvbqla3EOixuKjdB6255oHPK5XEGEufB6ZUsnd2zhX/v73G719MS0g1cQbMsh5ll
         cSc2FNmyVyAfq5adBBcya7Q2TpThgzVgK13nlBLhcXpWqI9MugUdqaOtsvCcN/gVIpoY
         9jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98By2maKTuzCmfZzinZ7sCCKM9VJ1p+/5Od3n08YGww=;
        b=Oln/vn/rLik67hRvzLBYbsf2W+D4i47AgrZr37+pV/TxMVfz3Ihq6ROkSbt31W5PfF
         6Wc+aM9fCv8ha6WSiR2WyGPIpaVWVJsj9HP6CFvxCCn9ooxnuBYi5Hm/gjotp4MrauCz
         nipfOVBGwUp5iEyfc6eGyFI442QTTPBwTL1COR0l96HFV59VT919zeZaX5zWPghVfOoz
         asJS76nSJb7VAdlX7kQaYp/FwWs99tacuyT/y4424459GNAkbgZkJHEzQIjFPisJ2lcF
         N9kwx6JUecCleqMTH2WXI8Oc/6vRJoiVqSSksrkE16cieR/VOX22QRp0tcW6TD/8aqkf
         7EtA==
X-Gm-Message-State: AKwxytej7dTrk87KQqDfW7NHZcvuOKXA0CpkJ7bt+2L3tcSKSbMM2qv8
        vCaz8wCpXfW4LTOk27eYawM389Xh
X-Google-Smtp-Source: AH8x225WSsjiEEorjaGf2b00RFhhpjycBl/wiFn9O8XVaROsXfyg5n2BLmHkECz5kz02N+aAxhQGxg==
X-Received: by 10.223.128.231 with SMTP id 94mr2369161wrl.64.1516492995152;
        Sat, 20 Jan 2018 16:03:15 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/12] document & test fetch pruning & add fetch.pruneTags
Date:   Sun, 21 Jan 2018 00:02:52 +0000
Message-Id: <20180121000304.32323-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now v2 and fully non-RFC, changes:

Ævar Arnfjörð Bjarmason (12):
  fetch tests: refactor in preparation for testing tag pruning
  fetch tests: arrange arguments for future readability
  fetch tests: add a tag to be deleted to the pruning tests
  fetch tests: double quote a variable for interpolation
  fetch tests: test --prune and refspec interaction

No changes.

  git fetch doc: add a new section to explain the ins & outs of pruning

Grammar etc. fixes from Eric. Thanks!

  git remote doc: correct dangerous lies about what prune does
  git-fetch & config doc: link to the new PRUNING section

No changes.

  fetch: don't redundantly NULL something calloc() gave us

Minor rephrasing of the commit message.

  fetch: stop accessing "remote" variable indirectly

NEW: Amends some existing confusing code, whose pattern will be used
by 12/12.

  fetch tests: add scaffolding for the new fetch.pruneTags

I screwed up positional arguments in the test description, fixed.

  fetch: add a --fetch-prune option and fetch.pruneTags config

Now actually works, and with a very different implementation which
involves making the previously private add_fetch_refspec() function in
remote.c part of the API.

 Documentation/config.txt        |  20 +++++-
 Documentation/fetch-options.txt |  18 ++++-
 Documentation/git-fetch.txt     |  73 +++++++++++++++++++
 Documentation/git-remote.txt    |  14 ++--
 builtin/fetch.c                 |  37 +++++++++-
 remote.c                        |   5 +-
 remote.h                        |   3 +
 t/t5510-fetch.sh                | 154 +++++++++++++++++++++++++++++-----------
 8 files changed, 272 insertions(+), 52 deletions(-)

-- 
2.15.1.424.g9478a66081

