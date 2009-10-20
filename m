From: "Philip Allison" <philip.allison@smoothwall.net>
Subject: Git rebase using "wrong" commit
Date: Tue, 20 Oct 2009 06:26:22 -0500
Message-ID: <1256037982.7122.31.camel@gridbug.soton.smoothwall.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
	protocol="application/pgp-signature";
	micalg=pgp-sha1;
	boundary="=-N+OilIXwjqrtY+FUDYrd"
Cc: "Thomas Adam" <thomas.adam@smoothwall.net>,
	"Philip Allison" <philip.allison@smoothwall.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 14:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0DnO-0006AI-6M
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 14:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbZJTM0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 08:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbZJTM0X
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 08:26:23 -0400
Received: from server514c.exghost.com ([72.32.253.76]:4069 "EHLO
	server514.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751934AbZJTM0W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 08:26:22 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2009 08:26:22 EDT
Received: by server514.appriver.com (CommuniGate Pro PIPE 5.2.14)
  with PIPE id 80274402; Tue, 20 Oct 2009 06:26:27 -0500
Received: from [72.32.253.159] (HELO fe08.exg4.exghost.com)
  by server514.appriver.com (CommuniGate Pro SMTP 5.2.14)
  with ESMTP id 80274399 for git@vger.kernel.org; Tue, 20 Oct 2009 06:26:26 -0500
Received: from BE03.exg4.exghost.com ([72.32.253.147]) by fe08.exg4.exghost.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Oct 2009 06:26:24 -0500
Received: from 67.192.118.157 ([67.192.118.157]) by BE03.exg4.exghost.com ([72.32.253.147]) via Exchange Front-End Server exg4.exghost.com ([72.32.253.163]) with Microsoft Exchange Server HTTP-DAV ; Tue, 20 Oct 2009 11:26:23 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Received: from gridbug by exg4.exghost.com; 20 Oct 2009 12:26:22 +0100
Content-class: urn:content-classes:message
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Git rebase using "wrong" commit
Thread-Index: AcpReCe5BmSvRqoqRRuyDdVrUNHz6w==
X-OriginalArrivalTime: 20 Oct 2009 11:26:24.0117 (UTC) FILETIME=[27EBCA50:01CA5178]
X-Policy: GLOBAL - UNKNOWN
X-Primary: philip.allison@smoothwall.net
X-Note: This Email was scanned by AppRiver SecureTide
X-Note: VCH-CT/SI:0-1456/SG:2 10/20/2009 6:26:20 AM
X-Virus-Scan: V-X0M0
X-Note: ICH-CT/SI:0-752/SG:2 10/20/2009 6:26:20 AM
X-Note: TCH-CT/SI:0-280/SG:8 10/20/2009 6:26:20 AM
X-GBUdb-Analysis: 0, 72.32.253.159, Ugly c=0.794862 p=-0.901698 Source White
X-Signature-Violations: 0-0-0-32767-c
X-Note: Spam Tests Failed: 
X-Country-Path: ->UNITED STATES->UNITED STATES->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 72.32.253.159
X-Note-Reverse-DNS: fe08.exg4.exghost.com
X-Note-WHTLIST: philip.allison@smoothwall.net
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 115 116 117 118 122 123 220 
X-Note: Mail Class: VALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130790>


--=-N+OilIXwjqrtY+FUDYrd
Content-Type: multipart/mixed; boundary="=-yjYmLXKKqlc8bnK90V0o"


--=-yjYmLXKKqlc8bnK90V0o
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello all,
	We have a specific branch (integration/bug-fixes) which is under
continual rebase, shared amongst several developers.  The tracked
instances have "branch.integration/bug-fixes.rebase true" and
"branch.integration/bug-fixes.mergeoptions --no-ff" - this is working
well.  Individual developers merge their topic branches (in this case
bug fixes) into integration/bug-fixes and push it out.
	Occasionally, we want to release some bug fixes, but not others.  IOW,
when integration/bug-fixes comes to be rebased onto master, we wish to
preserve some of the topic branch merges, but not others.  This usually
works fine, but an issue has cropped up where there is a conflict
between two fixes, and only one of the two bug fixes has been released;
now, when we come to perform the rebase, it is not working as desired.

Output of "git log --first-parent master..integration/bug-fixes":

-----
commit 9f79ca3928d645435d1608e22297dacd2be94e3b
Merge: 2bc19f9 cd8273f
Author: Philip Allison <philip.allison@smoothwall.net>
Date:   Tue Oct 20 10:11:06 2009 +0100

    Merge branch 'bug/2' into integration/bug-fixes
   =20
    * bug/2:
      Unify format of files 1, 2 and 3
   =20
    Conflicts:
        file1

commit 2bc19f9af94e03e06fbe5a1034820c606d13c3d3
Merge: c785da2 b17a93c
Author: Philip Allison <philip.allison@smoothwall.net>
Date:   Tue Oct 20 10:07:37 2009 +0100

    Merge branch 'bug/1' into integration/bug-fixes
   =20
    * bug/1:
      Fix file 1
-----

bug/2 has, effectively, been merged into master; bug/1 has not; hence,
there is not (on master) any equivalent change to that which was made to
resolve the conflict.

"git rebase -i master" output (whilst on HEAD of integration/bug-fixes):

-----
pick b17a93c Fix file 1

# Rebase cd8273f..9f79ca3 onto cd8273f
-----

The trouble here is that b17a93c is the head of bug/1 - the rebase has
picked up the changes from that branch and is trying to apply them as a
fast-forward commit in the newly rebased integration/bug-fixes, instead
of trying to rebase the *merge* of bug/1 (i.e. 2bc19f9).
	The "-m" and "-p" options to rebase don't seem to be helping.  I have
tried getting rebase to "pick 2bc19f9" via -i, but that isn't working
either:

-----
fatal: Commit 2bc19f9af94e03e06fbe5a1034820c606d13c3d3 is a merge but no
-m option was given.
Could not apply 2bc19f9...
-----

Interestingly, rebase does *not* seem to be trying to recreate 9f79ca3
(or its second parent), which is the problem I was originally expecting
to run into.

At the moment I don't know where to go from here, short of manually
recreating the branch as I want it, which I am loathe to do.  Ideas and
suggestions much appreciated.

Please find attached a working copy of the repository, just before any
attempted rebase.

Regards
--=20
Philip Allison
Senior Developer

SmoothWall Ltd
1 John Charles Way
Leeds LS12 6QA
United Kingdom

1 800 959 3760     (USA, Canada and North America)
0870 1 999 500     (United Kingdom)
+44 870 1 999 500  (All other countries)

SmoothWall is registered in England: 4298247

This email and any attachments transmitted with it are confidential
to the intended recipient(s) and may not be communicated to any
other person or published by any means without the permission of
SmoothWall Limited.  Any opinions stated in this message are solely
those of the author.  See: http://smoothwall.net/company/email.php
for the full text of this notice.

--=-yjYmLXKKqlc8bnK90V0o
Content-Disposition: attachment; filename="repo.tar.gz"
Content-Type: application/x-compressed-tar; name="repo.tar.gz"
Content-Transfer-Encoding: base64

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


--=-yjYmLXKKqlc8bnK90V0o--

--=-N+OilIXwjqrtY+FUDYrd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkrdnl4ACgkQDv5RnzK1PH1fwwCfbjkZd4v30HZSyfB66kdNnKqm
MDsAoJpNekq5D5XtOT2U/tfuu30DUlVu
=qMhj
-----END PGP SIGNATURE-----

--=-N+OilIXwjqrtY+FUDYrd--
