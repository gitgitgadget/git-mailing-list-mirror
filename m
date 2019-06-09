Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A031F462
	for <e@80x24.org>; Sun,  9 Jun 2019 04:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfFIEt2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 00:49:28 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:35013 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfFIEt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 00:49:27 -0400
Received: by mail-wm1-f53.google.com with SMTP id c6so5252942wml.0
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 21:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZxUjrJ9hQ4U3pJ1EP4nnsq9j/SrKI5ea/tPPCnVAoY=;
        b=sIP3YdHL/y/PINSvHddxtE3sfVj2ZsKTapW5XFES5ycdM8tW8DrZaIFKD8+igyRdCj
         chiOLP67Ehj75gCHUSu1NVG+n1rbwbVVo6aIWARibsrTSA4g8lLopFr2dd1VQzaJa2bY
         tnrpWhQTGQc32P0meEC+9tdhOScy2FKHefdu3vbvEGSjQ5MEsTN0gkcjv+5Yv8B1HMIq
         Rp/yPrM1RY4YBAqt8CNN0XUm6+cNO7I7QMXYuD55VxOtNB540MCeFEVKCxzf2LD7uX9l
         rT+nc/5GyzRRa4DwVGIlmWPI/I+ymaoJVwsdGBR4UKSajycic0q4UFTCLUWf+WlxcR0K
         RbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZxUjrJ9hQ4U3pJ1EP4nnsq9j/SrKI5ea/tPPCnVAoY=;
        b=BkinyDBZHC03l0wwlIEoCCv1nCnKzhK/qaM0MmObY/c727FF5A5WaPgHbhw0c4jBZm
         xOBZOoaIS2X1o796eeXSqxkEZ2hQE7sSlbdQ5reQ8p2Fbjdiu7JzE0rKSUWwR0zx+cU0
         REuOY5zrGEjJB2VmgQHfOCYEBQrokWB43XMVwgsMo7W5RZlNQdQ7G96tZ5pzlIz0sAT4
         u+tOLi3YP9cLqySisfUc7xnEaaI+fEIxg4mcJ5paVzPN1U+zFEINcyeco4gaFOZWcrFK
         0nlnYeE1/KK+luTks22k1+qncdxXHLGImavJ6aD/WFf+3hW6H7BsOMdfDcDwmqUeFhzW
         oAYA==
X-Gm-Message-State: APjAAAUxaFO6JHcYNeBm8NesrWgiXO8An29vFbVxUw2o2kLxZe0QB0kL
        qQC7We5pY3uI2onqemWQVFFOS9Dv5p4=
X-Google-Smtp-Source: APXvYqzIvXyDBnxvY0oK7yWMzh9HpQPD5yZXauX//NjnJ7Rld3+8K0Slmiv+iK9yXpg06SmkDxvD0w==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr1399414wmc.22.1560055765121;
        Sat, 08 Jun 2019 21:49:25 -0700 (PDT)
Received: from localhost.localdomain (160.10.112.78.rev.sfr.net. [78.112.10.160])
        by smtp.gmail.com with ESMTPSA id y2sm6461116wra.58.2019.06.08.21.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 21:49:24 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] Test oidmap
Date:   Sun,  9 Jun 2019 06:49:04 +0200
Message-Id: <20190609044907.32477-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.14.g9023ccb50a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Unlike hashmap that has t/helper/test-hashmap.c and t/t0011-hashmap.sh
oidmap has no specific test. The goal of this small patch series is to
change that and also improve oidmap a bit while at it.

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
2.22.0.14.g9023ccb50a

