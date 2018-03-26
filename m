Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FB71F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeCZS1Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:27:24 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39586 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCZS1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:27:23 -0400
Received: by mail-wm0-f41.google.com with SMTP id f125so17172668wme.4
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbTGFtlIp9oZdXPhzSf1MKHET/VpsUKPWT5cdTVh/00=;
        b=FkORdzRyqyVBAWHoTFQzsSBfRYNTvIlr1A/Huqn4mekPXBHjps0oq/l/+n6QjAoDek
         vELgF9PNSHeuLvdA5lxos5I6gf4hZqW8gPuaNmZtL52KtQpIWoHuqz5CMv1+uMa2cIU2
         HLi4sjFLfwd19P7T4T7p6nL15QAdG6F85JWkrbM/R6yqAU5i/6oEcM2Gme9eY3x533fq
         lsPYIuIbKWgiIx6k/wv144Jbj5NCLOpd24ISY8a4hFGd1WXvwUyyYm8b6y8O/2Yob/7a
         o+XpFWyrDbw8Mp0MtuT3fm9dezFPia5CDR3ZxjIgibEHGTzDpCg4/H/rDjOl1EuB91ZC
         GSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbTGFtlIp9oZdXPhzSf1MKHET/VpsUKPWT5cdTVh/00=;
        b=oCv+rDk+QrAfarS6qRzQSrLDIJ0R/QfyGPOlqj3DoqoCaCtvlFYquo3hPeY52tFcdp
         XNUXV0RBmXn0wJPodKyRI+VIlr8jFqDwm1GOkBaSLeupDZJ87hPeRB/q+o64srjXxlpg
         kwUL4AJ8FLZUbjRkXTY4pPd/LyA2ISZIXt5hJIGCoWfh9KV0GzCTCdbZMHCVGykKYjVu
         ORYUw7krPA2nanO6p8kpymk+DrIkyGyUt19U001BjK5DxtnRA5kwYwWiBytpzPknSZn1
         Crzqz1plihQKVfzVePycHPXLqDbQ76jk2NjjVSUIYKBT51CP5ntK31wR65s6L+ejqYrs
         mJAg==
X-Gm-Message-State: AElRT7HlEQN1oOap8OVyX0jK2AmasSB/VWmwEBGPQ2cv0loTveZy7K4f
        w1DdEd0jFrmT2D2V51lf+ZIF+ZuQ
X-Google-Smtp-Source: AG47ELv1WYGZ/o3oTXcaYdDw/wN873+w7GW6jh/RyAQAuh9U4Fqz3J1AWmFMJn/8OAqpprSLdZW6Bg==
X-Received: by 10.28.4.216 with SMTP id 207mr14746958wme.99.1522088842364;
        Mon, 26 Mar 2018 11:27:22 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b13sm19085852wmi.42.2018.03.26.11.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 11:27:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Dan Shumow <shumow@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] doc hash-function-transition: minor & major clarifications
Date:   Mon, 26 Mar 2018 18:27:06 +0000
Message-Id: <20180326182708.26551-1-avarab@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Having read through the hash-function-transition.txt again, a couple
of things jumped out at me:

Ævar Arnfjörð Bjarmason (2):
  doc hash-function-transition: clarify how older gits die on NewHash

We weren't accurately describing how "git status" would die on NewHash
repos on new versions.

  doc hash-function-transition: clarify what SHAttered means

I don't think we had a good summary of how SHA-1 vulnerabilities
overlap with concerns Git has, now that we've moved to the hardened
SHA-1.

I may very well have gotten this new summary subtly wrong though. So
please review.

 .../technical/hash-function-transition.txt    | 40 +++++++++++++++----
 1 file changed, 32 insertions(+), 8 deletions(-)

-- 
2.16.2.804.g6dcf76e118

