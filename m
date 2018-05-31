Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EFD91F42D
	for <e@80x24.org>; Thu, 31 May 2018 16:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755660AbeEaQks (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 12:40:48 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:38658 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755594AbeEaQkr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 12:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UOYAvo7kID5mie/gMDqx9RRAUR5QV4qFWl5WzIFhEWU=; b=xB6/N6zrPTW2MplwR3409sfS0w
        oUdQ0cIfGGEsMcnh8X/8q28XWPN1kEVgDFYv4ONbsOOlOonwA7PKvGXmjrdRwwwRd4WV4NqK1HOBs
        yOri0YBwvZm9SY4xCBHCxqwPzIgNrjWSa54zYPpQ3zhDtE3e9uvnzt2qZINIIe9Dg24eJTWJzt5CN
        ICIkEw6Wa8BH/WjvWdPOLLWukn65KsTFbo/lVuzI7CGt2V0TA4GGktlXpWctwMUl4yUqAF8HptUZd
        rwvEzqC5gj6ulKxkCEpf0qc9cCfQ9o4fnrtO5knjNyrN5Elb+n53v/k7TwHlycllQCrfOvD/sncSn
        cNmQEpzg==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:59332 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fOQd2-004b1x-GY
        for git@vger.kernel.org; Thu, 31 May 2018 12:40:45 -0400
Date:   Thu, 31 May 2018 12:38:46 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: is there a reason pre-commit.sample uses "git diff-index"?
Message-ID: <alpine.LFD.2.21.1805311235410.15130@localhost.localdomain>
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


  was going over some hooks and writing some tutorials for some of the
commit-related, client-side hooks, and was wondering (perhaps
stupidly) why the pre-commit.sample hook uses, as its last line:

  exec git diff-index --check --cached $against --
           ^^^^^^^^^^

as in, could this not be done equivalently with just git diff, not git
diff-index? i just did a quick test and it seems to do the same thing,
but i've never taken a close look at git diff-index before so i may
just be clueless about some important distinction.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
