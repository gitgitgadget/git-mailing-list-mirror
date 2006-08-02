From: Andy Parkins <andyparkins@gmail.com>
Subject: kompare won't parse git diffs
Date: Wed, 2 Aug 2006 11:07:39 +0100
Message-ID: <200608021107.43485.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1170946.IzDxStYeZk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 02 12:08:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Ddo-0006sF-Rn
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 12:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWHBKHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 06:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWHBKHt
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 06:07:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:26609 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750732AbWHBKHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 06:07:49 -0400
Received: by nf-out-0910.google.com with SMTP id o25so586534nfa
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 03:07:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=Im1ql2eCHSEUlM9xOscUB2d/+D2kYQWKuN6NNJ8bq3nLfaLNPIh+2b2GWKr0Bx8Go/3bg8eBhELxjRDGYB15qC9YjBAAmnXM9qqDD2xFe/gkW3ag7jpjhrVFGyMvybMF52JCx7hYD2HPj6+Xmf5H++bkQ41vBbiMmhhcs54yCL0=
Received: by 10.49.8.10 with SMTP id l10mr1991840nfi;
        Wed, 02 Aug 2006 03:07:47 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.gmail.com with ESMTP id n23sm1321954nfc.2006.08.02.03.07.46;
        Wed, 02 Aug 2006 03:07:47 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24643>

--nextPart1170946.IzDxStYeZk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

Kompare just shows blank for diffs redirected from git.  This makes it=20

I've tracked down the cause and it seems to be on the file declaration line=
s. =20
Here is a sample diff that kompare will not show.

diff --git a/file b/file
index a8b2ec6..a1e65fd 100644
=2D-- a/file
+++ b/file
@@ -1,2 +1,3 @@
 initial contents goes in master branch
 additional content added in repo1#master
+blah

As you can see, it's a simple addition of the line "blah".  Kompare shows t=
his=20
diff as blank.  Now if I modify the file so that the "---" and "+++" lines=
=20
both have "<tab>(something)" added:

diff --git a/file b/file
index a8b2ec6..a1e65fd 100644
=2D-- a/file      (anything can go here)
+++ b/file      (anything can go here)
@@ -1,2 +1,3 @@
 initial contents goes in master branch
 additional content added in repo1#master
+blah

http://bugs.kde.org/show_bug.cgi?id=3D131717

I've posted a bug for kompare, but thought that maybe it would be handy if =
git=20
outputted those bracketed comments anyway - I notice that "diff -u" from th=
e=20
command line does (although it uses the timestamp of the file).  Maybe the=
=20
object hash of the files being compared could go here?


Andy

=2D-=20
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com

--nextPart1170946.IzDxStYeZk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE0HlvwQJ9gE9xL20RAkjKAKCLtoggjFYuc0kkQ6bKSQXdfWTtUgCgrUSq
ZyCG5/tGR7FCM3YxlsAW04A=
=5Pgi
-----END PGP SIGNATURE-----

--nextPart1170946.IzDxStYeZk--
