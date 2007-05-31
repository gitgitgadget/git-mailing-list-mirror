From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Breaking up repositories
Date: Thu, 31 May 2007 08:53:58 -0700
Message-ID: <465EEF96.6050307@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9F99D97355CE439AF7D7E115"
Cc: git@vger.kernel.org, Jamey Sharp <jamey@minilop.net>
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 17:54:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htmz4-0006KP-ON
	for gcvg-git@gmane.org; Thu, 31 May 2007 17:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbXEaPyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 11:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759140AbXEaPyJ
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 11:54:09 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:56967 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbXEaPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 11:54:07 -0400
Received: (qmail 9802 invoked from network); 31 May 2007 15:54:05 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <jasonsewall@gmail.com>; 31 May 2007 15:54:05 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
References: 31e9dd080705302350x7752c1f0p3dee2f0d35a97b56@mail.gmail.com
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48813>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9F99D97355CE439AF7D7E115
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jason Sewall wrote:
> I recently imported my subversion repo with git-svn and I'm curious
> what the best way to break up the monolithic repo (my many disparate
> projects from my single svn repo) into individual git repos of their
> own.
>=20
>  I'm still trying to get a grasp on the considerable git toolbox and I
> can't seem to find the functionality I'm describing, but I'm sure it
> exists - I heard Linus talk about it in that Google talk on git!

In the specific case of git-svn, you can probably give git-svn the
appropriate paths to import each project separately; that may do what you=

want, depending on your repository layout.

In the general case, if you want to split a subtree of a git repo into a =
git
repo, you want git-split, by Jamey Sharp and I:
<http://people.freedesktop.org/~jamey/git-split>
=46rom a copy of the git repo you want to split, just run "git-split subd=
ir",
optionally with a newest and oldest commit, and it will output the sha1 o=
f
the new top commit for use as the new branch ref.  Remove all other
branches, reflogs, and other references to the old commits, and use prune=

or gc to get rid of old objects.  Repeat as desired for other subdirs.

We really need to fix some things in git-split and get it merged into git=
=2E

- Josh Triplett


--------------enig9F99D97355CE439AF7D7E115
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGXu+WGJuZRtD+evsRAjq3AJsFVUolyLWAAIKotcyCKg7fInA5GACZAXnG
sdCIZCu2vRmTDlVSUhkAoYA=
=5+X6
-----END PGP SIGNATURE-----

--------------enig9F99D97355CE439AF7D7E115--
