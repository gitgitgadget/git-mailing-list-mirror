From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Thu, 30 Oct 2008 14:28:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810301423520.13034@xanadu.home>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
 <alpine.LFD.2.00.0810301024300.13034@xanadu.home>
 <20081030145253.GK14786@spearce.org> <20081030145928.GA21707@glandium.org>
 <20081030150135.GG24098@artemis.corp>
 <alpine.LFD.2.00.0810301105350.13034@xanadu.home>
 <1225387882.19891.9.camel@maia.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pierre Habouzit <madcoder@debian.org>,
	Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 19:30:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvcHS-0003Y1-RS
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 19:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbYJ3S2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 14:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbYJ3S2r
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 14:28:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49266 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbYJ3S2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 14:28:47 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9K001NTDYLS501@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Oct 2008 14:27:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1225387882.19891.9.camel@maia.lan>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99518>

On Thu, 30 Oct 2008, Sam Vilain wrote:

> On Thu, 2008-10-30 at 12:53 -0400, Nicolas Pitre wrote:
> > > Seconded.
> > > 
> > > Having git-checkout $foo being a shorthand for git checkout -b $foo
> > > origin/$foo when origin/$foo exists and $foo doesn't is definitely handy.
> > 
> > No.  This is only the first step towards insanity.
> > 
> > In many cases origin/$foo == origin/master so this can't work in that 
> > case which is, after all, the common case.
> 
> I don't understand that argument at all, can you explain further?

By default, git creates a branch called "master.  Hence, by default, if 
you clone that repository, this branch will be called origin/master.  So 
by default $foo is already ambiguous.

> >   Therefore I think this is 
> > wrong to add magic operations which are not useful for the common case 
> > and actively _hide_ how git actually works.  Not only will you have to 
> > explain how git works anyway for that common origin/master case, but 
> > you'll also have to explain why sometimes the magic works and sometimes 
> > not.  Please keep such convenience shortcuts for your own scripts and/or 
> > aliases.
> 
> It's not about magic, it's about sensible defaults.  Currently this use
> case is an error, and the resultant command is very long to type, and
> involves typing the branch name twice.  I end up writing things like:
> 
>   git checkout -b {,origin/}wr34251-do-something
> 
> For the user who doesn't know to use the ksh-style {} blocks this is
> voodoo.  The longer form is cumbersome.

This is no excuse for promoting semantics only useful in such special 
cases.

> For the case where the thing you type is a resolvable reference, it
> would just check it out, as now.

As long as it checks it out with a detached head if it is a remote 
branch then I have no issue.


Nicolas
