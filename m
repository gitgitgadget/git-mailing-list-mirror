From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 17:43:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251737570.4648@racer.site>
References: <Pine.LNX.4.64.0705241230410.4648@racer.site>
 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
 <7vabvuywix.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
 <20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241908040.4648@racer.site> <20070525100030.GB942MdfPADPa@greensroom.kotnet.org>
 <7vabvsswtd.fsf@assigned-by-dhcp.cox.net> <20070525162838.GI942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Lars Hjemli <hjemli@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri May 25 18:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrcta-0003n3-Jw
	for gcvg-git@gmane.org; Fri, 25 May 2007 18:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbXEYQoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 12:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756182AbXEYQn7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 12:43:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:32866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751915AbXEYQn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 12:43:59 -0400
Received: (qmail invoked by alias); 25 May 2007 16:43:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 25 May 2007 18:43:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dO0VzUKSdw5U0638Zff+EshzI4G9gQLi770xWtW
	YY0z1H4LnJrpr6
X-X-Sender: gene099@racer.site
In-Reply-To: <20070525162838.GI942MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48395>

Hi,

On Fri, 25 May 2007, Sven Verdoolaege wrote:

> On Fri, May 25, 2007 at 09:16:30AM -0700, Junio C Hamano wrote:
> > Sven Verdoolaege <skimo@kotnet.org> writes:
> > > So, I think it would still be useful to have an optional additional
> > > out-of-tree mechanism of getting usable URLs if the URLs in .gitmodules
> > > or your local config don't work.
> > 
> > I thought that was already solved in my original two-level
> > strawman and can naturally be extended to the three-level
> > strawman.  What am I missing?
> 
> Maybe I'm missing something but you only seem to talk about .gitmodules
> and local config there, while this would be a way of automatically getting
> URLs that are either not available in .gitmodules or the local config
> or are outdated or should be overridden.

I do not see what you're getting at.

Either you want to fetch the URLs from an upstream, in which case they 
should be fetched. Why not in ".gitmodules"? If the URLs don't work, you 
should blame the maintainer, not fsck up the tool.

Or you want some sort of "fallback" set of URLs. I cannot think of any 
reasonable use case here.

Or you want to receive overrides, such as when a submodule has moved, so 
that it still works when you check out older versions (and do not have the 
objects locally already). But to make such overrides automatic wreaks 
havoc IMHO.

Also, this is rare enough that I'd rather not fsck up an elegant solution, 
where you have to treat such special cases manually, for something which 
affects "normal" users, which just track the project.

Maybe I'm wrong. But then, Josef is right, we can talk about that later. 
It's not like you need a feature like that from day one.

Ciao,
Dscho
