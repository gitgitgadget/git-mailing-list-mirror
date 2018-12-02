Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4486211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 16:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbeLBQaY (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 11:30:24 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:54664 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeLBQaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 11:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PHZouSunwI9QtG4xpaPlUCVLKc8uUpFTfqsVG1zc48c=; b=OzRU4VBfuVrR52SA9BcVkNC0qr
        m/CLrLA2uCT7FpcSndKDie4kUSSxcz2Lmucvh9bdMbxFpIvpTpW9MboOR7/NKznvwxQEhbzy5iKUa
        NpBNPFzwjtpi7LNAuDECyrhYdBveeKbuiwzeJ4Xt35sqentpg29UKc2KdlI/HgpB08m/B81fY3kWA
        ghwAyo2FYxATlBbqDZvO+NnF2FmYoNP0wMSJ1FHU5xJ4aMvN1+ThcNDXegZuXSU8ujvAGWx+BS0/l
        Zs7BaMW+HrzJMo3+YHNtTLeKy0mbJDb3c765Ma1b194egblmabQZYABu/7gX+0+D9KdkqjOQvMRI0
        Esg3M0+w==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:59222 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gTUdO-0004No-LY
        for git@vger.kernel.org; Sun, 02 Dec 2018 11:30:19 -0500
Date:   Sun, 2 Dec 2018 11:30:19 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: "git add -p" versus "git add -i", followed by "p"
Message-ID: <alpine.LFD.2.21.1812021124350.5509@localhost.localdomain>
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


  testing adding by patch for the very first time (i've just never
needed this), and reading the "progit" book and reading the man page,
and the impression i'm getting is that running "git add -p" (going
straight to patch mode) is supposed to be equivalent to running "git
add -i", then typing "p" to switch to patch mode.

  that is most emphatically not what i'm seeing. if i run "git add
-p", then i get to what i expect -- the patch subsystem:

  $ git add -p
  diff --git a/README.asc b/README.asc
  index fa40bad..840e85b 100644
  --- a/README.asc
  +++ b/README.asc
  @@ -1,3 +1,9 @@
  +change 1
  +
  +
  +
  +
  +
   = Pro Git, Second Edition

   Welcome to the second edition of the Pro Git book.
  Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?

but if i start with "git add -i", there seems to be no way to get to
patch mode -- certainly "p" doesn't do it. am i stupidly missing
something trivial? is the explanation misleading or inncomplete?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
