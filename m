Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BE11F461
	for <e@80x24.org>; Sun, 18 Aug 2019 10:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfHRKCn (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 06:02:43 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:37633 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHRKCn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 06:02:43 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Aug 2019 06:02:43 EDT
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id EE656807B737; Sun, 18 Aug 2019 11:54:58 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id 3BC1F807B726;
        Sun, 18 Aug 2019 11:54:29 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:58670 helo=ben.local)
        by ferret.domein-it.nl with esmtpa (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1hzHtK-0003zc-1L; Sun, 18 Aug 2019 11:54:26 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Ben Wijen <ben@wijen.net>
Subject: [PATCH 0/2] git rebase: Make sure upstream branch is left alone.
Date:   Sun, 18 Aug 2019 11:53:47 +0200
Message-Id: <20190818095349.3218-1-ben@wijen.net>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1hzHtK-0003zc-1L
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found an issue with git rebase --autostash <upstream> <branch> with an dirty worktree/index.
It seems the currently active branch is moved, which is not correct.
The following patches contain both a test and a fix.

Ben Wijen (2):
  t3420: never change upstream branch
  rebase.c: make sure current branch isn't moved when autostashing

 builtin/rebase.c            | 18 ++++++------------
 t/t3420-rebase-autostash.sh | 13 +++++++++----
 2 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.22.0

