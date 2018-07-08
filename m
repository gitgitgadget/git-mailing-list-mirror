Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E79C01F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 14:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeGHOoK (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 10:44:10 -0400
Received: from s019.cyon.net ([149.126.4.28]:51606 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754098AbeGHOoH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 10:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5qrPnOIX6rmX2Yo4pQ/Y+84YmzrdnMR81gHmNcXfh+w=; b=ILQfoT76QSiaaML+d3C69cWLz0
        5ILqeBVERB039gPW1Uo77TomKbD00GtuE1Nh6esKnwncQHlPuTDPNfBbXQ2WKU64DhraZGwtCwuw0
        BdcFKPxciDl+YoAkUcx9eWXIkWDXZGmu89zYpaCfulhADqQYNq39E2uBkMIe5CeloiFlNmjl7cFm7
        srG2kskT/V9Btiz4CYSEWsu0h/QuU3c9OxV/o9jyKT6PGJhJsVSo1VCn8xJTQLZ6qW1LJx2g6lnXp
        S3RTsDN9Lv8FL75I3sIklu6blOewlZWWFnCPYeNQdwBNz9tNedjWzXD21qJnipPdn852wwIRMgI4W
        M+H2If5A==;
Received: from [10.20.10.233] (port=6778 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcAuz-004haE-2S; Sun, 08 Jul 2018 16:44:06 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id D081320524; Sun,  8 Jul 2018 16:44:04 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [RFC PATCH 4/6] sequencer.c: avoid empty statements at top level
Date:   Sun,  8 Jul 2018 16:43:40 +0200
Message-Id: <20180708144342.11922-5-dev+git@drbeat.li>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
In-Reply-To: <20180708144342.11922-1-dev+git@drbeat.li>
References: <20180708144342.11922-1-dev+git@drbeat.li>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The marco GIT_PATH_FUNC expands to a complete statement including the
semicolon. Remove two extra trailing semicolons.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5354d4d51e..66e7073995 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -62,12 +62,12 @@ static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
  * The file to keep track of how many commands were already processed (e.g.
  * for the prompt).
  */
-static GIT_PATH_FUNC(rebase_path_msgnum, "rebase-merge/msgnum");
+static GIT_PATH_FUNC(rebase_path_msgnum, "rebase-merge/msgnum")
 /*
  * The file to keep track of how many commands are to be processed in total
  * (e.g. for the prompt).
  */
-static GIT_PATH_FUNC(rebase_path_msgtotal, "rebase-merge/end");
+static GIT_PATH_FUNC(rebase_path_msgtotal, "rebase-merge/end")
 /*
  * The commit message that is planned to be used for any changes that
  * need to be committed following a user interaction.
-- 
2.15.0.rc1.299.gda03b47c3

