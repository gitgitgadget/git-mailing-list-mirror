From: =?iso-8859-2?Q?Jan_Pe=B9ta?= <jan.pesta@certicon.cz>
Subject: [PATCH] GIT SVN
Date: Fri, 1 Mar 2013 13:24:58 +0100
Message-ID: <000301ce1677$c9eb3f80$5dc1be80$@certicon.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0004_01CE1680.2BB21880"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 01 13:25:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBP1e-000510-OT
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 13:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab3CAMY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 07:24:56 -0500
Received: from service.certicon.cz ([90.183.112.10]:4576 "EHLO
	service.certicon.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab3CAMY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 07:24:56 -0500
Received: from miami (c-006.certicon.cz [90.183.112.6])
	(Authenticated sender: pesta)
	by service.certicon.cz (Postfix) with ESMTPSA id CCAA11707E7
	for <git@vger.kernel.org>; Fri,  1 Mar 2013 13:24:52 +0100 (CET)
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac4Wd8l967/GQjHXR8WxH2dOsd2b5w==
Content-Language: cs
X-certicon-MailScanner-Information: Please contact our ICT for more information
X-MailScanner-ID: CCAA11707E7.0BD4C
X-certicon-MailScanner: Found to be clean
X-certicon-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=0.006, required 5.1, autolearn=disabled, ALL_TRUSTED -1.00,
	BAYES_05 -0.50, SUBJ_ALL_CAPS 1.51)
X-certicon-MailScanner-From: jan.pesta@certicon.cz
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217271>

This is a multipart message in MIME format.

------=_NextPart_000_0004_01CE1680.2BB21880
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Sorry,
My fault :)

Here is a patch atached.

Jan

Kind regards / S pozdravem
=A0
Jan Pe=B9ta
SW Engineer Sr.

CertiCon a.s., www.certicon.cz
Vaclavska 12
12000 Prague 2
Czech Republic
=A0
Office Prague: +420 224 904 406
Mobile: +420 604 794 306
=A0
E-mail: jan.pesta@certicon.cz

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On =
Behalf
Of Jan Pe=B9ta
Sent: Friday, March 01, 2013 11:29 AM
To: git@vger.kernel.org
Subject: [PATCH]

Hi,

I found a problem when using GIT-SVN.

In inproperly merges in SVN causes that the ranges contains additional
character "*".=20

Attached patch fix this issue, I have it already tested for several =
months.

Regards,
Jan


Kind regards / S pozdravem
=A0

Jan Pe=B9ta
SW Engineer Sr.

CertiCon a.s., www.certicon.cz
Vaclavska 12
12000 Prague 2
Czech Republic
=A0
Office Prague: +420 224 904 406
Mobile: +420 604 794 306
=A0
E-mail: jan.pesta@certicon.cz


--
To unsubscribe from this list: send the line "unsubscribe git" in the =
body
of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html

------=_NextPart_000_0004_01CE1680.2BB21880
Content-Type: application/octet-stream;
	name="svn.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="svn.patch"

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm=0A=
index 0ebc68a..6bd18e9 100644=0A=
--- a/perl/Git/SVN.pm=0A=
+++ b/perl/Git/SVN.pm=0A=
@@ -1493,6 +1493,7 @@ sub lookup_svn_merge {=0A=
 	my @merged_commit_ranges;=0A=
 	# find the tip=0A=
 	for my $range ( @ranges ) {=0A=
+		$range =3D~ s/[*]$//;=0A=
 		my ($bottom, $top) =3D split "-", $range;=0A=
 		$top ||=3D $bottom;=0A=
 		my $bottom_commit =3D $gs->find_rev_after( $bottom, 1, $top );=0A=

------=_NextPart_000_0004_01CE1680.2BB21880--
