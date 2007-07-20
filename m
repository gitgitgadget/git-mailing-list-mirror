From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Fri, 20 Jul 2007 00:59:09 -0400
Message-ID: <20070720045909.GM32566@spearce.org>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site> <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vejj96igx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707190258550.14781@racer.site> <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org> <7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net> <7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 06:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBkaI-0006ua-Qy
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 06:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbXGTE7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 00:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbXGTE7U
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 00:59:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49405 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbXGTE7T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 00:59:19 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IBka8-0001EG-2n; Fri, 20 Jul 2007 00:59:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 660D620FBAE; Fri, 20 Jul 2007 00:59:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53051>

Junio C Hamano <gitster@pobox.com> wrote:
> I've long time ago concluded that if we care about reliability
> (and we do very much), a bisectable tree without breaking
> backward compatibility is impossible.  I was hoping to find a
> "hole" in tree object format so that I can place an extended
> section that is invisible to older versions of git, and place a
> table that records offsets of each tree entries to help
> bisection and/or perhaps a hash table to help look-up, but I do
> not think it is possible.
...
> But the tree object format
> is designed so tight that I do not see there is any place to put
> an extension section.

I came to the same conclusion the last time I thought about this
problem, for all the same reasons you outlined.  And came up with
pack v4.  Because the only way I could see that we could produce
a more optimal tree was to just use a different *compression* of
the tree, while still keeping its data the same.  Nico seemed to
agree at the time, because he worked on the prototype with me.  :-)

Its still hanging around in my fastimport repository.  But has not
been merged with any recent Git, and it still needs a lot of work.

-- 
Shawn.
