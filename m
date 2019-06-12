Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB8FE1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfFMRBy (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:01:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38324 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfFLXYp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 19:24:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so18659997wrs.5
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mDRR9Hub7dwX7AGu4oitDRJGNyHmPQbq0Qe0I1cB1+g=;
        b=J4uffWpq783pEXKPrAbBUhcQOM7ud0iIzTvTuFaCbQ8JKB/LbhBRbXJKK7adU4HaWP
         znLTEI8rsQXYSmSjZlRft5onsMZHfH8MT8RpY5ieu2TzGtQqFHxs+X06xsTUw77GNBmo
         EBpJoViCpVk45BYp3U9mActnsAgw2Tfid1JfChLUVLcAH4B9UZcWtq2YdueyJStYYP/G
         zeiPF9ydkywFBVYsHCR4S9+T2n4FDjWsk0xF9qTKi61kdfecaUrBLq3VTcXcfaDe2btD
         E1Ws0iCCV6M+gaNgIeHWNZvWJYm8orZ42Hz3HDJIydEazhjTJa+qh2d3OY0i0WwTxXsv
         84LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mDRR9Hub7dwX7AGu4oitDRJGNyHmPQbq0Qe0I1cB1+g=;
        b=bH5J0xOQjNuoOmC/fJrfDiNs2bAEjhBrLKgWeKJL6S3vZaGOWmWEMR3SwHDiDfRJiM
         AZmYUOifXBahlX7ttamqq1kNimV/QMteMvQBExMAEDFba9x54aKkFa1Sh/g/acnENAYc
         F3Wr7JpOL30NZKh0pmjjgFbF7+3C9o0vc7gON/Sy6AgtR8rcse/xlpj8OiyJyZZjnVSM
         fU06VeiNtkpLhyG187wFCpk93IPqO9fMG7HEq1/gFsula3EbTkp3hplYCJlm/PTx+s9d
         1SqwWeHsH1JJR1ONH0SHHMJGHnfUO/T+A9jnfHcezwwfHElP5YAGz8UgZDwN25x2p5Nf
         6Nog==
X-Gm-Message-State: APjAAAW42oOGZdqipHqeBfIJoI9ktKy/Nl4f/Na9FnfMQoZtDSc/JWwV
        K5cEGdD3B/RQT7Ufc/sl4+KdFUWT
X-Google-Smtp-Source: APXvYqzxtYPuVsrnrGbw8j7tdXpioaGY+wPOn/5+aZ8Q1AXrF4PE6dX8ML36OKIkqO/sW+rl+eh5ug==
X-Received: by 2002:a5d:430c:: with SMTP id h12mr1065687wrq.163.1560381883531;
        Wed, 12 Jun 2019 16:24:43 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1018:b2dd:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id o126sm1414803wmo.31.2019.06.12.16.24.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 16:24:42 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 0/3] Test oidmap
Date:   Thu, 13 Jun 2019 01:24:22 +0200
Message-Id: <20190612232425.12149-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.6.gde8b105b43
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike hashmap that has t/helper/test-hashmap.c and t/t0011-hashmap.sh
oidmap has no specific test. The goal of this small patch series is to
change that and also improve oidmap a bit while at it.

Changes compared to V2 are the following:

  - removed suprious space between ">" and "actual" in t0016 as
    suggested by Gábor,

  - add a space between function names and () in t0016 as suggested by
    Junio.


Christian Couder (3):
  t/helper: add test-oidmap.c
  t: add t0016-oidmap.sh
  oidmap: use sha1hash() instead of static hash() function

 Makefile               |   1 +
 oidmap.c               |  13 +---
 t/helper/test-oidmap.c | 134 +++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c   |   1 +
 t/helper/test-tool.h   |   1 +
 t/t0016-oidmap.sh      | 100 ++++++++++++++++++++++++++++++
 6 files changed, 240 insertions(+), 10 deletions(-)
 create mode 100644 t/helper/test-oidmap.c
 create mode 100755 t/t0016-oidmap.sh

-- 
2.22.0.6.gde8b105b43

