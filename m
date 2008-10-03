From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Numeric Revision Names?
Date: Fri, 3 Oct 2008 19:13:52 +0200
Message-ID: <200810031913.55594.trast@student.ethz.ch>
References: <19796862.post@talk.nabble.com> <m3d4ihr7as.fsf@localhost.localdomain> <20081003115557.08d80c2f.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1861496.es48cj1Ivm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	marceloribeiro <marcelo@sonnay.com>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 19:16:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KloFA-00043C-Pf
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 19:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbYJCRN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 13:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbYJCRN5
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 13:13:57 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:52294 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594AbYJCRN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 13:13:56 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 3 Oct 2008 19:13:53 +0200
Received: from [192.168.0.7] ([84.75.157.245]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 3 Oct 2008 19:13:53 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20081003115557.08d80c2f.stephen@exigencecorp.com>
X-OriginalArrivalTime: 03 Oct 2008 17:13:53.0412 (UTC) FILETIME=[69453C40:01C9257B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97438>

--nextPart1861496.es48cj1Ivm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Stephen Haberman wrote:
>=20
> > Second, in my opinion revision numbers are not that useful for
> > projects with large number of commits (where revision number might be
> > something like r4321), and nonlinear history (you don't know how r4555
> > relates to r4556: they might be on different branches).
>=20
> For projects that do have a central authority (e.g. internal corporate
> projects), revision numbers make more sense.
>=20
> Granted, they are on separate branches (like svn), but the nice thing
> about them is that they are monotonically increasing. E.g. our qa
> people love numbers--the bug fix ticket says dev just put in
> r100...qa/production box says it is on r95. Doesn't matter the
> branch/whatever, they know the box doesn't have r100. Now, right, if
> its r105, it is trickier, although we also throw in branch name (e.g.
> topica-r100) which means no false positives but can lead to false
> negatives.

I wonder how that constitutes an argument for revision numbers.

=46irst, the _only_ guarantee you get out of monotonically increasing
revision numbers is that they're ... monotonically increasing.  You
might as well use the commit (not author!) timestamp for that purpose
(assuming your clocks are all synced).  They do not convey history
membership, only history non-membership, for the same obvious reason
that commit timestamps do.

Second, Git can do the check you mention above much more accurately.
If you tell QA that the fix is in 123abc, then 'git branch --contains
123abc' lists all local branches that have the fix, 'git describe
=2D-contains 123abc' gives you the nearest tag (i.e. usually the
lowest-numbered release version number) having the fix, etc.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1861496.es48cj1Ivm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjmUtMACgkQqUud07tmzP0cawCdHA3QaERZrxK6va+dNSnWVrqN
c8AAn3+66ztiAswkNfE06oE0yd2/btfP
=cu2e
-----END PGP SIGNATURE-----

--nextPart1861496.es48cj1Ivm--
