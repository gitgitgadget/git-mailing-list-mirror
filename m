Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4DC20248
	for <e@80x24.org>; Tue,  5 Mar 2019 10:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfCEKsd (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 05:48:33 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:42612 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfCEKsd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 05:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y5fPQ0Op0K8yJBOi4dkGYPkajCsnZ+Qhk5Zp0pJOAXw=; b=JioDIH1oVzoEwiTWsree2ckL6r
        q0wLKw1FIYv6RhZI745HRKU9oDY1gzoqJVXhRfF0OTk6+h3U8cRbYlcmU0piF30QQvSwEZq+Q5B7o
        um8xag/eoWvA/4cxUtCAPQYWCK1vo/KKw/yLTDnTVHfWd06z/fBeQeBlixfIAk1jbdMUdDT+kUEyT
        cM33V03MPPQwFp3s/5qoFvpQOuMYraMNCep1m3uaVGFEHW1/i0a4wDhtLvP0aG5ehXUvFMUJktosY
        b783ACp4IYXJMlJtED9L5u0kzmle7ZzGyyPZ+AHxTpiYzMEnHFBnj6kl75s9IL85SM9O8oJ3Z77HA
        tdLRWMKQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:53606 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h17cb-00GXUr-Oo
        for git@vger.kernel.org; Tue, 05 Mar 2019 05:48:30 -0500
Date:   Tue, 5 Mar 2019 05:48:28 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] doc/rebase: extend examples to show continuing branches
Message-ID: <alpine.LFD.2.21.1903050545460.24324@localhost.localdomain>
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


Currently, all of the examples for "man git-rebase" show rebasing from
a branch that has had no further development, which might mislead
readers into thinking that that is a necessary condition for rebasing,
so tweak the examples to show further development on such a branch to
clarify that.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5629ba4c5d..ba3c44fdaf 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -109,8 +109,8 @@ functionality which is found in 'next'.
     o---o---o---o---o  master
          \
           o---o---o---o---o  next
-                           \
-                            o---o---o  topic
+                   \
+                    o---o---o  topic
 ------------

 We want to make 'topic' forked from branch 'master'; for example,
@@ -134,8 +134,8 @@ Another example of --onto option is to rebase part of a
 branch.  If we have the following situation:

 ------------
-                            H---I---J topicB
-                           /
+                        H---I---J topicB
+                       /
                   E---F---G  topicA
                  /
     A---B---C---D  master

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
