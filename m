From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: gitweb search page link slightly wrong
Date: Tue, 01 May 2007 12:13:29 +0200
Message-ID: <1178014409.3483.12.camel@johannes.berg>
References: <1177706593.3565.59.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JlXhy+eQ6wdkyggIhbjx"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 12:12:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HipLq-0001dL-98
	for gcvg-git@gmane.org; Tue, 01 May 2007 12:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031661AbXEAKMu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 06:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031660AbXEAKMt
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 06:12:49 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:58329 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031656AbXEAKMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 06:12:48 -0400
Received: from [84.135.254.215] (helo=[10.0.0.4])
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.66)
	(envelope-from <johannes@sipsolutions.net>)
	id 1HipLi-0007ew-I0
	for git@vger.kernel.org; Tue, 01 May 2007 11:12:46 +0100
In-Reply-To: <1177706593.3565.59.camel@johannes.berg>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45938>


--=-JlXhy+eQ6wdkyggIhbjx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This seems to fix it but I have no idea what it breaks. Command
injection should be stopped a few lines above that, and no other
parameter is ever quoted using quotemeta, so I'm not sure what the point
is, but I suppose it is actually necessary because the search text is
then wrapped into a regular expression or something?

--- git.orig/gitweb/gitweb.perl	2007-05-01 11:58:27.000000000 +0200
+++ git/gitweb/gitweb.perl	2007-05-01 12:11:56.000000000 +0200
@@ -368,7 +368,6 @@ if (defined $searchtext) {
 	if (length($searchtext) < 2) {
 		die_error(undef, "At least two characters are required for search parame=
ter");
 	}
-	$searchtext =3D quotemeta $searchtext;
 }
=20
 our $searchtype =3D $cgi->param('st');


--=-JlXhy+eQ6wdkyggIhbjx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNxLJ/ETPhpq3jKURAoORAJ9OKZSvv4uC0fkxaq+2ulXUkyxGOgCfVken
5+/sTVq5W5RJX/o0/HfHNZ4=
=LaOw
-----END PGP SIGNATURE-----

--=-JlXhy+eQ6wdkyggIhbjx--
