From: Nicolas Pitre <nico@cam.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 14:33:11 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702211414410.31945@xanadu.home>
References: <20070221164527.GA8513@ginosko.local>
 <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
 <7vy7mrnxlo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 21 20:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJxDI-00025b-GB
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 20:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422827AbXBUTdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 14:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbXBUTdN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 14:33:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39803 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422827AbXBUTdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 14:33:12 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDT00IQ4VNBPD20@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Feb 2007 14:33:11 -0500 (EST)
In-reply-to: <7vy7mrnxlo.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40321>

On Wed, 21 Feb 2007, Junio C Hamano wrote:

> While I agree in principle to the argument that there is no
> taking it back what's already published, I've heard people
> wanting to just stop distributing further, without worrying
> about copies already out there.  'missing objects' support would
> help us in such a situation.

I still think this is a "put your head in the sand and pretend that some 
sensitive data never existed in the wild" attitude.  And I really don't 
see the point of supporting that illusion in GIT with technical means.

Either you care about published data or you don't.

If you do then you are screwed anyway irrespective of any missing object 
support we might implement.  There will always be someone somewhere with 
the real thing, and we all know how faster forbidden material does travel 
on the Internet.

If you don't then it is just better to rewrite history and have a clean 
and unambiguous repository.  And because you don't care about existing 
copies you shouldn't bother with the fact that the rewritten repo is not 
compatible with the previously published one.

Sure rewriting history is a potentially expensive operation depending on 
the size and nature of the change, but it is done only once.  And 
actually it can't be _that_ much expensive than a git-repack -a -f.

I think it is much better to provide a tool to properly rewrite history 
than adding support for missing objects and be stuck with them forever.


Nicolas
