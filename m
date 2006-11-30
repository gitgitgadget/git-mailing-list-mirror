X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Thu, 30 Nov 2006 12:16:01 -0600
Message-ID: <1164910560.4724.117.camel@cashmere.sps.mot.com>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
	 <ekafpm$fs7$1@sea.gmane.org> <20061126033433.GD29394@spearce.org>
	 <7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 18:17:31 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Git List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32783>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpqT2-0005fD-Ub for gcvg-git@gmane.org; Thu, 30 Nov
 2006 19:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030956AbWK3SQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 13:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030947AbWK3SQ7
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 13:16:59 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:21655 "EHLO
 de01egw01.freescale.net") by vger.kernel.org with ESMTP id S1030956AbWK3SQ7
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 13:16:59 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net
 [10.208.0.31]) by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
 kAUJcu36001789; Thu, 30 Nov 2006 12:38:56 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2]) by
 de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kAUIGqYb017487; Thu, 30
 Nov 2006 12:16:52 -0600 (CST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, 2006-11-25 at 21:58, Junio C Hamano wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Needing to put + in front of a refspec (or needing to fetch it with
> > --force) is the user agreeing that something _evil_ is going on with
> > the upstream and that they acknowledge this may cause problems for
> > them locally.
> >
> > I would prefer to see the upstream be able to publish a short
> > description of each branch, where the repository owner can describe
> > the policy of that branch, as well as have a machine readable
> > setting on each branch indicating if that branch will be rewound
> > from time to time, or never rewound.
> >
> > git-clone should skip rewinding branches by default, unless the user
> > adds an option (e.g. --include-rewinding-branches).  This way new
> > users to git.git don't get the `pu` branch unless they really mean
> > to get it, at which point they have hopefully also read the upstream's
> > description of the `pu` branch and its rewinding policy, and can
> > at least start to grasp what is going to happen if they start to
> > work with the branch.
> 
> I like this approach very much.

I see how it is! :-)  When Shawn says it, it is to be liked.
But when I allude to it a _year_ ago, I'm ignored.


    From: Jon Loeliger <jdl@freescale.com>
    To: git@vger.kernel.org
    Subject: Re: Trying to Update All Heads of a Repository
    Date: Fri, 4 Nov 2005 07:49:40 -0700 
    Message-ID:  <E1EY2su-0006LW-IN@jdl.com>

    So, from the git-pull man page:

        For "git push", the local ref that matches <src> is
        used to fast forward the remote ref that matches
        <dst>. If the optional plus + is used, the remote
        ref is updated even if it does not result in a fast
        forward update.

    Ah-ha!  Wait.  But here's the conceptual missing piece:
    When might I _know_ I have the situation where a
    fast-forward update might not happen?  And as a remote
    puller, that would be "never" -- unless I know something
    about the nature of the remote end.  That is, like you
    said, "pu" is subject to wild fluctuation and non-linear
    behavior.  But any random puller can't know that a
    priori.  So far, that is out-of-band information about a
    branch that needs to be "available".

Yep, out-of-band information that needs to be available indeed...

Ah well. :-)

jdl

