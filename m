From: martin f krafft <madduck@madduck.net>
Subject: Re: how to combine two clones in a collection
Date: Tue, 10 Jul 2007 19:45:43 +0200
Message-ID: <20070710174543.GA16054@piper.oerlikon.madduck.net>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org> <20070710062104.GA22603@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707100950520.3412@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Jmb-0003ET-1y
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 19:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943AbXGJRpt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 13:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757449AbXGJRps
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 13:45:48 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:60361 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbXGJRpr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 13:45:47 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id F2D12895D73
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 19:45:45 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 12585-04 for <git@vger.kernel.org>;
	Tue, 10 Jul 2007 19:45:45 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 90183895D72
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 19:45:45 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id B84489F121
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 19:45:44 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 077DE43FC; Tue, 10 Jul 2007 19:45:44 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707100950520.3412@woody.linux-foundation.org>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52099>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.07.10.1905=
 +0200]:
>    These would get both branches (including all of the upstream,
>    of course), but that's ok, since git will share all the common
>    objects *anyway*, so there is no "duplication". You can have
>    a hundred branches, and they won't use one whit more memory of
>    bandwidth (apart from the branch refs themselves being sent
>    over, of course), and only the actual *differences* between
>    branches will take up space.

The duplication I meant was when upstream uses SVN or a tarball,
which I then have to track/import into my git repo. But it's just
space and that's cheap these days.

>    Here, I don't really know how the debian package management is
>    supposed to work, but since they obviously aren't using git,
>    they must be using something else. A tar-ball or just a series
>    of patches? Both would be trivial to implement as just an
>    "export" from your git tree. Or you'd export the "debian"
>    branch as a separate SVN repo (I've not used the "export back
>    into a SVN" thing, so I don't know how well that works).

Just in case you're interested, otherwise the following two
paragraphs can be safely skipped:

  There is no standard for Debian packaging. In general, it's the
  upstream tarball and a diff to be applied for debianisation. Some
  people just use one giant diff, others use the diff to add patches
  as separate files to the unpacked contents of the tarball, which
  are then applied.

  I guess my final goal is to use git and branches, one to track
  upstream, one for every feature/patch I add, and then to create
  a source package from that by packaging the upstream branch into
  a tarball (or reusing an existing one), turning each branch into
  a single-file patch and then create the overall diff to add these
  single-files, including some glue to apply them automatically on
  unpacking/building.

> > The way I tend to think about a pair of branches is that one
> > depends on the other, or rather, one stems from the other.
>=20
> .. and no, that's not really how git works from a technical angle:
> in the the git model, all branches are technically 100% equal, and
> no branch "depends" on anything else, they are all equally
> first-class citizens.

Right, I knew that. What I meant is more that a branch derives off
another, meaning that before and including the branching commit,
they have shared ancestry.

I wonder how to create a project with two completely independent
branches which have no common ancestry. I don't think it's possible.
One needs a throwaway branch to create the first commit, then branch
each of the two branches off that, then delete the throwaya branch
(or keep it around).

But this is getting academic now...

> > So if I made changes to the debian branch, I'd check it out
> > first, then return to the upstream branch when done.
>=20
> It sounds like you would actually be fairly comfy with the git
> "switch branches within one repository" model, and you might not
> even need to make it look like two different trees.

Definitely.

As a Debian maintainer who really wants to use git for Debian
packaging though, I also need to worry about all the other people
who obtain my source package and need to be comfortable with it.
I may well understand what my 123 branches are for and how they are
interlinked, but that doesn't help Jane Schmoo fixing
a release-critical bug while I'm backpacking in Southeast Asia.

> But I don't want to fool you - I do think you'll have to change
> *some* of how you work. But it sounds like your workflow is
> *fairly* close to a very natural git flow.

Thanks for the encouragement!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
it is better to have loft and lost
than to never have loft at all.
                                                       -- groucho marx

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGk8XHIgvIgzMMSnURAjyRAKCk3STxLmcozX77m+1nokJHc6RKpgCcC8EV
5VRvElQ/3l+5ZBdg9wqbk6I=
=gQaa
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
