From: Ben Hutchings <ben@decadent.org.uk>
Subject: Surprising tag selection by 'git describe --contains'
Date: Sat, 18 Aug 2012 01:13:46 +0100
Message-ID: <1345248826.4986.33.camel@deadeye.wl.decadent.org.uk>
References: <20120814055011.6C43D2758@git.kroah.org>
	 <20120816231818.GB14850@kroah.com>
	 <CAKMK7uG3nhPVNC_epyMes=en9BTWFqfGYnzGLDkk_9QhyVDGAw@mail.gmail.com>
	 <20120817132250.GA28980@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Dba5uwrxUj8TZ9HpN+SA"
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	Kris Karas <bugs-a12@moonlit-rail.com>,
	Hunt Xu <mhuntxu@gmail.com>, stable@vger.kernel.org,
	git@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 02:14:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Wg6-0004N2-KZ
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 02:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab2HRAOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 20:14:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55796 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752125Ab2HRAOA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2012 20:14:00 -0400
Received: from [2001:470:1f08:1539:21c:bfff:fe03:f805] (helo=deadeye.wl.decadent.org.uk)
	by shadbolt.decadent.org.uk with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <ben@decadent.org.uk>)
	id 1T2Wfq-0006X4-F4; Sat, 18 Aug 2012 01:13:54 +0100
Received: from ben by deadeye.wl.decadent.org.uk with local (Exim 4.80)
	(envelope-from <ben@decadent.org.uk>)
	id 1T2Wfp-0005Eb-7C; Sat, 18 Aug 2012 01:13:53 +0100
In-Reply-To: <20120817132250.GA28980@kroah.com>
X-Mailer: Evolution 3.4.3-1 
X-SA-Exim-Connect-IP: 2001:470:1f08:1539:21c:bfff:fe03:f805
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203667>


--=-Dba5uwrxUj8TZ9HpN+SA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-17 at 06:22 -0700, Greg KH wrote:
> On Fri, Aug 17, 2012 at 09:18:44AM +0200, Daniel Vetter wrote:
> > On Fri, Aug 17, 2012 at 1:18 AM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
> > > On Tue, Aug 14, 2012 at 01:50:11AM -0400, Gregs git-bot wrote:
> > >> commit: 5ab3633d6907018b0b830a720e877c3884d679c3
> > >> From: Hunt Xu <mhuntxu@gmail.com>
> > >> Date: Sun, 1 Jul 2012 03:45:07 +0000
> > >> Subject: drm/i915: make rc6 in sysfs functions conditional
> > >>
> > >> Commit 0136db586c028f71e7cc21cc183064ff0d5919c8 merges rc6 informati=
on
> > >> into the power group. However, when compiled with CONFIG_PM not set,
> > >> modprobing i915 would taint since power_group_name is defined as NUL=
L.
> > >>
> > >> This patch makes these rc6 in sysfs functions conditional upon the
> > >> definition of the CONFIG_PM macro to avoid the above-mentioned probl=
em.
> > >>
> > >> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D45181
> > >> Cc: stable@vger.kernel.org
> > >> Tested-by: Kris Karas <bugs-a12@moonlit-rail.com>
> > >> Signed-off-by: Hunt Xu <mhuntxu@gmail.com>
> > >> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > >> ---
> > >>  drivers/gpu/drm/i915/i915_sysfs.c |   12 ++++++++++++
> > >>  1 files changed, 12 insertions(+), 0 deletions(-)
> > >
> > > As commit 0136db586c028f71e7cc21cc183064ff0d5919c8 only first showed =
up
> > > in 3.6-rc1, is this patch still needed for the stable tree(s)?
> >=20
> >=20
> > My git tag --contains claims it's in 3.5 already.
>=20
> Really?
>=20
> $ git describe --contains 0136db586c028f71e7cc21cc183064ff0d5919c8
> v3.6-rc1~59^2~56^2~76
>=20
> Do you see something else?

'git describe --contains' seems to choose the containing tag whose tree
has the shortest path from the given tree-like.  So, when some branch
has relatively few changes after Linus pulls it for release N and before
he pulls it for release N+1 *and* he pulls it later in the merge window
for release N+1, commits include in v3.N-rc1 can still be closer to
v3.(N+1)-rc1 because the extra merge commits on the path to v3.N-rc1
outweigh the extra non-merge commits on the path to v3.(N+1)-rc1.

git certainly doesn't (and shouldn't) know anything about ordering of
tag names, but I think that if one of the containing tags is the
ancestor of all the others then 'git describe --contains' should prefer
to use that.  Or at least, there should be some way to request that
behaviour.

For now, if in doubt, 'git tag --contains' will tell you all the
containing tags.

Ben.

> > And people have reported the regressions to prove it ;-)
>=20
> Ok, fair enough, I'll apply it.

--=20
Ben Hutchings
I say we take off; nuke the site from orbit.  It's the only way to be sure.

--=-Dba5uwrxUj8TZ9HpN+SA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUC7eOue/yOyVhhEJAQoEohAAqAUugTnqAPFJgGrMJloawvyPuKbMxOt2
DQN9pI+k8ODGLzuKjPEGlKrdUlVovGjmMjhgbZeG9ptgSH0hw7lg2fvGO3BkT65z
XsvTXrbHyPV/z2pu/FhMvPlrl62Usyw8JE6AyfQ4U09b73mrkwvQhFiWoqI1oIXb
4lzy996461/cWqfodvp9JGZUFRQjDXDvtFwzdnjjctAY/6DU75z73xLe4ZgX7HEI
9StmozgQ5rATh5wAUywjupSPiO992Vvm7cV24hYjPkWMJnhwXeyyOpWgKlkNOfp6
XV76OBMTqb1+a1Rqz+464TLW1Yu9TR+vefZN95K3uRKkT9j6B7W42qLaG2jlARRQ
/R5sxYE5VtcdJRpfUC1GP40BSsp5w14Rj8O2KDpoQzg/UEZw/e+gMH8upoMKG49q
DJM5YBTjJK6ixIbYs5+awyqyv4g26ApPRtgM4PyBMHEiEgUjjbhrKu1oqCnvcSoF
fjFIn1gfoB3MBgSSolW6fqnbRNMK0dTU4OUwps93npKMFe73FV4Zbd4TCTFx1Pi6
TFNOoqEy/E7meR2hWZe7fiN/u5VzmCltuduQON4fzYw1/f7/TXyvOP/i0FZm3aaP
A0Cbmuifw/9H7COEXRmFTmpXJSHIG7QigWEuNDJgL+As6/XIMGk90wryqXcihQVa
5MfTzpUb3+Q=
=Kn1C
-----END PGP SIGNATURE-----

--=-Dba5uwrxUj8TZ9HpN+SA--
