From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Fri, 12 Jan 2007 23:37:21 +0300
Message-ID: <20070112203721.GA4562@procyon.home>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com> <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com> <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net> <20070112184839.9431ddff.vsu@altlinux.ru> <81b0412b0701120938o1606dcachf2553a83b47921b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 22:06:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Tbr-0007HB-48
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 22:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbXALVGm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 16:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbXALVGm
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 16:06:42 -0500
Received: from master.altlinux.org ([62.118.250.235]:3906 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030499AbXALVGl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 16:06:41 -0500
X-Greylist: delayed 1745 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 16:06:41 EST
Received: by master.altlinux.org (Postfix, from userid 584)
	id EFF7BE38DD; Fri, 12 Jan 2007 23:37:35 +0300 (MSK)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0701120938o1606dcachf2553a83b47921b1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36710>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2007 at 06:38:26PM +0100, Alex Riesen wrote:
> On 1/12/07, Sergey Vlasov <vsu@altlinux.ru> wrote:
> >> Subject: [PATCH] merge-recursive: do not use on-file index when not=20
> >needed.
> >
> >This commit broke t3401-rebase-partial.sh:
> >
> >...
> >*   ok 3: rebase topic branch against new master and check git-am did no=
t=20
> >get halted
> >
>=20
> Hmm... Can't reproduce. Do you have your own patches in the tree?

I had when I encountered the problem, but then retested with clean
'master' (4494c656e2e29c468c48c9c2b20595342056e9dc) and got the same
crash.  But since the problem is an uninitialized stack variable, you
can get anything depending on the phase of the moon from it (however,
Valgrind should still be able to catch it).

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFp/GBW82GfkQfsqIRApB8AJ4sU6nyDKvLtqzii6gjI15czhtECwCfXYhX
DZjR+IPHd9qh2W4pm6QHumo=
=i/DH
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
