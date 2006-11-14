X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 17:29:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611141718480.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <ejdapj$vc0$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141627200.2591@xanadu.home>
 <200611142304.33673.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 14 Nov 2006 22:29:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200611142304.33673.jnareb@gmail.com>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31386>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk6mO-0006Xd-FK for gcvg-git@gmane.org; Tue, 14 Nov
 2006 23:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933462AbWKNW3R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 17:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933479AbWKNW3R
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 17:29:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52539 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S933462AbWKNW3Q (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 17:29:16 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8Q00348RSSWQC0@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Tue,
 14 Nov 2006 17:29:16 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Tue, 14 Nov 2006, Jakub Narebski wrote:

> Nicolas Pitre wrote:
> > On Tue, 14 Nov 2006, Jakub Narebski wrote:
> 
> >> We can always have --merge arguments to git-pull, and --fetch argument to
> >> git-merge.
> > 
> > That would be a complete abomination if you want my opinion.
> > 
> > Please let git-pull actually pull stuff from a remote place, and 
> > git-merge actually merge stuff only.  Let's keep simple concepts mapped 
> > to simple commands please.  Nothing prevents _you_ from scripting more 
> > involved operations with a single command of your liking afterwards.
> 
> Do we want to abandon completely "single-branch" workflow, where you
> don't use tracking branch, only merge directly into your working branch?

I really think we should.  Let's admit it: such a work flow has nothing 
to do with the tool.  It would certainly be much easier to teach new 
users about "this is a read-only view of the remote content that you can 
merge into your working branch" than trying to explain why the tool is 
so weird for the sake of supporting different work flows directly.

Again I think it is easier to grasp two simple commands than a single 
but complex one with multiple ramifications.

> That is the cause to (unused by most) future git-merge (replacement for
> git-pull .) --fetch=<remote>[#<branch>] option.
> 
> I'm not that sure about --merge option, but it could be useful, at least
> to have current automatic "Merge branch '<branch>' of <URL>" commit message.

A "remote" branch should obviously have a corresponding URL.  So if you 
do "git-merge remote" then you may as well prepare a commit message with 
that URL given the local name for that branch if you want.


