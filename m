Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365BB20248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfCDPBh (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:01:37 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:36236 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfCDPBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MdrDjMYVJiEk1XAukcjjCQz0SDR2Ik1V6R+4fQBhNrA=; b=s7kwYcgd747qozJFss14QYRIm/
        EZvcbNrfmBwYeCjDHAupmmmcXodlmVs1zLPPWeezus3unGJY1WQ3kMqk5uAEXTK+QxgTFFHTeit1r
        M3oMhx/PmYGVowAc3xw0kGTr9Jj79H+bp5Y4cSIhqOu/MzYEqDOvELD1hZ1WjFQifP1qrgaRhUBCQ
        G98OkdPv9aUWFtkpxpMDHgDtwTbMewII/CsIWjK/9aV58ZSvlf7pvcCw6hrnt958gDXh6IuCyL+Re
        wh0xM07TZF5Bl7BYJo2V+FUXNTqVa3sf0bY2Th4cWR4a54KhMSePPao86KKUPzWdeAqROrM/7/sP3
        juOler7w==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:50260 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h0p5x-00D27V-SY
        for git@vger.kernel.org; Mon, 04 Mar 2019 10:01:35 -0500
Date:   Mon, 4 Mar 2019 10:01:32 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: worth enhancing "man git-rebase" to show non-HEAD examples?
Message-ID: <alpine.LFD.2.21.1903040955540.16666@localhost.localdomain>
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


  one of the things i've noticed about the examples in "man
git-rebase" is that they invariably show rebasing relative to a
branch point that has not moved. for example, there's this example:

       o---o---o---o---o  master
            \
             o---o---o---o---o  next
                              \
                               o---o---o  topic

with subsequent sample command:

  $ git rebase --onto master next topic

sure, that works, but there seem to be no examples that show that this
is a valid starting point as well:

       o---o---o---o---o  master
            \
             o---o---o---o---o  next
                      \
                       o---o---o  topic

as in, the examples in that man page could potentially suggest to an
inexperienced reader that the *only* valid situations are rebasing as
long as the other branch has not developed any further. (yes, i
realize that, if you read carefully, it *should* make it clear, but i
think it would be helpful to at least graphically show that
happening.)

  thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

