From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Initial support for cloning submodules
Date: Fri, 18 May 2007 21:33:08 +0200
Message-ID: <20070518193308.GJ942MdfPADPa@greensroom.kotnet.org>
References: <11782762032207-git-send-email-skimo@liacs.nl>
 <7vfy6cqk0w.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:33:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp8Co-0004Bw-T0
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760755AbXERTdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760329AbXERTdM
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:33:12 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:36829 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759936AbXERTdK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:33:10 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JI9002E34Z8VM@psmtp08.wxs.nl> for git@vger.kernel.org; Fri,
 18 May 2007 21:33:08 +0200 (MEST)
Received: (qmail 10528 invoked by uid 500); Fri, 18 May 2007 19:33:08 +0000
In-reply-to: <7vfy6cqk0w.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47653>

On Fri, May 04, 2007 at 03:52:15PM -0700, Junio C Hamano wrote:
>  (3) "git-fetch --submodules", after finishing what it would do
>      without "--submodules" option, would inspect the fetched
>      tree (or the index derived from it), find the tree entries
>      with mode 160000 (i.e. submodule graft points), and _then_
>      uses the pathnames of these tree entries to consult the
>      config mechanism to see which URL(s) can be used to
>      retrieve them, probably only for new submodules.

I've gone for cloning all available submodules on the remote,
even if they are not used in the HEAD.
A submodule may have been removed already and IMHO, you wouldn't
want to clone a submodule at the time you reset to an intermediate
commit.

skimo
