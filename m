From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Thu, 12 Oct 2006 20:39:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610122038330.2435@xanadu.home>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
 <20061012201646.GC10922@admingilde.org>
 <d620685f0610121437m38eb454g7597b2a93010b023@mail.gmail.com>
 <452EBF99.5020108@gmail.com> <20061012222703.GA31152@admingilde.org>
 <452EC625.7050301@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Waitz <tali@admingilde.org>, apodtele <apodtele@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 02:43:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYB5M-0003Gd-GU
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 02:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWJMAjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 20:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWJMAjc
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 20:39:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30665 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751390AbWJMAjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 20:39:31 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7100963TTU1FJ0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Oct 2006 20:39:31 -0400 (EDT)
In-reply-to: <452EC625.7050301@gmail.com>
X-X-Sender: nico@xanadu.home
To: A Large Angry SCM <gitzilla@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28824>

On Thu, 12 Oct 2006, A Large Angry SCM wrote:

> Martin Waitz wrote:
> > On Thu, Oct 12, 2006 at 03:20:09PM -0700, A Large Angry SCM wrote:
> > > > +    if (it)
> > > > +        return it * width / (it + width) + 1;
> > > > +    else
> > > > +        return 0;
> > > No conditional needed:
> > >
> > >  return it * width / (it + width - 1)
> > 
> > But then it would start scaling much earlier
> > (for width 10: at 2 instead of 4).
> > This is not bad per se, but different...
> > 
> 
> OK:
> 	return (it * width + (it + width)/2)) / (it + width - 1)
> 
> Now it's back at 4. ;-)

Sure, but at this point the original conditional is probably more 
efficient.


Nicolas
