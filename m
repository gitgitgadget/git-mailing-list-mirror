Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9091F731
	for <e@80x24.org>; Mon,  5 Aug 2019 21:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfHEVEz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 17:04:55 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36500 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVEz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 17:04:55 -0400
Received: by mail-wm1-f49.google.com with SMTP id g67so70216849wme.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Z/MTND0ER1A/A2dXtGSsBooZN5BVgVFEqkR0K0yLwE=;
        b=p8cAPok7yYa8iUpN8Ed/S+nE8AFfGt1VAXpsAh2XHIsBjHZxaLiEAo9Cazg8wXAes4
         r+F2CMzKOywyYaFwq8XPk+DBnYHHNFPMwgvch2Wg+UkvwYm0J10QBxq2AauRoVurOxyj
         Z1GORMyO6BovGdEPVwc7AK+BUUplgF5oZFkJx4AsAnvhc9oT31sy58Yco3XcZMl/GVPJ
         S6owOt5suuudQ1sAIgRBs7tfoSvD76dB3V2Borip4tkiNqR0dFdgXcWuNb/eZEYM7H56
         9znnXFRUkXxm8etCVK/h3PA2cwGq0xa8GSACwWj4eSK1XnD1zrv58OKn2Zg/+mOhUBd0
         hyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Z/MTND0ER1A/A2dXtGSsBooZN5BVgVFEqkR0K0yLwE=;
        b=bMqNCUoDP1dS1aX/1nU/XNRm6M1Vnr3wd3rvM+oPcGVMAUlMNoUmG16xpxRO8duhgA
         xIC1Y2HmUPpdYCQwJ3lEbgsFn95Bfa87VgpQm4PsfjD98MH10vTrh+nhkVcxEVzKdS67
         isen+btM88nRgXXotXZVXXXpGFuicKKDmZJKeqDV7HQedrAc8KoeBU/TJyBKZVCTfWEm
         W0M43imbhDlrtzcc54EziHpippevoA9EUb3v1Emkd5VSdmAGsKHutZ8tuI7GptkUhBqV
         4/KBtSW9Sj3URVrh4kAvuEZkIewNVAUSuA08Vn4KBvTEaWurYz3c0/1b1FAa3imlZTgT
         g9jQ==
X-Gm-Message-State: APjAAAW/56lHos88WdX4kUVoFV3urWNZqI3YeRS5Uf21hW+yi2LWQ47E
        YzAli1y755AQIrrr1O4Ztck=
X-Google-Smtp-Source: APXvYqye1Eh8a2jQyTsycidXPLIzu25UHek/v74fxW66upizGJc1I1yMCO6wLc6ioxmD6UmYvCYCOQ==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr203927wmk.55.1565039093601;
        Mon, 05 Aug 2019 14:04:53 -0700 (PDT)
Received: from localhost.localdomain (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id s12sm82312179wmh.34.2019.08.05.14.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 14:04:52 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/2] tests: show the test name and number at the start of verbose output
Date:   Mon,  5 Aug 2019 23:04:45 +0200
Message-Id: <20190805210447.7169-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.309.g896d8c5f5f
In-Reply-To: <20190803080126.29488-1-szeder.dev@gmail.com>
References: <20190803080126.29488-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include the test script number, test number, and the test name at the
start of the verbose output of each test, to help navigating the
tests' logs.

Changes since v1:

  - Include not only the test name, but the test script number and
    test number as well.

  - An additional small adjustment was necessary to 't0000-basic.sh',
    which I thought is better as a separate preparatory patch, to ease
    review a bit.

SZEDER Gábor (2):
  t0000-basic: use realistic test script names in the verbose tests
  tests: show the test name and number at the start of verbose output

 t/t0000-basic.sh        | 20 ++++++++++----------
 t/test-lib-functions.sh |  4 ++--
 t/test-lib.sh           |  2 ++
 3 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.23.0.rc1.309.g896d8c5f5f

