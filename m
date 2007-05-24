From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 13:43:54 +0200
Message-ID: <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
 <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
 <20070524072945.GO28023@spearce.org>
 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site>
 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site>
 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 13:44:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrBje-0000L3-2y
	for gcvg-git@gmane.org; Thu, 24 May 2007 13:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbXEXLn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 07:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755904AbXEXLn5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 07:43:57 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:47957 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755888AbXEXLn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 07:43:56 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIJ00AREN96UF@psmtp08.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 13:43:55 +0200 (MEST)
Received: (qmail 2750 invoked by uid 500); Thu, 24 May 2007 11:43:54 +0000
In-reply-to: <Pine.LNX.4.64.0705241230410.4648@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48247>

On Thu, May 24, 2007 at 12:31:33PM +0100, Johannes Schindelin wrote:
> On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > OK... so what should git-update-server-info put in this file for submodules?
> > Or, equivalently, what should be the output of ls-remote?
> > 
> > Right now its a list of pairs of revs(sha1) and refs.
> > For submodules we want a connection between a submodule name
> > and one or more URLs where the submodule can be found.
> > How are you going to squeeze that into info/refs without confusing
> > older versions of git?
> 
> I wonder if the "ref^{blub}" syntax could be used for that: change "blub" 
> to the URL, or "sub:URL" or something.

Just to be clear, would it look like the following?

e8a6e39ecfbd391a54b9c3329fd3c6e33d745abd	refs/heads/bernstein
c5c64e3fe48302f0c4581985f9c68d615f7bcb4e	refs/heads/master
3fa7ded19a8da868d3af7c942f86358e6720f0c7	refs/heads/submodule
/home/sverdool/public_html/cloog.git	cloog^{URL}
http://www.liacs.nl/~sverdool/cloog.git	cloog^{URL}

Is there no code out there that expects the "rev" part to be
exactly 40 characters?
Or do you propose we put the URL in a blob and put the object sha1
in there.  If so, who's going to create these blobs for the git://
and ssh:// protocols?  upload-pack?

Thanks for the discussion, btw.
I hope we can come up with something that's acceptable to everyone.

skimo
