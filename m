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
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B761F462
	for <e@80x24.org>; Sat, 15 Jun 2019 10:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFOKHa (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 06:07:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32881 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFOKHa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 06:07:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so5002743wru.0
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Lotp8Pc5FffCJgoMD04aIZac1pYiA41GCpazV/VBRk=;
        b=lXUYVZIyIia+Fb2Ht66Sb3E4z16+HY1giJ+AQRMztYvxQsfHTL7KpznbNygqNyPoX7
         y+eDpmtetYxCbQ/bAbvs/zgxYC8eNWWkXhbOuzJXAQNssSi4pR75SasdvSJz0pzxMOfX
         V6Ja71IL4VcmGOJxp4bznwLiMTAfC60XkjTuUz4gQYspJrNtnTrM3BUdyDyjrS/SxvX/
         FkSSaKobnaj/K7GQyubnVKnRgNbvCcmYAupG02vDgGpq7hQRpn3dRTNZX+M7OT86OGVw
         7SZprw/dUUr480SWjhRBWKlIscd2LO9AmCLrh0QqpFJ/z+sgNIyJKmDPyvn4nWudtqUk
         Vakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Lotp8Pc5FffCJgoMD04aIZac1pYiA41GCpazV/VBRk=;
        b=ocffMDaWnuqr0E49WWPs/KjfRdbFCnsHB8MQ1KfWJo9ObBtr+nIXJB+9ujibZeik5R
         TkCGmjXL/vfo5fiKrTyAZahOR98wj6kqyaWOi1oKXC9aFPYwJC8pieeDMdxgxNlhn1ot
         I2Co5CpQYy7cCeosRXc+7LfAhbF7IrQoxB0S5BHTKtJdgama0vKcyBRT+Kye5Q8YOFgJ
         xRU4lVIM1n6R35PUcUTg7P5uq7YPgAAj3cn+11ihf1VD4lJZf4e4jYezweisInY29DFY
         jIowpxmsq2lqgcNr0ozomgaboDebHPnypzBFy/Txob+KITcijfjLkmMh+UR3Hkw6pgoL
         W5cw==
X-Gm-Message-State: APjAAAUN5noCk3kjKp5mUpr2YXR+8ZCiU+Pr/i7heRsdSfMSdJ7Ye/0L
        +oyMSpxwu/HA1UoQNewddUd87p0TyZU=
X-Google-Smtp-Source: APXvYqzgaCkugohvTutAHR/BAY0GPXTjpBHZkIBqQM1tT+Ycd15IBE2DuGtmJLbqDRklO8Ot48VgWw==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr2152390wrv.63.1560593247724;
        Sat, 15 Jun 2019 03:07:27 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1017:d205:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id x11sm8091576wmg.23.2019.06.15.03.07.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:07:26 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 0/4] Test oidmap
Date:   Sat, 15 Jun 2019 12:06:58 +0200
Message-Id: <20190615100702.20762-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.3.g82edbe9b01.dirty
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

Changes compared to V3 are the following:

  - removed "hash" command in test-oidmap.c and "hash" test in
    t0016-oidmap.sh as suggested by Peff,

  - added patch 4/4 which does the same as above in test-hashmap.c and
    t0011-hashmap.sh as suggested by Peff.

Previous versions on the mailing list:

V3: https://public-inbox.org/git/20190612232425.12149-1-chriscool@tuxfamily.org/
V2: https://public-inbox.org/git/20190611082325.28878-1-chriscool@tuxfamily.org/
V1: https://public-inbox.org/git/20190609044907.32477-1-chriscool@tuxfamily.org/

This patch series on GitHub:

https://github.com/chriscool/git/commits/oidmap

Christian Couder (4):
  t/helper: add test-oidmap.c
  t: add t0016-oidmap.sh
  oidmap: use sha1hash() instead of static hash() function
  test-hashmap: remove 'hash' command

 Makefile                |   1 +
 oidmap.c                |  13 +----
 t/helper/test-hashmap.c |   9 +--
 t/helper/test-oidmap.c  | 126 ++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c    |   1 +
 t/helper/test-tool.h    |   1 +
 t/t0011-hashmap.sh      |   9 ---
 t/t0016-oidmap.sh       |  84 +++++++++++++++++++++++++++
 8 files changed, 217 insertions(+), 27 deletions(-)
 create mode 100644 t/helper/test-oidmap.c
 create mode 100755 t/t0016-oidmap.sh

-- 
2.22.0.3.g82edbe9b01.dirty

