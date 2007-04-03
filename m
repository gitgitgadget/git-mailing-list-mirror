From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 18:34:04 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031832380.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031657130.28181@xanadu.home>
 <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031735470.28181@xanadu.home>
 <7vodm5un61.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:34:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrZt-0006Q9-1Z
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992440AbXDCWeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992438AbXDCWeJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:34:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47593 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992440AbXDCWeI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:34:08 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFY00CYX1CUOJ50@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 18:34:07 -0400 (EDT)
In-reply-to: <7vodm5un61.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43683>

On Tue, 3 Apr 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Make it conditionnal on --stdin then.  This covers all cases where we 
> > really want the secure thing to happen, and the --stdin case already 
> > perform the atomic rename-and-move thing when the pack is fully indexed.
> 
> Repacking objects in a repository uses pack-objects without
> using index-pack, as you suggested Chris.  Is there a sane usage
> of index-pack that does not use --stdin?  I do not think of any.
> 
> If there isn't, the "conditional on --stdin" suggestion means we
> unconditionally do the secure thing for all the sane usage, and
> go unsecure for an insane usage that we do not really care about.
> 
> If so, it seems to me that it would be the simplest not to touch
> the code at all, except that missing free().

That's exactly what I think as well.

> Am I missing something?

Not from my point of view.


Nicolas
