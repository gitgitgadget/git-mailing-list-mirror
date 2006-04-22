From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 15:58:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604221556170.2215@localhost.localdomain>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
 <Pine.LNX.4.64.0604212308080.2215@localhost.localdomain>
 <A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com>
 <7v7j5hkglq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604220835190.2215@localhost.localdomain>
 <7vslo5ikmk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Geert Bosch <bosch@adacore.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 21:58:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXOFf-00064H-N3
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 21:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWDVT6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 15:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWDVT6k
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 15:58:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:4606 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751110AbWDVT6k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Apr 2006 15:58:40 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY5001HS3HRF6E0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 22 Apr 2006 15:58:39 -0400 (EDT)
In-reply-to: <7vslo5ikmk.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19049>

On Sat, 22 Apr 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Well, actually I was measuring a 10% speed improvement with a quick and 
> > naive (not memory efficient) approach for pack-objects with the current 
> > algorithm.
> >...
> > The idea to avoid memory pressure is to reverse the window processing 
> > such that the object to delta against is constant for the entire window 
> > instead of the current logic where the target object is constant.  This 
> > way there would be only one index in memory at all time.
> 
> Your are right.  The first led to the latter unexplored idea.
> 
> I expect to be offline most of the day today, and have other
> things I can work on for the next few days anyway, so if you or
> somebody else have an inclination and energy to reverse the
> delta window, I would appreciate that.

I'll probably give it a try.

I'm still reviewing Geert's code right now and found minor things 
pertaining to the GIT delta encoding here and there which probably 
explain why it doesn't pack the Linux kernel archive yet.


Nicolas
