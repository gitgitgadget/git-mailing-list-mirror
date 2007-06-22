From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 2/2] Teach git-blame --gui how to start git-gui blame
Date: Fri, 22 Jun 2007 01:37:02 -0400
Message-ID: <20070622053702.GH17393@spearce.org>
References: <20070621045333.GB13977@spearce.org> <7vtzt13k4o.fsf@assigned-by-dhcp.pobox.com> <20070622035652.GD17393@spearce.org> <7vzm2sab63.fsf@assigned-by-dhcp.pobox.com> <20070622044716.GG17393@spearce.org> <7vps3oa7kf.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 07:37:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1bpW-0002TA-Ao
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 07:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbXFVFhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 01:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbXFVFhI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 01:37:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47705 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbXFVFhH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 01:37:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1bpQ-000128-Kz; Fri, 22 Jun 2007 01:37:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0987F20FBAE; Fri, 22 Jun 2007 01:37:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vps3oa7kf.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50678>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> This is only minor nuisance, but can we do something about this?
> >> 
> >>  $ git gui --version
> >>  Application initialization failed: no display name and no $DISPLAY environment variable
> >> 
> >> I know it is from wish, not you, so I wouldn't insist, though.
> 
> If this makes life any harder to people on Windows, especially
> minGW, I would suggest against it.

Its already done.  I don't think it will make a difference either
way right now.

Currently we still have to have a Bourne shell on both Cygwin
and MINGW platforms to perform key actions, like say git-clone.
The startup cost of git-gui is also rather high there anyway, so
this extra if test in Bourne shell before we exec into Tcl isn't
going to kill us.

Besides, you can side-step the entire Bourne shell thing by just
starting git-gui in wish yourself.  E.g.

  CALL /path/to/wish.exe /path/to/git-gui -- ...


I'd like to come back and make git-gui easier to install, perhaps by
making "starpacks" of git-gui and Git plumbing available for some
popular systems (e.g. MINGW/Windows, Mac OS X).  Such starpacks
would give users an easy way to get git-gui (and thus basic Git)
up and running quickly.  At that point I will need to revisit this
bootstrap code anyway.

-- 
Shawn.
