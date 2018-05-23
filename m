Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5045C1F51C
	for <e@80x24.org>; Wed, 23 May 2018 02:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753822AbeEWCRg (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 22:17:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52486 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753792AbeEWCRe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 22 May 2018 22:17:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DC7596047A;
        Wed, 23 May 2018 02:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1527041852;
        bh=6RNwmtq7uY5U18Vd0Jn/hULfvoLSR1AXwbRv3faSCfU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=omhP5gq9rvbLH0OBvRjDu/kRetBOuhcCvuF7w3BVNJrPJXtOot0cRlwWE021/pGOY
         UnoRwMydGpZqpHG3EVQJXkP8gDoqLcjAQhAMQqOkng2I0viYJf0MQ1nlJVNzdk4LOL
         ElFd1t+LFAKDIb8I/rJfLOcYgwcFt0IW43wz6wWycrtrHpqkArxEZa0OAeI/cMhmyT
         s35SKennhl8TQVL4UXn+gZweiPq54HgUuP8EfqoMJLwQSrTc9enSk4hJUEYUDc2zFY
         otxeHKPLdHjs1Mi4kBfFefyfnJcamBRnbA0uIchMiyptMWurv4p3MBT1C6Df+FjGG0
         05ixTPg1qurhPJQ9BFNs3CbV9WT8si2xPeMc9DisH6ybZyI/h5gDPUXioOy0ozHNab
         9019326dGA/kVSU8FQGLrejSlMQyzQpZNj+XehXbovkZiC2DYGy8YG/iunPAOLfAmm
         6ZhX/P2OPaqNZdg97OEV2pAd9zMg1WngEqcC/uBt5c1vrxJJCvc
Date:   Wed, 23 May 2018 02:17:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, sbeller@google.com
Subject: Re: [PATCH v2 1/2] remote-curl: accept all encodings supported by
 curl
Message-ID: <20180523021727.GJ652292@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, sbeller@google.com
References: <20180521234004.142548-1-bmwill@google.com>
 <20180522184204.47332-1-bmwill@google.com>
 <xmqqwovvw4fl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f54savKjS/tSNRaU"
Content-Disposition: inline
In-Reply-To: <xmqqwovvw4fl.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--f54savKjS/tSNRaU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2018 at 10:23:26AM +0900, Junio C Hamano wrote:
> Similarly, how much control do we have to ensure that the test HTTPD
> server (1) supports gzip and (2) does not support encoding algos
> with confusing names e.g. "funnygzipalgo" that may accidentally
> match that pattern?

I feel it's quite likely indeed that pretty much any Apache instance is
going to have the gzip encoding.  Every distributor I know supports it.

As for whether there are confusing alternate algorithms, I think it's
best to just look at the IANA registration[0] to see what people are
using.  Potential matches include gzip, x-gzip (a deprecated alias that
versions of Apache we can use are not likely to support), and
pack200-gzip (a format for Java archives, which we hope the remote side
will not be sending).

Overall, I think this is not likely to be a problem, but if necessary in
the future, we can add a prerequisite that looks in the module directory
for the appropriate module.  We haven't seen an issue with it yet,
though, TTBOMK.

[0] https://www.iana.org/assignments/http-parameters/http-parameters.xml#co=
ntent-coding
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--f54savKjS/tSNRaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsEzzYACgkQv1NdgR9S
9otqGg/+Kkyd7pHcMtmV3jovSLOQAp7nmVggUXQ9vgfFZYB/AE9BeEBpMkZpE5mE
B9wllWF8Jv0zH7rCHwx2Atf6yQiiKUtJ1UmdAUqQ1C3V/WlYThuJEb5VSglp6kJq
lSWCe6hp7dIQfHcguEGX6jpq6dxTmRu76UjBqQEPBLwRhCcNg5+SdiGUi8e72COq
mgQsVe1rTkLd7T9+9DJJkegzWVs5ongyZVZ9itVoQ5nvY4SuJs/2gNePloZ0XsJZ
AwY3wKbCTaStkUiO/REpN9r2N+rDew1fdZUI+3fk7gzmsRVP1OOP38lCH6KFEuIZ
JNJdIjif452MlXjfGSLWPklc9vYQ/dJDKK84BHJJ3yIt3KMqixL6A26MGyOMWwPD
dfReaqevVwTYrdSxtfVoMs61EJ1rdBVKn/LxDGy03UHwDAnGz2iHx7NL9Ez/6ptN
TcdgImOm/oBFGx/7qhk7mcGUdUEHlPjFaHqiOL1SwC7EAYFrtCPAX2kXGtyXm91/
FYfrpySE8uI/BMWldfDjVrrHFXpFtJVuF0yGabKxwvf77F0tNlkVJVeJC1FhAaH4
eTdza+FyHL/kBe09U+kH9HSgIGB5C17v7e/yJFTvbs6BzytQHZEPt2VlpqktQcdd
wGbDjNY+BfkoC3whWiTrlIZBW4BxAjPiJb7NCSuo7Kc/TbnD/UM=
=oEDE
-----END PGP SIGNATURE-----

--f54savKjS/tSNRaU--
