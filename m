From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 03:29:45 -0400
Message-ID: <20070524072945.GO28023@spearce.org>
References: <11799589913153-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0705240039370.4113@racer.site> <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net> <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 09:30:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7ln-00045b-5g
	for gcvg-git@gmane.org; Thu, 24 May 2007 09:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbXEXH34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 03:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbXEXH34
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 03:29:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58106 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbXEXH3z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 03:29:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hr7la-0003bs-K5; Thu, 24 May 2007 03:29:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 04C4D20FBAE; Thu, 24 May 2007 03:29:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48235>

Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Wed, May 23, 2007 at 05:50:42PM -0700, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > > I am sorry to complain so late in the game, but I am not really interested 
> > > in submodules. However, what you say here is not a task for git-config 
> > > IMHO, but rather for git-remote.
> > 
> > Honestly speaking, I do not think people have no business
> > peeking into configuratoin remote repository has, and it would
> > be preferrable that supermodule Porcelain stuff does not rely on
> > that.
> 
> Maybe there are too many negations in that sentence, but are you
> saying it is ok to look into the remote configuration or not?

I think its OK to look at *your* .git/config to see what is
configured for the remotes, (e.g. git config remote.origin.url)
but it is NOT OK to look at the *remote*'s .git/config to see what
they have configured.

Why?  Their configuration is their configuration.  Who knows what
they have stored there.  Look at the recent cvsserver config options,
there's now a lot of information about the SQL database that backs
cvsserver.  That stuff shouldn't be public.

If you want to publish something for a client to fetch, it should
be done by publishing a Git object referenced by a proper ref:
blob, tree, commit, tag, take your pick.

-- 
Shawn.
