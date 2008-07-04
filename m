From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Fri, 4 Jul 2008 03:06:16 +0200
Message-ID: <20080704010616.GH6677@leksak.fem-net>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 03:07:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEZlf-0000Sg-JB
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 03:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYGDBGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 21:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbYGDBGW
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 21:06:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:39751 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753489AbYGDBGV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 21:06:21 -0400
Received: (qmail invoked by alias); 04 Jul 2008 01:06:20 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp011) with SMTP; 04 Jul 2008 03:06:20 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+QEwU1232QnwbL2/EJAT1qp9Allpxrva/AGJ0mpE
	hAA78s9RZjdhw2
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEZke-0001o1-Dm; Fri, 04 Jul 2008 03:06:16 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87352>

Hi again,

Johannes Schindelin wrote:
> > > I'd not check in sequencer for the strategy.  Especially given that we 
> > > want to support user-written strategies in the future.
> > 
> > I don't know how this is planned to look like, but perhaps 
> > --list-strategies may make sense here, too.

Funny, a merge with an unknown merge strategy acts somehow like my
proposed --list-strategies (at least on git-merge.sh, haven't checked
on builtin-merge)
But that is just a silly side note.

> No.  You just do not check for strategies.  Period.

Well, I've seen that my strategy_check (which is now removed) only
produces a warning, so it had no big effect at all.
So I've tested merge --strategy=hours (to simulate a typo):

-- -- snip paste -- --
Testing:
        git sequencer todotest1

available strategies are: recur recursive octopus resolve stupid ours subtree
Error merging
* FAIL 33: merge multiple branches and --reuse-commit works
-- -- snap paste -- --

That means, with the information that can be seen, a user should easily be
able to fix that, i.e. run git-sequencer --edit and fix the line.

So I accept your period sign now ;-)

> and you can easily abort a rebase if you explicitely asked for an invalid 
> strategy.

Aborting after fixing a lot of conflicts in the sequencer process is
really annoying.  So I've chosen to never abort automatically.
(That was one of the first things that I changed after I first used my
own sequencer for real work and not only test cases.)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
