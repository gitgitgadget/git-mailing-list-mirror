From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Submodules
Date: Thu, 09 Aug 2007 07:44:19 +0200
Message-ID: <20070809054419.GT999MdfPADPa@greensroom.kotnet.org>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
 <7vhcn94y9l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0708082138520.21916@wbgn129.biozentrum.uni-wuerzburg.de>
 <200708082147.57822.andyparkins@gmail.com>
 <Pine.LNX.4.64.0708082211100.21857@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 07:44:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ0os-0005Jm-So
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 07:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763032AbXHIFoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 01:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762951AbXHIFoW
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 01:44:22 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:50455 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762050AbXHIFoV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 01:44:21 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMH00GRYRXV2H@psmtp09.wxs.nl> for git@vger.kernel.org; Thu,
 09 Aug 2007 07:44:20 +0200 (MEST)
Received: (qmail 6343 invoked by uid 500); Thu, 09 Aug 2007 05:44:19 +0000
In-reply-to: <Pine.LNX.4.64.0708082211100.21857@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55408>

On Wed, Aug 08, 2007 at 10:12:52PM +0100, Johannes Schindelin wrote:
> This is what I did.  I cloned msysgit.git, which contains one submodule.  
> To initialise that, I did "git submodule init" and "git submodule update".  
> It went and cloned the submodule.  Fine.
> 
> Then I committed in the submodule, a well-needed fix.
> 
> If I now go to the superproject again, and say "git submodule status", it 
> will not find the newest commit, and complain that it cannot access that 
> object.

There must be something else you're not telling us.
This procedure works just fine for me

bash-3.00$ git clone git://repo.or.cz/msysgit.git
Initialized empty Git repository in /home/skimo/git/msysgit/.git/
remote: Generating pack...
remote: Done counting 1857 objects.
remote: Deltifying 1857 objects...
remote:  100% (1857/1857) done
Indexing 1857 objects...
remote: Total 1857 (delta 475), reused 1857 (delta 475)
 100% (1857/1857) done
Resolving 475 deltas...
 100% (475/475) done
bash-3.00$ cd msysgit/
bash-3.00$ git submodule init
Submodule 'git' (git://repo.or.cz/git/mingw/4msysgit.git/) registered for path 'git'
bash-3.00$ git submodule update
Initialized empty Git repository in /home/skimo/git/msysgit/git/.git/
remote: Generating pack...
remote: Done counting 58074 objects.
remote: Deltifying 58074 objects...
remote:  100% (58074/58074) done
Indexing 58074 objects...
remote: Total 58074 (delta 40790), reused 55132 (delta 37853)
 100% (58074/58074) done
Resolving 40790 deltas...
 100% (40790/40790) done
Submodule path 'git': checked out 'f1e1dc5119bd9862bb4d2a975c8ca6362ea43af5'
bash-3.00$ cd git/
bash-3.00$ touch a; git add a; git commit -m 'add a'
Created commit 5318784: add a
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
bash-3.00$ cd ..
bash-3.00$ git submodule status
+5318784e6d492d988284a4d9aa4025496f2a3309 git (v1.5.3-rc2-690-g5318784)

skimo
