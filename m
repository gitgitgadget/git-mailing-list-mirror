Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228B820988
	for <e@80x24.org>; Sat, 15 Oct 2016 13:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbcJONpM (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 09:45:12 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53250 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754349AbcJONpK (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Oct 2016 09:45:10 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 295CF280AD;
        Sat, 15 Oct 2016 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1476539108;
        bh=gQhQRWcuPlvgqwL6aRKQLwOsoMOfS+X0d8JETtJZpYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2GOwMh3g3Tvu2yWzpshkmoP448RLKV0YrP3yF6mP9DvV1B3N07tef/GcQJhC2PIx
         Q36nO9Ud9zcMEHx+tfnc1OOCjthKEuCPhyZGH2czAW47DJoADz37FlAMTsB6XFMPfm
         e4CiafMi9FjMCHqeh1Bpmgp+Va6meCz7xDFZM8JVdoJ/UY+tBS/PyhrLd+wzevsYXS
         Ynv5P3cCgDSyms5EXEYstn329vh7xt1uCxnZywth2IrFQPkjTX2NSU/c+SkAeoot2H
         e8KmGG9RFnoT6gv0e2c3+OSIt4WfkKc5tMLCPGkAq7gNBNu/C2vg8+Dkke9d3OKzex
         M2yFMB8zPv8bgEwIftOPHJKCr23EZXbFQaQv/toCdRJijnB9QLbOjqGMfdlpODA7W3
         o8UdxG8vMgPMdxEWye/cWJBpbFm8Ocw1oxkYq9eKmUsprsbFnA5196I9azQ6zL//2A
         US6dqCgmiWXs3QTFKFimTxkk0wJWYGJn00kr2mTWu6xazh7bBaK
Date:   Sat, 15 Oct 2016 13:45:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cocci: avoid self-references in object_id transformations
Message-ID: <20161015134503.u3aznujploqee2le@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <a5ed26c0-7fea-259c-74c1-0cd870a35290@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghdewvhguvx3qbnb"
Content-Disposition: inline
In-Reply-To: <a5ed26c0-7fea-259c-74c1-0cd870a35290@web.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20160916 (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ghdewvhguvx3qbnb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 15, 2016 at 10:25:34AM +0200, Ren=C3=A9 Scharfe wrote:
> The object_id functions oid_to_hex, oid_to_hex_r, oidclr, oidcmp, and
> oidcpy are defined as wrappers of their legacy counterparts sha1_to_hex,
> sha1_to_hex_r, hashclr, hashcmp, and hashcpy, respectively.  Make sure
> that the Coccinelle transformations for converting legacy function calls
> are not applied to these wrappers themselves, which would result in
> tautological declarations.

Ah, yes, this is a good idea.  I've had to hack around this, but this is
much better than having to fix it up by hand.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ghdewvhguvx3qbnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.15 (GNU/Linux)

iQIcBAABCgAGBQJYAjLfAAoJEL9TXYEfUvaL5wIQAK+9ZToMzpwfdar/tbxeki7b
CHNpHg5axD75lLo2R+hvZFLyq6B51TVXDUXFv2oEs+oWdw+oPzuUAPXJPI6eXFlr
FgDJRngLCqBPRICqzk7CY3VsCC6EAFct8f0C2R4yu78ZAejPKBwkJIGdxdhJH9YV
mvWeBcO8XRcIGbEGxY1R7U6yxzOPvHwzX9lEkbVqHm8P+kzD+RPz9mBbW4qyHipV
D1cwOBrp8GoCJ/R68Gsu7/pt1wadh6qO9nsypZ6166pvDL6ACsnQF/avkF5G08XS
yHkQbGx5Q96bz3gjfK0GXuLpU9/IS0251EKOpWAaWvjElKQqPKBHAiPaLL8S/ST0
scN4wWwM4EjWq1CRlsFYk/QryyYuzeGC7cp4T9S/tTRKI4pTSjZu9C6yw0bE/93l
TJ51jQZ6CB1AkZCEIHbIqtn0zimG1LJcGUmpBo6c3J92+AS/obPdeHXh2fnuRK0z
plA80ca/5BMNeD4O5LnM3SjYe7r3H3B60G/WNg2nUHAdjwddi24TSgRAzV60D9V8
XjzE9Y1PAPPjDJpdk6kUxOifPIztnDPTvLWSAsVygB33/zQ5RVAtlc3p0wvN1p59
0rvWgfs8CZXN+A9sUH/iMf0lT4Fl6DtBsdTLYgR6bWHSw+2HUhuaJcO+LFgbWp2B
GqmFBrd3rzQGrjXjF2KK
=ujCf
-----END PGP SIGNATURE-----

--ghdewvhguvx3qbnb--
