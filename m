From: Adam Borowski <kilobyte@angband.pl>
Subject: git-bisect working only from toplevel dir
Date: Wed, 23 Nov 2011 15:50:34 +0100
Message-ID: <20111123145034.GB17927@angband.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 16:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTES2-00009a-Qj
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 16:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338Ab1KWPJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 10:09:21 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:50980 "EHLO
	tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308Ab1KWPJV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 10:09:21 -0500
X-Greylist: delayed 1125 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Nov 2011 10:09:20 EST
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.72)
	(envelope-from <kilobyte@tartarus.angband.pl>)
	id 1RTE9i-0004gE-4X
	for git@vger.kernel.org; Wed, 23 Nov 2011 15:50:34 +0100
Content-Disposition: inline
X-Junkbait: adolf@angband.pl, zareba@angband.pl
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@tartarus.angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185850>


--tsOsTdHNUZQcU9Ye
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

The requirement to be in the toplevel directory when calling git-bisect is
pretty infuriating.  I tried to find an explanation for this, and the only
reference I found was:

http://thread.gmane.org/gmane.comp.version-control.git/27524/focus=3D27596

However, since then, git-reset has been changed (in a81c311f).  What about
changing git-bisect as well?

A trivial patch seems to work for me, but I might have missed some corner
case.

--=20
1KB		// Yo momma uses IPv4!

--3MwIy2ne0vdjdPXF
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-git-bisect-allow-using-it-from-a-subdirectory.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 1dd5dda6a9db3d987e15784c4de24e593cc596e0 Mon Sep 17 00:00:00 2001
=46rom: Adam Borowski <kilobyte@angband.pl>
Date: Wed, 23 Nov 2011 15:08:42 +0100
Subject: [PATCH] git-bisect: allow using it from a subdirectory.

Just like git-reset, restricting it to toplevel is an annoyance, and the
latter has been changed in a81c311f.
---
 git-bisect.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 99efbe8..fd6ccdd 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -27,6 +27,7 @@ git bisect run <cmd>...
 Please use "git help bisect" to get the full man page.'
=20
 OPTIONS_SPEC=3D
+SUBDIRECTORY_OK=3DYes
 . git-sh-setup
 . git-sh-i18n
=20
--=20
1.7.8.rc3.31.g017d1


--3MwIy2ne0vdjdPXF--

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCgAGBQJOzQg5AAoJECw7Q2/qxoEBcSkIAIwuD/0MLce5IKLNYjdkuMjb
3w4sw09qI7zqFj4Nhe4FxiU5weKyOo+WYnzG3vUxnx+8MpXYvSb2JsYptCQYhsxf
3yLlgzkoxQVTfEMWEs1fXcsr/XTXcGzMuatuZVvj3clgx6dibGDgwqPunAV9nht0
u93iKINftdl4mLrE7CHk7Kv6PwYfEymowj9zssRoWchkdJ5lrC6JzWRSYUVGaGth
R8XsIKp7Mm9Nhg/Ruw/6BIT5kqjt8P255stAkHE6X1JT73r+5wSfDJnFcO87dePV
ZmRPLnC2qkDJ/ObZOBAH6wxa0Lbp6LOgBvnhcxyQY+wzj1FU4tQsYht3PBNDCog=
=+H13
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
