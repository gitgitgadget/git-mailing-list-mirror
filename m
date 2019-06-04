Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8FD1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 01:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFDBCy (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 21:02:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36888 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfFDBCx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jun 2019 21:02:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F27156046D;
        Tue,  4 Jun 2019 01:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1559610170;
        bh=ncdCdvtdgxkbuOvm2dD0VcUMWoCznXs8ObjN8pIrljE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sNAW5kBBXjyE3tRZ8DQbDUUoM4QzKOs2mEYNLqp6VK8w/VCgvA7eq1qC2iIcyswKm
         Ko2wWVXZihN9QoCi8B3gP2G5gXhrAQVygd7SuuDlFJPuqIGZFLNtDDQxAdqF1s3RD0
         8r58maSKEPU8nlfJ0TmGtthH2yopdMKfWKgPH/Ssm5P8NAHwPfEZa9lRafxyX07Eu+
         C6QjgLokYMmg4u4qWfX5KchCLuvBLQGDdjivcUzeDH8ohk2ndb6UqjOcErWJQjJN8F
         wP4ES3HwP+lrUWVPMMzfKbx52DL1qOFrg2j4sg4ornF9in3QrPIs/uuA5w0d+UM+OY
         BEkoCrkA9nb5fRX/FY8lGoCChK44Twd9Pzv9oA8bvH0iedFkuzYCfdaCtF6cQDuNHw
         iFc2Yg79Jcti9rGQuUY7nlSxQTdKgwceUslUb53TbUJHgwXeHlCDaF2yv7OGUWihJV
         TN0Wr1dIFtnvM4hyyJgStMnSUtPa/U6hZx3nhfg37CRw1Qse5O+
Date:   Tue, 4 Jun 2019 01:02:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, l.s.r@web.de,
        gitster@pobox.com, spearce@spearce.org, jrn@google.com
Subject: Re: [PATCH 2/2] url: do not allow %00 to represent NULL in URLs
Message-ID: <20190604010243.GR8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jeffhost@microsoft.com, l.s.r@web.de, gitster@pobox.com,
        spearce@spearce.org, jrn@google.com
References: <20190603204526.7723-1-matvore@google.com>
 <20190603204526.7723-3-matvore@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1IOPqZ3f1xe/JZlz"
Content-Disposition: inline
In-Reply-To: <20190603204526.7723-3-matvore@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1IOPqZ3f1xe/JZlz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-03 at 20:45:26, Matthew DeVore wrote:
> There is no reason to allow %00 to terminate a string, so do not allow it.
> Otherwise, we end up returning arbitrary content in the string (that whic=
h is
> after the %00) which is effectively hidden from callers and can escape sa=
nity
> checks and validation, and possible be used in tandem with a security
> vulnerability to introduce a payload.

So I think the reason you've stated is good and I agree that we
shouldn't decode data we're not going to use. However, I'm also
interested in the cases in which we decode data and don't want to allow
NULs, because we should, in general, allow bizarre URLs as long as
they're URL-encoded.

It looks like several of the places we do this are in the credential
manager code, and I think I can agree that usernames and passwords
should not contain NUL characters (for Basic auth, RFC 7617 prohibits
it). It also seems that the credential code decodes the path parameter
before passing it on, which is unfortunate, but can't be changed for
backward compatibility reasons.

And then the other instances are a file: URL in remote-testsvn.c and
query parameters that have no reason to contain NULs in http-backend.c.

So I think overall this is fine, although we probably want to change the
commit summary to say "NUL" instead of "NULL".
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--1IOPqZ3f1xe/JZlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlz1wzMACgkQv1NdgR9S
9oslmRAAhDvDqKTlEo//9kzHTyxxQ2mUbsPD8PyBJoIQZNuh+FHxyjyV/EJIENfn
VWb0N8TLEFBo+uJA2XzO8I3SVVExPg9SAikttFN9F+bUr8VNvXm8nwjhVV+Fas8V
wkaJ8ly6japgJWoR2H8zn9C6iY76gFyl8v4tKICMo5TApvWxrk6bpGgGDjPgXA7P
fL5nMFAl8PpJq65r+2XN/OuUGqNYhQUe30nV7YQu08bH8g6tnGmoKGAUTlaQCaS4
5PqyamPrVkeXDrGqLNXJyT0Ew7ImhAfMG3DT/vFV8DpM0XXBpIhtqG6v/62RccG2
UbnIhTK9BJz4Bwwcf079cUW0Q3q09/JJVxjK/feScuGVR+iGqrUTrDHBpuzwM7rl
RSqnvhELuUOSmzHnctPUzkXkiU4AZszvHYQLJ7+RafQo7nURFoTn+NN2yIEjTUwc
OiJhieY+nVmrfFspCIXue+9Hkbs0BezSUlRsPmH5T/u5+0uWLDOXZEMNeG8YbmA9
H68rKD78lLr/BLt0SKNO1X4opFfLJMIjoHCTQCkBMHPBlGTymgwrTbxIoDTkWYi5
9pEm4UTl5hiGKdmyYkL3E6TM8kYoFUjKwwxEJhcPNci5tyVN3x5MD1A5TmkA8F8c
L8lbexNOV/GoNCXKnuWKZjTf+SART2wThTWxT3yKIF+lygtTVzI=
=wJBJ
-----END PGP SIGNATURE-----

--1IOPqZ3f1xe/JZlz--
