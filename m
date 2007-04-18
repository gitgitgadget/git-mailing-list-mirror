From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 10:56:40 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704181036280.4504@xanadu.home>
References: <200704171041.46176.andyparkins@gmail.com>
 <"200704171803.58940.a n dyparkins"@gmail.com>
 <200704172012.31280.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
 <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
 <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
 <7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704172154160.4504@xanadu.home>
 <7vlkgqjmsa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 16:56:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeBaP-0003Ly-PM
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 16:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992702AbXDRO4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 10:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992703AbXDRO4m
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 10:56:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39283 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992702AbXDRO4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 10:56:41 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGP001E386GHRH0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Apr 2007 10:56:40 -0400 (EDT)
In-reply-to: <7vlkgqjmsa.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44895>

On Tue, 17 Apr 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Tue, 17 Apr 2007, Junio C Hamano wrote:
> >
> >> You have to be careful, though.  Depending on what kind of
> >> transformation you implement with the external tools, you would
> >> end up having to slow down everything we would do.
> >
> > So what?  
> >
> > We provide a rope with proper caveat emptor.  Up to others to hang 
> > themselves with it if they so desire.  It is not our problem anymore.
> 
> I sort-of find it hard to believe hearing this from somebody who
> muttered something about importance of perception a few days ago.

Sure!  And that applies in this case as well.

With such a _generic_ hook, Git will be perceived as much more powerful 
and flexible.  I insist on "generic" because people could experiment 
with their own filters without endless debate on the mailing list and 
pressure to include this or that feature in the core, and we don't have 
to commit to those feature we're not in agreement with.

And let's face it: there are probably legitimate and possibly more 
useful things to do with such a hook than keyword expansion.

If you go to Home Hardware you can buy rope.  Of course you can hang 
yourself with it, but the rope manufacturers won't commit to that I'm 
sure.  But if rope was banned by law because it represents a threath to 
life then governments would be perceived really strangely even if their 
intention are good.

Sure we might have a strong opinion against keyword expansion and that 
is reflected by the fact that Git will most probably never ship with the 
ability to perform keyword expansion.  That doesn't mean we should deny 
all possibilities for external filters _even_ if they can be used for 
keyword expansion.

> >> I suspect that you would have to play safe and say "when
> >> external tools are involved, we need to disable the existing
> >> content SHA-1 based optimization for all paths that ask for
> >> them" to keep your sanity.
> >
> > Maybe.  If that is what's really needed then so be it.  People who 
> > really want to do strange things will have the flexibility to do so, but 
> > they'll have to pay the price in loss of performance.
> 
> Not just that.  We end up having to pay the price of maintaining
> hooks to let them do crazy things.

Weight that against the price of fighting them against the crazy things 
they won't quit wanting to do.  At some point it is just a matter of 
getting out of the way.


Nicolas
