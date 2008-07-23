From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: HP-UX issues (WAS: Re: [RFC] Git User's Survey 2008)
Date: Thu, 24 Jul 2008 01:45:34 +0200
Message-ID: <20080723234534.GO32057@genesis.frugalware.org>
References: <200807230325.04184.jnareb@gmail.com> <7vsku1gqny.fsf@gitster.siamese.dyndns.org> <20080723074747.GA32057@genesis.frugalware.org> <200807232338.04340.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p0aHTXLXY/BobAxh"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:46:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLo2e-0001Gx-4C
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbYGWXph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755843AbYGWXph
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:45:37 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35100 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755873AbYGWXpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:45:36 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 13A921B252C;
	Thu, 24 Jul 2008 01:45:35 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E298F4465E;
	Thu, 24 Jul 2008 01:04:01 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3863F11909DF; Thu, 24 Jul 2008 01:45:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807232338.04340.jnareb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89809>


--p0aHTXLXY/BobAxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 11:38:00PM +0200, Jakub Narebski <jnareb@gmail.com>=
 wrote:
> > 2) Have coreutils installed. (But then I think it would be good to list
> > this dependency in INSTALL.)
>=20
> It would be good idea, although "POSIX-compliant shells" implies
> coreutils somewhat; shell scripts usually do require some utilities,
> like sed, grep, cat, test etc.

Sure, but we already use test_cmp instead of diff -u, avoid grep -a,
etc. These tricks are for running without GNU coreutils, I guess.

> > 3) Patch git to use automake's install-sh. (Would such a patch be ever
> > accepted?)
>=20
> I think it would.  It would allow us also to uncomment the
> AC_PROG_INSTALL line in configure.ac file to find 'install'
> automatically (autoconf requires having install.sh or install-sh
> fallback in the sources).
>=20
> The problem is coming up with minimal yet portable (at least as
> portable as git itself) fallback install.sh script.

I just checked automake-1.10.1's install-sh script, it works properly
with HP-UX's ksh.

I think it would be possible to:

1) Just use it: in long-term this would mean no additional maintenance
cost, since if any problem occurs, it could be just updated from
automake.

2) Or make it as minimal as possible: As far as I see the current git
build system just uses the -d and -m switches, so the support for the
-c, -C, -g, -o, -s, -t and -T switches could be removed. This way we
would get a minimal install-sh, but then it would have to be maintained
inside git.git.

I think 1) would be better.

--p0aHTXLXY/BobAxh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiHwp4ACgkQe81tAgORUJYLiwCaA/Gb4vJtjFjtC6neUNFAZems
iNoAnA/XP2aJH3bnbmQcHqhrYVBG5VUj
=Ww9q
-----END PGP SIGNATURE-----

--p0aHTXLXY/BobAxh--
