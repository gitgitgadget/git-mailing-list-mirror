From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 10/9] Sanitize @to recipients.
Date: Wed, 25 Apr 2007 21:53:22 -0700
Message-ID: <20070426045322.GM7846@curie-int.orbis-terrarum.net>
References: <1177555043986-git-send-email-robbat2@gentoo.org> <11775550432104-git-send-email-robbat2@gentoo.org> <1177555043272-git-send-email-robbat2@gentoo.org> <11775550432268-git-send-email-robbat2@gentoo.org> <11775550433288-git-send-email-robbat2@gentoo.org> <11775550432746-git-send-email-robbat2@gentoo.org> <7vhcr3vkjd.fsf@assigned-by-dhcp.cox.net> <20070426044137.GL7846@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lBqJz4CGKwlWe7/k"
Cc: Junio C Hamano <junkio@cox.net>
To: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 08:02:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgx3i-0003Nv-7K
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 08:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbXDZGCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 02:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756AbXDZGCX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 02:02:23 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:40733 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754751AbXDZGCW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 02:02:22 -0400
Received: (qmail 15823 invoked from network); 26 Apr 2007 05:02:20 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 05:02:20 +0000
Received: (qmail 3768 invoked by uid 10000); 25 Apr 2007 21:53:22 -0700
Content-Disposition: inline
In-Reply-To: <20070426044137.GL7846@curie-int.orbis-terrarum.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45614>


--lBqJz4CGKwlWe7/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We need to sanitize @to as well to ensure that names are properly quoted.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 git-send-email.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e1562b3..a45439e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -274,6 +274,7 @@ sub expand_aliases {
 }
=20
 @to =3D expand_aliases(@to);
+@to =3D (map { sanitize_address_rfc822($_) } @to);
 @initial_cc =3D expand_aliases(@initial_cc);
 @bcclist =3D expand_aliases(@bcclist);

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--lBqJz4CGKwlWe7/k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGMDBCPpIsIjIzwiwRAm4gAJ9a+D0uZZmIC5tqEpA/OIIpq9ywTQCgxtBG
NYy7VKZHzXmhOic+0g4VOFA=
=6nt3
-----END PGP SIGNATURE-----

--lBqJz4CGKwlWe7/k--
