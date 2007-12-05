From: Aidan Van Dyk <aidan@highrise.ca>
Subject: [PATCH] Compile fix for SCO OpenServer
Date: Wed, 5 Dec 2007 12:21:25 -0500
Message-ID: <20071205172125.GF12636@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="25rOlkxR6a4U87uN"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 18:45:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzyIr-0001Kz-Ex
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 18:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbXLERoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 12:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbXLERoU
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 12:44:20 -0500
Received: from yugib.highrise.ca ([205.150.199.213]:53452 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbXLERoR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 12:44:17 -0500
X-Greylist: delayed 1370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2007 12:44:16 EST
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 65CFF111E3A;
	Wed,  5 Dec 2007 12:21:25 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67170>


--25rOlkxR6a4U87uN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

SCO OpenServer hides the definitions of (at least) u_short and friends if
_XOPEN_SOURCE is defined.

Signed-off-by: Aidan Van Dyk <aidan@highrise.ca>
---

diff --git a/git-compat-util.h b/git-compat-util.h
index ca0a597..be8cbe8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -24,7 +24,7 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)      ((int)(sizeof(x) * 2.56 + 0.5) + 1)

-#if !defined(__APPLE__) && !defined(__FreeBSD__)
+#if !defined(__APPLE__) && !defined(__FreeBSD__) && !defined (__OPENSERVER__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif

--25rOlkxR6a4U87uN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFHVt4UuVxNPsxNPScRAkfAAJ94/YYO1vvq8ISkXifaFXGyxA8jhgCfbz54
HMmxPb8o9dwPyITeYon3Bw4=
=QlQh
-----END PGP SIGNATURE-----

--25rOlkxR6a4U87uN--
