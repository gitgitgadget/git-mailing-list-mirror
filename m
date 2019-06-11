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
	by dcvr.yhbt.net (Postfix) with ESMTP id C92501F462
	for <e@80x24.org>; Tue, 11 Jun 2019 08:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391234AbfFKIXt (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 04:23:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37718 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbfFKIXt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 04:23:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so11921654wrr.4
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N69a6q2/dUXjLk/3584TjshaPm3APJNdu0d8g9p6JaU=;
        b=mcHlHcoNROGKlAxOVZ+yDGtk4VCZ5Gy+eauV4N6bIS4n1wuc00fGO2Ds6l1JLevt2p
         g1a2uzltS5viT9y+5QtE85fzGlrHzT7zWfPJGBQFXoqgPVmff0hKR7E/xjxu17xtEQHV
         aQUpjn2Zv9pwBpwmJK2kBu52Hlkw2H2o9tz6myIZQCBm3AI7lvv5uy+8HJ4Mc015xMGz
         7VG0nU+CNJjrNOGYxkUA5bzbk+7Hq0RjRGFLSvasfyd8BmZPEyMd0spULh3H5NGRwq88
         r06vOMkfV+K8ZFoyvMTFpvFqN3+wC11Ip/ThPNfy+etKku895s5r/e7K+rUtGqQBsOyC
         RUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N69a6q2/dUXjLk/3584TjshaPm3APJNdu0d8g9p6JaU=;
        b=bnLTrLkcWb4rxRCWgP9K34FKbg9NdmbErJE8JuLMEEoKyhQUD9WKe3N496txKc15n9
         H+WaxpxjDcwWa7hHJ0iCMysEasQh5PHENqJRSFvtn+hR34IImG2Ou1zDX+Wu3e+1+Mlr
         2z+hf/Vog2rWh1DzA4h8jcX6fDa3la4Mc8bZABKaAR8Zmn6QBFYII3z8FCX3foFHyCp2
         ob09sdV9rgIaNyT9U5UW09f2za5uOOYI15fv+3GhHEzLebbCwcedJNV+3jmV4hUb+rzm
         X7LqNPSz7ODjheJLh6wyNTgFVsH4xqlvWf98z+glyei0CVtoCt+IPx5X8Y4nEF7onnuy
         Z0Rg==
X-Gm-Message-State: APjAAAUg4fwRUeCpSMyiXLhjV8dhxlql84JtiJq8xdsm3LxuJm3c8Zc4
        NWpHSo4uc3t3G4aYShjTA9ukTHah
X-Google-Smtp-Source: APXvYqyRbOB+o8Xzj/XtFsFi7ixabrI0MYVvFwfkrMvNhfr1990NE9KuK2z/+eWwQLE3uOgOHj3f0g==
X-Received: by 2002:adf:dfcd:: with SMTP id q13mr20374555wrn.234.1560241427343;
        Tue, 11 Jun 2019 01:23:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10dc:b342:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id o126sm2837350wmo.31.2019.06.11.01.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 01:23:46 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/3] Test oidmap
Date:   Tue, 11 Jun 2019 10:23:22 +0200
Message-Id: <20190611082325.28878-1-chriscool@tuxfamily.org>
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

Changes compared to V1 are the following:

  - use printf("%x\n", ntohl(sha1hash(oid.hash))) to print hashes as
    suggested by Gábor and approved by Junio,

  - use `git rev-parse "$1" | cut -c1-8` to check hashes in t0016 as
    suggested by Gábor,

  - removed PERL prereq on "hash" test in t0016 as allowed by the
    above change and suggested by Gábor,

  - removed suprious space between ">" and "expect" in t0016 as
    suggested by Gábor.

I decided against hardcoding values as I think it might help
transitionning from SHA1 to SHA256.

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

