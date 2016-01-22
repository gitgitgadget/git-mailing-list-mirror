From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Fri, 22 Jan 2016 02:33:59 +0000
Message-ID: <20160122023359.GA686558@vauxhall.crustytoothpaste.net>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
 <20160119191234.GA17562@sigill.intra.peff.net>
 <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
 <20160120002606.GA9359@glandium.org>
 <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
 <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:34:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMRYI-000082-LL
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 03:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbcAVCeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 21:34:10 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:59048 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751007AbcAVCeI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2016 21:34:08 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3D0F0282CA;
	Fri, 22 Jan 2016 02:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1453430044;
	bh=ACpLV+D3ZCZsh0pJdcUURxKOChSQjAfRfb0AkvaSwW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v6J+48oHr68nHEe5Ef+E+gxBxNBOEf+Lc+ojvaUZgykiLp7YRtTZgbM8eRTCX1ByN
	 P7mVjtxQ4opIpYLXMKDV2tCsX1H8d5vl36Hoea9vRIym5RHhFLfz1UlPZJk+Q1/2k+
	 KwjpDWI7Eo3/W35JnxexoKtEwYqc4OkaLjQYezDZn/O+Jk/yeofzMh1Ev1jKQnK3OF
	 axM+rwVPG+y2ZWsI5A/C47aq76vcOiHJgvDXwFWVxxaVEg8JmsmkFk/aPW+drZuG9z
	 WynMIjgjRfWP6+aJF+y/uV6seoZ/O25QlVoZHVU2gtswIbydDqelvhDVDaWPV9dvad
	 2d8eJhsDU1wQY+0z2Hhb5dUoM1FA97bO2PubHjRUuKOLD7IDQrhgYPju8C2mIYFJo8
	 bDJeGr8tfXJVUF1pYJfiJQ2lMkDpfzt/B+Gf6iWq8cJ6d4h32hlbk0sgeCg0TJBcCd
	 Uw1jqMieopNkCeVjjAqevC7kKxjfr6J8aHJE27BRoy1l/7CkI/p
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284544>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2016 at 10:22:16AM +0100, Lars Schneider wrote:
> I tested different settings and found that running prove with "-j5" seems=
 to be
> the fastest option for the Travis CI machines. However, I also noticed th=
at
> I got more test failures with higher parallelism (Dscho reported similar
> observations [1]).
>=20
> Especially t0025-crlf-auto.sh failed multiple times ([2], [3]) on the OS =
X builds
> when I increase the parallelism:
>=20
> not ok 4 - text=3Dtrue causes a CRLF file to be normalized
> not ok 9 - text=3Dauto, autocrlf=3Dtrue _does_ normalize CRLF files
>=20
> Anyone an idea why that might be the case?

I've seen this on my personal box too[0] when running make -j4 all test.
I wasn't able to pin down why it was occurring, but if we're going to
run the tests in parallel, it's probably worth spending some time
figuring it out.

[0] Debian amd64/sid, ThinkPad X220.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.10 (GNU/Linux)

iQIcBAEBCgAGBQJWoZUXAAoJEL9TXYEfUvaLfjMQALkQdgUxxqO5sewygfTdmWaX
a6JY5o8cyFI00bM+HnHijdRk/uHeoZoKcAbfrRr7THghyYS1AwIkq2GKumZGiUxb
mN+ot2vwrB5d9vFkpygp6Z+Z3L2a90zFQpsg1capbBZLppt9aflPHvZhyF2mfPQG
advjJT9HPvrj7V1/r0tv/KXVmbu2TeFvh1PQe+XbMsB1kkfdAVc/ybCBy+EoD/V1
6ZtQc0hwS+8i5mxpMgF8oBT/kYxMzQqz0tHMlh98dU9t53rP1EN7bHbcyfrhFuzK
yrr5qRdLVia8MsTxCe6/NH/CtxC2CFm2hRFC2cIWjYKHsKJ+1nfEdWVT/+Xx9OcO
MaIKNxAIJz6JlyTCCXVw9AnNCI7ncCxvMFWnR1DtamaJ/F0pkf45eaBgv9grjmIv
rX5XaBy1hceIMqMzRt4LB2ARpfikJqOm7Z1CXuF+occRZcYfR4+/ZRWL2Gk+oXXw
xp9aEVyy5QwSVUPRDBOExtIKYgfZJ68LHs6qJHCjdeUe5MNN7co4IqL7fA4UQcxJ
Rd0sFO6Gqera35fqeOu9Nv10IdUsvPBpbapf0P+sLUjOEoyKQnYkhK5FfxUDMKem
6Xwx1e3F5EqaGabmXsEozM2HmYu1Ch2JS4bUny2X7nC345Hm6TFKBSlUKjjTGlrb
T4Kzp+3feg0yp2Cdf/xB
=IxGs
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
