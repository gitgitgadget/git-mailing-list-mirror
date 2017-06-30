Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B763820209
	for <e@80x24.org>; Fri, 30 Jun 2017 09:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbdF3Jtk (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 05:49:40 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:11503 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdF3Jtj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 05:49:39 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id QsYKdOu0hQ527QsYSdIMsb; Fri, 30 Jun 2017 10:49:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498816177; bh=hcoGAX7XvnNLtPCxwe85bhv7ffmoM6w5RDNzjf9z0h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=EmD4hOEpG/UzHRLHC9sr2xh+Nx5u+j5/KQM7UypuDLeHRCiZU/s7mNar0Y1oUnr5A
         nh1D+grmv//spMpWp/1DGjNS2N2E/EbdWzLuIck/uWyT85dDaOj65kXpZoz1cePWG5
         nqs6vn9r7RwIp5E7qWvsu/KDFpRhOWhE5RwphTf0=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=j-kjViYnPEk9IFrRVGYA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/4] Move unquote_path from git-add--interactive.perl to Git.pm
Date:   Fri, 30 Jun 2017 10:49:08 +0100
Message-Id: <20170630094912.8653-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170622102622.26147-1-phillip.wood@talktalk.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPmLj1YF6TsCIFKW6MKFc2o3hclI9hZwM9kFY13x3yZwZekDGQx7o2TxoQo9KrWEL1BMm8ITviiYBKb0vzxiyM3J3O8bl2/0Sjz8ZgTmPRF/BkE+/JcT
 xz+d+kFg2pTgoHe+5lP2FPzg760aNWybTuYkzctHSXoizVP5OM3yZVPnJ3OaOXLcRMQy3/env9Ae6pva8EGvL+MfbFVO+pKDoWN8yhyGVviCTN04o1q6y42z
 rwb7SwIfxegFoDxdwbJxrZ/l+Ke/BLOT3P9LOkGiN5I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks for the review Junio, I've amended the patches as you suggested.

The first patch now removes unquote_path() from add -i as well as
adding it to Git.pm. I've fixed the naming issues (the version I sent
previously was copied from another script rather than directly from
add -i, I thought it was identical but must have changed it slightly
when I copied the original and then forgotten I'd made some changes)
I also expanded the documentation very slightly to mention parsing
diff -u as I think using -z isn't possible for that.

The error message in the third patch now starts with a lowercase letter.

Best Wishes

Phillip

Phillip Wood (4):
  add -i move unquote_path() to Git.pm
  Git::unquote_path() Handle '\a'
  Git::unquote_path() throw an exception on bad path
  Add tests for Git::unquote_path()

 git-add--interactive.perl | 43 +------------------------------------
 perl/Git.pm               | 54 ++++++++++++++++++++++++++++++++++++++++++++++-
 t/t9700/test.pl           |  7 ++++++
 3 files changed, 61 insertions(+), 43 deletions(-)

-- 
2.13.1

