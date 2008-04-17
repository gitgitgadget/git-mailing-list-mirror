From: martin f krafft <madduck@madduck.net>
Subject: gitweb: pathinfo feature breaks commitdiff/raw links
Date: Thu, 17 Apr 2008 11:23:39 +0200
Message-ID: <20080417092339.GA17016@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 11:27:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmQMK-0002FR-Ax
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 11:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933356AbYDQJXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 05:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933266AbYDQJXt
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 05:23:49 -0400
Received: from clegg.madduck.net ([82.197.162.59]:40910 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933356AbYDQJXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 05:23:46 -0400
Received: from wall.oerlikon.madduck.net (84-75-148-163.dclient.hispeed.ch [84.75.148.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 339DBA86A2
	for <git@vger.kernel.org>; Thu, 17 Apr 2008 11:23:40 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 944189F18E
	for <git@vger.kernel.org>; Thu, 17 Apr 2008 11:23:39 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 56B14C16EF; Thu, 17 Apr 2008 11:23:39 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6808/Thu Apr 17 10:40:10 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79778>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

as per suggestion in gitweb.cgi, I put the following into my
gitweb.conf:

  $feature{'pathinfo'}{'default'} =3D [1];

This mostly works, but James Vega recently found a corner case where
this is broken: the raw link of a commitdiff page, such as

  http://git.madduck.net/v/code/mailplate.git?a=3Dcommitdiff;h=3Df7d2365ee0=
ab439217083dd613daa4757a4e3d6e

suddenly becomes

  http://git.madduck.net/v/ARRAY(0xbc3b70)?a=3Dcommitdiff_plain;h=3Df7d2365=
ee0ab439217083dd613daa4757a4e3d6e
                           ^^^^^^^^^^^^^^^
when the feature is turned on. It works when it's off.

I discussed this a bit on IRC, with the following bottom line:

  < jengelh> if you see ARRAY... in the url, and [1] in the source
  the wise Perl person says "ah, of course"

Unfortunately, I am neither wise nor a Perl person, so I resort to
just pointing this out to you and can offer to test any patches on
this live server.

Cheers,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"it is only the modern that ever becomes old-fashioned."=20
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIBxcbIgvIgzMMSnURAt47AJ0ZA4iZRrI+gRnOYnU+yFpwj8qoswCgk64I
ZYgV8UsmJGt7KlBAX3bSPmk=
=H2Ic
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
