From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Mon, 5 Feb 2007 13:43:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702051338261.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
 <epv3r9$4f7$2@sea.gmane.org> <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
 <Pine.LNX.4.63.0702051208070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070205112101.GC14234@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 13:43:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE3Bm-0003nC-AN
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 13:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbXBEMnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 07:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbXBEMnP
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 07:43:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:45427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932258AbXBEMnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 07:43:14 -0500
Received: (qmail invoked by alias); 05 Feb 2007 12:43:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 05 Feb 2007 13:43:13 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070205112101.GC14234@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38749>

Hi,

On Mon, 5 Feb 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Fri, 2 Feb 2007, Lars Hjemli wrote:
> > 
> > > I think the following makes perfect sense:
> > > 
> > >  "HEAD@{yesterday}" = current branch, yesterday
> > >  "@{yesterday}"     = detached head (no branch), yesterday
> > 
> > Okay, so you say "HEAD@{yesterday}" does _not_ give you what HEAD pointed 
> > to yesterday, but "@{yesterday}" does?
> > 
> > Instead "HEAD@{yesterday}" looks up what HEAD points to _now_, and _then_ 
> > goes back to yesterday, finding out what that particular branch pointed to 
> > then, _regardless_ what HEAD was then?
> > 
> > Oh my, that's convoluted.
> 
> Depends on your point of view:
> 
>   HEAD: 1) noun.  Synonym for the branch I am currently on.
>   HEAD: 2) noun.  Synonym for the commit I am currently on.

HEAD: 3) noun. The tip of the current branch.
HEAD: 4) noun. The part of the body I am right now banging on the wall.

> Now that we can detach our HEAD anytime we want, I'm in the latter camp, 
> and your (Dscho's) meaning for HEAD@{yesterday} and @{yesterday} makes 
> perfect sense.
> 
> But I suspect most Git users are still in the former camp, as they 
> haven't been exposed to the process (or need, or desire) to detach their 
> HEAD...

But has _nothing_ to do with a detachable HEAD.

Once people know what HEAD is, they do

	git show HEAD

to see what the tip of their current branch looks like. Now, read out 
aloud "HEAD@{12:00.pm.yesterday}". Yes, that's right. It says "HEAD at 
noon yesterday".

I mean, it's really easy to see what HEAD is good for. If your head 
automatically resolved HEAD to "the current branch, right now, even if I 
am talking about another time", I find it convoluted.

That's all.

Ciao,
Dscho
