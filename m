From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 00:27:52 -0400
Message-ID: <20071023042752.GY14735@spearce.org>
References: <20071016060456.GC13801@spearce.org> <Pine.LNX.4.64.0710161209480.25221@racer.site> <20071016195744.GB32132@closure.lan> <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org> <20071023012140.GC22997@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBNC-0008Q6-Gx
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbXJWE17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbXJWE17
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:27:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39194 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbXJWE16 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:27:58 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkBMx-0001BW-3w; Tue, 23 Oct 2007 00:27:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5D53F20FBAE; Tue, 23 Oct 2007 00:27:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071023012140.GC22997@thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62082>

Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Oct 22, 2007 at 06:15:09PM -0700, Junio C Hamano wrote:
> > 
> > Sorry, WI is for "what's in", WC is for "what's cooking".  I
> > should remove PU and RB from there.
> 
> I assume PU is what you used to build your proposed-update branch?

Actually I found PU of some use:

	git branch -f pu next
	git checkout pu
	./Meta/PU --continue

its a little sluggish to list, but made it pretty easy to pick
topics for merging into pu.  git-rerere really makes it easy to
recover conflicts in pu during future rebuilds of pu.

> based off of master, and then merged into next.  Or maybe I'm not
> understanding how to make the WC and git-topic.perl script work and
> sing for me perfectly?

The other tidbits I managed to learn by trial and error here was
to make sure I did the following:

	- make sure master is fully merged into next
	- make sure next is fully merged into pu
	- Run "Meta/git-topic.perl --base=master | less"

It wasn't uncommon for me to merge master->next, next->pu, run
git-topic, then reset both next and pu *back* to what I had last
published (remote tracking branches updated during push make this
easy) before moving on with my next and pu updating activities.

Of course take my notes above with a grain of salt; I only worked
this way for a week and it took me a couple of days to come up with
the above.  Junio may very well have it streamlined even more.

-- 
Shawn.
