Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9584C20248
	for <e@80x24.org>; Sun, 24 Mar 2019 21:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfCXVzu (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 17:55:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54471 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXVzu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 17:55:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so6960182wmj.4
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Uf/H01W1lWOKpDvnapPCQkstii3bd/yopySZLMY9GY=;
        b=L+TjoOE6KXtNSggkbhXM2HZr2kObPsiJY9deddFhdXCnbDrvlVaFVOYEbFrZ154ZKP
         nL6FhxjZpkt0WgeX96tbCGcIRl/c4em8X/+X4HpGmSBqMTu0gOM3RgT3xud0YY6yeoOq
         ptEOrVP1MfFMLC/WkE84v5i1UtDDiKdQvflJFgYBrGtDomecuj74uXWVP5TF+wa59UmZ
         +tD70fZ9QvHPrqDWxYFLi661TwI2iR4GDhGfX8qtOCcSA6/Ua2Uq6J94mPjjFsx2ajjw
         TA6ZS22ozg8gwCekhjJAR5VgoCvG/c6j29z9JQkEXkUOiUoss+t7cL60DcjoyJcYOZZu
         zblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Uf/H01W1lWOKpDvnapPCQkstii3bd/yopySZLMY9GY=;
        b=fjio4vZXd2rohu4+B0wCMm4wkN1AzZhtsDFWwgCOX7YfhmkJ0Kxj1RN0E6WeGCSPaI
         finO2SX0C7UteeqUtzhTfNmmJ0do0pNbdpnN/W7WiXzen7BJWN2L4u6OLyrHzSgnuDEC
         SLLLZe1e6Ci2wC0DnfO+PK75xmfzHEdH7vHvhNqGyHNgwWUvE5gmX7HlH1WuBi4fsg4M
         64JyF7z/25LBQz5e9Vtw8SrNZkL5NtCvaZoVFgmX2CXQc7540l34Y5gjN7sTfr0Ph5Bf
         ntnlpeK96lNpM6rxBviXTeJxVphNPf2v2fQ41IwIRiaHs4dZKEg9CH+HNLYfMc5a++PA
         Rh/A==
X-Gm-Message-State: APjAAAWdBrkNlyYwte3s0fI3u0As+jvICqceyLsX0KhCLkWV6geSO4x0
        NOBYUKajezB3ENpex+dz7BGfRHRy
X-Google-Smtp-Source: APXvYqzPHSYWQ6F9/TXITBQ+XS8ujRGcR3bcBtIhICOx0WvRXgRUjv4+sOV9NNx7JLLplzVlgzFU1w==
X-Received: by 2002:a1c:1d97:: with SMTP id d145mr3283951wmd.136.1553464547294;
        Sun, 24 Mar 2019 14:55:47 -0700 (PDT)
Received: from localhost.localdomain (x4d0c479e.dyn.telefonica.de. [77.12.71.158])
        by smtp.gmail.com with ESMTPSA id o17sm15023530wrw.73.2019.03.24.14.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 14:55:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/6] Asciidoctor-related formatting and CI fixes
Date:   Sun, 24 Mar 2019 22:55:28 +0100
Message-Id: <20190324215534.9495-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190324155219.2284-1-szeder.dev@gmail.com>
References: <20190324155219.2284-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first three patches fix formatting issues with Asciidoctor; they
are the same patches that I sent earlier today, except some commit
message updates (now they mention the Asciidoctor version which
started to issue the warning, and I fixed that missing half-sentence
in one of the commit messages).

The last three patches are a small cleanup and fixes to the
documentation CI build jobs; notably patch 5 un-breaks the
documentation build job on Travis CI in the era of Asciidoctor v2.0.0
[1], and patch 5 fixes some forever-broken checks.

The formatting and CI fixes are not really related, but the check
fixed in patch 6 would choke without the formatting fixes silencing
warnings from Asciidoctor, that's why I send them in the same patch
series.

[1] https://public-inbox.org/git/20190324162131.GL4047@pobox.com/



SZEDER Gábor (6):
  Documentation/git-diff-tree.txt: fix formatting
  Documentation/technical/api-config.txt: fix formatting
  Documentation/technical/protocol-v2.txt: fix formatting
  ci: install Asciidoctor in 'ci/install-dependencies.sh'
  ci: stick with Asciidoctor v1.5.8 for now
  ci: fix AsciiDoc/Asciidoctor stderr check in the documentation build
    job

 Documentation/git-diff-tree.txt         |  1 +
 Documentation/technical/api-config.txt  |  2 +-
 Documentation/technical/protocol-v2.txt | 52 ++++++++++++-------------
 ci/install-dependencies.sh              |  3 ++
 ci/test-documentation.sh                | 15 ++++---
 5 files changed, 38 insertions(+), 35 deletions(-)

-- 
2.21.0.539.g07239c3a71.dirty

