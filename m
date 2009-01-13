From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 22:53:12 +0100
Message-ID: <200901132253.15370.trast@student.ethz.ch>
References: <1231883002.14181.27.camel@starfruit>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1770796.hVjfL3f335";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 22:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrDN-0004e0-1P
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbZAMVxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 16:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbZAMVxC
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:53:02 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:41276 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532AbZAMVxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 16:53:00 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 22:52:58 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 22:52:57 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1231883002.14181.27.camel@starfruit>
X-OriginalArrivalTime: 13 Jan 2009 21:52:57.0946 (UTC) FILETIME=[4BECDBA0:01C975C9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105543>

--nextPart1770796.hVjfL3f335
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

R. Tyler Ballance wrote:
> Besides a vigorous flogging, we're looking at other ways to prevent this
> sort of thing from happening again; the option we've settled on is to
> remove the "--force" flag from our internal build of v1.6.1
>
> I'm wondering if somebody could point me in the right direction to
> remove "--force" (safely) from the builtin-push.c and removing the
> "rebase" command (we've got no use for it, and would prefer it gone).

IMHO your update (or pre-receive) hook should just disallow
non-fast-forward updates.

This doesn't really address git-rebase, but it will disallow pushing a
"harmfully" rebased branch since those are by definition non-ff.  Why
take away the option to correct a mistake in the last commit with 'git
rebase -i'?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1770796.hVjfL3f335
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkltDUsACgkQqUud07tmzP1JiwCffUOQvWFzgnsnfFR7J1sn2aVI
//gAn1Dzm9PIQ/bL25H5ha6l6NzlE9aM
=i84R
-----END PGP SIGNATURE-----

--nextPart1770796.hVjfL3f335--
