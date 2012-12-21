From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v8 1/3] submodule: add get_submodule_config helper funtion
Date: Fri, 21 Dec 2012 06:04:25 -0500
Message-ID: <20121221110425.GE16849@odin.tremily.us>
References: <cover.1355932282.git.wking@tremily.us>
 <3377beb925bc209d90058493b74d174db1b7aa50.1355932282.git.wking@tremily.us>
 <20121221082033.GB560@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 12:05:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm0PV-0000CQ-5c
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 12:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab2LULEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 06:04:44 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:42259 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab2LULEm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 06:04:42 -0500
Received: from odin.tremily.us ([unknown] [72.68.92.119])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MFD00DVOO3DKP30@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 21 Dec 2012 05:04:27 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 4218973A904; Fri,
 21 Dec 2012 06:04:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1356087865; bh=QdHoOxaKso4K1VBNN9XyrS7kQQbm+ouUuuZ+Yb7gOas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FuwsOB66DofdY4kaF3cUgUWPQRpOlYV9Kf1v2UgJLxdbkTYGvFI8tydt3E/CQtwvb
 byOgWVwqlsMU3XgHLyJDOIXjFNQvwoLGvyg5V3F26a3hzv0/mV/y9m4gFO09KawLaB
 e9oPgk5eYYOl/fSLf7ZVJ7vXI/JQ3Tba8FYnyntg=
Content-disposition: inline
In-reply-to: <20121221082033.GB560@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211964>


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2012 at 09:20:33AM +0100, Heiko Voigt wrote:
> On Wed, Dec 19, 2012 at 11:03:31AM -0500, wking@tremily.us wrote:
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 2365149..263a60c 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -153,6 +153,32 @@ die_if_unmatched ()
> [...]
> > +get_submodule_config () {
> > +	name=3D"$1"
> > +	option=3D"$2"
> > +	default=3D"$3"
> > +	value=3D$(git config submodule."$name"."$option")
> > +	if test -z "$value"
> > +	then
> > +		value=3D$(git config -f .gitmodules submodule."$name"."$option")
> > +	fi
> > +	printf '%s' "${value:-$default}"
> > +}
> > +
> > +
> > +#
>=20
> Minor nit: For all other functions we only have one newline as
> separator.

I'm fine rerolling this, or Junio can make the change on my behalf, or
it can be left as is ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ1EI4AAoJEEUbTsx0l5OM3QUP/j/FWmbM1TldLICzn3oJAH3s
HfMSucCMSJ6o7r57nrxkomtc+rsrGpvNkG7pfVaTnkpATsW083JyvCKT/S7nGCv8
ljSFJK8OMEwbmQSUhT0/Q7DZK4vs13ozWMeV+osaB5VsGQoKd/kFr9TLFQ85efan
WKBiNNom5hU3ugUcISJAlZ5VeACq5ZSpgDiEBI+n++IhkK5nurs56w3QqE4OznQF
HbjjrmX3ydTedQl+wJB+nXAK/GYKVArt8doNmRYOpmNUbnV79IQfgizN28/YxmgV
ON8pT31EEMD1CAh3nF7Ys2zTDSIHz2oVWq344LZfKVdGR1Dw09sC9Qj9p+CQgfJ8
iXvvaI3KICOvUflBz0dB2P9diTUaJRLQ663yOX6iAKS5mp4BNy0lvElG/HSvNRQo
Uft2LjPnlpJYg2Qg7vRDfIqe+gqOChk3TPg/gC8wwrlTDBSbXmdeT1UZV9MWKdBn
2LJbJWUCwILIV20FiR7KRYusNqDcXLJpamLlx78j+gW5WeDFcR/Zcrx5OFUj0CbJ
Xv+podi86EQxZLhjOW7k4VZV7HBZH5nd6ecS606f+XqjpUdP7DwEEvtw/xClL5py
FF2DchQXVx3jmy0A864IwoGc6wYrF3d/9EelW3v/32CjPIITydE97KnV3yPHJvsm
A1WytxGuNp72WBi8J2J+
=LFKT
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
