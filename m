From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Anomaly in git log?
Date: Sat, 1 Mar 2008 13:35:54 +1100
Message-ID: <20080301133554.7a3cbd35.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__1_Mar_2008_13_35_54_+1100_YYb./.LfVg_MUVjk"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 03:36:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVHaT-0006QQ-Qz
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 03:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbYCACf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 21:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbYCACf5
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 21:35:57 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:36126 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbYCACf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 21:35:56 -0500
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 184EF368003
	for <git@vger.kernel.org>; Sat,  1 Mar 2008 13:35:55 +1100 (EST)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.8; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75603>

--Signature=_Sat__1_Mar_2008_13_35_54_+1100_YYb./.LfVg_MUVjk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that under some circumstances "git log <range> -- <file>" will
not show you all the commits in the range that affected that file.  In
particular if one of the commits removes the file, previous modifying
commits are not shown.

I found this in the current linux-next tree (next-20080229).

git log stable.. -- arch/avr32/kernel/semaphore.c

will show the commit that removes this file, but not the commit that
modifies it.  So, is this a bug in git log or my understanding?

If you do "git log -p stable.." and search for the file name, you will
find the other commit.

git version 1.5.4.3 from Debian unstable.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__1_Mar_2008_13_35_54_+1100_YYb./.LfVg_MUVjk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHyMEPTgG2atn1QN8RAjkbAJ9B9Z1vr8WfjBXse0Yfss6+tLHuDwCdF4Gw
KrFvhYb5jf5YKuXjpLM6TUY=
=KLHH
-----END PGP SIGNATURE-----

--Signature=_Sat__1_Mar_2008_13_35_54_+1100_YYb./.LfVg_MUVjk--
