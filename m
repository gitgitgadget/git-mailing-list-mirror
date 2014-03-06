From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Thu, 06 Mar 2014 02:25:28 +0100
Message-ID: <1394069128.7891.29.camel@Naugrim>
References: <1393858066.7891.20.camel@Naugrim> <5314BFA5.2030807@web.de>
	 <1393878866.7891.22.camel@Naugrim> <53176951.7000201@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-DAG82vvoAmjiL0eZ5/Tz"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 02:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLN4D-00013m-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 02:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366AbaCFBZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 20:25:41 -0500
Received: from smtpout5.laposte.net ([193.253.67.230]:19584 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757340AbaCFBZk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 20:25:40 -0500
Received: from [192.168.1.104] ([109.164.199.213])
	by mwinf8509-out with ME
	id a1RV1n0024ckmKR031RVFe; Thu, 06 Mar 2014 02:25:34 +0100
In-Reply-To: <53176951.7000201@web.de>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243497>


--=-DAG82vvoAmjiL0eZ5/Tz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 05 mars 2014 =C3=A0 19:13 +0100, Jens Lehmann a =C3=A9crit :
> Am 03.03.2014 21:34, schrieb Henri GEIST:
> > Le lundi 03 mars 2014 =C3=A0 17:45 +0000, Jens Lehmann a =C3=A9crit :
> >> Am 03.03.2014 14:47, schrieb Henri GEIST:
> >>> This new option prevent git submodule <add|update> to clone the missi=
ng
> >>> submodules with the --separate-git-dir option.
> >>> Then the submodule will be regular repository and their gitdir will n=
ot
> >>> be placed in the superproject gitdir/modules directory.
> >>
> >> And what is your motivation for this? After all submodules containing
> >> a .git directory are second class citizens (because they can never be
> >> safely removed by regular git commands).
> >>
> >=20
> > I recognize most people will prefer to have the .git directory separate=
.
> > And I do not intend to make this option the default.
> >=20
> > My reasons are:
> >=20
> >   - As it is not clearly stated in the doc that the gitdir is separate.
> >     The first time I have copied one module to an USB key I had a big
> >     surprise.
>=20
> Oops! Could you please help us by hinting how the documentation
> could be improved here?
>=20

Of course.
There is nothing in Documentation/git-submodule.txt to inform that submodul=
es
clones are different from regular clones.
I will write and propose a patch for the documentation.
But maybe in a new thread.


> >   - This will not change anything for people not using it.
>=20
> I do not agree, as they'll be seeing a new option and might use
> it to "go backward" as Junio explained in his answer.
>=20
> >   - I use an other patch which I plane to send later which enable multi=
ple
> >     level of superproject to add a gitlink to the same submodule.
> >     And in this case the superproject containing the separate gitdir wi=
ll be
> >     arbitrary and depend on the processing order of the
> >     'git submodule update --recursive' command.
>=20
> I don't understand that. How is that different from using different
> names (and thus different separate gitdirs) for that duplicated
> submodule? After all, the .git directory is just moved somewhere
> else in the superproject's work tree, and as the name defaults to
> the path of the submodule ...
>=20

I think I should give an example.
If I have a hierarchy like this :

superproject/submodule/subsubmodule

What I often do is:

superproject --> submodule --> subsubmodule
             |                 ^
             '-----------------'

Where '-->' is a gitlink.


That mean .gitmodules and index of the superproject contain both submodule =
and
submodule/subsubmodule.
And also mean (and that is the point) subsubmodule is a direct 'child' of b=
oth
superproject and submodule.
In this case where should the separate gitdir of subsubmodule be placed ?
  - In superproject/modules/submodule/subsubmodule ?
  - In superproject/submodule/modules/subsubmodule ?
  - Depending on the 'git submodule update' command order ?
  - Or both ?


> >   - I have written this for myself and have using it since 2012 and sen=
d it in
> >     the hope it could be useful for someone else even if it is only a f=
ew
> >     people. But if its not the case no problem I will keep using it for=
 myself.
>=20
> Thanks.




--=-DAG82vvoAmjiL0eZ5/Tz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMXzogACgkQkKuHPdwEGdSWqgD+IEkpRHzGfy5Pw1gub0da6j+a
uwdf5Tg11z0neFIhIL4A/RpG/aUDIpvuIn+MeIdjB5zKLac8vDxLDYp+ICzlB++e
=VL91
-----END PGP SIGNATURE-----

--=-DAG82vvoAmjiL0eZ5/Tz--
