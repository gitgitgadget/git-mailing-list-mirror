From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Tue, 08 Jan 2013 12:48:57 -0500
Message-ID: <20130108174857.GF4662@odin.tremily.us>
References: <20130107003603.GA25698@odin.tremily.us>
 <20130107013952.GE3823@elie.Belkin> <50EA7269.1080006@web.de>
 <20130108143214.GA3755@odin.tremily.us> <50EC536D.8050606@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=JbKQpFqZXJ2T76Sg
Cc: Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:49:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsdIv-0006Py-Ip
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808Ab3AHRtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 12:49:17 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:54807 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485Ab3AHRtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 12:49:17 -0500
Received: from odin.tremily.us ([unknown] [72.68.82.220])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MGB00CI9ITLF600@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 08 Jan 2013 11:48:58 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 3BF8E77F45A; Tue,
 08 Jan 2013 12:48:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1357667337; bh=KxOYCmeAcJujF29r3vI52zquXNfXa21TY3+VPKYdIS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hgh7zLAaz9kzxOEfYp97ntBMF9RJAp3WqBvOBnX+fHUxSkK8l90/itVrih0QeliuS
 7hCRCFZ6TjFoB+u8MdcHYWhl/H2ZQuN/75XRQK9JI9+TPpK1DcXaWuXFZUz/1pEhxR
 ebjAoMfFUBYFiNUrCPEWR2CfdyVGtQb6JkI/qkVU=
Content-disposition: inline
In-reply-to: <50EC536D.8050606@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212984>


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2013 at 06:12:13PM +0100, Jens Lehmann wrote:
> Am 08.01.2013 15:32, schrieb W. Trevor King:
> >  The Git directory for the
> > submodule stays in .git/modules/submod-1/ (good), but the worktree in
> > .git/modules/submod-1/config still points to ../../../submod-1 (bad).
>=20
> You'll not only have to update the gitfile but also the core.worktree
> setting in the repo. Sorry I missed that when you posted your script.

My git-submodule-mv.sh script does update core.worktree.  The problem
is that `git checkout`, `git merge`, etc. do not.

> > This means that submodule moves are possible, but anyone trying to
> > share them between several repositories (or trying to rebase across
> > the move within their own repository) is in for a world of suffering
> > ;).  I'm not sure how this should be addressed, but I didn't see
> > anything handling it in Jens' new series.
>=20
> If you adjust core.worktree properly you'll just have the old
> submodule work tree lying around (just like you do after you rm'd
> it) and everything apart from that should just work.
>=20
> As I mentioned that will be fixed by recursive submodule checkout.
> I'll see if I can polish my preliminary branch so that interested
> people can play around with it if anyone is interested.

Sounds like a fix will be in here.  I'll definitely help put the
branch through its paces ;).

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ7FwHAAoJEEUbTsx0l5OMVwYQAJmmaKyZ3qLW6IbDIsiWkVll
pGWhZB+D4bXAnLc5bu8qrtGszZqu4wno9Ia+gTUsDmF+BXgBC+JoVIyLe31uWSjd
GA6i1t3VjDJetuW6hvcDjDOvcjHmHx7KzoqV7KDMGWCylnqFUeyo0ikqBJr1/IUj
cLVdy+dNSTyItdwfHwWOpWAplPeFp9pPBpTIOgV6G0uG+n1lTnoGF0/DYJ2e+/sd
oBZZPdtdF35mtQA6MkNh6X9+wyJFJ4buHwTI4d2cKPO3bUC7MAIXq2lYiRF8Z3qa
nA5wSIF7vJcPWHWPuN14N+FWx6ChEfUVzogIpZ7aMeRCkSwCPLj8EyoLRTyGRzAj
SK/7KtEQtHptXms8/02uv25QPduGEmlMDp+BflOiBfHHv3td0DQr4MF4jL0IgPkk
CD4mstCjMSKAUDYXuTSW40nsEQGb2fFFzlZvaB4sKN6y8f13qjT1U3v+Wgt24tTS
zQ2/xcSX43mKdZUrqJom9EVSMro/DTyETMlYjQ7WAhCvEopQYHBIHdKPCF9SKsrM
rilAdyiQihHrKKtsOoPR/SfgHrGdShbE7iui08T4ur45GWdgCt+0wM92r2QjHVOh
tMBMVeqb31AnqLpX0UboSlBx4iV40v91hww1j3+WjvFukO8YuDXQ0k48Z1a4wMoG
DxhZKB7QznDTcw8bUAQj
=njr6
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
