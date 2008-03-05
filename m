From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-log segfault on 00 graft
Date: Wed, 5 Mar 2008 00:06:30 -0500
Message-ID: <20080305050630.GX8410@spearce.org>
References: <Pine.LNX.4.64.0803041954320.7660@fbirervta.pbzchgretzou.qr> <alpine.LSU.1.00.0803041908210.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Engelhardt <jengelh@computergmbh.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 05 06:07:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWlqX-0004E5-EA
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 06:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbYCEFGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 00:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbYCEFGi
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 00:06:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47260 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbYCEFGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 00:06:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWlpd-0005Yi-Rs; Wed, 05 Mar 2008 00:06:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 854A720FBAE; Wed,  5 Mar 2008 00:06:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803041908210.22527@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76168>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 4 Mar 2008, Jan Engelhardt wrote:
> 
> > I was playing a bit with grafts, and actually did this:
> > 
> >   echo '839affa3313011da783b5b8074a5c9805ee8503a 
> > 0000000000000000000000000000000000000000' >.git/info/grafts
> > 
> > running `git log --topo-order` causes a segfault. Yes, I probably 
> > "should not be doing that", but I think it at least should not
> > segfault.
> 
> Well, I agree with the first, but not the latter.  grafts are a really 
> core and plumbing thing, and if you set it to something nonsensical, I 
> think you should expect something like a segmentation fault.

I'm sorry, I don't know where you learned to program Dscho, but
my mentors always taught me that user input should be handled
with care, and SIGSEGV / SIGBUS / SIGILL is not handling with
care!

We tell users to popuate the .git/info/grafts file.  By hand.
Its user input.  We shouldn't segfault over a malformed entry.

-- 
Shawn.
