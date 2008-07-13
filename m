From: Petr Baudis <pasky@suse.cz>
Subject: Vanilla gitweb vs repo.or.cz
Date: Sun, 13 Jul 2008 13:59:30 +0200
Message-ID: <20080713115930.GH10151@machine.or.cz>
References: <20080712203042.GF1924@perso.beuc.net> <20080712222001.GE10151@machine.or.cz> <20080713082812.GA4944@perso.beuc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: savannah-hackers-public@gnu.org, git@vger.kernel.org
To: Sylvain Beucler <beuc@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 14:00:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI0Fj-0002C4-T9
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 14:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbYGML7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 07:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbYGML7d
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 07:59:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38741 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbYGML7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 07:59:33 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4371A393B31D; Sun, 13 Jul 2008 13:59:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080713082812.GA4944@perso.beuc.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88306>

  Hi,

On Sun, Jul 13, 2008 at 10:28:12AM +0200, Sylvain Beucler wrote:
> >   By the way, where can I see the source code of the gitweb you are
> > using?
> 
> We're using vanilla gitweb from the official Git, actually.

  ah, of course! Somehow, I forgot that you can customize the project
URLs shown without modifying the source code nowadays.

> Apparently that version begins to be outdated, doesn't it? For
> example, a user recently suggested we use a cache for the start page
> project list but that feature doesn't seem to be merged yet. Maybe
> should we switch to repo.or.cz's version directly?

  This is a bit more complicated; I've cc'd the Git mailing list in case
someone else finds this informative.

  The upstream gitweb is under active development; most importantly,
Lea Wiemann is intensively working on a new caching infrastructure and
is doing some cleanups, while Jakub Narebski tries to fight the general
apathy by posting various interesting RFC patches I keep promising
myself to finally check out (most importantly for an index page
overhaul; the recently introduced content tags were the first step
to this).

  Then, there is the http://repo.or.cz/w/git/gitweb.git repository,
which was my old attempt at maintaining gitweb actively. Unfortunately,
this didn't quite work out because of my general lack of time and
dedication. However, the next and pu branches still contain some patches
and these patches are actively used on repo.or.cz; I still hope to get
to clean them up and resubmit sometime soon. I'm working on a certain
Git-based project essentially fulltime this summer, so I hope to do get
around to it. :-)

  Finally, there is the http://repo.or.cz/w/git/repo.git repository.
This is the Git variant repo.or.cz uses - both for gitweb and the rest
of Git binaries too (e.g. git-daemon and gc cronjobs; however, I need to
do the ssh chroot updates manually, so that might lag a lot behind;
until just a few days ago, Git version in the chroot was from December
2007).  It dubbles as my personal Git patch queue, but most of the
non-gitweb patches aren't generally interesting (and mostly remind me
of "what all should I redo differently sometime").

  The gitweb patches in git/repo.git are superset of git/gitweb.git
patches and the extra patches are I believe (at least not currently)
interesting for general gitweb public. However, some of them _might_
be interesting for large-scale gitweb hosting like yours. Some of them
might end up in git/gitweb.git after some cleanup (graphiclog link,
email addresses obfuscation, ...).

  Thus, my recommendation for now would be to check out the patches
queued in

	http://repo.or.cz/w/git/gitweb.git
	http://repo.or.cz/w/git/repo.git

and maybe cherrypick some interesting ones; basing your gitweb directly
on git/repo.git probably does not make much sense unless you revert
"Custom gitweb changes" and probably others. Basing your gitweb on
git/gitweb.git might work, but would be a little bit adventurous. ;-)

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
