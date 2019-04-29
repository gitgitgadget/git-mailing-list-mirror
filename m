Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83C71F453
	for <e@80x24.org>; Mon, 29 Apr 2019 05:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfD2FUD (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 01:20:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39066 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfD2FUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 01:20:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so4504727plb.6
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 22:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0cdNrBNtXtzs7rYxfHcFEIDPeB6Mliktr0FLTIKvWxk=;
        b=cReRv89IRBtKTa/zb1/QuxNX6MS/QvR9tB6FkT08qwCyRkDz1VRyLgnYVmTLo7uOXJ
         T5TKw3+uKvRsMbnGDUyBTFS7KcCIVhMtTYIbiellJBJor0offRrASGOitnK5iMyLRTPV
         PgyPAxh7+xwE8/Op8iV8gtqTW6r/0DpHAjWEJXBaCP8T0IoKQOL7XmfQf0y4is+t3yN7
         RxeYLCn4tGFVzueINwdw2MtVtNYkCXrxy8AreqxvDHJFiPDqmivWrhOzy/Ga3tb/Nh1u
         rCGTas5niBgM8NcLTf0J16xNIhxTUJcFfQ3R84LbVwsCRz0gMThCRvDApD9exncliHBF
         3nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0cdNrBNtXtzs7rYxfHcFEIDPeB6Mliktr0FLTIKvWxk=;
        b=ojqXzm5kpTa0v+p/Wl2g60JH2RPmbb3vgzwUp8bxMXcWQoNBO33FStymLOMPp02TNZ
         zFh3d/lZOVKpdrvF9JdAkOON0mfAY//4Qs05gNQjW4mBnOHqUJNM9fx9t3L+lxuUctha
         QCmtv88KS9x90KtPPt5eLt1meBjCZrmuzOPX0v8fTDThbG+OZWolJBIsXCJhRAYueEd9
         ApYVqO1BLW0u26tNGTyovT0tN8oUVTiJ/q84xV5UsGorfv2XpldnchZpWPrfNSOhZ2Q7
         jJ0e3PYM6Vg+DJ+XgXDgVxltbdi4iFCvSOGysUPVGDgdhOsyhYu9twgsF5ygeSg4yeGx
         z2Mw==
X-Gm-Message-State: APjAAAX5zdukZldacfRA86VzsASxWaFTkdr2x8SqHNqkDkzwS0nZLb/t
        vQMXevYEt3oTsCbF/kS4yHZO1+UCb74=
X-Google-Smtp-Source: APXvYqzekd02rCM/jPk+wjJD3PD0CW14wd61lHLbtR0QYX8Ws+kBobBp6g/lQ57n3aTG8SNMtXBP5A==
X-Received: by 2002:a17:902:9a83:: with SMTP id w3mr60749741plp.241.1556515201965;
        Sun, 28 Apr 2019 22:20:01 -0700 (PDT)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id r4sm45564843pgl.69.2019.04.28.22.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Apr 2019 22:20:00 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v10 0/3]
Date:   Sun, 28 Apr 2019 22:19:41 -0700
Message-Id: <20190429051944.77164-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Added test_i18ncmp per instructions from Szeder

Is there some other part of the infrastructure that's testing for this? Because it did not fail in any of my Travis CI builds.

Travis CI results: https://travis-ci.org/nbelakovski/git/builds/525801210

Nickolai Belakovski (3):
  ref-filter: add worktreepath atom
  branch: update output to include worktree info
  branch: add worktree info on verbose output

 Documentation/git-branch.txt       | 12 ++++--
 Documentation/git-for-each-ref.txt |  5 +++
 builtin/branch.c                   | 16 ++++++--
 ref-filter.c                       | 78 ++++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh                  | 16 +++++---
 t/t3203-branch-output.sh           | 43 ++++++++++++++++++++-
 t/t6302-for-each-ref-filter.sh     | 13 +++++++
 7 files changed, 168 insertions(+), 15 deletions(-)

-- 
2.14.2

