From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Wed, 7 Jan 2009 13:24:44 +0100
Message-ID: <200901071324.57222.trast@student.ethz.ch>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net> <20090107112754.GA15158@roro3>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3625354.x7ylLzazEB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	pasky@suse.cz
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Wed Jan 07 13:26:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKXU6-0000O0-Cv
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 13:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbZAGMYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 07:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbZAGMYm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 07:24:42 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:39119 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbZAGMYm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 07:24:42 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 13:24:40 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 13:24:40 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090107112754.GA15158@roro3>
X-OriginalArrivalTime: 07 Jan 2009 12:24:40.0464 (UTC) FILETIME=[E9C38100:01C970C2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104789>

--nextPart3625354.x7ylLzazEB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Kirill Smelkov wrote:
> On Tue, Jan 06, 2009 at 09:32:03PM +0100, martin f krafft wrote:
> > I find this very confusing. Why not simply
> >=20
> >   TG_PAGER=3D"${GIT_PAGER:-}"
> >   TG_PAGER=3D"${TG_PAGER:-$PAGER}"
> >=20
> > ?
>=20
> I find it confusing too, but this is needed because they usually do
> something like this
>=20
>     $ GIT_PAGER=3D'' <some-git-command>
>=20
> to force it to be pagerless.
[...]
> So I think it would be better to preserve the same semantics for `tg
> patch` callers, though it's a pity that it's hard (maybe I'm wrong ?) to
> see whether an env var is unset.

Admittedly I haven't really studied your patch, but the ${} constructs
can in fact tell empty from unset:

  $ EMPTY=3D
  $ unset UNDEFINED
  $ echo ${UNDEFINED-foo}
  foo
  $ echo ${UNDEFINED:-foo}
  foo
  $ echo ${EMPTY-foo}

  $ echo ${EMPTY:-foo}
  foo

'man bash' indeed says

  When not performing substring expansion, bash tests for a parameter
  that is unset or null; omitting the colon results in a test only for
  a parameter that is unset.

So I suppose you could use

  ${GIT_PAGER-${PAGER-less}}

or similar.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart3625354.x7ylLzazEB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklknxkACgkQqUud07tmzP0mzgCglO27XaaBcTbzM0rLZKvx9zUC
/psAn1AuT35PoZum6kfVBH/oeAUt5gHw
=tRaI
-----END PGP SIGNATURE-----

--nextPart3625354.x7ylLzazEB--
