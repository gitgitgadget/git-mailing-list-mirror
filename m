From: Nicolas Pitre <nico@cam.org>
Subject: Re: observations on parsecvs testing
Date: Thu, 15 Jun 2006 16:55:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606151653440.16002@localhost.localdomain>
References: <Pine.LNX.4.64.0606151529350.16002@localhost.localdomain>
 <BAYC1-PASMTP10021C1A6034B8753D06DDAE820@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: keithp@keithp.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 15 22:56:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqysY-0007Kg-6u
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 22:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031351AbWFOUzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 16:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031350AbWFOUzj
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 16:55:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20982 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1031349AbWFOUzi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 16:55:38 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0X00HAS64QG200@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Jun 2006 16:55:38 -0400 (EDT)
In-reply-to: <BAYC1-PASMTP10021C1A6034B8753D06DDAE820@CEZ.ICE>
X-X-Sender: nico@localhost.localdomain
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21913>

On Thu, 15 Jun 2006, Sean wrote:

> On Thu, 15 Jun 2006 16:37:30 -0400 (EDT)
> Nicolas Pitre <nico@cam.org> wrote:
> 
> > Also rcs2git() is very inefficient especially with files having many 
> > revisions as it reconstructs the delta chain on every call.  For example 
> > mozilla/configure,v has at least 1690 revisions, and actually converting 
> > it into GIT blobs goes at a rate of 2.4 objects per second _only_ on my 
> > machine.  Can't objects be created as the delta list is walked/applied 
> > instead?  That would significantly reduce the initial convertion time.
> 
> Hi Nicolas,
> 
> That was a planned optimization which I did mention to Keith previously.
> Was kinda waiting to hear back how it was working for him, and if there
> was an interest to put more work into it to include in his mainline.

I think it is really worth it.  I'd expect the first half of the 
convertion to go significantly faster then.


Nicolas
