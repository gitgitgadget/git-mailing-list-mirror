From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Add clean.requireForce option, and add -f option to git-clean
 to override it
Date: Mon, 23 Apr 2007 19:03:53 -0700
Message-ID: <462D6589.7060206@freedesktop.org>
References: <462D4CC8.70006@freedesktop.org> <462D5C4D.3050004@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig97E97F49784E34830E7A2973"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Michael Spang <mspang@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Tue Apr 24 04:04:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgAOP-0002Ay-1b
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 04:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031024AbXDXCEa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 22:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031026AbXDXCEa
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 22:04:30 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:53531 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031024AbXDXCE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 22:04:29 -0400
Received: (qmail 15926 invoked from network); 24 Apr 2007 02:04:28 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail1.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <mspang@uwaterloo.ca>; 24 Apr 2007 02:04:28 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <462D5C4D.3050004@uwaterloo.ca>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45403>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig97E97F49784E34830E7A2973
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michael Spang wrote:
> Josh Triplett wrote:
>> +if [ "$disabled" =3D true ]; then
>> +	echo "clean.requireForce set and -n or -f not given; refusing to cle=
an"
>> +	exit 1
>> +fi
>=20
> How is it useful to abort completely? Wouldn't it be better to behave
> like -n unless -f is given?

I don't think so, for a couple of reasons.

* I want to make it really obvious that git-clean did nothing.  Spewing p=
iles
  of output quickly obscures the error message, and doesn't convey "git-c=
lean
  did nothing" at a glance.

* -n takes time, especially with a large working copy.  Doing nothing tak=
es
  very little time.  The original use case motivating this patch came fro=
m the
  idea of a git $HOME, and wanting to make sure git-clean won't delete
  everything untracked in $HOME.  git-clean -n would take a long time her=
e,
  and I don't want to do it implicitly, particularly if I meant to clean =
a git
  repository *under* $HOME.

- Josh Triplett


--------------enig97E97F49784E34830E7A2973
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLWWJGJuZRtD+evsRAojSAKCwLxdIbgbzxyxlFlvRCct6IWKETwCfZcY1
Qmzba8pKsKv415WFu2kfOaY=
=LpQj
-----END PGP SIGNATURE-----

--------------enig97E97F49784E34830E7A2973--
