Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9257A211B3
	for <e@80x24.org>; Sat,  8 Dec 2018 16:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLHQWY (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 11:22:24 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:34458 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeLHQWX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 11:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4RfeWlZZGtXmWRofYdYvqsUPg7cXvJzwN0y1IagGYhQ=; b=Hr7zxo9Q705gWzcDF8yNKtxW2
        kP1VP59vEVADm9hyNo52RgqahtTXjGWSDpcT8aE5oBbyY2mcNHsTphNyDw5liniXEJUHmjuP4cVr8
        q6gJB1TB2rt2A5ugNbjsLFzwMXzyDeCHW1QL0W7qTCeNKZ4RUihyZN/6cX2qcuMpXQPoaCSBqgl6J
        xpkneukBYBMdr1hFCTTvbRo8ZM6xBJdnB7nYPsJlYlkVBdaomoj2cC3El7P+Ii+2na1IE1XHxV2lj
        pl1suL3+BlISfKq60Pkw92YONNNsW40fwzPTic+5ChEMdYMxjcmZAmCMNrqqnQ1vTMU8LKjvaCqK+
        tqPRVkjbQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:50046 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gVfMz-0003dE-IU; Sat, 08 Dec 2018 11:22:22 -0500
Date:   Sat, 8 Dec 2018 11:22:18 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Duy Nguyen <pclouds@gmail.com>
cc:     =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "git add -p" versus "git add -i", followed by "p"
In-Reply-To: <CACsJy8AkMfZ02b9p2sQi2p=Bw4MDckLYy_cBFVeN2_UY-Z3kCg@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1812081121420.29731@localhost.localdomain>
References: <alpine.LFD.2.21.1812021124350.5509@localhost.localdomain> <20181202165617.GG30222@szeder.dev> <alpine.LFD.2.21.1812021201550.6459@localhost.localdomain> <CACsJy8AkMfZ02b9p2sQi2p=Bw4MDckLYy_cBFVeN2_UY-Z3kCg@mail.gmail.com>
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

On Sun, 2 Dec 2018, Duy Nguyen wrote:

> On Sun, Dec 2, 2018 at 6:05 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > >   Patch update>> 2
> > >              staged     unstaged path
> > >   * 1:    unchanged        +1/-0 README.md
> > >   * 2:    unchanged        +1/-0 contrib/README
> > >     3:    unchanged        +1/-0 t/README
> > >   Patch update>>
> > >
> > > Here I hit enter.  Did you?
> >
> >   perhaps i'm just not seeing it, but from "man git-add", it
> > doesn't seem obvious that you would first select the files to work
> > with, then hit a simple CR to get into actual patch mode.
>
> I think it's the same procedure as the "update" step, which
> describes this in more detail. I agree that the "patch" section does
> not make this obvious.

  when i get a chance, i'll try to reword it.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
