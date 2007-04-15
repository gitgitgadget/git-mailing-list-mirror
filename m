From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
	trees
Date: Sat, 14 Apr 2007 17:03:30 -0700
Message-ID: <20070415000330.GG3778@curie-int.orbis-terrarum.net>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <Pine.LNX.4.64.0704141019290.18655@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 02:03:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcsDW-00025I-PI
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 02:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbXDOADf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 20:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbXDOADf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 20:03:35 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:51221 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750782AbXDOADe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 20:03:34 -0400
Received: (qmail 20881 invoked from network); 15 Apr 2007 00:03:33 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 15 Apr 2007 00:03:33 +0000
Received: (qmail 25518 invoked by uid 10000); 14 Apr 2007 17:03:30 -0700
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704141019290.18655@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44473>


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 14, 2007 at 10:56:10AM +0200, Johannes Schindelin wrote:
> Ah! Seems we finally have a user for shallow clones! ;-)
Heh. I'm specifically looking at git, trying to resolve the deficiencies
that were identified during by one of our (Gentoo) SoC2006 projects, on
the potential migration of the Gentoo CVS. Git has matured tremendously
since then.

The primary Gentoo CVS module (gentoo-x86), has 234672 files tracked,
and 1309603 CVS revisions. Between 350k and 500k changesets, depending
on how you merge those revisions.

Couple of the things that were identified either in the SoC project, or
since then.
- Shallow history checkouts are important to our low-bandwidth
  ebuild-tree developers (people in places with 33.6k modems, because
  the phone lines don't work well enough for 56k), or other high latency
  setups.
- Shallow tree (subtree) checkouts, for the developers that focus on
  specific portions of large modules and have no interest in the rest of
  the that tree. Eg. Releng does their work in gentoo/src/releng.
- ACLs specific to subtree commits. Something similar to the cvs_acls.pl
  that FreeBSD uses would be great. Eg gentoo-x86/sec-policy/ is
  restricted to members of the security team (SELinux policies).
- CVS Keyword-like behavior, to specifically place the path and revision
  of certain files into the file directly, for ease of tracking when the
  file is removed from it's original surrounding. I know this one is
  going to draw some flack, but it's a very common practice for a user
  to copy a file out of the CVS tree, make some modifications, and then
  post the entire changed version up, esp. when the size of the changes
  exceeds the size of diff.

> Seriously again: I am at fault for putting the shallow support into Git,=
=20
> failing to provide sensible test cases. This was partly due to my=20
> laziness, and partly due to the overwhelming lack of demand.
I still haven't figured out a decent testcase for this, I need to dig
harder.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGIWvSPpIsIjIzwiwRAp/+AKDN4kUBGRCQ9RW4IjgCWHLxoByAdgCgvHIi
uqFHp2n64bfTDzxJ8X96pFA=
=gozZ
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
