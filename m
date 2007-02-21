From: Nicolas Pitre <nico@cam.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 15:49:33 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702211531060.31945@xanadu.home>
References: <20070221164527.GA8513@ginosko.local>
 <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
 <7vy7mrnxlo.fsf@assigned-by-dhcp.cox.net>
 <alpine.LRH.0.82.0702211414410.31945@xanadu.home>
 <7vbqjnntut.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 21 21:49:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJyPC-00061N-0Y
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 21:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161337AbXBUUtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 15:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbXBUUtg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 15:49:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:12757 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161337AbXBUUtf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 15:49:35 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDT007ZQZ6LY3N0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Feb 2007 15:49:34 -0500 (EST)
In-reply-to: <7vbqjnntut.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40324>

On Wed, 21 Feb 2007, Junio C Hamano wrote:

> Well, I think we are in agreement (and that is why I said "I've
> heard people wanting").
> 
> But it is entirely possible that somebody has a project that is
> internal to a company managed for a long time with git, that he
> wants to go open source, with (almost) full history.  And the
> project may have some proprietary add-on bit which cannot be
> published, while building the public bits does not require that
> part.  Stubbing things out may help that kind of situation.

It might help, or it might create a management nightmare.  It would be 
really easy to accidentally push the real objects out since a repo with 
them would be indistinguishable from a repo with stubs (that's the 
point of stub objects isn't it?), and because of the distributed nature 
of GIT the leak could come from anyone with access to the private 
objects.

In such a scenario I think it is still more sensible to rewrite the repo 
history before going open source.  You need only to worry about 
isolating the proprietary stuff once.


Nicolas
