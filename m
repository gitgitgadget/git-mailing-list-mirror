Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4CC20248
	for <e@80x24.org>; Sat, 16 Mar 2019 01:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCPBiW (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 21:38:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45245 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCPBiW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 21:38:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id v21so7484785pfm.12
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 18:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/7YvxgFhDSzn1x+hSaB/8rj42ttI4fTm9Cm8Pjkxukw=;
        b=HCiDIo5qCCfDvAGFyoClTml7FFQlyBAOPi9kGEogLgGrAZ3rt5E0z1VEPIsnIVC/EO
         RwWxfnIWmHe7m9FFDb9h2pSmtoytg0U2P4XlgfglV05qIqDZ5Pkragh4D9J/8kFAy5Db
         KxqWOjOB3kgQV+BjkpeH6ltT5vwC6yzVJiDVNnCR3F9uQbUL7+XshpV8gwLOVEyQfW2R
         AgOEDjOtFqx567O/1iuf1MUoNe4GofI6Q99miS0JZJ7Z//PAOGj+QUlsxAGISWwomGK5
         08/YNc8klBZwGeG2p62GNGEwK0GTuC6q1aXQ3dZ7z6m58/bJBA2zn2OJSBpQW4PXq7D4
         c87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/7YvxgFhDSzn1x+hSaB/8rj42ttI4fTm9Cm8Pjkxukw=;
        b=oWor63xZtCruWA+Inwr2kXYgCylvAPUGPHXzD/p8WXb8o0atMtaBNpgRyWk0kVnf8T
         A2vJ41XXrr1+pMf/Mbc/pD25HFOxQ7iBWKzX8QUSUZqe97Bd/9gnqVnrd/qmDWpJe9Pt
         Bcl/k427Xruc7YNjff75y0NXdeNNM9atc5844/VA2Vzf9rmDsPzRQAGAzrQ1ZDOb19pB
         o3/AHc1VcThWE+dfv1g1bzA1EnNWZQs1Ldkda7dZ4RkbHmvA6J2IZrjmpEWkgl4kBcZJ
         9qTehc3q+LE1mYvewfcL0VOdpl57jQqwhqgdJ2+qiQ4GdpbTXtFTWLG3jm5D7YaO+2+l
         GrFQ==
X-Gm-Message-State: APjAAAVtHH6C6/a4r8O4C2xblLo/LxIQ+jUjaVC5e5rqIq9TzoUjNuKD
        +hXfenMzwIj+T6dH2XLlgi9UaAet
X-Google-Smtp-Source: APXvYqz+zwJqeMM+GoeGH8QZmCNIgOu9xlMIy1koFR2TugZr9r6L0ZVfI91Rw6iG73QwcrGbai31Tg==
X-Received: by 2002:a65:6154:: with SMTP id o20mr6298335pgv.205.1552700301514;
        Fri, 15 Mar 2019 18:38:21 -0700 (PDT)
Received: from localhost.localdomain (173-8-128-22-SFBA.hfc.comcastbusiness.net. [173.8.128.22])
        by smtp.gmail.com with ESMTPSA id b138sm5817623pfb.48.2019.03.15.18.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 18:38:20 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, rafa.almas@gmail.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v9 0/3]
Date:   Fri, 15 Mar 2019 18:38:04 -0700
Message-Id: <20190316013807.38756-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

Cleanup on 2/3 and 3/3

To reiterate from elsewhere in the thread, I'd really like to get 1/3 and 2/3 in together.
For 3/3 I'm basically indifferent. I see some value in it, but I also think it clutters up
the verbose output, so I could understand if there's a lack of interest in it.

Also, I changed my strategy for how I updated tests that were impacted by these changes.
Instead of updating the impacted tests with the new expected output, I went back and made various
tests more self-contained. This seemed like a more sensible strategy from the standpoint
of decoupling tests and limiting scope of tests.

Travis-CI results: https://travis-ci.org/nbelakovski/git/builds/506853143

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

