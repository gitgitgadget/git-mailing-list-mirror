From: Nicolas Pitre <nico@cam.org>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sat, 09 Feb 2008 20:28:59 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802092016540.2732@xanadu.home>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802100110450.11591@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:29:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO10v-00017i-Ey
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 02:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbYBJB3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 20:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbYBJB3P
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 20:29:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:56919 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbYBJB3O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 20:29:14 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW000F3H1GBN660@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 09 Feb 2008 20:28:59 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0802100110450.11591@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73285>

On Sun, 10 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sat, 9 Feb 2008, Linus Torvalds wrote:
> 
> > I'm starting to free up some resources to look at the interesting 
> > problem with screwed-up commit dates confusing our commit walker into 
> > thinking that some uninteresting commit isn't actually uninteresting due 
> > to not traversing the uninteresting chain deep enough.
> 
> I was thinking the other night why I did not like the generation header.  
> And I found out why: it is redundant information.
> 
> So why not have some local "cache" which maintains the generation numbers 
> for the commits?  (Much like the "notes" cache I showed last year?)

Absolutely.

I, too, have some reservations about adding any kind of generation 
header to commit objects.  First because it can be generated and 
maintained locally, just like the pack index.  But also because its 
usefulness has not been proven in all possible graph topologies, and 
adding it to the commit header pretty much deny any further 
modifications/improvements on it, if for example some other kind of 
generation notation becomes advantageous to use.

So please don't put it into the commit object format.  The object 
database should ultimately contain only data that cannot be regenerated.


Nicolas
