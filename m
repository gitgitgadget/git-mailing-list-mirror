From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: read-for-fill and caching in gitweb (Re: kernel.org mirroring)
Date: Fri, 29 Dec 2006 19:31:56 +0000
Message-ID: <20061229193156.GG6558@localhost>
References: <46a038f90612281245s52bdd868h8c421951c7abeb84@mail.gmail.com> <20061229032126.GE6558@localhost> <200612291140.46909.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Fitzsimons <robfitz@273k.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jeff@garzik.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 29 20:32:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0NSm-0000WS-FG
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 20:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWL2TcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 14:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWL2TcO
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 14:32:14 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:38268 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965125AbWL2TcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 14:32:13 -0500
Received: from 213-202-135-153.bas502.dsl.esat.net ([213.202.135.153] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1H0NRz-0004d4-AT; Fri, 29 Dec 2006 19:31:31 +0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200612291140.46909.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35604>

> >                  project_list   summary  shortlog        log
> > v267                  173 1.6  1141 8.8   795 5.0   919  1.9
> > 1.4.4.3               220 2.3   397 2.4   930 4.2  1113 56.9
> > 1.5.0.rc0.g4a4d       226 1.9   292 1.7   352 4.0   491  6.7
> > 1.5.0.rc0.g4a4d        60 1.0   131 0.7   195 1.2   347  3.7
> > (mod_perl)

> It is simply the case that new features cost more. Namely in earlier
> versions of gitweb Last Change time was taken from HEAD (from current
> branch), in newer we check all branches (using git-for-each-ref).
> For published public repository it migh make sense to pack also heads
> (make them packed refs).
>
> I was thinking about making this a gitweb %feature, allowing gitweb
> administrator to chose if Last Change is taken from all branches
> (as it is now), from HEAD (as it was before), or from given branch
> (for example master).

I've sent a separate email with a patch to add this feature.
("[PATCH] gitweb: New feature last_modified_ref."
<20061229185805.GF6558@localhost>).

Here are the new numbers.  Notes: I've only got 3 projects in my project
list and I did a 'git gc' on them since yesterday.

                 project_list    summary   shortlog         log

v267                 174  1.1   286  2.1   794  3.4    921  3.2
1.4.4.3              207  1.7   383  2.0   921  5.2   1082  3.8
g04509 + patch       213  1.6   297 68.9   341  3.9    484  5.0
g04509 + patch        71 69.9   117  2.5   190  2.1    341  2.7
(mod_perl)
g04509 + patch       209  1.0   276  1.5   342  3.3    483  6.3
(HEAD)
g04509 + patch        66 70.1   117  2.6   189  3.4    341  3.8
(HEAD, mod_perl)

The v267 summary time is wrong, that version of gitweb is not
packed-refs aware.

I think I need a more consistent test setup I'm seeing some weird
deviations.

Robert
