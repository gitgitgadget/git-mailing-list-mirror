From: Frans Pop <elendil@planet.nl>
Subject: [BUG] Invalid rebase command leaves unclean status
Date: Sat, 3 Nov 2007 18:04:51 +0100
Message-ID: <200711031804.52259.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2249858.zjh7fAh20a";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 18:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoMQn-0006ZL-Ai
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 18:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbXKCREy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 13:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbXKCREy
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 13:04:54 -0400
Received: from hpsmtp-eml13.KPNXCHANGE.COM ([213.75.38.113]:44472 "EHLO
	hpsmtp-eml13.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754490AbXKCREx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Nov 2007 13:04:53 -0400
Received: from hpsmtp-eml03.kpnxchange.com ([213.75.38.103]) by hpsmtp-eml13.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 3 Nov 2007 18:04:52 +0100
Received: from faramir.fjphome.nl ([84.85.147.182]) by hpsmtp-eml03.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 3 Nov 2007 18:04:52 +0100
User-Agent: KMail/1.9.7
X-OriginalArrivalTime: 03 Nov 2007 17:04:52.0692 (UTC) FILETIME=[A697A940:01C81E3B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63293>

--nextPart2249858.zjh7fAh20a
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The first command results in the creation of an empty .dotest-merge/output=
=20
file which blocks any next attempt to do an interactive rebase until it is=
=20
manually removed.

$ git rebase master -i
Invalid branchname: -i
$ git rebase -i master
Interactive rebase already started
$ ls .git/.dotest-merge/
output
$ cat .git/.dotest-merge/output
$ rm -r .git/.dotest-merge/
$ git rebase -i master=20
<works>

This is with git version 1.5.3.5.

Cheers,
=46rans Pop

--nextPart2249858.zjh7fAh20a
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLKo0gm/Kwh6ICoQRAtmsAJ9JnSEiJnDlAgeAGK9AZI9Syw83hQCgk2mM
DcY/kuhdvvV+h/2NVgZd+w0=
=9alW
-----END PGP SIGNATURE-----

--nextPart2249858.zjh7fAh20a--
