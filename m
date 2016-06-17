Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_TVD_MIME_EPI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D158620179
	for <e@80x24.org>; Fri, 17 Jun 2016 17:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbcFQRbh (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 13:31:37 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:48781 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbcFQRbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 13:31:37 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jun 2016 13:31:36 EDT
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 394075CD848;
	Fri, 17 Jun 2016 19:24:59 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id TgHdRDTnVt6Q; Fri, 17 Jun 2016 19:24:56 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 2E6695CD0D5;
	Fri, 17 Jun 2016 19:24:56 +0200 (CEST)
Subject: Re: [PATCH 0/2] Log pretty format alignment improvements
To:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
References: <20160616131838.14440-1-pclouds@gmail.com>
 <xmqqtwgt3s9z.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	Josef Kufner <josef@kufner.cz>
Message-ID: <dc9501ec-7684-ac35-7bac-f88fab707f18@kufner.cz>
Date:	Fri, 17 Jun 2016 19:24:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqtwgt3s9z.fsf@gitster.mtv.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6FAJUogDqFpJiAFss4cXrbWwXTjsNDvMi"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6FAJUogDqFpJiAFss4cXrbWwXTjsNDvMi
Content-Type: multipart/mixed; boundary="8BMdKdo3vBnB8cMMOs34G7g15fMNlV3gE"
From: Josef Kufner <josef@kufner.cz>
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <dc9501ec-7684-ac35-7bac-f88fab707f18@kufner.cz>
Subject: Re: [PATCH 0/2] Log pretty format alignment improvements
References: <20160616131838.14440-1-pclouds@gmail.com>
 <xmqqtwgt3s9z.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqtwgt3s9z.fsf@gitster.mtv.corp.google.com>

--8BMdKdo3vBnB8cMMOs34G7g15fMNlV3gE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote, on 16.6.2016 20:25:
> "as long as >(N) can be used as Duy claims as a workaround to=20
> get the original behaviour, it is good to allow using >|(N)
> for this new output format; I didn't check if >(N) does behave
> that way, though"

Yes, it can be used in such way.

Example:

$ git log --format=3D'%<(10)%t%<(20)%h.' -n 1
004419a   9ca73ba             .

$ git log --format=3D'%<(10)%t%<|(30)%h.' -n 1
004419a   9ca73ba             .

Notice that dot is at exactly same column, because
10 + 20 =3D=3D 30.

The difference is when using --graph, because width of the graph is not
known in advance. After the patch the graph width is included in %<(N).
Original behavior is to not count with the graph width.


--8BMdKdo3vBnB8cMMOs34G7g15fMNlV3gE--

--6FAJUogDqFpJiAFss4cXrbWwXTjsNDvMi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZDJmAAoJEN5YZWvcKoxvKuIP/1+K33Qlob0QyFz7vxuaUydw
VZDsX2i9u1dvDelp4VRPHPG7dDCe6OCqGfuafg877EJvDura/DUkqBqas6dwGEGC
G6T5G9/qn0kWpQNLNQ7RkvFB+XZtdxyWqe3f+m1vwpmBeP6SQV/JRhbP2XmZN/Bc
KMSiwHhDWOkjMqe4jXknCyp8AxzxONTJ1g2JbbhnDEusqcrf0v9k6blhTLvK7PwX
iXJNVYXbZr9uL53Bz+yCHMfrixHNITjuHfNuJrmg1ZJsgqOrUFJ1M6AXgBhBgcfy
7TcOsD3CTJ/Sz8m1CBhYzMw+23NaiInbKiN7ohMC0U6N/yGUzjoV6vzuC+OWeEtF
SZpbLn9jJ2A3vCXzfTgBgl6eVANqXugbSVcXVK0KnPmY0GNTBzaXmEeGazerw/VN
i0YDjFbiIXriRtdBG0P87Tyi0PhteqXQnFUsXPsVWKN4aIG5PsPfGY2sZ95jpclU
2uJLKai3q5PxoEEHDsvfM5HXMNxk6Tc0Rp5Coe2tc0vstsauxLY6WawRuW8qvy3k
r9ePbd4aw4iBHR86UaB0o0GUZOGgS90sj44+y8WKKIEo8AEmodqUzPP15AGOTaNh
BzkmMS46TEtVENKcyUR7aDjEPwhU6+H3v5CzXT/snSFR/96vIT4rRTk3OPK3hwZf
7ZeiB1H2W+hUa266udXk
=bUDr
-----END PGP SIGNATURE-----

--6FAJUogDqFpJiAFss4cXrbWwXTjsNDvMi--
