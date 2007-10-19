From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [BUG] git remote add failure
Date: Thu, 18 Oct 2007 20:20:17 -0400
Message-ID: <20071019002017.GP14735@spearce.org>
References: <1192697719.31199.1216526739@webmail.messagingengine.com> <Pine.LNX.4.64.0710181708230.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:20:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IifbN-0006cB-L4
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbXJSAUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbXJSAUX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:20:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39041 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbXJSAUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 20:20:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iifav-0007nc-8g; Thu, 18 Oct 2007 20:20:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D9DCA20FBAE; Thu, 18 Oct 2007 20:20:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710181708230.25221@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61580>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 18 Oct 2007, Guido Ostkamp wrote:
> 
> > I think I've found a bug in "git remote add". I tried the following:
> > 
> > $ git remote add -f spearce2 http://repo.or.cz/git/spearce.git
> > Cannot get the repository state from http://repo.or.cz/git/spearce.git
> > fetch spearce2: command returned error: 1
> > 
> > Obviously I used the wrong URI. Then I tried again:
> > 
> > $ git remote add -f spearce2 http://repo.or.cz/r/git/spearce.git
> > remote spearce2 already exists.
> > 
> > I think Git should not store the bad info and block the name when the
> > first call wasn't successfull.
> 
> The problem there is of course that the fetch could fail because you are 
> offline.  In that case, you do not want git remote to throw the 
> information away.

Right.  But maybe there should be an easier way for the user to
"force" adding the remote over the existing remote.  Much like how
they can force creating a branch over an existing branch.

Too bad -f is already taken.  :-\

-- 
Shawn.
