From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 01:53:22 +0200
Message-ID: <20080330235322.GV11666@genesis>
References: <20080330231408.GR11666@genesis> <alpine.LSU.1.00.0803310137090.18259@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6k8oSBQUGGHRSAt9"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:54:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7Li-000776-Op
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYC3XxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 19:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYC3XxZ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:53:25 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60493 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbYC3XxY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 19:53:24 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 514B21B2579;
	Mon, 31 Mar 2008 01:53:23 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 419A444699;
	Mon, 31 Mar 2008 01:50:15 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CAC681190547; Mon, 31 Mar 2008 01:53:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803310137090.18259@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78532>


--6k8oSBQUGGHRSAt9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2008 at 01:41:18AM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> And what about system dependency?  I mean, if at all, this stuff belongs=
=20
> to compat/.  Definitely not into builtin-gc.c.  And yes, that means that=
=20
> you should not call the function is_on_battery() blindly, but _only_ if=
=20
> defer_on_battery is set.

Hm, should I just move it to there or should there be some kind of
check? Currently it just tries to open that file under /sys and if
fails, it just assumes we are not on battery. I think that's the
expected behaviour on systems not having a /sys filesystem.

As far as I see, compat/ is for functions which are available on some
systems but not an all ones. Obviously is_on_battery() won't be available
on any system. :)

The other issues (I hope) are fixed in the second patch.

--6k8oSBQUGGHRSAt9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH8Cfye81tAgORUJYRAqhYAJ94zTKNyUcxIGC5lIhWFFtygU4zRwCghQnc
LbmRf11UO7bI51qdQ8btb+A=
=SzFE
-----END PGP SIGNATURE-----

--6k8oSBQUGGHRSAt9--
