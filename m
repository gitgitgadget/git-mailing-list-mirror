Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0D71F516
	for <e@80x24.org>; Sun,  1 Jul 2018 04:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeGAEL3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 00:11:29 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38845 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeGAEL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 00:11:28 -0400
Received: by mail-ot0-f195.google.com with SMTP id w22-v6so14040394otk.5
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 21:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XS0EXOJfTh8nrcVrIh9CW96OKEw45M9T8xUcpNN1sak=;
        b=efVLoXxfghhwaXRxAWkufSpCiwJQSs5+Kh354QYIgOaWrwc+BZ10wbXg5WVf+Cxw24
         8buKP9qYTBQOOIbChemeoKGHtt7NVtQ/oGKwUDF2hneBlpLIEAl41iM3Mj7Y51CLU3Po
         xRUA0GLs5C39sls/FoQrgTYFex2u3sdHlaG+691hFsRIFy4T9Bi/mj+FKqZz9qZsDyBe
         Ojo52qX1XdNrSflhbET4kMcoHSb72r9PHqsFix4GjwmgQNW9sPy9O2Hf+Lql0+l6rbT1
         fvbpoa0FQbrphsxxBSnsKMiP99/ubjFZySWvtS0rcMtyhTpQ/Sc7enkHfsWCkQlWJQ8O
         Dg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XS0EXOJfTh8nrcVrIh9CW96OKEw45M9T8xUcpNN1sak=;
        b=Uj5JKnxgQbU+VrvIjQspaC7V/FXnbJpyuF33zvy6NhTxiu5W3Rc+sOaNyPrajlW+Y8
         9edvApN7vcQkMBTMM6unG4wAXAq5NkOBrqogirSgYmFUL7ERIgc8sH9Vcf3uycu65Dqu
         R0Jgx168DdEb5E31QhzuliytH2Oiaq4oBri7ZQ27ijbS9PmWKFMI3bGCYpODmwYTrsos
         tMmBUxE0//V9O2lnykv/UagiWPSbXXmJDS69EewwNT6LkaNjuTt/DH8qAbT0BwSmmZVg
         Bfsk+HYzk3bPCL3BCwTbDpz6JxENks5DDKSIEEAdD52ghY5bRQHAlJu1nwrFtc31G9wY
         7/yw==
X-Gm-Message-State: APt69E2Af61G3UOS0dK/DgK6C/+/dl4fGrhOFOe30m4buLunPiBcavuD
        KnwichVCWv9sMPxy/OkjnRzcZA==
X-Google-Smtp-Source: AAOMgpcY0uyPeW85P+Dxra2TILUMlllTqMcV7TyEl19DcnuIwiCvI1sg9V+gDJ/jqU4hpzfBIsBtkg==
X-Received: by 2002:a9d:b3:: with SMTP id w48-v6mr2656593oti.224.1530418287931;
        Sat, 30 Jun 2018 21:11:27 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id m3-v6sm6222677oif.26.2018.06.30.21.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 21:11:27 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/6] Add merge recursive testcases with undetected conflicts
Date:   Sat, 30 Jun 2018 21:11:16 -0700
Message-Id: <20180701041122.8753-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.130.gd703bbb5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SPOILER ALERT: This series contains answers to the "fun puzzle" at
  https://public-inbox.org/git/CABPp-BFc1OLYKzS5rauOehvEugPc0oGMJp-NMEAmVMW7QR=4Eg@mail.gmail.com/

When a merge succeeds, we expect the resulting contents to depend only
upon the trees and blobs of the branches involved and of their merge
base(s).  Unfortunately, there are currently about half a dozen cases
where the contents of a "successful" merge depend on the relative
commit timestamps of the merge bases.  Document these with testcases.

(This series came out of looking at modifying how file collision
conflict types are handled, as discussed at [1].  I discovered these
issues while working on that topic.)

[1] https://public-inbox.org/git/CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com/

Elijah Newren (6):
  t6036: add a failed conflict detection case with symlink modify/modify
  t6036: add a failed conflict detection case with symlink add/add
  t6036: add a failed conflict detection case with submodule
    modify/modify
  t6036: add a failed conflict detection case with submodule add/add
  t6036: add a failed conflict detection case with conflicting types
  t6036: add a failed conflict detection case: regular files, different
    modes

 t/t6036-recursive-corner-cases.sh | 451 ++++++++++++++++++++++++++++++
 1 file changed, 451 insertions(+)

-- 
2.18.0.130.gd703bbb5d
