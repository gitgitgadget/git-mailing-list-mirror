Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F69A1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 07:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfBTHx7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 02:53:59 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:46716 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBTHx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 02:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GHag1v3ottUIEq6LQN/wsxhvFVesfv04MiWktI3E+RA=; b=u4mgBTNH3ZIqVorbaYrNJEDCGY
        I2ax54NzhpTBmI+9+0gFFFsFs+pYfTbsoMywLDT9PasO20hFDCLui4iv6EsuV7MMC3nXe+SO8jZui
        q/X8w1vx5Xz0tajRoTGOiCASjkXsPxWJDSpBZhbEGxiY810bOPOdkArHUTDhczjqsVH9pHwhNhUqx
        NEvbY5j0vHeqWnbmI4xKpVRXfKwVmclgU2O0rpSo38+VL1oD5gDWDQw17+FE+p3uJcDw6mqRWs7na
        QT0eIUbFhwo2fw695QVCmvIDn1vT+krCsBUDaAIPAa0OXGa4iDzz0mmr8ZVcveiGX/ApEyqs9WUQ3
        efD2RxiA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:37466 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gwMhY-000Nci-FO
        for git@vger.kernel.org; Wed, 20 Feb 2019 02:53:57 -0500
Date:   Wed, 20 Feb 2019 02:53:54 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] mention use of "hooks.allownonascii" in "man githooks"
Message-ID: <alpine.LFD.2.21.1902200250420.7360@localhost.localdomain>
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


The default pre-commit script checks the config variable
"hooks.allownonascii" to determine whether to allow non-ASCII file
names -- mention this in "man githooks", just as the section on
"update" mentions the use of "hooks.allowunannotated".

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 959044347e..5bf653c111 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -99,6 +99,10 @@ All the `git commit` hooks are invoked with the environment
 variable `GIT_EDITOR=:` if the command will not bring up an editor
 to modify the commit message.

+The default 'pre-commit' hook, when enabled--and with the
+`hooks.allownonascii` config option unset or set to false--prevents
+the use of non-ASCII filenames.
+
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
