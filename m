Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10DD6211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 17:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbeLBRDb (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 12:03:31 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:34044 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBRDb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 12:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qsUG7+ZhEL/6RcT8glc3FtMd8VWoDrIqMr6w7rJCjy4=; b=E89nvzX5El+8224i1kIW+QJal
        eVLfd1Y7v4pZZ8IOeBTQLWE9kJUGemmlv3crQhkterfQMsqQolRfnwUyijJTDbE+XLvh5TgG+A8m+
        wdHisKczn7fu+1czg15dJKqGenAOCzrF2qp2fiTWVsVS+Wj6SMcLAfs6aU5fKKb/XYTO+HWwuPdhc
        5OvPLDESRzbx7VZgtL96WsAKXWUVd7tXf/G1aIga0Be/y3BIiX3F9z5ofgxfsGV58LWE8tKNm3MPt
        LZNREPCwIQ8GqiUp2Qr0nJVRby07OkiupvWSpZ5bSI8YaaWi1BOSZRDOXeWX39dH93fms2XvGoANo
        RQ1V87LwQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:60212 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gTV9S-0003Q9-0i; Sun, 02 Dec 2018 12:03:26 -0500
Date:   Sun, 2 Dec 2018 12:03:23 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git add -p" versus "git add -i", followed by "p"
In-Reply-To: <20181202165617.GG30222@szeder.dev>
Message-ID: <alpine.LFD.2.21.1812021201550.6459@localhost.localdomain>
References: <alpine.LFD.2.21.1812021124350.5509@localhost.localdomain> <20181202165617.GG30222@szeder.dev>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1787359627-1543770207=:6459"
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

--8323328-1787359627-1543770207=:6459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 2 Dec 2018, SZEDER Gábor wrote:

> On Sun, Dec 02, 2018 at 11:30:19AM -0500, Robert P. J. Day wrote:
> >
> >   testing adding by patch for the very first time (i've just never
> > needed this), and reading the "progit" book and reading the man page,
> > and the impression i'm getting is that running "git add -p" (going
> > straight to patch mode) is supposed to be equivalent to running "git
> > add -i", then typing "p" to switch to patch mode.
> >
> >   that is most emphatically not what i'm seeing. if i run "git add
> > -p", then i get to what i expect -- the patch subsystem:
> >
> >   $ git add -p
> >   diff --git a/README.asc b/README.asc
> >   index fa40bad..840e85b 100644
> >   --- a/README.asc
> >   +++ b/README.asc
> >   @@ -1,3 +1,9 @@
> >   +change 1
> >   +
> >   +
> >   +
> >   +
> >   +
> >    = Pro Git, Second Edition
> >
> >    Welcome to the second edition of the Pro Git book.
> >   Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?
> >
> > but if i start with "git add -i", there seems to be no way to get to
> > patch mode -- certainly "p" doesn't do it. am i stupidly missing
> > something trivial? is the explanation misleading or inncomplete?
>
> Worksforme™:
>
>   $ echo "New content" >>README.md
>   $ echo "New content" >>t/README
>   $ echo "New content" >>contrib//README
>   $ git add -i
>              staged     unstaged path
>     1:    unchanged        +1/-0 README.md
>     2:    unchanged        +1/-0 contrib/README
>     3:    unchanged        +1/-0 t/README
>
>   *** Commands ***
>     1: status       2: update       3: revert       4: add untracked
>     5: patch        6: diff         7: quit         8: help
>   What now> p
>              staged     unstaged path
>     1:    unchanged        +1/-0 README.md
>     2:    unchanged        +1/-0 contrib/README
>     3:    unchanged        +1/-0 t/README
>   Patch update>> 1
>              staged     unstaged path
>   * 1:    unchanged        +1/-0 README.md
>     2:    unchanged        +1/-0 contrib/README
>     3:    unchanged        +1/-0 t/README
>   Patch update>> 2
>              staged     unstaged path
>   * 1:    unchanged        +1/-0 README.md
>   * 2:    unchanged        +1/-0 contrib/README
>     3:    unchanged        +1/-0 t/README
>   Patch update>>
>
> Here I hit enter.  Did you?

  perhaps i'm just not seeing it, but from "man git-add", it doesn't
seem obvious that you would first select the files to work with, then
hit a simple CR to get into actual patch mode.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-1787359627-1543770207=:6459--
