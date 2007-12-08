From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: dmalloc and leaks in git
Date: Sat, 8 Dec 2007 21:19:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712082118210.27959@racer.site>
References: <9e4733910712081253t7cd43f87o6001f32fddc01565@mail.gmail.com> 
 <Pine.LNX.4.64.0712082058280.27959@racer.site>
 <9e4733910712081302h64d9b062kad02c4f13818d59f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 22:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J176E-0004P2-Px
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 22:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbXLHVUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 16:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbXLHVUI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 16:20:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:45553 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751012AbXLHVUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 16:20:06 -0500
Received: (qmail invoked by alias); 08 Dec 2007 21:20:04 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 08 Dec 2007 22:20:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+POPBQM4ePGOjMU9P+PEkzRvptVRiKq1WdvbyTl0
	JONeCNYgZdC4s9
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910712081302h64d9b062kad02c4f13818d59f@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67571>

Hi,

On Sat, 8 Dec 2007, Jon Smirl wrote:

> On 12/8/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Sat, 8 Dec 2007, Jon Smirl wrote:
> >
> > > It is very easy to use dmalloc with git. Follow the instructions here,
> > > http://dmalloc.com/docs/latest/online/dmalloc_4.html
> > >
> > > But using dmalloc shows a pervasive problem, none of the git commands
> > > are cleaning up after themselves. For example I ran a simple command,
> > > git-status, and thousands of objects were not freed.
> >
> > Known problem.  Goes by the name of "libification" on this list.
> 
> I tried using dmalloc to find the leak in repack but it is impossible
> to sort out the accidental leaks from the on-purpose ones. On exit
> there were millions of unfreed objects coming from all over the place.

This might be a starting point:

http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=2083418c5010f04fbcd6e1f67de522ad6acd863d

Hth,
Dscho
