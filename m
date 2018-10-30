Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70A91F453
	for <e@80x24.org>; Tue, 30 Oct 2018 10:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJ3TcV (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 15:32:21 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:34662 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeJ3TcU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 15:32:20 -0400
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id HRQbg5GIzdJAeHRQhgS6Md; Tue, 30 Oct 2018 10:39:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540895964;
        bh=IuWonc4j060TkG7boODzrkcOH6FsvOVC1wgxTX52YCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=RXI6mzJVOjCCGz1ZJy3aKB4EVrXxnKSHshY/t/R1dFvWPxWkwgEDFJYmvwyik4PfT
         dRt30PwOlWBbYCmGXRJ2KdqwYTVdt1WMEfHLQqV+RoqKV+jdz8396bOtcIljZzZbUx
         l2K1Ew7vAWNZGuazp2g0SwQuktX3WR1BlvEWukQ8=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=iuGNbSBixgLDAZXCjX4A:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 0/5] am/rebase: share read_author_script()
Date:   Tue, 30 Oct 2018 10:39:11 +0000
Message-Id: <20181030103916.6241-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20180912101029.28052-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD1SEs9fZRSNd3MMjvb4kHEOB80kfXmcb5XgEPx0rAwdbdniLTHdJd6EpUwLqmHPbX7svp+4NBmdu6JZtaQAyrA1lsWMRqD3DjtrFxL8U6cAao5190wY
 CW739GCRfB7lh37SWzwNbx6owiG8H2/7YcgRcrYHMiJxYx3j8eqzVtwWulF5NfDteyIjFuITx7JLqeFey1Q//vTEvaMDv6z85N7dyutBGT9u2HdYMUgBOlQ7
 n64sIufT001iL+nEeP60mTJlCSYCXKLl6WTx1pTRx/xk3jDr38BCtzZ/gPv8DHAq3vXREyp82n5MqzE5e7WyMHafp1u5BBwlaavJhD7ik40=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Junio for the feedback on v2. I've updated patch 4 based on
those comments, the rest are unchanged.

v1 cover letter:

This is a follow up to pw/rebase-i-author-script-fix, it reduces code
duplication and improves rebase's parsing of the author script. After
this I'll do another series to share the code to write the author
script.

Phillip Wood (5):
  am: don't die in read_author_script()
  am: improve author-script error reporting
  am: rename read_author_script()
  add read_author_script() to libgit
  sequencer: use read_author_script()

 builtin/am.c |  60 ++--------------
 sequencer.c  | 192 ++++++++++++++++++++++++++++++++-------------------
 sequencer.h  |   3 +
 3 files changed, 128 insertions(+), 127 deletions(-)

-- 
2.19.1

