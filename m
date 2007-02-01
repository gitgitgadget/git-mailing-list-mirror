From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Thu, 1 Feb 2007 14:24:32 -0500
Message-ID: <20070201192432.GD18608@spearce.org>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl> <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C14563.8060707@verizon.net> <7vk5z2r27s.fsf@assigned-by-dhcp.cox.net> <m264am5u1r.fsf@gmail.com> <81b0412b0702010003t7becddf3x8fe6b36b0d84599b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sethfalcon@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Mark Levedahl <mdl123@verizon.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 20:24:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HChY3-0001vG-6y
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 20:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422962AbXBATYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 14:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422964AbXBATYk
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 14:24:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39678 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422962AbXBATYj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 14:24:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HChXn-0008WO-Ri; Thu, 01 Feb 2007 14:24:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AE36020FBAE; Thu,  1 Feb 2007 14:24:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0702010003t7becddf3x8fe6b36b0d84599b@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38392>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 2/1/07, Seth Falcon <sethfalcon@gmail.com> wrote:
> >
> >> I am not in X right now and won't be able to look at it myself
> >> tonight.  Could folks on MacOS comment on Mark's patch?
> >
> >I gave it a quick spin on OS X.  gitk loads with a different geometry
> >than it had before, but seems to work the same.  If this fixes things
> >elsewhere, it seems fine here.
> >
> 
> FWIW, I confirm that. Much better. Mouse selection still does not
> work in patch pane, but broken layout was the most annoying.

The trick to getting mouse selection to work on Mac OS X on a
disabled text field (which is what that patch pane is):

	bind $damn_text_widget <Button-1> [list focus $damn_text_widget]

Apparently the disabled text widgets on Mac OS X don't receive
focus unless its forced by the application.  :-(

This trick doesn't harm a Tk application running on Windows, its
safe to just always setup the binding.  I'm using it in git-gui
for the diff pane.

-- 
Shawn.
