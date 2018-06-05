Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA951F403
	for <e@80x24.org>; Tue,  5 Jun 2018 11:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeFELRC (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 07:17:02 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:59986 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeFELRB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 07:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jbkbyNfbddmtmUhWNkwANdZiT1VePv4Byg0aMUueiEo=; b=g2N5f7MwGRC8CAVotOdfWi69ic
        2/0UyHY4bGpB3xrwnsGZFrCdfUIgY16T2lnue+2xzejJ4Y83AkyvR+m6BHH524sGZbQIGohtNqHIC
        haP3VxK5/bWOfq0vb8Ep1JoSRXcCY2iTH3FUGxTNxderE/xWK2J7jM9KMQUAQ69I49Vd+C4m58cvH
        3LPuewWVLCNNbblDmESQqL3RuksP6u7LBGRUggD8rNATlKbwAW23v4d0L6vP28Shyc1+uRrijQYfx
        s9tuVbOQz1+eoZbJ/d6lnHl0CY6W6kKbXWJLHiMJDxvlm3tffSvdBFIP/L9BN6CtFvmmwPdH9kM7s
        jIwF5otw==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:56668 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fQ9xS-000LXK-FI
        for git@vger.kernel.org; Tue, 05 Jun 2018 07:17:00 -0400
Date:   Tue, 5 Jun 2018 07:14:45 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] t3200-branch.sh: use "--set-upstream-to" in test
Message-ID: <alpine.LFD.2.21.1806050712270.10467@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Change deprecated "--set-upstream" branch option to
preferred "--set-upstream-to".

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  i'm assuming this should use "--set-upstream-to" as do all the
others.

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 69ea8202f4..ef887a0b32 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -885,8 +885,8 @@ test_expect_success 'test --unset-upstream on a particular branch' '
 	test_must_fail git config branch.my14.merge
 '

-test_expect_success '--set-upstream fails' '
-    test_must_fail git branch --set-upstream origin/master
+test_expect_success '--set-upstream-to fails' '
+    test_must_fail git branch --set-upstream-to origin/master
 '

 test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
