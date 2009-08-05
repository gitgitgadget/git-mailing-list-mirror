From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: blame on a deleted/renamed file
Date: Wed, 5 Aug 2009 16:09:41 +0200
Message-ID: <20090805140941.GB13340@atjola.homenet>
References: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
 <20090805123754.GA13340@atjola.homenet>
 <449c10960908050654v3823da76p1ddb5a2bbb5c323d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 16:10:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYhBh-0001P9-8l
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 16:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933912AbZHEOJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 10:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933568AbZHEOJp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 10:09:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:56829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933270AbZHEOJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 10:09:44 -0400
Received: (qmail invoked by alias); 05 Aug 2009 14:09:43 -0000
Received: from i59F55BB1.versanet.de (EHLO atjola.homenet) [89.245.91.177]
  by mail.gmx.net (mp010) with SMTP; 05 Aug 2009 16:09:43 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX182fsZJ8ns2sulDEoZ8QTUhD75SRIg+3UaeIqkv2q
	472yVMD7CSVBWI
Content-Disposition: inline
In-Reply-To: <449c10960908050654v3823da76p1ddb5a2bbb5c323d@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124909>

On 2009.08.05 08:54:09 -0500, Dan McGee wrote:
> 2009/8/5 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > On 2009.08.05 07:16:13 -0500, Dan McGee wrote:
> >> Is there no easy way in git to get a blame on a file that has eith=
er
> >> been renamed or deleted? I'll step through my thought process, and=
 a
> >> quick google and read of the manpage returned nothing obvious. Her=
e is
> >> the repository in question if it matters:
> >> git://projects.archlinux.org/pacman.git. I located a particular co=
mmit
> >> I was interested using a plain git-blame:
> >> $ git blame scripts/makepkg.sh.in
> >>
> >> OK, looks like lines moved around enough that we got stuck here, l=
et's
> >
> > How did it get stuck? The output I see follows the changes the whol=
e way
> > back through scripts/makepkg.in, scripts/makepkg.in and scripts/mak=
epkg.
>=20
> I said nothing about it not following renames. I asked about it
> following *those lines*. I know it already made the jump from
> scripts/makepkg.sh.in to scripts/makepkg.in, sorry if I wasn't clear
> there.

Hm, I still don't see what you mean. For some lines it stopped at
e19d7da4, yeah, but those were new lines, added in that commit, at leas=
t
those that I checked (e.g. "local ct=3D0" in generate_checksums()). For
the others, it already went back further.

> > And scripts/makepkg.in got added in e19d7da4, so its parent didn't =
have
> > it.
>=20
> Not sure where you are seeing that, it was changed in that revision,
> not added...

No idea, I guess I got confused by the various makepkg.* versions :-/
Especially by the "stab in the dark" blame call. ;-)

> >> $ git annotate --follow "scripts/makepkg.sh.in" e19d7da4~1
> >> fatal: no such path scripts/makepkg.sh.in in e19d7da4~1
> >
> > Same deal, scripts/makepkg.sh.in didn't exist in e19d7da4~1 either,=
 it
> > got renamed from scripts/makepkg.in in b5f8a44be
>=20
> That was my whole point here- I was stabbing in the dark so I showed
> you everything I tried because the git-annotate manpage failed me.
>=20
> >> Help? Or do I need to think about writing some sort of patch for i=
t?
> >> This is the first thing I have seen svn be able to do[1] that git
> >> can't. :)
> >
> > Uhm, no, svn fails in the exact same way, not quite unexpected.
[...]
> > doener@atjola:h $ svn blame file://$PWD/repo/bar
> > doener@atjola:h $ svn blame file://$PWD/repo/bar@1
> > svn: '/bar' is not a file in revision 1
>=20
> svn blame file://$PWD/repo/foo@1 works perfectly though, that was my =
use case.

Yeah, with the old name, and that works in git too, same deal as with
the previous one, I've been totally confused, sorry.

> Sorry for doing like a point-by-point refute of your response here, I
> probably wasn't clear enough in my original email.

No problem, pointing out my mistakes is the best you could do. And
basically, I (wrongly) did the same to your mail. ;-)

Bj=F6rn
