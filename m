From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Mon, 10 Mar 2014 10:08:06 +0100
Message-ID: <1394442486.7891.45.camel@Naugrim>
References: <1393858066.7891.20.camel@Naugrim> <5314BFA5.2030807@web.de>
	 <1393878866.7891.22.camel@Naugrim> <53176951.7000201@web.de>
	 <1394069128.7891.29.camel@Naugrim> <5318D101.9050305@web.de>
	 <1394136925.7891.31.camel@Naugrim> <5318DFDD.4060006@web.de>
	 <1394144428.7891.33.camel@Naugrim> <531A4FA3.3040007@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-4rKPsIaH1VM4Q11gjfcq"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 10:08:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMwC8-0005zz-L3
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 10:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbaCJJIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 05:08:19 -0400
Received: from smtpout7.laposte.net ([193.253.67.232]:40076 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbaCJJIS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 05:08:18 -0400
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8514-out with ME
	id bl861n0022iaXuy03l8690; Mon, 10 Mar 2014 10:08:13 +0100
In-Reply-To: <531A4FA3.3040007@web.de>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243718>


--=-4rKPsIaH1VM4Q11gjfcq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le samedi 08 mars 2014 =C3=A0 00:00 +0100, Jens Lehmann a =C3=A9crit :
> Am 06.03.2014 23:20, schrieb Henri GEIST:
> > Le jeudi 06 mars 2014 =C3=A0 21:51 +0100, Jens Lehmann a =C3=A9crit :
> >> Am 06.03.2014 21:15, schrieb Henri GEIST:
> >>> Le jeudi 06 mars 2014 =C3=A0 20:48 +0100, Jens Lehmann a =C3=A9crit :
> >>>> Am 06.03.2014 02:25, schrieb Henri GEIST:
> >>>> Wow, that shouldn't even work (as everything inside "submodule"
> >>>> shouldn't be part of the superproject but must be contained in
> >>>> the submodule itself). Do the "git submodule" script and other
> >>>> git commands like "git status" work for you in such setups?
> >>>
> >>> As I stated above it is the purpose of the other patch that I have no=
t already send
> >>> to implement this behavior. And that is why it work.
> >>
> >> Ok.
> >>
> >>> Everything including 'git submodule' and 'git status' work perfectly.
> >>> The intent of this patch is only to permit this for gitlinks. Not for=
 regular files.
> >>
> >> But I still believe that this shouldn't be permitted at all,
> >> no matter if files or submodules are concerned. The pitfalls
> >> files face in such a scenario are pretty much the same for
> >> submodules too.
> >=20
> > May be you have a good argument for this belief ?
>=20
> Sure, I stated it further down:
>=20
> >> The problem you're creating with your future patch
> >> is related to the work tree, not the GIT_DIR: "subsubmodule"
> >> could also be added to and tracked by "submodule" (as that is
> >> completely unaware of "subsubmodule" already being tracked by
> >> the superproject). Then you would end up in real trouble, as
> >> "superproject" and "submodule" could have differing SHA-1s
> >> recorded for subsubmodule. Don't go there, for just the same
> >> reasons we do not allow that for files.
>=20
> > As for the difference between submodules and regular files
> > the only difference is in the meaning.
> > Technically directory are just a special kind of file.
> > But there day to day use is drastically different of
> > the use of files which are not directories.
> > I am not against enabling it for files as well.
> > I am just unable to imagine a case where it make sens.
>=20
> It doesn't make sense for both files and submodules.
>=20
> > A possible solution when someone try to do it is to issue a warning.
> > "We are not able to see any good reason to do this are sure (y/n) ?"
>=20
> No, the only possible solution I see is not to allow that at
> all.
>=20
> >>>>> In this case where should the separate gitdir of subsubmodule be pl=
aced ?
> >>>>>   - In superproject/modules/submodule/subsubmodule ?
> >>>>>   - In superproject/submodule/modules/subsubmodule ?
> >>>>>   - Depending on the 'git submodule update' command order ?
> >>>>>   - Or both ?
> >>>>
> >>>> It should be placed in .git/modules/submodule/modules/subsubmodule
> >>>> of the superproject (assuming the subsubmodule is part of the first
> >>>> level submodule). But in your example that would live in
> >>>> .git/modules/submodule/subsubmodule (but as mentioned above, I do
> >>>> not consider this a valid setup because then two repositories would
> >>>> be responsible for the data inside subsubmodule, which will lead to
> >>>> lots of trouble).
> >>>
> >>> That is why a had proposed an option '--no-separate-git-dir'
> >>> for 'git submodule <add|update>' then no repository is responsible fo=
r the data
> >>> in subsubmodule except subsubmodule itself.
> >>
> >> As I mentioned in my other email, it doesn't matter at all for
> >> the setup you're describing if the git directory lives under
> >> .git/modules of the superproject or in a .git directory in the
> >> submodule. The problem you're creating with your future patch
> >> is related to the work tree, not the GIT_DIR: "subsubmodule"
> >> could also be added to and tracked by "submodule" (as that is
> >> completely unaware of "subsubmodule" already being tracked by
> >> the superproject). Then you would end up in real trouble, as
> >> "superproject" and "submodule" could have differing SHA-1s
> >> recorded for subsubmodule. Don't go there, for just the same
> >> reasons we do not allow that for files.
> >=20
> > In fact it mater.
> > Because multiples checkout of superproject and submodules in versions
> > where subsubmodule is present and not.
> > subsubmodule could have been clone one time by submodule and one time
> > by superproject.
>=20
> And each would have a different .git directory. Where is the
> problem with that? Size? Different refs?
>

