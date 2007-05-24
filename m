From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 13:16:45 +0200
Message-ID: <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
References: <11799589913153-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net>
 <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
 <20070524072945.GO28023@spearce.org>
 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site>
 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 13:16:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrBJM-00040B-6a
	for gcvg-git@gmane.org; Thu, 24 May 2007 13:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802AbXEXLQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 07:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755767AbXEXLQs
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 07:16:48 -0400
Received: from smtp13.wxs.nl ([195.121.247.4]:35225 "EHLO smtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888AbXEXLQr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 07:16:47 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JIJ00GTMLZX4H@smtp13.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 13:16:46 +0200 (CEST)
Received: (qmail 7474 invoked by uid 500); Thu, 24 May 2007 11:16:45 +0000
In-reply-to: <Pine.LNX.4.64.0705241201270.4648@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48245>

On Thu, May 24, 2007 at 12:02:41PM +0100, Johannes Schindelin wrote:
> On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > On Thu, May 24, 2007 at 10:41:30AM +0100, Johannes Schindelin wrote:
> > > I could imagine this to be another extension of ls-remote.
> > 
> > You mean extending upload-pack ?  Junio mentioned this possibility as well.
> > This only solves the git:// and ssh:// case though.
> > What to do with the other protocols?
> 
> As we do for the refs: put it into .git/info/refs. This file is already 
> meant to "cache" the output of ls-remote for dumb protocols.

OK... so what should git-update-server-info put in this file for submodules?
Or, equivalently, what should be the output of ls-remote?

Right now its a list of pairs of revs(sha1) and refs.
For submodules we want a connection between a submodule name
and one or more URLs where the submodule can be found.
How are you going to squeeze that into info/refs without confusing
older versions of git?

skimo
