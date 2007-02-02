From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Fri, 02 Feb 2007 09:52:48 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702020945090.3021@xanadu.home>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
 <epv3r9$4f7$2@sea.gmane.org>
 <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 15:53:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCzmb-0003IN-3V
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 15:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945913AbXBBOwu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 09:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945914AbXBBOwu
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 09:52:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25268 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945913AbXBBOwt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 09:52:49 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCU00LCMC004G70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 Feb 2007 09:52:48 -0500 (EST)
In-reply-to: <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38501>

On Fri, 2 Feb 2007, Lars Hjemli wrote:

> On 2/2/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Fri, 2 Feb 2007, Jakub Narebski wrote:
> >
> > > Perhaps we should use @{...} to refer to reflog for HEAD, or use yet
> > > another special notation?
> >
> > No.
> >
> > IMHO "bla@{yesterday}" should give you what "bla" pointed to, yesterday.
> > In that sense, the proposed reflog on "HEAD" makes perfect sense.
> 
> Since HEAD is a synonym for "current branch" everywhere else in git,
> while .git/logs/HEAD will be a log of detached HEAD (plus branch
> switches, I guess), I think the following makes perfect sense:
> 
>  "HEAD@{yesterday}" = current branch, yesterday
>  "@{yesterday}"     = detached head (no branch), yesterday

No it doesn't.

HEAD is a moving pointer.  Sometimes it means the current branch, 
sometimes it doesn't.

So HEAD is _NOT_ a synonym for "current branch" everywhere already.

And it is really nice to reflog the switching between branch which makes 
sense only if HEAD has a reflog of its own.

If I want to know where HEAD was yesterday, then the only way to get to 
this info is with a separate reflog for HEAD.  IF HEAD was a synonym for 
the current branch then it is impossible to know where HEAD was 
yesterday because you only get the info about where the current branch 
was yesterday.  But it is all possible that the yesterday's current 
branch wasn't the same as today's current branch.


Nicolas
