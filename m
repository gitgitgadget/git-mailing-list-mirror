Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25591F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbeGWOwl (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:52:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35353 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388030AbeGWOwk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:52:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id e6-v6so1039177edr.2
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZC5+FijKqsdAbKAQp0d94WILvhLqTBfs08J71l8mFUM=;
        b=qyyuaqyFPNCOdtAIpuzQx8DjfScmeOkFVRnraqyiZP/FVSd/rcYQf6SWguF2PMaknL
         hAiZmtxbr9QDxkD1bTGgllttljphp7OhyPkJY01foo8mOCm9YbfS7/dhTYjWB+FX972X
         2wK/y7p7UA7P0myetk7ASQ6Xg04Y7CrKuJ+Dx7+n/4g81NW6CGgbwgF5q8AJg4/7nies
         QpJY+K2hWQfjdLF6CU7cRlPDQQo2AGCgMsds/Dny97vrfKwINR3AAX8kwF6rjklJcANH
         XwKq+75IPFOiQD0z3cVn55/A0A48xwSyOIqQws5/aviRG7rF23jKyS4UTJPHKmAnCj8v
         l4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZC5+FijKqsdAbKAQp0d94WILvhLqTBfs08J71l8mFUM=;
        b=QEjVr2wcKQL36QFDrfjdk//WuFH+WcBDdagb2fjD9WUET6kxzxeyuIBVOOrg0eVXC0
         5S4T0JnNKiaHkqkqH6RppopxjYB78lkhU0w5cdGse1k3IVXaUmURdzpSq3okOrReS4Th
         9kQu+7YSOwB+Hb6hqGkr0asNPzfARb0sCxv93XyYt//RsbWTuMe2Ox97xml6e+mPoMfB
         LXgq5xNW47DdFM2zzFsFohD1LeGTlSEd6pqVHPpGfRqD5o9zRa7QKLxlUPSQ4RDNDfMG
         Jtk/CWGk+b89sV9+BOjKOrLNIfasrLsF+0ghqA/Lkold80wpeIr143IavI3iBOHtJbef
         SkOw==
X-Gm-Message-State: AOUpUlEhb2IjeC6XZ5BhdHqIxcCdrDMechOeabb8/+J1tgPp/QPHkOd7
        xBJNT7SlgVmvsjcLNRP2lVg=
X-Google-Smtp-Source: AAOMgpcEiVrXApMm+D+ld4kqdIfMQNrQyL8/nB6p73m5ieuli33QZ21v1EIpKnfo5o2xLGHMLhEWfA==
X-Received: by 2002:a50:9493:: with SMTP id s19-v6mr14441146eda.285.1532353878495;
        Mon, 23 Jul 2018 06:51:18 -0700 (PDT)
Received: from localhost.localdomain (x590d0011.dyn.telefonica.de. [89.13.0.17])
        by smtp.gmail.com with ESMTPSA id a11-v6sm494277edn.95.2018.07.23.06.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:51:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/5] Misc Coccinelle-related improvements
Date:   Mon, 23 Jul 2018 15:50:55 +0200
Message-Id: <20180723135100.24288-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a couple of minor Coccinelle-related improvements:

  - The first two patches are small cleanups.

  - The last three could make life perhaps just a tad bit easier for
    devs running 'make coccicheck'.


SZEDER Gábor (5):
  coccinelle: mark the 'coccicheck' make target as .PHONY
  coccinelle: use $(addsuffix) in 'coccicheck' make target
  coccinelle: exclude sha1dc source files from static analysis
  coccinelle: put sane filenames into output patches
  coccinelle: extract dedicated make target to clean Coccinelle's
    results

 Makefile | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.18.0.408.g42635c01bc