The problem is having two gitdir for one worktree.
with the .git file in the worktree pointing sometime on one and sometime on
the other.
=20
> > And then if they are cloned with --separate-gitdir subsubmodule can
> > have two gitdirs in superproject/modules/submodule/subsubmodule and
> > in superproject/submodule/modules/subsubmodule.
> > Only one is active at a given time but they are two and not synchronize=
d.
>=20
> But the synchronization is done via the superproject, no?
>=20

Only lot of careful manual command by the user could keep them synchronize.
But it is big wast of time. For no added value.
It is quicker to make subsubmodule a regular clone without a separate gitdi=
r
then there is nothing needing a synchronization.

> >> What is the use case you are trying to solve and why can that
> >> not be handled by adding "subsubmodule" inside "submodule"?
> >=20
> > The problem is access rights.
> >=20
> > Imagine you have 2 people Pierre and Paul.
> > Each with different access write on the server.
> > Pierre has full access on every things.
> > Paul has full access on superproject and subsubmodule but no read/write
> > access to submodule only execution on the directory.
>=20
> Ok, I think I'm slowly beginning to understand your setup.
>=20
> > I want all user to get every things they are allowed to have with the
> > command 'git submodule update --init --recursive'.
> > Then as Paul can not clone submodule he can not get subsubmodule
> > recursively through it.
>=20
> Sure, that's how it should work. Paul could only work on a branch
> where "submodule" is an empty directory containing "subsubmodule",
> as he doesn't have the rights to clone "submodule".

I will not redundantly create a branch for each user on the server.
When users clone the server it already create a special branch for them
'master' which track 'origin/master'. And if each user have its own branch
on the server it will completely defeat the goal of the server "collaborati=
on".
And transform the git server in simple rsync server.

>=20
> > And I need superproject to add also submodule/subsubmodule.
>=20
> No. Never let the same file/directory be tracked by two git
> repositories at the same time. Give Paul a branch to work on
> where "submodule" is just an empty directory, and everything
> will be fine. Or move "subsubmodule" outside of "submodule"
> (and let a symbolic link point to the new location if the
> path cannot be easily changed). Would that work for you?

If I use symbolic links it will just as gitlink enable to use the
same subsubmodule clone by more than one superproject but with two
major problems :
  - symbolic links do not work under Windows and some of my users do
    not even know something else could exist.
  - symbolic links will not store the SHA-1 of the subsubmodule.
    And a 'git status' in the repository containing the symbolic link
    will say nothing about subsubmodule state.




I think where we diverge is in the way we are looking gitlinks.
Where you see a hierarchic tree, I see a web.
And I use gitlinks just like multiplatform symbolic links storing
the SHA-1 of there destination and pointing exclusively on git repositories=
.



--=-4rKPsIaH1VM4Q11gjfcq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF0EABEKAAYFAlMdgPYACgkQkKuHPdwEGdQIEwEAkbZBhzwysadYFpKt5byH4pqw
ZTfg6UMayJ3jiMV6aeQA+N29vOLn7+stpym3fbfHIvch8zOWI8r3wZq1SrCcGvE=
=BzTU
-----END PGP SIGNATURE-----

--=-4rKPsIaH1VM4Q11gjfcq--
