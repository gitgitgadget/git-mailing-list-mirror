From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Thu, 06 Mar 2014 21:15:25 +0100
Message-ID: <1394136925.7891.31.camel@Naugrim>
References: <1393858066.7891.20.camel@Naugrim> <5314BFA5.2030807@web.de>
	 <1393878866.7891.22.camel@Naugrim> <53176951.7000201@web.de>
	 <1394069128.7891.29.camel@Naugrim> <5318D101.9050305@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-QNGqmczmz+0JRQqedozd"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 21:15:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLehj-0003ur-9d
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 21:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbaCFUPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 15:15:38 -0500
Received: from smtpout5.laposte.net ([193.253.67.230]:41083 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbaCFUPg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 15:15:36 -0500
Received: from [192.168.1.104] ([109.164.199.213])
	by mwinf8510-out with ME
	id aLFR1n0064ckmKR03LFRyB; Thu, 06 Mar 2014 21:15:31 +0100
In-Reply-To: <5318D101.9050305@web.de>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243545>


--=-QNGqmczmz+0JRQqedozd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 06 mars 2014 =C3=A0 20:48 +0100, Jens Lehmann a =C3=A9crit :
> Am 06.03.2014 02:25, schrieb Henri GEIST:
> > Le mercredi 05 mars 2014 =C3=A0 19:13 +0100, Jens Lehmann a =C3=A9crit =
:
> >> Am 03.03.2014 21:34, schrieb Henri GEIST:
> >>> Le lundi 03 mars 2014 =C3=A0 17:45 +0000, Jens Lehmann a =C3=A9crit :
> >>>> Am 03.03.2014 14:47, schrieb Henri GEIST:
> >>>>> This new option prevent git submodule <add|update> to clone the mis=
sing
> >>>>> submodules with the --separate-git-dir option.
> >>>>> Then the submodule will be regular repository and their gitdir will=
 not
> >>>>> be placed in the superproject gitdir/modules directory.
> >>>>
> >>>> And what is your motivation for this? After all submodules containin=
g
> >>>> a .git directory are second class citizens (because they can never b=
e
> >>>> safely removed by regular git commands).
> >>>>
> >>>
> >>> I recognize most people will prefer to have the .git directory separa=
te.
> >>> And I do not intend to make this option the default.
> >>>
> >>> My reasons are:
> >>>
> >>>   - As it is not clearly stated in the doc that the gitdir is separat=
e.
> >>>     The first time I have copied one module to an USB key I had a big
> >>>     surprise.
> >>
> >> Oops! Could you please help us by hinting how the documentation
> >> could be improved here?
> >>
> >=20
> > Of course.
> > There is nothing in Documentation/git-submodule.txt to inform that subm=
odules
> > clones are different from regular clones.
> > I will write and propose a patch for the documentation.
> > But maybe in a new thread.
>=20
> Thanks!
>=20
> >>>   - This will not change anything for people not using it.
> >>
> >> I do not agree, as they'll be seeing a new option and might use
> >> it to "go backward" as Junio explained in his answer.
> >>
> >>>   - I use an other patch which I plane to send later which enable mul=
tiple
> >>>     level of superproject to add a gitlink to the same submodule.
> >>>     And in this case the superproject containing the separate gitdir =
will be
> >>>     arbitrary and depend on the processing order of the
> >>>     'git submodule update --recursive' command.
> >>
> >> I don't understand that. How is that different from using different
> >> names (and thus different separate gitdirs) for that duplicated
> >> submodule? After all, the .git directory is just moved somewhere
> >> else in the superproject's work tree, and as the name defaults to
> >> the path of the submodule ...
> >>
> >=20
> > I think I should give an example.
> > If I have a hierarchy like this :
> >=20
> > superproject/submodule/subsubmodule
> >=20
> > What I often do is:
> >=20
> > superproject --> submodule --> subsubmodule
> >              |                 ^
> >              '-----------------'
> >=20
> > Where '-->' is a gitlink.
> >=20
> >=20
> > That mean .gitmodules and index of the superproject contain both submod=
ule and
> > submodule/subsubmodule.
>=20
> Wow, that shouldn't even work (as everything inside "submodule"
> shouldn't be part of the superproject but must be contained in
> the submodule itself). Do the "git submodule" script and other
> git commands like "git status" work for you in such setups?
>

As I stated above it is the purpose of the other patch that I have not alre=
ady send
to implement this behavior. And that is why it work.
Everything including 'git submodule' and 'git status' work perfectly.
The intent of this patch is only to permit this for gitlinks. Not for regul=
ar files.
=20
> > and also mean (and that is the point) subsubmodule is a direct 'child' =
of both
> > superproject and submodule.
>=20
> Which I think should not be possible. If that works with current
> Git I suspect we have a bug to fix ... or does your other patch
> make this work?

You have no bug on this point without my modification this is not possible.

>=20
> > In this case where should the separate gitdir of subsubmodule be placed=
 ?
> >   - In superproject/modules/submodule/subsubmodule ?
> >   - In superproject/submodule/modules/subsubmodule ?
> >   - Depending on the 'git submodule update' command order ?
> >   - Or both ?
>=20
> It should be placed in .git/modules/submodule/modules/subsubmodule
> of the superproject (assuming the subsubmodule is part of the first
> level submodule). But in your example that would live in
> .git/modules/submodule/subsubmodule (but as mentioned above, I do
> not consider this a valid setup because then two repositories would
> be responsible for the data inside subsubmodule, which will lead to
> lots of trouble).

That is why a had proposed an option '--no-separate-git-dir'
for 'git submodule <add|update>' then no repository is responsible for the =
data
in subsubmodule except subsubmodule itself.



--=-QNGqmczmz+0JRQqedozd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMY110ACgkQkKuHPdwEGdRyJwEAis4AaMLv4/FPbI/Or/cvDUzY
tMcfuoiNFHqD/tCIaIIA/0wj5jjKbmKX88HOBny9T1aI0TnVMF2hsizDi6WGBymY
=PsU3
-----END PGP SIGNATURE-----

--=-QNGqmczmz+0JRQqedozd--
