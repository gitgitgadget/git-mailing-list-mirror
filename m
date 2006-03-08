From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: Wed, 8 Mar 2006 21:30:59 +0300
Message-ID: <20060308183059.GD9555@procyon.home>
References: <20060308173249.1faed1d7.vsu@altlinux.ru> <20060308180422.27978.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Mar 08 19:34:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH3RL-00027e-PD
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 19:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWCHSbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 13:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWCHSbM
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 13:31:12 -0500
Received: from master.altlinux.org ([62.118.250.235]:33294 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932101AbWCHSbL
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 13:31:11 -0500
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 304A6E34B5; Wed,  8 Mar 2006 21:31:06 +0300 (MSK)
Received: by procyon.home (Postfix, from userid 500)
	id 24315E3668D; Wed,  8 Mar 2006 21:30:59 +0300 (MSK)
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20060308180422.27978.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17380>


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2006 at 01:04:22PM -0500, linux@horizon.com wrote:
> > And this won't work, unless you also add that wcwidth() implementation
> > to git.
>=20
> That was the general idea.  It is freely usable.
>=20
> > The problem is that the wchar_t encoding is not specified anywhere -
> > glibc uses Unicode for it, but other systems can use whatever they want
> > (even locale-dependent).
>=20
> Why is that a problem?  None of the code mentioned even uses wchar_t.
> The code I wrote converts from UTF-8 to straight Unicode, and that's
> what Markus Kuhn's wcwidth() expects as an argument.

wcwidth() is a standard library function which takes a wchar_t:

http://www.opengroup.org/onlinepubs/009695399/functions/wcwidth.html

It is easy to write a program which assumes that wchar_t is Unicode
without noticing it, because it will work fine with glibc...

So that mk_wcwidth() must be used unconditionally, and not as a
fallback for systems which do not provide wcwidth() in libc.

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD4DBQFEDyLjW82GfkQfsqIRAgOLAJir8vg+jigaJ4jYscMFCToW4aZjAJ0UqKqC
8pqDkv6XgmI8iaty6Pe3NA==
=WAXE
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
