From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/5] Make xstrndup common
Date: Sat, 28 Apr 2007 11:53:13 -0700
Message-ID: <46339819.8030007@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA4AAE18CB4E42531EACF65D9"
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 20:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhs2r-0007Jw-V5
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 20:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbXD1SxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 14:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754032AbXD1SxS
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 14:53:18 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:34195 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbXD1SxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 14:53:16 -0400
Received: (qmail 23246 invoked from network); 28 Apr 2007 18:53:15 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 28 Apr 2007 18:53:15 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
References: Pine.LNX.4.64.0704281303371.28708@iabervon.org
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45793>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4AAE18CB4E42531EACF65D9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Daniel Barkalow wrote:
> It was implemented in commit.c; move it with the other x memory functio=
ns.
[...]
> +static inline char *xstrndup(const char *str, int len)
> +{
> +	char *ret =3D xmalloc(len + 1);
> +	memcpy(ret, str, len);
> +	ret[len] =3D '\0';
> +	return ret;
> +}
> +

I don't know if it matters, but this definition of xstrndup, like the ver=
sion
in commit.c, doesn't match the definition of strndup.  strndup duplicates=
 a
string, copying up to n characters or the length of the string.  This xst=
rndup
always copies n characters, reading past the end of the string if it does=
n't
have at least n characters.

- Josh Triplett


--------------enigA4AAE18CB4E42531EACF65D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGM5gZGJuZRtD+evsRAllBAKCZxRFJV6KwioasRMXgWYXY5OJ16wCfQgE4
2X7rAfd8JjLAG6Z8WRZUw4o=
=pT34
-----END PGP SIGNATURE-----

--------------enigA4AAE18CB4E42531EACF65D9--
