From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 4/6] Convert struct name_entry to use struct object_id.
Date: Tue, 19 Apr 2016 23:16:17 +0000
Message-ID: <20160419231617.GA572694@vauxhall.crustytoothpaste.net>
References: <1460934641-435791-1-git-send-email-sandals@crustytoothpaste.net>
 <1460934641-435791-5-git-send-email-sandals@crustytoothpaste.net>
 <xmqqshyhxkw1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:16:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asesi-0000rE-G8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbcDSXQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:16:27 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:54212 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752101AbcDSXQ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2016 19:16:26 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A1191282A8;
	Tue, 19 Apr 2016 23:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1461107783;
	bh=dCYHEFrFs0n0ZkWWzc29n6nVeNxQnNkVladU2S/MohU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wEe0dKZZNrEEM9LHs4O1QyIS4lOqhR69+OtbUac2SuarUKRE2qDoiG9QSfyNvXUoN
	 uwXKcrsyfPzy5Yo6qu6aiK/XihbPUoE1PXdiUrjOrJK1sSUPy1zvBs+/gW0eGlRyri
	 SDhKHR1Kw2I+oAMi6gAU6y+h2Sz5fJ2yLLYNa7bXIFlucxywDAsZAN0GXNvVWL1K30
	 Eoscl54OaEFvYCnBtez2PeZbJ5Bmncju3/iqz1OM5Rli9LCr1CG8wygcnDkgnzwLaM
	 pQgCRQa4G7RVR4ExDkvVuHDpWGMngYHuAcQUBnp9vDRCv3ytaufj7L3sN18WZxfDG5
	 v+DIFFdFYXjOiUg8FatW6CZarUjtIlch/KZVmyV6WLuDdP80TuZUBd1WcRMyab2obi
	 zXvWgriPZLwPtrEv4sr90tCJhH9oMOwRhwEyUNpManXViOlgCpkMp0gtr7l2EZM0nk
	 oiYHpkYtZ27xTACXUsR+Uw3PuvpLG7WbAuReaXWVJUlWDPJiZv8
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <xmqqshyhxkw1.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.4.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291950>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2016 at 04:02:22PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > @@ -314,7 +314,7 @@ static int threeway_callback(int n, unsigned long m=
ask, unsigned long dirmask, s
> >  	}
> > =20
> >  	if (same_entry(entry+0, entry+1)) {
> > -		if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
> > +		if (entry[2].oid->hash && !S_ISDIR(entry[2].mode)) {
>=20
> Thanks for a warning in the cover letter.
>=20
> "if (entry[2].oid && !S_ISDIR(entry[2].mode)" would be a faithful
> conversion, wouldn't it?

Yes, I think that would be a better conversion.  I'll reroll after
waiting for further comments.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJXFrxBAAoJEL9TXYEfUvaLIycP/j6EhrbUefyE8WHE5A4Boq0c
y8wrSvSdYemBHz8j3NAcHZSFsvx9l55VW+APQ/nUQMQIyZpWj1Sr97dzYPr9EAlW
yE/pOjhhgX8DhoFjflh+rWYTYClqIRdYNbAPez4IdxrLTq4yPVmsUnjB4K0ie1An
HXxpvQa9fLuLLy7551D/Q53uqk6TmdPrBH4J2f0KLmOxa++S6vX6DTRtpoPR5GB5
1nOB0kJDLXDRZoRpo1jOiKBaBz93Xcgw1sz57W03rr0mgV9ZUYxVzfRr3nXh4F5b
3kYnyyZ98FluV8Oe1VIVHyULd51ffz/4q179Cyb//kkE6/eAmStyoLyu5Gj9E0Pa
1cCny4lLXM1H7Y7WiBu9tEFkn02vQdbFoEKNPcvG5ajijYvExq1AeUjvvbOg7/1g
zF5EzGkLA3bVYWnuH1H8dW2uC2HHccSoxv8B/YoOK+eBMSfrDASc/o3YtNW7sVFs
FleMNlfWTvmw5hIKOL0oZoNJNZVrvbAa/M8ALa7SXCy5/4RV40cfIOcGb3F1aFHZ
OA0Xd60JYD0/XDCGN8Yf9bBrgnPIoTZnua2Kz68y7pR3aBwu7kmk5mpUSx4QP/kw
kn4tm1gZbIoRat56Km/3SjkXneWYfF6C9LvSX1ATMrzrZSnywnDS3BS5tRORwZM5
JHUJBNNbKvW996MEVgaD
=dwqs
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
