Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FE591F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759336AbeD0VkN (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:40:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:47977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759330AbeD0VkM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:40:12 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MXDo1-1er5zx2H5B-00WGmV; Fri, 27 Apr 2018 23:40:08 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 08/11] filter-branch: stop suggesting to use grafts
Date:   Fri, 27 Apr 2018 23:39:57 +0200
Message-Id: <800556a8d34896b7fd8876cda90846ed5b994d02.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:mkXMDIBK7kRlbArp4mVVJZvXHKd+DoEaIXxJ8zCcn1CMgzVcjK5
 8tRsVXgMFcbYLA+W6dG/1+LaSObbN80bA1THYJkqNKNw7rzf/sEvuH/3X2Lz4TQ32vYdvuF
 tdUu1RsoJRoTfckQZvCJ/GArMlttXE/dxLkJiurDLCleqjmw3kdj/0ACAwAfyAVQsgrzBxQ
 86/3wP40C2NPXVYMc/swQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j/bJzyL9vP0=:7NaFk4PV64onvLiWtkomM5
 mCVMzWiwVV2Jls50BvP3vJlcOJF8skAYtegyOdsF1zmSDTgH3KKGEv54Jtq+062Q+6uRxyXFb
 s1Fn6KiNWsZoA59cJR1Qg90i0F34pyHs3cH15VaOsoanSowsZR1hk/ZymkRhZtXbvzJeIOHVs
 uYUdhAduwg3loDfL1i4DZN8OGuafbwvClmE4dxYV2J5h0Ms04qmQxeP7+LZgDg46u4a+D4Iuq
 bGqzoMlHTgfOeYNVD4GsV9ZRLYCHNNH6aDezgQh6Rf9hi1WOKuOQ0gnZK+5ZysJXdYakWng2w
 Bl1aVE+FghuF22vsRPvjNOnQdTYo6f3g/8RMW4gy6hs1KAUU17OAW1kvUEJH3Io58Iv4B0xf7
 b0doXA4nyo4k3Zr0dzZnBFvhgNtbC6uUAgqxqoRnBRlk+PO3Tz6pPO8nivPg1hiMVNFsFyMiU
 bUu5u1Zj0X3TAUoBD7jFp8oNRuWVzR3v0EJijlnidLaZnb6mj0O1WacBJBIh0/UPuTuJAUXdC
 cg5RbaenhIiZOS8+41PMj5fl3yNoyLYBF9vo9jHtzs/cOpGzFyKHkhE549W7bBpXYa1o69mZp
 NRad5Ppe0dopCPj7DDs5H8dX2Leo2CTG3tQUA9YkSkoDQTIxIZGtYyhXxQMIkqphQ8/Ri/YQq
 Z/kY0ex8xJ5mpoT1DcxuQEYGD0PrSzFc5fl64m4I23VxQFkXy/NYQzYAScprnUl4VuNF49qsE
 MMY4wDNjv7tK9B0ZhStO2khmfTZLfFjiHYCTjIcMRLbkQJehEA2rsrMWIXKW6NnLUiKjcACYx
 1RBckwH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The graft file is deprecated now, so let's use replace refs in the example
in filter-branch's man page instead.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-filter-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index b634043183b..1d4d2f86045 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -288,7 +288,7 @@ git filter-branch --parent-filter \
 or even simpler:
 
 -----------------------------------------------
-echo "$commit-id $graft-id" >> .git/info/grafts
+git replace --graft $commit-id $graft-id
 git filter-branch $graft-id..HEAD
 -----------------------------------------------
 
-- 
2.17.0.windows.1.33.gfcbb1fa0445


