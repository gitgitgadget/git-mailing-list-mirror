From: Michael Ellerman <michael@ellerman.id.au>
Subject: Any plans to make export work?
Date: Fri, 2 Sep 2005 00:53:15 +1000
Message-ID: <200509020053.20471.michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8942565.J4K6rgPlX6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 01 16:54:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAqRk-0000bF-O3
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 16:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbVIAOxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 10:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVIAOxY
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 10:53:24 -0400
Received: from ozlabs.org ([203.10.76.45]:13245 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965174AbVIAOxX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2005 10:53:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 2A44368144
	for <git@vger.kernel.org>; Fri,  2 Sep 2005 00:53:22 +1000 (EST)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7995>

--nextPart8942565.J4K6rgPlX6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Y'all,

I've been playing with export a bit, and it doesn't seem to work. Or at lea=
st=20
it doesn't do what I think of as "work"-ing.

I'm basically doing a git-export and trying to create a quilt series out of=
=20
it.

When you do a "quilt push -a" I get as far as:
06f81ea8ca09b880cadf101d7e23b500e9c164bc
[PATCH] scsi: remove volatile from scsi data

which doesn't apply as it (seems to) conflict with:=20
152587deb8903c0edf483a5b889f975bc6bea7e0
[PATCH] fix NMI lockup with CFQ scheduler

Those two commits (and others) were merged by hand in:
c46f2ffb9e7fce7208c2639790e1ade42e00b146
merge by hand (scsi_device.h)

Export gives me a patch for the merge, but it a) appears to contain everyth=
ing=20
that was merged, not just the fixup-by-hand, and b) export spits it out aft=
er=20
both of the commits which the merge merged - which is no good as quilt=20
doesn't even get that far.

I realise I'm trying to represent a DAG as a linear series of patches. But =
the=20
merge order is a linear sequence of commits, and so it *should* be=20
representable as a linear series of patches. I think.

Any thoughts?

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart8942565.J4K6rgPlX6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDFxXgdSjSd0sB4dIRAlo3AJ9PYGjUpAx49VvZwuiEpMcdi9zQogCfeBtB
vKXoqqXmD64biSf1XAGP2ao=
=lbgB
-----END PGP SIGNATURE-----

--nextPart8942565.J4K6rgPlX6--
