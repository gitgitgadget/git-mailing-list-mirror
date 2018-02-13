Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF551F576
	for <e@80x24.org>; Tue, 13 Feb 2018 10:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934165AbeBMKoY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:44:24 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:53859 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933966AbeBMKoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:44:23 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id lY4NeT0Dyr5N9lY4TeMF1a; Tue, 13 Feb 2018 10:44:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1518518661;
        bh=ZnVg61iryWl+uhlXSsgqQU9IVh7qEiol4w6ONk2ljZ8=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=ZdQzsm108UiEpdrtfIY1gj2bJ7iMO7VEtsSc3zsjNiOm7yfBu7NcBi+P1mQIDc2MV
         GPmWZajt9lDVw+gY9QwvNroWOC/bwIDGtFPfqpcw3eSItVXwWqlh6d4Kp0RWp2V4cL
         CUQF9dPXI+z71L3w3YoiaTSvsllxeqAXtw6Ea+b8=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=M9M9E24s c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=oUfm92HklYXWJ16obvEA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/4] Correct offsets of hunks when one is skipped
Date:   Tue, 13 Feb 2018 10:44:04 +0000
Message-Id: <20180213104408.9887-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfDjkD0JQTKcmM3xDu2LodyM4UfU3hF3V4WRqrz5SgUqd6Dq46Gk5vKbgmoQmQLoEjcohXnM6fiPOS3eOd/D2hlL/oc1T3hHfmxdaXqIiSdHbsGZ7NrGq
 fcBla4BByPaDYHIDlQ2CHaUxwMlDbipaadsq9Thg99gzl3TMX+hQm5kH6RXRibba03sLwRt4dIn244+9/TTOwPnrLta3aN64gu6T/MVnNbvZ6nM0nvYk5Ftj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

While working on a patch series to stage selected lines from a hunk
without having to edit it I got worried that subsequent patches would
be applied in the wrong place which lead to this series to correct the
offsets of hunks following those that are skipped or edited.

Phillip Wood (4):
  add -i: add function to format hunk header
  t3701: add failing test for pathological context lines
  add -p: Adjust offsets of subsequent hunks when one is skipped
  add -p: calculate offset delta for edited patches

 git-add--interactive.perl  | 93 +++++++++++++++++++++++++++++++++++-----------
 t/t3701-add-interactive.sh | 30 +++++++++++++++
 2 files changed, 102 insertions(+), 21 deletions(-)

-- 
2.16.1

