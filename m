Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 847871F404
	for <e@80x24.org>; Tue, 13 Feb 2018 13:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964922AbeBMNTY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 08:19:24 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:53376 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964778AbeBMNTW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 08:19:22 -0500
Received: by mail-wm0-f43.google.com with SMTP id t74so16041881wme.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 05:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cOQdkznpzSDenfeK6IJJ3K35qEWMM5z9+JQMu3zIDzk=;
        b=1wW3RtH9tu6upLU5aaSEVywrExhhACsgy+rALBRX1GEysOkQh6A1z2fZtEEMwQRjHh
         7goLWh8qtOntUVVPA8lfLyRKhS6Tozv7GsTUNjm9HrnbQJFF+rbyGY3lhtacXJ7mvqpb
         OXq6EoCfm0vDjZ9SbqpdHmefWvIb+egwBoBKyYAidVkh7HmBS3QPFBtwXqldsojvHyPa
         zD2dzAbNFxmDyNuueAmf5WnL0vugP0SvOYtP4rYNeL/sOUyiES1nFemBkytV39rjLmrl
         Hv725vYv/189ek3NDNkc7ZbSNYaqVR0rRBM8ftUOzgS0pZXcEdmYAFPrGA2LUcp4sQyK
         WHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cOQdkznpzSDenfeK6IJJ3K35qEWMM5z9+JQMu3zIDzk=;
        b=bk4ocEVltUWJita1mVugV8I3KCbGFRGr4f2M61k2EjLGC18OKbbLW9JQDmHW3RxpD5
         qSWaXOgmPO4NfvEMP9MBCvkjMilxQHD2+pnC6+27cfxvdd6PKeTrKG1GKnPZckEziEYJ
         ferD6YcZg4DY9iNWQKBSdeFD2eNcklyAobKcBl5lkC+gRFwnok60CZESyNCQgZdknmZN
         hJ+TB/GT4waVB/Sby0D7RSHcjLHSaFMzYHa+H+cw2GHRnCjMX0YYqKPRdHgUAARwkbdN
         /ki77mTaiEhfwSHnpCB2EE832CkO1Dc5+uvaCrccncAkRxcKCeDhfhDWF2w2HK+Bjsbz
         QdTw==
X-Gm-Message-State: APf1xPCoxljQbA9cgk8ZTySe1aBKfpP/GoDitjiXP+v8auPxSA+QrGbI
        mY9DpZvvI4edfdReFIZPJ7ZYU3StpkM+lg==
X-Google-Smtp-Source: AH8x224Wq0Dk8JNSs9VBozvwScW5jz6Kd9IzqnLV2BU5sRdgqMQwCRMt4KuZHRWmlZOTzS8BIcz9fA==
X-Received: by 10.28.36.65 with SMTP id k62mr1222227wmk.128.1518527960443;
        Tue, 13 Feb 2018 05:19:20 -0800 (PST)
Received: from ashopov.corp.uber.com ([213.208.239.148])
        by smtp.gmail.com with ESMTPSA id z81sm6541058wmc.32.2018.02.13.05.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Feb 2018 05:19:19 -0800 (PST)
From:   Alexander Shopov <ash@kambanaria.org>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Alexander Shopov <ash@kambanaria.org>, martin.agren@gmail.com,
        bmwill@google.com, peff@peff.net, sandals@crustytoothpaste.net,
        worldhello.net@gmail.com, j6t@kdbg.org, sunshine@sunshineco.com,
        pclouds@gmail.com
Subject: [PATCH 0/1] Mark messages for translation
Date:   Tue, 13 Feb 2018 14:19:14 +0100
Message-Id: <20180213131915.5707-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212151500.GA21208@sigill.intra.peff.net>
References: <20180212151500.GA21208@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following suggestions on last email exchange:

Junio C Hamano
  1. End sentences in long log message with '.'
  2. Leave final merge fixes to him based on suggestion from Jeff King  

Previous changes:

Eric Sunshine:
  1. Use 'test_i18ngrep' rather than 'grep'
Jeff King:
  2. Fix t1506
Johannes Sixt:
  3. Lower-case letters at the beginning of error messages
  4. Past tense to present tense in some cases
Eric Sunshine:
  5. Fix `-cname=value` to say `-c <name>=<value>`
  6. Do not translate "BUG message"
Duy Nguyen:
  7. Fix parentheses on `_` macro

Kind regards:
al_shopov



Alexander Shopov (1):
  Mark messages for translations

 git.c                          | 38 +++++++++++++-------------
 setup.c                        | 62 +++++++++++++++++++++---------------------
 t/t0002-gitfile.sh             |  4 +--
 t/t0008-ignores.sh             |  2 +-
 t/t1506-rev-parse-diagnosis.sh |  2 +-
 5 files changed, 54 insertions(+), 54 deletions(-)

-- 
2.16.1

