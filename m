Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AAE31F461
	for <e@80x24.org>; Wed, 21 Aug 2019 18:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfHUS3w (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 14:29:52 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:56992 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfHUS3w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 14:29:52 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 3EC9B80A51BB; Wed, 21 Aug 2019 20:29:50 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id 3003380A51A3;
        Wed, 21 Aug 2019 20:29:47 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:45970 helo=ben.local)
        by ferret.domein-it.nl with esmtpa (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i0VMd-0004zl-PT; Wed, 21 Aug 2019 20:29:43 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Wijen <ben@wijen.net>
Subject: [PATCH v3 0/1] rebase.c: make sure the active branch isn't moved when autostashing
Date:   Wed, 21 Aug 2019 20:29:40 +0200
Message-Id: <20190821182941.12674-1-ben@wijen.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820201237.10205-1-ben@wijen.net>
References: <20190820201237.10205-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i0VMd-0004zl-PT
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have done some more tests on what's actually going on.
The active branch is currently reset to master (before the rebase)
The confusion was because of me naming the active branch 'upstream'

I hope this clears things up...


Ben Wijen (1):
  rebase.c: make sure the active branch isn't moved when autostashing

 builtin/rebase.c            | 18 ++++++------------
 t/t3420-rebase-autostash.sh | 16 ++++++++++++----
 2 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.22.0

