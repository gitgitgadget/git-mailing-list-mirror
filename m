From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [WIP/PATCH 9/9] submodule: teach unpack_trees() to update
 submodules
Date: Mon, 3 Feb 2014 12:19:00 -0800
Message-ID: <20140203201900.GC16057@odin.tremily.us>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
 <52CC3E16.4060909@web.de>
 <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
 <52EFF25E.6080306@web.de>
 <52EFF3E9.2060403@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:19:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPz9-00067h-Nn
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbaBCUTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:19:06 -0500
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:39342
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753517AbaBCUTE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Feb 2014 15:19:04 -0500
Received: from omta09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id ModW1n0030SCNGk57wK2UL; Mon, 03 Feb 2014 20:19:02 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta09.westchester.pa.mail.comcast.net with comcast
	id MwK11n008152l3L3VwK1ms; Mon, 03 Feb 2014 20:19:02 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id AB0ABFC4B2D; Mon,  3 Feb 2014 12:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1391458740; bh=h1R0OKRRPFiaJFdavMWaqyDenqqYdoD8AHQ0T3p95Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f75FcTXJgLvK7vvYJG0JPAeL95nBNBywrJzV7E1gn5b4SPJUJwacgGxmjqtY7NI1H
	 OSHetoCIO93JoTMCQX3+JTaRh+Hvg+LA4uAUK7ljMqn1gxgJCfqxiCHpibYdv7pllk
	 06q1F+uqU/nwcv7N9nnD7Hed9lW/8hN80yBdl/80=
Content-Disposition: inline
In-Reply-To: <52EFF3E9.2060403@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1391458742;
	bh=Chniw8gWrpA/va70mLRm0zKePinfk5r+6gE033mj8pw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=RKlG/xD65S+n3mzl395J429oFzwC1DQWX9q/j0C/qLuBCOrcdV8T0K0Jsn8TfJ2k6
	 GytxfyY62z2jPcC5ZXsB9xh8uVpPKVbcb8+vg1+bPciYfSIgt8O0PDI56Mu/xWCoko
	 mQ4H55kg4Y2UOobLBF+lNw3VnG750fs/lacWT7J1Gn3s9fY1mgvjH4YD+Y3XIz4e1D
	 VgD6uvghBQxAqXpwzyLGUUY9q/HnrUmX7eetmS5hGlKiB7dbffyRwnD9WrDOn2nFxO
	 tkI+k8vGVkqDDMqmSPPDnC5y6g1W08ez8upJEuxwCx7Rs9CbCjramEtTIiUy6MnhdX
	 3AxV95gHLCGXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241472>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2014 at 08:54:17PM +0100, Jens Lehmann wrote:
> Implement the functionality needed to enable work tree manipulating
> commands so that an changed submodule does not only affect the index but
> it also updates the work tree of any initialized submodule according to
> the SHA-1 recorded in the superproject.

How about:

  =E2=80=A6so that *a* changed submodule ** updates the index and work tree=
 of
  any initialized submodule according to the SHA-1 recorded in the
  superproject.  Before this commit it updated neither; users had to
  run 'submodule update' to propagate gitlink updates into the
  submodule.

I'm pretty sure that's accurate anyway ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS7/mzAAoJEKKfehoaNkbt83oP/ReI2QSpiY94sxWoOM7HRRJP
nBVNKWhlzIocUfDa8rH0VDskYFlI76ud43N5Mq7MLG89M3H3CdGG/tocYxg5ASAh
26CnAfrcrNE7GuCsbX/Ue3kcn7VD3pd5n9fwy/xnxirptdZ9DttlHDNrDZdiMwEW
G+QEghPG061OKci2kD6NhIYD7XyN00V6E5NeAtJ5LJxN8US5LgVm2xypPQ/fhIXZ
8ktGnADoSXo/f65vbbWkjQofCVAI1R8IJXOi0zpFiWvM9g1GMBYCsQwj4PnkbKwH
BzdCjBhAz1PXBHazUM8YcqJ4W8AwBEeheovxKZE+1B99Xm3uPBW0ChJ7OkM4harS
NEmQc9ox0DuTunkVY5fv6mi18klF3aFHprNDazt+rTCwtvttFA6mcbhnlvG5fzkm
LZBFvE+rVWLb4R2yaCfn1o4w3umt0ut+sSVusI5DZfCYRuZO3elvdkRRN/NN5Ljt
cjA3zQTiaO+6srpCxUkmFMzN7ja+LVPqbvlAue9jEyRyoV3aBJLa6jBG3BCPbfrD
GczCDPgI7TbHo217/aM9/0oCle172DhqLBTs9tU030LfEDPCZ65JJyTbfY5cL5d/
hd09OrVmNgJ+twoB6cxuY8jjpINXJyz9nqnyeEL5YnJ3xFXN+ovsLi80s0sgkvGK
q/Rsgl3BLP4KTaxzYmpW
=AIhM
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
