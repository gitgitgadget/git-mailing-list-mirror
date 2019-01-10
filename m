Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46B61F803
	for <e@80x24.org>; Thu, 10 Jan 2019 23:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfAJX52 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 18:57:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58450 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729416AbfAJX52 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Jan 2019 18:57:28 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4BE1F60736;
        Thu, 10 Jan 2019 23:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547164646;
        bh=b9T1jwEg3T+AAcCBVQaxxpbSN4InGHBPj2Dz0g9rpWQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=e+nhZWIMOUQIhCAZPySRL0NaA7p/OzelGldyKk3Hi57i14dRYiE5qesKEDxkzm4Bu
         XbnMTnhs4KqACxN+wDJMHjJRXhB/Wv8Gj91Ts7Y4uQghZAFc5nF/A0sfemkvwijuiH
         Y+HOzkqESkTuVS5yKLiFsNDliu48t4VhTj42znynwuuXg3THi8un/Zp6Y0TA1LpM/M
         2nCM2SOVIXL7Ea9oyhSsbENnMigKIFi8++1dDzsrfPzxXhaG/B7wXHH/7bmtz+XqnG
         0YQOjp+UNL73weYN76R8pZc8QSmfIXFAPZMqZ47sPVB8e+FQION5Xae+ZWDihEgrQQ
         hTU13C0U7Mm29wJBO/zXRhgMhYY7o5ierSJIELpFIsjB39+rsE6Mh6DCOS+N/HqKte
         cgBY0jiHGB+4Dzc3z5ykoO/gic9HVDCRntbFXwxdkuSmX0IH87E6MA4ffRvI4tytTR
         1qcY0L0QGGHKyAk3kxPFmox6AdYkgZr+fVER2qYrhVfGkbssy7+
Date:   Thu, 10 Jan 2019 23:57:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] tree-walk: store object_id in a separate member
Message-ID: <20190110235721.GN423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
 <20190110042551.915769-5-sandals@crustytoothpaste.net>
 <20190110064944.GA6810@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2pkNiL1PnZBJ6Nr"
Content-Disposition: inline
In-Reply-To: <20190110064944.GA6810@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--p2pkNiL1PnZBJ6Nr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 01:49:45AM -0500, Jeff King wrote:
> This one really is a hashcpy() now, right, even after your final patch?
> I guess using rawsz explicitly makes it match the computation here:
>=20
> > @@ -107,7 +108,7 @@ static void entry_extract(struct tree_desc *t, stru=
ct name_entry *a)
> >  static int update_tree_entry_internal(struct tree_desc *desc, struct s=
trbuf *err)
> >  {
> >  	const void *buf =3D desc->buffer;
> > -	const unsigned char *end =3D desc->entry.oid->hash + the_hash_algo->r=
awsz;
> > +	const unsigned char *end =3D (const unsigned char *)desc->entry.path =
+ desc->entry.pathlen + 1 + the_hash_algo->rawsz;
> >  	unsigned long size =3D desc->size;
> >  	unsigned long len =3D end - (const unsigned char *)buf;
>=20
> So maybe it's better to be explicit as you have here. (Mostly just as I
> was reading it, I was looking for a use of hashcpy and was surprised not
> to find it ;) ).

Yeah, I think a hashcpy is a better choice. Will fix.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--p2pkNiL1PnZBJ6Nr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlw32+EACgkQv1NdgR9S
9ou1lg/+IS0vFNSyf3q0dlA7OMn7LR2Y/q/0maP4uaXa8Jkr8HKvG/ObLXmRWMJ9
x+BIyPYO4dv0MUrGleeUE02mdY8Yqss9uIXpQ3NvzBbbAHs7nhESWOUGbXyaBXnT
KNzDlmEbbwuhKxpMDkbkE1xW3H0MEZnfSm81S9x3ObX17Ba5RGrR16uTgRxzDxE8
SF88oEwTFSa267un65evdnpztOaO0tV57zYIU8MbZfpLLGZdFotFIkyqlLG/vsi7
zKeOCYjSmc9MM5z7MdjH/dhX6fU6ySjpB8uIKukab49jOEHhwXvE3g0N8Bpba9fh
lv5oa0CvIw7Fi/8uNNv1SeR1rdawBk9gQO13YynhJW9GHY0sOg+1ZCNp58j/b+0Z
6027uvEgw28hnSWMQKJTe9QTpiLRfaniXo67hlmLtvJQoifey2XLPgZVw2GHqkTg
E7CAbylc+/u/pCjTNZDtS5mFSDv9W5oECGqS5BQ8dosJ+zk0huW3WGnafsLt5n8S
/d/LO00bi8wv3zZUgVKyklBIJ9FkhgZcuUHwCBwV6PIV++Jo81WnJmVJjCRt6WRi
R1iLLM+cbuDq8l5KP/otqkg5ifOG50MBCMre9Z9nt6pwMrrTA/K1UCzt0tjln5g+
/oSwL7BwQzud+YQIJuUpaII3H+n2CgWTfrH8JA4EqxWRo21dNAM=
=QH56
-----END PGP SIGNATURE-----

--p2pkNiL1PnZBJ6Nr--
