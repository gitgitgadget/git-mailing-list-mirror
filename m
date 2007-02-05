From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Mon, 5 Feb 2007 06:21:01 -0500
Message-ID: <20070205112101.GC14234@spearce.org>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net> <epv3r9$4f7$2@sea.gmane.org> <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de> <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com> <Pine.LNX.4.63.0702051208070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 05 12:21:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE1uO-0005El-Of
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 12:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXBELVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 06:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbXBELVI
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 06:21:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42743 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbXBELVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 06:21:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HE1u8-0006Ym-6h; Mon, 05 Feb 2007 06:21:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8E0EF20FBAE; Mon,  5 Feb 2007 06:21:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702051208070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38741>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 2 Feb 2007, Lars Hjemli wrote:
> 
> > I think the following makes perfect sense:
> > 
> >  "HEAD@{yesterday}" = current branch, yesterday
> >  "@{yesterday}"     = detached head (no branch), yesterday
> 
> Okay, so you say "HEAD@{yesterday}" does _not_ give you what HEAD pointed 
> to yesterday, but "@{yesterday}" does?
> 
> Instead "HEAD@{yesterday}" looks up what HEAD points to _now_, and _then_ 
> goes back to yesterday, finding out what that particular branch pointed to 
> then, _regardless_ what HEAD was then?
> 
> Oh my, that's convoluted.

Depends on your point of view:

  HEAD: 1) noun.  Synonym for the branch I am currently on.
  HEAD: 2) noun.  Synonym for the commit I am currently on.

Now that we can detach our HEAD anytime we want, I'm in the
latter camp, and your (Dscho's) meaning for HEAD@{yesterday} and
@{yesterday} makes perfect sense.

But I suspect most Git users are still in the former camp, as they
haven't been exposed to the process (or need, or desire) to detach
their HEAD...

-- 
Shawn.
