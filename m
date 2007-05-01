From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Tue, 1 May 2007 19:42:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705011939590.4010@racer.site>
References: <463678B7.70409@gmail.com> <7v7irt9qm1.fsf@assigned-by-dhcp.cox.net>
 <200705010926.35265.andyparkins@gmail.com> <7virbc7vue.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0705011044210.6574@xanadu.home> <7vps5k5uzt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 19:42:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiwNC-0005du-3F
	for gcvg-git@gmane.org; Tue, 01 May 2007 19:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbXEARmm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 13:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755076AbXEARmm
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 13:42:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:39273 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755073AbXEARml (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 13:42:41 -0400
Received: (qmail invoked by alias); 01 May 2007 17:42:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 01 May 2007 19:42:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+s8mIAeuKsHtZy5bsNA2WQGftU9b4mpdYJvKqd42
	iCSAVadTBTnBUM
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps5k5uzt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45962>

Hi,

On Tue, 1 May 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Tue, 1 May 2007, Junio C Hamano wrote:
> >
> >> I was not sure if that is even a good idea, and I am now
> >> inclined to think that keeping the failed attempt history is
> >> probably better than potentially causing confusion to people who
> >> follow 'next'.  But it _is_ a possibility to reset 'next' to
> >> 'master'.
> >
> > And what is the advantage of doing that, exactly?
> 
> Not much and that is why I am not sure if that is a good idea,
> but one thing is:
> 
> 	$ git log master..next
> 	$ git log --no-merges master..next
> 
> would start showing what are still pending in next without
> noise.

Of course, you could graft a fake relationship there. Something like

echo $(git rev-parse master master^ next) >> .git/info/grafts

should do. And you can do it _locally_, since all you care about is the 
higher-level relationship that _you_ know about. And this is the way to 
teach Git about it.

Ciao,
Dscho
