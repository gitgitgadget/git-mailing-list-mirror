From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: Wed, 8 Mar 2006 17:32:49 +0300
Message-ID: <20060308173249.1faed1d7.vsu@altlinux.ru>
References: <20060306193326.19262.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__8_Mar_2006_17_32_49_+0300_bSKBCS0QjwK2zQZk"
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 15:33:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGzj6-00064i-Cy
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 15:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWCHOdB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 09:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWCHOdA
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 09:33:00 -0500
Received: from master.altlinux.org ([62.118.250.235]:28425 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751068AbWCHOdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 09:33:00 -0500
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 301D2E33A4; Wed,  8 Mar 2006 17:32:59 +0300 (MSK)
Received: by procyon.home (Postfix, from userid 500)
	id 2682BE3668D; Wed,  8 Mar 2006 17:32:52 +0300 (MSK)
To: linux@horizon.com
In-Reply-To: <20060306193326.19262.qmail@science.horizon.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17373>

--Signature=_Wed__8_Mar_2006_17_32_49_+0300_bSKBCS0QjwK2zQZk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 6 Mar 2006 14:33:26 -0500 linux@horizon.com wrote:

> Well, getting 15 characters in UTF-8 is easy (just stop before the 16th
> byte for which ((b & 0xc0) !=3D 0x80)), but what about combining characte=
rs?
>=20
> You've got accents and stuff to worry about.  And the annoying fact that
> Unicode defined accents as suffixes, so you have to go past the 15th
> column to include all of the=20
>=20
> And then there's that fact that many characters are traditionally
> represented as double-wide forms, even on character terminals.
>=20
> See http://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c for details
> an an example implementation of wcwidth().
>=20
[skip]
> 			/* Now find the width of it */
> 			w =3D wcwidth(c);

And this won't work, unless you also add that wcwidth() implementation
to git.

The problem is that the wchar_t encoding is not specified anywhere -
glibc uses Unicode for it, but other systems can use whatever they want
(even locale-dependent).

--Signature=_Wed__8_Mar_2006_17_32_49_+0300_bSKBCS0QjwK2zQZk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEDusUW82GfkQfsqIRAncNAJ9XrQneOBz9DR2g4Fh4OhBbuCveegCeNdit
VoZq4tMTEFKXA26Rqv8xZzw=
=B9Se
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Mar_2006_17_32_49_+0300_bSKBCS0QjwK2zQZk--
