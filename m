X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 18:15:42 -0500
Message-ID: <20061115231542.GB25270@spearce.org>
References: <200611151858.51833.andyparkins@gmail.com> <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org> <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com> <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home> <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <87velgs9hx.wl%cworth@cworth.org> <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org> <87psbos4pb.wl%cworth@cworth.org> <20061115180722.83ff8990.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 23:16:10 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061115180722.83ff8990.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31527>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkTyz-0006Fz-Ep for gcvg-git@gmane.org; Thu, 16 Nov
 2006 00:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162046AbWKOXPt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 18:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162054AbWKOXPt
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 18:15:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:19382 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1162046AbWKOXPs
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 18:15:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GkTyg-0005IN-JR; Wed, 15 Nov 2006 18:15:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 742F120FB0B; Wed, 15 Nov 2006 18:15:42 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> On Wed, 15 Nov 2006 14:52:32 -0800
> Carl Worth <cworth@cworth.org> wrote:
> 
> > The real fix is to stop glossing over git-merge and just give it a
> > usable syntax.
> 
> Agreed 100%   There's just no good reason to hide the user level
> merge command inside of pull.

So what about making git-merge take a -m "msg" argument to supply
the commit message, in which case it does the current behavior
(and thus git-pull needs to change to supply -m); and then make
git-merge without any -m parameter invoke "git pull . $@" ?

A minor tweak to both apps, a minor breakage to git-merge, but one
that I think anyone who invokes it by hand today would find sane
(using -m like we do elsewhere) and since the vintage of both
git-pull and git-merge should always match shouldn't break anyone
who uses git-pull today.

-- 
