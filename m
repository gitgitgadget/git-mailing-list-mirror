From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: git add -i doesn't update permissions
Date: Wed, 26 Mar 2008 11:23:32 +0100
Message-ID: <20080326102332.GA26842@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 23:50:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeeRn-0006kw-Ox
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 23:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbYCZWtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 18:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755791AbYCZWtl
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 18:49:41 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4676 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753816AbYCZWtk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 18:49:40 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id C65EF48802E; Wed, 26 Mar 2008 23:49:37 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JeeNB-0002Zb-2M
	for git@vger.kernel.org; Wed, 26 Mar 2008 23:45:37 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JeSn6-0006zB-4Q
	for git@vger.kernel.org; Wed, 26 Mar 2008 11:23:32 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78316>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 77c90f6..424271c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -66,4 +66,14 @@ test_expect_success 'revert works (commit)' '
        grep "unchanged *+3/-0 file" output
 '
=20
+test_expect_success 'update file permissions' '
+       git reset --hard &&
+       chmod +x file &&
+       printf "p\n1\n" | git add -i
+'
+
+test_expect_failure "update file permissions doesn't work" '
+       git status
+'
+
 test_done

Bye, J=F6rg.
--=20
Unsere Zweifel sind Verr=E4ter und oft genug verspielen wir den m=F6glichen
Gewinn, weil wir den Versuch nicht wagen.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH6iQkwe0mZwH1VIARAjesAKDDnqkSJF5fUhCq9QjqgxxLzwSJOwCfbSBE
QuEMY33w3j7BExZTL6W0fBk=
=XpR+
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
