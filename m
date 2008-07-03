From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/3] git-add--interactive: remove hunk coalescing
Date: Thu, 3 Jul 2008 21:24:13 +0200
Message-ID: <200807032124.22037.trast@student.ethz.ch>
References: <1215035956-26192-1-git-send-email-trast@student.ethz.ch> <7vtzf77wjp.fsf@gitster.siamese.dyndns.org> <7vod5f7w3f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart86797036.yBi7A5U0oE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 21:25:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEUQW-0003Fy-QR
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 21:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbYGCTYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbYGCTYJ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 15:24:09 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:24763 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbYGCTYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 15:24:07 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 3 Jul 2008 21:24:04 +0200
Received: from [192.168.0.2] ([84.75.156.10]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 3 Jul 2008 21:24:04 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vod5f7w3f.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 03 Jul 2008 19:24:04.0708 (UTC) FILETIME=[5B296A40:01C8DD42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87306>

--nextPart86797036.yBi7A5U0oE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
>=20
> > Blindly concatenating the above two and feeding them to "git apply" *ma=
y*
> > happen to work by accident, not by design.  This very much feels like a
> > hack of "This works most of the time for me, your mileage may vary" kin=
d,
> > which we would want to avoid when we can.
>=20
> Well, I changed my mind.  Let's run with this and see what happens.

In support of this being a feature of git-apply, notice that it even
handles the situation correctly where the context of a hunk has been
influenced by previous hunks, as in

@@ -1,2 +1,3 @@
 foo
+quux
 bar
@@ -1,3 +1,4 @@
 foo
 quux
+abc
 bar

With Don Zickus' recent patch, it also handles patches that go over
the same file twice.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch




--nextPart86797036.yBi7A5U0oE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhtJ2UACgkQqUud07tmzP0ePgCeMSCDyMaMGLC6/M80wbwvzSci
qOkAn1hZyq+epq3f99NsBcA7qBJjEDqg
=2ijV
-----END PGP SIGNATURE-----

--nextPart86797036.yBi7A5U0oE--
