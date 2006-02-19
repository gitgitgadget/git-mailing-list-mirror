From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: New shiny gitk
Date: Sun, 19 Feb 2006 23:12:15 +0300
Message-ID: <20060219231215.545b1537.vsu@altlinux.ru>
References: <17400.23434.724188.649656@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__19_Feb_2006_23_12_15_+0300_xEJ/RHHPvlXcTG1y"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 21:12:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAuvA-0004U1-1d
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 21:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWBSUMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 15:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWBSUMg
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 15:12:36 -0500
Received: from master.altlinux.org ([62.118.250.235]:55561 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750953AbWBSUMg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 15:12:36 -0500
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 8032EE36A9; Sun, 19 Feb 2006 23:12:24 +0300 (MSK)
Received: by procyon.home (Postfix, from userid 500)
	id D8632E36BC6; Sun, 19 Feb 2006 23:12:17 +0300 (MSK)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17400.23434.724188.649656@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16448>

--Signature=_Sun__19_Feb_2006_23_12_15_+0300_xEJ/RHHPvlXcTG1y
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Feb 2006 22:50:34 +1100 Paul Mackerras wrote:

> I just created a branch called "new" in my gitk repository at
>=20
> git://git.kernel.org/pub/scm/gitk/gitk.git
>=20
> which has a new improved version of gitk which is much faster than the
> old one and has a better graph layout algorithm.  I'd like people to
> try it out and tell me how they like it and if I broke anything (I'm
> pretty sure I broke the "Update" function, for instance).

I have found a case where the new algorithm produces much worse layout
than before.

I cloned the Linus' kernel tree:

   git clone git://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2=
.6.git linux-2.6

then fetched the Ubuntu tree:

   git fetch git://www.kernel.org/pub/scm/linux/kernel/git/bcollins/ubuntu-=
2.6.git master:ubuntu

then tried to look at Ubuntu changes:

  gitk origin..ubuntu

The old algorithm was producing a graph with less than 20 lines on the
left, so the patch description was visible.  The new version, however,
produces something which does not fit even on a 1920x1200 screen (look
at the bottom of the graph).

> If you use -d to get commits ordered by date, you will need the latest
> version of git-rev-list, which has the --date-order option.

I tried this option - it changes some things, but does not fix that
layout problem.

--Signature=_Sun__19_Feb_2006_23_12_15_+0300_xEJ/RHHPvlXcTG1y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFD+NEhW82GfkQfsqIRAiQvAJ9an3srcnaz1XxDQ8uk6B99hwyMxQCfUtLi
yZCEnEKTEGIVasokzSY1KKI=
=0iXU
-----END PGP SIGNATURE-----

--Signature=_Sun__19_Feb_2006_23_12_15_+0300_xEJ/RHHPvlXcTG1y--
