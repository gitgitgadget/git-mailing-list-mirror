From: Francis Galiegue <fg@one2team.net>
Subject: Re: Need help for migration from CVS to git in one go (ie, FORGETTING CVS history)
Date: Thu, 6 Nov 2008 13:13:50 +0100
Organization: One2team
Message-ID: <200811061313.50711.fg@one2team.net>
References: <200811060014.57046.fg@one2team.net> <m3zlkdeelm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 13:17:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky3nN-0004Wm-29
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 13:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbYKFMPv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 07:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753404AbYKFMPv
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 07:15:51 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:51013 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbYKFMPu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2008 07:15:50 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-63-83.w90-20.abo.wanadoo.fr [90.20.50.83])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id C634192C024;
	Thu,  6 Nov 2008 13:15:42 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <m3zlkdeelm.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100232>

Le Thursday 06 November 2008 04:08:16 Jakub Narebski, vous avez =E9crit=
=A0:
Hello,
[...]
> >
> > * 52 CVS modules, fine; but then this can become one and 52
> >   subdirectories in them and still act as separate modules from
> >   the build system point of view (which I have implemented, so
> >   I can change it);
>
> I think that those CVS modules should become separate repositories,
> perhaps joined together using submodules. This is one of more
> difficult things during conversion.
>
> Note that in Git commits are always whole tree (whole project)
> commits.
>

Honestly, I'm not fond of this approach. The problem with submodules as=
 far as=20
I'm concerned is that documentation is "not really there", and (unless =
the=20
README of egit is _really_ outdated) that there's no support in egit.

I know about commits affecting the whole tree, and even branches and ta=
gs, and=20
that's more of an advantage to my eyes, for two reasons:

* 99+% of queries currently done on the CVS tree (with Bonsai) cover al=
l=20
modules; only rarely is a single module concerned, and in this case you=
 just=20
fill in the appropriate field in the search page anyway;
* creating a branch is one command and that's it. It may also be one co=
mmand=20
with submodules, but again, the documentation makes me uncomfortable; w=
ith=20
CVS, well... You get the picture.

What's more, I don't think we have the requirement of making specific=20
per-module tags. Not as far as this has been discussed so far, anyway, =
and=20
not as far as the history shows.

> > * second: even though this may be a "non problem", we use Bonsai,
> > which has the ability to see what was commited by whom, given a tim=
e
> > interval (from d1 to d2): the base gitweb allows to search by
> > commiter, which is good, but it has no date boundaries: do tools
> > exist for git that can do this? If not, that wouldn't be a big deal=
,
> > however...
>
> First, there are more web interfaces than gitweb, see
> http://git.or.cz/gitweb/InterfacesFrontendsAndTools
>

Yep, I've yet to try those... There are quite a few!

> Second, you can do this from command line, using combination of commi=
t
> limiting a..b and a...b, or --since=3D<date> or --after=3D<date> and
> --before=3D<date>, commit message searching --author, --committer, an=
d
> --grep, and path limiting "git log -- <pathspec>".
>

Well, a Web-based search engine is kind of a requirement. I'm the only =
one to=20
do command line... Thanks for the hints, though!

> Third, it would be not that hard to add more advanced search support
> to gitweb; this is even one of planned features.
>

Which brings back to the subject of submodules, since as I said above, =
we=20
generally search on the entire tree, and per-module searches are rare.

> > * third: also Bonsai-related; Bonsai can link to Bugzilla by
> > matching (wild guess) /\b(?:#?)(\d+)\b/ and transforming this into
> > http://your.bugzilla.fqdn.here/show_bug.cgi?id=3D$1. Does gitweb ha=
ve
> > this built-in? (haven't looked yet) Is this planned, or has it been
> > discussed and been considered not worth the hassle?
>
> This is (under name of 'committags') in gitweb TODO; gitweb-xmms2
> support this IIRC or supported this (for Mantis and not Bugzilla
> though...)

Interesting... I'll have a look at it.

Thanks for the answers!
--=20
fge
