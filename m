From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] translate bad characters in refnames during git-svn
	fetch
Date: Mon, 16 Jul 2007 13:15:09 +0200
Message-ID: <20070716111509.GC18293@efreet.light.src>
References: <20070715130548.GA6144@piper.oerlikon.madduck.net> <20070716033050.GA29521@muzzle>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Cc: git discussion list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 13:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAOXw-00011A-P2
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 13:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708AbXGPLPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 07:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756784AbXGPLPS
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 07:15:18 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:47416 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757173AbXGPLPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 07:15:16 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3083157371;
	Mon, 16 Jul 2007 13:15:15 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id zCjVERRQMFPn; Mon, 16 Jul 2007 13:15:13 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 233F05725E;
	Mon, 16 Jul 2007 13:15:12 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IAOXl-0000GW-8B; Mon, 16 Jul 2007 13:15:09 +0200
Content-Disposition: inline
In-Reply-To: <20070716033050.GA29521@muzzle>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52662>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2007 at 20:30:50 -0700, Eric Wong wrote:
> The major issue with this is that it doesn't handle odd cases
> where a refname is sanitized into something
> (say "1234~2" sanitizes to "1234=3D2"), and then another branch
> is created named "1234=3D2".
>=20
> git-svn should at least keep track of what it got sanitized to, to
> avoid clobbering branches.
>=20
> I started working on this a while back but haven't gotten around
> to revisiting it:
> http://thread.gmane.org/gmane.comp.version-control.git/45651

I believe % is safe, right? So what if git-svn just url-escaped stuff in the
branch name it does not like. Of course % would be included in the list of
characters it does not like. Eg. 1234~2 would escape to 1234%7E2 and if the
user ever head 1234%7E2 in svn, it would simply escape too, to 1234%257E2.

Space is rather common, but that's why there is the + rule in url-encoding =
--
"foo bar" escapes to "foo+bar" and "foo+bar" escapes to "foo%2Bbar". Or you
could use something else to escape space. I can only think of "=3D", "_" is=
 too
common to have it escaped and anything else would conflict with either git =
or
shell.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGm1M9Rel1vVwhjGURAo4JAKC4m2rV9SQ5WoPtemFXKGiUJYfFkgCeP//l
vWtAK3wCHVYgAgyRBP9PMvg=
=jOhU
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
