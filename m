From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 12:00:30 +0200
Message-ID: <20070525100030.GB942MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.64.0705241201270.4648@racer.site>
 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site>
 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
 <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
 <20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241908040.4648@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Lars Hjemli <hjemli@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 12:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrWbE-0002Tw-4N
	for gcvg-git@gmane.org; Fri, 25 May 2007 12:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbXEYKAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 06:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXEYKAd
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 06:00:33 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:59805 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbXEYKAc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 06:00:32 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIL001WJD4VT5@smtp17.wxs.nl> for git@vger.kernel.org; Fri,
 25 May 2007 12:00:31 +0200 (CEST)
Received: (qmail 14682 invoked by uid 500); Fri, 25 May 2007 10:00:30 +0000
In-reply-to: <Pine.LNX.4.64.0705241908040.4648@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48352>

I'm obviously not going to stop anyone from putting URLs in .gitmodules
and I can see that it would be useful in practice, but I still think
that it doesn't matter where the submodule was located at any
given point in history (from the point of view of the superproject).
It only matters where the submodule is located now.

You may be bisecting a problem and you may need to clone a submodule
for a point in history when the submodule was placed somewhere else.
(You may not have had a need to checkout the submodule before,
or it may simply not be used in the current version of the supermodule.)
So, I think it would still be useful to have an optional additional
out-of-tree mechanism of getting usable URLs if the URLs in .gitmodules
or your local config don't work.

On Thu, May 24, 2007 at 07:11:31PM +0100, Johannes Schindelin wrote:
> On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > If you allow an override, then I don't see how having the initial
> > information in the tree is any better.
> 
> Isn't that obvious? _Most_ people will _not_ override the information.

You may be asked to.

	"Please clone from a mirror close to you and after cloning,
	 please change the URLs of these 54 submodules to a mirror
	 close to you."

> Plus, it is an easy solution to your problem, without having to touch a 
> lot of real core parts of Git. Simple is beautiful. And less buggy.

I'll take your word for it.

> > He needs to modify .gitmodules, but when the changes go upstream,
> > this .gitmodules changes get merged as well.
> 
> If you change the superproject, that is.

That's what I meant.  Plus, other users may want to pull from such forks too.

skimo
