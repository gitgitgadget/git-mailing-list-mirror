Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472D8211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 16:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeLBQYi (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 11:24:38 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:53642 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeLBQYi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 11:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QCk4uVubjLnetJbYgow0XcoBlrox714iA7N8VhMlxGQ=; b=sMOQEYkwTVyQZFeTkoTINMh4x
        Q137bUbg9cZNU9vrd0BPgmvU5D8f586N3TZW8KxAVa+LggRbIHfsoJj+K+Yd1QqvUN62+4he+/GZJ
        YAC9W8jMZKybKQ2NiLCsv8cbZLNgMRSrcOAYzQfDSy3gHRtoqE4G3Quq2VAa1cGdZiwa+Muko72Cy
        yZUCjHUcVOl6B2Nm5PUm8x263Ij1HVqRvO/hmmoBel8l0XBAXUr4KCkf3IQ4kKqnPRUPuqcI3UjQg
        /e6/O8DP1XXigRY7ChNOPj8lpnUAov3resaS9pXJOsDOFBqBwZz2sRhokkp+BUCMzIrSsbmPYDPei
        dLYCF64QQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:59134 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gTUXo-0003G3-D0; Sun, 02 Dec 2018 11:24:33 -0500
Date:   Sun, 2 Dec 2018 11:24:31 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: easy way to demonstrate length of colliding SHA-1 prefixes?
In-Reply-To: <87y398uknn.fsf@evledraar.gmail.com>
Message-ID: <alpine.LFD.2.21.1812021123050.5509@localhost.localdomain>
References: <alpine.LFD.2.21.1812020647440.32023@localhost.localdomain> <87y398uknn.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-59200103-1543767873=:5509"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-59200103-1543767873=:5509
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sun, 2 Dec 2018, Ævar Arnfjörð Bjarmason wrote:

> On Sun, Dec 02 2018, Robert P. J. Day wrote:
>
> >   as part of an upcoming git class i'm delivering, i thought it
> > would be amusing to demonstrate the maximum length of colliding
> > SHA-1 prefixes in a repository (in my case, i use the linux kernel
> > git repo for most of my examples).
> >
> >   is there a way to display the objects in the object database
> > that clash in the longest object name SHA-1 prefix; i mean, short
> > of manually listing all object names, running that through cut and
> > sort and uniq and ... you get the idea.
> >
> >   is there a cute way to do that? thanks.
>
> You'll always need to list them all. It's inherently an operation
> where for each SHA-1 you need to search for other ones with that
> prefix up to a given length.

  i assumed as much, just wasn't sure about the esoteric dark corners
of git i've never gotten to yet.

> Perhaps you've missed that you can use --abbrev=N for this, and just
> grep for things that are loger than that N, e.g. for linux.git:
>
>     git log --oneline --abbrev=10 --pretty=format:%h |
>     grep -E -v '^.{10}$' |
>     perl -pe 's/^(.{10}).*/$1/'
>
> This will list the 4 objects that need more than 10 characters to be
> shown unambiguously. If you then "git cat-file -t" them you'll get
> the disambiguation help.

  that's pretty close to what i came up with, thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-59200103-1543767873=:5509--
