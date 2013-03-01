From: =?iso-8859-2?Q?Jan_Pe=B9ta?= <jan.pesta@certicon.cz>
Subject: RE: [PATCH] GIT SVN
Date: Fri, 1 Mar 2013 13:55:32 +0100
Message-ID: <001001ce167c$0f376f10$2da64d30$@certicon.cz>
References: <000301ce1677$c9eb3f80$5dc1be80$@certicon.cz> <vpqsj4fmhgu.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0011_01CE1684.70FBD710"
Cc: <git@vger.kernel.org>
To: "'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 01 13:56:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBPVK-0007mO-EP
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 13:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab3CAMzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 07:55:33 -0500
Received: from service.certicon.cz ([90.183.112.10]:1288 "EHLO
	service.certicon.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab3CAMzc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 07:55:32 -0500
Received: from miami (c-006.certicon.cz [90.183.112.6])
	(Authenticated sender: pesta)
	by service.certicon.cz (Postfix) with ESMTPSA id 077EA1707DB;
	Fri,  1 Mar 2013 13:55:27 +0100 (CET)
In-Reply-To: <vpqsj4fmhgu.fsf@grenoble-inp.fr>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQLYBr7R5UpAzf+j4ArYDo75iW8jGQEzuZAPlnNLAfA=
Content-Language: cs
X-certicon-MailScanner-Information: Please contact our ICT for more information
X-MailScanner-ID: 077EA1707DB.C225F
X-certicon-MailScanner: Found to be clean
X-certicon-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=1.306, required 5.1, autolearn=disabled, ALL_TRUSTED -1.00,
	BAYES_50 0.80, SUBJ_ALL_CAPS 1.51)
X-certicon-MailScanner-SpamScore: s
X-certicon-MailScanner-From: jan.pesta@certicon.cz
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217273>

This is a multipart message in MIME format.

------=_NextPart_000_0011_01CE1684.70FBD710
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hi again,

Finally I created patch according to document.

Please have a look on referenced site for more details.

Currently I have a problems in our project, where SVN is main repository =
and
merge-info contains "*" which causes troubles in SVN.pm.

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


-----Original Message-----
From: Matthieu Moy [mailto:Matthieu.Moy@grenoble-inp.fr]=20
Sent: Friday, March 01, 2013 1:29 PM
To: Jan Pe=B9ta
Cc: git@vger.kernel.org
Subject: Re: [PATCH] GIT SVN

Jan Pe=B9ta <jan.pesta@certicon.cz> writes:

> Sorry,
> My fault :)
>
> Here is a patch atached.

Still, please, read Documentation/SubmittingPatches. Your patch cannot =
be
included as it is because of lack of sign-off.

Also, please write a commit message describing why this change is =
needed.
Where is this extra "*" comming from, and why do you need to remove it?

Thanks,

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/

------=_NextPart_000_0011_01CE1684.70FBD710
Content-Type: application/octet-stream;
	name="0001-In-inproperly-merges-the-ranges-contains-additional-.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-In-inproperly-merges-the-ranges-contains-additional-.patch"

>From 03aefff110cc46a82e87c01fed38ac6bb22b353b Mon Sep 17 00:00:00 2001=0A=
From: Jan Pesta <jan.pesta@certicon.cz>=0A=
Date: Fri, 1 Mar 2013 10:30:42 +0100=0A=
Subject: [PATCH] In inproperly merges, the ranges contains additional=0A=
 character "*".=0A=
=0A=
See =
http://www.open.collab.net/community/subversion/articles/merge-info.html=0A=
Extract:=0A=
The range r30430:30435 that was added to 1.5.x in this merge has a '*' =
suffix for 1.5.x\www.=0A=
This '*' is the marker for a non-inheritable mergeinfo range.=0A=
The '*' means that only the path on which the mergeinfo is explicitly =
set has had this range merged into it.=0A=
---=0A=
 perl/Git/SVN.pm | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
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
-- =0A=
1.8.1.msysgit.1=0A=
=0A=

------=_NextPart_000_0011_01CE1684.70FBD710--
