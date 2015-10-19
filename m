From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: problem with modification time of packfiles
Date: Mon, 19 Oct 2015 23:09:19 +0000
Message-ID: <20151019230919.GA60184@vauxhall.crustytoothpaste.net>
References: <87io63503w.fsf@msstf091.ucc.ie>
 <20151019025727.GA23404@vauxhall.crustytoothpaste.net>
 <87a8re4oks.fsf@msstf091.ucc.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Amann <a.amann@ucc.ie>
X-From: git-owner@vger.kernel.org Tue Oct 20 01:09:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoJYv-0000uv-8Q
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 01:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbbJSXJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 19:09:24 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:39563 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750814AbbJSXJX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2015 19:09:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 885D228094;
	Mon, 19 Oct 2015 23:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1445296162;
	bh=q0gOY7A5Yj/ipfBl0RAfNnIUGkVd7ChboP43WApfHMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsDL+RM04FMP+XKyrYb+lR2Y5dNqYyzEEcx7jX7tsaI0m+8l034XlWT+e2OeLwtrZ
	 jZLhO7XYpjqfeHG8aUTsECzn6/U3ANQ9/DuBQ/nujcQSHfOmTwRmlqYXQhCG36ge1u
	 dAfU3rMWI4NuGEs+WfGcdbtQC+YHJ+MUndZIlSVAi71t2PequO5ac3aNrb7Z8MOhFa
	 MzSEwgBJsB2AlDCJFlLap5URrO2IZLniW6HepLTB+ovgNw9MoIegHabUlqdsr4k7EA
	 MFdlqWswVfCTYx91wGra7736IxDA51rVPLzu4m09F1WnAByHoxScpg/MANgeSMHKnq
	 IXh9/bsnioVnVfkxWzANJtZ41qH4hrvuvYz1IrSTP6CYObT2HdLyiU88B8n3Z9XUZT
	 8qIrPtEfUS55iu9UQQ7lS6GcYuobvbTmzM/4h+EhsYMwBJs7/rQl5J085HDrgROUke
	 4gxS7RY+EyvXzOl3rb9kMv4tPsEBMc/3eq2I/veyi5WQn+XJuv5
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andreas Amann <a.amann@ucc.ie>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <87a8re4oks.fsf@msstf091.ucc.ie>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279896>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 08:59:15PM +0100, Andreas Amann wrote:
> Thank you for your answer.  However, this reasoning only applies to loose
> objects and not packfiles.
>=20
> My understanding is that "git prune" will not prune any pack files
> (except those starting with tmp_).  Only "git repack" should do that.
> Repack seems to be however mtime agnostic and therefore it does not seem
> to be necessary to freshen packfiles.
>=20
> It therefore seems that git freshens packfiles unnecessarily, which can
> lead to expensive and unnecessary backup operations.
>=20
> Given this, would a trivial patch to remove the freshening of packfiles
> be acceptable?

I'm not familiar enough with the code to say for certain, but it looks
like you're right.  Peff, Junio, do you think this is safe, or is there
something we're missing?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWJXgeAAoJEL9TXYEfUvaLnwIQAJDGiL+vm5njwGtTc740QHnn
cIxJdot86ZLoLNbQ6KOY8t8Bms/DdWO0RwTATNYfEN01J5KTQI5Wn/C+Xl7nD5GV
0FlP+Q+rGL3AQnQ672vEnqDoM3fDa58IKS+QH6n08a7dgBUCO2gYksVcVJLEgtPW
+Hc7hSzP9mnBnTO8GlMJOGqVonkSjlK0UlIRYKFKyWrnom6KvA4EHp/yO8kgciHy
cn/J2jRjaokrfNe6LZlTCxDKm0xrLv/Z2e8fGDMqggFUCzFGnQ5BcfkpQRfltLS1
a1h3zOXGCVjxxzWIYGGxVr06HVYHFhoDZbYIt/qslEzl1CPTTSVKnnalPxD3otuw
9u41bd2yMvhg1RvMncTDmt5kJ7fqyEbLYz5jRui315ZjKe16S/MMIQPRy5v/JlCt
2icagEx7aXpUar3V9IuQNVQ2KZJWfRu2dgqA/P8SnRzqAo8qdKu7nsATocI+Mz4b
2ezoqkq0/A+l5911qlYAuNh+cEUB2VZbdt/c/kWcAaXKYguOP8w9vQaihQNJ5XSM
7f9XeW8DtiAFSTnO/rKMjlE3WoBsU+TQzi44B0hseFVxyeubihzZLYH9u36It186
qJjL+fc+Gwbkystt2lqw8gl9luB6JNMxtfyn5I2dK9IdWbprGd0z4MW0VaRXQx+e
0lW3O+wUVOGwVieE0cKz
=SjZR
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
