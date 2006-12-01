X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Fri, 1 Dec 2006 13:27:40 -0500
Message-ID: <20061201182740.GB31025@spearce.org>
References: <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se> <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org> <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home> <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org> <456F4E38.50001@codeweavers.com> <eknj33$q2r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 18:28:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <eknj33$q2r$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32954>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqD6x-0002NZ-TM for gcvg-git@gmane.org; Fri, 01 Dec
 2006 19:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031693AbWLAS1o (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 13:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031700AbWLAS1o
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 13:27:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:4045 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1031693AbWLAS1n
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 13:27:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GqD6l-00076T-3J; Fri, 01 Dec 2006 13:27:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8A67220FB7F; Fri,  1 Dec 2006 13:27:40 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Robert Shearman wrote:
> 
> > Having the index exposed for even simple operations means that the user 
> > has to initially learn three states instead of two. The worst thing 
> > about the index is that it is a limbo state. The committed content is in 
> > the history and can be viewed by gitk (and other tools that the user 
> > will be introduced to later) and the working tree is exactly what the 
> > user sees in their editor. Having a hidden state isn't very good from an 
> > HCI point of view.
> 
> Index is accessible, just like committed contents. The fact that gitk, qgit,
> git-gui doesn't display state of index is their limitation.

Actually git-gui shows the index, but not quite as well as diff
and friends would.

But based on this thread I had a major realization: git-gui is
totally wrong in how it displays files (and therefore gitool is
too!).  I'm going to rewrite that part of git-gui's UI, hopefully
early next week.

Linus is right: To deny the index is to deny git itself.  Trying to
hide part of the index in git-gui is just wrong and makes things
like merge conflict resolutions harder, not easier.

-- 
